-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SocialService = game:GetService("SocialService")
local TweenService = game:GetService("TweenService")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local FeedSequencer = require(ReplicatedStorage.Shared.TreadmillVideoController.FeedSequencer)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Log = require(ReplicatedStorage.Packages.Log)
local Media = require(ReplicatedStorage.Shared.TreadmillVideoController.Media)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local TreadmillFlags = require(ReplicatedStorage.Shared.Flags.TreadmillFlags)
local TreadmillMediaIdentity = require(ReplicatedStorage.Shared.Modules.TreadmillMediaIdentity)
local Schema = require(ReplicatedStorage.Shared.Types.TreadmillMediaLike.Types.Schema)
local TreadmillMediaOverlay = require(ReplicatedStorage.Shared.Modules.TreadmillMediaOverlay)
require(ReplicatedStorage.Shared.TreadmillVideoController.Types.Interface)
local Trove = require(ReplicatedStorage.Packages.Trove)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local VideoCommentsCmds = require(ReplicatedStorage.Client.VideoCommentsCmds)
local v1 = Color3.fromRGB(255, 92, 122)
local v2 = TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v3 = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v4 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v5 = TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1)
local v6 = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local v7 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local LocalPlayer = Players.LocalPlayer
local v8 = Log.new()
local v9, v10, v11
local v12 = false
local v13
local Main = require(script.Parent.BackpackController.Main)
local v14
local v15 = false

local function dismissEquipHint() -- line 44 | captures: v14
    local v16 = v14
    v14 = nil
    if v16 ~= nil then
        v16:Destroy()
    end
end

local function warnMissingUi(v17) -- line 51 | captures: v12
    if not v12 then
        v12 = true
        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v17)))
    end
end

local function findTyped(v18, v19, v20, v21) -- line 58 | captures: v12
    local v22 = v18:FindFirstChild(v19, v21 == true)
    if v22 == nil then
        local v23 = ("%*.%* (%*)"):format(v18:GetFullName(), v19, v20)
        if not v12 then
            v12 = true
            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v23)))
        end
    else
        if v22:IsA(v20) then
            return v22
        end
        local v24 = ("%*.%* (%*)"):format(v18:GetFullName(), v19, v20)
        if not v12 then
            v12 = true
            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v24)))
        end
    end
    return nil
end

