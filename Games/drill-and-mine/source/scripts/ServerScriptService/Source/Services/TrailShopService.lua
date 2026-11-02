--[[
	TrailShopService
	Owns the trail catalog state per player: OwnedTrails + EquippedTrail in
	the profile, mirrored to the EquippedTrail / TrailBoost player attributes.
	StrengthClickServer (clicks) and DrillSystemServer (training pads)
	multiply their Strength grants by TrailBoost.
	Cash purchases run through here; Robux purchases are granted by
	PurchaseService via the "BuyTrail_<name>" receipt context calling
	GrantTrail. Buying always auto-equips. Equipping an already-equipped
	trail UNEQUIPS it (unlike drills, walking with no trail is valid).
	The visual is a plain Roblox Trail between two HRP attachments, built
	server-side so every player sees it.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local CollectionService = game:GetService("CollectionService")

local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)
local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)

local TrailShopService = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local NotEnoughCashEvent = Remotes:WaitForChild("NotEnoughCash")

local EQUIPPED_ATTR = "EquippedTrail"
local BOOST_ATTR = "TrailBoost"
local TRAIL_NAME = "EquippedTrailFX"
local RAINBOW_TAG = "RainbowTrail"

local TrailShopRemotes
local BuyTrailFunc
local EquipTrailFunc
local RequestTrailDataFunc
local TrailUpdateEvent

local function ensureRemotes()
	TrailShopRemotes = Remotes:FindFirstChild("TrailShopService")
	if not TrailShopRemotes then
		TrailShopRemotes = Instance.new("Folder")
		TrailShopRemotes.Name = "TrailShopService"
		TrailShopRemotes.Parent = Remotes
	end

	local function ensureFunc(name)
		local f = TrailShopRemotes:FindFirstChild(name)
		if not f then
			f = Instance.new("RemoteFunction")
			f.Name = name
			f.Parent = TrailShopRemotes
		end
		return f
	end

	BuyTrailFunc = ensureFunc("BuyTrail")
	EquipTrailFunc = ensureFunc("EquipTrail")
	RequestTrailDataFunc = ensureFunc("RequestTrailData")

	TrailUpdateEvent = TrailShopRemotes:FindFirstChild("TrailUpdate")
	if not TrailUpdateEvent then
		TrailUpdateEvent = Instance.new("RemoteEvent")
		TrailUpdateEvent.Name = "TrailUpdate"
		TrailUpdateEvent.Parent = TrailShopRemotes
	end
end

local function getOwnedTrails(playerData)
	playerData.OwnedTrails = playerData.OwnedTrails or {}
	return playerData.OwnedTrails
end

local function buildPayload(playerData)
	return {
		OwnedTrails = getOwnedTrails(playerData),
		EquippedTrail = playerData.EquippedTrail or "",
	}
end

-- ===== character visual =====

local function removeCharacterTrail(character)
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then
		return
	end
	for _, name in ipairs({ TRAIL_NAME, TRAIL_NAME .. "_A0", TRAIL_NAME .. "_A1" }) do
		local old = hrp:FindFirstChild(name)
		if old then
			old:Destroy()
		end
	end
end

local function buildColorSequence(colors)
	local keypoints = {}
	local count = #colors
	if count == 0 then
		return ColorSequence.new(Color3.new(1, 1, 1))
	end
	if count == 1 then
		return ColorSequence.new(colors[1])
	end
	for i, color in ipairs(colors) do
		keypoints[i] = ColorSequenceKeypoint.new((i - 1) / (count - 1), color)
	end
	return ColorSequence.new(keypoints)
end

local function applyCharacterTrail(player, character)
	character = character or player.Character
	if not character then
		return
	end
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then
		return
	end

	removeCharacterTrail(character)

	local trailName = player:GetAttribute(EQUIPPED_ATTR)
	local cfg = trailName and GameConfig.Trails and GameConfig.Trails[trailName]
	if not cfg then
		return
	end

	-- compact vertical ribbon just behind the lower back. Everything is
	-- derived from the HRP's size (2x2x1 on a standard rig) so scaled
	-- avatars get a trail that matches their body instead of a fixed span.
	local scale = hrp.Size.Y / 2
	local behind = hrp.Size.Z / 2 + 0.1

	local att0 = Instance.new("Attachment")
	att0.Name = TRAIL_NAME .. "_A0"
	att0.Position = Vector3.new(0, 0.4 * scale, behind)
	att0.Parent = hrp

	local att1 = Instance.new("Attachment")
	att1.Name = TRAIL_NAME .. "_A1"
	att1.Position = Vector3.new(0, -1.4 * scale, behind)
	att1.Parent = hrp

	local trail = Instance.new("Trail")
	trail.Name = TRAIL_NAME
	trail.Attachment0 = att0
	trail.Attachment1 = att1
	trail.Color = buildColorSequence(cfg.Colors or {})
	trail.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.1),
		NumberSequenceKeypoint.new(0.6, 0.4),
		NumberSequenceKeypoint.new(1, 1),
	})
	trail.WidthScale = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.7, 0.55),
		NumberSequenceKeypoint.new(1, 0.1),
	})
	trail.Lifetime = cfg.Lifetime or 0.55
	trail.MinLength = 0.05
	trail.FaceCamera = true
	trail.LightEmission = cfg.LightEmission or 0.9
	trail.LightInfluence = 0
	if cfg.Rainbow then
		CollectionService:AddTag(trail, RAINBOW_TAG)
	end
	trail.Parent = hrp
