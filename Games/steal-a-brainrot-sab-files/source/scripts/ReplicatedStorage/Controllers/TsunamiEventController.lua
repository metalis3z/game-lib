

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local ReplicatorClient = require(ReplicatedStorage.Packages.ReplicatorClient)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Gradients = require(ReplicatedStorage.Packages.Gradients)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Debounce = require(ReplicatedStorage.Packages.Debounce)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Spr = require(ReplicatedStorage.Packages.Spr)
local Net = require(ReplicatedStorage.Packages.Net)
local FastOverheadController = require(ReplicatedStorage.Controllers.FastOverheadController)
local ConfirmationController = require(ReplicatedStorage.Controllers.ConfirmationController)
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local CharacterController = require(ReplicatedStorage.Controllers.CharacterController)
local ShopController = require(ReplicatedStorage.Controllers.ShopController)
local TsunamiEventDebug = require(ReplicatedStorage.Shared.TsunamiEventDebug)
local TsunamiEventData = require(ReplicatedStorage.Shared.TsunamiEventData)
local Animals = require(ReplicatedStorage.Shared.Animals)
local Rarities = require(ReplicatedStorage.Datas.Rarities)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Animals_2 = require(ReplicatedStorage.Datas.Animals)
local Mutations = require(ReplicatedStorage.Datas.Mutations)
local Traits = require(ReplicatedStorage.Datas.Traits)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local MathUtils = require(ReplicatedStorage.Utils.MathUtils)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)

local tsunamiEventServiceBuySpeedUpgrade = Net:RemoteEvent("TsunamiEventService/BuySpeedUpgrade")
local tsunamiEventServiceToggleSlowmode = Net:RemoteEvent("TsunamiEventService/ToggleSlowmode")
local tsunamiEventServiceTeleport = Net:RemoteEvent("TsunamiEventService/Teleport")
local tsunamiEventServiceDrop = Net:RemoteEvent("TsunamiEventService/Drop")
local tsunamiEventServiceGrab = Net:RemoteEvent("TsunamiEventService/Grab")
local tsunamiEventServiceKill = Net:RemoteEvent("TsunamiEventService/Kill")
local shopServicePurchase = Net:RemoteEvent("ShopService/Purchase")

local LocalPlayer = Players.LocalPlayer

local RightBottom = LocalPlayer.PlayerGui:WaitForChild("RightBottom").Slowmode
local TsunamiSpeedUpgrade = LocalPlayer.PlayerGui:WaitForChild("TsunamiSpeedUpgrade").TsunamiSpeedUpgrade

local data = {}

local registerResult = nil

