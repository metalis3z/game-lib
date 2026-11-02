-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local GUI = require(ReplicatedStorage.Client.GUI)
local Player = require(ReplicatedStorage.Shared.Player)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local v1 = {
    popFromScale = 0.7,
    pulseSeconds = 0.25,
    pulsePeak = 1.06,
    popInfo = TweenInfo.new(0.28, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out),
    pulseOutInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    pulseInInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
}
local v2 = {
    fadeDelay = 0.5,
    clearDelay = 0.35,
    icon = "rbxassetid://99458650446228",
    sink = Vector3.new(0, -1, 0),
    growInfo = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    riseInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    fadeInfo = TweenInfo.new(0.3),
    baseTint = Color3.fromRGB(178, 233, 255)
}
local v3 = {}
local v4 = {
    from = 100,
    isInclusive = true,
    tint = Color3.fromRGB(255, 0, 0)
}
local v5 = {
    from = 25,
    isInclusive = true,
    tint = Color3.fromRGB(255, 67, 199)
}
local v6 = {
    from = 9,
    isInclusive = true,
    tint = Color3.fromRGB(0, 255, 255)
}
local v7 = {
    from = 1,
    isInclusive = false,
    tint = Color3.fromRGB(255, 238, 0)
}

v3[1] = v4
v3[2] = v5
v3[3] = v6
v3[4] = v7
v2.tintLadder = v3

local v8 = {
    seconds = 0.85,
    fadeStart = 0.72,
    startScale = 0.72,
    scaleWave = 0.18,
    touchDivisor = 2.5,
    launchXFraction = 0.25,
    cloneName = "SpeedGainPopup",
    playbackSpeed = 1,
    lift = NumberRange.new(100, 150),
    bend = NumberRange.new(90, 120)
}
local v9 = {
    TextLabel = "TextTransparency",
    ImageLabel = "ImageTransparency",
    UIStroke = "Transparency"
}
local v10 = {}
local LocalPlayer = Players.LocalPlayer
local v11 = Random.new()
local v12 = {}

local function build(v13, v14, v15) -- line 60
    local v16 = Instance.new(v13)
    for v17, v18 in v14 do
        v16[v17] = v18
    end
    v16.Parent = v15
    return v16
end

local function scaleFor(v19) -- line 71
    local v20 = v19:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
    v20.Parent = v19
    return v20
end

local function headlineScale(v21) -- line 79
    local Parent = v21.Parent
    local v22, v23
    if Parent == nil then
        v23 = true
    elseif Parent:IsA("GuiObject") then
        v22 = Parent:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
        v23 = false
    else
        v23 = true
    end
    if v23 then
        return nil
    end
    v22.Parent = Parent
    return v22
end

local function popHeadline(v24) -- line 91 | captures: TweenService, v1
    local Parent = v24.Parent
    local v25
    if Parent == nil then
    elseif Parent:IsA("GuiObject") then
        v25 = Parent:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
        v25.Parent = Parent
    end
    if v25 ~= nil then
        v25.Scale = v1.popFromScale
        TweenService:Create(v25, v1.popInfo, { Scale = 1 }):Play()
    end
end

local function paintAlpha(v26, v27) -- line 111 | captures: v9
    for v28, v29 in v26:GetDescendants() do
        local v30 = v9[v29.ClassName]
        if v30 ~= nil then
            v29[v30] = v27
        end
    end
end

local function ladderTint(v31) -- line 120 | captures: v2
    for v32, v33 in v2.tintLadder do
        if v33.isInclusive and v33.from <= v31 then
            return v33.tint
        end
        if v33.from < v31 then
            return v33.tint
        end
    end
    return v2.baseTint
end

local function spread(v34, v35) -- line 135 | captures: v11
    return v11:NextNumber(v34.Min * v35, v34.Max * v35)
end

local function arcSampler(v36, v37) -- line 138 | captures: UserInputService, v8, v11
    local v38 = if UserInputService.TouchEnabled then 1 / v8.touchDivisor else 1
    local bend = v8.bend
    local v39 = bend.Min * v38
    local X = v36.X
    local v40 = if v37.X < X then 1 else -1
    local v41 = v11:NextNumber(v39, bend.Max * v38) * v40
    local lift = v8.lift
    local v42 = v11:NextNumber(lift.Min * v38, lift.Max * v38)
    local v43 = (v36 + v37) * 0.5 + Vector2.new(v41, -v42)
    return function(v44) -- line 156 | captures: v36, v37, v43
        local v45 = 1 - v44
        return v36 * (v45 * v45) + v43 * (v45 * 2 * v44) + v37 * (v44 * v44)
    end
end

