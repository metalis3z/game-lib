--> Variables
local _L = _G._L

local Services
local Maid
local Network
local Audio
local TableUtils
local Character
local Shared
local RandomUtility
local Timer
local Create
local NumberUtility
local TableUtility
local Tags
local DictionaryUtility
local cancellableDelay
local Tracker
local AttributeUtility
local PetUtility
local EggUtility
local Eggs
local Notifications
local Purchases
local StatUtility

--> Constants
local EGG_UI_DISTANCE = 10

------------->
local Egg = {_objects = {}}
Egg.__index = Egg

function Egg._init()
	Services = _L.Get {"Common", "Library", "Services"}
	Maid = _L.Get {"Common", "Library", "Classes", "Maid"} 
	Trove = _L.Get {"Common", "Library", "Classes", "Trove"} 
	Network = _L.Get {"Common", "Library", "Network"}
	Audio = _L.Get {"Common", "Library", "Audio"}
	TableUtility = _L.Get {"Common", "Library", "Utilities", "TableUtility"}
	Character = _L.Get {"Client", "Modules", "Controllers", "Character"}
	Tracker = _L.Get {"Common", "Library", "Classes", "Tracker", "Tracker"}
	Shared = _L.Get {"Common", "Modules", "Shared"}
	RandomUtility = _L.Get {"Common", "Library", "Utilities", "RandomUtility"}
	Timer = _L.Get {"Common", "Library", "Classes", "Timer"}
	Create = _L.Get {"Common", "Library", "Functions", "Create"}
	NumberUtility = _L.Get {"Common", "Library", "Utilities", "NumberUtility"}
	cancellableDelay = _L.Get {"Common", "Library", "Functions", "cancellableDelay"}
	DictionaryUtility = _L.Get {"Common", "Library", "Utilities", "DictionaryUtility"}
	AttributeUtility = _L.Get {"Common", "Library", "Utilities", "AttributeUtility"}
	PetUtility = _L.Get {"Common", "Modules", "Utilities", "PetUtility"}
	Spr = _L.Get {"Common", "Library", "Physics", "Spr"}
	UI = _L.Get {"Client", "Modules", "UI"}
	Purchases = _L.Get {"Client", "Library", "Classes", "Purchases"}
	StatUtility = _L.Get {"Common", "Modules", "Utilities", "StatUtility"}
	EggUtility = _L.Get {"Common", "Modules", "Utilities", "EggUtility"}
end

function Egg._start()
	Eggs = UI.Get("Eggs")
	Notifications = UI.Get("Notifications")
	
	local closest
	
	Services.RunService.RenderStepped:Connect(function()
		local cloestEggInstance, closestEgg = TableUtility.min(TableUtility.filter(Egg._objects, function(i, v)
			local mag = v:_get_distance()
			
			if mag and mag <= EGG_UI_DISTANCE then
				return true
			else
				return false
			end
		end), function(i, v)
			return v:_get_distance()
		end)
		
		if closestEgg then
			for eggInstance, egg in pairs(Egg._objects) do
				task.spawn(function()
					if egg == closestEgg then
						closest = egg
						egg:_render(true)
					else
						egg:_render(false)
					end
				end)
			end
		else
			closest = nil
			
			for eggInstance, egg in pairs(Egg._objects) do
				task.spawn(function()
					egg:_render(false)
				end)
			end
		end
	end)
	
	Services.ContextActionService:BindAction("Auto", function(actionName, inputState, _inputObject)
		if closest then
			if inputState == Enum.UserInputState.Begin then
				closest:_auto_open()
			end

		end
	end, false, Enum.KeyCode.T)
	
	Services.ContextActionService:BindAction("Open_1", function(actionName, inputState, _inputObject)
		if closest then
			if inputState == Enum.UserInputState.Begin then
				closest:_open_1(true)
			end
			
		end
	end, false, Enum.KeyCode.E)

	Services.ContextActionService:BindAction("Open_3", function(actionName, inputState, _inputObject)
		if closest then
			if inputState == Enum.UserInputState.Begin then
				closest:_open_3(true)
			end
			
		end
	end, false, Enum.KeyCode.R)
end

function Egg.new(props)
	local self = setmetatable({}, Egg)
	
	self._instance = props.instance
	self._player_controller = props.player_controller
	
	self._name = self._instance.name
	self._info = EggUtility.getInfo(self._name)
	
	self._billboard = nil
	
	self._visible = Tracker.new(false)
	self._auto = {tracker = Tracker.new(false), trove = Trove.new()}
	
	self._trove = Trove.new()

	self:_construct()

	return self
end

function Egg:_construct()
	self:_setup()

	Egg._objects[self._instance] = self

	self._trove:Add(function()
		Egg._objects[self._instance] = nil
	end)
end

function Egg:_setup()
	task.spawn(function()
		repeat task.wait() until EggUtility

		self:_create_billboard()

		local trove = Trove.new()

		Tracker.Subscribe({self._visible, Eggs.is_opening}, function()
			trove:Clean()

			local visible = self._visible:Get()

			Spr.Stop(self._billboard.Main.UIScale)

			if visible and not Eggs.is_opening:Get() then
				self._billboard.Main.UIScale.Scale = 0.5

				Spr.Target(self._billboard.Main.UIScale, 0.8, 4, {
					Scale = 1
				})
			else
				self._billboard.Main.UIScale.Scale = 0
			end
		end)

		self._auto.tracker:Bind(function(value)
			self._auto.trove:Clean()
			
			if not value then
				if self._started then
					Notifications:add({text = "Auto Open is now disabled", color = Color3.fromRGB(255, 0, 0),})
				end
				return
			end
			
			self._started = true
			
			self._auto.trove:Add(Timer.Simple(1, function()
				self:_try_auto_open()
			end))

			self:_try_auto_open()
		end)
	end)
