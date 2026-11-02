-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local LocalPlayer = Players.LocalPlayer
local v1 = false
local v2

local function resolveMarker() -- line 16 | captures: Workspace
    local __OBJECTS = Workspace:FindFirstChild("__OBJECTS")
    local v3 = __OBJECTS and __OBJECTS:FindFirstChild("Areas")
    local v4 = v3 and v3:FindFirstChild("AdminAbuseEggSpawn")
    if v4 ~= nil and v4:IsA("BasePart") then
        return v4
    end
    return nil
end

local function restoreCamera() -- line 34 | captures: Workspace, LocalPlayer
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return
    end
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera.FieldOfView = 70
    local Character = LocalPlayer.Character
    local v5 = Character and Character:FindFirstChildOfClass("Humanoid")
    if v5 ~= nil then
        CurrentCamera.CameraSubject = v5
    end
end

local function stopCutscene() -- line 50 | captures: v1, v2, Workspace, LocalPlayer
    if not v1 then
        return
    end
    v1 = false
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil then
        CurrentCamera.CameraType = Enum.CameraType.Custom
        CurrentCamera.FieldOfView = 70
        local Character = LocalPlayer.Character
        local v6 = Character and Character:FindFirstChildOfClass("Humanoid")
        if v6 ~= nil then
            CurrentCamera.CameraSubject = v6
        end
    end
    local v7 = v2
    v2 = nil
    if v7 ~= nil then
        v7()
    end
end

local function resolveEggShot(v8) -- line 74
    local Facing = v8:GetAttribute("Facing")
    local Finish = v8:GetAttribute("Finish")
    if not (typeof(Facing) == "Vector3" and typeof(Finish) == "Vector3") then
        return nil
    end
    local X = Facing.X
    local Z = Facing.Z
    local v9 = Vector3.new(X, 0, Z)
    if v9.Magnitude <= 0 then
        return nil
    end
    local v10, v11 = v8:GetBoundingBox()
    local v12 = Finish + (v10.Position - v8:GetPivot().Position)
    local v13 = (v9.Unit * 0.9945218953682733 + Vector3.new(0, 0.10452846437692642, 0)) * (v11.Y / 0.8 * 0.5 / 0.22169466264293988)
    return CFrame.lookAt(v12 + v13, v12)
end

local function startCutscene() -- line 90 | captures: v1, v2, RunService, TweenService, Workspace, HiddenUIHandler, resolveEggShot
    if v1 then
        return
    end
    local __OBJECTS = Workspace:FindFirstChild("__OBJECTS")
    local v14 = __OBJECTS and __OBJECTS:FindFirstChild("Areas")
    local v15 = v14 and v14:FindFirstChild("AdminAbuseEggSpawn")
    if v15 ~= nil and not v15:IsA("BasePart") then
        v15 = nil
    end
    local CurrentCamera = Workspace.CurrentCamera
    if v15 == nil or CurrentCamera == nil then
        return
    end
    v2 = HiddenUIHandler.Acquire()
    v1 = true
    CurrentCamera.CameraType = Enum.CameraType.Scriptable
    local v16 = TweenInfo.new(2)
    local v17 = { FieldOfView = 80 }
    TweenService:Create(CurrentCamera, v16, v17):Play()
    local v18 = v15.Position + Vector3.new(0, 165, 0)
    local v19 = v15.Position + Vector3.new(-200, 25, 0)
    local v20 = CFrame.lookAt(v19, v18)
    CurrentCamera.CFrame = v20
    task.spawn(function() -- line 125 | captures: CurrentCamera, v20, v1, RunService, Workspace, resolveEggShot
        local v21
        while true do
            local v22, v23
            if v1 then
                local v24 = RunService.RenderStepped:Wait()
                if v1 then
                    CurrentCamera.CameraType = Enum.CameraType.Scriptable
                    local AdminAbuseEggDrop = Workspace:FindFirstChild("AdminAbuseEggDrop")
                    if AdminAbuseEggDrop == nil then
                        CurrentCamera.CFrame = v20
                        v22 = v21
                    elseif AdminAbuseEggDrop:IsA("Model") then
                        local v25 = resolveEggShot(AdminAbuseEggDrop)
                        if v25 == nil then
                            CurrentCamera.CFrame = v20
                            v22 = v21
                        elseif AdminAbuseEggDrop:GetAttribute("Done") then
                            if v21 == nil then
                                v22 = os.clock()
                            else
                                v22 = v21
                            end
                            local Position = AdminAbuseEggDrop:GetBoundingBox().Position
                            local v26 = CFrame.Angles(0, (os.clock() - v22) * 0.09, 0) * (v25.Position - Position)
                            local v27 = CFrame.lookAt(Position + v26, Position)
                            local v28 = v24 * 2.5
                            local v29 = math.clamp(v28, 0, 1)
                            CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(v27, v29)
                            CurrentCamera.FieldOfView += (25 - CurrentCamera.FieldOfView) * v29
                        else
                            local Position = AdminAbuseEggDrop:GetPivot().Position
                            local Start = AdminAbuseEggDrop:GetAttribute("Start")
                            local Finish = AdminAbuseEggDrop:GetAttribute("Finish")
                            local v30 = Start.Y - Finish.Y
                            local v31 = if v30 <= 0 then 1 else 1 - (Position.Y - Finish.Y) / v30
                            local v32 = CFrame.lookAt(v25.Position, Position)
                            local CFrame_2 = CurrentCamera.CFrame
                            local v33 = v24 * 2
                            CurrentCamera.CFrame = CFrame_2:Lerp(v32, (math.clamp(v33, 0, 1)))
                            local v34 = math.clamp(v31, 0, 1)
                            CurrentCamera.FieldOfView = math.lerp(80, 25, v34)
                            v22 = v21
                        end
                    else
                        v22 = v21
                    end
                    v23 = false
                else
                    v23 = true
                end
            else
                v23 = true
            end
            if v23 then
                break
            end
            v21 = v22
        end
    end)
