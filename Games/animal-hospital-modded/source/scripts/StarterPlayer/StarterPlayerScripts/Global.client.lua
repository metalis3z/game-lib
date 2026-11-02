local ReplicatedStorage = game:GetService('ReplicatedStorage')
local TweenService = game:GetService('TweenService')
local Players = game:GetService("Players")

local yo = ""
local PollVoteRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("PollVote")
local SoundService = game:GetService("SoundService")

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local FlashFrame = PlayerGui:WaitForChild("FlashUI"):WaitForChild("FlashFrame")
local EventsFrame = PlayerGui:WaitForChild("MainUI"):WaitForChild("Events")
local EventTemplate = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("WeatherHandler"):WaitForChild("EventTemplate")

local activeWeatherUI = nil
local weatherTimerThread = nil

local CameraShaker = require(ReplicatedStorage.Modules.CameraShaker.CameraShaker)
local CameraShakePresets = require(ReplicatedStorage.Modules.CameraShaker.CameraShaker.CameraShakePresets)

local camera = workspace.CurrentCamera
local camShaker = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCFrame)
	camera.CFrame = camera.CFrame * shakeCFrame
end)
camShaker:Start()
local activeShake = nil

local RunService = game:GetService("RunService")
local iceConn = nil
local iceVelocity = Vector3.zero


local function startIceMode()
	if iceConn then return end
	iceVelocity = Vector3.zero
	local DECEL = 0.98
	local ACCEL_BLEND = 0.08
	iceConn = RunService.Heartbeat:Connect(function(dt)
		local player = Players.LocalPlayer
		local character = player.Character
		if not character then return end
		local hrp = character:FindFirstChild("HumanoidRootPart")
		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not hrp or not humanoid then return end

		local moveDir = humanoid.MoveDirection
		local speed = humanoid.WalkSpeed

		if moveDir.Magnitude > 0.1 then
			local targetVel = moveDir * speed
			iceVelocity = iceVelocity:Lerp(targetVel, ACCEL_BLEND)
		else
			iceVelocity = iceVelocity * DECEL
		end

		if iceVelocity.Magnitude < 0.5 then
			iceVelocity = Vector3.zero
			return
		end

		local flatVel = Vector3.new(iceVelocity.X, 0, iceVelocity.Z)
		hrp.AssemblyLinearVelocity = Vector3.new(flatVel.X, hrp.AssemblyLinearVelocity.Y, flatVel.Z)
	end)
end

local function stopIceMode()
	if iceConn then
		iceConn:Disconnect()
		iceConn = nil
	end
	iceVelocity = Vector3.zero
end

--[[
discord.gg/Tsw2b2EkSE is this only server that this admin abuse SHOULD be sold on.
]]--
local function formatTime(seconds)
	local m = math.floor(seconds / 60)
	local s = seconds % 60
	if m > 0 then
		return m .. "m " .. s .. "s"
	end
	return s .. "s"
end

local function doFlash(color, soundId)
	FlashFrame.BackgroundColor3 = color
	FlashFrame.BackgroundTransparency = 0
	if soundId then
		local sound = Instance.new("Sound")
		sound.SoundId = soundId
		sound.Parent = SoundService
		sound:Play()
		sound.Ended:Once(function()
			sound:Destroy()
		end)
	end
	local tween = TweenService:Create(FlashFrame, TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		BackgroundTransparency = 1
	})
	tween:Play()
	tween.Completed:Wait()
end

local function cleanupWeatherUI()
	if weatherTimerThread then
		task.cancel(weatherTimerThread)
		weatherTimerThread = nil
	end
	if activeWeatherUI then
		activeWeatherUI:Destroy()
		activeWeatherUI = nil
	end
end

local function startWeatherUI(data)
	cleanupWeatherUI()

	local frame = EventTemplate:Clone()
	frame.Icon.Image = data.Image
	frame.Time.Text = formatTime(data.Time)
	frame.Parent = EventsFrame
	activeWeatherUI = frame

	local remaining = data.Time
	weatherTimerThread = task.spawn(function()
		while remaining > 0 do
			task.wait(1)
			remaining -= 1
			if activeWeatherUI == frame then
				frame.Time.Text = formatTime(remaining)
			else
				break
			end
		end
	end)
end

