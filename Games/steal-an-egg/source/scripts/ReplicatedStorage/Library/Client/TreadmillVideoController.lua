local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SocialService = game:GetService("SocialService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local CommentsController = require(script.CommentsController)
local ConsoleCmds = require(ReplicatedStorage.Library.Client.ConsoleCmds)
local FriendLikesController = require(script.FriendLikesController)
local Signal = require(ReplicatedStorage.Library.Signal)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local ImageColorPulse = require(ReplicatedStorage.Library.Client.GUIFX.ImageColorPulse)
local LikeController = require(script.LikeController)
local Network = require(ReplicatedStorage.Library.Client.Network)
local PreloadAssets = require(ReplicatedStorage.Library.Functions.PreloadAssets)
local PreloadSounds = require(ReplicatedStorage.Library.Functions.PreloadSounds)
local ScaleUDim2 = require(ReplicatedStorage.Library.Functions.ScaleUDim2)
local wcall = require(ReplicatedStorage.Library.Functions.wcall)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Signal2 = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local RuntimeInstanceRegistry = require(ReplicatedStorage.Library.Modules.RuntimeInstanceRegistry)
local TreadmillUtil = require(ReplicatedStorage.Library.Util.TreadmillUtil)
local TouchTapTracker = require(ReplicatedStorage.Library.Client.Input.TouchTapTracker)
local Variables = require(ReplicatedStorage.Library.Variables)
local FeedSequencer = require(script.FeedSequencer)

require(script.Types.Interface)

local Schema = require(script.Types.Schema)
local Media = require(script.Media)
local VideoFramePool = require(script.VideoFramePool)

local TreadmillsNetMap = Constants.NETWORK_MAP.Treadmills

-- Tweens & Colors
local SPINNER_TWEEN_INFO = TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true)
local STOP_PLAY_POP_TWEEN_INFO = TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local STOP_PLAY_FADE_TWEEN_INFO = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local HIGH_PRIORITY = Enum.ContextActionPriority.High.Value
local RED_COLOR = Color3.fromRGB(255, 0, 0)

-- Sound Preloading
task.spawn(PreloadSounds, "rbxassetid://84371411600743", "rbxassetid://90908618020821")

local LocalPlayer = Players.LocalPlayer
local logger = Log.new()

-- Surface GUI Setup & Validation
local SwapLeftGui = GUI.TreadmillScreenButtonSwapLeft()
assert(SwapLeftGui:IsA("SurfaceGui"), "Treadmill left swap GUI must be a SurfaceGui")

local SwapRightGui = GUI.TreadmillScreenButtonSwapRight()
assert(SwapRightGui:IsA("SurfaceGui"), "Treadmill right swap GUI must be a SurfaceGui")

local ShareGui = GUI.TreadmillScreenButtonShare()
assert(ShareGui:IsA("SurfaceGui"), "Treadmill share GUI must be a SurfaceGui")

local SideButtonsGui = GUI.TreadmillScreenSideButtons()
assert(SideButtonsGui:IsA("SurfaceGui"), "Treadmill side buttons GUI must be a SurfaceGui")

local VideoSurfaceGui = GUI.TreadmillVideoSurfaceGui()
assert(VideoSurfaceGui:IsA("SurfaceGui"), "Treadmill video GUI must be a SurfaceGui")

local ButtonSwapLeft = SwapLeftGui.ButtonSwapLeft
assert(ButtonSwapLeft:IsA("GuiButton"), "Treadmill left swap button must be a GuiButton")

local ButtonSwapRight = SwapRightGui.ButtonSwapRight
assert(ButtonSwapRight:IsA("ImageButton"), "Treadmill right swap button must be an ImageButton")

local ConsoleButtonLB = SwapLeftGui.ButtonSwapLeft.ConsoleButton
assert(ConsoleButtonLB:IsA("GuiObject"), "Treadmill left swap ConsoleButton must be a GuiObject")
assert(ConsoleButtonLB:GetAttribute("ConsoleButton") == "ButtonLB", "Treadmill left swap ConsoleButton must use ButtonLB")

local ConsoleButtonRB = SwapRightGui.ButtonSwapRight.ConsoleButton
assert(ConsoleButtonRB:IsA("GuiObject"), "Treadmill right swap ConsoleButton must be a GuiObject")
assert(ConsoleButtonRB:GetAttribute("ConsoleButton") == "ButtonRB", "Treadmill right swap ConsoleButton must use ButtonRB")

local ShareButton = ShareGui.Frame.ShareButton
assert(ShareButton:IsA("GuiButton"), "Treadmill share button must be a GuiButton")

local VideoFrame = VideoSurfaceGui.VideoFrame
assert(VideoFrame:IsA("Frame"), "Treadmill video frame container must be a Frame")

