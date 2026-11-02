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
local Notifications
local Confirm
local TradeUtility

--> Constants

------------->
local Trade = {
	name = script.Name
}

function Trade:_init()
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
	TradeUtility = _L.Get {"Common", "Modules", "Utilities", "TradeUtility"}
	PetUtility = _L.Get {"Common", "Modules", "Utilities", "PetUtility"}
	PetRarities = _L.Get {"Common", "Modules", "Databases", "Pets", "Rarities"}
	PetRarityUtility = _L.Get {"Common", "Modules", "Utilities", "PetRarityUtility"}
	Rainbow = _L.Get {"Client", "Modules", "Classes", "Rainbow"}
	self.is_open = Tracker.new(false)
	self.trove = Trove.new()
end

function Trade:_start()
	Notifications = UI.Get("Notifications")
	Confirm = UI.Get("Confirm")
	
	self._you_instances = {}
	self._other_instances = {}
	
	self.object = _L.PlayerGui.Trade
	
	self.is_open:Bind(function(value, props)
		if value then
			self:Open(props)
		else
			self:Close()
		end
	end)
	
	local data = Data.Await()

	if data then
		Rainbow.new({
			speed = 3,
			callback = function(value)
				for _, v in pairs(self._you_instances) do
					local petData = PetUtility.getData(data, v.uid)
					if petData then
						v.instance.Icon.ImageColor3 = if petData.tier == "Rainbow" then value else Color3.fromRGB(255, 255, 255)
					end
				end
				
				for _, v in pairs(self._other_instances) do
					local petData = PetUtility.getData(v.data, v.uid)
					if petData then
						v.instance.Icon.ImageColor3 = if petData.tier == "Rainbow" then value else Color3.fromRGB(255, 255, 255)
					end
				end
			end,
		})
		
		local function update()
			local value = data:Get("pets")
			
			for _, v in pairs(self._you_instances) do
				local petUid = v.uid
				local petData = PetUtility.getData(data, petUid)

				if not petData then
					local i, _ = TableUtility.match(self._you_instances, function(i, v)
						return v.uid == petUid
					end)

					if i then
						table.remove(self._you_instances, i)
					end

					v.trove:Destroy()
				end
			end

			for _, petData in pairs(value) do
				local petUid = petData.uid

				local _, v = TableUtility.match(self._you_instances, function(i, v)
					return v.uid == petUid
				end)

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

					petInstance.Pet.Text = petInfo.display_name or petInfo.name
					petInstance.Icon.Image = petImage

					newTrove:Add(petInstance)

					petInstance.MouseButton1Down:Connect(function()
						Network.Remote.Fire("S_Trade_Toggle_Add", petUid)
					end)

					petInstance.Equip.Visible = false
					petInstance.Delete.Visible = false

					petInstance.Parent = self.object.Main.You.MainList

					table.insert(self._you_instances, {
						name = petName,
						info = petInfo,
						rarity_info = PetRarityUtility.getInfo(petInfo.rarity),
						trove = newTrove,
						instance = petInstance,
						uid = petUid
					})
				end
			end

			local mega = {}

			for i = #PetRarities, 1, -1 do
				local rarityInfo = PetRarities[i]

				local mini = ArrayUtility.filter(self._you_instances, function(i, v)
					return v.rarity_info.name == rarityInfo.name
				end)

				table.sort(mini, function(a, b)
					return (PetUtility.getBoost(data, a.uid) or 0) > (PetUtility.getBoost(data, b.uid) or 0)
				end)

				for _, v in pairs(mini) do
					table.insert(mega, v)
				end
			end

			for i, v in pairs(mega) do
				v.instance.LayoutOrder = i
			end
		end
		
		data:Bind("pets", function(value)
			update()
		end)
		
		Timer.Simple(0.5, update)
	end
	
	Network.Remote.Fired("C_Trade_Request_Send", function(tradeRequest)
		local tradeRequestPlayer = tradeRequest.player
		local tradeRequestUid = tradeRequest.uid
		
		UI.Open({
			name = "Confirm",
			props = {
				ignore_last = true,
				text = tradeRequestPlayer.Name.." sent you a trade request. Would you like to accept it?",

				yes = function()
					local success, err = Network.Remote.Invoke("S_Trade_Request_Decide", tradeRequestUid, true)
					if not success then
						Notifications:add({
							text = if err == "disabled" then "Player has trade requests disabled." elseif err == "trading" then "This player is already trading." else "An error occured, please try again.",
							duration = 1
						})
					end
				end,

				no = function()
					local success, err = Network.Remote.Invoke("S_Trade_Request_Decide", tradeRequestUid, false)
					if not success then
						Notifications:add({
							text = if err == "disabled" then "Player has trade requests disabled." elseif err == "trading" then "This player is already trading." else "An error occured, please try again.",
							duration = 1
						})
					end
					
				end,
			}
		})
	end)
	
	self.object.Main.You.Actions.CancelBtn.MouseButton1Down:Connect(function()
		Network.Remote.Fire("S_Trade_Cancel")
	end)

	self.object.Main.You.Actions.ReadyBtn.MouseButton1Down:Connect(function()
		Network.Remote.Fire("S_Trade_Ready_Toggle")
	end)
	
	Network.Remote.Fired("C_Trade_Completed", function()
		Notifications:add({text = "✅ Trade completed!", color = Color3.fromRGB(0, 255, 0), audio = {name = "TradeCompleted1"}})
	end)
	
	task.spawn(function()
		AttributeUtility.waitFor(_L.Player, "trade")

		local trade = {tracker = TrackerUtility.fromAttributeSignal(_L.Player, "trade"), trove = Trove.new()}

		trade.tracker:Bind(function(value)
			trade.trove:Clean()
			
			for petInstance, v in pairs(self._other_instances) do
				v.trove:Destroy()
			end

			table.clear(self._other_instances)
			
			self.object.Main.You.Ready.Visible = false
			self.object.Main.Other.Ready.Visible = false

			if value then
				UI.Open({
					name = self.name,
					props = {
						uid = value
					}
				})

				trade.trove:Add(task.spawn(function()
					local tradeHolder = _L.Debris.Trades:WaitForChild(value)
					
					trade.trove:Add(task.spawn(function()
						AttributeUtility.waitFor(tradeHolder, "state")
						
						--local stateTracker = TrackerUtility.fromAttributeSignal(tradeHolder, "state")
						
						--trade.trove:Add(stateTracker:Bind(function(value)
						--	local lastStateValue = stateTracker:GetLast()
							
						--	local stateValue = value.value
						--	local stateProps = value.props
							
						--	if stateValue == "Processing" then
						--		self.object.Main.Top.Processing.Visible = true
						--	else
						--		self.object.Main.Top.Processing.Visible = false
						--	end
						--end))
					end))
					
					trade.trove:Add(task.spawn(function()
						AttributeUtility.waitFor(tradeHolder, "traders")

						trade.trove:Add(TrackerUtility.fromAttributeSignal(tradeHolder, "traders"):Bind(function(value)
							for _, trader in pairs(value) do
								local player = Services.Players:GetPlayerByUserId(trader.user_id)
								
								if player == _L.Player then
									self.object.Main.You.Ready.Visible = trader.ready
									
									for _, v in pairs(self._you_instances) do
										v.instance.Delete.Visible = table.find(trader.pets, v.uid) ~= nil
									end
								else
									local otherData = Data.Await(player, true)
									
									self.object.Main.Other.Ready.Visible = trader.ready
									self.object.Main.Other.Title.Text = "@"..player.Name
									
									if otherData then
										for petInstance, v in pairs(self._other_instances) do
											local petUid = v.uid
											local petData = PetUtility.getData(otherData, petUid)

											if not petData or table.find(trader.pets, v.uid) == nil then
												local i, v = TableUtility.match(self._other_instances, function(i, v)
													return v.uid == petUid
												end)

												if i then
													table.remove(self._other_instances, i)
												end
												
												if v then
													v.trove:Destroy()
												end
											end
										end

										for _, petData in pairs(otherData:Get("pets")) do
											local petUid = petData.uid

											local _, v = TableUtility.match(self._other_instances, function(i, v)
												return v.uid == petUid
											end)

											local petInstance = if v then v.instance else nil

											if not v and table.find(trader.pets, petUid) ~= nil then
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

												petInstance.Pet.Text = petInfo.display_name or petInfo.name
												petInstance.Icon.Image = petImage

												newTrove:Add(petInstance)

												petInstance.Equip.Visible = false
												petInstance.Delete.Visible = false
												
												petInstance.Parent = self.object.Main.Other.MainList

												table.insert(self._other_instances, {
													name = petName,
													info = petInfo,
													rarity_info = PetRarityUtility.getInfo(petInfo.rarity),
													trove = newTrove,
													instance = petInstance,
													uid = petUid,
													data = otherData
												})
											end
										end

										local mega = {}

										for i = #PetRarities, 1, -1 do
											local rarityInfo = PetRarities[i]

											local mini = ArrayUtility.filter(self._other_instances, function(i, v)
												return v.rarity_info.name == rarityInfo.name
											end)

											table.sort(mini, function(a, b)
												return (PetUtility.getBoost(data, a.uid) or 0) > (PetUtility.getBoost(data, b.uid) or 0)
											end)

											for _, v in pairs(mini) do
												table.insert(mega, v)
											end
										end

										for i, v in pairs(mega) do
											v.instance.LayoutOrder = i
										end
									end
								end
							end
						end))
					end))
				end))
			else
				UI.Close({name = self.name})
			end
		end)
	end)
end

function Trade:Open(props)
	local tradeUid = props.uid
	
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

function Trade:Close()
	Network.Remote.Fire("S_Trade_Cancel")
	
	self.object.Main.Visible = false
	
	Spr.Target(workspace.CurrentCamera, 0.7, 4, {
		FieldOfView = 70
	})

	Spr.Target(Services.Lighting.Blur, 0.7, 4, {
		Size = 0
	})
end

return Trade