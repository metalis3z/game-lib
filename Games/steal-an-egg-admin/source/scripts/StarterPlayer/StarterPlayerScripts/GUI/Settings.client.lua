-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local v1 = require(ReplicatedStorage.Packages.TopBarPlus).new()
v1:setName("Settings"):setImage(101403250204482):modifyTheme({
    "IconImage",
    "ScaleType",
    Enum.ScaleType.Fit
}):setImageScale(0.8)
v1:bindEvent("toggled", function() -- line 14 | captures: ReplicatedStorage
    local Audio = require(ReplicatedStorage.Shared.Audio)
    local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
    local Tabs = require(ReplicatedStorage.Client.Tabs)
    Audio.Play(Constants.BUTTON_FX.BUTTON_MOUSE_DOWN_SOUND, script, {
        Volume = 1.8,
        PlaybackSpeed = math.random(95, 105) / 100
    })
    Tabs.Toggle("Settings")
end)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local GUI = require(ReplicatedStorage.Client.GUI)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local SettingsCmds = require(ReplicatedStorage.Shared.SettingsCmds)
local TreadmillVideoGate = require(ReplicatedStorage.Client.TreadmillVideoGate)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local VolumePrefs = require(ReplicatedStorage.Client.VolumePrefs)
local v2 = UDim2.fromScale(0.75, 0.5)
local v3 = UDim2.fromScale(0.25, 0.5)
local v4 = Color3.fromRGB(212, 255, 0)
local v5 = ColorSequence.new(v4, Color3.fromRGB(0, 255, 8))
local v6 = Color3.fromRGB(255, 58, 61)
local v7 = ColorSequence.new(v6, Color3.fromRGB(255, 2, 6))
local v8 = {
    0.15,
    Enum.EasingStyle.Circular,
    Enum.EasingDirection.Out
}
HiddenUIHandler.Changed:Connect(function() -- line 35 | captures: v1, HiddenUIHandler
    v1:setEnabled(not HiddenUIHandler.IsHidden())
end)
v1:setEnabled(not HiddenUIHandler.IsHidden())
local ScrollingFrame = GUI.Settings().Frame.ScrollingFrame
local ScrollingFrame_2 = ScrollingFrame:IsA("ScrollingFrame")
assert(ScrollingFrame_2, "Settings scrolling frame must be a ScrollingFrame")
local v9 = {}
local v10 = {}
local v11
local v12 = {}

local function displayedState(v13, v14) -- line 46 | captures: SettingsCmds
    local v15 = SettingsCmds.Allows(v13)
    if v14 then
        return not v15
    end
    return v15
end

local function applyToggleVisuals(v16, v17, v18) -- line 53 | captures: Tween, v2, v3, v5, v7, v8
    local v19 = if v17 then "ON" else "OFF"
    v16.Status.Text = v19
    local v20 = if v17 then v5 else v7
    v16.KnobGradient.Color = v20
    local v21 = if v17 then v2 else v3
    if v18 then
        v16.Knob.Position = v21
    else
        Tween(v16.Knob, { Position = v21 }, v8)
    end
end

local function refreshToggle(v22) -- line 78 | captures: SettingsCmds, Tween, v2, v3, v5, v7, v8, v10
    local v23 = v10[v22]
    if not v23 then
        return
    end
    local v24 = SettingsCmds.Allows(v22)
    if v23.Inverted then
        v24 = not v24
    end
    local v25 = if v24 then "ON" else "OFF"
    v23.Status.Text = v25
    local v26 = if v24 then v5 else v7
    v23.KnobGradient.Color = v26
    local v27 = if v24 then v2 else v3
    Tween(v23.Knob, { Position = v27 }, v8)
end

local function attemptToggle(v28) -- line 108 | captures: SettingsCmds, Tween, v2, v3, v5, v7, v8, v9, v10
    if v9[v28] then
        return
    end
    v9[v28] = true
    local v29 = SettingsCmds.Flip(v28)
    v9[v28] = nil
    local v30, v31, v32
    if v29 then
        v32 = true
    else
        v30 = v10[v28]
        if v30 then
            v31 = SettingsCmds.Allows(v28)
            if v30.Inverted then
                v31 = not v31
            end
            v32 = false
        else
            v32 = true
        end
    end
    if v32 then
        return
    end
    local v33 = if v31 then "ON" else "OFF"
    v30.Status.Text = v33
    local v34 = if v31 then v5 else v7
    v30.KnobGradient.Color = v34
    local v35 = if v31 then v2 else v3
    Tween(v30.Knob, { Position = v35 }, v8)
