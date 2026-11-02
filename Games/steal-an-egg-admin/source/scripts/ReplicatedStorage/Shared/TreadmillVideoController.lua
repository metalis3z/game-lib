-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SocialService = game:GetService("SocialService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local ButtonHintStrip = require(ReplicatedStorage.Client.ButtonHintStrip)
local ClientGlobals = require(ReplicatedStorage.Client.ClientGlobals)
local CommentsController = require(script.CommentsController)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local FeedSequencer = require(script.FeedSequencer)
local FriendLikesController = require(script.FriendLikesController)
local GUI = require(ReplicatedStorage.Client.GUI)
local GamepadBindings = require(ReplicatedStorage.Client.GamepadBindings)
local ImageColorPulse = require(ReplicatedStorage.Client.UI.VFX.ImageColorPulse)
local LikeController = require(script.LikeController)
local Log = require(ReplicatedStorage.Packages.Log)
local Media = require(script.Media)
local PlatformSignals = require(ReplicatedStorage.Client.PlatformSignals)
local WarmAssets = require(ReplicatedStorage.Shared.Utils.Warmup).WarmAssets
local RecommendationFeedSource = require(script.RecommendationFeedSource)
local RecommendationFlags = require(script.RecommendationFlags)
local RecommendationSignals = require(script.RecommendationSignals)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local RuntimeInstanceRegistry = require(ReplicatedStorage.Client.Modules.RuntimeInstanceRegistry)
local ScaleUDim2 = require(ReplicatedStorage.Shared.Utils.Layout).ScaleUDim2
local Schema = require(script.Types.Schema)
local Signal = require(ReplicatedStorage.Packages.Signal)
local TouchTapTracker = require(ReplicatedStorage.Client.Input.TouchTapTracker)
local TreadmillMediaIdentity = require(ReplicatedStorage.Shared.Modules.TreadmillMediaIdentity)
local TreadmillMediaOverlay = require(ReplicatedStorage.Shared.Modules.TreadmillMediaOverlay)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local Trove = require(ReplicatedStorage.Packages.Trove)
require(script.Types.Interface)
local VideoFramePool = require(script.VideoFramePool)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local v1 = TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false)
local Value = Enum.ContextActionPriority.High.Value
local ButtonL2 = Enum.KeyCode.ButtonL2
local ButtonR2 = Enum.KeyCode.ButtonR2
local v2 = TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local v3 = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local v4 = Color3.fromRGB(255, 0, 0)
local v5 = TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true)
local v6 = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v7 = TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v8 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
task.spawn(require(ReplicatedStorage.Shared.Utils.Warmup).WarmSounds, "rbxassetid://73631216564444", "rbxassetid://113746383939224")
local LocalPlayer = Players.LocalPlayer
local v9 = Log.new()
local v10 = GUI.TreadmillScreenButtonSwapLeft()
local SurfaceGui = v10:IsA("SurfaceGui")
assert(SurfaceGui, "Treadmill left swap GUI must be a SurfaceGui")
local v11 = GUI.TreadmillScreenButtonSwapRight()
local SurfaceGui_2 = v11:IsA("SurfaceGui")
assert(SurfaceGui_2, "Treadmill right swap GUI must be a SurfaceGui")
local v12 = GUI.TreadmillScreenButtonShare()
local SurfaceGui_3 = v12:IsA("SurfaceGui")
assert(SurfaceGui_3, "Treadmill share GUI must be a SurfaceGui")
local v13 = GUI.TreadmillScreenSideButtons()
local SurfaceGui_4 = v13:IsA("SurfaceGui")
assert(SurfaceGui_4, "Treadmill side buttons GUI must be a SurfaceGui")
local v14 = GUI.TreadmillVideoSurfaceGui()
local SurfaceGui_5 = v14:IsA("SurfaceGui")
assert(SurfaceGui_5, "Treadmill video GUI must be a SurfaceGui")
local ButtonSwapLeft = v10.ButtonSwapLeft
local GuiButton = ButtonSwapLeft:IsA("GuiButton")
assert(GuiButton, "Treadmill left swap button must be a GuiButton")
local ButtonSwapRight = v11.ButtonSwapRight
local ImageButton = ButtonSwapRight:IsA("ImageButton")
assert(ImageButton, "Treadmill right swap button must be an ImageButton")
local ConsoleButton = v10.ButtonSwapLeft.ConsoleButton
local GuiObject = ConsoleButton:IsA("GuiObject")
assert(GuiObject, "Treadmill left swap ConsoleButton must be a GuiObject")
local v15

if ConsoleButton:GetAttribute("ConsoleButton") == "ButtonLB" then
    v15 = true
    GuiObject = true
else
    v15 = false
    GuiObject = false
end
assert(GuiObject, "Treadmill left swap ConsoleButton must use ButtonLB")
local ConsoleButton_2 = v11.ButtonSwapRight.ConsoleButton
local GuiObject_2 = ConsoleButton_2:IsA("GuiObject")
assert(GuiObject_2, "Treadmill right swap ConsoleButton must be a GuiObject")
GuiObject_2 = ConsoleButton_2:GetAttribute("ConsoleButton") == "ButtonRB"
assert(GuiObject_2, "Treadmill right swap ConsoleButton must use ButtonRB")
local ShareButton = v12.Frame.ShareButton
local GuiButton_2 = ShareButton:IsA("GuiButton")
assert(GuiButton_2, "Treadmill share button must be a GuiButton")
local VideoFrame = v14.VideoFrame
local Frame = VideoFrame:IsA("Frame")
assert(Frame, "Treadmill video frame container must be a Frame")
local MainVideo = VideoFrame.MainVideo
local VideoFrame_2 = MainVideo:IsA("VideoFrame")
assert(VideoFrame_2, "Treadmill main video must be a VideoFrame")
local StopPlay = VideoFrame.StopPlay
local ImageLabel = StopPlay:IsA("ImageLabel")
assert(ImageLabel, "Treadmill stop-play indicator must be an ImageLabel")
local MusicImage = VideoFrame.MusicImage
local ImageLabel_2 = MusicImage:IsA("ImageLabel")
assert(ImageLabel_2, "Treadmill music image must be an ImageLabel")
local Loading = VideoFrame.Loading
local GuiObject_3 = Loading:IsA("GuiObject")
assert(GuiObject_3, "Treadmill video loading frame must be a GuiObject")
local Spin = Loading.Spin
local GuiObject_4 = Spin:IsA("GuiObject")
assert(GuiObject_4, "Treadmill video loading spinner must be a GuiObject")
local Bar = VideoFrame.Bar
local GuiObject_5 = Bar:IsA("GuiObject")
assert(GuiObject_5, "Treadmill video bar must be a GuiObject")
local Progress = Bar.Progress
local GuiObject_6 = Progress:IsA("GuiObject")
assert(GuiObject_6, "Treadmill video progress must be a GuiObject")
local GoToNext = VideoFrame.GoToNext
local Frame_2 = GoToNext:IsA("Frame")
assert(Frame_2, "Treadmill VideoFrame.GoToNext must be a Frame")
local Glow = GoToNext.Glow
local ImageLabel_3 = Glow:IsA("ImageLabel")
assert(ImageLabel_3, "Treadmill GoToNext.Glow must be an ImageLabel")
local Arrow = GoToNext.Arrow
local ImageLabel_4 = Arrow:IsA("ImageLabel")
assert(ImageLabel_4, "Treadmill GoToNext.Arrow must be an ImageLabel")
local ArrowShadow = GoToNext.ArrowShadow
local ImageLabel_5 = ArrowShadow:IsA("ImageLabel")
assert(ImageLabel_5, "Treadmill GoToNext.ArrowShadow must be an ImageLabel")
local Label = GoToNext.Label
local TextLabel = Label:IsA("TextLabel")
assert(TextLabel, "Treadmill GoToNext.Label must be a TextLabel")
local LabelShadow = GoToNext.LabelShadow
local TextLabel_2 = LabelShadow:IsA("TextLabel")
assert(TextLabel_2, "Treadmill GoToNext.LabelShadow must be a TextLabel")
local Position = Arrow.Position
local Position_2 = ArrowShadow.Position
local Paused = VideoFrame.Paused
local Frame_3 = Paused:IsA("Frame")
assert(Frame_3, "Treadmill VideoFrame.Paused must be a Frame")
local Glow_2 = Paused.Glow
local ImageLabel_6 = Glow_2:IsA("ImageLabel")
assert(ImageLabel_6, "Treadmill Paused.Glow must be an ImageLabel")
local StopPlay_2 = Paused.StopPlay
local ImageLabel_7 = StopPlay_2:IsA("ImageLabel")
assert(ImageLabel_7, "Treadmill Paused.StopPlay must be an ImageLabel")
local EnjoyFree = StopPlay_2:FindFirstChild("EnjoyFree")
local VideoCounter = VideoFrame:FindFirstChild("VideoCounter")
local v16 = {}
local v17 = {
    Property = "ImageTransparency",
    Instance = Glow,
    Value = Glow.ImageTransparency
}
local v18 = {
    Property = "ImageTransparency",
    Instance = Arrow,
    Value = Arrow.ImageTransparency
}
local v19 = {
    Property = "ImageTransparency",
    Instance = ArrowShadow,
    Value = ArrowShadow.ImageTransparency
}
local v20 = {
    Property = "TextTransparency",
    Instance = Label,
    Value = Label.TextTransparency
}
local v21 = {
    Property = "TextTransparency",
    Instance = LabelShadow,
    Value = LabelShadow.TextTransparency
}