local MainVideo = VideoFrame.MainVideo
assert(MainVideo:IsA("VideoFrame"), "Treadmill main video must be a VideoFrame")

local StopPlayIndicator = VideoFrame.StopPlay
assert(StopPlayIndicator:IsA("ImageLabel"), "Treadmill stop-play indicator must be an ImageLabel")

local MusicImage = VideoFrame.MusicImage
assert(MusicImage:IsA("ImageLabel"), "Treadmill music image must be an ImageLabel")

local LoadingFrame = VideoFrame.Loading
assert(LoadingFrame:IsA("GuiObject"), "Treadmill video loading frame must be a GuiObject")

local LoadingSpinner = LoadingFrame.Spin
assert(LoadingSpinner:IsA("GuiObject"), "Treadmill video loading spinner must be a GuiObject")

local ProgressBarContainer = VideoFrame.Bar
assert(ProgressBarContainer:IsA("GuiObject"), "Treadmill video bar must be a GuiObject")

local ProgressBarFill = ProgressBarContainer.Progress
assert(ProgressBarFill:IsA("GuiObject"), "Treadmill video progress must be a GuiObject")

-- State Variables
local currentRuntimeToken = 0
local activeRuntimeTrove = nil
local activeTreadmillRuntime = nil
local mediaList = table.clone(Media)

if Constants.IS_STUDIO then
	local isValid, errMessage = Schema.TreadmillMediaEntries(mediaList)
	assert(isValid, (("Failed to validate treadmill video media entries: %*"):format(errMessage)))
end

local TreadmillController = {
	MediaChanged = Signal2.new(),
	Stopped = Signal2.new()
}

local function cancelStopPlayTween(runtime)
	local tween = runtime.StopPlayTween
	runtime.StopPlayTween = nil

	if tween then
		tween:Cancel()
	end
end

local function resetStopPlayIndicator(runtime)
	local tween = runtime.StopPlayTween
	runtime.StopPlayTween = nil

	if tween then
		tween:Cancel()
	end

	runtime.StopPlay.ImageTransparency = 0
	runtime.StopPlay.Size = runtime.StopPlayBaseSize
end

local function animateStopPlayIndicator(runtime, isPlay)
	local tween = runtime.StopPlayTween
	runtime.StopPlayTween = nil

	if tween then
		tween:Cancel()
	end

	local stopPlay = runtime.StopPlay
	stopPlay.Visible = true
	stopPlay.Image = isPlay and "rbxassetid://90908618020821" or "rbxassetid://84371411600743"
	stopPlay.ImageTransparency = 0
	stopPlay.Size = ScaleUDim2(runtime.StopPlayBaseSize, isPlay and 1.24 or 0.76)

	local popTween = TweenService:Create(stopPlay, STOP_PLAY_POP_TWEEN_INFO, {
		Size = runtime.StopPlayBaseSize
	})

	runtime.StopPlayTween = popTween
	popTween.Completed:Once(function()
		if runtime.StopPlayTween ~= popTween then
			return
		end

		runtime.StopPlayTween = nil

		if isPlay then
			local fadeTween = TweenService:Create(stopPlay, STOP_PLAY_FADE_TWEEN_INFO, {
				ImageTransparency = 1
			})

			runtime.StopPlayTween = fadeTween
			fadeTween.Completed:Once(function()
				if runtime.StopPlayTween == fadeTween then
					runtime.StopPlayTween = nil
					stopPlay.Visible = false
					stopPlay.ImageTransparency = 0
				end
			end)
			fadeTween:Play()
		end
	end)
	popTween:Play()
end

local function setSoundPlaying(sound, isPlaying)
	if not isPlaying then
		sound:Pause()
		return
	end

	if sound.TimePosition > 0 then
		sound:Resume()
	else
		sound:Play()
	end
end

local function setMediaPlaying(runtime, isPlaying, animateIndicator)
	local musicSound = runtime.MusicSound

	if musicSound == nil then
		local activeFrame = runtime.VideoFramePool.GetActiveFrame()
		local backgroundMusic = runtime.VideoBackgroundMusicSound

		if isPlaying then
			activeFrame:Play()
			if backgroundMusic ~= nil then
				if backgroundMusic.TimePosition > 0 then
					backgroundMusic:Resume()
				else
					backgroundMusic:Play()
				end
			end
		else
			activeFrame:Pause()
			if backgroundMusic ~= nil then
				backgroundMusic:Pause()
			end
		end
	elseif isPlaying then
		if musicSound.TimePosition > 0 then
			musicSound:Resume()
		else
			musicSound:Play()
		end
	else
		musicSound:Pause()
	end

	if animateIndicator ~= false then
		animateStopPlayIndicator(runtime, isPlaying)
		return
	end

	local stopPlayTween = runtime.StopPlayTween
	runtime.StopPlayTween = nil

	if stopPlayTween == nil then
		runtime.StopPlay.ImageTransparency = 0
		runtime.StopPlay.Size = runtime.StopPlayBaseSize
		runtime.StopPlay.Visible = not isPlaying
		return
	end

	stopPlayTween:Cancel()
	runtime.StopPlay.ImageTransparency = 0
	runtime.StopPlay.Size = runtime.StopPlayBaseSize
	runtime.StopPlay.Visible = not isPlaying
