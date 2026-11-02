-- Gingerbread Town Event Controller (Client)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local module = {}

local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local Lighting = game:GetService("Lighting")
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local VFX = require(ReplicatedStorage.Shared.VFX)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Observers = require(ReplicatedStorage.Packages.Observers)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)

local Name = script.Name
local LocalPlayer = Players.LocalPlayer

local UpdateRide  = Net:RemoteEvent(`EventService/{Name}/UpdateRide`)
local CreateRings = Net:RemoteEvent(`EventService/{Name}/CreateRings`)
local DestroyRings = Net:RemoteEvent(`EventService/{Name}/DestroyRings`)
local CollectCandy = Net:RemoteEvent(`EventService/{Name}/CollectCandy`)

-- FIX: trove réinitialisé à chaque OnStart pour éviter l'accumulation de connexions
local trove = nil

-- Utilitaire: charger une animation et l'ajouter au trove
local function loadAnim(animator, animAsset, customTrove)
	local track = animator:LoadAnimation(animAsset)
	local t = customTrove or trove
	t:Add(function()
		track:Stop(0)
		track:Destroy()
	end)
	return track
end

-- FIX: createSyncedAnimator réécrit proprement — le décompilateur avait mélangé
-- un booléen (isOutOfRange) avec un number (normalizedTime) dans var51,
-- causant math.clamp() sur un booléen → animation jamais synchronisée.
local function createSyncedAnimator(animator, animAsset, rideStartRef, rideDurationRef, onStateChange)
	local animTrove = Trove.new()
	local track = animator:LoadAnimation(animAsset)
	animTrove:Add(function()
		track:Stop(0)
		track:Destroy()
	end)

	animTrove:Add(RunService.PreRender:Connect(function()
		local rideStart = rideStartRef[1]
		local rideDuration = rideDurationRef[1]
		if not rideStart or not rideDuration then return end

		local now = workspace:GetServerTimeNow()
		local elapsed = now - rideStart
		-- FIX: calcul séparé du normalized time et du flag isOutOfRange
		local normalizedTime = math.clamp(elapsed / rideDuration, 0, 1)
		local isOutOfRange = elapsed < rideStart or elapsed > (rideStart + rideDuration)

		local targetPosition = normalizedTime * rideDuration

		if isOutOfRange then
			-- Hors de la plage → stopper l'animation
			if track.IsPlaying then
				track.TimePosition = 0
				track:Stop(0)
			end
		else
			-- Dans la plage → synchroniser
			if not track.IsPlaying then
				track:Play()
			end
			if math.abs(targetPosition - track.TimePosition) > 0.1 then
				track.TimePosition = targetPosition
			end
		end

		if onStateChange then
			onStateChange(isOutOfRange, targetPosition)
		end
	end))

	return animTrove:WrapClean()
end

local function playCharacterAnimation(player, amount)
	local Character = player.Character
	if not Character then return end
	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	if not HumanoidRootPart then return end

	local reward = script.Reward:Clone()
	reward.CurrencyCandyCane.Text = `+{amount}`
	reward.Parent = HumanoidRootPart

	TweenService:Create(reward, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		StudsOffset = Vector3.new(0, 2.5, 2.2),
	}):Play()
	TweenService:Create(reward.ImageLabel.ImageLabel, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
		ImageTransparency = 1,
	}):Play()
	TweenService:Create(reward.CurrencyCandyCane, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
		TextTransparency = 1,
	}):Play()
	TweenService:Create(reward.CurrencyCandyCane.UIStroke, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 1.5), {
		Transparency = 1,
	}):Play()
	task.delay(5, function()
		reward:Destroy()
	end)
end

local function playScreenCandyCaneAnimation(amount)
	local random_state = Random.new()
	for _ = 1, math.min(amount, 30) do
		local clone = script.Image:Clone()
		clone.Position = UDim2.fromScale(random_state:NextNumber(-0.25, 1.25), -(0.25 - random_state:NextNumber(0, 0.125)))
		clone.Rotation = random_state:NextNumber(-120, 120)
		local s = random_state:NextNumber(0.15, 0.2)
		clone.Size = UDim2.fromScale(s, s)
		clone.Parent = LocalPlayer.PlayerGui:FindFirstChild("Effects")
		CreateTween(clone, TweenInfo.new(random_state:NextNumber(0.75, 1.3), Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			Position = clone.Position + UDim2.fromScale(0, 1.5),
			Rotation = clone.Rotation + random_state:NextInteger(-3, 3) * 10,
		}, true).Completed:Once(function()
			task.wait(1)
			clone:Destroy()
		end)
	end