end

local v35 = {}

function v35.StartEvent(v36, v37, v38) -- line 175 | captures: startCutscene
    startCutscene()
end

function v35.StopEvent(v39) -- line 178 | captures: v1, v2, Workspace, LocalPlayer
    if not v1 then
        return
    end
    v1 = false
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil then
        CurrentCamera.CameraType = Enum.CameraType.Custom
        CurrentCamera.FieldOfView = 70
        local Character = LocalPlayer.Character
        local v40 = Character and Character:FindFirstChildOfClass("Humanoid")
        if v40 ~= nil then
            CurrentCamera.CameraSubject = v40
        end
    end
    local v41 = v2
    v2 = nil
    if v41 ~= nil then
        v41()
    end
end

Workspace:GetAttributeChangedSignal("AdminAbusePhase"):Connect(function() -- line 204 | captures: v1, v2, Workspace, LocalPlayer, startCutscene
    if Workspace:GetAttribute("AdminAbusePhase") == "Cutscene" then
        startCutscene()
    elseif v1 then
        v1 = false
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera ~= nil then
            CurrentCamera.CameraType = Enum.CameraType.Custom
            CurrentCamera.FieldOfView = 70
            local Character = LocalPlayer.Character
            local v42 = Character and Character:FindFirstChildOfClass("Humanoid")
            if v42 ~= nil then
                CurrentCamera.CameraSubject = v42
            end
        end
        local v43 = v2
        v2 = nil
        if v43 ~= nil then
            v43()
        end
    end
end)
LocalPlayer.CharacterAdded:Connect(function() -- line 232 | captures: v1, Workspace, LocalPlayer
    if not v1 then
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera ~= nil then
            CurrentCamera.CameraType = Enum.CameraType.Custom
            CurrentCamera.FieldOfView = 70
            local Character = LocalPlayer.Character
            local v44 = Character and Character:FindFirstChildOfClass("Humanoid")
            if v44 ~= nil then
                CurrentCamera.CameraSubject = v44
            end
        end
    end
end)

if Workspace:GetAttribute("AdminAbusePhase") == "Cutscene" then
    startCutscene()
elseif v1 then
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil then
        CurrentCamera.CameraType = Enum.CameraType.Custom
        CurrentCamera.FieldOfView = 70
        local Character = LocalPlayer.Character
        local v45 = Character and Character:FindFirstChildOfClass("Humanoid")
        if v45 ~= nil then
            CurrentCamera.CameraSubject = v45
        end
    end
    local v46 = v2
    if v46 ~= nil then
        v46()
    end
end
return v35
