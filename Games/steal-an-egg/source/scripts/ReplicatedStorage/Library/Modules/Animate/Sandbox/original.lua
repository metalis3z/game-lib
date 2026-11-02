-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = script.Parent
local Humanoid = v1:WaitForChild("Humanoid")
local v2 = "Standing"
local ok, result = pcall(function() --[[ Line: 7 ]]
	return UserSettings():IsUserFeatureEnabled("UserNoUpdateOnLoop")
end)
local v3 = ok and result
local ok2, result2 = pcall(function() --[[ Line: 12 ]]
	return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun")
end)
local v4 = ok2 and result2

local function getRigScale() --[[ getRigScale | Line: 17 | Upvalues: v4 (copy), v1 (copy) ]]
	if v4 then
		return v1:GetScale()
	end

	return 1
end

local ScaleDampeningPercent = script:FindFirstChild("ScaleDampeningPercent")
local v5 = ""
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = 1
local v10 = nil
local v11 = nil
local t = {}
local t2 = {}
local tbl = {
	idle = {
		{
			id = "http://www.roblox.com/asset/?id=507766666",
			weight = 1
		},
		{
			id = "http://www.roblox.com/asset/?id=507766951",
			weight = 1
		},
		{
			id = "http://www.roblox.com/asset/?id=507766388",
			weight = 9
		}
	},
	walk = {
		{
			id = "http://www.roblox.com/asset/?id=507777826",
			weight = 10
		}
	},
	run = {
		{
			id = "http://www.roblox.com/asset/?id=507767714",
			weight = 10
		}
	},
	swim = {
		{
			id = "http://www.roblox.com/asset/?id=507784897",
			weight = 10
		}
	},
	swimidle = {
		{
			id = "http://www.roblox.com/asset/?id=507785072",
			weight = 10
		}
	},
	jump = {
		{
			id = "http://www.roblox.com/asset/?id=507765000",
			weight = 10
		}
	},
	fall = {
		{
			id = "http://www.roblox.com/asset/?id=507767968",
			weight = 10
		}
	},
	climb = {
		{
			id = "http://www.roblox.com/asset/?id=507765644",
			weight = 10
		}
	},
	sit = {
		{
			id = "http://www.roblox.com/asset/?id=2506281703",
			weight = 10
		}
	},
	toolnone = {
		{
			id = "http://www.roblox.com/asset/?id=507768375",
			weight = 10
		}
	},
	toolslash = {
		{
			id = "http://www.roblox.com/asset/?id=522635514",
			weight = 10
		}
	},
	toollunge = {
		{
			id = "http://www.roblox.com/asset/?id=522638767",
			weight = 10
		}
	},
	wave = {
		{
			id = "http://www.roblox.com/asset/?id=507770239",
			weight = 10
		}
	},
	point = {
		{
			id = "http://www.roblox.com/asset/?id=507770453",
			weight = 10
		}
	},
	dance = {
		{
			id = "http://www.roblox.com/asset/?id=507771019",
			weight = 10
		},
		{
			id = "http://www.roblox.com/asset/?id=507771955",
			weight = 10
		},
		{
			id = "http://www.roblox.com/asset/?id=507772104",
			weight = 10
		}
	},
	dance2 = {
		{
			id = "http://www.roblox.com/asset/?id=507776043",
			weight = 10
		},
		{
			id = "http://www.roblox.com/asset/?id=507776720",
			weight = 10
		},
		{
			id = "http://www.roblox.com/asset/?id=507776879",
			weight = 10
		}
	},
	dance3 = {
		{
			id = "http://www.roblox.com/asset/?id=507777268",
			weight = 10
		},
		{
			id = "http://www.roblox.com/asset/?id=507777451",
			weight = 10
		},
		{
			id = "http://www.roblox.com/asset/?id=507777623",
			weight = 10
		}
	},
	laugh = {
		{
			id = "http://www.roblox.com/asset/?id=507770818",
			weight = 10
		}
	},
	cheer = {
		{
			id = "http://www.roblox.com/asset/?id=507770677",
			weight = 10
		}
	}
}
local t3 = {
	wave = false,
	point = false,
	dance = true,
	dance2 = true,
	dance3 = true,
	laugh = false,
	cheer = false
}

