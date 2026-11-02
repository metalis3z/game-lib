-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local GetDisplayNameFromUserIdAsync = require(ReplicatedStorage.Library.Functions.GetDisplayNameFromUserIdAsync)
local GetThumbnailFromUserIdAsync = require(ReplicatedStorage.Library.Functions.GetThumbnailFromUserIdAsync)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Network = require(ReplicatedStorage.Library.Client.Network)
local TreadmillMediaIdentity = require(ReplicatedStorage.Library.Modules.TreadmillMediaIdentity)
local Schema = require(ReplicatedStorage.Library.Types.TreadmillMediaLike.Types.Schema)

require(ReplicatedStorage.Library.Types.TreadmillMediaLike.Types.Interface)

local wcall = require(ReplicatedStorage.Library.Functions.wcall)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)

require(script.Parent.Types.Interface)

local t = {}

t.__index = t
t.__class = "FriendLikesController"

local Treadmills = Constants.NETWORK_MAP.Treadmills
local v1 = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v2 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local v3 = TweenInfo.new(2.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local v4 = Vector2.new(0.13, 0.13)
local v5 = Log.new()
local v6 = GUI.TreadmillScreenFriendLikes()

assert(v6:IsA("SurfaceGui"), "Treadmill friend-like GUI must be a SurfaceGui")

local Frame = v6.Frame
local Main = Frame.Main
local Template = Main.Template

assert(Template:IsA("Frame"), "Treadmill friend-like template must be a Frame")
assert(Template.Button:IsA("ImageButton"), "Treadmill friend-like template button must be an ImageButton")

local Profile = Frame.Profile

assert(Profile:IsA("Frame"), "Treadmill friend-like profile must be a Frame")

local Position = Profile.Position
local PlayerIcon = Profile.Main.Icon.PlayerIcon

assert(PlayerIcon:IsA("ImageLabel"), "Treadmill friend-like profile icon must be an ImageLabel")

local TextLabel = Profile.Main.TextLabel

assert(TextLabel:IsA("TextLabel"), "Treadmill friend-like profile label must be a TextLabel")
function t.new(p1, p2, p3, p4, p5) --[[ new | Line: 90 | Upvalues: Asserts (copy), t (copy), Profile (copy), PlayerIcon (copy), TextLabel (copy), Position (copy), Main (copy), Trove (copy), Template (copy), v6 (copy) ]]
	Asserts.func(p1)
	Asserts.func(p2)
	Asserts.table(p3)
	Asserts.table(p4)
	Asserts.BasePart(p5)

	local v2 = setmetatable({}, t)

	v2._destroyed = false
	v2._friendLikeUserIdsByMediaLikeKey = {}
	v2._getActiveVideoIndex = p1
	v2._interactionCallback = p2
	v2._mediaEntries = p3
	v2._profile = Profile
	v2._profilePlayerIcon = PlayerIcon
	v2._profileTextLabel = TextLabel
	v2._profileTween = nil
	v2._profileVisiblePosition = Position
	v2._rowsContainer = Main
	v2._rowsTrove = Trove.new()
	v2._rowTemplate = Template
	v2._screenTapSuppressUntil = 0
	v2._snapshotRequestSerial = 0
	v2._surfaceGui = v6
	v2._trove = p4:Extend()
	v2:_init(p5)

	return v2
end

local function escapeRichText(p1) --[[ escapeRichText | Line: 129 ]]
	return p1:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;"):gsub("\'", "&apos;")
end

local function getRandomFloatPosition(p1) --[[ getRandomFloatPosition | Line: 133 | Upvalues: v4 (copy) ]]
	return UDim2.fromScale(0.5 + p1:NextNumber(-v4.X, v4.X), 0.5 + p1:NextNumber(-v4.Y, v4.Y))
end

local function startButtonFloat(p1, p2) --[[ startButtonFloat | Line: 140 | Upvalues: TweenService (copy), v3 (copy), v4 (copy) ]]
	local v1 = Random.new()
	local v2 = nil
	local v32 = false

	p1.AnchorPoint = Vector2.new(0.5, 0.5)
	p1.Position = UDim2.fromScale(0.5, 0.5)

	local function v42() --[[ playNext | Line: 148 | Upvalues: v32 (ref), p1 (copy), TweenService (ref), v3 (ref), v1 (copy), v4 (ref), v2 (ref), v42 (copy) ]]
		if not v32 and p1.Parent ~= nil then
			local t = {}
			local v43 = v1

			t.Position = UDim2.fromScale(0.5 + v43:NextNumber(-v4.X, v4.X), 0.5 + v43:NextNumber(-v4.Y, v4.Y))

			local v5 = TweenService:Create(p1, v3, t)

			v2 = v5
			v5.Completed:Once(function() --[[ Line: 157 | Upvalues: v2 (ref), v5 (copy), v42 (ref) ]]
				if v2 == v5 then
					v2 = nil
					v42()
				end
			end)
			v5:Play()
		end
	end

	p2:Add(function() --[[ Line: 168 | Upvalues: v32 (ref), v2 (ref) ]]
		v32 = true

		if v2 == nil then
			return
		end

		v2:Cancel()
		v2 = nil
	end)
	v42()
end

function t._isAlive(p1) --[[ _isAlive | Line: 178 ]]
	return not p1._destroyed
end
function t._getMediaKey(p1) --[[ _getMediaKey | Line: 182 | Upvalues: TreadmillMediaIdentity (copy) ]]
	local v1 = p1._getActiveVideoIndex()
	local v2 = p1._mediaEntries[v1]

	assert(v2 ~= nil, (("Missing treadmill media entry for index %*"):format(v1)))

	return TreadmillMediaIdentity.GetMediaKey(v2)
end
function t._getProfileHiddenPosition(p1) --[[ _getProfileHiddenPosition | Line: 189 ]]
	local _profileVisiblePosition = p1._profileVisiblePosition

	return UDim2.new(_profileVisiblePosition.X.Scale, _profileVisiblePosition.X.Offset, 2, _profileVisiblePosition.Y.Offset)
end
function t._cancelProfileTween(p1) --[[ _cancelProfileTween | Line: 199 ]]
	local _profileTween = p1._profileTween

	p1._profileTween = nil

	if _profileTween == nil then
		return
	end

	_profileTween:Cancel()
end
function t._hideProfileImmediate(p1) --[[ _hideProfileImmediate | Line: 207 ]]
	p1:_cancelProfileTween()
	p1._profile.Visible = false
	p1._profile.Position = p1:_getProfileHiddenPosition()
end
function t._clearRows(p1) --[[ _clearRows | Line: 213 | Upvalues: Trove (copy) ]]
	p1._rowsTrove:Destroy()
	p1._rowsTrove = Trove.new()
end
function t._getRequestedMediaKeys(p1) --[[ _getRequestedMediaKeys | Line: 218 | Upvalues: TreadmillMediaIdentity (copy) ]]
	local v1 = p1._getActiveVideoIndex()
	local t = {}
	local t2 = {}

	for i, v in ipairs({ v1, v1 + 1, v1 - 1 }) do
		local v2 = p1._mediaEntries[v]

		if v2 ~= nil then
			local v3 = TreadmillMediaIdentity.GetMediaKey(v2)

			if not t[v3] then
				t[v3] = true
				table.insert(t2, v3)
			end
		end
	end

	return t2
end
function t._requestFriendLikeSnapshot(p1, p2) --[[ _requestFriendLikeSnapshot | Line: 245 | Upvalues: wcall (copy), Network (copy), Treadmills (copy), v5 (copy), Schema (copy) ]]
	local v1, v2 = wcall(function() --[[ Line: 249 | Upvalues: Network (ref), Treadmills (ref), p1 (copy) ]]
		return Network.Invoke(Treadmills.REQUEST_FRIEND_LIKE_SNAPSHOT, {
			MediaKeys = p1:_getRequestedMediaKeys()
		})
	end)

	if not v1 then
		v5:AtError():Log((("Failed to load treadmill friend-like snapshot: %*"):format(v2)))

		return
	end

	if not Schema.FriendLikeSnapshot(v2) then
		v5:AtError():Log("Invalid treadmill friend-like snapshot payload")

		return
	end

	if p1:_isAlive() and p2 == p1._snapshotRequestSerial then
		p1._friendLikeUserIdsByMediaLikeKey = table.clone(v2.FriendLikeUserIdsByMediaLikeKey)
		p1:UpdatePresentation()
	end
end
function t._requestFriendLikeSnapshotAsync(p1) --[[ _requestFriendLikeSnapshotAsync | Line: 274 ]]
	p1._snapshotRequestSerial = p1._snapshotRequestSerial + 1

	local _snapshotRequestSerial = p1._snapshotRequestSerial

	task.spawn(function() --[[ Line: 277 | Upvalues: p1 (copy), _snapshotRequestSerial (copy) ]]
		if p1:_isAlive() then
			p1:_requestFriendLikeSnapshot(_snapshotRequestSerial)
		end
	end)
end
function t._resolveDisplayName(p1, p2) --[[ _resolveDisplayName | Line: 286 | Upvalues: Players (copy), GetDisplayNameFromUserIdAsync (copy) ]]
	local v1 = Players:GetPlayerByUserId(p2)

	if v1 == nil then
		return GetDisplayNameFromUserIdAsync(p2)
	end

	return v1.DisplayName
end
function t._showProfilePreview(p1, p2, p3) --[[ _showProfilePreview | Line: 295 | Upvalues: Constants (copy), escapeRichText (copy), GetThumbnailFromUserIdAsync (copy), TweenService (copy), v1 (copy) ]]
	p1:_cancelProfileTween()

	local v12 = p1:_resolveDisplayName(p2)

	if not p1:_isAlive() then
		return
	end

	p1._profilePlayerIcon.Image = p3
	p1._profileTextLabel.RichText = true

	local v2 = if p2 == Constants.OWNER_ID then " (OWNER)" else ""

	p1._profileTextLabel.Text = ("<b>%*%*</b> liked this video"):format(escapeRichText(v12), v2)
	p1._profile.Position = p1:_getProfileHiddenPosition()
	p1._profile.Visible = true

	if p3 == "" then
		task.spawn(function() --[[ Line: 315 | Upvalues: GetThumbnailFromUserIdAsync (ref), p2 (copy), p1 (copy) ]]
			local v1 = GetThumbnailFromUserIdAsync(p2, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
			local v2 = if v1 == nil then "" else v1

			if p1:_isAlive() and p1._profile.Visible then
				p1._profilePlayerIcon.Image = v2
			end
		end)
	end

	local v3 = TweenService:Create(p1._profile, v1, {
		Position = p1._profileVisiblePosition
	})

	p1._profileTween = v3
	v3.Completed:Once(function() --[[ Line: 332 | Upvalues: p1 (copy), v3 (copy) ]]
		if p1._profileTween == v3 then
			p1._profileTween = nil
		end
	end)
	v3:Play()
end
function t._startRefreshLoop(p1) --[[ _startRefreshLoop | Line: 342 ]]
	task.spawn(function() --[[ Line: 343 | Upvalues: p1 (copy) ]]
		while p1:_isAlive() do
			task.wait(180)

			if not p1:_isAlive() then
				break
			end

			p1:_requestFriendLikeSnapshotAsync()
		end
	end)
end
function t._init(p1, p2) --[[ _init | Line: 355 ]]
	p1._surfaceGui.Adornee = p2
	p1._surfaceGui.Enabled = true
	p1._rowTemplate.Visible = false
	p1._profileTextLabel.RichText = true
	p1:_hideProfileImmediate()
	p1:UpdatePresentation()
	p1:_requestFriendLikeSnapshotAsync()
	p1:_startRefreshLoop()
end
function t.UpdatePresentation(p1) --[[ UpdatePresentation | Line: 370 | Upvalues: startButtonFloat (copy), ButtonFX (copy), GetThumbnailFromUserIdAsync (copy) ]]
	if not p1:_isAlive() then
		return
	end

	p1:_clearRows()

	local v2 = p1._friendLikeUserIdsByMediaLikeKey[p1:_getMediaKey()]

	if v2 == nil or #v2 == 0 then
		return
	end

	for i, v in ipairs(v2) do
		local v3 = p1._rowTemplate:Clone()
		local Button = v3.Button

		v3.Name = ("FriendLike_%*"):format(v)
		v3.Visible = true
		v3.LayoutOrder = i
		Button.PlayerIcon.Image = ""
		v3.Parent = p1._rowsContainer

		local v4 = p1._rowsTrove:Extend()

		startButtonFloat(Button, v4)
		v4:Add(ButtonFX(Button, nil, function() --[[ Line: 395 | Upvalues: p1 (copy), v (copy), Button (copy) ]]
			p1:SuppressScreenTap()
			p1._interactionCallback()
			p1:_showProfilePreview(v, Button.PlayerIcon.Image)
		end))
		v4:Add(v3)
		task.spawn(function() --[[ Line: 402 | Upvalues: GetThumbnailFromUserIdAsync (ref), v (copy), p1 (copy), v3 (copy), Button (copy) ]]
			local v1 = GetThumbnailFromUserIdAsync(v, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
			local v2 = if v1 == nil then "" else v1

			if p1:_isAlive() and v3.Parent ~= nil then
				Button.PlayerIcon.Image = v2
			end
		end)
	end
end
function t.HandleScreenTap(p1) --[[ HandleScreenTap | Line: 416 ]]
	if p1:_isAlive() and not (os.clock() < p1._screenTapSuppressUntil) then
		p1:HideProfilePreview()
	end
end
function t.SuppressScreenTap(p1) --[[ SuppressScreenTap | Line: 424 ]]
	p1._screenTapSuppressUntil = os.clock() + 0.12
end
function t.HandleMediaChanged(p1) --[[ HandleMediaChanged | Line: 428 ]]
	if p1:_isAlive() then
		p1:HideProfilePreview()
		p1:UpdatePresentation()
		p1:_requestFriendLikeSnapshotAsync()
	end
end
function t.HideProfilePreview(p1) --[[ HideProfilePreview | Line: 438 | Upvalues: TweenService (copy), v2 (copy) ]]
	if not p1:_isAlive() then
		return
	end

	p1:_cancelProfileTween()

	if p1._profile.Visible then
		local v1 = TweenService:Create(p1._profile, v2, {
			Position = p1:_getProfileHiddenPosition()
		})

		p1._profileTween = v1
		v1.Completed:Once(function() --[[ Line: 453 | Upvalues: p1 (copy), v1 (copy) ]]
			if p1._profileTween == v1 then
				p1._profileTween = nil
				p1._profile.Visible = false
			end
		end)
		v1:Play()
	else
		p1._profile.Position = p1:_getProfileHiddenPosition()
	end
end
function t.Destroy(p1) --[[ Destroy | Line: 464 ]]
	if not p1._destroyed then
		p1._destroyed = true
		p1:_clearRows()
		p1:_hideProfileImmediate()
		p1._surfaceGui.Enabled = false
		p1._trove:Destroy()
	end
end

return t