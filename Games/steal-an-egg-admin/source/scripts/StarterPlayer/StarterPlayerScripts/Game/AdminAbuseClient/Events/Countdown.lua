-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local function v1(...)
    return (type(...))
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Shake = require(ReplicatedStorage.Client.Shake)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local v2 = Color3.fromRGB(255, 255, 255)
local v3 = Color3.fromRGB(255, 82, 82)
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local v4 = Random.new()
local v5, v6, v7

local function playNamedSound(v8) -- line 17 | captures: ReplicatedStorage, Audio
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local v9 = Assets and Assets:FindFirstChild("Sounds")
    local v10 = v9 and v9:FindFirstChild(v8)
    if not (v10 ~= nil and v10:IsA("Sound")) then
        warn((("[Countdown] Missing ReplicatedStorage.Assets.Sounds.%*; the countdown continues without it"):format(v8)))
    else
        Audio.Play(v10, script)
    end
end

local function resolveNotificationLane() -- line 33 | captures: PlayerGui
    local Notifications = PlayerGui:FindFirstChild("Notifications")
    local v11
    if Notifications == nil then
    else
        v11 = Notifications:FindFirstChild("MessageTop")
    end
    if v11 ~= nil and v11:IsA("Frame") then
        return v11
    end
    return nil
end

local function resolveEndsAt() -- line 49 | captures: v7, Workspace
    local AdminAbuseCountdownEndsAt = Workspace:GetAttribute("AdminAbuseCountdownEndsAt")
    if type(AdminAbuseCountdownEndsAt) == "number" then
        return AdminAbuseCountdownEndsAt
    end
    return v7
end

local function formatClock(v12) -- line 56
    local v13 = math.ceil(v12)
    local v14 = v13 // 3600
    local v15 = v13 % 3600 // 60
    local v16 = v13 % 60
    if v14 > 0 then
        return string.format("%d:%02d:%02d", v14, v15, v16)
    end
    if v13 < 60 then
        return (tostring(v13))
    end
    return string.format("%02d:%02d", v15, v16)
end

local function setText(v17, v18) -- line 69
    v17.TimeLabel.Text = v18
    if v17.ShadowLabel ~= nil then
        v17.ShadowLabel.Text = v18
    end
end

local function punch(v19, v20) -- line 75 | captures: Tween
    local Punch = v19.Punch
    if Punch == nil then
        return
    end
    if v19.PunchTween ~= nil then
        v19.PunchTween:Cancel()
    end
    Punch.Scale = v20
    v19.PunchTween = Tween(Punch, { Scale = 1 }, { 0.35, "Back", "Out" })
    v19.ShakeUntil = os.clock() + 0.18
end

local function playTick(v21) -- line 87 | captures: Audio
    local v22 = v21 / 10
    local v23 = 1 - math.clamp(v22, 0, 1)
    Audio.Play("rbxassetid://103116044135853", script, {
        Volume = 0.7,
        PlaybackSpeed = v23 * 0.85 + 0.85
    })
end

local function teardown() -- line 91 | captures: v5, v6
    if v6 ~= nil then
        v6:Disconnect()
        v6 = nil
    end
    local v24 = v5
    v5 = nil
    if v24 ~= nil then
        v24.Gui:Destroy()
    end
end

local function fadeOut(v25) -- line 102 | captures: v5, v6, Tween
    if v5 ~= v25 then
        return
    end
    v5 = nil
    if v6 ~= nil then
        v6:Disconnect()
        v6 = nil
    end
    Tween(v25.TimeLabel, { TextTransparency = 1 }, { 0.6, "Sine", "In" })
    local UIStroke = v25.TimeLabel:FindFirstChildOfClass("UIStroke")
    if UIStroke ~= nil then
        Tween(UIStroke, { Transparency = 1 }, { 0.6, "Sine", "In" })
    end
    if v25.ShadowLabel ~= nil then
        Tween(v25.ShadowLabel, { TextTransparency = 1 }, { 0.6, "Sine", "In" })
    end
    task.delay(0.6, function() -- line 119 | captures: v25
        v25.Gui:Destroy()
    end)
end

local function applyPosition(v26, v27) -- line 123
    local Lane = v26.Lane
    if Lane == nil then
        v26.BasePosition = v26.LoweredPosition
    else
        local Y = Lane.AbsolutePosition.Y
        local v28 = Y
        local v29 = false
        for v30, v31 in Lane:GetChildren() do
            if v31:IsA("GuiObject") and v31.Visible then
                local v32 = v31.AbsolutePosition.Y + v31.AbsoluteSize.Y
                if v28 < v32 then
                    v28 = v32
                end
                v29 = true
            end
        end
        if v29 then
            Y = v28 + v26.LaneGap
        end
        local RestY = v26.RestY
        if RestY ~= nil then
            local v33 = if Y <= RestY then 5 else 18
            local v34 = Y - RestY
            local v35 = v27 * v33
            Y = RestY + v34 * math.min(v35, 1)
        end
        v26.RestY = Y
        local LoweredPosition = v26.LoweredPosition
        v26.BasePosition = UDim2.new(LoweredPosition.X.Scale, LoweredPosition.X.Offset, 0, Y - v26.Gui.AbsolutePosition.Y)
    end
