--!strict
-- LOCATION: ServerScriptService/Controllers/WeatherService/Tacos

local Tacos = {}
Tacos.Conns = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

local Events = ReplicatedStorage:WaitForChild("Events")
local WeatherAssets = ReplicatedStorage:WaitForChild("Weather"):WaitForChild("Tacos")

local TacoModel = WeatherAssets:WaitForChild("TacoModel")
local TacoSong = WeatherAssets:WaitForChild("Tacos")

local TacoSoundInstance = nil

local function NotifyAll(message: string)
	local notifEvent = Events:FindFirstChild("ShowNotification")
	if notifEvent then
		for _, p in ipairs(Players:GetPlayers()) do
			notifEvent:FireClient(p, message, "Success")
		end
	end
end

function Tacos.OnStart()
	NotifyAll("🌮 Tacos Event Has Started!")

	-- Spawn taco rain model
	local tacoClone = TacoModel:Clone()
	tacoClone.Parent = workspace:FindFirstChild("Weather") or workspace
	tacoClone.Name = "TacoModel"

	-- Play taco music
	TacoSoundInstance = TacoSong:Clone()
	TacoSoundInstance.Looped = true
	TacoSoundInstance.Volume = 0.5
	TacoSoundInstance.Parent = workspace
	TacoSoundInstance:Play()

	-- Fun atmosphere change
	local atmosphere = Lighting:FindFirstChild("Atmosphere")
	if atmosphere then
		atmosphere:SetAttribute("OriginalDensity", atmosphere.Density)
		atmosphere.Density = 0.3
	end

	-- Keep alive loop
	Tacos.Conns.AliveConn = task.spawn(function()
		while true do
			task.wait(math.random(10, 25))
		end
	end)
end

function Tacos.OnEnd()
	-- Cancel running threads
	if Tacos.Conns then
		for name, conn in pairs(Tacos.Conns) do
			if typeof(conn) == "thread" then
				task.cancel(conn)
			end
			Tacos.Conns[name] = nil
		end
	end
	Tacos.Conns = {}

	NotifyAll("🌮 Tacos Event Has Ended!")

	-- Remove taco model
	local weatherFolder = workspace:FindFirstChild("Weather")
	if weatherFolder then
		local tacoModel = weatherFolder:FindFirstChild("TacoModel")
		if tacoModel then tacoModel:Destroy() end
	end

	-- Stop taco music
	if TacoSoundInstance then
		TacoSoundInstance:Stop()
		TacoSoundInstance:Destroy()
		TacoSoundInstance = nil
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
	print("[WeatherService] Tacos ended")
end

return Tacos