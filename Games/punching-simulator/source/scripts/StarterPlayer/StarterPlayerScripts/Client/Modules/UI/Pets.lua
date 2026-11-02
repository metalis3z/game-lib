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
local Purchases

--> Constants

------------->
local Pets = {
	name = script.Name
}

function Pets:_init()
	Services = _L.Get {"Common", "Library", "Services"}
	Network = _L.Get {"Common", "Library", "Network"}
	Signal = _L.Get {"Common", "Library", "Classes", "Signal"}
	Tracker = _L.Get {"Common", "Library", "Classes", "Tracker", "Tracker"}
	Timer = _L.Get {"Common", "Library", "Classes", "Timer"}
	Data = _L.Get {"Client", "Library", "Classes", "Data"}
	Purchases = _L.Get {"Client", "Library", "Classes", "Purchases"}
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
	PetUtility = _L.Get {"Common", "Modules", "Utilities", "PetUtility"}
	PetRarities = _L.Get {"Common", "Modules", "Databases", "Pets", "Rarities"}
	PetRarityUtility = _L.Get {"Common", "Modules", "Utilities", "PetRarityUtility"}
	Rainbow = _L.Get {"Client", "Modules", "Classes", "Rainbow"}
	
	self.is_open = Tracker.new(false)
	self.trove = Trove.new()
	self._focus = {tracker = Tracker.new(false), trove = Trove.new()}
	self._mode = {tracker = Tracker.new("Default"), trove = Trove.new()}
	self._selected_pets = Tracker.new({})
end