end

local function getSurfaceHitScale(part, normalId, hitPosition)
	local normalVector
	if normalId == Enum.NormalId.Front then
		normalVector = Vector3.new(0, 0, -1)
	elseif normalId == Enum.NormalId.Back then
		normalVector = Vector3.new(0, 0, 1)
	elseif normalId == Enum.NormalId.Right then
		normalVector = Vector3.new(1, 0, 0)
	elseif normalId == Enum.NormalId.Left then
		normalVector = Vector3.new(-1, 0, 0)
	elseif normalId == Enum.NormalId.Top then
		normalVector = Vector3.new(0, 1, 0)
	else
		normalVector = Vector3.new(0, -1, 0)
	end

	local upReference = math.abs(normalVector.Y) == 1 and Vector3.new(0, 0, 1) or Vector3.new(0, 1, 0)
	local tangentU = normalVector:Cross(upReference).Unit
	local tangentV = tangentU:Cross(normalVector).Unit

	local localHit = part.CFrame:PointToObjectSpace(hitPosition)
	local halfSize = part.Size * 0.5

	local normalOffset = math.abs(normalVector.X) * halfSize.X + math.abs(normalVector.Y) * halfSize.Y + math.abs(normalVector.Z) * halfSize.Z
	local extentU = math.abs(tangentU.X) * halfSize.X + math.abs(tangentU.Y) * halfSize.Y + math.abs(tangentU.Z) * halfSize.Z
	local extentV = math.abs(tangentV.X) * halfSize.X + math.abs(tangentV.Y) * halfSize.Y + math.abs(tangentV.Z) * halfSize.Z

	local surfaceOriginOffset = localHit - normalVector * normalOffset

	local uScale = math.clamp(0.5 - surfaceOriginOffset:Dot(tangentU) / (extentU * 2), 0, 1)
	local vScale = math.clamp(0.5 - surfaceOriginOffset:Dot(tangentV) / (extentV * 2), 0, 1)

	return Vector2.new(uScale, vScale)
end

local function getVideoScreenTapScale(runtime, screenPosition)
	local camera = Workspace.CurrentCamera
	if camera == nil then
		return nil
	end

	local ray = camera:ScreenPointToRay(screenPosition.X, screenPosition.Y)
	local raycastResult = Workspace:Raycast(ray.Origin, ray.Direction * 1000, runtime.VideoScreenRaycastParams)

	if raycastResult == nil or raycastResult.Instance ~= runtime.VideoScreenPart then
		return nil
	end

	return getSurfaceHitScale(runtime.VideoScreenPart, runtime.VideoSurfaceGui.Face, raycastResult.Position)
end

local function toggleMediaPlaying(runtime)
	local musicSound = runtime.MusicSound

	if musicSound == nil then
		setMediaPlaying(runtime, not runtime.VideoFramePool.GetActiveFrame().Playing)
	else
		setMediaPlaying(runtime, not musicSound.IsPlaying)
	end
end

local function setVideoProgress(progressFrame, fraction)
	local currentSize = progressFrame.Progress.Size
	progressFrame.Progress.Size = UDim2.new(math.clamp(fraction, 0, 1), 0, currentSize.Y.Scale, currentSize.Y.Offset)
end

local function updateMediaProgress(runtime)
	local musicSound = runtime.MusicSound

	if musicSound == nil then
		local activeFrame = runtime.VideoFramePool.GetActiveFrame()
		local timeLength = activeFrame.TimeLength
		local currentSize = runtime.Progress.Size

		if timeLength <= 0 then
			runtime.Progress.Size = UDim2.new(0, 0, currentSize.Y.Scale, currentSize.Y.Offset)
		else
			runtime.Progress.Size = UDim2.new(math.clamp(activeFrame.TimePosition / timeLength, 0, 1), 0, currentSize.Y.Scale, currentSize.Y.Offset)
		end
	else
		local timeLength = musicSound.TimeLength
		local currentSize = runtime.Progress.Size

		if timeLength <= 0 then
			runtime.Progress.Size = UDim2.new(0, 0, currentSize.Y.Scale, currentSize.Y.Offset)
		else
			runtime.Progress.Size = UDim2.new(math.clamp(musicSound.TimePosition / timeLength, 0, 1), 0, currentSize.Y.Scale, currentSize.Y.Offset)
		end
	end
