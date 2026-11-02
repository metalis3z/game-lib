
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local EventTypes = require(ReplicatedStorage.Shared.EventTypes)

local data = {}

local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local TweenPivot = require(ReplicatedStorage.Shared.TweenPivot)
local Observers = require(ReplicatedStorage.Packages.Observers)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local MathUtils = require(ReplicatedStorage.Utils.MathUtils)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)
local MapInformation = require(ReplicatedStorage.Shared.MapInformation)
local Snapshot = require(ReplicatedStorage.Shared.Snapshot)

local Name = script.Name

local onClientEventObj = Net:RemoteEvent((("EventService/%*/Burst"):format(Name)))

local managedObj = Trove.new()

local ref1 = RaycastParams.new()

ref1.FilterType = Enum.RaycastFilterType.Include
ref1.FilterDescendantsInstances = {
	workspace.Map,
	workspace.Plots
}

local function createHole(val1, val2)

	local v28 = val1
	local ref2 = workspace:Raycast(val1, Vector3.new(-0, -25, -0, -0), ref1)
	if ref2 then
		v28 = ref2.Position
	end
	local managedObj_2 = script.Hole:Clone()
	managedObj_2.CFrame = CFrame.new(v28 + Vector3.new(0, 0.009999999776482582, 0, 0)) * CFrame.Angles(0, 0, 1.5707963267948966)
	managedObj_2.Size = Vector3.new(0.009999999776482582, 0.009999999776482582, 0.009999999776482582, 0)
	managedObj_2.Parent = workspace
	CreateTween(managedObj_2, TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		Size = Vector3.new(0.009999999776482582, 8, 8, 0)
	})
	task.delay(val2, function()

		CreateTween(managedObj_2, TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
			Size = Vector3.new(0.009999999776482582, 0.009999999776482582, 0.009999999776482582, 0)
		}).Completed:Wait()
		managedObj_2:Destroy()
	end)
end

