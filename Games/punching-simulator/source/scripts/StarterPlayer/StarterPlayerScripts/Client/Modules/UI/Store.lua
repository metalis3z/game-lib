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
local LuckPasses
local Purchases
local ScrollingFrameUtility

--> Constants

------------->
local Store = {
	name = script.Name
}

function Store:_init()
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
	LuckPasses = _L.Get {"Common", "Modules", "Databases", "LuckPasses"}
	LuckPassUtility = _L.Get {"Common", "Modules", "Utilities", "LuckPassUtility"}
	ScrollingFrameUtility = _L.Get {"Common", "Library", "Utilities", "ScrollingFrameUtility"}
	
	self.is_open = Tracker.new(false)
	self.subject_trove = Trove.new()
	self._final_canvas_position = Tracker.new(nil)
end

function Store:_start()
	self.object = _L.PlayerGui.Store
	
	self.is_open:Bind(function(value, props)
		if value then
			self:Open(props)
		else
			self:Close()
		end
	end)
	
	local eggIcon = self.object.Main.Middle.Exclusive.Dragon_Egg.Egg
	
	local jump = function()
		Services.TweenService:Create(eggIcon, TweenInfo.new(0.175, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Position = UDim2.fromScale(0.073, 0.4),
			--Rotation = -15
		}):Play()

		task.wait(0.175)

		Services.TweenService:Create(eggIcon, TweenInfo.new(0.175, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = UDim2.fromScale(0.073, 0.5),
			--Rotation = 15
		}):Play()

		task.wait(0.175)

		Services.TweenService:Create(eggIcon, TweenInfo.new(0.125, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = UDim2.fromScale(0.073, 0.4),
			--Rotation = -15
		}):Play()

		task.wait(0.125)

		Services.TweenService:Create(eggIcon, TweenInfo.new(0.075, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = UDim2.fromScale(0.073, 0.5),
			--Rotation = 0
		}):Play()
	end
	
	local i = 0
	
	Timer.Simple(1.5, function()
		i += 1
		
		if i%3 == 2 then
			jump()
		end
	end)
	
	local data = Data.Await()

	if data then
		self._instances = {}
		
		for _, boostInstance in pairs(self.object.Main.Middle.Potions.Left:GetChildren()) do
			if boostInstance:IsA("Frame") then
				local boostName = boostInstance.Name
				
				self._instances[boostName] = boostInstance
				
				boostInstance.UseBtn.MouseButton1Down:Connect(function()
					local success = Network.Remote.Invoke("S_Boosts_Use", boostName, 1)
					
					if success then
						Audio.Play({name = "Boost1"})
					end
				end)
			end
		end
		
		data:Bind("boosts", function(value)
			for boostName, boostInstance in pairs(self._instances) do
				local boostData = value[boostName]

				local boostQuantity = boostData.quantity

				boostInstance.UseBtn.TextLabel.Text = "USE ("..NumberUtility.short(boostQuantity)..")"
			end
		end)
		
		--local newTrove = Trove.new()

		--data:Bind("lucky_passes", function(value)
		--	newTrove:Clean()
			
		--	local v = LuckPassUtility.getBestInfo(data)
		--	local nextLuckPassInfo = if v then LuckPassUtility.getNextInfo(v.id) else LuckPassUtility.getInfo(1)
			
		--	for _, luckyPass in pairs(self.object.Main.Middle.Gamepasses.EggLuck:GetChildren()) do
		--		if luckyPass:IsA("Frame") and luckyPass:FindFirstChild("BuyBtn") then
		--			luckyPass.Lock.Visible = if nextLuckPassInfo then tonumber(luckyPass.Name) > nextLuckPassInfo.id else false
					
		--			newTrove:Add(luckyPass.BuyBtn.MouseButton1Down:Connect(function()
		--				if not v or v.id <= 2 then
		--					Purchases.PromptProduct(nextLuckPassInfo.name)
		--				end
		--			end))
		--		end
		--	end
		--end)
	end
	
	local backToTop = Tracker.new(false)
	
	backToTop:Bind(function(value)
		local backToTopInstance = self.object.Main.BackToTop
		
		if value then
			backToTopInstance.Visible = true

			Spr.Stop(backToTopInstance)

			backToTopInstance.Position = UDim2.fromScale(0.5, 0.125)

			Spr.Target(backToTopInstance, 1, 5, {
				Position = UDim2.fromScale(0.5, 0.09)
			})
		else
			backToTopInstance.Visible = false
		end
	end)
	
	Tracker.Subscribe({TrackerUtility.fromPropertySignal(self.object.Main.Middle, "CanvasPosition"), self._final_canvas_position}, function(value)
		local currentPosition = self.object.Main.Middle.CanvasPosition
		local finalPosition = self._final_canvas_position:Get()
		
		if finalPosition and finalPosition.Y == 0 then
			backToTop:Set(false)
		else
			backToTop:Set(currentPosition.Y ~= 0)
		end
	end)
	
	self.object.Main.BackToTop.MouseButton1Down:Connect(function()
		self:scroll({name = self.name, canvas_position = Vector2.new(0, 0)})
	end)
end

function Store:Open(props)
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
	
	self:scroll(props)
end

function Store:scroll(props)
	if props and (props.subject or props.canvas_position) then
		self.subject_trove:Clean()

		local finalCanvasPosition = props.canvas_position or ScrollingFrameUtility.getCanvasPositionY(self.object.Main.Middle, self.object.Main.Middle:FindFirstChild(props.subject))
		
		self._final_canvas_position:Set(finalCanvasPosition)
		
		local d = math.abs(finalCanvasPosition.Y - self.object.Main.Middle.CanvasPosition.Y)

		local newTween = Services.TweenService:Create(self.object.Main.Middle, TweenInfo.new(math.max((d / 1000) * 0.25, 0.5), Enum.EasingStyle.Quad), {
			CanvasPosition = finalCanvasPosition
		})

		self.object.Main.Middle.ScrollingEnabled = false

		task.spawn(function()
			local isCompleted = false

			self.subject_trove:Add(function()
				if not isCompleted then
					isCompleted = true
					self.object.Main.Middle.ScrollingEnabled = true
					self._final_canvas_position:Set(nil)
					newTween:Cancel()
				end
			end)

			newTween.Completed:Wait()

			if not isCompleted then
				isCompleted = true
				self.object.Main.Middle.ScrollingEnabled = true
				self._final_canvas_position:Set(nil)

				if props.subject_callback then
					props.subject_callback()
				end
			end
		end)

		newTween:Play()
	end
end

function Store:Close()
	self.object.Main.Visible = false
	
	Spr.Target(workspace.CurrentCamera, 0.7, 4, {
		FieldOfView = 70
	})

	Spr.Target(Services.Lighting.Blur, 0.7, 4, {
		Size = 0
	})
	
	self.subject_trove:Clean()
	
	self.object.Main.Middle.CanvasPosition = Vector2.new(0, 0)
end

return Store