v16[1] = {
    Property = "BackgroundTransparency",
    Instance = GoToNext,
    Value = GoToNext.BackgroundTransparency
}
v16[2] = v17
v16[3] = v18
v16[4] = v19
v16[5] = v20
v16[6] = v21

local v22 = {}
local v23 = {
    Property = "ImageTransparency",
    Instance = Glow_2,
    Value = Glow_2.ImageTransparency
}
local v24 = {
    Property = "ImageTransparency",
    Instance = StopPlay_2,
    Value = StopPlay_2.ImageTransparency
}

v22[1] = {
    Property = "BackgroundTransparency",
    Instance = Paused,
    Value = Paused.BackgroundTransparency
}
v22[2] = v23
v22[3] = v24

if EnjoyFree ~= nil and EnjoyFree:IsA("TextLabel") then
    local v25 = {
        Property = "TextTransparency",
        Instance = EnjoyFree,
        Value = EnjoyFree.TextTransparency
    }
    table.insert(v22, v25)
end
local v26 = 0
local v27, v28
local v29 = table.clone(Media)

if Constants.IS_STUDIO then
    local v30, v31 = Schema.TreadmillMediaEntries(v29)
    local v32 = ("Failed to validate treadmill video media entries: %*"):format(v31)
    assert(v30, v32)
end
TreadmillMediaOverlay.ApplyTo(v29)
task.spawn(function() -- line 178 | captures: RecommendationFeedSource, RecommendationFlags, v29
    RecommendationFlags.Enabled.Loaded:Wait()
    task.wait(math.random() * RecommendationFlags.PrefetchJitterSeconds:Get())
    RecommendationFeedSource.PrefetchFeed(v29)
end)
local v33 = {
    MediaChanged = Signal.new(),
    Stopped = Signal.new()
}

local function cancelStopPlayTween(v34) -- line 184
    local StopPlayTween = v34.StopPlayTween
    v34.StopPlayTween = nil
    if StopPlayTween ~= nil then
        StopPlayTween:Cancel()
    end
end

local function resetStopPlayIndicator(v35) -- line 191
    local StopPlayTween = v35.StopPlayTween
    v35.StopPlayTween = nil
    if StopPlayTween ~= nil then
        StopPlayTween:Cancel()
    end
    v35.StopPlay.ImageTransparency = 0
    v35.StopPlay.Size = v35.StopPlayBaseSize
end

local function animateStopPlayIndicator(v36, v37) -- line 200 | captures: TweenService, ScaleUDim2, v2, v3
    local StopPlayTween = v36.StopPlayTween
    v36.StopPlayTween = nil
    if StopPlayTween ~= nil then
        StopPlayTween:Cancel()
    end
    local StopPlay = v36.StopPlay
    StopPlay.Visible = true
    local v38 = if v37 then "rbxassetid://113746383939224" else "rbxassetid://73631216564444"
    StopPlay.Image = v38
    StopPlay.ImageTransparency = 0
    local v39 = if v37 then 1.24 else 0.76
    StopPlay.Size = ScaleUDim2(v36.StopPlayBaseSize, v39)
    local v40 = TweenService:Create(StopPlay, v2, { Size = v36.StopPlayBaseSize })
    v36.StopPlayTween = v40
    v40.Completed:Once(function() -- line 224 | captures: v36, v37, StopPlay, v40, TweenService, v3
        if v36.StopPlayTween == v40 then
            v36.StopPlayTween = nil
            if v37 then
                local v41 = TweenService:Create(StopPlay, v3, { ImageTransparency = 1 })
                v36.StopPlayTween = v41
                v41.Completed:Once(function() -- line 234 | captures: v41, v36, StopPlay
                    if v36.StopPlayTween ~= v41 then
                        return
                    end
                    v36.StopPlayTween = nil
                    StopPlay.Visible = false
                    StopPlay.ImageTransparency = 0
                end)
                v41:Play()
            end
        end
    end)
    v40:Play()
end

local function playCardFadeIn(v42, v43, v44) -- line 246 | captures: TweenService
    for v45, v46 in v42 do
        local Instance = v46.Instance
        Instance[v46.Property] = 1
        local Instance_2 = v46.Instance
        local v47 = {}
        v47[v46.Property] = v46.Value
        local v48 = TweenService:Create(Instance_2, v44, v47)
        local v49 = v46
        v43:Add(function() -- line 258 | captures: Instance, v48, v49
            v48:Cancel()
            Instance[v49.Property] = v49.Value
        end)
        v48:Play()
    end
end

local function hidePausedCard(v50) -- line 265 | captures: Paused
    local PausedCardTrove = v50.PausedCardTrove
    v50.PausedCardTrove = nil
    if PausedCardTrove ~= nil then
        PausedCardTrove:Destroy()
    end
    Paused.Visible = false
    if v50.MusicSound ~= nil then
        v50.MusicImage.Visible = true
    end
    local PausedPreviewFrame = v50.PausedPreviewFrame
    local PausedPreviewBaseSize = v50.PausedPreviewBaseSize
    v50.PausedPreviewFrame = nil
    v50.PausedPreviewBaseSize = nil
    if PausedPreviewFrame ~= nil and PausedPreviewBaseSize ~= nil then
        PausedPreviewFrame.Size = PausedPreviewBaseSize
    end
end

local function showPausedCard(v51) -- line 283 | captures: ScaleUDim2, Trove, v8, Paused, EnjoyFree, v22, playCardFadeIn
    if v51.PausedCardTrove == nil and v51.EndCardTrove == nil then
        local v52 = Trove.new()
        v51.PausedCardTrove = v52
        playCardFadeIn(v22, v52, v8)
        if EnjoyFree ~= nil and EnjoyFree:IsA("TextLabel") then
            EnjoyFree.Visible = not v51.HasPlayedMedia
        end
    else
        return
    end
    Paused.Visible = true
    v51.MusicImage.Visible = false
    local v53 = v51.VideoFramePool.GetActiveFrame()
    if v53.TimePosition <= 0 and not v53.Playing then
        pcall(function() -- line 298 | captures: v53
            v53:Play()
            v53:Pause()
            v53.TimePosition = 0
        end)
    end
    local Size = v53.Size
    local v54 = if Size.X.Scale <= 0 then 1 else 1 / Size.X.Scale
    local v55 = if Size.Y.Scale <= 0 then 1 else 1 / Size.Y.Scale
    local v56 = math.max(v54, v55)
    if not (v56 > 1) then
        return
    end
    v51.PausedPreviewFrame = v53
    v51.PausedPreviewBaseSize = Size
    v53.Size = ScaleUDim2(Size, v56)