end

local function hideLoading(runtime)
	local loadingTween = runtime.LoadingTween
	runtime.LoadingTween = nil

	if loadingTween then
		loadingTween:Cancel()
	end

	runtime.Loading.Visible = false
	runtime.LoadingSpin.Rotation = 0
end

local function showLoading(runtime)
	local loadingTween = runtime.LoadingTween
	runtime.LoadingTween = nil

	if loadingTween then
		loadingTween:Cancel()
	end

	runtime.Loading.Visible = true
	runtime.LoadingSpin.Rotation = 0
	runtime.ShareSurfaceGui.Enabled = false
	runtime.SideButtonsSurfaceGui.Enabled = false

	local spinTween = TweenService:Create(runtime.LoadingSpin, SPINNER_TWEEN_INFO, {
		Rotation = 360
	})
	runtime.LoadingTween = spinTween
	spinTween:Play()
end

local function clearMusicImage(runtime)
	runtime.MusicImage.Visible = false
	runtime.MusicImage.Image = ""

	local musicSound = runtime.MusicSound
	runtime.MusicSound = nil

	if musicSound ~= nil then
		musicSound:Stop()
		musicSound:Destroy()
	end
end

local function clearVideoBackgroundMusic(runtime)
	local backgroundMusic = runtime.VideoBackgroundMusicSound
	runtime.VideoBackgroundMusicSound = nil

	if backgroundMusic ~= nil then
		backgroundMusic:Stop()
		backgroundMusic:Destroy()
	end
end

local function unloadVideo(runtime)
	runtime.VideoTrove:Clean()

	local loadingTween = runtime.LoadingTween
	runtime.LoadingTween = nil

	if loadingTween ~= nil then
		loadingTween:Cancel()
	end

	runtime.Loading.Visible = false
	runtime.LoadingSpin.Rotation = 0
	runtime.MusicImage.Visible = false
	runtime.MusicImage.Image = ""

	local musicSound = runtime.MusicSound
	runtime.MusicSound = nil

	if musicSound ~= nil then
		musicSound:Stop()
		musicSound:Destroy()
	end

	local backgroundMusic = runtime.VideoBackgroundMusicSound
	runtime.VideoBackgroundMusicSound = nil

	if backgroundMusic ~= nil then
		backgroundMusic:Stop()
		backgroundMusic:Destroy()
	end

	runtime.VideoFramePool.ClearActive()
	runtime.MainVideo.Size = runtime.MainVideoBaseSize
	runtime.MainVideo.Volume = 1
	runtime.MainVideo.Video = ""

	local stopPlayTween = runtime.StopPlayTween
	runtime.StopPlayTween = nil

	if stopPlayTween ~= nil then
		stopPlayTween:Cancel()
	end

	runtime.StopPlay.ImageTransparency = 0
	runtime.StopPlay.Size = runtime.StopPlayBaseSize
	runtime.StopPlay.Visible = true

	local currentProgressSize = runtime.Progress.Size
	runtime.Progress.Size = UDim2.new(0, 0, currentProgressSize.Y.Scale, currentProgressSize.Y.Offset)
end

local function wrapVideoIndex(index)
	if index < 1 then
		return #mediaList
	end
	if index > #mediaList then
		return 1
	end
	return index
end

local function preloadDirectionalAssets(runtime, currentIndex, direction)
	if direction < 0 then
		return
	end

	local assetList = {}
	local videoList = {}

	for i = 1, 3 do
		local targetIndex = currentIndex + direction * i
		local wrappedIndex = wrapVideoIndex(targetIndex)
		local mediaEntry = mediaList[wrappedIndex]

		if mediaEntry.Kind == "Video" then
			table.insert(videoList, {
				MediaEntry = mediaEntry,
				MediaIndex = wrappedIndex
			})

			if mediaEntry.Music then
				table.insert(assetList, mediaEntry.Music.SoundId)
			end
		elseif mediaEntry.Kind == "MusicImage" then
			table.insert(assetList, mediaEntry.Image)
			table.insert(assetList, mediaEntry.SoundId)
		end
	end

	runtime.VideoFramePool.Preload(videoList)

	if #assetList > 0 then
		task.spawn(PreloadAssets, assetList)
	end
end

local function loadVideoBackgroundMusic(runtime, musicData)
	local backgroundSound = Instance.new("Sound")
	backgroundSound.Name = "TreadmillVideoBackgroundMusic"
	backgroundSound.SoundId = musicData.SoundId
	backgroundSound.Volume = musicData.Volume
	backgroundSound.Looped = true
	backgroundSound.Parent = runtime.MainVideo

	runtime.VideoBackgroundMusicSound = backgroundSound
	runtime.VideoTrove:Add(function()
		if runtime.VideoBackgroundMusicSound == backgroundSound then
			runtime.VideoBackgroundMusicSound = nil
		end

		if backgroundSound.Parent ~= nil then
			backgroundSound:Stop()
			backgroundSound:Destroy()
		end
	end)
