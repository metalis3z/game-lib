
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local EventTypes = require(ReplicatedStorage.Shared.EventTypes)

local data = {}

local EncryptedAssetsController = require(ReplicatedStorage.Controllers.EncryptedAssetsController)
local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local CameraController = require(ReplicatedStorage.Controllers.CameraController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local TweenPivot = require(ReplicatedStorage.Shared.TweenPivot)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Observers = require(ReplicatedStorage.Packages.Observers)
local MathUtils = require(ReplicatedStorage.Utils.MathUtils)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Spring = require(ReplicatedStorage.Packages.Spring)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Shake = require(ReplicatedStorage.Packages.Shake)
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)

local MexicoEvent = workspace.Sounds.MexicoEvent

local LocalPlayer = Players.LocalPlayer

local _unused = workspace.CurrentCamera

local Name = script.Name

local _unused = workspace.RenderedMovingAnimals

local eventServiceMexicoBurst = Net:RemoteEvent("EventService/Mexico/Burst")

local managedObj_4 = Trove.new()

local function _(loadAnimationObj, val4, val5)

	local v37Track = loadAnimationObj:LoadAnimation(val4);
	(val5 or managedObj_4):Add(function()

		v37Track:Stop(0)
		v37Track:Destroy()
	end)

	return v37Track
end

local function playTracksSynced(connections)

	return task.spawn(function()

		for _, v41Entry in connections do
			v41Entry:Play(0)
		end

		while true do
			local flag_5 = true
			for _, v41Entry_2 in connections do
				if v41Entry_2.Length == 0 then
					flag_5 = false
				else
					v41Entry_2:Stop(0)
				end
			end

			if not flag_5 then
				task.wait()
			else
				break
			end
		end

		for _, v41Entry_3 in connections do
			v41Entry_3:Stop(0)
		end

		for _, v41Entry_4 in connections do
			v41Entry_4:Play(0)
		end
	end)
end

local function setupSpeedTracks(connections_2)

	return RunService.PostSimulation:Connect(function(_)

		if MexicoEvent.TimePosition >= 28.5 then
			for _, v52Entry in connections_2 do
				v52Entry:AdjustSpeed(1.5)
			end
		end
	end)
end

