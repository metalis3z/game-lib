-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function v1(...)
    return (tonumber(...))
end

local v2 = {}
local v3 = {}
local v4 = {}
local v5 = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local v6 = {
    NETWORK_MAP = {
        AdminPanel = {
            PRO_ACTION = "AdminPanelAction",
            ADMIN_STATUS_RESPONSE = "AdminStatusResponse"
        },
        AdminMessages = { SHOW_MESSAGE = "AdminShowMessage" }
    }
}
local Assets = require(ReplicatedStorage.Data.Assets)
local v7 = ReplicatedStorage:WaitForChild("Network"):WaitForChild(v6.NETWORK_MAP.AdminPanel.PRO_ACTION)
local AdminPanel_PREVIEW = PlayerGui:WaitForChild("AdminPanel_PREVIEW")
local AdminPanel = AdminPanel_PREVIEW:WaitForChild("AdminPanel")
do
    local Toggle = AdminPanel_PREVIEW:FindFirstChild("Toggle")
    if Toggle then
        Toggle:Destroy()
    end
end
AdminPanel_PREVIEW.Enabled = true
AdminPanel.Visible = false

local Top = AdminPanel:WaitForChild("Top")
local Main = Top:WaitForChild("Main")
local Close = Main:WaitForChild("Close")
local Settings = Main:WaitForChild("Settings")
local Holder = AdminPanel:WaitForChild("Holder")
local Menus = Holder:WaitForChild("Menus")
local AdminPanelSettings = PlayerGui:WaitForChild("AdminPanelSettings"):WaitForChild("AdminPanelSettings")
local AdminPanelEggPicker = PlayerGui:WaitForChild("AdminPanelEggPicker"):WaitForChild("AdminPanelEggPicker")
local AdminPanelPetPicker = PlayerGui:WaitForChild("AdminPanelPetPicker"):WaitForChild("AdminPanelPetPicker")
local AdminPanelMutationPicker = PlayerGui:WaitForChild("AdminPanelMutationPicker"):WaitForChild("AdminPanelMutationPicker")
local AdminPanelPetIconPicker = PlayerGui:WaitForChild("AdminPanelPetIconPicker"):WaitForChild("AdminPanelPetIconPicker")
local AdminPanelPassInfo = PlayerGui:WaitForChild("AdminPanelPassInfo"):WaitForChild("AdminPanelPassInfo")
do
    local pcall_2
    local v8
    for v9, v10 in ipairs(AdminPanelPetIconPicker.Holder.Scroller:GetChildren()) do
        if v10:IsA("ImageButton") then
            pcall_2 = pcall
            local v11 = v10
            pcall_2, v8 = pcall_2(function() -- line 37 | captures: Assets, v11
                return Assets.Directory[v11.Name]
            end)
            if pcall_2 and v8 and v8.Icon then
                v10.Image = v8.Icon
            end
        end
    end
    for v12, v13 in ipairs(AdminPanelPetPicker.Holder.Scroller:GetChildren()) do
        if v13:IsA("ImageButton") then
            pcall_2 = pcall
            local v14 = v13
            pcall_2, v8 = pcall_2(function() -- line 54 | captures: Assets, v14
                return Assets.Directory[v14.Name]
            end)
            if pcall_2 and v8 and v8.Egg and v8.Icon then
                v13.Image = v8.Egg.Icon or v8.Icon
            end
        end
    end
end

local function firstOfClass(v15, v16) -- line 66
    if v15 then
        for v17, v18 in ipairs(v15:GetDescendants()) do
            if v18:IsA(v16) and v18.Name ~= "PassGateHit" then
                return v18
            end
        end
    else
        return nil
    end
end

local function allButtons(v19) -- line 76
    local v20 = {}
    for v21, v22 in ipairs(v19:GetDescendants()) do
        if v22:IsA("TextButton") and v22.Name ~= "PassGateHit" then
            v20[#v20 + 1] = v22
        end
    end
    return v20
end

local function labelOf(v23) -- line 89
    return v23:FindFirstChild("Label")
end

do
    local function setBtnText(v24, v25) -- line 93
        local Label = v24:FindFirstChild("Label")
        if Label then
            Label.Text = v25
        end
    end
end
do
    local function mkSound(v26, v27) -- line 101
        local Sound = Instance.new("Sound")
        Sound.SoundId = v26
        Sound:SetAttribute("BaseVol", v27 or 0.5)
        Sound.Volume = v27 or 0.5
        Sound.Parent = script
        return Sound
    end
end
local Sound = Instance.new("Sound")

Sound.SoundId = "rbxassetid://17481582653"
Sound:SetAttribute("BaseVol", 0.4)
Sound.Volume = 0.4
Sound.Parent = script

local Sound_2 = Instance.new("Sound")

Sound_2.SoundId = "rbxassetid://115498848044697"
Sound_2:SetAttribute("BaseVol", 0.6)
Sound_2.Volume = 0.6
Sound_2.Parent = script

local v28 = true
local v29 = 1
do
    local function playSound(v30) -- line 123 | captures: v28, v29, SoundService
        if v28 and v30 then
            v30.Volume = (v30:GetAttribute("BaseVol") or 0.5) * v29
            SoundService:PlayLocalSound(v30)
        end
    end
end
local v31 = true
local v32 = Color3.fromRGB(120, 220, 140)
local v33 = Color3.fromRGB(255, 100, 100)
local ScreenGui = Instance.new("ScreenGui")

ScreenGui.Name = "AdminPanelToasts"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 60
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

local function showToast(v34, v35) -- line 141 | captures: TweenService, ScreenGui
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(0.6, 0, 0.06, 0)
    TextLabel.Position = UDim2.new(0.5, 0, 0.35, 0)
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = v34
    TextLabel.TextColor3 = v35 or Color3.fromRGB(255, 255, 255)
    TextLabel.TextScaled = true
    TextLabel.Font = Enum.Font.GothamBlack
    TextLabel.ZIndex = 1000
    TextLabel.Parent = ScreenGui
    Instance.new("UITextSizeConstraint", TextLabel).MaxTextSize = 35
    local v36 = Instance.new("UIStroke", TextLabel)
    v36.Color = Color3.fromRGB(0, 0, 0)
    v36.Thickness = 2.5
    local v37 = Instance.new("UIScale", TextLabel)
    v37.Scale = 0.7
    local v38 = { Scale = 1 }
    TweenService:Create(v37, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), v38):Play()
    local v39 = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local v40 = { Position = UDim2.new(0.5, 0, 0.3, 0) }
    TweenService:Create(TextLabel, v39, v40):Play()
    task.delay(2, function() -- line 168 | captures: TextLabel, v36, TweenService
        local v41 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        local v42 = { TextTransparency = 1 }
        v42.Position = UDim2.new(0.5, 0, 0.25, 0)
        TweenService:Create(TextLabel, v41, v42):Play()
        TweenService:Create(v36, v41, { Transparency = 1 }):Play()
        task.delay(0.5, function() -- line 177 | captures: TextLabel
            TextLabel:Destroy()
        end)
    end)
end

do
    local function notifyOk(v43) -- line 185 | captures: v31, v32, showToast
        if v31 then
            showToast(v43, v32)
        end
    end
end
do
    local function notifyErr(v44) -- line 192 | captures: v31, v33, showToast
        if v31 then
            showToast(v44, v33)
        end
    end
end
TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v45 = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v46 = {}
local v47 = { __mode = "k" }
local v48 = setmetatable(v46, v47)

local function animate(v49) -- line 202 | captures: v28, v29, TweenService, SoundService, Sound, Sound_2, v45, v48
    if not v49 or not v49:IsA("GuiButton") or v48[v49] then
        return
    end
    v48[v49] = true
    local v50 = v49:FindFirstChildOfClass("UIScale") or Instance.new("UIScale", v49)
    local v51, v52
    if v50.Scale <= 0 then
        v51 = 1
        v52 = 1
    else
        local v53 = v50.Scale or 1
        v51 = v53
        v52 = v53
    end
    v50.Scale = v52
    local v54 = false
    local v55 = false

    local function refresh_1() -- line 219 | captures: v51, v54, v55, v50, TweenService, v45
        local v56, v57
        if v55 then
            local v58 = v51 * 0.92
            if v58 then
                v56 = v58
                v57 = true
            elseif v54 then
                local v59 = v51 * 1.06
                if v59 then
                    v56 = v59
                    v57 = true
                else
                    v57 = false
                end
            else
                v57 = false
            end
        elseif v54 then
            local v60 = v51 * 1.06
            if v60 then
                v56 = v60
                v57 = true
            else
                v57 = false
            end
        else
            v57 = false
        end
        if not v57 then
            v56 = v51
        end
        local v61 = { Scale = v56 }
        TweenService:Create(v50, v45, v61):Play()
    end

    v49.MouseEnter:Connect(function() -- line 227 | captures: v51, v54, v55, v50, v28, v29, TweenService, SoundService, Sound_2, v45
        v54 = true
        local v62, v63
        if v55 then
            local v64 = v51 * 0.92
            if v64 then
                v62 = v64
                v63 = true
            elseif v54 then
                local v65 = v51 * 1.06
                if v65 then
                    v62 = v65
                    v63 = true
                else
                    v63 = false
                end
            else
                v63 = false
            end
        elseif v54 then
            local v66 = v51 * 1.06
            if v66 then
                v62 = v66
                v63 = true
            else
                v63 = false
            end
        else
            v63 = false
        end
        if not v63 then
            v62 = v51
        end
        local v67 = { Scale = v62 }
        TweenService:Create(v50, v45, v67):Play()
        if v28 and Sound_2 then
            Sound_2.Volume = (Sound_2:GetAttribute("BaseVol") or 0.5) * v29
            SoundService:PlayLocalSound(Sound_2)
        end
    end)
    v49.MouseLeave:Connect(function() -- line 242 | captures: v51, v54, v55, v50, TweenService, v45
        v54 = false
        v55 = false
        local v68, v69
        if v55 then
            local v70 = v51 * 0.92
            if v70 then
                v68 = v70
                v69 = true
            elseif v54 then
                local v71 = v51 * 1.06
                if v71 then
                    v68 = v71
                    v69 = true
                else
                    v69 = false
                end
            else
                v69 = false
            end
        elseif v54 then
            local v72 = v51 * 1.06
            if v72 then
                v68 = v72
                v69 = true
            else
                v69 = false
            end
        else
            v69 = false
        end
        if not v69 then
            v68 = v51
        end
        local v73 = { Scale = v68 }
        TweenService:Create(v50, v45, v73):Play()
    end)
    v49.MouseButton1Down:Connect(function() -- line 253 | captures: v51, v54, v55, v50, v28, v29, TweenService, SoundService, Sound, v45
        v55 = true
        local v74, v75
        if v55 then
            local v76 = v51 * 0.92
            if v76 then
                v74 = v76
                v75 = true
            elseif v54 then
                local v77 = v51 * 1.06
                if v77 then
                    v74 = v77
                    v75 = true
                else
                    v75 = false
                end
            else
                v75 = false
            end
        elseif v54 then
            local v78 = v51 * 1.06
            if v78 then
                v74 = v78
                v75 = true
            else
                v75 = false
            end
        else
            v75 = false
        end
        if not v75 then
            v74 = v51
        end
        local v79 = { Scale = v74 }
        TweenService:Create(v50, v45, v79):Play()
        if v28 and Sound then
            Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
            SoundService:PlayLocalSound(Sound)
        end
    end)
    v49.MouseButton1Up:Connect(function() -- line 268 | captures: v51, v54, v55, v50, TweenService, v45
        v55 = false
        local v80, v81
        if v55 then
            local v82 = v51 * 0.92
            if v82 then
                v80 = v82
                v81 = true
            elseif v54 then
                local v83 = v51 * 1.06
                if v83 then
                    v80 = v83
                    v81 = true
                else
                    v81 = false
                end
            else
                v81 = false
            end
        elseif v54 then
            local v84 = v51 * 1.06
            if v84 then
                v80 = v84
                v81 = true
            else
                v81 = false
            end
        else
            v81 = false
        end
        if not v81 then
            v80 = v51
        end
        local v85 = { Scale = v80 }
        TweenService:Create(v50, v45, v85):Play()
    end)
end

do
    local function ensureGradient(v86, v87) -- line 279
        local v88 = v86:FindFirstChild(v87)
        if not v88 then
            v88 = Instance.new("UIGradient")
            v88.Name = v87
            v88.Rotation = 0
            v88.Parent = v86
        end
        return v88
    end
end
local Main_2

if not Main:FindFirstChild("ThemeGradient") then
    Main_2 = Instance.new("UIGradient")
    Main_2.Name = "ThemeGradient"
    Main_2.Rotation = 0
    Main_2.Parent = Main
end
Main_2 = AdminPanelSettings:WaitForChild("Top"):WaitForChild("Main")
local ThemeGradient = Main_2:FindFirstChild("ThemeGradient")

if not ThemeGradient then
    ThemeGradient = Instance.new("UIGradient")
    ThemeGradient.Name = "ThemeGradient"
    ThemeGradient.Rotation = 0
    ThemeGradient.Parent = Main_2
end
local ThemeGradient_2 = ThemeGradient
local ThemeGradient_3 = Top:FindFirstChild("ThemeGradient")
local ThemeGradient_4 = ThemeGradient_3

if not ThemeGradient_3 then
    ThemeGradient_3 = Instance.new("UIGradient")
    ThemeGradient_4 = ThemeGradient_3
    ThemeGradient_3.Name = "ThemeGradient"
    ThemeGradient_3.Rotation = 0
    ThemeGradient_3.Parent = Top
end
ThemeGradient_3 = AdminPanelSettings:WaitForChild("Top")
local ThemeGradient_5 = ThemeGradient_3:FindFirstChild("ThemeGradient")
local ThemeGradient_6 = ThemeGradient_5

if not ThemeGradient_5 then
    ThemeGradient_5 = Instance.new("UIGradient")
    ThemeGradient_6 = ThemeGradient_5
    ThemeGradient_5.Name = "ThemeGradient"
    ThemeGradient_5.Rotation = 0
    ThemeGradient_5.Parent = ThemeGradient_3
end
local v89 = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(56, 60, 85)),
    ColorSequenceKeypoint.new(0.57, Color3.fromRGB(49, 51, 74)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(33, 32, 48))
})
local v90 = Color3.fromRGB(80, 80, 80)

local function shades(v91) -- line 324
    local v92, v93, v94 = v91:ToHSV()
    local new = ColorSequence.new
    local fromHSV = Color3.fromHSV
    local v95 = v93 - 0.15
    local v96 = math.clamp(v95, 0, 1)
    local v97 = v94 + 0.18
    local v98 = fromHSV(v92, v96, (math.clamp(v97, 0, 1)))
    local fromHSV_2 = Color3.fromHSV
    local v99 = v93 + 0.1
    local v100 = math.clamp(v99, 0, 1)
    local v101 = v94 - 0.28
    return new(v98, fromHSV_2(v92, v100, (math.clamp(v101, 0, 1))))
end

local function paintButton(v102, v103) -- line 329
    if not v102 then
        return
    end
    local Color = v102:FindFirstChild("Color")
    if Color then
        local UIGradient = Color:FindFirstChildOfClass("UIGradient")
        if UIGradient then
            UIGradient.Color = v103
        end
        local Layout = Color:FindFirstChild("Layout")
        local v104 = Layout and Layout:FindFirstChildOfClass("UIGradient")
        if v104 then
            v104.Color = v103
        end
    end
    local ThemeGradient = v102:FindFirstChild("ThemeGradient")
    if ThemeGradient then
        ThemeGradient.Color = v103
    end
end

local v105 = {
    Blue = Color3.fromRGB(45, 120, 255),
    Red = Color3.fromRGB(235, 60, 60),
    Green = Color3.fromRGB(60, 200, 90),
    Purple = Color3.fromRGB(160, 80, 255),
    Orange = Color3.fromRGB(255, 150, 40)
}
local v106 = "RGB"
local v107 = 0
local v108