end

local function resetVideoBackgroundMusic(runtime)
	local backgroundMusic = runtime.VideoBackgroundMusicSound
	if backgroundMusic ~= nil then
		backgroundMusic:Stop()
		backgroundMusic.TimePosition = 0
	end
end

local function loadVideoMedia(runtime, mediaEntry, videoSerial)
	local activeFrame = runtime.VideoFramePool.Activate(runtime.VideoIndex, mediaEntry)
	activeFrame.Size = mediaEntry.Size or runtime.MainVideoBaseSize

	local currentProgressSize = runtime.Progress.Size
	runtime.Progress.Size = UDim2.new(0, 0, currentProgressSize.Y.Scale, currentProgressSize.Y.Offset)

	if mediaEntry.Music ~= nil then
		loadVideoBackgroundMusic(runtime, mediaEntry.Music)
	end

	runtime.VideoTrove:Add(activeFrame.Ended:Connect(function()
		if currentRuntimeToken ~= runtime.Token or runtime.VideoSerial ~= videoSerial then
			return
		end

		resetVideoBackgroundMusic(runtime)
	end))

	if not activeFrame.IsLoaded then
		runtime.StopPlay.Visible = false
		showLoading(runtime)

		local loadedConnection = nil
		loadedConnection = activeFrame.Loaded:Connect(function()
			if currentRuntimeToken ~= runtime.Token or runtime.VideoSerial ~= videoSerial then
				return
			end

			loadedConnection:Disconnect()
			hideLoading(runtime)

			runtime.ShareSurfaceGui.Enabled = true
			runtime.SideButtonsSurfaceGui.Enabled = true

			setMediaPlaying(runtime, true, false)
			resetStopPlayIndicator(runtime)
			runtime.StopPlay.Visible = false
		end)
		runtime.VideoTrove:Add(loadedConnection)
		return
	end

	hideLoading(runtime)
	runtime.ShareSurfaceGui.Enabled = true
	runtime.SideButtonsSurfaceGui.Enabled = true

	setMediaPlaying(runtime, true, false)
	resetStopPlayIndicator(runtime)
	runtime.StopPlay.Visible = false
end

local function loadMusicImageMedia(runtime, mediaEntry, videoSerial)
	runtime.VideoFramePool.ClearActive()
	runtime.MainVideo.Video = ""
	runtime.MusicImage.Image = mediaEntry.Image
	runtime.MusicImage.Visible = true

	local currentProgressSize = runtime.Progress.Size
	runtime.Progress.Size = UDim2.new(0, 0, currentProgressSize.Y.Scale, currentProgressSize.Y.Offset)

	local musicSound = Instance.new("Sound")
	musicSound.Name = "TreadmillMusicImageSound"
	musicSound.SoundId = mediaEntry.SoundId
	musicSound.Volume = mediaEntry.Volume
	musicSound.Looped = true
	musicSound.Parent = runtime.MainVideo

	runtime.MusicSound = musicSound
	runtime.VideoTrove:Add(function()
		if runtime.MusicSound == musicSound then
			runtime.MusicSound = nil
		end

		if musicSound.Parent ~= nil then
			musicSound:Stop()
			musicSound:Destroy()
		end
	end)

	if not musicSound.IsLoaded then
		runtime.StopPlay.Visible = false
		showLoading(runtime)

		local loadedConnection = nil
		loadedConnection = musicSound.Loaded:Connect(function()
			if currentRuntimeToken ~= runtime.Token or runtime.VideoSerial ~= videoSerial then
				return
			end

			loadedConnection:Disconnect()
			hideLoading(runtime)

			runtime.ShareSurfaceGui.Enabled = true
			runtime.SideButtonsSurfaceGui.Enabled = true

			setMediaPlaying(runtime, true, false)
			resetStopPlayIndicator(runtime)
			runtime.StopPlay.Visible = false
		end)
		runtime.VideoTrove:Add(loadedConnection)
		return
	end

	hideLoading(runtime)
	runtime.ShareSurfaceGui.Enabled = true
	runtime.SideButtonsSurfaceGui.Enabled = true

	setMediaPlaying(runtime, true, false)
	resetStopPlayIndicator(runtime)
	runtime.StopPlay.Visible = false
end

