local ContextActionService = game:GetService("ContextActionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui:WaitForChild("Digging")
local Camera = workspace.CurrentCamera

require(ReplicatedStorage.Shared.EventTypes)
require(ReplicatedStorage.Controllers.EncryptedAssetsController)
require(ReplicatedStorage.Controllers.CameraController)
require(ReplicatedStorage.Shared.SharedEventUtils)
require(ReplicatedStorage.Packages.CreateTween)
require(ReplicatedStorage.Shared.TweenPivot)
require(ReplicatedStorage.Utils.MathUtils)
require(ReplicatedStorage.Packages.Signal)
require(ReplicatedStorage.Packages.Spring)
require(ReplicatedStorage.Packages.Shake)

local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local Observers = require(ReplicatedStorage.Packages.Observers)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Spr = require(ReplicatedStorage.Packages.Spr)
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)

local scriptName = script.Name
local TroveInstance = Trove.new()

local DigStartEvent = Net:RemoteEvent(("EventService/%s/DigStart"):format(scriptName))
local DigEndEvent = Net:RemoteEvent(("EventService/%s/DigEnd"):format(scriptName))
local PlayAnimationEvent = Net:RemoteEvent(("EventService/%s/PlayGraveyardAnimation"):format(scriptName))
local CollectVFXEvent = Net:RemoteEvent(("EventService/%s/DigCollectVFX"):format(scriptName))
local BurstEvent = Net:RemoteEvent(("EventService/%s/Burst"):format(scriptName))

local GraveyardDigging = {}

function GraveyardDigging.OnStart()
	local activeEventData = EventController:GetActiveEventData(scriptName)
	assert(activeEventData)

	TroveInstance:Add(function()
		EffectController:Activate("Blink")
		CycleController:Update()
		SoundController:UpdateOST()
	end)

	TroveInstance:Clone(script.Map).Parent = workspace

	TroveInstance:Add(Observers.observeTag("HideInGraveyard", function(object)
		local originalParent = object.Parent
		object.Parent = script
		return function()
			pcall(function()
				object.Parent = originalParent
			end)
		end
	end, { workspace, script }))

	TroveInstance:Add(Observers.observeTag("HideInGraveyardTransparency", function(object)
		object.Transparency = 1
		return function()
			object.Transparency = 0
		end
	end, { workspace }))

	EffectController:Activate("Blink")
	CycleController:Update()
	SoundController:UpdateOST()

	EffectController:Run("GraveyardEvent", "GrassRecolor")
	EffectController:Run("GraveyardEvent", "WallRecolor")
	EffectController:Run("GraveyardEvent", "WallBottomRecolor")

	TroveInstance:Add(function()
		EffectController:Stop("GraveyardEvent", "GrassRecolor")
		EffectController:Stop("GraveyardEvent", "WallRecolor")
		EffectController:Stop("GraveyardEvent", "WallBottomRecolor")
	end)

	local oldAtmosphere = Lighting:FindFirstChild("Atmosphere")
	if oldAtmosphere then
		oldAtmosphere.Parent = script
		TroveInstance:Add(function()
			oldAtmosphere.Parent = Lighting
		end)
	end

	TroveInstance:Clone(script.AtmosphereGraveyard).Parent = Lighting

	TroveInstance:Add(Observers.observeCharacter(LocalPlayer, function(_, character)
		return Observers.observeChildren(character, function(child)
			if not child:IsA("Tool") or child.Name ~= "Agarrini Shovel" then
				return nil
			end

			local animator = character:FindFirstChildWhichIsA("Animator", true)
			if not animator then return end

			local idleAnim = animator:LoadAnimation(script.Idle)
			TroveInstance:Add(function()
				idleAnim:Stop(0)
				idleAnim:Destroy()
			end)

			idleAnim:Play(0)
			return function()
				idleAnim:Stop()
			end
		end)
	end))
end

function GraveyardDigging.OnStop()
	TroveInstance:Destroy()
end

