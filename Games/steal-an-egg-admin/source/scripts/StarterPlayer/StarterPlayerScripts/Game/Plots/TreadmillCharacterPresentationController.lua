-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local t = require(ReplicatedStorage.Packages.t)
local Ease = require(ReplicatedStorage.Shared.Utils.Interpolation).Ease
local Player = require(ReplicatedStorage.Shared.Player)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local RuntimeInstanceRegistry = require(ReplicatedStorage.Client.Modules.RuntimeInstanceRegistry)
local TreadmillFlags = require(ReplicatedStorage.Shared.Flags.TreadmillFlags)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts")
local v1 = require(PlayerScripts.PlayerModule):GetCameras()
local v2, v3, v4
local v5 = 0
local v6 = {}
local v7 = {}
local v8 = {}

local function restoreSnapshot(v9) -- line 27
    for v10, v11 in pairs(v9.PartStates) do
        if v10.Parent ~= nil then
            v10.Transparency = v11
        end
    end
end

local function restoreActiveSnapshot() -- line 34 | captures: v3
    local v12 = v3
    v3 = nil
    if v12 ~= nil then
        v12.DescendantTrove:Destroy()
        for v13, v14 in pairs(v12.PartStates) do
            if v13.Parent ~= nil then
                v13.Transparency = v14
            end
        end
    end
end

local function restoreBillboardAlwaysOnTop(v15, v16) -- line 47 | captures: v6
    if v6[v15] == v16 then
        v6[v15] = nil
        if v15.Parent ~= nil and v15.AlwaysOnTop == false then
            v15.AlwaysOnTop = v16
        end
    end
end

local function setBillboardNotAlwaysOnTop(v17) -- line 56 | captures: v2, t, v6
    t.strict(t.instanceIsA("BillboardGui"))(v17)
    local v18 = v2
    if not (v18 ~= nil and v6[v17] == nil) then
        return
    end
    local AlwaysOnTop = v17.AlwaysOnTop
    v6[v17] = AlwaysOnTop
    v17.AlwaysOnTop = false
    v18:Connect(v17:GetPropertyChangedSignal("AlwaysOnTop"), function() -- line 67 | captures: v17, v6
        if v17.AlwaysOnTop ~= false then
            v6[v17] = nil
        end
    end)
    v18:Add(function() -- line 72 | captures: v17, AlwaysOnTop, v6
        if v6[v17] == AlwaysOnTop then
            v6[v17] = nil
            if v17.Parent ~= nil and v17.AlwaysOnTop == false then
                v17.AlwaysOnTop = AlwaysOnTop
            end
        end
    end)
end

local function restoreHumanoidDisplayDistanceType(v19, v20) -- line 84 | captures: v7
    if v7[v19] == v20 then
        v7[v19] = nil
        if v19.Parent ~= nil and v19.DisplayDistanceType == Enum.HumanoidDisplayDistanceType.None then
            v19.DisplayDistanceType = v20
        end
    end
end

local function hideVisibleHumanoidDisplayDistance(v21) -- line 93 | captures: v2, t, v7
    t.strict(t.instanceIsA("Humanoid"))(v21)
    local v22 = v2
    if v22 ~= nil and v7[v21] == nil then
        local DisplayDistanceType = v21.DisplayDistanceType
        if DisplayDistanceType ~= Enum.HumanoidDisplayDistanceType.None then
            v7[v21] = DisplayDistanceType
            v21.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            v22:Connect(v21:GetPropertyChangedSignal("DisplayDistanceType"), function() -- line 107 | captures: v21, v7
                if v21.DisplayDistanceType ~= Enum.HumanoidDisplayDistanceType.None then
                    v7[v21] = nil
                end
            end)
            v22:Add(function() -- line 112 | captures: v21, DisplayDistanceType, v7
                if v7[v21] == DisplayDistanceType then
                    v7[v21] = nil
                    if v21.Parent ~= nil and v21.DisplayDistanceType == Enum.HumanoidDisplayDistanceType.None then
                        v21.DisplayDistanceType = DisplayDistanceType
                    end
                end
            end)
        end
    end