end

local function hideGoToNext(v57) -- line 322 | captures: GoToNext
    local EndCardTrove = v57.EndCardTrove
    v57.EndCardTrove = nil
    if EndCardTrove ~= nil then
        EndCardTrove:Destroy()
    end
    GoToNext.Visible = false
end

local function spawnGoToNextPulse(v58) -- line 330 | captures: TweenService, ScaleUDim2, v7, GoToNext, Arrow
    local v59 = Arrow:Clone()
    v59.Name = "ArrowPulse"
    local v60 = Arrow.ZIndex - 1
    v59.ZIndex = math.max(v60, 0)
    v59.ImageTransparency = 0.35
    v59.Parent = GoToNext
    v58:Add(v59)
    local v61 = TweenService:Create(v59, v7, {
        ImageTransparency = 1,
        Size = ScaleUDim2(Arrow.Size, 2.2)
    })
    v61.Completed:Once(function() -- line 338 | captures: v59
        v59:Destroy()
    end)
    v61:Play()
end

local function showGoToNext(v62) -- line 343 | captures: Trove, v6, GoToNext, Arrow, ArrowShadow, Position, Position_2, Paused, v16, playCardFadeIn, spawnGoToNextPulse
    if v62.EndCardTrove ~= nil then
        return
    end
    local PausedCardTrove = v62.PausedCardTrove
    v62.PausedCardTrove = nil
    if PausedCardTrove ~= nil then
        PausedCardTrove:Destroy()
    end
    Paused.Visible = false
    if v62.MusicSound ~= nil then
        v62.MusicImage.Visible = true
    end
    local PausedPreviewFrame = v62.PausedPreviewFrame
    local PausedPreviewBaseSize = v62.PausedPreviewBaseSize
    v62.PausedPreviewFrame = nil
    v62.PausedPreviewBaseSize = nil
    if PausedPreviewFrame ~= nil and PausedPreviewBaseSize ~= nil then
        PausedPreviewFrame.Size = PausedPreviewBaseSize
    end
    local v63 = Trove.new()
    v62.EndCardTrove = v63
    v62.StopPlay.Visible = false
    v62.SideButtonsSurfaceGui.Enabled = false
    v62.ShareSurfaceGui.Enabled = false
    playCardFadeIn(v16, v63, v6)
    GoToNext.Visible = true
    local v64 = GoToNext:GetAttribute("SwaySeconds") or 1.2
    local v65 = GoToNext:GetAttribute("SwayScale") or 0.02
    local v66 = os.clock()
    local v67 = 0
    local Value = Enum.RenderPriority.Last.Value
    v63:BindToRenderStep("TreadmillGoToNextCard", Value, function() -- line 374 | captures: v67, v63, v64, v65, v66, Arrow, ArrowShadow, Position, Position_2, spawnGoToNextPulse
        local v68 = os.clock() - v66
        local v69 = v68 * 3.141592653589793 * 2 / v64
        local v70 = math.sin(v69)
        local v71 = UDim2.fromScale(v70 * v65, 0)
        Arrow.Position = Position + v71
        ArrowShadow.Position = Position_2 + v71
        local v72 = v68 / v64 + 0.75
        local v73 = math.floor(v72)
        if v67 < v73 then
            v67 = v73
            spawnGoToNextPulse(v63)
        end
    end)
    v63:Add(function() -- line 386 | captures: Arrow, ArrowShadow, Position, Position_2
        Arrow.Position = Position
        ArrowShadow.Position = Position_2
    end)
end

local function setSoundPlaying(v74, v75) -- line 391
    if v75 then
        if v74.TimePosition > 0 then
            v74:Resume()
        else
            v74:Play()
        end
    else
        v74:Pause()
    end
end

local function setMediaPlaying(v76, v77, v78) -- line 402 | captures: Paused, animateStopPlayIndicator, showPausedCard
    local MusicSound = v76.MusicSound
    if MusicSound == nil then
        if v77 then
            v76.VideoFramePool.GetActiveFrame():Play()
            local VideoBackgroundMusicSound = v76.VideoBackgroundMusicSound
            if VideoBackgroundMusicSound ~= nil then
                if VideoBackgroundMusicSound.TimePosition <= 0 then
                    VideoBackgroundMusicSound:Play()
                else
                    VideoBackgroundMusicSound:Resume()
                end
            end
        else
            v76.VideoFramePool.GetActiveFrame():Pause()
            local VideoBackgroundMusicSound = v76.VideoBackgroundMusicSound
            if VideoBackgroundMusicSound ~= nil then
                VideoBackgroundMusicSound:Pause()
            end
        end
    elseif v77 then
        if MusicSound.TimePosition <= 0 then
            MusicSound:Play()
        else
            MusicSound:Resume()
        end
    else
        MusicSound:Pause()
    end
    if v77 then
        v76.HasPlayedMedia = true
        local PausedCardTrove = v76.PausedCardTrove
        v76.PausedCardTrove = nil
        if PausedCardTrove ~= nil then
            PausedCardTrove:Destroy()
        end
        Paused.Visible = false
        if v76.MusicSound ~= nil then
            v76.MusicImage.Visible = true
        end
        local PausedPreviewFrame = v76.PausedPreviewFrame
        local PausedPreviewBaseSize = v76.PausedPreviewBaseSize
        v76.PausedPreviewFrame = nil
        v76.PausedPreviewBaseSize = nil
        if PausedPreviewFrame ~= nil and PausedPreviewBaseSize ~= nil then
            PausedPreviewFrame.Size = PausedPreviewBaseSize
        end
    else
        showPausedCard(v76)
    end
    if v78 == false then
        local StopPlayTween = v76.StopPlayTween
        v76.StopPlayTween = nil
        if StopPlayTween ~= nil then
            StopPlayTween:Cancel()
        end
        v76.StopPlay.ImageTransparency = 0
        v76.StopPlay.Size = v76.StopPlayBaseSize
        v76.StopPlay.Visible = not v77
    else
        animateStopPlayIndicator(v76, v77)
    end
end

local function getSurfaceHitScale(v79, v80, v81) -- line 463
    local v82
    if v80 == Enum.NormalId.Front then
        v82 = Vector3.new(0, 0, -1)
    elseif v80 == Enum.NormalId.Back then
        v82 = Vector3.new(0, 0, 1)
    elseif v80 == Enum.NormalId.Right then
        v82 = Vector3.new(1, 0, 0)
    elseif v80 == Enum.NormalId.Left then
        v82 = Vector3.new(-1, 0, 0)
    elseif v80 == Enum.NormalId.Top then
        v82 = Vector3.new(0, 1, 0)
    else
        v82 = Vector3.new(0, -1, 0)
    end
    local Y = v82.Y
    local v83
    if math.abs(Y) == 1 then
        v83 = Vector3.new(0, 0, 1)
    else
        v83 = Vector3.new(0, 1, 0)
    end
    local Unit = v82:Cross(v83).Unit
    local Unit_2 = Unit:Cross(v82).Unit
    local v84 = v79.CFrame:PointToObjectSpace(v81)
    local v85 = v79.Size * 0.5
    local X = v82.X
    local v86 = math.abs(X) * v85.X
    local Y_2 = v82.Y
    local v87 = v86 + math.abs(Y_2) * v85.Y
    local Z = v82.Z
    local v88 = v87 + math.abs(Z) * v85.Z
    local X_2 = Unit.X
    local v89 = math.abs(X_2) * v85.X
    local Y_3 = Unit.Y
    local v90 = v89 + math.abs(Y_3) * v85.Y
    local Z_2 = Unit.Z
    local v91 = v90 + math.abs(Z_2) * v85.Z
    local X_3 = Unit_2.X
    local v92 = math.abs(X_3) * v85.X
    local Y_4 = Unit_2.Y
    local v93 = v92 + math.abs(Y_4) * v85.Y
    local Z_3 = Unit_2.Z
    local v94 = v93 + math.abs(Z_3) * v85.Z
    local v95 = v84 - v82 * v88
    local v96 = 0.5 - v95:Dot(Unit) / (v91 * 2)
    local v97 = math.clamp(v96, 0, 1)
    local v98 = 0.5 - v95:Dot(Unit_2) / (v94 * 2)
    return Vector2.new(v97, (math.clamp(v98, 0, 1)))