end

function module.OnStart(arg1)
	assert(EventController:GetActiveEventData(Name))

	-- FIX: nouveau trove à chaque OnStart pour éviter l'accumulation
	trove = Trove.new()

	-- Shared ride state (tables utilisées comme références mutables pour createSyncedAnimator)
	local rideStartRef = {nil}
	local rideDurationRef = {nil}

	local Cartoon = Lighting:FindFirstChild("Cartoon")
	if Cartoon then
		Cartoon.Parent = script
		trove:Add(function()
			Cartoon.Parent = Lighting
		end)
	end

	trove:Clone(script.NightSky).Parent = Lighting
	local mapClone = trove:Clone(script.GingerbreadTown)

	trove:Add(UpdateRide.OnClientEvent:Connect(function(rideStart, rideDuration)
		rideStartRef[1] = rideStart
		rideDurationRef[1] = rideDuration
	end))

	local ringsTrove = trove:Extend()
	local drops = {}

	trove:Add(CreateRings.OnClientEvent:Connect(function(ringsData)
		if not LocalPlayer:GetAttribute("SleighSeated") then return end
		for uuid, ringInfo in ringsData do
			local dropTrove = ringsTrove:Extend()
			local Candycane = mapClone.Rings:GetChildren()[ringInfo.ring].Candycane
			local drop = dropTrove:Clone(script.Drop)
			drop:PivotTo(Candycane:GetPivot())
			drop.BillboardGui.CurrencyCandyCane.Text = `+{ringInfo.amount}`
			drop.Parent = workspace
			local vfxAttach = dropTrove:Clone(script.ActivatedCandyCaneVFX.Attachment)
			vfxAttach.Parent = Candycane
			table.insert(drops, {
				ringTrove = dropTrove,
				vfx = vfxAttach,
				ring = ringInfo.ring,
				amount = ringInfo.amount,
				uuid = uuid,
				drop = drop,
			})
		end
	end))

	trove:Add(DestroyRings.OnClientEvent:Connect(function()
		ringsTrove:Clean()
		table.clear(drops)
	end))

	trove:Add(CollectCandy.OnClientEvent:Connect(function(uuid, amount)
		playCharacterAnimation(LocalPlayer, amount)
		playScreenCandyCaneAnimation(amount)
		task.spawn(function()
			SoundController:PlaySound(ReplicatedStorage.Sounds.Events["Gingerbread Town"].CandyCane)
		end)
		for i, v in drops do
			if v.uuid == uuid then
				v.ringTrove:Clean()
				local burst = script.BurstVFX:Clone()
				burst:PivotTo(v.drop:GetPivot() * CFrame.Angles(0, math.pi / 2, 0))
				burst.Parent = workspace
				VFX.emit(burst)
				task.delay(5, function()
					burst:Destroy()
				end)
				table.remove(drops, i)
				return
			end
		end
	end))

	trove:Add(Timer.Simple(0.05, function()
		if #drops == 0 then return end
		local Character = LocalPlayer.Character
		if not Character then return end
		for _, v in drops do
			if (v.drop:GetPivot().Position - Character:GetPivot().Position).Magnitude <= 30 then
				CollectCandy:FireServer(v.uuid)
			end
		end
	end))

	trove:Add(Observers.observeTag("GingerbreadTownReindeer", function(reindeer)
		local reindeerTrove = Trove.new()
		local idleTrack = reindeer:LoadAnimation(script.ReindeerIdle)
		reindeerTrove:Add(function()
			idleTrack:Stop(0)
			idleTrack:Destroy()
		end)
		idleTrack:Play(0)
		reindeerTrove:Add(createSyncedAnimator(reindeer, script.ReindeerTravel, rideStartRef, rideDurationRef))
		return reindeerTrove:WrapClean()
	end))

	trove:Add(Observers.observeTag("GingerbreadTownSleigh", function(sleigh)
		local sleighTrove = Trove.new()
		local flySound = sleighTrove:Clone(ReplicatedStorage.Sounds.Events["Gingerbread Town"].Fly)

		trove:Add(Observers.observeChildren(sleigh.Parent.Parent, function(child)
			if child.Name == "SleighMain" then
				flySound.Parent = child
			end
			return nil
		end))

		local weldList = {}
		local isAirborne = false

		sleighTrove:Add(Observers.observeTag("GingerbreadTownSleighMainWeld", function(weld)
			table.insert(weldList, weld)
			if isAirborne then
				weld.C1 = CFrame.Angles(math.pi / 2, 0, 0)
			end
			return function()
				local idx = table.find(weldList, weld)
				if idx then table.remove(weldList, idx) end
			end
		end))

		sleighTrove:Add(createSyncedAnimator(sleigh, script.SleighTravel, rideStartRef, rideDurationRef, function(outOfRange, _)
			-- outOfRange est maintenant correctement un booléen (pas un number)
			local airborne = not outOfRange
			if isAirborne == airborne then return end
			isAirborne = airborne
			if airborne then
				if not flySound.IsPlaying then flySound:Play() end
			else
				if flySound.IsPlaying then flySound:Stop() end
			end
			for _, weld in weldList do
				task.defer(function()
					weld.C1 = airborne and CFrame.Angles(math.pi / 2, 0, 0) or CFrame.identity
				end)
			end
		end))

		return sleighTrove:WrapClean()
	end))

	trove:Add(Observers.observeTag("GingerbreadTownEventReindeer", function(reindeerPart)
		local partTrove = Trove.new()
		local babyClone = partTrove:Clone(script.BabyReindeer)
		babyClone.Parent = workspace
		local Weld = Instance.new("Weld")
		Weld.Part0 = babyClone.PrimaryPart
		Weld.Part1 = reindeerPart
		Weld.C0 = babyClone.PrimaryPart.PivotOffset
		Weld.Parent = babyClone.PrimaryPart

		local idleTrack = babyClone.AnimationController.Animator:LoadAnimation(script.BabyReindeerIdle)
		partTrove:Add(function()
			idleTrack:Stop(0)
			idleTrack:Destroy()
		end)
		idleTrack.Priority = Enum.AnimationPriority.Idle
		idleTrack.Looped = true
		idleTrack:Play()

		local moveTrack = babyClone.AnimationController.Animator:LoadAnimation(script.BabyReindeerMove)
		partTrove:Add(function()
			moveTrack:Stop(0)
			moveTrack:Destroy()
		end)
		moveTrack.Priority = Enum.AnimationPriority.Action
		moveTrack.Looped = true

		partTrove:Add(Observers.observeAttribute(reindeerPart, "Moving", function(isMoving)
			if isMoving then
				moveTrack:Play()
			else
				moveTrack:Stop()
			end
			return nil
		end))

		return partTrove:WrapClean()
	end, {workspace}))

	trove:Add(Observers.observeTag("HideInGingerbreadTown", function(obj)
		local originalParent = obj.Parent
		obj.Parent = script
		return function()
			pcall(function()
				obj.Parent = originalParent
			end)
		end
	end, {workspace, script}))

	EffectController:Run("GingerbreadTownEvent", "GrassRecolor")
	EffectController:Run("GingerbreadTownEvent", "WallRecolor")
	EffectController:Run("GingerbreadTownEvent", "WallBottomRecolor")
	trove:Add(function()
		EffectController:Stop("GingerbreadTownEvent", "GrassRecolor")
		EffectController:Stop("GingerbreadTownEvent", "WallRecolor")
		EffectController:Stop("GingerbreadTownEvent", "WallBottomRecolor")
	end)

	mapClone.Parent = workspace

	EffectController:Activate("Blink")
	trove:Add(function()
		EffectController:Activate("Blink")
	end)

	CycleController:Update()
	SoundController:UpdateOST()
	trove:Add(function()
		CycleController:Update()
		SoundController:UpdateOST()
	end)
end

function module.OnStop(arg1)
	-- FIX: nil au lieu de false + cohérent avec le serveur
	ReplicatedStorage:SetAttribute("GingerbreadTownEvent", nil)
	if trove then
		trove:Destroy()
		trove = nil
	end
end

local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local BurstRemote = Net:RemoteEvent(`EventService/{Name}/Burst`)

function module.OnLoad(arg1)
	BurstRemote.OnClientEvent:Connect(function(animalId)
		ClientEventUtils.playBurst(script.ReindeerBurst, animalId, {ReplicatedStorage.Sounds.Events["Gingerbread Town"].Hit})
	end)
end

return module
