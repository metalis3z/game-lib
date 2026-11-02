-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = script.Parent
local v2 = v_u_1:WaitForChild("Torso")
local v_u_3 = v2:WaitForChild("Right Shoulder")
local v_u_4 = v2:WaitForChild("Left Shoulder")
local v_u_5 = v2:WaitForChild("Right Hip")
local v_u_6 = v2:WaitForChild("Left Hip")
v2:WaitForChild("Neck")
local v_u_7 = v_u_1:WaitForChild("Humanoid")
local v_u_8 = "Standing"
local v_u_9 = v_u_7.MaxHealth / 2
local v_u_10 = game:GetService("Workspace").CurrentCamera
local v_u_11 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("CameraShaker"))
local v_u_13 = v_u_11.new(Enum.RenderPriority.Camera.Value, function(p12)
	-- upvalues: (copy) v_u_10
	if v_u_10.CameraType ~= Enum.CameraType.Scriptable then
		v_u_10.CFrame = v_u_10.CFrame * p12
	end
end)
v_u_13:Start()
require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Warp")).Client("Shake"):Connect(function(p14)
	-- upvalues: (copy) v_u_13, (copy) v_u_11
	if game:GetService("Players").LocalPlayer:GetAttribute("CameraShake") == true then
		v_u_13:Shake(v_u_11.Presets[p14])
	end