end

local function getVideoScreenTapScale(v99, v100) -- line 512 | captures: Workspace, getSurfaceHitScale
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return nil
    end
    local v101 = CurrentCamera:ScreenPointToRay(v100.X, v100.Y)
    local v102 = Workspace:Raycast(v101.Origin, v101.Direction * 1000, v99.VideoScreenRaycastParams)
    if not (v102 ~= nil and v102.Instance == v99.VideoScreenPart) then
        return nil
    end
    return getSurfaceHitScale(v99.VideoScreenPart, v99.VideoSurfaceGui.Face, v102.Position)
end

local function toggleMediaPlaying(v103) -- line 524 | captures: setMediaPlaying
    local MusicSound = v103.MusicSound
    if MusicSound == nil then
        setMediaPlaying(v103, not v103.VideoFramePool.GetActiveFrame().Playing)
    else
        setMediaPlaying(v103, not MusicSound.IsPlaying)
    end
end

local function setVideoProgress(v104, v105) -- line 532
    local Size = v104.Progress.Size
    local v106 = math.clamp(v105, 0, 1)
    v104.Progress.Size = UDim2.new(v106, 0, Size.Y.Scale, Size.Y.Offset)
end

local function updateMediaProgress(v107) -- line 537
    local MusicSound = v107.MusicSound
    if MusicSound == nil then
        local v108 = v107.VideoFramePool.GetActiveFrame()
        local TimeLength = v108.TimeLength
        if TimeLength <= 0 then
            local Size = v107.Progress.Size
            v107.Progress.Size = UDim2.new(0, 0, Size.Y.Scale, Size.Y.Offset)
        else
            local Size = v107.Progress.Size
            local v109 = v108.TimePosition / TimeLength
            local v110 = math.clamp(v109, 0, 1)
            v107.Progress.Size = UDim2.new(v110, 0, Size.Y.Scale, Size.Y.Offset)
        end
    else
        local TimeLength = MusicSound.TimeLength
        if TimeLength <= 0 then
            local Size = v107.Progress.Size
            v107.Progress.Size = UDim2.new(0, 0, Size.Y.Scale, Size.Y.Offset)
        else
            local Size = v107.Progress.Size
            local v111 = MusicSound.TimePosition / TimeLength
            local v112 = math.clamp(v111, 0, 1)
            v107.Progress.Size = UDim2.new(v112, 0, Size.Y.Scale, Size.Y.Offset)
        end
    end
end

local function getWatchedFraction(v113) -- line 562
    local MusicSound = v113.MusicSound
    if MusicSound == nil then
        local v114 = v113.VideoFramePool.GetActiveFrame()
        local TimeLength = v114.TimeLength
        if TimeLength <= 0 then
            return nil
        end
        return v114.TimePosition / TimeLength
    end
    local TimeLength = MusicSound.TimeLength
    if TimeLength <= 0 then
        return nil
    end
    return MusicSound.TimePosition / TimeLength
end

local function hideLoading(v115) -- line 578
    local LoadingTween = v115.LoadingTween
    v115.LoadingTween = nil
    if LoadingTween ~= nil then
        LoadingTween:Cancel()
    end
    v115.Loading.Visible = false
    v115.LoadingSpin.Rotation = 0
end

local function showLoading(v116) -- line 587 | captures: TweenService, v1
    local LoadingTween = v116.LoadingTween
    v116.LoadingTween = nil
    if LoadingTween ~= nil then
        LoadingTween:Cancel()
    end
    v116.Loading.Visible = false
    v116.LoadingSpin.Rotation = 0
    v116.Loading.Visible = true
    v116.ShareSurfaceGui.Enabled = false
    v116.SideButtonsSurfaceGui.Enabled = false
    local v117 = TweenService:Create(v116.LoadingSpin, v1, { Rotation = 360 })
    v116.LoadingTween = v117
    v117:Play()
end

local function clearMusicImage(v118) -- line 602
    v118.MusicImage.Visible = false
    v118.MusicImage.Image = ""
    local MusicSound = v118.MusicSound
    v118.MusicSound = nil
    if MusicSound ~= nil then
        MusicSound:Stop()
        MusicSound:Destroy()
    end
end

local function clearVideoBackgroundMusic(v119) -- line 613
    local VideoBackgroundMusicSound = v119.VideoBackgroundMusicSound
    v119.VideoBackgroundMusicSound = nil
    if VideoBackgroundMusicSound ~= nil then
        VideoBackgroundMusicSound:Stop()
        VideoBackgroundMusicSound:Destroy()
    end
end

local function unloadVideo(v120) -- line 622 | captures: GoToNext, Paused
    v120.VideoTrove:Clean()
    local EndCardTrove = v120.EndCardTrove
    v120.EndCardTrove = nil
    if EndCardTrove ~= nil then
        EndCardTrove:Destroy()
    end
    GoToNext.Visible = false
    local PausedCardTrove = v120.PausedCardTrove
    v120.PausedCardTrove = nil
    if PausedCardTrove ~= nil then
        PausedCardTrove:Destroy()
    end
    Paused.Visible = false
    if v120.MusicSound ~= nil then
        v120.MusicImage.Visible = true
    end
    local PausedPreviewFrame = v120.PausedPreviewFrame
    local PausedPreviewBaseSize = v120.PausedPreviewBaseSize
    v120.PausedPreviewFrame = nil
    v120.PausedPreviewBaseSize = nil
    if PausedPreviewFrame ~= nil and PausedPreviewBaseSize ~= nil then
        PausedPreviewFrame.Size = PausedPreviewBaseSize
    end
    local LoadingTween = v120.LoadingTween
    v120.LoadingTween = nil
    if LoadingTween ~= nil then
        LoadingTween:Cancel()
    end
    v120.Loading.Visible = false
    v120.LoadingSpin.Rotation = 0
    v120.MusicImage.Visible = false
    v120.MusicImage.Image = ""
    local MusicSound = v120.MusicSound
    v120.MusicSound = nil
    if MusicSound ~= nil then
        MusicSound:Stop()
        MusicSound:Destroy()
    end
    local VideoBackgroundMusicSound = v120.VideoBackgroundMusicSound
    v120.VideoBackgroundMusicSound = nil
    if VideoBackgroundMusicSound ~= nil then
        VideoBackgroundMusicSound:Stop()
        VideoBackgroundMusicSound:Destroy()
    end
    v120.VideoFramePool.ClearActive()
    v120.MainVideo.Size = v120.MainVideoBaseSize
    v120.MainVideo.Volume = 1
    v120.MainVideo.Video = ""
    local StopPlayTween = v120.StopPlayTween
    v120.StopPlayTween = nil
    if StopPlayTween ~= nil then
        StopPlayTween:Cancel()
    end
    v120.StopPlay.ImageTransparency = 0
    v120.StopPlay.Size = v120.StopPlayBaseSize
    v120.StopPlay.Visible = true
    local Size = v120.Progress.Size
    v120.Progress.Size = UDim2.new(0, 0, Size.Y.Scale, Size.Y.Offset)
end

local function wrapVideoIndex(v121) -- line 683 | captures: v29
    if v121 < 1 then
        return #v29
    end
    if #v29 < v121 then
        return 1
    end
    return v121
end