end

local function getCameraTransparency(v23) -- line 124
    if v23 <= 5 then
        return 1
    end
    local v24 = 1 - (v23 - 5) / 8
    return (math.clamp(v24, 0, 1))
end

local function trackCharacterPart(v25, v26) -- line 130
    if v26:IsA("BasePart") and v26:FindFirstAncestorWhichIsA("Tool") == nil and v25.PartStates[v26] == nil then
        v25.PartStates[v26] = v26.Transparency
    end
end

local function bindCharacter(v27) -- line 136 | captures: v2, v3
    local v28 = v2
    if v28 == nil then
        return
    end
    local v29 = v3
    v3 = nil
    if v29 ~= nil then
        v29.DescendantTrove:Destroy()
        for v30, v31 in pairs(v29.PartStates) do
            if v30.Parent ~= nil then
                v30.Transparency = v31
            end
        end
    end
    local v32 = {
        Character = v27,
        DescendantTrove = v28:Extend(),
        PartStates = {}
    }
    v3 = v32
    for v33, v34 in ipairs(v27:GetDescendants()) do
        if v34:IsA("BasePart") and v34:FindFirstAncestorWhichIsA("Tool") == nil and v32.PartStates[v34] == nil then
            v32.PartStates[v34] = v34.Transparency
        end
    end
    v32.DescendantTrove:Connect(v27.DescendantAdded, function(v35) -- line 158 | captures: v32
        if v35:IsA("BasePart") and v35:FindFirstAncestorWhichIsA("Tool") == nil and v32.PartStates[v35] == nil then
            v32.PartStates[v35] = v35.Transparency
        end
    end)
end

local function updateCharacterTransparency() -- line 166 | captures: v3, Workspace, Player, LocalPlayer
    local CurrentCamera = Workspace.CurrentCamera
    local v36 = Player.Optional.Head(LocalPlayer)
    if CurrentCamera == nil or v36 == nil then
        return
    end
    local v37 = v3
    local v38, v39
    if v37 == nil then
        v39 = true
    elseif v36.Parent == v37.Character then
        local Magnitude = (CurrentCamera.CFrame.Position - v36.Position).Magnitude
        if Magnitude > 5 then
            local v40 = 1 - (Magnitude - 5) / 8
            v38 = math.clamp(v40, 0, 1)
        else
            v38 = 1
        end
        v39 = false
    else
        v39 = true
    end
    if v39 then
        return
    end
    for v41, v42 in pairs(v37.PartStates) do
        if v41.Parent == nil then
            v37.PartStates[v41] = nil
        else
            v41.Transparency = math.max(v42, v38)
        end
    end
end

local function resolveCurrentTransparency() -- line 191 | captures: v3, Workspace, Player, LocalPlayer
    local CurrentCamera = Workspace.CurrentCamera
    local v43 = Player.Optional.Head(LocalPlayer)
    if CurrentCamera == nil or v43 == nil then
        return nil
    end
    local v44 = v3
    if not (v44 ~= nil and v43.Parent == v44.Character) then
        return nil
    end
    local Magnitude = (CurrentCamera.CFrame.Position - v43.Position).Magnitude
    if Magnitude <= 5 then
        return 1
    end
    local v45 = 1 - (Magnitude - 5) / 8
    return (math.clamp(v45, 0, 1))
end

local function restoreAutoCameraState() -- line 207 | captures: Workspace
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil and CurrentCamera.CameraType == Enum.CameraType.Scriptable then
        CurrentCamera.CameraType = Enum.CameraType.Custom
    end
end

local function commitAutoCameraDistance(v46) -- line 213 | captures: v1
    v1:CommitCameraCFrame(v46, Enum.CameraType.Custom)
end

local function completeAutoCameraState(v47) -- line 216 | captures: v4, Workspace, v1
    v4 = nil
    if v4 == nil then
        return
    end
    v1:CommitCameraCFrame(v47, Enum.CameraType.Custom)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil and CurrentCamera.CameraType == Enum.CameraType.Scriptable then
        CurrentCamera.CameraType = Enum.CameraType.Custom
    end
