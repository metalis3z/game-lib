local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

-- Require for types/side-effects
require(ReplicatedStorage.Library.Types.AreaEggs)

local Audio = require(ReplicatedStorage.Library.Audio)
local EggCmds = require(ReplicatedStorage.Library.Client.EggCmds)
local ScreenEffects = require(script.ScreenEffects)
local HideImportantUI = require(ReplicatedStorage.Library.Client.HideImportantUI)
local Player = require(ReplicatedStorage.Library.Player)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local Variables = require(ReplicatedStorage.Library.Variables)

local LocalPlayer = Players.LocalPlayer

local OBJECTS = Workspace:WaitForChild("__OBJECTS")
assert(OBJECTS:IsA("Folder"), "Workspace.__OBJECTS must be a Folder")

local Areas = OBJECTS:WaitForChild("Areas")
assert(Areas:IsA("Folder"), "Workspace.__OBJECTS.Areas must be a Folder")

local GuardAreas = Areas:WaitForChild("GuardAreas")
assert(GuardAreas:IsA("Folder"), "Workspace.__OBJECTS.Areas.GuardAreas must be a Folder")

local runtimeState = nil
local AreaEggCarryController = {}

--==============================--
-- Helper Functions
--==============================--

-- Executes and clears a given lock function from the state
local function releaseLock(state, lockName)
	if state[lockName] then
		state[lockName]()
		state[lockName] = nil
	end
end

-- Returns a function that un-hides the UI safely
local function obtainUiHideLock()
	local isReleased = false
	HideImportantUI:Hide()

	return function()
		if not isReleased then
			isReleased = true
			HideImportantUI:UnHide()
		end
	end
end

-- Completely resets the carrying and run-back state
local function resetCarryState(state)
	state.CarryGeneration += 1

	if state.GuardStateConnection then
		state.GuardStateConnection:Disconnect()
		state.GuardStateConnection = nil
	end

	if state.Active then
		state.Active = false
		state.Effects:Stop()

		releaseLock(state, "ReleaseMusicLock")
		releaseLock(state, "ReleaseRunBackActiveLock")
	end

	releaseLock(state, "ReleaseUiHideLock")
end

-- Initiates the "Run Back" phase effects and locks
local function startRunBackState(state)
	if state.GuardStateConnection then
		state.GuardStateConnection:Disconnect()
		state.GuardStateConnection = nil
	end

	if state.Active then return end

	state.Active = true
	state.MusicLockGeneration += 1
	local currentMusicGen = state.MusicLockGeneration

	state.ReleaseRunBackActiveLock = Variables.Locks.AreaEggRunBack:ObtainLock()
	state.ReleaseMusicLock = Variables.Locks.GuardedGameplayMusic:ObtainLock()
	state.Effects:Start()

	local sound = Audio.Play("rbxassetid://113113198465358", script, 1.07, 2)

	local function onSoundEnded()
		if state.MusicLockGeneration == currentMusicGen then
			releaseLock(state, "ReleaseMusicLock")
		end
	end

	if sound and sound.SoundId ~= "" then
		state.Trove:Add(sound.Ended:Once(onSoundEnded))
		state.Trove:Add(sound.Stopped:Once(onSoundEnded))
	else
		onSoundEnded()
	end
end

-- Waits for the area guard to wake up before triggering the run-back state
local function startWhenGuardWakeFinishes(state, carryParams)
	state.CarryGeneration += 1
	local currentCarryGen = state.CarryGeneration

	if state.GuardStateConnection then
		state.GuardStateConnection:Disconnect()
		state.GuardStateConnection = nil
	end

	if state.Active then return end

	if carryParams.RunBackWakeDelayRequired ~= true then
		startRunBackState(state)
		return
	end

	local areaId = carryParams.AreaId
	assert(areaId ~= nil, "Carried area egg state must include AreaId")

	local guardArea = GuardAreas:FindFirstChild(areaId)
	assert(guardArea, string.format("Workspace.__OBJECTS.Areas.GuardAreas.%s is required", tostring(areaId)))
	assert(guardArea:IsA("Model"), string.format("Workspace.__OBJECTS.Areas.GuardAreas.%s must be a Model", tostring(areaId)))

	local guard = guardArea:FindFirstChild("Guard")
	assert(guard, string.format("%s.Guard is required", guardArea:GetFullName()))
	assert(guard:IsA("Model"), string.format("%s.Guard must be a Model", guardArea:GetFullName()))

	if guard:GetAttribute("GuardState") == "Chasing" then
		startRunBackState(state)
	else
		state.GuardStateConnection = guard:GetAttributeChangedSignal("GuardState"):Connect(function()
			if state.CarryGeneration ~= currentCarryGen then return end

			if guard:GetAttribute("GuardState") == "Chasing" then
				startRunBackState(state)
			end
		end)
	end
end

-- Evaluates the incoming carry state and decides whether to apply or reset
local function applyCarryState(state, carryParams)
	if carryParams.IsCarrying then
		if not state.ReleaseUiHideLock then
			local humanoid = Player.Optional.Humanoid(LocalPlayer)
			if humanoid then
				humanoid:UnequipTools()
			end

			state.ReleaseUiHideLock = obtainUiHideLock()
		end

		startWhenGuardWakeFinishes(state, carryParams)
	else
		resetCarryState(state)
	end
end

-- Initializes or retrieves the existing runtime state
local function resolveRuntime()
	if not runtimeState then
		runtimeState = {
			Active = false,
			CarryGeneration = 0,
			GuardStateConnection = nil,
			MusicLockGeneration = 0,
			ReleaseMusicLock = nil,
			ReleaseRunBackActiveLock = nil,
			ReleaseUiHideLock = nil,
			Started = false,
			Effects = ScreenEffects.new(),
			Trove = Trove.new()
		}
	end

	return runtimeState
end

--==============================--
-- Module Methods
--==============================--

function AreaEggCarryController.Start()
	local state = resolveRuntime()

	if state.Started then return end
	state.Started = true

	state.Trove:Add(EggCmds.AreaEggCarryStateChanged:Connect(function(carryParams)
		applyCarryState(state, carryParams)
	end))

	state.Trove:Connect(LocalPlayer.CharacterRemoving, function()
		resetCarryState(state)
	end)

	state.Trove:Add(function()
		resetCarryState(state)
	end)
end

return AreaEggCarryController