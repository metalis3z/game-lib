-- Reference copy for study. Game: +1 Drill & Mine (drill-and-mine)
-- Original: ReplicatedStorage/Source/Controllers/SettingsController.lua
-- What it does: Settings controller with Music and Sounds volume sliders (tweened fill bar and knob). Applies volume to every Sound in SoundService.Music and SoundService.Sounds, including ones added later, and debounces saves to the server (0.3 s task.delay cancelled on each new change).

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local SettingsController = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local SettingsRemotes = Remotes:WaitForChild("SettingsService")
local UpdateSettingFunc = SettingsRemotes:WaitForChild("UpdateSetting")
local RequestSettingsFunc = SettingsRemotes:WaitForChild("RequestSettings")
local SettingsUpdateEvent = SettingsRemotes:WaitForChild("SettingsUpdate")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local MusicFolder = SoundService:WaitForChild("Music")
local SoundsFolder = SoundService:WaitForChild("Sounds")

SettingsController.VfxToggled = Instance.new("BindableEvent")

local currentSettings = {
	MusicVolume = 0.1,
	SoundsVolume = 0.5,
	BrainrotVfx = true,
}

local musicSlider = {}
local soundsSlider = {}
local vfxOnButton = nil
local vfxOffButton = nil

local activeDrag = nil

local TWEEN_INFO = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local pendingSaves = {}

local function applyMusicVolume(volume)
	for _, sound in ipairs(MusicFolder:GetDescendants()) do
		if sound:IsA("Sound") then
			sound.Volume = volume
		end
	end
end

local function applySoundsVolume(volume)
	for _, sound in ipairs(SoundsFolder:GetDescendants()) do
		if sound:IsA("Sound") then
			sound.Volume = volume
		end
	end
end

local function updateSlider(slider, value)
	value = math.clamp(value, 0, 1)

	if slider.FillBar then
		local currentSize = slider.FillBar.Size
		local targetSize = UDim2.new(value, 0, currentSize.Y.Scale, currentSize.Y.Offset)
		TweenService:Create(slider.FillBar, TWEEN_INFO, { Size = targetSize }):Play()
	end

	if slider.BoolButton then
		local targetPos = UDim2.new(
			value,
			0,
			slider.BoolButton.Position.Y.Scale,
			slider.BoolButton.Position.Y.Offset
		)
		TweenService:Create(slider.BoolButton, TWEEN_INFO, { Position = targetPos }):Play()
	end

	if slider.TitleLabel then
		slider.TitleLabel.Text = tostring(math.floor(value * 100))
	end
end

local function saveSetting(key, value)
	if pendingSaves[key] then
		task.cancel(pendingSaves[key])
		pendingSaves[key] = nil
	end

	pendingSaves[key] = task.delay(0.3, function()
		pendingSaves[key] = nil
		pcall(function()
			UpdateSettingFunc:InvokeServer(key, value)
		end)
	end)
end

local function getSliderValue(barFrame, inputX)
	if not barFrame then return 0 end
	local absPos = barFrame.AbsolutePosition.X
	local absWidth = barFrame.AbsoluteSize.X
	if absWidth <= 0 then return 0 end
	return math.clamp((inputX - absPos) / absWidth, 0, 1)
end

local function processSliderInput(slider, inputX, settingsKey, applyFunc)
	local value = getSliderValue(slider.BarFrame, inputX)
	currentSettings[settingsKey] = value
	updateSlider(slider, value)
	applyFunc(value)
end

local function updateVfxButtons(enabled)
	if vfxOnButton then
		vfxOnButton.Visible = enabled
	end
	if vfxOffButton then
		vfxOffButton.Visible = not enabled
	end
end

function SettingsController.IsBrainrotVfxEnabled()
	return currentSettings.BrainrotVfx
end

function SettingsController.GetMusicVolume()
	return currentSettings.MusicVolume
end

function SettingsController.GetSoundsVolume()
	return currentSettings.SoundsVolume
end

local function applyAllSettings()
	applyMusicVolume(currentSettings.MusicVolume)
	applySoundsVolume(currentSettings.SoundsVolume)
	updateSlider(musicSlider, currentSettings.MusicVolume)
	updateSlider(soundsSlider, currentSettings.SoundsVolume)
	updateVfxButtons(currentSettings.BrainrotVfx)
end

