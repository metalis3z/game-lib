local l__Parent__1 = script.Parent;
local l__Humanoid__2 = l__Parent__1:WaitForChild("Humanoid");
local v3, v4 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserNoUpdateOnLoop");
end);
local v5, v6 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserAnimationSpeedDampening");
end);
local v7, v8 = pcall(function()
	return UserSettings():IsUserFeatureEnabled("UserAdjustHumanoidRootPartToHipPosition");
end);
local v9 = v7 or v8;
local l__ScaleDampeningPercent__10 = script:FindFirstChild("ScaleDampeningPercent");
if v9 then
	local v11 = 2;
else
	v11 = 1.35;
end;
local u1 = false;
local v12, v13 = pcall(function()
	u1 = UserSettings():IsUserFeatureEnabled("UserPreloadAnimations");
end);
if not v12 then
	u1 = false;
end;
math.randomseed(tick());
function findExistingAnimationInSet(p1, p2)
	if p1 ~= nil then
		if p2 == nil then
			return 0;
		end;
	else
		return 0;
	end;
	local l__count__14 = p1.count;
	local v15 = 1 - 1;
	while true do
		if p1[v15].anim.AnimationId == p2.AnimationId then
			return v15;
		end;
		if 0 <= 1 then
			if v15 < l__count__14 then

			else
				break;
			end;
		elseif l__count__14 < v15 then

		else
			break;
		end;
		v15 = v15 + 1;	
	end;
	return 0;
end;
local u2 = {};
local u3 = {};
function configureAnimationSet(p3, p4)
	if u2[p3] ~= nil then
		local v16, v17, v18 = pairs(u2[p3].connections);
		while true do
			local v19, v20 = v16(v17, v18);
			if v19 then

			else
				break;
			end;
			v18 = v19;
			v20:disconnect();		
		end;
	end;
	u2[p3] = {};
	u2[p3].count = 0;
	u2[p3].totalWeight = 0;
	u2[p3].connections = {};
	local u4 = false;
	local v21, v22 = pcall(function()
		u4 = UserSettings():IsUserFeatureEnabled("UserAllowDisableCustomAnims2");
	end);
	if u4 then
		local u5 = true;
		local v23, v24 = pcall(function()
			u5 = game:GetService("StarterPlayer").AllowCustomAnimations;
		end);
		if not v23 then
			u5 = true;
		end;
	end;
	local v25 = script:FindFirstChild(p3);
	if true then
		if v25 ~= nil then
			table.insert(u2[p3].connections, v25.ChildAdded:connect(function(p5)
				configureAnimationSet(p3, p4);
			end));
			table.insert(u2[p3].connections, v25.ChildRemoved:connect(function(p6)
				configureAnimationSet(p3, p4);
			end));
			local v26, v27, v28 = pairs(v25:GetChildren());
			while true do
				local v29, v30 = v26(v27, v28);
				if v29 then

				else
					break;
				end;
				v28 = v29;
				if v30:IsA("Animation") then
					local v31 = 1;
					local l__Weight__32 = v30:FindFirstChild("Weight");
					if l__Weight__32 ~= nil then
						v31 = l__Weight__32.Value;
					end;
					u2[p3].count = u2[p3].count + 1;
					local l__count__33 = u2[p3].count;
					u2[p3][l__count__33] = {};
					u2[p3][l__count__33].anim = v30;
					u2[p3][l__count__33].weight = v31;
					u2[p3].totalWeight = u2[p3].totalWeight + u2[p3][l__count__33].weight;
					table.insert(u2[p3].connections, v30.Changed:connect(function(p7)
						configureAnimationSet(p3, p4);
					end));
					table.insert(u2[p3].connections, v30.ChildAdded:connect(function(p8)
						configureAnimationSet(p3, p4);
					end));
					table.insert(u2[p3].connections, v30.ChildRemoved:connect(function(p9)
						configureAnimationSet(p3, p4);
					end));
				end;			
			end;
		end;
	end;
	if u2[p3].count <= 0 then
		local v34, v35, v36 = pairs(p4);
		while true do
			local v37, v38 = v34(v35, v36);
			if v37 then

			else
				break;
			end;
			v36 = v37;
			u2[p3][v37] = {};
			u2[p3][v37].anim = Instance.new("Animation");
			u2[p3][v37].anim.Name = p3;
			u2[p3][v37].anim.AnimationId = v38.id;
			u2[p3][v37].weight = v38.weight;
			u2[p3].count = u2[p3].count + 1;
			u2[p3].totalWeight = u2[p3].totalWeight + v38.weight;		
		end;
	end;
	if u1 then
		local v39, v40, v41 = pairs(u2);
		while true do
			local v42, v43 = v39(v40, v41);
			if v42 then

			else
				break;
			end;
			local l__count__44 = v43.count;
			local v45 = 1 - 1;
			while true do
				if u3[v43[v45].anim.AnimationId] == nil then
					l__Humanoid__2:LoadAnimation(v43[v45].anim);
					u3[v43[v45].anim.AnimationId] = true;
				end;
				if 0 <= 1 then
					if v45 < l__count__44 then

					else
						break;
					end;
				elseif l__count__44 < v45 then

				else
					break;
				end;
				v45 = v45 + 1;			
			end;		
		end;
	end;
