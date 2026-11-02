--!strict
-- LOCATION: ServerScriptService/Controllers/WeatherService/Candy

local Candy = {}
Candy.Conns = {}

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

local candyColors = {
	Color3.fromRGB(255, 105, 180), -- Hot pink
	Color3.fromRGB(255, 182, 193), -- Light pink
	Color3.fromRGB(186, 85, 211),  -- Purple
	Color3.fromRGB(255, 160, 122), -- Salmon
	Color3.fromRGB(255, 218, 185), -- Peach
	Color3.fromRGB(255, 192, 203), -- Pink
}

function Candy.OnStart()
	NotifyAll("🍬 Candy Event Has Started!")

	-- Sweet pink atmosphere
	local atmosphere = Lighting:FindFirstChild("Atmosphere")
	if atmosphere then
		atmosphere:SetAttribute("OriginalDensity", atmosphere.Density)
		atmosphere:SetAttribute("OriginalColor", atmosphere.Color)
		atmosphere:SetAttribute("OriginalDecay", atmosphere.Decay)
		atmosphere.Density = 0.45
		atmosphere.Color = Color3.fromRGB(255, 150, 200)
		atmosphere.Decay = Color3.fromRGB(255, 180, 220)
	end

	-- Warm candy lighting
	Lighting:SetAttribute("OriginalBrightness", Lighting.Brightness)
	Lighting:SetAttribute("OriginalOutdoorAmbient", Lighting.OutdoorAmbient)
	Lighting:SetAttribute("OriginalClockTime", Lighting.ClockTime)
	Lighting:SetAttribute("OriginalAmbient", Lighting.Ambient)
	Lighting.Brightness = 2
	Lighting.OutdoorAmbient = Color3.fromRGB(255, 180, 210)
	Lighting.Ambient = Color3.fromRGB(120, 60, 80)
	Lighting.ClockTime = 12

	-- Pink fog
	Lighting:SetAttribute("OriginalFogColor", Lighting.FogColor)
	Lighting:SetAttribute("OriginalFogEnd", Lighting.FogEnd)
	Lighting:SetAttribute("OriginalFogStart", Lighting.FogStart)
	Lighting.FogColor = Color3.fromRGB(255, 200, 220)
	Lighting.FogEnd = 700
	Lighting.FogStart = 0

	-- Candy color cycling
	Candy.Conns.ColorPop = task.spawn(function()
		local idx = 1
		while true do
			idx = (idx % #candyColors) + 1
			local color = candyColors[idx]
			local atmo = Lighting:FindFirstChild("Atmosphere")
			if atmo then
				atmosphere.Color = color
			end
			Lighting.OutdoorAmbient = Color3.new(
				math.min(1, color.R + 0.2),
				math.min(1, color.G + 0.1),
				math.min(1, color.B + 0.15)
			)

			-- Sweet sparkle flash
			if math.random(1, 6) == 1 then
				Lighting.Brightness = 3.5
				task.wait(0.06)
				Lighting.Brightness = 2
			end

			task.wait(0.8)
		end
	end)

	-- Ambient pulse
	Candy.Conns.AmbientPulse = task.spawn(function()
		while true do
			for i = 80, 140, 5 do
				Lighting.Ambient = Color3.fromRGB(i, math.floor(i * 0.5), math.floor(i * 0.65))
				task.wait(0.1)
			end
			for i = 140, 80, -5 do
				Lighting.Ambient = Color3.fromRGB(i, math.floor(i * 0.5), math.floor(i * 0.65))
				task.wait(0.1)
			end
		end
	end)
end

function Candy.OnEnd()
	if Candy.Conns then
		for name, conn in pairs(Candy.Conns) do
			if typeof(conn) == "thread" then
				task.cancel(conn)
			end
			Candy.Conns[name] = nil
		end
	end
	Candy.Conns = {}

	NotifyAll("🍬 Candy Event Has Ended!")

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
	print("[WeatherService] Candy ended")
end

return Candy