local function resolvePhoneUi() -- line 82 | captures: v9, v12, LocalPlayer
    local v25 = v9
    if v25 == nil then
        v9 = nil
        local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        local v26 = PlayerGui and PlayerGui:FindFirstChild("PhoneVideoUI")
        local v27, v28, v29
        if v26 == nil then
            v29 = true
        elseif v26:IsA("ScreenGui") then
            v27 = v26:FindFirstChild("Phone", false)
            if v27 == nil then
                v28 = ("%*.Phone (Frame)"):format((v26:GetFullName()))
                if not v12 then
                    v12 = true
                    warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v28)))
                end
                v27 = nil
            elseif not v27:IsA("Frame") then
                v27 = nil
            end
            v29 = false
        else
            v29 = true
        end
        if not v29 then
            if v27 ~= nil then
                local v30 = v27:FindFirstChild("MainVideo", true)
                if v30 == nil then
                    local v31 = ("%*.MainVideo (VideoFrame)"):format((v27:GetFullName()))
                    if not v12 then
                        v12 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v31)))
                    end
                    v30 = nil
                elseif not v30:IsA("VideoFrame") then
                    v30 = nil
                end
                local v32 = v27:FindFirstChild("Bar", false)
                local v33
                if v32 == nil then
                    v33 = ("%*.Bar (Frame)"):format((v27:GetFullName()))
                    if not v12 then
                        v12 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v33)))
                    end
                    v32 = nil
                elseif not v32:IsA("Frame") then
                    v32 = v28
                end
                local v34
                if v32 then
                    v34 = v32:FindFirstChild("Progress", false)
                    if v34 == nil then
                        local v35 = ("%*.Progress (GuiObject)"):format((v32:GetFullName()))
                        if not v12 then
                            v12 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v35)))
                        end
                        v34 = nil
                    elseif not v34:IsA("GuiObject") then
                        v34 = v32
                    end
                else
                    v34 = v32
                end
                local v36 = v27:FindFirstChild("Loading", false)
                local v37
                if v36 == nil then
                    v37 = ("%*.Loading (GuiObject)"):format((v27:GetFullName()))
                    if not v12 then
                        v12 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v37)))
                    end
                    v36 = nil
                elseif not v36:IsA("GuiObject") then
                    v36 = v33
                end
                local v38
                if v36 then
                    v38 = v36:FindFirstChild("Spin", false)
                    if v38 == nil then
                        local v39 = ("%*.Spin (GuiObject)"):format((v36:GetFullName()))
                        if not v12 then
                            v12 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v39)))
                        end
                        v38 = nil
                    elseif not v38:IsA("GuiObject") then
                        v38 = v36
                    end
                else
                    v38 = v36
                end
                local v40 = v27:FindFirstChild("GoToNext", false)
                if v40 == nil then
                    local v41 = ("%*.GoToNext (CanvasGroup)"):format((v27:GetFullName()))
                    if not v12 then
                        v12 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v41)))
                    end
                    v40 = nil
                elseif not v40:IsA("CanvasGroup") then
                    v40 = v37
                end
                local v42, v43, v44, v45
                if v40 then
                    v42 = v40:FindFirstChild("Arrow", false)
                    if v42 == nil then
                        v43 = ("%*.Arrow (ImageLabel)"):format((v40:GetFullName()))
                        if not v12 then
                            v12 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v43)))
                        end
                        v42 = nil
                    elseif not v42:IsA("ImageLabel") then
                        v42 = v40
                    end
                    v44 = v40:FindFirstChild("ArrowShadow", false)
                    if v44 == nil then
                        v45 = ("%*.ArrowShadow (ImageLabel)"):format((v40:GetFullName()))
                        if not v12 then
                            v12 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v45)))
                        end
                        v44 = nil
                    elseif not v44:IsA("ImageLabel") then
                        v44 = v40
                    end
                else
                    v42 = v40
                    v44 = v40
                end
                local v46 = v27:FindFirstChild("Paused", false)
                local v47
                if v46 == nil then
                    v47 = ("%*.Paused (CanvasGroup)"):format((v27:GetFullName()))
                    if not v12 then
                        v12 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v47)))
                    end
                    v46 = nil
                elseif not v46:IsA("CanvasGroup") then
                    v46 = v43
                end
                local v48 = v27:FindFirstChild("TapCatcher", false)
                local v49
                if v48 == nil then
                    v49 = ("%*.TapCatcher (GuiButton)"):format((v27:GetFullName()))
                    if not v12 then
                        v12 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v49)))
                    end
                    v48 = nil
                elseif not v48:IsA("GuiButton") then
                    v48 = v45
                end
                local v50 = v27:FindFirstChild("Close", false)
                local v51
                if v50 == nil then
                    v51 = ("%*.Close (GuiButton)"):format((v27:GetFullName()))
                    if not v12 then
                        v12 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v51)))
                    end
                    v50 = nil
                elseif not v50:IsA("GuiButton") then
                    v50 = v47
                end
                local v52 = v27:FindFirstChild("ButtonSwapLeft", true)
                local v53
                if v52 == nil then
                    v53 = ("%*.ButtonSwapLeft (GuiButton)"):format((v27:GetFullName()))
                    if not v12 then
                        v12 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v53)))
                    end
                    v52 = nil
                elseif not v52:IsA("GuiButton") then
                    v52 = v49
                end
                local v54 = v27:FindFirstChild("ButtonSwapRight", true)
                if v54 == nil then
                    local v55 = ("%*.ButtonSwapRight (GuiButton)"):format((v27:GetFullName()))
                    if not v12 then
                        v12 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v55)))
                    end
                    v54 = nil
                elseif not v54:IsA("GuiButton") then
                    v54 = v51
                end
                local v56 = v27:FindFirstChild("Share", false)
                local v57
                if v56 == nil then
                    v57 = ("%*.Share (GuiObject)"):format((v27:GetFullName()))
                    if not v12 then
                        v12 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v57)))
                    end
                    v56 = nil
                elseif not v56:IsA("GuiObject") then
                    v56 = v53
                end
                local v58
                if v56 then
                    v58 = v56:FindFirstChild("ShareButton", true)
                    if v58 == nil then
                        local v59 = ("%*.ShareButton (GuiButton)"):format((v56:GetFullName()))
                        if not v12 then
                            v12 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v59)))
                        end
                        v58 = nil
                    elseif not v58:IsA("GuiButton") then
                        v58 = v56
                    end
                else
                    v58 = v56
                end
                local v60 = v27:FindFirstChild("SideButtons", false)
                if v60 == nil then
                    local v61 = ("%*.SideButtons (GuiObject)"):format((v27:GetFullName()))
                    if not v12 then
                        v12 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v61)))
                    end
                    v60 = nil
                elseif not v60:IsA("GuiObject") then
                    v60 = v57
                end
                local v62
                if v60 then
                    v62 = v60:FindFirstChild("LikeButton", true)
                    if v62 == nil then
                        local v63 = ("%*.LikeButton (ImageButton)"):format((v60:GetFullName()))
                        if not v12 then
                            v12 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v63)))
                        end
                        v62 = nil
                    elseif not v62:IsA("ImageButton") then
                        v62 = v60
                    end
                else
                    v62 = v60
                end
                local v64
                if v62 then
                    v64 = v62:FindFirstChild("LikeCount", false)
                    if v64 == nil then
                        local v65 = ("%*.LikeCount (TextLabel)"):format((v62:GetFullName()))
                        if not v12 then
                            v12 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v65)))
                        end
                        v64 = nil
                    elseif not v64:IsA("TextLabel") then
                        v64 = v62
                    end
                else
                    v64 = v62
                end
                local v66
                if v60 then
                    v66 = v60:FindFirstChild("CommentsButton", true)
                    if v66 == nil then
                        local v67 = ("%*.CommentsButton (GuiButton)"):format((v60:GetFullName()))
                        if not v12 then
                            v12 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v67)))
                        end
                        v66 = nil
                    elseif not v66:IsA("GuiButton") then
                        v66 = v60
                    end
                else
                    v66 = v60
                end
                local v68
                if v66 then
                    v68 = v66:FindFirstChild("CommentsCount", false)
                    if v68 == nil then
                        local v69 = ("%*.CommentsCount (TextLabel)"):format((v66:GetFullName()))
                        if not v12 then
                            v12 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v69)))
                        end
                        v68 = nil
                    elseif not v68:IsA("TextLabel") then
                        v68 = v66
                    end
                else
                    v68 = v66
                end
                if v30 ~= nil and v34 ~= nil and v36 ~= nil and v38 ~= nil and v40 ~= nil and v42 ~= nil and v44 ~= nil and v46 ~= nil and v48 ~= nil and v50 ~= nil and v52 ~= nil and v54 ~= nil then
                    if v56 == nil then
                        return nil
                    end
                    if v58 == nil then
                        return nil
                    end
                    if v60 == nil then
                        return nil
                    end
                    if v62 == nil then
                        return nil
                    end
                    if v64 == nil then
                        return nil
                    end
                    if v66 == nil then
                        return nil
                    end
                    if v68 == nil then
                        return nil
                    end
                    local v70 = v46:FindFirstChild("EnjoyFree", true)
                    local VideoCounter = v27:FindFirstChild("VideoCounter")
                    for v71, v72 in { v27 } do
                        for v73, v74 in v72:GetDescendants() do
                            if v74.Name == "ConsoleButton" and v74:IsA("GuiObject") then
                                v74.Visible = false
                            end
                        end
                    end
                    local v75 = {
                        Gui = v26,
                        Phone = v27,
                        Video = v30,
                        Progress = v34,
                        Loading = v36,
                        LoadingSpin = v38,
                        GoToNext = v40,
                        Arrow = v42,
                        ArrowShadow = v44,
                        Paused = v46
                    }
                    if v70 ~= nil and not v70:IsA("TextLabel") then
                        v70 = nil
                    end
                    v75.EnjoyFreeLabel = v70
                    if VideoCounter ~= nil and not VideoCounter:IsA("TextLabel") then
                        VideoCounter = v70
                    end
                    v75.VideoCounter = VideoCounter
                    v75.TapCatcher = v48
                    v75.CloseButton = v50
                    v75.SwapLeftButton = v52
                    v75.SwapRightButton = v54
                    v75.ShareContainer = v56
                    v75.ShareButton = v58
                    v75.SideButtonsContainer = v60
                    v75.LikeButton = v62
                    v75.LikeCountLabel = v64
                    v75.CommentsButton = v66
                    v75.CommentsCountLabel = v68
                    local Comments = v27:FindFirstChild("Comments")
                    if Comments ~= nil and not Comments:IsA("GuiObject") then
                        Comments = nil
                    end
                    v75.CommentsPanel = Comments
                    v75.ArrowBasePosition = v42.Position
                    v75.ArrowShadowBasePosition = v44.Position
                    v75.VideoBaseSize = v30.Size
                    v75.OnscreenPosition = v27.Position
                    v75.OffscreenPosition = UDim2.new(v27.Position.X.Scale, 0, 2, 0)
                    v9 = v75
                    return v75
                end
            end
            return nil
        end
        if not v12 then
            v12 = true
            warn("[PhoneVideoController] PlayerGui.PhoneVideoUI is missing. The PhoneVideoUI ScreenGui is incomplete.")
        end
        return nil
    end
    if v25.Gui.Parent == nil then
        return
    end
    return v25