end;
function configureAnimationSetOld(p10, p11)
	if u2[p10] ~= nil then
		local v46, v47, v48 = pairs(u2[p10].connections);
		while true do
			local v49, v50 = v46(v47, v48);
			if v49 then

			else
				break;
			end;
			v48 = v49;
			v50:disconnect();		
		end;
	end;
	u2[p10] = {};
	u2[p10].count = 0;
	u2[p10].totalWeight = 0;
	u2[p10].connections = {};
	local u6 = false;
	local v51, v52 = pcall(function()
		u6 = UserSettings():IsUserFeatureEnabled("UserAllowDisableCustomAnims2");
	end);
	if u6 then
		local u7 = true;
		local v53, v54 = pcall(function()
			u7 = game:GetService("StarterPlayer").AllowCustomAnimations;
		end);
		if not v53 then
			u7 = true;
		end;
	end;
	local v55 = script:FindFirstChild(p10);
	if true then
		if v55 ~= nil then
			table.insert(u2[p10].connections, v55.ChildAdded:connect(function(p12)
				configureAnimationSet(p10, p11);
			end));
			table.insert(u2[p10].connections, v55.ChildRemoved:connect(function(p13)
				configureAnimationSet(p10, p11);
			end));
			local v56 = 1;
			local v57, v58, v59 = pairs(v55:GetChildren());
			while true do
				local v60, v61 = v57(v58, v59);
				if v60 then

				else
					break;
				end;
				v59 = v60;
				if v61:IsA("Animation") then
					table.insert(u2[p10].connections, v61.Changed:connect(function(p14)
						configureAnimationSet(p10, p11);
					end));
					u2[p10][v56] = {};
					u2[p10][v56].anim = v61;
					local l__Weight__62 = v61:FindFirstChild("Weight");
					if l__Weight__62 == nil then
						u2[p10][v56].weight = 1;
					else
						u2[p10][v56].weight = l__Weight__62.Value;
					end;
					u2[p10].count = u2[p10].count + 1;
					u2[p10].totalWeight = u2[p10].totalWeight + u2[p10][v56].weight;
					v56 = v56 + 1;
				end;			
			end;
		end;
	end;
	if u2[p10].count <= 0 then
		local v63, v64, v65 = pairs(p11);
		while true do
			local v66, v67 = v63(v64, v65);
			if v66 then

			else
				break;
			end;
			v65 = v66;
			u2[p10][v66] = {};
			u2[p10][v66].anim = Instance.new("Animation");
			u2[p10][v66].anim.Name = p10;
			u2[p10][v66].anim.AnimationId = v67.id;
			u2[p10][v66].weight = v67.weight;
			u2[p10].count = u2[p10].count + 1;
			u2[p10].totalWeight = u2[p10].totalWeight + v67.weight;		
		end;
	end;
	if u1 then
		local v68, v69, v70 = pairs(u2);
		while true do
			local v71, v72 = v68(v69, v70);
			if v71 then

			else
				break;
			end;
			local l__count__73 = v72.count;
			local v74 = 1 - 1;
			while true do
				l__Humanoid__2:LoadAnimation(v72[v74].anim);
				if 0 <= 1 then
					if v74 < l__count__73 then

					else
						break;
					end;
				elseif l__count__73 < v74 then

				else
					break;
				end;
				v74 = v74 + 1;			
			end;		
		end;
	end;
