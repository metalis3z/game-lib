-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = script.Parent
local Humanoid = v1:WaitForChild("Humanoid")
local v2 = "Standing"

local function getRigScale() --[[ getRigScale | Line: 7 | Upvalues: v1 (copy) ]]
	return v1:GetScale()
end

local ScaleDampeningPercent = script:FindFirstChild("ScaleDampeningPercent")
local v3 = ""
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = 1
local v8 = nil
local v9 = nil
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
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil

function resetManagerListeners() --[[ resetManagerListeners | Line: 115 | Upvalues: v10 (ref), v11 (ref), v12 (ref) ]]
	if v10 then
		v10:Disconnect()
		v10 = nil
	end

	if v11 then
		v11:Disconnect()
		v11 = nil
	end

	if not v12 then
		return
	end

	v12:Disconnect()
	v12 = nil
end
function processIfManagerBelongsToCharacter(p1) --[[ processIfManagerBelongsToCharacter | Line: 132 | Upvalues: v1 (copy), v14 (ref), v13 (ref), v10 (ref), v11 (ref), v12 (ref) ]]
	if p1.RootPart ~= v1.PrimaryPart then
		return false
	end

	if v14 == p1 then
		return true
	end

	resetManagerListeners()
	v13 = p1.GroundSensor
	v10 = p1:GetPropertyChangedSignal("GroundSensor"):Connect(function() --[[ Line: 137 | Upvalues: p1 (copy), v10 (ref) ]]
		if not processIfManagerBelongsToCharacter(p1) then
			return
		end

		v10:Disconnect()
		v10 = nil
	end)
	v11 = p1:GetPropertyChangedSignal("RootPart"):Connect(function() --[[ Line: 143 | Upvalues: p1 (copy), v11 (ref) ]]
		if not processIfManagerBelongsToCharacter(p1) then
			return
		end

		v11:Disconnect()
		v11 = nil
	end)
	v12 = p1.AncestryChanged:Connect(function(p1, p2) --[[ Line: 149 ]]
		if p2 ~= nil then
			return
		end

		resetManagerListeners()
		lookForControllerManager()
	end)
	v14 = p1

	return true
end
function lookForControllerManager() --[[ lookForControllerManager | Line: 165 | Upvalues: v13 (ref), v14 (ref), v1 (copy) ]]
	v13 = nil
	v14 = nil

	local ControllerManager = v1:FindFirstChildOfClass("ControllerManager")

	if ControllerManager then
		processIfManagerBelongsToCharacter(ControllerManager)
	end

	if v14 ~= nil then
		return
	end

	local v12 = nil

	v12 = v1.ChildAdded:Connect(function(p1) --[[ Line: 177 | Upvalues: v12 (ref) ]]
		if not (p1:IsA("ControllerManager") and processIfManagerBelongsToCharacter(p1)) then
			return
		end

		v12:Disconnect()
		v12 = nil
	end)
