-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_UserInputService_0 = game:GetService("UserInputService");
local l_HttpService_0 = game:GetService("HttpService");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local l_Debris_0 = game:GetService("Debris");
local l_Players_0 = game:GetService("Players");
local v7 = require(game.ReplicatedStorage.Modules.Misc.Maid);
local v8 = l_RunService_0:IsClient();
local v9 = l_RunService_0:IsServer();
local v10 = require(game.ReplicatedStorage.Initializer);
local v11 = require(game.ReplicatedStorage.Modules.Network);
local v12 = require(game.ReplicatedStorage.Modules.Sounds);
local v13 = {
	Head = true, 
	Torso = true, 
	["Left Arm"] = true, 
	["Left Leg"] = true, 
	["Right Arm"] = true, 
	["Right Leg"] = true
};
local v14 = PhysicalProperties.new(0.01, 0, 0, 0, 0);
local v15 = PhysicalProperties.new(0.7, 0.15, 0, 2, 2);
v0.KillerDistanceVector = Vector3.new(1, 4, 1, 0);
v0.RecursiveDestroy = function(_, v17) --[[ Line: 37 ]] --[[ Name: RecursiveDestroy ]]
	-- upvalues: v0 (copy)
	for _, v19 in pairs(v17) do
		if typeof(v19) == "table" then
			v0:RecursiveDestroy(v19);
		elseif typeof(v19) == "Instance" then
			v19:Destroy();
		end;
	end;
end;
v0.Lerp = function(_, v21, v22, v23) --[[ Line: 47 ]] --[[ Name: Lerp ]]
	return v21 + (v22 - v21) * v23;
end;
v0.SerializeVector = function(_, v25) --[[ Line: 51 ]] --[[ Name: SerializeVector ]]
	local v26 = buffer.create(12);
	local v27 = {
		v25.X, 
		v25.Y, 
		v25.Z
	};
	for v28, v29 in ipairs(v27) do
		buffer.writef32(v26, 4 * (v28 - 1), v29);
	end;
	return v26;
end;
v0.DeserializeVector = function(_, v31) --[[ Line: 64 ]] --[[ Name: DeserializeVector ]]
	local function _(v32) --[[ Line: 65 ]] --[[ Name: get ]]
		-- upvalues: v31 (copy)
		return (buffer.readf32(v31, 4 * (v32 - 1)));
	end;
	return (vector.create(buffer.readf32(v31, 0), buffer.readf32(v31, 4), (buffer.readf32(v31, 8))));
end;
v0.AddHitboxes = function(_, v35, v36) --[[ Line: 72 ]] --[[ Name: AddHitboxes ]]
	-- upvalues: v15 (copy)
	local v37 = typeof(v35) == "table" and v35.Config or {};
	local v38 = typeof(v35) == "table" and v35.Rig or v35;
	local v39 = {};
	assert(v38 and v38:IsA("Model"), "character must be a model");
	for _, v41 in ipairs({
		"CollisionHitbox", 
		"QueryHitbox"
		}) do
		while v38:FindFirstChild(v41) do
			v38[v41]:Destroy();
		end;
	end;
	local v42 = (v37.CollisionHitbox or game.ReplicatedStorage.Assets.Instances.CollisionHitbox):Clone();
	local v43 = v42:GetAttribute("CFrameOffset") or CFrame.new(0, 0.5, 0);
	v42.CFrame = v38.PrimaryPart.CFrame * v43;
	v42.Name = "CollisionHitbox";
	local v44 = (v37.QueryHitbox or game.ReplicatedStorage.Assets.Instances.QueryHitbox):Clone();
	local v45 = v42:GetAttribute("CFrameOffset") or CFrame.new(0, -0.25, 0);
	v44.CFrame = v38.PrimaryPart.CFrame * v45;
	v44.Name = "QueryHitbox";
	v44.CanQuery = true;
	v44:SetAttribute("CFOffset", v45);
	local v46 = v38:HasTag("Replicating") and game.Players:GetPlayerFromCharacter(v38);
	for _, v48 in pairs({
		v42, 
		v44
		}) do
		local v49 = false;
		if v48 == v44 then
			v49 = v46;
		end;
		local l_WeldConstraint_0 = Instance.new("WeldConstraint");
		l_WeldConstraint_0.Enabled = not v49;
		l_WeldConstraint_0.Name = "CollisionConnector";
		l_WeldConstraint_0.Parent = v48;
		l_WeldConstraint_0.Part1 = v48;
		l_WeldConstraint_0.Part0 = v38.PrimaryPart;
		v48.CollisionGroup = v36;
		v48.CustomPhysicalProperties = v15;
		v48.Anchored = v49;
		v48.Parent = v38;
		v39[v48.Name] = v48;
	end;
	return v39;
end;
v0.FixCharacter = function(_, v52, v53) --[[ Line: 122 ]] --[[ Name: FixCharacter ]]
	-- upvalues: v13 (copy), v15 (copy), v14 (copy)
	v53 = v53 or "Survivors";
	for _, v55 in ipairs(v52:GetDescendants()) do
		if not v55:GetAttribute("Hitbox") and v55:IsA("BasePart") and v55.CollisionGroup ~= "Ragdolls" then
			local v56 = v13[v55.Name] and v55.Parent == v52;
			v55.Anchored = false;
			v55.Massless = not v56 and v55 ~= v52.PrimaryPart;
			if v55 ~= v52.PrimaryPart then
				v55.CanCollide = false;
				v55.CanQuery = v56 or false;
				v55.CanTouch = v56 or false;
				v55.CustomPhysicalProperties = v56 and v15 or v14;
				v55.CollisionGroup = "None";
			else
				v55.CanCollide = true;
				v55.CanQuery = true;
				v55.CanTouch = true;
				v55.CustomPhysicalProperties = v15;
				v55.CollisionGroup = v53;
			end;
		end;
	end;
end;
v0.GetEntityType = function(_, v58) --[[ Line: 154 ]] --[[ Name: GetEntityType ]]
	if v58:GetAttribute("EntityType") then
		return v58:GetAttribute("EntityType");
	elseif v58:IsDescendantOf(workspace.Players) or v58:HasTag("SimulateSurvivor") then
		return true, "Humanoid";
	elseif v58:GetAttribute("OwnerName") then
		return false, "Building";
	else
		return false, "Entity";
	end;
end;
v0.SnapToAxis = function(_, v60) --[[ Line: 170 ]] --[[ Name: SnapToAxis ]]
	local v61 = math.abs(v60.X);
	local v62 = math.abs(v60.Y);
	local v63 = math.abs(v60.Z);
	if v62 < v61 and v63 < v61 then
		return (Vector3.new(math.sign(v60.X), 0, 0));
	elseif v61 < v62 and v63 < v62 then
		return (Vector3.new(0, math.sign(v60.Y), 0));
	else
		return (Vector3.new(0, 0, (math.sign(v60.Z))));
	end;
end;
v0.IsPlayerKiller = function(_, v65) --[[ Line: 184 ]] --[[ Name: IsPlayerKiller ]]
	local l_Character_0 = v65.Character;
	return l_Character_0 and l_Character_0.Parent and l_Character_0.Parent.Name == "Killers";
end;
v0.GetDistanceFromGround = function(_, v68) --[[ Line: 189 ]] --[[ Name: GetDistanceFromGround ]]
	local l_Humanoid_0 = v68:FindFirstChildOfClass("Humanoid");
	local v70 = v68 and v68.PrimaryPart;
	local v71 = l_Humanoid_0 and l_Humanoid_0.HipHeight or 2;
	local v72 = {
		v68:FindFirstChild("Left Leg"), 
		v68:FindFirstChild("Right Leg")
	};
	local function _(v73, v74, v75) --[[ Line: 195 ]] --[[ Name: absVector ]]
		return (Vector3.new(math.abs(v73), math.abs(v74), (math.abs(v75))));
	end;
	for _, v78 in v72 do
		if v78:IsA("Model") then
			v71 = math.max(v78:GetExtentsSize().Y, v71);
		elseif v78:IsA("BasePart") then
			local v79 = v78.CFrame:VectorToWorldSpace(v78.Size);
			local l_Z_0 = v79.Z;
			local l_Y_0 = v79.Y;
			local l_X_0 = v79.X;
			v79 = Vector3.new(math.abs(l_Z_0), math.abs(l_Y_0), (math.abs(l_X_0)));
			v79 = v78.CFrame:VectorToObjectSpace(v79);
			l_Z_0 = v79.X;
			l_Y_0 = v79.Y;
			l_X_0 = v79.Z;
			v71 = math.max(Vector3.new(math.abs(l_Z_0), math.abs(l_Y_0), (math.abs(l_X_0))).Y, v71);
		end;
	end;
	if v70 then
		v71 = v71 + v70.Size.Y / 2;
	end;
	return (math.clamp(v71, 2, 10));
end;
v0.IsAlive = function(_, v84) --[[ Line: 220 ]] --[[ Name: IsAlive ]]
	return v84 and v84.Parent and v84.PrimaryPart and v84:FindFirstChild("Humanoid") and v84.Humanoid.Health > 0;
end;
v0.EmitParticlesFromAttachment = function(_, v86) --[[ Line: 225 ]] --[[ Name: EmitParticlesFromAttachment ]]
	for _, v88 in pairs(v86:GetChildren()) do
		if v88:IsA("ParticleEmitter") then
			v88:Emit(v88:GetAttribute("EmitCount") or 1);
		end;
	end;
end;
v0.RemoveInstancesFromTableOfInstances = function(_, v90, v91) --[[ Line: 233 ]] --[[ Name: RemoveInstancesFromTableOfInstances ]]
	for v92, v93 in pairs(v90) do
		if v91[v93.Name] or v91[v93.ClassName] then
			table.remove(v90, v92);
		end;
	end;
	return v90;
end;
v0.DoFOVBop = function(_, v95, v96, v97, v98) --[[ Line: 243 ]] --[[ Name: DoFOVBop ]]
	-- upvalues: v0 (copy), l_HttpService_0 (copy), l_TweenService_0 (copy)
	local l_v0_FOVMultiplier_0 = v0:CreateFOVMultiplier(v95, v96, l_HttpService_0:GenerateGUID(false));
	local v100 = l_TweenService_0:Create(l_v0_FOVMultiplier_0, v98, {
		Value = v97
	});
	v100:Play();
	v100.Completed:Once(function(_) --[[ Line: 249 ]]
		-- upvalues: l_v0_FOVMultiplier_0 (copy)
		l_v0_FOVMultiplier_0:Destroy();
	end);
