-- Reference copy for study. Game: +1 Drill & Mine (drill-and-mine)
-- Original: ReplicatedStorage/Source/Controllers/NotificationsController.luau  (luau, 250 lines)
-- Categories: ui-animation 20.7, notifications 17.2
-- What it does: Colored toast notifications (Red/Green templates) that merge duplicates into "(xN)", pulse on repeat, pop in/out with UIScale, and preload their sounds.

local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

-- Per-type toast sounds (user-picked): Red = error / "you can't do that",
-- Green = success. Every other template (Rainbow spawn toasts, ...) keeps
-- the original notification pop.
local NOTIFICATION_SOUNDS = {
	Red = "rbxassetid://123430321654900",
	Green = "rbxassetid://136993031050456",
}
local DEFAULT_NOTIFICATION_SOUND = "rbxassetid://116155134441855"
local notificationSounds = {} -- [soundId] = base Sound kept in SoundService

local function playNotificationSound(colorName)
	local soundId = NOTIFICATION_SOUNDS[colorName] or DEFAULT_NOTIFICATION_SOUND
	local base = notificationSounds[soundId]
	if not base then
		base = Instance.new("Sound")
		base.Name = "NotificationPopSound"
		base.SoundId = soundId
		base.Volume = 0.6
		base.Parent = SoundService
		notificationSounds[soundId] = base
	end
	local one = base:Clone()
	one.Parent = SoundService
	one:Play()
	one.Ended:Once(function()
		one:Destroy()
	end)
	task.delay(5, function()
		if one.Parent then
			one:Destroy()
		end
	end)
end

-- warm the sound assets up front: a cold asset downloads on its first
-- Play(), which reads as a missing/late sound on the first toast
task.spawn(function()
	local toLoad = {}
	for _, id in { NOTIFICATION_SOUNDS.Red, NOTIFICATION_SOUNDS.Green, DEFAULT_NOTIFICATION_SOUND } do
		local s = Instance.new("Sound")
		s.SoundId = id
		table.insert(toLoad, s)
	end
	pcall(function()
		game:GetService("ContentProvider"):PreloadAsync(toLoad)
	end)
	for _, s in toLoad do
		s:Destroy()
	end
end)

local NotificationsController = {}

local player = Players.LocalPlayer

local SCALE_START = 0.0
local SCALE_OVERSHOOT = 1.15
local POP_IN_DURATION = 0.2
local POP_OUT_DURATION = 0.2
local PULSE_HALF = 0.1
local DEFAULT_VISIBLE_TIME = 1.6

local notificationFrame = nil
local templates = {}
local initialized = false
local active = {}

local function tryGetFrame()
	if notificationFrame and notificationFrame.Parent then return notificationFrame end
	local playerGui = player:FindFirstChild("PlayerGui")
	if not playerGui then return nil end
	local gui = playerGui:FindFirstChild("GUI")
	local folder = gui and gui:FindFirstChild("Folder")
	local notif = folder and folder:FindFirstChild("Notification")
	if not notif then return nil end
	notificationFrame = notif
	return notif
end

local function getTemplate(colorName)
	local cached = templates[colorName]
	if cached and cached.Parent then return cached end
	local frame = tryGetFrame()
	if not frame then return nil end
	local tmpl = frame:FindFirstChild("Notification" .. colorName)
	if not tmpl then return nil end
	tmpl.Visible = false
	templates[colorName] = tmpl
	return tmpl
end

local function setLabel(clone, text)
	local label = clone:FindFirstChildWhichIsA("TextLabel")
	if label then
		label.Text = text
	end
end

local function setInitialTransparency(clone, alpha)
	for _, desc in ipairs(clone:GetDescendants()) do
		if desc:IsA("TextLabel") or desc:IsA("TextButton") then
			desc.TextTransparency = alpha
		end
		if desc:IsA("ImageLabel") or desc:IsA("ImageButton") then
			desc.ImageTransparency = alpha
		end
		if desc:IsA("UIStroke") then
			desc.Transparency = alpha
		end
		if desc:IsA("Frame") then
			desc.BackgroundTransparency = alpha
		end
	end
