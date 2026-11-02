-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ContentProvider = game:GetService("ContentProvider")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local AreaEggResetWall = require(ReplicatedStorage.Client.AreaEggResetWall)
require(ReplicatedStorage.Shared.Types.AreaEggs)
local Audio = require(ReplicatedStorage.Shared.Audio)
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local CaptureTheEgg = require(ReplicatedStorage.Data.CaptureTheEgg)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local EggRenderer = require(ReplicatedStorage.Shared.Eggs.EggRenderer)
local EggState = require(ReplicatedStorage.Client.EggState)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local NotificationInstance = require(ReplicatedStorage.Client.Notifications.NotificationInstance)
local PlayVFX = require(ReplicatedStorage.UserGenerated.VFX.PlayVFX)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local SpawnLock = require(ReplicatedStorage.Client.SpawnLock)
local Trove = require(ReplicatedStorage.Packages.Trove)
local EggUidAttribute = CaptureTheEgg.EggUidAttribute
local v1 = { "Leader", "Second", "Third" }
local v2 = { "Leader", "Second", "Third", "You" }
local v3 = {}
local v4 = Color3.fromRGB(255, 214, 89)
local v5 = Color3.fromRGB(213, 213, 213)

v3[1] = v4
v3[2] = v5
v3[3] = Color3.fromRGB(204, 141, 96)

local v6 = UDim2.fromScale(0.5, 0.085)
local v8 = UDim2.fromScale(0.5, 0.2)
local v9 = UDim2.fromScale(0.5, -0.35)
local LocalPlayer = Players.LocalPlayer
local v10
local v11 = {}
local v13 = {}
local v14 = 0
local UserId
local v15 = false
local Uid, v16
local v17 = false
local v18 = false
local v19 = false
local v20 = not AreaEggResetWall.IsSealed()
local v21 = 0
local v22
local v23 = 0
local v24 = 0
local v25 = false
local v26 = false
local v27 = false
local v28 = 0
local v29 = false
local v30, v31, v32, v33
local v34 = {}
local v35 = {}
local v36 = {}
local v37 = {}

local function cancelTween(v38) -- line 69
    if v38 ~= nil then
        v38:Cancel()
    end
end

local function formatSeconds(v39) -- line 74
    local format = string.format
    local v40 = math.max(v39, 0) * 10
    return format("%.1f", math.floor(v40) / 10)
end

local function easeOutQuint(v41) -- line 77
    return 1 - (1 - v41) ^ 5
end

local function easeInOutCubic(v42) -- line 80
    if v42 < 0.5 then
        return v42 * 4 * v42 * v42
    end
    return 1 - (v42 * -2 + 2) ^ 3 / 2
end

local function warnMissingAssetOnce(v43, v44) -- line 86 | captures: v36
    if not v36[v43] then
        v36[v43] = true
        warn(v44)
    end
end

local function getScoreboardUi() -- line 93 | captures: v10, v27, v2, LocalPlayer
    local v45 = v10
    if v45 == nil then
        local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        local v46 = PlayerGui and PlayerGui:FindFirstChild("CaptureTheEggUI")
        local Board, v47, v48
        if v46 == nil then
            v48 = true
        elseif v46:IsA("ScreenGui") then
            Board = v46:FindFirstChild("Board")
            v47 = Board and Board:FindFirstChild("Rows")
            v48 = false
        else
            v48 = true
        end
        if not v48 then
            local v49
            if Board == nil then
                v49 = true
            elseif Board:IsA("Frame") then
                if v47 == nil then
                    v49 = true
                elseif v47:IsA("Frame") then
                    local UIListLayout = v47:FindFirstChildOfClass("UIListLayout")
                    if UIListLayout ~= nil then
                        UIListLayout:Destroy()
                    end
                    v49 = false
                else
                    v49 = true
                end
            else
                v49 = true
            end
            if not v49 then
                local v50 = {}
                for v51, v52 in v2 do
                    local v53 = v47:FindFirstChild(v52)
                    local v54 = v53 and v53:FindFirstChild("Avatar")
                    local v55 = v54 and v54:FindFirstChild("Timer")
                    if v53 == nil then
                        if not v27 then
                            v27 = true
                            warn((("[CaptureTheEgg] CaptureTheEggUI is missing its %* card."):format(v52)))
                        end
                        return nil
                    end
                    if v53:IsA("Frame") then
                        if v54 == nil then
                            if not v27 then
                                v27 = true
                                warn((("[CaptureTheEgg] CaptureTheEggUI is missing its %* card."):format(v52)))
                            end
                            return nil
                        end
                        if v54:IsA("ImageLabel") then
                            if v55 == nil then
                                if not v27 then
                                    v27 = true
                                    warn((("[CaptureTheEgg] CaptureTheEggUI is missing its %* card."):format(v52)))
                                end
                                return nil
                            end
                            if v55:IsA("TextLabel") then
                                local UIScale = v53:FindFirstChildOfClass("UIScale")
                                if UIScale == nil then
                                    UIScale = Instance.new("UIScale")
                                    UIScale.Name = "UIScale"
                                    UIScale.Parent = v53
                                end
                                v53.AnchorPoint = Vector2.new(0.5, 0.5)
                                v53.Position = UDim2.fromScale(0.5, 0.5)
                                v53.Visible = false
                                UIScale.Scale = 0.72
                                v50[v52] = {
                                    Token = 0,
                                    Name = v52,
                                    Frame = v53,
                                    Avatar = v54,
                                    Timer = v55,
                                    Scale = UIScale
                                }
                            else
                                if not v27 then
                                    v27 = true
                                    warn((("[CaptureTheEgg] CaptureTheEggUI is missing its %* card."):format(v52)))
                                end
                                return nil
                            end
                        else
                            if not v27 then
                                v27 = true
                                warn((("[CaptureTheEgg] CaptureTheEggUI is missing its %* card."):format(v52)))
                            end
                            return nil
                        end
                    else
                        if not v27 then
                            v27 = true
                            warn((("[CaptureTheEgg] CaptureTheEggUI is missing its %* card."):format(v52)))
                        end
                        return nil
                    end
                end
                local v56 = {
                    Gui = v46,
                    Board = Board,
                    Rows = v47,
                    Cards = v50
                }
                v10 = v56
                v27 = false
                return v56
            end
            if not v27 then
                v27 = true
                warn("[CaptureTheEgg] CaptureTheEggUI is stale; it needs a Board frame with a Rows frame.")
            end
            return nil
        end
        if not v27 then
            v27 = true
            warn("[CaptureTheEgg] CaptureTheEggUI is missing from StarterGui.")
        end
        return nil
    end
    if v45.Gui.Parent == nil then
        return
    end
    return v45
end

