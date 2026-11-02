-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local TweenService = game:GetService("TweenService")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local CommentRenderer = require(script.CommentRenderer)
local GUI = require(ReplicatedStorage.Client.GUI)
local Log = require(ReplicatedStorage.Packages.Log)
local Media = require(script.Parent.Media)
local Message = require(ReplicatedStorage.Client.Notifications.Message)
local PhotoInputController = require(script.PhotoInputController)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local TreadmillFlags = require(ReplicatedStorage.Shared.Flags.TreadmillFlags)
local TreadmillMediaCommentsConfig = require(ReplicatedStorage.Shared.Modules.TreadmillMediaCommentsConfig)
local TreadmillMediaIdentity = require(ReplicatedStorage.Shared.Modules.TreadmillMediaIdentity)
require(ReplicatedStorage.Shared.TreadmillVideoController.Types.Interface)
local Trove = require(ReplicatedStorage.Packages.Trove)
require(script.Types.Interface)
require(ReplicatedStorage.Client.VideoCommentsCmds.Types.Interface)
local VideoCommentsCmds = require(ReplicatedStorage.Client.VideoCommentsCmds)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local v1 = Color3.fromRGB(232, 158, 158)
local v2 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v3 = UDim2.fromScale(0.98, 0.65)
local v4 = Log.new()
local v5 = {}
local v6, Content, BackgroundColor3
local v7 = false
local v8 = {}
local TextInput, v9
local v10 = false
local v11 = false
local v12 = false
local v13 = ""
local v14
local v15 = 1
local v16 = 0
local NoComments
local v17 = {}
local v18
local v19 = {}
local v20 = 0
local Comment_01

local function v21(v22) -- line 52
end

local CommentsCount, CommentsTemplate
local v23 = 0
local v24

local function v25() -- line 57
end

local v26 = {}

local function trim(v27) -- line 59
    return v27:match("^%s*(.-)%s*$") or ""
end

local function characterCount(v28) -- line 62
    local v29 = utf8.len(v28)
    local v30 = v29 ~= nil
    assert(v30, "Comment text must contain valid UTF-8")
    return v29
end

local function showTooLongNotification() -- line 68 | captures: Message
    Message.Top({
        Message = "Your message is too long, please make it shorter!",
        Time = 3,
        ShowShadow = true,
        Color = Color3.new(1, 1, 1)
    })
end

local function showAlreadyCommentedNotification() -- line 71 | captures: Message
    Message.Top({
        Message = "You already commented this video.",
        Time = 3,
        ShowShadow = true,
        Color = Color3.new(1, 1, 1)
    })
end

local function showInvalidImageNotification() -- line 74 | captures: Message
    Message.Top({
        Message = "Invalid image, please upload another image.",
        Time = 3,
        ShowShadow = true,
        Color = Color3.new(1, 1, 1)
    })
end

local function showImageLookupFailedNotification() -- line 77 | captures: Message
    Message.Top({
        Message = "Something went wrong, please try again later.",
        Time = 3,
        ShowShadow = true,
        Color = Color3.new(1, 1, 1)
    })
end

local function showPostRateLimitNotification() -- line 80 | captures: Message
    Message.Top({
        Message = "You're doing this too fast, please wait a bit.",
        Time = 3,
        ShowShadow = true,
        Color = Color3.new(1, 1, 1)
    })
end

local function showFilteredCommentNotification() -- line 83 | captures: Message
    Message.Top({
        Message = "Your comment was filtered, please try another message!",
        Time = 3,
        ShowShadow = true,
        Color = Color3.new(1, 1, 1)
    })
end

local function isRateLimitError(v31) -- line 86
    if v31 == "You're doing that too fast!" then
        return true
    end
    return v31 == "You're on cooldown. Please try again later."
end

local function formatCommentsTitle(v32) -- line 90 | captures: Simple
    if v32 == 1 then
        return "1 comment"
    end
    return (("%* comments"):format((Simple.FormatCompact(v32, ".#"))))
