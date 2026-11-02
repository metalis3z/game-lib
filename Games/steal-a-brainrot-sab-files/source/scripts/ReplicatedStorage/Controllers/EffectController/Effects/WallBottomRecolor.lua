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
	Color = Color3.fromRGB(99, 95, 98)
}
local u8 = t2
local v9 = Signal.new()

local function update()
	local v11 = t2

	if ReplicatedStorage:GetAttribute("GraipussMedussiEvent") then
		v11 = {
			Context = "GraipussMedussiEvent",
			Color = Color3.fromRGB(80, 0, 160)
		}
	elseif ReplicatedStorage:GetAttribute("2026Event") then
		v11 = {
			Context = "2026",
			TweenTime = 0,
			Color = Color3.fromRGB(82, 98, 136)
		}
	elseif ReplicatedStorage:GetAttribute("ConcertEvent") then
		v11 = {
			Context = "Concert",
			Color = Color3.fromRGB(17, 17, 17)
		}
	elseif ReplicatedStorage:GetAttribute("RapConcertEvent") then
		v11 = {
			Context = "RapConcert",
			Color = Color3.fromRGB(17, 17, 17)
		}
	elseif ReplicatedStorage:GetAttribute("DulDulDulEvent") then
		v11 = {
			Context = "DulDulDulEvent",
			Color = Color3.fromRGB(129, 124, 128)
		}
	elseif ReplicatedStorage:GetAttribute("AyMiGatitoEvent") then
		v11 = {
			Context = "AyMiGatitoEvent",
			Color = Color3.fromRGB(165, 115, 165)
		}
	elseif ReplicatedStorage:GetAttribute("MexicoEvent") then
		v11 = {
			Context = "MexicoEvent",
			Color = Color3.fromRGB(138, 81, 45)
		}
	elseif ReplicatedStorage:GetAttribute("IndonesiaEvent") then
		v11 = {
			Context = "IndonesiaEvent",
			Color = Color3.fromRGB(95, 44, 0)
		}
	elseif ReplicatedStorage:GetAttribute("MeowlEvent") then
		v11 = {
			Context = "MeowlEvent",
			Color = Color3.fromRGB(111, 71, 30)
		}
	elseif ReplicatedStorage:GetAttribute("ValentinesEvent") then
		v11 = {
			Context = "ValentinesEvent",
			Color = Color3.fromRGB(200, 0, 0)
		}
	elseif ReplicatedStorage:GetAttribute("TrickOrTreatEvent") then
		v11 = {
			Context = "TrickOrTreatEvent",
			Color = Color3.fromRGB(83, 56, 33)
		}
	elseif ReplicatedStorage:GetAttribute("GraveyardEvent") then
		v11 = {
			Context = "GraveyardEvent",
			Color = Color3.fromRGB(72, 63, 138)
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
			Color = Color3.fromRGB(99, 42, 16)
		}
	elseif ReplicatedStorage:GetAttribute("EasterEvent") then
		v11 = {
			Context = "EasterEvent",
			TweenTime = 0,
			Color = Color3.fromRGB(234, 173, 231)
		}
	elseif ReplicatedStorage:GetAttribute("WitchingHourEvent") then
		v11 = {
			Context = "WitchingHourEvent",
			TweenTime = 0,
			Color = Color3.fromRGB(99, 95, 98)
		}
	elseif ReplicatedStorage:GetAttribute("YinYangEvent") then
		v11 = {
			Context = "YinYangEvent",
			TweenTime = 0,
			Color = Color3.fromRGB(204, 204, 204)
		}
	elseif ReplicatedStorage:GetAttribute("RadioactiveEvent") then
		v11 = {
			Context = "RadioactiveEvent",
			TweenTime = 0,
			Color = Color3.fromRGB(42, 42, 42)
		}
	elseif ReplicatedStorage:GetAttribute("CursedEvent") then
		v11 = {
			Context = "CursedEvent",
			TweenTime = 0,
			Color = Color3.fromRGB(65, 0, 0)
		}
	elseif ReplicatedStorage:GetAttribute("DivineEvent") then
		v11 = {
			Context = "DivineEvent",
			TweenTime = 0,
			Color = Color3.fromRGB(190, 136, 0)
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
			Color = Color3.fromRGB(7, 15, 34)
		}
	elseif ReplicatedStorage:GetAttribute("EggCityEvent") then
		v11 = {
			Context = "EggCityEvent",
			TweenTime = 0,
			Color = Color3.fromRGB(113, 65, 37)
		}
	elseif ReplicatedStorage:GetAttribute("LaserCityEvent") then
		v11 = {
			Context = "LaserCityEvent",
			TweenTime = 0,
			Color = Color3.fromRGB(90, 95, 105)
		}
	elseif ReplicatedStorage:GetAttribute("SummerEvent") then
		v11 = {
			Context = "SummerEvent",
			Color = Color3.fromRGB(103, 81, 42)
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
	Observers.observeTag("WallBottom", function(p4)
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