data.StartWaves = function(_)

	local tryIndexObj = ReplicatorClient.get("TsunamiEvent/Waves")
	local folder = Instance.new("Folder")
	folder.Name = "Waves"
	folder.Parent = workspace
	local data_2 = {}

	local function _(val10)

		local data_2Data = data_2[val10]
		if data_2Data then
			data_2Data.model:Destroy()
			data_2[val10] = nil
		end
	end

	local function reconcileWaves()

		local connections_3 = tryIndexObj:TryIndex({
			"waves"
		})
		if not connections_3 then
			return
		else
			local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow()
			for v49EntryId, v49Entry in connections_3 do
				if not data_2[v49EntryId] then
					local part1 = ReplicatedStorage.Models.TsunamiWaves[v49Entry.name]:Clone()
					part1.Name = v49EntryId
					part1:PivotTo(TsunamiEventData.getWavePositionAtTime(v49Entry, l_workspace_ServerTimeNow_0))
					local l_v53_FirstChild_0 = part1:FindFirstChild("WavesLoop", true)
					if l_v53_FirstChild_0 then
						l_v53_FirstChild_0.Looped = true
						l_v53_FirstChild_0:Play()
					end
					local pivot = part1.Main.CFrame:Inverse() * part1:GetPivot()
					local motor6D = Instance.new("Motor6D")
					motor6D.Part0 = workspace.Terrain
					motor6D.Part1 = part1.Main
					motor6D.C1 = pivot
					motor6D.Parent = part1.Main
					part1.Main.Anchored = false
					part1.Parent = folder
					data_2[v49EntryId] = {
						model = part1,
						motor = motor6D
					}
				end
			end

			for val11 in data_2 do
				if not connections_3[val11] then
					local data_2Data_2 = data_2[val11]
					if data_2Data_2 then
						data_2Data_2.model:Destroy()
						data_2[val11] = nil
					end
				end
			end
			return
		end
	end
	local val12 = 0
	RunService.PostSimulation:Connect(function(_)

		local connections_4 = tryIndexObj:TryIndex({
			"waves"
		})
		if not connections_4 then
			return
		else
			TsunamiEventDebug.clear()
			debug.profilebegin("updateWaves")
			local l_workspace_ServerTimeNow_1 = workspace:GetServerTimeNow()
			local data_3 = {}
			local data_4 = {}
			for v45EntryId, v45Entry in data_2 do
				local v62Data = connections_4[v45EntryId]
				if v62Data then
					if v62Data.despawnsAt <= l_workspace_ServerTimeNow_1 then
						local data_2Data_3 = data_2[v45EntryId]
						if data_2Data_3 then
							data_2Data_3.model:Destroy()
							data_2[v45EntryId] = nil
						end
					else
						local transform = TsunamiEventData.getWavePositionAtTime(v62Data, l_workspace_ServerTimeNow_1)
						local Transform = v45Entry.motor.Transform
						if Transform == CFrame.identity then
							Transform = transform
						end
						data_3[v45EntryId] = Transform
						data_4[v45EntryId] = transform
						v45Entry.motor.Transform = transform
					end
				end
			end
			debug.profileend()
			debug.profilebegin("playerKill")
			local l_v17_Character_0, ref7 = CharacterController:GetCharacter(LocalPlayer)
			if not l_v17_Character_0 or not ref7 or ref7.Health <= 0 then
				debug.profileend()
				return
			else
				local pivot_2 = l_v17_Character_0:GetPivot().Position
				local ref8 = RaycastParams.new()
				ref8.FilterType = Enum.RaycastFilterType.Include
				ref8.FilterDescendantsInstances = {
					(l_v17_Character_0:FindFirstChild("HumanoidRootPart"))
				}
				TsunamiEventDebug.drawHitbox(pivot_2)
				for v62EntryId, v62Entry in connections_4 do
					if v62Entry.despawnsAt > l_workspace_ServerTimeNow_1 and l_workspace_ServerTimeNow_1 - val12 > 1 then
						local data_2Data_4 = data_2[v62EntryId]
						if data_2Data_4 then
							local data_3Data = data_3[v62EntryId]
							local data_4Data = data_4[v62EntryId]
							if (data_4Data.Position - pivot_2).Magnitude < 300 then
								local extentsSize = data_2Data_4.model:GetExtentsSize()
								data_3Data = data_3Data + Vector3.new(0, extentsSize.Y * 0.5, -extentsSize.Z * 0.5)
								data_4Data = data_4Data + Vector3.new(0, extentsSize.Y * 0.5, -extentsSize.Z * 0.5)
								local val13, val14 = MathUtils.getSweptAABB(data_3Data.Position, data_4Data.Position, extentsSize)
								local val15 = CFrame.new(val13) * data_4Data.Rotation
								TsunamiEventDebug.drawTsunami(val15, val14)
								if MathUtils.isPointInVolume(pivot_2, val15, val14) then
									val12 = l_workspace_ServerTimeNow_1
									tsunamiEventServiceKill:FireServer()
								end
							end
						end
					end
				end
				debug.profileend()
				return
			end
		end
	end)
	tryIndexObj:Observe({
		"waves"
	}, reconcileWaves)
	task.spawn(reconcileWaves)
end

