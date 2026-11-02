-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlanarCurve = require(ReplicatedStorage.Shared.Utils.Interpolation).PlanarCurve
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Ease = require(ReplicatedStorage.Shared.Utils.Interpolation).Ease
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local GUI = require(ReplicatedStorage.Client.GUI)
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
local RecommendationSignals = require(script.Parent.RecommendationSignals)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local FrameStepper = require(ReplicatedStorage.Shared.Utils.FrameStepper)
local TreadmillMediaIdentity = require(ReplicatedStorage.Shared.Modules.TreadmillMediaIdentity)
local Schema = require(ReplicatedStorage.Shared.Types.TreadmillMediaLike.Types.Schema)
require(ReplicatedStorage.Shared.Types.TreadmillMediaLike.Types.Interface)
local t = require(ReplicatedStorage.Packages.t)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local v1 = t.intersection(t.numberMinExclusive((-1/0)), t.numberMaxExclusive((1/0)))

local function u87(v2) -- line 24 | captures: v1
    if typeof(v2) == "Vector2" then
        return v1(v2.X) and v1(v2.Y)
    end
    return false
end

require(ReplicatedStorage.Shared.Globals.Constants)
local Log = require(ReplicatedStorage.Packages.Log)
require(ReplicatedStorage.Packages.Trove)
require(script.Parent.Types.Interface)
local v3 = {}

v3.__index = v3
v3.__class = "LikeController"

local v4 = Color3.fromRGB(255, 92, 122)
local v5 = Log.new()
task.spawn(require(ReplicatedStorage.Shared.Utils.Warmup).WarmAssets, "rbxassetid://90146064998908", "rbxassetid://123761405635833")
local v6 = GUI.TreadmillScreenSideButtons()
local SurfaceGui = v6:IsA("SurfaceGui")
assert(SurfaceGui, "Treadmill like GUI must be a SurfaceGui")
local LikeButton = v6.Frame.Buttons.LikeButton
local ImageButton = LikeButton:IsA("ImageButton")
assert(ImageButton, "Treadmill like button must be an ImageButton")
local LikeCount = LikeButton.LikeCount
local TextLabel = LikeCount:IsA("TextLabel")
assert(TextLabel, "Treadmill like count label must be a TextLabel")

function v3.new(v7, v8, v9, v10, v11, v12) -- line 53 | captures: t, v3, v6, LikeButton, LikeCount
    t.strict(t.callback)(v7)
    t.strict(t.callback)(v8)
    t.strict(t.table)(v9)
    t.strict(t.table)(v10)
    t.strict(t.Instance)(v11)
    t.strict(t.instanceIsA("BasePart"))(v12)
    local v13 = {}
    local v14 = setmetatable(v13, v3)
    v14._countsByMediaLikeKey = {}
    v14._defaultLikeButtonColor = LikeButton.ImageColor3
    v14._destroyed = false
    v14._getActiveVideoIndex = v7
    v14._lastScreenTapPosition = nil
    v14._lastScreenTapTime = nil
    v14._likeButton = LikeButton
    v14._likeCountLabel = LikeCount
    v14._likeRequestLocks = {}
    v14._likeSurfaceGui = v6
    v14._likedTreadmillMedia = {}
    v14._mediaEntries = v9
    v14._onSingleTap = v8
    v14._pendingSingleTapSerial = 0
    v14._snapshotRequestSerial = 0
    v14._screenTapSuppressUntil = 0
    v14._trove = v10:Extend()
    v14._videoFrame = v11
    v14:_init(v12)
    return v14
end

local function formatLikeCount(v15) -- line 88 | captures: Simple
    local v16 = math.max(v15, 0)
    return Simple.FormatCompact(v16, ".#")
end

local function getSquareHeartSize(v17, v18) -- line 92
    local X = v17.X
    local Y = v17.Y
    local v19 = math.min(X, Y)
    return UDim2.fromScale(v19 / v17.X * v18, v19 / v17.Y * v18)
end

local function _isAlive(v20) -- line 96
    return not v20._destroyed
end

v3._isAlive = _isAlive

function v3._getMediaKey(v21) -- line 99 | captures: TreadmillMediaIdentity
    local v22 = v21._getActiveVideoIndex()
    local v23 = v21._mediaEntries[v22]
    local v24 = v23 ~= nil
    local v25 = ("Missing treadmill media entry for index %*"):format(v22)
    assert(v24, v25)
    return TreadmillMediaIdentity.GetMediaKey(v23)
end

local function _setRuntimeLikedState(v26, v27, v28) -- line 106
    if v28 then
        v26._likedTreadmillMedia[v27] = true
    else
        v26._likedTreadmillMedia[v27] = nil
    end
