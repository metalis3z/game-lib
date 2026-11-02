local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Asserts = require(ReplicatedStorage.Library.Asserts)
local Bezier2 = require(ReplicatedStorage.Library.Functions.Bezier2)
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Easing = require(ReplicatedStorage.Library.Functions.Easing)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Lock = require(ReplicatedStorage.Library.Functions.Lock)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Network = require(ReplicatedStorage.Library.Client.Network)
local PreloadAssets = require(ReplicatedStorage.Library.Functions.PreloadAssets)
local RenderStepped = require(ReplicatedStorage.Library.Functions.RenderStepped)
local Schema = require(ReplicatedStorage.Library.Types.TreadmillMediaLike.Types.Schema)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local TreadmillMediaIdentity = require(ReplicatedStorage.Library.Modules.TreadmillMediaIdentity)
local wcall = require(ReplicatedStorage.Library.Functions.wcall)

require(ReplicatedStorage.Library.Types.TreadmillMediaLike.Types.Interface)
require(ReplicatedStorage.Library.Modules.Packages.Trove)
require(script.Parent.Types.Interface)

local LikeController = {}
LikeController.__index = LikeController
LikeController.__class = "LikeController"

local Treadmills = Constants.NETWORK_MAP.Treadmills
local LIKE_HEART_COLOR = Color3.fromRGB(255, 92, 122)
local LIKED_HEART_IMAGE = "rbxassetid://90146064998908"
local UNLIKED_HEART_IMAGE = "rbxassetid://123761405635833"

local logger = Log.new()

task.spawn(PreloadAssets, LIKED_HEART_IMAGE, UNLIKED_HEART_IMAGE)

local sideButtonsGui = GUI.TreadmillScreenSideButtons()
assert(sideButtonsGui:IsA("SurfaceGui"), "Treadmill like GUI must be a SurfaceGui")

local likeButton = sideButtonsGui.Frame.Buttons.LikeButton
assert(likeButton:IsA("ImageButton"), "Treadmill like button must be an ImageButton")

local likeCountLabel = likeButton.LikeCount
assert(likeCountLabel:IsA("TextLabel"), "Treadmill like count label must be a TextLabel")

local function formatLikeCount(count)
	return Simple.FormatCompact(math.max(count, 0), ".#")
end

local function getSquareHeartSize(frameSize, scale)
	local minDimension = math.min(frameSize.X, frameSize.Y)
	return UDim2.fromScale(minDimension / frameSize.X * scale, minDimension / frameSize.Y * scale)
end

function LikeController.new(getActiveVideoIndex, onSingleTap, mediaEntries, parentTrove, videoFrame, adorneePart)
	Asserts.func(getActiveVideoIndex)
	Asserts.func(onSingleTap)
	Asserts.table(mediaEntries)
	Asserts.table(parentTrove)
	Asserts.Instance(videoFrame)
	Asserts.BasePart(adorneePart)

	local self = setmetatable({}, LikeController)

	self._countsByMediaLikeKey = {}
	self._defaultLikeButtonColor = likeButton.ImageColor3
	self._destroyed = false
	self._getActiveVideoIndex = getActiveVideoIndex
	self._lastScreenTapPosition = nil
	self._lastScreenTapTime = nil
	self._likeButton = likeButton
	self._likeCountLabel = likeCountLabel
	self._likeRequestLocks = {}
	self._likeSurfaceGui = sideButtonsGui
	self._likedTreadmillMedia = {}
	self._mediaEntries = mediaEntries
	self._onSingleTap = onSingleTap
	self._pendingSingleTapSerial = 0
	self._snapshotRequestSerial = 0
	self._screenTapSuppressUntil = 0
	self._trove = parentTrove:Extend()
	self._videoFrame = videoFrame

	self:_init(adorneePart)

	return self
end

function LikeController._isAlive(self)
	return not self._destroyed
end

