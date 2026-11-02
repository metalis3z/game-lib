-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local CollectionService = game:GetService("CollectionService")
local ContentProvider = game:GetService("ContentProvider")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local AreaEggCycle = require(ReplicatedStorage.Shared.Util.AreaEggCycle)
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local EggState = require(ReplicatedStorage.Client.EggState)
local GUI = require(ReplicatedStorage.Client.GUI)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local LightingsController = require(ReplicatedStorage.Client.LightingsController)
local Lightings = require(ReplicatedStorage.Data.Lightings)
local PlacedEggRenderer = require(ReplicatedStorage.Shared.Eggs.PlacedEggRenderer)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Sakura = require(ReplicatedStorage.Data.Sakura)
local SakuraBloomPolicy = require(ReplicatedStorage.Client.Modules.SakuraBloomPolicy)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Game = Players.LocalPlayer.PlayerScripts:FindFirstChild("Game")
local v1 = Game and Game:FindFirstChild("Plots")
local v2 = v1 and v1:FindFirstChild("ActiveAssetsController")
local v3

if v2 == nil then
else
    local v4, v5 = pcall(require, v2)
    if v4 then
        v3 = v5
    end
end
local v6 = {}
local v7 = {
    Cutscene1 = true,
    Cutscene2 = true,
    ZoneReveal = true
}
local v8 = {
    Cutscene1 = true,
    Tutorial = true,
    Steal = true
}
local v9 = {}
local v10 = {
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.PlayerList,
    Enum.CoreGuiType.Health,
    Enum.CoreGuiType.EmotesMenu
}
local LocalPlayer = Players.LocalPlayer
local v11 = Trove.new()
local v12 = false
local v13
local v14 = Trove.new()
local v15
local Build = Workspace:WaitForChild("__OBJECTS"):WaitForChild("Build")
local v16 = GUI.TutorialInstructions()
local ScreenGui = v16:IsA("ScreenGui")
assert(ScreenGui, "TutorialInstructions must be a ScreenGui")
local v17 = false
local v18 = false
local Enabled = v16.Enabled
local v19 = CameraShaker.new()
local v20 = false
local v21, v22, v23, v24

local function resolveMarker() -- line 81 | captures: Workspace
    local __OBJECTS = Workspace:FindFirstChild("__OBJECTS")
    local v25 = __OBJECTS and __OBJECTS:FindFirstChild("Areas")
    local v26 = v25 and v25:FindFirstChild("AdminAbuseEggSpawn")
    if v26 ~= nil and v26:IsA("BasePart") then
        return v26
    end
    return nil
end

local function resolveWall() -- line 99 | captures: Workspace
    local __OBJECTS = Workspace:FindFirstChild("__OBJECTS")
    local v27 = __OBJECTS and __OBJECTS:FindFirstChild("Areas")
    local v28 = v27 and v27:FindFirstChild("WallStartVisual")
    if v28 ~= nil and v28:IsA("BasePart") then
        return v28
    end
    return nil
end

local function resolveShot(v29, v30, v31) -- line 117
    local v32 = Vector3.new(-1, 0, 0)
    if v32.Magnitude <= 0 then
        v32 = Vector3.new(-1, 0, 0)
    end
    local v33 = v32.Unit * 0.9945218953682733 + Vector3.new(0, 0.10452846437692642, 0)
    local v34 = v30 / 0.8
    local v35 = v31 or 70
    local v36 = v33 * (math.max(v34, v35) * 0.5 / 0.3152987888789835)
    return CFrame.lookAt(v29 + v36, v29)
end

local function resolveModelSubject(v37) -- line 125 | captures: Workspace
    local v38 = Workspace:FindFirstChild(v37)
    if not (v38 ~= nil and v38:IsA("Model")) then
        return nil, nil
    end
    local v39, v40 = v38:GetBoundingBox()
    return v39.Position, v40.Y
end

local v41 = {}

local function resolveSubject(v42) -- line 135 | captures: Workspace, v41
    local DragonEventCutsceneBeat = Workspace:GetAttribute("DragonEventCutsceneBeat")
    local v43 = if type(DragonEventCutsceneBeat) == "string" then v41[DragonEventCutsceneBeat] else nil
    if v43 == nil then
        local Position, Y
        for v44, v45 in { "DragonCutscene", "DragonModel" } do
            local v46 = Workspace:FindFirstChild(v45)
            if v46 == nil then
                Position = nil
                Y = nil
            elseif v46:IsA("Model") then
                local v47, v48 = v46:GetBoundingBox()
                Position, Y = v47.Position, v48.Y
            end
            if Position ~= nil and Y ~= nil then
                return Position, Y
            end
        end
        return v42.Position, 70
    end
    local v49 = Workspace:FindFirstChild(v43.Name)
    local Position, Y
    if v49 == nil then
    elseif v49:IsA("Model") then
        local v50, v51 = v49:GetBoundingBox()
        Position, Y = v50.Position, v51.Y
    end
    if Position == nil or Y == nil then
        return
    end
    local v52 = v43.FocusLift or 0
    return Position + Vector3.new(0, v52, 0), Y, v43.MinFramedHeight
