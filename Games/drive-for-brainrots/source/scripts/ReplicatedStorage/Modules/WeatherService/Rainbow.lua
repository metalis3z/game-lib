--!strict
-- LOCATION: ServerScriptService/Controllers/WeatherService/Rainbow

local Rainbow = {}
Rainbow.Conns = {}

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

local function hsvToColor3(h: number, s: number, v: number): Color3
	h = h % 360
	local c = v * s
	local x = c * (1 - math.abs((h / 60) % 2 - 1))
	local m = v - c
	local r, g, b = 0, 0, 0
	if h < 60 then r, g, b = c, x, 0
	elseif h < 120 then r, g, b = x, c, 0
	elseif h < 180 then r, g, b = 0, c, x
	elseif h < 240 then r, g, b = 0, x, c
	elseif h < 300 then r, g, b = x, 0, c
	else r, g, b = c, 0, x end
	return Color3.new(r + m, g + m, b + m)
end

function Rainbow.OnStart()
	NotifyAll("🌈 Rainbow Event Has Started!")

	-- Bright cheerful atmosphere
	local atmosphere = Lighting:FindFirstChild("Atmosphere")
	if atmosphere then
		atmosphere:SetAttribute("OriginalDensity", atmosphere.Density)
		atmosphere:SetAttribute("OriginalColor", atmosphere.Color)
		atmosphere:SetAttribute("OriginalDecay", atmosphere.Decay)
		atmosphere.Density = 0.35
		atmosphere.Decay = Color3.fromRGB(220, 220, 255)
	end

	-- Bright daylight
	Lighting:SetAttribute("OriginalBrightness", Lighting.Brightness)
	Lighting:SetAttribute("OriginalOutdoorAmbient", Lighting.OutdoorAmbient)
	Lighting:SetAttribute("OriginalClockTime", Lighting.ClockTime)
	Lighting:SetAttribute("OriginalAmbient", Lighting.Ambient)
	Lighting.Brightness = 2.5
	Lighting.ClockTime = 14
	Lighting.Ambient = Color3.fromRGB(100, 100, 120)

	-- Soft white fog
	Lighting:SetAttribute("OriginalFogColor", Lighting.FogColor)
	Lighting:SetAttribute("OriginalFogEnd", Lighting.FogEnd)
	Lighting.FogColor = Color3.fromRGB(240, 240, 255)
	Lighting.FogEnd = 900

	-- Rainbow color cycling loop
	local hue = 0
	Rainbow.Conns.ColorCycle = task.spawn(function()
		while true do
			hue = (hue + 2) % 360
			local color = hsvToColor3(hue, 0.6, 1)
			local atmo = Lighting:FindFirstChild("Atmosphere")
			if atmo then
				atmosphere.Color = color
			end
			Lighting.OutdoorAmbient = hsvToColor3(hue, 0.3, 0.9)

			-- Occasional rainbow burst
			if math.random(1, 15) == 1 then
				Lighting.Brightness = 4
				task.wait(0.08)
				Lighting.Brightness = 2.5
			end

			task.wait(0.15)
		end
	end)

	-- Secondary slow ambient shift
	Rainbow.Conns.AmbientShift = task.spawn(function()
		local hue2 = 120
		while true do
			hue2 = (hue2 + 1) % 360
			Lighting.Ambient = hsvToColor3(hue2, 0.25, 0.5)
			task.wait(0.3)
		end
	end)
end

function Rainbow.OnEnd()
	if Rainbow.Conns then
		for name, conn in pairs(Rainbow.Conns) do
			if typeof(conn) == "thread" then
				task.cancel(conn)
			end
			Rainbow.Conns[name] = nil
		end
	end
	Rainbow.Conns = {}

	NotifyAll("🌈 Rainbow Event Has Ended!")

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
	if origFogColor then Lighting.FogColor = origFogColor end
	if origFogEnd then Lighting.FogEnd = origFogEnd end
	Lighting:SetAttribute("OriginalFogColor", nil)
	Lighting:SetAttribute("OriginalFogEnd", nil)

	Lighting.Brightness = 1.3
	print("[WeatherService] Rainbow ended")
end

return Rainbow