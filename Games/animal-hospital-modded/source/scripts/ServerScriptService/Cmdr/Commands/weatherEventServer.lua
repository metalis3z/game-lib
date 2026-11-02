local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

local WeatherHandler = require(ReplicatedStorage.Modules.WeatherHandler)
local Global = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Global")
local WeatherEvents = ReplicatedStorage:WaitForChild("WeatherEvent")
local MusicFolder = SoundService:WaitForChild("Music")
local AuraFaceTemplate = ReplicatedStorage.Modules.WeatherHandler:WaitForChild("AuraFace")

local AURA_FACES = {
	"rbxassetid://125356575288990",
	"rbxassetid://112478044631646",
	"rbxassetid://86127615336833",
	"rbxassetid://130178280923162",
	
}

local VALID_TYPES = {}
for name in pairs(WeatherHandler.WheatherList) do
	VALID_TYPES[name:lower()] = name
end

local playerAddedConn = nil
local auraCharConns = {}

local function switchMusic(name)
	for _, sound in ipairs(MusicFolder:GetChildren()) do
		if sound:IsA("Sound") then
			sound:Stop()
		end
	end
	local target = MusicFolder:FindFirstChild(name)
	if target and target:IsA("Sound") then
		target.Looped = true
		target:Play()
	end
end

local function getFlashRGB(config)
	return math.floor(config.FlashColor.R * 255),
	math.floor(config.FlashColor.G * 255),
	math.floor(config.FlashColor.B * 255)
end

local function fireWeatherToPlayer(player, config, remaining)
	local flashR, flashG, flashB = getFlashRGB(config)
	pcall(function()
		Global:FireClient(player, "weatherStart", {
			FlashR = flashR,
			FlashG = flashG,
			FlashB = flashB,
			SoundID = config.SoundID,
			Image = config.Image,
			Time = remaining,
			Name = _G.ActiveWeather and _G.ActiveWeather.Key or "",
		})
	end)
end

