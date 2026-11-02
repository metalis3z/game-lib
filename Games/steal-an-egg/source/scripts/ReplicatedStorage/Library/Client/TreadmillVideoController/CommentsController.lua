local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local TweenService = game:GetService("TweenService")

local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Media = require(script.Parent.Media)
local Message = require(ReplicatedStorage.Library.Client.NotificationCmds.Message)
local PhotoInputController = require(script.PhotoInputController)

local CommentRenderer = require(script.CommentRenderer)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local TreadmillMediaCommentsConfig = require(ReplicatedStorage.Library.Modules.TreadmillMediaCommentsConfig)
local TreadmillMediaIdentity = require(ReplicatedStorage.Library.Modules.TreadmillMediaIdentity)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local VideoCommentsCmds = require(ReplicatedStorage.Library.Client.VideoCommentsCmds)
local wcall = require(ReplicatedStorage.Library.Functions.wcall)

require(ReplicatedStorage.Library.Client.VideoCommentsCmds.Types.Interface)
require(ReplicatedStorage.Library.Client.TreadmillVideoController.Types.Interface)
require(script.Types.Interface)

local INPUT_ERROR_COLOR = Color3.fromRGB(232, 158, 158)
local TWEEN_INFO = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local logger = Log.new()

local CommentsController = {}

-- UI Elements
local commentsSurfaceGui: SurfaceGui? = nil
local commentsTemplate: Frame? = nil
local scrollingFrame: ScrollingFrame? = nil
local commentRowTemplate: Frame? = nil
local textInput: TextBox? = nil
local defaultInputBgColor: Color3? = nil
local noCommentsFrame: Frame? = nil
local photoInputController = nil
local commentsCountLabel: TextLabel? = nil

-- Controller Callbacks
local setShareButtonVisible = function(_visible: boolean) end
local suppressScreenTap = function() end

-- State Variables
local currentMediaKey = ""
local cachedCommentCount = 0
local isCommentsOpen = false
local isLoadingPage = false
local isPostingComment = false
local hasNextPage = false
local nextCursor: number? = nil

local positiveIndex = 1
local negativeIndex = 0
local pageRequestId = 0

local inputTween: Tween? = nil
local trove: Trove? = nil

-- Data Tracking
local commentDataMap = {} :: { [string]: any }
local commentRowMap = {} :: { [string]: any }
local commentedMediaKeys = {} :: { [string]: boolean }
local pendingLikeRequests = {} :: { [string]: boolean }

-- Notification Helpers
local function showNotification(text: string)
	Message.Top({
		Message = text,
		Time = 3,
		ShowShadow = true,
		Color = Color3.new(1, 1, 1),
	})
end

local function formatCommentsTitle(count: number): string
	if count == 1 then
		return "1 comment"
	end
	return ("%* comments"):format(Simple.FormatCompact(count, ".#"))
end

local function updateCommentCountDisplay(count: number)
	cachedCommentCount = math.max(0, count)
	if commentsCountLabel then
		commentsCountLabel.Text = Simple.FormatCompact(cachedCommentCount, ".#")
	end
	if commentsTemplate then
		commentsTemplate.Sheet.Header.Content.SubContent.Title.Text = formatCommentsTitle(cachedCommentCount)
	end
end

local function updateEmptyState()
	local isEmpty = (next(commentRowMap) == nil) and not isLoadingPage
	if scrollingFrame then
		scrollingFrame.Visible = not isEmpty
	end
	if noCommentsFrame then
		noCommentsFrame.Visible = isEmpty
	end
end

local function clearRows()
	for id, row in commentRowMap do
		row.Destroy()
		commentRowMap[id] = nil
	end

	table.clear(commentDataMap)
	table.clear(pendingLikeRequests)

	positiveIndex = 1
	negativeIndex = 0

	if scrollingFrame then
		scrollingFrame.CanvasPosition = Vector2.zero
	end
end

