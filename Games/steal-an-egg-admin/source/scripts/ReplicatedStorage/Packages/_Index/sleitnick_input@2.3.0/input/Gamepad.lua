-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Trove = require(script.Parent.Parent.Trove)
local Signal = require(script.Parent.Parent.Signal)
local UserInputService = game:GetService("UserInputService")
local HapticService = game:GetService("HapticService")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

local function ApplyDeadzone(v1, v2) -- line 12
    if math.abs(v1) < v2 then
        return 0
    end
    return (math.abs(v1) - v2) / (1 - v2) * math.sign(v1)
end

local function GetActiveGamepad() -- line 19 | captures: UserInputService
    local v3 = UserInputService:GetNavigationGamepads()
    local v4
    if #v3 <= 1 then
        local v5 = UserInputService:GetConnectedGamepads()
        local v6
        for v7, v8 in ipairs(v5) do
            if v6 == nil then
                v6 = v8
            else
                local Value = v8.Value
                if v6.Value <= Value then
                end
            end
            v4 = v6
        end
    else
        local v9
        for v10, v11 in ipairs(v3) do
            if v9 == nil then
                v9 = v11
            else
                local Value = v11.Value
                if v9.Value <= Value then
                end
            end
            v4 = v9
        end
    end
    if v4 and not UserInputService:GetGamepadConnected(v4) then
        v4 = nil
    end
    return v4
end

local function HeartbeatDelay(v12, v13) -- line 43 | captures: RunService
    local v14 = time()
    local v15
    v15 = RunService.Heartbeat:Connect(function() -- line 46 | captures: v15, v12, v13, v14
        local v16 = time() - v14
        if v12 <= v16 then
            v15:Disconnect()
            v13()
        end
    end)
    return v15
end

local v17 = {}

v17.__index = v17

function v17.new(v18) -- line 57 | captures: Trove, Signal, v17
    local v19 = {}
    local v20 = setmetatable(v19, v17)
    v20._trove = Trove.new()
    v20._gamepadTrove = v20._trove:Construct(Trove)
    v20.ButtonDown = v20._trove:Construct(Signal)
    v20.ButtonUp = v20._trove:Construct(Signal)
    v20.Connected = v20._trove:Construct(Signal)
    v20.Disconnected = v20._trove:Construct(Signal)
    v20.GamepadChanged = v20._trove:Construct(Signal)
    v20.DefaultDeadzone = 0.05
    v20.SupportsVibration = false
    v20.State = {}
    v20:_setupGamepad(v18)
    v20:_setupMotors()
    return v20
end

function v17._setupActiveGamepad(v21, v22) -- line 73 | captures: UserInputService, HapticService
    local _gamepad = v21._gamepad
    if v22 == _gamepad then
        return
    end
    v21._gamepadTrove:Clean()
    table.clear(v21.State)
    local v23
    if v22 then
        v23 = HapticService:IsVibrationSupported(v22)
    else
        v23 = false
    end
    v21.SupportsVibration = v23
    v21._gamepad = v22
    if v22 then
        for v24, v25 in ipairs(UserInputService:GetGamepadState(v22)) do
            v21.State[v25.KeyCode] = v25
        end
        v21._gamepadTrove:Add(v21, "StopMotors")
        v21._gamepadTrove:Connect(UserInputService.InputBegan, function(v26, v27) -- line 97 | captures: v21, v22
            if v26.UserInputType == v22 then
                v21.ButtonDown:Fire(v26.KeyCode, v27)
            end
        end)
        v21._gamepadTrove:Connect(UserInputService.InputEnded, function(v28, v29) -- line 102 | captures: v21, v22
            if v28.UserInputType == v22 then
                v21.ButtonUp:Fire(v28.KeyCode, v29)
            end
        end)
        if _gamepad == nil then
            v21.Connected:Fire()
        end
        v21.GamepadChanged:Fire(v22)
    else
        v21.Disconnected:Fire()
        v21.GamepadChanged:Fire(nil)
    end
end