end

local v76 = table.clone(Media)
TreadmillMediaOverlay.ApplyTo(v76)

local function isSkippedMediaIndex(v77) -- line 432 | captures: TreadmillMediaIdentity, TreadmillMediaOverlay, v76
    local v78 = v76[v77]
    if v78 ~= nil and v78.Kind == "Video" and v78.Disabled ~= true then
        return TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v78))
    end
    return true
end

local function countPlayableVideos() -- line 439 | captures: TreadmillMediaIdentity, TreadmillMediaOverlay, v76
    local v79
    local v80 = 0
    for v81 in v76 do
        local v82 = v76[v81]
        if v82 == nil then
            v79 = true
        elseif v82.Kind == "Video" and v82.Disabled ~= true then
            v79 = TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v82))
        end
        if not v79 then
            v80 += 1
        end
    end
    return v80
end

local function sequencerNextSkippingUnplayable(v83) -- line 458 | captures: FeedSequencer, Remotes, TreadmillMediaIdentity, TreadmillMediaOverlay, v76
    local v84, v85 = FeedSequencer.Next(v83.Feed)
    local v86 = #v76
    local v87
    for v88 = 1, v86 do
        local v89 = v76[v84]
        if v89 == nil then
            v87 = true
        elseif v89.Kind == "Video" and v89.Disabled ~= true then
            v87 = TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v89))
        end
        if not v87 then
            break
        end
        Remotes.Treadmill.RefreshClipCursor:FireServer(v85)
        v84, v85 = FeedSequencer.Next(v83.Feed)
        v87 = v84
    end
    return v84, v85
end

local function sequencerPreviousSkippingUnplayable(v90) -- line 481 | captures: FeedSequencer, Remotes, TreadmillMediaIdentity, TreadmillMediaOverlay, v76, sequencerNextSkippingUnplayable
    local v91, v92, v93 = FeedSequencer.Previous(v90.Feed)
    if v93 then
        local v94 = #v76
        local v95
        for v96 = 1, v94 do
            local v97 = v76[v91]
            if v97 == nil then
                v95 = true
            elseif v97.Kind == "Video" and v97.Disabled ~= true then
                v95 = TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v97))
            end
            if v95 then
                Remotes.Treadmill.RefreshClipCursor:FireServer(v92)
                local v98
                v91, v92, v98 = FeedSequencer.Previous(v90.Feed)
                if not v98 then
                    local v99, v100 = sequencerNextSkippingUnplayable(v90)
                    return v99, v100, true
                end
            else
                return v91, v92, true
            end
            v95 = v91
        end
        return v91, v92, true
    end
    return v91, v92, false
end

local function currentMediaKey(v101) -- line 511 | captures: TreadmillMediaIdentity, v76
    return TreadmillMediaIdentity.GetMediaKey(v76[v101.Index])
end

local function formatCompactCount(v102) -- line 514 | captures: Simple
    local v103 = math.max(v102, 0)
    return Simple.FormatCompact(v103, ".#")
end

local function updateSocialPresentation(v104, v105) -- line 518 | captures: Simple, TreadmillFlags, TreadmillMediaIdentity, VideoCommentsCmds, v1, v76
    local v106 = TreadmillMediaIdentity.GetMediaKey(v76[v105.Index])
    local v107 = v105.LikedByMediaKey[v106] == true
    local v108
    if v107 then
        v108 = v1
    else
        v108 = Color3.new(1, 1, 1)
    end
    v104.LikeButton.ImageColor3 = v108
    local v109 = if v107 then "rbxassetid://90146064998908" else "rbxassetid://123761405635833"
    v104.LikeButton.Image = v109
    local v110 = v105.LikeCountsByMediaKey[v106] or 0
    local v111 = math.max(v110, 0)
    v104.LikeCountLabel.Text = Simple.FormatCompact(v111, ".#")
    v104.CommentsButton.Visible = not TreadmillFlags.CommentsDisabled:Get()
    local v112 = VideoCommentsCmds.GetCachedCommentCount(v106) or 0
    local v113 = math.max(v112, 0)
    v104.CommentsCountLabel.Text = Simple.FormatCompact(v113, ".#")