local function requestPage()
	if not isCommentsOpen or isLoadingPage or not hasNextPage or nextCursor == nil or currentMediaKey == "" then
		return
	end

	isLoadingPage = true
	updateEmptyState()

	local targetCursor = nextCursor
	local currentRequestId = pageRequestId
	local mediaKey = currentMediaKey

	task.spawn(function()
		local response = VideoCommentsCmds.RequestCommentPage(
			mediaKey,
			targetCursor,
			TreadmillMediaCommentsConfig.COMMENT_PAGE_SIZE
		)

		if not isCommentsOpen or currentRequestId ~= pageRequestId then
			return
		end

		isLoadingPage = false

		if response.Ok then
			VideoCommentsCmds.ReconcileCommentCount(mediaKey, response.TotalCreatedCount)

			for _, comment in response.Comments do
				local renderIndex = positiveIndex

				if commentRowMap[comment.Id] == nil then
					commentDataMap[comment.Id] = comment
					commentRowMap[comment.Id] = CommentRenderer.Create(
						commentRowTemplate,
						scrollingFrame,
						comment,
						renderIndex,
						CommentsController.ToggleLike
					)
				end

				positiveIndex += 1
			end

			nextCursor = response.NextCursor
			hasNextPage = response.NextCursor ~= nil
		else
			hasNextPage = false
			nextCursor = nil
			logger:AtTrace():Log((("Unable to load treadmill comments: %*"):format(response.Error)))
		end

		updateEmptyState()
	end)
end

local function updateInputLimitPresentation()
	if not textInput or not defaultInputBgColor then
		return
	end

	local textLength = utf8.len(textInput.Text)
	assert(textLength ~= nil, "Comment text must contain valid UTF-8")

	local targetColor = if textLength >= TreadmillMediaCommentsConfig.MAX_COMMENT_CHARACTERS
		then INPUT_ERROR_COLOR
		else defaultInputBgColor

	if inputTween then
		inputTween:Cancel()
	end

	inputTween = TweenService:Create(textInput, TWEEN_INFO, {
		BackgroundColor3 = targetColor,
	})
	inputTween:Play()
end

local function postComment()
	if isPostingComment or currentMediaKey == "" or not textInput or not photoInputController then
		return
	end

	if commentedMediaKeys[currentMediaKey] then
		showNotification("You already commented this video.")
		return
	end

	suppressScreenTap()

	local rawText = textInput.Text
	local charCount = utf8.len(rawText)
	assert(charCount ~= nil, "Comment text must contain valid UTF-8")

	if charCount > TreadmillMediaCommentsConfig.MAX_COMMENT_CHARACTERS then
		showNotification("Your message is too long, please make it shorter!")
		return
	end

	local trimmedMessage = rawText:match("^%s*(.-)%s*$") or ""
	local imageAssetId = photoInputController:GetImageAssetId()

	if trimmedMessage == "" and imageAssetId == nil then
		return
	end

	isPostingComment = true

	local currentRequestId = pageRequestId
	local mediaKey = currentMediaKey

	task.spawn(function()
		local response = VideoCommentsCmds.PostComment(mediaKey, trimmedMessage, imageAssetId)

		if currentRequestId ~= pageRequestId then
			return
		end

		isPostingComment = false

		if response.Ok then
			commentedMediaKeys[mediaKey] = true
			textInput.Text = ""
			photoInputController:Reset()
			negativeIndex -= 1

			local comment = response.Comment
			local renderIndex = negativeIndex

			if commentRowMap[comment.Id] == nil then
				commentDataMap[comment.Id] = comment
				commentRowMap[comment.Id] = CommentRenderer.Create(
					commentRowTemplate,
					scrollingFrame,
					comment,
					renderIndex,
					CommentsController.ToggleLike
				)
			end

			VideoCommentsCmds.ReconcileCommentCount(mediaKey, cachedCommentCount + 1)
			updateEmptyState()

			if scrollingFrame then
				scrollingFrame.CanvasPosition = Vector2.zero
			end
		else
			if response.Error == "AlreadyCommented" then
				commentedMediaKeys[mediaKey] = true
				showNotification("You already commented this video.")
			elseif response.Error == "MessageFiltered" then
				showNotification("Your comment was filtered, please try another message!")
			elseif response.Error == "InvalidImageAssetId" then
				showNotification("Invalid image, please upload another image.")
			elseif response.Error == "ImageAssetLookupFailed" then
				showNotification("Something went wrong, please try again later.")
			elseif response.Error == "You're doing that too fast!" or response.Error == "You're on cooldown. Please try again later." then
				showNotification("You're doing this too fast, please wait a bit.")
			end

			logger:AtTrace():Log((("Unable to post treadmill comment: %*"):format(response.Error)))
		end
	end)
