

game:GetService("ServerScriptService")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")

game:GetService("TweenService")
game:GetService("SoundService")
game:GetService("HttpService")
game:GetService("StarterGui")

local RunService = game:GetService("RunService")

game:GetService("Lighting")
game:GetService("Players")
game:GetService("Debris")
require(ReplicatedStorage.Shared.EventTypes)

local t1 = {}
local SkullEmojiEffectController = require(ReplicatedStorage.Controllers.SkullEmojiEffectController)

require(ReplicatedStorage.Controllers.CharacterController)

local EffectController = require(ReplicatedStorage.Controllers.EffectController)

require(ReplicatedStorage.Controllers.AnimalController)
require(ReplicatedStorage.Controllers.SoundController)
require(ReplicatedStorage.Controllers.CycleController)

local EventController = require(ReplicatedStorage.Controllers.EventController)

require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
require(ReplicatedStorage.Shared.SharedEventUtils)
require(ReplicatedStorage.Packages.Serialization)
require(ReplicatedStorage.Packages.CreateTween)
require(ReplicatedStorage.Shared.ShakePresets)
require(ReplicatedStorage.Packages.TopbarPlus)
require(ReplicatedStorage.Packages.Observers)

local ServerData = require(ReplicatedStorage.Datas.ServerData)

require(ReplicatedStorage.Packages.Moonlite)
require(ReplicatedStorage.Utils.MathUtils)
require(ReplicatedStorage.Packages.Squash)
require(ReplicatedStorage.Packages.Shake)

local Trove = require(ReplicatedStorage.Packages.Trove)

require(ReplicatedStorage.Packages.Net)
require(ReplicatedStorage.Packages.Spr)

local VFX = require(ReplicatedStorage.Shared.VFX)
local _ = workspace.RenderedMovingAnimals
local scriptName = script.Name
local v13 = Trove.new()