end

function Egg:_try_auto_open()
	local success3, err3, notiErr3 = self:_open_3()

	if success3 == false then
		local success1, err1, notiErr1 = self:_open_1()
		
		if success1 == false then
			if notiErr1 then
				Notifications:add(notiErr1)
				self._auto.tracker:Set(false)
			end
		end
	end
end

function Egg:_create_billboard()
	self._billboard = _L.Assets.UI.EggBillboard:Clone()
	
	for _, pet in pairs(self._info.pets) do
		local petName = pet.name
		local petChance = pet.chance
		local newPetInstance = _L.Assets.UI.Eggs.Pet:Clone()
		local petInfo = PetUtility.getInfo(petName)
		
		local gradientInstance = _L.Assets.Gradients.PetRarities:FindFirstChild(petInfo.rarity)

		if gradientInstance then
			local newGradientInstance = gradientInstance:Clone()
			newGradientInstance.Parent = newPetInstance
		end
		
		newPetInstance.Icon.Image = petInfo.image
		newPetInstance.Chance.Text = petChance.."%"
		newPetInstance.Pet.Text = petName
		
		newPetInstance.MouseButton1Down:Connect(function()
			Network.Remote.Fire("S_Egg_Auto_Delete_Toggle", petName)
		end)
		
		newPetInstance.Parent = self._billboard.Main.Frame
		
		self._trove:Add(self._player_controller._data:Bind({"auto_delete", petName}, function(value)
			newPetInstance.Delete.Visible = value ~= nil
		end))
	end
	
	self._billboard.Main.Open_1.MouseButton1Down:Connect(function()
		self:_open_1(true)
	end)
	
	self._billboard.Main.Open_3.MouseButton1Down:Connect(function()
		self:_open_3(true)
	end)
	
	self._billboard.Main.Auto.MouseButton1Down:Connect(function()
		self:_auto_open()
	end)
	
	self._billboard.Main.Icon.Price.Text = NumberUtility.short(self._info.price)
	self._billboard.Main.Title.Text = self._info.display_name
	self._billboard.Adornee = self._instance.Egg
	self._billboard.Parent = _L.PlayerGui
end

function Egg:_render(visible)
	self._visible:Set(visible)
	
	if not visible then
		self._auto.tracker:Set(false)
	end
end

function Egg:_auto_open()
	self._auto.tracker:Set(not self._auto.tracker:Get())
end

function Egg:_open_1(s)
	if Eggs.is_opening:Get() then
		return
	end
	
	local success, err = Network.Remote.Invoke("S_Egg_Open_1", self._name)
	
	local notiErr
	
	if err == "afford" then
		notiErr = {
			text = "You need "..NumberUtility.short(self._info.price-self._player_controller._data:Get({"stats", "Gems"})).." more Gems to buy this egg!",
			color = Color3.fromRGB(255, 0, 0),
			audio = {name = "Fail1"}
		}
		
		UI.Open({name = "Store", props = {
			subject = "Gems",
			subject_callback = function()
				Purchases.PromptProduct(StatUtility.closestProduct("Gems", self._player_controller._data:Get({"stats", "Gems"}), self._info.price))
			end,
		}})
	elseif err == "space"  then
		notiErr = {
			text = "You need more Inventory Space to buy this egg!",
			color = Color3.fromRGB(255, 0, 0),
			audio = {name = "Fail1"}
		}
	end
	
	if notiErr and s then
		Notifications:add(notiErr)
	end
	
	return success, err, notiErr
end

function Egg:_open_3(s)
	if Eggs.is_opening:Get() then
		return
	end
	
	local success, err = Network.Remote.Invoke("S_Egg_Open_3", self._name, s)
	
	local notiErr
	
	if err == "afford" and not s then
		notiErr = {
			text = "You need "..NumberUtility.short(self._info.price*3-self._player_controller._data:Get({"stats", "Gems"})).." more Gems to buy this egg!",
			color = Color3.fromRGB(255, 0, 0),
			audio = {name = "Fail1"}
		}
		
		UI.Open({name = "Store", props = {
			subject = "Gems",
			subject_callback = function()
				Purchases.PromptProduct(StatUtility.closestProduct("Gems", self._player_controller._data:Get({"stats", "Gems"}), self._info.price*3))
			end,
		}})
	elseif err == "space" then
		notiErr = {
			text = "You need more Inventory Space to buy this egg!",
			color = Color3.fromRGB(255, 0, 0),
			audio = {name = "Fail1"}
		}
	end
	
	if notiErr and s then
		Notifications:add(notiErr)
	end
	
	return success, err, notiErr
end

function Egg:_get_distance()
	local characterController = self._player_controller._character_controller
	
	if characterController and characterController._root then
		return (characterController._root.Position - self._instance.Egg:GetPivot().Position).Magnitude
	end
end

function Egg:Destroy()
	self._trove:Destroy()
end

return Egg