function GraveyardDigging.OnLoad()
	task.spawn(pcall, function()
		ContentProvider:PreloadAsync(script:GetChildren())
	end)

	local localTrove = Trove.new()

	DigStartEvent.OnClientEvent:Connect(function(eventId, multiplier)
		localTrove:Clean()

		local fillBar = PlayerGui.Fillbar
		local fill = fillBar.Fill
		local mover = fillBar.Mover
		local label = fillBar.LabelHolder.TextLabel
		local scale = fillBar.LabelHolder.UIScale

		fillBar.Visible = true

		local progress, timePassed, clickCount = 0, 0, 0
		local decayRate = FFlags:GetInstant("GraveyardDigDecreaseTimer", 0.7)
		local decayAmount = FFlags:GetInstant("GraveyardDigDecreaseAmount", 0.1)
		local increasePerClick = FFlags:GetInstant("GraveyardDigIncreasePerClick", 0.04)
		local clickCooldown = FFlags:GetInstant("GraveyardDigClickCooldown", 0.05)
		local lastClick = 0

		localTrove:Add(RunService.PostSimulation:Connect(function(delta)
			timePassed += delta
			if timePassed >= decayRate then
				timePassed = 0
				progress = math.max(progress - decayAmount * multiplier, 0)
				Spr.target(fill, 1, 7, { Size = UDim2.fromScale(progress, 1) })
				Spr.target(mover, 1, 7, { Position = UDim2.fromScale(progress, 0.5) })
			end
		end))

		ContextActionService:BindActionAtPriority("Dig", function(_, state)
			if state ~= Enum.UserInputState.Begin then return Enum.ContextActionResult.Pass end

			local now = os.clock()
			if now - lastClick < clickCooldown then
				return Enum.ContextActionResult.Sink
			end

			progress = math.min(progress + increasePerClick, 1)
			lastClick = now
			clickCount += 1

			label.Text = string.format("Click Anywhere! (%03d)", clickCount)

			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
				local animator = LocalPlayer.Character:FindFirstChildWhichIsA("Animator", true)
				if animator then
					local anim = animator:LoadAnimation(script.Dig)
					anim:Play()
					SoundController:PlaySound(ReplicatedStorage.Sounds.Events.Graveyard.Dig)
				end
			end

			Spr.target(fill, 1, 7, { Size = UDim2.fromScale(progress, 1) })
			Spr.target(mover, 1, 7, { Position = UDim2.fromScale(progress, 0.5) })
			Spr.stop(scale)
			scale.Scale = 1.2
			Spr.target(scale, 0.8, 5, { Scale = 1 })

			if progress >= 1 then
				DigEndEvent:FireServer(eventId)
			end

			return Enum.ContextActionResult.Sink
		end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.ButtonX, Enum.UserInputType.Touch, Enum.UserInputType.MouseButton1)

		localTrove:Add(function()
			Spr.stop(scale)
			Spr.stop(mover)
			Spr.stop(fill)
			fill.Size = UDim2.fromScale(0, 1)
			mover.Position = UDim2.fromScale(0, 0.5)
			scale.Scale = 1
			label.Text = "Click Anywhere! (000)"
		end)

		localTrove:Add(function()
			ContextActionService:UnbindAction("Dig")
		end)
	end)

	DigEndEvent.OnClientEvent:Connect(function()
		PlayerGui.Fillbar.Visible = false
		localTrove:Clean()
	end)

	CollectVFXEvent.OnClientEvent:Connect(function(position, vfxName)
		local template = script.DigVFX:FindFirstChild(vfxName)
		if template then
			local clone = template:Clone()
			clone:PivotTo(position)
			clone.Parent = workspace
			VFX.emit(clone)
			task.delay(5, clone.Destroy, clone)

			local sfx = template:FindFirstChild("SFX")
			if sfx then
				SoundController:PlaySound(sfx, position.Position + Vector3.new(0, 3, 0))
			end
		end
	end)

	BurstEvent.OnClientEvent:Connect(function(animalId)
		local animalData = AnimalController:GetAnimals()[animalId]
		if not animalData then return end

		local model = animalData.AnimalModel
		local instance = animalData.Instance
		if not (model and instance) then return end

		local primaryPart = instance.PrimaryPart
		if not primaryPart then return end

		local burst = TroveInstance:Clone(script.Burst)
		burst:PivotTo(primaryPart.CFrame * CFrame.new(0, (burst.Size.Y + model:GetExtentsSize().Y) / 2, 0))
		burst.Parent = instance

		local weld = Instance.new("WeldConstraint")
		weld.Part0 = burst
		weld.Part1 = model.PrimaryPart
		weld.Parent = burst

		VFX.emit(burst)
		Debris:AddItem(burst, 5)
		SoundController:PlaySound(ReplicatedStorage.Sounds.Events.Graveyard.BrainrotHit, primaryPart.Position)
	end)

	PlayAnimationEvent.OnClientEvent:Connect(function(animationName, animalId)
		local animalData = AnimalController:GetAnimals()[animalId]
		if not animalData then return end

		local animAsset = script.Animations:FindFirstChild(animationName)
		if animAsset then
			local model = animalData.AnimalModel
			local controller = model:FindFirstChild("AnimationController") or Instance.new("AnimationController", model)
			local animator = controller:FindFirstChild("Animator") or Instance.new("Animator", controller)
			local anim = animator:LoadAnimation(animAsset)
			anim.Priority = Enum.AnimationPriority.Action4
			anim.Looped = false
			anim:Play()
			anim.Ended:Connect(function()
				anim:Stop(0)
				anim:Destroy()
			end)
		end
	end)
end

return GraveyardDigging