end;
v0.LoadAnimationFromID = function(_, v103, v104, v105) --[[ Line: 255 ]] --[[ Name: LoadAnimationFromID ]]
	if not v103 then
		warn(debug.traceback("no rig found while loading animation from ID!"));
		return;
	elseif not v104 then
		warn(debug.traceback("no ID found while loading animation onto rig!"));
		return;
	elseif typeof(v104) ~= "string" then
		return;
	else
		local l_v103_FirstChild_0 = v103:FindFirstChild("Animator", true);
		while not l_v103_FirstChild_0 do
			task.wait();
			l_v103_FirstChild_0 = v103:FindFirstChild("Animator", true);
		end;
		local l_v103_FirstChild_1 = v103:FindFirstChild(v104);
		if l_v103_FirstChild_1 then
			return l_v103_FirstChild_0:LoadAnimation(l_v103_FirstChild_1);
		else
			local l_Animation_0 = Instance.new("Animation");
			l_Animation_0.Name = v104;
			l_Animation_0.AnimationId = v104;
			l_Animation_0.Parent = v103;
			local v109 = l_v103_FirstChild_0:LoadAnimation(l_Animation_0);
			local v110 = 0;
			if v105 and v109.Length <= 0 then
				repeat
					v110 = v110 + task.wait();
				until v109.Length > 0 or v110 >= 25;
			end;
			return v109;
		end;
	end;
end;
v0.PlayDummyCutsceneAnimations = function(_, v112, v113, v114) --[[ Line: 289 ]] --[[ Name: PlayDummyCutsceneAnimations ]]
	-- upvalues: v0 (copy)
	local v115 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 5);
	local v116 = {};
	if v115 then
		local l_Dummies_0 = v115:FindFirstChild("Dummies");
		if not l_Dummies_0 then
			return;
		else
			for _, v119 in ipairs(l_Dummies_0:GetChildren()) do
				if v112.Config.Animations[v114][v119.Name .. "Rig"] then
					local v120 = v0:LoadAnimationFromID(v119, v112.Config.Animations[v114][v119.Name .. "Rig"]);
					v120:Play();
					v120.Stopped:Once(function() --[[ Line: 301 ]]
						-- upvalues: v119 (copy)
						for _, v122 in ipairs(v119:GetChildren()) do
							if v122:IsA("BasePart") then
								v122.Anchored = true;
							end;
						end;
					end);
					game.Debris:AddItem(v120, v113 + 3);
					v116[v119] = v120;
				end;
			end;
		end;
	end;
	return v116;
end;
v0.ApplyDamage = function(_, v124, v125) --[[ Line: 319 ]] --[[ Name: ApplyDamage ]]
	local v126 = require(game.ReplicatedStorage.Modules.AchievementUtil);
	local l_Humanoid_1 = v124:FindFirstChild("Humanoid");
	local v128 = tonumber(v125);
	if not v128 or not l_Humanoid_1 or l_Humanoid_1.Health <= 0 then
		return;
	elseif v124:GetAttribute("Invincible") then
		return;
	else
		local l_ResistanceMultipliers_0 = v124:FindFirstChild("ResistanceMultipliers");
		local v130 = 0;
		local l_pairs_0 = pairs;
		local v132 = l_ResistanceMultipliers_0 and l_ResistanceMultipliers_0:GetChildren() or {};
		for _, v134 in l_pairs_0(v132) do
			v130 = v130 + v134.Value;
		end;
		l_pairs_0 = v128 * (1 - math.min(v130, 100) / 100);
		v126:QueryAchievement("DusekkarUbercharge", nil, {
			RawDamage = v128, 
			RealDamage = l_pairs_0, 
			VictimCharacter = v124
		});
		v132 = require(game.ReplicatedStorage.Modules.Actors);
		local v135 = v132.CurrentActors[game.Players:GetPlayerFromCharacter(v124)];
		if v135 and v135.Behavior and v135.Behavior.OnHit then
			local v136 = {
				TimePast = 0
			};
			v135.Behavior:OnHit(v135, v136, l_pairs_0);
			if v136.TimePast ~= 0 then
				return;
			end;
		end;
		local l_l_Humanoid_1_Attribute_0 = l_Humanoid_1:GetAttribute("Overheal");
		if l_l_Humanoid_1_Attribute_0 then
			l_l_Humanoid_1_Attribute_0 = l_l_Humanoid_1_Attribute_0 - l_pairs_0;
			l_Humanoid_1:SetAttribute("Overheal", l_l_Humanoid_1_Attribute_0 > 0 and l_l_Humanoid_1_Attribute_0 or nil);
			if l_l_Humanoid_1_Attribute_0 < 0 then
				l_Humanoid_1.Health = l_Humanoid_1.Health - math.abs(l_l_Humanoid_1_Attribute_0);
			end;
		else
			l_Humanoid_1.Health = l_Humanoid_1.Health - l_pairs_0;
		end;
		if l_Humanoid_1.Health <= 0 and tostring(v124.Parent) == "Survivors" then
			local l_RoundManager_0 = game.ServerScriptService.Server.Systems.Core.RoundManager;
			local v139 = require(l_RoundManager_0);
			local v140 = require(l_RoundManager_0.Configuration);
			if v139.CurrentSession and v139.CurrentSession.TimePast then
				local l_CurrentSession_0 = v139.CurrentSession;
				l_CurrentSession_0.TimePast = l_CurrentSession_0.TimePast - (tonumber(v139.CurrentSession.Gamemode and v139.CurrentSession.Gamemode.TimeAddedOnKill) or 20);
			end;
			local v142 = tostring(v124:GetAttribute("RecentAttacker"));
			local v143 = tonumber(v124:GetAttribute("RecentAttackerTime")) or 0;
			local l_FirstChild_0 = game.Players:FindFirstChild(v142);
			if l_FirstChild_0 and v143 + 12.5 >= tick() then
				require(game.ReplicatedStorage.Modules.Stats):UpdatePlayerStat(l_FirstChild_0, "Kills", "Add", 1);
				v132:IncrementActorStats(l_FirstChild_0, {
					Action = "Killed a Survivor through damage over time", 
					Money = v140.KillerKillCurrency, 
					EXP = v140.KillerKillEXP
				});
			end;
		end;
		return;
	end;
end;
v0.Heal = function(_, v146, v147, _) --[[ Line: 390 ]] --[[ Name: Heal ]]
	local v149 = v146:GetAttribute("HardDamage") or 0;
	if v146.Health > v146.MaxHealth - v149 then
		return;
	else
		v146.Health = math.clamp(v146.Health + v147, 0, v146.MaxHealth - v149);
		return;
	end;
end;
v0.SpeedCaps = {};
v0.SetSpeedCap = function(_, v151, v152, v153, v154) --[[ Line: 399 ]] --[[ Name: SetSpeedCap ]]
	-- upvalues: v0 (copy)
	if game["Run Service"]:IsClient() then
		return;
	elseif not v152 then
		return;
	else
		local v155 = v151 and (v151:IsA("Model") and v151 or v151.Character);
		if not v155 then
			return;
		elseif v153 then
			if not v0.SpeedCaps[v155] then
				v0.SpeedCaps[v155] = {};
			end;
			v0.SpeedCaps[v155][v152] = {
				Value = v153, 
				ID = math.random(0, 1000000)
			};
			return;
		else
			if v0.SpeedCaps[v155] then
				if tonumber(v154) then
					local l_ID_0 = v0.SpeedCaps[v155].ID;
					task.delay(v154, function() --[[ Line: 418 ]]
						-- upvalues: v0 (ref), v155 (copy), l_ID_0 (copy), v152 (copy)
						if v0.SpeedCaps[v155] and v0.SpeedCaps[v155].ID == l_ID_0 then
							v0.SpeedCaps[v155][v152] = nil;
						end;
					end);
					return;
				else
					v0.SpeedCaps[v155][v152] = nil;
				end;
			end;
			return;
		end;
	end;
end;
local v157 = {};
v0.GiveStackableAttribute = function(_, v159, v160, v161, v162) --[[ Line: 434 ]] --[[ Name: GiveStackableAttribute ]]
	-- upvalues: v0 (copy), v157 (copy)
	if typeof(v159) == "Model" and (not v159 or not v0:IsAlive(v159)) then
		return;
	else
		local v163 = v161 or "Default";
		local v164 = v157[v159];
		if not v164 then
			v164 = {};
			v157[v159] = v164;
			v159.Destroying:Once(function() --[[ Line: 445 ]]
				-- upvalues: v157 (ref), v159 (copy)
				table.clear(v157[v159] or {});
				v157[v159] = nil;
			end);
		end;
		local v165 = v164[v160];
		if not v165 then
			v165 = {};
			v164[v160] = v165;
		end;
		local v166 = v159:GetAttribute(v160) or 0;
		local v167 = v165[v163];
		if v167 then
			if typeof(v167) == "thread" then
				pcall(task.cancel, v167);
			end;
			v166 = v166 - 1;
		end;
		v165[v163] = nil;
		v159:SetAttribute(v160, v166 + 1);
		if v162 then
			local v169 = task.delay(v162, function() --[[ Line: 477 ]]
				-- upvalues: v0 (ref), v159 (copy), v157 (ref), v165 (ref), v163 (copy), v160 (copy)
				if not v0:IsAlive(v159) then
					return;
				elseif not v157[v159] then
					return;
				else
					v165[v163] = nil;
					if not next(v165) then
						v159:SetAttribute(v160, nil);
						return;
					else
						local v168 = v159:GetAttribute(v160) or 0;
						v159:SetAttribute(v160, v168 - 1);
						return;
					end;
				end;
			end);
			v165[v163] = v169;
		else
			v165[v163] = true;
		end;
		return;
	end;
end;
v0.RemoveStackableAttribute = function(_, v171, v172, v173) --[[ Line: 495 ]] --[[ Name: RemoveStackableAttribute ]]
	-- upvalues: v0 (copy), v157 (copy)
	if typeof(v171) == "Model" and (not v171 or not v0:IsAlive(v171)) then
		return;
	else
		local v174 = v157[v171];
		if not v174 then
			return;
		else
			local v175 = v174[v172];
			if not v175 then
				return;
			elseif not v173 then
				for v176, v177 in pairs(v175) do
					if typeof(v177) == "thread" then
						pcall(task.cancel, v177);
					end;
					v175[v176] = nil;
				end;
				table.clear(v175 or {});
				v171:SetAttribute(v172, nil);
				return;
			else
				local v178 = v175[v173];
				if not v178 then
					return;
				else
					if typeof(v178) == "thread" then
						pcall(task.cancel, v178);
					end;
					v175[v173] = nil;
					if not next(v175) then
						v171:SetAttribute(v172, nil);
						return;
					else
						v171:SetAttribute(v172, (v171:GetAttribute(v172) or 0) - 1);
						return;
					end;
				end;
			end;
		end;
	end;
