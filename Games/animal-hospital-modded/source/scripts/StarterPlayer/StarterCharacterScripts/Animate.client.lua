local v1 = script.Parent
local CharacterModel = script.Parent:WaitForChild("CharacterModel")
local Animator = CharacterModel:WaitForChild("AnimationController"):WaitForChild("Animator")
local Humanoid = v1:WaitForChild("Humanoid")
local Animator2 = Humanoid:WaitForChild("Animator")
local v2 = "Standing"
local ok, result = pcall(function() --[[ Line: 19 ]]
	return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun")
end)
local v3 = ok and result

local function getRigScale() --[[ getRigScale | Line: 22 | Upvalues: v3 (copy), v1 (copy) ]]
	if v3 then
		return v1:GetScale()
	end

	return 1
end

local v4 = ""
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = 1
local t = {}

local function GetAnimation(p1) --[[ GetAnimation | Line: 38 | Upvalues: CharacterModel (copy) ]]
	local v1 = CharacterModel:WaitForChild(p1, 5)

	return if v1 then v1.AnimationId else v1
end

local tbl = {}
local t2 = {}
local t3 = {
	weight = 9,
	speed = 0.6
}
local Idle = CharacterModel:WaitForChild("Idle", 5)

t3.id = Idle and Idle.AnimationId
t2[1] = t3
tbl.idle = t2

local t4 = {}
local t5 = {
	weight = 10,
	speed = 2
}
local Walk = CharacterModel:WaitForChild("Walk", 5)

t5.id = Walk and Walk.AnimationId
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
local Jump = CharacterModel:WaitForChild("Jump", 5)

t7.id = Jump and Jump.AnimationId or "http://www.roblox.com/asset/?id=125750702"
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
local Idle2 = CharacterModel:WaitForChild("Idle", 5)

t9.id = Idle2 and Idle2.AnimationId
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
		id = "http://www.roblox.com/asset/?id=98274437792491",
		weight = 10
	}
}

local t10 = {}
local t11 = {
	weight = 10
}
local Tool = CharacterModel:WaitForChild("Tool", 5)

t11.id = Tool and Tool.AnimationId
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

