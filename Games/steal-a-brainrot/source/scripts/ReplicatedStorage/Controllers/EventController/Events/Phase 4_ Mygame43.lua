game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
game:GetService("Players")
game:GetService("Debris")
require(ReplicatedStorage.Shared.EventTypes)
local t = {}
local SkullEmojiEffectController = require(ReplicatedStorage.Controllers.SkullEmojiEffectController)
local EffectController = require(ReplicatedStorage.Controllers.EffectController)
require(ReplicatedStorage.Controllers.AnimalController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
require(ReplicatedStorage.Controllers.CycleController)
local EventController = require(ReplicatedStorage.Controllers.EventController)
require(ReplicatedStorage.Controllers.EventController.ClientEventUtils)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)
require(ReplicatedStorage.Shared.MapInformation)
require(ReplicatedStorage.Packages.CreateTween)
local ShakePresets = require(ReplicatedStorage.Shared.ShakePresets)
local Observers = require(ReplicatedStorage.Packages.Observers)
local MathUtils = require(ReplicatedStorage.Utils.MathUtils)
local Shake = require(ReplicatedStorage.Packages.Shake)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Net = require(ReplicatedStorage.Packages.Net)
local Spr = require(ReplicatedStorage.Packages.Spr)
local VFX = require(ReplicatedStorage.Shared.VFX)
local v1 = script.Name
local v2 = Net:RemoteEvent((("EventService/%*/CreateLightningOrb"):format(v1)))
local v3 = RaycastParams.new()
v3.FilterDescendantsInstances = { workspace.Events["Los Matteos"].Areas }
v3.FilterType = Enum.RaycastFilterType.Include
local CurrentCamera = workspace.CurrentCamera
local v4 = Trove.new()
local v5 = Shake.new()
v5.Amplitude = 5.5
v5.Frequency = 0.05
v5.FadeInTime = 0
v5.FadeOutTime = 0.6
v5.PositionInfluence = Vector3.new(0.5, 0.5, 0.5)
v5.RotationInfluence = Vector3.new(2.5, 0.5, 0.5)
local function shakeCameraBasedOnProximity(p1)
	local Magnitude = (CurrentCamera.CFrame.Position - p1).Magnitude
	if not (Magnitude <= 300) then
		return
	end
	local v1 = v5:Clone()
	local v2 = (1 - Magnitude / 300 * 0.5) ^ 2
	v1.Amplitude = v1.Amplitude * v2
	v1.RotationInfluence = v1.RotationInfluence * v2
	v4:Add(ShakePresets.BindShakeToCamera(v1))
	v1:Start()