end;
local u8 = {
	idle = { {
			id = "http://www.roblox.com/asset/?id=507766666", 
			weight = 1
		}, {
			id = "http://www.roblox.com/asset/?id=507766951", 
			weight = 1
		}, {
			id = "http://www.roblox.com/asset/?id=507766388", 
			weight = 9
		} }, 
	walk = { {
			id = "http://www.roblox.com/asset/?id=507777826", 
			weight = 10
		} }, 
	run = { {
			id = "http://www.roblox.com/asset/?id=507767714", 
			weight = 10
		} }, 
	swim = { {
			id = "http://www.roblox.com/asset/?id=507784897", 
			weight = 10
		} }, 
	swimidle = { {
			id = "http://www.roblox.com/asset/?id=507785072", 
			weight = 10
		} }, 
	jump = { {
			id = "http://www.roblox.com/asset/?id=507765000", 
			weight = 10
		} }, 
	fall = { {
			id = "http://www.roblox.com/asset/?id=507767968", 
			weight = 10
		} }, 
	climb = { {
			id = "http://www.roblox.com/asset/?id=507765644", 
			weight = 10
		} }, 
	sit = { {
			id = "http://www.roblox.com/asset/?id=10295386087", 
			weight = 10
		} }, 
	toolnone = { {
			id = "http://www.roblox.com/asset/?id=507768375", 
			weight = 10
		} }, 
	toolslash = { {
			id = "http://www.roblox.com/asset/?id=522635514", 
			weight = 10
		} }, 
	toollunge = { {
			id = "http://www.roblox.com/asset/?id=522638767", 
			weight = 10
		} }, 
	wave = { {
			id = "http://www.roblox.com/asset/?id=507770239", 
			weight = 10
		} }, 
	point = { {
			id = "http://www.roblox.com/asset/?id=507770453", 
			weight = 10
		} }, 
	dance = { {
			id = "http://www.roblox.com/asset/?id=507771019", 
			weight = 10
		}, {
			id = "http://www.roblox.com/asset/?id=507771955", 
			weight = 10
		}, {
			id = "http://www.roblox.com/asset/?id=507772104", 
			weight = 10
		} }, 
	dance2 = { {
			id = "http://www.roblox.com/asset/?id=507776043", 
			weight = 10
		}, {
			id = "http://www.roblox.com/asset/?id=507776720", 
			weight = 10
		}, {
			id = "http://www.roblox.com/asset/?id=507776879", 
			weight = 10
		} }, 
	dance3 = { {
			id = "http://www.roblox.com/asset/?id=507777268", 
			weight = 10
		}, {
			id = "http://www.roblox.com/asset/?id=507777451", 
			weight = 10
		}, {
			id = "http://www.roblox.com/asset/?id=507777623", 
			weight = 10
		} }, 
	laugh = { {
			id = "http://www.roblox.com/asset/?id=507770818", 
			weight = 10
		} }, 
	cheer = { {
			id = "http://www.roblox.com/asset/?id=507770677", 
			weight = 10
		} }
};
function scriptChildModified(p15)
	local v75 = u8[p15.Name];
	if v75 ~= nil then
		configureAnimationSet(p15.Name, v75);
	end;
