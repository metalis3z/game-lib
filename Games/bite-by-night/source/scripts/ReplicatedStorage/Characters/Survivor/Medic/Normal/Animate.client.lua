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
			["id"] = "http://www.roblox.com/asset/?id=88118053657768",
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
	["jump"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=138584038708942",
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
			["id"] = "http://www.roblox.com/asset/?id=138584038708942",
			["weight"] = 10
		}
	},
	["sit"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=138584038708942",
			["weight"] = 10
		}
	},
	["toolnone"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=138584038708942",
			["weight"] = 10
		}
	},
	["toolslash"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=138584038708942",
			["weight"] = 10
		}
	},
	["toollunge"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=138584038708942",
			["weight"] = 10
		}
	}
}
local v_u_25 = {
	["wave"] = false,
	["point"] = false,
	["dance1"] = true,
	["dance2"] = true,
	["dance3"] = true,
	["laugh"] = false,
	["cheer"] = false
}
function configureAnimationSet(p_u_26, p_u_27)
	-- upvalues: (copy) v_u_23
	if v_u_23[p_u_26] ~= nil then
		for _, v28 in pairs(v_u_23[p_u_26].connections) do
			v28:disconnect()
		end
	end
	v_u_23[p_u_26] = {}
	v_u_23[p_u_26].count = 0
	v_u_23[p_u_26].totalWeight = 0
	v_u_23[p_u_26].connections = {}
	local v29 = script:FindFirstChild(p_u_26)
	if v29 ~= nil then
		local v30 = v_u_23[p_u_26].connections
		local v31 = v29.ChildAdded
		table.insert(v30, v31:connect(function(_)
			-- upvalues: (copy) p_u_26, (copy) p_u_27
			configureAnimationSet(p_u_26, p_u_27)
		end))
		local v32 = v_u_23[p_u_26].connections
		local v33 = v29.ChildRemoved
		table.insert(v32, v33:connect(function(_)
			-- upvalues: (copy) p_u_26, (copy) p_u_27
			configureAnimationSet(p_u_26, p_u_27)
		end))
		local v34 = 1
		for _, v35 in pairs(v29:GetChildren()) do
			if v35:IsA("Animation") then
				local v36 = v_u_23[p_u_26].connections
				local v37 = v35.Changed
				table.insert(v36, v37:connect(function(_)
					-- upvalues: (copy) p_u_26, (copy) p_u_27
					configureAnimationSet(p_u_26, p_u_27)
					task.spawn(move, os.clock())
				end))
				v_u_23[p_u_26][v34] = {}
				v_u_23[p_u_26][v34].anim = v35
				local v38 = v35:FindFirstChild("Weight")
				if v38 == nil then
					v_u_23[p_u_26][v34].weight = 1
				else
					v_u_23[p_u_26][v34].weight = v38.Value
				end
				v_u_23[p_u_26].count = v_u_23[p_u_26].count + 1
				v_u_23[p_u_26].totalWeight = v_u_23[p_u_26].totalWeight + v_u_23[p_u_26][v34].weight
				v34 = v34 + 1
			end
		end
	end
	if v_u_23[p_u_26].count <= 0 then
		for v39, v40 in pairs(p_u_27) do
			v_u_23[p_u_26][v39] = {}
			v_u_23[p_u_26][v39].anim = Instance.new("Animation")
			v_u_23[p_u_26][v39].anim.Name = p_u_26
			v_u_23[p_u_26][v39].anim.AnimationId = v40.id
			v_u_23[p_u_26][v39].weight = v40.weight
			v_u_23[p_u_26].count = v_u_23[p_u_26].count + 1
			v_u_23[p_u_26].totalWeight = v_u_23[p_u_26].totalWeight + v40.weight
		end
	end
end
function scriptChildModified(p41)
	-- upvalues: (copy) v_u_24
	local v42 = v_u_24[p41.Name]
	if v42 ~= nil then
		configureAnimationSet(p41.Name, v42)
	end
