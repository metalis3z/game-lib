-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-04-03 16:18:21
-- Luau version 6, Types version 3
-- Time taken: 0.012400 seconds

local Parent_upvr = script.Parent
local Torso = Parent_upvr:WaitForChild("Torso")
local Right_Shoulder_upvr = Torso:WaitForChild("Right Shoulder")
local Left_Shoulder_upvr = Torso:WaitForChild("Left Shoulder")
local Right_Hip_upvr = Torso:WaitForChild("Right Hip")
local Left_Hip_upvr = Torso:WaitForChild("Left Hip")
local Humanoid_upvr = Parent_upvr:WaitForChild("Humanoid")
local var16_upvw = "Standing"
local pcall_result1, pcall_result2 = pcall(function() -- Line 15
	return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun")
end)
local var20_upvr = pcall_result1 and pcall_result2
local function _() -- Line 18, Named "getRigScale"
	--[[ Upvalues[2]:
		[1]: var20_upvr (readonly)
		[2]: Parent_upvr (readonly)
	]]
	if var20_upvr then
		return Parent_upvr:GetScale()
	end
	return 1
end
local var21_upvw = ""
local var22_upvw
local var23_upvw
local var24_upvw
local var25_upvw = 1
local tbl_upvr_2 = {}
local tbl_upvr_4 = {
	idle = {{
		id = "http://www.roblox.com/asset/?id=180435571";
		weight = 9;
	}, {
		id = "http://www.roblox.com/asset/?id=180435792";
		weight = 1;
	}};
	walk = {{
		id = "http://www.roblox.com/asset/?id=180426354";
		weight = 10;
	}};
	run = {{
		id = "run.xml";
		weight = 10;
	}};
	jump = {{
		id = "http://www.roblox.com/asset/?id=125750702";
		weight = 10;
	}};
	fall = {{
		id = "http://www.roblox.com/asset/?id=180436148";
		weight = 10;
	}};
	climb = {{
		id = "http://www.roblox.com/asset/?id=180436334";
		weight = 10;
	}};
	sit = {{
		id = "http://www.roblox.com/asset/?id=178130996";
		weight = 10;
	}};
	toolnone = {{
		id = "http://www.roblox.com/asset/?id=182393478";
		weight = 10;
	}};
	toolslash = {{
		id = "http://www.roblox.com/asset/?id=129967390";
		weight = 10;
	}};
	toollunge = {{
		id = "http://www.roblox.com/asset/?id=129967478";
		weight = 10;
	}};
	wave = {{
		id = "http://www.roblox.com/asset/?id=128777973";
		weight = 10;
	}};
	point = {{
		id = "http://www.roblox.com/asset/?id=128853357";
		weight = 10;
	}};
	dance1 = {{
		id = "http://www.roblox.com/asset/?id=182435998";
		weight = 10;
	}, {
		id = "http://www.roblox.com/asset/?id=182491037";
		weight = 10;
	}, {
		id = "http://www.roblox.com/asset/?id=182491065";
		weight = 10;
	}};
	dance2 = {{
		id = "http://www.roblox.com/asset/?id=182436842";
		weight = 10;
	}, {
		id = "http://www.roblox.com/asset/?id=182491248";
		weight = 10;
	}, {
		id = "http://www.roblox.com/asset/?id=182491277";
		weight = 10;
	}};
	dance3 = {{
		id = "http://www.roblox.com/asset/?id=182436935";
		weight = 10;
	}, {
		id = "http://www.roblox.com/asset/?id=182491368";
		weight = 10;
	}, {
		id = "http://www.roblox.com/asset/?id=182491423";
		weight = 10;
	}};
	laugh = {{
		id = "http://www.roblox.com/asset/?id=129423131";
		weight = 10;
	}};
	cheer = {{
		id = "http://www.roblox.com/asset/?id=129423030";
		weight = 10;
	}};
}
local tbl_upvr_3 = {"dance1", "dance2", "dance3"}
local tbl_upvr = {
	wave = false;
	point = false;
	dance1 = true;
	dance2 = true;
	dance3 = true;
	laugh = false;
	cheer = false;
}
function configureAnimationSet(arg1, arg2) -- Line 98
	--[[ Upvalues[1]:
		[1]: tbl_upvr_2 (readonly)
	]]
	if tbl_upvr_2[arg1] ~= nil then
		for _, v in pairs(tbl_upvr_2[arg1].connections) do
			v:disconnect()
		end
	end
	tbl_upvr_2[arg1] = {}
	tbl_upvr_2[arg1].count = 0
	tbl_upvr_2[arg1].totalWeight = 0
	tbl_upvr_2[arg1].connections = {}
	local SOME = script:FindFirstChild(arg1)
	if SOME ~= nil then
		table.insert(tbl_upvr_2[arg1].connections, SOME.ChildAdded:connect(function(arg1_2) -- Line 113
			--[[ Upvalues[2]:
				[1]: arg1 (readonly)
				[2]: arg2 (readonly)
			]]
			configureAnimationSet(arg1, arg2)
		end))
		table.insert(tbl_upvr_2[arg1].connections, SOME.ChildRemoved:connect(function(arg1_3) -- Line 114
			--[[ Upvalues[2]:
				[1]: arg1 (readonly)
				[2]: arg2 (readonly)
			]]
			configureAnimationSet(arg1, arg2)
		end))
		local var83 = 1
		for _, v_2 in pairs(SOME:GetChildren()) do
			if v_2:IsA("Animation") then
				table.insert(tbl_upvr_2[arg1].connections, v_2.Changed:connect(function(arg1_4) -- Line 118
					--[[ Upvalues[2]:
						[1]: arg1 (readonly)
						[2]: arg2 (readonly)
					]]
					configureAnimationSet(arg1, arg2)
				end))
				tbl_upvr_2[arg1][var83] = {}
				tbl_upvr_2[arg1][var83].anim = v_2
				local Weight = v_2:FindFirstChild("Weight")
				if Weight == nil then
					tbl_upvr_2[arg1][var83].weight = 1
				else
					tbl_upvr_2[arg1][var83].weight = Weight.Value
				end
				tbl_upvr_2[arg1].count = tbl_upvr_2[arg1].count + 1
				tbl_upvr_2[arg1].totalWeight = tbl_upvr_2[arg1].totalWeight + tbl_upvr_2[arg1][var83].weight
			end
		end
	end
	if tbl_upvr_2[arg1].count <= 0 then
		for i_3, v_3 in pairs(arg2) do
			v_2 = tbl_upvr_2[arg1]
			v_2[i_3] = {}
			v_2 = tbl_upvr_2[arg1][i_3]
			v_2.anim = Instance.new("Animation")
			v_2 = tbl_upvr_2[arg1][i_3].anim
			v_2.Name = arg1
			v_2 = tbl_upvr_2[arg1][i_3].anim
			v_2.AnimationId = v_3.id
			v_2 = tbl_upvr_2[arg1][i_3]
			v_2.weight = v_3.weight
			v_2 = tbl_upvr_2[arg1]
			v_2.count = tbl_upvr_2[arg1].count + 1
			v_2 = tbl_upvr_2[arg1]
			v_2.totalWeight = tbl_upvr_2[arg1].totalWeight + v_3.weight
		end
	end
