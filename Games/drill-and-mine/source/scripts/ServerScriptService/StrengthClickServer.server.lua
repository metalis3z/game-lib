-- StrengthClickServer: Strength/XP per click, level curve, level-up FX.
-- One click grants (1 + equipped drill Power) * equipped trail Boost --
-- the drill and the trail CUMULATE, so upgrading either directly raises
-- the per-click value (bare hands + no trail = the original +1).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local remote = ReplicatedStorage:WaitForChild("StrengthClickRemote")

local MAX_CLICKS_PER_SEC = 18

local function xpForLevel(level)
	-- exponential curve snapped to CLEAN numbers (user request: never show a
	-- "49"-style requirement): multiples of 5 below 100 (50, 55, 60, ...),
	-- 2 significant digits above (110, 270, 4.3K, ...)
	-- Growth retuned 1.095 -> 1.05 (2026-07-16, user: level ~330 must cost
	-- BILLIONS of total XP, not quadrillions; at 1.095 it cost ~5
	-- quadrillion). At 1.05: level 250 ~ 190M total, 330 ~ 9B, 500 ~ 40T.
	local raw = 50 * (1.05 ^ (level - 1))
	if raw < 100 then
		return math.floor(raw / 5 + 0.5) * 5
	end
	local mag = 10 ^ (math.floor(math.log10(raw)) - 1)
	return math.floor(raw / mag + 0.5) * mag
end

local lastClick = {}   -- [player] = {t = clock, count = n}
local boostCarry = {}  -- [player] = fractional Strength owed by the trail boost

-- ===== Persistence =====
-- Strength / Level / XP live in the ProfileService profile (fields in
-- GameConfig.Data.PlayerDataTemplate; the profile saves on release +
-- periodic autosave). PlayerDataService is required in the BACKGROUND --
-- its GameConfig chain once froze whole scripts at module level. Until a
-- player's saved values are mirrored into their attributes, clicks and
-- grants for them are dropped: a sub-second window on join that
-- guarantees defaults never overwrite (or double-count into) saved data.
local PlayerDataService
local dataLoaded = {} -- [player] = true once attributes mirror the profile

-- Equipped-trail Strength multiplier (TrailShopService mirrors it to the
-- TrailBoost attribute). Applies to CLICK gains here and to training-pad
-- payouts in DrillSystemServer; Robux strength packs stay unboosted.
local function trailBoost(plr)
	local boost = tonumber(plr:GetAttribute("TrailBoost")) or 1
	return math.max(boost, 1)
end

-- Equipped-drill click multiplier (DrillShopService mirrors the drill's
-- Power to the DrillPower attribute). 1 + Power so the starter Wood drill
-- (Power 0) keeps the classic +1 baseline while every shop drill makes
-- clicks hit harder; multiplied with the trail boost, never added.
local function drillFactor(plr)
	local power = tonumber(plr:GetAttribute("DrillPower")) or 0
	return 1 + math.max(power, 0)
end

-- Permanent rebirth reward (RebirthService mirrors it to the
-- StrengthMultiplier attribute): rebirth resets Strength to 0 and pays it
-- back with this gain multiplier on clicks and training pads.
local function rebirthBoost(plr)
	local mult = tonumber(plr:GetAttribute("StrengthMultiplier")) or 1
	return math.max(mult, 1)
end

-- Strength ladder (StrengthLadderServer mirrors the owned tier to the
-- StrengthLadderMult attribute): permanent x2..x1024 on clicks and pads.
local function passBoost(plr)
	return math.max(tonumber(plr:GetAttribute("StrengthLadderMult")) or 1, 1)
end

local function setupPlayer(plr)
	-- immediate defaults so UI bindings have values from frame one; the
	-- saved values overwrite them as soon as the profile loads
	if plr:GetAttribute("Level") == nil then plr:SetAttribute("Level", 1) end
	if plr:GetAttribute("XP") == nil then plr:SetAttribute("XP", 0) end
	plr:SetAttribute("XPMax", xpForLevel(plr:GetAttribute("Level")))
	if plr:GetAttribute("Strength") == nil then plr:SetAttribute("Strength", 0) end
end

local function loadFromProfile(plr, data)
	if dataLoaded[plr] or not plr.Parent then return end
	dataLoaded[plr] = true
	local level = math.max(math.floor(tonumber(data.Level) or 1), 1)
	plr:SetAttribute("Strength", tonumber(data.Strength) or 0)
	plr:SetAttribute("Level", level)
	plr:SetAttribute("XPMax", xpForLevel(level))
	plr:SetAttribute("XP", tonumber(data.XP) or 0)
end

