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
			["id"] = "http://www.roblox.com/asset/?id=126006323585482",
			["weight"] = 9
		}
	},
	["walkForward"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=112744383251617",
			["weight"] = 10
		}
	},
	["walkForwardRight"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=116788233185735",
			["weight"] = 10
		}
	},
	["walkForwardLeft"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=122285858968032",
			["weight"] = 10
		}
	},
	["walkBackward"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=123318273739719",
			["weight"] = 10
		}
	},
	["walkBackwardLeft"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=127677754444996",
			["weight"] = 10
		}
	},
	["walkBackwardRight"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=115199897086816",
			["weight"] = 10
		}
	},
	["walkRight"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=99339234626187",
			["weight"] = 10
		}
	},
	["walkLeft"] = {
		{
			["id"] = "http://www.roblox.com/asset/?id=90916154231024",
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
local v_u_88 = 0
function move(p89)
	-- upvalues: (copy) v_u_1, (ref) v_u_8, (copy) v_u_7, (ref) v_u_85, (ref) v_u_50, (ref) v_u_88, (copy) v_u_13, (copy) v_u_25, (ref) v_u_18, (ref) v_u_20, (ref) v_u_87, (copy) v_u_3, (copy) v_u_4, (copy) v_u_5, (copy) v_u_6, (copy) v_u_9, (ref) v_u_86, (ref) v_u_48, (ref) v_u_49, (ref) v_u_68
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
		local v90 = 1
		local v91 = 1
		local v92 = p89 - v_u_85
		v_u_85 = p89
		local v93 = false
		if v_u_50 > 0 then
			v_u_50 = v_u_50 - v92
		end
		local v94 = (v_u_1:FindFirstChild("HumanoidRootPart").AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude
		if v_u_8 == "Standing" or v_u_8 == "Stopping" then
			playAnimation("idle", 0.1, v_u_7)
		end
		if v_u_7.FloorMaterial ~= Enum.Material.Air and (v_u_8 ~= "Stopping" or v_u_1:FindFirstChild("HumanoidRootPart").CFrame.LookVector:Dot(v_u_7.MoveDirection) > 0.45) then
			if v94 > 0.01 and (v94 <= 15 and v_u_7.MoveDirection ~= Vector3.new(0, 0, 0)) then
				v_u_88 = 0
				v_u_13:StopSustained(0.5)
				v_u_8 = "Walking"
			else
				v_u_88 = 0
				if v_u_25[v_u_18] == nil and (v_u_8 ~= "Standing" or v94 > 8) and (v_u_8 ~= "Stopping" and v_u_8 ~= "WalkStopping") then
					if v_u_8 == "Walking" and (v_u_1:GetAttribute("Crouching") == false and (v94 > 0 and v_u_7.MoveDirection == Vector3.new(0, 0, 0))) then
						v_u_8 = "WalkStopping"
						stopAllAnimations()
						if v_u_20 then
							v_u_20.Priority = Enum.AnimationPriority.Action2
							v_u_20.Stopped:Once(function()
								-- upvalues: (ref) v_u_8, (ref) v_u_87, (ref) v_u_7
								v_u_8 = "Standing"
								v_u_87 = false
								if v_u_8 == "Standing" then
									playAnimation("idle", 0.1, v_u_7)
								end
							end)
						else
							v_u_8 = "Standing"
							playAnimation("idle", 0.1, v_u_7)
						end
					else
						playAnimation("idle", 0.1, v_u_7)
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
				local v95 = v_u_1:FindFirstChild("HumanoidRootPart").CFrame:VectorToObjectSpace(v_u_7.MoveDirection)
				if v_u_1:HasTag("Confusion") then
					v95 = v95 * -1
				end
				if game:GetService("UserInputService").MouseBehavior == Enum.MouseBehavior.Default then
					playAnimation("walkForward", 0.3, v_u_7)
				elseif v95:Dot((Vector3.new(1, 0, -1)).Unit) > 0.95 then
					playAnimation("walkForwardRight", 0.3, v_u_7)
				elseif v95:Dot((Vector3.new(1, 0, 1)).Unit) > 0.95 then
					playAnimation("walkBackwardRight", 0.3, v_u_7)
				elseif v95:Dot((Vector3.new(-1, 0, 1)).Unit) > 0.95 then
					playAnimation("walkBackwardLeft", 0.3, v_u_7)
				elseif v95:Dot((Vector3.new(-1, 0, -1)).Unit) > 0.95 then
					playAnimation("walkForwardLeft", 0.3, v_u_7)
				elseif v95:Dot((Vector3.new(0, 0, -1)).Unit) > 0.95 then
					playAnimation("walkForward", 0.3, v_u_7)
				elseif v95:Dot((Vector3.new(1, 0, 0)).Unit) > 0.95 then
					playAnimation("walkRight", 0.3, v_u_7)
				elseif v95:Dot((Vector3.new(0, 0, 1)).Unit) > 0.95 then
					playAnimation("walkBackward", 0.3, v_u_7)
				elseif v95:Dot((Vector3.new(-1, 0, 0)).Unit) > 0.95 then
					playAnimation("walkLeft", 0.3, v_u_7)
				end
				if v_u_20 then
					v_u_20.Priority = Enum.AnimationPriority.Movement
				end
				setAnimationSpeed(v94 / 12)
			elseif v_u_8 == "Dead" or (v_u_8 == "GettingUp" or (v_u_8 == "FallingDown" or (v_u_8 == "Seated" or v_u_8 == "PlatformStanding"))) then
				stopAllAnimations()
				v93 = true
				v91 = 1
				v90 = 0.1
			end
		end
		if v93 then
			local v96 = p89 * v91
			local v97 = v90 * math.sin(v96)
			v_u_3:SetDesiredAngle(v97 + 0)
			v_u_4:SetDesiredAngle(v97 - 0)
			v_u_5:SetDesiredAngle(-v97)
			v_u_6:SetDesiredAngle(-v97)
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
		v_u_86 = v_u_7.Health
		local v98 = getTool()
		if v98 and v98:FindFirstChild("Handle") then
			local v99 = getToolAnim(v98)
			if v99 then
				v_u_48 = v99.Value
				v99.Parent = nil
				v_u_49 = p89 + 0.3
			end
			if v_u_49 < p89 then
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
	local _, v100 = wait()
	move(v100)
end