end
function scriptChildModified(arg1) -- Line 151
	--[[ Upvalues[1]:
		[1]: tbl_upvr_4 (readonly)
	]]
	local var92 = tbl_upvr_4[arg1.Name]
	if var92 ~= nil then
		configureAnimationSet(arg1.Name, var92)
	end
end
script.ChildAdded:connect(scriptChildModified)
script.ChildRemoved:connect(scriptChildModified)
local var93
if Humanoid_upvr then
	var93 = Humanoid_upvr:FindFirstChildOfClass("Animator")
else
	var93 = nil
end
if var93 then
	for _, v_4 in ipairs(var93:GetPlayingAnimationTracks()) do
		v_4:Stop(0)
		v_4:Destroy()
	end
end
for i_5, _ in pairs(tbl_upvr_4) do
	-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [408.27]
	configureAnimationSet(i_5, nil)
end
local var100_upvw = "None"
local var101_upvw = 0
function stopAllAnimations() -- Line 192
	--[[ Upvalues[5]:
		[1]: var21_upvw (read and write)
		[2]: tbl_upvr (readonly)
		[3]: var22_upvw (read and write)
		[4]: var24_upvw (read and write)
		[5]: var23_upvw (read and write)
	]]
	local var102
	if tbl_upvr[var21_upvw] ~= nil and tbl_upvr[var102] == false then
		var102 = "idle"
	end
	var21_upvw = ""
	var22_upvw = nil
	if var24_upvw ~= nil then
		var24_upvw:disconnect()
	end
	if var23_upvw ~= nil then
		var23_upvw:Stop()
		var23_upvw:Destroy()
		var23_upvw = nil
	end
	return var102