end;
v0.GiveInvincible = function(_, v180, v181, v182) --[[ Line: 540 ]] --[[ Name: GiveInvincible ]]
	-- upvalues: v0 (copy)
	v0:GiveStackableAttribute(v180, "Invincible", v181, v182);
end;
v0.RemoveInvincible = function(_, v184, v185) --[[ Line: 544 ]] --[[ Name: RemoveInvincible ]]
	-- upvalues: v0 (copy)
	v0:RemoveStackableAttribute(v184, "Invincible", v185);
end;
v0.CreateValueMultiplier = function(_, v187, v188, v189, v190, v191, v192) --[[ Line: 549 ]] --[[ Name: CreateValueMultiplier ]]
	-- upvalues: l_TweenService_0 (copy), l_Debris_0 (copy)
	local v193 = v187 and (v187:IsA("Model") and v187 or v187.Character);
	local v194 = v193 and v193:FindFirstChild((("%*Multipliers"):format(v188)));
	local v195 = v194 and v194:FindFirstChild((tostring(v190)));
	local l_NumberValue_0 = Instance.new("NumberValue");
	l_NumberValue_0.Value = v189 or 1;
	l_NumberValue_0.Name = v190 or ("%*Multiplier"):format(v188);
	l_NumberValue_0:SetAttribute("Tick", tick());
	l_NumberValue_0:SetAttribute("Duration", v191);
	l_NumberValue_0.Parent = v194;
	if v191 then
		if v192 then
			task.delay(v191 - 0.3, function() --[[ Line: 559 ]]
				-- upvalues: l_TweenService_0 (ref), l_NumberValue_0 (copy)
				l_TweenService_0:Create(l_NumberValue_0, TweenInfo.new(0.3), {
					Value = 1
				}):Play();
			end);
		end;
		l_Debris_0:AddItem(l_NumberValue_0, v191);
	end;
	if v195 then
		v195:Destroy();
	end;
	return l_NumberValue_0;
end;
v0.CreateSpeedMultiplier = function(_, v198, v199, v200, v201, v202) --[[ Line: 565 ]] --[[ Name: CreateSpeedMultiplier ]]
	-- upvalues: v0 (copy)
	return v0:CreateValueMultiplier(v198, "Speed", v199, v200, v201, v202);
end;
v0.CreateFOVMultiplier = function(_, v204, v205, v206, v207, v208) --[[ Line: 570 ]] --[[ Name: CreateFOVMultiplier ]]
	-- upvalues: v0 (copy)
	return v0:CreateValueMultiplier(v204, "FOV", v205, v206, v207, v208);
end;
v0.CreateResistanceMultiplier = function(_, v210, v211, v212, v213, v214) --[[ Line: 575 ]] --[[ Name: CreateResistanceMultiplier ]]
	-- upvalues: v0 (copy)
	return v0:CreateValueMultiplier(v210, "Resistance", v211, v212, v213, v214);
end;
v0.GetSettingValue = function(_, v216, v217) --[[ Line: 580 ]] --[[ Name: GetSettingValue ]]
	-- upvalues: v8 (copy)
	if not v217 then
		v217 = v8 and game.Players.LocalPlayer;
	end;
	if v217 then
		local l_FirstChild_1 = v217.PlayerData.Settings:FindFirstChild(v216, true);
		if l_FirstChild_1 then
			return l_FirstChild_1.Value;
		end;
	end;
end;
v0.ApplyOverheal = function(_, v220, v221, v222) --[[ Line: 589 ]] --[[ Name: ApplyOverheal ]]
	local v223 = v220 and (v220:IsA("Model") and v220 or v220.Character);
	local v224 = v223 and v223:FindFirstChild("Humanoid");
	if not v224 then
		return;
	elseif not tonumber(v221) then
		return;
	elseif v221 <= 0 then
		v224:SetAttribute("Overheal", nil);
		v224:SetAttribute("DrainingID", nil);
		return;
	else
		v224:SetAttribute("Overheal", v221);
		if v222 then
			local v225 = math.random(-10000000, 10000000);
			v224:SetAttribute("DrainingID", v225);
			task.spawn(function() --[[ Line: 613 ]]
				-- upvalues: v224 (copy), v225 (copy)
				while v224.Parent and v224.Health > 0 and v225 == v224:GetAttribute("DrainingID") do
					local v226 = task.wait();
					local l_v224_Attribute_0 = v224:GetAttribute("Overheal");
					if l_v224_Attribute_0 then
						local v228 = l_v224_Attribute_0 - 2 * v226;
						if v228 > 0 then
							v224:SetAttribute("Overheal", v228);
						else
							break;
						end;
					else
						break;
					end;
				end;
				if v225 == v224:GetAttribute("DrainingID") then
					v224:SetAttribute("Overheal", nil);
					v224:SetAttribute("DrainingID", nil);
				end;
			end);
		end;
		return;
	end;
end;
v0.GetPlayerMousePosition = function(_, v230, v231) --[[ Line: 637 ]] --[[ Name: GetPlayerMousePosition ]]
	-- upvalues: v10 (copy)
	if game["Run Service"]:IsServer() then
		return (v10.Modules.Network:FireClientConnection(v230, "GetMousePosition", "REMOTE_FUNCTION", v231));
	elseif game["Run Service"]:IsClient() then
		return require(game.ReplicatedStorage.Systems.Player.Miscellaneous.GetPlayerMousePosition):GetMousePos(v231);
	else
		return;
	end;
end;
v0.GetActor = function(_, v233) --[[ Line: 647 ]] --[[ Name: GetActor ]]
	return require(game.ReplicatedStorage.Modules.Actors).CurrentActors[game.Players:GetPlayerFromCharacter(v233)];
end;
v0.SetUpCutscene = function(_, v235, v236, v237) --[[ Line: 652 ]] --[[ Name: SetUpCutscene ]]
	-- upvalues: v0 (copy)
	local v238 = v0:GetActor(v235) or v235;
	local v239 = v0:GetActor(v236) or v236;
	local l_PrimaryPart_0 = v236.PrimaryPart;
	local l_PrimaryPart_1 = v235.PrimaryPart;
	local v242 = typeof(v238) == "table" and v238:GetPivot().Position or l_PrimaryPart_1.Position;
	local v243 = typeof(v239) == "table" and v239:GetPivot().Position or l_PrimaryPart_0.Position;
	local v244 = CFrame.new(v242, (Vector3.new(v243.X, v242.Y, v243.Z)));
	if v244 ~= v244 then
		v244 = l_PrimaryPart_1.CFrame;
	end;
	v238:PivotTo(v244);
	v239:PivotTo(l_PrimaryPart_1.CFrame * (v237 or CFrame.new()));
	v235.PrimaryPart.Anchored = true;
	v236.PrimaryPart.Anchored = true;