end

local function registerToggleRow(v36, v37) -- line 146 | captures: ButtonFX, SettingsCmds, Tween, v2, v3, v5, v7, v8, ScrollingFrame, v9, v10
    local v38 = ScrollingFrame:FindFirstChild(v36)
    local v39
    if v38 and v38:IsA("GuiObject") then
        local ControlBar = v38:FindFirstChild("ControlBar")
        if ControlBar then
            v39 = ControlBar:FindFirstChild("Btn")
        end
    else
        return
    end
    local Description = v38:FindFirstChild("Description")
    if not (v39 and v39:IsA("ImageButton") and Description and Description:IsA("TextLabel")) then
        return
    end
    local UIGradient = v39:FindFirstChildOfClass("UIGradient")
    if not UIGradient then
        return
    end
    local v40 = {
        Row = v38,
        Knob = v39,
        KnobGradient = UIGradient,
        Status = Description,
        Inverted = v37
    }
    v10[v36] = v40
    ButtonFX(v39, nil, function() -- line 174 | captures: v36, SettingsCmds, Tween, v2, v3, v5, v7, v8, v9, v10
        if v9[v36] then
            return
        end
        v9[v36] = true
        local v41 = SettingsCmds.Flip(v36)
        v9[v36] = nil
        local v42, v43, v44
        if v41 then
            v44 = true
        else
            v42 = v10[v36]
            if v42 then
                v43 = SettingsCmds.Allows(v36)
                if v42.Inverted then
                    v43 = not v43
                end
                v44 = false
            else
                v44 = true
            end
        end
        if v44 then
            return
        end
        local v45 = if v43 then "ON" else "OFF"
        v42.Status.Text = v45
        local v46 = if v43 then v5 else v7
        v42.KnobGradient.Color = v46
        local v47 = if v43 then v2 else v3
        Tween(v42.Knob, { Position = v47 }, v8)
    end)
    local v48 = SettingsCmds.Allows(v36)
    if v37 then
        v48 = not v48
    end
    local v49 = if v48 then "ON" else "OFF"
    v40.Status.Text = v49
    local v50 = if v48 then v5 else v7
    v40.KnobGradient.Color = v50
    local v51 = if v48 then v2 else v3
    v40.Knob.Position = v51
end

local function applySliderVisuals(v52, v53) -- line 238
    v52.Fill.Size = UDim2.new(v53, 0, 1, 0)
    v52.Fill.Position = UDim2.new(v53 / 2, 0, 0.5, 0)
    v52.Stick.Position = UDim2.new(v53, 0, 0.4887853, 0)
end

local function settleSliderBoolean(v54, v55) -- line 243 | captures: SettingsCmds, Tween, v2, v3, v5, v7, v8, v9, v10
    local v56 = v55 > 0
    local v57 = false
    local v58 = false
    local v59 = false
    if SettingsCmds.Allows(v54) ~= v56 then
        v57 = true
    end
    if v57 and not v9[v54] then
        v58 = true
    end
    v57 = false
    if v58 then
        v9[v54] = true
        local v60 = SettingsCmds.Flip(v54)
        v9[v54] = nil
        if not v60 then
            v57 = true
        end
    end
    v58 = false
    local v61
    if v57 then
        v61 = v10[v54]
        if v61 then
            v58 = true
        end
    end
    v57 = false
    local v62
    if v58 then
        v62 = SettingsCmds.Allows(v54)
        if v61.Inverted then
            v59 = true
        else
            v57 = true
        end
    end
    v58 = false
    local v63
    if v57 then
        v63 = v62
        v58 = true
    end
    v57 = false
    if v59 then
        v63 = not v62
        v58 = true
    end
    v59 = false
    if v58 then
        if v63 then
            v57 = true
        else
            v59 = true
        end
    end
    v58 = false
    local v64
    if v59 then
        v64 = "OFF"
        v58 = true
    end
    v59 = false
    if v57 then
        v64 = "ON"
        v58 = true
    end
    v57 = false
    if v58 then
        v61.Status.Text = v64
        if v63 then
            v59 = true
        else
            v57 = true
        end
    end
    v58 = false
    local v65
    if v57 then
        v65 = v7
        v58 = true
    end
    v57 = false
    if v59 then
        v65 = v5
        v58 = true
    end
    v59 = false
    if v58 then
        v61.KnobGradient.Color = v65
        if v63 then
            v57 = true
        else
            v59 = true
        end
    end
    v58 = false
    local v66
    if v59 then
        v66 = v3
        v58 = true
    end
    if v57 then
        v66 = v2
        v58 = true
    end
    if v58 then
        Tween(v61.Knob, { Position = v66 }, v8)
    end