local function rainbow(v109) -- line 361
    local v110 = {}
    for v111 = 0, 6 do
        v110[#v110 + 1] = ColorSequenceKeypoint.new(v111 / 6, Color3.fromHSV((v109 + v111 / 6) % 1, 1, 1))
    end
    return ColorSequence.new(v110)
end

local function themeSeq() -- line 369 | captures: v106, v107, shades, v105, rainbow
    if v106 == "RGB" then
        return rainbow(v107)
    end
    local v112 = v105[v106] or Color3.fromRGB(45, 120, 255)
    return shades(v112)
end

local ThemeGradient_7 = Menus:FindFirstChild("ThemeGradient")
local v113 = ThemeGradient_7

if not ThemeGradient_7 then
    local UIGradient = Instance.new("UIGradient")
    v113 = UIGradient
    UIGradient.Name = "ThemeGradient"
    UIGradient.Rotation = 0
    UIGradient.Parent = Menus
end
local ThemeGradient_8 = ThemeGradient_5

local function paintTheme() -- line 384 | captures: ThemeGradient_2, ThemeGradient_4, v106, v107, v108, v113, shades, paintButton, v105, rainbow, ThemeGradient_8
    local v114
    if v106 == "RGB" then
        v114 = rainbow(v107)
    else
        local v115 = v105[v106] or Color3.fromRGB(45, 120, 255)
        v114 = shades(v115)
    end
    ThemeGradient_2.Color = v114
    ThemeGradient_4.Color = v114
    v113.Color = v114
    ThemeGradient_8.Color = v114
    if v108 then
        paintButton(v108, v114)
    end
end

do
    local function setTheme(v116) -- line 402 | captures: ThemeGradient_2, ThemeGradient_4, v106, v107, v108, v113, LocalPlayer, shades, paintButton, v105, rainbow, ThemeGradient_8
        v106 = v116
        LocalPlayer:SetAttribute("AdminThemeName", v116)
        local v117
        if v106 == "RGB" then
            v117 = rainbow(v107)
        else
            local v118 = v105[v106] or Color3.fromRGB(45, 120, 255)
            v117 = shades(v118)
        end
        ThemeGradient_2.Color = v117
        ThemeGradient_4.Color = v117
        v113.Color = v117
        ThemeGradient_8.Color = v117
        if v108 then
            paintButton(v108, v117)
        end
    end
end
RunService.Heartbeat:Connect(function(v119) -- line 423 | captures: ThemeGradient_2, ThemeGradient_4, v106, v107, v108, v113, AdminPanel, AdminPanelSettings, paintButton, rainbow, ThemeGradient_8
    if v106 ~= "RGB" or not AdminPanel.Visible and not AdminPanelSettings.Visible then
        return
    end
    v107 = (v107 + v119 / 3) % 1
    local v120 = rainbow(v107)
    ThemeGradient_2.Color = v120
    ThemeGradient_4.Color = v120
    v113.Color = v120
    ThemeGradient_8.Color = v120
    if v108 and AdminPanel.Visible then
        paintButton(v108, v120)
    end
end)
local v121 = {
    TeleportButton = "Spawn",
    AvatarEditorButton = "AvatarCreator",
    CutscenesButton = "Cutscene",
    TreadmillsButton = "MobGiver",
    CommandsButton = "Statistics",
    HDAdminButton = "HDAdmin",
    TagsButton = "CustomEgg",
    GuardsButton = "GuardEditor",
    BtoolsButton = "BTools",
    ItemsButton = "EggGiver",
    NPCsButton = "Npc",
    MainButton = "Main",
    FreecamButton = "Freecam",
    MorphButton = "Morph"
}
local v122 = {}
local v123 = {}
for v124, v125 in pairs(v121) do
    local v126 = Holder:FindFirstChild(v125)
    if v126 then
        v122[v125] = v126
    end
end
local v127 = "Main"
local v128 = {}

local function setBtnGradRot(v129, v130) -- line 451
    local function v131(v132, ...)
        table.insert(v132, ...)
    end

    local v133 = v129 and v129:FindFirstChild("Color")
    if not v133 then
        return
    end
    local v134 = { v133:FindFirstChildOfClass("UIGradient") }
    local Layout = v133:FindFirstChild("Layout")
    if Layout then
        v131(v134, Layout:FindFirstChildOfClass("UIGradient"))
    end
    for v135, v136 in ipairs(v134) do
        if v136 then
            if v136:GetAttribute("OrigRot") == nil then
                v136:SetAttribute("OrigRot", v136.Rotation)
            end
            if v130 then
                v136.Rotation = 0
            else
                v136.Rotation = v136:GetAttribute("OrigRot") or 90
            end
        end
    end
end

local function ensureBtnGradient(v137) -- line 472 | captures: v90
    local ThemeGradient = v137:FindFirstChild("ThemeGradient")
    if not ThemeGradient then
        ThemeGradient = Instance.new("UIGradient")
        ThemeGradient.Name = "ThemeGradient"
        ThemeGradient.Rotation = 0
        ThemeGradient.Parent = v137
    end
    if v137:GetAttribute("OrigBg") == nil then
        v137:SetAttribute("OrigBg", v137.BackgroundColor3)
    end
    v137.BackgroundColor3 = v90
    return ThemeGradient
end

local function highlight(v138) -- line 488 | captures: v89, v108, paintButton, themeSeq, setBtnGradRot, ensureBtnGradient
    local v139
    if v108 then
        if v108 == v138 then
            v139 = true
        else
            paintButton(v108, v89)
            setBtnGradRot(v108, false)
            local ThemeGradient = v108:FindFirstChild("ThemeGradient")
            if ThemeGradient then
                ThemeGradient:Destroy()
            end
            v139 = false
        end
    else
        v139 = true
    end
    if not v139 then
        local OrigBg = v108:GetAttribute("OrigBg")
        if OrigBg then
            v108.BackgroundColor3 = OrigBg
        end
    end
    v108 = v138
    if not v138 then
        return
    end
    ensureBtnGradient(v138)
    paintButton(v138, themeSeq())
    setBtnGradRot(v138, true)
end

local function showPage(v140, v141) -- line 513 | captures: v28, v29, v127, SoundService, Sound, v122, v123, v128, highlight
    local v142 = if v122[v140] then v140 else "Main"
    for v143, v144 in pairs(v122) do
        v144.Visible = v143 == v142
    end
    v127 = v142
    highlight(v123[v142])
    if v141 and v28 and Sound then
        Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
        SoundService:PlayLocalSound(Sound)
    end
    local v145 = v128[v142]
    if v145 then
        task.spawn(v145)
    end
end

do
    local function bounce(v146) -- line 533 | captures: TweenService
        local v147 = v146 and v146:FindFirstChildOfClass("UIScale")
        if not v147 then
            return
        end
        local v148 = v147:GetAttribute("Base") or v147.Scale
        v146:SetAttribute("Base", v148)
        v147.Scale = v148 * 0.9
        local v149 = { Scale = v148 }
        TweenService:Create(v147, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), v149):Play()
    end

    for v150, v151 in ipairs(Menus:GetChildren()) do
        if v151:IsA("TextButton") then
            local v152 = v121[v151.Name]
            if v152 and v122[v152] then
                v123[v152] = v151
                local MouseButton1Click = v151.MouseButton1Click
                local v153 = v151
                MouseButton1Click:Connect(function() -- line 558 | captures: showPage, bounce, v152, v153
                    showPage(v152, true)
                    bounce(v153)
                end)
            end
        end
    end
