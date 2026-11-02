

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

local EventTypes = require(ReplicatedStorage.Shared.EventTypes)

local data = {}

local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local Observers = require(ReplicatedStorage.Packages.Observers)
local MathUtils = require(ReplicatedStorage.Utils.MathUtils)
local Signal = require(ReplicatedStorage.Packages.Signal)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Net = require(ReplicatedStorage.Packages.Net)
local Spr = require(ReplicatedStorage.Packages.Spr)
local VFX = require(ReplicatedStorage.Shared.VFX)

local Name = script.Name

local LocalPlayer = Players.LocalPlayer

local remoteObj = Net:RemoteEvent((("EventService/%*/CollectCandy"):format(Name)))
local onClientEventObj = Net:RemoteEvent((("EventService/%*/DestroyRings"):format(Name)))
local onClientEventObj_2 = Net:RemoteEvent((("EventService/%*/CreateRings"):format(Name)))
local onClientEventObj_3 = Net:RemoteEvent((("EventService/%*/UpdateRide"):format(Name)))
local onClientEventObj_4 = Net:RemoteEvent((("EventService/%*/Burst"):format(Name)))

local managedObj_3 = Trove.new()

local function _(loadAnimationObj, val2, val3)

	local v33Track = loadAnimationObj:LoadAnimation(val2);
	(val3 or managedObj_3):Add(function()

		v33Track:Stop(0)
		v33Track:Destroy()
	end)

	return v33Track
end