end

local function tweenTransparency(clone, alpha, info)
	for _, desc in ipairs(clone:GetDescendants()) do
		local goal = nil
		if desc:IsA("TextLabel") or desc:IsA("TextButton") then
			goal = { TextTransparency = alpha }
		elseif desc:IsA("ImageLabel") or desc:IsA("ImageButton") then
			goal = { ImageTransparency = alpha }
		elseif desc:IsA("UIStroke") then
			goal = { Transparency = alpha }
		elseif desc:IsA("Frame") then
			goal = { BackgroundTransparency = alpha }
		end
		if goal then
			TweenService:Create(desc, info, goal):Play()
		end
	end
end

local function scheduleRemove(entry)
	entry.removeToken = (entry.removeToken or 0) + 1
	local token = entry.removeToken
	task.delay(entry.visibleTime, function()
		if token ~= entry.removeToken then return end
		if not entry.clone or not entry.clone.Parent then return end

		active[entry.key] = nil

		local popInfo = TweenInfo.new(POP_OUT_DURATION, Enum.EasingStyle.Back, Enum.EasingDirection.In)
		local fadeInfo = TweenInfo.new(POP_OUT_DURATION * 0.85, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
		tweenTransparency(entry.clone, 1, fadeInfo)
		local popOut = TweenService:Create(entry.scale, popInfo, { Scale = 0 })
		popOut:Play()
		popOut.Completed:Once(function()
			if entry.clone and entry.clone.Parent then
				entry.clone:Destroy()
			end
		end)
	end)
end

local function pulseEntry(entry)
	if not entry.scale then return end
	local up = TweenService:Create(entry.scale, TweenInfo.new(PULSE_HALF, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = SCALE_OVERSHOOT })
	up.Completed:Once(function()
		TweenService:Create(entry.scale, TweenInfo.new(PULSE_HALF, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Scale = 1.0 }):Play()
	end)
	up:Play()
end

function NotificationsController.Send(colorName, text, visibleTime)
	if not colorName or colorName == "" then return end
	text = text or ""
	visibleTime = visibleTime or DEFAULT_VISIBLE_TIME

	local key = colorName .. "|" .. text

	local existing = active[key]
	if existing and existing.clone and existing.clone.Parent then
		existing.count = (existing.count or 1) + 1
		setLabel(existing.clone, text .. " (x" .. existing.count .. ")")
		existing.visibleTime = visibleTime
		scheduleRemove(existing)
		pulseEntry(existing)
		playNotificationSound(colorName)
		return
	end

	local tmpl = getTemplate(colorName)
	if not tmpl then return end

	local frame = notificationFrame
	if not frame then return end

	local clone = tmpl:Clone()
	clone.Name = "Notification" .. colorName .. "_" .. tick()
	clone.Visible = true
	setLabel(clone, text)

	local scale = clone:FindFirstChildOfClass("UIScale")
	if not scale then
		scale = Instance.new("UIScale")
		scale.Parent = clone
	end
	scale.Scale = SCALE_START

	setInitialTransparency(clone, 1)
	clone.Parent = frame

	local popInfo = TweenInfo.new(POP_IN_DURATION, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	local popIn = TweenService:Create(scale, popInfo, { Scale = 1.0 })

	local fadeInfo = TweenInfo.new(POP_IN_DURATION * 0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	tweenTransparency(clone, 0, fadeInfo)

	popIn:Play()

	local entry = {
		key = key,
		clone = clone,
		scale = scale,
		count = 1,
		visibleTime = visibleTime,
		removeToken = 0,
	}
	active[key] = entry

	scheduleRemove(entry)
	playNotificationSound(colorName)
end

function NotificationsController.SendRed(text, visibleTime)
	NotificationsController.Send("Red", text, visibleTime)
end

function NotificationsController.SendGreen(text, visibleTime)
	NotificationsController.Send("Green", text, visibleTime)
end

function NotificationsController.Init()
	if initialized then return end
	initialized = true
	task.spawn(function()
		for _ = 1, 60 do
			if tryGetFrame() then return end
			task.wait(0.25)
		end
	end)
end

return NotificationsController