end;
script.ChildAdded:connect(scriptChildModified);
script.ChildRemoved:connect(scriptChildModified);
for v76, v77 in pairs(u8) do
	configureAnimationSet(v76, v77);
end;
local u9 = "";
local u10 = {
	wave = false, 
	point = false, 
	dance = true, 
	dance2 = true, 
	dance3 = true, 
	laugh = false, 
	cheer = false
};
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
function stopAllAnimations()
	local v78 = u9;
	if u10[v78] ~= nil then
		if u10[v78] == false then
			v78 = "idle";
		end;
	end;
	u9 = "";
	u11 = nil;
	if u12 ~= nil then
		u12:disconnect();
	end;
	if u13 ~= nil then
		u13:Stop();
		u13:Destroy();
		u13 = nil;
	end;
	if u14 ~= nil then
		u14:disconnect();
	end;
	if u15 ~= nil then
		u15:Stop();
		u15:Destroy();
		u15 = nil;
	end;
	return v78;
end;
local u16 = v5 or v6;
local u17 = l__ScaleDampeningPercent__10;
function getHeightScale()
	if l__Humanoid__2 then

	else
		return 1;
	end;
	if v9 then
		if not l__Humanoid__2.AutomaticScalingEnabled then
			return 1;
		end;
	end;
	local v79 = l__Humanoid__2.HipHeight / v11;
	if u16 then
		if u17 == nil then
			u17 = script:FindFirstChild("ScaleDampeningPercent");
		end;
		if u17 ~= nil then
			v79 = 1 + (l__Humanoid__2.HipHeight - v11) * u17.Value / v11;
		end;
	end;
	return v79;
end;
local u18 = 1;
function setRunSpeed(p16)
	local v80 = p16 * 0.8 / getHeightScale();
	if v80 ~= u18 then
		if v80 < 0.33 then
			u13:AdjustWeight(1);
			u15:AdjustWeight(0.0001);
		elseif v80 < 0.66 then
			local v81 = (v80 - 0.33) / 0.33;
			u13:AdjustWeight(1 - v81 + 0.0001);
			u15:AdjustWeight(v81 + 0.0001);
		else
			u13:AdjustWeight(0.0001);
			u15:AdjustWeight(1);
		end;
		u18 = v80;
		u15:AdjustSpeed(v80);
		u13:AdjustSpeed(v80);
	end;
end;
function setAnimationSpeed(p17)
	if u9 == "walk" then
		setRunSpeed(p17);
		return;
	end;
	if p17 ~= u18 then
		u18 = p17;
		u13:AdjustSpeed(u18);
	end;
end;
local u19 = v3 or v4;
function keyFrameReachedFunc(p18)
	if p18 == "End" then
		if u9 == "walk" then
			if u19 == true then

			else
				u15.TimePosition = 0;
				u13.TimePosition = 0;
				return;
			end;
			if u15.Looped ~= true then
				u15.TimePosition = 0;
			end;
			if u13.Looped ~= true then
				u13.TimePosition = 0;
				return;
			end;
		else
			local v82 = u9;
			if u10[v82] ~= nil then
				if u10[v82] == false then
					v82 = "idle";
				end;
			end;
			playAnimation(v82, 0.15, l__Humanoid__2);
			setAnimationSpeed(u18);
		end;
	end;
end;
function rollAnimation(p19)
	local v83 = math.random(1, u2[p19].totalWeight);
	local v84 = 1;
	while true do
		if u2[p19][v84].weight < v83 then

		else
			break;
		end;
		v83 = v83 - u2[p19][v84].weight;
		v84 = v84 + 1;	
	end;
	return v84;
