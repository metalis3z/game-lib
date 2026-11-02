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
local PlayerRewardUtility
local Module3D

--> Constants

------------->
local Eggs = {
	name = script.Name
}

function Eggs:_init()
	Services = _L.Get {"Common", "Library", "Services"}
	Network = _L.Get {"Common", "Library", "Network"}
	Signal = _L.Get {"Common", "Library", "Classes", "Signal"}
	Tracker = _L.Get {"Common", "Library", "Classes", "Tracker", "Tracker"}
	Timer = _L.Get {"Common", "Library", "Classes", "Timer"}
	Module3D = _L.Get {"Common", "Library", "Classes", "Module3D"}
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
	PlayerRewardUtility = _L.Get {"Common", "Modules", "Utilities", "PlayerRewardUtility"}
	Promise = _L.Get {"Common", "Library", "Classes", "Promise"}
	
	self.is_open = Tracker.new(false)
	self.trove = Trove.new()
	self.is_opening = Tracker.new(false)
end

function Eggs:_start()
	self.object = _L.PlayerGui.Eggs
	self._trove = Trove.new()
	
	self.is_open:Bind(function(value, props)
		if value and props then
			self:Open(props)
		else
			self:Close()
		end
	end)
	
	Network.Remote.Fired("C_Eggs_Open", function(props)
		UI.Open({name = self.name, props = props})
	end)
end

function Eggs:_reset()
	Spr.Stop(self.object.Main.Egg.UIScale)
	
	self.object.Main.Egg.UIScale.Scale = 0
	
	self.is_opening:Set(false)
	
	self._trove:Clean()
end

function Eggs:Open(props)
	local owns = false
	local purchases = _G.Purchases
	
	if purchases and purchases:OwnsGamepass("Fast_Hatch") then
		owns = true
	end
	
	self:_reset()
	
	self._trove:AddPromise(Promise.new(function(resolve)
		self.is_opening:Set(true)
		
		Spr.Target(self.object.Main.Egg.UIScale, 0.7, 2, {
			Scale = 0.65
		})

		local eggName = props.name
		local rewardData = props.reward_data

		local eggInstance = _L.Map.Eggs:FindFirstChild(eggName)

		if eggInstance then
			local newEggInstance = eggInstance.Egg:Clone()

			self._trove:Add(newEggInstance)

			local Model3D = Module3D:Attach3D(self.object.Main.Egg,newEggInstance)

			Model3D.LightColor = Color3.fromRGB(255, 255, 255)
			Model3D.Ambient = Color3.fromRGB(255, 255, 255)
			Model3D.LightDirection = Vector3.new(1, 1, 1)
			Model3D.CurrentCamera.FieldOfView = 5
			Model3D.Visible = true

			local x = 0

			local conn

			conn = Services.RunService.RenderStepped:Connect(function(dt)
				if x >= 3 * if owns then 0.5 else 1 then
					conn:Disconnect()

					Spr.Target(self.object.Main.Egg.UIScale, 0.7, 2, {
						Scale = 0.3
					})

					task.delay(0.1, function()
						Spr.Target(self.object.Main.Egg.UIScale, 0.7, 2, {
							Scale = 0.65
						})

						Spr.Target(_L.PlayerGui.Flash.Main, 0.7, 2, {
							BackgroundTransparency = 0
						})

						task.delay(0.4, function()
							Spr.Target(_L.PlayerGui.Flash.Main, 0.7, 2, {
								BackgroundTransparency = 1
							})
						end)

						task.delay(0.4, function()
							UI.Open({name = "Reward", props = {
								data = rewardData
							}})
						
							resolve()
						end)
					end)
				end

				Model3D:SetCFrame(CFrame.Angles(0, 0, (x + 1) * 0.25 * math.sin(math.sin(math.cos(x * (10 + x * 2))))))

				x += dt
			end)

			self._trove:Add(Model3D)
		end
	end)):finally(function()
		self:_reset()
	end)
end

function Eggs:Close()	
	--self:_reset()
end

return Eggs