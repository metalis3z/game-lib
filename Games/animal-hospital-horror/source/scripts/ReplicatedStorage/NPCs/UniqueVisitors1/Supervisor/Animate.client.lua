local v1 = script.Parent
local v2 = script.Parent
local Animator = v2:WaitForChild("Humanoid"):WaitForChild("Animator")
local Humanoid = v1:WaitForChild("Humanoid")
local Animator2 = Humanoid:WaitForChild("Animator")
local v3 = "Standing"
local ok, result = pcall(function() --[[ Line: 11 ]]
	return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun")
end)
local v4 = ok and result
local v5 = ""
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = 1
local t = {}
local tbl = {}
local t2 = {}
local t3 = {
	weight = 9,
	speed = 0.6
}
local Idle = v2:WaitForChild("Idle", 5)

t3.id = if Idle then Idle.AnimationId else Idle
t2[1] = t3
tbl.idle = t2

local t4 = {}
local t5 = {
	weight = 10,
	speed = 2
}
local Walk = v2:WaitForChild("Walk", 5)

t5.id = if Walk then Walk.AnimationId else Walk
t4[1] = t5
tbl.walk = t4
tbl.run = {
	{
		id = "run.xml",
		weight = 10
	}
}

local t6 = {}
local t7 = {
	weight = 10
}
local Jump = v2:WaitForChild("Jump", 5)

t7.id = (if Jump then Jump.AnimationId else Jump) or "http://www.roblox.com/asset/?id=125750702"
t6[1] = t7
tbl.jump = t6
tbl.fall = {
	{
		id = "http://www.roblox.com/asset/?id=180436148",
		weight = 10
	}
}

local t8 = {}
local t9 = {
	weight = 10
}
local Idle2 = v2:WaitForChild("Idle", 5)

t9.id = if Idle2 then Idle2.AnimationId else Idle2
t8[1] = t9
tbl.climb = t8
tbl.sit = {
	{
		id = "http://www.roblox.com/asset/?id=178130996",
		weight = 10
	}
}
tbl.toolnone = {
	{
		id = "http://www.roblox.com/asset/?id=121951842657913",
		weight = 10
	}
}

local t10 = {}
local t11 = {
	weight = 10
}
local Tool = v2:WaitForChild("Tool", 5)

t11.id = if Tool then Tool.AnimationId else Tool
t10[1] = t11
tbl.toolnoneAnimal = t10
tbl.toolslash = {
	{
		id = "http://www.roblox.com/asset/?id=129967390",
		weight = 10
	}
}
tbl.toollunge = {
	{
		id = "http://www.roblox.com/asset/?id=129967478",
		weight = 10
	}
}
tbl.wave = {
	{
		id = "http://www.roblox.com/asset/?id=128777973",
		weight = 10
	}
}
tbl.point = {
	{
		id = "http://www.roblox.com/asset/?id=128853357",
		weight = 10
	}
}
tbl.dance1 = {
	{
		id = "http://www.roblox.com/asset/?id=182435998",
		weight = 10
	},
	{
		id = "http://www.roblox.com/asset/?id=182491037",
		weight = 10
	},
	{
		id = "http://www.roblox.com/asset/?id=182491065",
		weight = 10
	}
}
tbl.dance2 = {
	{
		id = "http://www.roblox.com/asset/?id=182436842",
		weight = 10
	},
	{
		id = "http://www.roblox.com/asset/?id=182491248",
		weight = 10
	},
	{
		id = "http://www.roblox.com/asset/?id=182491277",
		weight = 10
	}
}
tbl.dance3 = {
	{
		id = "http://www.roblox.com/asset/?id=182436935",
		weight = 10
	},
	{
		id = "http://www.roblox.com/asset/?id=182491368",
		weight = 10
	},
	{
		id = "http://www.roblox.com/asset/?id=182491423",
		weight = 10
	}
}
tbl.laugh = {
	{
		id = "http://www.roblox.com/asset/?id=129423131",
		weight = 10
	}
}
tbl.cheer = {
	{
		id = "http://www.roblox.com/asset/?id=129423030",
		weight = 10
	}
}

local t12 = { "dance1", "dance2", "dance3" }
local t13 = {
	wave = false,
	point = false,
	dance1 = true,
	dance2 = true,
	dance3 = true,
	laugh = false,
	cheer = false
}

