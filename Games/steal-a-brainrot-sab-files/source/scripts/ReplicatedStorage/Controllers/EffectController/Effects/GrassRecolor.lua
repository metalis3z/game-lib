local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("TweenService")
require(script:FindFirstAncestor("Effects").Parent.Types)

local t1 = {}
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Signal = require(ReplicatedStorage.Packages.Signal)
local _ = script.Name
local t2 = {
	"WitchingHourEvent",
	"IndonesiaEvent",
	"CyberEvent",
	"PhantomEvent",
	"RadioactiveEvent",
	"LaserCityEvent"
}
local t3 = {
	Context = "Default",
	TweenTime = 0,
	Top = Color3.fromRGB(31, 128, 29),
	Bottom = Color3.fromRGB(31, 128, 29),
	Carpet = Color3.fromRGB(196, 40, 28)
}
local u9 = t3
local v10 = Signal.new()

local function update()
	local v12 = t3

	elseif ReplicatedStorage:GetAttribute("1YearClawsPhase") then
		v12 = {
			Context = "1YearClawsPhase",
			TweenTime = 1,
			Top = Color3.fromRGB(235, 178, 55),
			Bottom = Color3.fromRGB(235, 178, 55)
		}
	elseif ReplicatedStorage:GetAttribute("1YearBrazilPhase") then
		v12 = {
			Context = "1YearBrazilPhase",
			TweenTime = 1,
			Top = Color3.fromRGB(215, 92, 31),
			Bottom = Color3.fromRGB(215, 92, 31)
		}
	elseif ReplicatedStorage:GetAttribute("1YearMexicoPhase") then
		v12 = {
			Context = "1YearMexicoPhase",
			TweenTime = 1,
			Top = Color3.fromRGB(180, 130, 75),
			Bottom = Color3.fromRGB(150, 100, 55)
		}
	elseif ReplicatedStorage:GetAttribute("LanceEvent") then
		v12 = {
			Context = "Lance",
			TweenTime = 0,
			Bottom = Color3.fromRGB(209, 97, 45),
			Top = Color3.fromRGB(111, 59, 24)
		}
	elseif ReplicatedStorage:GetAttribute("RipMyGrannyEvent") then
		v12 = {
			Context = "RipMyGrannyEvent",
			TweenTime = 0,
			Bottom = Color3.fromRGB(31, 128, 29),
			Top = Color3.fromRGB(120, 101, 48)
		}
	elseif ReplicatedStorage:GetAttribute("EidEvent") then
		v12 = {
			Context = "EidEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(0, 85, 255),
			Bottom = Color3.fromRGB(0, 85, 255),
			Carpet = Color3.fromRGB(27, 42, 53)
		}
	elseif ReplicatedStorage:GetAttribute("2026Event") then
		v12 = {
			Context = "2026",
			TweenTime = 0,
			Top = Color3.fromRGB(48, 57, 79),
			Bottom = Color3.fromRGB(35, 35, 35),
			Carpet = Color3.fromRGB(60, 60, 60)
		}
	elseif ReplicatedStorage:GetAttribute("ConcertEvent") then
		v12 = {
			Context = "Concert",
			TweenTime = 2,
			Top = Color3.fromRGB(157, 155, 151),
			Bottom = Color3.fromRGB(46, 71, 89)
		}
	elseif ReplicatedStorage:GetAttribute("RapConcertEvent") then
		v12 = {
			Context = "RapConcert",
			TweenTime = 2,
			Top = Color3.fromRGB(157, 155, 151),
			Bottom = Color3.fromRGB(46, 71, 89)
		}
	elseif ReplicatedStorage:GetAttribute("BrazilEvent") then
		v12 = {
			Context = "Brazil",
			TweenTime = 2,
			Top = Color3.fromRGB(215, 92, 31),
			Bottom = Color3.fromRGB(215, 92, 31)
		}
	elseif ReplicatedStorage:GetAttribute("AyMiGatitoEvent") then
		v12 = {
			Context = "AyMiGatitoEvent",
			TweenTime = 2,
			Top = Color3.fromRGB(103, 185, 87),
			Bottom = Color3.fromRGB(81, 162, 59)
		}
	elseif ReplicatedStorage:GetAttribute("MexicoEvent") then
		v12 = {
			Context = "MexicoEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(160, 95, 53),
			Bottom = Color3.fromRGB(175, 126, 67)
		}
	elseif ReplicatedStorage:GetAttribute("IndonesiaEvent") then
		v12 = {
			Context = "IndonesiaEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(160, 95, 53),
			Bottom = Color3.fromRGB(56, 109, 63)
		}
	elseif ReplicatedStorage:GetAttribute("CrabRave") then
		v12 = {
			Context = "CrabRave",
			TweenTime = 1.95,
			Top = Color3.fromRGB(235, 178, 55),
			Bottom = Color3.fromRGB(235, 178, 55)
		}
	elseif ReplicatedStorage:GetAttribute("WaterEvent") then
		v12 = {
			Context = "WaterEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(226, 155, 64),
			Bottom = Color3.fromRGB(226, 155, 64)
		}
	elseif ReplicatedStorage:GetAttribute("StrawberryEvent") then
		v12 = {
			Context = "StrawberryEvent",
			TweenTime = 0,
			MaterialVariant = "Strawberry Stud",
			Top = Color3.fromRGB(255, 255, 255),
			Bottom = Color3.fromRGB(255, 255, 255),
			Carpet = Color3.fromRGB(31, 128, 29)
		}
	elseif ReplicatedStorage:GetAttribute("MeowlEvent") then
		v12 = {
			Context = "MeowlEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(69, 97, 44),
			Bottom = Color3.fromRGB(18, 65, 29)
		}
	elseif ReplicatedStorage:GetAttribute("ValentinesEvent") then
		v12 = {
			Context = "ValentinesEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(226, 153, 255),
			Bottom = Color3.fromRGB(188, 69, 71),
			Carpet = Color3.fromRGB(200, 0, 0)
		}
	elseif ReplicatedStorage:GetAttribute("DulDulDulEvent") then
		v12 = {
			Context = "DulDulDulEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(137, 136, 139),
			Bottom = Color3.fromRGB(87, 127, 41)
		}
	elseif ReplicatedStorage:GetAttribute("ChicleteiraBicicleteiraEvent") then
		v12 = {
			Context = "ChicleteiraBicicleteiraEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(85, 67, 67),
			Bottom = Color3.fromRGB(31, 128, 29),
			Carpet = Color3.fromRGB(61, 53, 57)
		}
	elseif ReplicatedStorage:GetAttribute("TrickOrTreatEvent") then
		v12 = {
			Context = "TrickOrTreatEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(56, 109, 60),
			Bottom = Color3.fromRGB(56, 109, 60),
			Carpet = Color3.fromRGB(27, 42, 53)
		}
	elseif ReplicatedStorage:GetAttribute("GraveyardEvent") then
		v12 = {
			Context = "GraveyardEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(47, 102, 72),
			Bottom = Color3.fromRGB(255, 255, 255)
		}
	elseif ReplicatedStorage:GetAttribute("GingerbreadTownEvent") then
		v12 = {
			Context = "GingerbreadTownEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(145, 161, 168),
			Bottom = Color3.fromRGB(145, 161, 168)
		}
	elseif ReplicatedStorage:GetAttribute("WinterHourEvent") then
		v12 = {
			Context = "WinterHourEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(145, 161, 168),
			Bottom = Color3.fromRGB(145, 161, 168),
			Carpet = Color3.fromRGB(87, 153, 166)
		}
	elseif ReplicatedStorage:GetAttribute("EasterEvent") then
		v12 = {
			Context = "EasterEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(87, 204, 51),
			Bottom = Color3.fromRGB(87, 204, 51),
			Carpet = Color3.fromRGB(193, 105, 196)
		}
	elseif ReplicatedStorage:GetAttribute("WitchingHourEvent") then
		v12 = {
			Context = "WitchingHourEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(39, 10, 59),
			Bottom = Color3.fromRGB(39, 10, 59)
		}
	elseif ReplicatedStorage:GetAttribute("YinYangEvent") then
		v12 = {
			Context = "YinYangEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(204, 204, 204),
			Bottom = Color3.fromRGB(0, 0, 0)
		}
	elseif ReplicatedStorage:GetAttribute("RadioactiveEvent") then
		v12 = {
			Context = "RadioactiveEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(31, 128, 29),
			Bottom = Color3.fromRGB(27, 42, 53),
			Carpet = Color3.fromRGB(196, 147, 0)
		}
	elseif ReplicatedStorage:GetAttribute("CursedEvent") then
		v12 = {
			Context = "CursedEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(0, 0, 0),
			Bottom = Color3.fromRGB(42, 17, 0)
		}
	elseif ReplicatedStorage:GetAttribute("DivineEvent") then
		v12 = {
			Context = "DivineEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(203, 187, 166),
			Bottom = Color3.fromRGB(203, 177, 45),
			Carpet = Color3.fromRGB(190, 136, 0)
		}
	elseif ReplicatedStorage:GetAttribute("PhantomEvent") then
		v12 = {
			Context = "PhantomEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(27, 42, 53),
			Bottom = Color3.fromRGB(46, 56, 62),
			Material = Enum.Material.Glass
		}
	elseif ReplicatedStorage:GetAttribute("CyberEvent") then
		v12 = {
			Context = "CyberEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(30, 34, 47),
			Top2 = Color3.fromRGB(0, 170, 196),
			Bottom = Color3.fromRGB(30, 34, 47),
			Carpet = Color3.fromRGB(15, 33, 75)
		}
	elseif ReplicatedStorage:GetAttribute("GalaxyEvent") then
		v12 = {
			Context = "GalaxyEvent",
			TweenTime = 2,
			Top = Color3.fromRGB(42, 99, 255),
			Bottom = Color3.fromRGB(42, 99, 255)
		}
	elseif ReplicatedStorage:GetAttribute("ExtinctEvent") then
		v12 = {
			Context = "ExtinctEvent",
			TweenTime = 0.5,
			Top = Color3.fromRGB(108, 83, 58),
			Bottom = Color3.fromRGB(108, 83, 58)
		}
	elseif ReplicatedStorage:GetAttribute("MoltenEvent") then
		v12 = {
			Context = "Molten",
			TweenTime = 0.5,
			Top = Color3.fromRGB(0, 0, 0),
			Bottom = Color3.fromRGB(0, 0, 0)
		}
	elseif ReplicatedStorage:GetAttribute("EggCityEvent") then
		v12 = {
			Context = "EggCityEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(93, 136, 61),
			Bottom = Color3.fromRGB(93, 136, 61)
		}
	elseif ReplicatedStorage:GetAttribute("BackroomsEvent") then
		v12 = {
			Context = "BackroomsEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(120, 108, 83),
			Bottom = Color3.fromRGB(120, 108, 83)
		}
	elseif ReplicatedStorage:GetAttribute("LaserCityEvent") then
		v12 = {
			Context = "LaserCityEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(149, 117, 61),
			Bottom = Color3.fromRGB(68, 129, 39)
		}
	elseif ReplicatedStorage:GetAttribute("Snow") then
		v12 = {
			Context = "Snow",
			TweenTime = 8,
			Top = Color3.fromRGB(190, 190, 190),
			Bottom = Color3.fromRGB(190, 190, 190)
		}
	elseif ReplicatedStorage:GetAttribute("SummerEvent") then
		v12 = {
			Context = "SummerEvent",
			TweenTime = 0,
			Top = Color3.fromRGB(162, 127, 66),
			Bottom = Color3.fromRGB(67, 141, 36),
			Carpet = t3.Carpet
		}
	end

	if u9.Context == v12.Context then
		return
	end

	u9 = v12
	v10:Fire()