end
do
    local Search = Holder:FindFirstChild("Search")
    if Search then
        local Label = Search:FindFirstChild("Label")
        local SearchBox = Search:FindFirstChild("SearchBox")
        local SearchBox_2 = SearchBox
        if not SearchBox then
            SearchBox = Instance.new("TextBox")
            SearchBox_2 = SearchBox
            SearchBox.Name = "SearchBox"
            SearchBox.BackgroundTransparency = 1
            SearchBox.ClearTextOnFocus = false
            SearchBox.Text = ""
            SearchBox.PlaceholderText = "Search..."
            SearchBox.ZIndex = 3
            if Label then
                SearchBox.FontFace = Label.FontFace
                SearchBox.TextColor3 = Label.TextColor3
                SearchBox.PlaceholderColor3 = Label.TextColor3
                SearchBox.TextScaled = Label.TextScaled
                SearchBox.TextSize = Label.TextSize
                SearchBox.TextStrokeTransparency = Label.TextStrokeTransparency
                SearchBox.TextStrokeColor3 = Label.TextStrokeColor3
                SearchBox.TextXAlignment = Label.TextXAlignment
                SearchBox.TextYAlignment = Label.TextYAlignment
                SearchBox.Size = Label.Size
                SearchBox.Position = Label.Position
                SearchBox.AnchorPoint = Label.AnchorPoint
                for v154, v155 in ipairs(Label:GetChildren()) do
                    if not v155:IsA("GuiObject") then
                        v155:Clone().Parent = SearchBox
                    end
                end
                Label.Visible = false
            else
                SearchBox.Size = UDim2.fromScale(0.9, 0.8)
                SearchBox.Position = UDim2.fromScale(0.5, 0.5)
                SearchBox.AnchorPoint = Vector2.new(0.5, 0.5)
            end
            SearchBox.Parent = Search
        end
        Search.MouseButton1Click:Connect(function() -- line 606 | captures: SearchBox_2
            SearchBox_2:CaptureFocus()
        end)
        local v156

        local function getOrdered() -- line 612 | captures: v156, Menus
            if not v156 then
                v156 = {}
                for v157, v158 in ipairs(Menus:GetChildren()) do
                    if v158:IsA("GuiObject") then
                        v156[#v156 + 1] = v158
                    end
                end
                table.sort(v156, function(v159, v160) -- line 623
                    return v159.LayoutOrder < v160.LayoutOrder
                end)
            end
            return v156
        end

        local function prettify(v161) -- line 631
            return (v161:gsub("BtnRow$", ""):gsub("Row%d*$", ""):gsub("(%l)(%u)", "%1 %2"))
        end

        local function isHeader(v162) -- line 635
            local Text = v162.Text
            if Text:match("%a") ~= nil and Text == Text:upper() then
                return #Text <= 40
            end
            return false
        end

        local v163 = {}
        local v164 = false

        local function buildIndex() -- line 643 | captures: v164, v121, v122, getOrdered, v163
            if v164 then
                return
            end
            v164 = true
            local v165 = {}
            for v166, v167 in ipairs((getOrdered())) do
                local v168 = v167:IsA("TextButton") and v121[v167.Name]
                if v168 and v122[v168] then
                    v165[#v165 + 1] = v168
                end
            end
            for v169, v170 in ipairs(v165) do
                local v171 = {}
                for v172, v173 in ipairs(v122[v170]:GetChildren()) do
                    if v173:IsA("GuiObject") then
                        v171[#v171 + 1] = v173
                    end
                end
                table.sort(v171, function(v174, v175) -- line 668
                    return v174.LayoutOrder < v175.LayoutOrder
                end)
                local Text = ""
                for v176, v177 in ipairs(v171) do
                    if v177:IsA("TextLabel") then
                        if v177.Name == "TextIgnore" then
                            local Text_2 = v177.Text
                            if Text_2:match("%a") ~= nil and Text_2 == Text_2:upper() and #Text_2 <= 40 then
                                Text = v177.Text
                                v163[#v163 + 1] = {
                                    page = v170,
                                    target = v177,
                                    hay = v177.Text:lower()
                                }
                            end
                        elseif v177:IsA("Frame") and v177.Name ~= "Invis" and not v177.Name:find("Ignore") then
                            local v178 = {
                                Text,
                                v177.Name:gsub("BtnRow$", ""):gsub("Row%d*$", ""):gsub("(%l)(%u)", "%1 %2")
                            }
                            for v179, v180 in ipairs(v177:GetDescendants()) do
                                if (v180:IsA("TextLabel") or v180:IsA("TextButton")) and v180.Name ~= "TextIgnore" and v180.Text ~= "" then
                                    v178[#v178 + 1] = v180.Text
                                end
                            end
                            v163[#v163 + 1] = {
                                page = v170,
                                target = v177,
                                hay = table.concat(v178, " "):lower()
                            }
                        end
                    elseif v177:IsA("Frame") and v177.Name ~= "Invis" and not v177.Name:find("Ignore") then
                        local v181 = {
                            Text,
                            v177.Name:gsub("BtnRow$", ""):gsub("Row%d*$", ""):gsub("(%l)(%u)", "%1 %2")
                        }
                        for v182, v183 in ipairs(v177:GetDescendants()) do
                            if (v183:IsA("TextLabel") or v183:IsA("TextButton")) and v183.Name ~= "TextIgnore" and v183.Text ~= "" then
                                v181[#v181 + 1] = v183.Text
                            end
                        end
                        v163[#v163 + 1] = {
                            page = v170,
                            target = v177,
                            hay = table.concat(v181, " "):lower()
                        }
                    end
                end
            end
        end

        local function pulse(v184) -- line 732 | captures: TweenService
            local SearchPulse = v184:FindFirstChild("SearchPulse")
            if not SearchPulse then
                SearchPulse = Instance.new("UIStroke")
                SearchPulse.Name = "SearchPulse"
                SearchPulse.Color = Color3.fromRGB(255, 225, 90)
                SearchPulse.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                SearchPulse.Parent = v184
            end
            SearchPulse.Thickness = 3
            local v185 = { Thickness = 0 }
            TweenService:Create(SearchPulse, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v185):Play()
        end

        local v186 = 0

        local function scrollTo(v187, v188) -- line 747 | captures: TweenService, RunService, pulse
            RunService.Heartbeat:Wait()
            RunService.Heartbeat:Wait()
            local v189 = v188.AbsolutePosition.Y - v187.AbsolutePosition.Y + v187.CanvasPosition.Y - 8
            local v190 = v187.AbsoluteCanvasSize.Y - v187.AbsoluteWindowSize.Y
            local v191 = math.max(0, v190)
            local v192 = math.clamp(v189, 0, v191)
            local v193 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local v194 = { CanvasPosition = Vector2.new(0, v192) }
            TweenService:Create(v187, v193, v194):Play()
            pulse(v188)
        end

        local function applyMenuFilter(v195) -- line 758 | captures: v121, getOrdered
            local v196 = getOrdered()
            for v197, v198 in ipairs(v196) do
                if v198:IsA("TextButton") and v121[v198.Name] then
                    if v195 == nil then
                        v198.Visible = true
                    else
                        v198.Visible = v195[v121[v198.Name]] == true
                    end
                end
            end
            local v199
            local v200 = false

            local function flush_1() -- line 774 | captures: v199, v200
                if v199 then
                    v199.Visible = v200
                end
            end

            for v201, v202 in ipairs(v196) do
                if v202:IsA("TextLabel") and v202.Name == "TextIgnore" then
                    if v199 then
                        v199.Visible = v200
                    end
                    v199 = v202
                    v200 = false
                elseif v202:IsA("TextButton") and v121[v202.Name] then
                    if v202.Visible then
                        v200 = true
                    else
                        if v199 then
                            v199.Visible = v200
                        end
                        v199 = v202
                        v200 = false
                    end
                end
            end
            if v199 then
                v199.Visible = v200
            end
        end

        SearchBox_2:GetPropertyChangedSignal("Text"):Connect(function() -- line 803 | captures: v127, SearchBox_2, v186, v122, v123, v128, highlight, v163, buildIndex, scrollTo, applyMenuFilter
            v186 += 1
            local v203 = v186
            local v204 = SearchBox_2.Text:lower():match("^%s*(.-)%s*$")
            if v204 == "" then
                applyMenuFilter(nil)
            else
                buildIndex()
                local v205 = {}
                local v206, v207
                for v208, v209 in ipairs(v163) do
                    if v209.hay:find(v204, 1, true) then
                        v205[v209.page] = true
                        if not v207 then
                            v206 = v209
                            v207 = v209
                        end
                    end
                end
                applyMenuFilter(v205)
                if v207 then
                    local page = v207.page
                    if not v122[page] then
                        page = "Main"
                    end
                    for v210, v211 in pairs(v122) do
                        v211.Visible = v210 == page
                    end
                    v127 = page
                    highlight(v123[page])
                    local v212 = v128[page]
                    if v212 then
                        task.spawn(v212)
                    end
                    task.spawn(function() -- line 838 | captures: v206, v203, v186, v122, scrollTo
                        if v203 == v186 then
                            scrollTo(v122[v206.page], v206.target)
                        end
                    end)
                end
            end
        end)
    end
end
local v213 = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local v214 = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
local Position = AdminPanel.Position
local v215 = UDim2.new(AdminPanel.Position.X.Scale, AdminPanel.Position.X.Offset, 1.6, 0)
local AdminPanelBlur = Lighting:FindFirstChild("AdminPanelBlur")
local v216 = AdminPanelBlur

if not AdminPanelBlur then
    local v217 = Instance.new("BlurEffect")
    v216 = v217
    v217.Name = "AdminPanelBlur"
    v217.Size = 0
    v217.Enabled = false
    v217.Parent = Lighting
end
local v218 = false
do
    local function isOpen() -- line 866 | captures: v218
        return v218
    end
end
do
    local function closeSettingsImmediate() -- line 870 | captures: AdminPanelSettings
        if AdminPanelSettings.Visible then
            AdminPanelSettings.Visible = false
        end
    end
end
do
    local function closeEggPickerImmediate() -- line 877 | captures: AdminPanelEggPicker
        if AdminPanelEggPicker.Visible then
            AdminPanelEggPicker.Visible = false
        end
    end
end
do
    local function closePetPickerImmediate() -- line 884 | captures: AdminPanelPetPicker
        if AdminPanelPetPicker.Visible then
            AdminPanelPetPicker.Visible = false
        end
    end
end
do
    local function closeMutationPickerImmediate() -- line 891 | captures: AdminPanelMutationPicker
        if AdminPanelMutationPicker.Visible then
            AdminPanelMutationPicker.Visible = false
        end
    end
end
do
    local function closePetIconPickerImmediate() -- line 898 | captures: AdminPanelPetIconPicker
        if AdminPanelPetIconPicker.Visible then
            AdminPanelPetIconPicker.Visible = false
        end
    end
end
do
    local function closePassInfoImmediate() -- line 905 | captures: AdminPanelPassInfo
        if AdminPanelPassInfo.Visible then
            AdminPanelPassInfo.Visible = false
        end
    end
end

local function openPanel() -- line 912 | captures: v127, v213, v216, v218, TweenService, AdminPanel, v122, v123, v128, highlight, Position, v215
    if v218 then
        return
    end
    v218 = true
    local v219 = v127
    if not v122[v219] then
        v219 = "Main"
    end
    for v220, v221 in pairs(v122) do
        v221.Visible = v220 == v219
    end
    v127 = v219
    highlight(v123[v219])
    local v222 = v128[v219]
    if v222 then
        task.spawn(v222)
    end
    AdminPanel.Position = v215
    AdminPanel.Visible = true
    local v223 = { Position = Position }
    TweenService:Create(AdminPanel, v213, v223):Play()
    v216.Enabled = true
    local v224 = { Size = 18 }
    TweenService:Create(v216, TweenInfo.new(0.35), v224):Play()
end

local function closePanel() -- line 940 | captures: v214, v216, v218, TweenService, AdminPanel, AdminPanelSettings, AdminPanelEggPicker, AdminPanelPetPicker, AdminPanelMutationPicker, AdminPanelPetIconPicker, AdminPanelPassInfo, Position, v215
    if not v218 then
        return
    end
    v218 = false
    if AdminPanelSettings.Visible then
        AdminPanelSettings.Visible = false
    end
    if AdminPanelEggPicker.Visible then
        AdminPanelEggPicker.Visible = false
    end
    if AdminPanelPetPicker.Visible then
        AdminPanelPetPicker.Visible = false
    end
    if AdminPanelMutationPicker.Visible then
        AdminPanelMutationPicker.Visible = false
    end
    if AdminPanelPetIconPicker.Visible then
        AdminPanelPetIconPicker.Visible = false
    end
    if AdminPanelPassInfo.Visible then
        AdminPanelPassInfo.Visible = false
    end
    local v225 = TweenService:Create(AdminPanel, v214, { Position = v215 })
    v225.Completed:Connect(function() -- line 966 | captures: v218, AdminPanel, Position
        if not v218 then
            AdminPanel.Visible = false
            AdminPanel.Position = Position
        end
    end)
    v225:Play()
    local v226 = { Size = 0 }
    local v227 = TweenService:Create(v216, TweenInfo.new(0.3), v226)
    v227.Completed:Connect(function() -- line 979 | captures: v216, v218
        if not v218 then
            v216.Enabled = false
        end
    end)
    v227:Play()
end

local function togglePanel() -- line 989 | captures: v218, openPanel, closePanel
    if v218 then
        closePanel()
    else
        openPanel()
    end
end

Close.MouseButton1Click:Connect(closePanel)
local Close_2 = AdminPanelSettings.Top.Main:FindFirstChild("Close")
local v228 = UDim2.new(0.5, 0, 0.5, 0)
local v229 = UDim2.new(0.5, 0, 1.5, 0)

AdminPanelSettings.AnchorPoint = Vector2.new(0.5, 0.5)
do
    local function openSettings() -- line 1003 | captures: v213, TweenService, AdminPanel, AdminPanelSettings, v228, v229
        AdminPanel.Visible = false
        AdminPanelSettings.Position = v229
        AdminPanelSettings.Visible = true
        local v230 = { Position = v228 }
        TweenService:Create(AdminPanelSettings, v213, v230):Play()
    end
end
do
    local function closeSettings() -- line 1012 | captures: v214, v218, TweenService, AdminPanel, AdminPanelSettings, v228, v229
        local v231 = TweenService:Create(AdminPanelSettings, v214, { Position = v229 })
        v231.Completed:Connect(function() -- line 1016 | captures: AdminPanelSettings, v228
            AdminPanelSettings.Visible = false
            AdminPanelSettings.Position = v228
        end)
        v231:Play()
        if v218 then
            AdminPanel.Visible = true
        end
    end

    Settings.MouseButton1Click:Connect(function() -- line 1029 | captures: v28, v29, v213, TweenService, SoundService, AdminPanel, AdminPanelSettings, Sound, v228, v229
        if v28 and Sound then
            Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
            SoundService:PlayLocalSound(Sound)
        end
        AdminPanel.Visible = false
        AdminPanelSettings.Position = v229
        AdminPanelSettings.Visible = true
        local v232 = { Position = v228 }
        TweenService:Create(AdminPanelSettings, v213, v232):Play()
    end)
    if Close_2 then
        Close_2.MouseButton1Click:Connect(closeSettings)
    end
end
local MouseButton1Click = AdminPanelEggPicker.Top.Main:FindFirstChild("Close")

AdminPanelEggPicker.AnchorPoint = Vector2.new(0.5, 0.5)

local function closeEggPicker() -- line 1048 | captures: v214, v218, TweenService, AdminPanel, AdminPanelEggPicker, v228, v229
    local v233 = TweenService:Create(AdminPanelEggPicker, v214, { Position = v229 })
    v233.Completed:Connect(function() -- line 1052 | captures: AdminPanelEggPicker, v228
        AdminPanelEggPicker.Visible = false
        AdminPanelEggPicker.Position = v228
    end)
    v233:Play()
    if v218 then
        AdminPanel.Visible = true
    end
end

if MouseButton1Click then
    MouseButton1Click.MouseButton1Click:Connect(function() -- line 1066 | captures: v28, v29, SoundService, Sound, closeEggPicker
        if v28 and Sound then
            Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
            SoundService:PlayLocalSound(Sound)
        end
        closeEggPicker()
    end)
end

local function animateAll(v234) -- line 1076 | captures: allButtons, animate
    for v235, v236 in ipairs((allButtons(v234))) do
        animate(v236)
    end
    v234.DescendantAdded:Connect(function(v237) -- line 1082 | captures: animate
        if v237:IsA("GuiButton") then
            animate(v237)
        end
    end)
end

animateAll(AdminPanelEggPicker)
local Close_3 = AdminPanelPetPicker.Top.Main:FindFirstChild("Close")

AdminPanelPetPicker.AnchorPoint = Vector2.new(0.5, 0.5)

local function closePetPicker() -- line 1094 | captures: v214, v218, TweenService, AdminPanel, AdminPanelPetPicker, v228, v229
    local v238 = TweenService:Create(AdminPanelPetPicker, v214, { Position = v229 })
    v238.Completed:Connect(function() -- line 1098 | captures: AdminPanelPetPicker, v228
        AdminPanelPetPicker.Visible = false
        AdminPanelPetPicker.Position = v228
    end)
    v238:Play()
    if v218 then
        AdminPanel.Visible = true
    end
end

if Close_3 then
    Close_3.MouseButton1Click:Connect(function() -- line 1112 | captures: v28, v29, SoundService, Sound, closePetPicker
        if v28 and Sound then
            Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
            SoundService:PlayLocalSound(Sound)
        end
        closePetPicker()
    end)
end
animateAll(AdminPanelPetPicker)
local Close_4 = AdminPanelMutationPicker.Top.Main:FindFirstChild("Close")

AdminPanelMutationPicker.AnchorPoint = Vector2.new(0.5, 0.5)

local function closeMutationPicker() -- line 1125 | captures: v214, v218, TweenService, AdminPanel, AdminPanelMutationPicker, v228, v229
    local v239 = TweenService:Create(AdminPanelMutationPicker, v214, { Position = v229 })
    v239.Completed:Connect(function() -- line 1129 | captures: AdminPanelMutationPicker, v228
        AdminPanelMutationPicker.Visible = false
        AdminPanelMutationPicker.Position = v228
    end)
    v239:Play()
    if v218 then
        AdminPanel.Visible = true
    end
end

if Close_4 then
    Close_4.MouseButton1Click:Connect(function() -- line 1143 | captures: v28, v29, SoundService, Sound, closeMutationPicker
        if v28 and Sound then
            Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
            SoundService:PlayLocalSound(Sound)
        end
        closeMutationPicker()
    end)
end
animateAll(AdminPanelMutationPicker)
local Close_5 = AdminPanelPetIconPicker.Top.Main:FindFirstChild("Close")

AdminPanelPetIconPicker.AnchorPoint = Vector2.new(0.5, 0.5)

local function closePetIconPicker() -- line 1156 | captures: v214, v218, TweenService, AdminPanel, AdminPanelPetIconPicker, v228, v229
    local v240 = TweenService:Create(AdminPanelPetIconPicker, v214, { Position = v229 })
    v240.Completed:Connect(function() -- line 1160 | captures: AdminPanelPetIconPicker, v228
        AdminPanelPetIconPicker.Visible = false
        AdminPanelPetIconPicker.Position = v228
    end)
    v240:Play()
    if v218 then
        AdminPanel.Visible = true
    end
end

if Close_5 then
    Close_5.MouseButton1Click:Connect(function() -- line 1174 | captures: v28, v29, SoundService, Sound, closePetIconPicker
        if v28 and Sound then
            Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
            SoundService:PlayLocalSound(Sound)
        end
        closePetIconPicker()
    end)
end
animateAll(AdminPanelPetIconPicker)
do
    local Close = AdminPanelPassInfo.Top.Main:FindFirstChild("Close")
    AdminPanelPassInfo.AnchorPoint = Vector2.new(0.5, 0.5)

    local function closePassInfo() -- line 1187 | captures: v214, v218, TweenService, AdminPanel, AdminPanelPassInfo, v228, v229
        local v241 = TweenService:Create(AdminPanelPassInfo, v214, { Position = v229 })
        v241.Completed:Connect(function() -- line 1191 | captures: AdminPanelPassInfo, v228
            AdminPanelPassInfo.Visible = false
            AdminPanelPassInfo.Position = v228
        end)
        v241:Play()
        if v218 then
            AdminPanel.Visible = true
        end
    end

    if Close then
        Close.MouseButton1Click:Connect(function() -- line 1205 | captures: v28, v29, SoundService, Sound, closePassInfo
            if v28 and Sound then
                Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                SoundService:PlayLocalSound(Sound)
            end
            closePassInfo()
        end)
    end
end
animateAll(AdminPanelPassInfo)
local v242 = {}
local v243 = {}
local v244
local v245 = 0
local v246 = { TogglePanel = "R" }

local function keyName(v247) -- line 1221 | captures: LocalPlayer, v246
    local v248 = LocalPlayer:GetAttribute("AdminKey_" .. v247)
    if typeof(v248) ~= "string" or v248 == "" then
        return v246[v247]
    end
    return v248
end

local function refreshKeyDisplay(v249) -- line 1229 | captures: v244, LocalPlayer, v243, v246
    for v250, v251 in ipairs(v243[v249] or {}) do
        v251.Text = ""
        if v244 == v249 then
            v251.PlaceholderText = "Recording key..."
        else
            local v252 = LocalPlayer:GetAttribute("AdminKey_" .. v249)
            if typeof(v252) == "string" then
                if v252 == "" then
                    v252 = v246[v249]
                end
            else
                v252 = v246[v249]
            end
            v251.PlaceholderText = v252 or "Bind Here"
        end
    end
end

do
    local function startCapture(v253) -- line 1247 | captures: v244, v245, refreshKeyDisplay
        local v254 = os.clock()
        if v254 - v245 < 0.05 then
            return
        end
        v245 = v254
        v244 = v253
        if v244 and v244 ~= v253 then
            refreshKeyDisplay(v244)
        end
        refreshKeyDisplay(v253)
    end
end

local function bindKeyField(v255, v256) -- line 1260 | captures: v244, v245, firstOfClass, v243, refreshKeyDisplay
    if not v255 then
        return
    end
    local v257 = firstOfClass(v255, "TextBox")
    if v257 then
        v257.TextEditable = false
        v257.Text = ""
        local v258 = v243[v256] or {}
        v243[v256] = v258
        local v259 = v243[v256]
        table.insert(v259, v257)
        v255.InputBegan:Connect(function(v260) -- line 1272 | captures: v256, v244, v245, refreshKeyDisplay
            if v260.UserInputType ~= Enum.UserInputType.MouseButton1 and v260.UserInputType ~= Enum.UserInputType.Touch then
                return
            end
            local v261 = os.clock()
            if v261 - v245 < 0.05 then
                return
            end
            v245 = v261
            v244 = v256
            if v244 and v244 ~= v256 then
                refreshKeyDisplay(v244)
            end
            refreshKeyDisplay(v256)
        end)
    end
    refreshKeyDisplay(v256)
    v255.MouseButton1Click:Connect(function() -- line 1292 | captures: v256, v244, v245, refreshKeyDisplay
        local v262 = os.clock()
        if v262 - v245 < 0.05 then
            return
        end
        v245 = v262
        v244 = v256
        if v244 and v244 ~= v256 then
            refreshKeyDisplay(v244)
        end
        refreshKeyDisplay(v256)
    end)
end

do
    local function releaseCaptureFocus(v263) -- line 1307 | captures: v243
        for v264, v265 in ipairs(v243[v263] or {}) do
            if v265.Focused then
                v265:ReleaseFocus()
            end
        end
    end

    local function actionForKey(v266) -- line 1315 | captures: LocalPlayer, v242, v246
        for v267 in pairs(v242) do
            local v268 = LocalPlayer:GetAttribute("AdminKey_" .. v267)
            if typeof(v268) == "string" then
                if v268 == "" then
                    local v269 = v246[v267]
                    if v269 and v269 == v266 then
                        return v267
                    end
                elseif v268 and v268 == v266 then
                    return v267
                end
            else
                local v270 = v246[v267]
                if v270 and v270 == v266 then
                    return v267
                end
            end
        end
    end

    UserInputService.InputBegan:Connect(function(v271, v272) -- line 1335 | captures: v28, v29, v244, UserInputService, SoundService, LocalPlayer, Sound, v242, refreshKeyDisplay, releaseCaptureFocus, actionForKey
        if v271.UserInputType == Enum.UserInputType.Keyboard then
            local KeyCode = v271.KeyCode
            if v244 then
                if KeyCode == Enum.KeyCode.Escape then
                    local v273 = v244
                    v244 = nil
                    refreshKeyDisplay(v273)
                    releaseCaptureFocus(v273)
                elseif KeyCode ~= Enum.KeyCode.Unknown then
                    local v274 = v244
                    v244 = nil
                    LocalPlayer:SetAttribute("AdminKey_" .. v274, KeyCode.Name)
                    refreshKeyDisplay(v274)
                    releaseCaptureFocus(v274)
                    if v28 and Sound then
                        Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                        SoundService:PlayLocalSound(Sound)
                    end
                end
            else
                local v275, v276
                if v272 or UserInputService:GetFocusedTextBox() then
                    v276 = true
                else
                    v275 = actionForKey(KeyCode.Name)
                    if v275 and v242[v275] then
                        if v28 and Sound then
                            Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                            SoundService:PlayLocalSound(Sound)
                        end
                        v276 = false
                    else
                        v276 = true
                    end
                end
                if not v276 then
                    v242[v275]()
                end
            end
        end
    end)
end
v242.TogglePanel = togglePanel
do
    local Holder = AdminPanelSettings:FindFirstChild("Holder")
    local v277 = Holder and Holder:FindFirstChild("ColorSwatches")
    local v278 = {}

    local function refreshSwatches() -- line 1379 | captures: v106, v278
        for v279, v280 in pairs(v278) do
            local v281 = v279 == v106
            if v281 then
                v280.Thickness = 3
            else
                v280.Thickness = 1
            end
            v280.Color = v281 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0)
            if v281 then
                v280.Transparency = 0
            else
                v280.Transparency = 0.45
            end
        end
    end

    if v277 then
        for v282, v283 in ipairs(v277:GetChildren()) do
            if v283:IsA("ImageButton") then
                local v284 = v283:GetAttribute("SwatchName") or v283.Name:gsub("Swatch_", "")
                v278[v284] = v283:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke", v283)
                v283.MouseButton1Click:Connect(function() -- line 1402 | captures: v28, v29, ThemeGradient_2, ThemeGradient_4, ThemeGradient_6, v106, v107, v108, v113, SoundService, LocalPlayer, Sound, shades, paintButton, v105, rainbow, refreshSwatches, v284
                    v106 = v284
                    LocalPlayer:SetAttribute("AdminThemeName", v284)
                    local v285
                    if v106 == "RGB" then
                        v285 = rainbow(v107)
                    else
                        local v286 = v105[v106] or Color3.fromRGB(45, 120, 255)
                        v285 = shades(v286)
                    end
                    ThemeGradient_2.Color = v285
                    ThemeGradient_4.Color = v285
                    v113.Color = v285
                    ThemeGradient_6.Color = v285
                    if v108 then
                        paintButton(v108, v285)
                    end
                    refreshSwatches()
                    if not (v28 and Sound) then
                        return
                    end
                    Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                    SoundService:PlayLocalSound(Sound)
                end)
            end
        end
        refreshSwatches()
    end

    local function wireToggle(v287, v288, v289) -- line 1432 | captures: v28, v29, SoundService, firstOfClass, Sound, animate, Holder
        local v290 = Holder and Holder:FindFirstChild(v287)
        local v291 = v290 and firstOfClass(v290, "GuiButton")
        if not v291 then
            return
        end
        local v292 = v288

        local function refresh_2() -- line 1440 | captures: v292, v291
            local v293 = if v292 then "ON" else "OFF"
            local Label = v291:FindFirstChild("Label")
            if Label then
                Label.Text = v293
            end
        end

        local v294 = if v292 then "ON" else "OFF"
        local Label = v291:FindFirstChild("Label")
        if Label then
            Label.Text = v294
        end
        animate(v291)
        v291.MouseButton1Click:Connect(function() -- line 1456 | captures: v292, v289, v291, v28, v29, SoundService, Sound
            v292 = not v292
            local v295 = if v292 then "ON" else "OFF"
            local Label = v291:FindFirstChild("Label")
            if Label then
                Label.Text = v295
            end
            v289(v292)
            if not (v292 and v28 and Sound) then
                return
            end
            Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
            SoundService:PlayLocalSound(Sound)
        end)
    end

    wireToggle("PanelSoundsRow", true, function(v296) -- line 1476 | captures: v28
        v28 = v296
    end)
    wireToggle("ShowPopupsRow", true, function(v297) -- line 1484 | captures: v31
        v31 = v297
    end)
    local v298 = Holder and Holder:FindFirstChild("SfxVolumeRow")
    if v298 and v298:FindFirstChild("Layout") then
        local v299 = v1(LocalPlayer:GetAttribute("AdminSfxVolume"))
        if v299 then
            v29 = math.clamp(v299, 0, 1)
        end
        local Frame = Instance.new("Frame")
        Frame.Name = "VolumeTrack"
        Frame.AnchorPoint = Vector2.new(1, 0.5)
        Frame.Position = UDim2.new(0.97, 0, 0.5, 0)
        Frame.Size = UDim2.new(0.5, 0, 0.26, 0)
        Frame.BackgroundColor3 = Color3.fromRGB(20, 22, 34)
        Frame.BorderSizePixel = 0
        Frame.ZIndex = 6
        Frame.Parent = v298
        Instance.new("UICorner", Frame).CornerRadius = UDim.new(1, 0)
        local SwatchName = Instance.new("UIStroke", Frame)
        SwatchName.Thickness = 2
        SwatchName.Color = Color3.fromRGB(0, 0, 0)
        local Frame_2 = Instance.new("Frame")
        Frame_2.Name = "Fill"
        Frame_2.Size = UDim2.new(v29, 0, 1, 0)
        Frame_2.BackgroundColor3 = Color3.fromRGB(80, 180, 255)
        Frame_2.BorderSizePixel = 0
        Frame_2.ZIndex = 7
        Frame_2.Parent = Frame
        Instance.new("UICorner", Frame_2).CornerRadius = UDim.new(1, 0)
        local Frame_3 = Instance.new("Frame")
        Frame_3.Name = "Knob"
        Frame_3.AnchorPoint = Vector2.new(0.5, 0.5)
        Frame_3.Position = UDim2.new(v29, 0, 0.5, 0)
        Frame_3.Size = UDim2.new(0, 0, 1.6, 0)
        Frame_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Frame_3.BorderSizePixel = 0
        Frame_3.ZIndex = 8
        Frame_3.Parent = Frame
        Instance.new("UICorner", Frame_3).CornerRadius = UDim.new(1, 0)
        Instance.new("UIAspectRatioConstraint", Frame_3).AspectRatio = 1
        local v300 = Instance.new("UIStroke", Frame_3)
        v300.Thickness = 2
        v300.Color = Color3.fromRGB(0, 0, 0)
        local TextButton = Instance.new("TextButton")
        TextButton.BackgroundTransparency = 1
        TextButton.Text = ""
        TextButton.Size = UDim2.fromScale(1.1, 3)
        TextButton.Position = UDim2.fromScale(0.5, 0.5)
        TextButton.AnchorPoint = Vector2.new(0.5, 0.5)
        TextButton.ZIndex = 9
        TextButton.Parent = Frame
        local v301 = false

        local function setFromX(v302) -- line 1544 | captures: v29, LocalPlayer, Frame, Frame_2, Frame_3
            local v303 = v302 - Frame.AbsolutePosition.X
            local X = Frame.AbsoluteSize.X
            local v304 = v303 / math.max(X, 1)
            local v305 = math.clamp(v304, 0, 1)
            v29 = v305
            Frame_2.Size = UDim2.new(v305, 0, 1, 0)
            Frame_3.Position = UDim2.new(v305, 0, 0.5, 0)
            LocalPlayer:SetAttribute("AdminSfxVolume", v305)
        end

        TextButton.InputBegan:Connect(function(v306) -- line 1553 | captures: v28, v29, v301, SoundService, Sound, setFromX
            if v306.UserInputType ~= Enum.UserInputType.MouseButton1 and v306.UserInputType ~= Enum.UserInputType.Touch then
                return
            end
            v301 = true
            setFromX(v306.Position.X)
            if v28 and Sound then
                Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                SoundService:PlayLocalSound(Sound)
            end
        end)
        UserInputService.InputChanged:Connect(function(v307) -- line 1568 | captures: v301, setFromX
            if not v301 or v307.UserInputType ~= Enum.UserInputType.MouseMovement and v307.UserInputType ~= Enum.UserInputType.Touch then
                return
            end
            setFromX(v307.Position.X)
        end)
        UserInputService.InputEnded:Connect(function(v308) -- line 1577 | captures: v301
            if v308.UserInputType == Enum.UserInputType.MouseButton1 or v308.UserInputType == Enum.UserInputType.Touch then
                v301 = false
            end
        end)
    end
end
animateAll(AdminPanelSettings)
do
    local function numOf(v309) -- line 1587
        local Text = v309 and v309.Text or ""
        return (tonumber(Text))
    end
end
local v310 = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(128, 201, 235)),
    ColorSequenceKeypoint.new(0.63, Color3.fromRGB(79, 146, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 96, 202))
})
local v311 = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 75, 75)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 0, 0))
})
local v312 = Color3.fromRGB(25, 41, 83)
Color3.fromRGB(85, 0, 0)

