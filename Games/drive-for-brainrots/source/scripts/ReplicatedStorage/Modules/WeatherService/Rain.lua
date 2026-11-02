--!strict
-- LOCATION: ServerScriptService/Controllers/WeatherService/Rain

local Rain = {}
Rain.Conns = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

local Events = ReplicatedStorage:WaitForChild("Events")
local WeatherAssets = ReplicatedStorage:WaitForChild("Weather"):WaitForChild("Rain")

local Rain1 = WeatherAssets:WaitForChild("Rain1")
local Rain2 = WeatherAssets:WaitForChild("Rain2")
local ThunderSound = WeatherAssets:WaitForChild("Sound")
local RainSky = WeatherAssets:WaitForChild("Sky")
local RainModel = WeatherAssets:WaitForChild("RainModel")

local function NotifyAll(message: string)
	local notifEvent = Events:FindFirstChild("ShowNotification")
	if notifEvent then
		for _, p in ipairs(Players:GetPlayers()) do
			notifEvent:FireClient(p, message, "Success")
		end
	end
end

local function FlashLightning(times: number, delayBetween: number)
	for i = 1, times do
		Lighting.Brightness = 10
		task.wait(0.05)
		Lighting.Brightness = 0.5
		task.wait(delayBetween or 0.1)
	end
end

function Rain.OnStart()
	NotifyAll("🌧️ Rain Event Has Started!")

	-- Play rain sounds
	Rain1:Play()
	Rain2:Play()

	-- Spawn rain particle model
	local rainClone = RainModel:Clone()
	rainClone.Parent = workspace:FindFirstChild("Weather") or workspace
	rainClone.Name = "RainModel"

	-- Save and swap skybox
	local currentSky = Lighting:FindFirstChild("Sky")
	if currentSky then
		currentSky.Name = "Sky_Backup"
		currentSky:SetAttribute("IsBackup", true)
	end
	local newSky = RainSky:Clone()
	newSky.Name = "Sky"
	newSky.Parent = Lighting

	-- Darken atmosphere
	local atmosphere = Lighting:FindFirstChild("Atmosphere")
	if atmosphere then
		atmosphere:SetAttribute("OriginalDensity", atmosphere.Density)
		atmosphere.Density = 0.5
	end

	-- Lightning and thunder loop
	Rain.Conns.ThunderConn = task.spawn(function()
		while true do
			local flashes = math.random(2, 5)
			local delayBetween = math.random(0, 2) / 10
			FlashLightning(flashes, delayBetween)

			local thunderDelay = math.random(5, 10)
			task.wait(thunderDelay)
			ThunderSound:Play()

			local cooldown = math.random(10, 25)
			task.wait(cooldown)
		end
	end)
end

function Rain.OnEnd()
	-- Cancel running threads
	if Rain.Conns then
		for name, conn in pairs(Rain.Conns) do
			if typeof(conn) == "thread" then
				task.cancel(conn)
			end
			Rain.Conns[name] = nil
		end
	end
	Rain.Conns = {}

	NotifyAll("🌤️ Rain Event Has Ended!")

	-- Stop sounds
	Rain1:Stop()
	Rain2:Stop()
	ThunderSound:Stop()

	-- Remove rain model
	local weatherFolder = workspace:FindFirstChild("Weather")
	if weatherFolder then
		local rainModel = weatherFolder:FindFirstChild("RainModel")
		if rainModel then rainModel:Destroy() end
	end

	-- Restore skybox
	local backupSky = Lighting:FindFirstChild("Sky_Backup")
	if backupSky then
		local currentSky = Lighting:FindFirstChild("Sky")
		if currentSky then currentSky:Destroy() end
		backupSky.Name = "Sky"
		backupSky:SetAttribute("IsBackup", nil)
	else
		-- No backup, just reset brightness
		Lighting.Brightness = 1.3
	end

	-- Restore atmosphere
	local atmosphere = Lighting:FindFirstChild("Atmosphere")
	if atmosphere then
		local origDensity = atmosphere:GetAttribute("OriginalDensity")
		if origDensity then
			atmosphere.Density = origDensity
			atmosphere:SetAttribute("OriginalDensity", nil)
		end
	end

	Lighting.Brightness = 1.3
	print("[WeatherService] Rain ended")
end

return Rain