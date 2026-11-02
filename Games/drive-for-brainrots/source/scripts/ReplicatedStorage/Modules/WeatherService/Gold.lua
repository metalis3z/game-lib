--!strict
-- LOCATION: ServerScriptService/Controllers/WeatherService/Gold

local Gold = {}
Gold.Conns = {}

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

function Gold.OnStart()
	NotifyAll("💰 Gold Event Has Started!")

	-- Golden atmosphere
	local atmosphere = Lighting:FindFirstChild("Atmosphere")
	if atmosphere then
		atmosphere:SetAttribute("OriginalDensity", atmosphere.Density)
		atmosphere:SetAttribute("OriginalColor", atmosphere.Color)
		atmosphere.Density = 0.4
		atmosphere.Color = Color3.fromRGB(255, 200, 50)
	end

	-- Warm golden lighting
	Lighting:SetAttribute("OriginalBrightness", Lighting.Brightness)
	Lighting:SetAttribute("OriginalOutdoorAmbient", Lighting.OutdoorAmbient)
	Lighting:SetAttribute("OriginalClockTime", Lighting.ClockTime)
	Lighting.Brightness = 2
	Lighting.OutdoorAmbient = Color3.fromRGB(255, 220, 100)
	Lighting.ClockTime = 14.5

	-- Golden fog
	Lighting:SetAttribute("OriginalFogColor", Lighting.FogColor)
	Lighting:SetAttribute("OriginalFogEnd", Lighting.FogEnd)
	Lighting.FogColor = Color3.fromRGB(255, 215, 0)
	Lighting.FogEnd = 800

	-- Ambient color shift loop
	Gold.Conns.AmbientLoop = task.spawn(function()
		while true do
			for i = 180, 255, 2 do
				local atmo = Lighting:FindFirstChild("Atmosphere")
				if atmo then
					atmosphere.Color = Color3.fromRGB(i, math.floor(i * 0.78), 50)
				end
				task.wait(0.1)
			end
			for i = 255, 180, -2 do
				local atmo = Lighting:FindFirstChild("Atmosphere")
				if atmo then
					atmosphere.Color = Color3.fromRGB(i, math.floor(i * 0.78), 50)
				end
				task.wait(0.1)
			end
		end
	end)
end

function Gold.OnEnd()
	if Gold.Conns then
		for name, conn in pairs(Gold.Conns) do
			if typeof(conn) == "thread" then
				task.cancel(conn)
			end
			Gold.Conns[name] = nil
		end
	end
	Gold.Conns = {}

	NotifyAll("💰 Gold Event Has Ended!")

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
	if origBrightness then Lighting.Brightness = origBrightness end
	if origAmbient then Lighting.OutdoorAmbient = origAmbient end
	if origClock then Lighting.ClockTime = origClock end
	Lighting:SetAttribute("OriginalBrightness", nil)
	Lighting:SetAttribute("OriginalOutdoorAmbient", nil)
	Lighting:SetAttribute("OriginalClockTime", nil)

	-- Restore fog
	local origFogColor = Lighting:GetAttribute("OriginalFogColor")
	local origFogEnd = Lighting:GetAttribute("OriginalFogEnd")
	if origFogColor then Lighting.FogColor = origFogColor end
	if origFogEnd then Lighting.FogEnd = origFogEnd end
	Lighting:SetAttribute("OriginalFogColor", nil)
	Lighting:SetAttribute("OriginalFogEnd", nil)

	Lighting.Brightness = 1.3
	print("[WeatherService] Gold ended")
end

return Gold