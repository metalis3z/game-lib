local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("TweenService")
require(script:FindFirstAncestor("Effects").Parent.Types)

local t1 = {}
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Signal = require(ReplicatedStorage.Packages.Signal)
local _ = script.Name
local t2 = {
	Context = "Default",
	Color = Color3.fromRGB(106, 57, 9)
}
local u8 = t2
local v9 = Signal.new()

local function update()
	local v11 = t2

		}
	elseif ReplicatedStorage:GetAttribute("2026Event") then
		v11 = {
			Context = "2026",
			TweenTime = 0,
			Color = Color3.fromRGB(65, 78, 108)
		}
	elseif ReplicatedStorage:GetAttribute("ConcertEvent") then
		v11 = {
			Context = "Concert",
			Color = Color3.fromRGB(46, 71, 89)
		}
	elseif ReplicatedStorage:GetAttribute("RapConcertEvent") then
		v11 = {
			Context = "RapConcert",
			Color = Color3.fromRGB(46, 71, 89)
		}
	elseif ReplicatedStorage:GetAttribute("AyMiGatitoEvent") then
		v11 = {
			Context = "AyMiGatitoEvent",
			Color = Color3.fromRGB(105, 120, 180)
		}
	elseif ReplicatedStorage:GetAttribute("MexicoEvent") then
		v11 = {
			Context = "MexicoEvent",
			Color = Color3.fromRGB(180, 91, 68)
		}
	elseif ReplicatedStorage:GetAttribute("IndonesiaEvent") then
		v11 = {
			Context = "IndonesiaEvent",
			Color = Color3.fromRGB(113, 61, 31)
		}
	elseif ReplicatedStorage:GetAttribute("DulDulDulEvent") then
		v11 = {
			Context = "DulDulDulEvent",
			Color = Color3.fromRGB(84, 81, 83)
		}
	elseif ReplicatedStorage:GetAttribute("ChicleteiraBicicleteiraEvent") then
		v11 = {
			Context = "ChicleteiraBicicleteiraEvent",
			Color = Color3.fromRGB(116, 85, 85)
		}
	elseif ReplicatedStorage:GetAttribute("MeowlEvent") then
		v11 = {
			Context = "MeowlEvent",
			Color = Color3.fromRGB(125, 93, 58)
		}
	elseif ReplicatedStorage:GetAttribute("ValentinesEvent") then
		v11 = {
			Context = "ValentinesEvent",
			Color = Color3.fromRGB(227, 100, 187)
		}
	elseif ReplicatedStorage:GetAttribute("TrickOrTreatEvent") then
		v11 = {
			Context = "TrickOrTreatEvent",
			Color = Color3.fromRGB(148, 71, 33)
		}
	elseif ReplicatedStorage:GetAttribute("GraveyardEvent") then
		v11 = {
			Context = "GraveyardEvent",
			Color = Color3.fromRGB(92, 94, 180)
		}
	elseif ReplicatedStorage:GetAttribute("GingerbreadTownEvent") then
		v11 = {
			Context = "GingerbreadTownEvent",
			TweenTime = 0,
			Color = Color3.fromRGB(99, 42, 16)
		}
	elseif ReplicatedStorage:GetAttribute("WinterHourEvent") then
		v11 = {
			Context = "WinterHourEvent",
			TweenTime = 0,
			Color = Color3.fromRGB(108, 120, 136)
		}
	elseif ReplicatedStorage:GetAttribute("WitchingHourEvent") then
		v11 = {
			Context = "WitchingHourEvent",
			TweenTime = 0,
			Color = Color3.fromRGB(68, 42, 77)
		}
	elseif ReplicatedStorage:GetAttribute("YinYangEvent") then
		v11 = {
			Context = "YinYangEvent",
			TweenTime = 0,
			Color = Color3.fromRGB(0, 0, 0)
		}
	elseif ReplicatedStorage:GetAttribute("RadioactiveEvent") then
		v11 = {
			Context = "RadioactiveEvent",
			TweenTime = 0,
			Color = Color3.fromRGB(128, 136, 117)
		}
	elseif ReplicatedStorage:GetAttribute("CursedEvent") then
		v11 = {
			Context = "CursedEvent",
			TweenTime = 0,
			Color = Color3.fromRGB(143, 0, 0)
		}
	elseif ReplicatedStorage:GetAttribute("DivineEvent") then
		v11 = {
			Context = "DivineEvent",
			TweenTime = 0,
			Color = Color3.fromRGB(157, 129, 108)
		}
	elseif ReplicatedStorage:GetAttribute("PhantomEvent") then
		v11 = {
			Context = "PhantomEvent",
			TweenTime = 0,
			Color = Color3.fromRGB(27, 42, 53)
		}
	elseif ReplicatedStorage:GetAttribute("CyberEvent") then
		v11 = {
			Context = "CyberEvent",
			TweenTime = 0,
			Color = Color3.fromRGB(15, 33, 75)
		}
	elseif ReplicatedStorage:GetAttribute("GalaxyEvent") then
		v11 = {
			Context = "GalaxyEvent",
			Color = Color3.fromRGB(20, 57, 67)
		}
	elseif ReplicatedStorage:GetAttribute("EggCityEvent") then
		v11 = {
			Context = "EggCityEvent",
			TweenTime = 0,
			Color = Color3.fromRGB(159, 91, 172)
		}
	elseif ReplicatedStorage:GetAttribute("LaserCityEvent") then
		v11 = {
			Context = "LaserCityEvent",
			TweenTime = 0,
			Color = Color3.fromRGB(100, 110, 120)
		}
	elseif ReplicatedStorage:GetAttribute("SummerEvent") then
		v11 = {
			Context = "SummerEvent",
			Color = Color3.fromRGB(134, 105, 55)
		}
	end

	if u8.Context == v11.Context then
		return
	end

	u8 = v11
	v9:Fire()
end

function t1.OnStart(_)
	update()
end
function t1.OnUpdate(_)
	update()
end
function t1.OnLoad(_)
	Observers.observeTag("Wall", function(p4)
		local u16 = nil

		local function runTween()
			if u16 then
				u16:Cancel()
			end

			u16 = CreateTween(p4, TweenInfo.new(2), {
				Color = if type(u8.Color) ~= "table" then u8.Color else u8.Color[p4:GetAttribute("Side") or "Left"] or (u8.Color.Left or select(2, next(u8)))
			})
		end

		local connection = v9:Connect(runTween)

		task.spawn(runTween)

		return function()
			connection:Disconnect()
			u16:Cancel()
		end
	end, { workspace })
end

return t1