end
script.ChildAdded:connect(scriptChildModified)
script.ChildRemoved:connect(scriptChildModified)
local v43
if v_u_7 then
	v43 = v_u_7:FindFirstChildOfClass("Animator")
else
	v43 = nil
end
if v43 then
	local v44 = v43:GetPlayingAnimationTracks()
	for _, v45 in ipairs(v44) do
		v45:Stop(0)
		v45:Destroy()
	end
end
for v46, v47 in pairs(v_u_24) do
	configureAnimationSet(v46, v47)
end
local v_u_48 = "None"
local v_u_49 = 0
local v_u_50 = 0
function stopAllAnimations()
	-- upvalues: (ref) v_u_18, (copy) v_u_25, (ref) v_u_19, (ref) v_u_21, (ref) v_u_20
	local v51 = v_u_18
	local v52 = v_u_25[v51] ~= nil and v_u_25[v51] == false and "idle" or v51
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
	return v52
end
function setAnimationSpeed(p53)
	-- upvalues: (ref) v_u_22, (ref) v_u_20
	if p53 ~= v_u_22 and v_u_20 then
		v_u_22 = p53
		v_u_20:AdjustSpeed(v_u_22)
	end
end
function keyFrameReachedFunc(p54)
	-- upvalues: (ref) v_u_18, (copy) v_u_25, (ref) v_u_22, (copy) v_u_7
	if p54 == "End" then
		local v55 = v_u_18
		local v56 = v_u_25[v55] ~= nil and v_u_25[v55] == false and "idle" or v55
		local v57 = v_u_22
		playAnimation(v56, 0, v_u_7)
		setAnimationSpeed(v57)
	end
end
function playAnimation(p58, p59, p60)
	-- upvalues: (copy) v_u_23, (ref) v_u_19, (ref) v_u_20, (ref) v_u_18, (ref) v_u_22, (ref) v_u_21, (ref) v_u_8, (copy) v_u_13, (copy) v_u_11
	local v61 = math.random(1, v_u_23[p58].totalWeight)
	local v62 = 1
	while v_u_23[p58][v62].weight < v61 do
		v61 = v61 - v_u_23[p58][v62].weight
		v62 = v62 + 1
	end
	local v63 = v_u_23[p58][v62].anim
	if v63 ~= v_u_19 then
		if v_u_20 ~= nil then
			v_u_20:Stop(p59)
			v_u_20:Destroy()
		end
		local v64 = (not (v_u_18:match("walk") or v_u_18:match("run")) or v_u_18 == "stop") and 0 or v_u_20.TimePosition
		v_u_22 = 1
		v_u_20 = p60:LoadAnimation(v63)
		v_u_20.Priority = Enum.AnimationPriority.Core
		v_u_20:Play(p59)
		v_u_20.TimePosition = v64
		v_u_18 = p58
		v_u_19 = v63
		if v_u_21 ~= nil then
			v_u_21:disconnect()
		end
		local v_u_65 = v_u_20:GetMarkerReachedSignal("Step"):Connect(function()
			-- upvalues: (ref) v_u_8, (ref) v_u_13, (ref) v_u_11
			if (v_u_8 == "Running" or v_u_8 == "RunningStart") and game:GetService("Players").LocalPlayer:GetAttribute("CameraShake") == true then
				v_u_13:Shake(v_u_11.Presets.RunningShake)
			end
		end)
		v_u_20.Stopped:Once(function()
			-- upvalues: (ref) v_u_65
			v_u_65:Disconnect()
		end)
		v_u_21 = v_u_20.KeyframeReached:connect(keyFrameReachedFunc)
	end
end
local v_u_66 = ""
local v_u_67 = nil
local v_u_68 = nil
local v_u_69 = nil
function toolKeyFrameReachedFunc(p70)
	-- upvalues: (ref) v_u_66, (copy) v_u_7
	if p70 == "End" then
		playToolAnimation(v_u_66, 0, v_u_7)
	end
