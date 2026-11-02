local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)
local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)

local RebirthService = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local RebirthRemotes = Remotes:WaitForChild("RebirthService")
local RequestRebirthFunc = RebirthRemotes:WaitForChild("RequestRebirth")
local RequestSkipRebirthFunc = RebirthRemotes:WaitForChild("RequestSkipRebirth")
local RequestRebirthDataFunc = RebirthRemotes:WaitForChild("RequestRebirthData")
local RebirthUpdateEvent = RebirthRemotes:WaitForChild("RebirthUpdate")

local CASH_PER_REBIRTH = (GameConfig.Rebirth and GameConfig.Rebirth.CashMultiplierPerRebirth) or 0.25
local MATERIAL_PER_REBIRTH = (GameConfig.Rebirth and GameConfig.Rebirth.MaterialMultiplierPerRebirth) or 0.1
local STRENGTH_PER_REBIRTH = (GameConfig.Rebirth and GameConfig.Rebirth.StrengthMultiplierPerRebirth) or 0.5
-- Rebirth gates on the drilling Level (StrengthClickServer owns the "Level"
-- player attribute) -- the Rebirth frame advertises exactly this requirement.
-- LINEAR: 25 + 25 * N -> 25, 50, ..., 250 at 9 rebirths
-- (GameConfig.Rebirth.GetRequiredLevel is the single source of truth; the
-- old quadratic collided with the exponential XP curve and asked for
-- trillion-XP levels by rebirth 7-9).
local function getRequiredLevel(rebirthCount)
	local getRequired = GameConfig.Rebirth and GameConfig.Rebirth.GetRequiredLevel
	if getRequired then
		return getRequired(rebirthCount)
	end
	return 25 + 25 * rebirthCount
end

local function getPlayerLevel(player)
	return tonumber(player:GetAttribute("Level")) or 1
end

-- Robux skip ladder: entry [rebirths + 1] buys the NEXT rebirth (price
-- escalates per rebirth); nil once the player is past MaxRobuxRebirths --
-- only the first 10 rebirths are Robux-buyable.
local function skipLadderEntry(rebirthCount)
	local cfg = GameConfig.Rebirth
	local ladder = cfg and cfg.RobuxLadder
	if not ladder then
		return nil
	end
	local maxBuyable = (cfg and cfg.MaxRobuxRebirths) or #ladder
	if rebirthCount >= maxBuyable then
		return nil
	end
	return ladder[rebirthCount + 1]
end

local function getCashMultiplier(rebirthCount)
	return 1 + rebirthCount * CASH_PER_REBIRTH
end

local function getMaterialMultiplier(rebirthCount)
	return 1 + rebirthCount * MATERIAL_PER_REBIRTH
end

-- Strength-GAIN multiplier: StrengthClickServer (clicks) and
-- DrillSystemServer (training pads) multiply their grants by the
-- StrengthMultiplier attribute -- the payback for the Strength reset below.
local function getStrengthMultiplier(rebirthCount)
	return 1 + rebirthCount * STRENGTH_PER_REBIRTH
end

local function pushMultiplierAttributes(player, rebirths)
	player:SetAttribute("CashMultiplier", getCashMultiplier(rebirths))
	player:SetAttribute("MaterialMultiplier", getMaterialMultiplier(rebirths))
	player:SetAttribute("StrengthMultiplier", getStrengthMultiplier(rebirths))
	player:SetAttribute("Rebirths", rebirths)
end

local function buildRebirthPayload(player, playerData)
	local currentRebirths = playerData.Rebirths or 0
	local currentLevel = getPlayerLevel(player)
	local requiredLevel = getRequiredLevel(currentRebirths)
	local skipEntry = skipLadderEntry(currentRebirths)
	return {
		CurrentRebirths = currentRebirths,
		NextRebirths = currentRebirths + 1,
		CurrentCashMultiplier = getCashMultiplier(currentRebirths),
		NextCashMultiplier = getCashMultiplier(currentRebirths + 1),
		CurrentMaterialMultiplier = getMaterialMultiplier(currentRebirths),
		NextMaterialMultiplier = getMaterialMultiplier(currentRebirths + 1),
		CurrentStrengthMultiplier = getStrengthMultiplier(currentRebirths),
		NextStrengthMultiplier = getStrengthMultiplier(currentRebirths + 1),
		CurrentLevel = currentLevel,
		RequiredLevel = requiredLevel,
		MeetsRequirements = currentLevel >= requiredLevel,
		IsMaxRebirth = false,
		-- Robux skip: price of the next rebirth (nil past MaxRobuxRebirths
		-- or while the ladder product id is still a 0 placeholder) -- the
		-- client hides the Skip button when CanSkip is false.
		SkipPrice = skipEntry and skipEntry.Price or nil,
		CanSkip = skipEntry ~= nil and (skipEntry.ProductId or 0) ~= 0,
	}
