--!strict
-- LOCATION: ServerScriptService/Controllers/WeatherService/Pyramid

local Pyramid = {}
Pyramid.Conns = {}

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

function Pyramid.OnStart()
	NotifyAll("🏛️ Pyramid Event Has Started!")

	-- Sandy desert atmosphere
	local atmosphere = Lighting:FindFirstChild("Atmosphere")
	if atmosphere then
		atmosphere:SetAttribute("OriginalDensity", atmosphere.Density)
		atmosphere:SetAttribute("OriginalColor", atmosphere.Color)
		atmosphere:SetAttribute("OriginalDecay", atmosphere.Decay)
		atmosphere.Density = 0.5
		atmosphere.Color = Color3.fromRGB(210, 180, 120)
		atmosphere.Decay = Color3.fromRGB(180, 150, 90)
	end

	-- Blazing desert sun
	Lighting:SetAttribute("OriginalBrightness", Lighting.Brightness)
	Lighting:SetAttribute("OriginalOutdoorAmbient", Lighting.OutdoorAmbient)
	Lighting:SetAttribute("OriginalClockTime", Lighting.ClockTime)
	Lighting:SetAttribute("OriginalAmbient", Lighting.Ambient)
	Lighting.Brightness = 3
	Lighting.OutdoorAmbient = Color3.fromRGB(230, 200, 140)
	Lighting.Ambient = Color3.fromRGB(140, 110, 60)
	Lighting.ClockTime = 13

	-- Sand fog
	Lighting:SetAttribute("OriginalFogColor", Lighting.FogColor)
	Lighting:SetAttribute("OriginalFogEnd", Lighting.FogEnd)
	Lighting:SetAttribute("OriginalFogStart", Lighting.FogStart)
	Lighting.FogColor = Color3.fromRGB(220, 190, 130)
	Lighting.FogEnd = 650
	Lighting.FogStart = 50

	-- Sandstorm intensity loop
	Pyramid.Conns.Sandstorm = task.spawn(function()
		while true do
			-- Calm period
			local atmo = Lighting:FindFirstChild("Atmosphere")
			if atmo then
				atmosphere.Density = 0.4
				atmosphere.Color = Color3.fromRGB(210, 180, 120)
			end
			Lighting.FogEnd = 700
			Lighting.Brightness = 3
			task.wait(math.random(6, 12))

			-- Sandstorm rolls in
			for i = 1, 10 do
				local atmo2 = Lighting:FindFirstChild("Atmosphere")
				if atmo2 then
					atmosphere.Density = 0.4 + (i * 0.04)
					atmosphere.Color = Color3.fromRGB(
						210 - (i * 5),
						180 - (i * 6),
						120 - (i * 5)
					)
				end
				Lighting.FogEnd = 700 - (i * 30)
				Lighting.Brightness = 3 - (i * 0.15)
				task.wait(0.3)
			end

			-- Peak sandstorm
			task.wait(math.random(3, 6))

			-- Sandstorm clears
			for i = 10, 1, -1 do
				local atmo3 = Lighting:FindFirstChild("Atmosphere")
				if atmo3 then
					atmosphere.Density = 0.4 + (i * 0.04)
					atmosphere.Color = Color3.fromRGB(
						210 - (i * 5),
						180 - (i * 6),
						120 - (i * 5)
					)
				end
				Lighting.FogEnd = 700 - (i * 30)
				Lighting.Brightness = 3 - (i * 0.15)
				task.wait(0.3)
			end
		end
	end)

	-- Heat shimmer effect
	Pyramid.Conns.HeatShimmer = task.spawn(function()
		while true do
			-- Subtle brightness waver (heat haze)
			local offset = math.random(-15, 15) / 100
			Lighting.Brightness = 3 + offset
			task.wait(0.2)
		end
	end)

	-- Golden glow pulse
	Pyramid.Conns.GoldenPulse = task.spawn(function()
		while true do
			for i = 200, 240, 4 do
				Lighting.OutdoorAmbient = Color3.fromRGB(i, math.floor(i * 0.85), math.floor(i * 0.6))
				task.wait(0.15)
			end
			for i = 240, 200, -4 do
				Lighting.OutdoorAmbient = Color3.fromRGB(i, math.floor(i * 0.85), math.floor(i * 0.6))
				task.wait(0.15)
			end
		end
	end)
end

function Pyramid.OnEnd()
	if Pyramid.Conns then
		for name, conn in pairs(Pyramid.Conns) do
			if typeof(conn) == "thread" then
				task.cancel(conn)
			end
			Pyramid.Conns[name] = nil
		end
	end
	Pyramid.Conns = {}

	NotifyAll("🏛️ Pyramid Event Has Ended!")

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
	print("[WeatherService] Pyramid ended")
end

return Pyramid