end;
v0.RagdollLaunch = function(_, v246, v247, v248) --[[ Line: 674 ]] --[[ Name: RagdollLaunch ]]
	local v249 = RaycastParams.new();
	v249.FilterDescendantsInstances = workspace.Players:GetDescendants();
	v249.FilterType = Enum.RaycastFilterType.Exclude;
	local v250 = v246.Rig.PrimaryPart.Size.X / 2;
	local l_Magnitude_0 = v248.Magnitude;
	local v252 = l_Magnitude_0 / 10;
	local v253 = workspace:Raycast(v247.PrimaryPart.Position, v248.Unit * v252, v249);
	local v254 = v253 and v253.Distance or v252;
	local v255 = v248 * game.TweenService:GetValue(v254 / v252, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
	v247:SetPrimaryPartCFrame(CFrame.new(v246.Rig.PrimaryPart.Position + v248.Unit * v250));
	v247.PrimaryPart.Anchored = false;
	v247.PrimaryPart.AssemblyLinearVelocity = v255;
	local v256 = require(game.ReplicatedStorage.Modules.Ragdolls);
	v256.AddProfile(v247, {
		Velocity = v255
	});
	v256.EnableRagdoll(v247, (math.clamp(l_Magnitude_0 / 80, 0.5, 5)));
end;
v0.SelectRandomKillers = function(_, v258, v259) --[[ Line: 700 ]] --[[ Name: SelectRandomKillers ]]
	-- upvalues: v0 (copy)
	local v260 = {};
	local v261 = {};
	for _, v263 in pairs(v258) do
		local v264 = v263.Instance and v263.Instance:FindFirstChild("PlayerData");
		local v265 = v264 and v264:FindFirstChild("Stats");
		local v266 = v265 and v265:FindFirstChild("KillerChance", true);
		if v266 then
			v263.KillerChance = v266;
			table.insert(v261, v263);
		end;
	end;
	local v267 = workspace:GetAttribute("ServerType") == "VIP";
	if v267 then
		v0:ShuffleTable(v261);
	else
		table.sort(v261, function(v268, v269) --[[ Line: 724 ]]
			return v268.KillerChance.Value > v269.KillerChance.Value;
		end);
	end;
	local v270 = math.clamp(#v258 - 1, workspace:GetAttribute("ForcedKiller") and 1 or 0, 1e999);
	if v270 >= 1 then
		for _ = 1, math.clamp(v259, 1, v270) do
			local v272 = nil;
			local v273 = nil;
			local l_workspace_Attribute_0 = workspace:GetAttribute("ForcedKiller");
			workspace:SetAttribute("ForcedKiller", nil);
			if l_workspace_Attribute_0 then
				for v275, v276 in pairs(v261) do
					if tostring(v276.Instance) == l_workspace_Attribute_0 then
						v272 = v276;
						v273 = v275;
					end;
				end;
			end;
			if not v272 then
				v272 = v261[1];
				v273 = 1;
			end;
			if v272 and v273 then
				if not v267 then
					v272.KillerChance.Value = 1;
				end;
				table.insert(v260, v272);
				table.remove(v261, v273);
			end;
		end;
	end;
	if not v267 then
		for _, v278 in pairs(v261) do
			v0:AddToPlayerStat(v278.Instance, "KillerChance", 1);
		end;
	end;
	return v260, v261;
end;
v0.PreloadAssets = function(_, v280) --[[ Line: 796 ]] --[[ Name: PreloadAssets ]]
	-- upvalues: v8 (copy)
	task.spawn(function() --[[ Line: 797 ]]
		-- upvalues: v8 (ref), v280 (copy)
		local v281 = {};
		local function v282(v283) --[[ Line: 799 ]] --[[ Name: fetchAssets ]]
			-- upvalues: v282 (copy), v8 (ref), v281 (copy)
			for v284, v285 in pairs(v283) do
				if typeof(v285) == "table" then
					v282(v285);
				elseif typeof(v285) == "string" and v285:find("rbxassetid://") then
					if v284 == "Sounds" and v8 then
						local l_Sound_0 = Instance.new("Sound");
						l_Sound_0.Parent = workspace:FindFirstChild("Sounds");
						l_Sound_0.SoundId = v285;
						l_Sound_0.Volume = 0;
						l_Sound_0:Play();
						game.Debris:AddItem(l_Sound_0, 1);
					end;
					table.insert(v281, v285);
				end;
			end;
		end;
		v282(v280);
		game.ContentProvider:PreloadAsync(v281);
	end);
end;
v0.ToggleLockForAbilityIcon = function(_, v288, v289, v290) --[[ Line: 822 ]] --[[ Name: ToggleLockForAbilityIcon ]]
	local l_AbilityContainer_0 = game.Players.LocalPlayer.PlayerGui.MainUI:FindFirstChild("AbilityContainer");
	local v292 = l_AbilityContainer_0 and l_AbilityContainer_0:FindFirstChild((tostring(v288)));
	if not v292 then
		return;
	else
		local function _(v293) --[[ Line: 830 ]] --[[ Name: setAbilityIconTitleTransparencies ]]
			-- upvalues: v292 (copy)
			local l_Clipping_0 = v292:FindFirstChild("Clipping");
			local l_CooldownTime_0 = v292:FindFirstChild("CooldownTime");
			if l_Clipping_0 then
				l_Clipping_0.Visible = v293;
			end;
			if l_CooldownTime_0 then
				l_CooldownTime_0.Visible = v293;
			end;
		end;
		if v290 and not v292:FindFirstChild(v289) then
			local v297 = script.AbilityLock:Clone();
			v297.Name = v289;
			v297.Parent = v292;
			local l_Clipping_1 = v292:FindFirstChild("Clipping");
			local l_CooldownTime_1 = v292:FindFirstChild("CooldownTime");
			if l_Clipping_1 then
				l_Clipping_1.Visible = false;
			end;
			if l_CooldownTime_1 then
				l_CooldownTime_1.Visible = false;
				return;
			end;
		elseif not v290 then
			local l_Clipping_2 = v292:FindFirstChild("Clipping");
			local l_CooldownTime_2 = v292:FindFirstChild("CooldownTime");
			if l_Clipping_2 then
				l_Clipping_2.Visible = true;
			end;
			if l_CooldownTime_2 then
				l_CooldownTime_2.Visible = true;
			end;
			l_Clipping_2 = v292:FindFirstChild(v289);
			if l_Clipping_2 then
				l_Clipping_2:Destroy();
			end;
		end;
		return;
	end;
end;
v0.ToggleLocksForAbilityIcons = function(_, v303, v304) --[[ Line: 857 ]] --[[ Name: ToggleLocksForAbilityIcons ]]
	-- upvalues: v0 (copy)
	local l_AbilityContainer_1 = game.Players.LocalPlayer.PlayerGui.MainUI:FindFirstChild("AbilityContainer");
	local v306 = l_AbilityContainer_1 and l_AbilityContainer_1:GetChildren() or {};
	for _, v308 in pairs(v306) do
		if v308:IsA("GuiObject") then
			v0:ToggleLockForAbilityIcon(v308.Name, v303, v304);
		end;
	end;
end;
local v309 = nil;
v0.CreateDisplayUI = function(_, v311) --[[ Line: 871 ]] --[[ Name: CreateDisplayUI ]]
	-- upvalues: v309 (ref), l_TweenService_0 (copy), l_Debris_0 (copy)
	if not v309 then
		v309 = Instance.new("ScreenGui");
		v309.Name = "KillerIntroUI";
		v309.DisplayOrder = 10;
		v309.ResetOnSpawn = false;
		v309.Parent = game.Players.LocalPlayer.PlayerGui;
	end;
	local v312 = {};
	local l_KillerDisplays_0 = game.ReplicatedStorage.Assets.UI.KillerDisplays;
	local v314 = l_KillerDisplays_0.KillerDisplayBackground:Clone();
	v314.Parent = v309;
	v314.ImageTransparency = 1;
	v314.Title.TextTransparency = 1;
	v314.Title.Text = #v311 > 1 and "This round's killers are..." or "This round's killer is...";
	l_TweenService_0:Create(v314, TweenInfo.new(0.2), {
		ImageTransparency = 0
	}):Play();
	l_TweenService_0:Create(v314.Title, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
		TextTransparency = 0
	}):Play();
	table.insert(v312, v314);
	table.insert(v312, v314.Title);
	task.delay(0.65, function() --[[ Line: 894 ]]
		-- upvalues: v311 (copy), l_KillerDisplays_0 (copy), v314 (copy), l_TweenService_0 (ref), v312 (copy)
		for v315, v316 in pairs(v311) do
			local v317 = l_KillerDisplays_0.Display:Clone();
			v317.Parent = v314.Displays;
			v317.LayoutOrder = v315;
			v317.KillerName.Text = v316.KillerName;
			v317.PlayerName.Text = ("(%*)"):format(v316.PlayerName);
			v317.KillerName.TextTransparency = 1;
			v317.PlayerName.TextTransparency = 1;
			l_TweenService_0:Create(v317.KillerName, TweenInfo.new(0.2), {
				TextTransparency = 0
			}):Play();
			l_TweenService_0:Create(v317.PlayerName, TweenInfo.new(0.2), {
				TextTransparency = 0.6
			}):Play();
			table.insert(v312, v317.KillerName);
			table.insert(v312, v317.PlayerName);
			if v315 ~= #v311 then
				local v318 = l_KillerDisplays_0.Separator:Clone();
				v318.Parent = v314.Displays;
				v318.LayoutOrder = v315;
				v318.TextTransparency = 1;
				l_TweenService_0:Create(v318, TweenInfo.new(0.2), {
					TextTransparency = 0
				}):Play();
				table.insert(v312, v318);
			end;
		end;
	end);
	task.delay(5, function() --[[ Line: 920 ]]
		-- upvalues: v312 (copy), l_Debris_0 (ref), l_TweenService_0 (ref)
		for _, v320 in pairs(v312) do
			l_Debris_0:AddItem(v320, 0.5);
			if v320:IsA("TextLabel") then
				l_TweenService_0:Create(v320, TweenInfo.new(0.5), {
					TextTransparency = 1
				}):Play();
			elseif v320:IsA("ImageLabel") then
				l_TweenService_0:Create(v320, TweenInfo.new(0.5), {
					ImageTransparency = 1
				}):Play();
			end;
		end;
	end);
end;
local v321 = nil;
v0.CreateTooltip = function(_, v323) --[[ Line: 935 ]] --[[ Name: CreateTooltip ]]
	-- upvalues: v321 (ref), v12 (copy), l_UserInputService_0 (copy)
	local l_LocalPlayer_0 = game.Players.LocalPlayer;
	if v321 and (v321.Title.Text ~= tostring(v323) or not v321.Parent) then
		if v321.Parent then
			game.TweenService:Create(v321.Title, TweenInfo.new(0.15), {
				TextSize = 0, 
				TextTransparency = 1
			}):Play();
			game.TweenService:Create(v321.Background, TweenInfo.new(0.15), {
				Size = UDim2.fromScale(), 
				ImageTransparency = 1
			}):Play();
			game.Debris:AddItem(v321, 0.15);
			v12:Play("hoverEnd");
		end;
		v321 = nil;
	elseif not v321 and v323 then
		local v325 = l_UserInputService_0:GetMouseLocation() - game.GuiService:GetGuiInset();
		v321 = script.Tooltip:Clone();
		v321.Title.Text = v323;
		v321.Title.Position = UDim2.fromOffset(v325.X, v325.Y + -28);
		v321.Background.Position = UDim2.fromOffset(v325.X, v325.Y + -28 - v321.Title.AbsoluteSize.Y / 2);
		v321.Background.Size = UDim2.fromOffset(v321.Title.AbsoluteSize.X + 64, v321.Title.AbsoluteSize.Y + 50);
		v321.Parent = l_LocalPlayer_0.PlayerGui:FindFirstChild("MainUI");
		v12:Play("hover");
		task.spawn(function() --[[ Line: 958 ]]
			-- upvalues: v321 (ref), l_UserInputService_0 (ref)
			while v321 and v321.Parent do
				local v326 = l_UserInputService_0:GetMouseLocation() - game.GuiService:GetGuiInset();
				v321.Title.Position = UDim2.fromOffset(v326.X, v326.Y + -28);
				v321.Background.Position = UDim2.fromOffset(v326.X, v326.Y + -28 - v321.Title.AbsoluteSize.Y / 2);
				v321.Background.Size = UDim2.fromOffset(v321.Title.AbsoluteSize.X + 64, v321.Title.AbsoluteSize.Y + 50);
				task.wait();
			end;
		end);
	end;
	return v321;
end;
v0.AddToPlayerStat = function(_, v328, v329, v330, v331) --[[ Line: 972 ]] --[[ Name: AddToPlayerStat ]]
	-- upvalues: v0 (copy)
	if workspace:GetAttribute("ServerType") == "VIP" and v331 ~= true then
		return;
	else
		local v332 = false;
		if typeof(v328) == "Instance" then
			v332 = v328:FindFirstChild("PlayerData");
		end;
		local v333 = v332 and v332.Stats:FindFirstChild(tostring(v329), true);
		if v333 and v333:IsA("NumberValue") then
			if v329 == "KillerChance" and not v331 and v332.Settings.Game.MaliceDisabled.Value then
				return;
			else
				if v329 == "Money" or v329 == "KillerChance" or v329 == "EXPBoostTime" then
					game.AnalyticsService:LogEconomyEvent(v328, Enum.AnalyticsEconomyFlowType.Source, v329, tonumber(v330) or 0, v333.Value + (tonumber(v330) or 0), Enum.AnalyticsEconomyTransactionType.Gameplay.Name);
				end;
				v333.Value = v333.Value + (tonumber(v330) or 0);
				if v329 == "Money" then
					v0:AddToPlayerStat(v328, "NetWorth", v330);
				end;
			end;
		end;
		return;
	end;
end;
v0.CopyTable = function(_, v335) --[[ Line: 1005 ]] --[[ Name: CopyTable ]]
	-- upvalues: v0 (copy)
	local v336 = {};
	for v337, v338 in pairs(v335) do
		if typeof(v338) == "table" then
			v336[v337] = v0:CopyTable(v338);
		else
			v336[v337] = v338;
		end;
	end;
	return v336;
end;
v0.JoinTables = function(_, ...) --[[ Line: 1018 ]] --[[ Name: JoinTables ]]
	local v340 = {};
	for _, v342 in ipairs(table.pack(...)) do
		for _, v344 in pairs(v342) do
			table.insert(v340, v344);
		end;
	end;
	return v340;
end;
v0.MergeTables = function(_, v346, v347, v348) --[[ Line: 1031 ]] --[[ Name: MergeTables ]]
	-- upvalues: v0 (copy)
	if not v347 then
		return v346;
	else
		local v349 = {
			Voicelines = true, 
			Emotes = true, 
			TerrorRadiusThemes = true
		};
		local v350 = {};
		local l_pairs_1 = pairs;
		local v352 = v346 or {};
		for v353, v354 in l_pairs_1(v352) do
			if typeof(v354) == "table" and typeof(v347[v353]) == "table" then
				v350[v353] = v0:MergeTables(v354, v347[v353], v348);
			else
				v350[v353] = v354;
			end;
		end;
		l_pairs_1 = pairs;
		v352 = v347 or {};
		for v355, v356 in l_pairs_1(v352) do
			if typeof(v356) == "table" and typeof(v346[v355]) == "table" and not v349[v355] then
				v350[v355] = v0:MergeTables(v346[v355], v356, v348);
			elseif not table.find(v348 or {}, v355) then
				v350[v355] = v356;
			end;
		end;
		return v350;
	end;
end;
v0.ShuffleTable = function(_, v358) --[[ Line: 1064 ]] --[[ Name: ShuffleTable ]]
	local v359 = nil;
	local v360 = nil;
	for v361 = #v358, 1, -1 do
		v359 = math.random(v361);
		v360 = v358[v361];
		v358[v361] = v358[v359];
		v358[v359] = v360;
	end;
	return v358;
end;
v0.ToCommas = function(_, v363) --[[ Line: 1076 ]] --[[ Name: ToCommas ]]
	return tostring(v363):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "");
