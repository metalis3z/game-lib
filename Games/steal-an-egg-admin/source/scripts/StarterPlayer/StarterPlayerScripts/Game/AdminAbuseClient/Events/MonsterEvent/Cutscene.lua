-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ContentProvider = game:GetService("ContentProvider")
game:GetService("Debris")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
require(ReplicatedStorage.Client.Modules.BulkFade)
local CutsceneHelperFunctions = require(script.Parent.Parent.Parent.CutsceneHelperFunctions)
require(ReplicatedStorage.Packages.Trove)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local CurrentCamera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local v1, v2, v3, v4
local v5 = {
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.PlayerList,
    Enum.CoreGuiType.Health,
    Enum.CoreGuiType.EmotesMenu
}

local function restoreCamera() -- line 34 | captures: TweenService, CurrentCamera, LocalPlayer
    local v6 = TweenInfo.new(0)
    TweenService:Create(CurrentCamera, v6, { FieldOfView = 70 }):Play()
    CurrentCamera.FieldOfView = 70
    CurrentCamera.CameraType = Enum.CameraType.Custom
    local v7 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
    CurrentCamera.CameraSubject = v7
    LocalPlayer.ReplicationFocus = nil
end

local function hideAllUi() -- line 52 | captures: v2, v3, v4, StarterGui, Tabs, LocalPlayer, v5
    if v2 ~= nil then
        return
    end
    local v8 = {}
    v3 = Tabs.Current()
    for v9, v10 in LocalPlayer:WaitForChild("PlayerGui"):GetChildren() do
        if v10:IsA("ScreenGui") and v10.Name ~= "DragonCinematic" and v10.Enabled then
            v8[v10] = true
            v10.Enabled = false
        end
    end
    v2 = v8
    pcall(function() -- line 65 | captures: LocalPlayer
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = false
    end)
    local v11 = {}
    for v12, v13 in v5 do
        v11[v13] = StarterGui:GetCoreGuiEnabled(v13)
        StarterGui:SetCoreGuiEnabled(v13, false)
    end
    v4 = v11
end

local function restoreAllUi() -- line 78 | captures: v2, v3, v4, StarterGui, LocalPlayer
    local v14 = v2
    local v15 = v3
    v2 = nil
    v3 = nil
    if v14 ~= nil then
        for v16 in v14 do
            if v16.Parent ~= nil and v16.Name ~= v15 then
                v16.Enabled = true
            end
        end
    end
    pcall(function() -- line 94 | captures: LocalPlayer
        LocalPlayer.PlayerGui.BottomUI.BottomFrame.Holder.List.Visible = true
    end)
    local v17 = v4
    v4 = nil
    if v17 ~= nil then
        for v18, v19 in v17 do
            StarterGui:SetCoreGuiEnabled(v18, v19)
        end
    end
    return v15
end

local function hideCutsceneUi() -- line 109 | captures: v1, HiddenUIHandler, hideAllUi
    if v1 == nil then
        v1 = HiddenUIHandler.Acquire()
    end
    hideAllUi()
end

local function restoreCutsceneUi() -- line 115 | captures: v1, Tabs, restoreAllUi
    local v20 = restoreAllUi()
    local v21 = v1
    v1 = nil
    if v21 ~= nil then
        v21()
    end
    if v20 ~= nil then
        Tabs.Show(v20, true)
    end
end

local function setTransparency(v22, v23) -- line 126
    for v24, v25 in v22 do
        if v25:IsA("BasePart") then
            if not v25:GetAttribute("OriginalTransparency") then
                v25:SetAttribute("OriginalTransparency", v25.Transparency)
            end
            v25.Transparency = v23 or v25:GetAttribute("OriginalTransparency")
        end
    end
end