end

-- ===== profile state =====

-- Mirror profile state to attributes, rebuild the character visual, then
-- push the payload to the client.
local function pushUpdate(player, playerData)
	local trailName = playerData.EquippedTrail or ""
	local cfg = GameConfig.Trails and GameConfig.Trails[trailName]
	player:SetAttribute(BOOST_ATTR, (cfg and cfg.Boost) or 1)
	player:SetAttribute(EQUIPPED_ATTR, cfg and trailName or "")
	applyCharacterTrail(player)
	TrailUpdateEvent:FireClient(player, buildPayload(playerData))
end

local function ensureBaseline(player, playerData)
	local owned = getOwnedTrails(playerData)
	local equipped = playerData.EquippedTrail
	if type(equipped) ~= "string"
		or (equipped ~= "" and (not owned[equipped] or not (GameConfig.Trails and GameConfig.Trails[equipped]))) then
		playerData.EquippedTrail = ""
		PlayerDataService.ScheduleSave(player)
	end
end

local function onBuyTrail(player, trailName)
	if type(trailName) ~= "string" then
		return false
	end
	local cfg = GameConfig.Trails and GameConfig.Trails[trailName]
	if not cfg then
		return false
	end
	-- Robux-exclusive trails (Price = 0 + RobuxOnly) only enter through the
	-- GrantTrail receipt path -- refusing here keeps a spoofed BuyTrail
	-- invoke from claiming them for free
	if cfg.RobuxOnly then
		return false
	end
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then
		return false
	end

	local owned = getOwnedTrails(playerData)

	if not owned[trailName] then
		local price = cfg.Price or 0
		if price > 0 then
			if (playerData.Cash or 0) < price then
				NotEnoughCashEvent:FireClient(player)
				return false
			end
			local ok = PlayerDataService.AddStat(player, "Cash", -price)
			if not ok then
				return false
			end
		end
		owned[trailName] = true
	end

	playerData.EquippedTrail = trailName
	PlayerDataService.ScheduleSave(player)
	pushUpdate(player, playerData)
	return true
end

-- Equip toggles: equipping the currently-equipped trail unequips it.
local function onEquipTrail(player, trailName)
	if type(trailName) ~= "string" then
		return false
	end
	if not (GameConfig.Trails and GameConfig.Trails[trailName]) then
		return false
	end
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then
		return false
	end
	if not getOwnedTrails(playerData)[trailName] then
		return false
	end
	if playerData.EquippedTrail == trailName then
		playerData.EquippedTrail = ""
	else
		playerData.EquippedTrail = trailName
	end
	PlayerDataService.ScheduleSave(player)
	pushUpdate(player, playerData)
	return true
end

local function onRequestTrailData(player)
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then
		return nil
	end
	ensureBaseline(player, playerData)
	return buildPayload(playerData)
end

-- Robux receipt path (PurchaseService context "BuyTrail_<name>"): grant
-- without touching cash, then auto-equip. Never refuse an already-owned
-- trail -- the Robux was already charged, equipping is the least-wrong grant.
function TrailShopService.GrantTrail(player, trailName)
	if type(trailName) ~= "string" then
		return false
	end
	if not (GameConfig.Trails and GameConfig.Trails[trailName]) then
		warn("[TrailShopService] Robux grant for unknown trail:", trailName)
		return false
	end
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then
		return false
	end
	getOwnedTrails(playerData)[trailName] = true
	playerData.EquippedTrail = trailName
	PlayerDataService.ScheduleSave(player)
	pushUpdate(player, playerData)
	return true
end

function TrailShopService.Init()
	ensureRemotes()

	BuyTrailFunc.OnServerInvoke = onBuyTrail
	EquipTrailFunc.OnServerInvoke = onEquipTrail
	RequestTrailDataFunc.OnServerInvoke = onRequestTrailData

	PlayerDataService.ProfileLoaded.Event:Connect(function(player)
		local playerData = PlayerDataService.GetPlayerData(player)
		if not playerData then
			return
		end
		ensureBaseline(player, playerData)
		pushUpdate(player, playerData)
	end)

	-- respawns lose the HRP attachments; rebuild from the attribute
	Players.PlayerAdded:Connect(function(player)
		player.CharacterAdded:Connect(function(character)
			task.defer(applyCharacterTrail, player, character)
		end)
	end)
	for _, player in ipairs(Players:GetPlayers()) do
		player.CharacterAdded:Connect(function(character)
			task.defer(applyCharacterTrail, player, character)
		end)
		if player.Character then
			task.defer(applyCharacterTrail, player, player.Character)
		end
	end
end

return TrailShopService