end;
v0.ConvertToAbbreviation = function(_, v365) --[[ Line: 1086 ]] --[[ Name: ConvertToAbbreviation ]]
	local function v367(v366) --[[ Line: 1087 ]] --[[ Name: formatNumber ]]
		if v366 % 1 == 0 then
			return string.format("%.0f", v366);
		elseif v366 * 10 % 1 == 0 then
			return string.format("%.1f", v366);
		else
			return string.format("%.2f", v366);
		end;
	end;
	if v365 >= 1000000000000000 then
		return v367(v365 / 1000000000000000) .. "Q+";
	elseif v365 >= 1000000000000 then
		return v367(v365 / 1000000000000) .. "T+";
	elseif v365 >= 1000000000 then
		return v367(v365 / 1000000000) .. "B+";
	elseif v365 >= 1000000 then
		return v367(v365 / 1000000) .. "M+";
	elseif v365 >= 1000 then
		return v367(v365 / 1000) .. "K+";
	else
		return (tostring(v365));
	end;
end;
v0.CalculateLevelFromEXP = function(_, v369) --[[ Line: 1113 ]] --[[ Name: CalculateLevelFromEXP ]]
	local v370 = 1;
	local v371 = 100;
	local l_v369_0 = v369;
	while v371 <= l_v369_0 do
		l_v369_0 = l_v369_0 - v371;
		v370 = v370 + 1;
		v371 = math.round(v370 * 10 + 100);
	end;
	return v370, l_v369_0, v371;
end;
v0.FormatTime = function(_, v374, v375) --[[ Line: 1144 ]] --[[ Name: FormatTime ]]
	-- upvalues: v10 (copy)
	if not v374 then
		v10.Debug("can't format time due to seconds being nil!");
		return "";
	elseif not v375 then
		v10.Debug("can't format time due to formatType being nil!");
		return "";
	else
		local v376 = math.floor(v374 / 86400);
		local v377 = math.floor(v374 % 86400 / 3600);
		local v378 = math.floor(v374 % 3600 / 60);
		local v379 = v374 % 60;
		local v380 = "";
		if v375 == "Clock" then
			if v376 > 0 then
				return (string.format("%d:%02d:%02d:%02d", v376, v377, v378, v379));
			elseif v377 > 0 then
				return (string.format("%02d:%02d:%02d", v377, v378, v379));
			else
				return (string.format("%02d:%02d", v378, v379));
			end;
		else
			if v375 == "String" then
				if v376 > 0 then
					v380 = ("%*%*%*"):format(v380, v376, v376 == 1 and " day" or " days");
				end;
				if v377 > 0 then
					if v380 ~= "" then
						v380 = ("%*%*"):format(v380, (not (not (v376 > 0) or v378 <= 0) or v379 > 0) and ", " or " and ");
					end;
					v380 = ("%*%*%*"):format(v380, v377, v377 == 1 and " hour" or " hours");
				end;
				if v378 > 0 then
					if v380 ~= "" then
						v380 = ("%*%*"):format(v380, (not (v376 <= 0) or v377 > 0) and v379 > 0 and ", " or " and ");
					end;
					v380 = ("%*%*%*"):format(v380, v378, v378 == 1 and " minute" or " minutes");
				end;
				if v379 > 0 then
					if v380 ~= "" then
						v380 = ("%*%*"):format(v380, (not (v376 <= 0 and v377 <= 0) or v378 > 0) and " and " or "");
					end;
					v380 = ("%*%*%*"):format(v380, v379, v379 == 1 and " second" or " seconds");
				end;
			end;
			return v380;
		end;
	end;
end;
v0.IntToRoman = function(_, v382) --[[ Line: 1195 ]] --[[ Name: IntToRoman ]]
	if not tonumber(v382) then
		return "IDK";
	else
		v382 = math.round((tonumber(v382)));
		local v383 = {
			{
				1000, 
				"M"
			}, 
			{
				900, 
				"CM"
			}, 
			{
				500, 
				"D"
			}, 
			{
				400, 
				"CD"
			}, 
			{
				100, 
				"C"
			}, 
			{
				90, 
				"XC"
			}, 
			{
				50, 
				"L"
			}, 
			{
				40, 
				"XL"
			}, 
			{
				10, 
				"X"
			}, 
			{
				9, 
				"IX"
			}, 
			{
				5, 
				"V"
			}, 
			{
				4, 
				"IV"
			}, 
			{
				1, 
				"I"
			}
		};
		local v384 = "";
		for _, v386 in pairs(v383) do
			while v386[1] <= v382 do
				v384 = v384 .. v386[2];
				v382 = v382 - v386[1];
			end;
		end;
		return v384;
	end;
end;
v0.ApplyCameraShake = function(_, v388, v389) --[[ Line: 1228 ]] --[[ Name: ApplyCameraShake ]]
	if not game.Players.LocalPlayer.PlayerData.Settings.Customization.ScreenShakeEnabled.Value then
		return;
	else
		local v390 = tick();
		local v391 = nil;
		v391 = game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 1238 ]]
			-- upvalues: v390 (copy), v389 (copy), v388 (copy), v391 (ref)
			local v392 = math.clamp((tick() - v390) / v389, 0, 1);
			local v393 = v388 * (1 - v392);
			local v394 = Vector3.new((math.random() - 0.5) * 2 * v393, (math.random() - 0.5) * 2 * v393, (math.random() - 0.5) * 2 * v393);
			local l_CurrentCamera_0 = workspace.CurrentCamera;
			l_CurrentCamera_0.CFrame = l_CurrentCamera_0.CFrame * CFrame.new(v394);
			if v392 >= 1 then
				v391:Disconnect();
				v391 = nil;
				return;
			else
				return;
			end;
		end);
		return;
	end;
end;
v0.ApplyCameraShakeTo = function(_, v397, v398, v399) --[[ Line: 1266 ]] --[[ Name: ApplyCameraShakeTo ]]
	-- upvalues: v9 (copy), v11 (copy)
	if not v9 then
		return;
	else
		v11:FireClientConnection(v397, "ShakeCamera", "REMOTE_EVENT", v398, v399);
		return;
	end;
end;
v0.RemoveCyclicReferences = function(_, v401, v402) --[[ Line: 1271 ]] --[[ Name: RemoveCyclicReferences ]]
	-- upvalues: v0 (copy)
	v402 = v402 or {};
	local v403 = {};
	for v404 in pairs(v401) do
		if not table.find(v402, v401[v404]) then
			if typeof(v401[v404]) ~= "table" then
				v403[v404] = v401[v404];
			else
				table.insert(v402, v401[v404]);
				v403[v404] = v401[v404];
				local v405 = v0:RemoveCyclicReferences(v401[v404], v402);
				for v406 in pairs(v403[v404]) do
					if not v405[v406] then
						v403[v404][v406] = nil;
					end;
				end;
			end;
		end;
	end;
	return v403;
end;
v0.IsOnScreen = function(_, v408, v409) --[[ Line: 1295 ]] --[[ Name: IsOnScreen ]]
	-- upvalues: v13 (copy)
	local v410 = false;
	if typeof(v408) ~= "Instance" then
		return;
	else
		local _ = tick();
		local l_Character_1 = game.Players.LocalPlayer.Character;
		local v413 = false;
		local v414 = require(game.ReplicatedStorage.Systems.Player.Miscellaneous.GetPlayerMousePosition);
		local v415 = {};
		table.insert(v415, v408);
		table.insert(v415, l_Character_1);
		table.insert(v415, workspace.CurrentCamera);
		for v416, _ in pairs(v414.TransparentParts) do
			table.insert(v415, v416);
		end;
		local function v421(v418) --[[ Line: 1316 ]] --[[ Name: checkForVisibility ]]
			-- upvalues: v415 (copy)
			local _, v420 = workspace.CurrentCamera:WorldToViewportPoint(v418.Position);
			if v420 and #workspace.CurrentCamera:GetPartsObscuringTarget({
				workspace.CurrentCamera.CFrame.Position, 
				v418.Position
				}, v415) == 0 then
				return true;
			else
				return;
			end;
		end;
		if v408:IsA("Model") then
			local l_Humanoid_2 = v408:FindFirstChild("Humanoid");
			for _, v424 in pairs(v408:GetChildren()) do
				if v424:IsA("BasePart") and ((if l_Humanoid_2 then v424.Parent == v408 and (v13[v424.Name] and true or false) else false) or v424.Transparency ~= 1 or v409) then
					v413 = v421(v424);
					v410 = v413;
				end;
				if v410 then
					break;
				end;
			end;
			if not v410 then
				return v413;
			end;
		elseif v408:IsA("BasePart") and (v408.Transparency ~= 1 or v409) then
			v413 = v421(v408);
		end;
		v410 = false;
		return v413;
	end;