end

local function projectCount(v33) -- line 96 | captures: CommentsCount, CommentsTemplate, v23, Simple
    v23 = math.max(0, v33)
    CommentsCount.Text = Simple.FormatCompact(v23, ".#")
    local v34 = v23
    local v35
    if v34 == 1 then
        v35 = "1 comment"
    else
        v35 = ("%* comments"):format((Simple.FormatCompact(v34, ".#")))
    end
    CommentsTemplate.Sheet.Header.Content.SubContent.Title.Text = v35
end

local function updateEmptyState() -- line 108 | captures: Content, v11, NoComments, v19
    local v36 = if next(v19) == nil then not v11 else false
    Content.Visible = not v36
    NoComments.Visible = v36
end

local function clearRows() -- line 113 | captures: Content, v15, v16, v5, v17, v19
    for v37, v38 in v19 do
        v38.Destroy()
        v19[v37] = nil
    end
    table.clear(v5)
    table.clear(v17)
    v15 = 1
    v16 = 0
    Content.CanvasPosition = Vector2.zero
end

local function renderComment(v39, v40) -- line 127 | captures: Content, Comment_01, CommentRenderer, v5, v19, v26
    if v19[v39.Id] == nil then
        v5[v39.Id] = v39
        v19[v39.Id] = CommentRenderer.Create(Comment_01, Content, v39, v40, v26.ToggleLike)
    end
end

local function requestPage() -- line 134 | captures: Content, v7, v10, v11, v13, v14, v15, NoComments, v20, Comment_01, CommentRenderer, TreadmillMediaCommentsConfig, VideoCommentsCmds, v4, v5, v19, v26
    local v41, v42
    if v10 then
        if v11 then
            v42 = true
        elseif v7 then
            if v14 == nil or v13 == "" then
                v42 = true
            else
                v11 = true
                if next(v19) == nil then
                    v41 = not v11
                else
                    v41 = false
                end
                v42 = false
            end
        else
            v42 = true
        end
    else
        v42 = true
    end
    if v42 then
        return
    end
    Content.Visible = not v41
    NoComments.Visible = v41
    local v43 = v14
    local v44 = v20
    local v45 = v13
    task.spawn(function() -- line 145 | captures: v43, v44, v45, Content, v7, v10, v11, v14, v15, NoComments, v20, Comment_01, CommentRenderer, TreadmillMediaCommentsConfig, VideoCommentsCmds, v4, v5, v19, v26
        local v46 = VideoCommentsCmds.RequestCommentPage(v45, v43, TreadmillMediaCommentsConfig.COMMENT_PAGE_SIZE)
        if v10 and v44 == v20 then
            v11 = false
            if v46.Ok then
                VideoCommentsCmds.ReconcileCommentCount(v45, v46.TotalCreatedCount)
                for v47, v48 in v46.Comments do
                    if v19[v48.Id] == nil then
                        v5[v48.Id] = v48
                        v19[v48.Id] = CommentRenderer.Create(Comment_01, Content, v48, v15, v26.ToggleLike)
                    end
                    v15 += 1
                end
                v14 = v46.NextCursor
                v7 = v46.NextCursor ~= nil
                local v49 = if next(v19) == nil then not v11 else false
                Content.Visible = not v49
                NoComments.Visible = v49
            else
                v7 = false
                v14 = nil
                local v50 = if next(v19) == nil then not v11 else false
                Content.Visible = not v50
                NoComments.Visible = v50
                v4:AtTrace():Log((("Unable to load treadmill comments: %*"):format(v46.Error)))
            end
        end
    end)
end

local function requestInitialPage() -- line 180 | captures: v7, v11, v14, v20, requestPage
    v20 += 1
    v14 = 0
    v7 = true
    v11 = false
    requestPage()
end

