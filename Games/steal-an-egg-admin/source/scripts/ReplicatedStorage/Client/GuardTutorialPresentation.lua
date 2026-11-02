-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ArrowPointer3D = require(ReplicatedStorage.Client.WorldFX.ArrowPointer3D)
local GUI = require(ReplicatedStorage.Client.GUI)
local Log = require(ReplicatedStorage.Packages.Log)
local MessageTyper = require(ReplicatedStorage.Client.UI.MessageTyper)
local TutorialBeam = require(ReplicatedStorage.Client.WorldFX.TutorialBeam)
local TutorialHighlightOverlay = require(script.TutorialHighlightOverlay)
local TutorialTapIndicator = require(script.TutorialTapIndicator)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local t = require(ReplicatedStorage.Packages.t)
local v1 = table.freeze({
    CROSSFADE_OUT = TweenInfo.new(0.02),
    CROSSFADE_IN = TweenInfo.new(0.02),
    FILL = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    READY_SCALE = TweenInfo.new(0.45, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, -1, true),
    READY_FLASH = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true),
    CLICK_PULSE = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true)
})

local function wantsAnchorValue(v2) -- line 26
    local v3
    if typeof(v2) == "Vector3" then
        v3 = true
    elseif typeof(v2) == "Instance" then
        v3 = v2:IsA("BasePart")
    else
        v3 = false
    end
    assert(v3, "a tutorial anchor has to be a BasePart or a Vector3")
end

local v4 = t.strict(t.string)
local v5 = t.strict(t.Color3)
local v6 = t.strict(t.boolean)
local v7 = t.strict(t.number)
local v8 = t.strict(t.optional(t.number))
local v9 = t.strict(t.instanceIsA("GuiButton"))
local v10 = t.strict(t.instanceIsA("GuiObject"))
local v11 = t.strict(t.instanceIsA("BasePart"))
local v12 = t.strict(t.CFrame)
local v13 = t.strict(t.optional(t.boolean))
local v14 = t.strict(t.optional(t.UDim))
local v15 = t.strict(t.optional(t.UDim2))
local v16 = Log.new()
local v17 = {}

v17.__index = v17
v17.__class = "GuardTutorialPresentation"

local function expect(v18, v19, v20) -- line 46
    local v21 = v18:IsA(v19)
    local v22 = ("%* is not a %*"):format(v20, v19)
    assert(v21, v22)
    return v18
end

local function messageParts(v23) -- line 51 | captures: GUI, MessageTyper
    local message = v23.message
    if message then
        return message
    end
    local v24 = GUI.TutorialInstructions()
    local ScreenGui = v24:IsA("ScreenGui")
    assert(ScreenGui, "TutorialInstructions is not a ScreenGui")
    local Frame = v24.Frame
    local Frame_2 = Frame:IsA("Frame")
    assert(Frame_2, "TutorialInstructions.Frame is not a Frame")
    local TextLabel = Frame.TextLabel
    local TextLabel_2 = TextLabel:IsA("TextLabel")
    assert(TextLabel_2, "TutorialInstructions.Frame.TextLabel is not a TextLabel")
    local UIStroke = TextLabel.UIStroke
    local UIStroke_2 = UIStroke:IsA("UIStroke")
    assert(UIStroke_2, "the tutorial label stroke is not a UIStroke")
    local UIGradient = TextLabel.UIGradient
    local UIGradient_2 = UIGradient:IsA("UIGradient")
    assert(UIGradient_2, "the tutorial label gradient is not a UIGradient")
    local v25 = {
        animator = MessageTyper.new(TextLabel),
        frame = Frame,
        gradient = UIGradient,
        label = TextLabel,
        screen = v24,
        stroke = UIStroke
    }
    v23.message = v25
    if v23.messageDefaults == nil then
        v23.messageDefaults = {
            framePosition = Frame.Position,
            strokeAlpha = TextLabel.TextStrokeTransparency,
            textAlpha = TextLabel.TextTransparency
        }
    end
    return v25
end

