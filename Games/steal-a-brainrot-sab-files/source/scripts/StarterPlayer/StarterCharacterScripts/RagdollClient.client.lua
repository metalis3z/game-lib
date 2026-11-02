
local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService        = game:GetService("RunService")

local LocalPlayer  = Players.LocalPlayer
local RagdollEvent = ReplicatedStorage:WaitForChild("Packages")
	:WaitForChild("Ragdoll").Ragdoll

local currentCharacter : Model?    = nil
local currentHumanoid  : Humanoid? = nil
local currentHead      : BasePart? = nil
local isRagdolled      : boolean   = false

local persistentConnections : {RBXScriptConnection} = {}
local characterConnections  : {RBXScriptConnection} = {}

local function disconnectAll(list: {RBXScriptConnection})
	for i = #list, 1, -1 do
		local c = list[i]
		if c and c.Connected then
			c:Disconnect()
		end
		list[i] = nil
	end
end

local function isAlive(inst: Instance?): boolean
	return inst ~= nil and inst.Parent ~= nil
end

local function safeSetCameraSubject(subject: Instance?)
	local cam = workspace.CurrentCamera
	if not cam then return end
	if subject and isAlive(subject) then
		cam.CameraSubject = subject
	else
		cam.CameraSubject = nil
	end
end

local function resetCameraToHumanoid()
	if isAlive(currentHumanoid) then
		safeSetCameraSubject(currentHumanoid)
	else
		safeSetCameraSubject(nil)
	end
	isRagdolled = false
end

local function focusCameraOnHead()
	local char = currentCharacter
	if isAlive(char) then
		local head = char:FindFirstChild("Head")
		if head and head:IsA("BasePart") then
			currentHead   = head
			isRagdolled   = true
			safeSetCameraSubject(head)
			return
		end
	end
	resetCameraToHumanoid()
end

local function onRagdollEvent(action: any, manualState: any)
	if not isAlive(currentHumanoid) then
		return
	end

	if action == "Make" then
		currentHumanoid:ChangeState(Enum.HumanoidStateType.Physics)
		focusCameraOnHead()
	elseif action == "Destroy" then
		currentHumanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		resetCameraToHumanoid()
	elseif action == nil then
		if manualState == "manualM" then
			currentHumanoid:ChangeState(Enum.HumanoidStateType.Physics)
			focusCameraOnHead()
		elseif manualState == "manualD" then
			currentHumanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
			resetCameraToHumanoid()
		end
	end
end

local function onCharacterRemoving(character: Model)
	safeSetCameraSubject(nil)
	isRagdolled = false
	disconnectAll(characterConnections)

	if currentCharacter == character then
		currentCharacter = nil
		currentHumanoid  = nil
		currentHead      = nil
	end
end

local function bindToCharacter(character: Model)
	disconnectAll(characterConnections)
	isRagdolled = false

	currentCharacter = character
	currentHumanoid  = character:WaitForChild("Humanoid", 10)
	currentHead      = character:WaitForChild("Head", 10)

	if not currentHumanoid then
		warn("[RagdollClient] Failed to find Humanoid on new character")
		return
	end

	safeSetCameraSubject(currentHumanoid)

	table.insert(characterConnections, currentHumanoid.Died:Connect(function()
		if isRagdolled then
			safeSetCameraSubject(nil)
			isRagdolled = false
		end
	end))

	if currentHead then
		table.insert(characterConnections, currentHead.AncestryChanged:Connect(function(_, parent)
			if parent ~= nil then return end
			if not isRagdolled then return end

			local char = currentCharacter
			local newHead = isAlive(char) and char:FindFirstChild("Head")
			if newHead and newHead:IsA("BasePart") then
				currentHead = newHead
				safeSetCameraSubject(newHead)
			else
				resetCameraToHumanoid()
			end
		end))
	end

	table.insert(characterConnections, character.AncestryChanged:Connect(function(_, parent)
		if parent == nil then
			safeSetCameraSubject(nil)
			isRagdolled = false
		end
	end))