function v17._setupGamepad(v30, v31) -- line 112 | captures: UserInputService, GetActiveGamepad
    if v31 then
        v30._trove:Connect(UserInputService.GamepadConnected, function(v32) -- line 125 | captures: v30, v31
            if v32 == v31 then
                v30:_setupActiveGamepad(v31)
            end
        end)
        v30._trove:Connect(UserInputService.GamepadDisconnected, function(v33) -- line 130 | captures: v30, v31
            if v33 == v31 then
                v30:_setupActiveGamepad(nil)
            end
        end)
        if UserInputService:GetGamepadConnected(v31) then
            v30:_setupActiveGamepad(v31)
        end
    else
        local function CheckToSetupActive() -- line 114 | captures: v30, GetActiveGamepad
            local v34 = GetActiveGamepad()
            if v34 ~= v30._gamepad then
                v30:_setupActiveGamepad(v34)
            end
        end

        v30._trove:Connect(UserInputService.GamepadConnected, CheckToSetupActive)
        v30._trove:Connect(UserInputService.GamepadDisconnected, CheckToSetupActive)
        v30:_setupActiveGamepad((GetActiveGamepad()))
    end
end

local function _setupMotors(v35) -- line 140
    v35._setMotorIds = {}
    for v36, v37 in ipairs(Enum.VibrationMotor:GetEnumItems()) do
        v35._setMotorIds[v37] = 0
    end
end

v17._setupMotors = _setupMotors

local function GetThumbstick(v38, v39, v40) -- line 146
    local Position = v38.State[v39].Position
    local v41 = v40 or v38.DefaultDeadzone
    local X = Position.X
    local v42 = if v41 <= math.abs(X) then (math.abs(X) - v41) / (1 - v41) * math.sign(X) else 0
    local Y = Position.Y
    local v43 = if v41 <= math.abs(Y) then (math.abs(Y) - v41) / (1 - v41) * math.sign(Y) else 0
    return Vector2.new(v42, v43)
end

v17.GetThumbstick = GetThumbstick

local function GetTrigger(v44, v45, v46) -- line 169
    local Z = v44.State[v45].Position.Z
    local v47 = v46 or v44.DefaultDeadzone
    if math.abs(Z) < v47 then
        return 0
    end
    return (math.abs(Z) - v47) / (1 - v47) * math.sign(Z)
end

v17.GetTrigger = GetTrigger

function v17.IsButtonDown(v48, v49) -- line 181 | captures: UserInputService
    return UserInputService:IsGamepadButtonDown(v48._gamepad, v49)
end

function v17.IsMotorSupported(v50, v51) -- line 184 | captures: HapticService
    return HapticService:IsMotorSupported(v50._gamepad, v51)
end

function v17.SetMotor(v52, v53, v54) -- line 187 | captures: HapticService
    local _setMotorIds = v52._setMotorIds
    _setMotorIds[v53] += 1
    local v55 = v52._setMotorIds[v53]
    HapticService:SetMotor(v52._gamepad, v53, v54)
    return v55
end

function v17.PulseMotor(v56, v57, v58, v59) -- line 194 | captures: RunService
    local v60 = v56:SetMotor(v57, v58)

    local function u9() -- line 196 | captures: v56, v57, v60
        if v56._setMotorIds[v57] == v60 then
            v56:StopMotor(v57)
        end
    end

    local v61 = time()
    local v62
    v62 = RunService.Heartbeat:Connect(function() -- line 205 | captures: v62, v56, v57, v59, v60, v61
        local v63 = time() - v61
        if not (v59 <= v63) then
            return
        end
        v62:Disconnect()
        if v56._setMotorIds[v57] ~= v60 then
            return
        end
        v56:StopMotor(v57)
    end)
    v56._gamepadTrove:Add(v62)
end

local function StopMotor(v64, v65) -- line 215
    v64:SetMotor(v65, 0)
end

v17.StopMotor = StopMotor

local function StopMotors(v66) -- line 218
    for v67, v68 in ipairs(Enum.VibrationMotor:GetEnumItems()) do
        if v66:IsMotorSupported(v68) then
            v66:StopMotor(v68)
        end
    end
end

v17.StopMotors = StopMotors

function v17.IsConnected(v69) -- line 225 | captures: UserInputService
    if v69._gamepad then
        return (UserInputService:GetGamepadConnected(v69._gamepad))
    end
    return false
end

local function GetUserInputType(v70) -- line 231
    return v70._gamepad
end

v17.GetUserInputType = GetUserInputType

function v17.SetAutoSelectGui(v71, v72) -- line 234 | captures: GuiService
    GuiService.AutoSelectGuiEnabled = v72
end

function v17.IsAutoSelectGuiEnabled(v73) -- line 237 | captures: GuiService
    return GuiService.AutoSelectGuiEnabled
end

local function Destroy(v74) -- line 240
    v74._trove:Destroy()
end

v17.Destroy = Destroy
return v17