end)
local v15, v16 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun")
end)
local v_u_17 = v15 and v16
local v_u_18 = ""
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = nil
local v_u_22 = 1
local v_u_23 = {}
local v_u_24 = {
	["idle"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=132093341627288",
			["weight"] = 9
		}
	},
	["stop"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=134554873774070",
			["weight"] = 11
		}
	},
	["stopWalk"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=124031004820072",
			["weight"] = 11
		}
	},
	["walkForward"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=74191355019462",
			["weight"] = 10
		}
	},
	["walkForwardRight"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=77598725257980",
			["weight"] = 10
		}
	},
	["walkForwardLeft"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=98877265098428",
			["weight"] = 10
		}
	},
	["walkBackward"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=73490234297432",
			["weight"] = 10
		}
	},
	["walkBackwardLeft"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=101371622150128",
			["weight"] = 10
		}
	},
	["walkBackwardRight"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=90916650190129",
			["weight"] = 10
		}
	},
	["walkRight"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=94073990140551",
			["weight"] = 10
		}
	},
	["walkLeft"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=73816962104391",
			["weight"] = 10
		}
	},
	["Crouchidle"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=87485433828062",
			["weight"] = 9
		}
	},
	["CrouchwalkForward"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=100193759687232",
			["weight"] = 10
		}
	},
	["CrouchwalkForwardRight"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=140227029457707",
			["weight"] = 10
		}
	},
	["CrouchwalkForwardLeft"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=139523607697140",
			["weight"] = 10
		}
	},
	["CrouchwalkBackward"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=70590137023565",
			["weight"] = 10
		}
	},
	["CrouchwalkBackwardLeft"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=94940938891574",
			["weight"] = 10
		}
	},
	["CrouchwalkBackwardRight"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=110186581042954",
			["weight"] = 10
		}
	},
	["CrouchwalkRight"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=92616971495579",
			["weight"] = 10
		}
	},
	["CrouchwalkLeft"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=101620230367321",
			["weight"] = 10
		}
	},
	["runForward"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=106384792044692",
			["weight"] = 10
		}
	},
	["runLeft"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=79503054699004",
			["weight"] = 10
		}
	},
	["runRight"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=116894915772923",
			["weight"] = 10
		}
	},
	["runStart"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=136809937947916",
			["weight"] = 11
		}
	},
	["runStartLeft"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=139382760193973",
			["weight"] = 11
		}
	},
	["runStartRight"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=138377008986809",
			["weight"] = 11
		}
	},
	["jump"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=125750702",
			["weight"] = 10
		}
	},
	["fall"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=83706345875190",
			["weight"] = 10
		}
	},
	["climb"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=180436334",
			["weight"] = 10
		}
	},
	["sit"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=178130996",
			["weight"] = 10
		}
	},
	["toolnone"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=182393478",
			["weight"] = 10
		}
	},
	["toolslash"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=129967390",
			["weight"] = 10
		}
	},
	["toollunge"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=129967478",
			["weight"] = 10
		}
	},
	["wave"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=128777973",
			["weight"] = 10
		}
	},
	["point"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=128853357",
			["weight"] = 10
		}
	},
	["dance1"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=182435998",
			["weight"] = 10
		},
		{
			["id"] = "http://www.roblox.com/asset/?id=182491037",
			["weight"] = 10
		},
		{
			["id"] = "http://www.roblox.com/asset/?id=182491065",
			["weight"] = 10
		}
	},
	["dance2"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=182436842",
			["weight"] = 10
		},
		{
			["id"] = "http://www.roblox.com/asset/?id=182491248",
			["weight"] = 10
		},
		{
			["id"] = "http://www.roblox.com/asset/?id=182491277",
			["weight"] = 10
		}
	},
	["dance3"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=182436935",
			["weight"] = 10
		},
		{
			["id"] = "http://www.roblox.com/asset/?id=182491368",
			["weight"] = 10
		},
		{
			["id"] = "http://www.roblox.com/asset/?id=182491423",
			["weight"] = 10
		}
	},
	["laugh"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=129423131",
			["weight"] = 10
		}
	},
	["cheer"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=129423030",
			["weight"] = 10
		}
	}
}
local v_u_25 = { "dance1", "dance2", "dance3" }
local v_u_26 = {
	["wave"] = false,
	["point"] = false,
	["dance1"] = true,
	["dance2"] = true,
	["dance3"] = true,
	["laugh"] = false,
	["cheer"] = false
}
function configureAnimationSet(p_u_27, p_u_28)
	-- upvalues: (copy) v_u_23
	if v_u_23[p_u_27] ~= nil then
		for _, v29 in pairs(v_u_23[p_u_27].connections) do
			v29:disconnect()
		end
	end
	v_u_23[p_u_27] = {}
	v_u_23[p_u_27].count = 0
	v_u_23[p_u_27].totalWeight = 0
	v_u_23[p_u_27].connections = {}
	local v30 = script:FindFirstChild(p_u_27)
	if v30 ~= nil then
		local v31 = v_u_23[p_u_27].connections
		local v32 = v30.ChildAdded
		table.insert(v31, v32:connect(function(_)
			-- upvalues: (copy) p_u_27, (copy) p_u_28
			configureAnimationSet(p_u_27, p_u_28)
		end))
		local v33 = v_u_23[p_u_27].connections
		local v34 = v30.ChildRemoved
		table.insert(v33, v34:connect(function(_)
			-- upvalues: (copy) p_u_27, (copy) p_u_28
			configureAnimationSet(p_u_27, p_u_28)
		end))
		local v35 = 1
		for _, v36 in pairs(v30:GetChildren()) do
			if v36:IsA("Animation") then
				local v37 = v_u_23[p_u_27].connections
				local v38 = v36.Changed
				table.insert(v37, v38:connect(function(_)
					-- upvalues: (copy) p_u_27, (copy) p_u_28
					configureAnimationSet(p_u_27, p_u_28)
					task.spawn(move, os.clock())
				end))
				v_u_23[p_u_27][v35] = {}
				v_u_23[p_u_27][v35].anim = v36
				local v39 = v36:FindFirstChild("Weight")
				if v39 == nil then
					v_u_23[p_u_27][v35].weight = 1
				else
					v_u_23[p_u_27][v35].weight = v39.Value
				end
				v_u_23[p_u_27].count = v_u_23[p_u_27].count + 1
				v_u_23[p_u_27].totalWeight = v_u_23[p_u_27].totalWeight + v_u_23[p_u_27][v35].weight
				v35 = v35 + 1
			end
		end
	end
	if v_u_23[p_u_27].count <= 0 then
		for v40, v41 in pairs(p_u_28) do
			v_u_23[p_u_27][v40] = {}
			v_u_23[p_u_27][v40].anim = Instance.new("Animation")
			v_u_23[p_u_27][v40].anim.Name = p_u_27
			v_u_23[p_u_27][v40].anim.AnimationId = v41.id
			v_u_23[p_u_27][v40].weight = v41.weight
			v_u_23[p_u_27].count = v_u_23[p_u_27].count + 1
			v_u_23[p_u_27].totalWeight = v_u_23[p_u_27].totalWeight + v41.weight
		end
	end