local function updateInputLimitPresentation() -- line 187 | captures: BackgroundColor3, TextInput, v9, TweenService, TreadmillMediaCommentsConfig, v1, v2
    local v51 = utf8.len(TextInput.Text)
    local v52 = v51 ~= nil
    assert(v52, "Comment text must contain valid UTF-8")
    local v53 = if v51 < TreadmillMediaCommentsConfig.MAX_COMMENT_CHARACTERS then BackgroundColor3 else v1
    if v9 ~= nil then
        v9:Cancel()
    end
    local v54 = TweenService:Create(TextInput, v2, { BackgroundColor3 = v53 })
    v9 = v54
    v54:Play()
end

local function postComment() -- line 204 | captures: Content, TextInput, v11, v12, v13, v16, NoComments, v18, v20, Comment_01, v23, v25, CommentRenderer, Message, TreadmillMediaCommentsConfig, VideoCommentsCmds, v4, v5, v8, v19, v26
    if not (v12 or v13 == "") then
        if v8[v13] then
            Message.Top({
                Message = "You already commented this video.",
                Time = 3,
                ShowShadow = true,
                Color = Color3.new(1, 1, 1)
            })
        else
            v25()
            local Text = TextInput.Text
            local v55 = utf8.len(Text)
            local v56 = v55 ~= nil
            assert(v56, "Comment text must contain valid UTF-8")
            if TreadmillMediaCommentsConfig.MAX_COMMENT_CHARACTERS < v55 then
                Message.Top({
                    Message = "Your message is too long, please make it shorter!",
                    Time = 3,
                    ShowShadow = true,
                    Color = Color3.new(1, 1, 1)
                })
            else
                local v57 = Text:match("^%s*(.-)%s*$") or ""
                local v58 = v18:GetImageAssetId()
                if v57 == "" then
                    if v58 ~= nil then
                        v12 = true
                        local v59 = v20
                        local v60 = v13
                        task.spawn(function() -- line 279 | captures: v59, v60, v57, v58, Content, TextInput, v11, v12, v16, NoComments, v18, v20, Comment_01, v23, CommentRenderer, Message, VideoCommentsCmds, v4, v5, v8, v19, v26
                            local v61 = VideoCommentsCmds.PostComment(v60, v57, v58)
                            if v59 == v20 then
                                v12 = false
                                if v61.Ok then
                                    v8[v60] = true
                                    TextInput.Text = ""
                                    v18:Reset()
                                    v16 -= 1
                                    local Comment = v61.Comment
                                    if v19[Comment.Id] == nil then
                                        v5[Comment.Id] = Comment
                                        v19[Comment.Id] = CommentRenderer.Create(Comment_01, Content, Comment, v16, v26.ToggleLike)
                                    end
                                    VideoCommentsCmds.ReconcileCommentCount(v60, v23 + 1)
                                    local v62 = if next(v19) == nil then not v11 else false
                                    Content.Visible = not v62
                                    NoComments.Visible = v62
                                    Content.CanvasPosition = Vector2.zero
                                else
                                    if v61.Error == "AlreadyCommented" then
                                        v8[v60] = true
                                        Message.Top({
                                            Message = "You already commented this video.",
                                            Time = 3,
                                            ShowShadow = true,
                                            Color = Color3.new(1, 1, 1)
                                        })
                                    elseif v61.Error == "MessageFiltered" then
                                        Message.Top({
                                            Message = "Your comment was filtered, please try another message!",
                                            Time = 3,
                                            ShowShadow = true,
                                            Color = Color3.new(1, 1, 1)
                                        })
                                    elseif v61.Error == "InvalidImageAssetId" then
                                        Message.Top({
                                            Message = "Invalid image, please upload another image.",
                                            Time = 3,
                                            ShowShadow = true,
                                            Color = Color3.new(1, 1, 1)
                                        })
                                    elseif v61.Error == "ImageAssetLookupFailed" then
                                        Message.Top({
                                            Message = "Something went wrong, please try again later.",
                                            Time = 3,
                                            ShowShadow = true,
                                            Color = Color3.new(1, 1, 1)
                                        })
                                    else
                                        local Error = v61.Error
                                        if Error == "You're doing that too fast!" or Error == "You're on cooldown. Please try again later." then
                                            Message.Top({
                                                Message = "You're doing this too fast, please wait a bit.",
                                                Time = 3,
                                                ShowShadow = true,
                                                Color = Color3.new(1, 1, 1)
                                            })
                                        end
                                    end
                                    v4:AtTrace():Log((("Unable to post treadmill comment: %*"):format(v61.Error)))
                                end
                            end
                        end)
                    end
                else
                    v12 = true
                    local v63 = v20
                    local v64 = v13
                    task.spawn(function() -- line 229 | captures: v57, v58, Content, TextInput, v11, v12, v16, NoComments, v18, v20, Comment_01, v23, CommentRenderer, Message, VideoCommentsCmds, v4, v5, v8, v19, v26, v63, v64
                        local v65 = VideoCommentsCmds.PostComment(v64, v57, v58)
                        if v63 == v20 then
                            v12 = false
                            if v65.Ok then
                                v8[v64] = true
                                TextInput.Text = ""
                                v18:Reset()
                                v16 -= 1
                                local Comment = v65.Comment
                                if v19[Comment.Id] == nil then
                                    v5[Comment.Id] = Comment
                                    v19[Comment.Id] = CommentRenderer.Create(Comment_01, Content, Comment, v16, v26.ToggleLike)
                                end
                                VideoCommentsCmds.ReconcileCommentCount(v64, v23 + 1)
                                local v66 = if next(v19) == nil then not v11 else false
                                Content.Visible = not v66
                                NoComments.Visible = v66
                                Content.CanvasPosition = Vector2.zero
                            else
                                if v65.Error == "AlreadyCommented" then
                                    v8[v64] = true
                                    Message.Top({
                                        Message = "You already commented this video.",
                                        Time = 3,
                                        ShowShadow = true,
                                        Color = Color3.new(1, 1, 1)
                                    })
                                elseif v65.Error == "MessageFiltered" then
                                    Message.Top({
                                        Message = "Your comment was filtered, please try another message!",
                                        Time = 3,
                                        ShowShadow = true,
                                        Color = Color3.new(1, 1, 1)
                                    })
                                elseif v65.Error == "InvalidImageAssetId" then
                                    Message.Top({
                                        Message = "Invalid image, please upload another image.",
                                        Time = 3,
                                        ShowShadow = true,
                                        Color = Color3.new(1, 1, 1)
                                    })
                                elseif v65.Error == "ImageAssetLookupFailed" then
                                    Message.Top({
                                        Message = "Something went wrong, please try again later.",
                                        Time = 3,
                                        ShowShadow = true,
                                        Color = Color3.new(1, 1, 1)
                                    })
                                else
                                    local Error = v65.Error
                                    if Error == "You're doing that too fast!" or Error == "You're on cooldown. Please try again later." then
                                        Message.Top({
                                            Message = "You're doing this too fast, please wait a bit.",
                                            Time = 3,
                                            ShowShadow = true,
                                            Color = Color3.new(1, 1, 1)
                                        })
                                    end
                                end
                                v4:AtTrace():Log((("Unable to post treadmill comment: %*"):format(v65.Error)))
                            end
                        end
                    end)
                end
            end
        end
    end