local function loadVideo(runtime, targetIndex, networkIndex, direction)
	runtime.VideoSerial = runtime.VideoSerial + 1
	local currentVideoSerial = runtime.VideoSerial

	runtime.VideoIndex = wrapVideoIndex(targetIndex)
	Network.Fire(TreadmillsNetMap.UPDATE_MEDIA_INDEX, networkIndex)

	unloadVideo(runtime)
	runtime.LikeController:UpdatePresentation()
	runtime.FriendLikesController:HandleMediaChanged()

	local mediaEntry = mediaList[runtime.VideoIndex]
	TreadmillController.MediaChanged:Fire(mediaEntry, runtime.VideoScreenPart)

	if mediaEntry.Kind == "Video" then
		loadVideoMedia(runtime, mediaEntry, currentVideoSerial)
	else
		loadMusicImageMedia(runtime, mediaEntry, currentVideoSerial)
	end

	preloadDirectionalAssets(runtime, runtime.VideoIndex, direction)
end

local function cleanupRuntime()
	currentRuntimeToken = currentRuntimeToken + 1
	TreadmillController.Stopped:Fire()

	if activeRuntimeTrove ~= nil then
		activeRuntimeTrove:Destroy()
		activeRuntimeTrove = nil
	end

	local runtime = activeTreadmillRuntime
	activeTreadmillRuntime = nil

	if runtime ~= nil then
		unloadVideo(runtime)
		runtime.LikeController:Destroy()
		runtime.FriendLikesController:Destroy()
		runtime.StopPlay.Visible = true
		runtime.LeftSurfaceGui.Enabled = false
		runtime.RightSurfaceGui.Enabled = false
		runtime.ShareSurfaceGui.Enabled = false
		runtime.SideButtonsSurfaceGui.Enabled = false
		runtime.VideoSurfaceGui.Enabled = false
		runtime.Trove:Destroy()
	end
end

local function projectConsoleSwapMarker(button, keyName)
	button.Visible = Variables.Console and (button:GetAttribute("HideOnLoad") ~= true)

	if not Variables.Console then
		return
	end

	if button:IsA("ImageLabel") or button:IsA("ImageButton") then
		button.Image = ConsoleCmds.GetImageForString(keyName)
	end
end

local function projectConsoleSwapMarkers()
	projectConsoleSwapMarker(ConsoleButtonLB, "ButtonLB")
	projectConsoleSwapMarker(ConsoleButtonRB, "ButtonRB")
end