math.randomseed(tick())
function findExistingAnimationInSet(p1, p2) --[[ findExistingAnimationInSet | Line: 116 ]]
	if p1 == nil or p2 == nil then
		return 0
	end

	for i = 1, p1.count do
		if p1[i].anim.AnimationId == p2.AnimationId then
			return i
		end
	end

	return 0
end
function configureAnimationSet(p1, p2) --[[ configureAnimationSet | Line: 130 | Upvalues: t2 (copy), t (copy), Humanoid (copy) ]]
	if t2[p1] ~= nil then
		for k, v in pairs(t2[p1].connections) do
			v:disconnect()
		end
	end

	t2[p1] = {}
	t2[p1].count = 0
	t2[p1].totalWeight = 0
	t2[p1].connections = {}

	local v1 = true
	local ok, _ = pcall(function() --[[ Line: 143 | Upvalues: v1 (ref) ]]
		v1 = game:GetService("StarterPlayer").AllowCustomAnimations
	end)

	if not ok then
		v1 = true
	end

	local v2 = script:FindFirstChild(p1)

	if v1 and v2 ~= nil then
		table.insert(t2[p1].connections, v2.ChildAdded:connect(function(p12) --[[ Line: 155 | Upvalues: p1 (copy), p2 (copy) ]]
			configureAnimationSet(p1, p2)
		end))
		table.insert(t2[p1].connections, v2.ChildRemoved:connect(function(p12) --[[ Line: 161 | Upvalues: p1 (copy), p2 (copy) ]]
			configureAnimationSet(p1, p2)
		end))

		for k, v in pairs(v2:GetChildren()) do
			if v:IsA("Animation") then
				local Weight = v:FindFirstChild("Weight")
				local v3 = if Weight == nil then 1 else Weight.Value

				t2[p1].count = t2[p1].count + 1

				local count = t2[p1].count

				t2[p1][count] = {}
				t2[p1][count].anim = v
				t2[p1][count].weight = v3
				t2[p1].totalWeight = t2[p1].totalWeight + t2[p1][count].weight
				table.insert(t2[p1].connections, v.Changed:connect(function(p12) --[[ Line: 182 | Upvalues: p1 (copy), p2 (copy) ]]
					configureAnimationSet(p1, p2)
				end))
				table.insert(t2[p1].connections, v.ChildAdded:connect(function(p12) --[[ Line: 188 | Upvalues: p1 (copy), p2 (copy) ]]
					configureAnimationSet(p1, p2)
				end))
				table.insert(t2[p1].connections, v.ChildRemoved:connect(function(p12) --[[ Line: 194 | Upvalues: p1 (copy), p2 (copy) ]]
					configureAnimationSet(p1, p2)
				end))
			end
		end
	end

	if t2[p1].count <= 0 then
		for k, v in pairs(p2) do
			t2[p1][k] = {}
			t2[p1][k].anim = Instance.new("Animation")
			t2[p1][k].anim.Name = p1
			t2[p1][k].anim.AnimationId = v.id
			t2[p1][k].weight = v.weight
			t2[p1].count = t2[p1].count + 1
			t2[p1].totalWeight = t2[p1].totalWeight + v.weight
		end
	end

	for k, v in pairs(t2) do
		for i = 1, v.count do
			if t[v[i].anim.AnimationId] == nil then
				Humanoid:LoadAnimation(v[i].anim)
				t[v[i].anim.AnimationId] = true
			end
		end
	end