return function(v26) -- line 145 | captures: v1, ContentProvider, Lighting, ReplicatedStorage, RunService, TweenService, Workspace, CutsceneHelperFunctions, Tabs, Remotes, CurrentCamera, LocalPlayer, restoreCamera, restoreAllUi, hideCutsceneUi, setTransparency
    local v27 = CutsceneHelperFunctions.GetHelperFunctions(v26)
    local SetProperty = v27.SetProperty
    local TweenProperty = v27.TweenProperty
    local LoadAnimationIntoRig = v27.LoadAnimationIntoRig
    local MakeFallbackCamera = v27.MakeFallbackCamera
    local MonsterEventCutscene = ReplicatedStorage.CutsceneAssets.MonsterEventCutscene
    local CutsceneUI = LocalPlayer.PlayerGui.CutsceneUI
    local CutsceneMusic = script.CutsceneMusic
    local Black = CutsceneUI.Black
    local Vignette = CutsceneUI.Vignette
    local v28
    local v29 = {}
    local v30 = {}
    local v31 = SetProperty("Workspace.CurrentCamera.FieldOfView", 45)
    local v32 = SetProperty("Player.PlayerGui.CutsceneUI.Vignette.ImageColor3", Color3.new(0, 0, 0))
    local v33 = TweenProperty("Player.PlayerGui.CutsceneUI.Vignette.ImageColor3", TweenInfo.new(0.9666666666666667, Enum.EasingStyle.Linear), Color3.new(0.419608, 0.733246, 1))
    local v34 = SetProperty("Player.PlayerGui.CutsceneUI.Vignette.ImageTransparency", 0)
    local v35 = SetProperty("Lighting.Blizzard.Enabled", true)
    local v36 = SetProperty("Lighting.Blizzard.Saturation", 0.1)
    local v37 = SetProperty("Lighting.Blizzard.Contrast", -0.1)
    local v38 = SetProperty("Lighting.Blizzard.TintColor", Color3.new(0.811765, 0.94902, 0.988235))
    local v39 = SetProperty("Lighting.Blizzard.Brightness", 0.05)
    local v40 = SetProperty("Lighting.CutsceneBlur.Enabled", true)
    local v41 = SetProperty("Lighting.CutsceneBlur.Size", 25)
    local v42 = SetProperty("Player.PlayerGui.CutsceneUI.Black.BackgroundTransparency", 0)
    local v43 = TweenProperty("Player.PlayerGui.CutsceneUI.Black.BackgroundTransparency", TweenInfo.new(0.9666666666666667, Enum.EasingStyle.Linear), 1)
    local v44 = SetProperty("Lighting.EndDepth.Enabled", false)
    v30[1] = v31

    v30[2] = function() -- line 176 | captures: v28
        local ZZZ = v28:WaitForChild("ZZZ")
        for v45, v46 in ipairs(ZZZ:GetDescendants()) do
            if v46:IsA("ParticleEmitter") then
                v46.Enabled = true
            end
        end
    end

    v30[3] = v32
    v30[4] = v33
    v30[5] = v34
    v30[6] = v35
    v30[7] = v36
    v30[8] = v37
    v30[9] = v38
    v30[10] = v39
    v30[11] = v40
    v30[12] = v41
    v30[13] = v42
    v30[14] = v43
    v30[15] = v44
    v30[16] = SetProperty("Lighting.General.Enabled", true)
    local v47 = SetProperty("Lighting.Orange.Enabled", false)
    local v48 = SetProperty("Lighting.BlackOrange.Enabled", false)
    local v49 = SetProperty("Lighting.Purple.Enabled", false)
    local v50 = SetProperty("Lighting.BlackPurple.Enabled", false)
    local v51 = SetProperty("Lighting.Black+White.Enabled", false)
    v30[17] = v47
    v30[18] = v48
    v30[19] = v49
    v30[20] = v50
    v30[21] = v51
    v30[22] = SetProperty("Lighting.White+Black.Enabled", false)
    v29[0] = v30
    local v52 = {}
    v52[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.7666666666666667, Enum.EasingStyle.Linear), 2)
    v29[23] = v52
    v29[297] = {
        function() -- line 215 | captures: v28
            local ZZZ = v28:WaitForChild("ZZZ")
            for v53, v54 in ipairs(ZZZ:GetDescendants()) do
                if v54:IsA("ParticleEmitter") then
                    v54.Enabled = false
                end
            end
        end
    }
    local v55 = {}
    v55[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.31666666666666665, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 12)
    v29[300] = v55
    v29[311] = {
        function() -- line 229 | captures: v28
            local function check(v56) -- line 231
                if v56 == nil then
                    return false
                end
                return v56 ~= 0
            end

            for v57, v58 in v28.Exclaim:GetDescendants() do
                if v58:IsA("ParticleEmitter") then
                    local EmitCount = v58:GetAttribute("EmitCount")
                    local EmitDuration = v58:GetAttribute("EmitDuration")
                    if EmitCount ~= nil and EmitCount ~= 0 then
                        v58:Emit(EmitCount)
                    end
                    if EmitDuration ~= nil and EmitDuration ~= 0 then
                        v58.Enabled = true
                        local delay = task.delay
                        local v59 = v58
                        delay(EmitDuration, function() -- line 246 | captures: v59
                            v59.Enabled = false
                        end)
                    end
                end
            end
        end
    }
    local v60 = {}
    v60[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 2)
    v29[319] = v60
    local v61 = {}
    v61[1] = TweenProperty("Player.PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 1)
    v29[455] = v61
    local v62 = {}
    local v63 = TweenProperty("Player.PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0)
    local v64 = TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
    v62[1] = v63
    v62[2] = TweenProperty("Lighting.CutsceneBlur.Size", v64, 20)
    v29[596] = v62
    local v65 = {}
    v65[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 2)
    v29[597] = v65
    local v66 = {}
    v66[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 15)
    v29[627] = v66
    v29[631] = {
        function() -- line 278 | captures: v28
            local function check(v67) -- line 280
                if v67 == nil then
                    return false
                end
                return v67 ~= 0
            end

            for v68, v69 in pairs(v28.Land:GetDescendants()) do
                if v69:IsA("ParticleEmitter") then
                    local EmitCount = v69:GetAttribute("EmitCount")
                    local EmitDuration = v69:GetAttribute("EmitDuration")
                    if EmitCount ~= nil and EmitCount ~= 0 then
                        v69:Emit(EmitCount)
                    end
                    if EmitDuration ~= nil and EmitDuration ~= 0 then
                        v69.Enabled = true
                        local delay = task.delay
                        local v70 = v69
                        delay(EmitDuration, function() -- line 295 | captures: v70
                            v70.Enabled = false
                        end)
                    end
                end
            end
        end
    }
    local v71 = {}
    v71[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.0666666666666667, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 5)
    v29[645] = v71
    v29[781] = {
        function() -- line 308 | captures: v28
            local Roar = v28:WaitForChild("Roar")
            for v72, v73 in ipairs(Roar:GetDescendants()) do
                if v73:IsA("ParticleEmitter") then
                    v73.Enabled = true
                end
            end
        end
    }
    local v74 = {}
    v74[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 10)
    v29[783] = v74
    local v75 = {}
    v75[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 4)
    v29[815] = v75
    local v76 = {}
    v76[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 5)
    v29[819] = v76
    v29[825] = {
        function() -- line 330 | captures: v28
            local Roar = v28:WaitForChild("Roar")
            for v77, v78 in ipairs(Roar:GetDescendants()) do
                if v78:IsA("ParticleEmitter") then
                    v78.Enabled = false
                end
            end
        end
    }
    v29[827] = {
        function() -- line 340 | captures: v28
            local Scream = v28:WaitForChild("Scream")
            for v79, v80 in ipairs(Scream:GetDescendants()) do
                if v80:IsA("ParticleEmitter") then
                    v80.Enabled = true
                end
            end
        end
    }
    local v81 = {}
    local v82 = TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

    v81[1] = function() -- line 351 | captures: v28
        local Scream = v28:WaitForChild("Scream")
        for v83, v84 in ipairs(Scream:GetDescendants()) do
            if v84:IsA("ParticleEmitter") then
                v84.Enabled = false
            end
        end
    end

    v81[2] = TweenProperty("Lighting.CutsceneBlur.Size", v82, 15)
    v29[915] = v81
    local v85 = {}
    v85[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 5)
    v29[916] = v85
    v29[1362] = {
        function() -- line 366 | captures: v28
            local Roar2 = v28:WaitForChild("Roar2")
            for v86, v87 in ipairs(Roar2:GetDescendants()) do
                if v87:IsA("ParticleEmitter") then
                    v87.Enabled = true
                end
            end
        end
    }
    local v88 = {}
    v88[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 9)
    v29[1411] = v88
    v29[1413] = {
        function() -- line 380 | captures: v28
            local Roar2 = v28:WaitForChild("Roar2")
            for v89, v90 in ipairs(Roar2:GetDescendants()) do
                if v90:IsA("ParticleEmitter") then
                    v90.Enabled = false
                end
            end
        end
    }
    v29[1414] = {
        function() -- line 390 | captures: v28
            local TweenService = game:GetService("TweenService")
            local v91 = v28
            if v91 then
                local v92 = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

                local function halfTimeScale(v93) -- line 398 | captures: TweenService, v92
                    TweenService:Create(v93, v92, { TimeScale = v93.TimeScale / 3 }):Play()
                end

                for v94, v95 in ipairs(v91:GetDescendants()) do
                    if v95:IsA("ParticleEmitter") then
                        TweenService:Create(v95, v92, { TimeScale = v95.TimeScale / 3 }):Play()
                    end
                end
            else
                warn("cutsceneVFX folder not found!")
            end
        end
    }
    v29[1415] = {
        function() -- line 409 | captures: v28
            local function check(v96) -- line 411
                if v96 == nil then
                    return false
                end
                return v96 ~= 0
            end

            for v97, v98 in pairs(v28.Punches.FirstPunch:GetDescendants()) do
                if v98:IsA("ParticleEmitter") then
                    local EmitCount = v98:GetAttribute("EmitCount")
                    local EmitDuration = v98:GetAttribute("EmitDuration")
                    if EmitCount ~= nil and EmitCount ~= 0 then
                        v98:Emit(EmitCount)
                    end
                    if EmitDuration ~= nil and EmitDuration ~= 0 then
                        v98.Enabled = true
                        local delay = task.delay
                        local v99 = v98
                        delay(EmitDuration, function() -- line 426 | captures: v99
                            v99.Enabled = false
                        end)
                    end
                end
            end
        end
    }
    local v100 = {}
    v100[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.9666666666666667, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 5)
    v29[1418] = v100
    v29[1478] = { SetProperty("Lighting.General.Enabled", false) }
    v29[1479] = {
        function() -- line 440 | captures: v28
            local TweenService = game:GetService("TweenService")
            local v101 = v28
            if v101 then
                local v102 = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

                local function doubleTimeScale(v103) -- line 448 | captures: TweenService, v102
                    TweenService:Create(v103, v102, { TimeScale = v103.TimeScale * 3 }):Play()
                end

                for v104, v105 in ipairs(v101:GetDescendants()) do
                    if v105:IsA("ParticleEmitter") then
                        TweenService:Create(v105, v102, { TimeScale = v105.TimeScale * 3 }):Play()
                    end
                end
            else
                warn("cutsceneVFX folder not found!")
            end
        end
    }
    v29[1483] = { SetProperty("Lighting.EndDepth.Enabled", true) }
    v29[1488] = {
        function() -- line 460 | captures: v28
            local function check(v106) -- line 462
                if v106 == nil then
                    return false
                end
                return v106 ~= 0
            end

            for v107, v108 in pairs(v28.Smash:GetDescendants()) do
                if v108:IsA("ParticleEmitter") then
                    local EmitCount = v108:GetAttribute("EmitCount")
                    local EmitDuration = v108:GetAttribute("EmitDuration")
                    if EmitCount ~= nil and EmitCount ~= 0 then
                        v108:Emit(EmitCount)
                    end
                    if EmitDuration ~= nil and EmitDuration ~= 0 then
                        v108.Enabled = true
                        local delay = task.delay
                        local v109 = v108
                        delay(EmitDuration, function() -- line 477 | captures: v109
                            v109.Enabled = false
                        end)
                    end
                end
            end
        end
    }
    v29[1489] = {
        function() -- line 486 | captures: v28
            local function check(v110) -- line 488
                if v110 == nil then
                    return false
                end
                return v110 ~= 0
            end

            for v111, v112 in pairs(v28.Dust:GetDescendants()) do
                if v112:IsA("ParticleEmitter") then
                    local EmitCount = v112:GetAttribute("EmitCount")
                    local EmitDuration = v112:GetAttribute("EmitDuration")
                    if EmitCount ~= nil and EmitCount ~= 0 then
                        v112:Emit(EmitCount)
                    end
                    if EmitDuration ~= nil and EmitDuration ~= 0 then
                        v112.Enabled = true
                        local delay = task.delay
                        local v113 = v112
                        delay(EmitDuration, function() -- line 503 | captures: v113
                            v113.Enabled = false
                        end)
                    end
                end
            end
        end
    }
    local v114 = {}
    v114[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.4666666666666667, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 11)
    v29[1505] = v114
    local v115 = {}
    v115[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 5)
    v29[1533] = v115
    local v116 = {}
    local v117 = TweenProperty("Lighting.Blizzard.Saturation", TweenInfo.new(1.65, Enum.EasingStyle.Linear), 0)
    local v118 = TweenProperty("Lighting.Blizzard.Contrast", TweenInfo.new(1.65, Enum.EasingStyle.Linear), 0)
    local v119 = TweenProperty("Lighting.Blizzard.TintColor", TweenInfo.new(1.65, Enum.EasingStyle.Linear), Color3.new(0.988235, 0.988235, 0.988235))
    local v120 = TweenInfo.new(1.65, Enum.EasingStyle.Linear)
    v116[1] = v117
    v116[2] = v118
    v116[3] = v119
    v116[4] = TweenProperty("Lighting.Blizzard.Brightness", v120, 0)
    v29[1683] = v116
    local v121 = {}
    v121[1] = TweenProperty("Player.PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(1.5666666666666667, Enum.EasingStyle.Linear), 1)
    v29[1693] = v121
    local v122 = {}
    v122[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.8833333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 2)
    v29[1738] = v122
    v29[1782] = { SetProperty("Lighting.Blizzard.Enabled", false) }
    v29[1814] = { SetProperty("Lighting.White+Black.Enabled", true) }
    local v123 = {}
    local v124 = SetProperty("Lighting.BlackOrange.Enabled", true)

    v123[1] = function() -- line 544 | captures: v28
        local function check(v125) -- line 546
            if v125 == nil then
                return false
            end
            return v125 ~= 0
        end

        for v126, v127 in pairs(v28.Punches.Punch1:GetDescendants()) do
            if v127:IsA("ParticleEmitter") then
                local EmitCount = v127:GetAttribute("EmitCount")
                local EmitDuration = v127:GetAttribute("EmitDuration")
                if EmitCount ~= nil and EmitCount ~= 0 then
                    v127:Emit(EmitCount)
                end
                if EmitDuration ~= nil and EmitDuration ~= 0 then
                    v127.Enabled = true
                    local delay = task.delay
                    local v128 = v127
                    delay(EmitDuration, function() -- line 561 | captures: v128
                        v128.Enabled = false
                    end)
                end
            end
        end
    end

    v123[2] = v124
    v123[3] = SetProperty("Lighting.White+Black.Enabled", false)
    v29[1816] = v123
    local v129 = {}
    local v130 = SetProperty("Lighting.Orange.Enabled", true)

    v129[1] = function() -- line 573 | captures: v28
        local function check(v131) -- line 575
            if v131 == nil then
                return false
            end
            return v131 ~= 0
        end

        for v132, v133 in pairs(v28.Smoke:GetDescendants()) do
            if v133:IsA("ParticleEmitter") then
                local EmitCount = v133:GetAttribute("EmitCount")
                local EmitDuration = v133:GetAttribute("EmitDuration")
                if EmitCount ~= nil and EmitCount ~= 0 then
                    v133:Emit(EmitCount)
                end
                if EmitDuration ~= nil and EmitDuration ~= 0 then
                    v133.Enabled = true
                    local delay = task.delay
                    local v134 = v133
                    delay(EmitDuration, function() -- line 590 | captures: v134
                        v134.Enabled = false
                    end)
                end
            end
        end
    end

    v129[2] = v130
    v129[3] = SetProperty("Lighting.BlackOrange.Enabled", false)
    v29[1818] = v129
    v29[1820] = { SetProperty("Lighting.Orange.Enabled", false) }
    v29[1854] = {
        function() -- line 602 | captures: v28
            local function check(v135) -- line 604
                if v135 == nil then
                    return false
                end
                return v135 ~= 0
            end

            for v136, v137 in pairs(v28.Smoke2:GetDescendants()) do
                if v137:IsA("ParticleEmitter") then
                    local EmitCount = v137:GetAttribute("EmitCount")
                    local EmitDuration = v137:GetAttribute("EmitDuration")
                    if EmitCount ~= nil and EmitCount ~= 0 then
                        v137:Emit(EmitCount)
                    end
                    if EmitDuration ~= nil and EmitDuration ~= 0 then
                        v137.Enabled = true
                        local delay = task.delay
                        local v138 = v137
                        delay(EmitDuration, function() -- line 619 | captures: v138
                            v138.Enabled = false
                        end)
                    end
                end
            end
        end
    }
    v29[2033] = { SetProperty("Lighting.White+Black.Enabled", true) }
    v29[2034] = {
        function() -- line 629 | captures: v28
            local function check(v139) -- line 631
                if v139 == nil then
                    return false
                end
                return v139 ~= 0
            end

            for v140, v141 in pairs(v28.Punches.Punch2:GetDescendants()) do
                if v141:IsA("ParticleEmitter") then
                    local EmitCount = v141:GetAttribute("EmitCount")
                    local EmitDuration = v141:GetAttribute("EmitDuration")
                    if EmitCount ~= nil and EmitCount ~= 0 then
                        v141:Emit(EmitCount)
                    end
                    if EmitDuration ~= nil and EmitDuration ~= 0 then
                        v141.Enabled = true
                        local delay = task.delay
                        local v142 = v141
                        delay(EmitDuration, function() -- line 646 | captures: v142
                            v142.Enabled = false
                        end)
                    end
                end
            end
        end
    }
    local v143 = {}
    v143[1] = SetProperty("Lighting.BlackPurple.Enabled", true)
    v143[2] = SetProperty("Lighting.White+Black.Enabled", false)
    v29[2035] = v143
    local v144 = {}
    v144[1] = SetProperty("Lighting.Purple.Enabled", true)
    v144[2] = SetProperty("Lighting.BlackPurple.Enabled", false)
    v29[2037] = v144
    v29[2039] = { SetProperty("Lighting.Purple.Enabled", false) }
    v29[2041] = { SetProperty("Lighting.Black+White.Enabled", true) }
    v29[2043] = { SetProperty("Lighting.Black+White.Enabled", false) }
    v29[2052] = {
        function() -- line 668 | captures: v28
            local function check(v145) -- line 670
                if v145 == nil then
                    return false
                end
                return v145 ~= 0
            end

            for v146, v147 in pairs(v28.Smoke3:GetDescendants()) do
                if v147:IsA("ParticleEmitter") then
                    local EmitCount = v147:GetAttribute("EmitCount")
                    local EmitDuration = v147:GetAttribute("EmitDuration")
                    if EmitCount ~= nil and EmitCount ~= 0 then
                        v147:Emit(EmitCount)
                    end
                    if EmitDuration ~= nil and EmitDuration ~= 0 then
                        v147.Enabled = true
                        local delay = task.delay
                        local v148 = v147
                        delay(EmitDuration, function() -- line 685 | captures: v148
                            v148.Enabled = false
                        end)
                    end
                end
            end
        end
    }
    local v149 = {}
    v149[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 10)
    v29[2160] = v149
    v29[2161] = { SetProperty("Lighting.White+Black.Enabled", true) }
    local v150 = {}
    v150[1] = SetProperty("Lighting.Black+White.Enabled", true)
    v150[2] = SetProperty("Lighting.White+Black.Enabled", false)
    v29[2163] = v150
    v29[2165] = { SetProperty("Lighting.Black+White.Enabled", false) }
    v29[2166] = {
        function() -- line 705 | captures: v28
            local function check(v151) -- line 707
                if v151 == nil then
                    return false
                end
                return v151 ~= 0
            end

            for v152, v153 in pairs(v28.Punches.Punch3:GetDescendants()) do
                if v153:IsA("ParticleEmitter") then
                    local EmitCount = v153:GetAttribute("EmitCount")
                    local EmitDuration = v153:GetAttribute("EmitDuration")
                    if EmitCount ~= nil and EmitCount ~= 0 then
                        v153:Emit(EmitCount)
                    end
                    if EmitDuration ~= nil and EmitDuration ~= 0 then
                        v153.Enabled = true
                        local delay = task.delay
                        local v154 = v153
                        delay(EmitDuration, function() -- line 722 | captures: v154
                            v154.Enabled = false
                        end)
                    end
                end
            end
        end
    }
    v29[2167] = {
        function() -- line 731 | captures: v28
            local function check(v155) -- line 733
                if v155 == nil then
                    return false
                end
                return v155 ~= 0
            end

            for v156, v157 in pairs(v28.Punches.Stomp:GetDescendants()) do
                if v157:IsA("ParticleEmitter") then
                    local EmitCount = v157:GetAttribute("EmitCount")
                    local EmitDuration = v157:GetAttribute("EmitDuration")
                    if EmitCount ~= nil and EmitCount ~= 0 then
                        v157:Emit(EmitCount)
                    end
                    if EmitDuration ~= nil and EmitDuration ~= 0 then
                        v157.Enabled = true
                        local delay = task.delay
                        local v158 = v157
                        delay(EmitDuration, function() -- line 748 | captures: v158
                            v158.Enabled = false
                        end)
                    end
                end
            end
        end,
        SetProperty("Lighting.Orange.Enabled", true)
    }
    local v159 = {}
    v159[1] = SetProperty("Lighting.Orange.Enabled", false)
    v159[2] = SetProperty("Lighting.BlackOrange.Enabled", true)
    v29[2169] = v159
    local v160 = {}
    v160[1] = SetProperty("Lighting.BlackOrange.Enabled", false)
    v160[2] = SetProperty("Lighting.White+Black.Enabled", true)
    v29[2171] = v160
    v29[2173] = { SetProperty("Lighting.White+Black.Enabled", false) }
    v29[2175] = { SetProperty("Lighting.BlackOrange.Enabled", true) }
    v29[2177] = { SetProperty("Lighting.BlackOrange.Enabled", false) }
    local v161 = {}
    v161[1] = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.48333333333333334, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), 2)
    v29[2180] = v161
    local v162 = {}
    local v163 = TweenInfo.new(0.8333333333333334, Enum.EasingStyle.Linear)

    v162[1] = function() -- line 776 | captures: v28
        local function check(v164) -- line 778
            if v164 == nil then
                return false
            end
            return v164 ~= 0
        end

        for v165, v166 in pairs(v28.Smoke4:GetDescendants()) do
            if v166:IsA("ParticleEmitter") then
                local EmitCount = v166:GetAttribute("EmitCount")
                local EmitDuration = v166:GetAttribute("EmitDuration")
                if EmitCount ~= nil and EmitCount ~= 0 then
                    v166:Emit(EmitCount)
                end
                if EmitDuration ~= nil and EmitDuration ~= 0 then
                    v166.Enabled = true
                    local delay = task.delay
                    local v167 = v166
                    delay(EmitDuration, function() -- line 793 | captures: v167
                        v167.Enabled = false
                    end)
                end
            end
        end
    end

    v162[2] = TweenProperty("Player.PlayerGui.CutsceneUI.Black.BackgroundTransparency", v163, 0)
    v29[2183] = v162
    local v168 = {}

    function v168.Run() -- line 803 | captures: v28, v26, LoadAnimationIntoRig, MakeFallbackCamera, MonsterEventCutscene, CutsceneUI, CutsceneMusic, Black, Vignette, v29, v1, ContentProvider, Lighting, ReplicatedStorage, RunService, TweenService, Workspace, Tabs, Remotes, CurrentCamera, restoreCamera, restoreAllUi, hideCutsceneUi, setTransparency
        local v169 = false
        xpcall(hideCutsceneUi, warn)
        local MonsterEventMap = Workspace:FindFirstChild("MonsterEventMap")
        if MonsterEventMap then
            MonsterEventMap.WallStartVisual2.Transparency = 1
        end
        v26:Add(function() -- line 811 | captures: v169, v1, Tabs, restoreAllUi
            if v169 then
                return
            end
            local v170 = restoreAllUi()
            local v171 = v1
            v1 = nil
            if v171 ~= nil then
                v171()
            end
            if v170 ~= nil then
                Tabs.Show(v170, true)
            end
            v169 = true
        end)
        local AreaEggSlotsClient = Workspace:FindFirstChild("AreaEggSlotsClient")
        pcall(function() -- line 826 | captures: AreaEggSlotsClient, v26, ReplicatedStorage, Workspace
            AreaEggSlotsClient.Parent = ReplicatedStorage
            v26:Add(function() -- line 828 | captures: AreaEggSlotsClient, Workspace
                AreaEggSlotsClient.Parent = Workspace
            end)
        end)
        local v172 = game.Workspace.__OBJECTS.Areas.GuardAreas.Snow.Nests:GetDescendants()
        setTransparency(v172, 1)
        v26:Add(function() -- line 834 | captures: v172, setTransparency
            setTransparency(v172)
        end)
        pcall(function() -- line 837 | captures: TweenService, Workspace
            task.spawn(function() -- line 838 | captures: TweenService, Workspace
                local DragonEggEventMusic = Workspace:FindFirstChild("DragonEggEventMusic")
                if DragonEggEventMusic then
                    local v173 = TweenInfo.new(1)
                    TweenService:Create(DragonEggEventMusic, v173, { Volume = 0 }):Play()
                end
            end)
        end)
        local v174 = {}
        for v175, v176 in script.LightingAssets:GetChildren() do
            local Name = v176.Name
            if not Lighting:FindFirstChild(Name) then
                local v177 = v176:Clone()
                v177.Parent = Lighting
                v26:Add(v177)
                table.insert(v174, v177)
            end
        end
        CutsceneUI.Enabled = true
        Black.BackgroundTransparency = 1
        Black.Visible = true
        Vignette.Visible = true
        v26:Add(function() -- line 861 | captures: Vignette
            Vignette.Visible = false
            Vignette.ImageTransparency = 1
        end)
        local v178 = script.CutsceneVFX:Clone()
        v178.Parent = Workspace
        v28 = v178
        v26:Add(v178)
        local v179 = TweenInfo.new(0.1)
        TweenService:Create(Black, v179, { BackgroundTransparency = 0 }):Play()
        v26:Add(function() -- line 871 | captures: Black
            Black.BackgroundTransparency = 1
            Black.Visible = false
        end)
        local v180 = MonsterEventCutscene:Clone()
        for v181, v182 in v180:GetChildren() do
            if v182:IsA("Model") and v182.PrimaryPart then
                v182.PrimaryPart.Anchored = true
            end
        end
        v180.Parent = workspace
        v26:Add(v180)
        local v183 = {}
        for v184, v185 in v180:GetChildren() do
            local Animation = v185:FindFirstChildOfClass("Animation")
            if Animation then
                table.insert(v183, Animation)
            end
        end
        task.spawn(function() -- line 890 | captures: v183, ContentProvider
            pcall(ContentProvider.PreloadAsync, ContentProvider, v183)
        end)
        local v186 = {}
        for v187, v188 in v180:GetChildren() do
            local Animation = v188:FindFirstChildOfClass("Animation")
            if Animation then
                v186[v188] = LoadAnimationIntoRig(v188, Animation.AnimationId)
            end
        end
        local v189 = true
        v26:Add(function() -- line 899 | captures: v189
            v189 = false
        end)
        v26:Add(function() -- line 902 | captures: v189, restoreCamera
            if v189 then
                restoreCamera()
            end
        end)
        for v190, v191 in v186 do
            v191:Play(0)
        end
        local v192 = v186[v180["Camera Rig"]]
        assert(v192, "Camera Rig needs an Animation")
        local v193 = os.clock() + 3
        local v194
        while true do
            if v189 and not (v192.TimePosition > 0) and v192.IsPlaying then
                if v193 <= os.clock() then
                    warn("[MonsterEvent.Cutscene] Camera Rig animation never started, moving the camera without it")
                    v194 = true
                    break
                end
                RunService.RenderStepped:Wait()
                continue
            end
            v194 = false
            break
        end
        CutsceneMusic:Play()
        local Cam = v180["Camera Rig"].Cam
        local v195 = v194 and MakeFallbackCamera(Cam, v180) or nil
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
        local v196 = v195 and v195(0, 37.516666666666666) or Cam.CFrame
        CurrentCamera.CFrame = v196
        local v197 = {}
        local v198 = 0
        local v199 = 0.1
        local v200 = RunService.Heartbeat:Connect(function(v201) -- line 942 | captures: v198, v199, v186, Cam, v195, v197, CutsceneMusic, v29, CurrentCamera
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
            local v202 = os.clock()
            local v203 = v195 and v195(v198, 37.516666666666666) or Cam.CFrame
            local new = CFrame.new
            local v204 = v202 * 0.7
            local v205 = math.sin(v204) * 0.35
            local v206 = v202 * 0.45
            CurrentCamera.CFrame = v203 * new(v205, math.sin(v206) * 0.2, 0)
            v198 += v201
            v199 -= 0.1
            if v199 <= 0 then
                v199 = 0.1
                for v207, v208 in v186 do
                    if v208.IsPlaying then
                        local v209 = v198 - v208.TimePosition
                        if math.abs(v209) >= 0.1 then
                            local xpcall_2 = xpcall
                            local v210 = v208
                            xpcall_2(function() -- line 959 | captures: v210, v198
                                v210.TimePosition = v198
                            end, warn)
                        end
                    end
                end
            end
            if CutsceneMusic.TimePosition < v198 - 0.001 then
                CutsceneMusic.PlaybackSpeed = 1.01
            else
                local v211 = v198 + 0.001
                if CutsceneMusic.TimePosition <= v211 then
                    CutsceneMusic.PlaybackSpeed = 1
                else
                    CutsceneMusic.PlaybackSpeed = 0.99
                end
            end
            for v212 = 0, 9 do
                local v213 = v198 * 60 - v212
                local v214 = math.floor(v213)
                if v29[v214] and not v197[v214] then
                    v197[v214] = true
                    for v215, v216 in v29[v214] do
                        task.spawn(v216)
                    end
                end
            end
        end)
        v26:Add(v200)
        task.wait(37.516666666666666)
        v200:Disconnect()
        xpcall(function() -- line 991 | captures: v178
            v178:Destroy()
        end, warn)
        Vignette.Visible = false
        xpcall(function() -- line 995 | captures: v174
            for v217, v218 in v174 do
                v218:Destroy()
            end
        end, warn)
        xpcall(function() -- line 1003 | captures: v180
            v180:Destroy()
        end, warn)
        pcall(function() -- line 1006 | captures: TweenService, Workspace
            task.spawn(function() -- line 1007 | captures: TweenService, Workspace
                local DragonEggEventMusic = Workspace:FindFirstChild("DragonEggEventMusic")
                if DragonEggEventMusic then
                    local v219 = TweenInfo.new(1)
                    TweenService:Create(DragonEggEventMusic, v219, { Volume = 0.5 }):Play()
                end
            end)
        end)
        xpcall(restoreCamera, warn)
        local v220 = false
        task.spawn(function() -- line 1018 | captures: v220, Remotes
            Remotes.MonsterEvent.RequestTeleport:InvokeServer()
            v220 = true
        end)
        local v221 = 0
        while not v220 do
            if v221 >= 5 then
                break
            end
            v221 += task.wait()
        end
        local v222 = TweenInfo.new(0.5)
        TweenService:Create(Black, v222, { BackgroundTransparency = 1 }):Play()
        local MonsterEventMap_2 = Workspace:FindFirstChild("MonsterEventMap")
        if MonsterEventMap_2 then
            MonsterEventMap_2.WallStartVisual2.Transparency = 0
        end
        task.wait(0.5)
        Black.Visible = false
        Vignette.Visible = false
        pcall(function() -- line 1038 | captures: AreaEggSlotsClient, Workspace
            AreaEggSlotsClient.Parent = Workspace
        end)
        xpcall(function() -- line 1041 | captures: v169, v1, Tabs, restoreAllUi
            local v223 = restoreAllUi()
            local v224 = v1
            v1 = nil
            if v224 ~= nil then
                v224()
            end
            if v223 ~= nil then
                Tabs.Show(v223, true)
            end
            v169 = true
        end, warn)
        setTransparency(v172)
    end

    return v168
end
