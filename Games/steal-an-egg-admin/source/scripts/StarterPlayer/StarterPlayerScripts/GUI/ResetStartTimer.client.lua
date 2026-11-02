-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local AreaEggCycle = require(ReplicatedStorage.Shared.Util.AreaEggCycle)
local AreaEggResetCycle = require(ReplicatedStorage.Data.AreaEggResetCycle)
require(ReplicatedStorage.Shared.Types.AreaEggResetCycle)
local Audio = require(ReplicatedStorage.Shared.Audio)
local ChatMsg = require(ReplicatedStorage.Client.ChatMsg)
local EggState = require(ReplicatedStorage.Client.EggState)
local GUI = require(ReplicatedStorage.Client.GUI)
local Log = require(ReplicatedStorage.Packages.Log)
local Notifications = require(ReplicatedStorage.Client.Notifications)
local Rarities = require(ReplicatedStorage.Data.Rarity).Rarities
local AreaEggResetWall = require(ReplicatedStorage.Client.AreaEggResetWall)
local Save = require(ReplicatedStorage.Shared.Save)
local v1 = TweenInfo.new(0.55, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local TeleportFadeHoldSeconds = AreaEggResetCycle.TeleportFadeHoldSeconds
local v2 = TweenInfo.new(AreaEggResetCycle.TeleportFadeSeconds, Enum.EasingStyle.Linear)
local v3 = TweenInfo.new(AreaEggResetCycle.SleepIconFadeSeconds, Enum.EasingStyle.Quad)
local v4 = TweenInfo.new(AreaEggResetCycle.NightIconFadeOutSeconds, Enum.EasingStyle.Quad)
local v5 = Log.new()

local function ensureResetStartTimerGui() -- line 29 | captures: Players, AreaEggResetCycle
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    local v6 = PlayerGui:FindFirstChild("NigthDayCountdown") or PlayerGui:FindFirstChild("NightDayCountdown")
    if not (v6 == nil or v6:IsA("ScreenGui")) then
        v6:Destroy()
        v6 = nil
    end
    if v6 == nil then
        v6 = Instance.new("ScreenGui")
        v6.Name = "NigthDayCountdown"
        v6.IgnoreGuiInset = true
        v6.ResetOnSpawn = false
        v6.DisplayOrder = 50
        v6.Parent = PlayerGui
    end
    local Frame = v6:FindFirstChild("Frame")
    if not (Frame == nil or Frame:IsA("Frame")) then
        Frame:Destroy()
        Frame = nil
    end
    if Frame == nil then
        Frame = Instance.new("Frame")
        Frame.Name = "Frame"
        Frame.AnchorPoint = Vector2.new(0.5, 0)
        Frame.BackgroundTransparency = 1
        Frame.Position = UDim2.fromScale(0.5, 0.04)
        Frame.Size = UDim2.fromOffset(360, 96)
        Frame.Parent = v6
    end
    local v7 = Frame:FindFirstChild("SleepIcon") or Frame:FindFirstChild("Icon")
    if not (v7 == nil or v7:IsA("ImageLabel")) then
        v7:Destroy()
        v7 = nil
    end
    if v7 == nil then
        v7 = Instance.new("ImageLabel")
        v7.Name = "SleepIcon"
        v7.AnchorPoint = Vector2.new(0.5, 0.5)
        v7.BackgroundTransparency = 1
        v7.Position = UDim2.fromScale(0.5, 0.16)
        v7.Size = UDim2.fromOffset(42, 42)
        v7.Parent = Frame
    end
    v7.AnchorPoint = Vector2.new(0.5, 0.5)
    v7.BackgroundTransparency = 1
    v7.Position = UDim2.fromScale(0.5, 0.16)
    v7.Size = UDim2.fromOffset(42, 42)
    v7.ScaleType = Enum.ScaleType.Fit
    v7.Visible = true
    v7.ImageTransparency = 0
    v7.ZIndex = 10
    v7.Image = AreaEggResetCycle.MoonIcon or v7.Image
    local NightTimer = Frame:FindFirstChild("NightTimer") or Frame:FindFirstChild("Timer") or Frame:FindFirstChild("Countdown")
    if not (NightTimer == nil or NightTimer:IsA("TextLabel")) then
        NightTimer:Destroy()
        NightTimer = nil
    end
    if NightTimer == nil then
        NightTimer = Instance.new("TextLabel")
        NightTimer.Name = "NightTimer"
        NightTimer.AnchorPoint = Vector2.new(0.5, 0.5)
        NightTimer.BackgroundTransparency = 1
        NightTimer.Position = UDim2.fromScale(0.5, 0.56)
        NightTimer.Size = UDim2.fromOffset(320, 46)
        NightTimer.Parent = Frame
    end
    NightTimer.Font = Enum.Font.GothamBlack
    NightTimer.TextColor3 = Color3.new(1, 1, 1)
    NightTimer.TextScaled = true
    local UIStroke = NightTimer:FindFirstChildOfClass("UIStroke")
    if UIStroke == nil then
        UIStroke = Instance.new("UIStroke")
        UIStroke.Parent = NightTimer
    end
    UIStroke.Thickness = 3
    UIStroke.Color = Color3.new(0, 0, 0)
    local v8 = Frame:FindFirstChild("TextLabel") or Frame:FindFirstChild("ResetCountdown")
    if not (v8 == nil or v8:IsA("TextLabel")) then
        v8:Destroy()
        v8 = nil
    end
    if v8 == nil then
        v8 = Instance.new("TextLabel")
        v8.Name = "TextLabel"
        v8.AnchorPoint = Vector2.new(0.5, 0.5)
        v8.BackgroundTransparency = 1
        v8.Position = UDim2.fromScale(0.5, 0.84)
        v8.Size = UDim2.fromOffset(120, 48)
        v8.Parent = Frame
    end
    v8.Font = Enum.Font.GothamBlack
    v8.Text = v8.Text ~= "" and v8.Text or "3"
    v8.TextColor3 = Color3.new(1, 1, 1)
    v8.TextScaled = true
    v8.Visible = false
    local UIScale = v8:FindFirstChildOfClass("UIScale")
    if UIScale == nil then
        UIScale = Instance.new("UIScale")
        UIScale.Parent = v8
    end
    UIScale.Scale = 1
    return v6
end

local function ensureFadeFrame() -- line 139 | captures: Players, GUI
    local v9, v10 = pcall(GUI.FadeFrame)
    if not v9 or v10 == nil then
        local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
        local Fade = PlayerGui:FindFirstChild("Fade")
        if not (Fade == nil or Fade:IsA("ScreenGui")) then
            Fade:Destroy()
            Fade = nil
        end
        if Fade == nil then
            Fade = Instance.new("ScreenGui")
            Fade.Name = "Fade"
            Fade.IgnoreGuiInset = true
            Fade.ResetOnSpawn = false
            Fade.DisplayOrder = 1000
            Fade.Parent = PlayerGui
        end
        local Fade_2 = Fade:FindFirstChild("Fade")
        if not (Fade_2 == nil or Fade_2:IsA("Frame")) then
            Fade_2:Destroy()
            Fade_2 = nil
        end
        if Fade_2 == nil then
            Fade_2 = Instance.new("Frame")
            Fade_2.Name = "Fade"
            Fade_2.BackgroundColor3 = Color3.new(0, 0, 0)
            Fade_2.BackgroundTransparency = 1
            Fade_2.BorderSizePixel = 0
            Fade_2.Size = UDim2.fromScale(1, 1)
            Fade_2.Parent = Fade
        end
        return Fade_2
    end
    return v10
end

local v11 = ensureResetStartTimerGui()
local v12 = ensureFadeFrame()
local TextLabel = v11.Frame.TextLabel
local NightTimer = v11.Frame.NightTimer
local UIStroke = NightTimer.UIStroke
local SleepIcon = v11.Frame.SleepIcon

SleepIcon.ImageTransparency = 0
SleepIcon.Visible = true

local UIScale = TextLabel:FindFirstChildOfClass("UIScale")
local UIScale_2 = UIScale

if UIScale == nil then
    local UIScale = Instance.new("UIScale")
    UIScale_2 = UIScale
    UIScale.Scale = 1
    UIScale.Parent = TextLabel
end
local v13 = 0
local v14
local v15 = 0
local v16, v17, v18, v19, DayStartsAt
local v20 = (-1/0)
local v21 = -1

if v11:IsA("SurfaceGui") then
    v11.Adornee = AreaEggResetWall.ResolveTimerPart()
end
task.spawn(require(ReplicatedStorage.Shared.Utils.Warmup).WarmSounds, 117751546358455, 136029417452204)

local function stopActiveTween() -- line 208 | captures: v14
    if v14 ~= nil then
        v14:Cancel()
        v14 = nil
    end
end

local function stopActiveFadeTween() -- line 214 | captures: v16
    if v16 ~= nil then
        v16:Cancel()
        v16 = nil
    end
end

local function stopActiveNightVisualTweens() -- line 220 | captures: v17, v18, v19
    if v17 ~= nil then
        v17:Cancel()
        v17 = nil
    end
    if v18 ~= nil then
        v18:Cancel()
        v18 = nil
    end
    if v19 ~= nil then
        v19:Cancel()
        v19 = nil
    end
end

local function tweenFadeFrame(v22, v23) -- line 234 | captures: v15, v16, TweenService, v2, v12
    if v16 ~= nil then
        v16:Cancel()
        v16 = nil
    end
    local v24 = TweenService:Create(v12, v2, { BackgroundTransparency = v23 })
    v16 = v24
    v24:Play()
    v24.Completed:Wait()
    if v22 == v15 then
        v16 = nil
        return true
    end
    return false
end

local function runTeleportFade(v25) -- line 249 | captures: v15, TeleportFadeHoldSeconds, tweenFadeFrame
    if tweenFadeFrame(v25, 0) then
        task.wait(TeleportFadeHoldSeconds)
        if v25 == v15 then
            tweenFadeFrame(v25, 1)
        end
    end
end

local function setCountdownVisible(v26) -- line 259 | captures: TextLabel
    TextLabel.Visible = v26
end

local function tweenNightVisuals(v27, v28) -- line 262 | captures: v13, v17, v18, v19, TweenService, v3, v4, NightTimer, UIStroke, SleepIcon
    if v17 ~= nil then
        v17:Cancel()
        v17 = nil
    end
    if v18 ~= nil then
        v18:Cancel()
        v18 = nil
    end
    if v19 ~= nil then
        v19:Cancel()
        v19 = nil
    end
    local v29 = if v28 == 1 then v4 else v3
    local v30 = TweenService:Create(SleepIcon, v29, { ImageTransparency = v28 })
    local v31 = TweenService:Create(NightTimer, v29, { TextTransparency = v28 })
    local v32 = TweenService:Create(UIStroke, v29, { Transparency = v28 })
    v17 = v30
    v18 = v31
    v19 = v32
    v30:Play()
    v31:Play()
    v32:Play()
    v30.Completed:Wait()
    if v27 == v13 then
        v17 = nil
        v18 = nil
        v19 = nil
        return true
    end
    return false
end

local function animateCount(v33) -- line 299 | captures: UIScale_2, v14, TweenService, v1, TextLabel
    if v14 ~= nil then
        v14:Cancel()
        v14 = nil
    end
    TextLabel.Text = tostring(v33)
    UIScale_2.Scale = 1.3
    local v34 = TweenService:Create(UIScale_2, v1, { Scale = 1 })
    v14 = v34
    v34:Play()
end

local v35 = Color3.new(1, 1, 1)

local function rarityGradient(v36) -- line 311 | captures: Rarities
    if v36 == nil then
        return nil
    end
    local v37 = Rarities[v36]
    if v37 == nil then
        return nil
    end
    return v37.RarityGradient
end

local function rareSpawnSegments(v38) -- line 321 | captures: Rarities, v35
    local EggName = v38.EggName
    local AreaName = v38.AreaName
    if EggName == nil or AreaName == nil then
        return nil
    end
    local RarityName = v38.RarityName
    local v39
    if RarityName == nil then
        v39 = "A "
    else
        v39 = ("A %s "):format(RarityName)
    end
    local v40 = {}
    local v41 = {
        Text = v39,
        Color = v35
    }
    local v42 = {
        Text = EggName,
        Color = v35
    }
    local RarityId = v38.RarityId
    if RarityId == nil then
        v42.Gradient = nil
    else
        local v43 = Rarities[RarityId]
        if v43 == nil then
            v42.Gradient = nil
        else
            v42.Gradient = v43.RarityGradient
        end
    end
    local v44 = {
        Text = " egg has spawned in ",
        Color = v35
    }
    local v45 = {
        Text = AreaName,
        Color = v35
    }
    local AreaRarityId = v38.AreaRarityId
    if AreaRarityId == nil then
        v45.Gradient = nil
    else
        local v46 = Rarities[AreaRarityId]
        if v46 == nil then
            v45.Gradient = nil
        else
            v45.Gradient = v46.RarityGradient
        end
    end
    local v47 = {
        Text = ("! %s"):format(v38.Emoji or ""),
        Color = v35
    }
    v40[1] = v41
    v40[2] = v42
    v40[3] = v44
    v40[4] = v45
    v40[5] = v47
    return v40
end

local function announceRareSpawns(v48) -- line 337 | captures: ChatMsg, EggState, Notifications, v35, rareSpawnSegments
    for v49, v50 in ipairs(v48) do
        ChatMsg.Announce({
            SkipTint = true,
            Body = v50.Message
        })
        Notifications.Message.Top({
            Time = 4,
            Message = v50.Message,
            Segments = rareSpawnSegments(v50),
            Color = v35,
            Sound = v50.SoundId
        })
    end
    EggState.RarityPresented:Fire(v48)
end

local function requestJoinRareSpawnPresentations() -- line 350 | captures: v21, EggState, Save, announceRareSpawns
    if not Save.IsLocalDataLoaded() then
        Save.ProfileReady:Wait()
    end
    local v51, v52 = EggState.FetchRarityShows()
    if not v51 or not (v52 ~= nil) or v52.PeriodIndex <= v21 then
        return
    end
    v21 = v52.PeriodIndex
    announceRareSpawns(v52.RareSpawns)
end

local function runCountdown(v53, v54) -- line 363 | captures: UIScale_2, v13, v14, DayStartsAt, v20, Workspace, AreaEggResetCycle, Audio, Notifications, AreaEggResetWall, v11, TextLabel, NightTimer, tweenNightVisuals, animateCount
    AreaEggResetWall.ArmReveal()
    v11.Enabled = true
    TextLabel.Visible = false
    task.spawn(AreaEggResetWall.RaiseWall)
    local v55 = v54.DayStartsAt - Workspace:GetServerTimeNow()
    local v56 = math.ceil(v55)
    NightTimer.Text = ("%*s"):format((math.max(v56, 1)))
    if tweenNightVisuals(v53, 0) then
        while true do
            local v57 = Workspace:GetServerTimeNow()
            local v58 = v54.DayStartsAt - v57
            if v58 <= 0 then
                break
            end
            local v59 = math.ceil(v58)
            NightTimer.Text = ("%*s"):format(v59)
            local v60 = v54.DayStartsAt - (v59 - 1)
            local wait = task.wait
            local v61 = v60 - v57
            wait((math.max(v61, 0.05)))
            if v53 == v13 then
                continue
            end
            return
        end
        if tweenNightVisuals(v53, 1) then
            local v62 = v54.DayStartsAt + AreaEggResetCycle.WallCountdownDelayAfterDayStartsSeconds - Workspace:GetServerTimeNow()
            task.wait((math.max(v62, 0)))
            if v53 == v13 then
                Notifications.Message.Top({
                    Message = "ALL EGG RESET!",
                    Time = 3.5
                })
                local v63 = AreaEggResetWall.ResolveWallPart()
                local v64 = v63.Position + v63.CFrame.LookVector * (v63.Size.Z / 2)
                local WallCountdownSeconds = AreaEggResetCycle.WallCountdownSeconds
                for v65 = WallCountdownSeconds, 1, -1 do
                    if v53 == v13 then
                        Audio.Play(117751546358455, v64, {
                            Volume = 2,
                            MaxDistance = 220
                        })
                        animateCount(v65)
                        if v65 == AreaEggResetCycle.WallCountdownSeconds then
                            TextLabel.Visible = true
                        end
                    else
                        return
                    end
                    task.wait(1)
                end
                if v53 == v13 then
                    if v14 ~= nil then
                        v14:Cancel()
                        v14 = nil
                    end
                    UIScale_2.Scale = 1
                    Audio.Play(136029417452204, v64, {
                        Volume = 1.5,
                        MaxDistance = 220
                    })
                    TextLabel.Visible = false
                    AreaEggResetWall.DropWall()
                    if v53 == v13 then
                        v11.Enabled = false
                        v20 = v54.DayStartsAt
                        DayStartsAt = nil
                    end
                end
            end
        end
    end
end

v5:AtDebug():Log("Reset start timer controller initialized")
v11.Enabled = true
TextLabel.Visible = false
SleepIcon.ImageTransparency = 0
NightTimer.TextTransparency = 0
UIStroke.Transparency = 0
AreaEggResetWall.ClearWall()

local function formatClock(v66) -- line 438
    local v67 = math.ceil(v66)
    local v68 = math.max(0, v67)
    local v69 = v68 / 60
    return ("%02d:%02d"):format(math.floor(v69), v68 % 60)
end

local function runIdleTimer() -- line 442 | captures: DayStartsAt, Workspace, AreaEggCycle, AreaEggResetCycle, v11, TextLabel, NightTimer, UIStroke, SleepIcon
    while true do
        if DayStartsAt ~= nil then
            task.wait(1)
            continue
        end
        local v70 = Workspace:GetServerTimeNow()
        local v71 = AreaEggCycle.IsNightPhase(v70)
        v11.Enabled = true
        TextLabel.Visible = false
        local v72 = if v71 then AreaEggResetCycle.MoonIcon or SleepIcon.Image else AreaEggResetCycle.SunIcon or SleepIcon.Image
        SleepIcon.Image = v72
        SleepIcon.Visible = true
        SleepIcon.BackgroundTransparency = 1
        SleepIcon.ImageTransparency = 0
        SleepIcon.Size = UDim2.fromOffset(42, 42)
        SleepIcon.ZIndex = 10
        NightTimer.TextTransparency = 0
        UIStroke.Transparency = 0
        local v73 = if v71 then "NIGHT " else "DAY "
        local v74 = AreaEggCycle.SecondsUntilPhaseEnd(v70)
        local v75 = math.ceil(v74)
        local v76 = math.max(0, v75)
        local v77 = v76 / 60
        NightTimer.Text = v73 .. ("%02d:%02d"):format(math.floor(v77), v76 % 60)
        task.wait(1)
    end
end

task.spawn(runIdleTimer)
EggState.ResetFade:Connect(function() -- line 464 | captures: v15, runTeleportFade
    v15 += 1
    task.spawn(runTeleportFade, v15)
end)
EggState.ResetCountdown:Connect(function(v78) -- line 468 | captures: v13, DayStartsAt, v20, runCountdown
    if not (v78.DayStartsAt <= v20) then
        local DayStartsAt_2 = DayStartsAt
        if DayStartsAt_2 == nil then
            if v78.DayStartsAt ~= DayStartsAt_2 then
                DayStartsAt = v78.DayStartsAt
                v13 += 1
                task.spawn(runCountdown, v13, v78)
            end
        elseif not (v78.DayStartsAt < DayStartsAt_2 or v78.DayStartsAt == DayStartsAt_2) then
            DayStartsAt = v78.DayStartsAt
            v13 += 1
            task.spawn(runCountdown, v13, v78)
        end
    end
end)
EggState.RarityRevealed:Connect(function(v79) -- line 489 | captures: v21, announceRareSpawns
    if not (v79.PeriodIndex <= v21) then
        v21 = v79.PeriodIndex
        announceRareSpawns(v79.RareSpawns)
    end
end)
task.spawn(requestJoinRareSpawnPresentations)

if not AreaEggCycle.IsNightPhase(Workspace:GetServerTimeNow()) then
    return
end
local v80 = { DayStartsAt = AreaEggCycle.NextResetTime(Workspace:GetServerTimeNow()) }
local DayStartsAt_2 = v80.DayStartsAt

if v20 < DayStartsAt_2 then
    local DayStartsAt_2 = DayStartsAt
    if DayStartsAt_2 == nil then
        if v80.DayStartsAt ~= DayStartsAt_2 then
            DayStartsAt = v80.DayStartsAt
            v13 += 1
            task.spawn(runCountdown, v13, v80)
        end
    elseif DayStartsAt_2 <= v80.DayStartsAt and v80.DayStartsAt ~= DayStartsAt_2 then
        DayStartsAt = v80.DayStartsAt
        v13 += 1
        task.spawn(runCountdown, v13, v80)
    end
end