end

local function clearAutoCameraState() -- line 227 | captures: v4, Workspace
    v4 = nil
    if v4 ~= nil then
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera ~= nil and CurrentCamera.CameraType == Enum.CameraType.Scriptable then
            CurrentCamera.CameraType = Enum.CameraType.Custom
        end
    end
end

local function resolveAutoCameraFocusPoint(v48, v49) -- line 237
    return v48.CFrame:PointToWorldSpace(v49)
end

local function resolveAutoCameraTargetCFrame(v50, v51) -- line 240
    local v52 = v50.Position - v51
    if v52.Magnitude <= 0.001 then
        v52 = -v50.CFrame.LookVector
    end
    local v53 = v51 - v52.Unit * 1.8
    local v54 = v50.Position + Vector3.new(0, 0.11999999731779099, 0)
    return CFrame.lookAt(v53, v54, (Vector3.new(0, 1, 0)))
end

local function updateAutoCamera() -- line 249 | captures: v4, Workspace, Ease, Player, LocalPlayer, v1
    local v55 = v4
    if v55 == nil then
        return
    end
    local CurrentCamera = Workspace.CurrentCamera
    local v56 = Player.Optional.Head(LocalPlayer)
    local v57 = Player.Optional.HumanoidRootPart(LocalPlayer)
    local VideoScreenPart = v55.VideoScreenPart
    if CurrentCamera ~= nil and v56 ~= nil and v57 ~= nil and VideoScreenPart ~= nil then
        if VideoScreenPart.Parent == nil then
            v4 = nil
            if v4 ~= nil then
                local CurrentCamera = Workspace.CurrentCamera
                if CurrentCamera ~= nil and CurrentCamera.CameraType == Enum.CameraType.Scriptable then
                    CurrentCamera.CameraType = Enum.CameraType.Custom
                end
            end
        else
            local v58 = v57.CFrame:PointToWorldSpace(v55.FocusOffset)
            local v59 = VideoScreenPart.Position - v58
            if v59.Magnitude <= 0.001 then
                v59 = -VideoScreenPart.CFrame.LookVector
            end
            local v60 = v58 - v59.Unit * 1.8
            local v61 = VideoScreenPart.Position + Vector3.new(0, 0.11999999731779099, 0)
            local v62 = CFrame.lookAt(v60, v61, (Vector3.new(0, 1, 0)))
            local v63 = (os.clock() - v55.StartedAt) / 0.35
            local v64 = math.clamp(v63, 0, 1)
            CurrentCamera.CFrame = v55.InitialCameraCFrame:Lerp(v62, Ease(v64, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))
            if not (v64 < 1) then
                v4 = nil
                if v4 ~= nil then
                    v1:CommitCameraCFrame(v62, Enum.CameraType.Custom)
                    local CurrentCamera = Workspace.CurrentCamera
                    if CurrentCamera ~= nil and CurrentCamera.CameraType == Enum.CameraType.Scriptable then
                        CurrentCamera.CameraType = Enum.CameraType.Custom
                    end
                end
            end
        end
    end
end

local function bindAutoCameraScreen(v65, v66) -- line 296 | captures: v4, Workspace, RuntimeInstanceRegistry, TreadmillUtil
    local v67 = RuntimeInstanceRegistry.Demand("Treadmill", v65)
    local Tool = v67:IsA("Tool")
    local v68 = ("Runtime treadmill \"%*\" must be a Tool"):format(v65)
    assert(Tool, v68)
    local v69 = v4
    if v69 ~= nil and v69.Token == v66 then
        local v70 = TreadmillUtil.FindVideoFeedScreenPart(v67)
        if v70 == nil then
            v4 = nil
            if v4 ~= nil then
                local CurrentCamera = Workspace.CurrentCamera
                if CurrentCamera ~= nil and CurrentCamera.CameraType == Enum.CameraType.Scriptable then
                    CurrentCamera.CameraType = Enum.CameraType.Custom
                end
            end
        else
            v69.VideoScreenPart = v70
        end
    end
