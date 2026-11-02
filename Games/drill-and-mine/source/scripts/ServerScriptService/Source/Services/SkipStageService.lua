--[[
	SkipStageService
	Makes the green SkipStagePad in every "DestroyPart ZoneN" folder a real
	Robux purchase (GameConfig.SkipZones: one dev product per zone, prices
	9 -> 499). At Init it stamps each pad's ProductId + SkipPrice attributes
	and billboard PriceLabel from the config; SkipPadClient fires the
	SkipStage remote when the player steps on a pad, the purchase runs
	through PurchaseService.PromptProduct, and on success the player is
	teleported onto the NEXT zone's top layer (zone 30 -> back to spawn).
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Workspace = game:GetService("Workspace")

local PurchaseService = require(ServerScriptService.Source.Services.PurchaseService)
local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)

local SkipStageService = {}

local MAX_PAD_DISTANCE = 30
local promptCooldown = {} -- [player] = os.clock() of the last prompt

local function zoneFolder(n)
	return Workspace:FindFirstChild("DestroyPart Zone" .. n)
end

local function setLabelText(label, text)
	if not label then
		return
	end
	label.Text = text
	for _, d in ipairs(label:GetDescendants()) do
		if d:IsA("TextLabel") then
			d.Text = text
		end
	end
end

local function stampPads()
	for n, cfg in pairs(GameConfig.SkipZones or {}) do
		local folder = zoneFolder(n)
		local padModel = folder and folder:FindFirstChild("SkipStagePad", true)
		local pad = padModel and padModel:FindFirstChild("Pad")
		if pad then
			pad:SetAttribute("ProductId", cfg.ProductId or 0)
			pad:SetAttribute("SkipPrice", cfg.Price or 0)
			local billboard = padModel:FindFirstChild("SkipBillboard", true)
			local priceLabel = billboard and billboard:FindFirstChild("PriceLabel", true)
			if priceLabel then
				-- Robux SYMBOL glyph inline in the text (game-wide standard,
				-- same as the shop Robux buttons), not an icon image
				setLabelText(priceLabel, utf8.char(0xE002) .. tostring(cfg.Price or 0))
			end
		else
			-- zone 30 is deliberately padless (final zone -- nothing to skip into)
			if n ~= 30 then
				warn(string.format("[SkipStageService] no SkipStagePad found for zone %d", n))
			end
		end
	end
end

-- The zone the given Pad part belongs to, or nil for anything that isn't
-- a real skip pad (the client hands us an instance -- never trust it).
local function zoneOfPad(pad)
	if typeof(pad) ~= "Instance" or not pad:IsA("BasePart") or pad.Name ~= "Pad" then
		return nil
	end
	local model = pad.Parent
	if not (model and model.Name == "SkipStagePad") then
		return nil
	end
	local node = model.Parent
	while node and node ~= Workspace do
		local n = node.Name:match("^DestroyPart Zone(%d+)$")
		if n then
			return tonumber(n)
		end
		node = node.Parent
	end
	return nil
end

-- Landing spot for a skip INTO zone n: the zone's floor island
-- (Assets.Islands.Zone<n>Island) -- NOT the drillable DoublePart layer
-- stack, which sits up on the zone wall and dropped skippers onto it.
-- The old layer/pad lookups remain only as fallbacks for a missing island.
local function zoneLandingCFrame(n)
	local assets = Workspace:FindFirstChild("Assets")
	local islands = assets and assets:FindFirstChild("Islands")
	local island = islands and islands:FindFirstChild("Zone" .. n .. "Island")
	if island and island:IsA("BasePart") then
		return CFrame.new(island.Position + Vector3.new(0, island.Size.Y / 2 + 4, 0))
	end

	local folder = zoneFolder(n)
	if not folder then
		return nil
	end
	local best
	for _, c in ipairs(folder:GetChildren()) do
		if c:IsA("BasePart") and c:FindFirstChild("FrontProgressSurfaceGui") then
			if not best or c.Position.Y > best.Position.Y then
				best = c
			end
		end
	end
	if not best then
		local padModel = folder:FindFirstChild("SkipStagePad", true)
		best = padModel and padModel:FindFirstChild("Pad")
	end
	if not best then
		return nil
	end
	return CFrame.new(best.Position + Vector3.new(0, best.Size.Y / 2 + 4, 0))
end

local function surfaceCFrame()
	local spawnLocation = Workspace:FindFirstChildWhichIsA("SpawnLocation", true)
	if spawnLocation then
		return CFrame.new(spawnLocation.Position + Vector3.new(0, 4, 0))
	end
	return nil
end

local function teleportAfterSkip(player, fromZone)
	local character = player.Character
	local hrp = character and character:FindFirstChild("HumanoidRootPart")
	if not hrp then
		return
	end
	local target
	if fromZone >= 30 then
		-- last zone: back to the surface
		target = surfaceCFrame()
	else
		target = zoneLandingCFrame(fromZone + 1)
	end
	if target then
		character:PivotTo(target)
	end
end

local function onSkipRequested(player, pad)
	local n = zoneOfPad(pad)
	if not n then
		return
	end
	local cfg = GameConfig.SkipZones and GameConfig.SkipZones[n]
	if not cfg or not cfg.ProductId or cfg.ProductId == 0 then
		return
	end

	-- the player must actually be at the pad
	local character = player.Character
	local hrp = character and character:FindFirstChild("HumanoidRootPart")
	if not hrp or (hrp.Position - pad.Position).Magnitude > MAX_PAD_DISTANCE then
		return
	end

	local now = os.clock()
	if promptCooldown[player] and now - promptCooldown[player] < 2 then
		return
	end
	promptCooldown[player] = now

	PurchaseService.PromptProduct(player, cfg.ProductId, "SkipZone_" .. n, function(success)
		if success and player.Parent then
			teleportAfterSkip(player, n)
		end
	end)
end

function SkipStageService.Init()
	local remotes = ReplicatedStorage:WaitForChild("Remotes")
	local remote = remotes:FindFirstChild("SkipStage")
	if not remote then
		remote = Instance.new("RemoteEvent")
		remote.Name = "SkipStage"
		remote.Parent = remotes
	end
	remote.OnServerEvent:Connect(onSkipRequested)

	Players.PlayerRemoving:Connect(function(player)
		promptCooldown[player] = nil
	end)

	task.defer(stampPads)
end

return SkipStageService