local function applyBoardVisibility(v57) -- line 174 | captures: v15, v17, v18, v19, v20, v22, v23, TweenService, v6, v8, v9, getScoreboardUi
    local v58 = getScoreboardUi()
    if v58 == nil then
        return
    end
    local Gui = v58.Gui
    local Board = v58.Board
    local v59 = v17 and not v19 and v20
    if v59 == v18 then
        if not v57 and v59 then
            Gui.Enabled = true
        end
    else
        v23 += 1
        local v60 = v23
        local v61 = v22
        if v61 ~= nil then
            v61:Cancel()
        end
        v22 = nil
        if v59 then
            local v62 = if v15 then v8 else v6
            Gui.Enabled = true
            if not v18 then
                Board.Position = v9
            end
            v18 = true
            if v57 then
                Board.Position = v62
            else
                local v63 = TweenInfo.new(0.42, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                v22 = TweenService:Create(Board, v63, { Position = v62 })
                v22:Play()
            end
        else
            v18 = false
            if v57 then
                Board.Position = v9
                Gui.Enabled = false
            elseif Gui.Enabled then
                local v64 = TweenInfo.new(0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                v22 = TweenService:Create(Board, v64, { Position = v9 })
                v22:Play()
                v22.Completed:Once(function() -- line 210 | captures: Gui, v60, v18, v23
                    if v60 == v23 and not v18 then
                        Gui.Enabled = false
                    end
                end)
            else
                Board.Position = v9
            end
        end
    end
end

local function setBoardShown(v65, v66) -- line 242 | captures: v17, applyBoardVisibility
    v17 = v65
    applyBoardVisibility(v66)
end

local function setTopNotificationAreaBusy(v67) -- line 246 | captures: v19, applyBoardVisibility
    if v19 ~= v67 then
        v19 = v67
        applyBoardVisibility()
    end
end

local function setWallIsDown(v68) -- line 253 | captures: v20, applyBoardVisibility
    if v20 ~= v68 then
        v20 = v68
        applyBoardVisibility()
    end
end

local function setLocalPlayerCarryingEgg(v69) -- line 260 | captures: v15, v18, v22, v23, TweenService, v6, v8, getScoreboardUi
    if v15 ~= v69 then
        v15 = v69
        if v18 then
            local v70 = getScoreboardUi()
            local v71
            if v70 == nil then
                v71 = true
            elseif v70.Gui.Enabled then
                v23 += 1
                local v72 = v22
                if v72 ~= nil then
                    v72:Cancel()
                end
                v71 = false
            else
                v71 = true
            end
            if v71 then
                return
            end
            local v73 = TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
            local v74 = {}
            if v69 then
                v74.Position = v8
            else
                v74.Position = v6
            end
            v22 = TweenService:Create(v70.Board, v73, v74)
            v22:Play()
        end
    end
end

local function cancelCardTweens(v75) -- line 289
    local MoveTween = v75.MoveTween
    if MoveTween ~= nil then
        MoveTween:Cancel()
    end
    local ScaleTween = v75.ScaleTween
    if ScaleTween ~= nil then
        ScaleTween:Cancel()
    end
    local AvatarTween = v75.AvatarTween
    if AvatarTween ~= nil then
        AvatarTween:Cancel()
    end
    local TimerTween = v75.TimerTween
    if TimerTween ~= nil then
        TimerTween:Cancel()
    end
    v75.MoveTween = nil
    v75.ScaleTween = nil
    v75.AvatarTween = nil
    v75.TimerTween = nil
end

local function removeTransferGhost(v76) -- line 311 | captures: v11
    local v77 = table.find(v11, v76)
    if v77 ~= nil then
        table.remove(v11, v77)
    end
    v76:Destroy()
end

local function clearTransferGhosts() -- line 318 | captures: v11
    for v78, v79 in v11 do
        v79:Destroy()
    end
    table.clear(v11)
end

local function cardWidthScale(v80, v81) -- line 327
    local AbsoluteSize = v80.Rows.AbsoluteSize
    if not (AbsoluteSize.X <= 0) and AbsoluteSize.Y > 0 then
        return v81.Frame.Size.Y.Scale * AbsoluteSize.Y / AbsoluteSize.X
    end
    return v81.Frame.Size.X.Scale
end

local function calculateCardPositions(v82, v83) -- line 337
    local v84 = {}
    local v85 = #v83 - 1
    local v86, v87 = nil, math.max(v85, 0) * 0.025
    for v88, v89 in v83 do
        local State = v89.State
        local AbsoluteSize = v82.Rows.AbsoluteSize
        if AbsoluteSize.X <= 0 then
            v86 = State.Frame.Size.X.Scale
        elseif AbsoluteSize.Y > 0 then
            v86 = State.Frame.Size.Y.Scale * AbsoluteSize.Y / AbsoluteSize.X
        end
        v87 += v86
    end
    local v90, v91 = nil, 0.5 - v87 * 0.5
    for v92, v93 in v83 do
        local State = v93.State
        local AbsoluteSize = v82.Rows.AbsoluteSize
        if AbsoluteSize.X <= 0 then
            v90 = State.Frame.Size.X.Scale
        elseif AbsoluteSize.Y > 0 then
            v90 = State.Frame.Size.Y.Scale * AbsoluteSize.Y / AbsoluteSize.X
        end
        v84[v93.State.Name] = UDim2.fromScale(v91 + v90 * 0.5, 0.5)
        v91 += v90 + 0.025
    end
    return v84
end

local function createTransferGhost(v94, v95, v96, v97) -- line 372 | captures: TweenService, v11
    local AbsoluteSize = v94.Rows.AbsoluteSize
    if not (AbsoluteSize.X <= 0) and not (AbsoluteSize.Y <= 0) and not (v95.Avatar.AbsoluteSize.X <= 0) then
        local v98 = v95.Avatar.AbsolutePosition + v95.Avatar.AbsoluteSize * 0.5 - v94.Rows.AbsolutePosition
        local v99 = v95.Avatar:Clone()
        v99.Name = ("Transfer_%*"):format(v95.UserId or 0)
        for v100, v101 in v99:GetDescendants() do
            if v101:IsA("TextLabel") then
                v101:Destroy()
            end
        end
        v99.AnchorPoint = Vector2.new(0.5, 0.5)
        v99.Position = UDim2.fromScale(v98.X / AbsoluteSize.X, v98.Y / AbsoluteSize.Y)
        v99.Size = UDim2.fromScale(v95.Avatar.AbsoluteSize.X / AbsoluteSize.X, v95.Avatar.AbsoluteSize.Y / AbsoluteSize.Y)
        v99.ZIndex = 30
        v99.Parent = v94.Rows
        table.insert(v11, v99)
        local fromScale = UDim2.fromScale
        local AbsoluteSize_2 = v94.Rows.AbsoluteSize
        local v102 = if AbsoluteSize_2.X <= 0 or AbsoluteSize_2.Y <= 0 then v96.Frame.Size.X.Scale else v96.Frame.Size.Y.Scale * AbsoluteSize_2.Y / AbsoluteSize_2.X
        local v103 = fromScale(v102, v96.Frame.Size.Y.Scale)
        local v104 = TweenInfo.new(0.38, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local v105 = TweenService:Create(v99, v104, {
            ImageTransparency = 0.35,
            Position = v97,
            Size = v103
        })
        v105:Play()
        v105.Completed:Once(function() -- line 405 | captures: v99, v11
            local v106 = table.find(v11, v99)
            if v106 ~= nil then
                table.remove(v11, v106)
            end
            v99:Destroy()
        end)
        return true
    end
    return false
end

local function showCard(v107, v108) -- line 415 | captures: TweenService
    local v109 = v107.Frame.Visible and v107.UserId ~= nil
    v107.Token += 1
    local MoveTween = v107.MoveTween
    if MoveTween ~= nil then
        MoveTween:Cancel()
    end
    local ScaleTween = v107.ScaleTween
    if ScaleTween ~= nil then
        ScaleTween:Cancel()
    end
    if not v109 then
        v107.Frame.Position = v108 + UDim2.fromScale(0, -0.32)
        v107.Scale.Scale = 0.72
    end
    v107.Frame.Visible = true
    local v110 = TweenInfo.new(0.42, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local v111 = { Position = v108 }
    v107.MoveTween = TweenService:Create(v107.Frame, v110, v111)
    local v112 = if v109 then 0.24 else 0.46
    local v113 = TweenInfo.new(v112, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    v107.ScaleTween = TweenService:Create(v107.Scale, v113, { Scale = 1 })
    v107.MoveTween:Play()
    v107.ScaleTween:Play()
end

local function hideCard(v114, v115) -- line 447 | captures: TweenService
    if v114.Frame.Visible then
        v114.Token += 1
        local Token = v114.Token
        local MoveTween = v114.MoveTween
        if MoveTween ~= nil then
            MoveTween:Cancel()
        end
        local ScaleTween = v114.ScaleTween
        if ScaleTween ~= nil then
            ScaleTween:Cancel()
        end
        local AvatarTween = v114.AvatarTween
        if AvatarTween ~= nil then
            AvatarTween:Cancel()
        end
        local TimerTween = v114.TimerTween
        if TimerTween ~= nil then
            TimerTween:Cancel()
        end
        v114.MoveTween = nil
        v114.ScaleTween = nil
        v114.AvatarTween = nil
        v114.TimerTween = nil
        v114.UserId = nil
        v114.Rank = nil
        if v115 then
            v114.Frame.Visible = false
            v114.Frame.Position = UDim2.fromScale(0.5, 0.5)
            v114.Scale.Scale = 0.72
            v114.Avatar.ImageTransparency = 0
            v114.Timer.TextTransparency = 0
        else
            local Frame = v114.Frame
            local v116 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            v114.MoveTween = TweenService:Create(Frame, v116, { Position = v114.Frame.Position + UDim2.fromScale(0, 0.18) })
            local Scale = v114.Scale
            local v117 = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In)
            v114.ScaleTween = TweenService:Create(Scale, v117, { Scale = 0.72 })
            v114.MoveTween:Play()
            v114.ScaleTween:Play()
            v114.ScaleTween.Completed:Once(function() -- line 491 | captures: v114, Token
                if v114.Token == Token and v114.UserId == nil then
                    v114.Frame.Visible = false
                end
            end)
        end
    elseif v114.UserId == nil then
    end
end

local function setCardEntry(v118, v119, v120, v121) -- line 501 | captures: TweenService, v3
    local v122 = v118.UserId ~= v119.UserId
    local format = string.format
    local Seconds = v119.Seconds
    local v123 = math.max(Seconds, 0) * 10
    local v124 = format("%.1f", math.floor(v123) / 10)
    local v125 = v118.Timer.Text ~= v124
    v118.Token += 1
    local Token = v118.Token
    local AvatarTween = v118.AvatarTween
    if AvatarTween ~= nil then
        AvatarTween:Cancel()
    end
    local TimerTween = v118.TimerTween
    if TimerTween ~= nil then
        TimerTween:Cancel()
    end
    v118.UserId = v119.UserId
    v118.Rank = v120
    v118.Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(v119.UserId)
    v118.Timer.Text = v124
    local UIStroke = v118.Avatar:FindFirstChildOfClass("UIStroke")
    if UIStroke ~= nil then
        if v120 == nil then
            UIStroke.Color = v118.Frame.BackgroundColor3
        else
            UIStroke.Color = v3[v120]
        end
    end
    if v122 then
        local v126 = if v121 then 1 else 0.52
        v118.Avatar.ImageTransparency = v126
        v118.Timer.TextTransparency = 1
        local v127 = if v121 then 0.2356 else 0
        task.delay(v127, function() -- line 546 | captures: v118, v119, Token, TweenService
            if not (v118.Token == Token and v118.UserId == v119.UserId) then
                return
            end
            local v128 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            v118.AvatarTween = TweenService:Create(v118.Avatar, v128, { ImageTransparency = 0 })
            local v129 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            v118.TimerTween = TweenService:Create(v118.Timer, v129, { TextTransparency = 0 })
            v118.AvatarTween:Play()
            v118.TimerTween:Play()
        end)
    else
        if v118.Avatar.ImageTransparency > 0 then
            local Avatar = v118.Avatar
            local v130 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            v118.AvatarTween = TweenService:Create(Avatar, v130, { ImageTransparency = 0 })
            v118.AvatarTween:Play()
        end
        if v125 then
            local Timer = v118.Timer
            local TextTransparency = v118.Timer.TextTransparency
            Timer.TextTransparency = math.max(TextTransparency, 0.28)
            local Timer_2 = v118.Timer
            local v131 = TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
            v118.TimerTween = TweenService:Create(Timer_2, v131, { TextTransparency = 0 })
            v118.TimerTween:Play()
        elseif v118.Timer.TextTransparency > 0 then
            local Timer = v118.Timer
            local TextTransparency = v118.Timer.TextTransparency
            Timer.TextTransparency = math.max(TextTransparency, 0.28)
            local Timer_2 = v118.Timer
            local v132 = TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
            v118.TimerTween = TweenService:Create(Timer_2, v132, { TextTransparency = 0 })
            v118.TimerTween:Play()
        end
    end
end

local function pulseLeader(v133) -- line 581 | captures: TweenService, v3
    local ScaleTween = v133.ScaleTween
    if ScaleTween ~= nil then
        ScaleTween:Cancel()
    end
    v133.Scale.Scale = 1.16
    local v134 = TweenInfo.new(0.62, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
    local v135 = { Scale = 1 }
    v133.ScaleTween = TweenService:Create(v133.Scale, v134, v135)
    v133.ScaleTween:Play()
    local UIStroke = v133.Avatar:FindFirstChildOfClass("UIStroke")
    if UIStroke == nil then
        return
    end
    UIStroke.Color = Color3.new(1, 1, 1)
    UIStroke.Thickness = 4
    local v136 = TweenInfo.new(0.62, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    TweenService:Create(UIStroke, v136, {
        Thickness = 2,
        Color = v3[1]
    }):Play()
end

local function buildCardAssignments(v137, v138) -- line 599 | captures: v1, LocalPlayer
    local v139 = {}
    local v140 = #v138
    local v141 = #v1
    local v142 = math.min(v140, v141)
    local v143 = false
    for v144 = 1, v142 do
        v143 = v143 or v138[v144].UserId == LocalPlayer.UserId
        local v145 = {
            State = v7.Cards[v1[v144]],
            Entry = v138[v144],
            Rank = v144
        }
        table.insert(v139, v145)
    end
    if not v143 then
        local v146
        for v147, v148 in v138 do
            if v148.UserId == LocalPlayer.UserId then
                v146 = v148
                break
            end
            v146 = nil
        end
        if v146 == nil then
            v146 = {
                Seconds = 0,
                UserId = LocalPlayer.UserId,
                Name = LocalPlayer.DisplayName
            }
        end
        local v149 = {
            State = v7.Cards.You,
            Entry = v146
        }
        table.insert(v139, v149)
    end
    return v139
end

local function reconcileScoreboard(v150) -- line 632 | captures: UserId, v18, getScoreboardUi, calculateCardPositions, createTransferGhost, showCard, hideCard, setCardEntry, pulseLeader, buildCardAssignments
    local v151 = getScoreboardUi()
    if v151 == nil then
        return
    end
    local v152 = buildCardAssignments(v151, v150)
    local v153 = calculateCardPositions(v151, v152)
    local v154 = {}
    for v155, v156 in v151.Cards do
        if v156.Frame.Visible and v156.UserId ~= nil then
            v154[v156.UserId] = v156
        end
    end
    local v157 = {}
    if v18 and v151.Gui.Enabled then
        for v158, v159 in v152 do
            local v160 = v154[v159.Entry.UserId]
            if v160 ~= nil and v160 ~= v159.State then
                v157[v159.State.Name] = createTransferGhost(v151, v160, v159.State, v153[v159.State.Name])
            end
        end
    end
    local v161 = {}
    for v162, v163 in v152 do
        local State = v163.State
        v161[State.Name] = true
        showCard(State, v153[State.Name])
        local v164 = v157[State.Name] == true
        setCardEntry(State, v163.Entry, v163.Rank, v164)
    end
    for v165, v166 in v151.Cards do
        if not v161[v165] then
            hideCard(v166)
        end
    end
    local UserId_2
    if #v12 <= 0 then
    else
        UserId_2 = v12[1].UserId
    end
    if UserId ~= nil and UserId_2 ~= nil and UserId ~= UserId_2 then
        pulseLeader(v151.Cards.Leader)
    end
    UserId = UserId_2
end

local function sanitizeEntries(v167) -- line 691
    local v168 = {}
    local v169 = {}
    for v170, v171 in v167 do
        if type(v171) == "table" then
            local UserId = v171.UserId
            if type(UserId) == "number" then
                local Name = v171.Name
                if type(Name) == "string" then
                    local Seconds = v171.Seconds
                    if type(Seconds) == "number" and v171.Seconds == v171.Seconds and not v169[v171.UserId] then
                        v169[v171.UserId] = true
                        local v172 = {
                            UserId = v171.UserId,
                            Name = v171.Name
                        }
                        local Seconds = v171.Seconds
                        v172.Seconds = math.max(Seconds, 0)
                        table.insert(v168, v172)
                    end
                end
            end
        end
    end
    return v168
end

local function renderScoreboard(v173) -- line 705 | captures: v13, v14, v17, v25, v26, v29, Workspace, applyBoardVisibility, reconcileScoreboard, sanitizeEntries
    local v174 = sanitizeEntries(v173)
    v13 = v174
    v14 = os.clock()
    if not v25 and Workspace:GetAttribute("Event_CaptureTheEgg") == true then
        v25 = true
    end
    if not v25 then
        return
    end
    v26 = Workspace:GetAttribute("Event_CaptureTheEggGameplay") == true
    reconcileScoreboard(v174)
    v17 = not (not (v25 and v26) or v29)
    applyBoardVisibility(nil)
end

local function updateLiveTimers() -- line 731 | captures: v10, v13, v14, v18, Workspace, EggState, EggUidAttribute
    local v175 = v10
    if not (v175 ~= nil and v18 and v175.Gui.Enabled) then
        return
    end
    local v176 = os.clock() - v14
    if not (v176 <= 0 or v176 > 2) then
        local v177 = Workspace:GetAttribute(EggUidAttribute)
        if type(v177) == "string" then
            local v178 = EggState.ReadFieldEgg(v177)
            local CarrierUserId
            if v178 == nil then
            else
                CarrierUserId = v178.CarrierUserId
            end
            if CarrierUserId ~= nil then
                for v179, v180 in v175.Cards do
                    if v180.Frame.Visible and v180.UserId == CarrierUserId then
                        for v181, v182 in v13 do
                            if v182.UserId == CarrierUserId then
                                local format = string.format
                                local v183 = v182.Seconds + v176
                                local v184 = math.max(v183, 0) * 10
                                local v185 = format("%.1f", math.floor(v184) / 10)
                                if v180.Timer.Text ~= v185 then
                                    v180.Timer.Text = v185
                                end
                                return
                            end
                        end
                        return
                    end
                end
            end
        end
    end
end

local function resetScoreboardCards() -- line 776 | captures: v13, UserId, v11, getScoreboardUi
    for v186, v187 in v11 do
        v187:Destroy()
    end
    table.clear(v11)
    local v188 = getScoreboardUi()
    if v188 ~= nil then
        for v189, v190 in v188.Cards do
            if v190.Frame.Visible then
                v190.Token += 1
                local MoveTween = v190.MoveTween
                if MoveTween ~= nil then
                    MoveTween:Cancel()
                end
                local ScaleTween = v190.ScaleTween
                if ScaleTween ~= nil then
                    ScaleTween:Cancel()
                end
                local AvatarTween = v190.AvatarTween
                if AvatarTween ~= nil then
                    AvatarTween:Cancel()
                end
                local TimerTween = v190.TimerTween
                if TimerTween ~= nil then
                    TimerTween:Cancel()
                end
                v190.MoveTween = nil
                v190.ScaleTween = nil
                v190.AvatarTween = nil
                v190.TimerTween = nil
                v190.UserId = nil
                v190.Rank = nil
                v190.Frame.Visible = false
                v190.Frame.Position = UDim2.fromScale(0.5, 0.5)
                v190.Scale.Scale = 0.72
                v190.Avatar.ImageTransparency = 0
                v190.Timer.TextTransparency = 0
            elseif v190.UserId == nil then
            end
        end
    end
    UserId = nil
    v13 = {}
end

local function refreshScoreboardAvailability() -- line 827 | captures: v13, v17, v25, v26, v29, Workspace, applyBoardVisibility, reconcileScoreboard
    if not v25 and Workspace:GetAttribute("Event_CaptureTheEgg") == true then
        v25 = true
    end
    v26 = v25 and Workspace:GetAttribute("Event_CaptureTheEggGameplay") == true
    if not v26 or v29 then
        v17 = false
    else
        reconcileScoreboard(v13)
        v17 = true
    end
    applyBoardVisibility(nil)
end

local function resolveAsset(v191, v192) -- line 845 | captures: ReplicatedStorage
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local v193 = Assets and Assets:FindFirstChild(v191)
    return v193 and v193:FindFirstChild(v192)
end

local function playSound(v194, v195, v196) -- line 857 | captures: ReplicatedStorage, Audio, v36
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local v197 = Assets and Assets:FindFirstChild("Sounds")
    local v198 = v197 and v197:FindFirstChild(v194)
    local v199, v200
    if v198 == nil then
        v200 = true
    elseif v198:IsA("Sound") then
        v199 = v196 or script
        v200 = false
    else
        v200 = true
    end
    if not v200 then
        local v201, v202 = pcall(Audio.Play, v198, v199)
        if v201 then
            if v202 ~= nil and v202.Parent ~= nil then
                if v196 == nil then
                    v195:Add(v202)
                end
                return v202
            end
        else
            warn((("[CaptureTheEgg] %* failed to play: %*"):format(v194, v202)))
        end
        return nil
    end
    local v203 = ("[CaptureTheEgg] Missing ReplicatedStorage.Assets.Sounds.%*; the cinematic will continue without it."):format(v194)
    if not v36[v194] then
        v36[v194] = true
        warn(v203)
    end
    return nil
end

local function emitImpactVfx(v204) -- line 893 | captures: Debris, ReplicatedStorage, Workspace, PlayVFX, v36
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local v205 = Assets and Assets:FindFirstChild("Particles")
    local v206 = v205 and v205:FindFirstChild("BigHitGroundAttach")
    if v206 == nil then
        if not v36.BigHitGroundAttach then
            v36.BigHitGroundAttach = true
            warn("[CaptureTheEgg] Missing ReplicatedStorage.Assets.Particles.BigHitGroundAttach; impact VFX was skipped.")
        end
    elseif v206:IsA("ParticleEmitter") then
        local Part = Instance.new("Part")
        Part.Name = "CaptureTheEggImpactVFX"
        Part.Anchored = true
        Part.CanCollide = false
        Part.CanQuery = false
        Part.CanTouch = false
        Part.CastShadow = false
        Part.Transparency = 1
        Part.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
        Part.CFrame = v204
        Part.Parent = Workspace:FindFirstChild("__DEBRIS") or Workspace
        Debris:AddItem(Part, 10)
        local v207 = v206:Clone()
        local v208, v209 = pcall(PlayVFX, Part, v204, v207)
        if not v208 then
            v207:Destroy()
            warn((("[CaptureTheEgg] BigHitGroundAttach failed to play: %*"):format(v209)))
        end
    elseif v206:FindFirstChildWhichIsA("ParticleEmitter", true) == nil and not v36.BigHitGroundAttachEmitter then
        v36.BigHitGroundAttachEmitter = true
        warn("[CaptureTheEgg] BigHitGroundAttach has no ParticleEmitter descendants; impact VFX was skipped.")
    end
end

local function preloadCutsceneAssets(v210) -- line 945 | captures: ContentProvider, ReplicatedStorage, CaptureTheEgg, EggRecords, EggRenderer, v35
    if v35[v210] then
        return
    end
    v35[v210] = true
    task.spawn(function() -- line 950 | captures: v210, ContentProvider, ReplicatedStorage, CaptureTheEgg, EggRecords, EggRenderer
        local v211 = {}
        local v212 = {}
        local v213 = {}
        local v214 = { "Sounds", "ImpactBoom" }
        v213[1] = { "Sounds", "CinematicRiser" }
        v213[2] = { "Sounds", "CinematicBoom" }
        v213[3] = v214
        v213[4] = { "Particles", "BigHitGroundAttach" }
        for v215, v216 in v213 do
            local Assets = ReplicatedStorage:FindFirstChild("Assets")
            local v217 = Assets and Assets:FindFirstChild(v216[1])
            local v218 = v217 and v217:FindFirstChild(v216[2])
            if v218 ~= nil then
                table.insert(v211, v218)
            end
        end
        local v219, v220 = pcall(function() -- line 976 | captures: v210, EggRecords, EggRenderer
            return EggRenderer.GetTemplate(EggRecords.NewEgg(v210))
        end)
        if v219 and typeof(v220) == "Instance" then
            table.insert(v211, v220)
        end
        for v221, v222 in {
                CaptureTheEgg.DanceAnimationId,
                CaptureTheEgg.R6DanceAnimationId
            } do
            local Animation = Instance.new("Animation")
            Animation.AnimationId = v222
            table.insert(v211, Animation)
            table.insert(v212, Animation)
        end
        if #v211 > 0 then
            pcall(ContentProvider.PreloadAsync, ContentProvider, v211)
        end
        for v223, v224 in v212 do
            v224:Destroy()
        end
    end)
end

local function resolvePreloadCategory(v225) -- line 1002 | captures: CaptureTheEgg
    local v226 = type(v225) == "table"
    local v227
    if v226 then
        local EggCategory = v225.EggCategory
        v227 = type(EggCategory) == "string"
    end
    if not v226 or not v227 then
        return CaptureTheEgg.CarryCategory
    end
    if v225.EggCategory == "" then
        return CaptureTheEgg.CarryCategory
    end
    return v225.EggCategory
end

local function ensureOverlay() -- line 1011 | captures: v33, LocalPlayer
    local v228 = v33
    local ScreenGui
    if v228 == nil then
        local ScreenGui_2 = Instance.new("ScreenGui")
        ScreenGui = ScreenGui_2
        ScreenGui_2.Name = "CaptureTheEggCinematic"
        ScreenGui_2.IgnoreGuiInset = true
        ScreenGui_2.ResetOnSpawn = false
        ScreenGui_2.DisplayOrder = 50
        ScreenGui_2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Name = "Vignette"
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.Image = "rbxassetid://104574024062008"
        ImageLabel.ImageColor3 = Color3.new(0, 0, 0)
        ImageLabel.ImageTransparency = 1
        ImageLabel.ScaleType = Enum.ScaleType.Stretch
        ImageLabel.Size = UDim2.fromScale(1, 1)
        ImageLabel.ZIndex = 1
        ImageLabel.Parent = ScreenGui_2

        local function createBar(v229, v230) -- line 1031 | captures: ScreenGui
            local Frame = Instance.new("Frame")
            Frame.Name = v229
            Frame.BackgroundColor3 = Color3.new(0, 0, 0)
            Frame.BorderSizePixel = 0
            Frame.Position = v230
            Frame.Size = UDim2.fromScale(1, 0.11)
            Frame.ZIndex = 2
            Frame.Parent = ScreenGui
            return Frame
        end

        local Top = createBar("Top", UDim2.fromScale(0, -0.11))
        local Bottom = createBar("Bottom", UDim2.fromScale(0, 1))
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        ScreenGui.Parent = PlayerGui
        local v231 = {
            Gui = ScreenGui,
            Top = Top,
            Bottom = Bottom,
            Vignette = ImageLabel
        }
        v33 = v231
        return v231
    end
    if v228.Gui.Parent == nil then
        local ScreenGui_2 = Instance.new("ScreenGui")
        ScreenGui = ScreenGui_2
        ScreenGui_2.Name = "CaptureTheEggCinematic"
        ScreenGui_2.IgnoreGuiInset = true
        ScreenGui_2.ResetOnSpawn = false
        ScreenGui_2.DisplayOrder = 50
        ScreenGui_2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Name = "Vignette"
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.Image = "rbxassetid://104574024062008"
        ImageLabel.ImageColor3 = Color3.new(0, 0, 0)
        ImageLabel.ImageTransparency = 1
        ImageLabel.ScaleType = Enum.ScaleType.Stretch
        ImageLabel.Size = UDim2.fromScale(1, 1)
        ImageLabel.ZIndex = 1
        ImageLabel.Parent = ScreenGui_2

        local function createBar(v232, v233) -- line 1068 | captures: ScreenGui
            local Frame = Instance.new("Frame")
            Frame.Name = v232
            Frame.BackgroundColor3 = Color3.new(0, 0, 0)
            Frame.BorderSizePixel = 0
            Frame.Position = v233
            Frame.Size = UDim2.fromScale(1, 0.11)
            Frame.ZIndex = 2
            Frame.Parent = ScreenGui
            return Frame
        end

        local Top = createBar("Top", UDim2.fromScale(0, -0.11))
        local Bottom = createBar("Bottom", UDim2.fromScale(0, 1))
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        ScreenGui.Parent = PlayerGui
        local v234 = {
            Gui = ScreenGui,
            Top = Top,
            Bottom = Bottom,
            Vignette = ImageLabel
        }
        v33 = v234
        return v234
    end
    return v228
end

local function setOverlayShown(v235) -- line 1086 | captures: v34, TweenService, ensureOverlay
    for v236, v237 in v34 do
        v237:Cancel()
    end
    table.clear(v34)
    local v238 = ensureOverlay()
    local v239 = if v235 then Enum.EasingDirection.Out else Enum.EasingDirection.In
    local v240 = TweenInfo.new(0.9, Enum.EasingStyle.Quint, v239)
    local v241 = {}
    local v242 = {}
    if v235 then
        v242.Position = UDim2.fromScale(0, 0)
    else
        v242.Position = UDim2.fromScale(0, -0.11)
    end
    local v243 = TweenService:Create(v238.Top, v240, v242)
    local v244 = {}
    if v235 then
        v244.Position = UDim2.fromScale(0, 0.89)
    else
        v244.Position = UDim2.fromScale(0, 1)
    end
    local v245 = TweenService:Create(v238.Bottom, v240, v244)
    local v246 = {}
    if v235 then
        v246.ImageTransparency = 0.3
    else
        v246.ImageTransparency = 1
    end
    v241[1] = v243
    v241[2] = v245
    v241[3] = TweenService:Create(v238.Vignette, v240, v246)
    v34 = v241
    for v247, v248 in v34 do
        v248:Play()
    end
end

local function cloneStarterCharacter(v249) -- line 1137 | captures: Players, ReplicatedStorage, CaptureTheEgg, v36
    local v250 = Players:GetPlayerByUserId(v249)
    local v251 = v250 and v250.Character
    if v251 == nil then
        local v252 = ReplicatedStorage:FindFirstChild(CaptureTheEgg.StarterRigName)
        if v252 ~= nil and v252:IsA("Model") then
            v251 = v252
        end
    end
    if v251 == nil then
        return nil
    end
    v251.Archivable = true
    local v253 = v251:Clone()
    v251.Archivable = false
    local v254 = v253:FindFirstChild("HumanoidRootPart", true)
    if v254 == nil then
        v254 = v253.PrimaryPart
    elseif not v254:IsA("BasePart") then
        v254 = nil
    end
    if v254 == nil then
        v253:Destroy()
        if not v36.DanceRigRoot then
            v36.DanceRigRoot = true
            warn("[CaptureTheEgg] The starter's cloned character has no root part.")
        end
        return nil
    end
    v253.PrimaryPart = v254
    for v255, v256 in v253:GetDescendants() do
        if v256:IsA("BasePart") then
            v256.Anchored = v256 == v254
            v256.CanCollide = false
            v256.CanQuery = false
            v256.CanTouch = false
            v256.Massless = v256 ~= v254
        elseif v256:IsA("Script") then
            v256:Destroy()
        elseif v256:IsA("LocalScript") then
        end
    end
    local Humanoid = v253:FindFirstChildOfClass("Humanoid")
    if Humanoid ~= nil then
        Humanoid.AutoRotate = false
        Humanoid.BreakJointsOnDeath = false
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    end
    return v253
end

local function playDance(v257) -- line 1193 | captures: CaptureTheEgg, v36
    local Humanoid = v257:FindFirstChildOfClass("Humanoid")
    if Humanoid == nil then
        if not v36.DanceHumanoid then
            v36.DanceHumanoid = true
            warn("[CaptureTheEgg] The starter's dancer rig has no Humanoid.")
        end
    else
        local Animator = Humanoid:FindFirstChildOfClass("Animator")
        if Animator == nil then
            Animator = Instance.new("Animator")
            Animator.Parent = Humanoid
        end
        for v258, v259 in Animator:GetPlayingAnimationTracks() do
            v259:Stop(0)
        end
        local Animation = Instance.new("Animation")
        if Humanoid.RigType == Enum.HumanoidRigType.R6 then
            Animation.AnimationId = CaptureTheEgg.R6DanceAnimationId
        else
            Animation.AnimationId = CaptureTheEgg.DanceAnimationId
        end
        Animation.Parent = v257
        local v260, v261 = pcall(Animator.LoadAnimation, Animator, Animation)
        if v260 then
            v261.Priority = Enum.AnimationPriority.Action
            v261.Looped = true
            v261:Play(0.1, 1, 1)
        else
            warn((("[CaptureTheEgg] Could not load the starter dance: %*"):format(v261)))
        end
    end
end

local function getModelTopOffset(v262) -- line 1231
    local v263, v264 = v262:GetBoundingBox()
    return v263.Position.Y + v264.Y * 0.5 - v262:GetPivot().Position.Y
end

local function getModelBottomToPivot(v265) -- line 1236
    local v266, v267 = v265:GetBoundingBox()
    return v265:GetPivot().Position.Y - (v266.Position.Y - v267.Y * 0.5)
end

local function handheldNoise(v268, v269) -- line 1241
    return (math.noise(v268 * 0.25, v269 * 7.31, 0.5) + math.noise(v268 * 1.25, v269 * 7.31 + 3.17, 9.5) * 0.2) / 1.2 * 2
end

local function handheldOffset(v270, v271) -- line 1245
    local v272 = (math.noise(v270 * 0.25, 7.31, 0.5) + math.noise(v270 * 1.25, 10.48, 9.5) * 0.2) / 1.2 * 2 * 0.02007128639793479 * v271
    local v273 = (math.noise(v270 * 0.25, 14.62, 0.5) + math.noise(v270 * 1.25, 17.79, 9.5) * 0.2) / 1.2 * 2 * 0.014835298641951801 * v271
    local v274 = (math.noise(v270 * 0.25, 21.93, 0.5) + math.noise(v270 * 1.25, 25.1, 9.5) * 0.2) / 1.2 * 2 * 0.007853981633974483 * v271
    local v275 = (math.noise(v270 * 0.25, 29.24, 0.5) + math.noise(v270 * 1.25, 32.41, 9.5) * 0.2) / 1.2 * 2 * 0.1599999964237213
    local v276 = (math.noise(v270 * 0.25, 36.55, 0.5) + math.noise(v270 * 1.25, 39.72, 9.5) * 0.2) / 1.2 * 2 * 0.12999999523162842
    local v277 = math.noise(v270 * 0.25, 43.86, 0.5)
    local new = CFrame.new
    local v278 = (v277 + math.noise(v270 * 1.25, 47.03, 9.5) * 0.2) / 1.2 * 2 * 0.07999999821186066
    return new(Vector3.new(v275, v276, v278) * v271) * CFrame.Angles(0, v272, 0) * CFrame.Angles(v273, 0, v274)
end

local function resolveShotDirection(v279, v280) -- line 1261
    local v281 = v279.Position - v280
    local X = v281.X
    local Z = v281.Z
    local v282 = Vector3.new(X, 0, Z)
    if v282.Magnitude < 1 then
        return Vector3.new(1, 0, 1).Unit
    end
    return v282.Unit
end

local function resolveEggShot(v283, v284, v285) -- line 1269
    local v286 = v285 * 0.5
    local v287 = v283 + Vector3.new(0, v286, 0)
    local v288 = v283 + v284 * (v285 * 0.55 + 45)
    local v289 = v285 * 0.18 + 11
    local v290 = v288 + Vector3.new(0, v289, 0)
    return CFrame.lookAt(v290, v287)
end

local function restoreCutsceneCamera() -- line 1274 | captures: v31, Workspace
    local CurrentCamera = Workspace.CurrentCamera
    local v291 = v31
    v31 = nil
    if CurrentCamera == nil or v291 == nil then
        return
    end
    CurrentCamera.CFrame = v291.CFrame
    CurrentCamera.FieldOfView = v291.FieldOfView
    CurrentCamera.CameraType = v291.CameraType
    if v291.CameraSubject ~= nil and v291.CameraSubject.Parent ~= nil then
        CurrentCamera.CameraSubject = v291.CameraSubject
    end
end

local function revealScoreboardAfterCutscene() -- line 1288 | captures: v25, refreshScoreboardAvailability
    if v25 then
        refreshScoreboardAvailability()
    end
end

local function stopCutscene(v292) -- line 1294 | captures: v25, v28, v29, v30, v31, v32, RunService, Workspace, refreshScoreboardAvailability, setOverlayShown
    if not v29 then
        return
    end
    v28 += 1
    v29 = false
    pcall(RunService.UnbindFromRenderStep, RunService, "CaptureTheEggCutsceneCamera")
    local v293 = v30
    v30 = nil
    if v293 ~= nil then
        v293:Clean()
    end
    setOverlayShown(false)
    local CurrentCamera = Workspace.CurrentCamera
    local v294 = v31
    v31 = nil
    if CurrentCamera ~= nil and v294 ~= nil then
        CurrentCamera.CFrame = v294.CFrame
        CurrentCamera.FieldOfView = v294.FieldOfView
        CurrentCamera.CameraType = v294.CameraType
        if v294.CameraSubject ~= nil and v294.CameraSubject.Parent ~= nil then
            CurrentCamera.CameraSubject = v294.CameraSubject
        end
    end
    if v32 ~= nil then
        v32 = nil
        v32()
    end
    if v292 and v25 then
        refreshScoreboardAvailability()
    end
end

local function buildCutsceneRecord(v295, v296) -- line 1327 | captures: EggRecords
    local v297 = EggRecords.NewEgg(v295)
    if v296 ~= nil and #v296 > 0 then
        v297.Mutations = table.clone(v296)
        v297.BaseMutation = v296[1]
    end
    return v297
end

local function playCutscene(v298, v299, v300, v301, v302, v303) -- line 1335 | captures: v15, v17, v18, v19, v20, v22, v23, v25, v28, v29, v30, v31, v32, RunService, TweenService, Workspace, CameraShaker, CaptureTheEgg, EggRecords, EggRenderer, HiddenUIHandler, Trove, v8, v9, getScoreboardUi, refreshScoreboardAvailability, playSound, emitImpactVfx, setOverlayShown, cloneStarterCharacter, playDance, handheldOffset, stopCutscene
    if not v29 then
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera == nil then
            if v25 then
                refreshScoreboardAvailability()
            end
        else
            local v304, v305 = pcall(function() -- line 1348 | captures: v302, v303, Workspace, CaptureTheEgg, EggRecords, EggRenderer
                local v306 = {
                    OwnerUserId = 0,
                    UID = "CaptureTheEggCutscene",
                    ModelName = "CaptureTheEggCutsceneEgg"
                }
                local v307 = EggRecords.NewEgg(v302)
                if v303 ~= nil and #v303 > 0 then
                    v307.Mutations = table.clone(v303)
                    v307.BaseMutation = v303[1]
                end
                v306.Record = v307
                v306.ScaleMultiplier = CaptureTheEgg.EggScale
                return EggRenderer.RenderVisual(v306, Workspace)
            end)
            if v304 then
                local v308, v309 = xpcall(function() -- line 1368 | captures: v298, v299, v300, v301, CurrentCamera, v305, v15, v17, v18, v19, v20, v22, v23, v28, v29, v30, v31, v32, RunService, TweenService, Workspace, CameraShaker, CaptureTheEgg, HiddenUIHandler, Trove, v8, v9, getScoreboardUi, playSound, emitImpactVfx, setOverlayShown, cloneStarterCharacter, playDance, handheldOffset, stopCutscene
                    v28 += 1
                    local v310 = v28
                    v29 = true
                    local v311 = Trove.new()
                    v30 = v311
                    local v312 = CameraShaker.new()
                    local Model = v305.Model
                    v311:Add(Model)
                    local v313, v314 = Model:GetBoundingBox()
                    local v315 = v313.Position.Y + v314.Y * 0.5 - Model:GetPivot().Position.Y
                    local v316 = v299.Position + Vector3.new(0, 260, 0)
                    local v317 = CFrame.new(v316) * v299.Rotation
                    Model:PivotTo(v317)
                    local v318 = CurrentCamera.CFrame.Position - v300.Position
                    local X = v318.X
                    local Z = v318.Z
                    local v319 = Vector3.new(X, 0, Z)
                    local Unit = if v319.Magnitude >= 1 then v319.Unit else Vector3.new(1, 0, 1).Unit
                    local Unit_2 = Unit
                    local v320 = cloneStarterCharacter(v298)
                    local v321, v322
                    if v320 == nil then
                        v321 = 0
                        v322 = 0
                    else
                        local v323, v324 = v320:GetBoundingBox()
                        local v325 = v320:GetPivot().Position.Y - (v323.Position.Y - v324.Y * 0.5)
                        v321 = v325
                        v322 = v325
                    end
                    local Rotation = CFrame.lookAt(Vector3.new(0, 0, 0), Unit).Rotation
                    if v320 ~= nil then
                        local new = CFrame.new
                        local v326 = v317.Position + v317.UpVector * v315
                        local v327 = v322 + 0.25
                        v320:PivotTo(new(v326 + Vector3.new(0, v327, 0)) * Rotation)
                        v320.Parent = Workspace
                        v311:Add(v320)
                        playDance(v320)
                    end
                    local v328 = os.clock()
                    local v329 = false
                    local v330 = false
                    local v331 = true
                    local v332 = false
                    local v333 = playSound("CinematicRiser", v311, nil)
                    v31 = {
                        CFrame = CurrentCamera.CFrame,
                        FieldOfView = CurrentCamera.FieldOfView,
                        CameraType = CurrentCamera.CameraType,
                        CameraSubject = CurrentCamera.CameraSubject
                    }
                    local v334 = v31
                    v17 = false
                    local v335 = getScoreboardUi()
                    if v335 ~= nil then
                        local Gui = v335.Gui
                        local Board = v335.Board
                        local v336 = v17 and not v19 and v20
                        if v336 == v18 then
                        end
                        v23 += 1
                        local v337 = v22
                        if v337 ~= nil then
                            v337:Cancel()
                        end
                        v22 = nil
                        if v336 then
                            local v338 = if v15 then v8 else false
                            Gui.Enabled = true
                            if not v18 then
                                Board.Position = v9
                            end
                            v18 = true
                            Board.Position = v338
                        else
                            v18 = false
                            Board.Position = v9
                            Gui.Enabled = false
                        end
                    end
                    v32 = HiddenUIHandler.Acquire()
                    setOverlayShown(true)
                    CurrentCamera.CameraType = Enum.CameraType.Scriptable

                    local function stepCutscene(v339) -- line 1455 | captures: Unit_2, v321, v329, v330, v331, v332, v310, v311, v312, Model, v315, v316, v320, Rotation, v328, v333, v334, v299, v300, v301, CurrentCamera, v28, v29, TweenService, Workspace, CaptureTheEgg, playSound, emitImpactVfx, setOverlayShown, handheldOffset, stopCutscene
                        local v340, v341, v342, v343
                        if v310 == v28 and v29 then
                            CurrentCamera.CameraType = Enum.CameraType.Scriptable
                            v340 = Workspace:GetServerTimeNow()
                            local v344 = (v340 - (v301 - CaptureTheEgg.CutsceneFallSeconds)) / CaptureTheEgg.CutsceneFallSeconds
                            v341 = math.clamp(v344, 0, 1)
                            v342 = v316:Lerp(v299.Position, v341 * 0.08 + v341 ^ 2.65 * 0.92)
                            local v345 = v341 * 3.141592653589793
                            local v346 = math.sin(v345)
                            local v347 = v341 * 15.707963267948966
                            local v348 = math.sin(v347) * 0.19198621771937624 * v346
                            local v349 = v341 * 21.991148575128552
                            local v350 = math.sin(v349) * 0.13962634015954636 * v346
                            local v351 = v341 * 25.132741228718345
                            local v352 = CFrame.Angles(v348, v351, v350)
                            v343 = CFrame.new(v342) * v299.Rotation * v352
                            if v331 then
                                Model:PivotTo(v343)
                            end
                        else
                            return
                        end
                        if v320 ~= nil then
                            local v353 = v343.Position + v343.UpVector * v315
                            local v354 = v321 + 0.25
                            local v355 = v353 + Vector3.new(0, v354, 0)
                            local v356 = CFrame.new(v355)
                            v320:PivotTo(v356 * Rotation)
                        end
                        local v357
                        if v341 >= 1 then
                            if v329 then
                                v357 = true
                            else
                                v329 = true
                                if v331 then
                                    v331 = false
                                    Model:PivotTo(v299)
                                    Model:Destroy()
                                end
                                v357 = false
                            end
                        else
                            v357 = true
                        end
                        if not v357 then
                            if v320 ~= nil then
                                local v358 = v299.Position + v299.UpVector * v315
                                local v359 = v321 + 0.25
                                local v360 = v358 + Vector3.new(0, v359, 0)
                                local v361 = CFrame.new(v360)
                                v320:PivotTo(v361 * Rotation)
                            end
                            if v333 ~= nil and v333.Parent ~= nil then
                                local v362 = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                                local v363 = TweenService:Create(v333, v362, { Volume = 0 })
                                v311:Add(v363)
                                v363:Play()
                            end
                            playSound("CinematicBoom", v311, nil)
                            playSound("ImpactBoom", v311, v300)
                            emitImpactVfx(v300)
                            v312:ShakeOnce(8.5, 12, 0, 1.35)
                        end
                        local v364 = os.clock() - v328
                        local v365 = v364 / 0.95
                        local v366 = 1 - (1 - math.clamp(v365, 0, 1)) ^ 5
                        local v367 = v315 * 0.5
                        local v368 = v342 + Vector3.new(0, v367, 0)
                        local v369 = v342 + Unit_2 * (v315 * 0.55 + 45)
                        local v370 = v315 * 0.18 + 11
                        local v371 = v369 + Vector3.new(0, v370, 0)
                        local v372 = CFrame.lookAt(v371, v368)
                        local Position = v299.Position
                        local v373 = v315 * 0.5
                        local v374 = Position + Vector3.new(0, v373, 0)
                        local v375 = Position + Unit_2 * (v315 * 0.55 + 45)
                        local v376 = v315 * 0.18 + 11
                        local v377 = v375 + Vector3.new(0, v376, 0)
                        local v378 = CFrame.lookAt(v377, v374)
                        local v379 = v334.CFrame:Lerp(v372, v366)
                        local v380 = v334.FieldOfView + (50 - v334.FieldOfView) * v366
                        local v381 = v340 - v301
                        local v382 = math.max(v381, 0)
                        local v383, v384, v385, v386, v387, v388
                        if v329 then
                            local v389 = v334.CFrame:Lerp(v378, v366)
                            local v390 = -v382 * 6
                            local v391 = v380 + math.exp(v390) * 9
                            if v382 >= 1.5 then
                                local v392 = (v382 - 1.5) / 1.15
                                v383 = math.clamp(v392, 0, 1)
                                if v383 >= 0.5 then
                                    v384 = 1 - (v383 * -2 + 2) ^ 3 / 2
                                else
                                    v384 = v383 * 4 * v383 * v383
                                end
                                v388 = false
                            else
                                v385 = v389
                                v386 = v391
                                v387 = 0
                                v388 = true
                            end
                        else
                            v385 = v379
                            v386 = v380
                            v387 = 0
                            v388 = true
                        end
                        if not v388 then
                            v385 = v378:Lerp(v334.CFrame, v384)
                            v386 = (v334.FieldOfView - 50) * v384 + 50
                            if not v330 then
                                v330 = true
                                setOverlayShown(false)
                            end
                            v387 = v383
                        end
                        local v393 = v364 / 1.1
                        local v394 = math.clamp(v393, 0, 1)
                        if v329 then
                            v394 *= 0.55
                        end
                        local v395 = v394 * (1 - v387)
                        CurrentCamera.FieldOfView = v386
                        local v396 = v385 * handheldOffset(v364, v395)
                        CurrentCamera.CFrame = v396 * v312:Update(v339)
                        if v387 >= 1 and not v332 then
                            v332 = true
                            task.defer(function() -- line 1547 | captures: v310, v28, stopCutscene
                                if v310 == v28 then
                                    stopCutscene(true)
                                end
                            end)
                        end
                    end

                    local v397 = Enum.RenderPriority.Camera.Value + 1
                    RunService:BindToRenderStep("CaptureTheEggCutsceneCamera", v397, function(v398) -- line 1554 | captures: v332, v310, stepCutscene, v28, stopCutscene
                        local v399, v400 = xpcall(stepCutscene, debug.traceback, v398)
                        if v399 or v332 then
                            return
                        end
                        v332 = true
                        warn((("[CaptureTheEgg] Cutscene frame failed: %*"):format(v400)))
                        task.defer(function() -- line 1560 | captures: v310, v28, stopCutscene
                            if v310 == v28 then
                                stopCutscene(true)
                            end
                        end)
                    end)
                end, debug.traceback)
                if not v308 then
                    warn((("[CaptureTheEgg] Cutscene setup failed: %*"):format(v309)))
                    if v29 then
                        stopCutscene(true)
                    elseif v25 then
                        refreshScoreboardAvailability()
                    end
                end
            else
                warn((("[CaptureTheEgg] Could not render the falling egg: %*"):format(v305)))
                if v25 then
                    refreshScoreboardAvailability()
                end
            end
        end
    end
end

function v37.StartEvent(v401, v402, v403) -- line 1581 | captures: v15, v17, v18, v19, v20, v22, v23, v24, v25, v26, ContentProvider, ReplicatedStorage, Workspace, CaptureTheEgg, EggRecords, EggRenderer, v6, v8, v9, v35, getScoreboardUi, resetScoreboardCards, refreshScoreboardAvailability
    v24 += 1
    v25 = true
    v26 = Workspace:GetAttribute("Event_CaptureTheEggGameplay") == true
    resetScoreboardCards()
    v17 = false
    local v404 = getScoreboardUi()
    if v404 ~= nil then
        local Gui = v404.Gui
        local Board = v404.Board
        local v405 = v17 and not v19 and v20
        if v405 == v18 then
        end
        v23 += 1
        local v406 = v22
        if v406 ~= nil then
            v406:Cancel()
        end
        v22 = nil
        if v405 then
            local v407 = if v15 then v8 else v6
            Gui.Enabled = true
            if not v18 then
                Board.Position = v9
            end
            v18 = true
            Board.Position = v407
        else
            v18 = false
            Board.Position = v9
            Gui.Enabled = false
        end
    end
    local CarryCategory
    if type(v403) == "table" then
        local EggCategory = v403.EggCategory
        if type(EggCategory) == "string" then
            if v403.EggCategory == "" then
                CarryCategory = CaptureTheEgg.CarryCategory
            else
                CarryCategory = v403.EggCategory
            end
        else
            CarryCategory = CaptureTheEgg.CarryCategory
        end
    else
        CarryCategory = CaptureTheEgg.CarryCategory
    end
    local CarryCategory_2 = CarryCategory
    if not v35[CarryCategory] then
        v35[CarryCategory] = true
        task.spawn(function() -- line 1636 | captures: CarryCategory_2, ContentProvider, ReplicatedStorage, CaptureTheEgg, EggRecords, EggRenderer
            local v408 = {}
            local v409 = {}
            local v410 = {}
            local v411 = { "Sounds", "ImpactBoom" }
            v410[1] = { "Sounds", "CinematicRiser" }
            v410[2] = { "Sounds", "CinematicBoom" }
            v410[3] = v411
            v410[4] = { "Particles", "BigHitGroundAttach" }
            for v412, v413 in v410 do
                local Assets = ReplicatedStorage:FindFirstChild("Assets")
                local v414 = Assets and Assets:FindFirstChild(v413[1])
                local v415 = v414 and v414:FindFirstChild(v413[2])
                if v415 ~= nil then
                    table.insert(v408, v415)
                end
            end
            local v416, v417 = pcall(function() -- line 1662 | captures: CarryCategory_2, EggRecords, EggRenderer
                return EggRenderer.GetTemplate(EggRecords.NewEgg(CarryCategory_2))
            end)
            if v416 and typeof(v417) == "Instance" then
                table.insert(v408, v417)
            end
            for v418, v419 in {
                    CaptureTheEgg.DanceAnimationId,
                    CaptureTheEgg.R6DanceAnimationId
                } do
                local Animation = Instance.new("Animation")
                Animation.AnimationId = v419
                table.insert(v408, Animation)
                table.insert(v409, Animation)
            end
            if #v408 > 0 then
                pcall(ContentProvider.PreloadAsync, ContentProvider, v408)
            end
            for v420, v421 in v409 do
                v421:Destroy()
            end
        end)
    end
    refreshScoreboardAvailability()
end

function v37.StopEvent(v422) -- line 1690 | captures: v15, v17, v18, v19, v20, v22, v23, v24, v25, v26, v6, v8, v9, getScoreboardUi, applyBoardVisibility, hideCard, resetScoreboardCards, stopCutscene
    v24 += 1
    local v423 = v24
    v25 = false
    v26 = false
    stopCutscene(false)
    v17 = false
    applyBoardVisibility(nil)
    local v424 = getScoreboardUi()
    if v424 ~= nil then
        for v425, v426 in v424.Cards do
            hideCard(v426)
        end
    end
    task.delay(0.26, function() -- line 1708 | captures: v423, v15, v17, v18, v19, v20, v22, v23, v24, v6, v8, v9, getScoreboardUi, resetScoreboardCards
        if v423 ~= v24 then
            return
        end
        resetScoreboardCards()
        v17 = false
        local v427 = getScoreboardUi()
        if v427 == nil then
            return
        end
        local Gui = v427.Gui
        local Board = v427.Board
        local v428 = v17 and not v19 and v20
        if v428 == v18 then
        end
        v23 += 1
        local v429 = v22
        if v429 ~= nil then
            v429:Cancel()
        end
        v22 = nil
        if v428 then
            local v430 = if v15 then v8 else v6
            Gui.Enabled = true
            if not v18 then
                Board.Position = v9
            end
            v18 = true
            Board.Position = v430
        else
            v18 = false
            Board.Position = v9
            Gui.Enabled = false
        end
    end)
end

Remotes.EggCapture.StandingsRefreshed.OnClientEvent:Connect(function(v431) -- line 1753 | captures: renderScoreboard
    if type(v431) == "table" then
        renderScoreboard(v431)
    end
end)
Remotes.EggCapture.CutsceneBegan.OnClientEvent:Connect(function(v432, v433, v434, v435, v436, v437) -- line 1759 | captures: playCutscene
    local v438
    if type(v432) == "number" and typeof(v433) == "CFrame" and typeof(v434) == "CFrame" and type(v435) == "number" and v435 == v435 and type(v436) == "string" then
        if type(v437) == "table" then
            v438 = v437
        end
    else
        return
    end
    playCutscene(v432, v433, v434, v435, v436, v438)
end)
AreaEggResetWall.Changed:Connect(function(v439) -- line 1771 | captures: v20, v21, AreaEggResetWall, applyBoardVisibility
    v21 += 1
    if v439 then
        if v20 ~= false then
            v20 = false
            applyBoardVisibility()
        end
    else
        local v440 = v21
        task.delay(AreaEggResetWall.CollapseSeconds, function() -- line 1775 | captures: v440, v20, v21, AreaEggResetWall, applyBoardVisibility
            if not (v440 == v21) or AreaEggResetWall.IsSealed() or not (v20 ~= true) then
                return
            end
            v20 = true
            applyBoardVisibility()
        end)
    end
end)
EggState.CarryChanged:Connect(function(v441) -- line 1790 | captures: Uid, v16, Workspace, SpawnLock, EggUidAttribute, setLocalPlayerCarryingEgg
    setLocalPlayerCarryingEgg(v441.IsCarrying)
    if v441.IsCarrying then
        Uid = v441.Uid
    else
        Uid = nil
    end
    if Uid ~= nil and Uid == Workspace:GetAttribute(EggUidAttribute) then
        if v16 == nil then
            v16 = SpawnLock.ObtainLock()
        end
    elseif v16 ~= nil then
        v16 = nil
        v16()
    end
end)
LocalPlayer.CharacterRemoving:Connect(function() -- line 1816 | captures: Uid, v16, Workspace, SpawnLock, EggUidAttribute, setLocalPlayerCarryingEgg
    setLocalPlayerCarryingEgg(false)
    Uid = nil
    if Uid ~= nil and Uid == Workspace:GetAttribute(EggUidAttribute) then
        if v16 == nil then
            v16 = SpawnLock.ObtainLock()
        end
    elseif v16 ~= nil then
        v16 = nil
        v16()
    end
end)
Workspace:GetAttributeChangedSignal(EggUidAttribute):Connect(function() -- line 1837 | captures: Uid, v16, Workspace, SpawnLock, EggUidAttribute
    if Uid ~= nil and Uid == Workspace:GetAttribute(EggUidAttribute) then
        if v16 == nil then
            v16 = SpawnLock.ObtainLock()
        end
    elseif v16 ~= nil then
        v16 = nil
        v16()
    end
end)
Workspace:GetAttributeChangedSignal("Event_CaptureTheEggGameplay"):Connect(refreshScoreboardAvailability)
RunService.RenderStepped:Connect(function() -- line 1857 | captures: v19, NotificationInstance, applyBoardVisibility, updateLiveTimers
    local v442 = NotificationInstance.IsTopContended()
    if v19 ~= v442 then
        v19 = v442
        applyBoardVisibility()
    end
    updateLiveTimers()
end)
task.defer(function() -- line 1865 | captures: v15, v17, v18, v19, v20, v22, v23, v25, Workspace, v6, v8, v9, getScoreboardUi, resetScoreboardCards, refreshScoreboardAvailability
    if Workspace:GetAttribute("Event_CaptureTheEgg") == true then
        v25 = true
        refreshScoreboardAvailability()
    else
        resetScoreboardCards()
        v17 = false
        local v443 = getScoreboardUi()
        if v443 ~= nil then
            local Gui = v443.Gui
            local Board = v443.Board
            local v444 = v17 and not v19 and v20
            if v444 == v18 then
            end
            v23 += 1
            local v445 = v22
            if v445 ~= nil then
                v445:Cancel()
            end
            v22 = nil
            if v444 then
                local v446 = if v15 then v8 else v6
                Gui.Enabled = true
                if not v18 then
                    Board.Position = v9
                end
                v18 = true
                Board.Position = v446
            else
                v18 = false
                Board.Position = v9
                Gui.Enabled = false
            end
        end
    end
end)
return v37