end

local function open() -- line 322 | captures: Content, v7, v10, v11, v13, v14, NoComments, v20, v21, CommentsTemplate, v25, TreadmillFlags, v19, clearRows, requestPage
    if v10 or v13 == "" or TreadmillFlags.CommentsDisabled:Get() then
        return
    end
    v25()
    v10 = true
    CommentsTemplate.Visible = true
    v21(false)
    clearRows()
    local v67 = if next(v19) == nil then not v11 else false
    Content.Visible = not v67
    NoComments.Visible = v67
    v20 += 1
    v14 = 0
    v7 = true
    v11 = false
    requestPage()
end

local function handleScroll() -- line 340 | captures: Content, v7, v10, requestPage
    if v10 and v7 and Content.AbsoluteCanvasSize.Y - Content.CanvasPosition.Y - Content.AbsoluteWindowSize.Y <= 64 then
        requestPage()
    end
end

local function handleMediaChanged(v68, v69) -- line 349 | captures: v6, v13, CommentsCount, CommentsTemplate, v23, Simple, TreadmillFlags, TreadmillMediaIdentity, VideoCommentsCmds, v26
    local v70 = TreadmillMediaIdentity.GetMediaKey(v68)
    v26.Close()
    v6.Adornee = v69
    v6.Enabled = not TreadmillFlags.CommentsDisabled:Get()
    v13 = v70
    local v71 = VideoCommentsCmds.GetCachedCommentCount(v70) or 0
    v23 = math.max(0, v71)
    CommentsCount.Text = Simple.FormatCompact(v23, ".#")
    local v72 = v23
    local v73
    if v72 == 1 then
        v73 = "1 comment"
    else
        v73 = ("%* comments"):format((Simple.FormatCompact(v72, ".#")))
    end
    CommentsTemplate.Sheet.Header.Content.SubContent.Title.Text = v73