end
function configureAnimationSetOld(p1, p2) --[[ configureAnimationSetOld | Line: 228 | Upvalues: t2 (copy), Humanoid (copy) ]]
	if t2[p1] ~= nil then
		for k, v in pairs(t2[p1].connections) do
			v:disconnect()
		end
	end

	t2[p1] = {}
	t2[p1].count = 0
	t2[p1].totalWeight = 0
	t2[p1].connections = {}

	local v1 = true
	local ok, _ = pcall(function() --[[ Line: 241 | Upvalues: v1 (ref) ]]
		v1 = game:GetService("StarterPlayer").AllowCustomAnimations
	end)

	if not ok then
		v1 = true
	end

	local v2 = script:FindFirstChild(p1)

	if v1 and v2 ~= nil then
		table.insert(t2[p1].connections, v2.ChildAdded:connect(function(p12) --[[ Line: 253 | Upvalues: p1 (copy), p2 (copy) ]]
			configureAnimationSet(p1, p2)
		end))
		table.insert(t2[p1].connections, v2.ChildRemoved:connect(function(p12) --[[ Line: 259 | Upvalues: p1 (copy), p2 (copy) ]]
			configureAnimationSet(p1, p2)
		end))

		local count = 1

		for k, v in pairs(v2:GetChildren()) do
			if v:IsA("Animation") then
				table.insert(t2[p1].connections, v.Changed:connect(function(p12) --[[ Line: 268 | Upvalues: p1 (copy), p2 (copy) ]]
					configureAnimationSet(p1, p2)
				end))
				t2[p1][count] = {}
				t2[p1][count].anim = v

				local Weight = v:FindFirstChild("Weight")

				if Weight == nil then
					t2[p1][count].weight = 1
				else
					t2[p1][count].weight = Weight.Value
				end

				t2[p1].count = t2[p1].count + 1
				t2[p1].totalWeight = t2[p1].totalWeight + t2[p1][count].weight
				count = count + 1
			end
		end
	end

	if t2[p1].count <= 0 then
		for k, v in pairs(p2) do
			t2[p1][k] = {}
			t2[p1][k].anim = Instance.new("Animation")
			t2[p1][k].anim.Name = p1
			t2[p1][k].anim.AnimationId = v.id
			t2[p1][k].weight = v.weight
			t2[p1].count = t2[p1].count + 1
			t2[p1].totalWeight = t2[p1].totalWeight + v.weight
		end
	end

	for k, v in pairs(t2) do
		for i = 1, v.count do
			Humanoid:LoadAnimation(v[i].anim)
		end
	end
end
function scriptChildModified(p1) --[[ scriptChildModified | Line: 310 | Upvalues: tbl (copy) ]]
	local v1 = tbl[p1.Name]

	if v1 == nil then
		return
	end

	configureAnimationSet(p1.Name, v1)
end
script.ChildAdded:connect(scriptChildModified)
script.ChildRemoved:connect(scriptChildModified)

local v12 = if Humanoid then Humanoid:FindFirstChildOfClass("Animator") else nil

if v12 then
	for i, v in ipairs((v12:GetPlayingAnimationTracks())) do
		v:Stop(0)
		v:Destroy()
	end
end

for k, v in pairs(tbl) do
	configureAnimationSet(k, v)
end

local v14 = "None"
local v15 = 0
local v16 = 0
local v17 = false

function stopAllAnimations() --[[ stopAllAnimations | Line: 351 | Upvalues: v5 (ref), t3 (copy), v17 (ref), v6 (ref), v8 (ref), v7 (ref), v11 (ref), v10 (ref) ]]
	local v1 = v5

	if t3[v1] ~= nil and t3[v1] == false then
		v1 = "idle"
	end

	if v17 then
		v1 = "idle"
		v17 = false
	end

	v5 = ""
	v6 = nil

	if v8 ~= nil then
		v8:disconnect()
	end

	if v7 ~= nil then
		v7:Stop()
		v7:Destroy()
		v7 = nil
	end

	if v11 ~= nil then
		v11:disconnect()
	end

	if v10 == nil then
		return v1
	end

	v10:Stop()
	v10:Destroy()
	v10 = nil

	return v1
end
function getHeightScale() --[[ getHeightScale | Line: 390 | Upvalues: Humanoid (copy), getRigScale (copy), ScaleDampeningPercent (ref) ]]
	if not Humanoid then
		return getRigScale()
	end

	if not Humanoid.AutomaticScalingEnabled then
		return getRigScale()
	end

	local v1 = Humanoid.HipHeight / 2

	if ScaleDampeningPercent == nil then
		ScaleDampeningPercent = script:FindFirstChild("ScaleDampeningPercent")
	end

	if ScaleDampeningPercent ~= nil then
		v1 = 1 + (Humanoid.HipHeight - 2) * ScaleDampeningPercent.Value / 2
	end

	return v1