local function progressParts(v26) -- line 88 | captures: messageParts
    local progress = v26.progress
    if progress then
        return progress
    end
    local Progression = messageParts(v26).frame.Progression
    local GuiObject = Progression:IsA("GuiObject")
    assert(GuiObject, "the progression frame is not a GuiObject")
    local Fill = Progression.Fill
    local GuiObject_2 = Fill:IsA("GuiObject")
    assert(GuiObject_2, "the progression fill is not a GuiObject")
    local ReadyLabel = Progression.ReadyLabel
    local GuiObject_3 = ReadyLabel:IsA("GuiObject")
    assert(GuiObject_3, "the ready label is not a GuiObject")
    local ReadyLabelWhite = ReadyLabel.ReadyLabelWhite
    local TextLabel = ReadyLabelWhite:IsA("TextLabel")
    assert(TextLabel, "the ready flash is not a TextLabel")
    local UIScale = ReadyLabel:FindFirstChildOfClass("UIScale")
    if UIScale == nil then
        UIScale = Instance.new("UIScale")
        UIScale.Parent = ReadyLabel
        v26.ownsReadyScale = true
    end
    local v27 = {
        fill = Fill,
        frame = Progression,
        ready = ReadyLabel,
        readyScale = UIScale,
        white = ReadyLabelWhite
    }
    v26.progress = v27
    return v27
end

local function resetMessageInk(v28) -- line 124
    local message = v28.message
    local messageDefaults = v28.messageDefaults
    if message == nil then
        return
    end
    local v29 = if messageDefaults then messageDefaults.textAlpha else 0
    message.label.TextTransparency = v29
    message.stroke.Transparency = 0
    local v30 = if messageDefaults then messageDefaults.strokeAlpha else 1
    message.label.TextStrokeTransparency = v30
end

local function stopTween(v31) -- line 145
    if v31 then
        v31:Cancel()
    end
    return nil
end

local function beginClickPulse(v32) -- line 151 | captures: TweenService, v1
    v32.Scale = 1
    local v33 = TweenService:Create(v32, v1.CLICK_PULSE, { Scale = 1.3 })
    v33:Play()
    return v33
end

local function stopProgressPulse(v34) -- line 157
    local readyScaleTween = v34.readyScaleTween
    if readyScaleTween then
        readyScaleTween:Cancel()
    end
    v34.readyScaleTween = nil
    local readyWhiteTween = v34.readyWhiteTween
    if readyWhiteTween then
        readyWhiteTween:Cancel()
    end
    v34.readyWhiteTween = nil
end

local function setReadyPulse(v35, v36, v37) -- line 169 | captures: TweenService, v1
    if v37 then
        if v35.readyScaleTween == nil then
            v36.ready.Visible = true
            v36.readyScale.Scale = 1
            v36.white.TextTransparency = 1
            local v38 = TweenService:Create(v36.readyScale, v1.READY_SCALE, { Scale = 1.2 })
            local v39 = TweenService:Create(v36.white, v1.READY_FLASH, { TextTransparency = 0 })
            v35.readyScaleTween = v38
            v35.readyWhiteTween = v39
            v38:Play()
            v39:Play()
        elseif v35.readyWhiteTween == nil then
            v36.ready.Visible = true
            v36.readyScale.Scale = 1
            v36.white.TextTransparency = 1
            local v40 = TweenService:Create(v36.readyScale, v1.READY_SCALE, { Scale = 1.2 })
            local v41 = TweenService:Create(v36.white, v1.READY_FLASH, { TextTransparency = 0 })
            v35.readyScaleTween = v40
            v35.readyWhiteTween = v41
            v40:Play()
            v41:Play()
        end
    else
        local readyScaleTween = v35.readyScaleTween
        if readyScaleTween then
            readyScaleTween:Cancel()
        end
        v35.readyScaleTween = nil
        local readyWhiteTween = v35.readyWhiteTween
        if readyWhiteTween then
            readyWhiteTween:Cancel()
        end
        v35.readyWhiteTween = nil
        v36.ready.Visible = false
        v36.readyScale.Scale = 1
        v36.white.TextTransparency = 1
    end