end

function v26.ToggleLike(v74) -- line 366 | captures: v13, v20, v25, VideoCommentsCmds, v5, v17, v19
    if v17[v74] then
        return
    end
    local v75 = v5[v74]
    local v76 = v19[v74]
    local v77 = if v75 == nil then false else v76 ~= nil
    local v78 = ("Missing rendered comment %*"):format(v74)
    assert(v77, v78)
    v25()
    v17[v74] = true
    local LikedByViewer = v75.LikedByViewer
    local LikeCount = v75.LikeCount
    local v79 = not LikedByViewer
    v75.LikedByViewer = v79
    local v80 = if v79 then 1 else -1
    local v81 = LikeCount + v80
    v75.LikeCount = math.max(0, v81)
    v76.UpdateLike(v75.LikedByViewer, v75.LikeCount)
    local v82 = v20
    local v83 = v13
    task.spawn(function() -- line 390 | captures: v74, LikedByViewer, LikeCount, v79, v82, v83, v20, VideoCommentsCmds, v5, v17, v19
        local v84 = VideoCommentsCmds.SetCommentLike(v83, v74, v79)
        if v82 ~= v20 then
            return
        end
        v17[v74] = nil
        local v85 = v5[v74]
        local v86 = v19[v74]
        if v85 == nil or v86 == nil then
            return
        end
        if v84.Ok then
            v85.LikedByViewer = v84.Liked
            local LikeCount = v84.LikeCount
            v85.LikeCount = math.max(0, LikeCount)
        else
            v85.LikedByViewer = LikedByViewer
            v85.LikeCount = LikeCount
        end
        v86.UpdateLike(v85.LikedByViewer, v85.LikeCount)
    end)
end

function v26.Close() -- line 411 | captures: Content, v7, TextInput, v10, v11, v12, v14, NoComments, v18, v20, v21, CommentsTemplate, v19, clearRows
    v20 += 1
    v10 = false
    v11 = false
    v12 = false
    v7 = false
    v14 = nil
    CommentsTemplate.Visible = false
    v21(true)
    TextInput.Text = ""
    v18:Reset()
    clearRows()
    local v87 = if next(v19) == nil then not v11 else false
    Content.Visible = not v87
    NoComments.Visible = v87
end

function v26.IsAvailable() -- line 427 | captures: v24, TreadmillFlags
    if v24 == nil then
        return false
    end
    return not TreadmillFlags.CommentsDisabled:Get()
end