local SLAM_IN = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local HOLD_SHRINK = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local PUNCH_OUT = TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local FADE_OUT = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

local BASE_SIZE = UDim2.new(0, 116, 0, 116)
local BIG_SIZE = UDim2.new(0, 180, 0, 180)
local SQUEEZE_SIZE = UDim2.new(0, 100, 0, 100)

local BAR_TWEEN = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function runCountdown(duration)
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    local countdownFrame = PlayerGui:WaitForChild("MainUI"):WaitForChild("Countdown")
    local intLabel = countdownFrame:WaitForChild("Int")

    countdownFrame.Visible = true

    for i = duration, 1, -1 do
        intLabel.TextTransparency = 1
        intLabel.Text = tostring(i)
        countdownFrame.Size = UDim2.new(0, 0, 0, 0)
        intLabel.Rotation = -8

        local slamSize = TweenService:Create(countdownFrame, SLAM_IN, {Size = BIG_SIZE})
        local slamText = TweenService:Create(intLabel, SLAM_IN, {TextTransparency = 0, Rotation = 0})
        slamSize:Play()
        slamText:Play()
        slamSize.Completed:Wait()

        local squeeze = TweenService:Create(countdownFrame, HOLD_SHRINK, {Size = SQUEEZE_SIZE})
        squeeze:Play()
        squeeze.Completed:Wait()

        local punch = TweenService:Create(countdownFrame, PUNCH_OUT, {Size = BASE_SIZE})
        punch:Play()
        punch.Completed:Wait()

        task.wait(math.max(0, 1 - 0.25 - 0.15 - 0.12 - 0.2))

        local fadeText = TweenService:Create(intLabel, FADE_OUT, {TextTransparency = 1})
        local shrinkOut = TweenService:Create(countdownFrame, FADE_OUT, {Size = UDim2.new(0, 0, 0, 0)})
        fadeText:Play()
        shrinkOut:Play()
        shrinkOut.Completed:Wait()
    end

    countdownFrame.Visible = false
    intLabel.TextTransparency = 0
end


local pollFrame = PlayerGui:WaitForChild("MainUI"):WaitForChild("PollVoting")
local buttons = pollFrame:WaitForChild("Buttons")
local bar = pollFrame:WaitForChild("Bar")

local leftButton = buttons:WaitForChild("LeftButton")
local rightButton = buttons:WaitForChild("RightButton")
local leftBar = bar:WaitForChild("Left")
local rightBar = bar:WaitForChild("Right")
local leftVotesLabel = bar:WaitForChild("LeftVotes")
local rightVotesLabel = bar:WaitForChild("RightVotes")
local questionLabel = bar:WaitForChild("Question")
local leftPercentLabel = leftBar:WaitForChild("LeftPercent"):WaitForChild("LeftPercent")
local rightPercentLabel = rightBar:WaitForChild("RightPercent"):WaitForChild("LeftPercent")

local myVote = nil

local questionOrigPos = questionLabel.Position
local barOrigPos = bar.Position
local barOrigSize = bar.Size
local buttonsOrigPos = buttons.Position

local SLIDE_IN = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local FADE_IN = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local SCALE_IN = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local SLIDE_OUT = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local FADE_OUT_POLL = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In)


local function hideAllPollElements()
    questionLabel.TextTransparency = 1
    questionLabel.Position = questionOrigPos - UDim2.new(0, 0, 0.3, 0)
    for _, obj in ipairs(questionLabel:GetDescendants()) do
        if obj:IsA("UIStroke") then obj.Transparency = 1 end
    end

    bar.Size = UDim2.new(0, 0, barOrigSize.Y.Scale, barOrigSize.Y.Offset)
    bar.BackgroundTransparency = 1
    leftVotesLabel.TextTransparency = 1
    rightVotesLabel.TextTransparency = 1
    leftBar.BackgroundTransparency = 1
    rightBar.BackgroundTransparency = 1
    for _, obj in ipairs(bar:GetDescendants()) do
        if obj:IsA("UIStroke") then obj.Transparency = 1 end
    end

    buttons.Position = buttonsOrigPos + UDim2.new(0, 0, 0.3, 0)
    leftButton.BackgroundTransparency = 1
    rightButton.BackgroundTransparency = 1
    leftButton.Title.TextTransparency = 1
    rightButton.Title.TextTransparency = 1
    for _, obj in ipairs(buttons:GetDescendants()) do
        if obj:IsA("UIStroke") then obj.Transparency = 1 end
    end
