local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local EventTypes = require(ReplicatedStorage.Shared.EventTypes)

local data = {}

local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local ShakePresets = require(ReplicatedStorage.Shared.ShakePresets)
local Observers = require(ReplicatedStorage.Packages.Observers)
local TweenPivot = require(ReplicatedStorage.Shared.TweenPivot)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local MathUtils = require(ReplicatedStorage.Utils.MathUtils)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Shake = require(ReplicatedStorage.Packages.Shake)
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)

local cloneObj = script["Svinina Bombardino"]
local cloneObj_2 = script["Bombardiro Crocodilo"]

local eventServiceBombardiroCrocodiloSpawnBomb = Net:RemoteEvent("EventService/Bombardiro Crocodilo/SpawnBomb")
local eventServiceBombardiroCrocodiloExplode = Net:RemoteEvent("EventService/Bombardiro Crocodilo/Explode")

local Name = script.Name

local managedObj = Trove.new()

local _unused = workspace.CurrentCamera

local data_2 = {}

data.OnStart = function(_)

	local l_v11_ActiveEventData_0 = EventController:GetActiveEventData(Name)
	assert(l_v11_ActiveEventData_0)
	local serverTimeNow = workspace:GetServerTimeNow()
	ReplicatedStorage:SetAttribute("BombardiroCrocodiloEvent", true)
	managedObj:Add(function()

		ReplicatedStorage:SetAttribute("BombardiroCrocodiloEvent", nil)
	end)
	managedObj:Add(task.delay(l_v11_ActiveEventData_0.startedAt + 8 - workspace:GetServerTimeNow(), function()

		local ref1 = if ServerData.IsTsunamiServer() then managedObj:Clone(script.PlanesbgTsunami) else managedObj:Clone(script.Planesbg)
		VFX.enable(ref1)
		ref1.Parent = workspace
		if ServerData.IsBiggerServer() then
			ClientEventUtils.resizeEffects(ref1, 2)
		end
		ReplicatedStorage:SetAttribute("BombardiroCrocodiloEventSoundTrack", true)
		SoundController:UpdateOST()
		managedObj:Add(function()

			ReplicatedStorage:SetAttribute("BombardiroCrocodiloEventSoundTrack", nil)
			SoundController:UpdateOST()
			EffectController:Activate("Blink")
		end)
	end))
	SoundController:UpdateOST()
	CycleController:Update()
	local subCollector = managedObj:Extend()
	local connections = table.create(3)
	subCollector:Add(function()

		table.clear(connections)
	end)
	local val1 = 0
	subCollector:Add(RunService.PreRender:Connect(function(val2)

		debug.profilebegin("Bombardiro Event")
		val1 = val1 + val2
		for v36EntryId, v36Entry in connections do
			if v36Entry.target and v36Entry.targetAttachment then
				v36Entry.beam.First.Enabled = true
				v36Entry.beam.Second.Enabled = true
				local val3 = math.clamp(val1 - v36EntryId + 1, 0, 1)
				local WorldPosition = v36Entry.beam.WorldPosition
				v36Entry.targetAttachment.Position = WorldPosition + (v36Entry.target:GetPivot().Position - WorldPosition) * val3
			end
		end
		debug.profileend()
	end))
	subCollector:Add(Observers.observeTag("BombardiroCrocodiloPlayerVFX", function(parent)

		local position = script.PlayerVFX.Beam:Clone()
		position.Parent = parent
		local managedObj_2 = script.PlayerVFX.Torso:Clone()
		managedObj_2.Parent = parent
		local l_v43_Attribute_0 = parent:GetAttribute("BombardiroIndex")
		connections[l_v43_Attribute_0] = {
			beam = position,
			target = nil
		}
		local val4 = Observers.observeTag("BombardiroCrocodiloPlayerVFX", function(getAttributeObj)

			if getAttributeObj == parent then

				return nil
			elseif getAttributeObj:GetAttribute("BombardiroIndex") ~= parent:GetAttribute("BombardiroIndex") % 3 + 1 then

				return nil
			else
				local attachment = Instance.new("Attachment")
				attachment.Position = position.WorldPosition
				attachment.Parent = workspace.Terrain
				local attribute = connections[parent:GetAttribute("BombardiroIndex")]
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
			connections[l_v43_Attribute_0] = nil
		end
	end))
	local data_3 = {}
	managedObj:Add(Observers.observeTag("BombardiroPlane", function(parent_2)

		local parent_3 = cloneObj_2:Clone()
		parent_3.PrimaryPart.Anchored = true
		for _, child in parent_3["Svinina Bombardino"]:GetChildren() do
			if child.Name ~= "RootPart" then
				child.Transparency = 1
			end
		end

		if FFlags:GetInstant("Optimisation.HumanoidBrainrotModels") or require(ReplicatedStorage.Shared.GetServerType):IsPublicServer() then
			local AnimationController = parent_3:FindFirstChild("AnimationController")
			if AnimationController then
				AnimationController:Destroy()
			end
			local humanoid = Instance.new("Humanoid", parent_3)
			local animator = Instance.new("Animator", humanoid)
			humanoid.Name = "AnimationController"
			humanoid.EvaluateStateMachine = false
			humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			humanoid.PlatformStand = true
			humanoid.Parent = parent_3
		end
		parent_3.Parent = parent_2
		local val5 = task.delay(5, function()

			for _, child_2 in parent_3["Svinina Bombardino"]:GetChildren() do
				if child_2.Name ~= "RootPart" then
					child_2.Transparency = 0
				end
			end
		end)
		data_2[parent_2.Name] = parent_3
		table.insert(data_3, parent_2)

		return function()

			local flag = table.find(data_3, parent_2)
			if flag then
				table.remove(data_3, flag)
			end
			parent_3:Destroy()
			data_2[parent_2.Name] = nil
			if coroutine.status(val5) == "suspended" then
				pcall(task.cancel, val5)
			end
		end
	end))
	managedObj:Add(RunService.PreRender:Connect(function(_)

		debug.profilebegin("Bombardiro Crocodilo:BulkMoveTo")
		local data_4 = {}
		local data_5 = {}
		for _, v51Entry in data_3 do
			local data_2Data = data_2[v51Entry.Name]
			if data_2Data then
				table.insert(data_4, data_2Data.PrimaryPart)
				table.insert(data_5, v51Entry.CFrame)
			end
		end
		workspace:BulkMoveTo(data_4, data_5, Enum.BulkMoveMode.FireCFrameChanged)
		debug.profileend()
	end))
end

data.OnStop = function(_)

	managedObj:Destroy()
end

data.OnLoad = function(_)

	local function playExplosion(cFrame, val6)
		local managedObj_3 = script[val6 or "Explosion"]:Clone()
		managedObj_3.CFrame = cFrame
		managedObj_3.Parent = workspace

		local explosionSound = ReplicatedStorage.Sounds.Events["Bombardiro Crocodilo"]:FindFirstChild("BombHit")
		if explosionSound then
			local soundClone = explosionSound:Clone()
			soundClone.Parent = managedObj_3
			soundClone:Play()
		end

		VFX.emit(managedObj_3)
		task.delay(5, function()
			managedObj_3:Destroy()
		end)
	end
	eventServiceBombardiroCrocodiloSpawnBomb.OnClientEvent:Connect(function(val7, ref2, ref3)

		local data_2Data_2 = data_2[val7]
		if data_2Data_2 and data_2Data_2:FindFirstChild("Svinina Bombardino") then
			for _, child_3 in data_2Data_2["Svinina Bombardino"]:GetChildren() do
				if child_3.Name ~= "RootPart" then
					child_3.Transparency = 1
					task.delay(1, function()

						child_3.Transparency = 0
					end)
				end
			end
		end
		local parent_4 = cloneObj:Clone()
		parent_4.PrimaryPart.Anchored = true
		parent_4:PivotTo(CFrame.new(ref2))
		local tweenObj = ReplicatedStorage.Sounds.Events["Bombardiro Crocodilo"].DroppingBomb:Clone()
		tweenObj.Parent = parent_4
		parent_4.Parent = workspace
		tweenObj:Play()
		local val8 = 0
		local val9 = MathUtils.calculateTimeToGround(ref2.y, ref3.y)
		local connectResult = nil
		connectResult = RunService.PostSimulation:Connect(function(val10)

			debug.profilebegin("Bombardiro Crocodilo:Bomb")
			val8 = val8 + val10
			local flag_2 = val8 / val9
			parent_4:PivotTo(CFrame.new(ref2 - vector.create(0, MathUtils.simulateGravity(val8), 0)) * CFrame.Angles(-val8 * 3.141592653589793 * 2, 0, 0))
			debug.profileend()
			if flag_2 >= 1 then
				connectResult:Disconnect()
				for _, descendant in parent_4:GetDescendants() do
					if descendant:IsA("BasePart") then
						descendant.Transparency = 1
					elseif descendant:IsA("ParticleEmitter") then
						descendant:Destroy()
					end
				end
				task.wait(3)
				parent_4:Destroy()
			end
		end)
	end)
	eventServiceBombardiroCrocodiloExplode.OnClientEvent:Connect(function(val11, val12)

		playExplosion(if typeof(val11) == "CFrame" then val11 else CFrame.new(val11), val12)
	end)
end

return data
