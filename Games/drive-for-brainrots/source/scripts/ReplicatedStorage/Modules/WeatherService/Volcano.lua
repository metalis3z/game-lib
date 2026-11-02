--!strict
-- LOCATION: ServerScriptService/Controllers/WeatherService/Volcano

local Volcano = {}
Volcano.Conns = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

local Events = ReplicatedStorage:WaitForChild("Events")

local function NotifyAll(message: string)
	local notifEvent = Events:FindFirstChild("ShowNotification")
	if notifEvent then
		for _, p in ipairs(Players:GetPlayers()) do
			notifEvent:FireClient(p, message, "Success")
		end
		end
	end
end

function Volcano.OnStart()
	NotifyAll("🌋 Volcano Event Has Started!")

	-- Smoky red atmosphere
	local atmosphere = Lighting:FindFirstChild("Atmosphere")
	if atmosphere then
		atmosphere:SetAttribute("OriginalDensity", atmosphere.Density)
		atmosphere:SetAttribute("OriginalColor", atmosphere.Color)
		atmosphere:SetAttribute("OriginalDecay", atmosphere.Decay)
		atmosphere.Density = 0.6
		atmosphere.Color = Color3.fromRGB(120, 30, 10)
		atmosphere.Decay = Color3.fromRGB(80, 20, 5)
	end

	-- Eerie red/orange lighting
	Lighting:SetAttribute("OriginalBrightness", Lighting.Brightness)
	Lighting:SetAttribute("OriginalOutdoorAmbient", Lighting.OutdoorAmbient)
	Lighting:SetAttribute("OriginalClockTime", Lighting.ClockTime)
	Lighting:SetAttribute("OriginalAmbient", Lighting.Ambient)
	Lighting.Brightness = 0.8
	Lighting.OutdoorAmbient = Color3.fromRGB(180, 50, 10)
	Lighting.Ambient = Color3.fromRGB(80, 15, 5)
	Lighting.ClockTime = 20

	-- Red/orange fog
	Lighting:SetAttribute("OriginalFogColor", Lighting.FogColor)
	Lighting:SetAttribute("OriginalFogEnd", Lighting.FogEnd)
	Lighting:SetAttribute("OriginalFogStart", Lighting.FogStart)
	Lighting.FogColor = Color3.fromRGB(100, 25, 5)
	Lighting.FogEnd = 600
	Lighting.FogStart = 0

	-- Eruption flicker loop
	Volcano.Conns.Eruption = task.spawn(function()
		while true do
			-- Low rumble glow
			Lighting.OutdoorAmbient = Color3.fromRGB(180, 50, 10)
			Lighting.Brightness = 0.8
			task.wait(math.random(4, 10))

			-- Eruption burst!
			for flash = 1, math.random(3, 6) do
				local intensity = math.random(150, 255)
				Lighting.Brightness = math.random(3, 6)
				Lighting.OutdoorAmbient = Color3.fromRGB(intensity, math.floor(intensity * 0.4), 0)
				Lighting.Ambient = Color3.fromRGB(math.floor(intensity * 0.5), math.floor(intensity * 0.15), 0)
				task.wait(0.04)
				Lighting.Brightness = 0.4
				Lighting.OutdoorAmbient = Color3.fromRGB(100, 20, 5)
				Lighting.Ambient = Color3.fromRGB(40, 8, 2)
				task.wait(0.06)
			end

			-- Settle back
			Lighting.Brightness = 0.8
			Lighting.OutdoorAmbient = Color3.fromRGB(180, 50, 10)
			Lighting.Ambient = Color3.fromRGB(80, 15, 5)
			task.wait(math.random(2, 5))
		end
	end)

	-- Slow atmosphere pulse
	Volcano.Conns.AtmoPulse = task.spawn(function()
		while true do
			for i = 80, 150, 3 do
				local atmo = Lighting:FindFirstChild("Atmosphere")
				if atmo then
					atmosphere.Color = Color3.fromRGB(i, math.floor(i * 0.25), math.floor(i * 0.08))
				end
				task.wait(0.12)
			end
			for i = 150, 80, -3 do
				local atmo = Lighting:FindFirstChild("Atmosphere")
				if atmo then
					atmosphere.Color = Color3.fromRGB(i, math.floor(i * 0.25), math.floor(i * 0.08))
				end
				task.wait(0.12)
			end
		end
	end)
end

function Volcano.OnEnd()
	if Volcano.Conns then
		for name, conn in pairs(Volcano.Conns) do
			if typeof(conn) == "thread" then
				task.cancel(conn)
			end
			Volcano.Conns[name] = nil
		end
	end
	Volcano.Conns = {}

	NotifyAll("🌋 Volcano Event Has Ended!")

	-- Restore atmosphere
	local atmosphere = Lighting:FindFirstChild("Atmosphere")
	if atmosphere then
		local origDensity = atmosphere:GetAttribute("OriginalDensity")
		local origColor = atmosphere:GetAttribute("OriginalColor")
		local origDecay = atmosphere:GetAttribute("OriginalDecay")
		if origDensity then atmosphere.Density = origDensity end
		if origColor then atmosphere.Color = origColor end
		if origDecay then atmosphere.Decay = origDecay end
		atmosphere:SetAttribute("OriginalDensity", nil)
		atmosphere:SetAttribute("OriginalColor", nil)
		atmosphere:SetAttribute("OriginalDecay", nil)
	end

	-- Restore lighting
	local origBrightness = Lighting:GetAttribute("OriginalBrightness")
	local origAmbient = Lighting:GetAttribute("OriginalOutdoorAmbient")
	local origClock = Lighting:GetAttribute("OriginalClockTime")
	local origAmb = Lighting:GetAttribute("OriginalAmbient")
	if origBrightness then Lighting.Brightness = origBrightness end
	if origAmbient then Lighting.OutdoorAmbient = origAmbient end
	if origClock then Lighting.ClockTime = origClock end
	if origAmb then Lighting.Ambient = origAmb end
	Lighting:SetAttribute("OriginalBrightness", nil)
	Lighting:SetAttribute("OriginalOutdoorAmbient", nil)
	Lighting:SetAttribute("OriginalClockTime", nil)
	Lighting:SetAttribute("OriginalAmbient", nil)

	-- Restore fog
	local origFogColor = Lighting:GetAttribute("OriginalFogColor")
	local origFogEnd = Lighting:GetAttribute("OriginalFogEnd")
	local origFogStart = Lighting:GetAttribute("OriginalFogStart")
	if origFogColor then Lighting.FogColor = origFogColor end
	if origFogEnd then Lighting.FogEnd = origFogEnd end
	if origFogStart then Lighting.FogStart = origFogStart end
	Lighting:SetAttribute("OriginalFogColor", nil)
	Lighting:SetAttribute("OriginalFogEnd", nil)
	Lighting:SetAttribute("OriginalFogStart", nil)

	Lighting.Brightness = 1.3
	print("[WeatherService] Volcano ended")
end

return Volcano