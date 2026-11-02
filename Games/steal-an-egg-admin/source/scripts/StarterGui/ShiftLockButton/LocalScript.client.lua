-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local GameSettings = UserSettings().GameSettings
local v2 = {}
while not Players.LocalPlayer do
    wait()
end
local LocalPlayer = Players.LocalPlayer
local v3 = LocalPlayer:GetMouse()
LocalPlayer:WaitForChild("PlayerGui")
local v4
local v5 = true
local v6 = true
local v7 = false
local v8 = false

v2.OnShiftLockToggled = Instance.new("BindableEvent")

local function isShiftLockMode() -- line 23 | captures: GameSettings, LocalPlayer
    local DevEnableMouseLock = LocalPlayer.DevEnableMouseLock
    if DevEnableMouseLock then
        if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch then
            if LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.ClickToMove then
                return false
            end
            if GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove then
                return false
            end
            return LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable
        end
        DevEnableMouseLock = false
    end
    return DevEnableMouseLock
end

if not UserInputService.TouchEnabled then
    local DevEnableMouseLock = LocalPlayer.DevEnableMouseLock
    v5 = DevEnableMouseLock
    if DevEnableMouseLock then
        if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch then
            v5 = not (LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.ClickToMove or GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove or LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable)
        else
            v5 = false
        end
    end
end

local function onShiftLockToggled() -- line 36 | captures: v6, v2
    v6 = not v6
    v2.OnShiftLockToggled:Fire()
end

local function v1() -- line 40
end

function v2.IsShiftLocked(v9) -- line 41 | captures: v5, v6
    return v5 and v6
end

function v2.SetIsInFirstPerson(v10, v11) -- line 48 | captures: v8
    v8 = v11
end

local function mouseLockSwitchFunc(v12, v13, v14) -- line 51 | captures: v5, v6, v2
    if v5 then
        v6 = not v6
        v2.OnShiftLockToggled:Fire()
    end
end

local function disableShiftLock() -- line 57 | captures: v4, v5, v7, v2, v3
    v5 = false
    v3.Icon = ""
    if v4 then
        v4:disconnect()
        v4 = nil
    end
    v7 = false
    v2.OnShiftLockToggled:Fire()
end

local function u68(v15, v16) -- line 67
    if not v16 and v15.UserInputType == Enum.UserInputType.Keyboard and v15.KeyCode == Enum.KeyCode.LeftShift then
    end
end

local function enableShiftLock() -- line 73 | captures: v4, v5, v6, v7, UserInputService, GameSettings, v2, LocalPlayer, u68
    local DevEnableMouseLock = LocalPlayer.DevEnableMouseLock
    if DevEnableMouseLock then
        if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch then
            if LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.ClickToMove or GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove then
                DevEnableMouseLock = false
            else
                DevEnableMouseLock = LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable
            end
        else
            DevEnableMouseLock = false
        end
    end
    v5 = DevEnableMouseLock
    if v5 then
        if v6 then
            v2.OnShiftLockToggled:Fire()
        end
        if not v7 then
            v4 = UserInputService.InputBegan:connect(u68)
            v7 = true
        end
    end
end

