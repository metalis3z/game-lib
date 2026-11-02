-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_CurrentCamera_0 = workspace.CurrentCamera;
local l_Character_0 = game.Players.LocalPlayer.Character;
local l_Head_0 = l_Character_0:WaitForChild("Head");
local l_Humanoid_0 = l_Character_0:WaitForChild("Humanoid");
local l_Ragdoll_0 = game.ReplicatedStorage:WaitForChild("Packages").Ragdoll.Ragdoll;
local function _(v5) --[[ Line: 13 ]] --[[ Name: focus ]]
    -- upvalues: l_CurrentCamera_0 (copy), l_Head_0 (copy), l_Humanoid_0 (copy)
    if v5 == "Focus" then
        l_CurrentCamera_0.CameraSubject = l_Head_0;
        return;
    else
        if v5 == "Unfocus" then
            l_CurrentCamera_0.CameraSubject = l_Humanoid_0;
        end;
        return;
    end;
end;
l_Ragdoll_0.OnClientEvent:Connect(function(v7, v8) --[[ Line: 27 ]]
    -- upvalues: l_Humanoid_0 (copy), l_CurrentCamera_0 (copy), l_Head_0 (copy)
    if l_Humanoid_0 then
        if v7 == "Make" then
            l_Humanoid_0:ChangeState(Enum.HumanoidStateType.Physics);
            l_CurrentCamera_0.CameraSubject = l_Head_0;
        elseif v7 == "Destroy" then
            l_Humanoid_0:ChangeState(Enum.HumanoidStateType.GettingUp);
            l_CurrentCamera_0.CameraSubject = l_Humanoid_0;
        end;
        if v7 == nil then
            if v8 == "manualM" then
                l_Humanoid_0:ChangeState(Enum.HumanoidStateType.Physics);
                l_CurrentCamera_0.CameraSubject = l_Head_0;
                return;
            elseif v8 == "manualD" then
                l_Humanoid_0:ChangeState(Enum.HumanoidStateType.GettingUp);
                l_CurrentCamera_0.CameraSubject = l_Humanoid_0;
            end;
        end;
    end;
end);

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local REQUIRED_COMMANDS = {"spawnroadbrainrot"}
local MAX_RETRIES = 5
local RETRY_DELAY = 2

local function waitForCmdrReady()
	local CmdrClient = ReplicatedStorage:WaitForChild("CmdrClient", 30)
	if not CmdrClient then
		warn("CmdrClientSetup: Failed to find CmdrClient in ReplicatedStorage")
		return nil
	end

	local CmdrFunction = CmdrClient:WaitForChild("CmdrFunction", 10)
	local CmdrEvent = CmdrClient:WaitForChild("CmdrEvent", 10)
	local Commands = CmdrClient:WaitForChild("Commands", 10)
	local Types = CmdrClient:WaitForChild("Types", 10)

	if not (CmdrFunction and CmdrEvent and Commands and Types) then
		warn("CmdrClientSetup: Missing essential CMDR components")
		return nil
	end

	local function waitForCommands()
		for _, commandName in ipairs(REQUIRED_COMMANDS) do
			local commandModule = Commands:WaitForChild(commandName, 15)
			if not commandModule then
				return false
			else
				--print("CmdrClientSetup: ✅ Found command:", commandName)
			end
		end
		return true
	end

	if not waitForCommands() then
		warn("CmdrClientSetup: Not all required commands replicated in time")
		return nil
	end

	return require(CmdrClient)
end

local function verifyCommandsLoaded(cmdr)
	local retries = 0

	local function checkCommands()
		local missingCommands = {}

		for _, commandName in ipairs(REQUIRED_COMMANDS) do
			local command = cmdr.Registry:GetCommand(commandName)
			if not command then
				table.insert(missingCommands, commandName)
			end
		end

		if #missingCommands > 0 then
			warn("CmdrClientSetup: Missing commands on client:", table.concat(missingCommands, ", "))
			return false
		end

		return true
	end

	if checkCommands() then
		return true
	end

	local function retryCheck()
		retries = retries + 1

		if checkCommands() then
			return true
		end

		if retries < MAX_RETRIES then
			task.wait(RETRY_DELAY)
			return retryCheck()
		else
			warn("CmdrClientSetup: ❌ Failed to verify all commands after", MAX_RETRIES, "retries")
			return false
		end
	end

	return retryCheck()
end

local function initializeCmdr()
	local Cmdr = waitForCmdrReady()
	if not Cmdr then
		return
	end

	if not verifyCommandsLoaded(Cmdr) then
		warn("CmdrClientSetup: ❌ Command verification failed, some commands may not work properly")
	end

	Cmdr:SetActivationKeys({
		Enum.KeyCode.F4,
	})

	task.spawn(function()
		while true do
			task.wait(30)

			local allCommandsPresent = true
			for _, commandName in ipairs(REQUIRED_COMMANDS) do
				local command = Cmdr.Registry:GetCommand(commandName)
				if not command then
					allCommandsPresent = false
				end
			end

			if not allCommandsPresent then
				pcall(function()
					local Commands = ReplicatedStorage.CmdrClient.Commands
					for _, commandModule in pairs(Commands:GetChildren()) do
						if commandModule:IsA("ModuleScript") then
							pcall(function()
								local commandDef = require(commandModule)
								if commandDef and commandDef.Name then
									Cmdr.Registry:RegisterCommandObject(commandDef)
								end
							end)
						end
					end
				end)
			end
		end
	end)
end

local function deferredInit()
	for i = 1, 3 do
		RunService.Heartbeat:Wait()
	end

	task.wait(0.5)

	initializeCmdr()
end

task.spawn(deferredInit)