local function bindVideoRuntime(treadmillModel, modelName, initialIndex, token)
	if token ~= currentRuntimeToken then
		return
	end

	local videoScreenPart, swapLeftPart, swapRightPart = TreadmillUtil.FindVideoPresentationParts(treadmillModel)

	if videoScreenPart == nil or swapLeftPart == nil or swapRightPart == nil then
		logger:AtTrace():Log((("[TreadmillVideoController] Skipped video presentation for %*"):format(modelName)))
		return
	end

	if token ~= currentRuntimeToken then
		return
	end

	local runtimeTrove = Trove.new()
	local videoTrove = runtimeTrove:Extend()

	local screenRaycastParams = RaycastParams.new()
	screenRaycastParams.FilterType = Enum.RaycastFilterType.Include
	screenRaycastParams.FilterDescendantsInstances = { videoScreenPart }

	local feedSequence = FeedSequencer.CreateRuntime(mediaList, initialIndex, LocalPlayer.UserId)
	local videoPool = VideoFramePool.new(MainVideo)
	local selfRuntime = nil

	local likeController = LikeController.new(function()
		return selfRuntime and selfRuntime.VideoIndex or 1
	end, function()
		assert(selfRuntime ~= nil, "Treadmill runtime must exist before handling like single tap")
		toggleMediaPlaying(selfRuntime)
	end, mediaList, runtimeTrove, VideoFrame, videoScreenPart)

	local runtime = {
		LoadingTween = nil,
		MusicSound = nil,
		StopPlayTween = nil,
		VideoBackgroundMusicSound = nil,
		VideoIndex = 1,
		VideoSerial = 0,
		Feed = feedSequence,
		FriendLikesController = FriendLikesController.new(function()
			return selfRuntime and selfRuntime.VideoIndex or 1
		end, function()
			likeController:SuppressScreenTap()
		end, mediaList, runtimeTrove, videoScreenPart),
		LeftSurfaceGui = SwapLeftGui,
		LikeController = likeController,
		Loading = LoadingFrame,
		LoadingSpin = LoadingSpinner,
		MainVideo = MainVideo,
		MainVideoBaseSize = MainVideo.Size,
		MusicImage = MusicImage,
		Progress = ProgressBarFill,
		RightSurfaceGui = SwapRightGui,
		ShareSurfaceGui = ShareGui,
		SideButtonsSurfaceGui = SideButtonsGui,
		StopPlay = StopPlayIndicator,
		StopPlayBaseSize = StopPlayIndicator.Size,
		Token = token,
		Trove = runtimeTrove,
		VideoFrame = VideoFrame,
		VideoScreenPart = videoScreenPart,
		VideoScreenRaycastParams = screenRaycastParams,
		VideoSurfaceGui = VideoSurfaceGui,
		VideoTrove = videoTrove,
		VideoFramePool = videoPool
	}

	selfRuntime = runtime
	runtimeTrove:Add(videoPool.Destroy)

	if token ~= currentRuntimeToken then
		runtimeTrove:Destroy()
		return
	end

	activeTreadmillRuntime = runtime
	SwapLeftGui.Adornee = swapLeftPart
	SwapRightGui.Adornee = swapRightPart
	ShareGui.Adornee = videoScreenPart
	SideButtonsGui.Adornee = videoScreenPart
	VideoSurfaceGui.Adornee = videoScreenPart

	SwapLeftGui.Enabled = true
	SwapRightGui.Enabled = true
	ShareGui.Enabled = true
	SideButtonsGui.Enabled = true
	VideoSurfaceGui.Enabled = true

	VideoFrame.Active = true
	MainVideo.Active = true

	local pulseStopFunc = nil
	if not runtime.Feed.HasSwappedRight then
		pulseStopFunc = ImageColorPulse.Start(ButtonSwapRight, RED_COLOR, SPINNER_TWEEN_INFO)
		runtimeTrove:Add(function()
			if pulseStopFunc then
				pulseStopFunc()
				pulseStopFunc = nil
			end
		end)
	end

	local function swapLeft()
		local targetIdx, networkIdx, canSwap = FeedSequencer.Previous(runtime.Feed)
		if canSwap then
			loadVideo(runtime, targetIdx, networkIdx, -1)
		end
	end

	local function swapRight()
		local targetIdx, networkIdx = FeedSequencer.Next(runtime.Feed)
		if pulseStopFunc then
			pulseStopFunc()
			pulseStopFunc = nil
		end
		loadVideo(runtime, targetIdx, networkIdx, 1)
	end

	runtimeTrove:Add(ButtonFX(ButtonSwapLeft, nil, swapLeft))
	runtimeTrove:Add(ButtonFX(ButtonSwapRight, nil, swapRight))

	projectConsoleSwapMarker(ConsoleButtonLB, "ButtonLB")
	projectConsoleSwapMarker(ConsoleButtonRB, "ButtonRB")

	runtimeTrove:Add(Signal.Fired("Changed Platform"):Connect(projectConsoleSwapMarkers))

	ContextActionService:BindActionAtPriority("TreadmillVideoSwap", function(_, inputState, inputObj)
		if inputState ~= Enum.UserInputState.Begin then
			return Enum.ContextActionResult.Sink
		end

		if inputObj.KeyCode == Enum.KeyCode.ButtonL1 then
			local targetIdx, networkIdx, canSwap = FeedSequencer.Previous(runtime.Feed)
			if canSwap then
				loadVideo(runtime, targetIdx, networkIdx, -1)
			end
		else
			local targetIdx, networkIdx = FeedSequencer.Next(runtime.Feed)
			if pulseStopFunc then
				pulseStopFunc()
				pulseStopFunc = nil
			end
			loadVideo(runtime, targetIdx, networkIdx, 1)
		end

		return Enum.ContextActionResult.Sink
	end, false, HIGH_PRIORITY, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)

	runtimeTrove:Add(function()
		ContextActionService:UnbindAction("TreadmillVideoSwap")
	end)

	runtimeTrove:Add(ButtonFX(ShareButton, nil, function()
		runtime.LikeController:SuppressScreenTap()

		local success, canInvite = wcall(SocialService.CanSendGameInviteAsync, SocialService, LocalPlayer)
		if success and canInvite then
			SocialService:PromptGameInvite(LocalPlayer)
		end
	end))

	local touchTapTracker = TouchTapTracker.new()

	local function handleVideoScreenTap(inputObj)
		local tapScale = getVideoScreenTapScale(runtime, Vector2.new(inputObj.Position.X, inputObj.Position.Y))
		if tapScale ~= nil then
			runtime.FriendLikesController:HandleScreenTap()
			runtime.LikeController:HandleScreenTap(tapScale)
		end
	end

	runtimeTrove:Connect(UserInputService.InputBegan, function(inputObj, gameProcessed)
		if gameProcessed then
			return
		end

		if inputObj.UserInputType == Enum.UserInputType.Touch then
			touchTapTracker:Begin(inputObj)
			return
		end

		if inputObj.UserInputType ~= Enum.UserInputType.MouseButton1 or UserInputService.TouchEnabled then
			return
		end

		local tapScale = getVideoScreenTapScale(runtime, Vector2.new(inputObj.Position.X, inputObj.Position.Y))
		if tapScale == nil then
			return
		end

		runtime.FriendLikesController:HandleScreenTap()
		runtime.LikeController:HandleScreenTap(tapScale)
	end)

	runtimeTrove:Connect(UserInputService.InputChanged, function(inputObj)
		if inputObj.UserInputType ~= Enum.UserInputType.Touch or not touchTapTracker:IsTrackingInput(inputObj) then
			return
		end

		touchTapTracker:Update(inputObj)
	end)

	runtimeTrove:Connect(UserInputService.InputEnded, function(inputObj, gameProcessed)
		if inputObj.UserInputType ~= Enum.UserInputType.Touch or not (touchTapTracker:IsTrackingInput(inputObj) and touchTapTracker:Evaluate(inputObj, gameProcessed)) then
			return
		end

		local tapScale = getVideoScreenTapScale(runtime, Vector2.new(inputObj.Position.X, inputObj.Position.Y))
		if tapScale == nil then
			return
		end

		runtime.FriendLikesController:HandleScreenTap()
		runtime.LikeController:HandleScreenTap(tapScale)
	end)

	runtimeTrove:Add(function()
		touchTapTracker:Reset()
	end)

	runtimeTrove:BindToRenderStep("TreadmillVideoProgress", Enum.RenderPriority.Last.Value, function()
		if currentRuntimeToken ~= runtime.Token then
			return
		end

		updateMediaProgress(runtime)
	end)

	runtimeTrove:Add(function()
		unloadVideo(runtime)
		runtime.LikeController:Destroy()
		runtime.FriendLikesController:Destroy()
		StopPlayIndicator.Visible = true
		SwapLeftGui.Enabled = false
		SwapRightGui.Enabled = false
		ShareGui.Enabled = false
		SideButtonsGui.Enabled = false
		VideoSurfaceGui.Enabled = false
	end)

	local currentIdx, networkIdx = FeedSequencer.Current(runtime.Feed)
	loadVideo(runtime, currentIdx, networkIdx, 1)

	logger:AtTrace():Log((("[TreadmillVideoController] Started treadmill video for %*"):format(modelName)))