local function initActivationVisual()

	local subCollector = managedObj:Extend()
	local connections = table.create(4)
	subCollector:Add(function()

		table.clear(connections)
	end)
	local val3 = 0
	subCollector:Add(RunService.PreRender:Connect(function(val4)

		debug.profilebegin("Sammyni Spyderini Event")
		val3 = val3 + val4
		for v35EntryId, v35Entry in connections do
			if v35Entry.target and v35Entry.targetAttachment then
				v35Entry.beam.First.Enabled = true
				v35Entry.beam.Second.Enabled = true
				local val5 = math.clamp(val3 - v35EntryId + 1, 0, 1)
				local WorldPosition = v35Entry.beam.WorldPosition
				v35Entry.targetAttachment.Position = WorldPosition + (v35Entry.target:GetPivot().Position - WorldPosition) * val5
			end
		end
		debug.profileend()
	end))
	subCollector:Add(Observers.observeTag("SammyniSpyderiniPlayerVFX", function(parent)

		local position = script.PlayerVFX.Beam:Clone()
		position.Parent = parent
		local managedObj_3 = script.PlayerVFX.Torso:Clone()
		managedObj_3.Parent = parent
		local l_v42_Attribute_0 = parent:GetAttribute("SammyniSpyderiniIndex")
		connections[l_v42_Attribute_0] = {
			beam = position,
			target = nil
		}
		local val6 = Observers.observeTag("SammyniSpyderiniPlayerVFX", function(getAttributeObj)

			if getAttributeObj == parent then

				return nil
			elseif getAttributeObj:GetAttribute("SammyniSpyderiniIndex") ~= parent:GetAttribute("SammyniSpyderiniIndex") % 4 + 1 then

				return nil
			else
				local attachment = Instance.new("Attachment")
				attachment.Position = position.WorldPosition
				attachment.Parent = workspace.Terrain
				local attribute = connections[parent:GetAttribute("SammyniSpyderiniIndex")]
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

			managedObj_3:Destroy()
			position:Destroy()
			val6()
			connections[l_v42_Attribute_0] = nil
		end
	end))
end

data.OnStart = function(_)

	local l_v12_ActiveEventData_0 = EventController:GetActiveEventData(Name)
	assert(l_v12_ActiveEventData_0)
	ReplicatedStorage:SetAttribute("SammyniSpyderiniEvent", true) 
	SoundController:PlaySound(ReplicatedStorage.Sounds.Events["Sammyni Spyderini"]:FindFirstChild("Activating"))
	managedObj:Add(function()

		ReplicatedStorage:SetAttribute("SammyniSpyderiniEvent", nil)
		EffectController:Activate("Blink")
		CycleController:Update()
		SoundController:UpdateOST()
		SoundController:UpdateAmbience()
	end)
	managedObj:Add(Observers.observeTag("SammyniSpyderini", function(parent_2)

		local addObj = Trove.new()
		local HumanoidRootPart = parent_2:WaitForChild("HumanoidRootPart")
		local part0 = addObj:Clone(script["Sammyni Spyderini"])
		local weld = addObj:Add(Instance.new("Weld"))
		weld.Part0 = part0.PrimaryPart
		weld.Part1 = HumanoidRootPart
		weld.C0 = CFrame.Angles(0, 3.141592653589793, 0)
		weld.Parent = part0.PrimaryPart
		part0.Parent = parent_2
		local Animator = part0.AnimationController.Animator
		local tweenObj = Animator:LoadAnimation(script.Idle)
		tweenObj.Priority = Enum.AnimationPriority.Idle
		local tweenObj_2 = Animator:LoadAnimation(script.Walk)
		tweenObj_2.Priority = Enum.AnimationPriority.Movement
		local tweenObj_3 = Animator:LoadAnimation(script.Attack)
		local tweenObj_4 = Animator:LoadAnimation(script.Ground)
		tweenObj_4.Looped = true
		local tweenObj_5 = Animator:LoadAnimation(script.InitialGround)
		tweenObj_5.Looped = true
		local tweenObj_6 = Animator:LoadAnimation(script.Jump)
		tweenObj:Play()
		addObj:Add(tweenObj_4:GetMarkerReachedSignal("Freeze"):Connect(function()

			tweenObj_4:AdjustSpeed(0)
		end))
		addObj:Add(tweenObj_5:GetMarkerReachedSignal("Freeze"):Connect(function()

			tweenObj_5:AdjustSpeed(0)
		end))
		local flag = nil

		local function updateGround()

			if parent_2:GetAttribute("InitialGround") then
				flag = true
				SoundController:PlaySound(ReplicatedStorage.Sounds.Events["Sammyni Spyderini"].EnterHole, HumanoidRootPart.Position, false)
				createHole(HumanoidRootPart.Position, 1.5)
				if not tweenObj_5.IsPlaying then
					tweenObj_5:Play()
					return
				end
			elseif parent_2:GetAttribute("Ground") then
				SoundController:PlaySound(ReplicatedStorage.Sounds.Events["Sammyni Spyderini"].EnterHole, HumanoidRootPart.Position, false)
				createHole(HumanoidRootPart.Position, 1.5)
				if not tweenObj_4.IsPlaying then
					if flag then
						tweenObj_4.TimePosition = 0.6
					end
					tweenObj_4:Play(flag and 0 or nil)
					if flag then
						tweenObj_4.TimePosition = 0.6
					end
				end
				flag = false
				return
			else
				flag = false
				SoundController:PlaySound(ReplicatedStorage.Sounds.Events["Sammyni Spyderini"].LeaveHole, HumanoidRootPart.Position, false)
				createHole(HumanoidRootPart.Position, 1.5)
				tweenObj_6:Play()
				tweenObj_4:Stop()
				tweenObj_5:Stop()
			end
		end
		addObj:Add(task.defer(function()

			if parent_2:GetAttribute("IsRunning") then
				tweenObj_2:Play()
			end
		end))
		addObj:Add(parent_2:GetAttributeChangedSignal("IsRunning"):Connect(function()

			if parent_2:GetAttribute("IsRunning") then
				tweenObj_2:Play()
				return
			else
				tweenObj_2:Stop()
				return
			end
		end))

		if parent_2:GetAttribute("Ground") and not tweenObj_4.IsPlaying then
			tweenObj_4.TimePosition = 0.6
			tweenObj_4:Play(0)
			tweenObj_4.TimePosition = 0.6
		end

		if parent_2:GetAttribute("InitialGround") and not tweenObj_5.IsPlaying then
			flag = true
			tweenObj_5:Play()
		end
		addObj:Add(parent_2:GetAttributeChangedSignal("Ground"):Connect(updateGround))
		addObj:Add(parent_2:GetAttributeChangedSignal("InitialGround"):Connect(updateGround))
		addObj:Add(parent_2:GetAttributeChangedSignal("AttackAnimation"):Connect(function()
			if parent_2:GetAttribute("AttackAnimation") then
				tweenObj_3:Play()
			else
				tweenObj_3:Stop()
			end
		end))

		return addObj:WrapClean()
	end))
	local serverTimeNow = l_v12_ActiveEventData_0.startedAt + 5 - workspace:GetServerTimeNow()
	managedObj:Add(task.delay(serverTimeNow, function()

		if serverTimeNow > 1 then
			SoundController:PlaySound(ReplicatedStorage.Sounds.Events["Sammyni Spyderini"].Expanding, MapInformation.MapCenter.Position, false)
		end
		local data_2 = {}
		if ServerData.IsBiggerServer() then
			for _, child in script.WebBigger:GetChildren() do
				table.insert(data_2, (managedObj:Clone(child)))
			end
		else
			data_2 = {
				managedObj:Clone(script.Web_Main)
			}
		end

		for _, v68Entry in data_2 do
			local MapCenter = v68Entry:FindFirstChild("MapCenter") or MapInformation.MapCenter
			for _, child_2 in v68Entry.Lines:GetChildren() do
				local Size = child_2.Size
				child_2.Size = Vector3.new(0, 1, 1, 0)
				CreateTween(child_2, TweenInfo.new(Size.Magnitude / 150, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
					Size = Size
				})
			end

			for _, descendant in v68Entry:GetDescendants() do
				if not descendant:IsDescendantOf(v68Entry.Lines) and descendant:IsA("BasePart") then
					local Sizedescendant = descendant.Size
					descendant.Size = Vector3.new(0, 1, 1, 0)
					local Transparency = descendant.Transparency
					descendant.Transparency = 1
					local val7 = ((descendant.Position - MapCenter.Position) * Vector3.new(1, 0, 1, 0)).Magnitude * 2 / 150
					task.delay(val7, function()

						descendant.Transparency = Transparency
					end)
					CreateTween(descendant, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, val7), {
						Size = Sizedescendant
					})
				end
			end
			v68Entry.Parent = workspace
		end
		CycleController:Update()
		SoundController:UpdateOST()
		SoundController:UpdateAmbience()
	end))
	managedObj:Add(task.spawn(function()

		initActivationVisual()
	end))
end

data.OnStop = function(_)

	managedObj:Destroy()
end

data.OnLoad = function(_)

	task.spawn(pcall, function()

		ContentProvider:PreloadAsync(script:GetChildren())
	end)
	onClientEventObj.OnClientEvent:Connect(function(val8)

		ClientEventUtils.playBurst(script.Burst, val8, {
			ReplicatedStorage.Sounds.Events["Sammyni Spyderini"].Hit
		})
	end)
end

return data