end

v3._setRuntimeLikedState = _setRuntimeLikedState

local function _applyLocalLikedState(v29, v30, v31) -- line 113
    if v29._likedTreadmillMedia[v30] == true == v31 then
        return
    end
    v29:_setRuntimeLikedState(v30, v31)
    local v32 = if v31 then 1 else -1
    local _countsByMediaLikeKey = v29._countsByMediaLikeKey
    local v33 = (v29._countsByMediaLikeKey[v30] or 0) + v32
    _countsByMediaLikeKey[v30] = math.max(v33, 0)
    v29:UpdatePresentation()
end

v3._applyLocalLikedState = _applyLocalLikedState

local function _reconcileLikedState(v34, v35, v36) -- line 128
    v34:_setRuntimeLikedState(v35, v36.Liked == true)
    local Count = v36.Count
    if typeof(Count) == "number" then
        v34._countsByMediaLikeKey[v35] = v36.Count
    end
    v34:UpdatePresentation()
end

v3._reconcileLikedState = _reconcileLikedState

function v3._requestLikeSnapshot(v37, v38) -- line 136 | captures: Remotes, Schema, TryCall, v5
    local v39, v40 = TryCall(function() -- line 138 | captures: Remotes
        return Remotes.Treadmill.AskFavourSnapshot:InvokeServer()
    end)
    if v39 then
        if Schema.LikeSnapshot(v40) then
            if v37:_isAlive() and v38 == v37._snapshotRequestSerial then
                v37._countsByMediaLikeKey = table.clone(v40.CountsByMediaLikeKey)
                v37._likedTreadmillMedia = table.clone(v40.LikedTreadmillMedia)
                v37:UpdatePresentation()
            end
        else
            v5:AtError():Log("Invalid treadmill media like snapshot payload")
        end
    else
        v5:AtError():Log((("Failed to load treadmill media like snapshot: %*"):format(v40)))
    end
end

local function _requestLikeSnapshotAsync(v41) -- line 156
    v41._snapshotRequestSerial += 1
    local _snapshotRequestSerial = v41._snapshotRequestSerial
    task.spawn(function() -- line 159 | captures: v41, _snapshotRequestSerial
        if v41:_isAlive() then
            v41:_requestLikeSnapshot(_snapshotRequestSerial)
        end
    end)
end

v3._requestLikeSnapshotAsync = _requestLikeSnapshotAsync

function v3._setLikedState(v42, v43) -- line 166 | captures: TryLock, RecommendationSignals, Remotes, Schema, TryCall, v5
    local v44 = v42:_getMediaKey()
    local v45 = v42._likeRequestLocks[v44]
    if v45 == nil then
        v45 = TryLock()
        v42._likeRequestLocks[v44] = v45
    end
    v45(function() -- line 173 | captures: v42, v43, v44, RecommendationSignals, Remotes, Schema, TryCall, v5
        v42._snapshotRequestSerial += 1
        local v46 = v42._likedTreadmillMedia[v44] == true
        local v47 = v42._countsByMediaLikeKey[v44] or 0
        v42:_applyLocalLikedState(v44, v43)
        local v48, v49 = TryCall(function() -- line 180 | captures: v43, v44, Remotes
            return Remotes.Treadmill.AskClipFavour:InvokeServer(v44, v43)
        end)
        if v48 then
            if Schema.LikeToggleResult(v49) then
                if v49.Ok == true then
                    if v42:_isAlive() then
                        v42:_reconcileLikedState(v44, v49)
                        local v50 = v49.Liked == true
                        RecommendationSignals.NotifyLikeResult(v44, v50)
                    end
                elseif v42:_isAlive() then
                    v42:_setRuntimeLikedState(v44, v46)
                    v42._countsByMediaLikeKey[v44] = v47
                    v42:UpdatePresentation()
                    local v51 = v5:AtError()
                    local Error = v49.Error
                    v51:Log((("Rejected treadmill media like state update: %*"):format((tostring(Error)))))
                end
            elseif v42:_isAlive() then
                v42:_setRuntimeLikedState(v44, v46)
                v42._countsByMediaLikeKey[v44] = v47
                v42:UpdatePresentation()
                v5:AtError():Log("Rejected treadmill media like state update: Invalid like toggle response")
            end
        elseif v42:_isAlive() then
            v42:_setRuntimeLikedState(v44, v46)
            v42._countsByMediaLikeKey[v44] = v47
            v42:UpdatePresentation()
            v5:AtError():Log((("Failed to update treadmill media like state: %*"):format(v49)))
        end
    end)
end