end

local function restoreCamera() -- line 181 | captures: TweenService, Workspace, LocalPlayer
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return
    end
    CurrentCamera.CameraType = Enum.CameraType.Custom
    TweenService:Create(CurrentCamera, TweenInfo.new(0), { FieldOfView = 70 }):Play()
    CurrentCamera.FieldOfView = 70
    local Character = LocalPlayer.Character
    local v53 = Character and Character:FindFirstChildOfClass("Humanoid")
    if v53 ~= nil then
        CurrentCamera.CameraSubject = v53
    end
end

local function ensureOverlay() -- line 201 | captures: v21, LocalPlayer
    local v54 = v21
    local ScreenGui
    if v54 == nil then
        local ScreenGui_2 = Instance.new("ScreenGui")
        ScreenGui = ScreenGui_2
        ScreenGui_2.Name = "DragonCinematic"
        ScreenGui_2.IgnoreGuiInset = true
        ScreenGui_2.ResetOnSpawn = false
        ScreenGui_2.DisplayOrder = 50
        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Name = "Vignette"
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.Image = "rbxassetid://104574024062008"
        ImageLabel.ImageColor3 = Color3.new(0, 0, 0)
        ImageLabel.ImageTransparency = 1
        ImageLabel.ScaleType = Enum.ScaleType.Stretch
        ImageLabel.Size = UDim2.fromScale(1, 1)
        ImageLabel.ZIndex = 1
        ImageLabel.Parent = ScreenGui_2

        local function bar(v55, v56) -- line 220 | captures: ScreenGui
            local Frame = Instance.new("Frame")
            Frame.Name = v55
            Frame.BackgroundColor3 = Color3.new(0, 0, 0)
            Frame.BorderSizePixel = 0
            Frame.Size = UDim2.fromScale(1, 0.11)
            Frame.Position = v56
            Frame.ZIndex = 2
            Frame.Parent = ScreenGui
            return Frame
        end

        local Top = bar("Top", UDim2.fromScale(0, -0.11))
        local Bottom = bar("Bottom", UDim2.fromScale(0, 1))
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        ScreenGui.Parent = PlayerGui
        local v57 = {
            Gui = ScreenGui,
            Top = Top,
            Bottom = Bottom,
            Vignette = ImageLabel
        }
        v21 = v57
        return v57
    end
    if v54.Gui.Parent == nil then
        local ScreenGui_2 = Instance.new("ScreenGui")
        ScreenGui = ScreenGui_2
        ScreenGui_2.Name = "DragonCinematic"
        ScreenGui_2.IgnoreGuiInset = true
        ScreenGui_2.ResetOnSpawn = false
        ScreenGui_2.DisplayOrder = 50
        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Name = "Vignette"
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.Image = "rbxassetid://104574024062008"
        ImageLabel.ImageColor3 = Color3.new(0, 0, 0)
        ImageLabel.ImageTransparency = 1
        ImageLabel.ScaleType = Enum.ScaleType.Stretch
        ImageLabel.Size = UDim2.fromScale(1, 1)
        ImageLabel.ZIndex = 1
        ImageLabel.Parent = ScreenGui_2

        local function bar(v58, v59) -- line 256 | captures: ScreenGui
            local Frame = Instance.new("Frame")
            Frame.Name = v58
            Frame.BackgroundColor3 = Color3.new(0, 0, 0)
            Frame.BorderSizePixel = 0
            Frame.Size = UDim2.fromScale(1, 0.11)
            Frame.Position = v59
            Frame.ZIndex = 2
            Frame.Parent = ScreenGui
            return Frame
        end

        local Top = bar("Top", UDim2.fromScale(0, -0.11))
        local Bottom = bar("Bottom", UDim2.fromScale(0, 1))
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        ScreenGui.Parent = PlayerGui
        local v60 = {
            Gui = ScreenGui,
            Top = Top,
            Bottom = Bottom,
            Vignette = ImageLabel
        }
        v21 = v60
        return v60
    end
    return v54
