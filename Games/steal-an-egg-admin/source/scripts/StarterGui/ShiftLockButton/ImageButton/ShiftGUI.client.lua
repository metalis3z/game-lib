-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
require(ReplicatedStorage.Shared.Globals.Constants)
local Log = require(ReplicatedStorage.Packages.Log)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local v1 = CFrame.new(-1.7, 0, 0)
local v2 = CFrame.new(1.7, 0, 0)
local v3 = Enum.RenderPriority.Camera.Value + 1
local v4 = {
    Off = "rbxasset://textures/ui/mouseLock_off@2x.png",
    On = "rbxasset://textures/ui/mouseLock_on@2x.png"
}
local LocalPlayer = Players.LocalPlayer
local Parent = script.Parent
local ImageButton = Parent:IsA("ImageButton")
assert(ImageButton, "StarterGui.ShiftLockButton.ImageButton must be an ImageButton")
local Parent_2 = Parent.Parent
local ScreenGui = Parent_2:IsA("ScreenGui")
assert(ScreenGui, "StarterGui.ShiftLockButton must be a ScreenGui")
local Lock = Parent_2.Lock
local ImageLabel = Lock:IsA("ImageLabel")
assert(ImageLabel, "StarterGui.ShiftLockButton.Lock must be an ImageLabel")
local v5 = false
local v6 = false
local v7 = Log.new()

local function updateImage(v8) -- line 33 | captures: Parent, Lock
    local v9 = if v8 then "rbxasset://textures/ui/mouseLock_on@2x.png" else "rbxasset://textures/ui/mouseLock_off@2x.png"
    Parent.Image = v9
    Lock.Visible = v8
end

local function getCurrentCamera() -- line 43 | captures: Workspace
    local CurrentCamera = Workspace.CurrentCamera
    local v10 = CurrentCamera ~= nil
    assert(v10, "Mobile shift lock requires Workspace.CurrentCamera")
    return CurrentCamera
end

local function updateShiftLock() -- line 49 | captures: v6, Workspace, Player, v2, LocalPlayer, Parent, Lock
    if v6 then
        return
    end
    local CurrentCamera = Workspace.CurrentCamera
    local v11 = CurrentCamera ~= nil
    assert(v11, "Mobile shift lock requires Workspace.CurrentCamera")
    if CurrentCamera.CameraType == Enum.CameraType.Scriptable then
        return
    end
    local v12 = Player.HumanoidRootPart(LocalPlayer)
    Player.Humanoid(LocalPlayer).AutoRotate = false
    Parent.Image = "rbxasset://textures/ui/mouseLock_on@2x.png"
    Lock.Visible = true
    local LookVector = CurrentCamera.CFrame.LookVector
    local v13 = LookVector.X * 900000
    local new = CFrame.new
    local Position = v12.Position
    local Y = v12.Position.Y
    local v14 = LookVector.Z * 900000
    v12.CFrame = new(Position, (Vector3.new(v13, Y, v14)))
    CurrentCamera.CFrame *= v2
end

local function disableShiftLock() -- line 70 | captures: v5, RunService, Workspace, Player, v1, LocalPlayer, Parent, Lock
    if not v5 then
        return
    end
    v5 = false
    RunService:UnbindFromRenderStep("MobileShiftLock")
    local v15 = Player.Optional.Humanoid(LocalPlayer)
    if v15 ~= nil then
        v15.AutoRotate = true
    end
    Parent.Image = "rbxasset://textures/ui/mouseLock_off@2x.png"
    Lock.Visible = false
    local CurrentCamera = Workspace.CurrentCamera
    local v16 = CurrentCamera ~= nil
    assert(v16, "Mobile shift lock requires Workspace.CurrentCamera")
    CurrentCamera.CFrame *= v1
end

local function enableShiftLock() -- line 88 | captures: v5, v6, RunService, v3, updateShiftLock
    if not (v5 or v6) then
        v5 = true
        RunService:BindToRenderStep("MobileShiftLock", v3, updateShiftLock)
    end
end