end

local function registerSliderRow(v67, v68) -- line 282 | captures: v11, UserInputService, SettingsCmds, Tween, VolumePrefs, v2, v3, v5, v7, v8, ScrollingFrame, v9, v10, applySliderVisuals
    local v69 = ScrollingFrame:FindFirstChild(v67)
    local ControlBar, v70
    if v69 and v69:IsA("GuiObject") then
        ControlBar = v69:FindFirstChild("ControlBar")
        if ControlBar then
            v70 = ControlBar:FindFirstChild("Fill")
        end
    else
        return
    end
    local v71, v72, v73
    if ControlBar then
        local v74 = ControlBar:FindFirstChild("Stick")
        if ControlBar:IsA("GuiObject") and v70 and v70:IsA("Frame") and v74 and v74:IsA("Frame") then
            v71 = {
                Row = v69,
                Bar = ControlBar,
                Fill = v70,
                Stick = v74,
                Category = v68
            }
            if SettingsCmds.Allows(v67) then
                v72 = VolumePrefs.Get(v68)
            else
                v72 = 0
            end
            v73 = false
        else
            v73 = true
        end
    else
        v73 = true
    end
    if v73 then
        return
    end
    applySliderVisuals(v71, v72)
    local v75 = false
    local v76, v77
    local ControlBar_2 = ControlBar

    local function levelFromX(v78) -- line 318 | captures: ControlBar_2
        local v79 = v78 - ControlBar_2.AbsolutePosition.X
        local X = ControlBar_2.AbsoluteSize.X
        local v80 = v79 / math.max(X, 1)
        return (math.clamp(v80, 0, 1))
    end

    local v81 = v71

    local function applyFromX(v82) -- line 322 | captures: v68, ControlBar_2, v81, VolumePrefs, applySliderVisuals
        local v83 = v82 - ControlBar_2.AbsolutePosition.X
        local X = ControlBar_2.AbsoluteSize.X
        local v84 = v83 / math.max(X, 1)
        local v85 = math.clamp(v84, 0, 1)
        applySliderVisuals(v81, v85)
        VolumePrefs.Set(v68, v85)
    end

    ControlBar.Active = true
    ControlBar.InputBegan:Connect(function(v86) -- line 329 | captures: v75, v76, v77, v68, ControlBar_2, v81, v11, VolumePrefs, applySliderVisuals
        if v86.UserInputType == Enum.UserInputType.MouseButton1 then
            v75 = true
            local v87 = v86.Position.X - ControlBar_2.AbsolutePosition.X
            local X = ControlBar_2.AbsoluteSize.X
            local v88 = v87 / math.max(X, 1)
            local v89 = math.clamp(v88, 0, 1)
            applySliderVisuals(v81, v89)
            VolumePrefs.Set(v68, v89)
        elseif v86.UserInputType == Enum.UserInputType.Touch and v11 == nil then
            v11 = v86
            v76 = v86
            v77 = Vector2.new(v86.Position.X, v86.Position.Y)
        end
    end)
    UserInputService.InputChanged:Connect(function(v90) -- line 344 | captures: v75, v76, v77, v68, ControlBar_2, v81, v11, VolumePrefs, applySliderVisuals
        if v75 then
            if v76 == nil and v90.UserInputType == Enum.UserInputType.MouseMovement then
                local v91 = v90.Position.X - ControlBar_2.AbsolutePosition.X
                local X = ControlBar_2.AbsoluteSize.X
                local v92 = v91 / math.max(X, 1)
                local v93 = math.clamp(v92, 0, 1)
                applySliderVisuals(v81, v93)
                VolumePrefs.Set(v68, v93)
            end
        elseif v90.UserInputType == Enum.UserInputType.Touch and v90 == v76 then
            local v94 = v77
            if v94 ~= nil then
                if v75 then
                    local v95 = v90.Position.X - ControlBar_2.AbsolutePosition.X
                    local X = ControlBar_2.AbsoluteSize.X
                    local v96 = v95 / math.max(X, 1)
                    local v97 = math.clamp(v96, 0, 1)
                    applySliderVisuals(v81, v97)
                    VolumePrefs.Set(v68, v97)
                else
                    local v98 = Vector2.new(v90.Position.X, v90.Position.Y) - v94
                    if not (v98.Magnitude < 8) then
                        local Y = v98.Y
                        local v99 = math.abs(Y)
                        local X = v98.X
                        if math.abs(X) <= v99 then
                            v11 = nil
                            v76 = nil
                            v77 = nil
                        else
                            v75 = true
                            local v100 = v90.Position.X - ControlBar_2.AbsolutePosition.X
                            local X = ControlBar_2.AbsoluteSize.X
                            local v101 = v100 / math.max(X, 1)
                            local v102 = math.clamp(v101, 0, 1)
                            applySliderVisuals(v81, v102)
                            VolumePrefs.Set(v68, v102)
                        end
                    end
                end
            end
        end
    end)
    UserInputService.InputEnded:Connect(function(v103) -- line 387 | captures: v75, v76, v77, v67, v68, ControlBar_2, v81, v11, SettingsCmds, Tween, VolumePrefs, v2, v3, v5, v7, v8, v9, v10, applySliderVisuals
        if v75 then
            local v104, v105
            if v76 == nil and v103.UserInputType == Enum.UserInputType.MouseButton1 then
                v75 = false
                v104 = v67
                v105 = VolumePrefs.Get(v68) > 0
            else
                return
            end
            if not (SettingsCmds.Allows(v104) == v105 or v9[v104]) then
                v9[v104] = true
                local v106 = SettingsCmds.Flip(v104)
                v9[v104] = nil
                if not v106 then
                    local v107 = v10[v104]
                    if v107 then
                        local v108 = SettingsCmds.Allows(v104)
                        if v107.Inverted then
                            v108 = not v108
                        end
                        local v109 = if v108 then "ON" else "OFF"
                        v107.Status.Text = v109
                        local v110 = if v108 then v5 else v7
                        v107.KnobGradient.Color = v110
                        local v111 = if v108 then v2 else v3
                        Tween(v107.Knob, { Position = v111 }, v8)
                    end
                end
            end
        else
            if v103.UserInputType == Enum.UserInputType.Touch and v103 == v76 then
                if not v75 then
                    local v112 = v103.Position.X - ControlBar_2.AbsolutePosition.X
                    local X = ControlBar_2.AbsoluteSize.X
                    local v113 = v112 / math.max(X, 1)
                    local v114 = math.clamp(v113, 0, 1)
                    applySliderVisuals(v81, v114)
                    VolumePrefs.Set(v68, v114)
                end
            else
                return
            end
            v75 = false
            v11 = nil
            v76 = nil
            v77 = nil
            local v115 = VolumePrefs.Get(v68) > 0
            local v116 = false
            local v117 = false
            local v118 = false
            if SettingsCmds.Allows(v67) ~= v115 then
                v116 = true
            end
            if v116 and not v9[v67] then
                v117 = true
            end
            v116 = false
            if v117 then
                v9[v67] = true
                local v119 = SettingsCmds.Flip(v67)
                v9[v67] = nil
                if not v119 then
                    v116 = true
                end
            end
            v117 = false
            local v120
            if v116 then
                v120 = v10[v67]
                if v120 then
                    v117 = true
                end
            end
            v116 = false
            local v121
            if v117 then
                v121 = SettingsCmds.Allows(v67)
                if v120.Inverted then
                    v118 = true
                else
                    v116 = true
                end
            end
            v117 = false
            local v122
            if v116 then
                v122 = v121
                v117 = true
            end
            v116 = false
            if v118 then
                v122 = not v121
                v117 = true
            end
            v118 = false
            if v117 then
                if v122 then
                    v116 = true
                else
                    v118 = true
                end
            end
            v117 = false
            local v123
            if v118 then
                v123 = "OFF"
                v117 = true
            end
            v118 = false
            if v116 then
                v123 = "ON"
                v117 = true
            end
            v116 = false
            if v117 then
                v120.Status.Text = v123
                if v122 then
                    v118 = true
                else
                    v116 = true
                end
            end
            v117 = false
            local v124
            if v116 then
                v124 = v7
                v117 = true
            end
            v116 = false
            if v118 then
                v124 = v5
                v117 = true
            end
            v118 = false
            if v117 then
                v120.KnobGradient.Color = v124
                if v122 then
                    v116 = true
                else
                    v118 = true
                end
            end
            v117 = false
            local v125
            if v118 then
                v125 = v3
                v117 = true
            end
            if v116 then
                v125 = v2
                v117 = true
            end
            if v117 then
                Tween(v120.Knob, { Position = v125 }, v8)
            end
        end
    end)
    SettingsCmds.Changed:Connect(function(v126, v127) -- line 485 | captures: v75, v67, v68, v81, VolumePrefs, applySliderVisuals
        if not (v126 ~= v67 or v75) then
            if v127 == false then
                applySliderVisuals(v81, 0)
            else
                if VolumePrefs.Get(v68) == 0 then
                    VolumePrefs.Set(v68, 1)
                end
                applySliderVisuals(v81, VolumePrefs.Get(v68))
            end
        end
    end)