end

local function setOverlayShown(v61) -- line 274 | captures: TweenService, ensureOverlay
    local v62 = ensureOverlay()
    local v63 = if v61 then Enum.EasingDirection.Out else Enum.EasingDirection.In
    local v64 = TweenInfo.new(0.9, Enum.EasingStyle.Quint, v63)
    local v65 = {}
    if v61 then
        v65.Position = UDim2.fromScale(0, 0)
    else
        v65.Position = UDim2.fromScale(0, -0.11)
    end
    TweenService:Create(v62.Top, v64, v65):Play()
    local v66 = {}
    if v61 then
        v66.Position = UDim2.fromScale(0, 0.89)
    else
        v66.Position = UDim2.fromScale(0, 1)
    end
    TweenService:Create(v62.Bottom, v64, v66):Play()
    local v67 = {}
    if v61 then
        v67.ImageTransparency = 0.3
    else
        v67.ImageTransparency = 1
    end
    TweenService:Create(v62.Vignette, v64, v67):Play()
end

local function hideAllUi() -- line 308 | captures: v22, v23, v24, StarterGui, Tabs, v10, LocalPlayer
    if v22 ~= nil then
        return
    end
    local v68 = {}
    v23 = Tabs.Current()
    for v69, v70 in LocalPlayer:WaitForChild("PlayerGui"):GetChildren() do
        if v70:IsA("ScreenGui") and v70.Name ~= "DragonCinematic" and v70.Enabled then
            v68[v70] = true
            v70.Enabled = false
        end
    end
    v22 = v68
    pcall(function() -- line 321 | captures: LocalPlayer
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = false
    end)
    local v71 = {}
    for v72, v73 in v10 do
        v71[v73] = StarterGui:GetCoreGuiEnabled(v73)
        StarterGui:SetCoreGuiEnabled(v73, false)
    end
    v24 = v71
end

local function restoreAllUi() -- line 334 | captures: v22, v23, v24, StarterGui, LocalPlayer
    local v74 = v22
    local v75 = v23
    v22 = nil
    v23 = nil
    if v74 ~= nil then
        for v76 in v74 do
            if v76.Parent ~= nil and v76.Name ~= v75 then
                v76.Enabled = true
            end
        end
    end
    pcall(function() -- line 350 | captures: LocalPlayer
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = true
    end)
    local v77 = v24
    v24 = nil
    if v77 ~= nil then
        for v78, v79 in v77 do
            StarterGui:SetCoreGuiEnabled(v78, v79)
        end
    end
    return v75
end

local function hideCutsceneUi() -- line 365 | captures: v13, HiddenUIHandler, hideAllUi
    if v13 == nil then
        v13 = HiddenUIHandler.Acquire()
    end
    hideAllUi()
end

local function restoreCutsceneUi() -- line 371 | captures: v13, Tabs, restoreAllUi
    local v80 = restoreAllUi()
    local v81 = v13
    v13 = nil
    if v81 ~= nil then
        v81()
    end
    if v80 ~= nil then
        Tabs.Show(v80, true)
    end
end

local function easeInOutCubic(v82) -- line 382
    if v82 < 0.5 then
        return v82 * 4 * v82 * v82
    end
    return 1 - (v82 * -2 + 2) ^ 3 / 2
end

local function handheldNoise(v83, v84) -- line 388
    return (math.noise(v83 * 0.22, v84 * 7.31, 0.5) + math.noise(v83 * 1.1, v84 * 7.31 + 3.17, 9.5) * 0.22) / 1.22 * 2
end

local function handheldOffset(v85, v86) -- line 392
    local v87 = (math.noise(v85 * 0.22, 7.31, 0.5) + math.noise(v85 * 1.1, 10.48, 9.5) * 0.22) / 1.22 * 2 * 0.038397243543875255 * v86
    local v88 = (math.noise(v85 * 0.22, 14.62, 0.5) + math.noise(v85 * 1.1, 17.79, 9.5) * 0.22) / 1.22 * 2 * 0.026179938779914945 * v86
    local v89 = (math.noise(v85 * 0.22, 21.93, 0.5) + math.noise(v85 * 1.1, 25.1, 9.5) * 0.22) / 1.22 * 2 * 0.010471975511965976 * v86
    local v90 = (math.noise(v85 * 0.22, 29.24, 0.5) + math.noise(v85 * 1.1, 32.41, 9.5) * 0.22) / 1.22 * 2 * 0.25
    local v91 = (math.noise(v85 * 0.22, 36.55, 0.5) + math.noise(v85 * 1.1, 39.72, 9.5) * 0.22) / 1.22 * 2 * 0.20000000298023224
    local v92 = math.noise(v85 * 0.22, 43.86, 0.5)
    local new = CFrame.new
    local v93 = (v92 + math.noise(v85 * 1.1, 47.03, 9.5) * 0.22) / 1.22 * 2 * 0.10000000149011612
    return new(Vector3.new(v90, v91, v93) * v86) * CFrame.Angles(0, v87, 0) * CFrame.Angles(v88, 0, v89)