end

function v17.new() -- line 212 | captures: v17
    local v42 = {
        ownsReadyScale = false,
        transition = 0
    }
    return (setmetatable(v42, v17))
end

function v17.AnnounceTyped(v43, v44, v45) -- line 216 | captures: v4, v5, messageParts
    v4(v44)
    v5(v45)
    local v46 = messageParts(v43)
    v43.transition += 1
    local message = v43.message
    local messageDefaults = v43.messageDefaults
    if message ~= nil then
        local v47 = if messageDefaults then messageDefaults.textAlpha else 0
        message.label.TextTransparency = v47
        message.stroke.Transparency = 0
        local v48 = if messageDefaults then messageDefaults.strokeAlpha else 1
        message.label.TextStrokeTransparency = v48
    end
    v46.screen.Enabled = true
    v46.animator:Type(v44, v45)
end

function v17.AnnounceNow(v49, v50, v51) -- line 242 | captures: v4, v5, messageParts
    v4(v50)
    v5(v51)
    local v52 = messageParts(v49)
    v49.transition += 1
    local message = v49.message
    local messageDefaults = v49.messageDefaults
    if message ~= nil then
        local v53 = if messageDefaults then messageDefaults.textAlpha else 0
        message.label.TextTransparency = v53
        message.stroke.Transparency = 0
        local v54 = if messageDefaults then messageDefaults.strokeAlpha else 1
        message.label.TextStrokeTransparency = v54
    end
    v52.screen.Enabled = true
    v52.animator:ShowAll(v50, v51)
end

function v17.CrossfadeTo(v55, v56, v57) -- line 268 | captures: TweenService, Tween, v1, v4, v5, messageParts
    v4(v56)
    v5(v57)
    local v58 = messageParts(v55)
    v55.transition += 1
    local transition = v55.transition
    v58.screen.Enabled = true
    v58.animator:Halt()

    local function fadeIn() -- line 277 | captures: v55, v56, v57, v58, transition, TweenService, Tween, v1
        if transition ~= v55.transition then
            return
        end
        local messageDefaults = v55.messageDefaults
        v58.label.RichText = true
        v58.label.Text = v56
        v58.label.TextColor3 = v57
        v58.label.MaxVisibleGraphemes = -1
        v58.label.TextTransparency = 1
        v58.label.TextStrokeTransparency = 1
        v58.stroke.Transparency = 1
        Tween(v58.stroke, { Transparency = 0 }, { 0.02 })
        local v59 = {}
        if messageDefaults then
            v59.TextTransparency = messageDefaults.textAlpha
            v59.TextStrokeTransparency = messageDefaults.strokeAlpha
        else
            v59.TextTransparency = 0
            v59.TextStrokeTransparency = 1
        end
        TweenService:Create(v58.label, v1.CROSSFADE_IN, v59):Play()
    end

    if v58.label.Text == "" then
        fadeIn()
    else
        local v60 = TweenService:Create(v58.label, v1.CROSSFADE_OUT, {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        })
        Tween(v58.stroke, { Transparency = 1 }, { 0.02 })
        v60.Completed:Connect(fadeIn)
        v60:Play()
    end
end

function v17.SetAnnounceGradient(v61, v62) -- line 315 | captures: v6, messageParts
    v6(v62)
    messageParts(v61).gradient.Enabled = v62
end

function v17.SetAnnounceHeight(v63, v64) -- line 319 | captures: v8, messageParts
    v8(v64)
    local v65 = messageParts(v63)
    local messageDefaults = v63.messageDefaults
    local v66 = if messageDefaults then messageDefaults.framePosition else v65.frame.Position
    if v64 ~= nil then
        v66 = UDim2.new(v66.X.Scale, v66.X.Offset, v64, v66.Y.Offset)
    end
    v65.frame.Position = v66
end

