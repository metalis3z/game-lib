--[[
	DrillShopService
	Owns the drill catalog state per player: OwnedDrills + SelectedDrill in
	the profile, mirrored to the SelectedDrill / DrillPower player attributes
	that DrillSystemServer reads (template lookup + damage bonus).
	Cash purchases run through here; Robux purchases are granted by
	PurchaseService via the "BuyDrill_<name>" receipt context calling GrantDrill.
	Buying always auto-equips.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)
local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)

local DrillShopService = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local NotEnoughCashEvent = Remotes:WaitForChild("NotEnoughCash")

local DEFAULT_DRILL = GameConfig.DefaultDrill or "Drill1 - Wood"
local SELECTED_ATTR = "SelectedDrill"
local POWER_ATTR = "DrillPower"

local DrillShopRemotes
local BuyDrillFunc
local EquipDrillFunc
local RequestDrillDataFunc
local DrillUpdateEvent

local function ensureRemotes()
	DrillShopRemotes = Remotes:FindFirstChild("DrillShopService")
	if not DrillShopRemotes then
		DrillShopRemotes = Instance.new("Folder")
		DrillShopRemotes.Name = "DrillShopService"
		DrillShopRemotes.Parent = Remotes
	end

	local function ensureFunc(name)
		local f = DrillShopRemotes:FindFirstChild(name)
		if not f then
			f = Instance.new("RemoteFunction")
			f.Name = name
			f.Parent = DrillShopRemotes
		end
		return f
	end

	BuyDrillFunc = ensureFunc("BuyDrill")
	EquipDrillFunc = ensureFunc("EquipDrill")
	RequestDrillDataFunc = ensureFunc("RequestDrillData")

	DrillUpdateEvent = DrillShopRemotes:FindFirstChild("DrillUpdate")
	if not DrillUpdateEvent then
		DrillUpdateEvent = Instance.new("RemoteEvent")
		DrillUpdateEvent.Name = "DrillUpdate"
		DrillUpdateEvent.Parent = DrillShopRemotes
	end
end

local function getOwnedDrills(playerData)
	playerData.OwnedDrills = playerData.OwnedDrills or {}
	return playerData.OwnedDrills
end

local function buildPayload(playerData)
	return {
		OwnedDrills = getOwnedDrills(playerData),
		SelectedDrill = playerData.SelectedDrill or DEFAULT_DRILL,
	}
end

-- Mirror profile state to attributes. DrillPower is set BEFORE
-- SelectedDrill: DrillSystemServer rebuilds the character visual on the
-- SelectedDrill change, so both attributes must already be final then.
local function pushUpdate(player, playerData)
	local drillName = playerData.SelectedDrill or DEFAULT_DRILL
	local cfg = GameConfig.Drills and GameConfig.Drills[drillName]
	player:SetAttribute(POWER_ATTR, (cfg and cfg.Power) or 0)
	player:SetAttribute(SELECTED_ATTR, drillName)
	DrillUpdateEvent:FireClient(player, buildPayload(playerData))
end

local function ensureBaseline(player, playerData)
	local owned = getOwnedDrills(playerData)
	local changed = false

	if not owned[DEFAULT_DRILL] then
		owned[DEFAULT_DRILL] = true
		changed = true
	end

	local selected = playerData.SelectedDrill
	if type(selected) ~= "string" or selected == "" or not owned[selected] or not (GameConfig.Drills and GameConfig.Drills[selected]) then
		playerData.SelectedDrill = DEFAULT_DRILL
		changed = true
	end

	if changed then
		PlayerDataService.ScheduleSave(player)
	end
end

local function onBuyDrill(player, drillName)
	if type(drillName) ~= "string" then
		return false
	end
	local cfg = GameConfig.Drills and GameConfig.Drills[drillName]
	if not cfg then
		return false
	end
	-- Robux-exclusive drills only enter through the GrantDrill receipt path
	-- (same guard as the Gold Trail) -- a spoofed BuyDrill invoke must not
	-- claim them for cash
	if cfg.RobuxOnly then
		return false
	end
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then
		return false
	end

	local owned = getOwnedDrills(playerData)

	if not owned[drillName] then
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
		owned[drillName] = true
	end

	playerData.SelectedDrill = drillName
	PlayerDataService.ScheduleSave(player)
	pushUpdate(player, playerData)
	return true
end

local function onEquipDrill(player, drillName)
	if type(drillName) ~= "string" then
		return false
	end
	if not (GameConfig.Drills and GameConfig.Drills[drillName]) then
		return false
	end
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then
		return false
	end
	if not getOwnedDrills(playerData)[drillName] then
		return false
	end
	playerData.SelectedDrill = drillName
	PlayerDataService.ScheduleSave(player)
	pushUpdate(player, playerData)
	return true
end

local function onRequestDrillData(player)
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then
		return nil
	end
	ensureBaseline(player, playerData)
	return buildPayload(playerData)
end

-- Robux receipt path (PurchaseService context "BuyDrill_<name>"): grant
-- without touching cash, then auto-equip. Never refuse an already-owned
-- drill -- the Robux was already charged, equipping is the least-wrong grant.
function DrillShopService.GrantDrill(player, drillName)
	if type(drillName) ~= "string" then
		return false
	end
	if not (GameConfig.Drills and GameConfig.Drills[drillName]) then
		warn("[DrillShopService] Robux grant for unknown drill:", drillName)
		return false
	end
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then
		return false
	end
	getOwnedDrills(playerData)[drillName] = true
	playerData.SelectedDrill = drillName
	PlayerDataService.ScheduleSave(player)
	pushUpdate(player, playerData)
	return true
end

function DrillShopService.Init()
	ensureRemotes()

	BuyDrillFunc.OnServerInvoke = onBuyDrill
	EquipDrillFunc.OnServerInvoke = onEquipDrill
	RequestDrillDataFunc.OnServerInvoke = onRequestDrillData

	PlayerDataService.ProfileLoaded.Event:Connect(function(player)
		local playerData = PlayerDataService.GetPlayerData(player)
		if not playerData then
			return
		end
		ensureBaseline(player, playerData)
		pushUpdate(player, playerData)
	end)
end

return DrillShopService