function t1.OnStart(_)
	local ActiveEventData = EventController:GetActiveEventData(scriptName)

	assert(ActiveEventData)

	local function calculateTimeLeftFor(n1: number)
		return ActiveEventData.startedAt + 0 + n1 - workspace:GetServerTimeNow()
	end

	local clone = v13:Clone(script.Rusty)

	clone.Parent = workspace

	local v23 = if not ServerData.IsTsunamiServer() then not ServerData.IsBiggerServer() and 150 or 250 else 350
	local v24 = if not ServerData.IsTsunamiServer() then workspace.Road.StartGround.CFrame else script.StartTsunami.CFrame
	local v25 = not ServerData.IsTsunamiServer() and 1 or 10
	local v26 = not ServerData.IsTsunamiServer() and 13.9 or 50

	local morphTemplate = script:FindFirstChild("CustomRusty")
	local morph = nil
	local usingMorph = false
	local morphSnapTrack = nil

	local vfxHand = clone.LeftHand

	if morphTemplate then
		usingMorph = true

		morph = v13:Clone(morphTemplate)
		morph.Parent = workspace

		for _, d in ipairs(clone:GetDescendants()) do
			if d:IsA("BasePart") then
				d.Transparency = 1
				d.CanCollide = false
			elseif d:IsA("Decal") or d:IsA("Texture") then
				d.Transparency = 1
			end
		end

		local morphHum = morph:FindFirstChildOfClass("Humanoid")
		if morphHum then
			morphHum.EvaluateStateMachine = false
			morphHum.AutoRotate = false
			morphHum.WalkSpeed = 0
			morphHum.JumpPower = 0
		end

		local morphHRP = morph:FindFirstChild("HumanoidRootPart")
		if morphHRP then
			morphHRP.Anchored = false
			morph.PrimaryPart = morphHRP
		end
		for _, p in ipairs(morph:GetDescendants()) do
			if p:IsA("BasePart") then
				p.CanCollide = false
				p.Massless = true
			end
		end

		clone:PivotTo(v24)
		morph:PivotTo(v24)

		local driverHRP = clone:FindFirstChild("HumanoidRootPart")
		if morphHRP and driverHRP then
			local weld = Instance.new("Weld")
			weld.Part0 = driverHRP
			weld.Part1 = morphHRP
			weld.C0 = CFrame.new()
			weld.C1 = CFrame.new()
			weld.Parent = driverHRP
			v13:Add(weld)
		end

		local morphLeftHand = morph:FindFirstChild("LeftHand")
		if morphLeftHand then
			vfxHand = morphLeftHand
		end

		local morphAnimator = morph:FindFirstChildWhichIsA("Animator", true)
		if morphAnimator then
			local morphWalk = morphAnimator:LoadAnimation(script.WalkAnimation)
			morphWalk.Looped = true
			morphWalk.Priority = Enum.AnimationPriority.Action
			v13:Add(morphWalk, "Stop")
			v13:Add(morphWalk)
			morphWalk:Play()

			morphSnapTrack = morphAnimator:LoadAnimation(script.SnapAnimation)
			morphSnapTrack.Looped = false
			morphSnapTrack.Priority = Enum.AnimationPriority.Action
			v13:Add(morphSnapTrack, "Stop")
			v13:Add(morphSnapTrack)
			v13:Add(morphSnapTrack:GetMarkerReachedSignal("Freeze"):Connect(function()
				morphSnapTrack:AdjustSpeed(0)
			end))
		end
	end

	local clone2 = v13:Clone(ReplicatedStorage.Sounds.Events["Rusty Snap"].Fire)

	clone2.Parent = clone.HumanoidRootPart
	clone2:Play()

	local clone3 = v13:Clone(ReplicatedStorage.Sounds.Events["Rusty Snap"].Walk)

	clone3.Parent = clone.HumanoidRootPart
	clone3:Play()

	local _ = ActiveEventData.startedAt + 11.17 - workspace:GetServerTimeNow()
	local track = clone.Humanoid.Animator:LoadAnimation(script.WalkAnimation)

	track.Looped = true
	v13:Add(track, "Stop")
	v13:Add(track)

	local track2 = clone.Humanoid.Animator:LoadAnimation(script.SnapAnimation)

	track2.Looped = false
	v13:Add(track2, "Stop")
	v13:Add(track2)
	v13:Add(track2:GetMarkerReachedSignal("Freeze"):Connect(function()
		track2:AdjustSpeed(0)
	end))
	track:Play()

	v13:Add(RunService.PostSimulation:Connect(function(_: number)
		debug.profilebegin("Rusty Snap:Update")

		local v31 = math.clamp((9 - (ActiveEventData.startedAt + 0 + 9 - workspace:GetServerTimeNow())) / 9, 0, 1)

		clone:PivotTo(v24:Lerp(v24 + Vector3.new(0, 0, v23), v31))
		clone:ScaleTo((math.lerp(v25, v26, v31 * v31)))
		if usingMorph and morph then
			morph:ScaleTo((math.lerp(v25, v26, v31 * v31)))
		end
		debug.profileend()
	end))
	v13:Add(task.delay(ActiveEventData.startedAt + 0 + 9 - workspace:GetServerTimeNow(), function()
		track2:Play()
		if morphSnapTrack then
			morphSnapTrack:Play()
		end
	end))
	v13:Add(task.delay(ActiveEventData.startedAt + 0 + 9.5 - workspace:GetServerTimeNow(), function()
		SkullEmojiEffectController:Play(2.5, "Lower")
	end))
	v13:Add(task.delay(ActiveEventData.startedAt + 0 + 9.5 - workspace:GetServerTimeNow(), function()
		ReplicatedStorage.Sounds.Events["Rusty Snap"].Snap:Play()

		local LeftHand = vfxHand
		local clone4 = v13:Clone(script.Snap)

		clone4.CFrame = LeftHand.CFrame
		clone4.Parent = workspace

		local Weld = Instance.new("Weld")

		Weld.Part0 = clone4
		Weld.Part1 = LeftHand
		Weld.Parent = clone4
		VFX.emit(clone4)
	end))
	v13:Add(task.delay(ActiveEventData.startedAt + 0 + 12 - workspace:GetServerTimeNow(), function()
		SkullEmojiEffectController:Stop()
		EffectController:Activate("Blink")
		v13:Remove(clone)
		if morph then
			v13:Remove(morph)
		end
	end))
end
function t1.OnStop(_)
	v13:Destroy()
end
function t1.OnLoad(_)
	task.spawn(pcall, function()
		ContentProvider:PreloadAsync(script:GetChildren())
	end)
	task.spawn(pcall, function()
		ContentProvider:PreloadAsync(ReplicatedStorage.Models.Events["Rusty Snap"])
	end)
end

return t1