end
function playToolAnimation(p71, p72, p73, p74)
	-- upvalues: (copy) v_u_23, (ref) v_u_68, (ref) v_u_67, (ref) v_u_66, (ref) v_u_69
	local v75 = math.random(1, v_u_23[p71].totalWeight)
	local v76 = 1
	while v_u_23[p71][v76].weight < v75 do
		v75 = v75 - v_u_23[p71][v76].weight
		v76 = v76 + 1
	end
	local v77 = v_u_23[p71][v76].anim
	if v_u_68 ~= v77 then
		if v_u_67 ~= nil then
			v_u_67:Stop()
			v_u_67:Destroy()
			p72 = 0
		end
		v_u_67 = p73:LoadAnimation(v77)
		if p74 then
			v_u_67.Priority = p74
		end
		v_u_67:Play(p72)
		v_u_66 = p71
		v_u_68 = v77
		v_u_69 = v_u_67.KeyframeReached:connect(toolKeyFrameReachedFunc)
	end
end
function stopToolAnimations()
	-- upvalues: (ref) v_u_66, (ref) v_u_69, (ref) v_u_68, (ref) v_u_67
	local v78 = v_u_66
	if v_u_69 ~= nil then
		v_u_69:disconnect()
	end
	v_u_66 = ""
	v_u_68 = nil
	if v_u_67 ~= nil then
		v_u_67:Stop()
		v_u_67:Destroy()
		v_u_67 = nil
	end
	return v78
end
function onDied()
	-- upvalues: (ref) v_u_8
	v_u_8 = "Dead"
end
function onJumping()
	-- upvalues: (copy) v_u_7, (ref) v_u_50, (ref) v_u_8
	playAnimation("jump", 0.1, v_u_7)
	v_u_50 = 0.3
	v_u_8 = "Jumping"
end
function onClimbing(p79)
	-- upvalues: (copy) v_u_17, (copy) v_u_1, (copy) v_u_7, (ref) v_u_8
	local v80 = p79 / (not v_u_17 and 1 or v_u_1:GetScale())
	playAnimation("climb", 0.1, v_u_7)
	setAnimationSpeed(v80 / 12)
	v_u_8 = "Climbing"
end
function onGettingUp()
	-- upvalues: (ref) v_u_8
	v_u_8 = "GettingUp"
end
function onFreeFall()
	-- upvalues: (ref) v_u_50, (copy) v_u_7, (ref) v_u_8
	if v_u_50 <= 0 then
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
function onSwimming(p81)
	-- upvalues: (ref) v_u_8
	if p81 > 0 then
		v_u_8 = "Running"
	else
		v_u_8 = "Standing"
	end
end
function getTool()
	-- upvalues: (copy) v_u_1
	for _, v82 in ipairs(v_u_1:GetChildren()) do
		if v82.className == "Tool" then
			return v82
		end
	end
	return nil
end
function getToolAnim(p83)
	for _, v84 in ipairs(p83:GetChildren()) do
		if v84.Name == "toolanim" and v84.className == "StringValue" then
			return v84
		end
	end
	return nil
