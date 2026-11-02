--> Variables
local _L = _G._L

local Services
local Signal
local Tracker
local Data
local TableUtility
local NumberUtility
local Spr
local Trove
local Audio
local Shared
local Timer
local FastTween
local cancellableDelay
local Constants
local AttributeUtility
local TrackerUtility
local _Stats
local ProgressBar
local Free
local Wheel
local Store
local Notifications
local Settings

--> Constants

------------->
local Top = {
	name = script.Name
}

function Top:_init()
	Network = _L.Get {"Common", "Library", "Network"}
	Services = _L.Get {"Common", "Library", "Services"}
	Signal = _L.Get {"Common", "Library", "Classes", "Signal"}
	Tracker = _L.Get {"Common", "Library", "Classes", "Tracker", "Tracker"}
	Timer = _L.Get {"Common", "Library", "Classes", "Timer"}
	Data = _L.Get {"Client", "Library", "Classes", "Data"}
	TableUtility = _L.Get {"Common", "Library", "Utilities", "TableUtility"}
	NumberUtility = _L.Get {"Common", "Library", "Utilities", "NumberUtility"}
	TrackerUtility = _L.Get {"Common", "Library", "Utilities", "TrackerUtility"}
	AttributeUtility = _L.Get {"Common", "Library", "Utilities", "AttributeUtility"}
	Spr = _L.Get {"Common", "Library", "Physics", "Spr"}
	Trove = _L.Get {"Common", "Library", "Classes", "Trove"}
	Audio = _L.Get {"Common", "Library", "Audio"} 
	Shared = _L.Get {"Common", "Modules", "Shared"}
	FastTween = _L.Get {"Common", "Library", "Functions", "FastTween"}
	cancellableDelay = _L.Get {"Common", "Library", "Functions", "cancellableDelay"}
	Constants = _L.Get {"Common", "Modules", "Constants"}
	_Stats = _L.Get {"Common", "Modules", "Databases", "Stats"}
	ProgressBar = _L.Get {"Client", "Modules", "Classes", "ProgressBar"}
	UI = _L.Get {"Client", "Modules", "UI"}
end

function Top:_start()
	Free = UI.Get("Free")
	Wheel = UI.Get("Wheel")
	Store = UI.Get("Store")
	Notifications = UI.Get("Notifications")
	Settings = UI.Get("Settings")
	Season = UI.Get("Season")
	
	self.object = _L.PlayerGui.Main.Top

	local data = Data.Await()

	if data then
		local icon = self.object.Free.Free.Icon

		Timer.Simple(1.5, function()
			Spr.Target(icon, 0.3, 3, {
				Rotation = 15
			})

			task.wait(0.175)

			Spr.Target(icon, 0.3, 3, {
				Rotation = -10
			})

			task.wait(0.175)

			Spr.Target(icon, 0.3, 3, {
				Rotation = 7
			})

			task.wait(0.125)

			Spr.Target(icon, 0.3, 3, {
				Rotation = 0
			})
		end)
		
		for _, statFrame in pairs(self.object.Stats:GetChildren()) do
			if statFrame:IsA("ImageLabel") then
				local statName = statFrame.Name
				local trove = Trove.new()

				data:Bind({"stats", statName}, function(value)
					trove:Clean()

					statFrame.Number.Text = NumberUtility.short(value)

					Spr.Target(statFrame.UIScale, 0.4, 6, {
						Scale = 1.1
					})

					trove:Add(cancellableDelay(0.05, function()
						Spr.Target(statFrame.UIScale, 0.8, 12, {
							Scale = 1
						})
					end))
				end)
				
				statFrame.Buy.MouseButton1Down:Connect(function()
					UI.Open({name = "Store", props = {
						subject = statName
					}})
				end)
			end
		end
		
		local progressBar = ProgressBar.new({instance = self.object.ProgressBar, format = function(n1, n2)
			return (math.round((n1 / n2) * 1000) / 10).."%"
		end,})

		local lastWeaponInfo = nil

		data:Bind({"stats", "Strength"}, function(value)
			local currentPowerInfo = Shared.GetCurrentPowerInfoFromStrength(value)
			local nextPowerInfo = Shared.GetNextPowerInfoFromStrength(value)

			if lastWeaponInfo and currentPowerInfo and lastWeaponInfo.name ~= currentPowerInfo.name and lastWeaponInfo.strength <= currentPowerInfo.strength and data:Get({"settings", "Popups"}) then
				Notifications:add({text = "⬆️ Level Up!", color = Color3.fromRGB(0, 255, 255), audio = {name = "Progress1"}})
				Network.Bindable.Fire("C_Character_LevelUp")
			end

			lastWeaponInfo = currentPowerInfo

			if nextPowerInfo then
				self.object.ProgressLabelText.Text = [[<stroke color= "rgb(0, 0, 0)" joins="round" thickness="2" transparency="0">^^ Reach <font color= "rgb(0, 255, 0)">]]..NumberUtility.short(nextPowerInfo.required)..[[</font> Strength for a new POWER ^^</stroke>]]
				progressBar:Set({value, nextPowerInfo.required})
			else
				self.object.ProgressLabelText.Text = [[<stroke color= "rgb(0, 0, 0)" joins="round" thickness="2" transparency="0">You have reached the best <font color= "rgb(0, 255, 0)">POWER</font> in the game!</stroke>]]
				progressBar:Set({100, 100})
			end
		end)
	end
	
	local og = self.object.Position

	UI._current:Bind(function(value)
		self.object.ProgressBar.Visible = value == nil
		self.object.ProgressLabelText.Visible = value == nil
	end)
end

--[[

<font color= "rgb(255, 255, 255)"><font color= "rgb(0, 255, 0)">Deathmatch!</font>: Killing people gives you some of their gems for 5 minutes.</font>
]]
return Top