function LikeController._getMediaKey(self)
	local activeIdx = self._getActiveVideoIndex()
	local mediaEntry = self._mediaEntries[activeIdx]

	assert(mediaEntry ~= nil, (("Missing treadmill media entry for index %*"):format(activeIdx)))

	return TreadmillMediaIdentity.GetMediaKey(mediaEntry)
end

function LikeController._setRuntimeLikedState(self, mediaKey, isLiked)
	if isLiked then
		self._likedTreadmillMedia[mediaKey] = true
	else
		self._likedTreadmillMedia[mediaKey] = nil
	end
end

function LikeController._applyLocalLikedState(self, mediaKey, isLiked)
	local currentlyLiked = self._likedTreadmillMedia[mediaKey] == true
	if currentlyLiked == isLiked then
		return
	end

	self:_setRuntimeLikedState(mediaKey, isLiked)
	self._countsByMediaLikeKey[mediaKey] = math.max((self._countsByMediaLikeKey[mediaKey] or 0) + (if isLiked then 1 else -1), 0)
	self:UpdatePresentation()
end

function LikeController._reconcileLikedState(self, mediaKey, resultPayload)
	self:_setRuntimeLikedState(mediaKey, resultPayload.Liked == true)

	if typeof(resultPayload.Count) == "number" then
		self._countsByMediaLikeKey[mediaKey] = resultPayload.Count
	end

	self:UpdatePresentation()
end

function LikeController._requestLikeSnapshot(self, requestSerial)
	local success, snapshotData = wcall(function()
		return Network.Invoke(Treadmills.REQUEST_LIKE_SNAPSHOT)
	end)

	if not success then
		logger:AtError():Log((("Failed to load treadmill media like snapshot: %*"):format(snapshotData)))
		return
	end

	if not Schema.LikeSnapshot(snapshotData) then
		logger:AtError():Log("Invalid treadmill media like snapshot payload")
		return
	end

	if self:_isAlive() and requestSerial == self._snapshotRequestSerial then
		self._countsByMediaLikeKey = table.clone(snapshotData.CountsByMediaLikeKey)
		self._likedTreadmillMedia = table.clone(snapshotData.LikedTreadmillMedia)
		self:UpdatePresentation()
	end
end

function LikeController._requestLikeSnapshotAsync(self)
	self._snapshotRequestSerial += 1
	local currentSerial = self._snapshotRequestSerial

	task.spawn(function()
		if self:_isAlive() then
			self:_requestLikeSnapshot(currentSerial)
		end
	end)
end

function LikeController._setLikedState(self, targetLiked)
	local mediaKey = self:_getMediaKey()
	local lock = self._likeRequestLocks[mediaKey]

	if lock == nil then
		lock = Lock()
		self._likeRequestLocks[mediaKey] = lock
	end

	lock(function()
		self._snapshotRequestSerial += 1

		local previousLiked = self._likedTreadmillMedia[mediaKey] == true
		local previousCount = self._countsByMediaLikeKey[mediaKey] or 0

		self:_applyLocalLikedState(mediaKey, targetLiked)

		local success, response = wcall(function()
			return Network.Invoke(Treadmills.REQUEST_SET_MEDIA_LIKE, mediaKey, targetLiked)
		end)

		if success then
			if Schema.LikeToggleResult(response) then
				if response.Ok == true then
					if self:_isAlive() then
						self:_reconcileLikedState(mediaKey, response)
					end
				elseif self:_isAlive() then
					self:_setRuntimeLikedState(mediaKey, previousLiked)
					self._countsByMediaLikeKey[mediaKey] = previousCount
					self:UpdatePresentation()
					logger:AtError():Log((("Rejected treadmill media like state update: %*"):format(tostring(response.Error))))
				end
			elseif self:_isAlive() then
				self:_setRuntimeLikedState(mediaKey, previousLiked)
				self._countsByMediaLikeKey[mediaKey] = previousCount
				self:UpdatePresentation()
				logger:AtError():Log("Rejected treadmill media like state update: Invalid like toggle response")
			end
		elseif self:_isAlive() then
			self:_setRuntimeLikedState(mediaKey, previousLiked)
			self._countsByMediaLikeKey[mediaKey] = previousCount
			self:UpdatePresentation()
			logger:AtError():Log((("Failed to update treadmill media like state: %*"):format(response)))
		end
	end)