end

local function showPollIntro()
    hideAllPollElements()
    pollFrame.Visible = true

    TweenService:Create(questionLabel, SLIDE_IN, {
        Position = questionOrigPos,
        TextTransparency = 0,
    }):Play()
    for _, obj in ipairs(questionLabel:GetDescendants()) do
        if obj:IsA("UIStroke") then
            TweenService:Create(obj, FADE_IN, {Transparency = 0}):Play()
        end
    end

    task.wait(0.3)

    TweenService:Create(bar, SCALE_IN, {
        Size = barOrigSize,
        BackgroundTransparency = 0,
    }):Play()
    for _, obj in ipairs(bar:GetDescendants()) do
        if obj:IsA("UIStroke") then
            TweenService:Create(obj, FADE_IN, {Transparency = 0}):Play()
        end
    end
    task.wait(0.15)
    TweenService:Create(leftBar, FADE_IN, {BackgroundTransparency = 0}):Play()
    TweenService:Create(rightBar, FADE_IN, {BackgroundTransparency = 0}):Play()
    TweenService:Create(leftVotesLabel, FADE_IN, {TextTransparency = 0}):Play()
    TweenService:Create(rightVotesLabel, FADE_IN, {TextTransparency = 0}):Play()

    task.wait(0.25)

    TweenService:Create(buttons, SLIDE_IN, {Position = buttonsOrigPos}):Play()
    TweenService:Create(leftButton, FADE_IN, {BackgroundTransparency = 0}):Play()
    TweenService:Create(rightButton, FADE_IN, {BackgroundTransparency = 0}):Play()
    TweenService:Create(leftButton.Title, FADE_IN, {TextTransparency = 0}):Play()
    TweenService:Create(rightButton.Title, FADE_IN, {TextTransparency = 0}):Play()
    for _, obj in ipairs(buttons:GetDescendants()) do
        if obj:IsA("UIStroke") then
            TweenService:Create(obj, FADE_IN, {Transparency = 0}):Play()
        end
    end
end

local function showPollOutro()
    TweenService:Create(buttons, SLIDE_OUT, {Position = buttonsOrigPos + UDim2.new(0, 0, 0.3, 0)}):Play()
    TweenService:Create(leftButton, FADE_OUT_POLL, {BackgroundTransparency = 1}):Play()
    TweenService:Create(rightButton, FADE_OUT_POLL, {BackgroundTransparency = 1}):Play()
    TweenService:Create(leftButton.Title, FADE_OUT_POLL, {TextTransparency = 1}):Play()
    TweenService:Create(rightButton.Title, FADE_OUT_POLL, {TextTransparency = 1}):Play()
    for _, obj in ipairs(buttons:GetDescendants()) do
        if obj:IsA("UIStroke") then
            TweenService:Create(obj, FADE_OUT_POLL, {Transparency = 1}):Play()
        end
    end

    task.wait(0.2)

    TweenService:Create(bar, SLIDE_OUT, {Size = UDim2.new(0, 0, barOrigSize.Y.Scale, barOrigSize.Y.Offset)}):Play()
    TweenService:Create(bar, FADE_OUT_POLL, {BackgroundTransparency = 1}):Play()
    TweenService:Create(leftVotesLabel, FADE_OUT_POLL, {TextTransparency = 1}):Play()
    TweenService:Create(rightVotesLabel, FADE_OUT_POLL, {TextTransparency = 1}):Play()
    TweenService:Create(leftBar, FADE_OUT_POLL, {BackgroundTransparency = 1}):Play()
    TweenService:Create(rightBar, FADE_OUT_POLL, {BackgroundTransparency = 1}):Play()
    for _, obj in ipairs(bar:GetDescendants()) do
        if obj:IsA("UIStroke") then
            TweenService:Create(obj, FADE_OUT_POLL, {Transparency = 1}):Play()
        end
    end

    task.wait(0.2)

    local t = TweenService:Create(questionLabel, SLIDE_OUT, {
        Position = questionOrigPos - UDim2.new(0, 0, 0.3, 0),
        TextTransparency = 1,
    })
    for _, obj in ipairs(questionLabel:GetDescendants()) do
        if obj:IsA("UIStroke") then
            TweenService:Create(obj, FADE_OUT_POLL, {Transparency = 1}):Play()
        end
    end
    t:Play()
    t.Completed:Wait()

    pollFrame.Visible = false
