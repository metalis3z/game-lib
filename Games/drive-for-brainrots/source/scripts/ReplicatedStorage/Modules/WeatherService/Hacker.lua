--!strict
-- LOCATION: ServerScriptService/Controllers/WeatherService/Hacker

local Hacker = {}
Hacker.Conns = {}

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

function Hacker.OnStart()
	NotifyAll("💻 Hacker Event Has Started!")

	-- Green and black atmosphere
	local atmosphere = Lighting:FindFirstChild("Atmosphere")
	if atmosphere then
		atmosphere:SetAttribute("OriginalDensity", atmosphere.Density)
		atmosphere:SetAttribute("OriginalColor", atmosphere.Color)
		atmosphere.Density = 0.6
		atmosphere.Color = Color3.fromRGB(0, 40, 0)
	end

	-- Dark green lighting
	Lighting:SetAttribute("OriginalBrightness", Lighting.Brightness)
	Lighting:SetAttribute("OriginalOutdoorAmbient", Lighting.OutdoorAmbient)
	Lighting:SetAttribute("OriginalClockTime", Lighting.ClockTime)
	Lighting:SetAttribute("OriginalAmbient", Lighting.Ambient)
	Lighting.Brightness = 0.3
	Lighting.OutdoorAmbient = Color3.fromRGB(0, 60, 0)
	Lighting.Ambient = Color3.fromRGB(0, 30, 0)
	Lighting.ClockTime = 0

	-- Green fog
	Lighting:SetAttribute("OriginalFogColor", Lighting.FogColor)
	Lighting:SetAttribute("OriginalFogEnd", Lighting.FogEnd)
	Lighting:SetAttribute("OriginalFogStart", Lighting.FogStart)
	Lighting.FogColor = Color3.fromRGB(0, 20, 0)
	Lighting.FogEnd = 500
	Lighting.FogStart = 0

	-- Glitch flicker loop
	Hacker.Conns.GlitchLoop = task.spawn(function()
		while true do
			-- Random green intensity flicker
			local intensity = math.random(20, 80)
			local atmo = Lighting:FindFirstChild("Atmosphere")
			if atmo then
				atmosphere.Color = Color3.fromRGB(0, intensity, 0)
			end
			Lighting.OutdoorAmbient = Color3.fromRGB(0, intensity, 0)

			-- Occasional bright flash (glitch effect)
			if math.random(1, 8) == 1 then
				Lighting.Brightness = 3
				Lighting.OutdoorAmbient = Color3.fromRGB(0, 255, 0)
				task.wait(0.05)
				Lighting.Brightness = 0.3
				Lighting.OutdoorAmbient = Color3.fromRGB(0, intensity, 0)
			end

			task.wait(math.random(3, 8) / 10)
		end
	end)
end

function Hacker.OnEnd()
	if Hacker.Conns then
		for name, conn in pairs(Hacker.Conns) do
			if typeof(conn) == "thread" then
				task.cancel(conn)
			end
			Hacker.Conns[name] = nil
		end
	end
	Hacker.Conns = {}

	NotifyAll("💻 Hacker Event Has Ended!")

	-- Restore atmosphere
	local atmosphere = Lighting:FindFirstChild("Atmosphere")
	if atmosphere then
		local origDensity = atmosphere:GetAttribute("OriginalDensity")
		local origColor = atmosphere:GetAttribute("OriginalColor")
		if origDensity then atmosphere.Density = origDensity end
		if origColor then atmosphere.Color = origColor end
		atmosphere:SetAttribute("OriginalDensity", nil)
		atmosphere:SetAttribute("OriginalColor", nil)
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
	print("[WeatherService] Hacker ended")
end

return Hacker