end;
v0.CreateProgressBar = function(_, v426, v427) --[[ Line: 1347 ]] --[[ Name: CreateProgressBar ]]
	v426 = v426 or "Performing Action";
	v427 = tonumber(v427) or 5;
	local l_LocalPlayer_1 = game.Players.LocalPlayer;
	local v429 = game.ReplicatedStorage.Assets.UI.ProgressBar:Clone();
	v429.Title.Text = ("%*."):format(v426);
	v429.Parent = l_LocalPlayer_1.PlayerGui:FindFirstChild("TemporaryUI");
	game.Debris:AddItem(v429, v427);
	task.spawn(function() --[[ Line: 1357 ]]
		-- upvalues: v429 (copy), v427 (ref), v426 (ref)
		local v430 = 0;
		local v431 = 0;
		local v432 = 0;
		while v429.Parent do
			local v433 = v430 / v427;
			local v434 = v433 == 0 and 0 or 1 / v433;
			v429.Bar.Clipping.Size = UDim2.fromScale(v433, 1);
			v429.Bar.Clipping.Top.Size = UDim2.fromScale(v434, 1);
			if v431 >= 0.3 then
				v431 = 0;
				v432 = v432 + 1;
				v429.Title.Text = ("%*%*"):format(v426, (string.rep(".", v432 % 3 + 1)));
			end;
			local v435 = game["Run Service"].Heartbeat:Wait();
			v430 = math.clamp(v430 + v435, 0, v427);
			v431 = v431 + v435;
		end;
	end);
	return v429;
end;
local v436 = nil;
local v437 = nil;
v0.FadeIn = function(_, v439) --[[ Line: 1390 ]] --[[ Name: FadeIn ]]
	-- upvalues: v437 (ref), v10 (copy), v436 (ref), l_TweenService_0 (copy)
	if not v439 then
		v439 = {};
	end;
	if v437 and v437.Parent then
		v10.Debug("FadeIn cancelled b/c there's already a fade that exists!");
		return;
	else
		if not v436 then
			v436 = Instance.new("ScreenGui");
			v436.Name = "FadeUI";
			v436.IgnoreGuiInset = true;
			v436.ResetOnSpawn = false;
			v436.DisplayOrder = 10;
			v436.Parent = v10.Player.PlayerGui;
		end;
		v437 = Instance.new("Frame");
		v437.Name = "Fade";
		v437.BackgroundTransparency = v439.StartTransparency or 1;
		v437.BackgroundColor3 = v439.Color or Color3.new();
		v437.Size = UDim2.fromScale(1, 1);
		v437.Parent = v436;
		if v439.InstantTween then
			v437.BackgroundTransparency = v439.EndTransparency or 0;
			return;
		else
			local v440 = l_TweenService_0:Create(v437, v439.TweenInfo or TweenInfo.new(v439.Time or 0.325, Enum.EasingStyle.Linear), {
				BackgroundTransparency = v439.EndTransparency or 0
			});
			v440:Play();
			if v439.Yield then
				v440.Completed:Wait();
			end;
			return;
		end;
	end;
end;
v0.FadeOut = function(_, v442) --[[ Line: 1428 ]] --[[ Name: FadeOut ]]
	-- upvalues: v437 (ref), v10 (copy), v436 (ref), l_TweenService_0 (copy), l_Debris_0 (copy)
	if not v442 then
		v442 = {};
	end;
	if not v437 then
		v10.Debug("FadeOut cancelled b/c there's no fade that exists!");
		return;
	elseif not v436 then
		v10.Debug("FadeOut called before ever calling FadeIn!");
		return;
	else
		local v443 = l_TweenService_0:Create(v437, v442.TweenInfo or TweenInfo.new(v442.Time or 0.325, Enum.EasingStyle.Linear), {
			BackgroundTransparency = v442.Transparency or 1
		});
		v443:Play();
		l_Debris_0:AddItem(v437, v443.TweenInfo.Time);
		if v442.Yield then
			v443.Completed:Wait();
		end;
		v437 = nil;
		return;
	end;
end;
v0.CreateWarning = function(_, v445, v446, v447) --[[ Line: 1450 ]] --[[ Name: CreateWarning ]]
	local l_LocalPlayer_2 = game.Players.LocalPlayer;
	local l_FirstChild_2 = l_LocalPlayer_2.PlayerGui.TemporaryUI:FindFirstChild(v445);
	if l_FirstChild_2 then
		l_FirstChild_2:Destroy();
	end;
	local v450 = (v447 or game.ReplicatedStorage.Assets.UI.Warning):Clone();
	v450.Name = v445;
	v450.Title.Text = tostring(v446);
	v450.Parent = l_LocalPlayer_2.PlayerGui.TemporaryUI;
	task.delay(3, function() --[[ Line: 1463 ]]
		-- upvalues: v450 (copy)
		if v450.Parent then
			if v450:GetAttribute("InstantDeletion") then
				v450:Destroy();
				return;
			else
				game.Debris:AddItem(v450, 1);
				game.TweenService:Create(v450, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					BackgroundTransparency = 1
				}):Play();
				game.TweenService:Create(v450.Title, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					TextTransparency = 1, 
					TextStrokeTransparency = 1, 
					BackgroundTransparency = 1
				}):Play();
			end;
		end;
	end);
end;
v0.DisplayBubble = function(_, v452, v453) --[[ Line: 1477 ]] --[[ Name: DisplayBubble ]]
	-- upvalues: v11 (copy)
	if not v452 then
		return;
	elseif game["Run Service"]:IsServer() then
		v11:FireAllClientConnection("DisplayBubble", "REMOTE_EVENT", v452, v453);
		return;
	else
		game.TextChatService:DisplayBubble(v452, v453);
		return;
	end;
end;
v0.ToggleControls = function(_, v455) --[[ Line: 1487 ]] --[[ Name: ToggleControls ]]
	-- upvalues: v10 (copy)
	local l_Controls_0 = require(v10.Player.PlayerScripts:WaitForChild("PlayerModule")):GetControls();
	if not v455 then
		l_Controls_0:Disable();
		return;
	else
		l_Controls_0:Enable();
		return;
	end;
end;
v0.ToggleResetButton = function(_, v458) --[[ Line: 1499 ]] --[[ Name: ToggleResetButton ]]
	task.spawn(function() --[[ Line: 1500 ]]
		-- upvalues: v458 (copy)
		game:GetService("StarterGui"):SetCore("ResetButtonCallback", v458);
	end);
end;
v0.ToggleSprinting = function(_, v460, v461, v462) --[[ Line: 1507 ]] --[[ Name: ToggleSprinting ]]
	-- upvalues: v11 (copy)
	v11:FireConnection("DisableSprinting", v460, not v461);
	if v462 then
		task.delay(v462, function() --[[ Line: 1510 ]]
			-- upvalues: v11 (ref), v460 (copy), v461 (copy)
			v11:FireConnection("DisableSprinting", v460, v461);
		end);
	end;
end;
v0.CreateMoneyDisplay = function(_, v464) --[[ Line: 1517 ]] --[[ Name: CreateMoneyDisplay ]]
	-- upvalues: v10 (copy), v12 (copy)
	local l_NumberValue_1 = Instance.new("NumberValue");
	l_NumberValue_1:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 1520 ]]
		-- upvalues: l_NumberValue_1 (copy), v10 (ref), v464 (copy)
		local v466 = math.round(l_NumberValue_1.Value);
		local v467 = v10.Modules.Util:ToCommas(v466);
		v464.CurrentBalance.Text = ("%*$ "):format(v467);
	end);
	local l_FirstChild_3 = game.Players.LocalPlayer:WaitForChild("PlayerData"):WaitForChild("Stats"):FindFirstChild("Money", true);
	l_FirstChild_3:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 1530 ]]
		-- upvalues: l_NumberValue_1 (copy), l_FirstChild_3 (copy), v464 (copy)
		game.TweenService:Create(l_NumberValue_1, TweenInfo.new(1), {
			Value = l_FirstChild_3.Value
		}):Play();
		v464.CurrentBalance.TextSize = v464.CurrentBalance.AbsoluteSize.Y;
	end);
	l_NumberValue_1.Value = l_FirstChild_3.Value;
	v464.CurrentBalance.Text = ("%*$ "):format((v10.Modules.Util:ToCommas((math.round(l_NumberValue_1.Value)))));
	v464.CurrentBalance.TextSize = v464.CurrentBalance.AbsoluteSize.Y;
	v464.BuyMore.MouseEnter:Connect(function() --[[ Line: 1541 ]]
		-- upvalues: v12 (ref)
		v12:Play("hover");
	end);
	v464.BuyMore.MouseLeave:Connect(function() --[[ Line: 1542 ]]
		-- upvalues: v12 (ref)
		v12:Play("hoverEnd");
	end);
	v464.BuyMore.MouseButton1Click:Connect(function() --[[ Line: 1543 ]]
		-- upvalues: v10 (ref)
		local l_Shop_0 = v10.PlayerSystems.Shop;
		v10.PlayerSystems.SidebarHandler.SidebarMenus.Shop:ToggleMenu(true);
		l_Shop_0:SwitchTab("Robux");
	end);
end;
v0.ApplyVelocity = function(_, v471, v472, v473, v474) --[[ Line: 1552 ]] --[[ Name: ApplyVelocity ]]
	-- upvalues: l_Players_0 (copy), v7 (copy), l_RunService_0 (copy)
	if v471 and v471:IsA("Model") then
		v471 = v471.PrimaryPart;
	end;
	if not v471 then
		return nil;
	else
		local l_AssemblyMass_0 = v471.AssemblyMass;
		for _, v477 in (v471.Parent:GetDescendants()) do
			if v477:IsA("BasePart") and not v477.Massless and v477 ~= v471 then
				l_AssemblyMass_0 = l_AssemblyMass_0 + v477.AssemblyMass;
			end;
		end;
		local v478 = require(game.ReplicatedStorage.Modules.Actors);
		local l_l_Players_0_PlayerFromCharacter_0 = l_Players_0:GetPlayerFromCharacter(v471.Parent);
		local v480 = l_l_Players_0_PlayerFromCharacter_0 and v478.CurrentActors[l_l_Players_0_PlayerFromCharacter_0];
		local v481 = v480 and v480.GetPivot and v480:GetPivot() or v471.CFrame;
		local l_LinearVelocity_0 = Instance.new("LinearVelocity");
		l_LinearVelocity_0.MaxForce = l_AssemblyMass_0 * 350;
		l_LinearVelocity_0.RelativeTo = Enum.ActuatorRelativeTo.World;
		l_LinearVelocity_0.VelocityConstraintMode = Enum.VelocityConstraintMode.Line;
		l_LinearVelocity_0.LineDirection = Vector3.new(v481.LookVector.X, 0, v481.LookVector.Z);
		l_LinearVelocity_0.LineVelocity = v472 or 0;
		l_LinearVelocity_0.Attachment0 = v471:FindFirstChild("RootAttachment") or v471:FindFirstChildOfClass("Attachment");
		l_LinearVelocity_0.Parent = v471;
		local v483 = v7.new();
		if v473 then
			task.spawn(function() --[[ Line: 1579 ]]
				-- upvalues: v483 (copy), l_RunService_0 (ref), l_LinearVelocity_0 (copy), v471 (ref), v481 (ref), v480 (copy), v474 (copy)
				v483:Add(l_RunService_0.Heartbeat:Connect(function(_) --[[ Line: 1580 ]]
					-- upvalues: l_LinearVelocity_0 (ref), v471 (ref), v483 (ref), v481 (ref), v480 (ref), v474 (ref)
					if not l_LinearVelocity_0.Active or not v471.Parent then
						v483:Destroy();
					end;
					v481 = v480 and v480.GetPivot and v480:GetPivot() or v471.CFrame;
					l_LinearVelocity_0.LineDirection = l_LinearVelocity_0.LineDirection:Lerp(Vector3.new(v481.LookVector.X, 0, v481.LookVector.Z), v474 or 0);
				end));
			end);
		end;
		return l_LinearVelocity_0, v483;
	end;