local function raiseBadge(v46, v47, v48, v49, v50) -- line 161 | captures: TweenService, GUI, Player, v2, LocalPlayer, v11, popHeadline, ladderTint
    local function v51(v52, v53, ...)
        return (Vector3.new(v52, v53, ...))
    end

    local v54 = Player.Optional.HumanoidRootPart(LocalPlayer)
    if v54 == nil then
        return
    end
    local v55 = {
        AlwaysOnTop = true,
        Name = "PlusOne",
        StudsOffset = Vector3.new(0, 1, 0),
        Adornee = v54,
        Size = UDim2.new(4.5, 0, 1.5, 0)
    }
    local v56 = GUI.PlayerGui()
    local BillboardGui = Instance.new("BillboardGui")
    for v57, v58 in v55 do
        BillboardGui[v57] = v58
    end
    BillboardGui.Parent = v56
    local v59 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 0, 0, 0)
    }
    local Frame = Instance.new("Frame")
    for v60, v61 in v59 do
        Frame[v60] = v61
    end
    Frame.Parent = BillboardGui
    local v62 = {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0.05, 0),
        VerticalAlignment = Enum.VerticalAlignment.Center
    }
    local UIListLayout = Instance.new("UIListLayout")
    for v63, v64 in v62 do
        UIListLayout[v63] = v64
    end
    UIListLayout.Parent = Frame
    local v65 = {
        BackgroundTransparency = 1,
        Image = v2.icon,
        Size = UDim2.new(0.3, 0, 0.8, 0)
    }
    local ImageLabel = Instance.new("ImageLabel")
    for v66, v67 in v65 do
        ImageLabel[v66] = v67
    end
    ImageLabel.Parent = Frame
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    for v68, v69 in { AspectRatio = 1 } do
        UIAspectRatioConstraint[v68] = v69
    end
    UIAspectRatioConstraint.Parent = ImageLabel
    local v70 = {
        BackgroundTransparency = 1,
        TextScaled = true,
        Font = Enum.Font.GothamBlack,
        Size = UDim2.new(0.6, 0, 0.9, 0),
        Text = v47
    }
    v70.TextColor3 = v49 or ladderTint(v48 or 1)
    local TextLabel = Instance.new("TextLabel")
    for v71, v72 in v70 do
        TextLabel[v71] = v72
    end
    TextLabel.Parent = Frame
    local UIStroke = Instance.new("UIStroke")
    for v73, v74 in { Thickness = 2 } do
        UIStroke[v73] = v74
    end
    UIStroke.Parent = TextLabel
    local v75 = v51(v11:NextInteger(-4, 4), v11:NextInteger(3, 5), v11:NextInteger(-2, 2))
    TweenService:Create(Frame, v2.growInfo, { Size = UDim2.new(1, 0, 1, 0) }):Play()
    TweenService:Create(BillboardGui, v2.riseInfo, { StudsOffset = v75 }):Play()
    if v50 ~= nil then
        v50()
    end
    task.delay(v2.fadeDelay, function() -- line 258 | captures: v46, BillboardGui, ImageLabel, TextLabel, UIStroke, v75, TweenService, v2, popHeadline
        local v76 = {}
        local v77 = {}
        local v78 = { StudsOffset = v75 + v2.sink }
        v77[1] = BillboardGui
        v77[2] = v78
        v76[1] = {
            TextLabel,
            { TextTransparency = 1 }
        }
        v76[2] = {
            ImageLabel,
            { ImageTransparency = 1 }
        }
        v76[3] = {
            UIStroke,
            { Transparency = 1 }
        }
        v76[4] = v77
        for v79, v80 in v76 do
            TweenService:Create(v80[1], v2.fadeInfo, v80[2]):Play()
        end
        task.delay(v2.clearDelay, function() -- line 283 | captures: v46, BillboardGui, popHeadline
            popHeadline(v46)
            BillboardGui:Destroy()
        end)
    end)
end

