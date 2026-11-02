--[[
	StrengthLadderServer -- the x2 Strength gamepass replaced by a
	repeat-purchase DEV PRODUCT ladder (2026-07-23): each tier doubles the
	player's permanent strength multiplier (x2 -> x4 -> ... -> x1024, see
	GameConfig.StrengthLadder). The owned tier persists in the profile
	(StrengthMultLevel) and is mirrored to two player attributes:
	  StrengthMultLevel  -- owned tier index (0 = none)
	  StrengthLadderMult -- 2^tier, read by every strength formula
	    (StrengthClickServer clicks, DrillSystemServer pad payouts + layer
	    damage, PodiumService offline strength, StrengthClickClient popup).
	The HUD X2DrillPanel (X2StrengthPassController) invokes the
	StrengthLadderRemote RemoteFunction to buy the NEXT tier -- the server
	picks the product for the player's current tier (the client never
	chooses a product id), prompts through PurchaseService and grants in
	the receipt callback.
	Legacy: owners of the retired x2 Strength gamepass (off-sale) keep
	their doubling -- pass ownership floors the tier at 1.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local GameConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("GameConfig"))

local LADDER = GameConfig.StrengthLadder or {}
local PASS_ATTR = "OwnsGamepass_x2Strength"
local LEVEL_ATTR = "StrengthMultLevel"
local MULT_ATTR = "StrengthLadderMult"

local remote = Instance.new("RemoteFunction")
remote.Name = "StrengthLadderRemote"
remote.Parent = ReplicatedStorage

-- required in the BACKGROUND, same reason as StrengthClickServer: the
-- service require chain once froze whole scripts at module level
local PlayerDataService
local PurchaseService
local dataLoaded = {} -- [player] = true once the profile tier is mirrored
local prompting = {}  -- [player] = true while a ladder prompt is pending

local function applyLevel(plr, level)
	level = math.clamp(math.floor(tonumber(level) or 0), 0, #LADDER)
	plr:SetAttribute(LEVEL_ATTR, level)
	plr:SetAttribute(MULT_ATTR, 2 ^ level)
	return level
end

local function writeThrough(plr, level)
	local data = PlayerDataService and PlayerDataService.GetPlayerData(plr)
	if data then
		data.StrengthMultLevel = level
	end
end

local function loadFromProfile(plr, data)
	if dataLoaded[plr] or not plr.Parent then return end
	dataLoaded[plr] = true
	local level = math.max(math.floor(tonumber(data.StrengthMultLevel) or 0), 0)
	-- legacy x2 Strength gamepass owners never drop below tier 1
	if plr:GetAttribute(PASS_ATTR) == true then
		level = math.max(level, 1)
	end
	level = applyLevel(plr, level)
	data.StrengthMultLevel = level
end

-- GamepassService mirrors pass ownership asynchronously, so the legacy
-- floor must also react to the attribute arriving AFTER the profile
local function onPassChanged(plr)
	if plr:GetAttribute(PASS_ATTR) ~= true then return end
	if not dataLoaded[plr] then return end -- loadFromProfile applies the floor
	local level = tonumber(plr:GetAttribute(LEVEL_ATTR)) or 0
	if level < 1 then
		writeThrough(plr, applyLevel(plr, 1))
	end
end

local function setupPlayer(plr)
	-- immediate defaults so formulas and UI have values from frame one; the
	-- saved tier overwrites them as soon as the profile loads
	if plr:GetAttribute(LEVEL_ATTR) == nil then
		applyLevel(plr, 0)
	end
	plr:GetAttributeChangedSignal(PASS_ATTR):Connect(function()
		onPassChanged(plr)
	end)
	onPassChanged(plr)
end

remote.OnServerInvoke = function(plr)
	if not dataLoaded[plr] then return false end -- profile not mirrored yet
	if prompting[plr] then return false end      -- one prompt at a time
	local level = tonumber(plr:GetAttribute(LEVEL_ATTR)) or 0
	local entry = LADDER[level + 1]
	if not entry or not entry.ProductId or entry.ProductId == 0 then return false end
	if not PurchaseService or not PurchaseService.PromptProduct then return false end

	prompting[plr] = true
	PurchaseService.PromptProduct(plr, entry.ProductId, "StrengthLadder", function(success)
		prompting[plr] = nil
		if not success or not plr.Parent then return end
		-- re-read at grant time so a stale closure can never skip a tier
		local nowLevel = tonumber(plr:GetAttribute(LEVEL_ATTR)) or 0
		writeThrough(plr, applyLevel(plr, nowLevel + 1))
	end)
	return true
end

task.spawn(function()
	PurchaseService = require(ServerScriptService.Source.Services.PurchaseService)
	PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)
	PlayerDataService.ProfileLoaded.Event:Connect(function(plr, data)
		loadFromProfile(plr, data)
	end)
	-- profiles that finished loading before this require resolved
	for _, plr in ipairs(Players:GetPlayers()) do
		local data = PlayerDataService.GetPlayerData(plr)
		if data then loadFromProfile(plr, data) end
	end
end)

Players.PlayerAdded:Connect(setupPlayer)
Players.PlayerRemoving:Connect(function(plr)
	dataLoaded[plr] = nil
	prompting[plr] = nil
end)
for _, plr in ipairs(Players:GetPlayers()) do setupPlayer(plr) end