end

function t1.OnStart(_)
	update()
end
function t1.OnUpdate(_)
	update()
end
function t1.OnLoad(_)
	Observers.observeTag("Grass", function(p4)
		local u17 = nil
		local p4Material = p4.Material

		local function runTween()
			if u17 then
				u17:Cancel()
			end

			p4.MaterialVariant = u9.MaterialVariant or ""

			local v27 = not p4:GetAttribute("Bottom") and "Top" or "Bottom"

			if v27 == "Top" and u9.Top2 and p4:GetAttribute("Top2") then
				v27 = "Top2"
			end

			if u9.Material and v27 ~= "Bottom" then
				p4.Material = u9.Material
			else
				p4.Material = p4Material
			end

			u17 = CreateTween(p4, TweenInfo.new(u9.TweenTime), {
				Color = if type(u9[v27]) ~= "table" then u9[v27] else u9[v27][p4:GetAttribute("Side") or "Left"] or (u9[v27].Left or select(2, next(u9[v27])))
			})
		end

		local connection = v10:Connect(runTween)

		task.spawn(runTween)

		return function()
			connection:Disconnect()
			u17:Cancel()
		end
	end, { workspace })
	Observers.observeTag("Carpet", function(p5)
		local u22 = nil

		local function runTween()
			if u22 then
				u22:Cancel()
			end

			local v28 = false

			for _, v30 in t2 do
				if ReplicatedStorage:GetAttribute(v30) then
					v28 = true

					break
				end
			end

			p5.Transparency = not v28 and 0 or 1
			u22 = CreateTween(p5, TweenInfo.new(u9.TweenTime), {
				Color = u9.Carpet or t3.Carpet
			})
		end

		local t4 = { v10:Connect(runTween) }

		for _, v26 in t2 do
			table.insert(t4, ReplicatedStorage:GetAttributeChangedSignal(v26):Connect(runTween))
		end

		task.spawn(runTween)

		return function()
			for _, v32 in t4 do
				v32:Disconnect()
			end

			u22:Cancel()
		end
	end, { workspace })
end

return t1