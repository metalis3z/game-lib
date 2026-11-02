-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local DisplayName = require(ReplicatedStorage.Shared.Utils.PlayerUtils).DisplayName
local Thumbnail = require(ReplicatedStorage.Shared.Utils.PlayerUtils).Thumbnail
local Log = require(ReplicatedStorage.Packages.Log)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Trove = require(ReplicatedStorage.Packages.Trove)
require(script.Parent.Types.Interface)
require(ReplicatedStorage.Client.VideoCommentsCmds.Types.Interface)
local v1 = Color3.fromRGB(232, 68, 86)
local v2 = Color3.fromRGB(255, 255, 255)
local v3 = Log.new()
local v4 = {}

local function formatPostedAt(v5) -- line 21
    local v6 = os.time() - v5
    local v7 = math.max(0, v6)
    if v7 < 60 then
        return "just now"
    end
    if v7 < 3600 then
        local v8 = v7 / 60
        return (("%*m ago"):format((math.floor(v8))))
    end
    if v7 < 86400 then
        local v9 = v7 / 3600
        return (("%*h ago"):format((math.floor(v9))))
    end
    local v10 = v7 / 86400
    return (("%*d ago"):format((math.floor(v10))))
end

local function fitDisplayName(v11, v12) -- line 34 | captures: TextService
    v11.Text = v12
    v11.AutomaticSize = Enum.AutomaticSize.X
    v11.TextTruncate = Enum.TextTruncate.AtEnd
    local X = TextService:GetTextSize(v12, v11.TextSize, v11.Font, Vector2.new((1/0), v11.AbsoluteSize.Y)).X
    local v13 = math.ceil(X) + 2
    local v14 = math.min(v13, 140)
    v11.Size = UDim2.new(0, v14, v11.Size.Y.Scale, v11.Size.Y.Offset)
end

local function configureDynamicLayout(v15) -- line 42
    v15.AutomaticSize = Enum.AutomaticSize.Y
    v15.Size = UDim2.fromScale(1, 0)
    v15.Content.AutomaticSize = Enum.AutomaticSize.Y
    v15.Content.Size = UDim2.new(v15.Content.Size.X.Scale, v15.Content.Size.X.Offset, 0, 0)
    v15.Content.Comment.AutomaticSize = Enum.AutomaticSize.Y
    v15.Content.Comment.Size = UDim2.fromScale(1, 0)
    v15.Content.Comment.TextWrapped = true
end

local function configureOwnerPresentation(v16, v17, v18) -- line 51 | captures: v2
    local DisplayName = v16.Content.User.DisplayName
    v16.Content.User.OwnerTag.Visible = v17
    DisplayName.OwnerGradient.Enabled = v17
    DisplayName.OwnerStroke.Enabled = v17
    if v17 then
        DisplayName.TextColor3 = v2
    else
        DisplayName.TextColor3 = v18
    end
end

local function loadUserPresentation(v19, v20) -- line 64 | captures: Constants, DisplayName, Thumbnail, v3, fitDisplayName
    fitDisplayName(v19.Content.User.DisplayName, "Loading...")
    task.spawn(function() -- line 66 | captures: v19, v20, Constants, DisplayName, v3, fitDisplayName
        local v21, v22 = pcall(DisplayName, v20)
        if v19.Parent ~= nil then
            if v21 then
                if v20 == Constants.OWNER_ID then
                    v22 = ("%*"):format(v22)
                end
                fitDisplayName(v19.Content.User.DisplayName, v22)
            else
                v3:AtTrace():Log((("Failed to resolve comment display name for user %*"):format(v20)))
            end
        end
    end)
    task.spawn(function() -- line 83 | captures: v19, v20, Thumbnail, v3
        local v23, v24 = pcall(Thumbnail, v20, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
        if v19.Parent ~= nil then
            if v23 then
                if v24 == nil then
                    v3:AtTrace():Log((("Failed to resolve comment avatar for user %*"):format(v20)))
                else
                    v19.Avatar.Image = v24
                end
            else
                v3:AtTrace():Log((("Failed to resolve comment avatar for user %*"):format(v20)))
            end
        end
    end)
end

function v4.Create(v25, v26, v27, v28, v29) -- line 100 | captures: ButtonFX, Constants, Simple, Trove, v1, v2, formatPostedAt, configureDynamicLayout, loadUserPresentation
    local v30 = v25:Clone()
    v30.Name = ("Comment_%*"):format(v27.Id)
    v30.LayoutOrder = v28
    v30.Visible = true
    v30.Parent = v26
    local Content = v30.Content
    local PostedAt = Content.Actions.Left.PostedAt
    local Like = Content.Actions.Right.Like
    local Icon = Like.Icon
    local TextColor3 = Icon.TextColor3
    local FontFace = Icon.FontFace
    local v31 = Trove.new()
    PostedAt.LayoutOrder = Content.User.DisplayName.LayoutOrder + 1
    Content.Comment.Text = v27.Message
    PostedAt.Text = formatPostedAt(v27.CreatedAt)
    configureDynamicLayout(v30)
    local v32 = v27.UserId == Constants.OWNER_ID
    local DisplayName = v30.Content.User.DisplayName
    v30.Content.User.OwnerTag.Visible = v32
    DisplayName.OwnerGradient.Enabled = v32
    DisplayName.OwnerStroke.Enabled = v32
    if v32 then
        DisplayName.TextColor3 = v2
    else
        DisplayName.TextColor3 = Content.User.DisplayName.TextColor3
    end
    if v27.ImageAssetId == nil then
        Content.Photo.Visible = false
    else
        Content.Photo.Visible = true
        Content.Photo.Container.Image.Image = ("rbxassetid://%*"):format(v27.ImageAssetId)
        Content.Photo.Container.Image.ScaleType = Enum.ScaleType.Crop
    end
    local LikedByViewer = v27.LikedByViewer
    local v33 = if LikedByViewer then v1 else TextColor3
    Icon.TextColor3 = v33
    local v34
    if LikedByViewer then
        v34 = Font.new(FontFace.Family, Enum.FontWeight.Bold, FontFace.Style)
    else
        v34 = FontFace
    end
    Icon.FontFace = v34
    local Label = Like.Label
    local LikeCount = v27.LikeCount
    local v35 = math.max(0, LikeCount)
    Label.Text = Simple.FormatCompact(v35, ".#")
    loadUserPresentation(v30, v27.UserId)
    v31:Add(ButtonFX(Like, nil, function() -- line 153 | captures: v27, v29
        v29(v27.Id)
    end))
    v31:Add(v30)
    local v36 = { Row = v30 }

    function v36.UpdateLike(v37, v38) -- line 159 | captures: Like, Icon, TextColor3, FontFace, Simple, v1
        local v39 = if v37 then v1 else TextColor3
        Icon.TextColor3 = v39
        local v40
        if v37 then
            v40 = Font.new(FontFace.Family, Enum.FontWeight.Bold, FontFace.Style)
        else
            v40 = FontFace
        end
        Icon.FontFace = v40
        local v41 = math.max(0, v38)
        Like.Label.Text = Simple.FormatCompact(v41, ".#")
    end

    function v36.Destroy() -- line 176 | captures: v31
        v31:Destroy()
    end

    return v36
end

return v4