function configureAnimationSet(p1, p2) --[[ configureAnimationSet | Line: 196 | Upvalues: t (copy) ]]
	if t[p1] ~= nil then
		for k, v in pairs(t[p1].connections) do
			v:disconnect()
		end
	end

	t[p1] = {}
	t[p1].count = 0
	t[p1].totalWeight = 0
	t[p1].connections = {}

	local v1 = script:FindFirstChild(p1)

	if v1 ~= nil then
		table.insert(t[p1].connections, v1.ChildAdded:connect(function(p12) --[[ Line: 209 | Upvalues: p1 (copy), p2 (copy) ]]
			configureAnimationSet(p1, p2)
		end))
		table.insert(t[p1].connections, v1.ChildRemoved:connect(function(p12) --[[ Line: 213 | Upvalues: p1 (copy), p2 (copy) ]]
			configureAnimationSet(p1, p2)
		end))

		local count = 1

		for k, v in pairs(v1:GetChildren()) do
			if v:IsA("Animation") then
				table.insert(t[p1].connections, v.Changed:connect(function(p12) --[[ Line: 220 | Upvalues: p1 (copy), p2 (copy) ]]
					configureAnimationSet(p1, p2)
				end))
				t[p1][count] = {}
				t[p1][count].anim = v

				local Weight = v:FindFirstChild("Weight")

				if Weight == nil then
					t[p1][count].weight = 1
				else
					t[p1][count].weight = Weight.Value
				end

				t[p1].count = t[p1].count + 1
				t[p1].totalWeight = t[p1].totalWeight + t[p1][count].weight
				count = count + 1
			end
		end
	end

	if not (t[p1].count <= 0) then
		return
	end

	for k, v in pairs(p2) do
		t[p1][k] = {}
		t[p1][k].anim = Instance.new("Animation")
		t[p1][k].anim.Name = p1
		t[p1][k].anim.AnimationId = v.id
		t[p1][k].weight = v.weight
		t[p1].count = t[p1].count + 1
		t[p1].totalWeight = t[p1].totalWeight + v.weight
	end
end
function scriptChildModified(p1) --[[ scriptChildModified | Line: 250 | Upvalues: tbl (copy) ]]
	local v1 = tbl[p1.Name]

	if v1 == nil then
		return
	end

	configureAnimationSet(p1.Name, v1)
end
script.ChildAdded:connect(scriptChildModified)
script.ChildRemoved:connect(scriptChildModified)

if Animator then
	for i, v in ipairs((Animator:GetPlayingAnimationTracks())) do
		v:Stop(0)
		v:Destroy()
	end
end

for k, v in pairs(tbl) do
	configureAnimationSet(k, v)
end

local v16 = "None"
local v17 = 0
local v18 = 0

function stopAllAnimations() --[[ stopAllAnimations | Line: 272 | Upvalues: v5 (ref), t13 (copy), v6 (ref), v8 (ref), v7 (ref) ]]
	local v1 = v5
	local v2 = if t13[v1] == nil or t13[v1] ~= false then v1 else "idle"

	v5 = ""
	v6 = nil

	if v8 ~= nil then
		v8:disconnect()
	end

	if v7 == nil then
		return v2
	end

	v7:Stop()
	v7:Destroy()
	v7 = nil

	return v2
end
function setAnimationSpeed(p1) --[[ setAnimationSpeed | Line: 288 | Upvalues: v9 (ref), v7 (ref) ]]
	if p1 == v9 then
		return
	end

	v9 = p1
	v7:AdjustSpeed(p1)
end
function keyFrameReachedFunc(p1) --[[ keyFrameReachedFunc | Line: 295 | Upvalues: v5 (ref), v9 (ref), t13 (copy), Humanoid (copy) ]]
	if p1 ~= "End" then
		return
	end

	local v1 = v5

	playAnimation(if t13[v1] == nil or t13[v1] ~= false then v1 else "idle", 0, Humanoid)
	setAnimationSpeed(v9)
end
function playAnimation(p1, p2, p3) --[[ playAnimation | Line: 304 | Upvalues: t (copy), v6 (ref), v7 (ref), v9 (ref), Animator (copy), v5 (ref), v8 (ref) ]]
	if game.Players.LocalPlayer:HasTag("DeadPlayer") then
		stopAllAnimations()

		return
	end

	local sum = math.random(1, t[p1].totalWeight)
	local count = 1

	while t[p1][count].weight < sum do
		sum = sum - t[p1][count].weight
		count = count + 1
	end

	local anim = t[p1][count].anim

	if anim == v6 then
		return
	end

	if v7 ~= nil then
		v7:Stop(p2)
		v7:Destroy()
	end

	v9 = 1
	v7 = Animator:LoadAnimation(anim)
	v7:Play(p2)
	v5 = p1
	v6 = anim

	if v8 ~= nil then
		v8:disconnect()
	end

	v8 = v7.KeyframeReached:connect(keyFrameReachedFunc)