end
function scriptChildModified(p42)
	-- upvalues: (copy) v_u_24
	local v43 = v_u_24[p42.Name]
	if v43 ~= nil then
		configureAnimationSet(p42.Name, v43)
	end
end
script.ChildAdded:connect(scriptChildModified)
script.ChildRemoved:connect(scriptChildModified)
local v44
if v_u_7 then
	v44 = v_u_7:FindFirstChildOfClass("Animator")
else
	v44 = nil
end
if v44 then
	local v45 = v44:GetPlayingAnimationTracks()
	for _, v46 in ipairs(v45) do
		v46:Stop(0)
		v46:Destroy()
	end
end
for v47, v48 in pairs(v_u_24) do
	configureAnimationSet(v47, v48)
end
local v_u_49 = "None"
local v_u_50 = 0
local v_u_51 = 0
function stopAllAnimations()
	-- upvalues: (ref) v_u_18, (copy) v_u_26, (ref) v_u_19, (ref) v_u_21, (ref) v_u_20
	local v52 = v_u_18
	local v53 = v_u_26[v52] ~= nil and v_u_26[v52] == false and "idle" or v52
	v_u_18 = ""
	v_u_19 = nil
	if v_u_21 ~= nil then
		v_u_21:disconnect()
	end
	if v_u_20 ~= nil then
		v_u_20:Stop()
		v_u_20:Destroy()
		v_u_20 = nil
	end
	return v53
end
function setAnimationSpeed(p54)
	-- upvalues: (ref) v_u_22, (ref) v_u_20
	if p54 ~= v_u_22 and v_u_20 then
		v_u_22 = p54
		v_u_20:AdjustSpeed(v_u_22)
	end
end
function keyFrameReachedFunc(p55)
	-- upvalues: (ref) v_u_18, (copy) v_u_26, (ref) v_u_22, (copy) v_u_7
	if p55 == "End" then
		local v56 = v_u_18
		local v57 = v_u_26[v56] ~= nil and v_u_26[v56] == false and "idle" or v56
		local v58 = v_u_22
		playAnimation(v57, 0, v_u_7)
		setAnimationSpeed(v58)
	end
end
function playAnimation(p59, p60, p61)
	-- upvalues: (copy) v_u_23, (ref) v_u_19, (ref) v_u_20, (ref) v_u_22, (ref) v_u_18, (ref) v_u_21, (ref) v_u_8, (copy) v_u_13, (copy) v_u_11
	local v62 = math.random(1, v_u_23[p59].totalWeight)
	local v63 = 1
	while v_u_23[p59][v63].weight < v62 do
		v62 = v62 - v_u_23[p59][v63].weight
		v63 = v63 + 1
	end
	local v64 = v_u_23[p59][v63].anim
	if v64 ~= v_u_19 then
		if v_u_20 ~= nil then
			v_u_20:Stop(p60)
			v_u_20:Destroy()
		end
		v_u_22 = 1
		local v65 = (not (v_u_18:match("walk") or v_u_18:match("run")) or v_u_18 == "stop") and 0 or v_u_20.TimePosition
		v_u_20 = p61:LoadAnimation(v64)
		v_u_20.Priority = Enum.AnimationPriority.Core
		v_u_20:Play(p60)
		v_u_20.TimePosition = v65
		v_u_18 = p59
		v_u_19 = v64
		if v_u_21 ~= nil then
			v_u_21:disconnect()
		end
		local v_u_66 = v_u_20:GetMarkerReachedSignal("Step"):Connect(function()
			-- upvalues: (ref) v_u_8, (ref) v_u_13, (ref) v_u_11
			if (v_u_8 == "Running" or v_u_8 == "RunningStart") and game:GetService("Players").LocalPlayer:GetAttribute("CameraShake") == true then
				v_u_13:Shake(v_u_11.Presets.RunningShake)
			end
		end)
		v_u_20.Stopped:Once(function()
			-- upvalues: (ref) v_u_66
			v_u_66:Disconnect()
		end)
		v_u_21 = v_u_20.KeyframeReached:connect(keyFrameReachedFunc)
	end