end

local function applyVideoSettingVisibility() -- line 499 | captures: TreadmillVideoGate, ScrollingFrame
    local DisableVideos = ScrollingFrame:FindFirstChild("DisableVideos")
    if DisableVideos and DisableVideos:IsA("GuiObject") then
        DisableVideos.Visible = not TreadmillVideoGate.IsVideoPlayerDisabled()
    end
end

function v12.Init() -- line 505 | captures: SettingsCmds, TreadmillVideoGate, Tween, v2, v3, v5, v7, v8, ScrollingFrame, v10, registerToggleRow, registerSliderRow, applyVideoSettingVisibility
    registerSliderRow("Music", "Music")
    registerSliderRow("SFX", "SFX")
    registerToggleRow("HideOtherPets", true)
    registerToggleRow("HideSelfPets", true)
    registerToggleRow("DisableVideos", true)
    SettingsCmds.Changed:Connect(function(v128) -- line 512 | captures: SettingsCmds, Tween, v2, v3, v5, v7, v8, v10
        local v129 = v10[v128]
        if not v129 then
            return
        end
        local v130 = SettingsCmds.Allows(v128)
        if v129.Inverted then
            v130 = not v130
        end
        local v131 = if v130 then "ON" else "OFF"
        v129.Status.Text = v131
        local v132 = if v130 then v5 else v7
        v129.KnobGradient.Color = v132
        local v133 = if v130 then v2 else v3
        Tween(v129.Knob, { Position = v133 }, v8)
    end)
    local HideOtherPets = v10.HideOtherPets
    if HideOtherPets then
        local HideOtherPets_2 = SettingsCmds.Allows("HideOtherPets")
        if HideOtherPets.Inverted then
            HideOtherPets_2 = not HideOtherPets_2
        end
        local v134 = if HideOtherPets_2 then "ON" else "OFF"
        HideOtherPets.Status.Text = v134
        local v135 = if HideOtherPets_2 then v5 else v7
        HideOtherPets.KnobGradient.Color = v135
        local v136 = if HideOtherPets_2 then v2 else v3
        Tween(HideOtherPets.Knob, { Position = v136 }, v8)
    end
    local HideSelfPets = v10.HideSelfPets
    if HideSelfPets then
        local HideSelfPets_2 = SettingsCmds.Allows("HideSelfPets")
        if HideSelfPets.Inverted then
            HideSelfPets_2 = not HideSelfPets_2
        end
        local v137 = if HideSelfPets_2 then "ON" else "OFF"
        HideSelfPets.Status.Text = v137
        local v138 = if HideSelfPets_2 then v5 else v7
        HideSelfPets.KnobGradient.Color = v138
        local v139 = if HideSelfPets_2 then v2 else v3
        Tween(HideSelfPets.Knob, { Position = v139 }, v8)
    end
    local DisableVideos = v10.DisableVideos
    if DisableVideos then
        local DisableVideos_2 = SettingsCmds.Allows("DisableVideos")
        if DisableVideos.Inverted then
            DisableVideos_2 = not DisableVideos_2
        end
        local v140 = if DisableVideos_2 then "ON" else "OFF"
        DisableVideos.Status.Text = v140
        local v141 = if DisableVideos_2 then v5 else v7
        DisableVideos.KnobGradient.Color = v141
        local v142 = if DisableVideos_2 then v2 else v3
        Tween(DisableVideos.Knob, { Position = v142 }, v8)
    end
    TreadmillVideoGate.Changed:Connect(applyVideoSettingVisibility)
    local DisableVideos_2 = ScrollingFrame:FindFirstChild("DisableVideos")
    if DisableVideos_2 and DisableVideos_2:IsA("GuiObject") then
        DisableVideos_2.Visible = not TreadmillVideoGate.IsVideoPlayerDisabled()
    end
end

v12.Init()