local function paintToggle(v313, v314) -- line 1595 | captures: v310, v311, v312
    v313.BackgroundColor3 = v312
    local v315 = v314 and v310 or v311
    for v316, v317 in ipairs(v313:GetDescendants()) do
        if v317:IsA("UIGradient") then
            v317.Color = v315
        end
    end
end

local function makeToggle(v318, v319, v320, v321) -- line 1605 | captures: v28, v29, SoundService, firstOfClass, Sound, animate, paintToggle
    local v322 = v318 and firstOfClass(v318, "TextButton")
    if v322 then
        local v323 = v321 or false

        local function refresh_3() -- line 1615 | captures: v323, v319, v322, paintToggle
            local Label = v322:FindFirstChild("Label")
            if Label then
                Label.Text = v319
            end
            paintToggle(v322, v323)
        end

        local v324 = if not v323 or not v319 then v320 else v319
        local Label = v322:FindFirstChild("Label")
        if Label then
            Label.Text = v324
        end
        paintToggle(v322, v323)
        animate(v322)
        v322.MouseButton1Click:Connect(function() -- line 1631 | captures: v323, v319, v320, v322, v28, v29, SoundService, Sound, paintToggle
            v323 = not v323
            local v325 = v323 and v319 or v320
            local Label = v322:FindFirstChild("Label")
            if Label then
                Label.Text = v325
            end
            paintToggle(v322, v323)
            if not (v28 and Sound) then
                return
            end
            Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
            SoundService:PlayLocalSound(Sound)
        end)
        return function() -- line 1647 | captures: v323
            return v323
        end
    end
    return function() -- line 1609 | captures: v321
        return v321
    end
end

