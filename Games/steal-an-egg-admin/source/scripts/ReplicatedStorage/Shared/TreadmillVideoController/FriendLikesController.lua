-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local GUI = require(ReplicatedStorage.Client.GUI)
local DisplayName = require(ReplicatedStorage.Shared.Utils.PlayerUtils).DisplayName
local Thumbnail = require(ReplicatedStorage.Shared.Utils.PlayerUtils).Thumbnail
local Log = require(ReplicatedStorage.Packages.Log)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local TreadmillMediaIdentity = require(ReplicatedStorage.Shared.Modules.TreadmillMediaIdentity)
local Schema = require(ReplicatedStorage.Shared.Types.TreadmillMediaLike.Types.Schema)
require(ReplicatedStorage.Shared.Types.TreadmillMediaLike.Types.Interface)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
require(script.Parent.Types.Interface)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local v1 = {}

v1.__index = v1
v1.__class = "FriendLikesController"

local v2 = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v3 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local v4 = TweenInfo.new(2.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local v5 = Vector2.new(0.13, 0.13)
local v6 = Log.new()
local v7 = GUI.TreadmillScreenFriendLikes()
local SurfaceGui = v7:IsA("SurfaceGui")
assert(SurfaceGui, "Treadmill friend-like GUI must be a SurfaceGui")
local Frame = v7.Frame
local Main = Frame.Main
local Template = Main.Template
local Frame_2 = Template:IsA("Frame")
assert(Frame_2, "Treadmill friend-like template must be a Frame")
local ImageButton = Template.Button:IsA("ImageButton")
assert(ImageButton, "Treadmill friend-like template button must be an ImageButton")
local Profile = Frame.Profile
local Frame_3 = Profile:IsA("Frame")
assert(Frame_3, "Treadmill friend-like profile must be a Frame")
local Position = Profile.Position
local PlayerIcon = Profile.Main.Icon.PlayerIcon
local ImageLabel = PlayerIcon:IsA("ImageLabel")
assert(ImageLabel, "Treadmill friend-like profile icon must be an ImageLabel")
local TextLabel = Profile.Main.TextLabel
local TextLabel_2 = TextLabel:IsA("TextLabel")
assert(TextLabel_2, "Treadmill friend-like profile label must be a TextLabel")

function v1.new(v8, v9, v10, v11, v12) -- line 51 | captures: Trove, t, v1, v7, Main, Template, Profile, Position, PlayerIcon, TextLabel
    t.strict(t.callback)(v8)
    t.strict(t.callback)(v9)
    t.strict(t.table)(v10)
    t.strict(t.table)(v11)
    t.strict(t.instanceIsA("BasePart"))(v12)
    local v13 = {}
    local v14 = setmetatable(v13, v1)
    v14._destroyed = false
    v14._friendLikeUserIdsByMediaLikeKey = {}
    v14._getActiveVideoIndex = v8
    v14._interactionCallback = v9
    v14._mediaEntries = v10
    v14._profile = Profile
    v14._profilePlayerIcon = PlayerIcon
    v14._profileTextLabel = TextLabel
    v14._profileTween = nil
    v14._profileVisiblePosition = Position
    v14._rowsContainer = Main
    v14._rowsTrove = Trove.new()
    v14._rowTemplate = Template
    v14._screenTapSuppressUntil = 0
    v14._snapshotRequestSerial = 0
    v14._surfaceGui = v7
    v14._trove = v11:Extend()
    v14:_init(v12)
    return v14
end

local function escapeRichText(v15) -- line 83
    return v15:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;"):gsub("'", "&apos;")
end

local function getRandomFloatPosition(v16) -- line 90 | captures: v5
    local v17 = 0.5 + v16:NextNumber(-v5.X, v5.X)
    return UDim2.fromScale(v17, 0.5 + v16:NextNumber(-v5.Y, v5.Y))
end

local function startButtonFloat(v18, v19) -- line 94 | captures: TweenService, v4, v5
    local v20 = Random.new()
    local v21
    local v22 = false
    v18.AnchorPoint = Vector2.new(0.5, 0.5)
    v18.Position = UDim2.fromScale(0.5, 0.5)
    local v23

    function v23() -- line 101 | captures: v23, v21, v22, v18, v20, TweenService, v4, v5
        if v22 or v18.Parent == nil then
            return
        end
        local v24 = {}
        local v25 = 0.5 + v20:NextNumber(-v5.X, v5.X)
        v24.Position = UDim2.fromScale(v25, 0.5 + v20:NextNumber(-v5.Y, v5.Y))
        local v26 = TweenService:Create(v18, v4, v24)
        v21 = v26
        v26.Completed:Once(function() -- line 111 | captures: v26, v23, v21
            if v21 == v26 then
                v21 = nil
                v23()
            end
        end)
        v26:Play()
    end

    v19:Add(function() -- line 120 | captures: v21, v22
        v22 = true
        if v21 ~= nil then
            v21:Cancel()
            v21 = nil
        end
    end)
    v23()
end

local function _isAlive(v27) -- line 129
    return not v27._destroyed
end

v1._isAlive = _isAlive

function v1._getMediaKey(v28) -- line 132 | captures: TreadmillMediaIdentity
    local v29 = v28._getActiveVideoIndex()
    local v30 = v28._mediaEntries[v29]
    local v31 = v30 ~= nil
    local v32 = ("Missing treadmill media entry for index %*"):format(v29)
    assert(v31, v32)
    return TreadmillMediaIdentity.GetMediaKey(v30)
end

local function _getProfileHiddenPosition(v33) -- line 139
    local _profileVisiblePosition = v33._profileVisiblePosition
    return UDim2.new(_profileVisiblePosition.X.Scale, _profileVisiblePosition.X.Offset, 2, _profileVisiblePosition.Y.Offset)
end

v1._getProfileHiddenPosition = _getProfileHiddenPosition

local function _cancelProfileTween(v34) -- line 143
    local _profileTween = v34._profileTween
    v34._profileTween = nil
    if _profileTween ~= nil then
        _profileTween:Cancel()
    end
end

v1._cancelProfileTween = _cancelProfileTween

local function _hideProfileImmediate(v35) -- line 150
    v35:_cancelProfileTween()
    v35._profile.Visible = false
    v35._profile.Position = v35:_getProfileHiddenPosition()
end

v1._hideProfileImmediate = _hideProfileImmediate

function v1._clearRows(v36) -- line 156 | captures: Trove
    v36._rowsTrove:Destroy()
    v36._rowsTrove = Trove.new()
end

function v1._getRequestedMediaKeys(v37) -- line 160 | captures: TreadmillMediaIdentity
    local v38 = {}
    local v39 = {}
    local v40 = v37._getActiveVideoIndex()
    local v41 = {
        v40,
        v40 + 1,
        v40 - 1
    }
    for v42, v43 in ipairs(v41) do
        local v44 = v37._mediaEntries[v43]
        if v44 ~= nil then
            local v45 = TreadmillMediaIdentity.GetMediaKey(v44)
            if not v39[v45] then
                v39[v45] = true
                table.insert(v38, v45)
            end
        end
    end
    return v38
end

function v1._requestFriendLikeSnapshot(v46, v47) -- line 178 | captures: Remotes, Schema, TryCall, v6
    local v48, v49 = TryCall(function() -- line 180 | captures: v46, Remotes
        return Remotes.Treadmill.AskFriendFavourSnapshot:InvokeServer({ MediaKeys = v46:_getRequestedMediaKeys() })
    end)
    if v48 then
        if Schema.FriendLikeSnapshot(v49) then
            if v46:_isAlive() and v47 == v46._snapshotRequestSerial then
                v46._friendLikeUserIdsByMediaLikeKey = table.clone(v49.FriendLikeUserIdsByMediaLikeKey)
                v46:UpdatePresentation()
            end
        else
            v6:AtError():Log("Invalid treadmill friend-like snapshot payload")
        end
    else
        v6:AtError():Log((("Failed to load treadmill friend-like snapshot: %*"):format(v49)))
    end
end

local function _requestFriendLikeSnapshotAsync(v50) -- line 197
    v50._snapshotRequestSerial += 1
    local _snapshotRequestSerial = v50._snapshotRequestSerial
    task.spawn(function() -- line 200 | captures: v50, _snapshotRequestSerial
        if v50:_isAlive() then
            v50:_requestFriendLikeSnapshot(_snapshotRequestSerial)
        end
    end)
end

v1._requestFriendLikeSnapshotAsync = _requestFriendLikeSnapshotAsync

function v1._resolveDisplayName(v51, v52) -- line 207 | captures: Players, DisplayName
    local v53 = Players:GetPlayerByUserId(v52)
    if v53 == nil then
        return DisplayName(v52)
    end
    return v53.DisplayName
end

function v1._showProfilePreview(v54, v55, v56) -- line 214 | captures: TweenService, Constants, Thumbnail, v2, escapeRichText
    v54:_cancelProfileTween()
    local v57 = v54:_resolveDisplayName(v55)
    if not v54:_isAlive() then
        return
    end
    v54._profilePlayerIcon.Image = v56
    v54._profileTextLabel.RichText = true
    local v58 = if v55 == Constants.OWNER_ID then " (OWNER)" else ""
    v54._profileTextLabel.Text = ("<b>%*%*</b> liked this video"):format(escapeRichText(v57), v58)
    v54._profile.Position = v54:_getProfileHiddenPosition()
    v54._profile.Visible = true
    if v56 == "" then
        task.spawn(function() -- line 235 | captures: v54, v55, Thumbnail
            local v59 = Thumbnail(v55, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
            if v59 == nil then
                v59 = ""
            end
            if v54:_isAlive() and v54._profile.Visible then
                v54._profilePlayerIcon.Image = v59
            end
        end)
    end
    local v60 = TweenService:Create(v54._profile, v2, { Position = v54._profileVisiblePosition })
    v54._profileTween = v60
    v60.Completed:Once(function() -- line 251 | captures: v54, v60
        if v54._profileTween == v60 then
            v54._profileTween = nil
        end
    end)
    v60:Play()
end

local function _startRefreshLoop(v61) -- line 259
    task.spawn(function() -- line 260 | captures: v61
        while true do
            if v61:_isAlive() then
                task.wait(180)
                if v61:_isAlive() then
                    v61:_requestFriendLikeSnapshotAsync()
                    continue
                end
            end
            break
        end
    end)
end

v1._startRefreshLoop = _startRefreshLoop

local function _init(v62, v63) -- line 270
    v62._surfaceGui.Adornee = v63
    v62._surfaceGui.Enabled = true
    v62._rowTemplate.Visible = false
    v62._profileTextLabel.RichText = true
    v62:_hideProfileImmediate()
    v62:UpdatePresentation()
    v62:_requestFriendLikeSnapshotAsync()
    v62:_startRefreshLoop()
end

v1._init = _init

function v1.UpdatePresentation(v64) -- line 280 | captures: ButtonFX, Thumbnail, startButtonFloat
    if not v64:_isAlive() then
        return
    end
    v64:_clearRows()
    local v65 = v64._friendLikeUserIdsByMediaLikeKey[v64:_getMediaKey()]
    if v65 ~= nil and #v65 ~= 0 then
        for v66, v67 in ipairs(v65) do
            local v68 = v64._rowTemplate:Clone()
            local Button = v68.Button
            v68.Name = ("FriendLike_%*"):format(v67)
            v68.Visible = true
            v68.LayoutOrder = v66
            Button.PlayerIcon.Image = ""
            v68.Parent = v64._rowsContainer
            local v69 = v64._rowsTrove:Extend()
            startButtonFloat(Button, v69)
            local v70 = v67
            v69:Add(ButtonFX(Button, nil, function() -- line 300 | captures: v64, Button, v70
                v64:SuppressScreenTap()
                v64._interactionCallback()
                v64:_showProfilePreview(v70, Button.PlayerIcon.Image)
            end))
            v69:Add(v68)
            local spawn = task.spawn
            spawn(function() -- line 306 | captures: v64, v68, Button, v70, Thumbnail
                local v71 = Thumbnail(v70, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
                if v71 == nil then
                    v71 = ""
                end
                if v64:_isAlive() and v68.Parent ~= nil then
                    Button.PlayerIcon.Image = v71
                end
            end)
        end
    end
end

local function HandleScreenTap(v72) -- line 321
    if v72:_isAlive() and not (os.clock() < v72._screenTapSuppressUntil) then
        v72:HideProfilePreview()
    end
end

v1.HandleScreenTap = HandleScreenTap

local function SuppressScreenTap(v73) -- line 327
    v73._screenTapSuppressUntil = os.clock() + 0.12
end

v1.SuppressScreenTap = SuppressScreenTap

local function HandleMediaChanged(v74) -- line 330
    if not v74:_isAlive() then
        return
    end
    v74:HideProfilePreview()
    v74:UpdatePresentation()
    v74:_requestFriendLikeSnapshotAsync()
end

v1.HandleMediaChanged = HandleMediaChanged

function v1.HideProfilePreview(v75) -- line 338 | captures: TweenService, v3
    if v75:_isAlive() then
        v75:_cancelProfileTween()
        if v75._profile.Visible then
            local v76 = TweenService:Create(v75._profile, v3, { Position = v75:_getProfileHiddenPosition() })
            v75._profileTween = v76
            v76.Completed:Once(function() -- line 351 | captures: v75, v76
                if v75._profileTween == v76 then
                    v75._profileTween = nil
                    v75._profile.Visible = false
                end
            end)
            v76:Play()
        else
            v75._profile.Position = v75:_getProfileHiddenPosition()
        end
    end
end

local function Destroy(v77) -- line 360
    if v77._destroyed then
        return
    end
    v77._destroyed = true
    v77:_clearRows()
    v77:_hideProfileImmediate()
    v77._surfaceGui.Enabled = false
    v77._trove:Destroy()
end

v1.Destroy = Destroy
return v1