function v26.Toggle() -- line 431 | captures: Content, v7, v10, v11, v13, v14, NoComments, v20, v21, CommentsTemplate, v24, v25, TreadmillFlags, v19, v26, clearRows, requestPage
    if v24 ~= nil then
        if v10 then
            v25()
            v26.Close()
        else
            if v10 or v13 == "" or TreadmillFlags.CommentsDisabled:Get() then
                return
            end
            v25()
            v10 = true
            CommentsTemplate.Visible = true
            v21(false)
            clearRows()
            local v88 = if next(v19) == nil then not v11 else false
            Content.Visible = not v88
            NoComments.Visible = v88
            v20 += 1
            v14 = 0
            v7 = true
            v11 = false
            requestPage()
        end
    end
end

function v26.Deactivate() -- line 457 | captures: v6, v13, CommentsCount, CommentsTemplate, v23, Simple, v26
    v26.Close()
    v13 = ""
    v6.Enabled = false
    v23 = 0
    CommentsCount.Text = Simple.FormatCompact(v23, ".#")
    local v89 = v23
    local v90
    if v89 == 1 then
        v90 = "1 comment"
    else
        v90 = ("%* comments"):format((Simple.FormatCompact(v89, ".#")))
    end
    CommentsTemplate.Sheet.Header.Content.SubContent.Title.Text = v90
end