function v3._spawnHeartAnimation(v52, v53) -- line 221 | captures: PlanarCurve, Ease, FrameStepper, t, u87, v4
    t.strict(u87)(v53)
    local _videoFrame = v52._videoFrame
    local AbsoluteSize = _videoFrame.AbsoluteSize
    local v54 = if AbsoluteSize.X > 0 then AbsoluteSize.Y > 0 else false
    assert(v54, "Treadmill like animation requires a non-zero video frame size")
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "TreadmillLikeHeart"
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = "rbxassetid://90146064998908"
    ImageLabel.ImageColor3 = v4
    ImageLabel.ImageTransparency = 0
    ImageLabel.Position = UDim2.fromScale(v53.X, v53.Y)
    ImageLabel.Size = UDim2.fromScale(0.15, 0.08)
    ImageLabel.ZIndex = v52._likeButton.ZIndex + 10
    ImageLabel.Parent = _videoFrame
    Instance.new("UIAspectRatioConstraint").Parent = ImageLabel
    local v55 = Random.new()
    local v56 = v55:NextNumber(-0.08, 0.08)
    local v57 = -v55:NextNumber(0.24, 0.34)
    local v58 = v53.X + v56
    local v59 = math.clamp(v58, 0.05, 0.95)
    local v60 = v53.Y + v57
    local v61 = Vector2.new(v59, (math.clamp(v60, 0.05, 0.95)))
    local v62 = v53.X + v56 * 0.55
    local v63 = math.clamp(v62, 0.05, 0.95)
    local v64 = v53.Y + v57 * 0.45
    local v65 = Vector2.new(v63, (math.clamp(v64, 0.05, 0.95)))
    local v66 = PlanarCurve(v53, v65, v61)
    local v67
    local v68 = false

    local function cleanupHeart(v69) -- line 252 | captures: v67, v68, ImageLabel
        if v68 then
            return
        end
        v68 = true
        local v70 = v67
        v67 = nil
        if v70 ~= nil then
            if v69 then
                v70:Cancel()
            end
            v70:Destroy()
        end
        if ImageLabel.Parent ~= nil then
            ImageLabel:Destroy()
        end
    end

    v67 = FrameStepper.OnRender(function(v71, v72) -- line 269 | captures: v67, v68, v52, AbsoluteSize, ImageLabel, v66, Ease
        if v52:_isAlive() then
            if ImageLabel.Parent == nil then
                return
            end
            local v73 = Ease(v72, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local v74 = v66(v73)
            local v75 = if v72 > 0.18 then 0.4 + -0.32 * Ease((v72 - 0.18) / 0.82, Enum.EasingStyle.Quad, Enum.EasingDirection.In) else 0.6 + -0.19999999999999996 * Ease(v72 / 0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            ImageLabel.Position = UDim2.fromScale(v74.X, v74.Y)
            local X = AbsoluteSize.X
            local Y = AbsoluteSize.Y
            local v76 = math.min(X, Y)
            ImageLabel.Size = UDim2.fromScale(v76 / AbsoluteSize.X * v75, v76 / AbsoluteSize.Y * v75)
            local v77 = (v72 - 0.35) / 0.65
            ImageLabel.ImageTransparency = math.clamp(v77, 0, 1)
            if v72 < 1 then
                return false
            end
            if not v68 then
                v68 = true
                local v78 = v67
                v67 = nil
                if v78 ~= nil then
                    v78:Destroy()
                end
                if ImageLabel.Parent ~= nil then
                    ImageLabel:Destroy()
                end
            end
        elseif not v68 then
            v68 = true
            local v79 = v67
            v67 = nil
            if v79 ~= nil then
                v79:Destroy()
            end
            if ImageLabel.Parent ~= nil then
                ImageLabel:Destroy()
            end
        end
        return true
    end, 0.65, true)
    v52._trove:Add(function() -- line 318 | captures: v67, v68, ImageLabel
        if v68 then
            return
        end
        v68 = true
        local v80 = v67
        v67 = nil
        if v80 ~= nil then
            v80:Cancel()
            v80:Destroy()
        end
        if ImageLabel.Parent ~= nil then
            ImageLabel:Destroy()
        end
    end)
end

function v3._handleDoubleTap(v81, v82) -- line 334 | captures: t, u87
    t.strict(u87)(v82)
    v81:_spawnHeartAnimation(v82)
    if v81._likedTreadmillMedia[v81:_getMediaKey()] ~= true then
        v81:_setLikedState(true)
    end
end

local function _startRefreshLoop(v83) -- line 343
    task.spawn(function() -- line 344 | captures: v83
        while true do
            if v83:_isAlive() then
                task.wait(180)
                if v83:_isAlive() then
                    v83:_requestLikeSnapshotAsync()
                    continue
                end
            end
            break
        end
    end)
end

v3._startRefreshLoop = _startRefreshLoop

function v3._init(v84, v85) -- line 354 | captures: ButtonFX
    v84._likeSurfaceGui.Adornee = v85
    v84._likeSurfaceGui.Enabled = true
    v84:UpdatePresentation()
    local _trove = v84._trove
    local _likeButton = v84._likeButton
    _trove:Add(ButtonFX(_likeButton, nil, function() -- line 358 | captures: v84
        v84:Toggle()
    end))
    v84:_requestLikeSnapshotAsync()
    v84:_startRefreshLoop()
end

function v3.UpdatePresentation(v86) -- line 364 | captures: Simple, v4
    if not v86:_isAlive() then
        return
    end
    local v87 = v86:_getMediaKey()
    local v88 = v86._likedTreadmillMedia[v87] == true
    local v89
    if v88 then
        v89 = v4
    else
        v89 = Color3.fromRGB(255, 255, 255)
    end
    v86._likeButton.ImageColor3 = v89
    local v90 = if v88 then "rbxassetid://90146064998908" else "rbxassetid://123761405635833"
    v86._likeButton.Image = v90
    local v91 = v86._countsByMediaLikeKey[v87] or 0
    local v92 = math.max(v91, 0)
    v86._likeCountLabel.Text = Simple.FormatCompact(v92, ".#")
end

local function SuppressScreenTap(v93) -- line 386
    v93._screenTapSuppressUntil = os.clock() + 0.12
end

v3.SuppressScreenTap = SuppressScreenTap

local function Toggle(v94) -- line 389
    if v94:_isAlive() then
        v94:SuppressScreenTap()
        v94:_setLikedState(v94._likedTreadmillMedia[v94:_getMediaKey()] ~= true)
    end
end

v3.Toggle = Toggle

function v3.HandleScreenTap(v95, v96) -- line 397 | captures: t, u87
    t.strict(u87)(v96)
    local v97, AbsoluteSize, v98, v99
    if v95:_isAlive() then
        if os.clock() < v95._screenTapSuppressUntil then
            v99 = true
        else
            v97 = os.clock()
            AbsoluteSize = v95._videoFrame.AbsoluteSize
            if AbsoluteSize.X > 0 then
                v98 = AbsoluteSize.Y > 0
            else
                v98 = false
            end
            v99 = false
        end
    else
        v99 = true
    end
    if v99 then
        return
    end
    assert(v98, "Treadmill like tap handling requires a non-zero video frame size")
    if v95._lastScreenTapTime == nil or v95._lastScreenTapPosition == nil or v97 - v95._lastScreenTapTime > 0.25 then
        v95._pendingSingleTapSerial += 1
        local _pendingSingleTapSerial = v95._pendingSingleTapSerial
        v95._lastScreenTapTime = v97
        v95._lastScreenTapPosition = v96
        task.delay(0.25, function() -- line 413 | captures: _pendingSingleTapSerial, v95
            if not (v95:_isAlive() and v95._pendingSingleTapSerial == _pendingSingleTapSerial) then
                return
            end
            v95._lastScreenTapTime = nil
            v95._lastScreenTapPosition = nil
            v95._onSingleTap()
        end)
    else
        local v100 = (v96.X - v95._lastScreenTapPosition.X) * AbsoluteSize.X
        local v101 = v96.Y - v95._lastScreenTapPosition.Y
        if Vector2.new(v100, v101 * AbsoluteSize.Y).Magnitude <= 36 then
            v95._pendingSingleTapSerial += 1
            v95._lastScreenTapTime = nil
            v95._lastScreenTapPosition = nil
            v95:_handleDoubleTap(v96)
        else
            v95._pendingSingleTapSerial += 1
            local _pendingSingleTapSerial = v95._pendingSingleTapSerial
            v95._lastScreenTapTime = v97
            v95._lastScreenTapPosition = v96
            task.delay(0.25, function() -- line 452 | captures: v95, _pendingSingleTapSerial
                if not (v95:_isAlive() and v95._pendingSingleTapSerial == _pendingSingleTapSerial) then
                    return
                end
                v95._lastScreenTapTime = nil
                v95._lastScreenTapPosition = nil
                v95._onSingleTap()
            end)
        end
    end
end

local function Destroy(v102) -- line 461
    if v102._destroyed then
        return
    end
    v102._destroyed = true
    v102._pendingSingleTapSerial += 1
    v102._likeSurfaceGui.Enabled = false
    v102._trove:Destroy()
end

v3.Destroy = Destroy
return v3
