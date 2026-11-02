-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ContentProvider = game:GetService("ContentProvider")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local CutsceneHelperFunctions = require(script.Parent.Parent.Parent.CutsceneHelperFunctions)
require(ReplicatedStorage.Packages.Trove)
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local function restoreCamera() -- line 17 | captures: TweenService, CurrentCamera, LocalPlayer
    local v1 = TweenInfo.new(0)
    TweenService:Create(CurrentCamera, v1, { FieldOfView = 70 }):Play()
    CurrentCamera.FieldOfView = 70
    CurrentCamera.CameraType = Enum.CameraType.Custom
    local v2 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
    CurrentCamera.CameraSubject = v2
    LocalPlayer.ReplicationFocus = nil
end

local function cloneCharacterRig(v3) -- line 35 | captures: LocalPlayer
    local Character = LocalPlayer.Character
    local v4 = Character and Character:FindFirstChildOfClass("Humanoid")
    if Character ~= nil and v4 ~= nil and Character.PrimaryPart ~= nil then
        local Archivable = Character.Archivable
        Character.Archivable = true
        local v5 = Character:Clone()
        Character.Archivable = Archivable
        v5.Name = v3.Name
        for v6, v7 in ipairs(v5:GetChildren()) do
            if v7:IsA("LocalScript") then
                v7:Destroy()
            elseif v7:IsA("Script") or v7:IsA("Tool") then
            end
        end
        local Humanoid = v5:FindFirstChildOfClass("Humanoid")
        assert(Humanoid, "Cloned character lost its Humanoid")
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        if Humanoid:FindFirstChildOfClass("Animator") == nil then
            Instance.new("Animator").Parent = Humanoid
        end
        for v8, v9 in ipairs(v5:GetDescendants()) do
            if v9:IsA("BasePart") then
                v9.Anchored = v9 == v5.PrimaryPart
                v9.CanCollide = false
                v9.CanQuery = false
                v9.CanTouch = false
                v9.LocalTransparencyModifier = 0
            end
        end
        local Animation = v3:FindFirstChildOfClass("Animation")
        local v10 = ("%* needs an Animation child"):format(v3.Name)
        assert(Animation, v10)
        Animation:Clone().Parent = v5
        v5:PivotTo(v3:GetPivot())
        return v5
    end
    return nil
end

local function hideCharacter(v11) -- line 79 | captures: LocalPlayer
    local Character = LocalPlayer.Character
    if Character == nil then
        return function() -- line 82
        end
    end
    local v12 = {}
    for v13, v14 in ipairs(Character:GetDescendants()) do
        if v14:IsA("BasePart") then
            v12[v14] = v14.LocalTransparencyModifier
            v14.LocalTransparencyModifier = 1
        elseif v14:IsA("Decal") then
            v12[v14] = v14.Transparency
            v14.Transparency = 1
        end
    end

    local function restore() -- line 94 | captures: v12
        for v15, v16 in v12 do
            if v15.Parent then
                if v15:IsA("BasePart") then
                    v15.LocalTransparencyModifier = v16
                elseif v15:IsA("Decal") then
                    v15.Transparency = v16
                end
            end
        end
    end

    v11:Add(restore)
    return restore
end