end
function animateTool()
	-- upvalues: (ref) v_u_48, (copy) v_u_7
	if v_u_48 == "None" then
		playToolAnimation("toolnone", 0.1, v_u_7, Enum.AnimationPriority.Idle)
		return
	elseif v_u_48 == "Slash" then
		playToolAnimation("toolslash", 0, v_u_7, Enum.AnimationPriority.Action)
		return
	elseif v_u_48 == "Lunge" then
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
local v_u_85 = 0
local v_u_86 = v_u_7.Health
local v_u_87 = false
local v_u_88 = false
local v_u_89 = 0
function move(p90)
	-- upvalues: (copy) v_u_1, (ref) v_u_8, (copy) v_u_7, (ref) v_u_85, (ref) v_u_50, (ref) v_u_87, (ref) v_u_89, (copy) v_u_13, (ref) v_u_20, (copy) v_u_25, (ref) v_u_18, (ref) v_u_88, (copy) v_u_3, (copy) v_u_4, (copy) v_u_5, (copy) v_u_6, (copy) v_u_9, (ref) v_u_86, (ref) v_u_48, (ref) v_u_49, (ref) v_u_68
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
		local v91 = 1
		local v92 = 1
		local v93 = p90 - v_u_85
		v_u_85 = p90
		local v94 = false
		if v_u_50 > 0 then
			v_u_50 = v_u_50 - v93
		end
		local v95 = (v_u_1:FindFirstChild("HumanoidRootPart").AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude
		if v_u_8 == "Standing" or v_u_8 == "Stopping" then
			if v_u_1:GetAttribute("Crouching") == true and v_u_87 == false then
				v_u_87 = true
				stopAllAnimations()
				playAnimation("Crouchidle", 0.1, v_u_7)
			elseif v_u_1:GetAttribute("Crouching") == false and v_u_87 == true then
				v_u_87 = false
				stopAllAnimations()
				playAnimation("idle", 0.1, v_u_7)
			end
		end
		if v_u_7.FloorMaterial ~= Enum.Material.Air and (v_u_8 ~= "Stopping" or v_u_1:FindFirstChild("HumanoidRootPart").CFrame.LookVector:Dot(v_u_7.MoveDirection) > 0.45) then
			if v95 > 0.01 and (v95 <= 15 and v_u_7.MoveDirection ~= Vector3.new(0, 0, 0)) then
				v_u_89 = 0
				v_u_13:StopSustained(0.5)
				v_u_8 = "Walking"
			elseif v95 > 15 and v_u_7.MoveDirection ~= Vector3.new(0, 0, 0) then
				local v96 = v_u_1:FindFirstChild("HumanoidRootPart").CFrame:VectorToObjectSpace(v_u_7.MoveDirection)
				if v_u_1:HasTag("Confusion") then
					v96 = v96 * -1
				end
				local v_u_97 = game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.Default and 1 or (v96:Dot((Vector3.new(1, 0, -1)).Unit) > 0.95 and 2 or (v96:Dot((Vector3.new(-1, 0, -1)).Unit) > 0.95 and 3 or 1))
				if v_u_1:HasTag("Battery") or v_u_8 == "Running" and (v_u_8 ~= "RunningStart" or v_u_89 == v_u_97) then
					if v_u_8 == "Running" then
						v_u_89 = 0
					end
				else
					stopAllAnimations()
					if v_u_97 == 2 then
						v_u_89 = 2
						playAnimation("runStartRight", 0, v_u_7)
						v_u_8 = "RunningStart"
					elseif v_u_97 == 3 then
						v_u_89 = 3
						playAnimation("runStartLeft", 0, v_u_7)
						v_u_8 = "RunningStart"
					elseif v_u_97 == 1 then
						v_u_89 = 1
						playAnimation("runStart", 0, v_u_7)
						v_u_8 = "RunningStart"
					else
						v_u_8 = "RunningStart"
					end
					if v_u_20 and v_u_8 == "RunningStart" then
						v_u_20.Priority = Enum.AnimationPriority.Action
						v_u_20.Stopped:Once(function()
							-- upvalues: (ref) v_u_8, (ref) v_u_89, (ref) v_u_97, (ref) v_u_20
							if v_u_8 == "RunningStart" and v_u_89 == v_u_97 then
								if v_u_20 then
									v_u_20.TimePosition = 0
								end
								v_u_8 = "Running"
								v_u_89 = 0
							end
						end)
					end
				end
			else
				v_u_89 = 0
				if v_u_25[v_u_18] == nil and (v_u_8 ~= "Standing" or v95 > 12) and (v_u_8 ~= "Stopping" and v_u_8 ~= "WalkStopping") then
					if (v_u_8 == "Standing" and v95 > 12 or (v_u_8 == "Running" or v_u_8 == "RunningStart") and v95 > 21) and v_u_7.MoveDirection == Vector3.new(0, 0, 0) then
						v_u_8 = "Stopping"
						stopAllAnimations()
						playAnimation("stop", 0, v_u_7)
						if v_u_20 then
							v_u_20.Priority = Enum.AnimationPriority.Action2
							v_u_20.Stopped:Once(function()
								-- upvalues: (ref) v_u_8, (ref) v_u_88, (ref) v_u_1, (ref) v_u_7
								v_u_8 = "Standing"
								v_u_88 = false
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
					elseif v_u_8 == "Walking" and (v_u_1:GetAttribute("Crouching") == false and (v95 > 2 and v_u_7.MoveDirection == Vector3.new(0, 0, 0))) then
						v_u_8 = "WalkStopping"
						stopAllAnimations()
						playAnimation("stopWalk", 0.1, v_u_7)
						if v_u_20 then
							v_u_20.Priority = Enum.AnimationPriority.Action2
							v_u_20.Stopped:Once(function()
								-- upvalues: (ref) v_u_8, (ref) v_u_88, (ref) v_u_1, (ref) v_u_7
								v_u_8 = "Standing"
								v_u_88 = false
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
							playAnimation("Crouchidle", 0.1, v_u_7)
						else
							playAnimation("idle", 0.1, v_u_7)
						end
						v_u_8 = "Standing"
					end
				end
			end
		end
		if v_u_8 == "FreeFall" and v_u_50 <= 0 then
			playAnimation("fall", 0.3, v_u_7)
		else
			if v_u_8 == "Seated" then
				playAnimation("sit", 0.5, v_u_7)
				return
			end
			if v_u_8 == "Walking" or v_u_8 == "WalkStopping" and v_u_7.MoveDirection ~= Vector3.new(0, 0, 0) then
				local v98 = v_u_1:FindFirstChild("HumanoidRootPart").CFrame:VectorToObjectSpace(v_u_7.MoveDirection)
				if v_u_1:HasTag("Confusion") then
					v98 = v98 * -1
				end
				if v_u_1:GetAttribute("Crouching") == true then
					if game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.Default then
						playAnimation("CrouchwalkForward", 0.3, v_u_7)
					elseif v98:Dot((Vector3.new(1, 0, -1)).Unit) > 0.95 then
						playAnimation("CrouchwalkForwardRight", 0.3, v_u_7)
					elseif v98:Dot((Vector3.new(1, 0, 1)).Unit) > 0.95 then
						playAnimation("CrouchwalkBackwardRight", 0.3, v_u_7)
					elseif v98:Dot((Vector3.new(-1, 0, 1)).Unit) > 0.95 then
						playAnimation("CrouchwalkBackwardLeft", 0.3, v_u_7)
					elseif v98:Dot((Vector3.new(-1, 0, -1)).Unit) > 0.95 then
						playAnimation("CrouchwalkForwardLeft", 0.3, v_u_7)
					elseif v98:Dot((Vector3.new(0, 0, -1)).Unit) > 0.95 then
						playAnimation("CrouchwalkForward", 0.3, v_u_7)
					elseif v98:Dot((Vector3.new(1, 0, 0)).Unit) > 0.95 then
						playAnimation("CrouchwalkRight", 0.3, v_u_7)
					elseif v98:Dot((Vector3.new(0, 0, 1)).Unit) > 0.95 then
						playAnimation("CrouchwalkBackward", 0.3, v_u_7)
					elseif v98:Dot((Vector3.new(-1, 0, 0)).Unit) > 0.95 then
						playAnimation("CrouchwalkLeft", 0.3, v_u_7)
					end
					if v_u_20 then
						v_u_20.Priority = Enum.AnimationPriority.Movement
					end
					setAnimationSpeed(v95 / 6)
				else
					if game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.Default then
						playAnimation("walkForward", 0.3, v_u_7)
					elseif v98:Dot((Vector3.new(1, 0, -1)).Unit) > 0.95 then
						playAnimation("walkForwardRight", 0.3, v_u_7)
					elseif v98:Dot((Vector3.new(1, 0, 1)).Unit) > 0.95 then
						playAnimation("walkBackwardRight", 0.3, v_u_7)
					elseif v98:Dot((Vector3.new(-1, 0, 1)).Unit) > 0.95 then
						playAnimation("walkBackwardLeft", 0.3, v_u_7)
					elseif v98:Dot((Vector3.new(-1, 0, -1)).Unit) > 0.95 then
						playAnimation("walkForwardLeft", 0.3, v_u_7)
					elseif v98:Dot((Vector3.new(0, 0, -1)).Unit) > 0.95 then
						playAnimation("walkForward", 0.3, v_u_7)
					elseif v98:Dot((Vector3.new(1, 0, 0)).Unit) > 0.95 then
						playAnimation("walkRight", 0.3, v_u_7)
					elseif v98:Dot((Vector3.new(0, 0, 1)).Unit) > 0.95 then
						playAnimation("walkBackward", 0.3, v_u_7)
					elseif v98:Dot((Vector3.new(-1, 0, 0)).Unit) > 0.95 then
						playAnimation("walkLeft", 0.3, v_u_7)
					end
					if v_u_20 then
						v_u_20.Priority = Enum.AnimationPriority.Movement
					end
					setAnimationSpeed(v95 / 12)
				end
			elseif v_u_8 == "Running" then
				local v99 = v_u_1:FindFirstChild("HumanoidRootPart").CFrame:VectorToObjectSpace(v_u_7.MoveDirection)
				if v_u_1:HasTag("Confusion") then
					v99 = v99 * -1
				end
				if game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.Default then
					playAnimation("runForward", 0.1, v_u_7)
				elseif v99:Dot((Vector3.new(1, 0, -1)).Unit) > 0.9 then
					playAnimation("runRight", 0.3, v_u_7)
				elseif v99:Dot((Vector3.new(-1, 0, -1)).Unit) > 0.9 then
					playAnimation("runLeft", 0.3, v_u_7)
				else
					playAnimation("runForward", 0.3, v_u_7)
				end
				if v_u_20 then
					v_u_20.Priority = Enum.AnimationPriority.Movement
				end
				setAnimationSpeed(v95 / 24)
			elseif v_u_8 == "Dead" or (v_u_8 == "GettingUp" or (v_u_8 == "FallingDown" or (v_u_8 == "Seated" or v_u_8 == "PlatformStanding"))) then
				stopAllAnimations()
				v94 = true
				v92 = 1
				v91 = 0.1
			end
		end
		if v94 then
			local v100 = p90 * v92
			local v101 = v91 * math.sin(v100)
			v_u_3:SetDesiredAngle(v101 + 0)
			v_u_4:SetDesiredAngle(v101 - 0)
			v_u_5:SetDesiredAngle(-v101)
			v_u_6:SetDesiredAngle(-v101)
		end
		if v_u_7.Health <= v_u_9 then
			if v_u_88 == false then
				v_u_88 = true
				if game:GetService("Players").LocalPlayer:GetAttribute("CameraShake") == true then
					v_u_13:ShakeSustain(v_u_13.Presets.Injured)
				end
			end
		elseif v_u_88 == true then
			v_u_88 = false
			v_u_13:StopSustained(1)
		end
		v_u_86 = v_u_7.Health
		local v102 = getTool()
		if v102 and v102:FindFirstChild("Handle") then
			local v103 = getToolAnim(v102)
			if v103 then
				v_u_48 = v103.Value
				v103.Parent = nil
				v_u_49 = p90 + 0.3
			end
			if v_u_49 < p90 then
				v_u_49 = 0
				v_u_48 = "None"
			end
			animateTool()
		else
			stopToolAnimations()
			v_u_48 = "None"
			v_u_68 = nil
			v_u_49 = 0
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
playAnimation("idle", 0.1, v_u_7)
local _ = "Standing"
while v_u_1.Parent ~= nil do
	local _, v104 = wait()
	move(v104)
end