end

local function openComments()
	if isCommentsOpen or currentMediaKey == "" or not commentsTemplate then
		return
	end

	suppressScreenTap()
	isCommentsOpen = true
	commentsTemplate.Visible = true

	setShareButtonVisible(false)
	clearRows()
	updateEmptyState()

	pageRequestId += 1
	nextCursor = 0
	hasNextPage = true
	isLoadingPage = false

	requestPage()
end

local function handleScroll()
	if not isCommentsOpen or not hasNextPage or not scrollingFrame then
		return
	end

	local distanceFromBottom = scrollingFrame.AbsoluteCanvasSize.Y - scrollingFrame.CanvasPosition.Y - scrollingFrame.AbsoluteWindowSize.Y
	if distanceFromBottom <= 64 then
		requestPage()
	end
end

local function handleMediaChanged(mediaItem: any, adorneePart: BasePart)
	local mediaKey = TreadmillMediaIdentity.GetMediaKey(mediaItem)

	CommentsController.Close()

	if commentsSurfaceGui then
		commentsSurfaceGui.Adornee = adorneePart
		commentsSurfaceGui.Enabled = true
	end

	currentMediaKey = mediaKey
	updateCommentCountDisplay(VideoCommentsCmds.GetCachedCommentCount(mediaKey) or 0)
end

function CommentsController.ToggleLike(commentId: string)
	if pendingLikeRequests[commentId] then
		return
	end

	local commentData = commentDataMap[commentId]
	local commentRow = commentRowMap[commentId]

	assert(commentData ~= nil and commentRow ~= nil, (("Missing rendered comment %*"):format(commentId)))

	suppressScreenTap()
	pendingLikeRequests[commentId] = true

	local previousLiked = commentData.LikedByViewer
	local previousCount = commentData.LikeCount
	local nextLiked = not previousLiked

	commentData.LikedByViewer = nextLiked
	commentData.LikeCount = math.max(0, previousCount + (if nextLiked then 1 else -1))
	commentRow.UpdateLike(commentData.LikedByViewer, commentData.LikeCount)

	local currentRequestId = pageRequestId
	local mediaKey = currentMediaKey

	task.spawn(function()
		local response = VideoCommentsCmds.SetCommentLike(mediaKey, commentId, nextLiked)

		if currentRequestId ~= pageRequestId then
			return
		end

		pendingLikeRequests[commentId] = nil

		local activeData = commentDataMap[commentId]
		local activeRow = commentRowMap[commentId]

		if not activeData or not activeRow then
			return
		end

		if response.Ok then
			activeData.LikedByViewer = response.Liked
			activeData.LikeCount = math.max(0, response.LikeCount)
		else
			activeData.LikedByViewer = previousLiked
			activeData.LikeCount = previousCount
		end

		activeRow.UpdateLike(activeData.LikedByViewer, activeData.LikeCount)
	end)
end

function CommentsController.Close()
	pageRequestId += 1
	isCommentsOpen = false
	isLoadingPage = false
	isPostingComment = false
	hasNextPage = false
	nextCursor = nil

	if commentsTemplate then
		commentsTemplate.Visible = false
	end

	setShareButtonVisible(true)

	if textInput then
		textInput.Text = ""
	end

	if photoInputController then
		photoInputController:Reset()
	end

	clearRows()
	updateEmptyState()
end

function CommentsController.Deactivate()
	CommentsController.Close()
	currentMediaKey = ""

	if commentsSurfaceGui then
		commentsSurfaceGui.Enabled = false
	end

	updateCommentCountDisplay(0)
end

