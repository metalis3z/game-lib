local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

require(ReplicatedStorage.Shared.EventTypes)

local AdminWarSnapEvent = {}

local SkullEmojiEffectController = require(ReplicatedStorage.Controllers.SkullEmojiEffectController)
local CharacterController = require(ReplicatedStorage.Controllers.CharacterController)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local AnimalController = require(ReplicatedStorage.Controllers.AnimalController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local CycleController = require(ReplicatedStorage.Controllers.CycleController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local ClientEventUtils = require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)
local Serialization = require(ReplicatedStorage.Packages.Serialization)
local CreateTween = require(ReplicatedStorage.Packages.CreateTween)
local ShakePresets = require(ReplicatedStorage.Shared.ShakePresets)
local TopbarPlus = require(ReplicatedStorage.Packages.TopbarPlus)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Moonlite = require(ReplicatedStorage.Packages.Moonlite)
local MathUtils = require(ReplicatedStorage.Utils.MathUtils)
local Squash = require(ReplicatedStorage.Packages.Squash)
local Shake = require(ReplicatedStorage.Packages.Shake)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local Spr = require(ReplicatedStorage.Packages.Spr)

local VFX = require(ReplicatedStorage.Shared.VFX)

local RenderedMovingAnimals = workspace.RenderedMovingAnimals
local eventName = script.Name
local trove = Trove.new()

local function getGroundOffset(model)
	local humanoid = model:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return Vector3.zero
	end

	local pivotCFrame = model:GetPivot()
	local lowestY = math.huge

	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			local partBottom = part.Position.Y - (part.Size.Y / 2)
			if partBottom < lowestY then
				lowestY = partBottom
			end
		end
	end

	if lowestY == math.huge then
		return Vector3.zero
	end

	local offsetY = pivotCFrame.Y - lowestY
	return Vector3.new(0, offsetY, 0)
end
local function getAnimator(model)
	local humanoid = model:FindFirstChildOfClass("Humanoid")
	if humanoid then
		local animator = humanoid:FindFirstChildOfClass("Animator")
		if not animator then
			animator = Instance.new("Animator")
			animator.Parent = humanoid
		end
		return animator
	end

	local animationController = model:FindFirstChildOfClass("AnimationController")
	if animationController then
		local animator = animationController:FindFirstChildOfClass("Animator")
		if not animator then
			animator = Instance.new("Animator")
			animator.Parent = animationController
		end
		return animator
	end

	return nil
end

local function setupAnimations(model, walkAnim, snapAnim, troveRef)
	local animator = getAnimator(model)
	assert(animator, "No Animator found on model: " .. model.Name)

	local walkAnimation = animator:LoadAnimation(walkAnim)
	walkAnimation.Looped = true
	troveRef:Add(walkAnimation, "Stop")
	troveRef:Add(walkAnimation)

	local snapAnimation = animator:LoadAnimation(snapAnim)
	snapAnimation.Looped = false
	troveRef:Add(snapAnimation, "Stop")
	troveRef:Add(snapAnimation)

	snapAnimation:GetMarkerReachedSignal("Freeze"):Connect(function()
		snapAnimation:AdjustSpeed(0)
	end)

	return walkAnimation, snapAnimation
end

	local activeEventData = EventController:GetActiveEventData(eventName)
	assert(activeEventData)

	local eventFolder = ReplicatedStorage.Controllers.EventController.Events["Duo Snap"]
	local sammyModel = eventFolder:FindFirstChild("CustomSammy") or eventFolder:FindFirstChild("BrotinhoDev") or script.Sammy
	local sammyModel2 = eventFolder:FindFirstChild("CustomSammy2") or eventFolder:FindFirstChild("Iloveholdingroups") or script.Sammy
	local startCFrame = workspace.Road.StartGround.CFrame
	local endCFrame = workspace.Road.End.CFrame

	local sammy1 = trove:Clone(sammyModel)
	sammy1.Name = "Sammy1"
	sammy1.Parent = workspace

	local sammy2 = trove:Clone(sammyModel2)
	sammy2.Name = "Sammy2"
	sammy2.Parent = workspace

	local groundOffset1 = getGroundOffset(sammy1)
	local groundOffset2 = getGroundOffset(sammy2)

	local humanoid1 = sammy1:FindFirstChildOfClass("Humanoid")
	if humanoid1 then
		humanoid1.AutoRotate = false
		humanoid1.JumpPower = 0
		humanoid1.WalkSpeed = 0
	end

	local humanoid2 = sammy2:FindFirstChildOfClass("Humanoid")
	if humanoid2 then
		humanoid2.AutoRotate = false
		humanoid2.JumpPower = 0
		humanoid2.WalkSpeed = 0
	end

	local fireSound1 = trove:Clone(ReplicatedStorage.Sounds.Events["Duo Snap"].Fire)
	fireSound1.Parent = sammy1.HumanoidRootPart
	fireSound1:Play()

	local fireSound2 = trove:Clone(ReplicatedStorage.Sounds.Events["Duo Snap"].Fire)
	fireSound2.Parent = sammy2.HumanoidRootPart
	fireSound2:Play()

	local walkSound1 = trove:Clone(ReplicatedStorage.Sounds.Events["Duo Snap"].Walk)
	walkSound1.Parent = sammy1.HumanoidRootPart
	walkSound1:Play()

	local walkSound2 = trove:Clone(ReplicatedStorage.Sounds.Events["Duo Snap"].Walk)
	walkSound2.Parent = sammy2.HumanoidRootPart
	walkSound2:Play()

	local walkAnimation1, snapAnimation1 = setupAnimations(sammy1, script.WalkAnimation, script.SnapAnimation, trove)
	local walkAnimation2, snapAnimation2 = setupAnimations(sammy2, script.WalkAnimation, script.SnapAnimation, trove)

	walkAnimation1:Play()
	walkAnimation2:Play()

	trove:Add(RunService.PostSimulation:Connect(function(deltaTime)
		debug.profilebegin("Duo Snap:Update")

		local elapsedFraction = (9 - (activeEventData.startedAt + 9 - workspace:GetServerTimeNow())) / 9
		local clampedProgress = math.clamp(elapsedFraction, 0, 1)
		local easedProgress = clampedProgress * clampedProgress

		sammy1:PivotTo(
			(startCFrame:Lerp(startCFrame + Vector3.new(0, 0, 150), clampedProgress))
				+ groundOffset1 * math.lerp(1, 13.9, easedProgress)
		)
		sammy1:ScaleTo(math.lerp(1, 13.9, easedProgress))

		sammy2:PivotTo(
			(endCFrame:Lerp(endCFrame + Vector3.new(0, 0, -150), clampedProgress) * CFrame.Angles(0, math.rad(180), 0))
				+ groundOffset2 * math.lerp(1, 13.9, easedProgress)
		)
		sammy2:ScaleTo(math.lerp(1, 13.9, easedProgress))

		debug.profileend()
	end))

	trove:Add(task.delay(activeEventData.startedAt + 9 - workspace:GetServerTimeNow(), function()
		snapAnimation1:Play()
		snapAnimation2:Play()
	end))

	trove:Add(task.delay(activeEventData.startedAt + 9.5 - workspace:GetServerTimeNow(), function()
		SkullEmojiEffectController:Play(2.5, "Lower")
	end))

	trove:Add(task.delay(activeEventData.startedAt + 9.5 - workspace:GetServerTimeNow(), function()
		ReplicatedStorage.Sounds.Events["Duo Snap"].Walk:Stop()
		ReplicatedStorage.Sounds.Events["Duo Snap"].Snap:Play()

		local hand1 = sammy1.LeftHand
		local snapParticle1 = trove:Clone(script.Snap)
		snapParticle1.CFrame = hand1.CFrame
		snapParticle1.Parent = workspace

		local weld1 = Instance.new("Weld")
		weld1.Part0 = snapParticle1
		weld1.Part1 = hand1
		weld1.Parent = snapParticle1

		VFX.emit(snapParticle1)

		local hand2 = sammy2.LeftHand
		local snapParticle2 = trove:Clone(script.Snap)
		snapParticle2.CFrame = hand2.CFrame
		snapParticle2.Parent = workspace

		local weld2 = Instance.new("Weld")
		weld2.Part0 = snapParticle2
		weld2.Part1 = hand2
		weld2.Parent = snapParticle2

		VFX.emit(snapParticle2)
	end))

	trove:Add(task.delay(activeEventData.startedAt + 12 - workspace:GetServerTimeNow(), function()
		SkullEmojiEffectController:Stop()
		EffectController:Activate("Blink")
		trove:Remove(sammy1)
		trove:Remove(sammy2)
	end))
end

function AdminWarSnapEvent.OnStop(self)
	trove:Destroy()
end

function AdminWarSnapEvent.OnLoad(self)
	task.spawn(pcall, function()
		ContentProvider:PreloadAsync(script:GetChildren())
	end)
	task.spawn(pcall, function()
		ContentProvider:PreloadAsync(ReplicatedStorage.Models.Events["Duo Snap"])
	end)
end

return AdminWarSnapEvent