local function preloadMediaIndices(v122, v123) -- line 692 | captures: WarmAssets, v29
    local v124 = {}
    local v125 = {}
    for v126, v127 in ipairs(v123) do
        local v128 = v29[v127]
        if v128.Kind == "Video" then
            local v129 = {
                MediaEntry = v128,
                MediaIndex = v127
            }
            table.insert(v125, v129)
            local Music = v128.Music
            if Music then
                local SoundId = Music.SoundId
                table.insert(v124, SoundId)
            end
        elseif v128.Kind == "MusicImage" then
            local Image = v128.Image
            table.insert(v124, Image)
            local SoundId = v128.SoundId
            table.insert(v124, SoundId)
        end
    end
    v122.VideoFramePool.Preload(v125)
    if #v124 > 0 then
        task.spawn(WarmAssets, v124)
    end
end

local function preloadDirectionalAssets(v130, v131, v132) -- line 714 | captures: v29, preloadMediaIndices
    if v132 < 0 then
        return
    end
    local v133 = {}
    local v134 = v131 + v132 * 1
    if v134 < 1 then
        v134 = #v29
    elseif not (v134 <= #v29) then
        v134 = 1
    end
    table.insert(v133, v134)
    local v135 = v131 + v132 * 2
    if v135 < 1 then
        v135 = #v29
    elseif not (v135 <= #v29) then
        v135 = 1
    end
    table.insert(v133, v135)
    local v136 = v131 + v132 * 3
    if v136 < 1 then
        v136 = #v29
    elseif not (v136 <= #v29) then
        v136 = 1
    end
    table.insert(v133, v136)
    preloadMediaIndices(v130, v133)
end

local function loadVideoBackgroundMusic(v137, v138) -- line 749
    local Sound = Instance.new("Sound")
    Sound.Name = "TreadmillVideoBackgroundMusic"
    Sound.SoundId = v138.SoundId
    Sound.Volume = v138.Volume
    Sound.Looped = true
    Sound.Parent = v137.MainVideo
    v137.VideoBackgroundMusicSound = Sound
    v137.VideoTrove:Add(function() -- line 757 | captures: v137, Sound
        if v137.VideoBackgroundMusicSound == Sound then
            v137.VideoBackgroundMusicSound = nil
        end
        if Sound.Parent ~= nil then
            Sound:Stop()
            Sound:Destroy()
        end
    end)
end

local function resetVideoBackgroundMusic(v139) -- line 767
    local VideoBackgroundMusicSound = v139.VideoBackgroundMusicSound
    if VideoBackgroundMusicSound ~= nil then
        VideoBackgroundMusicSound:Stop()
        VideoBackgroundMusicSound.TimePosition = 0
    end
end

local function loadVideoMedia(v140, v141, v142) -- line 775 | captures: v26, RecommendationSignals, showGoToNext, setMediaPlaying, showLoading, loadVideoBackgroundMusic
    local v143 = v140.VideoFramePool.Activate(v140.VideoIndex, v141)
    v143.Size = v141.Size or v140.MainVideoBaseSize
    local Size = v140.Progress.Size
    v140.Progress.Size = UDim2.new(0, 0, Size.Y.Scale, Size.Y.Offset)
    local Music = v141.Music
    if Music ~= nil then
        loadVideoBackgroundMusic(v140, Music)
    end
    v140.VideoTrove:Add(v143.Ended:Connect(function() -- line 790 | captures: v140, v142, v26, RecommendationSignals, showGoToNext
        if v26 == v140.Token and v140.VideoSerial == v142 then
            RecommendationSignals.MarkEnded()
            local VideoBackgroundMusicSound = v140.VideoBackgroundMusicSound
            if VideoBackgroundMusicSound ~= nil then
                VideoBackgroundMusicSound:Stop()
                VideoBackgroundMusicSound.TimePosition = 0
            end
        else
            return
        end
        showGoToNext(v140)
    end))
    if v143.IsLoaded then
        local LoadingTween = v140.LoadingTween
        v140.LoadingTween = nil
        if LoadingTween ~= nil then
            LoadingTween:Cancel()
        end
        v140.Loading.Visible = false
        v140.LoadingSpin.Rotation = 0
        v140.ShareSurfaceGui.Enabled = true
        v140.SideButtonsSurfaceGui.Enabled = true
        setMediaPlaying(v140, v140.HasPlayedMedia, false)
    else
        v140.StopPlay.Visible = false
        showLoading(v140)
        local v144
        v144 = v143.Loaded:Connect(function() -- line 806 | captures: v144, v140, v142, v26, setMediaPlaying
            local v145
            if v26 == v140.Token and v140.VideoSerial == v142 then
                v144:Disconnect()
                v145 = v140
                local LoadingTween = v140.LoadingTween
                v140.LoadingTween = nil
                if LoadingTween ~= nil then
                    LoadingTween:Cancel()
                end
            else
                return
            end
            v145.Loading.Visible = false
            v145.LoadingSpin.Rotation = 0
            v140.ShareSurfaceGui.Enabled = true
            v140.SideButtonsSurfaceGui.Enabled = true
            setMediaPlaying(v140, v140.HasPlayedMedia, false)
        end)
        v140.VideoTrove:Add(v144)
    end
end

local function loadMusicImageMedia(v146, v147, v148) -- line 837 | captures: v26, RecommendationSignals, showGoToNext, setMediaPlaying, showLoading
    v146.VideoFramePool.ClearActive()
    v146.MainVideo.Video = ""
    v146.MusicImage.Image = v147.Image
    v146.MusicImage.Visible = true
    local Size = v146.Progress.Size
    v146.Progress.Size = UDim2.new(0, 0, Size.Y.Scale, Size.Y.Offset)
    local Sound = Instance.new("Sound")
    Sound.Name = "TreadmillMusicImageSound"
    Sound.SoundId = v147.SoundId
    Sound.Volume = v147.Volume
    Sound.Parent = v146.MainVideo
    Sound.Looped = false
    v146.MusicSound = Sound
    v146.VideoTrove:Add(function() -- line 853 | captures: v146, Sound
        if v146.MusicSound == Sound then
            v146.MusicSound = nil
        end
        if Sound.Parent ~= nil then
            Sound:Stop()
            Sound:Destroy()
        end
    end)
    v146.VideoTrove:Add(Sound.Ended:Connect(function() -- line 862 | captures: v146, v148, v26, RecommendationSignals, showGoToNext
        if v26 == v146.Token and v146.VideoSerial == v148 then
            RecommendationSignals.MarkEnded()
            showGoToNext(v146)
        end
    end))
    if Sound.IsLoaded then
        local LoadingTween = v146.LoadingTween
        v146.LoadingTween = nil
        if LoadingTween ~= nil then
            LoadingTween:Cancel()
        end
        v146.Loading.Visible = false
        v146.LoadingSpin.Rotation = 0
        v146.ShareSurfaceGui.Enabled = true
        v146.SideButtonsSurfaceGui.Enabled = true
        setMediaPlaying(v146, v146.HasPlayedMedia, false)
    else
        v146.StopPlay.Visible = false
        showLoading(v146)
        local v149
        v149 = Sound.Loaded:Connect(function() -- line 873 | captures: v149, v146, v148, v26, setMediaPlaying
            local v150
            if v26 == v146.Token and v146.VideoSerial == v148 then
                v149:Disconnect()
                v150 = v146
                local LoadingTween = v146.LoadingTween
                v146.LoadingTween = nil
                if LoadingTween ~= nil then
                    LoadingTween:Cancel()
                end
            else
                return
            end
            v150.Loading.Visible = false
            v150.LoadingSpin.Rotation = 0
            v146.ShareSurfaceGui.Enabled = true
            v146.SideButtonsSurfaceGui.Enabled = true
            setMediaPlaying(v146, v146.HasPlayedMedia, false)
        end)
        v146.VideoTrove:Add(v149)
    end
end

local function loadVideo(v151, v152, v153, v154, v155) -- line 904 | captures: RecommendationFeedSource, RecommendationSignals, Remotes, v29, v33, unloadVideo, preloadMediaIndices, preloadDirectionalAssets, loadVideoMedia, loadMusicImageMedia
    v151.VideoSerial += 1
    local VideoSerial = v151.VideoSerial
    if v152 < 1 then
        v151.VideoIndex = #v29
    elseif v152 <= #v29 then
        v151.VideoIndex = v152
    else
        v151.VideoIndex = 1
    end
    if RecommendationSignals.HasActiveView() then
        local MusicSound = v151.MusicSound
        local v156
        if MusicSound == nil then
            local v157 = v151.VideoFramePool.GetActiveFrame()
            local TimeLength = v157.TimeLength
            if TimeLength > 0 then
                v156 = v157.TimePosition / TimeLength
            end
        else
            local TimeLength = MusicSound.TimeLength
            if TimeLength > 0 then
                v156 = MusicSound.TimePosition / TimeLength
            end
        end
        RecommendationSignals.EndView(v156)
    end
    if v155 == nil then
        if v153 ~= nil then
            Remotes.Treadmill.RefreshClipCursor:FireServer(v153)
        end
    else
        Remotes.Treadmill.SubmitClipView:FireServer(v155.MediaKey)
        RecommendationSignals.BeginView(v155)
    end
    unloadVideo(v151)
    v151.LikeController:UpdatePresentation()
    v151.FriendLikesController:HandleMediaChanged()
    local v158 = v29[v151.VideoIndex]
    v33.MediaChanged:Fire(v158, v151.VideoScreenPart)
    if v158.Kind == "Video" then
        loadVideoMedia(v151, v158, VideoSerial)
    else
        loadMusicImageMedia(v151, v158, VideoSerial)
    end
    if v155 == nil then
        preloadDirectionalAssets(v151, v151.VideoIndex, v154)
    else
        preloadMediaIndices(v151, RecommendationFeedSource.PeekAhead(3))
    end
end

local function cleanupRuntime() -- line 959 | captures: v26, v27, v28, RecommendationSignals, v33, unloadVideo
    v26 += 1
    v33.Stopped:Fire()
    local v159 = v27
    v27 = nil
    if v159 ~= nil then
        v159:Destroy()
    end
    local v160 = v28
    v28 = nil
    if v160 == nil then
        return
    end
    if RecommendationSignals.HasActiveView() then
        local MusicSound = v160.MusicSound
        local v161
        if MusicSound == nil then
            local v162 = v160.VideoFramePool.GetActiveFrame()
            local TimeLength = v162.TimeLength
            if TimeLength > 0 then
                v161 = v162.TimePosition / TimeLength
            end
        else
            local TimeLength = MusicSound.TimeLength
            if TimeLength > 0 then
                v161 = MusicSound.TimePosition / TimeLength
            end
        end
        RecommendationSignals.EndView(v161)
    end
    unloadVideo(v160)
    v160.LikeController:Destroy()
    v160.FriendLikesController:Destroy()
    v160.StopPlay.Visible = true
    v160.LeftSurfaceGui.Enabled = false
    v160.RightSurfaceGui.Enabled = false
    v160.ShareSurfaceGui.Enabled = false
    v160.SideButtonsSurfaceGui.Enabled = false
    v160.VideoSurfaceGui.Enabled = false
    v160.Trove:Destroy()
end

local function projectConsoleSwapMarker(v163, v164) -- line 1004 | captures: ClientGlobals, GamepadBindings
    v163.Visible = ClientGlobals.Console and v163:GetAttribute("HideOnLoad") ~= true
    if ClientGlobals.Console and (v163:IsA("ImageLabel") or v163:IsA("ImageButton")) then
        v163.Image = GamepadBindings.GlyphFor(v164)
    end
end

local function projectConsoleSwapMarkers() -- line 1021 | captures: ConsoleButton, ConsoleButton_2, projectConsoleSwapMarker
    projectConsoleSwapMarker(ConsoleButton, "ButtonLB")
    projectConsoleSwapMarker(ConsoleButton_2, "ButtonRB")
end

local function isExcludedMediaIndex(v165) -- line 1025 | captures: TreadmillMediaIdentity, TreadmillMediaOverlay, v29
    local v166 = v29[v165]
    if v166 == nil then
        return false
    end
    return (TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v166)))
end

local function updateVideoCounter() -- line 1030 | captures: TreadmillMediaIdentity, TreadmillMediaOverlay, VideoCounter, v29
    if not (VideoCounter ~= nil and VideoCounter:IsA("TextLabel")) then
        return
    end
    local v167 = 0
    for v168 in v29 do
        local v169 = v29[v168]
        if not (v169 ~= nil and TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v169))) then
            v167 += 1
        end
    end
    VideoCounter.Text = ("TOTAL VIDEOS: %*"):format(v167)