end

local function stopCutscene() -- line 408 | captures: v12, v13, RunService, Workspace, Tabs, LocalPlayer, setOverlayShown, restoreAllUi
    if not v12 then
        return
    end
    v12 = false
    RunService:UnbindFromRenderStep("DragonEventCutsceneCamera")
    setOverlayShown(false)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil then
        CurrentCamera.CameraType = Enum.CameraType.Custom
        CurrentCamera.FieldOfView = 70
        local Character = LocalPlayer.Character
        local v94 = Character and Character:FindFirstChildOfClass("Humanoid")
        if v94 ~= nil then
            CurrentCamera.CameraSubject = v94
        end
    end
    local v95 = restoreAllUi()
    local v96 = v13
    v13 = nil
    if v96 ~= nil then
        v96()
    end
    if v95 ~= nil then
        Tabs.Show(v95, true)
    end
end

local function resolveZoneBounds() -- line 438 | captures: Workspace
    local __OBJECTS = Workspace:FindFirstChild("__OBJECTS")
    local v97 = __OBJECTS and __OBJECTS:FindFirstChild("Areas")
    local v98 = v97 and v97:FindFirstChild("CherryBlossom")
    local v99 = v98 and v98:FindFirstChild("Bounds")
    if v99 ~= nil and v99:IsA("BasePart") then
        return v99
    end
    return nil
end

local function startZoneRevealCutscene() -- line 460 | captures: v12, v13, RunService, Workspace, HiddenUIHandler, v19, setOverlayShown, hideAllUi, handheldOffset, resolveZoneBounds
    local v100 = resolveZoneBounds()
    local CurrentCamera = Workspace.CurrentCamera
    if v100 == nil or CurrentCamera == nil then
        return
    end
    v12 = true
    if v13 == nil then
        v13 = HiddenUIHandler.Acquire()
    end
    hideAllUi()
    setOverlayShown(true)
    CurrentCamera.CameraType = Enum.CameraType.Scriptable
    CurrentCamera.FieldOfView = 60
    local Position = v100.Position
    local v101 = Position + Vector3.new(120, 10, 0)
    local v102 = Position + Vector3.new(-400, 28, 0)
    local v103 = CFrame.lookAt(v102, v101)
    local v104 = Position + Vector3.new(-240, 18, 0)
    local v105 = CFrame.lookAt(v104, v101)
    local v106 = os.clock()
    local v107 = Enum.RenderPriority.Camera.Value + 1
    RunService:BindToRenderStep("DragonEventCutsceneCamera", v107, function(v108) -- line 481 | captures: CurrentCamera, v103, v105, v106, v12, v19, handheldOffset
        if not v12 then
            return
        end
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
        local v109 = os.clock() - v106
        local v110 = v109 / 9
        local v111 = math.clamp(v110, 0, 1)
        local v112 = if v111 >= 0.5 then 1 - (v111 * -2 + 2) ^ 3 / 2 else v111 * 4 * v111 * v111
        local v113 = v109 / 1.5
        local v114 = math.clamp(v113, 0, 1)
        local v115 = v103:Lerp(v105, v112)
        local new = CFrame.new
        local v116 = v109 - 9
        local v117 = v115 * new(0, 0, -math.max(0, v116) * 1.6) * handheldOffset(v109, v114)
        CurrentCamera.CFrame = v117 * v19:Update(v108)
    end)
end

