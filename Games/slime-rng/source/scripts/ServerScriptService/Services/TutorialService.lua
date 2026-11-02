local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local DataService = require(ReplicatedStorage.Packages.DataService).server

local STEPS = {
	"init", "firstRoll", "rollCompleted", "enemySpawned", "enemyKilled",
	"secondRoll", "secondRollCompleted", "thirdRoll", "thirdRollCompleted",
	"openUpgrades", "buyBackpackUpgrade", "closeUpgrades", "openBackpack",
	"equipBetterSlime", "closeBackpack", "earnCoins200", "openUpgradeForAuto",
	"buyAutoUpgrade", "closeUpgradeForAuto", "earnCoins400", "unlockZone2",
}

local StepData = {}
for i, id in ipairs(STEPS) do
	StepData[id] = {
		num      = i,
		nextStep = STEPS[i + 1] or "complete"
	}
end

local AUTO_ADVANCE_STEPS = {
	rollCompleted       = true,
	enemySpawned        = true,
	enemyKilled         = true,
	secondRollCompleted = true,
	thirdRollCompleted  = true,
}

local tutorialRemoteEvent = nil

local function getCurrentStep(tutorialData)
	if tutorialData and tutorialData.completed == true then
		return "complete"
	end
	if tutorialData == nil then return "init" end
	local step = tutorialData.step
	if type(step) ~= "string" or not StepData[step] then
		return "init"
	end
	return step
end

local function getEquippedCount(equipped)
	if type(equipped) ~= "table" then return 0 end
	local count = 0
	for k, v in pairs(equipped) do
		if type(k) == "number" and type(v) == "string" then
			count += 1 -- array style
		elseif type(k) == "string" and v == true then
			count += 1 -- dict style
		end
	end
	return count
end

local function hasAnySlimeEquipped(data)
	local equipped = data:get("equipped") or {}
	return getEquippedCount(equipped) > 0
end

local function doAdvance(player, data, fromStep)
	local stepInfo = StepData[fromStep]
	if not stepInfo then return nil end

	local nextStep = stepInfo.nextStep
	if nextStep == "complete" then
		DataService:set(player, {"tutorial", "step"},      "complete")
		DataService:set(player, {"tutorial", "completed"}, true)
	else
		DataService:set(player, {"tutorial", "step"}, nextStep)
	end

	print("[TutorialService] Advanced:", fromStep, "->", nextStep, "for", player.Name)

	if tutorialRemoteEvent then
		tutorialRemoteEvent:FireClient(player, "syncStep", nextStep)
	end

	return nextStep
end

local function chainAutoAdvance(player, fromStep)
	if not AUTO_ADVANCE_STEPS[fromStep] then return end

	task.delay(0.8, function()
		local data = DataService:waitForData(player)
		if not data then return end

		local tutorialData = data:get("tutorial")
		if not tutorialData or tutorialData.completed then return end

		local current = getCurrentStep(tutorialData)
		if current ~= fromStep then
			print("[TutorialService] Step already moved past", fromStep, "-> now at", current)
			return
		end

		local nextStep = doAdvance(player, data, fromStep)
		if nextStep and AUTO_ADVANCE_STEPS[nextStep] then
			chainAutoAdvance(player, nextStep)
		end
	end)
end

local function checkEquipStepOnJoin(player)
	task.wait(4)

	local data = DataService:waitForData(player)
	if not data then return end

	local tutorialData = data:get("tutorial")
	if not tutorialData or tutorialData.completed then return end

	local currentStep = getCurrentStep(tutorialData)

	print("[TutorialService] Join check - step:", currentStep, "for", player.Name)

	if currentStep ~= "equipBetterSlime" then return end

	if hasAnySlimeEquipped(data) then
		print("[TutorialService] Has slimes equipped on join - skipping equipBetterSlime for", player.Name)
		doAdvance(player, data, "equipBetterSlime")
		task.wait(0.5)
		local data2 = DataService:waitForData(player)
		if not data2 then return end
		local tutorialData2 = data2:get("tutorial")
		if tutorialData2 and not tutorialData2.completed then
			local step2 = getCurrentStep(tutorialData2)
			if step2 == "closeBackpack" then
				print("[TutorialService] Also skipping closeBackpack for", player.Name)
				doAdvance(player, data2, "closeBackpack")
			end
		end
	else
		print("[TutorialService] No slimes equipped on join for", player.Name)
	end
