-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ContentProvider = game:GetService("ContentProvider")
local Debris = game:GetService("Debris")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local BulkFade = require(ReplicatedStorage.Client.Modules.BulkFade)
local CutsceneHelperFunctions = require(script.Parent.Parent.Parent.CutsceneHelperFunctions)
require(ReplicatedStorage.Packages.Trove)
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local function restoreCamera() -- line 19 | captures: TweenService, CurrentCamera, LocalPlayer
    local v1 = TweenInfo.new(0)
    TweenService:Create(CurrentCamera, v1, { FieldOfView = 70 }):Play()
    CurrentCamera.FieldOfView = 70
    CurrentCamera.CameraType = Enum.CameraType.Custom
    local v2 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
    CurrentCamera.CameraSubject = v2
    LocalPlayer.ReplicationFocus = nil
end

return function(v3) -- line 37 | captures: ContentProvider, Debris, Lighting, ReplicatedStorage, RunService, TweenService, Workspace, BulkFade, CutsceneHelperFunctions, CurrentCamera, LocalPlayer, restoreCamera
    local v4 = CutsceneHelperFunctions.GetHelperFunctions(v3)
    local SetProperty = v4.SetProperty
    local TweenProperty = v4.TweenProperty
    local LoadAnimationIntoRig = v4.LoadAnimationIntoRig
    local MakeFallbackCamera = v4.MakeFallbackCamera
    local DragonEggEventCutscene2 = ReplicatedStorage.CutsceneAssets.DragonEggEventCutscene2
    local CutsceneUI = LocalPlayer.PlayerGui.CutsceneUI
    local CutsceneMusic = script.CutsceneMusic
    local Black = CutsceneUI.Black
    local v5
    local v6 = {}
    local v7 = {}
    local v8 = SetProperty("Workspace.CurrentCamera.FieldOfView", 25)
    local v9 = SetProperty("Workspace.__OBJECTS.Build.1.BOTTOMS.Footprint.Meshes/untitled2 (1).CFrame", CFrame.new(3438.9807, 35.8888, -354.9071, -0.3907, 0, 0.9205, 0, 1, 0, -0.9205, 0, -0.3907))
    local v10 = SetProperty("Workspace.__OBJECTS.Build.1.BOTTOMS.Footprint.FogMesh.CFrame", CFrame.new(3438.9807, 35.6132, -354.9067, 0.5446, 0, -0.8387, 0, 1, 0, 0.8387, 0, 0.5446))
    local v11 = SetProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", 0)
    local v12 = TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.8333333333333334, Enum.EasingStyle.Linear), 1)
    local v13 = SetProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", 1)
    local v14 = SetProperty("Lighting.CutsceneBlur.Enabled", true)
    v7[1] = v8
    v7[2] = v9
    v7[3] = v10
    v7[4] = v11
    v7[5] = v12
    v7[6] = v13
    v7[7] = v14
    v7[8] = SetProperty("Lighting.CutsceneBlur.Size", 2)
    v6[0] = v7
    v6[326] = {
        function() -- line 68 | captures: v5
            for v15, v16 in v5.Charge.Orb:GetDescendants() do
                if v16:IsA("ParticleEmitter") then
                    v16.Enabled = true
                end
            end
        end
    }
    v6[457] = {
        function() -- line 77 | captures: v5
            for v17, v18 in v5.Charge.Ball:GetDescendants() do
                if v18:IsA("ParticleEmitter") then
                    v18.Enabled = true
                end
            end
        end
    }
    v6[484] = {
        function() -- line 86 | captures: v5
            for v19, v20 in v5.Charge.Orb:GetDescendants() do
                if v20:IsA("ParticleEmitter") then
                    v20.Enabled = false
                end
            end
        end
    }
    v6[622] = {
        function() -- line 95 | captures: v5
            for v21, v22 in v5.Charge.Ball:GetDescendants() do
                if v22:IsA("ParticleEmitter") then
                    v22.Enabled = false
                end
            end
        end
    }
    local v23 = {}
    local v24 = TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(1.3333333333333333, Enum.EasingStyle.Linear), 0)
    local v25 = TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear)
    v23[1] = v24
    v23[2] = TweenProperty("Lighting.CutsceneBlur.Size", v25, 20)
    v6[821] = v23
    local v26 = {}
    local v27 = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(1.9833333333333334, Enum.EasingStyle.Linear), 30)
    local v28 = TweenInfo.new(1.2, Enum.EasingStyle.Linear)
    v26[1] = v27
    v26[2] = TweenProperty("Lighting.CutsceneBlur.Size", v28, 4)
    v6[822] = v26
    local v29 = {}
    v29[1] = TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.26666666666666666, Enum.EasingStyle.Linear), 0.5)
    v6[917] = v29
    local v30 = {}
    v30[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.15, Enum.EasingStyle.Linear), 15)
    v6[930] = v30
    local v31 = {}
    v31[1] = TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), 1)
    v6[933] = v31
    local v32 = {}
    v32[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.4, Enum.EasingStyle.Linear), 2)
    v6[939] = v32
    local v33 = {}
    v33[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.7833333333333333, Enum.EasingStyle.Linear), 25)
    v6[941] = v33
    local v34 = {}
    local v35 = TweenProperty("Workspace.__OBJECTS.Build.1.BOTTOMS.Footprint.Meshes/untitled2 (1).CFrame", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), CFrame.new(3438.9807, 69.4803, -354.9071, -0.3907, 0, 0.9205, 0, 1, 0, -0.9205, 0, -0.3907))
    local v36 = TweenProperty("Workspace.__OBJECTS.Build.1.BOTTOMS.Footprint.FogMesh.CFrame", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), CFrame.new(3438.9807, 69.2047, -354.9067, 0.5446, 0, -0.8387, 0, 1, 0, 0.8387, 0, 0.5446))
    v34[1] = v35
    v34[2] = v36
    v34[3] = SetProperty("Workspace.__OBJECTS.Build.1.BOTTOMS.Floor.Transparency", 1)
    v6[943] = v34
    v6[946] = {
        function() -- line 147 | captures: v5
            local function check(v37) -- line 149
                if v37 == nil then
                    return false
                end
                return v37 ~= 0
            end

            for v38, v39 in v5.Stomp:GetDescendants() do
                if v39:IsA("ParticleEmitter") then
                    local EmitCount = v39:GetAttribute("EmitCount")
                    local EmitDuration = v39:GetAttribute("EmitDuration")
                    if EmitCount ~= nil and EmitCount ~= 0 then
                        v39:Emit(EmitCount)
                    end
                    if EmitDuration ~= nil and EmitDuration ~= 0 then
                        v39.Enabled = true
                        local delay = task.delay
                        local v40 = v39
                        delay(EmitDuration, function() -- line 164 | captures: v40
                            v40.Enabled = false
                        end)
                    end
                end
            end
        end,
        function() -- line 171 | captures: v5
            for v41, v42 in v5.Decay:GetDescendants() do
                if v42:IsA("ParticleEmitter") then
                    v42.Enabled = true
                end
            end
        end
    }
    local v43 = {}
    v43[1] = TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(1.3833333333333333, Enum.EasingStyle.Linear), 1)
    v6[957] = v43
    v6[1200] = {}
    local v44 = {}
    v44[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.6833333333333333, Enum.EasingStyle.Linear), 50)
    v6[1380] = v44
    local v45 = {}
    v45[1] = TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.5, Enum.EasingStyle.Linear), 1)
    v6[1410] = v45
    local v46 = {}

    function v46.Run() -- line 193 | captures: v5, v3, SetProperty, LoadAnimationIntoRig, MakeFallbackCamera, DragonEggEventCutscene2, CutsceneUI, CutsceneMusic, Black, v6, ContentProvider, Debris, Lighting, ReplicatedStorage, RunService, TweenService, Workspace, BulkFade, CurrentCamera, LocalPlayer, restoreCamera
        Workspace.__OBJECTS.Build:WaitForChild("AAEventProps")
        task.wait()
        pcall(function() -- line 197 | captures: TweenService, Workspace
            task.spawn(function() -- line 198 | captures: TweenService, Workspace
                local DragonEggEventMusic = Workspace:FindFirstChild("DragonEggEventMusic")
                if DragonEggEventMusic then
                    local v47 = TweenInfo.new(1)
                    TweenService:Create(DragonEggEventMusic, v47, { Volume = 0 }):Play()
                end
            end)
        end)
        local v48 = {}
        for v49, v50 in script.LightingAssets:GetChildren() do
            local Name = v50.Name
            if not Lighting:FindFirstChild(Name) then
                local v51 = v50:Clone()
                v51.Parent = Lighting
                v3:Add(v51)
                table.insert(v48, v51)
            end
        end
        CutsceneUI.Enabled = true
        Black.BackgroundTransparency = 1
        Black.Visible = true
        local v52 = script.CutsceneVFX:Clone()
        v52.Parent = Workspace
        v5 = v52
        v3:Add(v52)
        local v53 = TweenInfo.new(0.1)
        TweenService:Create(Black, v53, { BackgroundTransparency = 0 }):Play()
        v3:Add(function() -- line 226 | captures: Black
            Black.BackgroundTransparency = 1
            Black.Visible = false
        end)
        local v54 = DragonEggEventCutscene2:Clone()
        for v55, v56 in v54:GetChildren() do
            if v56:IsA("Model") and v56.PrimaryPart then
                v56.PrimaryPart.Anchored = true
            end
        end
        v54.Parent = workspace
        v3:Add(v54)
        local v57 = {}
        for v58, v59 in v54:GetChildren() do
            local Animation = v59:FindFirstChildOfClass("Animation")
            if Animation then
                table.insert(v57, Animation)
            end
        end
        task.spawn(function() -- line 245 | captures: v57, ContentProvider
            pcall(ContentProvider.PreloadAsync, ContentProvider, v57)
        end)
        local v60 = {}
        for v61, v62 in v54:GetChildren() do
            local Animation = v62:FindFirstChildOfClass("Animation")
            if Animation then
                v60[v62] = LoadAnimationIntoRig(v62, Animation.AnimationId)
            end
        end
        local v63 = true
        v3:Add(function() -- line 254 | captures: v63
            v63 = false
        end)
        v3:Add(function() -- line 257 | captures: v63, restoreCamera
            if v63 then
                restoreCamera()
            end
        end)
        for v64, v65 in v60 do
            v65:Play(0)
        end
        local v66 = v60[v54["Camera Rig"]]
        assert(v66, "Camera Rig needs an Animation")
        local v67 = os.clock() + 3
        local v68
        while true do
            if v63 and not (v66.TimePosition > 0) and v66.IsPlaying then
                if v67 <= os.clock() then
                    warn("[CutscenePart2] Camera Rig animation never started, moving the camera without it")
                    v68 = true
                    break
                end
                RunService.RenderStepped:Wait()
                continue
            end
            v68 = false
            break
        end
        local Vignette = CutsceneUI.Vignette
        v3:Add(function() -- line 287 | captures: Vignette
            Vignette.Visible = false
            Vignette.ImageTransparency = 1
        end)
        CutsceneMusic:Play()
        local Cam = v54["Camera Rig"].Cam
        local v69 = v68 and MakeFallbackCamera(Cam, v54) or nil
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
        local v70 = v69 and v69(0, 24.666666666666668) or Cam.CFrame
        CurrentCamera.CFrame = v70
        local v71 = {}
        local v72 = 0
        local v73 = 0.1
        local v74 = RunService.Heartbeat:Connect(function(v75) -- line 302 | captures: v72, v73, v60, Cam, v69, v71, CutsceneMusic, v6, CurrentCamera
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
            local v76 = os.clock()
            local v77 = v69 and v69(v72, 24.666666666666668) or Cam.CFrame
            local new = CFrame.new
            local v78 = v76 * 0.7
            local v79 = math.sin(v78) * 0.35
            local v80 = v76 * 0.45
            CurrentCamera.CFrame = v77 * new(v79, math.sin(v80) * 0.2, 0)
            v72 += v75
            v73 -= 0.1
            if v73 <= 0 then
                v73 = 0.1
                for v81, v82 in v60 do
                    if v82.IsPlaying then
                        local v83 = v72 - v82.TimePosition
                        if math.abs(v83) >= 0.1 then
                            local xpcall_2 = xpcall
                            local v84 = v82
                            xpcall_2(function() -- line 319 | captures: v84, v72
                                v84.TimePosition = v72
                            end, warn)
                        end
                    end
                end
            end
            if CutsceneMusic.TimePosition < v72 - 0.001 then
                CutsceneMusic.PlaybackSpeed = 1.01
            else
                local v85 = v72 + 0.001
                if CutsceneMusic.TimePosition <= v85 then
                    CutsceneMusic.PlaybackSpeed = 1
                else
                    CutsceneMusic.PlaybackSpeed = 0.99
                end
            end
            for v86 = 0, 9 do
                local v87 = v72 * 60 - v86
                local v88 = math.floor(v87)
                if v6[v88] and not v71[v88] then
                    v71[v88] = true
                    for v89, v90 in v6[v88] do
                        task.spawn(v90)
                    end
                end
            end
        end)
        v3:Add(v74)
        task.wait(24.666666666666668)
        v74:Disconnect()
        xpcall(function() -- line 351 | captures: v52
            v52:Destroy()
        end, warn)
        Vignette.Visible = false
        xpcall(function() -- line 355 | captures: v48
            for v91, v92 in v48 do
                v92:Destroy()
            end
        end, warn)
        xpcall(function() -- line 363 | captures: v54
            v54:Destroy()
        end, warn)
        pcall(function() -- line 366 | captures: TweenService, Workspace
            task.spawn(function() -- line 367 | captures: TweenService, Workspace
                local DragonEggEventMusic = Workspace:FindFirstChild("DragonEggEventMusic")
                if DragonEggEventMusic then
                    local v93 = TweenInfo.new(1)
                    TweenService:Create(DragonEggEventMusic, v93, { Volume = 0.5 }):Play()
                end
            end)
        end)
        local MonstersAreComing = CutsceneUI.MonstersAreComing
        local v94 = BulkFade.new(MonstersAreComing, TweenInfo.new(1))
        v94:FadeOutInstant()
        task.wait()
        v94:FadeIn()
        CutsceneUI.MonstersAreComing.Visible = true
        task.spawn(function() -- line 382 | captures: CutsceneUI
            local function toDHMS(v95) -- line 384
                return string.format("%02i:%02i:%02i:%02i", v95 / 86400, v95 / 3600 % 24, v95 / 60 % 60, v95 % 60)
            end

            script.Roar:Play()
            local v96 = 604799
            while CutsceneUI.MonstersAreComing.Visible do
                CutsceneUI.MonstersAreComing.TimeRemaining.Text = string.format("%02i:%02i:%02i:%02i", v96 / 86400, v96 / 3600 % 24, v96 / 60 % 60, v96 % 60)
                script.ClockTick:Play()
                task.wait(1)
                v96 -= 1
            end
        end)
        task.wait(5)
        local v97 = ReplicatedStorage.CutsceneAssets.DragonEggEventRareEgg:Clone()
        for v98, v99 in v97:GetDescendants() do
            if v99:IsA("BasePart") then
                v99.Anchored = true
            end
        end
        v3:Add(v97)
        Debris:AddItem(v97, 20)
        v97.Parent = Workspace
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
        CurrentCamera.CFrame = CFrame.lookAt(Vector3.new(3307, 100, -341), v97:GetPivot().Position)
        CurrentCamera.FieldOfView = 40
        local v100 = TweenInfo.new(1)
        TweenService:Create(Black, v100, { BackgroundTransparency = 1 }):Play()
        v94:FadeOut()
        pcall(function() -- line 413 | captures: Workspace
            Workspace.__OBJECTS.Build["1"].BOTTOMS.Floor.Transparency = 0
            Workspace.__OBJECTS.Build["1"].BOTTOMS.Footprint["Meshes/untitled2 (1)"].Position = Vector3.new(0, 0, 0)
            Workspace.__OBJECTS.Build["1"].BOTTOMS.Footprint.FogMesh.Position = Vector3.new(0, 0, 0)
        end)
        pcall(function() -- line 419 | captures: SetProperty
            SetProperty("Workspace.__OBJECTS.Build.1.BOTTOMS.Footprint.Meshes/untitled2 (1).Position", (Vector3.new(0, 0, 0)))()
            SetProperty("Workspace.__OBJECTS.Build.1.BOTTOMS.Footprint.FogMesh.Position", (Vector3.new(0, 0, 0)))()
        end)
        local v101 = TweenInfo.new(4.5)
        TweenService:Create(CurrentCamera, v101, { FieldOfView = 35 }):Play()
        task.wait(1)
        Black.Visible = false
        CutsceneUI.MonstersAreComing.Visible = false
        task.wait(5)
        local Character = LocalPlayer.Character
        if Character then
            Character:FindFirstChild("HumanoidRootPart")
        end
        local v102 = TweenInfo.new(5)
        TweenService:Create(CurrentCamera, v102, {
            FieldOfView = 70,
            CFrame = CFrame.lookAt(Vector3.new(485, 100.5, -365), (Vector3.new(515, 80.5, -365)))
        }):Play()
        task.wait(5)
        xpcall(restoreCamera, warn)
        xpcall(function() -- line 437 | captures: Workspace
            Workspace.__OBJECTS.Build["1"].BOTTOMS.Floor.Transparency = 0
        end, warn)
        pcall(function() -- line 440 | captures: v97
            v97:Destroy()
        end)
    end

    return v46
end
