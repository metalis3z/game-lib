local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local EventTypes = require(ReplicatedStorage.Shared.EventTypes)

local data = {}

local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local Observers = require(ReplicatedStorage.Packages.Observers)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local MathUtils = require(ReplicatedStorage.Utils.MathUtils)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)
local Snapshot = require(ReplicatedStorage.Shared.Snapshot)

local Name = script.Name

local eventServiceWaterBurst = Net:RemoteEvent("EventService/Water/Burst")

local managedObj = Trove.new()

local data_2 = {}

local function initActivationVisual()

	local subCollector = managedObj:Extend()
	local connections = table.create(4)
	subCollector:Add(function()

		table.clear(connections)
	end)
	local val1 = 0
	subCollector:Add(RunService.PreRender:Connect(function(val2)

		debug.profilebegin("Water Event")
		val1 = val1 + val2
		for v27EntryId, v27Entry in connections do
			if v27Entry.target and v27Entry.targetAttachment then
				v27Entry.beam.First.Enabled = true
				v27Entry.beam.Second.Enabled = true
				local val3 = math.clamp(val1 - v27EntryId + 1, 0, 1)
				local WorldPosition = v27Entry.beam.WorldPosition
				v27Entry.targetAttachment.Position = WorldPosition + (v27Entry.target:GetPivot().Position - WorldPosition) * val3
			end
		end
		debug.profileend()
	end))
	subCollector:Add(Observers.observeTag("WaterPlayerVFX", function(parent)

		local position = script.PlayerVFX.Beam:Clone()
		position.Parent = parent
		local managedObj_2 = script.PlayerVFX.Torso:Clone()
		managedObj_2.Parent = parent
		local l_v34_Attribute_0 = parent:GetAttribute("WaterIndex")
		connections[l_v34_Attribute_0] = {
			beam = position,
			target = nil
		}
		local val4 = Observers.observeTag("WaterPlayerVFX", function(getAttributeObj)

			if getAttributeObj == parent then

				return nil
			elseif getAttributeObj:GetAttribute("WaterIndex") ~= parent:GetAttribute("WaterIndex") % 4 + 1 then

				return nil
			else
				local attachment = Instance.new("Attachment")
				attachment.Position = position.WorldPosition
				attachment.Parent = workspace.Terrain
				local attribute = connections[parent:GetAttribute("WaterIndex")]
				attribute.target = getAttributeObj
				attribute.beam.First.Attachment0 = attachment
				attribute.beam.Second.Attachment0 = attachment
				attribute.targetAttachment = attachment

				return function()

					attachment:Destroy()
				end
			end
		end)

		return function()

			managedObj_2:Destroy()
			position:Destroy()
			val4()
			connections[l_v34_Attribute_0] = nil
		end
	end))
end

local function createSharks()

	local data_3 = {}
	managedObj:Add(Observers.observeTag("WaterShark", function(parent_2)

		local attribute_2 = parent_2:GetAttribute("SharkType") or "Orcalero Orcala"
		local scriptData = script[attribute_2]
		local managedObj_3 = scriptData:Clone()
		managedObj_3.PrimaryPart.Anchored = true
		managedObj_3.Parent = parent_2
		local val5 = if scriptData == script["Orcalero Orcala"] then script.OrcaleroSwim else script.TralaleroSwim
		local val6 = if scriptData == script["Orcalero Orcala"] then script.OrcaleroAttack else script.TralaleroAttack
		local v48Track = managedObj_3.AnimationController.Animator:LoadAnimation(val5)
		v48Track.Priority = Enum.AnimationPriority.Action
		local v49Track = managedObj_3.AnimationController.Animator:LoadAnimation(val6)
		v49Track.Priority = Enum.AnimationPriority.Action4
		v49Track.Looped = false
		v48Track:Play()

		local function playAnimation()

			v48Track:Stop(0)
			v48Track:Destroy()
			v49Track:Stop(0)
			v49Track:Destroy()
		end
		local attributeChangedSignal = parent_2:GetAttributeChangedSignal("Attack"):Connect(function()

			v49Track:Play()
		end)
		data_2[parent_2.Name] = managedObj_3
		table.insert(data_3, parent_2)

		return function()

			local flag = table.find(data_3, parent_2)
			if flag then
				table.remove(data_3, flag)
			end
			attributeChangedSignal:Disconnect()
			managedObj_3:Destroy()
			data_2[parent_2.Name] = nil
			if type(playAnimation) == "function" then
				playAnimation()
				playAnimation = nil
			end
		end
	end))
	managedObj:Add(RunService.PreRender:Connect(function(_)

		debug.profilebegin("WaterEvent:Update Sharks")
		local data_4 = {}
		local data_5 = {}
		for _, v43Entry in data_3 do
			local data_2Data = data_2[v43Entry.Name]
			if data_2Data then
				table.insert(data_4, data_2Data.PrimaryPart)
				table.insert(data_5, v43Entry.CFrame)
			end
		end
		workspace:BulkMoveTo(data_4, data_5, Enum.BulkMoveMode.FireCFrameChanged)
		debug.profileend()
	end))