data.StartSpeedHandling = function(_)

	local getObj_2 = Synchronizer:Wait(LocalPlayer)
	if not getObj_2 then
		return
	else

		local function updateSlowmode()

			local attribute = LocalPlayer:GetAttribute("TsunamiSlowmode")
			RightBottom.Function.Text = attribute and "ON" or "OFF"
			RightBottom.Image = attribute and "rbxassetid://137163242046829" or "rbxassetid://117563252724415"
		end
		LocalPlayer:GetAttributeChangedSignal("TsunamiSlowmode"):Connect(updateSlowmode)
		local attribute_2 = LocalPlayer:GetAttribute("TsunamiSlowmode")
		RightBottom.Function.Text = attribute_2 and "ON" or "OFF"
		RightBottom.Image = attribute_2 and "rbxassetid://137163242046829" or "rbxassetid://117563252724415"
		RightBottom.Visible = true
		RightBottom.Activated:Connect(function()

			tsunamiEventServiceToggleSlowmode:FireServer()
		end)
		attribute_2 = {}
		for upgradeId, upgrade in TsunamiEventData.upgrades do
			local ref9 = TsunamiSpeedUpgrade.Content.List.Template:Clone()
			ref9.Name = tostring(upgradeId)
			ref9.LayoutOrder = upgradeId
			ref9.Frame.Label.Text = ("+%* Speed"):format(upgrade)
			ref9.Frame.Tip.Text = ("+%*"):format(upgrade)
			ref9.Visible = true
			ref9.Parent = TsunamiSpeedUpgrade.Content.List
			attribute_2[upgradeId] = ref9
			local animateObj = AnimatedButton.new(ref9.Frame.Buy)
			animateObj:Animate()
			animateObj.OnActivated:Connect(function()

				tsunamiEventServiceBuySpeedUpgrade:FireServer(upgradeId)
			end)
			local tsunamiEventDataData = TsunamiEventData.products[upgrade]
			local animateObj_2 = AnimatedButton.new(ref9.Frame.BuyRobux)
			ShopController:BindLabelToProductPrice(ref9.Frame.BuyRobux.Price, tsunamiEventDataData, "Product")
			animateObj_2:Animate()
			animateObj_2.OnActivated:Connect(function()

				shopServicePurchase:FireServer(tsunamiEventDataData)
			end)
		end

		local function updateSpeedUpgrades()

			local val16 = getObj_2:Get({
				"TsunamiEvent",
				"SpeedUpgrades"
			})
			for upgradeId_2, upgrade_2 in TsunamiEventData.upgrades do
				local attribute_2Data = attribute_2[upgradeId_2]
				local flag_2 = TsunamiEventData.getUpgradeCost(val16, upgrade_2)
				attribute_2Data.Frame.Buy.Price.Text = ("Buy ($%*)"):format((NumberUtils:ToString(flag_2)))
				attribute_2Data.Frame.PreviousAmount.Text = NumberUtils:Comma(TsunamiEventData.getTotalSpeed(val16))
				attribute_2Data.Frame.TargetAmount.Text = NumberUtils:Comma(TsunamiEventData.getTotalSpeed(val16 + upgrade_2))
				Spr.target(attribute_2Data.Frame.Buy, 1, 5, {
					BackgroundColor3 = if flag_2 <= getObj_2:Get("Coins") then Color3.fromRGB(81, 158, 86) else Color3.fromRGB(158, 158, 158)
				})
			end
		end
		getObj_2:OnChanged({
			"TsunamiEvent",
			"SpeedUpgrades"
		}, updateSpeedUpgrades)
		getObj_2:OnChanged("Coins", updateSpeedUpgrades)
		task.spawn(updateSpeedUpgrades)
		return
	end
end

data.StartVIPAreas = function(_)

	local getObj = Synchronizer:Wait(LocalPlayer)
	if not getObj then
		return
	else
		local val1 = nil

		local function updateVIPAreas()

			if typeof(val1) == "function" then
				val1()
				val1 = nil
			end
			local flag_3 = getObj:Get("Gamepass.VIP") == true
			val1 = Observers.observeTag("VIPAreas", function(touchedObj)

				touchedObj.CanCollide = not flag_3
				touchedObj.CanTouch = not flag_3
				local connectResult = nil
				if not flag_3 then
					connectResult = touchedObj.Touched:Connect(function(ref1)

						if Players:GetPlayerFromCharacter(ref1.Parent) == LocalPlayer and not Debounce("VIPAreaTouch", 1) then
							shopServicePurchase:FireServer(1229510262)
						end
					end)
				end

				return function()

					touchedObj.CanCollide = true
					touchedObj.CanTouch = true
					connectResult:Disconnect()
				end
			end)
		end
		getObj:OnChanged("Gamepass.VIP", updateVIPAreas)
		getObj:OnDictionaryInserted("Gamepass", updateVIPAreas)
		task.spawn(updateVIPAreas)
		return
	end