local function applyAuraFace(character)
	local head = character:FindFirstChild("Head")
	if not head then return end
	if head:FindFirstChild("AuraFace") then return end
	local gui = AuraFaceTemplate:Clone()
	gui.Image.Image = AURA_FACES[math.random(1, #AURA_FACES)]
	gui.Name = "AuraFace"
	gui.Parent = head
end

local function removeAuraFace(character)
	local head = character:FindFirstChild("Head")
	if not head then return end
	local gui = head:FindFirstChild("AuraFace")
	if gui then gui:Destroy() end
end

local function applyAuraToAll()
	for _, player in ipairs(Players:GetPlayers()) do
		if player.Character then
			applyAuraFace(player.Character)
		end
		local conn = player.CharacterAdded:Connect(function(char)
			if _G.ActiveWeather and _G.ActiveWeather.Key == "Aura" then
				task.wait(0.5)
				applyAuraFace(char)
			end
		end)
		auraCharConns[player] = conn
	end
end

local function cleanupAura()
	for player, conn in pairs(auraCharConns) do
		conn:Disconnect()
		if player.Character then
			removeAuraFace(player.Character)
		end
	end
	table.clear(auraCharConns)
end

local baseplateOrigColor = _G.BaseplateOrigColor or nil

local function applyFrostToAll()
	for _, player in ipairs(Players:GetPlayers()) do
		pcall(function()
			Global:FireClient(player, "frostStart")
		end)
	end
end

local function cleanupFrost()
	for _, player in ipairs(Players:GetPlayers()) do
		pcall(function()
			Global:FireClient(player, "frostEnd")
		end)
	end
end

local function connectPlayerAdded()
	if playerAddedConn then return end
	playerAddedConn = Players.PlayerAdded:Connect(function(player)
		if not _G.ActiveWeather then return end
		local elapsed = tick() - _G.ActiveWeather.StartTime
		local remaining = math.max(0, math.ceil(_G.ActiveWeather.Duration - elapsed))
		if remaining <= 0 then return end
		task.delay(1, function()
			if not _G.ActiveWeather then return end
			fireWeatherToPlayer(player, _G.ActiveWeather.Config, remaining)
			if _G.ActiveWeather.Key == "Aura" then
				if player.Character then
					applyAuraFace(player.Character)
				end
				local conn = player.CharacterAdded:Connect(function(char)
					if _G.ActiveWeather and _G.ActiveWeather.Key == "Aura" then
						task.wait(0.5)
						applyAuraFace(char)
					end
				end)
				auraCharConns[player] = conn
			elseif _G.ActiveWeather.Key == "Frost" then
				pcall(function()
					Global:FireClient(player, "frostStart")
				end)
			end
		end)
	end)
end

local function disconnectPlayerAdded()
	if playerAddedConn then
		playerAddedConn:Disconnect()
		playerAddedConn = nil
	end
end

local function forceCleanupCurrent()
	if not _G.ActiveWeather then return end

	if _G.ActiveWeather.Model then
		_G.ActiveWeather.Model:Destroy()
	end

	if _G.ActiveWeather.Key == "Aura" then
		cleanupAura()
		workspace.Gravity = 196.2
	elseif _G.ActiveWeather.Key == "Frost" then
		cleanupFrost()
	end

	local baseplate = workspace:FindFirstChild("Baseplate")
	if baseplate and baseplateOrigColor then
		TweenService:Create(baseplate, TweenInfo.new(1), {Color = baseplateOrigColor}):Play()
		baseplateOrigColor = nil
		_G.BaseplateOrigColor = nil
	end


	for _, player in ipairs(Players:GetPlayers()) do
		pcall(function()
			Global:FireClient(player, "weatherEnd")
		end)
	end

	disconnectPlayerAdded()
	_G.ActiveWeather = nil
end

return function(context, weatherType: string, durationOverride: number?)
	local key = VALID_TYPES[weatherType:lower()]
	if not key then
		return "Invalid weather type. Options: Aura, Candy, Disco, Toxic, Lava, Hacker, Frost"
	end

	if _G.ActiveWeather then
		forceCleanupCurrent()
	end

	local config = WeatherHandler.WheatherList[key]
	local normal = WeatherHandler.Normal
	local duration = tonumber(durationOverride) or config.Time

	local folder = WeatherEvents:FindFirstChild(config.FolderName)
	if not folder then
		return "Weather folder not found: " .. config.FolderName
	end

	local model = folder:GetChildren()[1]
	if not model then
		return "No model found in weather folder: " .. config.FolderName
	end

	_G.ActiveWeather = {
		Key = key,
		Config = config,
		StartTime = tick(),
		Duration = duration,
	}

	local atmosphere = Lighting:FindFirstChildWhichIsA("Atmosphere")
	TweenService:Create(Lighting, TweenInfo.new(1), {ClockTime = config.ClockTime}):Play()
	if atmosphere then
		TweenService:Create(atmosphere, TweenInfo.new(1), {Color = config.AtmosphereColor}):Play()
	end

	local cloned = model:Clone()
	cloned.Name = "_WeatherModel"
	cloned.Parent = workspace
	_G.ActiveWeather.Model = cloned

	switchMusic(key)

	if key == "Aura" then
		applyAuraToAll()
		workspace.Gravity = 100
	elseif key == "Frost" then
		applyFrostToAll()
	end

	local BASEPLATE_COLORS = {
		Disco = Color3.fromRGB(157, 140, 159),
		Candy = Color3.fromRGB(150, 101, 149),
		Frost = Color3.fromRGB(0, 157, 236),
		Toxic = Color3.fromRGB(25, 139, 42),
		Hacker = Color3.fromRGB(25, 139, 42),
		Lava = Color3.fromRGB(150, 81, 82),
	}
	local bpColor = BASEPLATE_COLORS[key]
	if bpColor then
		local baseplate = workspace:FindFirstChild("Baseplate")
		if baseplate then
			if not baseplateOrigColor then
				baseplateOrigColor = baseplate.Color
				_G.BaseplateOrigColor = baseplate.Color
			end
			TweenService:Create(baseplate, TweenInfo.new(1), {Color = bpColor}):Play()
		end
	end

	for _, player in ipairs(Players:GetPlayers()) do
		fireWeatherToPlayer(player, config, duration)
	end

	connectPlayerAdded()

	task.spawn(function()
		local endTime = tick() + duration
		while tick() < endTime do
			task.wait(1)
			if not _G.ActiveWeather or _G.ActiveWeather.Key ~= key then
				return
			end
		end

		if _G.ActiveWeather and _G.ActiveWeather.Key == key then
			TweenService:Create(Lighting, TweenInfo.new(1), {ClockTime = normal.ClockTime}):Play()
			if atmosphere then
				TweenService:Create(atmosphere, TweenInfo.new(1), {Color = normal.AtmosphereColor}):Play()
			end

			if _G.ActiveWeather.Model then
				_G.ActiveWeather.Model:Destroy()
			end

			if key == "Aura" then
				cleanupAura()
				workspace.Gravity = 196.2
			elseif key == "Frost" then
				cleanupFrost()
			end

			local baseplate = workspace:FindFirstChild("Baseplate")
			if baseplate and baseplateOrigColor then
				TweenService:Create(baseplate, TweenInfo.new(1), {Color = baseplateOrigColor}):Play()
				baseplateOrigColor = nil
				_G.BaseplateOrigColor = nil
			end

			switchMusic("Normal")

			for _, player in ipairs(Players:GetPlayers()) do
				pcall(function()
					Global:FireClient(player, "weatherEnd")
				end)
			end

			_G.ActiveWeather = nil
			disconnectPlayerAdded()
		end
	end)
end