end
function setAnimationSpeed(arg1) -- Line 214
	--[[ Upvalues[2]:
		[1]: var25_upvw (read and write)
		[2]: var23_upvw (read and write)
	]]
	if arg1 ~= var25_upvw then
		var25_upvw = arg1
		var23_upvw:AdjustSpeed(var25_upvw)
	end
end
function keyFrameReachedFunc(arg1) -- Line 221
	--[[ Upvalues[4]:
		[1]: var21_upvw (read and write)
		[2]: tbl_upvr (readonly)
		[3]: var25_upvw (read and write)
		[4]: Humanoid_upvr (readonly)
	]]
	if arg1 == "End" then
		local var103
		if tbl_upvr[var21_upvw] ~= nil and tbl_upvr[var103] == false then
			var103 = "idle"
		end
		playAnimation(var103, 0, Humanoid_upvr)
		setAnimationSpeed(var25_upvw)
	end
end
function playAnimation(arg1, arg2, arg3) -- Line 237
	--[[ Upvalues[6]:
		[1]: tbl_upvr_2 (readonly)
		[2]: var22_upvw (read and write)
		[3]: var23_upvw (read and write)
		[4]: var25_upvw (read and write)
		[5]: var21_upvw (read and write)
		[6]: var24_upvw (read and write)
	]]
	local var105
	while tbl_upvr_2[arg1][var105].weight < math.random(1, tbl_upvr_2[arg1].totalWeight) do
		var105 += 1
	end
	local anim_2 = tbl_upvr_2[arg1][var105].anim
	if anim_2 ~= var22_upvw then
		if var23_upvw ~= nil then
			var23_upvw:Stop(arg2)
			var23_upvw:Destroy()
		end
		var25_upvw = 1
		var23_upvw = arg3:LoadAnimation(anim_2)
		var23_upvw.Priority = Enum.AnimationPriority.Core
		var23_upvw:Play(arg2)
		var21_upvw = arg1
		var22_upvw = anim_2
		if var24_upvw ~= nil then
			var24_upvw:disconnect()
		end
		var24_upvw = var23_upvw.KeyframeReached:connect(keyFrameReachedFunc)
	end
end
local var107_upvw = ""
local var108_upvw
local var109_upvw
local var110_upvw
function toolKeyFrameReachedFunc(arg1) -- Line 286
	--[[ Upvalues[2]:
		[1]: var107_upvw (read and write)
		[2]: Humanoid_upvr (readonly)
	]]
	if arg1 == "End" then
		playToolAnimation(var107_upvw, 0, Humanoid_upvr)
	end
