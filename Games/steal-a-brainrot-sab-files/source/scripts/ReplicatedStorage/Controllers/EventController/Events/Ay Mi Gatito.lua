local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

local EventTypes = require(ReplicatedStorage.Shared.EventTypes)

local data = {}

local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local Observers = require(ReplicatedStorage.Packages.Observers)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)

local AyMiGatito = workspace.Sounds.AyMiGatito

local LocalPlayer = Players.LocalPlayer

local Name = script.Name

local managedObj = Trove.new()

local eventServiceAyMiGatitoBurst = Net:RemoteEvent("EventService/AyMiGatito/Burst")

local function _(loadAnimationObj, val24, val25)

	local v22Track = loadAnimationObj:LoadAnimation(val24);
	(val25 or managedObj):Add(function()

		v22Track:Stop(0)
		v22Track:Destroy()
	end)

	return v22Track
end

local function _(flag_12)
	if flag_12 >= 43 and flag_12 < 48 then

		return 0.4
	elseif flag_12 >= 48 and flag_12 < 50 then

		return (flag_12 - 48) / 2 * 0.3 + 0.4
	elseif flag_12 >= 50 and flag_12 < 55.5 then

		return 0.7
	elseif flag_12 >= 55.5 and flag_12 < 57 then

		return (flag_12 - 55.5) / 1.5 * 0.3 + 0.7
	else

		return 1
	end
end

local calculateAnimationSpeed = function(flag_13, _)
	if flag_13 < 7 then

		return 0
	else
		local val26 = flag_13 - 7
		if flag_13 >= 222.313 then

			return (math.max(0, 1 - (flag_13 - 222.313) / 3))
		else
			local flag_14 = val26 % 72.771
			if flag_14 >= 43 and flag_14 < 48 then

				return 0.4
			elseif flag_14 >= 48 and flag_14 < 50 then

				return (flag_14 - 48) / 2 * 0.3 + 0.4
			elseif flag_14 >= 50 and flag_14 < 55.5 then

				return 0.7
			elseif flag_14 >= 55.5 and flag_14 < 57 then

				return (flag_14 - 55.5) / 1.5 * 0.3 + 0.7
			else

				return 1
			end
		end
	end
end

local function _(flag_15)
	if flag_15 < 7 then

		return 0, false
	else
		local val27 = flag_15 - 7

		return val27 % 72.771, val27 < 218.313
	end
end

