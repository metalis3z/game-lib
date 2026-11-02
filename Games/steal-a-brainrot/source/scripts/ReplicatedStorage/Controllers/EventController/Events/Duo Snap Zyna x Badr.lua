local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Trove = require(ReplicatedStorage.Packages.Trove)
local EventController = require(ReplicatedStorage.Controllers.EventController)
local SkullEmojiEffectController = require(ReplicatedStorage.Controllers.SkullEmojiEffectController)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
local VFX = require(ReplicatedStorage.Shared.VFX)

local EVENT_NAME = script.Name
local trove = Trove.new()
local Duo = {}

function Duo.OnStart()
	local eventData = EventController:GetActiveEventData(EVENT_NAME)
	assert(eventData)

	local aspaModel = trove:Clone(script.Aspa)
	aspaModel.Parent = workspace
	local sammyModel = trove:Clone(script.Sammy)
	sammyModel.Parent = workspace

	for _, model in { aspaModel, sammyModel } do
		local fireSound = trove:Clone(ReplicatedStorage.Sounds.Events["Phase 5: Sammy Snap"].Fire)
		fireSound.Parent = model.HumanoidRootPart
		fireSound:Play()
		local walkSound = trove:Clone(ReplicatedStorage.Sounds.Events["Phase 5: Sammy Snap"].Walk)
		walkSound.Parent = model.HumanoidRootPart
		walkSound:Play()
	end

	local function loadTracks(model)
		local animator = model.AnimationController.Animator
		local walkTrack = animator:LoadAnimation(script.WalkAnimation)
		walkTrack.Looped = true
		trove:Add(walkTrack, "Stop")
		trove:Add(walkTrack)

		local snapTrack = animator:LoadAnimation(script.SnapAnimation)
		snapTrack.Looped = false
		trove:Add(snapTrack, "Stop")
		trove:Add(snapTrack)
		snapTrack:GetMarkerReachedSignal("Freeze"):Connect(function()
			snapTrack:AdjustSpeed(0)
		end)

		walkTrack:Play()
		return walkTrack, snapTrack
	end

	local aspaWalk, aspaSnap = loadTracks(aspaModel)
	local sammyWalk, sammySnap = loadTracks(sammyModel)

	local startedAt = eventData.startedAt
	local movementDuration = 9
	local function getGroundOffset(model)
		local bounds, size = model:GetBoundingBox()
		return model:GetPivot().Position.Y - (bounds.Position.Y - size.Y / 2)
	end

	local aspaBaseYOffset = getGroundOffset(aspaModel)
	local sammyBaseYOffset = getGroundOffset(sammyModel)
	local groundY = workspace.Road.StartGround.Position.Y
	local aspaStart = Vector3.new(aspaModel:GetPivot().Position.X, groundY, aspaModel:GetPivot().Position.Z)
	local sammyStart = Vector3.new(sammyModel:GetPivot().Position.X, groundY, sammyModel:GetPivot().Position.Z)
	local aspaEnd = aspaStart + Vector3.new(0, 0, 150)
	local sammyEnd = sammyStart + Vector3.new(0, 0, -150)
	local snapping = false

	aspaModel:PivotTo(CFrame.new(aspaStart + Vector3.new(0, aspaBaseYOffset, 0)) * CFrame.Angles(0, math.rad(180), 0))
	sammyModel:PivotTo(CFrame.new(sammyStart + Vector3.new(0, sammyBaseYOffset, 0)))

	trove:Add(RunService.PostSimulation:Connect(function()
		if snapping or not aspaModel.Parent or not sammyModel.Parent then
			return
		end

		local progress = math.clamp((workspace:GetServerTimeNow() - startedAt) / movementDuration, 0, 1)
		local scale = math.lerp(1, 13.9, progress * progress)
		aspaModel:ScaleTo(scale)
		sammyModel:ScaleTo(scale)
		aspaModel:PivotTo(CFrame.new(aspaStart:Lerp(aspaEnd, progress) + Vector3.new(0, aspaBaseYOffset * scale, 0)) * CFrame.Angles(0, math.rad(180), 0))
		sammyModel:PivotTo(CFrame.new(sammyStart:Lerp(sammyEnd, progress) + Vector3.new(0, sammyBaseYOffset * scale, 0)))
	end))

	trove:Add(task.delay(math.max(0, startedAt + movementDuration - workspace:GetServerTimeNow()), function()
		snapping = true
		aspaWalk:Stop()
		sammyWalk:Stop()
		aspaSnap:Play()
		sammySnap:Play()
	end))

	trove:Add(task.delay(math.max(0, startedAt + 9.5 - workspace:GetServerTimeNow()), function()
		SkullEmojiEffectController:Play(2.5, "Lower")
		ReplicatedStorage.Sounds.Events["Phase 5: Sammy Snap"].Snap:Play()

		for _, model in { aspaModel, sammyModel } do
			local leftHand = model:FindFirstChild("LeftHand")
			if leftHand then
				local snapVfx = trove:Clone(script.Snap)
				snapVfx.CFrame = leftHand.CFrame
				snapVfx.Parent = workspace
				local weld = Instance.new("Weld")
				weld.Part0 = snapVfx
				weld.Part1 = leftHand
				weld.Parent = snapVfx
				VFX.emit(snapVfx)
			end
		end
	end))

	trove:Add(task.delay(math.max(0, startedAt + 12 - workspace:GetServerTimeNow()), function()
		SkullEmojiEffectController:Stop()
		EffectController:Activate("Blink")
		trove:Remove(aspaModel)
		trove:Remove(sammyModel)
	end))
end

function Duo.OnStop()
	trove:Destroy()
end

function Duo.OnLoad()
end

return Duo