end

local function requestLikeSnapshot(v114, v115) -- line 541 | captures: v10, Remotes, Schema, TryCall, v8, updateSocialPresentation
    task.spawn(function() -- line 542 | captures: v114, v115, v10, Remotes, Schema, TryCall, v8, updateSocialPresentation
        local v116, v117 = TryCall(function() -- line 544 | captures: Remotes
            return Remotes.Treadmill.AskFavourSnapshot:InvokeServer()
        end)
        if not (v116 and Schema.LikeSnapshot(v117)) then
            v8:AtWarning():Log("[PhoneVideoController] Could not load the media like snapshot")
        elseif v10 == v115 then
            v115.LikeCountsByMediaKey = table.clone(v117.CountsByMediaLikeKey)
            v115.LikedByMediaKey = table.clone(v117.LikedTreadmillMedia)
            updateSocialPresentation(v114, v115)
        end
    end)
end

local function toggleLike(v118, v119) -- line 559 | captures: v10, Remotes, TreadmillMediaIdentity, Schema, TryCall, v8, v76, updateSocialPresentation
    if v119.LikeBusy then
        return
    end
    v119.LikeBusy = true
    local v120 = TreadmillMediaIdentity.GetMediaKey(v76[v119.Index])
    local v121 = v119.LikedByMediaKey[v120] == true
    local v122 = v119.LikeCountsByMediaKey[v120] or 0
    local v123 = not v121
    v119.LikedByMediaKey[v120] = v123
    local v124 = if v123 then 1 else -1
    local LikeCountsByMediaKey = v119.LikeCountsByMediaKey
    local v125 = v122 + v124
    LikeCountsByMediaKey[v120] = math.max(v125, 0)
    updateSocialPresentation(v118, v119)
    task.spawn(function() -- line 577 | captures: v118, v119, v120, v122, v121, v123, v10, Remotes, Schema, TryCall, v8, updateSocialPresentation
        local v126, v127 = TryCall(function() -- line 579 | captures: v120, v123, Remotes
            return Remotes.Treadmill.AskClipFavour:InvokeServer(v120, v123)
        end)
        if v10 ~= v119 then
            return
        end
        v119.LikeBusy = false
        if v126 and Schema.LikeToggleResult(v127) and v127.Ok == true then
            local v128 = v127.Liked == true
            v119.LikedByMediaKey[v120] = v128
            local Count = v127.Count
            if type(Count) == "number" then
                v119.LikeCountsByMediaKey[v120] = v127.Count
            end
            updateSocialPresentation(v118, v119)
        else
            v119.LikedByMediaKey[v120] = v121
            v119.LikeCountsByMediaKey[v120] = v122
            updateSocialPresentation(v118, v119)
            v8:AtWarning():Log("[PhoneVideoController] Media like update was rejected")
        end
    end)
end

local function fadeInCard(v129, v130, v131) -- line 601 | captures: TweenService
    v130.GroupTransparency = 1
    v130.Visible = true
    local v132 = TweenService:Create(v130, v131, { GroupTransparency = 0 })
    v129:Add(function() -- line 605 | captures: v132
        v132:Cancel()
    end)
    v132:Play()
end

local function hidePausedCard(v133, v134) -- line 610
    local PausedCardTrove = v134.PausedCardTrove
    v134.PausedCardTrove = nil
    if PausedCardTrove ~= nil then
        PausedCardTrove:Destroy()
    end
    v133.Paused.Visible = false
    local PreviewBaseSize = v134.PreviewBaseSize
    v134.PreviewBaseSize = nil
    if PreviewBaseSize ~= nil then
        v133.Video.Size = PreviewBaseSize
    end
end

local function showPausedCard(v135, v136) -- line 623 | captures: Trove, v4, fadeInCard
    local v137
    if v136.PausedCardTrove == nil and v136.EndCardTrove == nil then
        v137 = Trove.new()
        v136.PausedCardTrove = v137
        local EnjoyFreeLabel = v135.EnjoyFreeLabel
        if EnjoyFreeLabel ~= nil then
            EnjoyFreeLabel.Visible = not v136.HasPlayed
        end
    else
        return
    end
    fadeInCard(v137, v135.Paused, v4)
    if v135.Video.TimePosition <= 0 and not v135.Video.Playing then
        pcall(function() -- line 636 | captures: v135
            v135.Video:Play()
            v135.Video:Pause()
            v135.Video.TimePosition = 0
        end)
    end
    local PreviewBaseSize = v136.PreviewBaseSize
    if PreviewBaseSize ~= nil then
        v136.PreviewBaseSize = nil
        v135.Video.Size = PreviewBaseSize
    end
    local Size = v135.Video.Size
    local v138 = if Size.X.Scale <= 0 then 1 else 1 / Size.X.Scale
    local v139 = if Size.Y.Scale <= 0 then 1 else 1 / Size.Y.Scale
    local v140 = math.max(v138, v139)
    if v140 > 1 then
        v136.PreviewBaseSize = Size
        v135.Video.Size = UDim2.new(Size.X.Scale * v140, Size.X.Offset * v140, Size.Y.Scale * v140, Size.Y.Offset * v140)
    end
end

local function hideEndCard(v141, v142) -- line 665
    local EndCardTrove = v142.EndCardTrove
    v142.EndCardTrove = nil
    if EndCardTrove ~= nil then
        EndCardTrove:Destroy()
    end
    v141.GoToNext.Visible = false
end