end

local function applyShake(v36) -- line 163 | captures: v4
    local Holder = v36.Holder
    if os.clock() < v36.ShakeUntil then
        local v37 = v4:NextInteger(-6, 6)
        Holder.Position = v36.BasePosition + UDim2.fromOffset(v37, v4:NextInteger(-6, 6))
    elseif Holder.Position ~= v36.BasePosition then
        Holder.Position = v36.BasePosition
    end
end

local function applyScale(v38, v39, v40) -- line 174
    local Scale = v38.Scale
    local v41 = v39 - v38.Scale
    local v42 = v40 * 5
    v38.Scale = Scale + v41 * math.min(v42, 1)
    local BaseSize = v38.BaseSize
    v38.Holder.Size = UDim2.fromScale(BaseSize.X.Scale * v38.Scale, BaseSize.Y.Scale * v38.Scale)
end

local function startFinale(v43) -- line 179 | captures: Shake, playNamedSound, punch, fadeOut
    v43.FinaleAt = os.clock()
    v43.TimeLabel.Text = "0"
    if v43.ShadowLabel ~= nil then
        v43.ShadowLabel.Text = "0"
    end
    v43.TimeLabel.TextColor3 = v43.UrgentColor
    punch(v43, 1.45)
    playNamedSound("CinematicBoom")
    Shake.Play(0.35, 0.35)
    task.delay(1.4, function() -- line 189 | captures: v43, fadeOut
        fadeOut(v43)
    end)
end

local function step(v44) -- line 193 | captures: v5, v6, v7, Workspace, Audio, playNamedSound, formatClock, punch, fadeOut, applyPosition, applyShake, startFinale
    local v45 = v5
    if v45 ~= nil then
        if v45.Gui.Parent == nil then
            if v6 ~= nil then
                v6:Disconnect()
                v6 = nil
            end
            local v46 = v5
            v5 = nil
            if v46 ~= nil then
                v46.Gui:Destroy()
            end
        elseif v45.FinaleAt == nil then
            local AdminAbuseCountdownEndsAt = Workspace:GetAttribute("AdminAbuseCountdownEndsAt")
            if type(AdminAbuseCountdownEndsAt) ~= "number" then
                AdminAbuseCountdownEndsAt = v7
            end
            if AdminAbuseCountdownEndsAt == nil then
                fadeOut(v45)
            else
                local v47 = AdminAbuseCountdownEndsAt - Workspace:GetServerTimeNow()
                if v47 <= 0 then
                    startFinale(v45)
                else
                    local v48 = math.ceil(v47)
                    if v47 <= 10 then
                        if not v45.RiserPlayed then
                            v45.RiserPlayed = true
                            playNamedSound("CinematicRiser")
                        end
                        local v49 = v47 / 10
                        local v50 = 1 - math.clamp(v49, 0, 1)
                        v45.TimeLabel.TextColor3 = v45.CalmColor:Lerp(v45.UrgentColor, v50)
                        local v51
                        if v47 <= 6 then
                            v51 = string.format("%.1f", v47)
                        else
                            v51 = tostring(v48)
                        end
                        v45.TimeLabel.Text = v51
                        if v45.ShadowLabel ~= nil then
                            v45.ShadowLabel.Text = v51
                        end
                        if v48 ~= v45.LastWholeSecond then
                            punch(v45, v45.PunchScale)
                            local v52 = v48 / 10
                            local v53 = 1 - math.clamp(v52, 0, 1)
                            Audio.Play("rbxassetid://103116044135853", script, {
                                Volume = 0.7,
                                PlaybackSpeed = v53 * 0.85 + 0.85
                            })
                        end
                        local Scale = v45.Scale
                        local v54 = 1 - v45.Scale
                        local v55 = v44 * 5
                        v45.Scale = Scale + v54 * math.min(v55, 1)
                        local BaseSize = v45.BaseSize
                        v45.Holder.Size = UDim2.fromScale(BaseSize.X.Scale * v45.Scale, BaseSize.Y.Scale * v45.Scale)
                    else
                        local v56 = formatClock(v47)
                        v45.TimeLabel.Text = v56
                        if v45.ShadowLabel ~= nil then
                            v45.ShadowLabel.Text = v56
                        end
                        v45.TimeLabel.TextColor3 = v45.CalmColor
                        local Scale = v45.Scale
                        local v57 = 0.55 - v45.Scale
                        local v58 = v44 * 5
                        v45.Scale = Scale + v57 * math.min(v58, 1)
                        local BaseSize = v45.BaseSize
                        v45.Holder.Size = UDim2.fromScale(BaseSize.X.Scale * v45.Scale, BaseSize.Y.Scale * v45.Scale)
                    end
                    v45.LastWholeSecond = v48
                    applyPosition(v45, v44)
                    applyShake(v45)
                end
            end
        else
            local Scale = v45.Scale
            local v59 = 1 - v45.Scale
            local v60 = v44 * 5
            v45.Scale = Scale + v59 * math.min(v60, 1)
            local BaseSize = v45.BaseSize
            v45.Holder.Size = UDim2.fromScale(BaseSize.X.Scale * v45.Scale, BaseSize.Y.Scale * v45.Scale)
            applyPosition(v45, v44)
            applyShake(v45)
        end
    end