local function buildList(v326, v327, v328, v329) -- line 1653 | captures: v28, v29, SoundService, Sound
    local v330 = v326:FindFirstChild(v329 or "StageChooser")
    if v330 then
        local Template = v330:FindFirstChild("Template")
        if Template then
            Template.Visible = false
        end
        for v331, v332 in ipairs(v330:GetChildren()) do
            if v332:IsA("Frame") and v332.Name ~= "Template" then
                v332:Destroy()
            end
        end
        local v333 = {}
        local v334

        local function select_upv_1(v335, v336) -- line 1671 | captures: v334, v328, v333
            v334 = v335
            for v337, v338 in ipairs(v333) do
                local SelStroke = v338:FindFirstChild("SelStroke")
                if SelStroke then
                    SelStroke.Enabled = v338 == v336
                end
            end
            if v328 then
                v328(v335)
            end
        end

        for v339, v340 in ipairs(v327) do
            if Template then
                local v341 = Template:Clone()
                v341.Name = "Row"
                v341.Visible = true
                v341:SetAttribute("ListLabel", v340.label)
                local Layout = v341:FindFirstChild("Layout")
                local v342 = Layout and Layout:FindFirstChild("Label")
                if v342 then
                    v342.Text = v340.label
                end
                local UIStroke = Instance.new("UIStroke")
                UIStroke.Name = "SelStroke"
                UIStroke.Thickness = 3
                UIStroke.Color = Color3.fromRGB(255, 255, 255)
                UIStroke.Enabled = false
                UIStroke.Parent = v341
                local TextButton = Instance.new("TextButton")
                TextButton.Name = "ClickHit"
                TextButton.BackgroundTransparency = 1
                TextButton.Text = ""
                TextButton.Size = UDim2.fromScale(1, 1)
                TextButton.ZIndex = 50
                TextButton.Parent = v341
                local MouseButton1Click = TextButton.MouseButton1Click
                local v343 = v340
                MouseButton1Click:Connect(function() -- line 1712 | captures: select_upv_1, v341, v343, v28, v29, SoundService, Sound
                    select_upv_1(v343.key, v341)
                    if v28 and Sound then
                        Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                        SoundService:PlayLocalSound(Sound)
                    end
                end)
                v341.Parent = v330
                v333[#v333 + 1] = v341
            end
        end
        local v344 = {
            getSelected = function() -- getSelected | line 1726 | captures: v334
                return v334
            end
        }

        function v344.filter(v345) -- line 1730 | captures: v333
            local v346 = (v345 or ""):lower()
            for v347, v348 in ipairs(v333) do
                local v349 = (v348:GetAttribute("ListLabel") or ""):lower()
                if v346 == "" then
                    v348.Visible = true
                else
                    v348.Visible = v349:find(v346, 1, true) ~= nil
                end
            end
        end

        return v344
    end
    local v350 = {
        getSelected = 0,
        filter = 0
    }

    function v350.getSelected() -- line 1746
    end

    function v350.filter() -- line 1749
    end

    return v350
end

do
    local function fire(v351) -- line 1755 | captures: v7
        v7:FireServer(v351)
    end
end
v7.OnClientEvent:Connect(function(v352, v353) -- line 1760 | captures: v31, LocalPlayer, v32, v33, showToast
    if not (v352 == "prompt" and typeof(v353) == "number") then
        if typeof(v353) == "string" and v353 ~= "" then
            if v352 then
                if v31 then
                    showToast(v353, v32)
                end
            elseif v31 then
                showToast(v353, v33)
            end
        end
    else
        local MarketplaceService = game:GetService("MarketplaceService")
        pcall(MarketplaceService.PromptGamePassPurchase, MarketplaceService, LocalPlayer, v353)
    end
end)
local Morph = v122.Main and v122.Main:FindFirstChild("Passes")
local v354 = {
    {
        attr = "HasBeOwner",
        name = "BeOwner",
        promptKind = "PromptBeOwner"
    },
    {
        attr = "HasAdminPlus",
        name = "AdminPlus",
        promptKind = "PromptAdminPlus"
    },
    {
        attr = "HasHDAdminVIP",
        name = "HDAdmin",
        promptKind = "PromptHDAdmin"
    },
    {
        attr = "HasNoCooldowns",
        name = "NoCooldowns",
        promptKind = "PromptNoCooldowns"
    }
}
for v355, v356 in ipairs(v354) do
    local v357 = Morph and Morph:FindFirstChild(v356.name)
    if v357 and v357:IsA("GuiButton") then
        local MouseButton1Click = v357.MouseButton1Click
        local v358 = v356
        MouseButton1Click:Connect(function() -- line 1788 | captures: v7, v358
            v7:FireServer({ kind = v358.promptKind })
        end)
        local Label = v357:FindFirstChild("Label")
        if Label and Label:IsA("TextLabel") then
            local Text = Label.Text

            local function reflectOwned() -- line 1799 | captures: Label, Text
                Label.Text = Text
            end

            reflectOwned()
            LocalPlayer:GetAttributeChangedSignal(v356.attr):Connect(reflectOwned)
        end
    end
end
local InputBegan = v122.Main and v122.Main:FindFirstChild("InfoRow")

local function firstButton(v359) -- line 1808 | captures: firstOfClass
    local v360, v361
    if v359 then
        if v359:IsA("GuiButton") then
            v360 = v359
            v361 = true
        else
            v361 = false
        end
    else
        v360 = v359
        v361 = true
    end
    if not v361 then
        v360 = firstOfClass(v359, "GuiButton")
    end
    return v360
end

do
    local v362 = InputBegan and firstButton(InputBegan)

    local function openPassInfo() -- line 1814 | captures: v213, TweenService, AdminPanel, AdminPanelPassInfo, v228, v229
        AdminPanel.Visible = false
        local Scroller = AdminPanelPassInfo.Holder:FindFirstChild("Scroller")
        if Scroller then
            Scroller.CanvasPosition = Vector2.new(0, 0)
        end
        AdminPanelPassInfo.Position = v229
        AdminPanelPassInfo.Visible = true
        local v363 = { Position = v228 }
        TweenService:Create(AdminPanelPassInfo, v213, v363):Play()
    end

    if v362 then
        v362.MouseButton1Click:Connect(function() -- line 1829 | captures: v28, v29, SoundService, Sound, openPassInfo
            if v28 and Sound then
                Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                SoundService:PlayLocalSound(Sound)
            end
            openPassInfo()
        end)
    end
end
do
    local Scroller = AdminPanelPassInfo.Holder:FindFirstChild("Scroller")
    for v364, v365 in ipairs(v354) do
        local v366 = Scroller and Scroller:FindFirstChild(v365.name)
        local v367 = v366 and v366:FindFirstChild("Status")
        if v367 then
            local v368 = v365

            local function reflectOwned_2() -- line 1844 | captures: LocalPlayer, v367, v368
                local v369 = if LocalPlayer:GetAttribute(v368.attr) == true then "FREE" else ""
                v367.Text = v369
            end

            reflectOwned_2()
            LocalPlayer:GetAttributeChangedSignal(v365.attr):Connect(reflectOwned_2)
        end
    end
end

local function buttonByLabel(v370, v371) -- line 1853 | captures: allButtons
    if v370 then
        local v372 = v371:lower()
        local v373 = allButtons(v370)
        for v374, v375 in ipairs(v373) do
            local Label = v375:FindFirstChild("Label")
            if Label and Label:IsA("TextLabel") and Label.Text:lower() == v372 then
                return v375
            end
        end
        for v376, v377 in ipairs(v373) do
            local Label = v377:FindFirstChild("Label")
            if Label and Label:IsA("TextLabel") and Label.Text:lower():find(v372, 1, true) then
                return v377
            end
        end
    else
        return nil
    end
end

local function firstTextBox(v378) -- line 1875 | captures: firstOfClass
    return v378 and firstOfClass(v378, "TextBox")
end

local SetToRow
local v379
local Reset
local Reset_2
local CustomEgg
local v380

if v122.Morph then
    Morph = v122.Morph
    local v381 = firstTextBox(Morph:FindFirstChild("NewNameRow"))
    local v382 = makeToggle(Morph:FindFirstChild("VerifiedBadgeRow"), "ON", "OFF", false)
    local v383 = firstTextBox(Morph:FindFirstChild("MorphAsRow"))
    local v384 = firstTextBox(Morph:FindFirstChild("SetToRow"))
    local v385 = makeToggle(Morph:FindFirstChild("KeepAfterDeathRow"), "ON", "OFF", false)
    v2[1] = nil
    local v386
    for v387, v388 in ipairs(Morph:GetChildren()) do
        if v388:IsA("TextLabel") and v388.Name == "TextIgnore" and v388.Text:match("^%s*Current") then
            v2[1] = v388
            v386 = v388
        end
    end
    if v386 then
        local refreshCurrent = (function(v389)
            local function refreshCurrent() -- line 1897 | captures: v389, LocalPlayer
                local AdminCustomName = LocalPlayer:GetAttribute("AdminCustomName")
                if typeof(AdminCustomName) ~= "string" or AdminCustomName == "" then
                    AdminCustomName = LocalPlayer.DisplayName
                end
                v389[1].Text = "Current: " .. tostring(AdminCustomName)
            end

            return refreshCurrent
        end)(v2)
        refreshCurrent()
        LocalPlayer:GetAttributeChangedSignal("AdminCustomName"):Connect(refreshCurrent)
        LocalPlayer.CharacterAdded:Connect(((function(v390)
            return function() -- line 1908 | captures: v390, LocalPlayer
                task.wait(0.3)
                local AdminCustomName = LocalPlayer:GetAttribute("AdminCustomName")
                if typeof(AdminCustomName) ~= "string" or AdminCustomName == "" then
                    AdminCustomName = LocalPlayer.DisplayName
                end
                v390[1].Text = "Current: " .. tostring(AdminCustomName)
            end
        end)(v2)))
    end
    SetToRow = Morph:FindFirstChild("SetToRow")
    v379 = SetToRow and SetToRow:FindFirstChild("Layout")

    local function stepSize(v391) -- line 1922 | captures: v384
        if not v384 then
            return
        end
        local Text = v384 and v384.Text or ""
        local v392 = (tonumber(Text) or 1) + v391
        local v393 = math.clamp(v392, 0.2, 5) * 10 + 0.5
        local v394 = math.floor(v393) / 10
        v384.Text = tostring(v394)
    end

    local v395 = v379 and SetToRow:FindFirstChild("SizeMinus", true)
    CustomEgg = SetToRow and SetToRow:FindFirstChild("SizePlus", true)
    if v395 and v395:IsA("GuiButton") then
        animate(v395)
        v395.MouseButton1Click:Connect(function() -- line 1934 | captures: v28, v29, SoundService, Sound, v384
            if v28 and Sound then
                Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                SoundService:PlayLocalSound(Sound)
            end
            if not v384 then
                return
            end
            local Text = v384 and v384.Text or ""
            local v396 = (tonumber(Text) or 1) + -0.1
            local v397 = math.clamp(v396, 0.2, 5) * 10 + 0.5
            local v398 = math.floor(v397) / 10
            v384.Text = tostring(v398)
        end)
    end
    if CustomEgg and CustomEgg:IsA("GuiButton") then
        animate(CustomEgg)
        CustomEgg.MouseButton1Click:Connect(function() -- line 1950 | captures: v28, v29, SoundService, Sound, v384
            if v28 and Sound then
                Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                SoundService:PlayLocalSound(Sound)
            end
            if not v384 then
                return
            end
            local Text = v384 and v384.Text or ""
            local v399 = (tonumber(Text) or 1) + 0.1
            local v400 = math.clamp(v399, 0.2, 5) * 10 + 0.5
            local v401 = math.floor(v400) / 10
            v384.Text = tostring(v401)
        end)
    end
    local MouseButton1Click = Morph:FindFirstChild("SETBtnRow")
    if MouseButton1Click then
        local MouseButton1Click_2 = buttonByLabel(MouseButton1Click, "SET")
        Reset = buttonByLabel(MouseButton1Click, "Reset")
        if MouseButton1Click_2 then
            MouseButton1Click_2.MouseButton1Click:Connect(function() -- line 1970 | captures: v31, v7, v33, showToast, v381, v382
                local Text = v381 and v381.Text or ""
                if Text == "" then
                    if v31 then
                        showToast("Enter a display name!", v33)
                    end
                else
                    local v402 = {
                        kind = "SetDisplayName",
                        verified = 0
                    }
                    v402.value = Text
                    if v382() then
                        v402.verified = "yes"
                    else
                        v402.verified = "no"
                    end
                    v7:FireServer(v402)
                end
            end)
        end
        if Reset then
            Reset.MouseButton1Click:Connect(function() -- line 1986 | captures: v7
                v7:FireServer({ kind = "ResetDisplayName" })
            end)
        end
    end
    Reset = Morph:FindFirstChild("SETBtnRow3")
    local Reset_3, MouseButton1Click_2
    if Reset then
        MouseButton1Click_2 = buttonByLabel(Reset, "SET")
        Reset_3 = buttonByLabel(Reset, "Reset")
        if MouseButton1Click_2 then
            MouseButton1Click_2.MouseButton1Click:Connect(function() -- line 2000 | captures: v31, v7, v32, v33, showToast, v383
                local Text = v383 and v383.Text or ""
                if Text == "" then
                    if v31 then
                        showToast("Enter a username!", v33)
                    end
                else
                    v7:FireServer({
                        kind = "MorphAppearance",
                        keep = false,
                        value = Text
                    })
                    if v31 then
                        showToast("Morphing into " .. Text .. "...", v32)
                    end
                end
            end)
        end
        if Reset_3 then
            Reset_3.MouseButton1Click:Connect(function() -- line 2016 | captures: v7
                v7:FireServer({ kind = "Unmorph" })
            end)
        end
    end
    Reset_3 = Morph:FindFirstChild("SETBtnRow5")
    if Reset_3 then
        MouseButton1Click_2 = buttonByLabel(Reset_3, "SET")
        Reset_2 = buttonByLabel(Reset_3, "Reset")
        if MouseButton1Click_2 then
            MouseButton1Click_2.MouseButton1Click:Connect(function() -- line 2029 | captures: v31, v7, v33, showToast, v384, v385
                local Text = v384 and v384.Text or ""
                local v403 = tonumber(Text)
                if v403 then
                    local v404 = math.clamp(v403, 0.2, 5)
                    if v384 then
                        v384.Text = tostring(v404)
                    end
                    v7:FireServer({
                        kind = "SetSize",
                        value = v404,
                        keep = v385()
                    })
                elseif v31 then
                    showToast("Enter a size number!", v33)
                end
            end)
        end
        if Reset_2 then
            Reset_2.MouseButton1Click:Connect(function() -- line 2046 | captures: v7
                v7:FireServer({ kind = "ResetSize" })
            end)
        end
    end
    local v405 = v2[1]
    local v406 = {}
    v406[1] = v405
    v380 = v406
else
    v380 = v2
end
local v407
local v408
local MouseButton1Click_2
local Remove
local SETBtnRow2

if v122.AvatarCreator then
    local AvatarCreator = v122.AvatarCreator
    local v409
    v380[1] = nil
    task.spawn(((function(v410)
        return function() -- line 2060 | captures: v410, v409
            local v411 = workspace:WaitForChild("Avalog", 20)
            local v412 = v411 and v411:WaitForChild("Avalog", 20)
            if v412 then
                local v413, v414 = pcall(require, v412)
                if v413 then
                    if not v414.Started then
                        v414:Start()
                    end
                    v409 = v414
                else
                    warn("[AdminPanelUi] Avalog failed to load: " .. tostring(v414))
                end
                local v415, v416 = pcall(function() -- line 2073 | captures: v411
                    return require(v411.Avalog.Packages.Avalog.SourceCode.Client.Avatar.LocalAvatar)
                end)
                if v415 then
                    v410[1] = v416
                end
            else
                warn("[AdminPanelUi] Avalog not found in Workspace - Avatar Editor button will report it")
            end
        end
    end)(v380)))
    v408 = AvatarCreator:FindFirstChild("ResetToDefaultAvatarBtnRow")
    local v417 = v408 and firstButton(v408)
    if v417 then
        v417.MouseButton1Click:Connect(function() -- line 2090 | captures: v7
            v7:FireServer({ kind = "Unmorph" })
        end)
    end
    local v418 = AvatarCreator:FindFirstChild("OpenAvatarEditorBtnRow")
    local v419 = v418 and firstButton(v418)
    v407 = v419
    if v419 then
        v419.MouseButton1Click:Connect(((function(v420)
            return function() -- line 2100 | captures: v420, v31, v409, LocalPlayer, v33, showToast, closePanel
                if v409 then
                    closePanel()
                    if v420[1] and LocalPlayer.Character then
                        pcall(((function(v421)
                            return function() -- line 2106 | captures: v421, LocalPlayer
                                v421[1]:SetCharacter(LocalPlayer.Character)
                            end
                        end)(v420)))
                    end
                    if not pcall(function() -- line 2113 | captures: v409
                            v409:SetOpen(true)
                        end) and
                        v31 then
                        showToast("Couldn't open the Avatar Editor.", v33)
                    end
                elseif v31 then
                    showToast("Avatar Editor isn't ready yet - try again in a moment.", v33)
                end
            end
        end)(v380)))
    end
    MouseButton1Click_2 = AvatarCreator:FindFirstChild("SHOWBUTTONBtnRow")
    if MouseButton1Click_2 then
        SetToRow = buttonByLabel(MouseButton1Click_2, "SHOW BUTTON")
        local v422 = buttonByLabel(MouseButton1Click_2, "HIDE BUTTON")
        if SetToRow then
            SetToRow.MouseButton1Click:Connect(function() -- line 2133 | captures: v31, LocalPlayer, v32, showToast
                LocalPlayer:SetAttribute("AvalogTopbarHidden", false)
                if v31 then
                    showToast("Avatar Editor button shown", v32)
                end
            end)
        end
        if v422 then
            v422.MouseButton1Click:Connect(function() -- line 2145 | captures: v31, LocalPlayer, v32, showToast
                LocalPlayer:SetAttribute("AvalogTopbarHidden", true)
                if v31 then
                    showToast("Avatar Editor button hidden", v32)
                end
            end)
        end
    end
    local v423, v424
    v379, v424 = pcall(function() -- line 2158 | captures: ReplicatedStorage
        return require(ReplicatedStorage.Shared.Save)
    end)
    if v379 then
        v423 = v424
    end
    local v425 = buildList(AvatarCreator, {}, nil, "OutfitChooser")

    local function readOutfitNames() -- line 2167 | captures: v423
        local v426 = {}
        if v423 and v423.Get then
            local v427, v428 = pcall(function() -- line 2174 | captures: v423
                return v423.Get()
            end)
            if v427 and type(v428) == "table" then
                local SavedOutfits = v428.SavedOutfits
                if type(SavedOutfits) == "table" then
                    for v429, v430 in ipairs(v428.SavedOutfits) do
                        if type(v430) == "table" then
                            local name = v430.name
                            if type(name) == "string" then
                                v426[#v426 + 1] = {
                                    key = v430.name,
                                    label = v430.name
                                }
                            end
                        end
                    end
                end
            end
        end
        return v426
    end

    local function refreshOutfits() -- line 2191 | captures: v425, buildList, AvatarCreator, readOutfitNames
        v425 = buildList(AvatarCreator, readOutfitNames(), nil, "OutfitChooser")
    end

    refreshOutfits()
    local MouseButton1Click
    if v423 and v423.FieldSignal then
        Reset_2, MouseButton1Click = pcall(function() -- line 2201 | captures: v423
            return v423.FieldSignal("SavedOutfits")
        end)
        if Reset_2 and MouseButton1Click and MouseButton1Click.Connect then
            MouseButton1Click:Connect(function() -- line 2208 | captures: refreshOutfits
                task.defer(refreshOutfits)
            end)
        end
    end
    task.delay(5, refreshOutfits)
    SETBtnRow2 = AvatarCreator:FindFirstChild("SaveOutfit")
    Reset = SETBtnRow2 and firstButton(SETBtnRow2)
    if Reset then
        Reset.MouseButton1Click:Connect(function() -- line 2221 | captures: v7
            v7:FireServer({ kind = "SaveOutfit" })
        end)
    end
    Reset_2 = AvatarCreator:FindFirstChild("EquipBtnRow")
    if Reset_2 then
        MouseButton1Click = buttonByLabel(Reset_2, "Equip")
        Remove = buttonByLabel(Reset_2, "Remove")
        if MouseButton1Click then
            MouseButton1Click.MouseButton1Click:Connect(function() -- line 2234 | captures: v31, v425, v7, v33, showToast
                local v431 = v425.getSelected()
                if v431 then
                    v7:FireServer({
                        kind = "EquipOutfit",
                        value = v431
                    })
                elseif v31 then
                    showToast("Pick a saved outfit first!", v33)
                end
            end)
        end
        if Remove then
            Remove.MouseButton1Click:Connect(function() -- line 2247 | captures: v31, v425, v7, v33, showToast
                local v432 = v425.getSelected()
                if v432 then
                    v7:FireServer({
                        kind = "DeleteOutfit",
                        value = v432
                    })
                elseif v31 then
                    showToast("Pick a saved outfit first!", v33)
                end
            end)
        end
    end
    local v433 = v380[1]
end

if v122.Statistics then
    local Statistics = v122.Statistics

    local function wireStatRow(v434, v435, v436) -- line 2262 | captures: v31, v7, firstOfClass, v33, showToast, buttonByLabel, Statistics
        local v437 = Statistics:FindFirstChild(v434)
        if not v437 then
            return
        end
        local v438 = firstOfClass(v437, "TextBox")
        local SET = buttonByLabel(v437, "SET")
        local ADD = buttonByLabel(v437, "ADD")

        local function send_1(v439) -- line 2271 | captures: v438, v31, v7, v33, showToast
            local Text = v438 and v438.Text or ""
            local v440 = tonumber(Text)
            if v440 then
                v7:FireServer({
                    kind = v439,
                    value = v440
                })
            elseif v31 then
                showToast("Type a number first!", v33)
            end
        end

        if SET then
            SET.MouseButton1Click:Connect(function() -- line 2282 | captures: v435, v438, v31, v7, v33, showToast
                local Text = v438 and v438.Text or ""
                local v441 = tonumber(Text)
                if v441 then
                    v7:FireServer({
                        kind = v435,
                        value = v441
                    })
                elseif v31 then
                    showToast("Type a number first!", v33)
                end
            end)
        end
        if ADD then
            ADD.MouseButton1Click:Connect(function() -- line 2297 | captures: v436, v438, v31, v7, v33, showToast
                local Text = v438 and v438.Text or ""
                local v442 = tonumber(Text)
                if v442 then
                    v7:FireServer({
                        kind = v436,
                        value = v442
                    })
                elseif v31 then
                    showToast("Type a number first!", v33)
                end
            end)
        end
    end

    wireStatRow("WalkSpeedRow", "SetSpeed", "AddSpeed")
    wireStatRow("SpeedXPRow", "SetMoney", "AddMoney")
    wireStatRow("BaseLevelRow", "SetBaseLevel", "AddBaseLevel")
    wireStatRow("MultiplierRow", "SetTreadmillLevel", "AddTreadmillLevel")
    local ResetAllDataBtnRow = Statistics:FindFirstChild("ResetAllDataBtnRow")
    v408 = ResetAllDataBtnRow and firstButton(ResetAllDataBtnRow)
    if v408 then
        local v443 = labelOf(v408)
        v443 = v443 and v443:IsA("TextLabel") and v443.Text or "Reset All Data"
        v407 = false
        local v444 = 0
        MouseButton1Click_2 = v408.MouseButton1Click
        local v445 = v443
        MouseButton1Click_2:Connect(function() -- line 2321 | captures: v31, v407, v444, v7, v33, showToast, ResetAllDataBtnRow, v445
            v444 += 1
            if v407 then
                v407 = false
                local Label = ResetAllDataBtnRow:FindFirstChild("Label")
                if Label then
                    Label.Text = v445
                end
                v7:FireServer({ kind = "ResetAllData" })
            else
                v407 = true
                local v446 = v444
                local Label = ResetAllDataBtnRow:FindFirstChild("Label")
                if Label then
                    Label.Text = "Click again to confirm"
                end
                if v31 then
                    showToast("This wipes ALL your progress - click again to confirm.", v33)
                end
                task.delay(5, function() -- line 2344 | captures: v446, v407, v444, ResetAllDataBtnRow, v445
                    if not (v407 and v444 == v446) then
                        return
                    end
                    v407 = false
                    local Label = ResetAllDataBtnRow:FindFirstChild("Label")
                    if not Label then
                        return
                    end
                    Label.Text = v445
                end)
            end
        end)
    end
end
local v447 = { Thickness = 2 }

v447.Color = Color3.fromRGB(0, 0, 0)

local v448 = { Thickness = 4 }

v448.Color = Color3.fromRGB(255, 225, 90)
do
    local function paintCell(v449, v450) -- line 2368 | captures: v448
        local SelectStroke = v449:FindFirstChild("SelectStroke")
        if SelectStroke then
            SelectStroke.Thickness = v448.Thickness
            SelectStroke.Color = v448.Color
        end
    end
end
local v451 = {}

local function wireCellPicker(v452, v453, v454, v455, v456) -- line 2378 | captures: v28, v29, SoundService, firstOfClass, Sound, v447, v448, v451
    local v457 = v452:FindFirstChild(v453)
    local v458 = v457 and firstOfClass(v457, "TextButton")
    local v459

    local function pick_upv_1(v460) -- line 2383 | captures: v459, v455, v456, v458, v28, v29, SoundService, Sound, v447, v448
        for v461, v462 in ipairs(v456:GetChildren()) do
            if v462:IsA("ImageButton") then
                local SelectStroke = v462:FindFirstChild("SelectStroke")
                if SelectStroke then
                    SelectStroke.Thickness = v447.Thickness
                    SelectStroke.Color = v447.Color
                end
            end
        end
        v459 = v460
        local SelectStroke = v460:FindFirstChild("SelectStroke")
        if SelectStroke then
            local v463 = v448 or v447
            SelectStroke.Thickness = v463.Thickness
            SelectStroke.Color = v463.Color
        end
        if v458 then
            local Name = v460.Name
            local Label = v458:FindFirstChild("Label")
            if Label then
                Label.Text = Name
            end
        end
        if v28 and Sound then
            Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
            SoundService:PlayLocalSound(Sound)
        end
        v455()
    end

    if not v451[v456] then
        local v464 = {}
        v451[v456] = v464
        for v465, v466 in ipairs(v456:GetChildren()) do
            if v466:IsA("ImageButton") then
                local MouseButton1Click = v466.MouseButton1Click
                local v467 = v466
                MouseButton1Click:Connect(function() -- line 2422 | captures: v464, v467
                    if v464.active then
                        v464.active(v467)
                    end
                end)
            end
        end
    end
    local v468 = v451[v456]
    if v458 then
        v458.MouseButton1Click:Connect(function() -- line 2436 | captures: v459, v468, v454, v456, pick_upv_1, v28, v29, SoundService, Sound, v447, v448
            v468.active = pick_upv_1
            for v469, v470 in ipairs(v456:GetChildren()) do
                if v470:IsA("ImageButton") then
                    local v471 = v470 == v459
                    local SelectStroke = v470:FindFirstChild("SelectStroke")
                    if SelectStroke then
                        local v472 = v471 and v448 or v447
                        SelectStroke.Thickness = v472.Thickness
                        SelectStroke.Color = v472.Color
                    end
                end
            end
            if v28 and Sound then
                Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                SoundService:PlayLocalSound(Sound)
            end
            v454()
        end)
    end

    local function reset_1() -- line 2459 | captures: v459, v458, v447
        if v459 then
            local SelectStroke = v459:FindFirstChild("SelectStroke")
            if SelectStroke then
                SelectStroke.Thickness = v447.Thickness
                SelectStroke.Color = v447.Color
            end
        end
        v459 = nil
        if not v458 then
            return
        end
        local Label = v458:FindFirstChild("Label")
        if not Label then
            return
        end
        Label.Text = "SELECT"
    end

    return function() -- line 2478 | captures: v459
            return v459 and v459.Name or nil
        end,
        reset_1
end

local function openPetIconPicker() -- line 2486 | captures: v213, TweenService, AdminPanel, AdminPanelPetIconPicker, v228, v229
    AdminPanel.Visible = false
    AdminPanelPetIconPicker.Position = v229
    AdminPanelPetIconPicker.Visible = true
    local v473 = { Position = v228 }
    TweenService:Create(AdminPanelPetIconPicker, v213, v473):Play()
end

local function openPetPicker() -- line 2495 | captures: v213, TweenService, AdminPanel, AdminPanelPetPicker, v228, v229
    AdminPanel.Visible = false
    AdminPanelPetPicker.Position = v229
    AdminPanelPetPicker.Visible = true
    local v474 = { Position = v228 }
    TweenService:Create(AdminPanelPetPicker, v213, v474):Play()
end

local v475
local Reset_3
local SETBtnRow4
local Reset_4
local MouseButton1Click_3

if v122.Morph then
    local Morph = v122.Morph
    local v476, v477 = wireCellPicker(Morph, "MobMorphRow", openPetIconPicker, closePetIconPicker, AdminPanelPetIconPicker.Holder.Scroller)
    local v478 = makeToggle(Morph:FindFirstChild("KeepAfterDeathRow2"), "ON", "OFF", false)
    SETBtnRow2 = Morph:FindFirstChild("SETBtnRow2")
    if SETBtnRow2 then
        Reset = buttonByLabel(SETBtnRow2, "SET")
        Reset_3 = buttonByLabel(SETBtnRow2, "Reset")
        if Reset then
            Reset.MouseButton1Click:Connect(function() -- line 2515 | captures: v31, v7, v32, v33, showToast, v476, v478
                local v479 = v476()
                if v479 then
                    v7:FireServer({
                        kind = "MorphMob",
                        value = v479,
                        keep = v478()
                    })
                    if v31 then
                        showToast("Morphing into " .. v479 .. "...", v32)
                    end
                elseif v31 then
                    showToast("Pick a pet first!", v33)
                end
            end)
        end
        if Reset_3 then
            Reset_3.MouseButton1Click:Connect(function() -- line 2531 | captures: v7, v477
                v477()
                v7:FireServer({ kind = "UnmorphMob" })
            end)
        end
    end
    local v480, v481 = wireCellPicker(Morph, "EggMorphRow", openPetPicker, closePetPicker, AdminPanelPetPicker.Holder.Scroller)
    local v482 = makeToggle(Morph:FindFirstChild("KeepAfterDeathRow3"), "ON", "OFF", false)
    SETBtnRow4 = Morph:FindFirstChild("SETBtnRow4")
    if SETBtnRow4 then
        v475 = buttonByLabel(SETBtnRow4, "SET")
        Reset_4 = buttonByLabel(SETBtnRow4, "Reset")
        if v475 then
            v475.MouseButton1Click:Connect(function() -- line 2548 | captures: v31, v7, v32, v33, showToast, v480, v482
                local v483 = v480()
                if v483 then
                    v7:FireServer({
                        kind = "MorphEgg",
                        value = v483,
                        keep = v482()
                    })
                    if v31 then
                        showToast("Morphing into " .. v483 .. "...", v32)
                    end
                elseif v31 then
                    showToast("Pick an egg first!", v33)
                end
            end)
        end
        if Reset_4 then
            Reset_4.MouseButton1Click:Connect(function() -- line 2564 | captures: v7, v481
                v481()
                v7:FireServer({ kind = "UnmorphEgg" })
            end)
        end
    end
    Reset_4 = {
        Morph:FindFirstChild("MobMorphRow"),
        Morph:FindFirstChild("KeepAfterDeathRow2"),
        SETBtnRow2
    }
    MouseButton1Click_3 = {
        Morph:FindFirstChild("EggMorphRow"),
        Morph:FindFirstChild("KeepAfterDeathRow3"),
        SETBtnRow4
    }
end

local function openMutationPicker() -- line 2575 | captures: v213, TweenService, AdminPanel, AdminPanelMutationPicker, v228, v229
    AdminPanel.Visible = false
    AdminPanelMutationPicker.Position = v229
    AdminPanelMutationPicker.Visible = true
    local v484 = { Position = v228 }
    TweenService:Create(AdminPanelMutationPicker, v213, v484):Play()
end

local function openEggPicker() -- line 2584 | captures: v213, TweenService, AdminPanel, AdminPanelEggPicker, v228, v229
    AdminPanel.Visible = false
    AdminPanelEggPicker.Position = v229
    AdminPanelEggPicker.Visible = true
    local v485 = { Position = v228 }
    TweenService:Create(AdminPanelEggPicker, v213, v485):Play()
end

local FocusLost
local v486
local MouseButton1Click_4
local FocusLost_2
local v487

if v122.Spawn then
    CustomEgg = v122.Spawn
    local v488, v489 = wireCellPicker(CustomEgg, "BiomeRow", openEggPicker, closeEggPicker, AdminPanelEggPicker.Holder)
    local v490, v491 = wireCellPicker(CustomEgg, "EggRow", openPetPicker, closePetPicker, AdminPanelPetPicker.Holder.Scroller)
    local v492, v493 = wireCellPicker(CustomEgg, "MutationRow", openMutationPicker, closeMutationPicker, AdminPanelMutationPicker.Holder.Scroller)
    Reset_4 = CustomEgg:FindFirstChild("SizeRow")
    local v494 = Reset_4 and firstTextBox(Reset_4)
    v4[1] = 1;
    (function(v495)
        local function getSelectedSize() -- line 2602 | captures: v495
            return v495[1]
        end

        return getSelectedSize
    end)(v4);
    (function(v496)
        local function resetSize() -- line 2606 | captures: v496, v494
            v496[1] = 1
            if v494 then
                v494.Text = ""
            end
        end

        return resetSize
    end)(v4)
    if v494 then
        v494.FocusLost:Connect(((function(v497)
            return function(v498) -- line 2616 | captures: v497, v28, v29, SoundService, Sound, v494
                local Text = v494 and v494.Text or ""
                local v499 = tonumber(Text)
                if v499 then
                    local v500 = math.clamp(v499, 0.1, 8)
                    v497[1] = v500
                    v494.Text = string.format("%.2f", v500)
                    if v498 and v28 and Sound then
                        Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                        SoundService:PlayLocalSound(Sound)
                    end
                else
                    v494.Text = ""
                end
            end
        end)(v4)))
    end
    FocusLost = CustomEgg:FindFirstChild("SpawnEggBtnRow")
    v486 = FocusLost and firstButton(FocusLost)
    if v486 then
        v486.MouseButton1Click:Connect(((function(v501)
            return function() -- line 2637 | captures: v501, v31, v7, v33, showToast, v488, v490, v492
                local v502 = v488()
                local v503 = v490()
                if v502 then
                    if v503 then
                        v7:FireServer({
                            kind = "SpawnEgg",
                            biome = v502,
                            egg = v503,
                            mutation = v492() or "None",
                            size = v501[1]
                        })
                    elseif v31 then
                        showToast("Pick an egg first!", v33)
                    end
                elseif v31 then
                    showToast("Pick a biome first!", v33)
                end
            end
        end)(v4)))
    end
    MouseButton1Click_4 = CustomEgg:FindFirstChild("TeleportToSpawnBtnRow")
    FocusLost_2 = MouseButton1Click_4 and firstButton(MouseButton1Click_4)
    if FocusLost_2 then
        FocusLost_2.MouseButton1Click:Connect(((function(v504)
            return function() -- line 2657 | captures: v504, v28, v29, v31, SoundService, Sound, v32, showToast, v489, v491, v493, v494
                v489()
                v491()
                v493()
                v504[1] = 1
                if v494 then
                    v494.Text = ""
                end
                if v28 and Sound then
                    Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                    SoundService:PlayLocalSound(Sound)
                end
                if v31 then
                    showToast("Spawn form cleared", v32)
                end
            end
        end)(v4)))
    end
    local v505 = v4[1]
    local v506 = {}
    v506[1] = v505
    v487 = v506
else
    v487 = v4
end
local MouseButton1Click_5
local FocusLost_3
local MouseButton1Click_6
local v507
do
    local v508
    local v509
    if v122.EggGiver then
        CustomEgg = v122.EggGiver
        local v510, v511 = wireCellPicker(CustomEgg, "EggRow", openPetPicker, closePetPicker, AdminPanelPetPicker.Holder.Scroller)
        local v512, v513 = wireCellPicker(CustomEgg, "MutationRow", openMutationPicker, closeMutationPicker, AdminPanelMutationPicker.Holder.Scroller)
        Remove = CustomEgg:FindFirstChild("SizeRow")
        local v514 = Remove and firstTextBox(Remove)
        v3[1] = 1;
        (function(v515)
            local function getSelectedSize_2() -- line 2687 | captures: v515
                return v515[1]
            end

            return getSelectedSize_2
        end)(v3);
        (function(v516)
            local function resetSize_2() -- line 2691 | captures: v516, v514
                v516[1] = 1
                if v514 then
                    v514.Text = ""
                end
            end

            return resetSize_2
        end)(v3)
        if v514 then
            v514.FocusLost:Connect(((function(v517)
                return function(v518) -- line 2701 | captures: v517, v28, v29, SoundService, Sound, v514
                    local Text = v514 and v514.Text or ""
                    local v519 = tonumber(Text)
                    if v519 then
                        local v520 = math.clamp(v519, 0.1, 8)
                        v517[1] = v520
                        v514.Text = string.format("%.2f", v520)
                        if v518 and v28 and Sound then
                            Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                            SoundService:PlayLocalSound(Sound)
                        end
                    else
                        v514.Text = ""
                    end
                end
            end)(v3)))
        end
        FocusLost_3 = CustomEgg:FindFirstChild("QuantityRow")
        local v521 = FocusLost_3 and firstTextBox(FocusLost_3)
        v5[1] = 1;
        (function(v522)
            local function getSelectedQuantity() -- line 2721 | captures: v522
                return v522[1]
            end

            return getSelectedQuantity
        end)(v5);
        (function(v523)
            local function resetQuantity() -- line 2725 | captures: v523, v521
                v523[1] = 1
                if v521 then
                    v521.Text = ""
                end
            end

            return resetQuantity
        end)(v5)
        if v521 then
            v521.FocusLost:Connect(((function(v524)
                return function(v525) -- line 2735 | captures: v524, v28, v29, SoundService, Sound, v521
                    local Text = v521 and v521.Text or ""
                    local v526 = tonumber(Text)
                    if v526 then
                        local v527 = v526 + 0.5
                        local v528 = math.floor(v527)
                        local v529 = math.clamp(v528, 1, 3)
                        v524[1] = v529
                        v521.Text = tostring(v529)
                        if v525 and v28 and Sound then
                            Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                            SoundService:PlayLocalSound(Sound)
                        end
                    else
                        v521.Text = ""
                    end
                end
            end)(v5)))
        end
        FocusLost_2 = CustomEgg:FindFirstChild("GiveEggBtnRow")
        MouseButton1Click_5 = FocusLost_2 and firstButton(FocusLost_2)
        if MouseButton1Click_5 then
            MouseButton1Click_5.MouseButton1Click:Connect(((function(v530, v531)
                return function() -- line 2756 | captures: v530, v531, v31, v7, v33, showToast, v510, v512
                    local v532 = v510()
                    if v532 then
                        v7:FireServer({
                            kind = "GiveEgg",
                            egg = v532,
                            mutation = v512() or "None",
                            size = v530[1],
                            quantity = v531[1]
                        })
                    elseif v31 then
                        showToast("Pick an egg first!", v33)
                    end
                end
            end)(v3, v5)))
        end
        MouseButton1Click_6 = CustomEgg:FindFirstChild("TeleportToSpawnBtnRow")
        v507 = MouseButton1Click_6 and firstButton(MouseButton1Click_6)
        if v507 then
            v507.MouseButton1Click:Connect(((function(v533, v534)
                return function() -- line 2771 | captures: v533, v534, v28, v29, v31, SoundService, Sound, v32, showToast, v511, v513, v514, v521
                    v511()
                    v513()
                    v533[1] = 1
                    if v514 then
                        v514.Text = ""
                    end
                    v534[1] = 1
                    if v521 then
                        v521.Text = ""
                    end
                    if v28 and Sound then
                        Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                        SoundService:PlayLocalSound(Sound)
                    end
                    if v31 then
                        showToast("Egg Giver form cleared", v32)
                    end
                end
            end)(v3, v5)))
        end
        local v535 = v3[1]
        local v536 = {}
        v536[1] = v535
        local v537 = v5[1]
        local v538 = {}
        v538[1] = v537
        v508 = v536
        v509 = v538
    else
        v508 = v3
        v509 = v5
    end
    if v122.MobGiver then
        CustomEgg = v122.MobGiver
        local v539, v540 = wireCellPicker(CustomEgg, "PetRow", openPetIconPicker, closePetIconPicker, AdminPanelPetIconPicker.Holder.Scroller)
        local v541, v542 = wireCellPicker(CustomEgg, "MutationRow", openMutationPicker, closeMutationPicker, AdminPanelMutationPicker.Holder.Scroller)
        Remove = CustomEgg:FindFirstChild("SizeRow")
        local v543 = Remove and firstTextBox(Remove)
        v508[1] = 1;
        (function(v544)
            local function getSelectedSize_3() -- line 2803 | captures: v544
                return v544[1]
            end

            return getSelectedSize_3
        end)(v508);
        (function(v545)
            local function resetSize_3() -- line 2807 | captures: v545, v543
                v545[1] = 1
                if v543 then
                    v543.Text = ""
                end
            end

            return resetSize_3
        end)(v508)
        if v543 then
            v543.FocusLost:Connect(((function(v546)
                return function(v547) -- line 2817 | captures: v546, v28, v29, SoundService, Sound, v543
                    local Text = v543 and v543.Text or ""
                    local v548 = tonumber(Text)
                    if v548 then
                        local v549 = math.clamp(v548, 0.1, 8)
                        v546[1] = v549
                        v543.Text = string.format("%.2f", v549)
                        if v547 and v28 and Sound then
                            Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                            SoundService:PlayLocalSound(Sound)
                        end
                    else
                        v543.Text = ""
                    end
                end
            end)(v508)))
        end
        FocusLost_3 = CustomEgg:FindFirstChild("QuantityRow")
        local v550 = FocusLost_3 and firstTextBox(FocusLost_3)
        v509[1] = 1;
        (function(v551)
            local function getSelectedQuantity_2() -- line 2837 | captures: v551
                return v551[1]
            end

            return getSelectedQuantity_2
        end)(v509);
        (function(v552)
            local function resetQuantity_2() -- line 2841 | captures: v552, v550
                v552[1] = 1
                if v550 then
                    v550.Text = ""
                end
            end

            return resetQuantity_2
        end)(v509)
        if v550 then
            v550.FocusLost:Connect(((function(v553)
                return function(v554) -- line 2851 | captures: v553, v28, v29, SoundService, Sound, v550
                    local Text = v550 and v550.Text or ""
                    local v555 = tonumber(Text)
                    if v555 then
                        local v556 = v555 + 0.5
                        local v557 = math.floor(v556)
                        local v558 = math.clamp(v557, 1, 3)
                        v553[1] = v558
                        v550.Text = tostring(v558)
                        if v554 and v28 and Sound then
                            Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                            SoundService:PlayLocalSound(Sound)
                        end
                    else
                        v550.Text = ""
                    end
                end
            end)(v509)))
        end
        FocusLost_2 = CustomEgg:FindFirstChild("GiveEggBtnRow")
        MouseButton1Click_5 = FocusLost_2 and firstButton(FocusLost_2)
        if MouseButton1Click_5 then
            MouseButton1Click_5.MouseButton1Click:Connect(((function(v559, v560)
                return function() -- line 2872 | captures: v559, v560, v31, v7, v33, showToast, v539, v541
                    local v561 = v539()
                    if v561 then
                        v7:FireServer({
                            kind = "GiveMob",
                            pet = v561,
                            mutation = v541() or "None",
                            size = v559[1],
                            quantity = v560[1]
                        })
                    elseif v31 then
                        showToast("Pick a pet first!", v33)
                    end
                end
            end)(v508, v509)))
        end
        MouseButton1Click_6 = CustomEgg:FindFirstChild("TeleportToSpawnBtnRow")
        v507 = MouseButton1Click_6 and firstButton(MouseButton1Click_6)
        if v507 then
            v507.MouseButton1Click:Connect(((function(v562, v563)
                return function() -- line 2887 | captures: v562, v563, v28, v29, v31, SoundService, Sound, v32, showToast, v540, v542, v543, v550
                    v540()
                    v542()
                    v562[1] = 1
                    if v543 then
                        v543.Text = ""
                    end
                    v563[1] = 1
                    if v550 then
                        v550.Text = ""
                    end
                    if v28 and Sound then
                        Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                        SoundService:PlayLocalSound(Sound)
                    end
                    if v31 then
                        showToast("Mob Giver form cleared", v32)
                    end
                end
            end)(v508, v509)))
        end
        local v564 = v508[1]
        local v565 = v509[1]
    end
end

if v122.CustomEgg then
    CustomEgg = v122.CustomEgg
    local v566, v567 = wireCellPicker(CustomEgg, "EggRow", openPetPicker, closePetPicker, AdminPanelPetPicker.Holder.Scroller)
    local v568, v569 = wireCellPicker(CustomEgg, "PetRow", openPetIconPicker, closePetIconPicker, AdminPanelPetIconPicker.Holder.Scroller)
    local v570, v571 = wireCellPicker(CustomEgg, "MutationRow", openMutationPicker, closeMutationPicker, AdminPanelMutationPicker.Holder.Scroller)
    Reset_4 = CustomEgg:FindFirstChild("SizeRow")
    local v572 = Reset_4 and firstTextBox(Reset_4)
    v487[1] = 1;
    (function(v573)
        local function getSelectedSize_4() -- line 2920 | captures: v573
            return v573[1]
        end

        return getSelectedSize_4
    end)(v487);
    (function(v574)
        local function resetSize_4() -- line 2924 | captures: v574, v572
            v574[1] = 1
            if v572 then
                v572.Text = ""
            end
        end

        return resetSize_4
    end)(v487)
    if v572 then
        v572.FocusLost:Connect(((function(v575)
            return function(v576) -- line 2934 | captures: v575, v28, v29, SoundService, Sound, v572
                local Text = v572 and v572.Text or ""
                local v577 = tonumber(Text)
                if v577 then
                    local v578 = math.clamp(v577, 0.1, 8)
                    v575[1] = v578
                    v572.Text = string.format("%.2f", v578)
                    if v576 and v28 and Sound then
                        Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                        SoundService:PlayLocalSound(Sound)
                    end
                else
                    v572.Text = ""
                end
            end
        end)(v487)))
    end
    FocusLost = CustomEgg:FindFirstChild("MoneyRow")
    local v579 = FocusLost and firstTextBox(FocusLost)
    local v580

    local function getSelectedMoney() -- line 2954 | captures: v580
        return v580
    end

    local function resetMoney() -- line 2958 | captures: v580, v579
        v580 = nil
        if v579 then
            v579.Text = ""
        end
    end

    if v579 then
        v579.FocusLost:Connect(function(v581) -- line 2968 | captures: v28, v29, v580, SoundService, Sound, v579
            local Text = v579 and v579.Text or ""
            local v582 = tonumber(Text)
            if v582 then
                local v583 = math.max(v582, 0)
                v580 = v583
                v579.Text = string.format("%.2f", v583)
                if v581 and v28 and Sound then
                    Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                    SoundService:PlayLocalSound(Sound)
                end
            else
                v580 = nil
                v579.Text = ""
            end
        end)
    end
    MouseButton1Click_6 = CustomEgg:FindFirstChild("TeleportToStageBtnRow")
    v507 = MouseButton1Click_6 and firstButton(MouseButton1Click_6)
    if v507 then
        v507.MouseButton1Click:Connect(((function(v584)
            return function() -- line 2990 | captures: v584, v31, v580, v7, v33, showToast, v566, v568, v570
                local v585 = v566()
                if v585 then
                    v7:FireServer({
                        kind = "GiveCustomEgg",
                        egg = v585,
                        pet = v568(),
                        mutation = v570() or "None",
                        size = v584[1],
                        moneyPerSecond = v580
                    })
                elseif v31 then
                    showToast("Pick an egg first!", v33)
                end
            end
        end)(v487)))
    end
    local MouseButton1Click = CustomEgg:FindFirstChild("TeleportToSpawnBtnRow")
    local v586 = MouseButton1Click and firstButton(MouseButton1Click)
    if v586 then
        v586.MouseButton1Click:Connect(((function(v587)
            return function() -- line 3005 | captures: v587, v28, v29, v31, v580, SoundService, Sound, v32, showToast, v567, v569, v571, v572, v579
                v567()
                v569()
                v571()
                v587[1] = 1
                if v572 then
                    v572.Text = ""
                end
                v580 = nil
                if v579 then
                    v579.Text = ""
                end
                if v28 and Sound then
                    Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                    SoundService:PlayLocalSound(Sound)
                end
                if v31 then
                    showToast("Custom Egg form cleared", v32)
                end
            end
        end)(v487)))
    end
    local v588 = v487[1]
end
do
    local v589
    if v122.GuardEditor then
        local v590
        Reset_2 = v122.GuardEditor
        local v591, v592 = wireCellPicker(Reset_2, "BiomeRow", openEggPicker, closeEggPicker, AdminPanelEggPicker.Holder)
        Reset_4 = Reset_2:FindFirstChild("QuantityRow")
        local v593 = Reset_4 and firstTextBox(Reset_4)
        MouseButton1Click_3 = Reset_2:FindFirstChild("SizeRow")
        if MouseButton1Click_3 then
            v589 = firstTextBox(MouseButton1Click_3)
            MouseButton1Click_3 = MouseButton1Click_3:FindFirstChild("Layout")
        else
            v589 = MouseButton1Click_3
        end
        local v594 = v589

        local function stepSize_2(v595) -- line 3042 | captures: v594
            if not v594 then
                return
            end
            local format = string.format
            local Text = v594 and v594.Text or ""
            local v596 = (tonumber(Text) or 1) + v595
            local v597 = math.clamp(v596, 0.1, 5) * 10 + 0.5
            v594.Text = format("%.2f", math.floor(v597) / 10)
        end

        if MouseButton1Click_3 then
            FocusLost = MouseButton1Click_3:FindFirstChild("SizeMinus")
            MouseButton1Click_3 = MouseButton1Click_3:FindFirstChild("SizePlus")
        else
            FocusLost = MouseButton1Click_3
        end
        if FocusLost and FocusLost:IsA("GuiButton") then
            animate(FocusLost)
            MouseButton1Click_4 = FocusLost.MouseButton1Click
            local v598 = v589
            MouseButton1Click_4:Connect(function() -- line 3054 | captures: v28, v29, SoundService, Sound, v598
                if v28 and Sound then
                    Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                    SoundService:PlayLocalSound(Sound)
                end
                if not v598 then
                    return
                end
                local format = string.format
                local Text = v598 and v598.Text or ""
                local v599 = (tonumber(Text) or 1) + -0.1
                local v600 = math.clamp(v599, 0.1, 5) * 10 + 0.5
                v598.Text = format("%.2f", math.floor(v600) / 10)
            end)
        end
        if MouseButton1Click_3 and MouseButton1Click_3:IsA("GuiButton") then
            animate(MouseButton1Click_3)
            MouseButton1Click_4 = MouseButton1Click_3.MouseButton1Click
            local v601 = v589
            MouseButton1Click_4:Connect(function() -- line 3070 | captures: v28, v29, SoundService, Sound, v601
                if v28 and Sound then
                    Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                    SoundService:PlayLocalSound(Sound)
                end
                if not v601 then
                    return
                end
                local format = string.format
                local Text = v601 and v601.Text or ""
                local v602 = (tonumber(Text) or 1) + 0.1
                local v603 = math.clamp(v602, 0.1, 5) * 10 + 0.5
                v601.Text = format("%.2f", math.floor(v603) / 10)
            end)
        end
        MouseButton1Click_4 = Reset_2:FindFirstChild("SETBtnRow")
        if MouseButton1Click_4 then
            v590 = buttonByLabel(MouseButton1Click_4, "SET")
            local Reset = buttonByLabel(MouseButton1Click_4, "Reset")
            local v604 = false

            local function lockButtons(v605, v606) -- line 3088 | captures: v590, v604, Reset
                v604 = v605
                if v590 then
                    v590.Active = not v605
                    local v607 = if v605 then v606 or "..." else "SET"
                    local Label = v590:FindFirstChild("Label")
                    if Label then
                        Label.Text = v607
                    end
                end
                if Reset then
                    Reset.Active = not v605
                end
            end

            v7.OnClientEvent:Connect(function() -- line 3105 | captures: v590, v604, Reset
                if not v604 then
                    return
                end
                v604 = false
                if v590 then
                    v590.Active = true
                    local Label = v590:FindFirstChild("Label")
                    if Label then
                        Label.Text = "SET"
                    end
                end
                if Reset then
                    Reset.Active = true
                end
            end)
            if v590 then
                MouseButton1Click_6 = v590.MouseButton1Click
                local v608 = v589
                MouseButton1Click_6:Connect(function() -- line 3126 | captures: v31, v590, v604, v7, v32, v33, showToast, v591, Reset, v608, v593
                    if not v604 then
                        local v609 = v591()
                        if v609 then
                            local v610 = v593 and v593.Text or ""
                            if v610 == "" then
                                if v31 then
                                    showToast("Type a username first!", v33)
                                end
                            else
                                local v611 = v608 and v608.Text or ""
                                local v612 = tonumber(v611)
                                if v612 then
                                    local v613 = math.clamp(v612, 0.1, 5)
                                    if v608 then
                                        v608.Text = string.format("%.2f", v613)
                                    end
                                    v604 = true
                                    if v590 then
                                        v590.Active = false
                                        local Label = v590:FindFirstChild("Label")
                                        if Label then
                                            Label.Text = "Applying..."
                                        end
                                    end
                                    if Reset then
                                        Reset.Active = false
                                    end
                                    v7:FireServer({
                                        kind = "SetGuardAppearance",
                                        biome = v609,
                                        username = v610,
                                        size = v613
                                    })
                                    local v614 = ("Applying %s as the %s guard..."):format(v610, v609)
                                    if v31 then
                                        showToast(v614, v32)
                                    end
                                elseif v31 then
                                    showToast("Enter a size number!", v33)
                                end
                            end
                        elseif v31 then
                            showToast("Pick a biome first!", v33)
                        end
                    end
                end)
            end
            if Reset then
                Reset.MouseButton1Click:Connect(function() -- line 3174 | captures: v31, v590, v604, v7, v33, showToast, v591, Reset
                    if not v604 then
                        local v615 = v591()
                        if v615 then
                            v604 = true
                            if v590 then
                                v590.Active = false
                                local Label = v590:FindFirstChild("Label")
                                if Label then
                                    Label.Text = "Resetting..."
                                end
                            end
                            if Reset then
                                Reset.Active = false
                            end
                            v7:FireServer({
                                kind = "ResetGuardAppearance",
                                biome = v615
                            })
                        elseif v31 then
                            showToast("Pick a biome first!", v33)
                        end
                    end
                end)
            end
        end
        MouseButton1Click_4 = Reset_2:FindFirstChild("TeleportToSpawnBtnRow")
        FocusLost_2 = MouseButton1Click_4 and firstButton(MouseButton1Click_4)
        if FocusLost_2 then
            MouseButton1Click_5 = FocusLost_2.MouseButton1Click
            local v616 = v589
            MouseButton1Click_5:Connect(function() -- line 3205 | captures: v28, v29, v31, SoundService, Sound, v32, showToast, v592, v616, v593
                v592()
                if v593 then
                    v593.Text = ""
                end
                if v616 then
                    v616.Text = ""
                end
                if v28 and Sound then
                    Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                    SoundService:PlayLocalSound(Sound)
                end
                if v31 then
                    showToast("Guard Editor form cleared", v32)
                end
            end)
        end
    end
    if v122.Npc then
        Reset_3 = v122.Npc
        local v617 = firstTextBox(Reset_3:FindFirstChild("NPCDisplayNameRow"))
        local v618 = firstTextBox(Reset_3:FindFirstChild("NPCMorphNameRow"))
        local v619 = firstTextBox(Reset_3:FindFirstChild("NPCVerifiedCheckmarkRow"))
        local v620 = makeToggle(Reset_3:FindFirstChild("NPCFollowsYouRow"), "YES", "NO", true)
        MouseButton1Click_3 = Reset_3:FindFirstChild("SpawnNPCBtnRow")
        v589 = MouseButton1Click_3 and firstButton(MouseButton1Click_3)
        if v589 then
            v589.MouseButton1Click:Connect(function() -- line 3236 | captures: v7, v617, v618, v619, v620
                local v621 = {
                    morphName = 0,
                    follows = 0,
                    kind = "SpawnNPC",
                    verified = 0,
                    displayName = 0
                }
                v621.displayName = v617 and v617.Text or ""
                v621.morphName = v618 and v618.Text or ""
                v621.verified = v619 and v619.Text or ""
                v621.follows = v620()
                v7:FireServer(v621)
            end)
        end
        FocusLost_3 = Reset_3:FindFirstChild("DespawnNpc")
        local FocusLost = FocusLost_3 and firstButton(FocusLost_3)
        if FocusLost then
            FocusLost.MouseButton1Click:Connect(function() -- line 3251 | captures: v7
                v7:FireServer({ kind = "DespawnNPC" })
            end)
        end
    end
    if v122.Freecam then
        Reset_3 = v122.Freecam
        Reset_2 = PlayerGui:WaitForChild("FreecamGui", 10)
        Remove = Reset_2 and Reset_2:WaitForChild("FreecamScript", 10)
        local v622 = Remove and Remove:WaitForChild("ToggleRequested", 10)

        local function fireFreecamToggle() -- line 3264 | captures: v31, v33, showToast, closePanel, v622
            if v622 then
                closePanel()
                v622:Fire()
            elseif v31 then
                showToast("Freecam is unavailable", v33)
            end
        end

        MouseButton1Click_3 = Reset_3:FindFirstChild("EnableFreecamBtnRow")
        v589 = MouseButton1Click_3 and firstButton(MouseButton1Click_3)
        if v589 then
            v589.MouseButton1Click:Connect(fireFreecamToggle)
        end
        v242.Freecam = fireFreecamToggle
        bindKeyField(firstButton(Reset_3:FindFirstChild("ENABLEDISABLEFreecamRow") or Reset_3), "Freecam")
        local v623 = firstTextBox(Reset_3:FindFirstChild("SpeedRow"))
        if v623 then
            v623.FocusLost:Connect(function(v624) -- line 3283 | captures: v28, v29, v31, SoundService, LocalPlayer, Sound, v32, showToast, v623
                local Text = v623 and v623.Text or ""
                local v625 = tonumber(Text)
                if v625 and v625 > 0 then
                    local v626 = math.clamp(v625, 0.1, 20)
                    LocalPlayer:SetAttribute("FreecamSpeed", v626)
                    v623.Text = tostring(v626)
                    if v624 and v28 and Sound then
                        Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                        SoundService:PlayLocalSound(Sound)
                    end
                    if v31 then
                        showToast("Freecam speed set to " .. v626, v32)
                    end
                else
                    v623.Text = ""
                end
            end)
        end
    end
end

if v122.BTools then
    Reset_3 = v122.BTools
    Reset_2 = Reset_3:FindFirstChild("GiveBtools")
    Remove = Reset_3:FindFirstChild("RemoveBtools")
    SETBtnRow4 = Reset_2 and firstButton(Reset_2)
    if SETBtnRow4 then
        SETBtnRow4.MouseButton1Click:Connect(function() -- line 3311 | captures: v28, v29, SoundService, v7, Sound
            if v28 and Sound then
                Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                SoundService:PlayLocalSound(Sound)
            end
            v7:FireServer({ kind = "BToolsShow" })
        end)
    end
    Reset_4 = Remove and firstButton(Remove)
    if Reset_4 then
        Reset_4.MouseButton1Click:Connect(function() -- line 3324 | captures: v28, v29, SoundService, v7, Sound
            if v28 and Sound then
                Sound.Volume = (Sound:GetAttribute("BaseVol") or 0.5) * v29
                SoundService:PlayLocalSound(Sound)
            end
            v7:FireServer({ kind = "BToolsHide" })
        end)
    end
end
do
    local v627
    if v122.Main then
        Reset_2 = v122.Main
        bindKeyField(firstButton(Reset_2:FindFirstChild("OpenClosePanelRow") or Reset_2), "TogglePanel")
        Remove = Reset_2:FindFirstChild("ResetToDefaultBtnRow")
        SETBtnRow4 = Remove and firstButton(Remove)
        if SETBtnRow4 then
            SETBtnRow4.MouseButton1Click:Connect(function() -- line 3343 | captures: v31, LocalPlayer, v32, showToast, refreshKeyDisplay
                LocalPlayer:SetAttribute("AdminKey_TogglePanel", nil)
                refreshKeyDisplay("TogglePanel")
                if v31 then
                    showToast("Keybinds reset to default", v32)
                end
            end)
        end
        Reset_4 = Reset_2:FindFirstChild("SHOWBUTTONBtnRow")
        if Reset_4 then
            v475 = buttonByLabel(Reset_4, "SHOW BUTTON")
            v627 = buttonByLabel(Reset_4, "HIDE BUTTON")
            if v475 then
                v475.MouseButton1Click:Connect(function() -- line 3360 | captures: v31, LocalPlayer, v32, showToast
                    LocalPlayer:SetAttribute("AdminButtonHidden", nil)
                    if v31 then
                        showToast("Admin button shown", v32)
                    end
                end)
            end
            if v627 then
                v627.MouseButton1Click:Connect(function() -- line 3372 | captures: v31, LocalPlayer, v32, showToast
                    LocalPlayer:SetAttribute("AdminButtonHidden", true)
                    if v31 then
                        showToast("Admin button hidden - type /admin to bring it back", v32)
                    end
                end)
            end
        end
    end
    Reset_2 = v122.HDAdmin
    if Reset_2 then
        local function dashboard() -- line 3386 | captures: v33, showToast
            local HDAdminMain = _G.HDAdminMain
            if HDAdminMain then
                return HDAdminMain
            end
            showToast("HD Admin is not installed in this place.", v33)
            return nil
        end

        SETBtnRow4 = firstButton(Reset_2:FindFirstChild("OpenHDAdminDashboardBtnRow"))
        if SETBtnRow4 then
            SETBtnRow4.Activated:Connect(function() -- line 3396 | captures: v33, showToast, closePanel
                local HDAdminMain = _G.HDAdminMain
                if not HDAdminMain then
                    showToast("HD Admin is not installed in this place.", v33)
                    HDAdminMain = nil
                end
                if not HDAdminMain then
                    return
                end
                local pcall_2 = pcall
                local HDAdminMain_2 = HDAdminMain
                if pcall_2(function() -- line 3399 | captures: HDAdminMain_2
                        HDAdminMain_2:GetModule("GUIs"):OpenMainFrame()
                    end) then
                    closePanel()
                else
                    showToast("HD Admin could not open its dashboard.", v33)
                end
            end)
        end
        v627 = Reset_2:FindFirstChild("ShowHideHDAdminTopbarButton")
        for v628, v629 in {
                {
                    label = "SHOW BUTTON",
                    hidden = false
                },
                {
                    label = "HIDE BUTTON",
                    hidden = true
                }
            } do
            v486 = buttonByLabel(v627, v629.label)
            if v486 then
                MouseButton1Click_4 = v486.Activated
                local v630 = v629
                MouseButton1Click_4:Connect(function() -- line 3407 | captures: LocalPlayer, v33, showToast, v630
                    local HDAdminMain = _G.HDAdminMain
                    if not HDAdminMain then
                        showToast("HD Admin is not installed in this place.", v33)
                        HDAdminMain = nil
                    end
                    if not HDAdminMain then
                        return
                    end
                    local pcall_2 = pcall
                    local HDAdminMain_2 = HDAdminMain
                    if pcall_2(function() -- line 3410 | captures: HDAdminMain_2, v630
                            HDAdminMain_2:GetModule("TopbarIcons").Dashboard:setEnabled(not v630.hidden)
                        end) then
                        LocalPlayer:SetAttribute("HDAdminIconHidden", v630.hidden)
                    else
                        showToast("HD Admin's topbar icon is unavailable.", v33)
                    end
                end)
            end
        end
    end
end
do
    local AdminBTN = PlayerGui:WaitForChild("HUD"):WaitForChild("GameHUD"):WaitForChild("LeftControls"):WaitForChild("AdminBTN")
    if not AdminBTN:IsA("GuiButton") or not AdminBTN then
        MouseButton1Click_3 = AdminBTN:FindFirstChildWhichIsA("GuiButton", true)
    else
        MouseButton1Click_3 = AdminBTN
    end
    if MouseButton1Click_3 then
        MouseButton1Click_3.Activated:Connect(togglePanel)
    else
        warn("[AdminPanelUi] HUD AdminBTN has no GuiButton")
    end

    local function refreshEntry() -- line 3426 | captures: LocalPlayer, AdminBTN
        if AdminBTN then
            AdminBTN.Visible = LocalPlayer:GetAttribute("AdminButtonHidden") ~= true
        end
    end

    refreshEntry()
    LocalPlayer:GetAttributeChangedSignal("AdminButtonHidden"):Connect(refreshEntry)
end
task.spawn(function() -- line 3436 | captures: v31, LocalPlayer, v32, showToast
    local TextChatService = game:GetService("TextChatService")
    local v631 = TextChatService:FindFirstChild("AdminUnhideCommand") or TextChatService:WaitForChild("AdminUnhideCommand", 15)
    if v631 and v631:IsA("TextChatCommand") then
        v631.Triggered:Connect(function() -- line 3444 | captures: v31, LocalPlayer, v32, showToast
            LocalPlayer:SetAttribute("AdminButtonHidden", nil)
            if v31 then
                showToast("Admin button restored", v32)
            end
        end)
    end
end)
AdminPanelSettings.Visible = false
AdminPanel.Visible = false
animateAll(AdminPanel)
do
    local AdminThemeName = LocalPlayer:GetAttribute("AdminThemeName")
    if typeof(AdminThemeName) == "string" and (AdminThemeName == "RGB" or v105[AdminThemeName]) then
        v106 = AdminThemeName
    end
end
showPage("Main", false)
paintTheme()
do
    local v632
    for v633, v634 in ipairs(Main:GetChildren()) do
        if v634:IsA("TextLabel") and v634.Name ~= "TitleUp" and v634.Text:find("Toggle") then
            v632 = v634
            break
        end
    end

    local function refreshHint() -- line 3474 | captures: v632, LocalPlayer
        if not (v632 and v632:IsA("TextLabel")) then
            return
        end
        local AdminKey_TogglePanel = LocalPlayer:GetAttribute("AdminKey_TogglePanel")
        if typeof(AdminKey_TogglePanel) == "string" then
            if AdminKey_TogglePanel == "" then
                AdminKey_TogglePanel = "R"
            end
        else
            AdminKey_TogglePanel = "R"
        end
        v632.Text = "Press " .. (AdminKey_TogglePanel or "?") .. " to Toggle"
    end

    refreshHint()

    local function keyAttr(v635) -- line 3491
        return "AdminKey_" .. v635
    end

    LocalPlayer:GetAttributeChangedSignal((keyAttr("TogglePanel"))):Connect(refreshHint)
end
MouseButton1Click_4 = print
v507 = keyName("TogglePanel")
MouseButton1Click_4("[AdminPanelUi] ready - toggle key: " .. tostring(v507))