data.OnStart = function(_)

	local l_v15_ActiveEventData_0 = EventController:GetActiveEventData(Name)
	assert(l_v15_ActiveEventData_0)

	local function _(val6)

		return (math.max(l_v15_ActiveEventData_0.startedAt + val6 - workspace:GetServerTimeNow(), 0))
	end
	managedObj_4:Add(function()

		EffectController:Activate("Blink")
		CycleController:Update()
		SoundController:UpdateOST()
	end)
	local wallRoachesObj = if ServerData.IsTsunamiServer() then managedObj_4:Clone(script.MapTsunami) else if ServerData.IsBiggerServer() then managedObj_4:Clone(script.MapBigger) else managedObj_4:Clone(script.Map)
	wallRoachesObj.Parent = workspace
	managedObj_4:Add(Observers.observeTag("HideInMexico", function(ref3)
		local Parent = ref3.Parent
		ref3.Parent = script

		return function()

			pcall(function()

				ref3.Parent = Parent
			end)
		end
	end, {
		workspace,
		script
	}))
	EffectController:Activate("Blink")
	CycleController:Update()
	SoundController:UpdateOST()
	EffectController:Run("MexicoEvent", "GrassRecolor")
	managedObj_4:Add(function()

		EffectController:Stop("MexicoEvent", "GrassRecolor")
	end)
	EffectController:Run("MexicoEvent", "WallRecolor")
	managedObj_4:Add(function()

		EffectController:Stop("MexicoEvent", "WallRecolor")
	end)
	EffectController:Run("MexicoEvent", "WallBottomRecolor")
	managedObj_4:Add(function()

		EffectController:Stop("MexicoEvent", "WallBottomRecolor")
	end)
	managedObj_4:Add(Observers.observeTag("Roach", function(parent)

		local addObj = Trove.new()
		local HumanoidRootPart = parent:WaitForChild("HumanoidRootPart")
		local part0 = addObj:Clone(script.Cockroach)
		local weld = addObj:Add(Instance.new("Weld"))
		weld.Part0 = part0.PrimaryPart
		weld.Part1 = HumanoidRootPart
		weld.Parent = part0.PrimaryPart
		part0.Parent = parent
		local AnimationController = part0:FindFirstChild("AnimationController")
		if AnimationController then
			AnimationController:Destroy()
		end
		local humanoid = Instance.new("Humanoid", part0)
		local animator = Instance.new("Animator", humanoid)
		humanoid.Name = "AnimationController"
		humanoid.EvaluateStateMachine = false
		humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		humanoid.PlatformStand = true
		humanoid.Parent = part0
		local Animator = part0.AnimationController.Animator
		local tweenObj_2 = Animator:LoadAnimation(script.TakeHat)
		tweenObj_2.Looped = false
		tweenObj_2.Priority = Enum.AnimationPriority.Action3
		local tweenObj_3 = Animator:LoadAnimation(script.PutHat)
		tweenObj_3.Looped = false
		tweenObj_3.Priority = Enum.AnimationPriority.Action4
		addObj:Add(parent:GetAttributeChangedSignal("AttackAnimation"):Connect(function()

			tweenObj_3:Play()
		end))
		parent:SetAttribute("Shuffle", false)
		addObj:Add(Observers.observeAttribute(parent, "Shuffle", function(flag_6)

			if flag_6 then
				local wrapCleanObj = Trove.new()
				local managedObj_5 = Animator:LoadAnimation(script.Shuffle);
				(wrapCleanObj or managedObj_4):Add(function()

					managedObj_5:Stop(0)
					managedObj_5:Destroy()
				end)
				local v77 = managedObj_5
				v77.Looped = true
				v77:Play()
				v77:AdjustSpeed(1.5)

				return wrapCleanObj:WrapClean()
			else

				return Observers.observeAttribute(parent, "Instrument", function(formatArg)

					local addObj_2 = Trove.new()
					if formatArg == "Sombrero" then
						tweenObj_2:Play()
						VFX.disable(part0.RootPart.VFX)
					else
						VFX.enable(part0.RootPart.VFX)
					end
					local ref4 = Animator:LoadAnimation(script:FindFirstChild((("RoachWalk%*"):format(formatArg))) or script.RoachWalk)
					local v81 = ref4;
					(addObj_2 or managedObj_4):Add(function()

						v81:Stop(0)
						v81:Destroy()
					end)
					local v81_2 = ref4
					v81_2.Priority = Enum.AnimationPriority.Action2
					addObj_2:Add(Observers.observeAttribute(parent, "IsRunning", function(flag_7)

						if flag_7 then
							v81_2:Play()
						else
							v81_2:Stop()
						end

						return nil
					end))
					local flag = script.Instruments:FindFirstChild(formatArg)
					local cloneResult = nil
					if flag then
						cloneResult = addObj_2:Clone(flag)
						if cloneResult.PrimaryPart then
							ref4 = Instance.new("Weld")
							ref4.Part0 = cloneResult.PrimaryPart
							ref4.Part1 = part0.PrimaryPart
							ref4.C0 = CFrame.new(0, 3.5, 0)
							ref4.Parent = cloneResult.PrimaryPart
						end

						for _, child in cloneResult:GetChildren() do
							local ref1 = child:FindFirstChildOfClass("RigidConstraint")
							if ref1 then
								local Attachment0 = ref1.Attachment0
								if Attachment0 then
									local l_v67_FirstChild_0 = part0:FindFirstChild(Attachment0.Name, true)
									if l_v67_FirstChild_0 then
										ref1.Attachment1 = l_v67_FirstChild_0
									end
								end
							end
						end
						cloneResult.Parent = part0.PrimaryPart
					end
					addObj_2:Add(Observers.observeAttribute(parent, "Dance", function(flag_8)

						if not flag_8 then

							return nil
						else
							local addObj_3 = Trove.new()
							local l_script_FirstChild_0 = script:FindFirstChild((("Roach%*"):format(formatArg)))
							local tweenObj_4 = nil
							if l_script_FirstChild_0 then
								local l_script_FirstChild_0Track = Animator:LoadAnimation(l_script_FirstChild_0)
								local v96 = l_script_FirstChild_0Track;
								(addObj_3 or managedObj_4):Add(function()

									v96:Stop(0)
									v96:Destroy()
								end)
								tweenObj_4 = l_script_FirstChild_0Track
								tweenObj_4.Looped = true
								tweenObj_4.Priority = Enum.AnimationPriority.Action
								tweenObj_4:Play()
								if formatArg == "Maracas" then
									tweenObj_4:AdjustSpeed(0.65)
								end
							end
							local tweenObj_5 = nil
							if cloneResult and cloneResult:FindFirstChild("AnimationController") then
								local l_script_FirstChild_1 = script:FindFirstChild(formatArg)
								if l_script_FirstChild_1 then
									local l_script_FirstChild_1Track = cloneResult.AnimationController.Animator:LoadAnimation(l_script_FirstChild_1)
									local v100 = l_script_FirstChild_1Track;
									(addObj_3 or managedObj_4):Add(function()

										v100:Stop(0)
										v100:Destroy()
									end)
									tweenObj_5 = l_script_FirstChild_1Track
									tweenObj_5.Looped = true
									tweenObj_5.Priority = Enum.AnimationPriority.Action
									tweenObj_5:Play()
									if tweenObj_4 then
										managedObj_4:Add(tweenObj_4.DidLoop:Connect(function()

											tweenObj_5.TimePosition = 0
										end))
									end
								end
								local l_script_FirstChild_2 = script:FindFirstChild((("Walk%*"):format(formatArg)))
								if l_script_FirstChild_2 then
									local l_script_FirstChild_2Track = cloneResult.AnimationController.Animator:LoadAnimation(l_script_FirstChild_2);
									(addObj_3 or managedObj_4):Add(function()

										l_script_FirstChild_2Track:Stop(0)
										l_script_FirstChild_2Track:Destroy()
									end)
									local v103 = l_script_FirstChild_2Track
									v103.Priority = Enum.AnimationPriority.Action2
									addObj_3:Add(Observers.observeAttribute(parent, "IsRunning", function(flag_2)

										if flag_2 then
											v103:Play()
										else
											v103:Stop()
										end

										return nil
									end))
								end
							end
							addObj_3:Add(setupSpeedTracks({
								tweenObj_4,
								tweenObj_5
							}))

							return addObj_3:WrapClean()
						end
					end))

					return addObj_2:WrapClean()
				end)
			end
		end))
		local serverTimeNow = math.max(l_v15_ActiveEventData_0.startedAt + 28.5 - workspace:GetServerTimeNow(), 0)
		addObj:Add(managedObj_4:Add(task.delay(serverTimeNow, function()

			parent:SetAttribute("Shuffle", true)
			addObj:Add(managedObj_4:Add(task.delay(math.max(l_v15_ActiveEventData_0.startedAt + 34.5 - workspace:GetServerTimeNow(), 0), function()

				parent:SetAttribute("Shuffle", false)
			end)))
		end)))

		return addObj:WrapClean()
	end))

	for _, child_2 in wallRoachesObj.WallRoaches:GetChildren() do
		local attribute = child_2:GetAttribute("Instrument") or "Violin"
		local pivotToObj = managedObj_4:Clone(script.Wall)
		pivotToObj:PivotTo(child_2:GetPivot())
		for _, child_3 in pivotToObj.Instruments:GetChildren() do
			if child_3.Name ~= attribute then
				child_3:Destroy()
			end
		end
		pivotToObj.Parent = workspace
		local managedObj = pivotToObj.Cockroach.AnimationController.Animator:LoadAnimation(script[("Roach%*"):format(attribute)])
		managedObj_4:Add(function()

			managedObj:Stop(0)
			managedObj:Destroy()
		end)
		local v113 = managedObj
		v113:Play()
		local managedObj_2 = pivotToObj.Instruments[attribute].AnimationController.Animator:LoadAnimation(script[attribute])
		managedObj_4:Add(function()

			managedObj_2:Stop(0)
			managedObj_2:Destroy()
		end)
		local v115 = managedObj_2
		v115:Play()
		managedObj_4:Add(v113.DidLoop:Connect(function()

			v115.TimePosition = 0
		end))
		local val1 = {
			v115,
			v113
		}
		managedObj_4:Add(playTracksSynced(val1))
		managedObj_4:Add(setupSpeedTracks(val1))
	end
	managedObj_4:Add(task.spawn(function()
		ReplicatedStorage:SetAttribute("MexicoEventMusic", true)
		MexicoEvent.TimePosition = workspace:GetServerTimeNow() - l_v15_ActiveEventData_0.startedAt
		SoundController:UpdateOST()
		managedObj_4:Add(function()
			MexicoEvent:Stop()
			ReplicatedStorage:SetAttribute("MexicoEventMusic", nil)
		end)
	end))
	managedObj_4:Add(eventServiceMexicoBurst.OnClientEvent:Connect(function(val2)

		ClientEventUtils.playBurst(script.Burst, val2, {
			ReplicatedStorage.Sounds.Events.Mexico.Hit
		})
	end))
	managedObj_4:Add(task.delay(math.max(l_v15_ActiveEventData_0.startedAt + 28.5 - workspace:GetServerTimeNow(), 0), function()

		local _unused = managedObj_4:Add(Signal.new())
		local _unused = managedObj_4:Add(Observers.observeCharacters(function(_, parent_2)

			local managedObj_3 = Trove.new()
			managedObj_3:Add(task.spawn(function()

				local Humanoid = parent_2:WaitForChild("Humanoid")
				if not Humanoid then
					return
				else
					local Animator_2 = Humanoid:WaitForChild("Animator")
					if not Animator_2 then
						return
					else
						local tweenObj = Animator_2:LoadAnimation(script.PlayerDance)
						tweenObj.Priority = Enum.AnimationPriority.Action
						local flag_3 = nil

						local function tryCreateMaracas()

							if flag_3 then
								return
							else
								local getChildrenObj = managedObj_3:Clone(script.PlayerMaracas)
								for _, child_4 in getChildrenObj:GetChildren() do
									local ref2 = child_4:FindFirstChildOfClass("RigidConstraint")
									if ref2 then
										local Attachment0_2 = ref2.Attachment0
										if Attachment0_2 then
											local l_v121_FirstChild_0 = parent_2:FindFirstChild(Attachment0_2.Name, true)
											if l_v121_FirstChild_0 and l_v121_FirstChild_0:IsA("Attachment") then
												ref2.Attachment1 = l_v121_FirstChild_0
											end
										end
									end
								end
								getChildrenObj.Parent = parent_2
								flag_3 = getChildrenObj
								return
							end
						end

						local function _()

							if flag_3 then
								managedObj_3:Remove(flag_3)
								flag_3 = nil
							end
						end
						local flag_4 = 0
						managedObj_3:Add(RunService.PostSimulation:Connect(function(val3)

							debug.profilebegin("Mexico:Player:Dance")
							local serverTimeNow = workspace:GetServerTimeNow()
							if math.max(l_v15_ActiveEventData_0.startedAt + 43.5 - workspace:GetServerTimeNow(), 0) > 0 then
								if not tweenObj.IsPlaying then
									tweenObj:Play()
									tryCreateMaracas()
								end
								debug.profileend()
								return
							else
								if not (Humanoid.MoveDirection ~= Vector3.new(0, 0, 0, 0)) and not LocalPlayer:GetAttribute("Stealing") then
									if flag_4 < 3 then
										flag_4 = flag_4 + val3
									elseif not tweenObj.IsPlaying then
										tweenObj:Play()
										tryCreateMaracas()
									end
								else
									flag_4 = 0
									if tweenObj.IsPlaying then
										tweenObj:Stop()
										if flag_3 then
											managedObj_3:Remove(flag_3)
											flag_3 = nil
										end
									end
								end
								debug.profileend()
								return
							end
						end))
						managedObj_3:Add(function()

							tweenObj:Stop()
							tweenObj:Destroy()
						end)
						return
					end
				end
			end))

			return managedObj_3:WrapClean()
		end))
	end))
end

data.OnStop = function(_)

	managedObj_4:Destroy()
end

data.OnLoad = function(_)

	task.spawn(pcall, function()

		ContentProvider:PreloadAsync(script:GetChildren())
	end)
	task.spawn(function()
		ContentProvider:PreloadAsync({
			MexicoEvent
		})
	end)
end

return data