local function spawnArrowPulse(v143, v144) -- line 673 | captures: TweenService, v2
    local v145 = v143.Arrow:Clone()
    v145.Name = "ArrowPulse"
    local v146 = v143.Arrow.ZIndex - 1
    v145.ZIndex = math.max(v146, 0)
    v145.ImageTransparency = 0.35
    v145.Parent = v143.GoToNext
    v144:Add(v145)
    local v147 = TweenService:Create(v145, v2, {
        ImageTransparency = 1,
        Size = UDim2.new(v143.Arrow.Size.X.Scale * 2.2, 0, v143.Arrow.Size.Y.Scale * 2.2, 0)
    })
    v147.Completed:Once(function() -- line 681 | captures: v145
        v145:Destroy()
    end)
    v147:Play()
end

local function showEndCard(v148, v149) -- line 686 | captures: RunService, Trove, v3, fadeInCard, spawnArrowPulse
    if v149.EndCardTrove ~= nil then
        return
    end
    local PausedCardTrove = v149.PausedCardTrove
    v149.PausedCardTrove = nil
    if PausedCardTrove ~= nil then
        PausedCardTrove:Destroy()
    end
    v148.Paused.Visible = false
    local PreviewBaseSize = v149.PreviewBaseSize
    v149.PreviewBaseSize = nil
    if PreviewBaseSize ~= nil then
        v148.Video.Size = PreviewBaseSize
    end
    local v150 = Trove.new()
    v149.EndCardTrove = v150
    v148.ShareContainer.Visible = false
    v148.SideButtonsContainer.Visible = false
    fadeInCard(v150, v148.GoToNext, v3)
    local v151 = v148.GoToNext:GetAttribute("SwaySeconds") or 1.2
    local v152 = v148.GoToNext:GetAttribute("SwayScale") or 0.02
    local v153 = os.clock()
    local v154 = 0
    local RenderStepped = RunService.RenderStepped
    v150:Connect(RenderStepped, function() -- line 710 | captures: v154, v148, v150, v151, v152, v153, spawnArrowPulse
        local v155 = os.clock() - v153
        local v156 = v155 * 3.141592653589793 * 2 / v151
        local v157 = math.sin(v156)
        local v158 = UDim2.fromScale(v157 * v152, 0)
        v148.Arrow.Position = v148.ArrowBasePosition + v158
        v148.ArrowShadow.Position = v148.ArrowShadowBasePosition + v158
        local v159 = v155 / v151 + 0.75
        local v160 = math.floor(v159)
        if v154 < v160 then
            v154 = v160
            spawnArrowPulse(v148, v150)
        end
    end)
    v150:Add(function() -- line 722 | captures: v148
        v148.Arrow.Position = v148.ArrowBasePosition
        v148.ArrowShadow.Position = v148.ArrowShadowBasePosition
    end)
end

local function playVideo(v161, v162) -- line 727
    v162.HasPlayed = true
    local PausedCardTrove = v162.PausedCardTrove
    v162.PausedCardTrove = nil
    if PausedCardTrove ~= nil then
        PausedCardTrove:Destroy()
    end
    v161.Paused.Visible = false
    local PreviewBaseSize = v162.PreviewBaseSize
    v162.PreviewBaseSize = nil
    if PreviewBaseSize ~= nil then
        v161.Video.Size = PreviewBaseSize
    end
    v161.Video:Play()
end

local function pauseVideo(v163, v164) -- line 742 | captures: showPausedCard
    v163.Video:Pause()
    showPausedCard(v163, v164)
end

local function stopLoading(v165, v166) -- line 746
    local LoadingTween = v166.LoadingTween
    v166.LoadingTween = nil
    if LoadingTween ~= nil then
        LoadingTween:Cancel()
    end
    v165.Loading.Visible = false
    v165.LoadingSpin.Rotation = 0
end

local function finishLoad(v167, v168) -- line 755 | captures: updateSocialPresentation, showPausedCard
    local LoadingTween = v168.LoadingTween
    v168.LoadingTween = nil
    if LoadingTween ~= nil then
        LoadingTween:Cancel()
    end
    v167.Loading.Visible = false
    v167.LoadingSpin.Rotation = 0
    v167.ShareContainer.Visible = true
    v167.SideButtonsContainer.Visible = true
    updateSocialPresentation(v167, v168)
    if v168.HasPlayed then
        v168.HasPlayed = true
        local PausedCardTrove = v168.PausedCardTrove
        v168.PausedCardTrove = nil
        if PausedCardTrove ~= nil then
            PausedCardTrove:Destroy()
        end
        v167.Paused.Visible = false
        local PreviewBaseSize = v168.PreviewBaseSize
        v168.PreviewBaseSize = nil
        if PreviewBaseSize ~= nil then
            v167.Video.Size = PreviewBaseSize
        end
        v167.Video:Play()
    else
        showPausedCard(v167, v168)
    end
end

