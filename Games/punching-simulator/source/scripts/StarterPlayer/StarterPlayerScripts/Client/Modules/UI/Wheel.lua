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
local WheelRewardUtility
local Purchases

--> Constants

------------->
local Wheel = {
	name = script.Name
}

function Wheel:_init()
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
	WheelRewards = _L.Get {"Common", "Modules", "Databases", "WheelRewards"}
	PlayerRewardUtility = _L.Get {"Common", "Modules", "Utilities", "PlayerRewardUtility"}
	WheelRewardUtility = _L.Get {"Common", "Modules", "Utilities", "WheelRewardUtility"}
	
	self.is_open = Tracker.new(false)
	self.trove = Trove.new()
	self._is_spinning = Tracker.new(false)
end

function Wheel:_start()
	self.object = _L.PlayerGui.Wheel
	
	self.is_open:Bind(function(value, props)
		if value then
			self:Open()
		else
			self:Close()
		end
	end)
	
	local function spinBtn()
		if self._is_spinning:Get() then
			return
		end

		local success, err, spinReward, spinId = Network.Remote.Invoke("S_Wheel_Spin_Request")

		if success then
			self:_spin({reward = spinReward, id = spinId})
			return
		end
		
		if err == "notenough" then
			-- prompt
			-- noti
		end
	end
	
	self.object.Main.Background.SpinBtn.MouseButton1Down:Connect(spinBtn)
	self.object.Main.SpinBtn.MouseButton1Down:Connect(spinBtn)

	for _, wheelRewardInfo in pairs(WheelRewards) do
		local wheelRewardId = wheelRewardInfo.id
		
		local wheelRewardInstance = self.object.Main.Background.Inner:FindFirstChild(wheelRewardId)
		local playerRewardInfo = PlayerRewardUtility.getInfo(wheelRewardInfo.reward_name).getInfo(wheelRewardInfo.name)
		
		if playerRewardInfo and not wheelRewardInstance:GetAttribute("Skip") then
			wheelRewardInstance.ImageLabel.Image = playerRewardInfo.image
			wheelRewardInstance.Chance.Text = wheelRewardInfo.chance.."%"
		end
	end
	
	local data = Data.Await()
	
	if data then
		data:Bind({"stats", "Wheel_Spin"}, function(value)
			self:_render(data)
		end)
		
		Timer.Simple(0.5, function()
			self:_render(data)
		end)
		
		AttributeUtility.waitFor(_L.Player, "last_wheel_time")
		
		TrackerUtility.fromAttributeSignal(_L.Player, "last_wheel_time"):Bind(function(value)
			self:_render(data)
		end)
	end
	
	for _, v in pairs(self.object.Main.Products:GetChildren()) do
		v.MouseButton1Down:Connect(function()
			UI.Open({name = "Store", props = {
				subject = "WheelSpins",
				subject_callback = function()
					Purchases.PromptProduct(v.Name)
				end,
			}})
		end)
	end
end

function Wheel:_render(data)
	local currentWheelSpins = data:Get({"stats", "Wheel_Spin"})
	
	self.object.Main.SpinBtn.Quantity.Text = if currentWheelSpins <= 0 then "" else "x"..currentWheelSpins
	_L.PlayerGui.Main.Top.Wheel.Counter.Number.Text = "x"..currentWheelSpins
	
	local wheelTimeLeft
	
	if _L.Player:GetAttribute("last_wheel_time") then
		wheelTimeLeft = WheelRewardUtility.getTimeLeft(_L.Player)
	end
	
	if wheelTimeLeft then
		self.object.Main.SpinBtn.TextLabel.Text = "SPIN ".."("..NumberUtility.timer.colon.minutes(wheelTimeLeft)..")"
		
		if currentWheelSpins <= 0 then
			_L.PlayerGui.Main.Top.Wheel.Counter.Number.Text = NumberUtility.timer.colon.minutes(wheelTimeLeft)
		end
	else
		self.object.Main.SpinBtn.TextLabel.Text = "SPIN"
		_L.PlayerGui.Main.Top.Wheel.Counter.Number.Text = "x"..currentWheelSpins
	end
end

function Wheel:_spin(props)
	task.spawn(function()
		local spinReward = props.reward
		local spinId = props.id

		local wheelRewardId = spinReward.id

		local wheelRewardInfo = WheelRewardUtility.getInfo(wheelRewardId)

		self._is_spinning:Set(true)
		
		local offset = (8 - wheelRewardId + 1) * 45
		
		FastTween(self.object.Main.Background.Inner, {
			Rotation = (360 * 5) + offset
		}, {5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out}).Completed:Wait()
		
		self.object.Main.Background.Inner.Rotation = offset
		
		local success = Network.Remote.Invoke("S_Wheel_Spin_Confirm", spinId)
		
		if success then
			if UI._current:Get() ~= "Trade" then
				UI.Open({
					name = "Reward", 
					props = {
						data = {
							{
								reward_name = wheelRewardInfo.reward_name,
								name = wheelRewardInfo.name,
								value = wheelRewardInfo.value
							}
						}
					}
				})
			end
		end
		
		self._is_spinning:Set(false)
	end)
end

function Wheel:Open()
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

function Wheel:Close()
	self.object.Main.Visible = false
	
	
	Spr.Target(workspace.CurrentCamera, 0.7, 4, {
		FieldOfView = 70
	})
	
	Spr.Target(Services.Lighting.Blur, 0.7, 4, {
		Size = 0
	})
end

return Wheel