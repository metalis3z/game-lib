-- Reference copy for study. Game: steal-a-brainrot-sab-files
-- Original: ServerScriptService/Services/StealService.lua
-- Excerpt of lines 24-26, 69-80, 139-139, 180-202, 311-420, 1897-1938 (code unchanged; gaps marked with "-- [...]")
-- What it does: The guard rails a later Steal-a-Brainrot build added around StartSteal: a per-podium steal
--   lock so two thieves can't grab the same item, a 1s steal cooldown, no stealing from players who are mid-
--   trade or who joined less than 30s ago, a capacity-aware free-podium finder, and a StealHitbox tracker per
--   plot.

-- [lines 24-26]
local playerJoinTimes = {}

local stealLocks: { [string]: boolean } = {}

-- [...]

-- [lines 69-80]
local function acquireStealLock(plotUID: string, podiumIndex: number): boolean
	local key = plotUID .. "_" .. tostring(podiumIndex)
	if stealLocks[key] then return false end
	stealLocks[key] = true
	return true

end

local function releaseStealLock(plotUID: string, podiumIndex: number)
	stealLocks[plotUID .. "_" .. tostring(podiumIndex)] = nil
end
StealService.WHITELIST = {

-- [...]

-- [lines 139-139]
local STEAL_PROTECTION_TIME = 30

-- [...]

-- [lines 180-202]
local function getMaxAnimals(player: Player): number
	local plot = _G.playerPlots[player.UserId]
	if not plot then
		return 100
	end
	local tier = plot:GetAttribute("Tier") or 0
	local baseData = BasesData[tier]
	local max = baseData and baseData.MaxAnimals or 100
	return max
end

local function findFreePodiumIndex(player: Player, animalList: table): number?
	local maxAnimals = getMaxAnimals(player)
	for i = 1, maxAnimals do
		local slot = animalList[i]
		if slot == "Empty" or slot == nil then
			return i
		end
	end
	return nil
end

local activeSteals: {[Player]: {

-- [...]

-- [lines 311-420]
function StealService:StartSteal(player: Player, victimPlotUID: string, podiumIndex: number, targetPodiumIndex: number?)
	warn(("[STEALDBG2] StartSteal entry uid=%s podium=%s (%s)"):format(tostring(victimPlotUID), tostring(podiumIndex), typeof(podiumIndex)))
	if not acquireStealLock(victimPlotUID, podiumIndex) then
		warn("[STEALDBG2] FAIL lock held")
		return
	end
	local character = player.Character
	if not player or not character or not victimPlotUID or not podiumIndex then return end
	if player:GetAttribute("Stealing") then
		releaseStealLock(victimPlotUID, podiumIndex) return
	end

	if player:GetAttribute("StealCooldown") then
		releaseStealLock(victimPlotUID, podiumIndex) return
	end
	player:SetAttribute("StealCooldown", true)
	task.delay(1, function()
		if player then
			player:SetAttribute("StealCooldown", nil)
		end
	end)
	local character = player.Character
	if not character then releaseStealLock(victimPlotUID, podiumIndex) return end

	local humanoid = character:FindFirstChild("Humanoid") :: Humanoid
	if not humanoid or humanoid.Health < 1 then releaseStealLock(victimPlotUID, podiumIndex) return end

	local victimPlotChannel = Synchronizer:Get(victimPlotUID)
	if not victimPlotChannel then releaseStealLock(victimPlotUID, podiumIndex) return end

	local victimPlayer = victimPlotChannel:Get("Owner")

	if typeof(victimPlayer) == "string" then
		victimPlayer = Players:FindFirstChild(victimPlayer)
	end

	if victimPlayer and victimPlayer:IsA("Player") and victimPlayer ~= player then
		local victimChannel = Synchronizer:Get(victimPlayer)
		if victimChannel and victimChannel:Get("StealImmune") == true then
			NotificationService.Error(player, "This player just teleported, try again shortly.", 5)
			releaseStealLock(victimPlotUID, podiumIndex)
			return
		end
	end

	if victimPlayer and victimPlayer:IsA("Player") then
		if victimPlayer ~= player and StealService.WHITELIST[victimPlayer.UserId] then
			NotificationService.Error(player, "You can't steal from this user", 2)
			releaseStealLock(victimPlotUID, podiumIndex)
			return
		end

		local TradeService = require(ServerScriptService.Services.TradeService)
		if victimPlayer ~= player and TradeService:isInTrade(victimPlayer.UserId) then
			NotificationService.Error(player, "You can't steal from someone who is trading.", 2)
			releaseStealLock(victimPlotUID, podiumIndex)
			return
		end
	end

	if victimPlayer and player ~= victimPlayer then
		local joinTime = playerJoinTimes[victimPlayer.UserId]
		if joinTime then
			local elapsed = os.clock() - joinTime
			local remaining = STEAL_PROTECTION_TIME - elapsed
			if remaining > 0 then
				if not player:GetAttribute("AntiStealSpam") then
					player:SetAttribute("AntiStealSpam", true)
					NotificationService.Notify(
						player,
						string.format("<font color=\"#FF0000\">This player just joined, please wait %d seconds</font>", math.ceil(remaining)),
						3,
						"Sounds.Sfx.Error"
					)
					task.delay(0.8, function()
						if player then
							player:SetAttribute("AntiStealSpam", nil)
						end
					end)
				end
				releaseStealLock(victimPlotUID, podiumIndex)
				return
			end
		end
	end

	if victimPlayer and victimPlayer.Name == "SpyderSammy" and player ~= victimPlayer then

		if player:GetAttribute("AntiStealSpam") then
			releaseStealLock(victimPlotUID, podiumIndex)
			return
		end
		player:SetAttribute("AntiStealSpam", true)
		task.delay(0.2, function()
			player:SetAttribute("AntiStealSpam", nil)
		end)

		NotificationService.Notify(
			player,
			"<font color=\"#FF0000\">You can't steal from this user</font>",
			3,
			"Sounds.Sfx.Error"
		)
		releaseStealLock(victimPlotUID, podiumIndex)
		return
	end

	local victimAnimalList = victimPlotChannel:Get("AnimalList")
	if not victimAnimalList then warn("[STEALDBG2] FAIL AnimalList nil") releaseStealLock(victimPlotUID, podiumIndex) return end


-- [...]

-- [lines 1897-1938]
local function SetupBaseProtection(plot)
	if not plot or not plot:IsA("Model") then return end

	local hitbox = plot:FindFirstChild("StealHitbox")
	if not hitbox or not hitbox:IsA("BasePart") then return end

	local insidePlayers = {}
	table.insert(allInsidePlayersTables, insidePlayers)

	hitbox.Touched:Connect(function(hit)
		local character = hit.Parent
		local player = Players:GetPlayerFromCharacter(character)
		if not player then return end

		insidePlayers[player] = true
	end)

	task.spawn(function()
		while plot.Parent do
			for player in pairs(insidePlayers) do
				local character = player.Character
				if not character then
					insidePlayers[player] = nil
					continue
				end
				local root = character:FindFirstChild("HumanoidRootPart")
				if root then
					local dist = (root.Position - hitbox.Position).Magnitude
					if dist > (hitbox.Size.X + hitbox.Size.Z) / 2 then
						insidePlayers[player] = nil
					end
				end
			end
			task.wait(2)
		end
	end)

	plot:GetAttributeChangedSignal("Locked"):Connect(function()
		if plot:GetAttribute("Locked") == true then
		end
	end)
end