local function startCutscene(v118) -- line 503 | captures: v12, v13, RunService, Workspace, HiddenUIHandler, Tabs, v9, v11, v19, resolveSubject, setOverlayShown, hideAllUi, restoreAllUi, handheldOffset, startZoneRevealCutscene
    local v119
    if not v12 then
        if v118 == "ZoneReveal" then
            startZoneRevealCutscene()
        elseif v118 == "Cutscene1" then
            if v13 == nil then
                v13 = HiddenUIHandler.Acquire()
            end
            hideAllUi()
            local v120 = require(script.CutscenePart1)(v11)
            task.spawn(function() -- line 519 | captures: v120, v12, v13, Tabs, restoreAllUi
                v120.Run()
                if v12 then
                    return
                end
                local v121 = restoreAllUi()
                local v122 = v13
                v13 = nil
                if v122 ~= nil then
                    v122()
                end
                if v121 ~= nil then
                    Tabs.Show(v121, true)
                end
            end)
        elseif v118 == "Cutscene2" then
            if v13 == nil then
                v13 = HiddenUIHandler.Acquire()
            end
            hideAllUi()
            local v123 = require(script.CutscenePart2)(v11)
            task.spawn(function() -- line 542 | captures: v123, v12, v13, Tabs, restoreAllUi
                v123.Run()
                if v12 then
                    return
                end
                local v124 = restoreAllUi()
                local v125 = v13
                v13 = nil
                if v125 ~= nil then
                    v125()
                end
                if v124 ~= nil then
                    Tabs.Show(v124, true)
                end
            end)
        else
            local __OBJECTS = Workspace:FindFirstChild("__OBJECTS")
            local v126 = __OBJECTS and __OBJECTS:FindFirstChild("Areas")
            local v127 = v126 and v126:FindFirstChild("AdminAbuseEggSpawn")
            local v128
            if v127 == nil then
            elseif v127:IsA("BasePart") then
                v119 = v127
                v128 = v127
            end
            local CurrentCamera = Workspace.CurrentCamera
            if v128 == nil or CurrentCamera == nil then
                return
            end
            v12 = true
            if v13 == nil then
                v13 = HiddenUIHandler.Acquire()
            end
            hideAllUi()
            setOverlayShown(true)
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
            CurrentCamera.FieldOfView = 80
            local Position = v128.Position
            local v129 = Vector3.new(-1, 0, 0)
            if v129.Magnitude <= 0 then
                v129 = Vector3.new(-1, 0, 0)
            end
            local v130 = (v129.Unit * 0.9945218953682733 + Vector3.new(0, 0.10452846437692642, 0)) * 138.75727260339056
            local v131 = CFrame.lookAt(Position + v130, Position)
            local v132 = v131
            CurrentCamera.CFrame = v131
            local v133 = v131
            local v134 = 80
            local v135 = os.clock()
            local v136 = Workspace:GetAttribute("DragonEventCutsceneBeat")
            local v137 = os.clock()
            local v138
            local v139 = Enum.RenderPriority.Camera.Value + 1
            RunService:BindToRenderStep("DragonEventCutsceneCamera", v139, function(v140) -- line 599 | captures: v119, v132, v133, v134, v135, v136, v138, CurrentCamera, v137, v12, Workspace, v9, v19, resolveSubject, handheldOffset
                if not v12 then
                    return
                end
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                local DragonEventCutsceneBeat = Workspace:GetAttribute("DragonEventCutsceneBeat")
                if DragonEventCutsceneBeat ~= v136 then
                    v136 = DragonEventCutsceneBeat
                    v133 = v132
                    v134 = CurrentCamera.FieldOfView
                    v135 = os.clock()
                    v138 = nil
                end
                local v141, v142, v143 = resolveSubject(v119)
                local v144 = v138
                if v144 ~= nil then
                    local v145 = -v140 / 0.18
                    v141 = v144:Lerp(v141, 1 - math.exp(v145))
                end
                v138 = v141
                local v146 = (os.clock() - v137) * 0.07
                local v147 = -math.cos(v146)
                local v148 = math.sin(v146)
                local v149 = Vector3.new(v147, 0, v148)
                if v149.Magnitude <= 0 then
                    v149 = Vector3.new(-1, 0, 0)
                end
                local v150 = v149.Unit * 0.9945218953682733 + Vector3.new(0, 0.10452846437692642, 0)
                local v151 = v142 / 0.8
                local v152 = v143 or 70
                local v153 = v150 * (math.max(v151, v152) * 0.5 / 0.3152987888789835)
                local v154 = CFrame.lookAt(v141 + v153, v141)
                local v155
                if type(DragonEventCutsceneBeat) == "string" then
                    if v9[DragonEventCutsceneBeat] == nil then
                        v155 = 1.6
                    else
                        v155 = v9[DragonEventCutsceneBeat]
                    end
                else
                    v155 = 1.6
                end
                local v156 = (os.clock() - v135) / v155
                local v157 = math.clamp(v156, 0, 1)
                local v158 = if v157 >= 0.5 then 1 - (v157 * -2 + 2) ^ 3 / 2 else v157 * 4 * v157 * v157
                v132 = v133:Lerp(v154, v158)
                local v159 = os.clock() - v137
                local v160 = v159 / 1.5
                local v161 = math.clamp(v160, 0, 1)
                local v162 = v132 * handheldOffset(v159, v161)
                CurrentCamera.CFrame = v162 * v19:Update(v140)
                CurrentCamera.FieldOfView = v134 + (35 - v134) * v158
            end)
        end
    end