end;
function playAnimation(p20, p21, p22)
	local l__anim__85 = u2[p20][rollAnimation(p20)].anim;
	if l__anim__85 ~= u11 then
		if u13 ~= nil then
			u13:Stop(p21);
			u13:Destroy();
		end;
		if u15 ~= nil then
			u15:Stop(p21);
			u15:Destroy();
			if u19 == true then
				u15 = nil;
			end;
		end;
		u18 = 1;
		u13 = p22:LoadAnimation(l__anim__85);
		u13.Priority = Enum.AnimationPriority.Core;
		u13:Play(p21);
		u9 = p20;
		u11 = l__anim__85;
		if u12 ~= nil then
			u12:disconnect();
		end;
		u12 = u13.KeyframeReached:connect(keyFrameReachedFunc);
		if p20 == "walk" then
			u15 = p22:LoadAnimation(u2.run[rollAnimation("run")].anim);
			u15.Priority = Enum.AnimationPriority.Core;
			u15:Play(p21);
			if u14 ~= nil then
				u14:disconnect();
			end;
			u14 = u15.KeyframeReached:connect(keyFrameReachedFunc);
		end;
	end;
end;
local u20 = "";
function toolKeyFrameReachedFunc(p23)
	if p23 == "End" then
		playToolAnimation(u20, 0, l__Humanoid__2);
	end;
end;
local u21 = nil;
local u22 = nil;
local u23 = nil;
function playToolAnimation(p24, p25, p26, p27)
	local l__anim__86 = u2[p24][rollAnimation(p24)].anim;
	if u21 ~= l__anim__86 then
		if u22 ~= nil then
			u22:Stop();
			u22:Destroy();
			p25 = 0;
		end;
		u22 = p26:LoadAnimation(l__anim__86);
		if p27 then
			u22.Priority = p27;
		end;
		u22:Play(p25);
		u20 = p24;
		u21 = l__anim__86;
		u23 = u22.KeyframeReached:connect(toolKeyFrameReachedFunc);
	end;
end;
function stopToolAnimations()
	if u23 ~= nil then
		u23:disconnect();
	end;
	u20 = "";
	u21 = nil;
	if u22 ~= nil then
		u22:Stop();
		u22:Destroy();
		u22 = nil;
	end;
	return u20;
end;
local u24 = "Standing";
function onRunning(p28)
	if 0.5 < p28 then
		playAnimation("walk", 0.2, l__Humanoid__2);
		setAnimationSpeed(p28 / 10);
		u24 = "Running";
		return;
	end;
	if u10[u9] == nil then
		playAnimation("idle", 0.2, l__Humanoid__2);
		u24 = "Standing";
	end;
end;
function onDied()
	u24 = "Dead";
end;
local u25 = 0;
function onJumping()
	playAnimation("jump", 0.1, l__Humanoid__2);
	u25 = 0.31;
	u24 = "Jumping";
end;
function onClimbing(p29)
	playAnimation("climb", 0.1, l__Humanoid__2);
	setAnimationSpeed(p29 / 5);
	u24 = "Climbing";
end;
function onGettingUp()
	u24 = "GettingUp";
end;
function onFreeFall()
	if u25 <= 0 then
		playAnimation("fall", 0.2, l__Humanoid__2);
	end;
	u24 = "FreeFall";
end;
function onFallingDown()
	u24 = "FallingDown";
end;
function onSeated()
	u24 = "Seated";
end;
function onPlatformStanding()
	u24 = "PlatformStanding";
end;
function onSwimming(p30)
	if 1 < p30 then

	else
		playAnimation("swimidle", 0.4, l__Humanoid__2);
		u24 = "Standing";
		return;
	end;
	playAnimation("swim", 0.4, l__Humanoid__2);
	setAnimationSpeed(p30 / 10);
	u24 = "Swimming";
end;
local u26 = "None";
function animateTool()
	if u26 == "None" then
		playToolAnimation("toolnone", 0.1, l__Humanoid__2, Enum.AnimationPriority.Idle);
		return;
	end;
	if u26 == "Slash" then
		playToolAnimation("toolslash", 0, l__Humanoid__2, Enum.AnimationPriority.Action);
		return;
	end;
	if u26 == "Lunge" then

	else
		return;
	end;
	playToolAnimation("toollunge", 0, l__Humanoid__2, Enum.AnimationPriority.Action);