GameSettings.Changed:connect(function(v17) -- line 89 | captures: v4, v5, v6, v7, UserInputService, GameSettings, v2, LocalPlayer, v3, u68
    if v17 == "ControlMode" then
        if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch then
            local DevEnableMouseLock = LocalPlayer.DevEnableMouseLock
            if DevEnableMouseLock then
                if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch then
                    if LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.ClickToMove or GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove then
                        DevEnableMouseLock = false
                    else
                        DevEnableMouseLock = LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable
                    end
                else
                    DevEnableMouseLock = false
                end
            end
            v5 = DevEnableMouseLock
            if v5 then
                if v6 then
                    v2.OnShiftLockToggled:Fire()
                end
                if not v7 then
                    v4 = UserInputService.InputBegan:connect(u68)
                    v7 = true
                end
            end
        else
            v5 = false
            v3.Icon = ""
            if v4 then
                v4:disconnect()
                v4 = nil
            end
            v7 = false
            v2.OnShiftLockToggled:Fire()
        end
    elseif v17 == "ComputerMovementMode" then
        if GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove then
            v5 = false
            v3.Icon = ""
            if v4 then
                v4:disconnect()
                v4 = nil
            end
            v7 = false
            v2.OnShiftLockToggled:Fire()
        else
            local DevEnableMouseLock = LocalPlayer.DevEnableMouseLock
            if DevEnableMouseLock then
                if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch then
                    if LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.ClickToMove or GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove then
                        DevEnableMouseLock = false
                    else
                        DevEnableMouseLock = LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable
                    end
                else
                    DevEnableMouseLock = false
                end
            end
            v5 = DevEnableMouseLock
            if v5 then
                if v6 then
                    v2.OnShiftLockToggled:Fire()
                end
                if not v7 then
                    v4 = UserInputService.InputBegan:connect(u68)
                    v7 = true
                end
            end
        end
    end
end)
LocalPlayer.Changed:connect(function(v18) -- line 149 | captures: v4, v5, v6, v7, UserInputService, GameSettings, v2, LocalPlayer, v3, u68
    if v18 == "DevEnableMouseLock" then
        if LocalPlayer.DevEnableMouseLock then
            local DevEnableMouseLock = LocalPlayer.DevEnableMouseLock
            if DevEnableMouseLock then
                if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch then
                    if LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.ClickToMove or GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove then
                        DevEnableMouseLock = false
                    else
                        DevEnableMouseLock = LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable
                    end
                else
                    DevEnableMouseLock = false
                end
            end
            v5 = DevEnableMouseLock
            if v5 then
                if v6 then
                    v2.OnShiftLockToggled:Fire()
                end
                if not v7 then
                    v4 = UserInputService.InputBegan:connect(u68)
                    v7 = true
                end
            end
        else
            v5 = false
            v3.Icon = ""
            if v4 then
                v4:disconnect()
                v4 = nil
            end
            v7 = false
            v2.OnShiftLockToggled:Fire()
        end
    elseif v18 == "DevComputerMovementMode" then
        if LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.ClickToMove and LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable then
            local DevEnableMouseLock = LocalPlayer.DevEnableMouseLock
            if DevEnableMouseLock then
                if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch then
                    if LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.ClickToMove or GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove then
                        DevEnableMouseLock = false
                    else
                        DevEnableMouseLock = LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable
                    end
                else
                    DevEnableMouseLock = false
                end
            end
            v5 = DevEnableMouseLock
            if v5 then
                if v6 then
                    v2.OnShiftLockToggled:Fire()
                end
                if not v7 then
                    v4 = UserInputService.InputBegan:connect(u68)
                    v7 = true
                end
            end
        else
            v5 = false
            v3.Icon = ""
            if v4 then
                v4:disconnect()
                v4 = nil
            end
            v7 = false
            v2.OnShiftLockToggled:Fire()
        end
    end
end)
LocalPlayer.CharacterAdded:connect(function(v19) -- line 209
end)

if not UserInputService.TouchEnabled then
    local DevEnableMouseLock = LocalPlayer.DevEnableMouseLock
    if DevEnableMouseLock then
        if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch then
            if LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.ClickToMove or GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove then
                DevEnableMouseLock = false
            else
                DevEnableMouseLock = LocalPlayer.DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable
            end
        else
            DevEnableMouseLock = false
        end
    end
    if DevEnableMouseLock then
        v7 = true
    end
end
v5 = LocalPlayer.DevEnableMouseLock

if v5 then
    if GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch then
        v5 = not (LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.ClickToMove or GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove or LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable)
    else
        v5 = false
    end
end

if v5 and v6 then
    v2.OnShiftLockToggled:Fire()
end
return v2