end

local function bindVideoRuntimeWhenReady(treadmillName, initialIndex, token)
	local bindTrove = Trove.new()
	activeRuntimeTrove = bindTrove

	local isBound = false

	local function bindIfCurrent(treadmillTool)
		if not isBound and (treadmillTool ~= nil and (token == currentRuntimeToken and activeRuntimeTrove == bindTrove)) then
			local isTool = treadmillTool:IsA("Tool")
			assert(isTool, (("Runtime treadmill \"%*\" must be a Tool"):format(treadmillName)))

			isBound = true
			activeRuntimeTrove = nil
			bindTrove:Destroy()
			bindVideoRuntime(treadmillTool, treadmillName, initialIndex, token)
		end
	end

	bindTrove:Add(RuntimeInstanceRegistry.Changed:Connect(function(registryCategory, registryKey, instance)
		if registryCategory ~= "Treadmill" or registryKey ~= treadmillName then
			return
		end

		bindIfCurrent(instance)
	end))

	bindIfCurrent(RuntimeInstanceRegistry.Get("Treadmill", treadmillName))
end

function TreadmillController.Start(treadmillName, initialIndex)
	cleanupRuntime()
	currentRuntimeToken = currentRuntimeToken + 1
	bindVideoRuntimeWhenReady(treadmillName, initialIndex, currentRuntimeToken)
end

function TreadmillController.GetStoppedIconImage()
	return "rbxassetid://84371411600743"
end

function TreadmillController.ResolveCoverImage(mediaEntry)
	if mediaEntry.Kind == "Video" then
		return mediaEntry.CoverImage or ""
	end

	return mediaEntry.Image
end

function TreadmillController.GetCurrentMediaEntry(releaseStateData)
	local sequenceRuntime = FeedSequencer.CreateRuntime(
		mediaList,
		FeedSequencer.ResolveReleaseTrackingState(releaseStateData, LocalPlayer.UserId, releaseStateData.HasSwappedRight == true),
		LocalPlayer.UserId
	)
	local currentIdx = FeedSequencer.Current(sequenceRuntime)
	return mediaList[currentIdx]
end

function TreadmillController.Stop()
	cleanupRuntime()
end

function TreadmillController.SuppressScreenTap()
	local activeRuntime = activeTreadmillRuntime
	if activeRuntime == nil then
		return
	end

	activeRuntime.LikeController:SuppressScreenTap()
end

function TreadmillController.SetShareButtonVisible(visible)
	ShareButton.Visible = visible
end

CommentsController.Start({
	MediaChanged = TreadmillController.MediaChanged,
	SetShareButtonVisible = TreadmillController.SetShareButtonVisible,
	Stopped = TreadmillController.Stopped,
	SuppressScreenTap = TreadmillController.SuppressScreenTap
})

return TreadmillController