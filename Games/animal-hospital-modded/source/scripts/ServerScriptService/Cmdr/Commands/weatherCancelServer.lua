local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

local WeatherHandler = require(ReplicatedStorage.Modules.WeatherHandler)
local Global = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Global")
local MusicFolder = SoundService:WaitForChild("Music")

return function(context)
	if not _G.ActiveWeather then
		return "No weather event is currently active."
	end

	local normal = WeatherHandler.Normal
	local atmosphere = Lighting:FindFirstChildWhichIsA("Atmosphere")

	TweenService:Create(Lighting, TweenInfo.new(1), {ClockTime = normal.ClockTime}):Play()
	if atmosphere then
		TweenService:Create(atmosphere, TweenInfo.new(1), {Color = normal.AtmosphereColor}):Play()
	end

	if _G.ActiveWeather.Model then
		_G.ActiveWeather.Model:Destroy()
	end

	for _, player in ipairs(Players:GetPlayers()) do
		if player.Character then
			local head = player.Character:FindFirstChild("Head")
			if head then
				local auraFace = head:FindFirstChild("AuraFace")
				if auraFace then auraFace:Destroy() end
			end
		end
		pcall(function()
			Global:FireClient(player, "frostEnd")
		end)
	end
	workspace.Gravity = 196.2

	local baseplate = workspace:FindFirstChild("Baseplate")
	if baseplate then
		local origColor = _G.BaseplateOrigColor or Color3.fromRGB(18, 103, 32)
		TweenService:Create(baseplate, TweenInfo.new(1), {Color = origColor}):Play()
		_G.BaseplateOrigColor = nil
	end

	_G.ActiveWeather = nil

	for _, sound in ipairs(MusicFolder:GetChildren()) do
		if sound:IsA("Sound") then
			sound:Stop()
		end
	end
	local normalSound = MusicFolder:FindFirstChild("Normal")
	if normalSound and normalSound:IsA("Sound") then
		normalSound.Looped = true
		normalSound:Play()
	end

	for _, player in ipairs(Players:GetPlayers()) do
		pcall(function()
			Global:FireClient(player, "weatherCancel")
		end)
	end
end