local function DropAnnounce(v67) -- line 336
    v67.transition += 1
    local message = v67.message
    if message == nil then
        return
    end
    message.animator:Blank()
    message.label.Text = ""
    local message_2 = v67.message
    local messageDefaults = v67.messageDefaults
    if message_2 ~= nil then
        local v68 = if messageDefaults then messageDefaults.textAlpha else 0
        message_2.label.TextTransparency = v68
        message_2.stroke.Transparency = 0
        local v69 = if messageDefaults then messageDefaults.strokeAlpha else 1
        message_2.label.TextStrokeTransparency = v69
    end
    local messageDefaults_2 = v67.messageDefaults
    if messageDefaults_2 then
        message.frame.Position = messageDefaults_2.framePosition
    end
    message.gradient.Enabled = false
    message.screen.Enabled = false
end

v17.DropAnnounce = DropAnnounce

function v17.TrackSpeedGoal(v70, v71, v72) -- line 369 | captures: TweenService, v1, v6, v7, progressParts, setReadyPulse
    v7(v71)
    v6(v72)
    local v73 = progressParts(v70)
    v73.frame.Visible = true
    local fillTween = v70.fillTween
    if fillTween then
        fillTween:Cancel()
    end
    local Size = v73.fill.Size
    local v74 = math.clamp(v71, 0, 1)
    local v75 = UDim2.new(v74, 0, Size.Y.Scale, Size.Y.Offset)
    local v76 = TweenService:Create(v73.fill, v1.FILL, { Size = v75 })
    v70.fillTween = v76
    v76:Play()
    setReadyPulse(v70, v73, v72)
end

local function DropSpeedGoal(v77) -- line 386
    local fillTween = v77.fillTween
    if fillTween then
        fillTween:Cancel()
    end
    v77.fillTween = nil
    local readyScaleTween = v77.readyScaleTween
    if readyScaleTween then
        readyScaleTween:Cancel()
    end
    v77.readyScaleTween = nil
    local readyWhiteTween = v77.readyWhiteTween
    if readyWhiteTween then
        readyWhiteTween:Cancel()
    end
    v77.readyWhiteTween = nil
    local progress = v77.progress
    if progress == nil then
        return
    end
    local Size = progress.fill.Size
    progress.fill.Size = UDim2.new(0, 0, Size.Y.Scale, Size.Y.Offset)
    progress.ready.Visible = false
    progress.readyScale.Scale = 1
    progress.white.TextTransparency = 1
    progress.frame.Visible = false
end

v17.DropSpeedGoal = DropSpeedGoal

function v17.PointBeamAt(v78, v79) -- line 413 | captures: TutorialBeam
    local v80
    if typeof(v79) == "Vector3" then
        v80 = true
    elseif typeof(v79) == "Instance" then
        v80 = v79:IsA("BasePart")
    else
        v80 = false
    end
    assert(v80, "a tutorial anchor has to be a BasePart or a Vector3")
    local beam = v78.beam
    if beam == nil then
        v78.beam = TutorialBeam.Attach(v79)
    else
        TutorialBeam.Retarget(beam, v79)
    end
end

function v17.RetargetBeam(v81, v82) -- line 423 | captures: TutorialBeam
    local v83
    if typeof(v82) == "Vector3" then
        v83 = true
    elseif typeof(v82) == "Instance" then
        v83 = v82:IsA("BasePart")
    else
        v83 = false
    end
    assert(v83, "a tutorial anchor has to be a BasePart or a Vector3")
    local beam = v81.beam
    if beam == nil then
        v81.beam = TutorialBeam.Attach(v82)
    else
        TutorialBeam.Retarget(beam, v82)
    end
end

function v17.DropBeam(v84) -- line 433 | captures: TutorialBeam
    local beam = v84.beam
    if beam ~= nil then
        v84.beam = nil
        TutorialBeam.Destroy(beam)
    end
end

function v17.MarkTapTarget(v85, v86, v87, v88, v89) -- line 440 | captures: TutorialTapIndicator, v9, v13, v14, v15
    v9(v86)
    v13(v87)
    v14(v88)
    v15(v89)
    v85:DropTapTarget()
    v85.dropTapLater = TutorialTapIndicator.Attach(v86, v87, v88, v89)