end
function playToolAnimation(arg1, arg2, arg3, arg4) -- Line 294
	--[[ Upvalues[5]:
		[1]: tbl_upvr_2 (readonly)
		[2]: var109_upvw (read and write)
		[3]: var108_upvw (read and write)
		[4]: var107_upvw (read and write)
		[5]: var110_upvw (read and write)
	]]
	local var112
	while tbl_upvr_2[arg1][var112].weight < math.random(1, tbl_upvr_2[arg1].totalWeight) do
		var112 += 1
	end
	local var113
	local anim = tbl_upvr_2[arg1][var112].anim
	if var109_upvw ~= anim then
		if var108_upvw ~= nil then
			var108_upvw:Stop()
			var108_upvw:Destroy()
			var113 = 0
		end
		var108_upvw = arg3:LoadAnimation(anim)
		if arg4 then
			var108_upvw.Priority = arg4
		end
		var108_upvw:Play(var113)
		var107_upvw = arg1
		var109_upvw = anim
		var110_upvw = var108_upvw.KeyframeReached:connect(toolKeyFrameReachedFunc)
	end
end
function stopToolAnimations() -- Line 329
	--[[ Upvalues[4]:
		[1]: var107_upvw (read and write)
		[2]: var110_upvw (read and write)
		[3]: var109_upvw (read and write)
		[4]: var108_upvw (read and write)
	]]
	if var110_upvw ~= nil then
		var110_upvw:disconnect()
	end
	var107_upvw = ""
	var109_upvw = nil
	if var108_upvw ~= nil then
		var108_upvw:Stop()
		var108_upvw:Destroy()
		var108_upvw = nil
	end
	return var107_upvw
end
function onRunning(arg1) -- Line 352
	--[[ Upvalues[7]:
		[1]: var20_upvr (readonly)
		[2]: Parent_upvr (readonly)
		[3]: Humanoid_upvr (readonly)
		[4]: var22_upvw (read and write)
		[5]: var16_upvw (read and write)
		[6]: tbl_upvr (readonly)
		[7]: var21_upvw (read and write)
	]]
	local var117
	if var20_upvr then
		var117 = Parent_upvr:GetScale()
	else
		var117 = 1
	end
	local var118 = arg1 / var117
	var117 = 0.01
	if var117 < var118 then
		var117 = playAnimation
		var117("walk", 0.1, Humanoid_upvr)
		var117 = var22_upvw
		if var117 then
			var117 = var22_upvw.AnimationId
			if var117 == "http://www.roblox.com/asset/?id=180426354" then
				var117 = setAnimationSpeed
				var117(var118 / 14.5)
			end
		end
		var117 = "Running"
		var16_upvw = var117
	else
		var117 = tbl_upvr[var21_upvw]
		if var117 == nil then
			var117 = playAnimation
			var117("idle", 0.1, Humanoid_upvr)
			var117 = "Standing"
			var16_upvw = var117
		end
	end
end
function onDied() -- Line 369
	--[[ Upvalues[1]:
		[1]: var16_upvw (read and write)
	]]
	var16_upvw = "Dead"
end
function onJumping() -- Line 373
	--[[ Upvalues[3]:
		[1]: Humanoid_upvr (readonly)
		[2]: var101_upvw (read and write)
		[3]: var16_upvw (read and write)
	]]
	playAnimation("jump", 0.1, Humanoid_upvr)
	var101_upvw = 0.3
	var16_upvw = "Jumping"
end
function onClimbing(arg1) -- Line 379
	--[[ Upvalues[4]:
		[1]: var20_upvr (readonly)
		[2]: Parent_upvr (readonly)
		[3]: Humanoid_upvr (readonly)
		[4]: var16_upvw (read and write)
	]]
	local var119
	if var20_upvr then
		var119 = Parent_upvr:GetScale()
	else
		var119 = 1
	end
	var119 = playAnimation
	var119("climb", 0.1, Humanoid_upvr)
	var119 = setAnimationSpeed
	var119(arg1 / var119 / 12)
	var119 = "Climbing"
	var16_upvw = var119
end
function onGettingUp() -- Line 387
	--[[ Upvalues[1]:
		[1]: var16_upvw (read and write)
	]]
	var16_upvw = "GettingUp"