end

local data_5 = {}

data.StartBrainrotRendering = function(_)

	local listenObj = ReplicatorClient.get("TsunamiEvent/Brainrots")
	listenObj:WaitForLoaded()
	local ToolsFrames = LocalPlayer.PlayerGui:WaitForChild("ToolsFrames").Drop

	local function getDropButtonVisibility()

		local connections = listenObj:TryIndex({
			"brainrots"
		})
		if not connections then

			return false
		else
			for _, v114Entry in connections do
				if v114Entry.grabbed == LocalPlayer.UserId then

					return true
				end
			end

			return false
		end
	end

	local function _()

		ToolsFrames.Visible = getDropButtonVisibility()
	end

	local function _(val2)

		local data_5Data = data_5[val2]
		if data_5Data then
			data_5Data.trove:Destroy()
			data_5[val2] = nil
		end
	end

	local function renderBrainrot(val3)

		if data_5[val3] then
			return
		else
			local val4 = listenObj:Path({
				"brainrots",
				val3
			})
			local addObj = Trove.new()
			local subCollector = addObj:Extend()
			local subCollector_2 = addObj:Extend()
			data_5[val3] = {
				trove = addObj,
				model = nil
			}

			local function updateBrainrotModel()

				subCollector:Destroy()
				local textLabelText = listenObj:TryIndex(val4())
				if not textLabelText then
					return
				else
					local l_v21_AnimatedModel_0 = Animals:GetAnimatedModel(textLabelText.brainrot, "Idle")
					assert(l_v21_AnimatedModel_0)
					subCollector:Add(l_v21_AnimatedModel_0)
					data_5[val3].model = l_v21_AnimatedModel_0
					subCollector:Add(function()

						if data_5[val3] then
							data_5[val3].model = nil
						end
					end)
					assert(l_v21_AnimatedModel_0.PrimaryPart, (("%* has no PrimaryPart"):format(textLabelText)))
					local animals_2Data = Animals_2[textLabelText.brainrot]
					local rarityData = Rarities[animals_2Data.Rarity]

					local function updateCFrame()

						if textLabelText.grabbed then
							l_v21_AnimatedModel_0:PivotTo(CFrame.new(10000, 10000, 10000))
							return
						else
							l_v21_AnimatedModel_0:PivotTo(textLabelText.cframe)
							return
						end
					end
					subCollector:Add(listenObj:Listen(val4("cframe"), updateCFrame))
					subCollector:Add(listenObj:Listen(val4("grabbed"), updateCFrame))
					subCollector:Add(task.defer(updateCFrame))
					l_v21_AnimatedModel_0.PrimaryPart.Anchored = true

					local function updateTag()

						subCollector_2:Clean()
						local flag_4 = listenObj:TryIndex(val4({
							"grabbed"
						}))
						if flag_4 then
							return
						elseif not listenObj:TryIndex(val4({
							"tag"
							})) then
							return
						else
							local ref2 = subCollector_2:Clone(script.BillboardGui)
							ref2.TextLabel.Text = textLabelText.brainrot
							if flag_4 then
								subCollector_2:Add(Observers.observeTag("Held_" .. flag_4, function(adornee)

									ref2.Adornee = adornee

									return function()

										if ref2.Adornee == adornee then
											ref2.Adornee = nil
										end
									end
								end))
							else
								ref2.Adornee = l_v21_AnimatedModel_0.PrimaryPart
							end
							ref2.Parent = LocalPlayer.PlayerGui
							return
						end
					end

					if textLabelText.mutation then
						Animals:ApplyMutation(l_v21_AnimatedModel_0, textLabelText.brainrot, textLabelText.mutation)
					end

					if textLabelText.traits then
						Animals:ApplyTraits(l_v21_AnimatedModel_0, textLabelText.brainrot, textLabelText.traits)
					end
					local oVERHEADATTACHMENT = l_v21_AnimatedModel_0:FindFirstChild("OVERHEAD_ATTACHMENT", true)
					if not oVERHEADATTACHMENT then
						local attachment = Instance.new("Attachment")
						local extentsSize_2 = l_v21_AnimatedModel_0:GetExtentsSize()
						attachment.CFrame = CFrame.new(0, extentsSize_2.Y * 0.5, 0)
						attachment.Parent = l_v21_AnimatedModel_0.PrimaryPart
						oVERHEADATTACHMENT = attachment
					end
					local ref3, handle = FastOverheadController.createFastOverhead({
						adornee = oVERHEADATTACHMENT,
						guiTemplate = FastOverheadController.GuiTemplates.AnimalOverhead
					})
					subCollector:Add(handle)
					subCollector:Add(listenObj:Observe(val4({
						"tag"
					}), updateTag))
					subCollector:Add(listenObj:Observe(val4({
						"grabbed"
					}), updateTag))
					local Generation = ref3.Generation
					local Stolen = ref3.Stolen
					Stolen.Visible = true
					Stolen.LayoutOrder = -1
					Stolen.Size = UDim2.fromScale(1, 0.25)

					local function updateOverhead()

						Generation.Text = ("$%*/s"):format((NumberUtils:ToString(Animals:GetGeneration(textLabelText.brainrot, textLabelText.mutation, textLabelText.traits, nil))))
						Stolen.Text = ("%*s"):format(textLabelText.timer)
					end
					ref3.DisplayName.Text = animals_2Data.DisplayName
					ref3.Price.Text = ("$%*"):format((NumberUtils:ToString(Animals:GetPrice(textLabelText.brainrot))))
					ref3.Rarity.Text = animals_2Data.Rarity
					ref3.Rarity.TextColor3 = Rarities[animals_2Data.Rarity].Color
					if textLabelText.mutation then
						local mutationData = Mutations[textLabelText.mutation]
						ref3.Mutation.Text = mutationData.DisplayText
						if mutationData.GradientPreset then
							subCollector:Add(Gradients.apply(ref3.Mutation, mutationData.GradientPreset))
						else
							ref3.Mutation.TextColor3 = mutationData.MainColor
						end
					end

					if textLabelText.traits then
						local Template = ref3.Traits.Template
						for _, trait in textLabelText.traits do
							local traitData = Traits[trait]
							if traitData then
								local ref4 = Template:Clone()
								ref4.Parent = Template.Parent
								ref4.Image = traitData.Icon
								ref4.Visible = true
							end
						end
						ref3.Traits.Visible = true
					end
					task.spawn(updateOverhead)
					subCollector:Add(Timer.Simple(1, updateOverhead))
					subCollector:Add(listenObj:Listen(val4("timer"), updateOverhead))
					ref3.Mutation.Visible = textLabelText.mutation ~= nil
					if Rarities[animals_2Data.Rarity].StrokeColor then
						ref3.Rarity.UIStroke.Color = Rarities[animals_2Data.Rarity].StrokeColor
					end

					if rarityData.GradientPreset then
						subCollector:Add(Gradients.apply(ref3.Rarity, rarityData.GradientPreset))
					end
					ref3.Parent = oVERHEADATTACHMENT
					local proximityPrompt = subCollector:Add(Instance.new("ProximityPrompt"))
					proximityPrompt.ActionText = "Grab"
					proximityPrompt.ObjectText = textLabelText.brainrot
					proximityPrompt.HoldDuration = 2
					proximityPrompt.RequiresLineOfSight = false
					proximityPrompt.MaxActivationDistance = 10
					proximityPrompt.Parent = l_v21_AnimatedModel_0.PrimaryPart
					subCollector:Add(proximityPrompt.Triggered:Connect(function(ref5)

						if not ref5.Character then
							return
						else
							tsunamiEventServiceGrab:FireServer(val3)
							return
						end
					end))
					return
				end
			end
			addObj:Add(listenObj:Listen(val4("mutation"), function()

				updateBrainrotModel()
			end))
			addObj:Add(listenObj:Listen(val4("traits"), function()

				updateBrainrotModel()
			end))
			addObj:Add(task.spawn(updateBrainrotModel))

			return addObj
		end
	end
	listenObj:Observe({
		"brainrots"
	}, function(connections_2, flag_5)

		ToolsFrames.Visible = getDropButtonVisibility()
		if connections_2 == nil then
			for val5 in data_5 do
				local data_5Data_2 = data_5[val5]
				if data_5Data_2 then
					data_5Data_2.trove:Destroy()
					data_5[val5] = nil
				end
			end
			return
		else
			for val6 in connections_2 do
				if not data_5[val6] then
					renderBrainrot(val6)
				end
			end

			if flag_5 ~= nil then
				for val7 in data_5 do
					if not connections_2[val7] then
						local data_5Data_3 = data_5[val7]
						if data_5Data_3 then
							data_5Data_3.trove:Destroy()
							data_5[val7] = nil
						end
					end
				end
			end
			return
		end
	end)
	ToolsFrames.Activate.Activated:Connect(function()

		tsunamiEventServiceDrop:FireServer()
	end)