end;
local v485 = TweenInfo.new(0.25);
local v486 = {};
local v487 = {};
v0.RevealPlayerAura = function(_, v489, v490, v491, v492) --[[ Line: 1599 ]] --[[ Name: RevealPlayerAura ]]
	-- upvalues: v486 (copy), v11 (copy), l_Debris_0 (copy), l_TweenService_0 (copy), v485 (copy), v487 (copy), v0 (copy)
	v492 = v492 or -1;
	local v493 = v489 and v489:IsA("Player") and v489.Character or v489;
	local v494 = v493 and game.Players:GetPlayerFromCharacter(v493);
	local l_LocalPlayer_3 = game.Players.LocalPlayer;
	local l_Character_2 = l_LocalPlayer_3.Character;
	if v493 and l_Character_2 and (not v493:GetAttribute("Undetectable") or tostring(v493.Parent) == tostring(l_Character_2.Parent) or #workspace.Players.Survivors:GetChildren() <= 1) then
		local v497 = {
			Killers = Color3.new(1, 0, 0), 
			Survivors = Color3.new(1, 0.75, 0), 
			Spectating = Color3.new(1, 1, 1)
		};
		local v498 = v493:FindFirstChild("PlayerAura") or v486[v493];
		if v498 then
			return;
		else
			local v499 = v491 or v497[tostring(v493.Parent)] or v497[tostring(v493)] or v497.Spectating;
			local l_Value_0 = l_LocalPlayer_3.PlayerData.Settings.Game.AltHighlights.Value;
			if v494 then
				v11:FireServerConnection("RevealedAura", "REMOTE_EVENT", v494, v490);
			end;
			local v501 = nil;
			do
				local l_v501_0 = v501;
				if l_Value_0 then
					if v493:IsA("Model") and not v493.PrimaryPart then
						return;
					else
						l_v501_0 = game.ReplicatedStorage.Assets.UI.Highlight:Clone();
						l_v501_0.Name = "PlayerAura";
						l_v501_0.Adornee = v493:FindFirstChild("Head") or v493:IsA("Model") and v493.PrimaryPart or v493;
						l_v501_0.Container.ImageColor3 = v499;
						l_v501_0.Parent = l_LocalPlayer_3.PlayerGui.TemporaryUI;
						v486[v493] = l_v501_0;
						local l_ViewportFrame_0 = l_v501_0.Container.ViewportFrame;
						local v504 = nil;
						v504 = if v493:IsA("Model") then l_ViewportFrame_0.ModelCenter.CFrame else l_ViewportFrame_0.PartCenter.CFrame;
						local v505 = v493:Clone();
						if v493:IsA("Model") then
							v505:SetPrimaryPartCFrame(v504);
						else
							v505.CFrame = v504;
						end;
						v505.Parent = l_ViewportFrame_0;
						local v506 = {
							l_ViewportFrame_0, 
							l_ViewportFrame_0.Parent
						};
						l_Debris_0:AddItem(l_v501_0, tonumber(v490) or 10);
						if not v498 then
							for _, v508 in pairs(v506) do
								l_TweenService_0:Create(v508, TweenInfo.new(1), {
									ImageTransparency = 0
								}):Play();
							end;
						else
							for _, v510 in pairs(v506) do
								v510.ImageTransparency = 0;
							end;
						end;
						task.delay((tonumber(v490) or 10) - 1, function() --[[ Line: 1687 ]]
							-- upvalues: l_v501_0 (ref), v486 (ref), v493 (copy), v506 (copy), l_TweenService_0 (ref)
							if not l_v501_0 or not l_v501_0.Parent then
								return;
							else
								l_v501_0.Name = "goodbai";
								if v486[v493] == l_v501_0 then
									v486[v493] = nil;
								end;
								for _, v512 in pairs(v506) do
									l_TweenService_0:Create(v512, TweenInfo.new(1), {
										ImageTransparency = 1
									}):Play();
								end;
								return;
							end;
						end);
						local v513 = l_v501_0.Adornee and (l_v501_0.Adornee:IsA("Model") and l_v501_0.Adornee.PrimaryPart or l_v501_0.Adornee:IsA("BasePart") and l_v501_0.Adornee);
						if v513 and v492 > 0 then
							if v492 < (v513.Position - l_Character_2.PrimaryPart.Position).Magnitude then
								for _, v515 in pairs(v506) do
									v515.ImageTransparency = 1;
								end;
							end;
							local v516 = nil;
							while task.wait(0.5) and l_v501_0 and l_v501_0.Parent do
								local v517 = v492 < (v513.Position - l_Character_2.PrimaryPart.Position).Magnitude;
								if v516 ~= v517 then
									v516 = v517;
									for _, v519 in pairs(v506) do
										game.TweenService:Create(v519, v485, {
											ImageTransparency = v517 and 1 or 0
										}):Play();
									end;
								end;
							end;
						end;
					end;
				else
					local v520 = {};
					if v498 and v487[v498] then
						v520 = v0:CopyTable(v487[v498]);
						table.clear(v487[v498]);
						v487[v498] = nil;
					end;
					for _, v522 in ipairs(v493:GetChildren()) do
						if v522:IsA("Highlight") and v522.Name ~= "PlayerAura" then
							v522.Parent = nil;
							table.insert(v520, v522);
						end;
					end;
					l_v501_0 = Instance.new("Highlight");
					l_v501_0.Name = "PlayerAura";
					l_v501_0.FillColor = v499;
					l_v501_0.OutlineColor = v499;
					l_v501_0.Parent = v493;
					l_Debris_0:AddItem(l_v501_0, tonumber(v490) or 10);
					v487[l_v501_0] = v520;
					do
						local l_v520_0 = v520;
						local v525 = v493.ChildAdded:Connect(function(v524) --[[ Line: 1755 ]]
							-- upvalues: l_v501_0 (ref), l_v520_0 (ref)
							if not l_v501_0 or not l_v501_0.Parent then
								return;
							else
								if v524.ClassName == "Highlight" and v524.Name ~= "PlayerAura" then
									table.insert(l_v520_0, v524);
								end;
								return;
							end;
						end);
						if not v498 then
							l_v501_0.FillTransparency = 1;
							l_v501_0.OutlineTransparency = 1;
							l_TweenService_0:Create(l_v501_0, TweenInfo.new(1), {
								FillTransparency = 0.5, 
								OutlineTransparency = 0
							}):Play();
						end;
						task.delay((tonumber(v490) or 10) - 1, function() --[[ Line: 1771 ]]
							-- upvalues: v525 (copy), l_v501_0 (ref), v493 (copy), l_v520_0 (ref), v487 (ref), l_TweenService_0 (ref)
							v525:Disconnect();
							if l_v501_0 and l_v501_0.Parent then
								if v493 and v493.Parent then
									for _, v527 in pairs(l_v520_0) do
										if v527 or v527.Parent then
											v527.Parent = v493;
										end;
									end;
								else
									for _, v529 in pairs(l_v520_0) do
										v529:Destroy();
									end;
								end;
								table.clear(l_v520_0);
								v487[l_v501_0] = nil;
								l_v501_0.Name = "goodbai";
								l_TweenService_0:Create(l_v501_0, TweenInfo.new(1), {
									FillTransparency = 1, 
									OutlineTransparency = 1
								}):Play();
							end;
						end);
						local v530 = l_v501_0.Parent and (l_v501_0.Parent:IsA("Model") and l_v501_0.Parent.PrimaryPart or l_v501_0.Parent:IsA("BasePart") and l_v501_0.Parent);
						if v530 and v492 > 0 then
							if v492 < (v530.Position - l_Character_2.PrimaryPart.Position).Magnitude then
								l_v501_0.FillTransparency = 1;
								l_v501_0.OutlineTransparency = 1;
							end;
							local v531 = nil;
							while task.wait(0.5) and l_v501_0 and l_v501_0.Parent do
								local v532 = v492 < (v530.Position - l_Character_2.PrimaryPart.Position).Magnitude;
								if v531 ~= v532 then
									v531 = v532;
									game.TweenService:Create(l_v501_0, v485, {
										FillTransparency = v532 and 1 or 0.5, 
										OutlineTransparency = v532 and 1 or 0
									}):Play();
								end;
							end;
						end;
					end;
				end;
			end;
		end;
	end;
end;
v0.ApplyUnsafeTouched = function(_, v534, v535, v536, v537) --[[ Line: 1818 ]] --[[ Name: ApplyUnsafeTouched ]]
	assert(typeof(v534) == "Instance", "Bad instance, must be BasePart.");
	assert(type(v536) == "function", "Bad callback, must be function.");
	v535 = v535 or false;
	v537 = v537 or v534.Size.Magnitude * 2;
	local v538 = nil;
	local v539 = {
		Disconnect = function() --[[ Line: 1827 ]] --[[ Name: Disconnect ]]
			-- upvalues: v538 (ref)
			if v538 then
				v538:Disconnect();
				v538 = nil;
			end;
		end
	};
	v534.CanTouch = true;
	v538 = v534.Touched:Connect(function(v540) --[[ Line: 1836 ]]
		-- upvalues: v534 (copy), v537 (ref), v536 (copy), v539 (copy)
		if (v540.Position - v534.Position).Magnitude > v537 then
			return;
		else
			v536(v539, v540);
			return;
		end;
	end);
	return v539;
end;
v0.ApplyOnTouched = function(_, v542, v543, v544) --[[ Line: 1846 ]] --[[ Name: ApplyOnTouched ]]
	assert(typeof(v542) == "Instance", "Bad instance, must be BasePart.");
	assert(type(v544) == "function", "Back callback, must be function.");
	v543 = v543 or false;
	local v545 = nil;
	local v546 = {
		Disconnect = function() --[[ Line: 1854 ]] --[[ Name: Disconnect ]]
			-- upvalues: v545 (ref)
			if v545 then
				v545:Disconnect();
				v545 = nil;
				return;
			else
				warn((("[%*/ApplyOnTouched]: Failed to disconnect __HeartbeatConnection as it does not exist."):format(script)));
				return;
			end;
		end
	};
	v545 = game["Run Service"].Heartbeat:Connect(function(_) --[[ Line: 1864 ]]
		-- upvalues: v542 (copy), v546 (copy), v543 (ref), v544 (copy)
		if not v542 or not v542.Parent then
			v546.Disconnect();
		end;
		local v548 = workspace:Blockcast(v542.CFrame, v542.Size, (Vector3.new(0, 1, 0, 0)));
		if not v548 then
			return;
		else
			local l_Instance_0 = v548.Instance;
			if l_Instance_0 then
				if v543 then
					v546.Disconnect();
				end;
				pcall(v544, v546, l_Instance_0);
			end;
			return;
		end;
	end);
	return v546;
end;
v0.RevealPlayerAuraTo = function(_, v551, v552, v553, v554, v555) --[[ Line: 1881 ]] --[[ Name: RevealPlayerAuraTo ]]
	-- upvalues: v11 (copy)
	if v551 and v551:IsA("Model") then
		v551 = game.Players:GetPlayerFromCharacter(v551);
	end;
	v11:FireClientConnection(v551, "RevealPlayerAura", "REMOTE_EVENT", v552, v553, v554, v555);
end;
v0.RemovePlayerAuraFrom = function(_, v557, v558) --[[ Line: 1892 ]] --[[ Name: RemovePlayerAuraFrom ]]
	-- upvalues: v9 (copy), v11 (copy), v8 (copy), v487 (copy), l_Debris_0 (copy), l_TweenService_0 (copy), v486 (copy)
	if not v557 then
		return;
	elseif v9 then
		if v558 then
			v11:FireClientConnection(v558, "RemovePlayerAura", "REMOTE_EVENT", v557);
			return;
		else
			v11:FireAllClientConnection("RemovePlayerAura", "REMOTE_EVENT", v557);
			return;
		end;
	else
		if v8 then
			local v559 = v557:IsA("Player") and v557.Character or v557;
			local l_Character_3 = game.Players.LocalPlayer.Character;
			if v559 then
				local l_PlayerAura_0 = v559:FindFirstChild("PlayerAura");
				if l_PlayerAura_0 and tostring(l_Character_3.Parent) ~= tostring(v559.Parent) then
					local v562 = {};
					if v487[l_PlayerAura_0] then
						if v559 and v559.Parent then
							for _, v564 in pairs(v562) do
								if v564 or v564.Parent then
									v564.Parent = v559;
								end;
							end;
						else
							for _, v566 in pairs(v562) do
								v566:Destroy();
							end;
						end;
						table.clear(v487[l_PlayerAura_0]);
						v487[l_PlayerAura_0] = nil;
					end;
					l_PlayerAura_0.Name = "goodbai";
					l_Debris_0:AddItem(l_PlayerAura_0, 1);
					l_TweenService_0:Create(l_PlayerAura_0, TweenInfo.new(1), {
						FillTransparency = 1, 
						OutlineTransparency = 1
					}):Play();
					return;
				elseif v486[v559] then
					v486[v559]:Destroy();
					v486[v559] = nil;
				end;
			end;
		end;
		return;
	end;
end;
v0.GetClosestPlayerFromPosition = function(_, v568, v569) --[[ Line: 1940 ]] --[[ Name: GetClosestPlayerFromPosition ]]
	-- upvalues: v0 (copy)
	v569 = v569 or {};
	v569.MaxDistance = v569.MaxDistance or 9999;
	v569.PlayerSelection = v569.PlayerSelection or "Survivors";
	v569.VerticalMultiplier = v569.VerticalMultiplier or 1;
	local v570 = v569.IncludedSelection or {};
	for _, v572 in pairs(workspace.Players:GetChildren()) do
		if (v569.PlayerSelection == "All" or v572.Name == v569.PlayerSelection) and v572.Name ~= "Spectating" then
			for _, v574 in pairs(v572:GetChildren()) do
				if not v574:GetAttribute("Undetectable") or v569.OverrideUndetectable or #workspace.Players.Survivors:GetChildren() <= 1 then
					table.insert(v570, v574);
				end;
			end;
		end;
	end;
	local v575 = {};
	for _, v577 in pairs(v570) do
		if v0:IsAlive(v577) then
			local l_v0_Actor_0 = v0:GetActor(v577);
			local l_Magnitude_1 = (((l_v0_Actor_0 and l_v0_Actor_0.GetPivot and l_v0_Actor_0:GetPivot() or v577.PrimaryPart.CFrame).Position - v568) * Vector3.new(1, v569.VerticalMultiplier, 1)).Magnitude;
			if l_Magnitude_1 and (tonumber(v569.MaxDistance) or 999) >= l_Magnitude_1 then
				table.insert(v575, {
					Player = v577, 
					Distance = l_Magnitude_1
				});
			end;
		end;
	end;
	table.sort(v575, function(v580, v581) --[[ Line: 1972 ]]
		return v580.Distance < v581.Distance;
	end);
	if v569.ReturnTable then
		return v575;
	else
		local v582 = v575[1];
		if v582 then
			return v582.Player, v582.Distance;
		else
			return;
		end;
	end;
end;
v0.GetPlayerRootLookVector = function(_, v584) --[[ Line: 1986 ]] --[[ Name: GetPlayerRootLookVector ]]
	-- upvalues: v8 (copy), v11 (copy)
	if v8 or not v584 then
		return;
	else
		local _ = os.clock();
		local v586 = {};
		local v587 = v11:FireClientConnection(v584, "GetLocalPosData", "REMOTE_FUNCTION");
		if v587 then
			v587:gsub("[%d%.%-e]+", function(v588) --[[ Line: 1994 ]]
				-- upvalues: v586 (copy)
				table.insert(v586, (tonumber(v588)));
			end);
			v587 = Vector3.new(v586[4], v586[5], v586[6]);
		end;
		return v587 or v584.Character and v584.Character.PrimaryPart and v584.Character.PrimaryPart.CFrame.LookVector;
	end;
end;
v0.OnPlayingStateChanged = function(v589) --[[ Line: 2004 ]] --[[ Name: OnPlayingStateChanged ]]
	local l_LocalPlayer_4 = game.Players.LocalPlayer;
	local v591 = l_LocalPlayer_4.Character or l_LocalPlayer_4.CharacterAdded:Wait();
	task.spawn(v589, (tostring(v591.Parent)));
	v591:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 2008 ]]
		-- upvalues: v589 (copy), v591 (copy)
		v589((tostring(v591.Parent)));
	end);