end

local function sequencerNextSkippingExcluded(v170) -- line 1048 | captures: v15, FeedSequencer, Remotes, TreadmillMediaIdentity, TreadmillMediaOverlay, v29
    local v171, v172 = FeedSequencer.Next(v170.Feed)
    local v173 = #v29
    for v174 = 1, v173 do
        local v175 = v29[v171]
        if not (v175 ~= nil and TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v175))) then
            break
        end
        Remotes.Treadmill.RefreshClipCursor:FireServer(v172)
        v171, v172 = FeedSequencer.Next(v15.Feed)
    end
    return v171, v172
end

local function sequencerPreviousSkippingExcluded(v176) -- line 1066 | captures: FeedSequencer, Remotes, TreadmillMediaIdentity, TreadmillMediaOverlay, Frame, v29, sequencerNextSkippingExcluded
    local v177, v178, v179 = FeedSequencer.Previous(v176.Feed)
    if v179 then
        local v180 = #v29
        for v181 = 1, v180 do
            local v182 = v29[v177]
            if v182 ~= nil and TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v182)) then
                Remotes.Treadmill.RefreshClipCursor:FireServer(v178)
                local v183
                v177, v178, v183 = FeedSequencer.Previous(Frame.Feed)
                if not v183 then
                    local v184, v185 = sequencerNextSkippingExcluded(Frame)
                    return v184, v185, true
                end
            else
                return v177, v178, true
            end
        end
        return v177, v178, true
    end
    return v177, v178, false
end