local function loadVideo(v169, v170, v171, v172) -- line 784 | captures: v10, v13, TweenService, Remotes, v5, v8, v76, updateSocialPresentation, showPausedCard
    local v173 = v76[v171]
    local LoadToken, v174
    if v173 == nil then
        v174 = true
    elseif v173.Kind == "Video" then
        v170.LoadToken += 1
        LoadToken = v170.LoadToken
        local EndCardTrove = v170.EndCardTrove
        v170.EndCardTrove = nil
        if EndCardTrove ~= nil then
            EndCardTrove:Destroy()
        end
        v174 = false
    else
        v174 = true
    end
    if not v174 then
        v169.GoToNext.Visible = false
        local PausedCardTrove = v170.PausedCardTrove
        v170.PausedCardTrove = nil
        if PausedCardTrove ~= nil then
            PausedCardTrove:Destroy()
        end
        v169.Paused.Visible = false
        local PreviewBaseSize = v170.PreviewBaseSize
        v170.PreviewBaseSize = nil
        if PreviewBaseSize ~= nil then
            v169.Video.Size = PreviewBaseSize
        end
        local CommentsPanel = v169.CommentsPanel
        if CommentsPanel ~= nil then
            CommentsPanel.Visible = false
        end
        v170.Index = v171
        Remotes.Treadmill.RefreshClipCursor:FireServer(v172)
        v13 = v172
        v169.Video:Pause()
        local v175 = v173.Size or v169.VideoBaseSize
        v169.Video.Size = v175
        v169.Video.Volume = v173.Volume or 1
        v169.Video.Video = v173.Video
        v169.Video.TimePosition = 0
        local Size = v169.Progress.Size
        v169.Progress.Size = UDim2.new(0, 0, Size.Y.Scale, Size.Y.Offset)
        if v169.Video.IsLoaded then
            local LoadingTween = v170.LoadingTween
            v170.LoadingTween = nil
            if LoadingTween ~= nil then
                LoadingTween:Cancel()
            end
            v169.Loading.Visible = false
            v169.LoadingSpin.Rotation = 0
            v169.ShareContainer.Visible = true
            v169.SideButtonsContainer.Visible = true
            updateSocialPresentation(v169, v170)
            if v170.HasPlayed then
                v170.HasPlayed = true
                local PausedCardTrove = v170.PausedCardTrove
                v170.PausedCardTrove = nil
                if PausedCardTrove ~= nil then
                    PausedCardTrove:Destroy()
                end
                v169.Paused.Visible = false
                local PreviewBaseSize = v170.PreviewBaseSize
                v170.PreviewBaseSize = nil
                if PreviewBaseSize ~= nil then
                    v169.Video.Size = PreviewBaseSize
                end
                v169.Video:Play()
            else
                showPausedCard(v169, v170)
            end
        else
            v169.ShareContainer.Visible = false
            v169.SideButtonsContainer.Visible = false
            local LoadingTween = v170.LoadingTween
            v170.LoadingTween = nil
            if LoadingTween ~= nil then
                LoadingTween:Cancel()
            end
            v169.Loading.Visible = false
            v169.LoadingSpin.Rotation = 0
            v169.Loading.Visible = true
            local v176 = TweenService:Create(v169.LoadingSpin, v5, { Rotation = 360 })
            v170.LoadingTween = v176
            v176:Play()
            local v177
            local Loaded = v169.Video.Loaded
            local LoadToken_2 = LoadToken
            v177 = Loaded:Connect(function() -- line 844 | captures: v177, v169, v170, LoadToken_2, v10, updateSocialPresentation, showPausedCard
                v177:Disconnect()
                local v178, v179
                if v10 == v170 and v170.LoadToken == LoadToken_2 then
                    v178 = v169
                    v179 = v170
                    local LoadingTween = v170.LoadingTween
                    v170.LoadingTween = nil
                    if LoadingTween ~= nil then
                        LoadingTween:Cancel()
                    end
                else
                    return
                end
                v178.Loading.Visible = false
                v178.LoadingSpin.Rotation = 0
                v178.ShareContainer.Visible = true
                v178.SideButtonsContainer.Visible = true
                updateSocialPresentation(v178, v179)
                if v179.HasPlayed then
                    v179.HasPlayed = true
                    local PausedCardTrove = v179.PausedCardTrove
                    v179.PausedCardTrove = nil
                    if PausedCardTrove ~= nil then
                        PausedCardTrove:Destroy()
                    end
                    v178.Paused.Visible = false
                    local PreviewBaseSize = v179.PreviewBaseSize
                    v179.PreviewBaseSize = nil
                    if PreviewBaseSize ~= nil then
                        v178.Video.Size = PreviewBaseSize
                    end
                    v178.Video:Play()
                else
                    showPausedCard(v178, v179)
                end
            end)
            v170.Trove:Add(v177)
        end
    else
        v8:AtWarning():Log((("[PhoneVideoController] Media index %* is not a playable video"):format(v171)))
    end
end

local function closePhone() -- line 910 | captures: v10, v11, TweenService, v7, resolvePhoneUi
    local v180 = v10
    v10 = nil
    if v180 == nil then
        return
    end
    local v181 = resolvePhoneUi()
    v180.Trove:Destroy()
    if v181 == nil then
        return
    end
    v181.Video:Pause()
    if v11 ~= nil then
        v11:Cancel()
    end
    local v182 = TweenService:Create(v181.Phone, v7, { Position = v181.OffscreenPosition })
    v11 = v182
    v182.Completed:Once(function() -- line 927 | captures: v181, v10
        if v10 == nil then
            v181.Gui.Enabled = false
        end
    end)
    v182:Play()
end

