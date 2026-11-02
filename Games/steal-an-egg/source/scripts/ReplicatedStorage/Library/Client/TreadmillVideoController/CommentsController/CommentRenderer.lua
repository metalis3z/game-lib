-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local GetDisplayNameFromUserIdAsync = require(ReplicatedStorage.Library.Functions.GetDisplayNameFromUserIdAsync)
local GetThumbnailFromUserIdAsync = require(ReplicatedStorage.Library.Functions.GetThumbnailFromUserIdAsync)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)

require(script.Parent.Types.Interface)
require(ReplicatedStorage.Library.Client.VideoCommentsCmds.Types.Interface)

local v1 = Color3.fromRGB(232, 68, 86)
local v2 = Color3.fromRGB(255, 255, 255)
local v3 = Log.new()
local t = {}

local function formatPostedAt(p1) --[[ formatPostedAt | Line: 38 ]]
	local v2 = math.max(0, os.time() - p1)

	if v2 < 60 then
		return "just now"
	end

	if v2 < 3600 then
		return ("%*m ago"):format((math.floor(v2 / 60)))
	end

	if v2 < 86400 then
		return ("%*h ago"):format((math.floor(v2 / 3600)))
	end

	return ("%*d ago"):format((math.floor(v2 / 86400)))
end

local function fitDisplayName(p1, p2) --[[ fitDisplayName | Line: 55 | Upvalues: TextService (copy) ]]
	p1.Text = p2
	p1.AutomaticSize = Enum.AutomaticSize.X
	p1.TextTruncate = Enum.TextTruncate.AtEnd

	local X = TextService:GetTextSize(p2, p1.TextSize, p1.Font, Vector2.new((1 / 0), p1.AbsoluteSize.Y)).X

	p1.Size = UDim2.new(0, math.min(math.ceil(X) + 2, 140), p1.Size.Y.Scale, p1.Size.Y.Offset)
end

local function configureDynamicLayout(p1) --[[ configureDynamicLayout | Line: 70 ]]
	p1.AutomaticSize = Enum.AutomaticSize.Y
	p1.Size = UDim2.fromScale(1, 0)
	p1.Content.AutomaticSize = Enum.AutomaticSize.Y
	p1.Content.Size = UDim2.new(p1.Content.Size.X.Scale, p1.Content.Size.X.Offset, 0, 0)
	p1.Content.Comment.AutomaticSize = Enum.AutomaticSize.Y
	p1.Content.Comment.Size = UDim2.fromScale(1, 0)
	p1.Content.Comment.TextWrapped = true
end

local function configureOwnerPresentation(p1, p2, p3) --[[ configureOwnerPresentation | Line: 80 | Upvalues: v2 (copy) ]]
	local DisplayName = p1.Content.User.DisplayName

	p1.Content.User.OwnerTag.Visible = p2
	DisplayName.OwnerGradient.Enabled = p2
	DisplayName.OwnerStroke.Enabled = p2
	DisplayName.TextColor3 = if p2 then v2 else p3
end

local function loadUserPresentation(p1, p2) --[[ loadUserPresentation | Line: 92 | Upvalues: fitDisplayName (copy), GetDisplayNameFromUserIdAsync (copy), Constants (copy), v3 (copy), GetThumbnailFromUserIdAsync (copy) ]]
	fitDisplayName(p1.Content.User.DisplayName, "Loading...")
	task.spawn(function() --[[ Line: 94 | Upvalues: GetDisplayNameFromUserIdAsync (ref), p2 (copy), p1 (copy), Constants (ref), fitDisplayName (ref), v3 (ref) ]]
		local ok, result = pcall(GetDisplayNameFromUserIdAsync, p2)

		if p1.Parent == nil then
			return
		end

		if not ok then
			v3:AtTrace():Log((("Failed to resolve comment display name for user %*"):format(p2)))

			return
		end

		fitDisplayName(p1.Content.User.DisplayName, if p2 == Constants.OWNER_ID then ("%*"):format(result) else result)
	end)
	task.spawn(function() --[[ Line: 108 | Upvalues: GetThumbnailFromUserIdAsync (ref), p2 (copy), p1 (copy), v3 (ref) ]]
		local ok, result = pcall(GetThumbnailFromUserIdAsync, p2, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)

		if p1.Parent == nil then
			return
		end

		if ok and result ~= nil then
			p1.Avatar.Image = result
		else
			v3:AtTrace():Log((("Failed to resolve comment avatar for user %*"):format(p2)))
		end
	end)
end

function t.Create(p1, p2, p3, p4, p5) --[[ Create | Line: 127 | Upvalues: Trove (copy), formatPostedAt (copy), configureDynamicLayout (copy), Constants (copy), v2 (copy), v1 (copy), Simple (copy), loadUserPresentation (copy), ButtonFX (copy) ]]
	local v12 = p1:Clone()

	v12.Name = ("Comment_%*"):format(p3.Id)
	v12.LayoutOrder = p4
	v12.Visible = true
	v12.Parent = p2

	local v22 = v12.Content
	local PostedAt = v22.Actions.Left.PostedAt
	local Like = v22.Actions.Right.Like
	local Icon = Like.Icon
	local TextColor3 = Icon.TextColor3
	local FontFace = Icon.FontFace
	local v3 = Trove.new()

	PostedAt.LayoutOrder = v22.User.DisplayName.LayoutOrder + 1
	v22.Comment.Text = p3.Message
	PostedAt.Text = formatPostedAt(p3.CreatedAt)
	configureDynamicLayout(v12)

	local v4 = if p3.UserId == Constants.OWNER_ID then true else false
	local DisplayName = v12.Content.User.DisplayName

	v12.Content.User.OwnerTag.Visible = v4
	DisplayName.OwnerGradient.Enabled = v4
	DisplayName.OwnerStroke.Enabled = v4
	DisplayName.TextColor3 = if v4 then v2 else v22.User.DisplayName.TextColor3

	if p3.ImageAssetId == nil then
		v22.Photo.Visible = false
	else
		v22.Photo.Visible = true
		v22.Photo.Container.Image.Image = ("rbxassetid://%*"):format(p3.ImageAssetId)
		v22.Photo.Container.Image.ScaleType = Enum.ScaleType.Crop
	end

	local function updateLike(p1, p2) --[[ updateLike | Line: 163 | Upvalues: Icon (copy), v1 (ref), TextColor3 (copy), FontFace (copy), Like (copy), Simple (ref) ]]
		Icon.TextColor3 = if p1 then v1 else TextColor3
		Icon.FontFace = if p1 then Font.new(FontFace.Family, Enum.FontWeight.Bold, FontFace.Style) else FontFace
		Like.Label.Text = Simple.FormatCompact(math.max(0, p2), ".#")
	end

	local LikedByViewer = p3.LikedByViewer

	Icon.TextColor3 = if LikedByViewer then v1 else TextColor3
	Icon.FontFace = if LikedByViewer then Font.new(FontFace.Family, Enum.FontWeight.Bold, FontFace.Style) else FontFace
	Like.Label.Text = Simple.FormatCompact(math.max(0, p3.LikeCount), ".#")
	loadUserPresentation(v12, p3.UserId)
	v3:Add(ButtonFX(Like, nil, function() --[[ Line: 173 | Upvalues: p5 (copy), p3 (copy) ]]
		p5(p3.Id)
	end))
	v3:Add(v12)

	return {
		Row = v12,
		UpdateLike = updateLike,
		Destroy = function() --[[ Destroy | Line: 181 | Upvalues: v3 (copy) ]]
			v3:Destroy()
		end
	}
end

return t