return function(v17) -- line 111 | captures: ContentProvider, Lighting, ReplicatedStorage, RunService, TweenService, Workspace, CutsceneHelperFunctions, CurrentCamera, LocalPlayer, restoreCamera, hideCharacter
    local v18 = CutsceneHelperFunctions.GetHelperFunctions(v17)
    local SetProperty = v18.SetProperty
    local TweenProperty = v18.TweenProperty
    local LoadAnimationIntoRig = v18.LoadAnimationIntoRig
    local MakeFallbackCamera = v18.MakeFallbackCamera
    local DragonEggEventCutscene1 = ReplicatedStorage.CutsceneAssets.DragonEggEventCutscene1
    local CutsceneUI = LocalPlayer.PlayerGui.CutsceneUI
    local CutsceneMusic = script.CutsceneMusic
    local Black = CutsceneUI.Black
    local v19
    local v20 = {}
    local v21 = {}
    local v22 = SetProperty("Workspace.CurrentCamera.FieldOfView", 35)
    local v23 = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(1.2666666666666666, Enum.EasingStyle.Linear), 80.84581)
    local v24 = SetProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled2_Walls102.CFrame", CFrame.new(3526.5938, 86.4341, -373.0499, 0, 0, 1, 0, 1, -0, -1, 0, 0))
    local v25 = TweenProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled2_Walls102.CFrame", TweenInfo.new(5.35, Enum.EasingStyle.Linear), CFrame.new(3514.3865, 86.4341, -383.3008, 0.9781, 0, 0.2079, 0, 1, 0, -0.2079, 0, 0.9781))
    local v26 = SetProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls100 (2).CFrame", CFrame.new(3527.27, 90.0758, -374.963, -0, 0, 1, 0, 1, 0, -1, 0, -0))
    local v27 = TweenProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls100 (2).CFrame", TweenInfo.new(5.35, Enum.EasingStyle.Linear), CFrame.new(3516.3984, 90.0758, -383.037, 0.9781, 0, 0.2079, 0, 1, 0, -0.2079, 0, 0.9781))
    local v28 = SetProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls103.CFrame", CFrame.new(3526.6228, 84.8732, -373.5785, -0, 0, 1, 0, 1, 0, -1, 0, -0))
    local v29 = TweenProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls103.CFrame", TweenInfo.new(5.35, Enum.EasingStyle.Linear), CFrame.new(3514.9097, 84.8732, -383.3822, 0.9781, 0, 0.2079, 0, 1, 0, -0.2079, 0, 0.9781))
    local v30 = SetProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls104.CFrame", CFrame.new(3526.4937, 86.4515, -369.8316, -0, 0, 1, 0, 1, 0, -1, 0, -0))
    local v31 = TweenProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls104.CFrame", TweenInfo.new(5.35, Enum.EasingStyle.Linear), CFrame.new(3511.2178, 86.4515, -382.7296, 0.9781, 0, 0.2079, 0, 1, 0, -0.2079, 0, 0.9781))
    local v32 = SetProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls105.CFrame", CFrame.new(3526.3276, 86.4762, -364.6917, -0, 0, 1, 0, 1, 0, -1, 0, -0))
    local v33 = TweenProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls105.CFrame", TweenInfo.new(5.35, Enum.EasingStyle.Linear), CFrame.new(3506.1558, 86.4762, -381.8233, 0.9781, 0, 0.2079, 0, 1, 0, -0.2079, 0, 0.9781))
    local v34 = SetProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls106.CFrame", CFrame.new(3526.365, 88.1662, -374.3624, -0, 0, 1, 0, 1, 0, -1, 0, -0))
    local v35 = TweenProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls106.CFrame", TweenInfo.new(5.35, Enum.EasingStyle.Linear), CFrame.new(3515.6228, 88.1662, -383.7974, 0.9781, 0, 0.2079, 0, 1, 0, -0.2079, 0, 0.9781))
    local v36 = SetProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls107.CFrame", CFrame.new(3526.3193, 89.4656, -369.1417, -0, 0, 1, 0, 1, 0, -1, 0, -0))
    local v37 = TweenInfo.new(5.35, Enum.EasingStyle.Linear)
    v21[1] = v22
    v21[2] = v23
    v21[3] = v24
    v21[4] = v25
    v21[5] = v26
    v21[6] = v27
    v21[7] = v28
    v21[8] = v29
    v21[9] = v30
    v21[10] = v31
    v21[11] = v32
    v21[12] = v33
    v21[13] = v34
    v21[14] = v35
    v21[15] = v36
    v21[16] = TweenProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.LeftDoor.Meshes/untitled_Walls107.CFrame", v37, CFrame.new(3510.5066, 89.4656, -382.7566, 0.9781, 0, 0.2079, 0, 1, 0, -0.2079, 0, 0.9781))
    local v38 = SetProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.RightDoor.right1.CFrame", CFrame.new(3526.5938, 86.4341, -355.3767, 0, 0, 1, 0, 1, -0, -1, 0, 0))
    local v39 = TweenProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.RightDoor.right1.CFrame", TweenInfo.new(5.35, Enum.EasingStyle.Linear), CFrame.new(3514.4778, 86.4341, -345.5578, -0.9703, 0, 0.2419, 0, 1, 0, -0.2419, 0, -0.9703))
    local v40 = SetProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.RightDoor.right2.CFrame", CFrame.new(3527.27, 90.0758, -353.463, -0, 0, 1, 0, 1, 0, -1, 0, -0))
    local v41 = TweenProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.RightDoor.right2.CFrame", TweenInfo.new(5.35, Enum.EasingStyle.Linear), CFrame.new(3516.4983, 90.0758, -345.751, -0.9703, 0, 0.2419, 0, 1, 0, -0.2419, 0, -0.9703))
    local v42 = SetProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.RightDoor.right3.CFrame", CFrame.new(3526.6228, 84.8732, -354.8475, -0, 0, 1, 0, 1, 0, -1, 0, -0))
    local v43 = TweenProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.RightDoor.right3.CFrame", TweenInfo.new(5.35, Enum.EasingStyle.Linear), CFrame.new(3514.9985, 84.8732, -345.458, -0.9703, 0, 0.2419, 0, 1, 0, -0.2419, 0, -0.9703))
    local v44 = SetProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.RightDoor.right4.CFrame", CFrame.new(3526.4937, 86.4515, -358.5941, -0, 0, 1, 0, 1, 0, -1, 0, -0))
    local v45 = TweenProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.RightDoor.right4.CFrame", TweenInfo.new(5.35, Enum.EasingStyle.Linear), CFrame.new(3511.3318, 86.4515, -346.2393, -0.9703, 0, 0.2419, 0, 1, 0, -0.2419, 0, -0.9703))
    local v46 = SetProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.RightDoor.right5.CFrame", CFrame.new(3526.3276, 86.4762, -363.7342, -0, 0, 1, 0, 1, 0, -1, 0, -0))
    local v47 = TweenProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.RightDoor.right5.CFrame", TweenInfo.new(5.35, Enum.EasingStyle.Linear), CFrame.new(3506.3042, 86.4762, -347.3215, -0.9703, 0, 0.2419, 0, 1, 0, -0.2419, 0, -0.9703))
    local v48 = SetProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.RightDoor.right6.CFrame", CFrame.new(3526.365, 88.1662, -354.0636, -0, 0, 1, 0, 1, 0, -1, 0, -0))
    local v49 = TweenProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.RightDoor.right6.CFrame", TweenInfo.new(5.35, Enum.EasingStyle.Linear), CFrame.new(3515.6965, 88.1662, -345.0182, -0.9703, 0, 0.2419, 0, 1, 0, -0.2419, 0, -0.9703))
    local v50 = SetProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.RightDoor.right7.CFrame", CFrame.new(3526.3193, 89.4657, -359.2843, -0, 0, 1, 0, 1, 0, -1, 0, -0))
    local v51 = TweenProperty("Workspace.__OBJECTS.Build.AAEventProps.DragonCave.Door.RightDoor.right7.CFrame", TweenInfo.new(5.35, Enum.EasingStyle.Linear), CFrame.new(3510.6201, 89.4657, -346.237, -0.9703, 0, 0.2419, 0, 1, 0, -0.2419, 0, -0.9703))
    v21[17] = v38
    v21[18] = v39
    v21[19] = v40
    v21[20] = v41
    v21[21] = v42
    v21[22] = v43
    v21[23] = v44
    v21[24] = v45
    v21[25] = v46
    v21[26] = v47
    v21[27] = v48
    v21[28] = v49
    v21[29] = v50
    v21[30] = v51

    v21[31] = function() -- line 198 | captures: v19
        local function check(v52) -- line 200
            if v52 == nil then
                return false
            end
            return v52 ~= 0
        end

        for v53, v54 in v19.DoorOpenSmoke:GetDescendants() do
            if v54:IsA("ParticleEmitter") then
                local EmitCount = v54:GetAttribute("EmitCount")
                local EmitDuration = v54:GetAttribute("EmitDuration")
                if EmitCount ~= nil and EmitCount ~= 0 then
                    v54:Emit(EmitCount)
                end
                if EmitDuration ~= nil and EmitDuration ~= 0 then
                    v54.Enabled = true
                    local delay = task.delay
                    local v55 = v54
                    delay(EmitDuration, function() -- line 215 | captures: v55
                        v55.Enabled = false
                    end)
                end
            end
        end
    end

    v21[32] = SetProperty("Lighting.dragondepth.Enabled", false)
    v38 = SetProperty("Lighting.dragondepth.InFocusRadius", 20)
    v39 = SetProperty("Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.Enabled", false)
    v40 = SetProperty("Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.FillTransparency", 0.5)
    v41 = TweenProperty("Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.FillTransparency", TweenInfo.new(7.583333333333333, Enum.EasingStyle.Linear), 1)
    v42 = SetProperty("Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.OutlineTransparency", 0)
    v43 = TweenProperty("Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.OutlineTransparency", TweenInfo.new(7.583333333333333, Enum.EasingStyle.Linear), 1)
    v44 = SetProperty("Lighting.ThirdPoV.Enabled", false)
    v45 = SetProperty("Lighting.ThirdPoV.InFocusRadius", 50)
    v46 = SetProperty("Lighting.ThirdPoV.FocusDistance", 200)
    v47 = SetProperty("Lighting.1.Enabled", true)
    v48 = SetProperty("Lighting.1.InFocusRadius", 50)
    v49 = SetProperty("Lighting.1.FocusDistance", 25)
    v50 = SetProperty("Workspace.CutsceneVFX.Fly.CFrame", CFrame.new(3632.9419, 20.3041, -371.646, -0.1736, 0, 0.9848, 0, 1, 0, -0.9848, 0, -0.1736))
    v51 = SetProperty("Workspace.CutsceneVFX.Charge.CFrame", CFrame.new(3407.4592, 101.738, -375.0436, 1, 0, 0, 0, 1, 0, 0, 0, 1))
    local v56 = SetProperty("Workspace.CutsceneVFX.Wave.CFrame", CFrame.new(3395.644, -3.5316, -364.8042, 1, 0, 0, 0, 1, 0, 0, 0, 1))
    v21[33] = v38
    v21[34] = v39
    v21[35] = v40
    v21[36] = v41
    v21[37] = v42
    v21[38] = v43
    v21[39] = v44
    v21[40] = v45
    v21[41] = v46
    v21[42] = v47
    v21[43] = v48
    v21[44] = v49
    v21[45] = v50
    v21[46] = v51
    v21[47] = v56
    v21[48] = SetProperty("Lighting.CutsceneBlur.Enabled", true)
    v38 = SetProperty("Lighting.CutsceneBlur.Size", 2)
    v39 = SetProperty("Lighting.BLACK.Enabled", false)
    v40 = SetProperty("Lighting.WHITE.Enabled", false)
    v41 = SetProperty("Lighting.Black+White.Enabled", false)
    v42 = SetProperty("Lighting.White+Black.Enabled", false)
    v43 = SetProperty("Lighting.red.Enabled", false)
    v44 = SetProperty("Lighting.Whitered.Enabled", false)
    v45 = SetProperty("Lighting.Whitered.Saturation", -1.1)
    v46 = TweenProperty("Lighting.Whitered.Saturation", TweenInfo.new(49.38333333333333, Enum.EasingStyle.Linear), 0)
    v47 = SetProperty("Lighting.Whitered.Contrast", -1000000)
    v48 = TweenProperty("Lighting.Whitered.Contrast", TweenInfo.new(49.38333333333333, Enum.EasingStyle.Linear), 0)
    v49 = SetProperty("Lighting.Whitered.TintColor", Color3.new(1, 1, 1))
    v21[49] = v38
    v21[50] = v39
    v21[51] = v40
    v21[52] = v41
    v21[53] = v42
    v21[54] = v43
    v21[55] = v44
    v21[56] = v45
    v21[57] = v46
    v21[58] = v47
    v21[59] = v48
    v21[60] = v49
    v21[61] = SetProperty("Lighting.Whitered.Brightness", 0)
    v20[0] = v21
    v38 = {}
    v38[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 80.64736)
    v20[76] = v38
    v38 = {}
    v38[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 80.46038)
    v20[82] = v38
    v38 = {}
    v38[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 80.22632)
    v20[88] = v38
    v38 = {}
    v38[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 79.80621)
    v20[94] = v38
    v38 = {}
    v38[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 78.99367)
    v20[100] = v38
    v38 = {}
    v38[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 77.62277)
    v20[106] = v38
    v38 = {}
    v38[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 75.68993)
    v20[112] = v38
    v38 = {}
    v38[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 73.3545)
    v20[118] = v38
    v38 = {}
    v38[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 70.81742)
    v20[124] = v38
    v38 = {}
    v38[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 68.21306)
    v20[130] = v38
    v38 = {}
    v38[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 65.59524)
    v20[136] = v38
    v38 = {}
    v38[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(1.2, Enum.EasingStyle.Linear), 34.16667)
    v20[142] = v38
    v38 = {}
    v38[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 31.56664)
    v20[214] = v38
    v38 = {}
    v38[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 29.09974)
    v20[220] = v38
    v38 = {}
    v38[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 27.03225)
    v20[226] = v38
    v38 = {}
    v38[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 25.63041)
    v20[232] = v38
    v38 = {}
    v38[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.05, Enum.EasingStyle.Linear), 25.26233)
    v20[238] = v38
    v38 = {}
    v38[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 24.72586)
    v20[241] = v38
    v38 = {}
    v38[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 24.47468)
    v20[247] = v38
    v38 = {}
    v38[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.05, Enum.EasingStyle.Linear), 24.3586)
    v20[253] = v38
    v38 = {}
    v38[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.05, Enum.EasingStyle.Linear), 24.26451)
    v20[256] = v38
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 24.07752)
    v20[259] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 23.94988)
    v20[265] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 23.84164)
    v20[271] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 23.7417)
    v20[277] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), 23.61215)
    v20[283] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 23.50904)
    v20[291] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.05, Enum.EasingStyle.Linear), 23.45451)
    v20[297] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.05, Enum.EasingStyle.Linear), 23.39405)
    v20[300] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 23.16991)
    v20[303] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 22.78801)
    v20[309] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 22.7113)
    v20[315] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.05, Enum.EasingStyle.Linear), 22.47363)
    v20[316] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Linear), 21.96249)
    v20[319] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear), 21.60656)
    v20[325] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.3, Enum.EasingStyle.Linear), 20)
    v20[329] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(1.4166666666666667, Enum.EasingStyle.Back, Enum.EasingDirection.In), 15.9003)
    v20[365] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.In), 13.47454)
    v20[450] = v21
    v21 = {}
    local v57 = SetProperty("Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.Enabled", true)
    local v58 = TweenProperty("Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.FillTransparency", TweenInfo.new(0.15, Enum.EasingStyle.Linear), 0.4)
    local v59 = TweenInfo.new(0.15, Enum.EasingStyle.Linear)
    v21[1] = v57
    v21[2] = v58
    v21[3] = TweenProperty("Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.OutlineTransparency", v59, 0)
    v20[455] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.05, Enum.EasingStyle.Back, Enum.EasingDirection.In), 12.3416)
    v20[456] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.05, Enum.EasingStyle.Back, Enum.EasingDirection.In), 11.20867)
    v20[459] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.05, Enum.EasingStyle.Back, Enum.EasingDirection.In), 10.54439)
    v20[462] = v21
    v21 = {}
    v57 = TweenProperty("Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.FillTransparency", TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear), 1)
    v58 = TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear)

    v21[1] = function() -- line 461 | captures: v19
        local function check(v60) -- line 463
            if v60 == nil then
                return false
            end
            return v60 ~= 0
        end

        for v61, v62 in v19.Shimmer:GetDescendants() do
            if v62:IsA("ParticleEmitter") then
                local EmitCount = v62:GetAttribute("EmitCount")
                local EmitDuration = v62:GetAttribute("EmitDuration")
                if EmitCount ~= nil and EmitCount ~= 0 then
                    v62:Emit(EmitCount)
                end
                if EmitDuration ~= nil and EmitDuration ~= 0 then
                    v62.Enabled = true
                    local delay = task.delay
                    local v63 = v62
                    delay(EmitDuration, function() -- line 478 | captures: v63
                        v63.Enabled = false
                    end)
                end
            end
        end
    end

    v21[2] = v57
    v21[3] = TweenProperty("Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.OutlineTransparency", v58, 1)
    v20[464] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.In), 9.65424)
    v20[465] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.05, Enum.EasingStyle.Back, Enum.EasingDirection.In), 9.47588)
    v20[471] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.In), 9.19042)
    v20[474] = v21
    v20[477] = { SetProperty("Workspace.DragonEggEventCutscene1.cutscene1egg.Highlight.Enabled", false) }
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.In), 9)
    v20[480] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), 8)
    v20[486] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Back, Enum.EasingDirection.In), 40)
    v20[522] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(2.216666666666667, Enum.EasingStyle.Back, Enum.EasingDirection.In), 45)
    v20[523] = v21
    v20[670] = {
        function() -- line 518 | captures: v19
            local ZZZ = v19:WaitForChild("ZZZ")
            for v64, v65 in ipairs(ZZZ:GetChildren()) do
                if v65:IsA("ParticleEmitter") then
                    v65.Enabled = true
                end
            end
        end
    }
    v20[721] = { SetProperty("Lighting.ThirdPoV.Enabled", true) }
    v21 = {}
    v21[1] = TweenProperty("Lighting.ThirdPoV.FocusDistance", TweenInfo.new(0.38333333333333336, Enum.EasingStyle.Linear), 0)
    v20[780] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Back, Enum.EasingDirection.In), 25)
    v20[858] = v21
    v20[859] = { SetProperty("Lighting.ThirdPoV.Enabled", false) }
    v21 = {}
    v21[1] = SetProperty("Lighting.dragondepth.Enabled", true)
    v21[2] = SetProperty("Lighting.1.Enabled", false)
    v20[1264] = v21
    v21 = {}
    v21[1] = TweenProperty("Lighting.dragondepth.InFocusRadius", TweenInfo.new(2.033333333333333, Enum.EasingStyle.Linear), 13)
    v20[1376] = v21
    v20[1571] = {
        function() -- line 547 | captures: v19
            local function check(v66) -- line 549
                if v66 == nil then
                    return false
                end
                return v66 ~= 0
            end

            for v67, v68 in v19.Mud:GetDescendants() do
                if v68:IsA("ParticleEmitter") then
                    local EmitCount = v68:GetAttribute("EmitCount")
                    local EmitDuration = v68:GetAttribute("EmitDuration")
                    if EmitCount ~= nil and EmitCount ~= 0 then
                        v68:Emit(EmitCount)
                    end
                    if EmitDuration ~= nil and EmitDuration ~= 0 then
                        v68.Enabled = true
                        local delay = task.delay
                        local v69 = v68
                        delay(EmitDuration, function() -- line 564 | captures: v69
                            v69.Enabled = false
                        end)
                    end
                end
            end
        end
    }
    v21 = {}
    v21[1] = TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.9666666666666667, Enum.EasingStyle.Linear), 0.5)
    v20[1573] = v21
    v20[1576] = {
        function() -- line 577 | captures: v19
            local ZZZ = v19:WaitForChild("ZZZ")
            for v70, v71 in ipairs(ZZZ:GetChildren()) do
                if v71:IsA("ParticleEmitter") then
                    v71.Enabled = false
                end
            end
        end
    }
    v21 = {}
    v21[1] = TweenProperty("Lighting.dragondepth.InFocusRadius", TweenInfo.new(0.7166666666666667, Enum.EasingStyle.Linear), 50)
    v20[1590] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(3.533333333333333, Enum.EasingStyle.Back, Enum.EasingDirection.In), 40)
    v20[1686] = v21
    v21 = {}
    v21[1] = TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(1.5333333333333334, Enum.EasingStyle.Linear), 0)
    v20[1807] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Back, Enum.EasingDirection.In), 15)
    v20[1898] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(4.05, Enum.EasingStyle.Back, Enum.EasingDirection.In), 25)
    v20[1899] = v21
    v20[1929] = {
        function() -- line 607 | captures: v19
            local function check(v72) -- line 609
                if v72 == nil then
                    return false
                end
                return v72 ~= 0
            end

            for v73, v74 in v19.Takeoff:GetDescendants() do
                if v74:IsA("ParticleEmitter") then
                    local EmitCount = v74:GetAttribute("EmitCount")
                    local EmitDuration = v74:GetAttribute("EmitDuration")
                    if EmitCount ~= nil and EmitCount ~= 0 then
                        v74:Emit(EmitCount)
                    end
                    if EmitDuration ~= nil and EmitDuration ~= 0 then
                        v74.Enabled = true
                        local delay = task.delay
                        local v75 = v74
                        delay(EmitDuration, function() -- line 624 | captures: v75
                            v75.Enabled = false
                        end)
                    end
                end
            end
        end
    }
    v20[2120] = {
        function() -- line 633 | captures: v19
            local Fly = v19:WaitForChild("Fly")
            for v76, v77 in ipairs(Fly:GetDescendants()) do
                if v77:IsA("ParticleEmitter") then
                    v77.Enabled = true
                end
            end
        end
    }
    v21 = {}
    v21[1] = TweenProperty("Workspace.CutsceneVFX.Fly.CFrame", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), CFrame.new(3632.9526, 76.9216, -371.6479, -0.1736, 0, 0.9848, 0, 1, 0, -0.9848, 0, -0.1736))
    v20[2130] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CutsceneVFX.Fly.CFrame", TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear), CFrame.new(3610.0322, 76.9216, -367.6064, -0.1736, 0, 0.9848, 0, 1, 0, -0.9848, 0, -0.1736))
    v20[2131] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CutsceneVFX.Fly.CFrame", TweenInfo.new(0.05, Enum.EasingStyle.Linear), CFrame.new(3582.1382, 76.9216, -364.7979, -0.1736, 0, 0.9848, 0, 1, 0, -0.9848, 0, -0.1736))
    v21[2] = SetProperty("Lighting.White+Black.Enabled", true)
    v20[2135] = v21
    v21 = {}
    v21[1] = SetProperty("Lighting.Black+White.Enabled", true)
    v21[2] = SetProperty("Lighting.White+Black.Enabled", false)
    v20[2137] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CutsceneVFX.Fly.CFrame", TweenInfo.new(0.05, Enum.EasingStyle.Linear), CFrame.new(3554.259, 76.9216, -363.7752, -0.0367, 0, 0.9993, 0, 1, 0, -0.9993, 0, -0.0367))
    v20[2138] = v21
    v21 = {}
    v21[1] = SetProperty("Lighting.Black+White.Enabled", false)
    v21[2] = SetProperty("Lighting.red.Enabled", true)
    v20[2139] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CutsceneVFX.Fly.CFrame", TweenInfo.new(0.15, Enum.EasingStyle.Linear), CFrame.new(3535.5564, 76.9216, -363.0892, -0.0367, 0, 0.9993, 0, 1, 0, -0.9993, 0, -0.0367))
    v21[2] = SetProperty("Lighting.red.Enabled", false)
    v20[2141] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(2.466666666666667, Enum.EasingStyle.Back, Enum.EasingDirection.In), 22)

    v21[2] = function() -- line 680 | captures: v19
        local Fly = v19:WaitForChild("Fly")
        for v78, v79 in ipairs(Fly:GetDescendants()) do
            if v79:IsA("ParticleEmitter") then
                v79.Enabled = false
            end
        end
    end

    v20[2142] = v21
    v20[2181] = {
        function() -- line 690 | captures: v19
            local function check(v80) -- line 692
                if v80 == nil then
                    return false
                end
                return v80 ~= 0
            end

            for v81, v82 in v19.EggDrop:GetDescendants() do
                if v82:IsA("ParticleEmitter") then
                    local EmitCount = v82:GetAttribute("EmitCount")
                    local EmitDuration = v82:GetAttribute("EmitDuration")
                    if EmitCount ~= nil and EmitCount ~= 0 then
                        v82:Emit(EmitCount)
                    end
                    if EmitDuration ~= nil and EmitDuration ~= 0 then
                        v82.Enabled = true
                        local delay = task.delay
                        local v83 = v82
                        delay(EmitDuration, function() -- line 707 | captures: v83
                            v83.Enabled = false
                        end)
                    end
                end
            end
        end
    }
    v21 = {}
    v21[1] = TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(9.933333333333334, Enum.EasingStyle.Back, Enum.EasingDirection.In), 28)
    v20[2290] = v21
    v21 = {}
    v21[1] = TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.75, Enum.EasingStyle.Linear), 0.4)
    v20[2344] = v21
    v21 = {}
    v21[1] = TweenProperty("Lighting.dragondepth.InFocusRadius", TweenInfo.new(1, Enum.EasingStyle.Linear), 250)
    v20[2357] = v21
    v21 = {}
    v21[1] = TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(5.933333333333334, Enum.EasingStyle.Linear), 0.4)
    v20[2389] = v21
    v21 = {}
    v21[1] = TweenProperty("Lighting.dragondepth.InFocusRadius", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 20)
    v20[2417] = v21
    v21 = {}
    v21[1] = TweenProperty("Lighting.dragondepth.InFocusRadius", TweenInfo.new(1.2333333333333334, Enum.EasingStyle.Linear), 300)
    v20[2568] = v21
    v20[2635] = { SetProperty("Lighting.White+Black.Enabled", true) }
    v21 = {}
    v57 = SetProperty("Lighting.Black+White.Enabled", true)

    v21[1] = function() -- line 742 | captures: v19
        local Charge = v19:WaitForChild("Charge")
        for v84, v85 in ipairs(Charge:GetDescendants()) do
            if v85:IsA("ParticleEmitter") then
                v85.Enabled = true
            end
        end
    end

    v21[2] = v57
    v21[3] = SetProperty("Lighting.White+Black.Enabled", false)
    v20[2637] = v21
    v21 = {}
    v21[1] = SetProperty("Lighting.Black+White.Enabled", false)
    v21[2] = SetProperty("Lighting.White+Black.Enabled", true)
    v20[2639] = v21
    v21 = {}
    v21[1] = SetProperty("Lighting.White+Black.Enabled", false)
    v21[2] = SetProperty("Lighting.red.Enabled", true)
    v20[2641] = v21
    v20[2643] = { SetProperty("Lighting.red.Enabled", false) }
    v21 = {}
    v21[1] = TweenProperty("Workspace.CutsceneVFX.Charge.CFrame", TweenInfo.new(1.9666666666666666, Enum.EasingStyle.Linear), CFrame.new(3403.1526, 101.738, -375.0436, 1, 0, 0, 0, 1, 0, 0, 0, 1))
    v20[2647] = v21
    v21 = {}
    v21[1] = TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(1.4333333333333333, Enum.EasingStyle.Linear), 1)
    v20[2745] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CutsceneVFX.Wave.CFrame", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), CFrame.new(3395.645, 87.3247, -364.8042, 1, 0, 0, 0, 1, 0, 0, 0, 1))
    v20[2766] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CutsceneVFX.Wave.CFrame", TweenInfo.new(1.9833333333333334, Enum.EasingStyle.Linear), CFrame.new(3305.9136, 87.3247, -364.8042, 1, 0, 0, 0, 1, 0, 0, 0, 1))
    v20[2767] = v21
    v21 = {}
    v57 = TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0.5)
    v58 = TweenProperty("Workspace.CutsceneVFX.Wave.CFrame", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), CFrame.new(3459.4167, 87.3247, -358.4828, 1, 0, 0, 0, 1, 0, 0, 0, 1))
    v59 = TweenInfo.new(5.983333333333333, Enum.EasingStyle.Back, Enum.EasingDirection.In)

    v21[1] = function() -- line 786 | captures: v19
        local Charge = v19:WaitForChild("Charge")
        for v86, v87 in ipairs(Charge:GetDescendants()) do
            if v87:IsA("ParticleEmitter") then
                v87.Enabled = false
            end
        end
    end

    v21[2] = v57
    v21[3] = v58
    v21[4] = TweenProperty("Workspace.CurrentCamera.FieldOfView", v59, 15)
    v20[2886] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CutsceneVFX.Wave.CFrame", TweenInfo.new(1.5, Enum.EasingStyle.Linear), CFrame.new(3375.6699, 87.3247, -358.4828, 1, 0, 0, 0, 1, 0, 0, 0, 1))
    v20[2887] = v21
    v21 = {}
    v21[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.48333333333333334, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 10)
    v20[2948] = v21
    v21 = {}
    v57 = SetProperty("Lighting.Whitered.Enabled", true)
    v58 = TweenProperty("Lighting.Whitered.Saturation", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), -1.1)
    v59 = TweenProperty("Lighting.Whitered.Contrast", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), 25)
    local v88 = TweenProperty("Lighting.Whitered.TintColor", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), Color3.new(1, 0.173412, 0.0980392))
    local v89 = TweenInfo.new(0.1, Enum.EasingStyle.Linear)
    v21[1] = v57
    v21[2] = v58
    v21[3] = v59
    v21[4] = v88
    v21[5] = TweenProperty("Lighting.Whitered.Brightness", v89, 2)
    v20[2963] = v21
    v21 = {}
    v21[1] = TweenProperty("Lighting.Whitered.Brightness", TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), 15)
    v20[2969] = v21
    v21 = {}
    v57 = TweenProperty("Workspace.CutsceneVFX.Wave.CFrame", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), CFrame.new(2920.835, 87.3247, -358.4828, 1, 0, 0, 0, 1, 0, 0, 0, 1))
    v58 = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 2)
    v59 = TweenProperty("Lighting.Whitered.Saturation", TweenInfo.new(1.8, Enum.EasingStyle.Linear), 0)
    v88 = TweenProperty("Lighting.Whitered.Contrast", TweenInfo.new(1.8, Enum.EasingStyle.Linear), 0)
    v89 = TweenProperty("Lighting.Whitered.TintColor", TweenInfo.new(1.8, Enum.EasingStyle.Linear), Color3.new(1, 1, 1))
    local v90 = TweenInfo.new(1.8, Enum.EasingStyle.Linear)
    v21[1] = v57
    v21[2] = v58
    v21[3] = v59
    v21[4] = v88
    v21[5] = v89
    v21[6] = TweenProperty("Lighting.Whitered.Brightness", v90, 0)
    v20[2977] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CutsceneVFX.Wave.CFrame", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), CFrame.new(2920.835, 87.3247, -369.4669, 1, 0, 0, 0, 1, 0, 0, 0, 1))
    v21[2] = SetProperty("Lighting.Whitered.Enabled", false)
    v20[2978] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CutsceneVFX.Wave.CFrame", TweenInfo.new(2, Enum.EasingStyle.Linear), CFrame.new(2570.1248, 87.3247, -369.4669, 1, 0, 0, 0, 1, 0, 0, 0, 1))
    v20[2979] = v21
    v21 = {}
    v21[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.4666666666666667, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 10)
    v20[3071] = v21
    v21 = {}
    v57 = SetProperty("Lighting.Whitered.Enabled", true)
    v58 = TweenProperty("Lighting.Whitered.Saturation", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), -1.1)
    v59 = TweenProperty("Lighting.Whitered.Contrast", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), 25)
    v88 = TweenProperty("Lighting.Whitered.TintColor", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), Color3.new(1, 0.173412, 0.0980392))
    v89 = TweenInfo.new(0.1, Enum.EasingStyle.Linear)
    v21[1] = v57
    v21[2] = v58
    v21[3] = v59
    v21[4] = v88
    v21[5] = TweenProperty("Lighting.Whitered.Brightness", v89, 2)
    v20[3085] = v21
    v21 = {}
    v21[1] = TweenProperty("Lighting.Whitered.Brightness", TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), 15)
    v20[3091] = v21
    v21 = {}
    v57 = TweenProperty("Workspace.CutsceneVFX.Wave.CFrame", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), CFrame.new(2512.0125, 87.3247, -369.4669, 1, 0, 0, 0, 1, 0, 0, 0, 1))
    v58 = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 2)
    v59 = TweenProperty("Lighting.Whitered.Saturation", TweenInfo.new(2.1666666666666665, Enum.EasingStyle.Linear), 0)
    v88 = TweenProperty("Lighting.Whitered.Contrast", TweenInfo.new(2.1666666666666665, Enum.EasingStyle.Linear), 0)
    v89 = TweenProperty("Lighting.Whitered.TintColor", TweenInfo.new(2.1666666666666665, Enum.EasingStyle.Linear), Color3.new(1, 1, 1))
    v90 = TweenInfo.new(2.1666666666666665, Enum.EasingStyle.Linear)
    v21[1] = v57
    v21[2] = v58
    v21[3] = v59
    v21[4] = v88
    v21[5] = v89
    v21[6] = TweenProperty("Lighting.Whitered.Brightness", v90, 0)
    v20[3099] = v21
    v21 = {}
    v21[1] = TweenProperty("Workspace.CutsceneVFX.Wave.CFrame", TweenInfo.new(2.4, Enum.EasingStyle.Linear), CFrame.new(2172.207, 87.3247, -364.1021, 1, 0, 0, 0, 1, 0, 0, 0, 1))
    v21[2] = SetProperty("Lighting.Whitered.Enabled", false)
    v20[3100] = v21
    v21 = {}
    v21[1] = TweenProperty("Lighting.dragondepth.InFocusRadius", TweenInfo.new(1.9333333333333333, Enum.EasingStyle.Linear), 13)
    v20[3106] = v21
    v20[3200] = {
        function() -- line 907 | captures: Black, TweenService
            Black.Visible = true
            Black.BackgroundTransparency = 1
            local v91 = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
            TweenService:Create(Black, v91, { BackgroundTransparency = 0 }):Play()
            task.delay(2, function() -- line 912 | captures: Black, TweenService
                local v92 = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
                TweenService:Create(Black, v92, { BackgroundTransparency = 1 }):Play()
                task.wait(0.5)
                Black.Visible = false
            end)
        end
    }
    v21 = {}
    v57 = SetProperty("Lighting.Whitered.Enabled", true)
    v58 = TweenProperty("Lighting.Whitered.Saturation", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), -1.1)
    v59 = TweenProperty("Lighting.Whitered.Contrast", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), 25)
    v88 = TweenProperty("Lighting.Whitered.TintColor", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), Color3.new(1, 0.173412, 0.0980392))
    v89 = TweenInfo.new(0.1, Enum.EasingStyle.Linear)
    v21[1] = v57
    v21[2] = v58
    v21[3] = v59
    v21[4] = v88
    v21[5] = TweenProperty("Lighting.Whitered.Brightness", v89, 2)
    v20[3229] = v21
    v21 = {}
    v21[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 30)
    v20[3234] = v21
    v21 = {}
    v21[1] = TweenProperty("Lighting.Whitered.Brightness", TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), 15)
    v20[3235] = v21
    v57 = {}

    function v57.Run() -- line 944 | captures: v19, v17, LoadAnimationIntoRig, MakeFallbackCamera, DragonEggEventCutscene1, CutsceneUI, CutsceneMusic, Black, v20, ContentProvider, Lighting, RunService, TweenService, Workspace, CurrentCamera, restoreCamera, hideCharacter
        Workspace.__OBJECTS.Build:WaitForChild("AAEventProps")
        local v93 = {}
        for v94, v95 in script.LightingAssets:GetChildren() do
            local Name = v95.Name
            if not Lighting:FindFirstChild(Name) then
                local v96 = v95:Clone()
                v96.Parent = Lighting
                v17:Add(v96)
                table.insert(v93, v96)
            end
        end
        CutsceneUI.Enabled = true
        Black.BackgroundTransparency = 1
        Black.Visible = true
        local v97 = script.CutsceneVFX:Clone()
        v97.Parent = Workspace
        v19 = v97
        v17:Add(v97)
        local v98 = TweenInfo.new(0.1)
        local v99 = { BackgroundTransparency = 0 }
        TweenService:Create(Black, v98, v99):Play()
        v17:Add(function() -- line 967 | captures: Black
            Black.BackgroundTransparency = 1
            Black.Visible = false
        end)
        local v100 = DragonEggEventCutscene1:Clone()
        for v101, v102 in v100:GetChildren() do
            if v102:IsA("Model") and v102.PrimaryPart then
                v102.PrimaryPart.Anchored = true
            end
        end
        local v103 = hideCharacter(v17)
        v100.Parent = workspace
        v17:Add(v100)
        local v104 = {}
        for v105, v106 in v100:GetChildren() do
            local Animation = v106:FindFirstChildOfClass("Animation")
            if Animation then
                table.insert(v104, Animation)
            end
        end
        task.spawn(function() -- line 987 | captures: v104, ContentProvider
            pcall(ContentProvider.PreloadAsync, ContentProvider, v104)
        end)
        local v107 = {}
        for v108, v109 in v100:GetChildren() do
            local Animation = v109:FindFirstChildOfClass("Animation")
            if Animation then
                v107[v109] = LoadAnimationIntoRig(v109, Animation.AnimationId)
            end
        end
        local v110 = true
        v17:Add(function() -- line 996 | captures: v110
            v110 = false
        end)
        v17:Add(function() -- line 999 | captures: v110, restoreCamera
            if v110 then
                restoreCamera()
            end
        end)
        for v111, v112 in v107 do
            v112:Play(0)
        end
        local v113 = v107[v100["Camera Rig"]]
        assert(v113, "Camera Rig needs an Animation")
        local v114 = os.clock() + 3
        local v115
        while true do
            if v110 and not (v113.TimePosition > 0) and v113.IsPlaying then
                if v114 <= os.clock() then
                    warn("[CutscenePart1] Camera Rig animation never started, moving the camera without it")
                    v115 = true
                    break
                end
                RunService.RenderStepped:Wait()
                continue
            end
            v115 = false
            break
        end
        local Vignette = CutsceneUI.Vignette
        Vignette.Visible = true
        Vignette.ImageTransparency = 0.1
        local v116 = TweenInfo.new(10, Enum.EasingStyle.Linear)
        TweenService:Create(Vignette, v116, { ImageTransparency = 1 }):Play()
        task.delay(10, function() -- line 1036
        end)
        v17:Add(function() -- line 1037 | captures: Vignette
            Vignette.Visible = false
            Vignette.ImageTransparency = 1
        end)
        local v117 = TweenInfo.new(0.3)
        TweenService:Create(Black, v117, { BackgroundTransparency = 1 }):Play()
        task.delay(0.3, function() -- line 1043 | captures: Black
            Black.Visible = false
        end)
        CutsceneMusic:Play()
        local Cam = v100["Camera Rig"].Cam
        local v118 = v115 and MakeFallbackCamera(Cam, v100) or nil
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
        local v119 = v118 and v118(0, 55.083333333333336) or Cam.CFrame
        CurrentCamera.CFrame = v119
        local v120 = {}
        local v121 = 0
        local v122 = 0.1
        local v123 = RunService.Heartbeat:Connect(function(v124) -- line 1057 | captures: v121, v122, v107, Cam, v118, v120, CutsceneMusic, v20, CurrentCamera
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
            local v125 = os.clock()
            local v126 = v118 and v118(v121, 55.083333333333336) or Cam.CFrame
            local new = CFrame.new
            local v127 = v125 * 0.7
            local v128 = math.sin(v127) * 0.35
            local v129 = v125 * 0.45
            CurrentCamera.CFrame = v126 * new(v128, math.sin(v129) * 0.2, 0)
            v121 += v124
            v122 -= 0.1
            if v122 <= 0 then
                v122 = 0.1
                for v130, v131 in v107 do
                    if v131.IsPlaying then
                        local v132 = v121 - v131.TimePosition
                        if math.abs(v132) >= 0.1 then
                            local xpcall_2 = xpcall
                            local v133 = v131
                            xpcall_2(function() -- line 1074 | captures: v133, v121
                                v133.TimePosition = v121
                            end, warn)
                        end
                    end
                end
            end
            if CutsceneMusic.TimePosition < v121 - 0.001 then
                CutsceneMusic.PlaybackSpeed = 1.01
            else
                local v134 = v121 + 0.001
                if CutsceneMusic.TimePosition <= v134 then
                    CutsceneMusic.PlaybackSpeed = 1
                else
                    CutsceneMusic.PlaybackSpeed = 0.99
                end
            end
            for v135 = 0, 9 do
                local v136 = v121 * 60 - v135
                local v137 = math.floor(v136)
                if v20[v137] and not v120[v137] then
                    v120[v137] = true
                    for v138, v139 in v20[v137] do
                        task.spawn(v139)
                    end
                end
            end
        end)
        v17:Add(v123)
        task.wait(55.083333333333336)
        v123:Disconnect()
        xpcall(function() -- line 1106 | captures: v97
            v97:Destroy()
        end, warn)
        Vignette.Visible = false
        xpcall(function() -- line 1110 | captures: v93
            for v140, v141 in v93 do
                v141:Destroy()
            end
        end, warn)
        xpcall(function() -- line 1118 | captures: v100
            v100:Destroy()
        end, warn)
        xpcall(restoreCamera, warn)
        v103()
        pcall(function() -- line 1123 | captures: TweenService, Workspace
            task.spawn(function() -- line 1124 | captures: TweenService, Workspace
                local v142 = Workspace:WaitForChild("DragonEggEventMusic", 15)
                local v143 = TweenInfo.new(1)
                TweenService:Create(v142, v143, { Volume = 0.5 }):Play()
            end)
        end)
    end

    return v57
end