end


local function updatePollUI(data)
    local leftVotes = data.leftVotes or 0
    local rightVotes = data.rightVotes or 0
    local total = leftVotes + rightVotes

    leftVotesLabel.Text = leftVotes .. " Vote" .. (leftVotes == 1 and "" or "s")
    rightVotesLabel.Text = rightVotes .. " Vote" .. (rightVotes == 1 and "" or "s")

    local leftPct = total > 0 and (leftVotes / total) or 0.5
    local rightPct = total > 0 and (rightVotes / total) or 0.5

    leftPercentLabel.Text = math.floor(leftPct * 100 + 0.5) .. "%"
    rightPercentLabel.Text = math.floor(rightPct * 100 + 0.5) .. "%"

    TweenService:Create(leftBar, BAR_TWEEN, {Size = UDim2.new(leftPct, 0, 1, 0)}):Play()
    TweenService:Create(rightBar, BAR_TWEEN, {Size = UDim2.new(rightPct, 0, 1, 0)}):Play()
end

local SELECTED_COLOR = Color3.fromRGB(255, 255, 111)
local DEFAULT_COLOR = Color3.new(1, 1, 1)
local COLOR_TWEEN = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function updateSelectedButton()
    local leftColor = myVote == "left" and SELECTED_COLOR or DEFAULT_COLOR
    local rightColor = myVote == "right" and SELECTED_COLOR or DEFAULT_COLOR
    TweenService:Create(leftButton.Title, COLOR_TWEEN, {TextColor3 = leftColor}):Play()
    TweenService:Create(rightButton.Title, COLOR_TWEEN, {TextColor3 = rightColor}):Play()
end


leftButton.MouseButton1Click:Connect(function()
    if not pollFrame.Visible then return end
    myVote = "left"
    updateSelectedButton()
    PollVoteRemote:FireServer("left")
end)

rightButton.MouseButton1Click:Connect(function()
    if not pollFrame.Visible then return end
    myVote = "right"
    updateSelectedButton()
    PollVoteRemote:FireServer("right")
end)