task.spawn(function()
	local ServerScriptService = game:GetService("ServerScriptService")
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

-- Level-up FX is CLIENT-side (StrengthClickClient's "levelup" handler).
-- The old server-side Sound + ParticleEmitter on the character replicated
-- to EVERY player in the server; now only the leveling player sees and
-- hears their own burst.
local function levelUpFX(plr)
	remote:FireClient(plr, "levelup")
end

-- Shared grant path: world clicks, training-pad payouts and Robux strength
-- packs all land here. FX plays once per grant even when a big grant
-- crosses several levels at once; every grant is written through to the
-- profile so it survives rejoins.
local function applyGain(plr, amount)
	plr:SetAttribute("Strength", (plr:GetAttribute("Strength") or 0) + amount)
	local xp = (plr:GetAttribute("XP") or 0) + amount
	local level = plr:GetAttribute("Level") or 1
	local xpMax = plr:GetAttribute("XPMax") or xpForLevel(level)

	local leveled = false
	while xp >= xpMax do
		xp -= xpMax
		level += 1
		xpMax = xpForLevel(level)
		plr:SetAttribute("Level", level)
		plr:SetAttribute("XPMax", xpMax)
		leveled = true
	end
	if leveled then levelUpFX(plr) end
	plr:SetAttribute("XP", xp)
	-- write-through to the profile (an in-memory table write): ProfileService
	-- autosaves periodically and saves on release, so this costs no per-click
	-- DataStore traffic while making every gain rejoin-proof
	local data = PlayerDataService and PlayerDataService.GetPlayerData(plr)
	if data then
		data.Strength = plr:GetAttribute("Strength")
		data.Level = level
		data.XP = xp
	end
end

-- Server-to-server full reset (RebirthService): rebirthing puts the click
-- progression back to zero -- Strength 0, Level 1, XP 0 -- in the
-- attributes AND the profile, so it survives the rejoin too.
local resetBindable = Instance.new("BindableEvent")
resetBindable.Name = "ResetStrength"
resetBindable.Parent = script
resetBindable.Event:Connect(function(plr)
	if typeof(plr) ~= "Instance" or not plr:IsA("Player") or not plr.Parent then return end
	plr:SetAttribute("Strength", 0)
	plr:SetAttribute("Level", 1)
	plr:SetAttribute("XPMax", xpForLevel(1))
	plr:SetAttribute("XP", 0)
	boostCarry[plr] = nil
	local data = PlayerDataService and PlayerDataService.GetPlayerData(plr)
	if data then
		data.Strength = 0
		data.Level = 1
		data.XP = 0
	end
end)

-- Server-to-server grants (training ore pads): fire with (player, amount)
local grantBindable = Instance.new("BindableEvent")
grantBindable.Name = "GrantStrength"
grantBindable.Parent = script
grantBindable.Event:Connect(function(plr, amount)
	if typeof(plr) ~= "Instance" or not plr:IsA("Player") or not plr.Parent then return end
	if not dataLoaded[plr] then return end -- profile not mirrored yet (see Persistence)
	amount = math.floor(tonumber(amount) or 0)
	if amount < 1 then return end
	applyGain(plr, amount)
end)

remote.OnServerEvent:Connect(function(plr)
	if not dataLoaded[plr] then return end -- profile not mirrored yet (see Persistence)
	-- simple rate limit
	local now = os.clock()
	local entry = lastClick[plr]
	if not entry or now - entry.t >= 1 then
		entry = { t = now, count = 0 }
		lastClick[plr] = entry
	end
	entry.count += 1
	if entry.count > MAX_CLICKS_PER_SEC then return end

	-- no strength clicking while underground in the zones
	local char = plr.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp and hrp.Position.Y < -4 then return end

	-- standing on a training pad: the pad is already granting strength
	if plr:GetAttribute("OnTrainingPad") then return end

	-- one click = (1 + drill Power) * trail boost * rebirth multiplier *
	-- ladder multiplier; the fractional part is carried so a x1.2 trail
	-- still averages exactly 1.2x with integer grants (+1, +1, +1, +2, ...)
	local gain = drillFactor(plr) * trailBoost(plr) * rebirthBoost(plr) * passBoost(plr) + (boostCarry[plr] or 0)
	local whole = math.floor(gain)
	boostCarry[plr] = gain - whole
	if whole >= 1 then
		applyGain(plr, whole)
	end
end)

Players.PlayerAdded:Connect(setupPlayer)
Players.PlayerRemoving:Connect(function(plr)
	lastClick[plr] = nil
	boostCarry[plr] = nil
	dataLoaded[plr] = nil
end)
for _, plr in ipairs(Players:GetPlayers()) do setupPlayer(plr) end