end

data.GetBrainrot = function(_, val8)

	return ReplicatorClient.get("TsunamiEvent/Brainrots"):TryIndex({
		"brainrots",
		val8
	})
end

data.GetBrainrotCFrame = function(_, val9, flag_6)

	local l_v40_Brainrot_0 = data:GetBrainrot(val9)
	if not l_v40_Brainrot_0 then

		return nil, nil
	elseif not data_5[val9] then

		return nil, nil
	else
		local flag = data_5[val9].model
		if not flag then

			return nil, nil
		elseif not flag_6 then
			local tags = l_v40_Brainrot_0.grabbed and CollectionService:GetTags((("Held_%*"):format(l_v40_Brainrot_0.grabbed)))[1]
			if not tags then

				return l_v40_Brainrot_0.cframe, flag
			else
				local _unused = nil

				return (if tags.PrimaryPart then tags.PrimaryPart.CFrame else tags:GetPivot()) + Vector3.new(0, tags:GetExtentsSize().Y * 0.5, 0), flag
			end
		else

			return l_v40_Brainrot_0.cframe, flag
		end
	end
end

data.StartNormalServer = function(_)

	RightBottom.Visible = false
	Observers.observeTag("TsunamiLTMMachine", function(ref6)

		local addObj_2 = Trove.new()
		addObj_2:Add(ref6.Prompt.ProximityPrompt.Triggered:Connect(function()

			if ConfirmationController:IsInPrompt() then
				return
			elseif not ConfirmationController:Show("Are you sure you want to join the <font color=\"rgb(255, 53, 56)\">Escape Tsunami LTM</font>?", 300, "JoinCancel") then
				return
			else
				tsunamiEventServiceTeleport:FireServer()
				return
			end
		end))
		local Arcadopus = ReplicatedStorage.Animations.Animals:FindFirstChild("Arcadopus")
		if Arcadopus then
			local tweenObj = ref6.Arcadopus.AnimationController.Animator:LoadAnimation(Arcadopus.Idle)
			tweenObj.Looped = true
			tweenObj:Play()
		end

		return addObj_2:WrapClean()
	end)
end

data.Start = function(_)

	if not ServerData.IsTsunamiServer() then
		data:StartNormalServer()
		return
	else
		registerResult = InterfaceController:Register("TsunamiSpeedUpgrade", TsunamiSpeedUpgrade, "TopQuint")
		registerResult:AttachCloseButton(TsunamiSpeedUpgrade.Header.Close)
		registerResult:Close()
		if not Synchronizer:Wait(LocalPlayer) then
			return
		else
			task.spawn(data.StartSpeedHandling, data)
			task.spawn(data.StartVIPAreas, data)
			task.spawn(data.StartWaves, data)
			task.spawn(data.StartBrainrotRendering, data)
			return
		end
	end
end

return data