function v26.Start(v91) -- line 472 | captures: v6, Content, BackgroundColor3, TextInput, v11, v13, NoComments, v18, Comment_01, v21, CommentsCount, CommentsTemplate, v23, v24, v25, Players, TextChatService, ButtonFX, GUI, Media, PhotoInputController, Simple, TreadmillFlags, TreadmillMediaIdentity, Trove, VideoCommentsCmds, TryCall, v3, v19, v26, updateInputLimitPresentation, postComment, open, handleScroll, handleMediaChanged
    local v92 = v24 == nil
    assert(v92, "Treadmill comments controller must only start once")
    local CommentsButton = GUI.TreadmillScreenSideButtons().Frame.Buttons.CommentsButton
    local v93 = GUI.TreadmillScreenButtonShare()
    local SurfaceGui = v93:IsA("SurfaceGui")
    assert(SurfaceGui, "Treadmill share GUI must be a SurfaceGui")
    local ShareButton = v93.Frame.ShareButton
    local GuiButton = CommentsButton:IsA("GuiButton")
    assert(GuiButton, "Treadmill comments button must be a GuiButton")
    local GuiButton_2 = ShareButton:IsA("GuiButton")
    assert(GuiButton_2, "Treadmill share button must be a GuiButton")
    local v94, v95 = TryCall(TextChatService.CanUserChatAsync, TextChatService, Players.LocalPlayer.UserId)
    CommentsButton.Visible = v94 and v95 == true
    if CommentsButton.Visible then
        v21 = v91.SetShareButtonVisible
        v25 = v91.SuppressScreenTap
        v6 = GUI.TreadmillScreenComments()
        CommentsTemplate = v6.Frame.CommentsTemplate
        Content = CommentsTemplate.Sheet.Content
        Comment_01 = Content.Comment_01
        TextInput = CommentsTemplate.Sheet.Actions.Content.TextInputWrapper.TextInput
        local SurfaceGui = v6:IsA("SurfaceGui")
        assert(SurfaceGui, "Treadmill comments GUI must be a SurfaceGui")
        local ScrollingFrame = Content:IsA("ScrollingFrame")
        assert(ScrollingFrame, "Treadmill comments content must be a ScrollingFrame")
        local Frame = Comment_01:IsA("Frame")
        assert(Frame, "Treadmill comments row template must be a Frame")
        local TextLabel = CommentsButton.CommentsCount:IsA("TextLabel")
        assert(TextLabel, "Treadmill comments count must be a TextLabel")
        BackgroundColor3 = TextInput.BackgroundColor3
        NoComments = CommentsTemplate.Sheet.NoComments
        v18 = PhotoInputController.new(CommentsTemplate, v25)
        CommentsCount = CommentsButton.CommentsCount
        v24 = Trove.new()
        for v96, v97 in Content:GetChildren() do
            if v97:IsA("Frame") and v97.Name:match("^Comment_%d+$") then
                if v97.Name == "Comment_01" then
                    v97.Visible = false
                else
                    v97:Destroy()
                end
            end
        end
        Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
        v6.Enabled = false
        CommentsTemplate.Visible = false
        CommentsTemplate.Overlay.Active = true
        CommentsTemplate.AddPhoto.Visible = false
        local v98 = v24
        local v99 = v98 ~= nil
        assert(v99, "Treadmill comments trove must exist after startup")
        v98:Add(ButtonFX(CommentsButton, nil, open))
        v98:Add(ButtonFX(CommentsTemplate.Sheet.Header.Content.Close, nil, function() -- line 533 | captures: v25, v26
            v25()
            v26.Close()
        end))
        v98:Connect(CommentsTemplate.Overlay.InputBegan, function(v100) -- line 537 | captures: CommentsTemplate, v25, v26
            if v100.UserInputType == Enum.UserInputType.MouseButton1 then
                if v100.Position.Y < CommentsTemplate.Sheet.AbsolutePosition.Y then
                    v25()
                    v26.Close()
                end
            elseif v100.UserInputType == Enum.UserInputType.Touch and v100.Position.Y < CommentsTemplate.Sheet.AbsolutePosition.Y then
                v25()
                v26.Close()
            end
        end)
        v98:Add(ButtonFX(CommentsTemplate.Sheet.Actions.Content.Send, nil, postComment))
        v98:Connect(TextInput:GetPropertyChangedSignal("Text"), updateInputLimitPresentation)
        v98:Connect(Content:GetPropertyChangedSignal("CanvasPosition"), handleScroll)
        v98:Add(v91.MediaChanged:Connect(handleMediaChanged))
        v98:Add(v91.Stopped:Connect(v26.Deactivate))
        v98:Add(VideoCommentsCmds.CommentCountChanged:Connect(function(v101, v102) -- line 555 | captures: v13, CommentsCount, CommentsTemplate, v23, Simple
            if v101 ~= v13 then
                return
            end
            v23 = math.max(0, v102)
            CommentsCount.Text = Simple.FormatCompact(v23, ".#")
            local v103 = v23
            local v104
            if v103 == 1 then
                v104 = "1 comment"
            else
                v104 = ("%* comments"):format((Simple.FormatCompact(v103, ".#")))
            end
            CommentsTemplate.Sheet.Header.Content.SubContent.Title.Text = v104
        end))
        local Position = ShareButton.Position
        v98:Add(TreadmillFlags.CommentsDisabled.Changed:Connect(function() -- line 570 | captures: Position, CommentsButton, ShareButton, v6, v13, TreadmillFlags, v3, v26
            local v105 = TreadmillFlags.CommentsDisabled:Get()
            CommentsButton.Visible = not v105
            local v106 = if v105 then v3 else Position
            ShareButton.Position = v106
            if v105 then
                v26.Close()
                v6.Enabled = false
            elseif v13 ~= "" then
                v6.Enabled = true
            end
        end))
        local v107 = TreadmillFlags.CommentsDisabled:Get()
        CommentsButton.Visible = not v107
        local v108 = if v107 then v3 else Position
        ShareButton.Position = v108
        if v107 then
            v26.Close()
            v6.Enabled = false
        elseif v13 ~= "" then
            v6.Enabled = true
        end
        local v109 = TreadmillMediaIdentity.BuildMediaKeys(Media)
        VideoCommentsCmds.StartCommentCountCache(v109)
        v23 = 0
        CommentsCount.Text = Simple.FormatCompact(v23, ".#")
        local v110 = v23
        local v111
        if v110 == 1 then
            v111 = "1 comment"
        else
            v111 = ("%* comments"):format((Simple.FormatCompact(v110, ".#")))
        end
        CommentsTemplate.Sheet.Header.Content.SubContent.Title.Text = v111
        local v112 = if next(v19) == nil then not v11 else false
        Content.Visible = not v112
        NoComments.Visible = v112
    else
        ShareButton.Position = v3
    end
end

return v26