end
local v_u_67 = ""
local v_u_68 = nil
local v_u_69 = nil
local v_u_70 = nil
function toolKeyFrameReachedFunc(p71)
	-- upvalues: (ref) v_u_67, (copy) v_u_7
	if p71 == "End" then
		playToolAnimation(v_u_67, 0, v_u_7)
	end
end
function playToolAnimation(p72, p73, p74, p75)
	-- upvalues: (copy) v_u_23, (ref) v_u_69, (ref) v_u_68, (ref) v_u_67, (ref) v_u_70
	local v76 = math.random(1, v_u_23[p72].totalWeight)
	local v77 = 1
	while v_u_23[p72][v77].weight < v76 do
		v76 = v76 - v_u_23[p72][v77].weight
		v77 = v77 + 1
	end
	local v78 = v_u_23[p72][v77].anim
	if v_u_69 ~= v78 then
		if v_u_68 ~= nil then
			v_u_68:Stop()
			v_u_68:Destroy()
			p73 = 0
		end
		v_u_68 = p74:LoadAnimation(v78)
		if p75 then
			v_u_68.Priority = p75
		end
		v_u_68:Play(p73)
		v_u_67 = p72
		v_u_69 = v78
		v_u_70 = v_u_68.KeyframeReached:connect(toolKeyFrameReachedFunc)
	end
end
function stopToolAnimations()
	-- upvalues: (ref) v_u_67, (ref) v_u_70, (ref) v_u_69, (ref) v_u_68
	local v79 = v_u_67
	if v_u_70 ~= nil then
		v_u_70:disconnect()
	end
	v_u_67 = ""
	v_u_69 = nil
	if v_u_68 ~= nil then
		v_u_68:Stop()
		v_u_68:Destroy()
		v_u_68 = nil
	end
	return v79
end
function onDied()
	-- upvalues: (ref) v_u_8
	v_u_8 = "Dead"
end
function onJumping()
	-- upvalues: (copy) v_u_7, (ref) v_u_51, (ref) v_u_8
	playAnimation("jump", 0.1, v_u_7)
	v_u_51 = 0.3
	v_u_8 = "Jumping"
end
function onClimbing(p80)
	-- upvalues: (copy) v_u_17, (copy) v_u_1, (copy) v_u_7, (ref) v_u_8
	local v81 = p80 / (not v_u_17 and 1 or v_u_1:GetScale())
	playAnimation("climb", 0.1, v_u_7)
	setAnimationSpeed(v81 / 12)
	v_u_8 = "Climbing"
end
function onGettingUp()
	-- upvalues: (ref) v_u_8
	v_u_8 = "GettingUp"
end
function onFreeFall()
	-- upvalues: (ref) v_u_51, (copy) v_u_7, (ref) v_u_8
	if v_u_51 <= 0 then
		playAnimation("fall", 0.3, v_u_7)
	end
	v_u_8 = "FreeFall"
end
function onFallingDown()
	-- upvalues: (ref) v_u_8
	v_u_8 = "FallingDown"
end
function onSeated()
	-- upvalues: (ref) v_u_8
	v_u_8 = "Seated"
end
function onPlatformStanding()
	-- upvalues: (ref) v_u_8
	v_u_8 = "PlatformStanding"
end
function onSwimming(p82)
	-- upvalues: (ref) v_u_8
	if p82 > 0 then
		v_u_8 = "Running"
	else
		v_u_8 = "Standing"
	end
end
function getTool()
	-- upvalues: (copy) v_u_1
	for _, v83 in ipairs(v_u_1:GetChildren()) do
		if v83.className == "Tool" then
			return v83
		end
	end
	return nil
end
function getToolAnim(p84)
	for _, v85 in ipairs(p84:GetChildren()) do
		if v85.Name == "toolanim" and v85.className == "StringValue" then
			return v85
		end
	end
	return nil
end
function animateTool()
	-- upvalues: (ref) v_u_49, (copy) v_u_7
	if v_u_49 == "None" then
		playToolAnimation("toolnone", 0.1, v_u_7, Enum.AnimationPriority.Idle)
		return
	elseif v_u_49 == "Slash" then
		playToolAnimation("toolslash", 0, v_u_7, Enum.AnimationPriority.Action)
		return
	elseif v_u_49 == "Lunge" then
		playToolAnimation("toollunge", 0, v_u_7, Enum.AnimationPriority.Action)
	end