end

local function bindPlayerDisplayDistance(v71) -- line 318 | captures: v2, t, Player, hideVisibleHumanoidDisplayDistance
    t.strict(t.instanceIsA("Player"))(v71)
    local v72 = v2
    if v72 == nil then
        return
    end
    local v73 = Player.Optional.Humanoid(v71)
    if v73 ~= nil then
        hideVisibleHumanoidDisplayDistance(v73)
    end

    local function bindPlayerCharacterDisplayDistance(v74) -- line 329 | captures: v71, v72, t, Player, hideVisibleHumanoidDisplayDistance
        t.strict(t.instanceIsA("Model"))(v74)
        local v75 = Player.Optional.Humanoid(v71)
        if v75 ~= nil then
            hideVisibleHumanoidDisplayDistance(v75)
        end
        v72:Connect(v74.ChildAdded, function(v76) -- line 336 | captures: hideVisibleHumanoidDisplayDistance
            if v76:IsA("Humanoid") then
                hideVisibleHumanoidDisplayDistance(v76)
            end
        end)
    end

    if v71.Character ~= nil then
        bindPlayerCharacterDisplayDistance(v71.Character)
    end
    v72:Connect(v71.CharacterAdded, bindPlayerCharacterDisplayDistance)
end

local function bindHumanoidDisplayPresentation() -- line 347 | captures: v2, Players, bindPlayerDisplayDistance
    local v77 = v2
    if v77 ~= nil then
        for v78, v79 in ipairs(Players:GetPlayers()) do
            task.defer(bindPlayerDisplayDistance, v79)
        end
        v77:Connect(Players.PlayerAdded, bindPlayerDisplayDistance)
    end
end

local function bindYourBaseBillboardPresentation() -- line 357 | captures: v2, PlotState, setBillboardNotAlwaysOnTop
    local v80 = v2
    if v80 == nil then
        return
    end
    local v81 = PlotState.FindLocalBaseSign()
    if v81 ~= nil then
        setBillboardNotAlwaysOnTop(v81)
    end
    v80:Add(PlotState.LocalPlotChanged:Connect(function() -- line 366 | captures: PlotState, setBillboardNotAlwaysOnTop
        local v82 = PlotState.FindLocalBaseSign()
        if v82 ~= nil then
            setBillboardNotAlwaysOnTop(v82)
        end
    end))
end

function v8.Stop() -- line 373 | captures: v2, v3, v4, v5, Workspace
    v5 += 1
    v4 = nil
    if v4 ~= nil then
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera ~= nil and CurrentCamera.CameraType == Enum.CameraType.Scriptable then
            CurrentCamera.CameraType = Enum.CameraType.Custom
        end
    end
    local v83 = v2
    v2 = nil
    if v83 == nil then
        local v84 = v3
        v3 = nil
        if v84 ~= nil then
            v84.DescendantTrove:Destroy()
            for v85, v86 in pairs(v84.PartStates) do
                if v85.Parent ~= nil then
                    v85.Transparency = v86
                end
            end
        end
    else
        v83:Destroy()
    end
end

function v8.StopCameraTransparency() -- line 400 | captures: v8
    v8.Stop()
end

local function cameraSubjectPosition() -- line 407 | captures: Workspace, v1
    local activeCameraController = v1 ~= nil and rawget(v1, "activeCameraController") or nil
    if activeCameraController ~= nil then
        local GetSubjectPosition = activeCameraController.GetSubjectPosition
        if type(GetSubjectPosition) == "function" then
            local v87, v88 = pcall(activeCameraController.GetSubjectPosition, activeCameraController)
            if v87 and typeof(v88) == "Vector3" then
                return v88
            end
        end
    end
    local CurrentCamera = Workspace.CurrentCamera
    local CameraSubject = CurrentCamera ~= nil and CurrentCamera.CameraSubject or nil
    if CameraSubject ~= nil then
        if CameraSubject:IsA("Humanoid") then
            local RootPart = CameraSubject.RootPart
            if RootPart ~= nil then
                return RootPart.Position
            end
        elseif CameraSubject:IsA("BasePart") then
            return CameraSubject.Position
        end
    end
    if CurrentCamera == nil then
        return nil
    end
    return CurrentCamera.Focus.Position