end

local function rootMotionCompensation(p1) --[[ rootMotionCompensation | Line: 411 ]]
	return p1 * 1.25 / getHeightScale()
end

local function setRunSpeed(p1) --[[ setRunSpeed | Line: 419 | Upvalues: v7 (ref), v10 (ref) ]]
	local v1 = p1 * 1.25 / getHeightScale()
	local v2 = 0.0001
	local v3 = 1
	local v4

	if v1 <= 0.5 then
		v2 = 1
		v4 = 0.0001
		v3 = v1 / 0.5
	elseif v1 < 1 then
		local v5 = (v1 - 0.5) / 0.5

		v2 = 1 - v5
		v4 = v5
	else
		v4 = 1
		v3 = v1 / 1
	end

	v7:AdjustWeight(v2)
	v10:AdjustWeight(v4)
	v7:AdjustSpeed(v3)
	v10:AdjustSpeed(v3)
end

function setAnimationSpeed(p1) --[[ setAnimationSpeed | Line: 445 | Upvalues: v5 (ref), setRunSpeed (copy), v9 (ref), v7 (ref) ]]
	if v5 == "walk" then
		setRunSpeed(p1)

		return
	end

	if p1 == v9 then
		return
	end

	v9 = p1
	v7:AdjustSpeed(p1)
end
function keyFrameReachedFunc(p1) --[[ keyFrameReachedFunc | Line: 456 | Upvalues: v5 (ref), v3 (copy), v10 (ref), v7 (ref), t3 (copy), v17 (ref), v9 (ref), Humanoid (copy) ]]
	if p1 ~= "End" then
		return
	end

	if v5 == "walk" then
		if v3 ~= true then
			v10.TimePosition = 0
			v7.TimePosition = 0

			return
		end

		if v10.Looped ~= true then
			v10.TimePosition = 0
		end

		if v7.Looped ~= true then
			v7.TimePosition = 0
		end
	else
		local v1 = v5

		if t3[v1] ~= nil and t3[v1] == false then
			v1 = "idle"
		end

		if v17 then
			if v7.Looped then
				return
			end

			v1 = "idle"
			v17 = false
		end

		playAnimation(v1, 0.15, Humanoid)
		setAnimationSpeed(v9)
	end
end
function rollAnimation(p1) --[[ rollAnimation | Line: 494 | Upvalues: t2 (copy) ]]
	local sum = math.random(1, t2[p1].totalWeight)
	local count = 1

	while t2[p1][count].weight < sum do
		sum = sum - t2[p1][count].weight
		count = count + 1
	end

	return count
end

local function switchToAnim(p1, p2, p3, p4) --[[ switchToAnim | Line: 505 | Upvalues: v6 (ref), v7 (ref), v10 (ref), v3 (copy), v9 (ref), v5 (ref), v8 (ref), t2 (copy), v11 (ref) ]]
	if p1 == v6 then
		return
	end

	if v7 ~= nil then
		v7:Stop(p3)
		v7:Destroy()
	end

	if v10 ~= nil then
		v10:Stop(p3)
		v10:Destroy()

		if v3 == true then
			v10 = nil
		end
	end

	v9 = 1
	v7 = p4:LoadAnimation(p1)
	v7.Priority = Enum.AnimationPriority.Core
	v7:Play(p3)
	v5 = p2
	v6 = p1

	if v8 ~= nil then
		v8:disconnect()
	end

	v8 = v7.KeyframeReached:connect(keyFrameReachedFunc)

	if p2 ~= "walk" then
		return
	end

	v10 = p4:LoadAnimation(t2.run[rollAnimation("run")].anim)
	v10.Priority = Enum.AnimationPriority.Core
	v10:Play(p3)

	if v11 ~= nil then
		v11:disconnect()
	end

	v11 = v10.KeyframeReached:connect(keyFrameReachedFunc)