ReplicatedStorage.Remotes.Global.OnClientEvent:Connect(function(action, message, userid, name)
    if action == 'globalNotify' then
        local new = script.MessageFrame:Clone()
        local PGui = Players.LocalPlayer:WaitForChild("PlayerGui")

        if userid then
            local ok, thumb = pcall(function()
                return Players:GetUserThumbnailAsync(userid, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
            end)
        end
        new.Message.Text = string.format("%s %s : %s", yo, name or "System", message)

        for _, obj in ipairs(new:GetDescendants()) do
            if obj:IsA("TextLabel") then
                obj.TextTransparency = 1
                obj.TextStrokeTransparency = 1
            elseif obj:IsA("ImageLabel") then
                obj.ImageTransparency = 1
            elseif obj:IsA("UIStroke") then
                obj.Transparency = 1
            end
        end

        local function fade(object, targetTransparency, dur)
            local props = {}
            if object:IsA("TextLabel") then
                props.TextTransparency = targetTransparency
                props.TextStrokeTransparency = targetTransparency
            elseif object:IsA("ImageLabel") then
                props.ImageTransparency = targetTransparency
            elseif object:IsA("UIStroke") then
                props.Transparency = targetTransparency
            end
            local tween = TweenService:Create(object, TweenInfo.new(dur, Enum.EasingStyle.Bounce, Enum.EasingDirection.InOut), props)
            tween:Play()
        end
        
        if PGui.MainUI.Global:FindFirstChild('Notify') then
            for _, obj in ipairs(PGui.MainUI.Global.Notify:GetDescendants()) do
                if obj:IsA("TextLabel") or obj:IsA("ImageLabel") or obj:IsA("UIStroke") then
                    fade(obj, 1, 0.3)
                end
            end

            task.wait(0.5)
            PGui.MainUI.Global.Notify:Destroy()
        end
        
        new.Parent = PGui.MainUI.Global

        for _, obj in ipairs(new:GetDescendants()) do
            if obj:IsA("TextLabel") or obj:IsA("ImageLabel") or obj:IsA("UIStroke") then
                fade(obj, 0, 0.3)
            end
        end

        task.delay(10, function()
            for _, obj in ipairs(new:GetDescendants()) do
                if obj:IsA("TextLabel") or obj:IsA("ImageLabel") or obj:IsA("UIStroke") then
                    fade(obj, 1, 0.3)
                end
            end

            task.wait(0.5)
            new:Destroy()
        end)

    elseif action == "countdown" then
        local dur = tonumber(message) or 10
        task.spawn(runCountdown, dur)

    elseif action == "pollStart" then
        local data = message
        myVote = nil
        leftButton.Title.TextColor3 = DEFAULT_COLOR
        rightButton.Title.TextColor3 = DEFAULT_COLOR
        questionLabel.Text = data.question
        leftButton.Title.Text = data.option1
        rightButton.Title.Text = data.option2
        updatePollUI(data)
        task.spawn(showPollIntro)

    elseif action == "pollUpdate" then
        local data = message
        updatePollUI(data)

    elseif action == "pollEnd" then
        task.delay(3, function()
            task.spawn(showPollOutro)
        end)

    elseif action == "forceDance" then
        local data = message
        task.spawn(function()
            local player = Players.LocalPlayer
            local character = player.Character
            if not character then return end
            local humanoid = character:FindFirstChildWhichIsA("Humanoid")
            if not humanoid then return end

            if _G.forcedDanceTrack then
                _G.forcedDanceTrack:Stop()
                _G.forcedDanceTrack:Destroy()
                _G.forcedDanceTrack = nil
            end
            if _G.forcedDanceAnim then
                _G.forcedDanceAnim:Destroy()
                _G.forcedDanceAnim = nil
            end
            if _G.forcedDanceConn then
                _G.forcedDanceConn:Disconnect()
                _G.forcedDanceConn = nil
            end

            local animator = humanoid:FindFirstChildWhichIsA("Animator")
            if not animator then return end

            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://" .. tostring(data.animId)
            _G.forcedDanceAnim = anim

            local track = animator:LoadAnimation(anim)
            track.Priority = Enum.AnimationPriority.Action
            track.Looped = true
            track:Play()
            _G.forcedDanceTrack = track

            _G.forcedDanceConn = track.Stopped:Connect(function()
                if _G.forcedDanceTrack == track then
                    track:Play()
                end
            end)
        end)

    elseif action == "cancelEmote" then
        task.spawn(function()
            if _G.forcedDanceTrack then
                _G.forcedDanceTrack:Stop()
                _G.forcedDanceTrack:Destroy()
                _G.forcedDanceTrack = nil
            end
            if _G.forcedDanceAnim then
                _G.forcedDanceAnim:Destroy()
                _G.forcedDanceAnim = nil
            end
            if _G.forcedDanceConn then
                _G.forcedDanceConn:Disconnect()
                _G.forcedDanceConn = nil
            end
        end)

    elseif action == "weatherStart" then
        local data = message
        task.spawn(function()
            if activeShake then
                activeShake:StartFadeOut(0.5)
                activeShake = nil
            end
            stopIceMode()

            local flashColor = Color3.fromRGB(data.FlashR, data.FlashG, data.FlashB)
            camShaker:Shake(CameraShakePresets["Soft Bump"])
            task.spawn(doFlash, flashColor, data.SoundID)
            -- print("produced and sold by arnavdabest only")
            startWeatherUI(data)
            if data.Name == "Aura" then
                activeShake = camShaker:ShakeSustain(CameraShakePresets.Earthquake)
            end
        end)

    elseif action == "weatherEnd" then
        task.spawn(function()
            if activeShake then
                activeShake:StartFadeOut(1)
                activeShake = nil
            end
            stopIceMode()
            cleanupWeatherUI()
            doFlash(Color3.new(1, 1, 1))
        end)

    elseif action == "weatherCancel" then
        task.spawn(function()
            if activeShake then
                activeShake:StartFadeOut(1)
                activeShake = nil
            end
            stopIceMode()
            cleanupWeatherUI()
            doFlash(Color3.new(1, 1, 1))
        end)

    elseif action == "frostStart" then
        startIceMode()

    elseif action == "frostEnd" then
        stopIceMode()
    end
end)