local function setupSliderConnections(slider, settingsKey, applyFunc, saveKey)
	if not slider.BarFrame then return end

	local function onBegin(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1
			and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		processSliderInput(slider, input.Position.X, settingsKey, applyFunc)

		activeDrag = {
			Slider = slider,
			SettingsKey = settingsKey,
			ApplyFunc = applyFunc,
			SaveKey = saveKey,
		}
	end

	slider.BarFrame.InputBegan:Connect(onBegin)

	if slider.FillBar then
		slider.FillBar.InputBegan:Connect(onBegin)
	end

	if slider.BoolButton then
		slider.BoolButton.InputBegan:Connect(onBegin)
	end
end

function SettingsController.Init()
	local mainGui = playerGui:WaitForChild("MainUI", 10)
	if not mainGui then
		return
	end

	local frames = mainGui:WaitForChild("Frames", 10)
	if not frames then return end

	local settingsFrame = frames:WaitForChild("Settings", 10)
	if not settingsFrame then return end

	local scrollingFrame = settingsFrame:WaitForChild("ScrollingFrame", 10)
	if not scrollingFrame then return end

	local musicFrame = scrollingFrame:WaitForChild("Music", 5)
	if musicFrame then
		local bar = musicFrame:WaitForChild("Bar", 5)
		if bar then
			musicSlider.BarFrame = bar
			musicSlider.BoolButton = bar:FindFirstChild("Bool")
			if musicSlider.BoolButton then
				musicSlider.TitleLabel = musicSlider.BoolButton:FindFirstChild("Title")
			end
			local canvasGroup = bar:FindFirstChild("CanvasGroup")
			if canvasGroup then
				musicSlider.FillBar = canvasGroup:FindFirstChild("Bar")
			end
		end
	end

	local soundsFrame = scrollingFrame:WaitForChild("Sounds", 5)
	if soundsFrame then
		local bar = soundsFrame:WaitForChild("Bar", 5)
		if bar then
			soundsSlider.BarFrame = bar
			soundsSlider.BoolButton = bar:FindFirstChild("Bool")
			if soundsSlider.BoolButton then
				soundsSlider.TitleLabel = soundsSlider.BoolButton:FindFirstChild("Title")
			end
			local canvasGroup = bar:FindFirstChild("CanvasGroup")
			if canvasGroup then
				soundsSlider.FillBar = canvasGroup:FindFirstChild("Bar")
			end
		end
	end

	local vfxFrame = scrollingFrame:WaitForChild("BrainrotVfx", 5)
	if vfxFrame then
		vfxOnButton = vfxFrame:FindFirstChild("On")
		vfxOffButton = vfxFrame:FindFirstChild("Off")

		if vfxOnButton then
			vfxOnButton.MouseButton1Click:Connect(function()
				currentSettings.BrainrotVfx = false
				updateVfxButtons(false)
				saveSetting("BrainrotVfx", false)
				SettingsController.VfxToggled:Fire(false)
			end)
		end

		if vfxOffButton then
			vfxOffButton.MouseButton1Click:Connect(function()
				currentSettings.BrainrotVfx = true
				updateVfxButtons(true)
				saveSetting("BrainrotVfx", true)
				SettingsController.VfxToggled:Fire(true)
			end)
		end
	end

	setupSliderConnections(musicSlider, "MusicVolume", applyMusicVolume, "MusicVolume")
	setupSliderConnections(soundsSlider, "SoundsVolume", applySoundsVolume, "SoundsVolume")

	UserInputService.InputChanged:Connect(function(input)
		if not activeDrag then return end
		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then
			processSliderInput(
				activeDrag.Slider,
				input.Position.X,
				activeDrag.SettingsKey,
				activeDrag.ApplyFunc
			)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if not activeDrag then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			saveSetting(activeDrag.SaveKey, currentSettings[activeDrag.SettingsKey])
			activeDrag = nil
		end
	end)

	SettingsUpdateEvent.OnClientEvent:Connect(function(settings)
		if not settings then return end
		local oldVfx = currentSettings.BrainrotVfx

		if settings.MusicVolume ~= nil then
			currentSettings.MusicVolume = settings.MusicVolume
		end
		if settings.SoundsVolume ~= nil then
			currentSettings.SoundsVolume = settings.SoundsVolume
		end
		if settings.BrainrotVfx ~= nil then
			currentSettings.BrainrotVfx = settings.BrainrotVfx
		end

		applyAllSettings()

		if oldVfx ~= currentSettings.BrainrotVfx then
			SettingsController.VfxToggled:Fire(currentSettings.BrainrotVfx)
		end
	end)

	task.spawn(function()
		for _ = 1, 20 do
			local success, settings = pcall(function()
				return RequestSettingsFunc:InvokeServer()
			end)
			if success and settings then
				if settings.MusicVolume ~= nil then
					currentSettings.MusicVolume = settings.MusicVolume
				end
				if settings.SoundsVolume ~= nil then
					currentSettings.SoundsVolume = settings.SoundsVolume
				end
				if settings.BrainrotVfx ~= nil then
					currentSettings.BrainrotVfx = settings.BrainrotVfx
				end
				applyAllSettings()

				if not currentSettings.BrainrotVfx then
					SettingsController.VfxToggled:Fire(false)
				end

				return
			end
			task.wait(0.5)
		end
	end)

	applyAllSettings()

	MusicFolder.DescendantAdded:Connect(function(desc)
		if desc:IsA("Sound") then
			desc.Volume = currentSettings.MusicVolume
		end
	end)

	SoundsFolder.DescendantAdded:Connect(function(desc)
		if desc:IsA("Sound") then
			desc.Volume = currentSettings.SoundsVolume
		end
	end)
end

return SettingsController