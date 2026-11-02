-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

game:GetService("RunService")

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local elapsed = nil
local u7 = nil
local LocalPlayer = Players.LocalPlayer
local u9 = nil
local t1 = {
	IsNight = function(_)
		return workspace:GetServerTimeNow() % 1800 >= 900
	end,
	IsDay = function(_)
		return workspace:GetServerTimeNow() % 1800 < 900
	end,
	Update = function(_)
		elapsed = os.clock()

		local v14 = true
		local v15 = nil

		if u9 then
			local v16 = u9:Get("Overrides")[1]

			v15 = if not v16 then nil else v16.state
		end

		if ReplicatedStorage:GetAttribute("BloodmoonEvent") then
			v15 = 20
		end

		if ReplicatedStorage:GetAttribute("CandyEvent") then
			v15 = 14
		end

		if ReplicatedStorage:GetAttribute("GalaxyEvent") or ReplicatedStorage:GetAttribute("YinYangEvent") or ReplicatedStorage:GetAttribute("RadioactiveEvent") or ReplicatedStorage:GetAttribute("UFOEvent") or ReplicatedStorage:GetAttribute("StrawberryEvent") or ReplicatedStorage:GetAttribute("WitchingHourEvent") or ReplicatedStorage:GetAttribute("WinterHourEvent") or ReplicatedStorage:GetAttribute("GingerbreadTownEvent") or ReplicatedStorage:GetAttribute("SkibidiEvent") or ReplicatedStorage:GetAttribute("AyMiGatitoEvent") then
			v15 = 11
			v14 = false
		end

		if ReplicatedStorage:GetAttribute("TrickOrTreatEvent") or ReplicatedStorage:GetAttribute("GraveyardEvent") then
			v15 = 5
			v14 = false
		end

		if ReplicatedStorage:GetAttribute("Effect_Space") or ReplicatedStorage:GetAttribute("NyanCatsEvent") or ReplicatedStorage:GetAttribute("4thOfJulyEvent") or ReplicatedStorage:GetAttribute("1YearEvent") or ReplicatedStorage:GetAttribute("10BVisitsEvent") or ReplicatedStorage:GetAttribute("GlitchEvent") or ReplicatedStorage:GetAttribute("MoltenEvent") or ReplicatedStorage:GetAttribute("BombardiroCrocodiloEvent") or ReplicatedStorage:GetAttribute("Starfall") or ReplicatedStorage:GetAttribute("LosMatteosEventNightTime") or ReplicatedStorage:GetAttribute("SammyniSpyderiniEvent") or ReplicatedStorage:GetAttribute("MeowlEvent") or ReplicatedStorage:GetAttribute("CursedEvent") or ReplicatedStorage:GetAttribute("CyberEvent") or ReplicatedStorage:GetAttribute("ValentinesEvent") or ReplicatedStorage:GetAttribute("RipMyGrannyEvent") or ReplicatedStorage:GetAttribute("SmurfCatEvent") or ReplicatedStorage:GetAttribute("CapybaraEvent") or ReplicatedStorage:GetAttribute("CapybaraEventNight") or ReplicatedStorage:GetAttribute("") then
			v15 = 0
		end

		if ReplicatedStorage:GetAttribute("ChicleteiraBicicleteiraEvent") then
			v15 = 6
		end

		if ReplicatedStorage:GetAttribute("WaterEvent") then
			v15 = 14.5
		end

		if ReplicatedStorage:GetAttribute("CrabRave") then
			v15 = 14
		end

		if ReplicatedStorage:GetAttribute("2026Event") or ReplicatedStorage:GetAttribute("ConcertEvent") or ReplicatedStorage:GetAttribute("RapConcertEvent") or ReplicatedStorage:GetAttribute("BrazilEvent") then
			v15 = 0
			v14 = false
		end

		if ReplicatedStorage:GetAttribute("LanceEvent") then
			v15 = 4
			v14 = false
		end

		if ReplicatedStorage:GetAttribute("NorthPoleEventActive") and LocalPlayer:GetAttribute("InNorthPole") then
			v15 = 11
			v14 = false
		end

		local v17 = not v15

		if not v15 then
			local v18 = workspace:GetServerTimeNow() % 1800

			if v18 < 900 then
				v15 = 6 + v18 / 900 * 12
			else
				v15 = 18 + (v18 - 900) / 900 * 12

				if v15 >= 24 then
					v15 -= 24
				end
			end

			if ReplicatedStorage:GetAttribute("ClockTimeOverride") then
				v15 = ReplicatedStorage:GetAttribute("ClockTimeOverride")
			end
		end

		if math.abs(v15 - Lighting.ClockTime) > 1 and v17 ~= u7 then
			TweenService:Create(Lighting, TweenInfo.new(5), {
				ClockTime = v15
			}):Play()
			TweenService:Create(Lighting.SunRays, TweenInfo.new(1), {
				Intensity = not v14 and 0 or 0.071
			})
		else
			Lighting.ClockTime = v15
			Lighting.SunRays.Intensity = not v14 and 0 or 0.071
		end

		u7 = v17
	end
}

function t1.Start(_)
	task.spawn(function()
		while true do
			if not elapsed or os.clock() - elapsed >= 5 then
				t1:Update()
			end

			task.wait(1)
		end
	end)
	task.spawn(function()
		u9 = Synchronizer:Wait("Cycle")
		u9:OnArrayInserted("Overrides", function()
			t1:Update()
		end)
		u9:OnArrayRemoved("Overrides", function()
			t1:Update()
		end)
	end)
end

return t1