local function bindVideoRuntime(v186, v187, v188, v189) -- line 1091 | captures: v26, v28, ContextActionService, SocialService, UserInputService, ButtonFX, ButtonHintStrip, CommentsController, FeedSequencer, FriendLikesController, ImageColorPulse, LikeController, PlatformSignals, RecommendationFeedSource, RecommendationSignals, Remotes, TouchTapTracker, TreadmillMediaIdentity, TreadmillMediaOverlay, TreadmillUtil, Trove, VideoFramePool, TryCall, Value, ButtonL2, ButtonR2, v4, v5, LocalPlayer, v9, v10, v11, v12, v13, v14, ButtonSwapLeft, ButtonSwapRight, ConsoleButton, ConsoleButton_2, ShareButton, VideoFrame, MainVideo, StopPlay, MusicImage, Loading, Spin, Progress, v29, setMediaPlaying, getVideoScreenTapScale, updateMediaProgress, unloadVideo, loadVideo, projectConsoleSwapMarker, projectConsoleSwapMarkers, sequencerNextSkippingExcluded, sequencerPreviousSkippingExcluded
    if v189 ~= v26 then
        return
    end
    local v190, v191, v192 = TreadmillUtil.FindVideoPresentationParts(v186)
    if v190 ~= nil and v191 ~= nil and v192 ~= nil then
        if v189 == v26 then
            local v193 = Trove.new()
            local v194 = v193:Extend()
            local v195 = RaycastParams.new()
            v195.FilterType = Enum.RaycastFilterType.Include
            v195.FilterDescendantsInstances = { v190 }
            local v196 = FeedSequencer.CreateRuntime(v29, v188, LocalPlayer.UserId)
            RecommendationFeedSource.PrefetchFeed(v29)
            local v197 = RecommendationFeedSource.GetReadyItem()
            local v198 = VideoFramePool.new(MainVideo)
            local v199 = LikeController.new(function() -- line 1114
                return 1
            end, function() -- line 1120 | captures: setMediaPlaying
                assert(false, "Treadmill runtime must exist before handling like single tap")
                local RequestNext = (nil).RequestNext
                if (nil).EndCardTrove == nil then
                    local MusicSound = (nil).MusicSound
                    if MusicSound == nil then
                        setMediaPlaying(nil, not (nil).VideoFramePool.GetActiveFrame().Playing)
                    else
                        setMediaPlaying(nil, not MusicSound.IsPlaying)
                    end
                elseif RequestNext == nil then
                    local MusicSound = (nil).MusicSound
                    if MusicSound == nil then
                        setMediaPlaying(nil, not (nil).VideoFramePool.GetActiveFrame().Playing)
                    else
                        setMediaPlaying(nil, not MusicSound.IsPlaying)
                    end
                else
                    RequestNext()
                end
            end, v29, v193, VideoFrame, v190)
            local v200 = {
                EndCardTrove = nil,
                HasPlayedMedia = false,
                LoadingTween = nil,
                PausedCardTrove = nil,
                PausedPreviewBaseSize = nil,
                PausedPreviewFrame = nil,
                RequestNext = nil,
                MusicSound = nil,
                Feed = v196,
                FriendLikesController = FriendLikesController.new(function() -- line 1146
                    return 1
                end, function() -- line 1152 | captures: v199
                    v199:SuppressScreenTap()
                end, v29, v193, v190),
                LeftSurfaceGui = v10,
                LikeController = v199,
                Loading = Loading,
                LoadingSpin = Spin,
                MainVideo = MainVideo,
                MainVideoBaseSize = MainVideo.Size,
                MusicImage = MusicImage,
                Progress = Progress
            }
            local v201 = v197 ~= nil
            v200.RecommendationActive = v201
            v200.RightSurfaceGui = v11
            v200.ShareSurfaceGui = v12
            v200.SideButtonsSurfaceGui = v13
            v200.StopPlay = StopPlay
            v200.StopPlayBaseSize = StopPlay.Size
            v200.StopPlayTween = nil
            v200.Token = v189
            v200.Trove = v193
            v200.VideoBackgroundMusicSound = nil
            v200.VideoFrame = VideoFrame
            v200.VideoIndex = 1
            v200.VideoScreenPart = v190
            v200.VideoScreenRaycastParams = v195
            v200.VideoSerial = 0
            v200.VideoSurfaceGui = v14
            v200.VideoTrove = v194
            v200.VideoFramePool = v198
            v193:Add(v198.Destroy)
            if v189 == v26 then
                v28 = v200
                v10.Adornee = v191
                v11.Adornee = v192
                v12.Adornee = v190
                v13.Adornee = v190
                v14.Adornee = v190
                v10.Enabled = true
                v11.Enabled = true
                v12.Enabled = true
                v13.Enabled = true
                v14.Enabled = true
                VideoFrame.Active = true
                MainVideo.Active = true
                local v202
                if not v200.Feed.HasSwappedRight then
                    v202 = ImageColorPulse.Start(ButtonSwapRight, v4, v5)
                    v193:Add(function() -- line 1215 | captures: v202
                        local v203 = v202
                        if v203 ~= nil then
                            v203()
                            v202 = nil
                        end
                    end)
                end

                local function swapLeft() -- line 1223 | captures: v200, RecommendationFeedSource, loadVideo, sequencerPreviousSkippingExcluded
                    if v200.RecommendationActive then
                        local v204, v205 = RecommendationFeedSource.Previous()
                        if v204 == nil then
                            v200.RecommendationActive = false
                            local v206, v207, v208 = sequencerPreviousSkippingExcluded(v200)
                            if v208 then
                                loadVideo(v200, v206, v207, -1)
                            end
                        elseif v205 then
                            loadVideo(v200, v204.MediaIndex, nil, -1, v204)
                        end
                    else
                        local v209, v210, v211 = sequencerPreviousSkippingExcluded(v200)
                        if v211 then
                            loadVideo(v200, v209, v210, -1)
                        end
                    end
                end

                local function swapRight() -- line 1247 | captures: v202, v200, RecommendationFeedSource, loadVideo, sequencerNextSkippingExcluded
                    local v212 = v202
                    if v212 ~= nil then
                        v212()
                        v202 = nil
                    end
                    if v200.RecommendationActive then
                        local v213 = RecommendationFeedSource.Next()
                        if v213 == nil then
                            v200.RecommendationActive = false
                            local v214, v215 = sequencerNextSkippingExcluded(v200)
                            loadVideo(v200, v214, v215, 1)
                        else
                            loadVideo(v200, v213.MediaIndex, nil, 1, v213)
                        end
                    else
                        local v216, v217 = sequencerNextSkippingExcluded(v200)
                        loadVideo(v200, v216, v217, 1)
                    end
                end

                v200.RequestNext = swapRight
                v193:Add(ButtonFX(ButtonSwapLeft, nil, swapLeft))
                v193:Add(ButtonFX(ButtonSwapRight, nil, swapRight))
                projectConsoleSwapMarker(ConsoleButton, "ButtonLB")
                projectConsoleSwapMarker(ConsoleButton_2, "ButtonRB")
                v193:Add(PlatformSignals.Changed:Connect(projectConsoleSwapMarkers))
                ContextActionService:BindActionAtPriority("TreadmillVideoActions", function(v218, v219, v220) -- line 1274 | captures: v199, swapLeft, swapRight, CommentsController
                    if v219 == Enum.UserInputState.Begin then
                        local KeyCode = v220.KeyCode
                        if KeyCode == Enum.KeyCode.ButtonL1 then
                            swapLeft()
                        elseif KeyCode == Enum.KeyCode.ButtonR1 then
                            swapRight()
                        elseif KeyCode == Enum.KeyCode.ButtonL2 then
                            v199:Toggle()
                        elseif KeyCode == Enum.KeyCode.ButtonR2 then
                            CommentsController.Toggle()
                        end
                    end
                    return Enum.ContextActionResult.Sink
                end, false, Value, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1, Enum.KeyCode.ButtonL2, Enum.KeyCode.ButtonR2)
                v193:Add(function() -- line 1289 | captures: ContextActionService
                    ContextActionService:UnbindAction("TreadmillVideoActions")
                end)
                ButtonHintStrip.PinLeft(0.2)
                ButtonHintStrip.Present("TreadmillLike", ButtonL2, "Like")
                if CommentsController.IsAvailable() then
                    ButtonHintStrip.Present("TreadmillComments", ButtonR2, "Comments")
                end
                v193:Add(function() -- line 1297 | captures: ButtonHintStrip
                    ButtonHintStrip.Retract("TreadmillLike")
                    ButtonHintStrip.Retract("TreadmillComments")
                    ButtonHintStrip.PinLeft(nil)
                end)
                v193:Add(ButtonFX(ShareButton, nil, function() -- line 1302 | captures: v200, SocialService, RecommendationSignals, TryCall, LocalPlayer
                    v200.LikeController:SuppressScreenTap()
                    local v221, v222 = TryCall(SocialService.CanSendGameInviteAsync, SocialService, LocalPlayer)
                    if v221 and v222 then
                        SocialService:PromptGameInvite(LocalPlayer)
                        RecommendationSignals.NotifyShared()
                    end
                end))
                local v223 = TouchTapTracker.new()

                local function handleVideoScreenTap(v224) -- line 1313 | captures: v200, getVideoScreenTapScale
                    local v225 = getVideoScreenTapScale(v200, Vector2.new(v224.Position.X, v224.Position.Y))
                    if v225 ~= nil then
                        v200.FriendLikesController:HandleScreenTap()
                        v200.LikeController:HandleScreenTap(v225)
                    end
                end

                v193:Connect(UserInputService.InputBegan, function(v226, v227) -- line 1321 | captures: v200, v223, UserInputService, getVideoScreenTapScale
                    if not v227 then
                        if v226.UserInputType == Enum.UserInputType.Touch then
                            v223:Begin(v226)
                        elseif not (v226.UserInputType ~= Enum.UserInputType.MouseButton1 or UserInputService.TouchEnabled) then
                            local v228 = getVideoScreenTapScale(v200, Vector2.new(v226.Position.X, v226.Position.Y))
                            if v228 ~= nil then
                                v200.FriendLikesController:HandleScreenTap()
                                v200.LikeController:HandleScreenTap(v228)
                            end
                        end
                    end
                end)
                v193:Connect(UserInputService.InputChanged, function(v229) -- line 1339 | captures: v223
                    if v229.UserInputType == Enum.UserInputType.Touch and v223:IsTrackingInput(v229) then
                        v223:Update(v229)
                    end
                end)
                v193:Connect(UserInputService.InputEnded, function(v230, v231) -- line 1344 | captures: v200, v223, getVideoScreenTapScale
                    if not (v230.UserInputType == Enum.UserInputType.Touch and v223:IsTrackingInput(v230) and v223:Evaluate(v230, v231)) then
                        return
                    end
                    local v232 = getVideoScreenTapScale(v200, Vector2.new(v230.Position.X, v230.Position.Y))
                    if v232 ~= nil then
                        v200.FriendLikesController:HandleScreenTap()
                        v200.LikeController:HandleScreenTap(v232)
                    end
                end)
                v193:Add(function() -- line 1355 | captures: v223
                    v223:Reset()
                end)
                v193:BindToRenderStep("TreadmillVideoProgress", Enum.RenderPriority.Last.Value, function() -- line 1358 | captures: v200, v26, updateMediaProgress
                    if v26 == v200.Token then
                        updateMediaProgress(v200)
                    end
                end)
                v193:Add(function() -- line 1363 | captures: v200, v10, v11, v12, v13, v14, StopPlay, unloadVideo
                    unloadVideo(v200)
                    v200.LikeController:Destroy()
                    v200.FriendLikesController:Destroy()
                    StopPlay.Visible = true
                    v10.Enabled = false
                    v11.Enabled = false
                    v12.Enabled = false
                    v13.Enabled = false
                    v14.Enabled = false
                end)
                if v197 == nil then
                    local v233, v234 = FeedSequencer.Current(v200.Feed)
                    local v235 = v29[v233]
                    if v235 ~= nil and TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v235)) then
                        Remotes.Treadmill.RefreshClipCursor:FireServer(v234)
                        v233, v234 = sequencerNextSkippingExcluded(v200)
                    end
                    loadVideo(v200, v233, v234, 1)
                else
                    loadVideo(v200, v197.MediaIndex, nil, 1, v197)
                end
                local v236 = if v200.RecommendationActive then "recommendation" else "sequencer"
                v9:AtTrace():Log((("[TreadmillVideoController] Started treadmill video for %* (%* feed)"):format(v187, v236)))
            else
                v193:Destroy()
            end
        end
    else
        v9:AtTrace():Log((("[TreadmillVideoController] Skipped video presentation for %*"):format(v187)))
    end