local function initActivationVisual()

	local subCollector = managedObj:Extend()
	local connections = table.create(2)
	subCollector:Add(function()

		table.clear(connections)
	end)
	local val28 = 0
	subCollector:Add(RunService.PreRender:Connect(function(val29)

		debug.profilebegin("Ay Mi Gatito Event Activation")
		val28 = val28 + val29
		for v37EntryId, v37Entry in connections do
			if v37Entry.target and v37Entry.targetAttachment then
				v37Entry.beam.First.Enabled = true
				v37Entry.beam.Second.Enabled = true
				local val30 = math.clamp(val28 - v37EntryId + 1, 0, 1)
				local WorldPosition = v37Entry.beam.WorldPosition
				v37Entry.targetAttachment.Position = WorldPosition + (v37Entry.target:GetPivot().Position - WorldPosition) * val30
			end
		end
		debug.profileend()
	end))
	subCollector:Add(Observers.observeTag("AyMiGatitoPlayerVFX", function(parent)

		local position = script.PlayerVFX.Beam:Clone()
		position.Parent = parent
		local managedObj_2 = script.PlayerVFX.Torso:Clone()
		managedObj_2.Parent = parent
		local l_v44_Attribute_0 = parent:GetAttribute("AyMiGatitoIndex")
		connections[l_v44_Attribute_0] = {
			beam = position,
			target = nil
		}
		local val31 = Observers.observeTag("AyMiGatitoPlayerVFX", function(getAttributeObj)

			if getAttributeObj == parent then

				return nil
			elseif getAttributeObj:GetAttribute("AyMiGatitoIndex") ~= parent:GetAttribute("AyMiGatitoIndex") % 2 + 1 then

				return nil
			else
				local attachment = Instance.new("Attachment")
				attachment.Position = position.WorldPosition
				attachment.Parent = workspace.Terrain
				local attribute = connections[parent:GetAttribute("AyMiGatitoIndex")]
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
			val31()
			connections[l_v44_Attribute_0] = nil
		end
	end))
end

local function initGatitoObserver(ref5)

	local data_2 = {}
	managedObj:Add(RunService.PostSimulation:Connect(function(_)

		if #data_2 == 0 then
			return
		else
			local serverTimeNow = workspace:GetServerTimeNow() - ref5.startedAt
			if serverTimeNow < 7 then
				local _unused = 0
				local _unused = false
			else
				local val32 = serverTimeNow - 7
				local val33 = val32 % 72.771
				local val34 = val32 < 218.313
				local _unused = val33
				local _unused = val34
			end
			local val35
			if serverTimeNow < 7 then
				val35 = 0
			else
				local val36 = serverTimeNow - 7
				if serverTimeNow >= 222.313 then
					val35 = math.max(0, 1 - (serverTimeNow - 222.313) / 3)
				else
					local flag_16 = val36 % 72.771
					val35 = flag_16 >= 43 and flag_16 < 48 and 0.4 or if flag_16 >= 48 and flag_16 < 50 then (flag_16 - 48) / 2 * 0.3 + 0.4 else flag_16 >= 50 and flag_16 < 55.5 and 0.7 or if flag_16 >= 55.5 and flag_16 < 57 then (flag_16 - 55.5) / 1.5 * 0.3 + 0.7 else 1
				end
			end

			for _, v54Entry in data_2 do
				if v54Entry.dance and v54Entry.dance.IsPlaying then
					v54Entry.dance:AdjustSpeed(val35)
				end

				if v54Entry.walk and v54Entry.walk.IsPlaying then
					v54Entry.walk:AdjustSpeed(val35)
				end

				if v54Entry.idle and v54Entry.idle.IsPlaying then
					v54Entry.idle:AdjustSpeed(val35)
				end
			end
			return
		end
	end))
	managedObj:Add(function()

		table.clear(data_2)
	end)
	managedObj:Add(Observers.observeTag("Gatito", function(parent_2)

		local addObj_2 = Trove.new()
		local HumanoidRootPart = parent_2:WaitForChild("HumanoidRootPart")
		local attribute_2 = parent_2:GetAttribute("Variant") or "Gatito"
		local part0 = addObj_2:Clone(script.Gatitos:FindFirstChild(attribute_2) or script.Gatitos.Gatito)
		local weld = addObj_2:Add(Instance.new("Weld"))
		weld.Part0 = part0.PrimaryPart
		weld.Part1 = HumanoidRootPart
		weld.Parent = part0.PrimaryPart
		part0.Parent = parent_2
		local AnimationController = part0:FindFirstChild("AnimationController")
		if AnimationController then
			AnimationController:Destroy()
		end
		local humanoid = Instance.new("Humanoid", part0)
		Instance.new("Animator", humanoid)
		humanoid.Name = "AnimationController"
		humanoid.EvaluateStateMachine = false
		humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		humanoid.PlatformStand = true
		humanoid.Parent = part0
		local Animator = part0.AnimationController.Animator
		local tweenObj_2 = nil
		local tweenObj_3 = nil
		local tweenObj_4 = nil
		local GatitoDance1 = script:FindFirstChild("GatitoDance1")
		if GatitoDance1 then
			local l_GatitoDance1_0Track = Animator:LoadAnimation(GatitoDance1)
			local v82 = l_GatitoDance1_0Track;
			(addObj_2 or managedObj):Add(function()
				v82:Stop(0)
				v82:Destroy()
			end)
			tweenObj_2 = l_GatitoDance1_0Track
			tweenObj_2.Looped = true
			tweenObj_2.Priority = Enum.AnimationPriority.Action
		end
		local GatitoWalk = script:FindFirstChild("GatitoWalk")
		if GatitoWalk then
			local l_GatitoWalk_0Track = Animator:LoadAnimation(GatitoWalk)
			local v85 = l_GatitoWalk_0Track;
			(addObj_2 or managedObj):Add(function()

				v85:Stop(0)
				v85:Destroy()
			end)
			tweenObj_3 = l_GatitoWalk_0Track
			tweenObj_3.Priority = Enum.AnimationPriority.Action2
		end
		local GatitoIdle = script:FindFirstChild("GatitoIdle")
		if GatitoIdle then
			local l_GatitoIdle_0Track = Animator:LoadAnimation(GatitoIdle)
			local v88 = l_GatitoIdle_0Track;
			(addObj_2 or managedObj):Add(function()

				v88:Stop(0)
				v88:Destroy()
			end)
			tweenObj_4 = l_GatitoIdle_0Track
			tweenObj_4.Looped = true
			tweenObj_4.Priority = Enum.AnimationPriority.Idle
		end
		addObj_2:Add(parent_2:GetAttributeChangedSignal("AttackAnimation"):Connect(function()

			local GatitoAttack = script:FindFirstChild("GatitoAttack")
			if GatitoAttack then
				local l_Animator_0 = Animator
				local v70 = addObj_2
				local l_GatitoAttack_0Track = l_Animator_0:LoadAnimation(GatitoAttack);
				(v70 or managedObj):Add(function()

					l_GatitoAttack_0Track:Stop(0)
					l_GatitoAttack_0Track:Destroy()
				end)
				local v93 = l_GatitoAttack_0Track
				v93.Looped = false
				v93.Priority = Enum.AnimationPriority.Action4
				v93:Play()
			end
		end))
        
		if tweenObj_3 then
			local function updateMovementAnimation()
				local isRunning = parent_2:GetAttribute("IsRunning")
				local isChasing = parent_2:GetAttribute("IsChasing")

				if isRunning or isChasing then
					if tweenObj_3 and not tweenObj_3.IsPlaying then
						tweenObj_3:Play()
					end
					if tweenObj_4 then tweenObj_4:Stop() end
					if tweenObj_2 then tweenObj_2:Stop() end
				else
					if tweenObj_3 then tweenObj_3:Stop() end
					if tweenObj_2 and parent_2:GetAttribute("Dance") then
						tweenObj_2:Play()
					elseif tweenObj_4 then
						tweenObj_4:Play()
					end
				end
			end

			addObj_2:Add(parent_2:GetAttributeChangedSignal("IsRunning"):Connect(updateMovementAnimation))
			addObj_2:Add(parent_2:GetAttributeChangedSignal("IsChasing"):Connect(updateMovementAnimation))
		end
		addObj_2:Add(Observers.observeAttribute(parent_2, "Dance", function(flag_18)

			if not flag_18 then
				if tweenObj_2 then
					tweenObj_2:Stop()
				end

				if tweenObj_4 then
					tweenObj_4:Play()
				end

				return nil
			else
				if tweenObj_4 and tweenObj_4.IsPlaying then
					tweenObj_4:Stop()
				end

				if tweenObj_2 then
					tweenObj_2:Play()
				end

				return nil
			end
		end))
		local val37 = {
			dance = tweenObj_2,
			walk = tweenObj_3,
			idle = tweenObj_4
		}
		table.insert(data_2, val37)
		addObj_2:Add(function()

			local flag_19 = table.find(data_2, val37)
			if flag_19 then
				table.remove(data_2, flag_19)
			end
		end)

		return addObj_2:WrapClean()
	end))
end

local initMusicController = function(ref1)

	managedObj:Add(task.spawn(function()

		local serverTimeNow_2 = workspace:GetServerTimeNow() - ref1.startedAt
		if serverTimeNow_2 < 7 then
			local _unused = 0
			local _unused = false
		else
			local val1 = serverTimeNow_2 - 7
			local val2 = val1 % 72.771
			local val3 = val1 < 218.313
			local _unused = val2
			local _unused = val3
		end
		local timePosition = serverTimeNow_2 - 7
		if timePosition >= 0 and timePosition < 218.313 then
			AyMiGatito.TimePosition = timePosition % 72.771
			ReplicatedStorage:SetAttribute("AyMiGatitoEventMusic" ,true)
			AyMiGatito:Play()
		end
		managedObj:Add(function()
			ReplicatedStorage:SetAttribute("AyMiGatitoEventMusic" ,false)
			AyMiGatito:Stop()
		end)
		local val4 = -1
		managedObj:Add(RunService.PostSimulation:Connect(function(_)

			local serverTimeNow_3 = workspace:GetServerTimeNow() - ref1.startedAt
			local flag = serverTimeNow_3 - 7
			if serverTimeNow_3 >= 225.313 then
				AyMiGatito:Stop()
				return
			elseif flag < 0 then
				return
			else
				local flag_2 = math.floor(flag / 72.771)
				local timePosition_2 = flag % 72.771  * 0.9524
				if flag_2 ~= val4 and val4 >= 0 then
					AyMiGatito.TimePosition = 0
				end
				val4 = flag_2
				if math.abs(AyMiGatito.TimePosition - timePosition_2) > 0.5 then
					AyMiGatito.TimePosition = timePosition_2
				end
				return
			end
		end))
	end))
end

local function initAnimatedInstancesObserver(ref2)

	local data_3 = {}
	managedObj:Add(RunService.PostSimulation:Connect(function(_)

		if #data_3 == 0 then
			return
		else
			local serverTimeNow_4 = workspace:GetServerTimeNow() - ref2.startedAt
			if serverTimeNow_4 < 7 then
				local _unused = 0
				local _unused = false
			else
				local val5 = serverTimeNow_4 - 7
				local val6 = val5 % 72.771
				local val7 = val5 < 218.313
				local _unused = val6
				local _unused = val7
			end
			local val8
			if serverTimeNow_4 < 7 then
				val8 = 0
			else
				local val9 = serverTimeNow_4 - 7
				if serverTimeNow_4 >= 222.313 then
					val8 = math.max(0, 1 - (serverTimeNow_4 - 222.313) / 3)
				else
					local flag_3 = val9 % 72.771
					val8 = flag_3 >= 43 and flag_3 < 48 and 0.4 or if flag_3 >= 48 and flag_3 < 50 then (flag_3 - 48) / 2 * 0.3 + 0.4 else flag_3 >= 50 and flag_3 < 55.5 and 0.7 or if flag_3 >= 55.5 and flag_3 < 57 then (flag_3 - 55.5) / 1.5 * 0.3 + 0.7 else 1
				end
			end

			for _, v118Entry in data_3 do
				if v118Entry.IsPlaying then
					v118Entry:AdjustSpeed(val8)
				end
			end
			return
		end
	end))
	managedObj:Add(function()

		table.clear(data_3)
	end)
	managedObj:Add(Observers.observeTag("AyMiGatitoAnimatedInstance", function(findFirstChildObj)

		local wrapCleanObj = Trove.new()
		local AnimationController_2 = findFirstChildObj:FindFirstChild("AnimationController")
		if not AnimationController_2 then

			return wrapCleanObj:WrapClean()
		else
			local Animator_2 = AnimationController_2:FindFirstChild("Animator")
			if not Animator_2 then

				return wrapCleanObj:WrapClean()
			else
				local Animation = findFirstChildObj:FindFirstChild("Animation")
				if not Animation then

					return wrapCleanObj:WrapClean()
				else
					local l_Animation_0Track = Animator_2:LoadAnimation(Animation);
					(wrapCleanObj or managedObj):Add(function()

						l_Animation_0Track:Stop(0)
						l_Animation_0Track:Destroy()
					end)
					local v138 = l_Animation_0Track
					v138.Looped = true
					v138.Priority = Enum.AnimationPriority.Action
					v138:Play()
					table.insert(data_3, v138)
					wrapCleanObj:Add(function()

						local flag_4 = table.find(data_3, v138)
						if flag_4 then
							table.remove(data_3, flag_4)
						end
					end)

					return wrapCleanObj:WrapClean()
				end
			end
		end
	end, {
		workspace
	}))
end

local function initPlayerDanceController(ref3)

	managedObj:Add(task.delay(ref3.startedAt + 7 + 7.308 - workspace:GetServerTimeNow(), function()

		managedObj:Add(Observers.observeCharacters(function(_, waitForChildObj)

			local addObj = Trove.new()
			addObj:Add(task.spawn(function()

				local Humanoid = waitForChildObj:WaitForChild("Humanoid")
				if not Humanoid then
					return
				else
					local Animator_3 = Humanoid:WaitForChild("Animator")
					if not Animator_3 then
						return
					else
						local PlayerDance1 = script:FindFirstChild("PlayerDance1")
						local PlayerDance2 = script:FindFirstChild("PlayerDance2")
						local loadAnimationResult = nil
						local loadAnimationResult_2 = nil
						if PlayerDance1 then
							loadAnimationResult = Animator_3:LoadAnimation(PlayerDance1)
							loadAnimationResult.Priority = Enum.AnimationPriority.Action
						end

						if PlayerDance2 then
							loadAnimationResult_2 = Animator_3:LoadAnimation(PlayerDance2)
							loadAnimationResult_2.Priority = Enum.AnimationPriority.Action
						end
						local flag_5 = 0
						local flag_6 = 1
						addObj:Add(RunService.PostSimulation:Connect(function(val10)

							debug.profilebegin("AyMiGatito:Player:Dance")
							local serverTimeNow_5 = workspace:GetServerTimeNow() - ref3.startedAt
							local flag_7 = serverTimeNow_5 - 7
							flag_6 = 1
							if flag_7 >= 0 then
								local flag_8 = math.floor(flag_7 / 72.771) + 1
								local val11 = flag_7 % 72.771
								if flag_8 == 2 and val11 >= 7.308 and val11 < 29.126 then
									flag_6 = 2
								end
							end
							local tweenObj = if flag_6 == 1 then loadAnimationResult else loadAnimationResult_2
							local stopObj = if flag_6 == 1 then loadAnimationResult_2 else loadAnimationResult
							if serverTimeNow_5 < 7 then
								local _unused = 0
								local _unused = false
							else
								local val12 = serverTimeNow_5 - 7
								local val13 = val12 % 72.771
								local val14 = val12 < 218.313
								local _unused = val13
								local _unused = val14
							end
							local val15
							if serverTimeNow_5 < 7 then
								val15 = 0
							else
								local val16 = serverTimeNow_5 - 7
								if serverTimeNow_5 >= 222.313 then
									val15 = math.max(0, 1 - (serverTimeNow_5 - 222.313) / 3)
								else
									local flag_9 = val16 % 72.771
									val15 = flag_9 >= 43 and flag_9 < 48 and 0.4 or if flag_9 >= 48 and flag_9 < 50 then (flag_9 - 48) / 2 * 0.3 + 0.4 else flag_9 >= 50 and flag_9 < 55.5 and 0.7 or if flag_9 >= 55.5 and flag_9 < 57 then (flag_9 - 55.5) / 1.5 * 0.3 + 0.7 else 1
								end
							end
							local val17 = nil
							local val18 = false
							if flag_7 >= 0 then
								val18 = flag_7 <= 20
							end
							val17 = val18
							if Humanoid.MoveDirection == Vector3.new(0, 0, 0, 0) and not LocalPlayer:GetAttribute("Stealing") or val17 then
								if flag_5 < 3 and not val17 then
									flag_5 = flag_5 + val10
								elseif tweenObj and not tweenObj.IsPlaying then
									if stopObj and stopObj.IsPlaying then
										stopObj:Stop()
									end
									tweenObj:Play()
								end

								if tweenObj and tweenObj.IsPlaying then
									tweenObj:AdjustSpeed(val15)
								end
							else
								flag_5 = 0
								if loadAnimationResult and loadAnimationResult.IsPlaying then
									loadAnimationResult:Stop()
								end

								if loadAnimationResult_2 and loadAnimationResult_2.IsPlaying then
									loadAnimationResult_2:Stop()
								end
							end
							debug.profileend()
						end))
						addObj:Add(function()

							if loadAnimationResult then
								loadAnimationResult:Stop()
								loadAnimationResult:Destroy()
							end

							if loadAnimationResult_2 then
								loadAnimationResult_2:Stop()
								loadAnimationResult_2:Destroy()
							end
						end)
						return
					end
				end
			end))

			return addObj:WrapClean()
		end))
	end))
end

data.OnStart = function(_)

	local l_v11_ActiveEventData_0 = EventController:GetActiveEventData(Name)
	assert(l_v11_ActiveEventData_0)
	managedObj:Add(function()

		ReplicatedStorage:SetAttribute("AyMiGatitoEventMusic", nil)
		EffectController:Activate("Blink")
		CycleController:Update()
		SoundController:UpdateOST()
		SoundController:UpdateAmbience()
	end)
	managedObj:Add(task.delay(l_v11_ActiveEventData_0.startedAt + 7 - workspace:GetServerTimeNow(), function()

		if ServerData.IsTsunamiServer() then
			managedObj:Clone(script.MapVFXTsunami).Parent = workspace
		elseif ServerData.IsBiggerServer() then
			managedObj:Clone(script.MapVFXBigger).Parent = workspace
		else
			managedObj:Clone(script.MapVFX).Parent = workspace
		end

		if ServerData.IsTsunamiServer() then
			managedObj:Clone(script.GatitoMapTsunami).Parent = workspace
		elseif ServerData.IsBiggerServer() then
			managedObj:Clone(script.GatitoMapBigger).Parent = workspace
		else
			managedObj:Clone(script.GatitoMap).Parent = workspace
		end
		EffectController:Run("AyMiGatitoEvent", "GrassRecolor")
		managedObj:Add(function()

			EffectController:Stop("AyMiGatitoEvent", "GrassRecolor")
		end)
		EffectController:Run("AyMiGatitoEvent", "WallRecolor")
		managedObj:Add(function()

			EffectController:Stop("AyMiGatitoEvent", "WallRecolor")
		end)
		EffectController:Run("AyMiGatitoEvent", "WallBottomRecolor")
		managedObj:Add(function()

			EffectController:Stop("AyMiGatitoEvent", "WallBottomRecolor")
		end)
		local Atmosphere = Lighting:FindFirstChild("Atmosphere")
		if Atmosphere then
			Atmosphere.Parent = script
			managedObj:Add(function()

				Atmosphere.Parent = Lighting
			end)
		end
		managedObj:Clone(script.AtmosphereAyMiGatito).Parent = Lighting
		managedObj:Add(Observers.observeTag("HideInAyMiGatito", function(ref4)
			local Parent = ref4.Parent
			ref4.Parent = script

			return function()

				pcall(function()

					ref4.Parent = Parent
				end)
			end
		end, {
			workspace,
			script
		}))
		CycleController:Update()
		SoundController:UpdateOST()
		SoundController:UpdateAmbience()
		EffectController:Activate("Blink")
		local l_v11_ActiveEventData_0 = l_v11_ActiveEventData_0
		initMusicController(l_v11_ActiveEventData_0)
		initGatitoObserver(l_v11_ActiveEventData_0)
		initAnimatedInstancesObserver(l_v11_ActiveEventData_0)
		initPlayerDanceController(l_v11_ActiveEventData_0)
	end))
	managedObj:Add(task.spawn(function()

		initActivationVisual()
	end))
	managedObj:Add(eventServiceAyMiGatitoBurst.OnClientEvent:Connect(function(val23)

		ClientEventUtils.playBurst(script.Burst, val23, {
			ReplicatedStorage.Sounds.Events["Ay Mi Gatito"].Hit
		})
	end))
end

data.OnStop = function(_)

	managedObj:Destroy()
end

data.OnLoad = function(_)

	task.spawn(pcall, function()

		ContentProvider:PreloadAsync(script:GetChildren())
		ContentProvider:PreloadAsync({
			AyMiGatito
		})
	end)
end

return data