end

function v8.Start(v89) -- line 432 | captures: v2, v4, v5, Workspace, t, Player, PlotState, TreadmillFlags, Trove, LocalPlayer, v8, restoreActiveSnapshot, setBillboardNotAlwaysOnTop, bindCharacter, updateCharacterTransparency, clearAutoCameraState, updateAutoCamera, bindAutoCameraScreen, bindHumanoidDisplayPresentation, cameraSubjectPosition
    t.strict(t.string)(v89)
    v8.Stop()
    v5 += 1
    local v90 = v5
    local v91 = Trove.new()
    v2 = v91
    local CurrentCamera = Workspace.CurrentCamera
    local v92 = Player.Optional.HumanoidRootPart(LocalPlayer)
    local v93 = cameraSubjectPosition()
    if CurrentCamera ~= nil and v93 ~= nil and v92 ~= nil and not TreadmillFlags.CameraAutoFrameDisabled:Get() then
        v4 = {
            FocusOffset = v92.CFrame:PointToObjectSpace(v93),
            InitialCameraCFrame = CurrentCamera.CFrame,
            StartedAt = os.clock(),
            Token = v90
        }
        task.spawn(bindAutoCameraScreen, v89, v90)
    end
    local Character = LocalPlayer.Character
    if Character ~= nil then
        bindCharacter(Character)
    end
    v91:Connect(LocalPlayer.CharacterAdded, bindCharacter)
    v91:BindToRenderStep("TreadmillCameraAutoFrame", Enum.RenderPriority.Camera.Value + 1, updateAutoCamera)
    v91:BindToRenderStep("TreadmillCameraTransparency", Enum.RenderPriority.Camera.Value + 2, updateCharacterTransparency)
    bindHumanoidDisplayPresentation()
    local v94 = v2
    if v94 ~= nil then
        local v95 = PlotState.FindLocalBaseSign()
        if v95 ~= nil then
            setBillboardNotAlwaysOnTop(v95)
        end
        v94:Add(PlotState.LocalPlotChanged:Connect(function() -- line 461 | captures: PlotState, setBillboardNotAlwaysOnTop
            local v96 = PlotState.FindLocalBaseSign()
            if v96 ~= nil then
                setBillboardNotAlwaysOnTop(v96)
            end
        end))
    end
    v91:Add(restoreActiveSnapshot)
    v91:Add(clearAutoCameraState)
end

function v8.StartCameraTransparency(v97) -- line 471 | captures: v8
    v8.Start(v97)
end

function v8.IsLocalCharacterFullyTransparent() -- line 474 | captures: v3, Workspace, Player, LocalPlayer
    local CurrentCamera = Workspace.CurrentCamera
    local v98 = Player.Optional.Head(LocalPlayer)
    local v99
    if CurrentCamera == nil or v98 == nil then
    else
        local v100 = v3
        if v100 == nil then
        elseif v98.Parent == v100.Character then
            local Magnitude = (CurrentCamera.CFrame.Position - v98.Position).Magnitude
            if Magnitude > 5 then
                local v101 = 1 - (Magnitude - 5) / 8
                v99 = math.clamp(v101, 0, 1)
            else
                v99 = 1
            end
        end
    end
    if v99 == nil then
        return false
    end
    return v99 >= 1
end

TreadmillFlags.CameraAutoFrameDisabled.Changed:Connect(function(v102) -- line 500 | captures: v4, Workspace
    if v102 then
        v4 = nil
        if v4 ~= nil then
            local CurrentCamera = Workspace.CurrentCamera
            if CurrentCamera ~= nil and CurrentCamera.CameraType == Enum.CameraType.Scriptable then
                CurrentCamera.CameraType = Enum.CameraType.Custom
            end
        end
    end
end)
return v8