function Pets:_start()
	Notifications = UI.Get("Notifications")
	
	self.object = _L.PlayerGui.Pets
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
		Rainbow.new({
			speed = 3,
			callback = function(value)
				for _, v in pairs(self._instances) do
					local petData = PetUtility.getData(data, v.uid)
					if petData then
						v.instance.Icon.ImageColor3 = if petData.tier == "Rainbow" then value else Color3.fromRGB(255, 255, 255)
					end
				end
				
				local focusUid = self._focus.tracker:Get()
				
				if focusUid then
					local focusData = PetUtility.getData(data, focusUid)
					
					if focusData and focusData.tier == "Rainbow" then
						self.object.Main.Clip.Focus.Icon.ImageColor3 = value
						return
					end
				end
				
				self.object.Main.Clip.Focus.Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
			end,
		})
		
		self.object.Main.Space.Inner.Equip.Buy.MouseButton1Down:Connect(function()
			local purchases = _G.Purchases
			
			if purchases then
				UI.Open({name = "Store", props = {
					subject = "MorePetsEquipped",
					subject_callback = function()
						if purchases:OwnsGamepass("5_Pets_Equipped") then
							purchases:PromptGamepass("8_Pets_Equipped")
						else
							purchases:PromptGamepass("5_Pets_Equipped")
						end
					end,
				}})
			end
		end)
		
		self.object.Main.Space.Inner.Storage.Buy.MouseButton1Down:Connect(function()
			local purchases = _G.Purchases

			if purchases then
				UI.Open({name = "Store", props = {
					subject = "MorePetStorage",
					subject_callback = function()
						Purchases.PromptProduct("25_Pet_Storage")
					end,
				}})
			end
		end)
	
		local function update()
			local value = data:Get("pets")

			for petInstance, v in pairs(self._instances) do
				local petUid = v.uid
				local petData = PetUtility.getData(data, petUid)

				if not petData then
					local i, v = TableUtility.match(self._instances, function(i, v)
						return v.uid == petUid
					end)

					if i then
						table.remove(self._instances, i)
					end

					if v then
						v.trove:Destroy()
					end
				end
			end

			for _, petData in pairs(value) do
				local petUid = petData.uid

				local _, v = TableUtility.match(self._instances, function(i, v)
					return v.uid == petUid
				end)

				local isEquipped = petData.equipped
				local petInstance = if v then v.instance else nil

				if not v then
					local petName = petData.name
					local petInfo = PetUtility.getInfo(petName)
					local petImage = petInfo.image

					local newTrove = Trove.new()

					petInstance = _L.Assets.UI.Pets.Pet:Clone()
					local gradientInstance = _L.Assets.Gradients.PetRarities:FindFirstChild(petInfo.rarity)

					if gradientInstance then
						local newGradientInstance = gradientInstance:Clone()
						newGradientInstance.Parent = petInstance
					end

					newTrove:Add(self._mode.tracker:Bind(function(value)
						petInstance.Icon.ImageTransparency = if value == "Delete" then 0.3 else 0
					end))

					petInstance.Pet.Text = petInfo.display_name or petInfo.name
					petInstance.Icon.Image = petImage

					newTrove:Add(petInstance)

					petInstance.MouseButton1Down:Connect(function()
						if self._mode.tracker:Get() == "Default" then
							self._focus.tracker:Set(if self._focus.tracker:Get() == petUid then nil else petUid)
						elseif self._mode.tracker:Get() == "Delete" then
							local newSelectedPets = TableUtility.deep.clone(self._selected_pets:Get())

							local i = table.find(newSelectedPets, petUid)

							if i then
								table.remove(newSelectedPets, i)
							else
								table.insert(newSelectedPets, petUid)
							end

							self._selected_pets:Set(newSelectedPets)
						end
					end)

					petInstance.Parent = self.object.Main.Middle

					table.insert(self._instances, {
						name = petName,
						info = petInfo,
						rarity_info = PetRarityUtility.getInfo(petInfo.rarity),
						trove = newTrove,
						instance = petInstance,
						uid = petUid
					})
				end

				petInstance.Equip.Visible = if self._mode.tracker:Get() == "Default" then isEquipped else false
				petInstance.Delete.Visible = self._mode.tracker:Get() == "Delete" and table.find(self._selected_pets:Get(), petUid)
			end

			local mega = {}

			for i = #PetRarities, 1, -1 do
				local rarityInfo = PetRarities[i]

				local mini = ArrayUtility.filter(self._instances, function(i, v)
					return v.rarity_info.name == rarityInfo.name
				end)

				table.sort(mini, function(a, b)
					return (PetUtility.getBoost(data, a.uid) or 0) > (PetUtility.getBoost(data, b.uid) or 0)
				end)

				for _, v in pairs(mini) do
					table.insert(mega, v)
				end
			end

			local mini1 = ArrayUtility.filter(mega, function(i, v)
				local d = PetUtility.getData(data, v.uid)

				if not d then
					return false
				end

				return d.equipped
			end)

			local mini2 = ArrayUtility.filter(mega, function(i, v)
				local d = PetUtility.getData(data, v.uid)

				if not d then
					return false
				end

				return not d.equipped
			end)

			table.clear(mega)

			for i, v in pairs(mini1) do
				table.insert(mega, v)
			end

			for i, v in pairs(mini2) do
				table.insert(mega, v)
			end

			for i, v in pairs(mega) do
				v.instance.LayoutOrder = i
			end

			local i, v = TableUtility.match(value, function(i, v)
				return v.uid == self._focus.tracker:Get()
			end)

			if not v then
				self._focus.tracker:Set(nil)
			end
		end
		
		Tracker.Subscribe({data:Track("pets"), self._mode.tracker, self._selected_pets, self._focus.tracker}, update)
		Timer.Simple(0.5, update)
		
		self._focus.tracker:Bind(function(value)
			self._focus.trove:Clean()
			
			if value then
				local petData = PetUtility.getData(data, value)
				local petName = petData.name
				local petInfo = PetUtility.getInfo(petName)
				local petImage = petInfo.image
				local petUid = value
				local petRarityInfo = PetRarityUtility.getInfo(petInfo.rarity)
				
				self.object.Main.Clip.Focus.Pet.Text = petName
				self.object.Main.Clip.Focus.Icon.Image = petImage
				self.object.Main.Clip.Focus.Boost.Text = NumberUtility.decimal(PetUtility.getBoost(data, petUid)).."x Boost" 
				self.object.Main.Clip.Focus.Rarity.Pet.Text = petRarityInfo.name
				
				local rarityGradient = _L.Assets.Gradients.PetRarities:FindFirstChild(petRarityInfo.name)
				
				if rarityGradient then
					local newRarityGradient = rarityGradient:Clone()
					
					newRarityGradient.Parent = self.object.Main.Clip.Focus.Rarity
					
					self._focus.trove:Add(newRarityGradient)
				end
				
				self._focus.trove:Connect(self.object.Main.Clip.Focus.EquipBtn.MouseButton1Down, function()
					local hasEquipSpace = PetUtility.hasEquipSpace(data)

					local success, newState = Network.Remote.Invoke("S_Pets_Toggle_Equip", petUid)
					
					Audio.Play({name = "Equip1", speed = if newState then 1.3 else 2.6})
					
					if newState and hasEquipSpace then
						Notifications:add({text = "✅ Successfully equipped pet!", color = Color3.fromRGB(0, 255, 0)})
					end
				end)
				
				self._focus.trove:Connect(self.object.Main.Clip.Focus.DeleteBtn.MouseButton1Down, function()
					UI.Open({name = "Confirm", props = {
						text = "Are you sure you want to delete this pet?",
						yes = function()
							local success = Network.Remote.Invoke("S_Pets_Delete", petUid)

							if success then
								Notifications:add({text = "✅ Successfully deleted pet!", color = Color3.fromRGB(0, 255, 0), audio = {name = "Delete1"}})
							end
						end,
						no = function()
						end,
					}})
				end)
				
				self._focus.trove:Connect(self.object.Main.Clip.Focus.CraftBtn.MouseButton1Down, function()
					UI.Open({name = "Confirm", props = {
						text = "Are you sure you want to craft this pet?",
						yes = function()
							local success = Network.Remote.Invoke("S_Pets_Craft", petUid)

							if success then
								Notifications:add({text = "✅ Successfully crafted pet!", color = Color3.fromRGB(0, 255, 0), audio = {name = "Craft1"}})
							end
						end,
						no = function()
						end,
					}})
				end)
				
				Spr.Target(self.object.Main.Clip.Focus, 0.8, 5, {
					Position = UDim2.fromScale(0.83, 0.55)
				})
				
				self._focus.trove:Add(data:Bind("pets", function(value)
					local _, newPetData = TableUtility.match(value, function(i, v)
						return v.uid == petUid
					end)
					
					if newPetData then
						self.object.Main.Clip.Focus.EquipBtn.Image = if newPetData.equipped then Constants.POP_BUTTON_RED else Constants.POP_BUTTON_GREEN
						self.object.Main.Clip.Focus.EquipBtn.TextLabel.Text = if newPetData.equipped then "Unequip" else "Equip"
					end
				end))
				
				Spr.Target(self.object.Main.Middle, 0.8, 5, {
					Position = UDim2.fromScale(0.338, 0.525),
					Size = UDim2.fromScale(0.65, 0.775)
				})

				Spr.Target(self.object.Main.Middle.UIGridLayout, 0.8, 5, {
					CellSize = UDim2.fromScale(0.194, 0.35)
				})
				
				local focusUid = self._focus.tracker:Get()
				
				if focusUid then
					local focusData = PetUtility.getData(data, focusUid)
					local craftable = PetUtility.getCraftable(data, focusUid)
					
					if craftable then
						self.object.Main.Clip.Focus.Require.Text = if focusData and focusData.tier == "Rainbow" then "Not available" else TableUtility.length(craftable).."/"..Constants.PETS_NEEDED_FOR_CRAFT.." required"
						self.object.Main.Clip.Focus.CraftBtn.UIGradient.Enabled = not focusData.tier and TableUtility.length(craftable)>=Constants.PETS_NEEDED_FOR_CRAFT
						self.object.Main.Clip.Focus.CraftBtn.ImageColor3 = if focusData and not focusData.tier and TableUtility.length(craftable)>=Constants.PETS_NEEDED_FOR_CRAFT then Color3.fromRGB(255, 255, 255) else Color3.fromRGB(150, 150, 150)
					end
				end
			else
				Spr.Target(self.object.Main.Clip.Focus, 0.8, 5, {
					Position = UDim2.fromScale(1.2, 0.55)
				})
				
				Spr.Target(self.object.Main.Middle, 0.8, 5, {
					Position = UDim2.fromScale(0.5, 0.525),
					Size = UDim2.fromScale(0.975, 0.775)
				})

				Spr.Target(self.object.Main.Middle.UIGridLayout, 0.8, 5, {
					CellSize = UDim2.fromScale(0.125, 0.35)
				})
			end
		end)
		
		self.object.Main.DeleteBtn.MouseButton1Click:Connect(function()
			self._mode.tracker:Set(if self._mode.tracker:Get() == "Delete" then "Default" else "Delete")
		end)
		
		self._mode.tracker:Bind(function(value)
			self.object.Main.CancelDeleteBtn.Visible = value == "Delete"
			self.object.Main.ConfirmDeleteBtn.Visible = value == "Delete"
						
			self.object.Main.DeleteBtn.Visible = value == "Default"
			self.object.Main.EquipBestBtn.Visible = value == "Default"
			
			if value == "Delete" then
				self._focus.tracker:Set(nil)
				self._selected_pets:Set({})
			end
		end)
		
		self._selected_pets:Bind(function(value)
			self.object.Main.ConfirmDeleteBtn.TextLabel.Text = "Delete ("..#value..")"
		end)
		
		self.object.Main.CancelDeleteBtn.MouseButton1Click:Connect(function()
			self._mode.tracker:Set("Default")
		end)
		
		self.object.Main.ConfirmDeleteBtn.MouseButton1Click:Connect(function()
			local petUids = self._selected_pets:Get()
			
			if TableUtility.length(petUids) <= 0 then
				return
			end
			
			local petInfos = TableUtility.map(petUids, function(i, v)
				local petData = PetUtility.getData(data, v)
				local petInfo = PetUtility.getInfo(petData.name)
				return petData.uid, petInfo
			end)
			
			self._mode.tracker:Set("Default")
			self._selected_pets:Set({})
			
			local success = Network.Remote.Invoke("S_Pets_Delete", petUids)

			if success then
				Notifications:add({text = "✅ Successfully deleted all pets!", color = Color3.fromRGB(0, 255, 0)})
				Audio.Play({name = "Delete1"})
			end
		end)
		
		self.object.Main.EquipBestBtn.MouseButton1Click:Connect(function()
			local success, petUids = Network.Remote.Invoke("S_Pets_Equip_Best")

			if success then
				local petInfos = TableUtility.map(petUids, function(i, v)
					local petData = PetUtility.getData(data, v)
					local petInfo = PetUtility.getInfo(petData.name)
					return v, petInfo
				end)
				
				Notifications:add({text = "✅ Successfully equipped pets!", color = Color3.fromRGB(0, 255, 0)})

				Audio.Play({name = "EquipBest1"})
			end
		end)
		
		Tracker.Subscribe({data:Track({"stats", "Pet_Storage_Space"}), data:Track("pets")}, function()
			local value1 = data:Get("pets")
			local value2 = data:Get({"stats", "Pet_Storage_Space"})
			
			self.object.Main.Space.Inner.Storage.TextLabel.Text = TableUtility.length(value1).."/"..value2
		end)
		
		Tracker.Subscribe({data:Track({"stats", "Pet_Equip_Space"}), data:Track("pets")}, function()
			local value1 = TableUtility.filter(data:Get("pets"), function(i, v)
				return v.equipped
			end)
			
			local value2 = data:Get({"stats", "Pet_Equip_Space"})

			self.object.Main.Space.Inner.Equip.TextLabel.Text = TableUtility.length(value1).."/"..value2
		end)
	end
end

function Pets:Open()
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

function Pets:Close()
	
	self.object.Main.Visible = false
	
	Spr.Target(workspace.CurrentCamera, 0.7, 4, {
		FieldOfView = 70
	})

	Spr.Target(Services.Lighting.Blur, 0.7, 4, {
		Size = 0
	})
end

return Pets