end

local function preloadCutsceneAssets() -- line 655 | captures: v20, ContentProvider, ReplicatedStorage
    if not v20 then
        v20 = true
        task.spawn(function() -- line 660 | captures: ContentProvider, ReplicatedStorage
            ContentProvider:PreloadAsync({ ReplicatedStorage.CutsceneAssets.DragonEggEventCutscene1 })
        end)
    end
end

local function setNightGuiHidden(v163) -- line 664 | captures: LocalPlayer
    local PlayerGui = LocalPlayer.PlayerGui
    local v164 = PlayerGui and PlayerGui:FindFirstChild("ResetStartTimer")
    if v164 ~= nil and v164:IsA("SurfaceGui") then
        v164.Enabled = not v163
    end
end

local function destroyTutorial() -- line 674 | captures: v15, v14
    v15 = nil
    v14:Clean()
end

local function showTutorial() -- line 678 | captures: v15, RunService, Workspace, AreaEggCycle, LocalPlayer, v14
    if v15 ~= nil then
        return
    end
    local __OBJECTS = Workspace:FindFirstChild("__OBJECTS")
    local v165 = __OBJECTS and __OBJECTS:FindFirstChild("Areas")
    local v166 = v165 and v165:FindFirstChild("WallStartVisual")
    if v166 ~= nil and not v166:IsA("BasePart") then
        v166 = nil
    end
    if v166 == nil then
        return
    end
    local v167 = script.WallStartVisual:Clone()
    v14:Add(v167)
    v167.Parent = Workspace
    v15 = v167
    local Main = v167.SurfaceGui.Main
    local Title = Main.Title
    local TimerLabel = Main.TimerLabel
    local v168
    local Heartbeat = RunService.Heartbeat
    v14:Add(Heartbeat:Connect(function() -- line 710 | captures: v168, Title, TimerLabel, Workspace, AreaEggCycle, LocalPlayer
        local v169 = Workspace:GetServerTimeNow()
        local v170 = if AreaEggCycle.IsNightPhase(v169) then "Starting in" else "Time Remaining"
        Title.Text = v170
        local v171 = AreaEggCycle.SecondsUntilPhaseEnd(v169)
        local v172 = v171 / 60
        local v173 = math.floor(v172)
        local v174 = v171 % 60
        local v175 = math.floor(v174)
        if v171 < 1 then
            v168 = v169
        end
        if v168 then
            TimerLabel.Text = "GET READY!!!"
            if v169 - v168 > 7 then
                v168 = nil
            end
        else
            TimerLabel.Text = string.format("%d:%02d", v173, v175)
        end
        local PlayerGui = LocalPlayer.PlayerGui
        local v176 = PlayerGui and PlayerGui:FindFirstChild("ResetStartTimer")
        if v176 ~= nil and v176:IsA("SurfaceGui") then
            v176.Enabled = false
        end
    end))
    v14:Add(function() -- line 744 | captures: LocalPlayer
        local PlayerGui = LocalPlayer.PlayerGui
        local v177 = PlayerGui and PlayerGui:FindFirstChild("ResetStartTimer")
        if v177 ~= nil and v177:IsA("SurfaceGui") then
            v177.Enabled = true
        end
    end)
end

local function setPetsHidden(v178) -- line 755 | captures: v3
    local v179 = v3
    if v179 ~= nil then
        pcall(v179.SetAllPetsHidden, v178)
    end
end

local function isInsideCherryBlossom() -- line 762 | captures: Player, LocalPlayer, resolveZoneBounds
    local v180 = resolveZoneBounds()
    if v180 == nil then
        return false
    end
    local v181 = Player.Optional.PrimaryPart(LocalPlayer)
    if v181 == nil then
        return false
    end
    local v182 = v180.CFrame:PointToObjectSpace(v181.Position)
    local X = v182.X
    if math.abs(X) <= v180.Size.X / 2 then
        local Z = v182.Z
        return math.abs(Z) <= v180.Size.Z / 2
    end
    return false
end

