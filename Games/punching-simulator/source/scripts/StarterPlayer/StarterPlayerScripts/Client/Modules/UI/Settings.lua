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
local Purchases
local Icon
local _Settings

--> Constants

------------->
local Settings = {
	name = script.Name
}

function Settings:_init()
	Purchases = _L.Get {"Client", "Library", "Classes", "Purchases"}
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
	Icon = _L.Get {"Client", "Modules", "Icon"}
	_Settings = _L.Get {"Common", "Modules", "Databases", "Settings"}
	
	self.is_open = Tracker.new(false)
	self.trove = Trove.new()
end

function Settings:_start()
	self.object = _L.PlayerGui.Settings
	
	self.is_open:Bind(function(value, props)
		if value then
			self:Open()
		else
			self:Close()
		end
	end)
	
	local data = Data.Await()

	if data then
		local icon = Icon.new()
		
		:setImage("rbxassetid://13874799129")

		icon.selected:Connect(function()
			icon:deselect()
			Audio.Play({name = "Plop1"})
			UI.Toggle({name = self.name})
			UI.Close({name = "Daily"})
		end)
		
		local tab = Tracker.new("Settings")
		
		self.object.Main.Buttons.Settings.MouseButton1Down:Connect(function()
			tab:Set("Settings")
		end)
		
		self.object.Main.Buttons.Titles.MouseButton1Down:Connect(function()
			tab:Set("Titles")
		end)
		
		self.object.Main.Buttons.Stats.MouseButton1Down:Connect(function()
			tab:Set("Stats")
		end)
		
		for _, settingFrame in pairs(self.object.Main.Middle.Settings:GetChildren()) do
			if settingFrame:IsA("Frame") then
				local settingName = settingFrame.Name
				local settingInfo = _Settings[settingName]
				
				data:Bind("settings", function(value)
					local settingData = value[settingName]
					
					settingFrame.Main.StateBtn.Image = if settingData then Constants.POP_BUTTON_GREEN else Constants.POP_BUTTON_RED
					settingFrame.Main.StateBtn.TextLabel.Text = if settingData then "On" else "Off"
				end)
				
				settingFrame.Main.StateBtn.MouseButton1Down:Connect(function()
					local success, err = Network.Remote.Invoke("S_Settings_Toggle", settingName)
					
					if not success then
						if settingName == "Auto_Rebirth" and err == "owns" then
							UI.Open({name = "Store", props = {
								subject = "Gamepasses",
								subject_callback = function()
									Purchases.PromptGamepass("Auto_Rebirth")
								end,
							}})
						end
					end
				end)
			end
		end
		
		for _, statFrame in pairs(self.object.Main.Middle.Stats:GetChildren()) do
			if statFrame:IsA("Frame") then
				local statName = statFrame.Name
				
				data:Bind({"stats", statName}, function(value)
					statFrame.Main.Title.Text = statName..": "..NumberUtility.short(value)
				end)
			end
		end
		
		self._title_instances = {}
		
		for _, titleButton in pairs(self.object.Main.Middle.Titles:GetChildren()) do
			if titleButton:IsA("Frame") then
				local titleId = tonumber(titleButton.Name)

				self._title_instances[titleId] = titleButton

				titleButton.Main.MouseButton1Down:Connect(function()
					Audio.Play({name = "ButtonDown1"})
					Network.Remote.Fire("S_Titles_Toggle_Equip", titleId)
				end)
			end
		end

		data:Bind("titles", function(value)
			for titleId, titleButton in pairs(self._title_instances) do
				local _, titleData = TableUtility.match(value, function(i, v)
					return v.id == titleId
				end)

				local titleEquipped = titleData and titleData.equipped

				titleButton.Main.Equipped.Visible = titleEquipped
				titleButton.Main.Locked.Visible = titleData == nil
			end
		end)
		
		tab:Bind(function(value)
			for _, a in pairs(self.object.Main.Middle:GetChildren()) do
				a.Visible = value == a.Name
			end
		end)
	end
end

function Settings:Open()
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

function Settings:Close()
	
	self.object.Main.Visible = false
	
	Spr.Target(workspace.CurrentCamera, 0.7, 4, {
		FieldOfView = 70
	})

	Spr.Target(Services.Lighting.Blur, 0.7, 4, {
		Size = 0
	})
	
end

return Settings