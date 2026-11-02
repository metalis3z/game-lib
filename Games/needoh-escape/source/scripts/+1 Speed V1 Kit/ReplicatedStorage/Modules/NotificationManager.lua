--!strict
-- LOCATION: ReplicatedStorage/Modules/NotificationManager

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")

local NotificationManager = {}

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local TWEEN_INFO_FADE = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local NOTIFICATION_LIFETIME = 2

-- Color Definitions
local successStrokeColor = Color3.fromRGB(25, 75, 0)
local successGradient = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 255, 0)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0)),
})
local errorStrokeColor = Color3.fromRGB(100, 0, 0)
local errorGradient = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 85, 127)),
})

local notificationTemplate = ReplicatedStorage:WaitForChild("Templates"):WaitForChild("NotificationTemplate")

-- Resolve the notifications frame fresh each call so death/reinit never breaks it
local function getNotificationFrame()
	local gui = playerGui:FindFirstChild("GUI")
	if not gui then return nil end
	local frames = gui:FindFirstChild("Frames")
	if not frames then return nil end
	return frames:FindFirstChild("Notifications")
end

-- show() is always fire-and-forget — never yields the caller
function NotificationManager.show(message: string, messageType: string)
	task.spawn(function()
		local notificationFrame = getNotificationFrame()
		if not notificationFrame then return end

		local newNotification = notificationTemplate:Clone() :: TextLabel
		newNotification.Text = message

		local stroke = newNotification:FindFirstChild("Stroke") :: UIStroke
		local gradient = newNotification:FindFirstChild("Gradient") :: UIGradient

		if stroke and gradient then
			if messageType == "Success" then
				stroke.Color = successStrokeColor
				gradient.Color = successGradient
			else
				stroke.Color = errorStrokeColor
				gradient.Color = errorGradient
			end
		end

		newNotification.Parent = notificationFrame
		newNotification.TextTransparency = 1
		if stroke then stroke.Transparency = 1 end

		local textFadeIn = TweenService:Create(newNotification, TWEEN_INFO_FADE, { TextTransparency = 0 })
		local strokeFadeIn = stroke and TweenService:Create(stroke, TWEEN_INFO_FADE, { Transparency = 0 })

		textFadeIn:Play()
		if strokeFadeIn then strokeFadeIn:Play() end

		-- Play sound
		local soundFolder = Workspace:FindFirstChild("Sounds")
		if soundFolder then
			local sound = soundFolder:FindFirstChild(messageType) :: Sound
			if sound then SoundService:PlayLocalSound(sound) end
		end

		task.wait(NOTIFICATION_LIFETIME)

		-- Guard: frame may have been destroyed if player left/reset
		if not newNotification.Parent then return end

		local textFadeOut = TweenService:Create(newNotification, TWEEN_INFO_FADE, { TextTransparency = 1 })
		local strokeFadeOut = stroke and TweenService:Create(stroke, TWEEN_INFO_FADE, { Transparency = 1 })

		textFadeOut:Play()
		if strokeFadeOut then strokeFadeOut:Play() end
		textFadeOut.Completed:Wait()

		if newNotification.Parent then
			newNotification:Destroy()
		end
	end)
end

return NotificationManager