end
function onFreeFall() -- Line 391
	--[[ Upvalues[3]:
		[1]: var101_upvw (read and write)
		[2]: Humanoid_upvr (readonly)
		[3]: var16_upvw (read and write)
	]]
	if var101_upvw <= 0 then
		playAnimation("fall", 0.3, Humanoid_upvr)
	end
	var16_upvw = "FreeFall"
end
function onFallingDown() -- Line 398
	--[[ Upvalues[1]:
		[1]: var16_upvw (read and write)
	]]
	var16_upvw = "FallingDown"
end
function onSeated() -- Line 402
	--[[ Upvalues[1]:
		[1]: var16_upvw (read and write)
	]]
	var16_upvw = "Seated"
end
function onPlatformStanding() -- Line 406
	--[[ Upvalues[1]:
		[1]: var16_upvw (read and write)
	]]
	var16_upvw = "PlatformStanding"
end
function onSwimming(arg1) -- Line 410
	--[[ Upvalues[1]:
		[1]: var16_upvw (read and write)
	]]
	if 0 < arg1 then
		var16_upvw = "Running"
	else
		var16_upvw = "Standing"
	end
end
function getTool() -- Line 418
	--[[ Upvalues[1]:
		[1]: Parent_upvr (readonly)
	]]
	for _, v_6 in ipairs(Parent_upvr:GetChildren()) do
		if v_6.className == "Tool" then
			return v_6
		end
	end
	return nil
end
function getToolAnim(arg1) -- Line 425
	for _, v_7 in ipairs(arg1:GetChildren()) do
		if v_7.Name == "toolanim" and v_7.className == "StringValue" then
			return v_7
		end
	end
	return nil
end
function animateTool() -- Line 434
	--[[ Upvalues[2]:
		[1]: var100_upvw (read and write)
		[2]: Humanoid_upvr (readonly)
	]]
	if var100_upvw == "None" then
		playToolAnimation("toolnone", 0.1, Humanoid_upvr, Enum.AnimationPriority.Idle)
	else
		if var100_upvw == "Slash" then
			playToolAnimation("toolslash", 0, Humanoid_upvr, Enum.AnimationPriority.Action)
			return
		end
		if var100_upvw == "Lunge" then
			playToolAnimation("toollunge", 0, Humanoid_upvr, Enum.AnimationPriority.Action)
			return
		end
	end
end
function moveSit() -- Line 452
	--[[ Upvalues[4]:
		[1]: Right_Shoulder_upvr (readonly)
		[2]: Left_Shoulder_upvr (readonly)
		[3]: Right_Hip_upvr (readonly)
		[4]: Left_Hip_upvr (readonly)
	]]
	Right_Shoulder_upvr.MaxVelocity = 0.15
	Left_Shoulder_upvr.MaxVelocity = 0.15
	Right_Shoulder_upvr:SetDesiredAngle(1.57)
	Left_Shoulder_upvr:SetDesiredAngle(-1.57)
	Right_Hip_upvr:SetDesiredAngle(1.57)
	Left_Hip_upvr:SetDesiredAngle(-1.57)