local function isInBloom(v183) -- line 780 | captures: Workspace, Sakura, SakuraBloomPolicy, Save, isInsideCherryBlossom
    local v184 = Save.IsLocalDataLoaded()
    local v185
    if v184 then
        v185 = Save.Get()
    end
    if SakuraBloomPolicy.HasBloomUnlocked(v184, v185) then
        local v186 = Workspace:GetAttribute(Sakura.Bloom.EndsAtAttribute)
        if typeof(v186) == "number" and v183 < v186 then
            return (isInsideCherryBlossom())
        end
    end
    return false
end

local function onPhaseChanged() -- line 795 | captures: v3, v12, v13, v15, v17, v18, Enabled, RunService, Workspace, AreaEggCycle, PlacedEggRenderer, Tabs, v7, v8, LocalPlayer, v14, setOverlayShown, restoreAllUi, startCutscene, showTutorial, isInBloom
    local DragonEventPhase = Workspace:GetAttribute("DragonEventPhase")
    if DragonEventPhase == nil then
        if v12 then
            v12 = false
            RunService:UnbindFromRenderStep("DragonEventCutsceneCamera")
            setOverlayShown(false)
            local CurrentCamera = Workspace.CurrentCamera
            if CurrentCamera ~= nil then
                CurrentCamera.CameraType = Enum.CameraType.Custom
                CurrentCamera.FieldOfView = 70
                local Character = LocalPlayer.Character
                local v187 = Character and Character:FindFirstChildOfClass("Humanoid")
                if v187 ~= nil then
                    CurrentCamera.CameraSubject = v187
                end
            end
            local v188 = restoreAllUi()
            local v189 = v13
            v13 = nil
            if v189 ~= nil then
                v189()
            end
            if v188 ~= nil then
                Tabs.Show(v188, true)
            end
        end
    elseif v7[DragonEventPhase] then
        startCutscene(DragonEventPhase)
    end
    if DragonEventPhase == "Tutorial" or DragonEventPhase == "Steal" then
        showTutorial()
    else
        v15 = nil
        v14:Clean()
    end
    pcall(function() -- line 836 | captures: DragonEventPhase, v17, v18, Enabled, Workspace, AreaEggCycle, LocalPlayer, isInBloom
        local v190 = DragonEventPhase == "Steal"
        LocalPlayer.PlayerGui.DragonEggEventUI.Enabled = v190
        task.spawn(function() -- line 839 | captures: DragonEventPhase, v17, v18, Enabled, Workspace, AreaEggCycle, LocalPlayer, isInBloom
            if DragonEventPhase == "Steal" then
                while true do
                    local v191
                    if LocalPlayer.PlayerGui.DragonEggEventUI.Enabled then
                        task.wait(1)
                        local v192 = Workspace:GetServerTimeNow()
                        v191 = not isInBloom(v192) and not AreaEggCycle.IsNightPhase(v192) and AreaEggCycle.IsCloseToReset(AreaEggCycle.SecondsUntilPhaseEnd(v192)) and not v17 and not v18 and not Enabled
                    else
                        break
                    end
                    if v191 then
                        LocalPlayer.PlayerGui.DragonEggEventUI.Enabled = false
                    end
                end
            end
        end)
    end)
    local v193 = if DragonEventPhase == nil then false else v8[DragonEventPhase] == true
    local PlayerGui = LocalPlayer.PlayerGui
    local v194 = PlayerGui and PlayerGui:FindFirstChild("ResetStartTimer")
    if v194 ~= nil and v194:IsA("SurfaceGui") then
        v194.Enabled = not v193
    end
    local v195 = v3
    if v195 ~= nil then
        pcall(v195.SetAllPetsHidden, v193)
    end
    PlacedEggRenderer.SetAllHidden(v193)
end

local function onMapChanged() -- line 883 | captures: LightingsController, Lightings, Build
    if Build:GetAttribute("DragonEventMap") == true then
        LightingsController:SetModifier("DragonEvent", function() -- line 885 | captures: Lightings
            return Lightings.Directory.DragonEvent
        end, 50, 2)
    else
        LightingsController:ClearModifier("DragonEvent", 2)
    end
end

local v196 = {}

function v196.StartEvent(v197, v198, v199) -- line 893 | captures: startCutscene
    if v199 ~= "Cutscene1" and v199 ~= "Cutscene2" and v199 ~= "ZoneReveal" then
        startCutscene("Dynamic")
    else
        startCutscene(v199)
    end
end