end

function v17.MarkSurfaceTapTarget(v90, v91, v92, v93, v94, v95) -- line 448 | captures: TutorialTapIndicator, v4, v11, v13, v14, v15
    v11(v91)
    v4(v92)
    v13(v93)
    v14(v94)
    v15(v95)
    local v96
    for v97, v98 in v91:GetChildren() do
        if v98:IsA("SurfaceGui") then
            v96 = v98:FindFirstChild(v92)
            if v96 ~= nil and v96:IsA("GuiButton") then
                break
            end
        end
        v96 = nil
    end
    v90:DropTapTarget()
    if v96 == nil then
        return false
    end
    v90.dropTapLater = TutorialTapIndicator.Attach(v96, v93, v94, v95)
    return true
end

local function DropTapTarget(v99) -- line 472
    local dropTapLater = v99.dropTapLater
    if dropTapLater ~= nil then
        v99.dropTapLater = nil
        dropTapLater()
    end
end

v17.DropTapTarget = DropTapTarget

function v17.PinWorldClickHint(v100, v101) -- line 479 | captures: ReplicatedStorage, TweenService, v1, v12
    v12(v101)
    local clickPart = v100.clickPart
    if clickPart == nil then
        local BillboardTutorialClick = ReplicatedStorage.Assets.Billboards.BillboardTutorialClick
        local BasePart = BillboardTutorialClick:IsA("BasePart")
        assert(BasePart, "Assets.Billboards.BillboardTutorialClick is not a BasePart")
        local v102 = BillboardTutorialClick:Clone()
        v102.CFrame = v101
        v102.Parent = workspace
        local BillboardGui = v102.BillboardGui
        local BillboardGui_2 = BillboardGui:IsA("BillboardGui")
        assert(BillboardGui_2, "the click-hint billboard is not a BillboardGui")
        local Image = BillboardGui.Image
        local ImageLabel = Image:IsA("ImageLabel")
        assert(ImageLabel, "the click-hint image is not a ImageLabel")
        local UIScale = Image.UIScale
        local UIScale_2 = UIScale:IsA("UIScale")
        assert(UIScale_2, "the click-hint scale is not a UIScale")
        v100.clickPart = v102
        UIScale.Scale = 1
        local v103 = TweenService:Create(UIScale, v1.CLICK_PULSE, { Scale = 1.3 })
        v103:Play()
        v100.clickTween = v103
    else
        clickPart.CFrame = v101
    end
end

local function DropWorldClickHint(v104) -- line 508
    local clickTween = v104.clickTween
    if clickTween then
        clickTween:Cancel()
    end
    v104.clickTween = nil
    local clickPart = v104.clickPart
    if clickPart ~= nil then
        clickPart:Destroy()
        v104.clickPart = nil
    end
end

v17.DropWorldClickHint = DropWorldClickHint

function v17.SetScreenClickHint(v105, v106) -- line 520 | captures: Players, TweenService, v1, v6
    v6(v106)
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    local PlayerGui_2 = PlayerGui:IsA("PlayerGui")
    assert(PlayerGui_2, "LocalPlayer.PlayerGui is not a PlayerGui")
    local TutorialClick = PlayerGui:WaitForChild("TutorialClick")
    local ScreenGui = TutorialClick:IsA("ScreenGui")
    assert(ScreenGui, "PlayerGui.TutorialClick is not a ScreenGui")
    local Image = TutorialClick.Image
    local ImageLabel = Image:IsA("ImageLabel")
    assert(ImageLabel, "TutorialClick.Image is not a ImageLabel")
    local UIScale = Image.UIScale
    local UIScale_2 = UIScale:IsA("UIScale")
    assert(UIScale_2, "TutorialClick.Image.UIScale is not a UIScale")
    v105.screenClick = TutorialClick
    if v106 then
        TutorialClick.Enabled = true
        if v105.screenClickTween == nil then
            UIScale.Scale = 1
            local v107 = TweenService:Create(UIScale, v1.CLICK_PULSE, { Scale = 1.3 })
            v107:Play()
            v105.screenClickTween = v107
        end
    else
        v105:DropScreenClickHint()
    end