end

local function bindVideoRuntimeWhenReady(v237, v238, v239) -- line 1397 | captures: v26, v27, RuntimeInstanceRegistry, Trove, bindVideoRuntime
    local v240 = Trove.new()
    v27 = v240
    local v241 = false

    local function bindIfCurrent(v242) -- line 1401 | captures: v241, v237, v238, v239, v240, v26, v27, bindVideoRuntime
        if v241 or not (v242 ~= nil) or not (v239 == v26) or not (v27 == v240) then
            return
        end
        local Tool = v242:IsA("Tool")
        local v243 = ("Runtime treadmill \"%*\" must be a Tool"):format(v237)
        assert(Tool, v243)
        v241 = true
        v27 = nil
        v240:Destroy()
        bindVideoRuntime(v242, v237, v238, v239)
    end

    local Changed = RuntimeInstanceRegistry.Changed
    v240:Add(Changed:Connect(function(v244, v245, v246) -- line 1412 | captures: v237, bindIfCurrent
        if v244 == "Treadmill" and v245 == v237 then
            bindIfCurrent(v246)
        end
    end))
    bindIfCurrent(RuntimeInstanceRegistry.Peek("Treadmill", v237))
end

function v33.Start(v247, v248) -- line 1419 | captures: v26, cleanupRuntime, bindVideoRuntimeWhenReady
    cleanupRuntime()
    v26 += 1
    bindVideoRuntimeWhenReady(v247, v248, v26)
end

local function GetStoppedIconImage() -- line 1424
    return "rbxassetid://73631216564444"
end

v33.GetStoppedIconImage = GetStoppedIconImage

local function ResolveCoverImage(v249) -- line 1427
    if v249.Kind == "Video" then
        return v249.CoverImage or ""
    end
    return v249.Image
end

v33.ResolveCoverImage = ResolveCoverImage

function v33.GetCurrentMediaEntry(v250) -- line 1433 | captures: FeedSequencer, LocalPlayer, v29
    local v251 = v250.HasSwappedRight == true
    local v252 = FeedSequencer.ResolveReleaseTrackingState(v250, LocalPlayer.UserId, v251)
    local v253 = FeedSequencer.CreateRuntime(v29, v252, LocalPlayer.UserId)
    return v29[FeedSequencer.Current(v253)]
end

local v254

function v33.GetMediaEntryByKey(v255) -- line 1440 | captures: v254, TreadmillMediaIdentity, v29
    local v256 = v254
    if v256 == nil then
        v256 = {}
        for v257, v258 in ipairs(v29) do
            local v259 = TreadmillMediaIdentity.GetMediaKey(v258)
            if v256[v259] == nil then
                v256[v259] = v258
            end
        end
        v254 = v256
    end
    return v256[v255]
end

function v33.GetActiveMediaEntry() -- line 1455 | captures: v28, v29
    local v260 = v28
    if v260 == nil then
        return nil
    end
    return v29[v260.VideoIndex]
end

function v33.Stop() -- line 1462 | captures: cleanupRuntime
    cleanupRuntime()
end

function v33.SuppressScreenTap() -- line 1465 | captures: v28
    local v261 = v28
    if v261 ~= nil then
        v261.LikeController:SuppressScreenTap()
    end
end

function v33.SetShareButtonVisible(v262) -- line 1471 | captures: ShareButton
    ShareButton.Visible = v262
end

TreadmillMediaOverlay.Changed:Connect(function() -- line 1474 | captures: v254, TreadmillMediaOverlay, v29, updateVideoCounter
    TreadmillMediaOverlay.ApplyTo(v29)
    v254 = nil
    updateVideoCounter()
end)
updateVideoCounter()

local function OnClientInvoke(v263) -- line 1480 | captures: LocalPlayer
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TreadmillDurationProbe"
    ScreenGui.ResetOnSpawn = false
    local VideoFrame = Instance.new("VideoFrame")
    VideoFrame.Size = UDim2.fromOffset(1, 1)
    VideoFrame.BackgroundTransparency = 1
    VideoFrame.Volume = 0
    VideoFrame.Video = ("rbxassetid://%*"):format(v263)
    VideoFrame.Parent = ScreenGui
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    local v264 = os.clock() + 20
    while true do
        if not (os.clock() < v264) or VideoFrame.IsLoaded and VideoFrame.TimeLength > 0 then
            break
        end
        task.wait(0.25)
    end
    local TimeLength = VideoFrame.TimeLength
    ScreenGui:Destroy()
    if TimeLength <= 0 then
        return nil
    end
    return TimeLength
end

Remotes.Treadmill.GaugeClipLength.OnClientInvoke = OnClientInvoke
CommentsController.Start({
    MediaChanged = v33.MediaChanged,
    SetShareButtonVisible = v33.SetShareButtonVisible,
    Stopped = v33.Stopped,
    SuppressScreenTap = v33.SuppressScreenTap
})
return v33
