--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
game:GetService("ServerScriptService")
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
game:GetService("TweenService")
game:GetService("SoundService")
game:GetService("HttpService")
game:GetService("StarterGui")
local v_u_3 = game:GetService("RunService")
game:GetService("Lighting")
game:GetService("Players")
game:GetService("Debris")
require(v_u_1.Shared.EventTypes)
local v4 = {}
local v_u_5 = require(v_u_1.Controllers.SkullEmojiEffectController)
require(v_u_1.Controllers.CharacterController)
local v_u_6 = require(v_u_1.Controllers.EffectController)
require(v_u_1.Controllers.AnimalController)
require(v_u_1.Controllers.SoundController)
require(v_u_1.Controllers.CycleController)
local v_u_7 = require(v_u_1.Controllers.EventController)
require(v_u_1.Controllers.EventController.ClientEventUtils)
require(v_u_1.Shared.SharedEventUtils)
require(v_u_1.Packages.Serialization)
require(v_u_1.Packages.CreateTween)
require(v_u_1.Shared.ShakePresets)
require(v_u_1.Packages.TopbarPlus)
require(v_u_1.Packages.Observers)
require(v_u_1.Packages.Moonlite)
require(v_u_1.Utils.MathUtils)
require(v_u_1.Packages.Squash)
require(v_u_1.Packages.Shake)
local v8 = require(v_u_1.Packages.Trove)
require(v_u_1.Packages.Net)
require(v_u_1.Packages.Spr)
local v_u_9 = require(v_u_1.Shared.VFX)
local _ = workspace.RenderedMovingAnimals
local v_u_10 = script.Name
local v_u_11 = v8.new()
function v4.OnStart(_)
	-- upvalues: (copy) v_u_7, (copy) v_u_10, (copy) v_u_11, (copy) v_u_1, (copy) v_u_3, (copy) v_u_5, (copy) v_u_9, (copy) v_u_6
	local v_u_12 = v_u_7:GetActiveEventData(v_u_10)
	assert(v_u_12)
	local v_u_13 = v_u_11:Clone(script.Sammy)
	v_u_13.Parent = workspace
	local v14 = v_u_11:Clone(v_u_1.Sounds.Events["Phase 5: Sammy Snap"].Fire)
	v14.Parent = v_u_13.HumanoidRootPart
	v14:Play()
	local v15 = v_u_11:Clone(v_u_1.Sounds.Events["Phase 5: Sammy Snap"].Walk)
	v15.Parent = v_u_13.HumanoidRootPart
	v15:Play()
	local _ = v_u_12.startedAt + 11.17 - workspace:GetServerTimeNow()
	local v16 = v_u_13.AnimationController.Animator:LoadAnimation(script.WalkAnimation)
	v16.Looped = true
	v_u_11:Add(v16, "Stop")
	v_u_11:Add(v16)
	local v_u_17 = v_u_13.AnimationController.Animator:LoadAnimation(script.SnapAnimation)
	v_u_17.Looped = false
	v_u_11:Add(v_u_17, "Stop")
	v_u_11:Add(v_u_17)
	v_u_17:GetMarkerReachedSignal("Freeze"):Connect(function()
		-- upvalues: (copy) v_u_17
		v_u_17:AdjustSpeed(0)
	end)
	v16:Play()
	v_u_11:Add(v_u_3.PostSimulation:Connect(function(_)
		-- upvalues: (copy) v_u_12, (copy) v_u_13
		debug.profilebegin("Sammy Snap:Update")
		local v18 = (9 - (v_u_12.startedAt + 9 - workspace:GetServerTimeNow())) / 9
		local v19 = math.clamp(v18, 0, 1)
		local v20 = workspace.Road.StartGround.CFrame
		v_u_13:PivotTo(v20:Lerp(v20 + Vector3.new(0, 0, 150), v19))
		local v21 = v_u_13
		local v22 = v19 * v19
		v21:ScaleTo((math.lerp(1, 13.9, v22)))
		debug.profileend()
	end))
	v_u_11:Add(task.delay(v_u_12.startedAt + 9 - workspace:GetServerTimeNow(), function()
		-- upvalues: (copy) v_u_17
		v_u_17:Play()
	end))
	v_u_11:Add(task.delay(v_u_12.startedAt + 9.5 - workspace:GetServerTimeNow(), function()
		-- upvalues: (ref) v_u_5
		v_u_5:Play(2.5, "Lower")
	end))
	v_u_11:Add(task.delay(v_u_12.startedAt + 9.5 - workspace:GetServerTimeNow(), function()
		-- upvalues: (ref) v_u_1, (copy) v_u_13, (ref) v_u_11, (ref) v_u_9
		v_u_1.Sounds.Events["Phase 5: Sammy Snap"].Snap:Play()
		local v23 = v_u_13.LeftHand
		local v24 = v_u_11:Clone(script.Snap)
		v24.CFrame = v23.CFrame
		v24.Parent = workspace
		local v25 = Instance.new("Weld")
		v25.Part0 = v24
		v25.Part1 = v23
		v25.Parent = v24
		v_u_9.emit(v24)
	end))
	v_u_11:Add(task.delay(v_u_12.startedAt + 12 - workspace:GetServerTimeNow(), function()
		-- upvalues: (ref) v_u_5, (ref) v_u_6, (ref) v_u_11, (copy) v_u_13
		v_u_5:Stop()
		v_u_6:Activate("Blink")
		v_u_11:Remove(v_u_13)
	end))
end
function v4.OnStop(_)
	-- upvalues: (copy) v_u_11
	v_u_11:Destroy()
end
function v4.OnLoad(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	task.spawn(pcall, function()
		-- upvalues: (ref) v_u_2
		v_u_2:PreloadAsync(script:GetChildren())
	end)
	task.spawn(pcall, function()
		-- upvalues: (ref) v_u_2, (ref) v_u_1
		v_u_2:PreloadAsync(v_u_1.Models.Events["Phase 5: Sammy Snap"])
	end)
end
return v4