function configureAnimationSet(p1, p2) --[[ configureAnimationSet | Line: 111 | Upvalues: t (copy) ]]
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
		table.insert(t[p1].connections, v1.ChildAdded:connect(function(p12) --[[ Line: 126 | Upvalues: p1 (copy), p2 (copy) ]]
			configureAnimationSet(p1, p2)
		end))
		table.insert(t[p1].connections, v1.ChildRemoved:connect(function(p12) --[[ Line: 127 | Upvalues: p1 (copy), p2 (copy) ]]
			configureAnimationSet(p1, p2)
		end))

		local count = 1

		for k, v in pairs(v1:GetChildren()) do
			if v:IsA("Animation") then
				table.insert(t[p1].connections, v.Changed:connect(function(p12) --[[ Line: 131 | Upvalues: p1 (copy), p2 (copy) ]]
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
		t[p1][k].anim.AnimationId = v.id or ""
		t[p1][k].weight = v.weight
		t[p1].count = t[p1].count + 1
		t[p1].totalWeight = t[p1].totalWeight + v.weight
	end
end
function scriptChildModified(p1) --[[ scriptChildModified | Line: 165 | Upvalues: tbl (copy) ]]
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

local v15 = "None"
local v16 = 0
local v17 = 0

function stopAllAnimations() --[[ stopAllAnimations | Line: 206 | Upvalues: v4 (ref), t13 (copy), v5 (ref), v7 (ref), v6 (ref) ]]
	local v1 = v4

	if t13[v1] ~= nil and t13[v1] == false then
		v1 = "idle"
	end

	v4 = ""
	v5 = nil

	if v7 ~= nil then
		v7:disconnect()
	end

	if v6 == nil then
		return v1
	end

	v6:Stop()
	v6:Destroy()
	v6 = nil

	return v1
end
function setAnimationSpeed(p1) --[[ setAnimationSpeed | Line: 228 | Upvalues: v8 (ref), v6 (ref) ]]
	if p1 == v8 then
		return
	end

	v8 = p1
	v6:AdjustSpeed(p1)
end
function keyFrameReachedFunc(p1) --[[ keyFrameReachedFunc | Line: 235 | Upvalues: v4 (ref), t13 (copy), v8 (ref), Humanoid (copy) ]]
	if p1 ~= "End" then
		return
	end

	local v1 = v4

	if t13[v1] ~= nil and t13[v1] == false then
		v1 = "idle"
	end

	playAnimation(v1, 0, Humanoid)
	setAnimationSpeed(v8)
end
function playAnimation(p1, p2, p3) --[[ playAnimation | Line: 251 | Upvalues: t (copy), v5 (ref), v6 (ref), v8 (ref), Animator (copy), v4 (ref), v7 (ref) ]]
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

	if anim == v5 then
		return
	end

	if v6 ~= nil then
		v6:Stop(p2)
		v6:Destroy()
	end

	v8 = 1
	if not anim or anim.AnimationId == "" then
		return
	end
	v6 = Animator:LoadAnimation(anim)
	v6:Play(p2)
	v4 = p1
	v5 = anim

	if v7 ~= nil then
		v7:disconnect()
	end

	v7 = v6.KeyframeReached:connect(keyFrameReachedFunc)
end

local v18 = ""
local v19 = nil
local v20 = nil
local v21 = nil
local v22 = nil

function toolKeyFrameReachedFunc(p1) --[[ toolKeyFrameReachedFunc | Line: 302 | Upvalues: v18 (ref), Humanoid (copy) ]]
	if p1 ~= "End" then
		return
	end

	playToolAnimation(v18, 0, Humanoid)
end
function playToolAnimation(p1, p2, p3, p4) --[[ playToolAnimation | Line: 310 | Upvalues: t (copy), v20 (ref), v19 (ref), v21 (ref), Animator (copy), Animator2 (copy), v18 (ref), v22 (ref) ]]
	local sum = math.random(1, t[p1].totalWeight)
	local count = 1

	while t[p1][count].weight < sum do
		sum = sum - t[p1][count].weight
		count = count + 1
	end

	local anim = t[p1][count].anim

	if v20 == anim then
		return
	end

	if v19 ~= nil then
		v19:Stop()
		v19:Destroy()
		p2 = 0
	end

	if v21 ~= nil then
		v21:Stop()
		v21:Destroy()
		v21 = nil
	end

	if p1 == "toolnone" then
		local entry = t.toolnoneAnimal and t.toolnoneAnimal[1]
		local a = entry and entry.anim
		if a then
			local ok, loaded = pcall(function() return Animator:LoadAnimation(a) end)
			if ok and loaded then
				v21 = loaded
				pcall(function() v21:Play(p2) end)
			end
		end
	end

	-- Animaciones de herramienta perdidas (assets privados): si no cargan, no
	-- animamos pero tampoco reventamos el script (el tool igual se equipa/se ve).
	local ok2, loaded2 = pcall(function() return Animator2:LoadAnimation(anim) end)
	if not ok2 or not loaded2 then
		v18 = p1
		v20 = anim
		return
	end
	v19 = loaded2

	if p4 then
		v19.Priority = p4
	end

	v19:Play(p2)
	v18 = p1
	v20 = anim
	v22 = v19.KeyframeReached:connect(toolKeyFrameReachedFunc)
end
function stopToolAnimations() --[[ stopToolAnimations | Line: 356 | Upvalues: v18 (ref), v22 (ref), v20 (ref), v19 (ref), v21 (ref) ]]
	local v1 = v18

	if v22 ~= nil then
		v22:disconnect()
	end

	v18 = ""
	v20 = nil

	if v19 ~= nil then
		v19:Stop()
		v19:Destroy()
		v19 = nil
	end

	if v21 == nil then
		return v1
	end

	v21:Stop()
	v21:Destroy()
	v21 = nil

	return v1
end
function onRunning(p1) --[[ onRunning | Line: 385 | Upvalues: v3 (copy), v1 (copy), Humanoid (copy), v5 (ref), v2 (ref), t13 (copy), v4 (ref) ]]
	local v22 = p1 / (if v3 then v1:GetScale() else 1)

	if v22 > 0.01 then
		playAnimation("walk", 0.1, Humanoid)

		if not v5 or v5.AnimationId ~= "http://www.roblox.com/asset/?id=180426354" then
			v2 = "Running"

			return
		end

		setAnimationSpeed(v22 / 14.5 / 4)
		v2 = "Running"
	else
		if t13[v4] ~= nil then
			return
		end

		playAnimation("idle", 0.1, Humanoid)
		v2 = "Standing"
	end
end
function onDied() --[[ onDied | Line: 402 | Upvalues: v2 (ref) ]]
	v2 = "Dead"
end
function onJumping() --[[ onJumping | Line: 406 | Upvalues: Humanoid (copy), v17 (ref), v2 (ref) ]]
	playAnimation("jump", 0.1, Humanoid)
	v17 = 0.3
	v2 = "Jumping"
end
function onClimbing(p1) --[[ onClimbing | Line: 412 | Upvalues: v3 (copy), v1 (copy), Humanoid (copy), v2 (ref) ]]
	local v12 = if v3 then v1:GetScale() else 1

	playAnimation("climb", 0.1, Humanoid)
	setAnimationSpeed(p1 / v12 / 12)
	v2 = "Climbing"
end
function onGettingUp() --[[ onGettingUp | Line: 420 | Upvalues: v2 (ref) ]]
	v2 = "GettingUp"
end
function onFreeFall() --[[ onFreeFall | Line: 424 | Upvalues: v17 (ref), Humanoid (copy), v2 (ref) ]]
	if v17 <= 0 then
		playAnimation("fall", 0.3, Humanoid)
	end

	v2 = "FreeFall"
end
function onFallingDown() --[[ onFallingDown | Line: 431 | Upvalues: v2 (ref) ]]
	v2 = "FallingDown"
end
function onSeated() --[[ onSeated | Line: 435 | Upvalues: v2 (ref) ]]
	v2 = "Seated"
end
function onPlatformStanding() --[[ onPlatformStanding | Line: 439 | Upvalues: v2 (ref) ]]
	v2 = "PlatformStanding"
end
function onSwimming(p1) --[[ onSwimming | Line: 443 | Upvalues: v2 (ref) ]]
	v2 = if p1 > 0 then "Running" else "Standing"
end
function getTool() --[[ getTool | Line: 451 | Upvalues: v1 (copy) ]]
	for i, v in ipairs(v1:GetChildren()) do
		if v.className == "Tool" then
			return v
		end
	end

	return nil
end
function getToolAnim(p1) --[[ getToolAnim | Line: 458 ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v.Name == "toolanim" and v.className == "StringValue" then
			return v
		end
	end

	return nil
end
function animateTool() --[[ animateTool | Line: 467 | Upvalues: v15 (ref), Humanoid (copy) ]]
	if v15 == "None" then
		playToolAnimation("toolnone", 0.1, Humanoid, Enum.AnimationPriority.Idle)

		return
	end

	if v15 == "Slash" then
		playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action)

		return
	end

	if v15 == "Lunge" then
		playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action)
	end
end
function moveSit() --[[ moveSit | Line: 485 ]] end

local v23 = 0

function move(p1) --[[ move | Line: 496 | Upvalues: v23 (ref), v17 (ref), v2 (ref), Humanoid (copy), v15 (ref), v16 (ref), v20 (ref) ]]
	local v1 = 1
	local v22 = 1
	local v3 = p1 - v23

	v23 = p1

	local v4 = false

	if v17 > 0 then
		v17 = v17 - v3
	end

	if v2 == "FreeFall" and v17 <= 0 then
		playAnimation("fall", 0.3, Humanoid)
	else
		if v2 == "Seated" then
			playAnimation("sit", 0.5, Humanoid)

			return
		end

		if v2 == "Running" then
			playAnimation("walk", 0.1, Humanoid)
		elseif v2 == "Dead" or (v2 == "GettingUp" or (v2 == "FallingDown" or (v2 == "Seated" or v2 == "PlatformStanding"))) then
			stopAllAnimations()
			v4 = true
			v22 = 1
			v1 = 0.1
		end
	end

	if v4 then
		local _ = v1 * math.sin(p1 * v22)
	end

	local v5 = getTool()

	if not (v5 and v5:FindFirstChild("Handle")) then
		stopToolAnimations()
		v15 = "None"
		v20 = nil
		v16 = 0

		return
	end

	local v6 = getToolAnim(v5)

	if v6 then
		v15 = v6.Value
		v6.Parent = nil
		v16 = p1 + 0.3
	end

	if v16 < p1 then
		v16 = 0
		v15 = "None"
	end

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
game:GetService("Players").LocalPlayer.Chatted:connect(function(p1) --[[ Line: 573 | Upvalues: t12 (copy), v2 (ref), t13 (copy), Humanoid (copy) ]]
	local v1 = ""

	if p1 == "/e dance" then
		v1 = t12[math.random(1, #t12)]
	elseif string.sub(p1, 1, 3) == "/e " then
		v1 = string.sub(p1, 4)
	elseif string.sub(p1, 1, 7) == "/emote " then
		v1 = string.sub(p1, 8)
	end

	if v2 ~= "Standing" or t13[v1] == nil then
		return
	end

	playAnimation(v1, 0.1, Humanoid)
end)
script:WaitForChild("PlayEmote").OnInvoke = function(p1) --[[ Line: 590 | Upvalues: v2 (ref), t13 (copy), Humanoid (copy), v6 (ref) ]]
	if v2 ~= "Standing" then
		return
	end

	if t13[p1] == nil then
		return false
	end

	playAnimation(p1, 0.1, Humanoid)

	return true, v6
end
playAnimation("idle", 0.1, Humanoid)
game:GetService("CollectionService"):GetInstanceAddedSignal("DeadPlayer"):Connect(function(p1) --[[ Line: 611 ]]
	if p1 ~= game.Players.LocalPlayer then
		return
	end

	print("stop all anims because death")
	stopAllAnimations()
end)

while v1.Parent ~= nil do
	local _2, v24 = wait(0.1)

	move(v24)
end