function CommentsController.Start(controllerInterface: any)
	assert(trove == nil, "Treadmill comments controller must only start once")

	local commentsButton = GUI.TreadmillScreenSideButtons().Frame.Buttons.CommentsButton
	local shareGui = GUI.TreadmillScreenButtonShare()

	assert(shareGui:IsA("SurfaceGui"), "Treadmill share GUI must be a SurfaceGui")

	local shareButton = shareGui.Frame.ShareButton

	assert(commentsButton:IsA("GuiButton"), "Treadmill comments button must be a GuiButton")
	assert(shareButton:IsA("GuiButton"), "Treadmill share button must be a GuiButton")

	local success, canChat = wcall(TextChatService.CanUserChatAsync, TextChatService, Players.LocalPlayer.UserId)
	commentsButton.Visible = if success then canChat == true else false

	if not commentsButton.Visible then
		shareButton.Position = UDim2.fromScale(0.98, 0.65)
		return
	end

	setShareButtonVisible = controllerInterface.SetShareButtonVisible
	suppressScreenTap = controllerInterface.SuppressScreenTap

	commentsSurfaceGui = GUI.TreadmillScreenComments()
	assert(commentsSurfaceGui:IsA("SurfaceGui"), "Treadmill comments GUI must be a SurfaceGui")

	commentsTemplate = commentsSurfaceGui.Frame.CommentsTemplate
	scrollingFrame = commentsTemplate.Sheet.Content
	commentRowTemplate = scrollingFrame.Comment_01
	textInput = commentsTemplate.Sheet.Actions.Content.TextInputWrapper.TextInput

	assert(scrollingFrame:IsA("ScrollingFrame"), "Treadmill comments content must be a ScrollingFrame")
	assert(commentRowTemplate:IsA("Frame"), "Treadmill comments row template must be a Frame")
	assert(commentsButton.CommentsCount:IsA("TextLabel"), "Treadmill comments count must be a TextLabel")

	defaultInputBgColor = textInput.BackgroundColor3
	noCommentsFrame = commentsTemplate.Sheet.NoComments
	photoInputController = PhotoInputController.new(commentsTemplate, suppressScreenTap)
	commentsCountLabel = commentsButton.CommentsCount

	trove = Trove.new()

	-- Clean up initial design-time template children
	for _, child in scrollingFrame:GetChildren() do
		if child:IsA("Frame") and child.Name:match("^Comment_%d+$") then
			if child.Name == "Comment_01" then
				child.Visible = false
				continue
			end
			child:Destroy()
		end
	end

	scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	commentsSurfaceGui.Enabled = false
	commentsTemplate.Visible = false
	commentsTemplate.Overlay.Active = true
	commentsTemplate.AddPhoto.Visible = false

	local currentTrove = trove
	currentTrove:Add(ButtonFX(commentsButton, nil, openComments))
	currentTrove:Add(ButtonFX(commentsTemplate.Sheet.Header.Content.Close, nil, function()
		suppressScreenTap()
		CommentsController.Close()
	end))

	currentTrove:Connect(commentsTemplate.Overlay.InputBegan, function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		if input.Position.Y >= commentsTemplate.Sheet.AbsolutePosition.Y then
			return
		end

		suppressScreenTap()
		CommentsController.Close()
	end)

	currentTrove:Add(ButtonFX(commentsTemplate.Sheet.Actions.Content.Send, nil, postComment))
	currentTrove:Connect(textInput:GetPropertyChangedSignal("Text"), updateInputLimitPresentation)
	currentTrove:Connect(scrollingFrame:GetPropertyChangedSignal("CanvasPosition"), handleScroll)
	currentTrove:Add(controllerInterface.MediaChanged:Connect(handleMediaChanged))
	currentTrove:Add(controllerInterface.Stopped:Connect(CommentsController.Deactivate))

	currentTrove:Add(VideoCommentsCmds.CommentCountChanged:Connect(function(mediaKey, count)
		if mediaKey == currentMediaKey then
			updateCommentCountDisplay(count)
		end
	end))

	VideoCommentsCmds.StartCommentCountCache(TreadmillMediaIdentity.BuildMediaKeys(Media))
	updateCommentCountDisplay(0)
	updateEmptyState()
end

return CommentsController