local function updateAvailability() -- line 95 | captures: v5, v6, RunService, UserInputService, Workspace, Player, v1, LocalPlayer, Parent, Lock, v7
    local v17 = v6
    if v17 then
        if v5 then
            v5 = false
            RunService:UnbindFromRenderStep("MobileShiftLock")
            local v18 = Player.Optional.Humanoid(LocalPlayer)
            if v18 ~= nil then
                v18.AutoRotate = true
            end
            Parent.Image = "rbxasset://textures/ui/mouseLock_off@2x.png"
            Lock.Visible = false
            local CurrentCamera = Workspace.CurrentCamera
            local v19 = CurrentCamera ~= nil
            local v20 = "Mobile shift lock requires Workspace.CurrentCamera"
            assert(v19, v20)
            CurrentCamera.CFrame *= v1
        end
        v7:AtDebug():Log("Mobile shift lock suppressed by a gameplay lock")
    end
    local v21 = UserInputService.TouchEnabled and not v17
    Parent.Visible = v21
end

local function toggleShiftLock() -- line 121 | captures: v5, v6, RunService, Workspace, Player, v1, v3, LocalPlayer, Parent, Lock, updateShiftLock
    if v5 then
        v5 = false
        RunService:UnbindFromRenderStep("MobileShiftLock")
        local v22 = Player.Optional.Humanoid(LocalPlayer)
        if v22 ~= nil then
            v22.AutoRotate = true
        end
        Parent.Image = "rbxasset://textures/ui/mouseLock_off@2x.png"
        Lock.Visible = false
        local CurrentCamera = Workspace.CurrentCamera
        local v23 = CurrentCamera ~= nil
        assert(v23, "Mobile shift lock requires Workspace.CurrentCamera")
        CurrentCamera.CFrame *= v1
    elseif not v5 and not v6 then
        v5 = true
        RunService:BindToRenderStep("MobileShiftLock", v3, updateShiftLock)
    end
end

Parent.Image = "rbxasset://textures/ui/mouseLock_off@2x.png"
Lock.Visible = false

local v24 = v6

if v24 then
    if v5 then
        v5 = false
        RunService:UnbindFromRenderStep("MobileShiftLock")
        local v25 = Player.Optional.Humanoid(LocalPlayer)
        if v25 ~= nil then
            v25.AutoRotate = true
        end
        Parent.Image = "rbxasset://textures/ui/mouseLock_off@2x.png"
        Lock.Visible = false
        local CurrentCamera = Workspace.CurrentCamera
        local v26 = CurrentCamera ~= nil
        local v27 = "Mobile shift lock requires Workspace.CurrentCamera"
        assert(v26, v27)
        CurrentCamera.CFrame *= v1
    end
    v7:AtDebug():Log("Mobile shift lock suppressed by a gameplay lock")
end
Parent.Visible = UserInputService.TouchEnabled and not v24
Remotes.Treadmill.AssignedBeltShifted.OnClientEvent:Connect(function(v28) -- line 176 | captures: v5, v6, RunService, UserInputService, Workspace, Player, v1, LocalPlayer, Parent, Lock, v7
    v6 = v28 ~= nil
    local v29 = v6
    if v29 then
        if v5 then
            v5 = false
            RunService:UnbindFromRenderStep("MobileShiftLock")
            local v30 = Player.Optional.Humanoid(LocalPlayer)
            if v30 ~= nil then
                v30.AutoRotate = true
            end
            Parent.Image = "rbxasset://textures/ui/mouseLock_off@2x.png"
            Lock.Visible = false
            local CurrentCamera = Workspace.CurrentCamera
            local v31 = CurrentCamera ~= nil
            local v32 = "Mobile shift lock requires Workspace.CurrentCamera"
            assert(v31, v32)
            CurrentCamera.CFrame *= v1
        end
        v7:AtDebug():Log("Mobile shift lock suppressed by a gameplay lock")
    end
    local v33 = UserInputService.TouchEnabled and not v29
    Parent.Visible = v33
end)
Parent.Activated:Connect(toggleShiftLock)