end

local v19 = ""
local v20 = nil
local v21 = nil
local v22 = nil
local v23 = nil

function toolKeyFrameReachedFunc(p1) --[[ toolKeyFrameReachedFunc | Line: 338 | Upvalues: v19 (ref), Humanoid (copy) ]]
	if p1 ~= "End" then
		return
	end

	playToolAnimation(v19, 0, Humanoid)
end
function playToolAnimation(p1, p2, p3, p4) --[[ playToolAnimation | Line: 344 | Upvalues: t (copy), v21 (ref), v20 (ref), v22 (ref), Animator (copy), Animator2 (copy), v19 (ref), v23 (ref) ]]
	local sum = math.random(1, t[p1].totalWeight)
	local count = 1

	while t[p1][count].weight < sum do
		sum = sum - t[p1][count].weight
		count = count + 1
	end

	local anim = t[p1][count].anim

	if v21 == anim then
		return
	end

	if v20 ~= nil then
		v20:Stop()
		v20:Destroy()
		p2 = 0
	end

	if v22 ~= nil then
		v22:Stop()
		v22:Destroy()
		v22 = nil
	end

	if p1 == "toolnone" then
		v22 = Animator:LoadAnimation(t.toolnoneAnimal[1].anim)
		v22:Play(p2)
	end

	v20 = Animator2:LoadAnimation(anim)

	if p4 then
		v20.Priority = p4
	end

	v20:Play(p2)
	v19 = p1
	v21 = anim
	v23 = v20.KeyframeReached:connect(toolKeyFrameReachedFunc)
end
function stopToolAnimations() --[[ stopToolAnimations | Line: 378 | Upvalues: v19 (ref), v23 (ref), v21 (ref), v20 (ref), v22 (ref) ]]
	local v1 = v19

	if v23 ~= nil then
		v23:disconnect()
	end

	v19 = ""
	v21 = nil

	if v20 ~= nil then
		v20:Stop()
		v20:Destroy()
		v20 = nil
	end

	if v22 == nil then
		return v1
	end

	v22:Stop()
	v22:Destroy()
	v22 = nil

	return v1
end
function onRunning(p1) --[[ onRunning | Line: 398 | Upvalues: v4 (copy), v1 (copy), Humanoid (copy), v6 (ref), v3 (ref), t13 (copy), v5 (ref) ]]
	local v2 = p1 / (if v4 then v1:GetScale() else 1)

	if v2 > 0.01 then
		playAnimation("walk", 0.1, Humanoid)

		if not v6 or v6.AnimationId ~= "http://www.roblox.com/asset/?id=180426354" then
			v3 = "Running"

			return
		end

		setAnimationSpeed(v2 / 14.5 / 4)
		v3 = "Running"
	else
		if t13[v5] ~= nil then
			return
		end

		playAnimation("idle", 0.1, Humanoid)
		v3 = "Standing"
	end
end
function onDied() --[[ onDied | Line: 414 | Upvalues: v3 (ref) ]]
	v3 = "Dead"
end
function onJumping() --[[ onJumping | Line: 418 | Upvalues: Humanoid (copy), v18 (ref), v3 (ref) ]]
	playAnimation("jump", 0.1, Humanoid)
	v18 = 0.3
	v3 = "Jumping"
end
function onClimbing(p1) --[[ onClimbing | Line: 424 | Upvalues: v4 (copy), v1 (copy), Humanoid (copy), v3 (ref) ]]
	local v12 = if v4 then v1:GetScale() else 1

	playAnimation("climb", 0.1, Humanoid)
	setAnimationSpeed(p1 / v12 / 12)
	v3 = "Climbing"
end
function onGettingUp() --[[ onGettingUp | Line: 431 | Upvalues: v3 (ref) ]]
	v3 = "GettingUp"
end
function onFreeFall() --[[ onFreeFall | Line: 435 | Upvalues: v18 (ref), Humanoid (copy), v3 (ref) ]]
	if not (v18 <= 0) then
		v3 = "FreeFall"

		return
	end

	playAnimation("fall", 0.3, Humanoid)
	v3 = "FreeFall"
end
function onFallingDown() --[[ onFallingDown | Line: 442 | Upvalues: v3 (ref) ]]
	v3 = "FallingDown"
end
function onSeated() --[[ onSeated | Line: 446 | Upvalues: v3 (ref) ]]
	v3 = "Seated"
end
function onPlatformStanding() --[[ onPlatformStanding | Line: 450 | Upvalues: v3 (ref) ]]
	v3 = "PlatformStanding"