end;
v0.OnPlayerAdded = function(v592) --[[ Line: 2014 ]] --[[ Name: OnPlayerAdded ]]
	for _, v594 in pairs(game.Players:GetPlayers()) do
		task.spawn(v592, v594);
	end;
	game.Players.PlayerAdded:Connect(v592);
end;
v0.OnCharacterAdded = function(v595) --[[ Line: 2021 ]] --[[ Name: OnCharacterAdded ]]
	-- upvalues: v0 (copy)
	v0.OnPlayerAdded(function(v596) --[[ Line: 2022 ]]
		-- upvalues: v595 (copy)
		if v596.Character then
			v595(v596.Character, v596);
		end;
		v596.CharacterAdded:Connect(function() --[[ Line: 2026 ]]
			-- upvalues: v595 (ref), v596 (copy)
			v595(v596.Character, v596);
		end);
	end);
end;
v0.ValueBaseToTable = function(_, v598) --[[ Line: 2032 ]] --[[ Name: ValueBaseToTable ]]
	local v599 = {};
	local function v600(v601, v602) --[[ Line: 2035 ]] --[[ Name: recurse ]]
		-- upvalues: v600 (copy)
		for _, v604 in pairs(v601:GetChildren()) do
			local l_Name_0 = v604.Name;
			if v604:IsA("Folder") then
				v602[l_Name_0] = {};
				v600(v604, v602[l_Name_0]);
			else
				v602[l_Name_0] = v604.Value;
			end;
		end;
	end;
	v600(v598, v599);
	return v599;
end;
v0.ValueTableToBase = function(_, v607, v608, v609) --[[ Line: 2051 ]] --[[ Name: ValueTableToBase ]]
	local v610 = {
		number = "IntValue", 
		boolean = "BoolValue", 
		string = "StringValue"
	};
	local function v611(v612, v613) --[[ Line: 2058 ]] --[[ Name: recurse ]]
		-- upvalues: v609 (copy), v611 (copy), v610 (copy)
		for v614, v615 in pairs(v612) do
			if typeof(v615) == "table" and (not v609 or not v609[v614]) then
				local l_v613_FirstChild_0 = v613:FindFirstChild(v614);
				if not l_v613_FirstChild_0 then
					l_v613_FirstChild_0 = Instance.new("Folder");
					l_v613_FirstChild_0.Name = v614;
					l_v613_FirstChild_0.Parent = v613;
				end;
				v611(v615, l_v613_FirstChild_0);
			else
				local l_v613_FirstChild_1 = v613:FindFirstChild(v614);
				if not l_v613_FirstChild_1 then
					local v618 = v610[typeof(v615)];
					l_v613_FirstChild_1 = Instance.new(v618);
					l_v613_FirstChild_1.Name = v614;
				end;
				l_v613_FirstChild_1.Value = v615;
				l_v613_FirstChild_1.Parent = v613;
			end;
		end;
	end;
	v611(v607, v608);
end;
v0.EmitParticles = function(_, v620) --[[ Line: 2083 ]] --[[ Name: EmitParticles ]]
	if typeof(v620) == "Instance" then
		v620 = v620:GetDescendants();
	end;
	for _, v622 in ipairs(v620) do
		if v622:IsA("ParticleEmitter") then
			local l_v622_Attribute_0 = v622:GetAttribute("EmitCount");
			local l_v622_Attribute_1 = v622:GetAttribute("EmitDelay");
			local v625 = v622:GetAttribute("EmitDuration") or v622:GetAttribute("Toggle") or not l_v622_Attribute_0;
			local function v626() --[[ Line: 2093 ]] --[[ Name: f ]]
				-- upvalues: v625 (copy), v622 (copy), l_v622_Attribute_0 (copy)
				if v625 then
					v622.Enabled = not v622.Enabled;
					if typeof(v625) == "number" then
						task.delay(v625, function() --[[ Line: 2098 ]]
							-- upvalues: v622 (ref)
							if v622 then
								v622.Enabled = false;
							end;
						end);
						return;
					end;
				else
					v622:Emit(l_v622_Attribute_0);
				end;
			end;
			if l_v622_Attribute_1 then
				task.delay(l_v622_Attribute_1, v626);
			else
				v626();
			end;
		end;
	end;
end;
return table.freeze(v0);