end
function t.OnStart(p1)
	local v12 = EventController:GetActiveEventData(v1)
	assert(v12)
	local function calculateTimeLeftFor(p1)
		return v12.startedAt + p1 - workspace:GetServerTimeNow()
	end
	v4:Add(function()
		EffectController:Activate("Blink")
	end)
	local v22 = nil
	local function getOrbPosition(p1)
		local v3 = CFrame.new((p1 - 1) * 30 + -45, if if p1 == 2 then true elseif p1 == 3 then true else false then 70 else 50, 15)
		if v22 then
			return v22.HumanoidRootPart.CFrame * v3
		else
			return v3
		end
	end
	ReplicatedStorage.Sounds.Events["Phase 4: Mygame43"].Appear:Play()
	v4:Add(Observers.observeTag("Mygame43", function(p1)
		v22 = p1
		local v1 = v22
		assert(v1)
		local v2 = v22.Humanoid.Animator:LoadAnimation(script.Idle)
		local v3 = v22.Humanoid.Animator:LoadAnimation(script.Spawn)
		v2:Play()
		v3:Play()
		v3.TimePosition = 7 - (v12.startedAt + 7 - workspace:GetServerTimeNow())
		v4:Add(task.delay(v12.startedAt + 7.7 - workspace:GetServerTimeNow(), function()
			for i = 1, 4 do
				local v3 = CFrame.new((i - 1) * 30 + -45, if if i == 2 then true elseif i == 3 then true else false then 70 else 50, 15)
				local v42 = if v22 then v22.HumanoidRootPart.CFrame * v3 else v3
				local v5 = v4:Clone(script.Orb)
				v5.CFrame = v42 - Vector3.new(0, 100, 0)
				v5.Parent = workspace
				v4:Add(function()
					Spr.stop(v5)
				end)
				local v6 = Random.new():NextNumber(2, 3)
				v4:Add(RunService.PostSimulation:Connect(function(p1)
					debug.profilebegin("Mygame43:FloatOrb")
					local t = {}
					t.Pivot = v42 + Vector3.new(0, math.sin((os.clock() + i * 90) * v6) * 4, 0)
					Spr.target(v5, 0.8, 1, t)
					debug.profileend()
				end))
			end
		end))
		v4:Add(task.delay(v12.startedAt + 3.6999999999999997 - workspace:GetServerTimeNow(), function()
			VFX.enable(v22);
			("FocusMyGame43_%*"):format(os.clock() // 1)
			local v1 = RunService.PreRender:Connect(function(p1)
				debug.profilebegin("Mygame43:Focus")
				local v1 = CurrentCamera.CFrame
				CurrentCamera.CFrame = v1:Lerp(CFrame.lookAt(v1.Position, v22:GetPivot().Position), p1 ^ 0.45)
				debug.profileend()
			end)
			task.delay(0.6, function()
				v1:Disconnect()
				SkullEmojiEffectController:Play(3, "Lower")
			end)
		end))
		return nil
	end))
	v4:Add(v2.OnClientEvent:Connect(function(p1, p2, p3, p4, p5)
		local v3 = CFrame.new((p2 - 1) * 30 + -45, if if p2 == 2 then true elseif p2 == 3 then true else false then 70 else 50, 15)
		local Position = (if v22 then v22.HumanoidRootPart.CFrame * v3 else v3).Position
		local v5 = v4:Clone(script.OrbSmaller)
		v5.CFrame = CFrame.new(Position)
		local v6 = ReplicatedStorage.Sounds.Events["Phase 4: Mygame43"].OrbFlying:Clone()
		v6.Parent = v5
		v5.Parent = workspace
		v6:Play()
		VFX.enable(v5)
		local v7 = Random.new(p1)
		local v10 = Position + (p3 - Position) * 0.25 + Vector3.new(v7:NextNumber(50, 100) * (v7:NextInteger(0, 1) * 2 - 1), v7:NextInteger(300, 400), 0)
		local v13 = Position + (p3 - Position) * 0.6 + Vector3.new(v7:NextNumber(50, 150) * (v7:NextInteger(0, 1) * 2 - 1), v7:NextInteger(100, 200), 0)
		local v14 = 0
		local v15 = nil
		v15 = v4:Add(RunService.PostSimulation:Connect(function(p1)
			debug.profilebegin("Mygame43:UpdateOrb")
			v14 = v14 + p1
			local v1 = TweenService:GetValue(v14 / p4, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
			SharedEventUtils.pushPartCFrame(v5, CFrame.new(MathUtils.cubicBezier(v1, Position, v10, v13, p3)))
			if v1 >= 1 and v15 then
				v4:Remove(v15)
				v15 = nil
				VFX.disable(v5)
				task.delay(3, function()
					v4:Remove(v5)
				end)
				shakeCameraBasedOnProximity(p3)
				local v2 = if p5 then script.StrikeBrainrot:Clone() else script.Strike:Clone()
				v2.Position = p3
				v2.Parent = workspace
				VFX.emit(v2)
				task.delay(4, function()
					v2:Destroy()
				end)
				if p5 then
					SoundController:PlaySound(ReplicatedStorage.Sounds.Events["Los Matteos"].Hit, p3, false)
				else
					SoundController:PlaySound(ReplicatedStorage.Sounds.Events["Phase 4: Mygame43"].OrbHitNothing, p3, false)
				end
			end
			debug.profileend()
		end))
	end))
end
function t.OnStop(p1)
	v4:Destroy()
end
function t.OnLoad(p1)  end
return t