end

local function show() -- line 275 | captures: v5, v6, RunService, v2, v3, PlayerGui, step
    local function v61(...)
        return (tonumber(...))
    end

    local function v62(...)
        return (tonumber(...))
    end

    if v5 == nil then
        local v63 = PlayerGui:WaitForChild("CountdownGui", 10)
        if not (v63 ~= nil and v63:IsA("ScreenGui")) then
            warn("[Countdown] Missing StarterGui.CountdownGui; the countdown has no display")
        elseif v5 == nil then
            local v64 = v63:Clone()
            v64.Name = "CountdownGuiActive"
            v64.Enabled = true
            local Holder = v64:FindFirstChild("Holder")
            local v65
            if Holder == nil then
            else
                v65 = Holder:FindFirstChild("Time")
            end
            local Shadow, Punch, CalmColor, UrgentColor, v66, v67
            if Holder == nil then
                v67 = true
            elseif Holder:IsA("Frame") then
                if v65 == nil then
                    v67 = true
                elseif v65:IsA("TextLabel") then
                    Shadow = Holder:FindFirstChild("Shadow")
                    Punch = Holder:FindFirstChild("Punch")
                    CalmColor = Holder:GetAttribute("CalmColor")
                    UrgentColor = Holder:GetAttribute("UrgentColor")
                    v66 = {
                        Scale = 0.55,
                        ShakeUntil = 0,
                        RiserPlayed = false,
                        Gui = v64,
                        Holder = Holder,
                        TimeLabel = v65
                    }
                    if Shadow ~= nil and not Shadow:IsA("TextLabel") then
                        Shadow = nil
                    end
                    v67 = false
                else
                    v67 = true
                end
            else
                v67 = true
            end
            if not v67 then
                v66.ShadowLabel = Shadow
                if Punch ~= nil and not Punch:IsA("UIScale") then
                    Punch = Shadow
                end
                v66.Punch = Punch
                v66.BaseSize = Holder.Size
                v66.BasePosition = Holder.Position
                v66.LoweredPosition = Holder.Position
                v66.LaneGap = v61(Holder:GetAttribute("LaneGapPixels")) or 8
                local Notifications = PlayerGui:FindFirstChild("Notifications")
                local v68
                if Notifications == nil then
                else
                    v68 = Notifications:FindFirstChild("MessageTop")
                end
                if v68 ~= nil and not v68:IsA("Frame") then
                    v68 = Punch
                end
                v66.Lane = v68
                if typeof(CalmColor) ~= "Color3" then
                    CalmColor = v2
                end
                v66.CalmColor = CalmColor
                if typeof(UrgentColor) ~= "Color3" then
                    UrgentColor = v3
                end
                v66.UrgentColor = UrgentColor
                v66.PunchScale = v62(Holder:GetAttribute("PunchScale")) or 1.3
                v66.TimeLabel.Text = ""
                if v66.ShadowLabel ~= nil then
                    v66.ShadowLabel.Text = ""
                end
                v5 = v66
                v64.Parent = PlayerGui
                if v6 == nil then
                    v6 = RunService.RenderStepped:Connect(step)
                end
            else
                warn("[Countdown] CountdownGui needs Holder and Holder.Time; the countdown has no display")
                v64:Destroy()
            end
        end
    end
end

local v69 = {}

function v69.StartEvent(v70, v71, v72) -- line 366 | captures: v7, Workspace, show
    v7 = Workspace:GetServerTimeNow() + v71
    show()
end

function v69.StopEvent(v73) -- line 370 | captures: v5, v7, fadeOut
    v7 = nil
    local v74 = v5
    if v74 ~= nil and v74.FinaleAt == nil then
        fadeOut(v74)
    end
end

Workspace:GetAttributeChangedSignal("AdminAbuseCountdownEndsAt"):Connect(function() -- line 379 | captures: v5, Workspace, fadeOut, show
    local function v75(...)
        return (type(...))
    end

    if v75(Workspace:GetAttribute("AdminAbuseCountdownEndsAt")) == "number" then
        show()
    else
        local v76 = v5
        if v76 ~= nil and v76.FinaleAt == nil then
            fadeOut(v76)
        end
    end
end)

if v1(Workspace:GetAttribute("AdminAbuseCountdownEndsAt")) == "number" then
    show()
else
    local v77 = v5
    if v77 ~= nil and v77.FinaleAt == nil then
        fadeOut(v77)
    end
end
return v69
