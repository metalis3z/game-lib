--!strict
-- LOCATION: ServerScriptService/Controllers/WeatherService/Galaxy

local Galaxy = {}
Galaxy.Conns = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

local Events = ReplicatedStorage:WaitForChild("Events")
local WeatherAssets = ReplicatedStorage:WaitForChild("Weather"):WaitForChild("Galaxy")

local GalaxiesSound = WeatherAssets:WaitForChild("Galaxies")
local GalaxySky = WeatherAssets:WaitForChild("Sky1")
local GalaxyModel = WeatherAssets:WaitForChild("GalaxyModel")

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

function Galaxy.OnStart()
	NotifyAll("🌌 Galaxy Event Has Started!")

	-- Play galaxy sound
	GalaxiesSound.Looped = true
	GalaxiesSound:Play()

	-- Spawn galaxy particle model
	local galaxyClone = GalaxyModel:Clone()
	galaxyClone.Parent = workspace:FindFirstChild("Weather") or workspace
	galaxyClone.Name = "GalaxyModel"

	-- Save and swap skybox
	local currentSky = Lighting:FindFirstChild("Sky")
	if currentSky then
		currentSky.Name = "Sky_Backup"
		currentSky:SetAttribute("IsBackup", true)
	end
	local newSky = GalaxySky:Clone()
	newSky.Name = "Sky"
	newSky.Parent = Lighting

	-- Darken atmosphere for space effect
	local atmosphere = Lighting:FindFirstChild("Atmosphere")
	if atmosphere then
		atmosphere:SetAttribute("OriginalDensity", atmosphere.Density)
		atmosphere.Density = 0.1
	end

	-- Star flash loop
	Galaxy.Conns.FlashConn = task.spawn(function()
		while true do
			local flashes = math.random(2, 5)
			local delayBetween = math.random(0, 2) / 10
			FlashLightning(flashes, delayBetween)

			local cooldown = math.random(10, 25)
			task.wait(cooldown)
		end
	end)
end

function Galaxy.OnEnd()
	-- Cancel running threads
	if Galaxy.Conns then
		for name, conn in pairs(Galaxy.Conns) do
			if typeof(conn) == "thread" then
				task.cancel(conn)
			end
			Galaxy.Conns[name] = nil
		end
	end
	Galaxy.Conns = {}

	NotifyAll("🌌 Galaxy Event Has Ended!")

	-- Stop sound
	GalaxiesSound:Stop()

	-- Remove galaxy model
	local weatherFolder = workspace:FindFirstChild("Weather")
	if weatherFolder then
		local galaxyModel = weatherFolder:FindFirstChild("GalaxyModel")
		if galaxyModel then galaxyModel:Destroy() end
	end

	-- Restore skybox
	local backupSky = Lighting:FindFirstChild("Sky_Backup")
	if backupSky then
		local currentSky = Lighting:FindFirstChild("Sky")
		if currentSky then currentSky:Destroy() end
		backupSky.Name = "Sky"
		backupSky:SetAttribute("IsBackup", nil)
	else
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
	print("[WeatherService] Galaxy ended")
end

return Galaxy