end

local TutorialService = {}

function TutorialService:init()
	local networker031 = ReplicatedStorage.Packages._Index["leifstout_networker@0.3.1"].networker
	local remotes = networker031:WaitForChild("_remotes", 10)
	if not remotes then
		warn("[TutorialService] Could not find _remotes in networker@0.3.1")
		return
	end

	local tutorialRemotes = remotes:WaitForChild("TutorialService", 10)
	if not tutorialRemotes then
		warn("[TutorialService] Could not find TutorialService in _remotes")
		return
	end

	tutorialRemoteEvent = tutorialRemotes:FindFirstChild("RemoteEvent")

	local remoteFunction = tutorialRemotes:FindFirstChild("RemoteFunction")
	if remoteFunction then
		remoteFunction.OnServerInvoke = function(player: Player, method: string, ...)
			print("[TutorialService] Invoked - method:", method, "player:", player.Name)
			if method == "requestAdvanceStep" then
				return self:requestAdvanceStep(player, ...)
			end
			warn("[TutorialService] Unknown method:", method)
			return false, nil
		end
		print("[TutorialService] OnServerInvoke set successfully")
	else
		warn("[TutorialService] RemoteFunction not found")
	end

	if tutorialRemoteEvent then
		tutorialRemoteEvent.OnServerEvent:Connect(function(player: Player, method: string, ...)
			if method == "requestAdvanceStep" then
				self:requestAdvanceStep(player, ...)
			end
		end)
	end

	Players.PlayerAdded:Connect(function(player)
		task.spawn(checkEquipStepOnJoin, player)
	end)

	print("[TutorialService] Initialized")
end

function TutorialService:requestAdvanceStep(player: Player, clientStep: string)
	if type(clientStep) ~= "string" then
		return false, nil
	end

	local data = DataService:waitForData(player)
	if not data then return false, nil end

	local tutorialData = data:get("tutorial")
	if tutorialData and tutorialData.completed == true then
		return false, nil
	end

	local serverStep = getCurrentStep(tutorialData)

	if serverStep == "equipBetterSlime" and hasAnySlimeEquipped(data) then
		print("[TutorialService] equipBetterSlime satisfied, auto-advancing for", player.Name)
		local nextStep = doAdvance(player, data, "equipBetterSlime")
		-- Also skip closeBackpack if needed
		if nextStep == "closeBackpack" then
			task.wait(0.3)
			local data2 = DataService:waitForData(player)
			if data2 then
				local td2 = data2:get("tutorial")
				if td2 and not td2.completed and getCurrentStep(td2) == "closeBackpack" then
					nextStep = doAdvance(player, data2, "closeBackpack")
				end
			end
		end
		return true, nextStep
	end

	if clientStep ~= serverStep then
		local clientNum = StepData[clientStep] and StepData[clientStep].num or 0
		local serverNum = StepData[serverStep] and StepData[serverStep].num or 0

		if clientNum < serverNum then
			warn("[TutorialService] Client behind server. Client:", clientStep,
				"Server:", serverStep, "- sending resync to", player.Name)
			return false, serverStep
		end

		warn("[TutorialService] Step mismatch - client:", clientStep, "server:", serverStep)
		return false, nil
	end

	local nextStep = doAdvance(player, data, serverStep)
	if not nextStep then return false, nil end

	if AUTO_ADVANCE_STEPS[nextStep] then
		chainAutoAdvance(player, nextStep)
	end

	return true, nextStep
end

return TutorialService