end
function moveSit()
	-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_5, (copy) v_u_6
	v_u_3.MaxVelocity = 0.15
	v_u_4.MaxVelocity = 0.15
	v_u_3:SetDesiredAngle(1.57)
	v_u_4:SetDesiredAngle(-1.57)
	v_u_5:SetDesiredAngle(1.57)
	v_u_6:SetDesiredAngle(-1.57)
end
local v_u_86 = 0
local v_u_87 = false
local v_u_88 = v_u_7.Health
local v_u_89 = false
local v_u_90 = 0
local v_u_91 = v_u_7:LoadAnimation(script:WaitForChild("Axe_Hold_Idle"):WaitForChild("Animation"))
v_u_91.Priority = Enum.AnimationPriority.Action3
function move(p92)
	-- upvalues: (copy) v_u_1, (ref) v_u_8, (copy) v_u_7, (ref) v_u_86, (ref) v_u_51, (ref) v_u_89, (copy) v_u_91, (copy) v_u_13, (ref) v_u_90, (ref) v_u_20, (copy) v_u_26, (ref) v_u_18, (ref) v_u_87, (copy) v_u_3, (copy) v_u_4, (copy) v_u_5, (copy) v_u_6, (copy) v_u_9, (ref) v_u_88, (ref) v_u_49, (ref) v_u_50, (ref) v_u_69
	if v_u_1:HasTag("CantMove") or (v_u_1:GetAttribute("Stun") == true or (v_u_1:HasTag("StopAnim") or v_u_1:HasTag("KillAnims"))) then
		if v_u_8 ~= "Standing" then
			v_u_8 = "Standing"
			playAnimation("idle", 0.1, v_u_7)
		end
		if v_u_1:HasTag("KillAnims") then
			stopAllAnimations()
		end
		return
	else
		local v93 = 1
		local v94 = 1
		local v95 = p92 - v_u_86
		v_u_86 = p92
		local v96 = false
		if v_u_51 > 0 then
			v_u_51 = v_u_51 - v95
		end
		local v97 = (v_u_1:FindFirstChild("HumanoidRootPart").AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude
		if v_u_8 == "Standing" or v_u_8 == "Stopping" then
			if v_u_1:GetAttribute("Crouching") == true and v_u_89 == false then
				v_u_89 = true
				stopAllAnimations()
				v_u_91:Play(0)
				playAnimation("Crouchidle", 0.1, v_u_7)
			elseif v_u_1:GetAttribute("Crouching") == false and v_u_89 == true then
				v_u_89 = false
				v_u_91:Play(0)
				stopAllAnimations()
				playAnimation("idle", 0.1, v_u_7)
			end
		end
		if v_u_7.FloorMaterial ~= Enum.Material.Air and (v_u_8 ~= "Stopping" or v_u_1:FindFirstChild("HumanoidRootPart").CFrame.LookVector:Dot(v_u_7.MoveDirection) > 0.45) then
			if v97 > 0.01 and (v97 <= 13 and v_u_7.MoveDirection ~= Vector3.new(0, 0, 0)) then
				v_u_13:StopSustained(0.5)
				v_u_90 = 0
				v_u_8 = "Walking"
			elseif v97 > 13 and v_u_7.MoveDirection ~= Vector3.new(0, 0, 0) then
				local v98 = v_u_1:FindFirstChild("HumanoidRootPart").CFrame:VectorToObjectSpace(v_u_7.MoveDirection)
				if v_u_1:HasTag("Confusion") then
					v98 = v98 * -1
				end
				local v_u_99 = game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.Default and 1 or (v98:Dot((Vector3.new(1, 0, -1)).Unit) > 0.95 and 2 or (v98:Dot((Vector3.new(-1, 0, -1)).Unit) > 0.95 and 3 or 1))
				if v_u_1:HasTag("Battery") or v_u_8 == "Running" and (v_u_8 ~= "RunningStart" or v_u_90 == v_u_99) then
					if v_u_8 == "Running" then
						v_u_90 = 0
					end
				else
					stopAllAnimations()
					if v_u_99 == 2 then
						v_u_90 = 2
						playAnimation("runStartRight", 0, v_u_7)
						v_u_8 = "RunningStart"
					elseif v_u_99 == 3 then
						v_u_90 = 3
						playAnimation("runStartLeft", 0, v_u_7)
						v_u_8 = "RunningStart"
					elseif v_u_99 == 1 then
						v_u_90 = 1
						playAnimation("runStart", 0, v_u_7)
						v_u_8 = "RunningStart"
					else
						v_u_8 = "RunningStart"
					end
					if v_u_20 and v_u_8 == "RunningStart" then
						v_u_20.Priority = Enum.AnimationPriority.Action
						v_u_20.Stopped:Once(function()
							-- upvalues: (ref) v_u_8, (ref) v_u_90, (ref) v_u_99, (ref) v_u_20
							if v_u_8 == "RunningStart" and v_u_90 == v_u_99 then
								if v_u_20 then
									v_u_20.TimePosition = 0
								end
								v_u_8 = "Running"
								v_u_90 = 0
							end
						end)
					end
				end
			else
				v_u_90 = 0
				if v_u_26[v_u_18] == nil and (v_u_8 ~= "Standing" or v97 > 12) and v_u_8 ~= "Stopping" then
					if (v_u_8 == "Standing" and v97 > 12 or (v_u_8 == "Running" or v_u_8 == "RunningStart") and v97 > 21) and v_u_7.MoveDirection == Vector3.new(0, 0, 0) then
						v_u_8 = "Stopping"
						stopAllAnimations()
						v_u_91:Play(0)
						playAnimation("stop", 0, v_u_7)
						if v_u_20 then
							v_u_20.Priority = Enum.AnimationPriority.Action
							v_u_20.Stopped:Once(function()
								-- upvalues: (ref) v_u_8, (ref) v_u_87, (ref) v_u_1, (ref) v_u_91, (ref) v_u_7
								v_u_8 = "Standing"
								v_u_87 = false
								if v_u_8 == "Standing" then
									if v_u_1:GetAttribute("Crouching") == true then
										v_u_91:Play(0)
										playAnimation("Crouchidle", 0.1, v_u_7)
										return
									end
									v_u_91:Stop(0.5)
									playAnimation("idle", 0.1, v_u_7)
								end
							end)
						else
							v_u_8 = "Standing"
							if v_u_1:GetAttribute("Crouching") == true then
								v_u_91:Play(0)
								playAnimation("Crouchidle", 0.1, v_u_7)
							else
								v_u_91:Stop(0.5)
								playAnimation("idle", 0.1, v_u_7)
							end
						end
					elseif v_u_8 == "Walking" and (v_u_1:GetAttribute("Crouching") == false and (v97 > 2 and v_u_7.MoveDirection == Vector3.new(0, 0, 0))) then
						v_u_8 = "WalkStopping"
						v_u_91:Play(0)
						stopAllAnimations()
						playAnimation("stopWalk", 0.1, v_u_7)
						if v_u_20 then
							v_u_20.Priority = Enum.AnimationPriority.Action2
							v_u_20.Stopped:Once(function()
								-- upvalues: (ref) v_u_8, (ref) v_u_87, (ref) v_u_1, (ref) v_u_7
								v_u_8 = "Standing"
								v_u_87 = false
								if v_u_8 == "Standing" then
									if v_u_1:GetAttribute("Crouching") == true then
										playAnimation("Crouchidle", 0.1, v_u_7)
										return
									end
									playAnimation("idle", 0.1, v_u_7)
								end
							end)
						else
							v_u_8 = "Standing"
							if v_u_1:GetAttribute("Crouching") == true then
								playAnimation("Crouchidle", 0.1, v_u_7)
							else
								playAnimation("idle", 0.1, v_u_7)
							end
						end
					else
						if v_u_1:GetAttribute("Crouching") == true then
							v_u_91:Play(0)
							playAnimation("Crouchidle", 0.1, v_u_7)
						else
							v_u_91:Stop(0.5)
							playAnimation("idle", 0.1, v_u_7)
						end
						v_u_8 = "Standing"
					end
				end
			end
		end
		if v_u_8 == "FreeFall" and v_u_51 <= 0 then
			v_u_91:Play(0)
			playAnimation("fall", 0.3, v_u_7)
		else
			if v_u_8 == "Seated" then
				v_u_91:Play(0)
				playAnimation("sit", 0.5, v_u_7)
				return
			end
			if v_u_8 == "Walking" or v_u_8 == "WalkStopping" and v_u_7.MoveDirection ~= Vector3.new(0, 0, 0) then
				local v100 = v_u_1:FindFirstChild("HumanoidRootPart").CFrame:VectorToObjectSpace(v_u_7.MoveDirection)
				if v_u_1:HasTag("Confusion") then
					v100 = v100 * -1
				end
				v_u_91:Play(0)
				if v_u_1:GetAttribute("Crouching") == true then
					if game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.Default then
						playAnimation("CrouchwalkForward", 0.3, v_u_7)
					elseif v100:Dot((Vector3.new(1, 0, -1)).Unit) > 0.95 then
						playAnimation("CrouchwalkForwardRight", 0.3, v_u_7)
					elseif v100:Dot((Vector3.new(1, 0, 1)).Unit) > 0.95 then
						playAnimation("CrouchwalkBackwardRight", 0.3, v_u_7)
					elseif v100:Dot((Vector3.new(-1, 0, 1)).Unit) > 0.95 then
						playAnimation("CrouchwalkBackwardLeft", 0.3, v_u_7)
					elseif v100:Dot((Vector3.new(-1, 0, -1)).Unit) > 0.95 then
						playAnimation("CrouchwalkForwardLeft", 0.3, v_u_7)
					elseif v100:Dot((Vector3.new(0, 0, -1)).Unit) > 0.95 then
						playAnimation("CrouchwalkForward", 0.3, v_u_7)
					elseif v100:Dot((Vector3.new(1, 0, 0)).Unit) > 0.95 then
						playAnimation("CrouchwalkRight", 0.3, v_u_7)
					elseif v100:Dot((Vector3.new(0, 0, 1)).Unit) > 0.95 then
						playAnimation("CrouchwalkBackward", 0.3, v_u_7)
					elseif v100:Dot((Vector3.new(-1, 0, 0)).Unit) > 0.95 then
						playAnimation("CrouchwalkLeft", 0.3, v_u_7)
					end
					if v_u_20 then
						v_u_20.Priority = Enum.AnimationPriority.Movement
					end
					setAnimationSpeed(v97 / 6)
				else
					if game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.Default then
						playAnimation("walkForward", 0.3, v_u_7)
					elseif v100:Dot((Vector3.new(1, 0, -1)).Unit) > 0.95 then
						playAnimation("walkForwardRight", 0.3, v_u_7)
					elseif v100:Dot((Vector3.new(1, 0, 1)).Unit) > 0.95 then
						playAnimation("walkBackwardRight", 0.3, v_u_7)
					elseif v100:Dot((Vector3.new(-1, 0, 1)).Unit) > 0.95 then
						playAnimation("walkBackwardLeft", 0.3, v_u_7)
					elseif v100:Dot((Vector3.new(-1, 0, -1)).Unit) > 0.95 then
						playAnimation("walkForwardLeft", 0.3, v_u_7)
					elseif v100:Dot((Vector3.new(0, 0, -1)).Unit) > 0.95 then
						playAnimation("walkForward", 0.3, v_u_7)
					elseif v100:Dot((Vector3.new(1, 0, 0)).Unit) > 0.95 then
						playAnimation("walkRight", 0.3, v_u_7)
					elseif v100:Dot((Vector3.new(0, 0, 1)).Unit) > 0.95 then
						playAnimation("walkBackward", 0.3, v_u_7)
					elseif v100:Dot((Vector3.new(-1, 0, 0)).Unit) > 0.95 then
						playAnimation("walkLeft", 0.3, v_u_7)
					end
					if v_u_20 then
						v_u_20.Priority = Enum.AnimationPriority.Movement
					end
					setAnimationSpeed(v97 / 12)
				end
			elseif v_u_8 == "Running" then
				local v101 = v_u_1:FindFirstChild("HumanoidRootPart").CFrame:VectorToObjectSpace(v_u_7.MoveDirection)
				v_u_91:Play(0)
				if game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.Default then
					playAnimation("runForward", 0.25, v_u_7)
				elseif v101:Dot((Vector3.new(1, 0, -1)).Unit) > 0.9 then
					playAnimation("runRight", 0.25, v_u_7)
				elseif v101:Dot((Vector3.new(-1, 0, -1)).Unit) > 0.9 then
					playAnimation("runLeft", 0.25, v_u_7)
				else
					playAnimation("runForward", 0.25, v_u_7)
				end
				if v_u_20 then
					v_u_20.Priority = Enum.AnimationPriority.Movement
				end
				setAnimationSpeed(v97 / 24)
			elseif v_u_8 == "Dead" or (v_u_8 == "GettingUp" or (v_u_8 == "FallingDown" or (v_u_8 == "Seated" or v_u_8 == "PlatformStanding"))) then
				v_u_91:Stop(0.5)
				stopAllAnimations()
				v96 = true
				v94 = 1
				v93 = 0.1
			end
		end
		if v_u_1:HasTag("NoHold") then
			v_u_91:Stop(0.5)
		end
		if v96 then
			local v102 = p92 * v94
			local v103 = v93 * math.sin(v102)
			v_u_3:SetDesiredAngle(v103 + 0)
			v_u_4:SetDesiredAngle(v103 - 0)
			v_u_5:SetDesiredAngle(-v103)
			v_u_6:SetDesiredAngle(-v103)
		end
		if v_u_7.Health <= v_u_9 then
			if v_u_87 == false then
				v_u_87 = true
				if game:GetService("Players").LocalPlayer:GetAttribute("CameraShake") == true then
					v_u_13:ShakeSustain(v_u_13.Presets.Injured)
				end
			end
		elseif v_u_87 == true then
			v_u_87 = false
			v_u_13:StopSustained(1)
		end
		v_u_88 = v_u_7.Health
		local v104 = getTool()
		if v104 and v104:FindFirstChild("Handle") then
			local v105 = getToolAnim(v104)
			if v105 then
				v_u_49 = v105.Value
				v105.Parent = nil
				v_u_50 = p92 + 0.3
			end
			if v_u_50 < p92 then
				v_u_50 = 0
				v_u_49 = "None"
			end
			animateTool()
		else
			stopToolAnimations()
			v_u_49 = "None"
			v_u_69 = nil
			v_u_50 = 0
		end
	end
end
v_u_7.Died:connect(onDied)
v_u_7.Jumping:connect(onJumping)
v_u_7.Climbing:connect(onClimbing)
v_u_7.GettingUp:connect(onGettingUp)
v_u_7.FreeFalling:connect(onFreeFall)
v_u_7.FallingDown:connect(onFallingDown)
v_u_7.Seated:connect(onSeated)
v_u_7.PlatformStanding:connect(onPlatformStanding)
v_u_7.Swimming:connect(onSwimming)
game:GetService("Players").LocalPlayer.Chatted:connect(function(p106)
	-- upvalues: (copy) v_u_25, (ref) v_u_8, (copy) v_u_26, (copy) v_u_7
	local v107 = ""
	if p106 == "/e dance" then
		v107 = v_u_25[math.random(1, #v_u_25)]
	elseif string.sub(p106, 1, 3) == "/e " then
		v107 = string.sub(p106, 4)
	elseif string.sub(p106, 1, 7) == "/emote " then
		v107 = string.sub(p106, 8)
	end
	if v_u_8 == "Standing" and v_u_26[v107] ~= nil then
		playAnimation(v107, 0.1, v_u_7)
	end
end)
script:WaitForChild("PlayEmote").OnInvoke = function(p108)
	-- upvalues: (ref) v_u_8, (copy) v_u_26, (copy) v_u_7, (ref) v_u_20
	if v_u_8 == "Standing" then
		if v_u_26[p108] == nil then
			return false
		end
		playAnimation(p108, 0.1, v_u_7)
		return true, v_u_20
	end
end
playAnimation("idle", 0.1, v_u_7)
local _ = "Standing"
while v_u_1.Parent ~= nil do
	local _, v109 = wait()
	move(v109)
end