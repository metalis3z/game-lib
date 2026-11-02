local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Save = require(ReplicatedStorage.Library.Client.Save)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Tween = require(ReplicatedStorage.Library.Functions.Tween)

local TOGGLE_ON_COLOR = Color3.fromRGB(0, 255, 0)
local LocalPlayer = Players.LocalPlayer

local SlowToggle = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Elements"):WaitForChild("Left"):WaitForChild("Tools"):WaitForChild("SlowToggle")
local ImageButton = SlowToggle:WaitForChild("ImageButton")
local Circle = SlowToggle:WaitForChild("Circle")

local DEFAULT_TOGGLE_COLOR = SlowToggle.BackgroundColor3
local CIRCLE_OFF_POSITION = Circle.Position

local toggleEnabled = false
local BASE_WALK_SPEED = Constants.BASE_WALK_SPEED
local activeTreadmill = nil
local currentHumanoid = nil
local walkSpeedConn = nil

local function setToggleVisuals(enabled)
	if enabled then
		SlowToggle.BackgroundColor3 = TOGGLE_ON_COLOR
		Tween(Circle, {
			Position = UDim2.new(0.73, CIRCLE_OFF_POSITION.X.Offset, CIRCLE_OFF_POSITION.Y.Scale, CIRCLE_OFF_POSITION.Y.Offset)
		}, { 0.15 })
	else
		SlowToggle.BackgroundColor3 = DEFAULT_TOGGLE_COLOR
		Tween(Circle, {
			Position = CIRCLE_OFF_POSITION
		}, { 0.15 })
	end
end

local function getEffectiveWalkSpeed()
	if currentHumanoid == nil or currentHumanoid.Parent == nil or currentHumanoid.Health <= 0 then
		return BASE_WALK_SPEED
	end
	return currentHumanoid.WalkSpeed
end

local function refreshVisibility()
	if activeTreadmill ~= nil then
		SlowToggle.Visible = false
		return
	end
	SlowToggle.Visible = toggleEnabled or getEffectiveWalkSpeed() > 50
end

local function applyToggleState(enabled, restoredWalkSpeed)
	BASE_WALK_SPEED = restoredWalkSpeed
	if toggleEnabled ~= enabled then
		toggleEnabled = enabled
		setToggleVisuals(enabled)
	end
	refreshVisibility()
end

local function requestToggleState()
	local enabled, restoredWalkSpeed = Network.Invoke(Constants.NETWORK_MAP.Treadmills.REQUEST_GET_SLOW_TOGGLE_STATE)
	assert(typeof(enabled) == "boolean", "Expected slow-toggle enabled state from server")
	assert(typeof(restoredWalkSpeed) == "number", "Expected slow-toggle restored walk speed from server")
	applyToggleState(enabled, restoredWalkSpeed)
end

local function requestSetToggleEnabled(enabled)
	local newEnabled, restoredWalkSpeed = Network.Invoke(Constants.NETWORK_MAP.Treadmills.REQUEST_SET_SLOW_TOGGLE_ENABLED, enabled)
	assert(typeof(newEnabled) == "boolean", "Expected slow-toggle enabled state from server")
	assert(typeof(restoredWalkSpeed) == "number", "Expected slow-toggle restored walk speed from server")
	applyToggleState(newEnabled, restoredWalkSpeed)
end

local function bindHumanoid(humanoid)
	if walkSpeedConn ~= nil then
		walkSpeedConn:Disconnect()
		walkSpeedConn = nil
	end

	currentHumanoid = humanoid
	walkSpeedConn = humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(refreshVisibility)

	refreshVisibility()
end

local function connectCharacter(character)
	bindHumanoid(character:WaitForChild("Humanoid"))
	requestToggleState()
end

ImageButton.Activated:Connect(function()
	requestSetToggleEnabled(not toggleEnabled)
end)

if Save.IsLocalDataLoaded() then
	requestToggleState()
else
	Save.LoadedStats:Connect(requestToggleState)
end

Network.Fired(Constants.NETWORK_MAP.Treadmills.ACTIVE_TREADMILL_EVENT):Connect(function(treadmill)
	activeTreadmill = treadmill
	refreshVisibility()
end)

if LocalPlayer.Character ~= nil then
	bindHumanoid(LocalPlayer.Character:WaitForChild("Humanoid"))
	requestToggleState()
end

LocalPlayer.CharacterAdded:Connect(connectCharacter)