local function openPhone() -- line 934 | captures: v10, v11, v13, v14, v15, RunService, SocialService, TweenService, ButtonFX, FeedSequencer, Remotes, Save, TreadmillMediaIdentity, Schema, TreadmillMediaOverlay, Trove, TryCall, v6, LocalPlayer, v8, resolvePhoneUi, v76, sequencerNextSkippingUnplayable, sequencerPreviousSkippingUnplayable, updateSocialPresentation, toggleLike, showPausedCard, showEndCard, loadVideo, closePhone
    v15 = true
    local v183 = v14
    v14 = nil
    if v183 ~= nil then
        v183:Destroy()
    end
    if v10 == nil then
        local v184 = resolvePhoneUi()
        if v184 ~= nil then
            local v185 = Save.Get()
            if v185 == nil then
                v8:AtWarning():Log("[PhoneVideoController] Save data is not loaded yet")
            else
                local v186
                local v187 = 0
                for v188 in v76 do
                    local v189 = v76[v188]
                    if v189 == nil then
                        v186 = true
                    elseif v189.Kind == "Video" and v189.Disabled ~= true then
                        v186 = TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v189))
                    end
                    if not v186 then
                        v187 += 1
                    end
                end
                if v187 == 0 then
                    v8:AtWarning():Log("[PhoneVideoController] No treadmill videos are available")
                else
                    local v190 = {
                        HasPlayed = false,
                        Index = 1,
                        LoadToken = 0,
                        LikeBusy = false,
                        Trove = Trove.new()
                    }
                    local v191 = v13 or v185.TreadmillMediaFeedState
                    v190.Feed = FeedSequencer.CreateRuntime(v76, v191, LocalPlayer.UserId)
                    v190.LikedByMediaKey = {}
                    v190.LikeCountsByMediaKey = {}
                    v10 = v190
                    v190.Trove:Add(function() -- line 988 | captures: v184, v190
                        local EndCardTrove = v190.EndCardTrove
                        v190.EndCardTrove = nil
                        if EndCardTrove ~= nil then
                            EndCardTrove:Destroy()
                        end
                        v184.GoToNext.Visible = false
                        local PausedCardTrove = v190.PausedCardTrove
                        v190.PausedCardTrove = nil
                        if PausedCardTrove ~= nil then
                            PausedCardTrove:Destroy()
                        end
                        v184.Paused.Visible = false
                        local PreviewBaseSize = v190.PreviewBaseSize
                        v190.PreviewBaseSize = nil
                        if PreviewBaseSize ~= nil then
                            v184.Video.Size = PreviewBaseSize
                        end
                        local LoadingTween = v190.LoadingTween
                        v190.LoadingTween = nil
                        if LoadingTween ~= nil then
                            LoadingTween:Cancel()
                        end
                        v184.Loading.Visible = false
                        v184.LoadingSpin.Rotation = 0
                    end)

                    local function goToNextVideo() -- line 1019 | captures: v184, v190, sequencerNextSkippingUnplayable, loadVideo
                        local v192, v193 = sequencerNextSkippingUnplayable(v190)
                        loadVideo(v184, v190, v192, v193)
                    end

                    local VideoCounter = v184.VideoCounter
                    if VideoCounter ~= nil then
                        local v194 = 0
                        local v195
                        for v196 in v76 do
                            local v197 = v76[v196]
                            if v197 == nil then
                                v195 = true
                            elseif v197.Kind == "Video" and v197.Disabled ~= true then
                                v195 = TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v197))
                            end
                            if not v195 then
                                v194 += 1
                            end
                        end
                        VideoCounter.Text = ("Total Videos: %*"):format(v194)
                    end
                    v190.Trove:Add(ButtonFX(v184.CloseButton, nil, function() -- line 1044 | captures: LocalPlayer, closePhone
                        local Character = LocalPlayer.Character
                        local v198
                        if Character == nil then
                        else
                            v198 = Character:FindFirstChildOfClass("Humanoid")
                        end
                        if v198 == nil then
                            closePhone()
                        else
                            v198:UnequipTools()
                        end
                    end))
                    local Trove_2 = v190.Trove
                    local SwapLeftButton = v184.SwapLeftButton
                    Trove_2:Add(ButtonFX(SwapLeftButton, nil, function() -- line 1058 | captures: v184, v190, sequencerPreviousSkippingUnplayable, loadVideo
                        local v199, v200, v201 = sequencerPreviousSkippingUnplayable(v190)
                        if v201 then
                            loadVideo(v184, v190, v199, v200)
                        end
                    end))
                    v190.Trove:Add(ButtonFX(v184.SwapRightButton, nil, goToNextVideo))
                    v190.Trove:Add(ButtonFX(v184.ShareButton, nil, function() -- line 1066 | captures: SocialService, TryCall, LocalPlayer
                        local v202, v203 = TryCall(SocialService.CanSendGameInviteAsync, SocialService, LocalPlayer)
                        if v202 and v203 then
                            SocialService:PromptGameInvite(LocalPlayer)
                        end
                    end))
                    local Trove_3 = v190.Trove
                    local LikeButton = v184.LikeButton
                    Trove_3:Add(ButtonFX(LikeButton, nil, function() -- line 1073 | captures: v184, v190, toggleLike
                        toggleLike(v184, v190)
                    end))
                    local Trove_4 = v190.Trove
                    local CommentsButton = v184.CommentsButton
                    Trove_4:Add(ButtonFX(CommentsButton, nil, function() -- line 1076 | captures: v184
                        local CommentsPanel = v184.CommentsPanel
                        if CommentsPanel ~= nil then
                            CommentsPanel.Visible = not CommentsPanel.Visible
                        end
                    end))
                    v190.Trove:Add(function() -- line 1082 | captures: v184
                        local CommentsPanel = v184.CommentsPanel
                        if CommentsPanel ~= nil then
                            CommentsPanel.Visible = false
                        end
                    end)
                    task.spawn(function() -- line 1088 | captures: v184, v190, v10, Remotes, Schema, TryCall, v8, updateSocialPresentation
                        local v204, v205 = TryCall(function() -- line 1090 | captures: Remotes
                            return Remotes.Treadmill.AskFavourSnapshot:InvokeServer()
                        end)
                        if not (v204 and Schema.LikeSnapshot(v205)) then
                            v8:AtWarning():Log("[PhoneVideoController] Could not load the media like snapshot")
                        elseif v10 == v190 then
                            v190.LikeCountsByMediaKey = table.clone(v205.CountsByMediaLikeKey)
                            v190.LikedByMediaKey = table.clone(v205.LikedTreadmillMedia)
                            updateSocialPresentation(v184, v190)
                        end
                    end)
                    v190.Trove:Connect(v184.TapCatcher.Activated, function() -- line 1104 | captures: v184, v190, sequencerNextSkippingUnplayable, showPausedCard, loadVideo
                        if v190.EndCardTrove == nil then
                            if v184.Video.Playing then
                                v184.Video:Pause()
                                showPausedCard(v184, v190)
                            else
                                v190.HasPlayed = true
                                local PausedCardTrove = v190.PausedCardTrove
                                v190.PausedCardTrove = nil
                                if PausedCardTrove ~= nil then
                                    PausedCardTrove:Destroy()
                                end
                                v184.Paused.Visible = false
                                local PreviewBaseSize = v190.PreviewBaseSize
                                v190.PreviewBaseSize = nil
                                if PreviewBaseSize ~= nil then
                                    v184.Video.Size = PreviewBaseSize
                                end
                                v184.Video:Play()
                            end
                        else
                            local v206, v207 = sequencerNextSkippingUnplayable(v190)
                            loadVideo(v184, v190, v206, v207)
                        end
                    end)
                    v190.Trove:Connect(v184.Video.Ended, function() -- line 1133 | captures: v184, v190, v10, showEndCard
                        if v10 == v190 then
                            showEndCard(v184, v190)
                        end
                    end)
                    v190.Trove:Connect(RunService.RenderStepped, function() -- line 1138 | captures: v184
                        local TimeLength = v184.Video.TimeLength
                        if not (TimeLength > 0) then
                            return
                        end
                        local Size = v184.Progress.Size
                        local v208 = v184.Video.TimePosition / TimeLength
                        local v209 = math.clamp(v208, 0, 1)
                        v184.Progress.Size = UDim2.new(v209, 0, Size.Y.Scale, Size.Y.Offset)
                    end)
                    v184.Video.Looped = false
                    if v11 ~= nil then
                        v11:Cancel()
                    end
                    v184.Phone.Position = v184.OffscreenPosition
                    v184.Gui.Enabled = true
                    local v210 = { Position = v184.OnscreenPosition }
                    local v211 = TweenService:Create(v184.Phone, v6, v210)
                    v11 = v211
                    v211:Play()
                    local v212, v213 = FeedSequencer.Current(v190.Feed)
                    local v214 = v76[v212]
                    if v214 == nil or v214.Kind ~= "Video" or v214.Disabled == true or TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v214)) then
                        Remotes.Treadmill.RefreshClipCursor:FireServer(v213)
                        v212, v213 = sequencerNextSkippingUnplayable(v190)
                    end
                    loadVideo(v184, v190, v212, v213)
                end
            end
        end
    end