end
lookForControllerManager()
math.randomseed(tick())
function findExistingAnimationInSet(p1, p2) --[[ findExistingAnimationInSet | Line: 191 ]]
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
function configureAnimationSet(p1, p2) --[[ configureAnimationSet | Line: 205 | Upvalues: t2 (copy), t (copy), Humanoid (copy) ]]
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
	local ok, _ = pcall(function() --[[ Line: 218 | Upvalues: v1 (ref) ]]
		v1 = game:GetService("StarterPlayer").AllowCustomAnimations
	end)

	if not ok then
		v1 = true
	end

	local v2 = script:FindFirstChild(p1)

	if v1 and v2 ~= nil then
		table.insert(t2[p1].connections, v2.ChildAdded:connect(function(p12) --[[ Line: 226 | Upvalues: p1 (copy), p2 (copy) ]]
			configureAnimationSet(p1, p2)
		end))
		table.insert(t2[p1].connections, v2.ChildRemoved:connect(function(p12) --[[ Line: 227 | Upvalues: p1 (copy), p2 (copy) ]]
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
				table.insert(t2[p1].connections, v.Changed:connect(function(p12) --[[ Line: 243 | Upvalues: p1 (copy), p2 (copy) ]]
					configureAnimationSet(p1, p2)
				end))
				table.insert(t2[p1].connections, v.ChildAdded:connect(function(p12) --[[ Line: 244 | Upvalues: p1 (copy), p2 (copy) ]]
					configureAnimationSet(p1, p2)
				end))
				table.insert(t2[p1].connections, v.ChildRemoved:connect(function(p12) --[[ Line: 245 | Upvalues: p1 (copy), p2 (copy) ]]
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
function configureAnimationSetOld(p1, p2) --[[ configureAnimationSetOld | Line: 276 | Upvalues: t2 (copy), Humanoid (copy) ]]
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
	local ok, _ = pcall(function() --[[ Line: 289 | Upvalues: v1 (ref) ]]
		v1 = game:GetService("StarterPlayer").AllowCustomAnimations
	end)

	if not ok then
		v1 = true
	end

	local v2 = script:FindFirstChild(p1)

	if v1 and v2 ~= nil then
		table.insert(t2[p1].connections, v2.ChildAdded:connect(function(p12) --[[ Line: 297 | Upvalues: p1 (copy), p2 (copy) ]]
			configureAnimationSet(p1, p2)
		end))
		table.insert(t2[p1].connections, v2.ChildRemoved:connect(function(p12) --[[ Line: 298 | Upvalues: p1 (copy), p2 (copy) ]]
			configureAnimationSet(p1, p2)
		end))

		local count = 1

		for k, v in pairs(v2:GetChildren()) do
			if v:IsA("Animation") then
				table.insert(t2[p1].connections, v.Changed:connect(function(p12) --[[ Line: 302 | Upvalues: p1 (copy), p2 (copy) ]]
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
function scriptChildModified(p1) --[[ scriptChildModified | Line: 341 | Upvalues: tbl (copy) ]]
	local v1 = tbl[p1.Name]

	if v1 == nil then
		return
	end

	configureAnimationSet(p1.Name, v1)
end
script.ChildAdded:connect(scriptChildModified)
script.ChildRemoved:connect(scriptChildModified)

local v15 = if Humanoid then Humanoid:FindFirstChildOfClass("Animator") else nil

if v15 then
	for i, v in ipairs((v15:GetPlayingAnimationTracks())) do
		v:Stop(0)
		v:Destroy()
	end
end

for k, v in pairs(tbl) do
	configureAnimationSet(k, v)
end

local v17 = "None"
local v18 = 0
local v19 = 0
local v20 = false

function stopAllAnimations() --[[ stopAllAnimations | Line: 382 | Upvalues: v3 (ref), t3 (copy), v20 (ref), v4 (ref), v6 (ref), v5 (ref), v9 (ref), v8 (ref) ]]
	local v1 = v3

	if t3[v1] ~= nil and t3[v1] == false then
		v1 = "idle"
	end

	if v20 then
		v1 = "idle"
		v20 = false
	end

	v3 = ""
	v4 = nil

	if v6 ~= nil then
		v6:disconnect()
	end

	if v5 ~= nil then
		v5:Stop()
		v5:Destroy()
		v5 = nil
	end

	if v9 ~= nil then
		v9:disconnect()
	end

	if v8 == nil then
		return v1
	end

	v8:Stop()
	v8:Destroy()
	v8 = nil

	return v1
end
function getHeightScale() --[[ getHeightScale | Line: 421 | Upvalues: Humanoid (copy), getRigScale (copy), ScaleDampeningPercent (ref) ]]
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

local function rootMotionCompensation(p1) --[[ rootMotionCompensation | Line: 441 ]]
	return p1 * 1.25 / getHeightScale()
end

local function setRunSpeed(p1) --[[ setRunSpeed | Line: 449 | Upvalues: v5 (ref), v8 (ref) ]]
	local v1 = p1 * 1.25 / getHeightScale()
	local v2 = 0.0001
	local v3 = 1
	local v4

	if v1 <= 0.5 then
		v2 = 1
		v4 = 0.0001
		v3 = v1 / 0.5
	elseif v1 < 1 then
		local v52 = (v1 - 0.5) / 0.5

		v2 = 1 - v52
		v4 = v52
	else
		v4 = 1
		v3 = v1 / 1
	end

	v5:AdjustWeight(v2)
	v8:AdjustWeight(v4)
	v5:AdjustSpeed(v3)
	v8:AdjustSpeed(v3)
end

function setAnimationSpeed(p1) --[[ setAnimationSpeed | Line: 475 | Upvalues: v3 (ref), setRunSpeed (copy), v7 (ref), v5 (ref) ]]
	if v3 == "walk" then
		setRunSpeed(p1)

		return
	end

	if p1 == v7 then
		return
	end

	v7 = p1
	v5:AdjustSpeed(p1)
end
function keyFrameReachedFunc(p1) --[[ keyFrameReachedFunc | Line: 486 | Upvalues: v3 (ref), v8 (ref), v5 (ref), t3 (copy), v20 (ref), v7 (ref), Humanoid (copy) ]]
	if p1 ~= "End" then
		return
	end

	if v3 == "walk" then
		if v8.Looped ~= true then
			v8.TimePosition = 0
		end

		if v5.Looped ~= true then
			v5.TimePosition = 0
		end
	else
		local v1 = v3

		if t3[v1] ~= nil and t3[v1] == false then
			v1 = "idle"
		end

		if v20 then
			if v5.Looped then
				return
			end

			v1 = "idle"
			v20 = false
		end

		playAnimation(v1, 0.15, Humanoid)
		setAnimationSpeed(v7)
	end
end
function rollAnimation(p1) --[[ rollAnimation | Line: 519 | Upvalues: t2 (copy) ]]
	local sum = math.random(1, t2[p1].totalWeight)
	local count = 1

	while t2[p1][count].weight < sum do
		sum = sum - t2[p1][count].weight
		count = count + 1
	end

	return count
end

local function switchToAnim(p1, p2, p3, p4) --[[ switchToAnim | Line: 530 | Upvalues: v4 (ref), v5 (ref), v8 (ref), v7 (ref), v3 (ref), v6 (ref), t2 (copy), v9 (ref) ]]
	if p1 == v4 then
		return
	end

	if v5 ~= nil then
		v5:Stop(p3)
		v5:Destroy()
	end

	if v8 ~= nil then
		v8:Stop(p3)
		v8:Destroy()
		v8 = nil
	end

	v7 = 1
	v5 = p4:LoadAnimation(p1)
	v5.Priority = Enum.AnimationPriority.Core
	v5:Play(p3)
	v3 = p2
	v4 = p1

	if v6 ~= nil then
		v6:disconnect()
	end

	v6 = v5.KeyframeReached:connect(keyFrameReachedFunc)

	if p2 ~= "walk" then
		return
	end

	v8 = p4:LoadAnimation(t2.run[rollAnimation("run")].anim)
	v8.Priority = Enum.AnimationPriority.Core
	v8:Play(p3)

	if v9 ~= nil then
		v9:disconnect()
	end

	v9 = v8.KeyframeReached:connect(keyFrameReachedFunc)
end

function playAnimation(p1, p2, p3) --[[ playAnimation | Line: 579 | Upvalues: t2 (copy), switchToAnim (copy), v20 (ref) ]]
	switchToAnim(t2[p1][rollAnimation(p1)].anim, p1, p2, p3)
	v20 = false
end
function playEmote(p1, p2, p3) --[[ playEmote | Line: 587 | Upvalues: switchToAnim (copy), v20 (ref) ]]
	switchToAnim(p1, p1.Name, p2, p3)
	v20 = true
end

local v21 = ""
local v22 = nil
local v23 = nil
local v24 = nil

function toolKeyFrameReachedFunc(p1) --[[ toolKeyFrameReachedFunc | Line: 600 | Upvalues: v21 (ref), Humanoid (copy) ]]
	if p1 ~= "End" then
		return
	end

	playToolAnimation(v21, 0, Humanoid)
end
function playToolAnimation(p1, p2, p3, p4) --[[ playToolAnimation | Line: 607 | Upvalues: t2 (copy), v23 (ref), v22 (ref), v21 (ref), v24 (ref) ]]
	local anim = t2[p1][rollAnimation(p1)].anim

	if v23 == anim then
		return
	end

	if v22 ~= nil then
		v22:Stop()
		v22:Destroy()
		p2 = 0
	end

	v22 = p3:LoadAnimation(anim)

	if p4 then
		v22.Priority = p4
	end

	v22:Play(p2)
	v21 = p1
	v23 = anim
	v24 = v22.KeyframeReached:connect(toolKeyFrameReachedFunc)
end
function stopToolAnimations() --[[ stopToolAnimations | Line: 634 | Upvalues: v21 (ref), v24 (ref), v23 (ref), v22 (ref) ]]
	local v1 = v21

	if v24 ~= nil then
		v24:disconnect()
	end

	v21 = ""
	v23 = nil

	if v22 == nil then
		return v1
	end

	v22:Stop()
	v22:Destroy()
	v22 = nil

	return v1
end
function onRunning(p1) --[[ onRunning | Line: 656 | Upvalues: v13 (ref), Humanoid (copy), v14 (ref), v20 (ref), v2 (ref), t3 (copy), v3 (ref) ]]
	local v1 = getHeightScale()

	if v13 ~= nil and Humanoid.EvaluateStateMachine == false then
		local RootPart = Humanoid.RootPart
		local SensedPart = v13.SensedPart

		if SensedPart then
			local v22 = SensedPart:GetVelocityAtPosition(v13.HitFrame.Position)
			local AssemblyLinearVelocity = RootPart.AssemblyLinearVelocity
			local Magnitude = Vector3.new(AssemblyLinearVelocity.X - v22.X, 0, AssemblyLinearVelocity.Z - v22.Z).Magnitude
			local Magnitude2 = v14.MovingDirection.Magnitude

			if Magnitude2 < 0.1 then
				Magnitude = 0
				Magnitude2 = 0
			elseif Magnitude2 > 1 then
				Magnitude2 = 1
			end

			p1 = Magnitude * Magnitude2
		end
	end

	if (v20 and Humanoid.MoveDirection == Vector3.new(0, 0, 0) and Humanoid.WalkSpeed / v1 or 0.75) * v1 < p1 then
		playAnimation("walk", 0.2, Humanoid)
		setAnimationSpeed(p1 / 16)
		v2 = "Running"

		return
	end

	if t3[v3] ~= nil or v20 then
		return
	end

	playAnimation("idle", 0.2, Humanoid)
	v2 = "Standing"
end
function onDied() --[[ onDied | Line: 699 | Upvalues: v2 (ref) ]]
	v2 = "Dead"
end
function onJumping() --[[ onJumping | Line: 703 | Upvalues: Humanoid (copy), v19 (ref), v2 (ref) ]]
	playAnimation("jump", 0.1, Humanoid)
	v19 = 0.31
	v2 = "Jumping"
end
function onClimbing(p1) --[[ onClimbing | Line: 709 | Upvalues: Humanoid (copy), v2 (ref) ]]
	local v1 = p1 / getHeightScale()

	playAnimation("climb", 0.1, Humanoid)
	setAnimationSpeed(v1 / 5)
	v2 = "Climbing"
end
function onGettingUp() --[[ onGettingUp | Line: 717 | Upvalues: v2 (ref) ]]
	v2 = "GettingUp"
end
function onFreeFall() --[[ onFreeFall | Line: 721 | Upvalues: v19 (ref), Humanoid (copy), v2 (ref) ]]
	if v19 <= 0 then
		playAnimation("fall", 0.2, Humanoid)
	end

	v2 = "FreeFall"
end
function onFallingDown() --[[ onFallingDown | Line: 728 | Upvalues: v2 (ref) ]]
	v2 = "FallingDown"
end
function onSeated() --[[ onSeated | Line: 732 | Upvalues: v2 (ref) ]]
	v2 = "Seated"
end
function onPlatformStanding() --[[ onPlatformStanding | Line: 736 | Upvalues: v2 (ref) ]]
	v2 = "PlatformStanding"
end
function onSwimming(p1) --[[ onSwimming | Line: 743 | Upvalues: Humanoid (copy), v2 (ref) ]]
	local v1 = p1 / getHeightScale()

	if v1 > 1 then
		playAnimation("swim", 0.4, Humanoid)
		setAnimationSpeed(v1 / 10)
		v2 = "Swimming"
	else
		playAnimation("swimidle", 0.4, Humanoid)
		v2 = "Standing"
	end
end
function animateTool() --[[ animateTool | Line: 756 | Upvalues: v17 (ref), Humanoid (copy) ]]
	if v17 == "None" then
		playToolAnimation("toolnone", 0.1, Humanoid, Enum.AnimationPriority.Idle)

		return
	end

	if v17 == "Slash" then
		playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action)

		return
	end

	if v17 == "Lunge" then
		playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action)
	end
end
function getToolAnim(p1) --[[ getToolAnim | Line: 773 ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v.Name == "toolanim" and v.className == "StringValue" then
			return v
		end
	end

	return nil
end

local v25 = 0

function stepAnimate(p1) --[[ stepAnimate | Line: 784 | Upvalues: v25 (ref), v19 (ref), v2 (ref), Humanoid (copy), v1 (copy), v17 (ref), v18 (ref), v23 (ref) ]]
	local v12 = p1 - v25

	v25 = p1

	if v19 > 0 then
		v19 = v19 - v12
	end

	if v2 == "FreeFall" and v19 <= 0 then
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
		v17 = "None"
		v23 = nil
		v18 = 0

		return
	end

	local v22 = getToolAnim(Tool)

	if v22 then
		v17 = v22.Value
		v22.Parent = nil
		v18 = p1 + 0.3
	end

	if not (v18 < p1) then
		animateTool()

		return
	end

	v18 = 0
	v17 = "None"
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
game:GetService("Players").LocalPlayer.Chatted:connect(function(p1) --[[ Line: 850 | Upvalues: v2 (ref), t3 (copy), Humanoid (copy) ]]
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
script:WaitForChild("PlayEmote").OnInvoke = function(p1) --[[ Line: 864 | Upvalues: v2 (ref), t3 (copy), Humanoid (copy), v5 (ref) ]]
	if v2 ~= "Standing" then
		return
	end

	if t3[p1] ~= nil then
		playAnimation(p1, 0.1, Humanoid)

		return true, v5
	end

	if typeof(p1) == "Instance" and p1:IsA("Animation") then
		playEmote(p1, 0.1, Humanoid)

		return true, v5
	end

	return false
end

if v1.Parent ~= nil then
	playAnimation("idle", 0.1, Humanoid)
end

while v1.Parent ~= nil do
	local _, v26 = wait(0.1)

	stepAnimate(v26)
end