end;
function getToolAnim(p31)
	local v87, v88, v89 = ipairs(p31:GetChildren());
	while true do
		v87(v88, v89);
		if v87 then

		else
			break;
		end;
		v89 = v87;
		if v88.Name == "toolanim" then
			if v88.className == "StringValue" then
				return v88;
			end;
		end;	
	end;
	return nil;
end;
local u27 = 0;
local u28 = 0;
function stepAnimate(p32)
	u27 = p32;
	if 0 < u25 then
		u25 = u25 - (p32 - u27);
	end;
	if u24 == "FreeFall" then
		if u25 <= 0 then
			playAnimation("fall", 0.2, l__Humanoid__2);
		else
			if u24 == "Seated" then
				playAnimation("sit", 0.5, l__Humanoid__2);
				return;
			end;
			if u24 == "Running" then
				playAnimation("walk", 0.2, l__Humanoid__2);
			elseif u24 ~= "Dead" then
				if u24 ~= "GettingUp" then
					if u24 ~= "FallingDown" then
						if u24 ~= "Seated" then
							if u24 == "PlatformStanding" then
								stopAllAnimations();
							end;
						else
							stopAllAnimations();
						end;
					else
						stopAllAnimations();
					end;
				else
					stopAllAnimations();
				end;
			else
				stopAllAnimations();
			end;
		end;
	else
		if u24 == "Seated" then
			playAnimation("sit", 0.5, l__Humanoid__2);
			return;
		end;
		if u24 == "Running" then
			playAnimation("walk", 0.2, l__Humanoid__2);
		elseif u24 ~= "Dead" then
			if u24 ~= "GettingUp" then
				if u24 ~= "FallingDown" then
					if u24 ~= "Seated" then
						if u24 == "PlatformStanding" then
							stopAllAnimations();
						end;
					else
						stopAllAnimations();
					end;
				else
					stopAllAnimations();
				end;
			else
				stopAllAnimations();
			end;
		else
			stopAllAnimations();
		end;
	end;
	local v90 = l__Parent__1:FindFirstChildOfClass("Tool");
	if v90 then
		if v90:FindFirstChild("Handle") then

		else
			stopToolAnimations();
			u26 = "None";
			u21 = nil;
			u28 = 0;
			return;
		end;
	else
		stopToolAnimations();
		u26 = "None";
		u21 = nil;
		u28 = 0;
		return;
	end;
	local v91 = getToolAnim(v90);
	if v91 then
		u26 = v91.Value;
		v91.Parent = nil;
		u28 = p32 + 0.3;
	end;
	if u28 < p32 then
		u28 = 0;
		u26 = "None";
	end;
	animateTool();
end;
l__Humanoid__2.Died:connect(onDied);
l__Humanoid__2.Running:connect(onRunning);
l__Humanoid__2.Jumping:connect(onJumping);
l__Humanoid__2.Climbing:connect(onClimbing);
l__Humanoid__2.GettingUp:connect(onGettingUp);
l__Humanoid__2.FreeFalling:connect(onFreeFall);
l__Humanoid__2.FallingDown:connect(onFallingDown);
l__Humanoid__2.Seated:connect(onSeated);
l__Humanoid__2.PlatformStanding:connect(onPlatformStanding);
l__Humanoid__2.Swimming:connect(onSwimming);
game:GetService("Players").LocalPlayer.Chatted:connect(function(p33)
	local v92 = "";
	if string.sub(p33, 1, 3) == "/e " then
		v92 = string.sub(p33, 4);
	elseif string.sub(p33, 1, 7) == "/emote " then
		v92 = string.sub(p33, 8);
	end;
	if u24 == "Standing" and u10[v92] ~= nil then
		playAnimation(v92, 0.1, l__Humanoid__2);
	end;
end);
playAnimation("idle", 0.1, l__Humanoid__2);
u24 = "Standing";
while l__Parent__1.Parent ~= nil do
	local v93, v94 = wait(0.1);
	stepAnimate(v94);
end;