end

local function DropScreenClickHint(v108) -- line 549
    local screenClickTween = v108.screenClickTween
    if screenClickTween then
        screenClickTween:Cancel()
    end
    v108.screenClickTween = nil
    local screenClick = v108.screenClick
    if screenClick ~= nil then
        screenClick.Enabled = false
    end
end

v17.DropScreenClickHint = DropScreenClickHint

function v17.RingButton(v109, v110) -- line 560 | captures: TutorialHighlightOverlay, v10
    v10(v110)
    v109:DropRing()
    v109.dropRingLater = TutorialHighlightOverlay.Attach(v110)
end

local function DropRing(v111) -- line 565
    local dropRingLater = v111.dropRingLater
    if dropRingLater ~= nil then
        v111.dropRingLater = nil
        dropRingLater()
    end
end

v17.DropRing = DropRing

function v17.PointArrowAt(v112, v113, v114, v115) -- line 572 | captures: ArrowPointer3D
    local function v116(...)
        assert(...)
    end

    local v117
    if typeof(v113) == "Vector3" then
        v117 = true
    elseif typeof(v113) == "Instance" then
        v117 = v113:IsA("BasePart")
    else
        v117 = false
    end
    assert(v117, "a tutorial anchor has to be a BasePart or a Vector3")
    local v118
    if typeof(v114) == "Vector3" then
        v118 = true
    elseif typeof(v114) == "Instance" then
        v118 = v114:IsA("BasePart")
    else
        v118 = false
    end
    assert(v118, "a tutorial anchor has to be a BasePart or a Vector3")
    v116(ArrowPointer3D.__types.OptionalConfig(v115))
    v112:DropArrow()
    local v119 = ArrowPointer3D.new(v113, v114, v115)
    v119:Start()
    v112.arrow = v119
end

local function RetargetArrow(v120, v121) -- line 583
    local v122
    if typeof(v121) == "Vector3" then
        v122 = true
    elseif typeof(v121) == "Instance" then
        v122 = v121:IsA("BasePart")
    else
        v122 = false
    end
    assert(v122, "a tutorial anchor has to be a BasePart or a Vector3")
    local arrow = v120.arrow
    assert(arrow, "there is no tutorial arrow to retarget"):PointAt(v121)
end

v17.RetargetArrow = RetargetArrow

local function RebaseArrow(v123, v124) -- line 588
    local v125
    if typeof(v124) == "Vector3" then
        v125 = true
    elseif typeof(v124) == "Instance" then
        v125 = v124:IsA("BasePart")
    else
        v125 = false
    end
    assert(v125, "a tutorial anchor has to be a BasePart or a Vector3")
    local arrow = v123.arrow
    assert(arrow, "there is no tutorial arrow to rebase"):PointFrom(v124)
end

v17.RebaseArrow = RebaseArrow

local function DropArrow(v126) -- line 593
    local arrow = v126.arrow
    if arrow ~= nil then
        v126.arrow = nil
        arrow:Destroy()
    end
end

v17.DropArrow = DropArrow

local function DropEverything(v127) -- line 600
    v127:DropArrow()
    v127:DropBeam()
    v127:DropWorldClickHint()
    v127:DropRing()
    v127:DropTapTarget()
    v127:DropScreenClickHint()
    v127:DropSpeedGoal()
    v127:DropAnnounce()
end

v17.DropEverything = DropEverything

function v17.Destroy(v128) -- line 610 | captures: v16
    v16:AtTrace():Log("Tearing down the guard tutorial presentation layer")
    v128:DropEverything()
    local progress = v128.progress
    if v128.ownsReadyScale and progress ~= nil then
        progress.readyScale:Destroy()
        v128.progress = nil
    end
end

return v17
