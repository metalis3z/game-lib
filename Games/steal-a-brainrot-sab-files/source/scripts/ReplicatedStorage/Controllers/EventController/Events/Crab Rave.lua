
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

local EventTypes = require(ReplicatedStorage.Shared.EventTypes)

local data = {}

local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)

local CameraController = require(ReplicatedStorage.Controllers.CameraController)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Observers = require(ReplicatedStorage.Packages.Observers)
local TweenPivot = require(ReplicatedStorage.Shared.TweenPivot)
local ServerData = require(ReplicatedStorage.Datas.ServerData)
local Signal = require(ReplicatedStorage.Packages.Signal)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)

local eventServiceCrabRaveHit = Net:RemoteEvent("EventService/Crab Rave/Hit")

local LocalPlayer = Players.LocalPlayer

local CrabRave = workspace.Sounds.CrabRave

local Name = script.Name

local managedObj = Trove.new()

data.OnStart = function(_)

	local l_v15_ActiveEventData_0 = EventController:GetActiveEventData(Name)
	assert(l_v15_ActiveEventData_0)
	ReplicatedStorage:SetAttribute("CrabRave", true)
	managedObj:Add(function()

		ReplicatedStorage:SetAttribute("CrabRave", nil)
		CycleController:Update()
		SoundController:UpdateOST()
	end)
	managedObj:Add(task.spawn(function()

		while not CrabRave.IsLoaded do
			task.wait()
		end
		CrabRave.TimePosition = math.max(CrabRave.TimePosition, workspace:GetServerTimeNow() - l_v15_ActiveEventData_0.startedAt)
	end))
	CycleController:Update()
	SoundController:UpdateOST()
	local flag_5 = ServerData.IsTsunamiServer()
	local colorCorrectionEffect = managedObj:Add(Instance.new("ColorCorrectionEffect"))
	colorCorrectionEffect.Parent = workspace.CurrentCamera

	local function _(val9, val10)

		return l_v15_ActiveEventData_0.startedAt + val9 - (val10 or workspace:GetServerTimeNow())
	end
	local findFirstChildResult = nil
	local findFirstChildObj = if ServerData.IsBiggerServer() then managedObj:Clone(script.OceanBigger) else managedObj:Clone(script.Ocean)
	local val11 = ServerData.IsBiggerServer() and 902 or 400
	local val12 = 45
	if flag_5 then
		local Areas = workspace.Map:FindFirstChild("Areas")
		local getPivotObj = Areas and Areas:FindFirstChild("1")
		if getPivotObj then
			local l_v42_Pivot_0 = getPivotObj:GetPivot()
			local val13 = l_v42_Pivot_0.Position.X + getPivotObj.Size.X / 2
			findFirstChildObj:PivotTo(CFrame.new(val13, l_v42_Pivot_0.Position.Y + 0.2, l_v42_Pivot_0.Position.Z) * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966))
			val11 = getPivotObj.Size.X
			val12 = 45 * (getPivotObj.Size.X / 400)
			local width0 = getPivotObj.Size.Z
			for _, descendant in findFirstChildObj:GetDescendants() do
				if descendant:IsA("Beam") then
					descendant.Width0 = width0
					descendant.Width1 = width0
				end
			end
		end
	end
	findFirstChildObj.Parent = workspace
	local ocean = findFirstChildObj:FindFirstChild("ocean")
	local att1 = findFirstChildObj:FindFirstChild("att1")
	findFirstChildResult = findFirstChildObj:FindFirstChild("oceanparticles")
	for _, child in findFirstChildObj:GetChildren() do
		if child:IsA("Beam") then
			local TextureLength = child.TextureLength
			child.TextureLength = 0
			if ocean then
				TweenService:Create(ocean, TweenInfo.new(l_v15_ActiveEventData_0.startedAt + val12 - workspace:GetServerTimeNow(), Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
					TextureLength = TextureLength
				}):Play()
			end
		end
	end

	if att1 then
		TweenService:Create(att1, TweenInfo.new(l_v15_ActiveEventData_0.startedAt + val12 - workspace:GetServerTimeNow(), Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
			Position = Vector3.new(0, 0, val11)
		}):Play()
	end
	local highlight = managedObj:Add(Instance.new("Highlight"))
	assert(highlight)
	highlight.DepthMode = Enum.HighlightDepthMode.Occluded
	highlight.FillColor = Color3.new(1, 1, 1)
	highlight.FillTransparency = 1
	highlight.OutlineTransparency = 1
	TweenService:Create(colorCorrectionEffect, TweenInfo.new(l_v15_ActiveEventData_0.startedAt + 1.95 - workspace:GetServerTimeNow()), {
		Brightness = -1.2
	}):Play()
	if findFirstChildResult then
		managedObj:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 45 - workspace:GetServerTimeNow(), function()

			VFX.enable(findFirstChildResult)
		end))
	end
	EffectController:Run("CrabRaveEvent", "GrassRecolor")
	managedObj:Add(function()

		EffectController:Stop("CrabRaveEvent", "GrassRecolor")
	end)
	managedObj:Add(function()

		EffectController:Activate("Blink")
	end)
	managedObj:Add(Observers.observeTag("CrabRaveCrabFolder", function(parent)

		if highlight then
			highlight.Parent = parent
		end

		return nil
	end))
	managedObj:Add(Observers.observeTag("CrabRaveCrabs", function(part1)

		local managedObj_2 = Trove.new()
		local Name_2 = part1.Parent.Name
		local part0 = managedObj_2:Clone(script.Crab)
		local cloneResult = nil
		local cloneResult_2 = nil

		local function _(val14)

			local v61Track = part0.AnimationController:LoadAnimation(val14)
			managedObj_2:Add(function()

				v61Track:Stop(0)
				v61Track:Destroy()
			end)

			return v61Track
		end
		part0["Cylinder.005"].Transparency = 1
		managedObj_2:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 2 - workspace:GetServerTimeNow(), function()

			part0["Cylinder.005"].Transparency = 0
		end))
		local weld = managedObj_2:Add(Instance.new("Weld"))
		weld.Part0 = part0["Cylinder.005"]
		weld.Part1 = part1.HumanoidRootPart
		weld.C1 = CFrame.new(0, 3.6, 0)
		weld.Parent = part0
		if FFlags:GetInstant("Optimisation.HumanoidBrainrotModels") or require(ReplicatedStorage.Shared.GetServerType):IsPublicServer() then
			local AnimationController = part1:FindFirstChild("AnimationController")
			if AnimationController then
				AnimationController:Destroy()
			end
			local humanoid = Instance.new("Humanoid", part1)
			local animator = Instance.new("Animator", humanoid)
			humanoid.Name = "AnimationController"
			humanoid.EvaluateStateMachine = false
			humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			humanoid.PlatformStand = true
			humanoid.Parent = part1
		end
		local val15 = 0
		local val16 = 0
		local c1 = CFrame.new(0, 3.6, 0)
		managedObj_2:Add(RunService.PostSimulation:Connect(function(val17)

			debug.profilebegin("Crab Rave:Crab:Rotate")
			if math.abs(val16 - val15) < 0.1 then
				return
			else
				val15 = val16 + (val15 - val16) * math.exp(val17 * -1)
				weld.C1 = c1 * CFrame.Angles(0, val15, 0)
				debug.profileend()
				return
			end
		end))
		part0.Parent = part1
		local Animation1 = script.Animation1
		local l_Animation1_0Track = part0.AnimationController:LoadAnimation(Animation1)
		local v73 = l_Animation1_0Track
		managedObj_2:Add(function()

			v73:Stop(0)
			v73:Destroy()
		end)
		local v73_2 = l_Animation1_0Track
		l_Animation1_0Track = script.Animation2
		local v73Track = part0.AnimationController:LoadAnimation(l_Animation1_0Track)
		local v76 = v73Track
		managedObj_2:Add(function()

			v76:Stop(0)
			v76:Destroy()
		end)
		Animation1 = v73Track
		v73Track = script.Animation3_Right
		local v76Track = part0.AnimationController:LoadAnimation(v73Track)
		local v78 = v76Track
		managedObj_2:Add(function()

			v78:Stop(0)
			v78:Destroy()
		end)
		l_Animation1_0Track = v76Track
		v76Track = script.Animation3_Left
		local v78Track = part0.AnimationController:LoadAnimation(v76Track)
		local v80 = v78Track
		managedObj_2:Add(function()

			v80:Stop(0)
			v80:Destroy()
		end)
		v73Track = v78Track
		v73Track.Priority = Enum.AnimationPriority.Action
		v78Track = script.Animation4_Walk
		local v80Track = part0.AnimationController:LoadAnimation(v78Track)
		local v82 = v80Track
		managedObj_2:Add(function()

			v82:Stop(0)
			v82:Destroy()
		end)
		v76Track = v80Track
		v76Track.Priority = Enum.AnimationPriority.Action
		v80Track = script.Animation4_Attack
		local v82Track = part0.AnimationController:LoadAnimation(v80Track)
		local v84 = v82Track
		managedObj_2:Add(function()

			v84:Stop(0)
			v84:Destroy()
		end)
		v78Track = v82Track
		v78Track.Priority = Enum.AnimationPriority.Action4
		v80Track = v76Track
		v82Track = function(val18, val19)

			if v80Track == val18 then
				return
			else
				local IsPlaying = v80Track.IsPlaying
				if IsPlaying then
					v80Track:Stop()
				end
				v80Track = val18
				if IsPlaying and not val19 then
					v80Track:Play()
				end
				return
			end
		end
		v73_2:Play()
		managedObj_2:Add(part1:GetAttributeChangedSignal("IsRunning"):Connect(function()

			if part1:GetAttribute("IsRunning") then
				if not v80Track.IsPlaying then
					v80Track:Play()
				end

				if cloneResult then
					cloneResult.ParticleEmitter.Enabled = true
				end

				if cloneResult_2 then
					cloneResult_2.ParticleEmitter.Enabled = true
					return
				end
			else
				if v80Track.IsPlaying then
					v80Track:Stop()
				end

				if cloneResult then
					cloneResult.ParticleEmitter.Enabled = false
				end

				if cloneResult_2 then
					cloneResult_2.ParticleEmitter.Enabled = false
				end
			end
		end))
		managedObj_2:Add(part1:GetAttributeChangedSignal("Attack"):Connect(function()

			v78Track:Play()
		end))
		local Animation5 = script.Animation5
		local l_Animation5_0Track = part0.AnimationController:LoadAnimation(Animation5)
		local v90 = l_Animation5_0Track
		managedObj_2:Add(function()

			v90:Stop(0)
			v90:Destroy()
		end)
		local v90_2 = l_Animation5_0Track
		v90_2.Priority = Enum.AnimationPriority.Action2
		l_Animation5_0Track = script.Animation6
		local v90Track = part0.AnimationController:LoadAnimation(l_Animation5_0Track)
		local v93 = v90Track
		managedObj_2:Add(function()

			v93:Stop(0)
			v93:Destroy()
		end)
		Animation5 = v90Track
		Animation5.Priority = Enum.AnimationPriority.Action2
		v90Track = script.Animation7
		local v93Track = part0.AnimationController:LoadAnimation(v90Track)
		local v95 = v93Track
		managedObj_2:Add(function()

			v95:Stop(0)
			v95:Destroy()
		end)
		l_Animation5_0Track = v93Track
		l_Animation5_0Track.Priority = Enum.AnimationPriority.Action2
		v93Track = script.Animation8
		local v95Track = part0.AnimationController:LoadAnimation(v93Track)
		local v97 = v95Track
		managedObj_2:Add(function()

			v97:Stop(0)
			v97:Destroy()
		end)
		v90Track = v95Track
		v90Track.Priority = Enum.AnimationPriority.Action2
		v93Track = {
			[1] = v90_2,
			[2] = Animation5,
			[3] = l_Animation5_0Track,
			[4] = v90Track
		}
		v95Track = nil
		managedObj_2:Add(part1:GetAttributeChangedSignal("Dance"):Connect(function()
			local attribute = nil
			local serverTimeNow = l_v15_ActiveEventData_0.startedAt + 85 - workspace:GetServerTimeNow()
			local serverTimeNow_2 = l_v15_ActiveEventData_0.startedAt + 105 - workspace:GetServerTimeNow()

			attribute = serverTimeNow <= 0 and serverTimeNow_2 > 0 and 4 or part1:GetAttribute("Dance")

			if attribute and v93Track[attribute] and v95Track == v93Track[attribute] then
				return
			else
				if v95Track then
					v95Track:Stop()
					v95Track = nil
				end

				if attribute ~= nil then
					v95Track = v93Track[attribute]
					if v95Track then
					    v95Track:Play()
					end
					local globalElapsed = workspace:GetServerTimeNow() - l_v15_ActiveEventData_0.startedAt
					if v95Track and v95Track.Length > 0 then
						v95Track.TimePosition = globalElapsed % v95Track.Length
					end
				end
				return
			end
		end))
		local cloneResult_3 = nil
		managedObj_2:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 7 - workspace:GetServerTimeNow(), function()

			v73_2:Stop()
			Animation1:Play()
		end))

		if Name_2 == "Ground" then
			managedObj_2:Add(part1:GetAttributeChangedSignal("ReachedFirstTarget"):Once(function()

				cloneResult_3 = managedObj_2:Clone(script.SanddrumRoll)
				local weld_2 = managedObj_2:Add(Instance.new("Weld"))
				weld_2.Part0 = cloneResult_3
				weld_2.Part1 = part0["Cylinder.005"]
				weld_2.C0 = CFrame.new(0.2, 3.629, 4.378)
				weld_2.Parent = cloneResult_3
				cloneResult_3.Parent = part0
			end))
		end
		managedObj_2:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 27.5 - workspace:GetServerTimeNow(), function()

			if Name_2 == "Ground" then
				local pivot = part1:GetPivot()
				if cloneResult_3 then
					local v102 = cloneResult_3
					v102.ParticleEmitter.Enabled = false
					local l_v102_0 = v102
					task.delay(3, function()

						managedObj_2:Remove(l_v102_0)
					end)
					cloneResult_3 = nil
				end
				local v76_2 = v73Track
				if v80Track ~= v76_2 then
					if v80Track.IsPlaying then
						v80Track:Stop()
					end
					v80Track = v76_2
				end
				v73Track:Play(nil, nil, 0.3333333333333333)
				val16 = 1.5707963267948966
			end
		end))
		managedObj_2:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 31 - workspace:GetServerTimeNow(), function()

			if Name_2 == "Ground" then
				v73Track:AdjustSpeed(1)
				cloneResult = managedObj_2:Clone(script.WalkPart)
				assert(cloneResult)
				local weld_3 = managedObj_2:Add(Instance.new("Weld"))
				weld_3.Part0 = cloneResult
				weld_3.Part1 = part0["Cylinder.005"]
				weld_3.C0 = CFrame.new(0.614, 3.129, 4.731) * CFrame.fromOrientation(0, -1.5707963267948966, 0)
				weld_3.Parent = cloneResult
				cloneResult.Parent = part0
				cloneResult_2 = managedObj_2:Clone(script.WalkPart)
				assert(cloneResult_2)
				local weld_4 = managedObj_2:Add(Instance.new("Weld"))
				weld_4.Part0 = cloneResult_2
				weld_4.Part1 = part0["Cylinder.005"]
				weld_4.C0 = CFrame.new(0.414, 3.129, -4.78) * CFrame.fromOrientation(0, -1.5707963267948966, 0)
				weld_4.Parent = cloneResult_2
				cloneResult_2.Parent = part0
				return
			else
				if Name_2 == "Wall" then
					Animation1:Stop()
					v73_2:Play()
				end
				return
			end
		end))
		managedObj_2:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 43 - workspace:GetServerTimeNow(), function()

			l_Animation1_0Track:Play(nil, nil, 0.3333333333333333)
			val16 = 0
		end))
		managedObj_2:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 46 - workspace:GetServerTimeNow(), function()

			l_Animation1_0Track:Stop()
			local v78_2 = v76Track
			if v80Track ~= v78_2 then
				local IsPlayingv80Track = v80Track.IsPlaying
				if IsPlayingv80Track then
					v80Track:Stop()
				end
				v80Track = v78_2
				if IsPlayingv80Track then
					v80Track:Play()
				end
			end

			if Name_2 == "Wall" then
				Animation1:Stop()
				v73_2:Play()
			end
		end))
		managedObj_2:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 141 - workspace:GetServerTimeNow(), function()

			local serverTimeNow_3 = l_v15_ActiveEventData_0.startedAt + 161 - workspace:GetServerTimeNow()
			local val1 = 0
			managedObj_2:Add(RunService.PreSimulation:Connect(function(val2)

				debug.profilebegin("Crab Rave:Crab:Adjust Dance Speed")
				val1 = val1 + val2
				local val3 = math.lerp(1, 0.1, val1 / serverTimeNow_3)
				v90_2:AdjustSpeed(val3)
				Animation5:AdjustSpeed(val3)
				l_Animation5_0Track:AdjustSpeed(val3)
				v90Track:AdjustSpeed(val3)
				debug.profileend()
			end))
		end))

		return function()

			managedObj_2:Destroy()
		end
	end))
	local _unused = workspace.CurrentCamera
	local flag = 0
	local val4 = 0
	managedObj:Add(RunService.PostSimulation:Connect(function(val5)

		debug.profilebegin("Crab Rave:Update")
		val4 = val4 - val5
		flag = flag - val5
		local flag_2 = math.clamp((CrabRave.PlaybackLoudness - 100) / 900, 0, 1)
		if flag <= 0 and highlight then
			flag = 0.5
			highlight.FillTransparency = 0
			TweenService:Create(highlight, TweenInfo.new(0.3), {
				FillTransparency = 1
			}):Play()
		end

		if flag_2 >= 0.25 and val4 <= 0 then
			val4 = 0.1
			CameraController:Fov((flag_2 - 0.25) * 20 + 70, 0.1)
		end
		debug.profileend()
	end))
	managedObj:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 7 - workspace:GetServerTimeNow(), function()

		if highlight then
			highlight:Destroy()
			highlight = nil
		end
		local tweenInfo = TweenService:Create(colorCorrectionEffect, TweenInfo.new(1), {
			Brightness = 0
		})
		tweenInfo:Play()
		tweenInfo.Completed:Once(function()

			tweenInfo:Cancel()
			tweenInfo:Destroy()
		end)
	end))
	managedObj:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 46 - workspace:GetServerTimeNow(), function()

		local _unused = managedObj:Add(Signal.new())
		local val7 = managedObj:Add(Observers.observeCharacter(Players.LocalPlayer, function(_, waitForChildObj)

			local addObj = Trove.new()
			addObj:Add(task.spawn(function()

				local Humanoid = waitForChildObj:WaitForChild("Humanoid")
				if not Humanoid then
					return
				else
					local Animator = Humanoid:WaitForChild("Animator")
					if not Animator then
						return
					else
						local tweenObj = Animator:LoadAnimation(script.Dance)
						tweenObj.Priority = Enum.AnimationPriority.Action
						tweenObj:Play(2)
						local flag_3 = 0
						local flag_4 = 0
						addObj:Add(RunService.PostSimulation:Connect(function(val6)

							debug.profilebegin("Crab Rave:Player:Dance")
							local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow()
							if l_v15_ActiveEventData_0.startedAt + 66 - (l_workspace_ServerTimeNow_0 or workspace:GetServerTimeNow()) > 0 then
								if not tweenObj.IsPlaying then
									tweenObj:Play()
									tweenObj.TimePosition = (l_workspace_ServerTimeNow_0 - l_v15_ActiveEventData_0.startedAt) % tweenObj.Length
								end
								debug.profileend()
								return
							else
								local Length = tweenObj.Length
								if flag_4 ~= Length and Length > 0 then
									flag_4 = Length
									tweenObj.TimePosition = (l_workspace_ServerTimeNow_0 - l_v15_ActiveEventData_0.startedAt) % Length
								end

								if not (Humanoid.MoveDirection ~= Vector3.new(0, 0, 0, 0)) and not LocalPlayer:GetAttribute("Stealing") then
									if flag_3 < 3 then
										flag_3 = flag_3 + val6
									elseif not tweenObj.IsPlaying then
										tweenObj:Play()
										tweenObj.TimePosition = (l_workspace_ServerTimeNow_0 - l_v15_ActiveEventData_0.startedAt) % tweenObj.Length
									end
								else
									flag_3 = 0
									if tweenObj.IsPlaying then
										tweenObj:Stop()
									end
								end
								debug.profileend()
								return
							end
						end))
						addObj:Add(function()

							tweenObj:Stop()
							tweenObj:Destroy()
						end)
						return
					end
				end
			end))

			return addObj:WrapClean()
		end))
		managedObj:Add(task.delay(l_v15_ActiveEventData_0.startedAt + 140 - workspace:GetServerTimeNow(), val7))
	end))
end

data.OnStop = function(_)

	managedObj:Destroy()
end

data.OnLoad = function(_)

	task.spawn(pcall, function()

		ContentProvider:PreloadAsync(script:GetChildren())
	end)
	eventServiceCrabRaveHit.OnClientEvent:Connect(function(val8)

		if not data.Active then
			return
		else
			ClientEventUtils.playBurst(script.CrabHit, val8)
			return
		end
	end)
end

return data