end

function LikeController._spawnHeartAnimation(self, normalizedTapPosition)
	Asserts.finiteVector2(normalizedTapPosition)

	local videoFrame = self._videoFrame
	local frameSize = videoFrame.AbsoluteSize

	assert(frameSize.X > 0 and frameSize.Y > 0, "Treadmill like animation requires a non-zero video frame size")

	local heartImage = Instance.new("ImageLabel")
	heartImage.Name = "TreadmillLikeHeart"
	heartImage.AnchorPoint = Vector2.new(0.5, 0.5)
	heartImage.BackgroundTransparency = 1
	heartImage.Image = LIKED_HEART_IMAGE
	heartImage.ImageColor3 = LIKE_HEART_COLOR
	heartImage.ImageTransparency = 0
	heartImage.Position = UDim2.fromScale(normalizedTapPosition.X, normalizedTapPosition.Y)
	heartImage.Size = UDim2.fromScale(0.15, 0.08)
	heartImage.ZIndex = self._likeButton.ZIndex + 10
	heartImage.Parent = videoFrame

	Instance.new("UIAspectRatioConstraint").Parent = heartImage

	local rng = Random.new()
	local offsetX = rng:NextNumber(-0.08, 0.08)
	local offsetY = -rng:NextNumber(0.24, 0.34)

	local endPosition = Vector2.new(
		math.clamp(normalizedTapPosition.X + offsetX, 0.05, 0.95),
		math.clamp(normalizedTapPosition.Y + offsetY, 0.05, 0.95)
	)
	local controlPoint = Vector2.new(
		math.clamp(normalizedTapPosition.X + offsetX * 0.55, 0.05, 0.95),
		math.clamp(normalizedTapPosition.Y + offsetY * 0.45, 0.05, 0.95)
	)
	local bezierCurve = Bezier2(normalizedTapPosition, controlPoint, endPosition)

	local renderConnection = nil
	local isCleanedUp = false

	local function cleanupHeart(disconnectConnection)
		if isCleanedUp then
			return
		end
		isCleanedUp = true

		local connection = renderConnection
		renderConnection = nil

		if connection ~= nil then
			if disconnectConnection then
				connection:Disconnect()
			end
			connection:Then(function()
				connection:Destroy()
			end)
		end

		if heartImage.Parent ~= nil then
			heartImage:Destroy()
		end
	end

	renderConnection = RenderStepped(function(_, progress)
		if self:_isAlive() and heartImage.Parent ~= nil then
			local currentPos = bezierCurve(Easing(progress, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
			local scaleMultiplier = if progress <= 0.18
				then 0.6 - 0.2 * Easing(progress / 0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
				else 0.4 - 0.32 * Easing((progress - 0.18) / 0.82, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

			heartImage.Position = UDim2.fromScale(currentPos.X, currentPos.Y)

			local minDimension = math.min(frameSize.X, frameSize.Y)
			heartImage.Size = UDim2.fromScale(
				(minDimension / frameSize.X) * scaleMultiplier,
				(minDimension / frameSize.Y) * scaleMultiplier
			)
			heartImage.ImageTransparency = math.clamp((progress - 0.35) / 0.65, 0, 1)

			if progress < 1 then
				return false
			end

			if isCleanedUp then
				return true
			end
			isCleanedUp = true

			local conn = renderConnection
			renderConnection = nil
			if conn ~= nil then
				conn:Then(function()
					conn:Destroy()
				end)
			end
		else
			if isCleanedUp then
				return true
			end
			isCleanedUp = true

			local conn = renderConnection
			renderConnection = nil
			if conn ~= nil then
				conn:Then(function()
					conn:Destroy()
				end)
			end
		end

		if heartImage.Parent ~= nil then
			heartImage:Destroy()
		end

		return true
	end, 0.65, true)

	self._trove:Add(function()
		cleanupHeart(true)
	end)
end

function LikeController._handleDoubleTap(self, tapPosition)
	Asserts.finiteVector2(tapPosition)

	self:_spawnHeartAnimation(tapPosition)

	if self._likedTreadmillMedia[self:_getMediaKey()] ~= true then
		self:_setLikedState(true)
	end
end

function LikeController._startRefreshLoop(self)
	task.spawn(function()
		while self:_isAlive() do
			task.wait(180)

			if not self:_isAlive() then
				break
			end

			self:_requestLikeSnapshotAsync()
		end
	end)
end

function LikeController._init(self, adorneePart)
	self._likeSurfaceGui.Adornee = adorneePart
	self._likeSurfaceGui.Enabled = true

	self:UpdatePresentation()

	self._trove:Add(ButtonFX(self._likeButton, nil, function()
		self:SuppressScreenTap()
		self:_setLikedState(not (self._likedTreadmillMedia[self:_getMediaKey()] == true))
	end))

	self:_requestLikeSnapshotAsync()
	self:_startRefreshLoop()
end

function LikeController.UpdatePresentation(self)
	if not self:_isAlive() then
		return
	end

	local mediaKey = self:_getMediaKey()
	local isLiked = self._likedTreadmillMedia[mediaKey] == true

	self._likeButton.ImageColor3 = if isLiked then LIKE_HEART_COLOR else Color3.fromRGB(255, 255, 255)
	self._likeButton.Image = if isLiked then LIKED_HEART_IMAGE else UNLIKED_HEART_IMAGE
	self._likeCountLabel.Text = formatLikeCount(self._countsByMediaLikeKey[mediaKey] or 0)
end

function LikeController.SuppressScreenTap(self)
	self._screenTapSuppressUntil = os.clock() + 0.12
end

function LikeController.HandleScreenTap(self, tapPosition)
	Asserts.finiteVector2(tapPosition)

	if not self:_isAlive() or os.clock() < self._screenTapSuppressUntil then
		return
	end

	local now = os.clock()
	local frameSize = self._videoFrame.AbsoluteSize

	assert(frameSize.X > 0 and frameSize.Y > 0, "Treadmill like tap handling requires a non-zero video frame size")

	local lastTime = self._lastScreenTapTime
	local lastPos = self._lastScreenTapPosition

	if lastTime ~= nil and lastPos ~= nil then
		local timeDelta = now - lastTime
		local pixelDelta = Vector2.new((tapPosition.X - lastPos.X) * frameSize.X, (tapPosition.Y - lastPos.Y) * frameSize.Y)

		if timeDelta <= 0.25 and pixelDelta.Magnitude <= 36 then
			self._pendingSingleTapSerial += 1
			self._lastScreenTapTime = nil
			self._lastScreenTapPosition = nil
			self:_handleDoubleTap(tapPosition)
			return
		end
	end

	self._pendingSingleTapSerial += 1
	local currentSingleTapSerial = self._pendingSingleTapSerial

	self._lastScreenTapTime = now
	self._lastScreenTapPosition = tapPosition

	task.delay(0.25, function()
		if self:_isAlive() and self._pendingSingleTapSerial == currentSingleTapSerial then
			self._lastScreenTapTime = nil
			self._lastScreenTapPosition = nil
			self._onSingleTap()
		end
	end)
end

function LikeController.Destroy(self)
	if not self._destroyed then
		self._destroyed = true
		self._pendingSingleTapSerial += 1
		self._likeSurfaceGui.Enabled = false
		self._trove:Destroy()
	end
end

return LikeController