end

function playAnimation(p1, p2, p3) --[[ playAnimation | Line: 555 | Upvalues: t2 (copy), switchToAnim (copy), v17 (ref) ]]
	switchToAnim(t2[p1][rollAnimation(p1)].anim, p1, p2, p3)
	v17 = false
end
function playEmote(p1, p2, p3) --[[ playEmote | Line: 563 | Upvalues: switchToAnim (copy), v17 (ref) ]]
	switchToAnim(p1, p1.Name, p2, p3)
	v17 = true
end

local v18 = ""
local v19 = nil
local v20 = nil
local v21 = nil

function toolKeyFrameReachedFunc(p1) --[[ toolKeyFrameReachedFunc | Line: 576 | Upvalues: v18 (ref), Humanoid (copy) ]]
	if p1 ~= "End" then
		return
	end

	playToolAnimation(v18, 0, Humanoid)
end
function playToolAnimation(p1, p2, p3, p4) --[[ playToolAnimation | Line: 582 | Upvalues: t2 (copy), v20 (ref), v19 (ref), v18 (ref), v21 (ref) ]]
	local anim = t2[p1][rollAnimation(p1)].anim

	if v20 == anim then
		return
	end

	if v19 ~= nil then
		v19:Stop()
		v19:Destroy()
		p2 = 0
	end

	v19 = p3:LoadAnimation(anim)

	if p4 then
		v19.Priority = p4
	end

	v19:Play(p2)
	v18 = p1
	v20 = anim
	v21 = v19.KeyframeReached:connect(toolKeyFrameReachedFunc)
end
function stopToolAnimations() --[[ stopToolAnimations | Line: 608 | Upvalues: v18 (ref), v21 (ref), v20 (ref), v19 (ref) ]]
	local v1 = v18

	if v21 ~= nil then
		v21:disconnect()
	end

	v18 = ""
	v20 = nil

	if v19 == nil then
		return v1
	end

	v19:Stop()
	v19:Destroy()
	v19 = nil

	return v1
end
function onRunning(p1) --[[ onRunning | Line: 630 | Upvalues: v4 (copy), v17 (ref), Humanoid (copy), v2 (ref), t3 (copy), v5 (ref) ]]
	local v1 = if v4 then getHeightScale() else 1

	if (v17 and Humanoid.MoveDirection == Vector3.new(0, 0, 0) and Humanoid.WalkSpeed / v1 or 0.75) * v1 < p1 then
		playAnimation("walk", 0.2, Humanoid)
		setAnimationSpeed(p1 / 16)
		v2 = "Running"

		return
	end

	if t3[v5] ~= nil or v17 then
		return
	end

	playAnimation("idle", 0.2, Humanoid)
	v2 = "Standing"
end
function onDied() --[[ onDied | Line: 648 | Upvalues: v2 (ref) ]]
	v2 = "Dead"
end
function onJumping() --[[ onJumping | Line: 652 | Upvalues: Humanoid (copy), v16 (ref), v2 (ref) ]]
	playAnimation("jump", 0.1, Humanoid)
	v16 = 0.31
	v2 = "Jumping"
end
function onClimbing(p1) --[[ onClimbing | Line: 658 | Upvalues: v4 (copy), Humanoid (copy), v2 (ref) ]]
	if v4 then
		p1 = p1 / getHeightScale()
	end

	playAnimation("climb", 0.1, Humanoid)
	setAnimationSpeed(p1 / 5)
	v2 = "Climbing"
end
function onGettingUp() --[[ onGettingUp | Line: 668 | Upvalues: v2 (ref) ]]
	v2 = "GettingUp"
end
function onFreeFall() --[[ onFreeFall | Line: 672 | Upvalues: v16 (ref), Humanoid (copy), v2 (ref) ]]
	if not (v16 <= 0) then
		v2 = "FreeFall"

		return
	end

	playAnimation("fall", 0.2, Humanoid)
	v2 = "FreeFall"
end
function onFallingDown() --[[ onFallingDown | Line: 679 | Upvalues: v2 (ref) ]]
	v2 = "FallingDown"