function v196.StopEvent(v200) -- line 903 | captures: v3, v12, v13, v15, RunService, Workspace, PlacedEggRenderer, Tabs, LocalPlayer, v11, v14, restoreCamera, setOverlayShown, restoreAllUi
    if v12 then
        v12 = false
        RunService:UnbindFromRenderStep("DragonEventCutsceneCamera")
        setOverlayShown(false)
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera ~= nil then
            CurrentCamera.CameraType = Enum.CameraType.Custom
            CurrentCamera.FieldOfView = 70
            local Character = LocalPlayer.Character
            local v201 = Character and Character:FindFirstChildOfClass("Humanoid")
            if v201 ~= nil then
                CurrentCamera.CameraSubject = v201
            end
        end
        local v202 = restoreAllUi()
        local v203 = v13
        v13 = nil
        if v203 ~= nil then
            v203()
        end
        if v202 ~= nil then
            Tabs.Show(v202, true)
        end
    end
    v15 = nil
    v14:Clean()
    v11:Clean()
    restoreCamera()
    local PlayerGui = LocalPlayer.PlayerGui
    local v204 = PlayerGui and PlayerGui:FindFirstChild("ResetStartTimer")
    if v204 ~= nil and v204:IsA("SurfaceGui") then
        v204.Enabled = true
    end
    local v205 = v3
    if v205 ~= nil then
        pcall(v205.SetAllPetsHidden, false)
    end
    PlacedEggRenderer.SetAllHidden(false)
    local v206 = restoreAllUi()
    local v207 = v13
    v13 = nil
    if v207 ~= nil then
        v207()
    end
    if v206 ~= nil then
        Tabs.Show(v206, true)
    end
end

Workspace:GetAttributeChangedSignal("DragonEventPhase"):Connect(onPhaseChanged)
Workspace:GetAttributeChangedSignal("DragonEventCutsceneBeat"):Connect(function() -- line 969 | captures: v12, Workspace, v6, v19
    local DragonEventCutsceneBeat = Workspace:GetAttribute("DragonEventCutsceneBeat")
    local v208 = if type(DragonEventCutsceneBeat) == "string" then v6[DragonEventCutsceneBeat] else nil
    if v208 ~= nil and v12 then
        v19:ShakeOnce(v208.Magnitude, v208.Roughness, v208.FadeIn, v208.FadeOut)
    end
end)
Build:GetAttributeChangedSignal("DragonEventMap"):Connect(onMapChanged)
CollectionService:GetInstanceAddedSignal("DragonNestGuideBeam"):Connect(function(v209) -- line 984 | captures: LocalPlayer
    if v209:IsA("Beam") then
        v209.Enabled = v209:GetAttribute("Owner") == LocalPlayer.UserId
    end
end)
for v210, v211 in CollectionService:GetTagged("DragonNestGuideBeam") do
    if v211:IsA("Beam") then
        v211.Enabled = v211:GetAttribute("Owner") == LocalPlayer.UserId
    end
end
EggState.CarryChanged:Connect(function(v212) -- line 998 | captures: v17
    v17 = v212.IsCarrying
end)
Remotes.Treadmill.AssignedBeltShifted.OnClientEvent:Connect(function(v213) -- line 1001 | captures: v18
    v18 = v213 ~= nil
end)
v16:GetPropertyChangedSignal("Enabled"):Connect(function() -- line 1006 | captures: Enabled, v16
    Enabled = v16.Enabled
end)
LocalPlayer.CharacterAdded:Connect(function() -- line 1009 | captures: v12, Workspace, v8, LocalPlayer
    local CurrentCamera, v214, v215
    if v12 then
        v215 = true
    else
        CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera == nil then
            v215 = true
        else
            CurrentCamera.CameraType = Enum.CameraType.Custom
            CurrentCamera.FieldOfView = 70
            local Character = LocalPlayer.Character
            v214 = Character and Character:FindFirstChildOfClass("Humanoid")
            v215 = false
        end
    end
    if not v215 and v214 ~= nil then
        CurrentCamera.CameraSubject = v214
    end
    local DragonEventPhase = Workspace:GetAttribute("DragonEventPhase")
    local v216 = if DragonEventPhase == nil then false else v8[DragonEventPhase] == true
    local PlayerGui = LocalPlayer.PlayerGui
    local v217 = PlayerGui and PlayerGui:FindFirstChild("ResetStartTimer")
    if v217 ~= nil and v217:IsA("SurfaceGui") then
        v217.Enabled = not v216
    end
end)
onPhaseChanged()
onMapChanged()

if not v20 then
    task.spawn(function() -- line 1039 | captures: ContentProvider, ReplicatedStorage
        ContentProvider:PreloadAsync({ ReplicatedStorage.CutsceneAssets.DragonEggEventCutscene1 })
    end)
end
return v196