end
function onSwimming(p1) --[[ onSwimming | Line: 454 | Upvalues: v3 (ref) ]]
	v3 = if p1 > 0 then "Running" else "Standing"
end
function getTool() --[[ getTool | Line: 462 | Upvalues: v1 (copy) ]]
	for i, v in ipairs(v1:GetChildren()) do
		if v.className == "Tool" then
			return v
		end
	end

	return nil
end
function getToolAnim(p1) --[[ getToolAnim | Line: 471 ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v.Name == "toolanim" and v.className == "StringValue" then
			return v
		end
	end

	return nil
end
function animateTool() --[[ animateTool | Line: 479 | Upvalues: v16 (ref), Humanoid (copy) ]]
	if v16 == "None" then
		playToolAnimation("toolnone", 0.1, Humanoid, Enum.AnimationPriority.Idle)

		return
	end

	if v16 == "Slash" then
		playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action)

		return
	end

	if v16 ~= "Lunge" then
		return
	end

	playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action)
end
function moveSit() --[[ moveSit | Line: 489 ]] end

local v24 = 0

function move(p1) --[[ move | Line: 491 | Upvalues: v24 (ref), v18 (ref), v3 (ref), Humanoid (copy), v16 (ref), v17 (ref), v21 (ref) ]]
	local v1 = 1
	local v2 = 1
	local v32 = p1 - v24

	v24 = p1

	local v4 = false

	if v18 > 0 then
		v18 = v18 - v32
	end

	if v3 == "FreeFall" and v18 <= 0 then
		playAnimation("fall", 0.3, Humanoid)
	else
		if v3 == "Seated" then
			playAnimation("sit", 0.5, Humanoid)

			return
		end

		if v3 == "Running" then
			playAnimation("walk", 0.1, Humanoid)
		elseif v3 == "Dead" or (v3 == "GettingUp" or (v3 == "FallingDown" or (v3 == "Seated" or v3 == "PlatformStanding"))) then
			stopAllAnimations()
			v4 = true
			v2 = 1
			v1 = 0.1
		end
	end

	if v4 then
		local _ = v1 * math.sin(p1 * v2)
	end

	local v5 = getTool()

	if not (v5 and v5:FindFirstChild("Handle")) then
		stopToolAnimations()
		v16 = "None"
		v21 = nil
		v17 = 0

		return
	end

	local v6 = getToolAnim(v5)

	if v6 then
		v16 = v6.Value
		v6.Parent = nil
		v17 = p1 + 0.3
	end

	if not (v17 < p1) then
		animateTool()

		return
	end

	v17 = 0
	v16 = "None"
	animateTool()
end
Humanoid.Died:connect(onDied)
Humanoid.Running:connect(onRunning)
Humanoid.Jumping:connect(onJumping)
Humanoid.Climbing:connect(onClimbing)
Humanoid.GettingUp:connect(onGettingUp)
Humanoid.FreeFalling:connect(onFreeFall)
Humanoid.FallingDown:connect(onFallingDown)
Humanoid.Seated:connect(onSeated)
Humanoid.PlatformStanding:connect(onPlatformStanding)
Humanoid.Swimming:connect(onSwimming)
game:GetService("Players").LocalPlayer.Chatted:connect(function(p1) --[[ Line: 550 | Upvalues: t12 (copy), v3 (ref), t13 (copy), Humanoid (copy) ]]
	local v1 = ""

	if p1 == "/e dance" then
		v1 = t12[math.random(1, #t12)]
	elseif string.sub(p1, 1, 3) == "/e " then
		v1 = string.sub(p1, 4)
	elseif string.sub(p1, 1, 7) == "/emote " then
		v1 = string.sub(p1, 8)
	end

	if v3 ~= "Standing" or t13[v1] == nil then
		return
	end

	playAnimation(v1, 0.1, Humanoid)
end)
script:WaitForChild("PlayEmote").OnInvoke = function(p1) --[[ Line: 564 | Upvalues: v3 (ref), t13 (copy), Humanoid (copy), v7 (ref) ]]
	if v3 ~= "Standing" then
		return
	end

	if t13[p1] == nil then
		return false
	end

	playAnimation(p1, 0.1, Humanoid)

	return true, v7
end
playAnimation("idle", 0.1, Humanoid)
game:GetService("CollectionService"):GetInstanceAddedSignal("DeadPlayer"):Connect(function(p1) --[[ Line: 576 ]]
	if p1 ~= game.Players.LocalPlayer then
		return
	end

	print("stop all anims because death")
	stopAllAnimations()
end)

while v1.Parent ~= nil do
	local _, v25 = wait(0.1)

	move(v25)
end