end
function onSeated() --[[ onSeated | Line: 683 | Upvalues: v2 (ref) ]]
	v2 = "Seated"
end
function onPlatformStanding() --[[ onPlatformStanding | Line: 687 | Upvalues: v2 (ref) ]]
	v2 = "PlatformStanding"
end
function onSwimming(p1) --[[ onSwimming | Line: 694 | Upvalues: v4 (copy), Humanoid (copy), v2 (ref) ]]
	if v4 then
		p1 = p1 / getHeightScale()
	end

	if p1 > 1 then
		playAnimation("swim", 0.4, Humanoid)
		setAnimationSpeed(p1 / 10)
		v2 = "Swimming"
	else
		playAnimation("swimidle", 0.4, Humanoid)
		v2 = "Standing"
	end
end
function animateTool() --[[ animateTool | Line: 709 | Upvalues: v14 (ref), Humanoid (copy) ]]
	if v14 == "None" then
		playToolAnimation("toolnone", 0.1, Humanoid, Enum.AnimationPriority.Idle)

		return
	end

	if v14 == "Slash" then
		playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action)

		return
	end

	if v14 == "Lunge" then
		playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action)
	end
end
function getToolAnim(p1) --[[ getToolAnim | Line: 726 ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v.Name == "toolanim" and v.className == "StringValue" then
			return v
		end
	end

	return nil
end

local v22 = 0

function stepAnimate(p1) --[[ stepAnimate | Line: 737 | Upvalues: v22 (ref), v16 (ref), v2 (ref), Humanoid (copy), v1 (copy), v14 (ref), v15 (ref), v20 (ref) ]]
	local v12 = p1 - v22

	v22 = p1

	if v16 > 0 then
		v16 = v16 - v12
	end

	if v2 == "FreeFall" and v16 <= 0 then
		playAnimation("fall", 0.2, Humanoid)
	else
		if v2 == "Seated" then
			playAnimation("sit", 0.5, Humanoid)

			return
		end

		if v2 == "Running" then
			playAnimation("walk", 0.2, Humanoid)
		elseif v2 == "Dead" or (v2 == "GettingUp" or (v2 == "FallingDown" or (v2 == "Seated" or v2 == "PlatformStanding"))) then
			stopAllAnimations()
		end
	end

	local Tool = v1:FindFirstChildOfClass("Tool")

	if not (Tool and Tool:FindFirstChild("Handle")) then
		stopToolAnimations()
		v14 = "None"
		v20 = nil
		v15 = 0

		return
	end

	local v23 = getToolAnim(Tool)

	if v23 then
		v14 = v23.Value
		v23.Parent = nil
		v15 = p1 + 0.3
	end

	if not (v15 < p1) then
		animateTool()

		return
	end

	v15 = 0
	v14 = "None"
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
game:GetService("Players").LocalPlayer.Chatted:connect(function(p1) --[[ Line: 809 | Upvalues: v2 (ref), t3 (copy), Humanoid (copy) ]]
	local v1 = ""

	if string.sub(p1, 1, 3) == "/e " then
		v1 = string.sub(p1, 4)
	elseif string.sub(p1, 1, 7) == "/emote " then
		v1 = string.sub(p1, 8)
	end

	if v2 ~= "Standing" or t3[v1] == nil then
		return
	end

	playAnimation(v1, 0.1, Humanoid)
end)
script:WaitForChild("PlayEmote").OnInvoke = function(p1) --[[ Line: 823 | Upvalues: v2 (ref), t3 (copy), Humanoid (copy), v7 (ref) ]]
	if v2 ~= "Standing" then
		return
	end

	if t3[p1] ~= nil then
		playAnimation(p1, 0.1, Humanoid)

		return true, v7
	end

	if typeof(p1) == "Instance" and p1:IsA("Animation") then
		playEmote(p1, 0.1, Humanoid)

		return true, v7
	end

	return false
end

if v1.Parent ~= nil then
	playAnimation("idle", 0.1, Humanoid)
end

while v1.Parent ~= nil do
	local _, v23 = wait(0.1)

	stepAnimate(v23)
end