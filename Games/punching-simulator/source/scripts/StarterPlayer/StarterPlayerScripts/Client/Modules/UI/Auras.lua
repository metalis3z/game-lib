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
local ArrayUtility
local UI
local Network
local PetUtility
local Notifications
local RankUtility
local AuraUtility

--> Constants

------------->
local Auras = {
	name = script.Name
}

function Auras:_init()
	Services = _L.Get {"Common", "Library", "Services"}
	Network = _L.Get {"Common", "Library", "Network"}
	Signal = _L.Get {"Common", "Library", "Classes", "Signal"}
	Tracker = _L.Get {"Common", "Library", "Classes", "Tracker", "Tracker"}
	Timer = _L.Get {"Common", "Library", "Classes", "Timer"}
	Data = _L.Get {"Client", "Library", "Classes", "Data"}
	TableUtility = _L.Get {"Common", "Library", "Utilities", "TableUtility"}
	NumberUtility = _L.Get {"Common", "Library", "Utilities", "NumberUtility"}
	TrackerUtility = _L.Get {"Common", "Library", "Utilities", "TrackerUtility"}
	AttributeUtility = _L.Get {"Common", "Library", "Utilities", "AttributeUtility"}
	ArrayUtility = _L.Get {"Common", "Library", "Utilities", "ArrayUtility"}
	Spr = _L.Get {"Common", "Library", "Physics", "Spr"}
	Trove = _L.Get {"Common", "Library", "Classes", "Trove"}
	Audio = _L.Get {"Common", "Library", "Audio"} 
	Shared = _L.Get {"Common", "Modules", "Shared"}
	FastTween = _L.Get {"Common", "Library", "Functions", "FastTween"}
	cancellableDelay = _L.Get {"Common", "Library", "Functions", "cancellableDelay"}
	Constants = _L.Get {"Common", "Modules", "Constants"}
	UI = _L.Get {"Client", "Modules", "UI"}
	RankUtility = _L.Get {"Common", "Modules", "Utilities", "RankUtility"}
	AuraUtility = _L.Get {"Common", "Modules", "Utilities", "AuraUtility"}
	
	self.is_open = Tracker.new(false)
	self.trove = Trove.new()
end

function Auras:_start()
	Notifications = UI.Get("Notifications")
	
	self.object = _L.PlayerGui.Auras
	self._instances = {}
	
	self.is_open:Bind(function(value, props)
		if value then
			self:Open()
		else
			self:Close()
		end
	end)
	
	local data = Data.Await()
	
	if data then
		for _, auraInstance in pairs(self.object.Main.Middle:GetChildren()) do
			if auraInstance:IsA("Frame") then
				local auraName = auraInstance.Name
				local auraInfo = AuraUtility.getInfo(auraName)
				local rankInfo = RankUtility.getInfoFromAuraName(auraName)
				
				self._instances[auraName] = auraInstance
				
				auraInstance.EquipBtn.MouseButton1Down:Connect(function()
					local success, newState = Network.Remote.Invoke("S_Auras_Toggle_Equip", auraName)
					
					if success then
						if newState then
							Notifications:add({
								text = "✅ Successfully equipped "..auraName.."!",
								color = Color3.fromRGB(0, 255, 0),
							})
						end
						
						Audio.Play({name = "Equip1", speed = if newState then 1.3 else 2.6})
					else
						local currentRebirths = data:Get({"stats", "Rebirths"})

						Notifications:add({
							text = "❌ You need "..NumberUtility.short(rankInfo.required - currentRebirths).." more Rebirths to equip this aura!",
							color = Color3.fromRGB(255, 0, 0),
							audio = {name = "Fail1"}
						})
						
						UI.Open({name = "Rebirth"})
					end
				end)
				
				data:Bind("equipped_aura", function(value)
					auraInstance.EquipBtn.TextLabel.Text = if value == auraName then "UNEQUIP" else "EQUIP"
					auraInstance.EquipBtn.Image = if value == auraName then Constants.POP_BUTTON_RED else Constants.POP_BUTTON_GREEN
				end)
			end
		end
		
		data:Bind({"stats", "Rebirths"}, function(value)
			for auraName, auraInstance in pairs(self._instances) do
				if auraInstance:IsA("Frame") then
					local auraInfo = AuraUtility.getInfo(auraName)
					local rankInfo = RankUtility.getInfoFromAuraName(auraName)
					
					local hasRank = RankUtility.has(data, rankInfo.name, true)
					
					auraInstance.Frame.Lock.Visible = not hasRank
					auraInstance.Frame.BackgroundColor3 = if hasRank then Color3.fromRGB(255, 255, 255) else Color3.fromRGB(150, 150, 150)
				end
			end
		end)
	end
end

function Auras:Open()
	Spr.Stop(self.object.Main)
	
	
	self.object.Main.Visible = true
	self.object.Main.Position = UDim2.fromScale(0.5, 0.55)
	
	Spr.Target(self.object.Main, 1, 4, {
		Position = UDim2.fromScale(0.5, 0.5)
	})
	
	Spr.Target(workspace.CurrentCamera, 0.7, 4, {
		FieldOfView = 80
	})

	Spr.Target(Services.Lighting.Blur, 0.7, 4, {
		Size = 20
	})
end

function Auras:Close()
	self.object.Main.Visible = false
	

	Spr.Target(workspace.CurrentCamera, 0.7, 4, {
		FieldOfView = 70
	})

	Spr.Target(Services.Lighting.Blur, 0.7, 4, {
		Size = 0
	})
end

return Auras