local function flyToHeadline(v81, v82, v83, v84, v85) -- line 289 | captures: RunService, Audio, GUI, v8, v9, popHeadline, arcSampler
    local function finish() -- line 291 | captures: v85
        if v85 ~= nil then
            v85()
        end
    end

    local CurrentCamera = workspace.CurrentCamera
    if not (v82 <= 0 or CurrentCamera == nil) then
        local v86 = GUI.SpeedGainAnimation()
        local ScreenGui = v86:IsA("ScreenGui")
        assert(ScreenGui, "speed gain host is not a ScreenGui")
        local Frame = v86.Frame
        local Frame_2 = Frame:IsA("Frame")
        assert(Frame_2, "speed gain host is missing its Frame template")
        local v87 = Frame:Clone()
        v87.Name = v8.cloneName
        v87.Visible = true
        v87.AnchorPoint = Vector2.new(0.5, 0.5)
        local CurrentBoost = v87.CurrentBoost
        local TextLabel = CurrentBoost:IsA("TextLabel")
        assert(TextLabel, "speed gain template has no CurrentBoost label")
        local v88 = CurrentBoost:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
        v88.Parent = CurrentBoost
        CurrentBoost.Text = v83
        v88.Scale = v8.startScale
        local ViewportSize = CurrentCamera.ViewportSize
        local v89 = v84 or Vector2.new(ViewportSize.X * v8.launchXFraction, ViewportSize.Y)
        local v90 = arcSampler(v89, v81.AbsolutePosition + v81.AbsoluteSize * 0.5)
        v87.Position = UDim2.fromOffset(v89.X, v89.Y)
        v87.Parent = v86
        for v91, v92 in v87:GetDescendants() do
            local v93 = v9[v92.ClassName]
            if v93 ~= nil then
                v92[v93] = 0
            end
        end
        if v8.spawnSoundId then
            Audio.Play(v8.spawnSoundId, script, { PlaybackSpeed = v8.playbackSpeed })
        end
        local v94 = os.clock()
        local v95 = 0
        while v95 < 1 do
            if v87.Parent == nil then
                break
            end
            local v96 = (os.clock() - v94) / v8.seconds
            v95 = math.min(v96, 1)
            local v97 = v90(v95)
            v87.Position = UDim2.fromOffset(v97.X, v97.Y)
            local v98 = v95 * 3.141592653589793
            local v99 = math.sin(v98)
            v88.Scale = v8.startScale + v99 * v8.scaleWave
            local v100 = (v95 - v8.fadeStart) / (1 - v8.fadeStart)
            local v101 = math.clamp(v100, 0, 1)
            for v102, v103 in v87:GetDescendants() do
                local v104 = v9[v103.ClassName]
                if v104 ~= nil then
                    v103[v104] = v101
                end
            end
            RunService.RenderStepped:Wait()
        end
        if v87.Parent ~= nil then
            if v8.landingSoundId then
                Audio.Play(v8.landingSoundId, script)
            end
            popHeadline(v81)
            v87:Destroy()
        end
    end
    if v85 ~= nil then
        v85()
    end
end

function v10.PlayWalk(v105, v106, v107, v108) -- line 373 | captures: v10
    v10.ShowGainBadge(v105, v106, v107, v108)
end

function v10.ShowGainBadge(v109, v110, v111, v112) -- line 376 | captures: TreadmillUtil, raiseBadge
    if v110 <= 0 then
        if v112 ~= nil then
            v112()
        end
    else
        local v113 = "+" .. TreadmillUtil.FormatSpeedPower((math.round(v110)))
        raiseBadge(v109, v113, v110, v111, v112)
    end
end

function v10.Play(v114, v115, v116, v117) -- line 386 | captures: TreadmillUtil, flyToHeadline
    local v118 = TreadmillUtil.FormatSpeedPower(v115)
    flyToHeadline(v114, v115, "+" .. v118 .. " Speed", v116, v117)
end

function v10.SetHeadlinePulsing(v119, v120) -- line 390 | captures: TweenService, v1, v12
    local v121
    local Parent = v119.Parent
    local v122
    if Parent == nil then
    elseif Parent:IsA("GuiObject") then
        local v123 = Parent:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
        v123.Parent = Parent
        v121 = v123
        v122 = v123
    end
    if v122 ~= nil then
        local v124 = v12[v122]
        if v124 == nil then
            local v125 = if v124 then v124.token else 0
            local v126 = v125 + 1
            v12[v122] = {
                isActive = v120,
                token = v126
            }
            if v120 then
                task.spawn(function() -- line 420 | captures: v121, v126, TweenService, v1, v12
                    local function isStillOurs() -- line 422 | captures: v121, v126, v12
                        local v127 = v12[v121]
                        if v127 ~= nil and v127.token == v126 then
                            return (v121:IsDescendantOf(game))
                        end
                        return false
                    end

                    local v128 = {}
                    local v129 = {
                        info = v1.pulseOutInfo,
                        scale = v1.pulsePeak
                    }
                    local v130 = {
                        scale = 1,
                        info = v1.pulseInInfo
                    }
                    v128[1] = v129
                    v128[2] = v130
                    while true do
                        local v131 = v12[v121]
                        if v131 ~= nil and v131.token == v126 and v121:IsDescendantOf(game) then
                            for v132, v133 in v128 do
                                local v134 = v12[v121]
                                if v134 ~= nil and v134.token == v126 and v121:IsDescendantOf(game) then
                                    TweenService:Create(v121, v133.info, { Scale = v133.scale }):Play()
                                    task.wait(v1.pulseSeconds)
                                else
                                    return
                                end
                            end
                            continue
                        end
                        break
                    end
                end)
            else
                TweenService:Create(v122, v1.pulseInInfo, { Scale = 1 }):Play()
            end
        elseif v124.isActive == v120 then
        end
    end
end

function v10.HideSource() -- line 458 | captures: GUI
    local v135 = GUI.SpeedGainAnimation()
    local ScreenGui = v135:IsA("ScreenGui")
    assert(ScreenGui, "speed gain host is not a ScreenGui")
    local Frame = v135.Frame
    local Frame_2 = Frame:IsA("Frame")
    assert(Frame_2, "speed gain host is missing its Frame template")
    Frame.Visible = false
end

return v10