end

local function pushPayload(player)
	local pd = PlayerDataService.GetPlayerData(player)
	if not pd then return end
	RebirthUpdateEvent:FireClient(player, buildRebirthPayload(player, pd))
end

local function performRebirth(player, skipMode)
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then
		return false
	end

	local currentRebirths = playerData.Rebirths or 0

	if not skipMode then
		if getPlayerLevel(player) < getRequiredLevel(currentRebirths) then
			return false
		end
	end

	-- Cash SURVIVES rebirth (user spec 2026-07-16): rebirthing only resets
	-- the click progression (Strength / Level / XP, below) and pays back
	-- with the permanent multipliers.
	PlayerDataService.SetStat(player, "Rebirths", currentRebirths + 1)

	-- rebirth also resets the click progression (user spec): Strength back to
	-- 0, Level back to 1 -- handled by StrengthClickServer so the attribute +
	-- profile writes stay in one place
	local clickServer = ServerScriptService:FindFirstChild("StrengthClickServer")
	local resetStrength = clickServer and clickServer:FindFirstChild("ResetStrength")
	if resetStrength then
		resetStrength:Fire(player)
	else
		warn("[RebirthService] ResetStrength bindable not found")
	end

	-- The ResetStrength bindable above resets Strength 0 / Level 1 / XP 0
	-- (attributes + profile) -- and ONLY that progression. Cash, drills,
	-- trails, loot, every boost AND the upgrade-shop levels all survive:
	-- the old Cash wipe + ResetForRebirth calls (upgrades + bridge
	-- material) are gone per the user's rebirth design. The payback is the
	-- permanent StrengthMultiplier pushed below.
	-- Attribute AND profile both reset so a rejoin right after rebirth
	-- can't restore it (StrengthClickServer mirrors attribute -> profile).
	player:SetAttribute("Strength", 0)
	playerData.Strength = 0
	PlayerDataService.ScheduleSave(player)

	pushMultiplierAttributes(player, currentRebirths + 1)
	pushPayload(player)
	return true
end

function RebirthService.GetCashMultiplier(player)
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then return 1.0 end
	return getCashMultiplier(playerData.Rebirths or 0)
end

function RebirthService.GetMaterialMultiplier(player)
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then return 1.0 end
	return getMaterialMultiplier(playerData.Rebirths or 0)
end

-- Admin console grant (AdminCommandsService "giverebirth"): the same paid
-- skip path the Robux ladder uses -- level requirement bypassed, Strength /
-- Level / XP reset like any real rebirth, multipliers pushed.
function RebirthService.GrantRebirth(player)
	return performRebirth(player, true)
end

function RebirthService.Init()
	RequestRebirthFunc.OnServerInvoke = function(p) return performRebirth(p, false) end
	-- Robux skip: the server picks the ladder product for the player's
	-- CURRENT rebirth count and grants inside the purchase callback. (The
	-- old handler granted the rebirth directly, so any exploiter invoking
	-- the remote got a free rebirth -- the client never sends a product id
	-- anymore, it just asks to start the purchase.) Returns true once the
	-- prompt opened; the grant lands via ProcessReceipt -> callback.
	RequestSkipRebirthFunc.OnServerInvoke = function(p)
		local pd = PlayerDataService.GetPlayerData(p)
		if not pd then return false end
		local entry = skipLadderEntry(pd.Rebirths or 0)
		if not entry or (entry.ProductId or 0) == 0 then return false end
		local okPS, PurchaseService = pcall(require, ServerScriptService.Source.Services.PurchaseService)
		if not okPS or not PurchaseService or not PurchaseService.PromptProduct then
			warn("[RebirthService] PurchaseService unavailable for Robux skip")
			return false
		end
		PurchaseService.PromptProduct(p, entry.ProductId, "SkipRebirth", function(success)
			if success then
				performRebirth(p, true)
			end
		end)
		return true
	end
	RequestRebirthDataFunc.OnServerInvoke = function(p)
		local pd = PlayerDataService.GetPlayerData(p)
		if not pd then return nil end
		return buildRebirthPayload(p, pd)
	end

	PlayerDataService.ProfileLoaded.Event:Connect(function(player)
		local pd = PlayerDataService.GetPlayerData(player)
		if pd then
			pushMultiplierAttributes(player, pd.Rebirths or 0)
		end
		task.defer(pushPayload, player)
		-- level-ups change MeetsRequirements, so keep the client payload fresh
		player:GetAttributeChangedSignal("Level"):Connect(function()
			pushPayload(player)
		end)
	end)

	PlayerDataService.DataChanged.Event:Connect(function(player, statName)
		if statName == "Rebirths" then
			pushPayload(player)
		end
	end)
end

return RebirthService