end

local function isPhoneEnabled() -- line 1175 | captures: TreadmillFlags
    return TreadmillFlags.PhoneEnabled:Get()
end

local function bindPhoneTool(v215) -- line 1178 | captures: TreadmillFlags, LocalPlayer, closePhone, openPhone
    if not v215:IsA("Tool") then
        return
    end
    v215.Equipped:Connect(function() -- line 1182 | captures: v215, TreadmillFlags, LocalPlayer, openPhone
        if TreadmillFlags.PhoneEnabled:Get() and v215.Parent == LocalPlayer.Character then
            openPhone()
        end
    end)
    v215.Unequipped:Connect(closePhone)
    if TreadmillFlags.PhoneEnabled:Get() and LocalPlayer.Character ~= nil and v215.Parent == LocalPlayer.Character then
        openPhone()
    end
end

CollectionService:GetInstanceAddedSignal("PhoneTool"):Connect(bindPhoneTool)
for v216, v217 in CollectionService:GetTagged("PhoneTool") do
    bindPhoneTool(v217)
end
LocalPlayer.CharacterRemoving:Connect(function() -- line 1197 | captures: v14, closePhone
    local v218 = v14
    v14 = nil
    if v218 ~= nil then
        v218:Destroy()
    end
    closePhone()
end)

local function buildEquipHintArrow(v219) -- line 1205
    local Frame = Instance.new("Frame")
    Frame.Name = "PhoneEquipHint"
    Frame.AnchorPoint = Vector2.new(0.5, 1)
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.fromScale(0.7, 0.7)
    Frame.Visible = false
    Frame.ZIndex = 30
    v219:Add(Frame)
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "Arrow"
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.Position = UDim2.fromScale(0.5, 0.5)
    ImageLabel.Size = UDim2.fromScale(1, 1)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = "rbxassetid://107875622740177"
    ImageLabel.ScaleType = Enum.ScaleType.Fit
    ImageLabel.Rotation = 90
    ImageLabel.ZIndex = 31
    ImageLabel.Parent = Frame
    Instance.new("UIAspectRatioConstraint").Parent = ImageLabel
    return Frame
end

local function showEquipHint() -- line 1228 | captures: v14, RunService, TreadmillFlags, Trove, Main, resolvePhoneUi, buildEquipHintArrow
    if not (v14 == nil and TreadmillFlags.PhoneEnabled:Get() and resolvePhoneUi() ~= nil) then
        return
    end
    local v220 = Trove.new()
    v14 = v220
    local v221 = buildEquipHintArrow(v220)
    v220:Connect(RunService.RenderStepped, function() -- line 1235 | captures: v221, Main
        local v222 = Main:GetPhoneSlotFrame()
        if v222 == nil then
            v221.Visible = false
        else
            if v221.Parent ~= v222 then
                v221.Parent = v222
            end
            v221.Visible = true
            local v223 = os.clock() * 3.141592653589793 * 2 / 0.9
            local v224 = math.sin(v223) * 6
            v221.Position = UDim2.new(0.5, 0, 0, v224 - 10)
        end
    end)
end

TreadmillFlags.PhoneEnabled.Changed:Connect(function(v225) -- line 1249 | captures: v14, closePhone
    if v225 then
        return
    end
    local v226 = v14
    v14 = nil
    if v226 ~= nil then
        v226:Destroy()
    end
    closePhone()
end)
Remotes.Treadmill.AssignedBeltShifted.OnClientEvent:Connect(function(v227) -- line 1259 | captures: v14, v15, Save, showEquipHint
    if v227 == nil then
        local v228 = v14
        v14 = nil
        if v228 ~= nil then
            v228:Destroy()
        end
    else
        local v229 = Save.Get()
        if not v15 and v229 ~= nil and v229.HasRiddenTreadmill == true and v229.HasEquippedPhone ~= true then
            showEquipHint()
        end
    end
end)
