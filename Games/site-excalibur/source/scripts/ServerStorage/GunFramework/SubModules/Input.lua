local Input = {}

local Event = require(script.Parent.Event)

local UIS = game:GetService("UserInputService")

Input.MouseDelta = Vector3.new()
Input.GamepadDelta = Vector3.new()
Input.TouchDelta = Vector3.new()

Input.InputBegan = {}
local InputBeganEvent = Event.New(Input.InputBegan)
Input.InputEnded = {}
local InputEndedEvent = Event.New(Input.InputEnded)
Input.CurrentKeys = {}
Input.GamepadConnected = UIS:GetGamepadConnected(Enum.UserInputType.Gamepad1)
UIS.InputBegan:Connect(function(io, cancel)
    if cancel then
        return
    end
    Input.CurrentKeys[io.KeyCode] = true
    Input.CurrentKeys[io.UserInputType] = true
    InputBeganEvent(io)
end)
UIS.InputEnded:Connect(function(io, cancel)
    if cancel then
        return
    end
    Input.CurrentKeys[io.KeyCode] = false
    Input.CurrentKeys[io.UserInputType] = false
    InputEndedEvent(io)
end)
local lastgamepadpos = Vector3.new()

local lastmousepos = Vector3.new()

local MouseButton2Holding = false

UIS.InputBegan:Connect(function(io, cancel)
    if io.UserInputType == Enum.UserInputType.MouseButton2 then
        MouseButton2Holding = true
        UIS.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
    end
end)

local lastPos = Vector3.new()

UIS.InputEnded:Connect(function(io, cancel)
    if io.UserInputType == Enum.UserInputType.MouseButton2 then
        MouseButton2Holding = false
        UIS.MouseBehavior = Enum.MouseBehavior.Default
    end

	if io.UserInputType == Enum.UserInputType.Touch then
		Input.TouchDelta = Vector3.new()
		lastPos = Vector3.new()
	end
end)


UIS.InputChanged:Connect(function(io, cancel)
    if io.UserInputType == Enum.UserInputType.MouseMovement then
        Input.MouseDelta = io.Delta
    end
    if io.UserInputType == Enum.UserInputType.Touch then
		if cancel then return end

		Input.MouseDelta = io.Delta * 10
    end
    if io.UserInputType == Enum.UserInputType.Gamepad1 and io.KeyCode == Enum.KeyCode.Thumbstick2 then
        local pos = io.Position
        if io.UserInputState == Enum.UserInputState.Cancel then
            Input.GamepadDelta = Vector3.new()
            return
        end
        local newpos = Vector3.new(pos.x * 10, -pos.y * 10, pos.z * 10)
        if newpos.magnitude - lastgamepadpos.magnitude < 0 then
        else
        end
        if pos.magnitude >= 0.2 then
            local mult = 20 * pos.magnitude
            if pos.magnitude > 0.3 then
            end
            Input.GamepadDelta = Vector3.new(pos.x * mult, -pos.y * mult, pos.z * mult)
        else
            Input.GamepadDelta = Vector3.new()
        end
        lastgamepadpos = Input.GamepadDelta
    end
end)
function Input.IsKeyDown(input)
    if Input.CurrentKeys[input] then
        return true
    end
end
function Input.MatchKey(io, keys)
    keys = keys or {}
    for i, v in pairs(keys) do
        if v and (io.UserInputType == v or io.KeyCode == v) then
            return true
        end
    end
    return false
end
function Input.Step()
    Input.GamepadConnected = UIS:GetGamepadConnected(Enum.UserInputType.Gamepad1)
    Input.MouseDelta = Vector3.new()
end

return Input