data.OnStart = function(_)

	assert((EventController:GetActiveEventData(Name)))
	local Cartoon = Lighting:FindFirstChild("Cartoon")
	if Cartoon then
		Cartoon.Parent = script
		managedObj_3:Add(function()

			Cartoon.Parent = Lighting
		end)
	end
	managedObj_3:Clone(script.NightSky).Parent = Lighting
	local ringsObj = managedObj_3:Clone(script.GingerbreadTown)
	local subCollector = managedObj_3:Extend()
	local flag_5 = nil
	local val4 = nil

	local function _(flag_6, val5, val6)
		local val7 = math.clamp((flag_6 - val5) / val6, 0, 1)
		local val8 = true
		if flag_6 >= val5 then
			val8 = val5 + val6 < flag_6
		end

		return val7, val8
	end
	managedObj_3:Add(onClientEventObj_3.OnClientEvent:Connect(function(val9, val10)

		flag_5 = val9
		val4 = val10
	end))
	local subCollector = managedObj_3:Extend()
	local data_2 = {}
	managedObj_3:Add(onClientEventObj_2.OnClientEvent:Connect(function(connections)

		if not LocalPlayer:GetAttribute("SleighSeated") then
			return
		else
			for v53EntryId, v53Entry in connections do
				local subCollector_2 = subCollector:Extend()
				local children = ringsObj.Rings:GetChildren()[v53Entry.ring].Candycane
				local pivotToObj = subCollector_2:Clone(script.Drop)
				pivotToObj:PivotTo(children:GetPivot())
				pivotToObj.BillboardGui.CurrencyCandyCane.Text = ("+%*"):format(v53Entry.amount)
				pivotToObj.Parent = workspace
				local ref3 = subCollector_2:Clone(script.ActivatedCandyCaneVFX.Attachment)
				ref3.Parent = children
				table.insert(data_2, {
					ringTrove = subCollector_2,
					vfx = ref3,
					ring = v53Entry.ring,
					amount = v53Entry.amount,
					uuid = v53EntryId,
					drop = pivotToObj
				})
			end
			return
		end
	end))
	managedObj_3:Add(onClientEventObj.OnClientEvent:Connect(function()

		subCollector:Clean()
		table.clear(data_2)
	end))

	local function createSyncedAnimator(loadAnimationObj_2, val11, flag_7)

		local addObj = Trove.new()
		local v61Track = loadAnimationObj_2:LoadAnimation(val11);
		(addObj or managedObj_3):Add(function()

			v61Track:Stop(0)
			v61Track:Destroy()
		end)
		local v64 = v61Track
		addObj:Add(RunService.PreRender:Connect(function()

			if not flag_5 or not val4 then
				return
			else
				local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow()
				local v41 = flag_5
				local v42 = val4
				local val12 = math.clamp((l_workspace_ServerTimeNow_0 - v41) / v42, 0, 1)
				local flag_8 = true
				if l_workspace_ServerTimeNow_0 >= v41 then
					flag_8 = v41 + v42 < l_workspace_ServerTimeNow_0
				end
				l_workspace_ServerTimeNow_0 = val12 * val4
				v41 = v64.TimePosition
				v42 = true
				if flag_8 then
					if v64.IsPlaying then
						v64.TimePosition = 0
						v64:Stop(0)
					end
					v42 = false
				elseif math.abs(l_workspace_ServerTimeNow_0 - v41) > 0.1 then
					if not v64.IsPlaying then
						v64:Play()
					end
					v64.TimePosition = l_workspace_ServerTimeNow_0
				end

				if flag_7 then
					flag_7(v42, l_workspace_ServerTimeNow_0)
				end
				return
			end
		end))

		return addObj:WrapClean()
	end

	local function playCharacterAnimation(ref4, val13)

		local Character = ref4.Character
		if not Character then
			return
		else
			local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
			if not HumanoidRootPart then
				return
			else
				local managedObj_4 = script.Reward:Clone()
				managedObj_4.CurrencyCandyCane.Text = ("+%*"):format(val13)
				managedObj_4.Parent = HumanoidRootPart
				TweenService:Create(managedObj_4, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					StudsOffset = Vector3.new(0, 2.5, 2.200000047683716, 0)
				}):Play()
				TweenService:Create(managedObj_4.ImageLabel.ImageLabel, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
					ImageTransparency = 1
				}):Play()
				TweenService:Create(managedObj_4.CurrencyCandyCane, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
					TextTransparency = 1
				}):Play()
				TweenService:Create(managedObj_4.CurrencyCandyCane.UIStroke, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
					Transparency = 1
				}):Play()
				task.delay(5, function()

					managedObj_4:Destroy()
				end)
				return
			end
		end
	end

	local function playScreenCandyCaneAnimation(val14)

		local rotation = Random.new()
		for _ = 1, math.min(val14, 30) do
			local managedObj_5 = script.Image:Clone()
			managedObj_5.Position = UDim2.fromScale(rotation:NextNumber(-0.25, 1.25), -(0.25 - rotation:NextNumber(0, 0.125)))
			managedObj_5.Rotation = rotation:NextNumber(-120, 120)
			local val15 = rotation:NextNumber(0.15, 0.2)
			managedObj_5.Size = UDim2.fromScale(val15, val15)
			managedObj_5.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Effects")
			CreateTween(managedObj_5, TweenInfo.new(rotation:NextNumber(0.75, 1.3), Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Position = managedObj_5.Position + UDim2.fromScale(0, 1.5),
				Rotation = managedObj_5.Rotation + rotation:NextInteger(-3, 3) * 10
			}, true).Completed:Once(function()

				task.wait(1)
				managedObj_5:Destroy()
			end)
		end
	end
	EffectController:Run("GingerbreadTownEvent", "GrassRecolor")
	managedObj_3:Add(function()

		EffectController:Stop("GingerbreadTownEvent", "GrassRecolor")
	end)
	EffectController:Run("GingerbreadTownEvent", "WallRecolor")
	managedObj_3:Add(function()

		EffectController:Stop("GingerbreadTownEvent", "WallRecolor")
	end)
	EffectController:Run("GingerbreadTownEvent", "WallBottomRecolor")
	managedObj_3:Add(function()

		EffectController:Stop("GingerbreadTownEvent", "WallBottomRecolor")
	end)
	ringsObj.Parent = workspace
	managedObj_3:Add(remoteObj.OnClientEvent:Connect(function(val16, val17)

		playCharacterAnimation(LocalPlayer, val17)
		playScreenCandyCaneAnimation(val17)
		task.spawn(function()

			SoundController:PlaySound(ReplicatedStorage.Sounds.Events["Gingerbread Town"].CandyCane)
		end)

		for v52EntryId, v52Entry_2 in data_2 do
			if v52Entry_2.uuid == val16 then
				v52Entry_2.ringTrove:Clean()
				local managedObj_6 = script.BurstVFX:Clone()
				managedObj_6:PivotTo(v52Entry_2.drop:GetPivot() * CFrame.Angles(0, 1.5707963267948966, 0))
				managedObj_6.Parent = workspace
				VFX.emit(managedObj_6)
				task.delay(5, function()

					managedObj_6:Destroy()
				end)
				table.remove(data_2, v52EntryId)
				return
			end
		end
	end))
	managedObj_3:Add(Timer.Simple(0.05, function()

		if #data_2 == 0 then
			return
		else
			local CharacterLocalPlayer = LocalPlayer.Character
			if not CharacterLocalPlayer then
				return
			else
				for _, v52Entry in data_2 do
					if (v52Entry.drop:GetPivot().Position - CharacterLocalPlayer:GetPivot().Position).Magnitude <= 30 then
						remoteObj:FireServer(v52Entry.uuid)
					end
				end
				return
			end
		end
	end))
	managedObj_3:Add(Observers.observeTag("GingerbreadTownReindeer", function(loadAnimationObj_3)

		local addObj_2 = Trove.new()
		local tweenObj = loadAnimationObj_3:LoadAnimation(script.ReindeerIdle);
		(addObj_2 or managedObj_3):Add(function()

			tweenObj:Stop(0)
			tweenObj:Destroy()
		end)
		tweenObj:Play(0)
		addObj_2:Add(createSyncedAnimator(loadAnimationObj_3, script.ReindeerTravel))

		return addObj_2:WrapClean()
	end))
	managedObj_3:Add(Observers.observeTag("GingerbreadTownSleigh", function(ref5)

		local addObj_3 = Trove.new()
		local tweenObj_2 = addObj_3:Clone(ReplicatedStorage.Sounds.Events["Gingerbread Town"].Fly)
		managedObj_3:Add(Observers.observeChildren(ref5.Parent.Parent, function(parent)

			if parent.Name == "SleighMain" then
				tweenObj_2.Parent = parent
			end

			return nil
		end))
		local data_3 = {}
		local flag = nil
		addObj_3:Add(Observers.observeTag("GingerbreadTownSleighMainWeld", function(ref1)

			table.insert(data_3, ref1)
			if flag then
				ref1.C1 = CFrame.Angles(1.5707963267948966, 0, 0)
			end

			return function()

				local flag_2 = table.find(data_3, ref1)
				if flag_2 then
					table.remove(data_3, flag_2)
				end
			end
		end))
		addObj_3:Add(createSyncedAnimator(ref5, script.SleighTravel, function(flag_3)

			if flag == flag_3 then
				return
			else
				if flag_3 then
					if not tweenObj_2.IsPlaying then
						tweenObj_2:Play()
					end
				elseif tweenObj_2.IsPlaying then
					tweenObj_2:Stop()
				end
				flag = flag_3
				for _, v99Entry in data_3 do
					task.defer(function()

						v99Entry.C1 = if flag_3 then CFrame.Angles(1.5707963267948966, 0, 0) else CFrame.identity
					end)
				end
				return
			end
		end))

		return addObj_3:WrapClean()
	end))
	managedObj_3:Add(Observers.observeTag("GingerbreadTownEventReindeer", function(part1)

		local cloneObj = Trove.new()
		local part0 = cloneObj:Clone(script.BabyReindeer)
		part0.Parent = workspace
		local weld = Instance.new("Weld")
		weld.Part0 = part0.PrimaryPart
		weld.Part1 = part1
		weld.C0 = part0.PrimaryPart.PivotOffset
		weld.Parent = part0.PrimaryPart
		local managedObj = part0.AnimationController.Animator:LoadAnimation(script.BabyReindeerIdle)
		managedObj_3:Add(function()

			managedObj:Stop(0)
			managedObj:Destroy()
		end)
		local v110 = managedObj
		v110.Priority = Enum.AnimationPriority.Idle
		v110.Looped = true
		v110:Play()
		local managedObj_2 = part0.AnimationController.Animator:LoadAnimation(script.BabyReindeerMove)
		managedObj_3:Add(function()

			managedObj_2:Stop(0)
			managedObj_2:Destroy()
		end)
		local v112 = managedObj_2
		v112.Priority = Enum.AnimationPriority.Action
		v112.Looped = true
		cloneObj:Add(Observers.observeAttribute(part1, "Moving", function(flag_4)

			if flag_4 then
				v112:Play()
			else
				v112:Stop()
			end

			return nil
		end))

		return cloneObj:WrapClean()
	end, {
		workspace
	}))
	managedObj_3:Add(function()

		EffectController:Activate("Blink")
	end)
	managedObj_3:Add(Observers.observeTag("HideInGingerbreadTown", function(ref2)
		local Parent = ref2.Parent
		ref2.Parent = script

		return function()

			pcall(function()

				ref2.Parent = Parent
			end)
		end
	end, {
		workspace,
		script
	}))
	CycleController:Update()
	SoundController:UpdateOST()
	EffectController:Activate("Blink")
	managedObj_3:Add(function()

		CycleController:Update()
		SoundController:UpdateOST()
	end)
end

data.OnStop = function(_)

	managedObj_3:Destroy()
end

data.OnLoad = function(_)

	onClientEventObj_4.OnClientEvent:Connect(function(val1)

		ClientEventUtils.playBurst(script.ReindeerBurst, val1, {
			ReplicatedStorage.Sounds.Events["Gingerbread Town"].Hit
		})
	end)
	ContentProvider:PreloadAsync(script:GetChildren())
end

return data