end

data.OnStart = function(_)

	local l_v12_ActiveEventData_0 = EventController:GetActiveEventData(Name)
	assert(l_v12_ActiveEventData_0)
	ReplicatedStorage:SetAttribute("WaterEvent", true)
	SoundController:PlaySound(ReplicatedStorage.Sounds.Events.Water:FindFirstChild("Activating"))
	managedObj:Add(function()

		ReplicatedStorage:SetAttribute("WaterEvent", nil)
		EffectController:Activate("Blink")
		EffectController:Stop(Name, "GrassRecolor")
		CycleController:Update()
		SoundController:UpdateOST()
		SoundController:UpdateAmbience()
	end)
	managedObj:Add(task.delay(l_v12_ActiveEventData_0.startedAt + 4 - workspace:GetServerTimeNow(), function()

		EffectController:Activate("Blink")
		local colorCorrectionEffect = managedObj:Add(Instance.new("ColorCorrectionEffect"))
		colorCorrectionEffect.Brightness = 0.15
		colorCorrectionEffect.Contrast = 0.1
		colorCorrectionEffect.Saturation = -0.1
		colorCorrectionEffect.TintColor = Color3.fromRGB(113, 186, 234)
		colorCorrectionEffect.Parent = workspace.CurrentCamera
		managedObj:Clone(script.Water).Parent = workspace
		EffectController:Run(Name, "GrassRecolor")
		CycleController:Update()
		SoundController:UpdateOST()
		SoundController:UpdateAmbience()
		createSharks()
		managedObj:Add(Observers.observeCharacters(function(_, val7)

			return Observers.observeChildren(val7, function(parent_3)

				if parent_3.Name ~= "UpperTorso" then

					return nil
				else
					local data_6 = {}
					for _, child in script.PlayerBubbles:GetChildren() do
						local ref1 = child:Clone()
						ref1.Parent = parent_3
						table.insert(data_6, ref1)
					end
					local val8 = Observers.observeChildren(val7, function(isAObj)

						if not isAObj:IsA("Humanoid") then

							return nil
						else
							local propertyChangedSignal = isAObj:GetPropertyChangedSignal("MoveDirection"):Connect(function()

								local enabled = isAObj.MoveDirection ~= Vector3.new(0, 0, 0, 0)
								for _, v68Entry in data_6 do
									v68Entry.Enabled = enabled
								end
							end)

							return function()

								propertyChangedSignal:Disconnect()
							end
						end
					end)

					return function()

						for _, v68Entry_2 in data_6 do
							v68Entry_2:Destroy()
						end
						table.clear(data_6)
						val8()
					end
				end
			end)
		end))
		managedObj:Add(function()
			workspace.Gravity = 196.2
		end)
		managedObj:Add(RunService.PostSimulation:Connect(function(_)
			debug.profilebegin("Water:Gravity")
			workspace.Gravity = 29.429999999999996
			debug.profileend()
		end))
	end))
	managedObj:Add(task.spawn(function()

		initActivationVisual()
	end))
end

data.OnStop = function(_)

	managedObj:Destroy()
end

data.OnLoad = function(_)

	eventServiceWaterBurst.OnClientEvent:Connect(function(val9, val10)

		local data_2Data_2 = data_2[val9]
		if data_2Data_2 then
			data_2Data_2.Parent:SetAttribute("Attack", not data_2Data_2.Parent:GetAttribute("Attack"))
		end
		ClientEventUtils.playBurst(script.Burst, val10, {
			ReplicatedStorage.Sounds.Events.Water["Brainrot Hit"]
		})
	end)
end

return data