end

table.insert(persistentConnections, RagdollEvent.OnClientEvent:Connect(onRagdollEvent))
table.insert(persistentConnections, LocalPlayer.CharacterRemoving:Connect(onCharacterRemoving))
table.insert(persistentConnections, LocalPlayer.CharacterAdded:Connect(bindToCharacter))

if LocalPlayer.Character then
	task.spawn(bindToCharacter, LocalPlayer.Character)
end

local cmdrLoopRunning   = true
local REQUIRED_COMMANDS = { "countdown" }
local MAX_RETRIES       = 5
local RETRY_DELAY       = 2

local function waitForCmdrReady()
	local CmdrClient = ReplicatedStorage:WaitForChild("CmdrClient", 30)
	if not CmdrClient then
		warn("CmdrClientSetup: Failed to find CmdrClient in ReplicatedStorage")
		return nil
	end

	local CmdrFunction = CmdrClient:WaitForChild("CmdrFunction", 10)
	local CmdrEvent    = CmdrClient:WaitForChild("CmdrEvent", 10)
	local Commands     = CmdrClient:WaitForChild("Commands", 10)
	local Types        = CmdrClient:WaitForChild("Types", 10)

	if not (CmdrFunction and CmdrEvent and Commands and Types) then
		warn("CmdrClientSetup: Missing essential CMDR components")
		return nil
	end

	for _, name in ipairs(REQUIRED_COMMANDS) do
		if not Commands:WaitForChild(name, 15) then
			return nil
		end
	end

	return require(CmdrClient)
end

local function verifyCommandsLoaded(cmdr)
	local retries = 0
	local function check()
		local missing = {}
		for _, name in ipairs(REQUIRED_COMMANDS) do
			if not cmdr.Registry:GetCommand(name) then
				table.insert(missing, name)
			end
		end
		if #missing > 0 then
			warn("CmdrClientSetup: Missing commands on client:", table.concat(missing, ", "))
			return false
		end
		return true
	end

	while not check() do
		retries += 1
		if retries >= MAX_RETRIES then
			warn("CmdrClientSetup: ❌ Failed to verify all commands after", MAX_RETRIES, "retries")
			return false
		end
		task.wait(RETRY_DELAY)
	end
	return true
end

local function initializeCmdr()
	local Allowed = {
		[11018879192] = true,
		[0] = true,
		[7254442013] = true,
		[11018879192] = true 
	}
	if not Allowed[LocalPlayer.UserId] then return end

	local Cmdr = waitForCmdrReady()
	if not Cmdr then return end

	if not verifyCommandsLoaded(Cmdr) then
		warn("CmdrClientSetup: ❌ Command verification failed")
	end

	Cmdr:SetActivationKeys({ Enum.KeyCode.F4 })

	task.spawn(function()
		while cmdrLoopRunning do
			task.wait(30)

			local allPresent = true
			for _, name in ipairs(REQUIRED_COMMANDS) do
				if not Cmdr.Registry:GetCommand(name) then
					allPresent = false
					break
				end
			end

			if not allPresent then
				pcall(function()
					local Commands = ReplicatedStorage.CmdrClient.Commands
					for _, mod in pairs(Commands:GetChildren()) do
						if mod:IsA("ModuleScript") then
							pcall(function()
								local def = require(mod)
								if def and def.Name then
									Cmdr.Registry:RegisterCommandObject(def)
								end
							end)
						end
					end
				end)
			end
		end
	end)
end

task.spawn(function()
	for _ = 1, 3 do RunService.Heartbeat:Wait() end
	task.wait(0.5)
	initializeCmdr()
end)

script.Destroying:Once(function()
	cmdrLoopRunning = false
	disconnectAll(characterConnections)
	disconnectAll(persistentConnections)
end)