end
local var130_upvw = 0
local var131_upvw = 0
function move(arg1) -- Line 463
	--[[ Upvalues[11]:
		[1]: var130_upvw (read and write)
		[2]: var101_upvw (read and write)
		[3]: var16_upvw (read and write)
		[4]: Humanoid_upvr (readonly)
		[5]: Right_Shoulder_upvr (readonly)
		[6]: Left_Shoulder_upvr (readonly)
		[7]: Right_Hip_upvr (readonly)
		[8]: Left_Hip_upvr (readonly)
		[9]: var100_upvw (read and write)
		[10]: var131_upvw (read and write)
		[11]: var109_upvw (read and write)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	var130_upvw = arg1
	if 0 < var101_upvw then
		var101_upvw -= arg1 - var130_upvw
	end
	local var132
	if var16_upvw == "FreeFall" and var101_upvw <= 0 then
		playAnimation("fall", 0.3, Humanoid_upvr)
	else
		if var16_upvw == "Seated" then
			playAnimation("sit", 0.5, Humanoid_upvr)
			return
		end
		if var16_upvw == "Running" then
			playAnimation("walk", 0.1, Humanoid_upvr)
		elseif var16_upvw == "Dead" or var16_upvw == "GettingUp" or var16_upvw == "FallingDown" or var16_upvw == "Seated" or var16_upvw == "PlatformStanding" then
			stopAllAnimations()
			var132 = true
		end
	end
	if var132 then
		local var133 = 0.1 * math.sin(arg1 * 1)
		Right_Shoulder_upvr:SetDesiredAngle(var133 + 0)
		Left_Shoulder_upvr:SetDesiredAngle(var133 - 0)
		Right_Hip_upvr:SetDesiredAngle(-var133)
		Left_Hip_upvr:SetDesiredAngle(-var133)
	end
	local getTool_result1 = getTool()
	if getTool_result1 and getTool_result1:FindFirstChild("Handle") then
		local getToolAnim_result1 = getToolAnim(getTool_result1)
		if getToolAnim_result1 then
			var100_upvw = getToolAnim_result1.Value
			getToolAnim_result1.Parent = nil
			var131_upvw = arg1 + 0.3
		end
		if var131_upvw < arg1 then
			var131_upvw = 0
			var100_upvw = "None"
		end
		animateTool()
	else
		stopToolAnimations()
		var100_upvw = "None"
		var109_upvw = nil
		var131_upvw = 0
	end
end
Humanoid_upvr.Died:connect(onDied)
Humanoid_upvr.Running:connect(onRunning)
Humanoid_upvr.Jumping:connect(onJumping)
Humanoid_upvr.Climbing:connect(onClimbing)
Humanoid_upvr.GettingUp:connect(onGettingUp)
Humanoid_upvr.FreeFalling:connect(onFreeFall)
Humanoid_upvr.FallingDown:connect(onFallingDown)
Humanoid_upvr.Seated:connect(onSeated)
Humanoid_upvr.PlatformStanding:connect(onPlatformStanding)
Humanoid_upvr.Swimming:connect(onSwimming)
game:GetService("Players").LocalPlayer.Chatted:connect(function(arg1) -- Line 540
	--[[ Upvalues[4]:
		[1]: tbl_upvr_3 (readonly)
		[2]: var16_upvw (read and write)
		[3]: tbl_upvr (readonly)
		[4]: Humanoid_upvr (readonly)
	]]
	local var137
	if arg1 == "/e dance" then
		var137 = tbl_upvr_3[math.random(1, #tbl_upvr_3)]
	elseif string.sub(arg1, 1, 3) == "/e " then
		var137 = string.sub(arg1, 4)
	elseif string.sub(arg1, 1, 7) == "/emote " then
		var137 = string.sub(arg1, 8)
	end
	if var16_upvw == "Standing" and tbl_upvr[var137] ~= nil then
		playAnimation(var137, 0.1, Humanoid_upvr)
	end
end)
script:WaitForChild("PlayEmote").OnInvoke = function(arg1) -- Line 557
	--[[ Upvalues[4]:
		[1]: var16_upvw (read and write)
		[2]: tbl_upvr (readonly)
		[3]: Humanoid_upvr (readonly)
		[4]: var23_upvw (read and write)
	]]
	if var16_upvw ~= "Standing" then return end
	if tbl_upvr[arg1] ~= nil then
		playAnimation(arg1, 0.1, Humanoid_upvr)
		return true, var23_upvw
	end
	return false
end
playAnimation("idle", 0.1, Humanoid_upvr)
var16_upvw = "Standing"
while Parent_upvr.Parent ~= nil do
	local _, wait_result2 = wait(0.1)
	move(wait_result2)
end