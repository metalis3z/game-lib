--- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

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
local l_spawn_0 = task.spawn;
local l_floor_0 = math.floor;
local l_sqrt_0 = math.sqrt;
local v16 = {
	Head = true, 
	Torso = true, 
	["Left Arm"] = true, 
	["Left Leg"] = true, 
	["Right Arm"] = true, 
	["Right Leg"] = true
};
local _ = PhysicalProperties.new(0.01, 0, 0, 0, 0);
local v18 = PhysicalProperties.new(0.7, 0.15, 0, 2, 2);
v0.KillerDistanceVector = Vector3.new(1, 4, 1, 0);
v0.RecursiveDestroy = function(_, v20) --[[ Line: 41 ]] --[[ Name: RecursiveDestroy ]]
	-- upvalues: v0 (copy)
	for _, v22 in pairs(v20) do
		if typeof(v22) == "table" then
			v0:RecursiveDestroy(v22);
		elseif typeof(v22) == "Instance" then
			v22:Destroy();
		end;
	end;
end;
v0.Lerp = function(_, v24, v25, v26) --[[ Line: 51 ]] --[[ Name: Lerp ]]
	return v24 + (v25 - v24) * v26;
end;
v0.SerializeVector = function(_, v28) --[[ Line: 55 ]] --[[ Name: SerializeVector ]]
	local v29 = buffer.create(12);
	local v30 = {
		v28.X, 
		v28.Y, 
		v28.Z
	};
	for v31, v32 in ipairs(v30) do
		buffer.writef32(v29, 4 * (v31 - 1), v32);
	end;
	return v29;
end;
v0.DeserializeVector = function(_, v34) --[[ Line: 68 ]] --[[ Name: DeserializeVector ]]
	local function _(v35) --[[ Line: 69 ]] --[[ Name: get ]]
		-- upvalues: v34 (copy)
		return (buffer.readf32(v34, 4 * (v35 - 1)));
	end;
	return (vector.create(buffer.readf32(v34, 0), buffer.readf32(v34, 4), (buffer.readf32(v34, 8))));
end;
v0.AddHitboxes = function(_, v38, v39) --[[ Line: 76 ]] --[[ Name: AddHitboxes ]]
	-- upvalues: v18 (copy)
	local v40 = typeof(v38) == "table" and v38.Config or {};
	local v41 = typeof(v38) == "table" and v38.Rig or v38;
	local v42 = {};
	assert(v41 and v41:IsA("Model"), "character must be a model");
	for _, v44 in ipairs({
		"CollisionHitbox", 
		"QueryHitbox"
		}) do
		while v41:FindFirstChild(v44) do
			v41[v44]:Destroy();
		end;
	end;
	local v45 = (v40.CollisionHitbox or game.ReplicatedStorage.Assets.Instances.CollisionHitbox):Clone();
	local v46 = v45:GetAttribute("CFrameOffset") or CFrame.new(0, 0.5, 0);
	v45.CFrame = v41.PrimaryPart.CFrame * v46;
	v45.Name = "CollisionHitbox";
	local v47 = (v40.QueryHitbox or game.ReplicatedStorage.Assets.Instances.QueryHitbox):Clone();
	local v48 = v45:GetAttribute("CFrameOffset") or CFrame.new(0, -0.25, 0);
	v47.CFrame = v41.PrimaryPart.CFrame * v48;
	v47.Name = "QueryHitbox";
	v47.CanQuery = true;
	v47:SetAttribute("CFOffset", v48);
	local v49 = v41:HasTag("Replicating") and game.Players:GetPlayerFromCharacter(v41);
	for _, v51 in pairs({
		v45, 
		v47
		}) do
		local v52 = false;
		if v51 == v47 then
			v52 = v49;
		end;
		local l_WeldConstraint_0 = Instance.new("WeldConstraint");
		l_WeldConstraint_0.Enabled = not v52;
		l_WeldConstraint_0.Name = "CollisionConnector";
		l_WeldConstraint_0.Parent = v51;
		l_WeldConstraint_0.Part1 = v51;
		l_WeldConstraint_0.Part0 = v41.PrimaryPart;
		v51.CollisionGroup = v39;
		v51.CustomPhysicalProperties = v18;
		v51.Anchored = v52;
		v51.Parent = v41;
		v42[v51.Name] = v51;
	end;
	return v42;
end;
v0.FixCharacter = function(_, v55, v56) --[[ Line: 126 ]] --[[ Name: FixCharacter ]]
	-- upvalues: v16 (copy), v18 (copy)
	v56 = v56 or "Survivors";
	local v57 = {};
	for _, v59 in ipairs(v55:GetDescendants()) do
		if not v59:GetAttribute("Hitbox") and v59:IsA("BasePart") and v59.CollisionGroup ~= "Ragdolls" then
			local v60 = (not not v16[v59.Name] or v55:GetAttribute("CustomRig")) and v59.Parent == v55;
			if v60 then
				table.insert(v57, v59);
			end;
			v59.Anchored = false;
			v59.Massless = not v60 and v59 ~= v55.PrimaryPart;
			if v59 ~= v55.PrimaryPart then
				v59.CanCollide = false;
				v59.CanQuery = v60 or false;
				v59.CanTouch = v60 or false;
				v59.CollisionGroup = "None";
				if v59.Parent ~= v55 then
					v59.RootPriority = -2;
				end;
			else
				v59.CanCollide = true;
				v59.CanQuery = true;
				v59.CanTouch = true;
				v59.CustomPhysicalProperties = v18;
				v59.CollisionGroup = v56;
			end;
		end;
	end;
	local v61 = 3.5 / #v57;
	for _, v63 in ipairs(v57) do
		v63.CustomPhysicalProperties = PhysicalProperties.new(v61, v18.Friction, v18.Elasticity, v18.FrictionWeight, v18.ElasticityWeight);
	end;
end;
v0.GetEntityType = function(_, v65) --[[ Line: 178 ]] --[[ Name: GetEntityType ]]
	local l_v65_Attribute_0 = v65:GetAttribute("EntityType");
	if l_v65_Attribute_0 then
		return l_v65_Attribute_0 == "Humanoid", l_v65_Attribute_0;
	elseif v65:IsDescendantOf(workspace.Players) or v65:HasTag("SimulateSurvivor") then
		return true, "Humanoid";
	elseif v65:GetAttribute("OwnerName") then
		return false, "Building";
	else
		return false, "Entity";
	end;
end;
v0.SnapToAxis = function(_, v68) --[[ Line: 195 ]] --[[ Name: SnapToAxis ]]
	local v69 = math.abs(v68.X);
	local v70 = math.abs(v68.Y);
	local v71 = math.abs(v68.Z);
	if v70 < v69 and v71 < v69 then
		return (Vector3.new(math.sign(v68.X), 0, 0));
	elseif v69 < v70 and v71 < v70 then
		return (Vector3.new(0, math.sign(v68.Y), 0));
	else
		return (Vector3.new(0, 0, (math.sign(v68.Z))));
	end;
end;
v0.IsPlayerKiller = function(_, v73) --[[ Line: 209 ]] --[[ Name: IsPlayerKiller ]]
	local l_Character_0 = v73.Character;
	return l_Character_0 and l_Character_0.Parent and l_Character_0.Parent.Name == "Killers";
end;
v0.GetDistanceFromGround = function(_, v76) --[[ Line: 214 ]] --[[ Name: GetDistanceFromGround ]]
	local l_Humanoid_0 = v76:FindFirstChildOfClass("Humanoid");
	local v78 = v76 and v76.PrimaryPart;
	local v79 = l_Humanoid_0 and l_Humanoid_0.HipHeight or 2;
	local v80 = {
		v76:FindFirstChild("Left Leg"), 
		v76:FindFirstChild("Right Leg")
	};
	local function _(v81, v82, v83) --[[ Line: 220 ]] --[[ Name: absVector ]]
		return (Vector3.new(math.abs(v81), math.abs(v82), (math.abs(v83))));
	end;
	for _, v86 in v80 do
		if v86:IsA("Model") then
			v79 = math.max(v86:GetExtentsSize().Y, v79);
		elseif v86:IsA("BasePart") then
			local v87 = v86.CFrame:VectorToWorldSpace(v86.Size);
			local l_Z_0 = v87.Z;
			local l_Y_0 = v87.Y;
			local l_X_0 = v87.X;
			v87 = Vector3.new(math.abs(l_Z_0), math.abs(l_Y_0), (math.abs(l_X_0)));
			v87 = v86.CFrame:VectorToObjectSpace(v87);
			l_Z_0 = v87.X;
			l_Y_0 = v87.Y;
			l_X_0 = v87.Z;
			v79 = math.max(Vector3.new(math.abs(l_Z_0), math.abs(l_Y_0), (math.abs(l_X_0))).Y, v79);
		end;
	end;
	if v78 then
		v79 = v79 + v78.Size.Y / 2;
	end;
	return (math.clamp(v79, 2, 10));
end;
v0.IsAlive = function(_, v92) --[[ Line: 245 ]] --[[ Name: IsAlive ]]
	return v92 and typeof(v92) == "Instance" and v92.Parent and v92.PrimaryPart and v92:FindFirstChild("Humanoid") and v92.Humanoid.Health > 0;
end;
v0.EmitParticlesFromAttachment = function(_, v94) --[[ Line: 250 ]] --[[ Name: EmitParticlesFromAttachment ]]
	for _, v96 in pairs(v94:GetChildren()) do
		if v96:IsA("ParticleEmitter") then
			v96:Emit(v96:GetAttribute("EmitCount") or 1);
		end;
	end;
end;
v0.RemoveInstancesFromTableOfInstances = function(_, v98, v99) --[[ Line: 258 ]] --[[ Name: RemoveInstancesFromTableOfInstances ]]
	for v100, v101 in pairs(v98) do
		if v99[v101.Name] or v99[v101.ClassName] then
			table.remove(v98, v100);
		end;
	end;
	return v98;
end;
v0.DoFOVBop = function(_, v103, v104, v105, v106) --[[ Line: 268 ]] --[[ Name: DoFOVBop ]]
	-- upvalues: v0 (copy), l_HttpService_0 (copy), l_TweenService_0 (copy)
	local l_v0_FOVMultiplier_0 = v0:CreateFOVMultiplier(v103, v104, l_HttpService_0:GenerateGUID(false));
	local v108 = l_TweenService_0:Create(l_v0_FOVMultiplier_0, v106, {
		Value = v105
	});
	v108:Play();
	v108.Completed:Once(function(_) --[[ Line: 274 ]]
		-- upvalues: l_v0_FOVMultiplier_0 (copy)
		l_v0_FOVMultiplier_0:Destroy();
	end);
end;
v0.LoadAnimationFromID = function(_, v111, v112, v113) --[[ Line: 280 ]] --[[ Name: LoadAnimationFromID ]]
	if not v111 then
		warn(debug.traceback("no rig found while loading animation from ID!"));
		return;
	elseif not v112 then
		warn(debug.traceback("no ID found while loading animation onto rig!"));
		return;
	elseif typeof(v112) ~= "string" then
		return;
	else
		local l_v111_FirstChild_0 = v111:FindFirstChild("Animator", true);
		while not l_v111_FirstChild_0 do
			task.wait();
			l_v111_FirstChild_0 = v111:FindFirstChild("Animator", true);
		end;
		local l_v111_FirstChild_1 = v111:FindFirstChild(v112);
		if l_v111_FirstChild_1 then
			return l_v111_FirstChild_0:LoadAnimation(l_v111_FirstChild_1);
		else
			local l_Animation_0 = Instance.new("Animation");
			l_Animation_0.Name = v112;
			l_Animation_0.AnimationId = v112;
			l_Animation_0.Parent = v111;
			local v117 = l_v111_FirstChild_0:LoadAnimation(l_Animation_0);
			local v118 = 0;
			if v113 and v117.Length <= 0 then
				repeat
					v118 = v118 + task.wait();
				until v117.Length > 0 or v118 >= 25;
			end;
			return v117;
		end;
	end;
end;
v0.PlayDummyCutsceneAnimations = function(_, v120, v121, v122) --[[ Line: 314 ]] --[[ Name: PlayDummyCutsceneAnimations ]]
	-- upvalues: v0 (copy)
	local v123 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 5);
	local v124 = {};
	if v123 then
		local l_Dummies_0 = v123:FindFirstChild("Dummies");
		if not l_Dummies_0 then
			return;
		else
			for _, v127 in ipairs(l_Dummies_0:GetChildren()) do
				if v120.Config.Animations[v122][v127.Name .. "Rig"] then
					local v128 = v0:LoadAnimationFromID(v127, v120.Config.Animations[v122][v127.Name .. "Rig"]);
					v128:Play();
					v128.Stopped:Once(function() --[[ Line: 326 ]]
						-- upvalues: v127 (copy)
						for _, v130 in ipairs(v127:GetChildren()) do
							if v130:IsA("BasePart") then
								v130.Anchored = true;
							end;
						end;
					end);
					game.Debris:AddItem(v128, v121 + 3);
					v124[v127] = v128;
				end;
			end;
		end;
	end;
	return v124;
end;
v0.ApplyDamage = function(_, v132, v133) --[[ Line: 344 ]] --[[ Name: ApplyDamage ]]
	local v134 = require(game.ReplicatedStorage.Modules.AchievementUtil);
	local v135 = require(game.ReplicatedStorage.Modules.Actors);
	local l_Humanoid_1 = v132:FindFirstChild("Humanoid");
	local v137 = tonumber(v133);
	if not v137 or not l_Humanoid_1 or l_Humanoid_1.Health <= 0 then
		return;
	elseif v132:GetAttribute("Invincible") then
		return;
	else
		local l_ResistanceMultipliers_0 = v132:FindFirstChild("ResistanceMultipliers");
		local v139 = 0;
		local l_pairs_0 = pairs;
		local v141 = l_ResistanceMultipliers_0 and l_ResistanceMultipliers_0:GetChildren() or {};
		for _, v143 in l_pairs_0(v141) do
			v139 = v139 + v143.Value;
		end;
		l_pairs_0 = v137 * (1 - math.min(v139, 100) / 100);
		v134:QueryAchievement("DusekkarUbercharge", nil, {
			RawDamage = v137, 
			RealDamage = l_pairs_0, 
			VictimCharacter = v132
		});
		v141 = v135.CurrentActors[game.Players:GetPlayerFromCharacter(v132)];
		if v141 and v141.Behavior and v141.Behavior.OnHit then
			local v144 = {
				TimePast = 0
			};
			v141.Behavior:OnHit(v141, v144, l_pairs_0);
			if v144.TimePast ~= 0 then
				return;
			end;
		end;
		local l_l_Humanoid_1_Attribute_0 = l_Humanoid_1:GetAttribute("Overheal");
		local v146 = v132:GetAttribute("DusekkarProtected") and game.Players:FindFirstChild(v132:GetAttribute("DusekkarProtected"));
		if l_Humanoid_1.Health + (l_l_Humanoid_1_Attribute_0 or 0) <= l_pairs_0 and v146 then
			if v146 then
				local l_Character_1 = v146.Character;
				print((("dusekkar moment (%* protected by %*)"):format(v132, v146)));
				v135:IncrementActorStats(v146, {
					Action = "Prevented the death of a Survivor", 
					Money = 10, 
					EXP = 30
				});
				v132:SetAttribute("DusekkarProtected", nil);
				l_Character_1:SetAttribute("Protecting", nil);
				return;
			end;
		elseif l_l_Humanoid_1_Attribute_0 then
			l_l_Humanoid_1_Attribute_0 = l_l_Humanoid_1_Attribute_0 - l_pairs_0;
			l_Humanoid_1:SetAttribute("Overheal", l_l_Humanoid_1_Attribute_0 > 0 and l_l_Humanoid_1_Attribute_0 or nil);
			if l_l_Humanoid_1_Attribute_0 < 0 then
				l_Humanoid_1.Health = l_Humanoid_1.Health - math.abs(l_l_Humanoid_1_Attribute_0);
			end;
		else
			l_Humanoid_1.Health = l_Humanoid_1.Health - l_pairs_0;
		end;
		if l_Humanoid_1.Health <= 0 and tostring(v132.Parent) == "Survivors" then
			local l_RoundManager_0 = game.ServerScriptService.Server.Systems.Core.RoundManager;
			local v149 = require(l_RoundManager_0);
			local v150 = require(l_RoundManager_0.Configuration);
			if v149.CurrentSession and v149.CurrentSession.TimePast then
				local l_CurrentSession_0 = v149.CurrentSession;
				l_CurrentSession_0.TimePast = l_CurrentSession_0.TimePast - (tonumber(v149.CurrentSession.Gamemode and v149.CurrentSession.Gamemode.TimeAddedOnKill) or 20);
			end;
			local v152 = tostring(v132:GetAttribute("RecentAttacker"));
			local v153 = tonumber(v132:GetAttribute("RecentAttackerTime")) or 0;
			local l_FirstChild_0 = game.Players:FindFirstChild(v152);
			if l_FirstChild_0 and v153 + 12.5 >= tick() then
				require(game.ReplicatedStorage.Modules.Stats):UpdatePlayerStat(l_FirstChild_0, "Kills", "Add", 1);
				v135:IncrementActorStats(l_FirstChild_0, {
					Action = "Killed a Survivor through damage over time", 
					Money = v150.KillerKillCurrency, 
					EXP = v150.KillerKillEXP
				});
			end;
		end;
		return;
	end;
end;
v0.Heal = function(_, v156, v157, _) --[[ Line: 436 ]] --[[ Name: Heal ]]
	local v159 = v156:GetAttribute("HardDamage") or 0;
	if v156.Health > v156.MaxHealth - v159 then
		return false;
	else
		v156.Health = math.clamp(v156.Health + v157, 0, v156.MaxHealth - v159);
		return true;
	end;
end;
v0.SpeedCaps = {};
v0.SetSpeedCap = function(_, v161, v162, v163, v164) --[[ Line: 449 ]] --[[ Name: SetSpeedCap ]]
	-- upvalues: v0 (copy)
	if game["Run Service"]:IsClient() then
		return;
	elseif not v162 then
		return;
	else
		local v165 = v161 and (v161:IsA("Model") and v161 or v161.Character);
		if not v165 then
			return;
		elseif v163 then
			if not v0.SpeedCaps[v165] then
				v0.SpeedCaps[v165] = {};
			end;
			v0.SpeedCaps[v165][v162] = {
				Value = v163, 
				ID = math.random(0, 1000000)
			};
			return;
		else
			if v0.SpeedCaps[v165] then
				if tonumber(v164) then
					local l_ID_0 = v0.SpeedCaps[v165].ID;
					task.delay(v164, function() --[[ Line: 468 ]]
						-- upvalues: v0 (ref), v165 (copy), l_ID_0 (copy), v162 (copy)
						if v0.SpeedCaps[v165] and v0.SpeedCaps[v165].ID == l_ID_0 then
							v0.SpeedCaps[v165][v162] = nil;
						end;
					end);
					return;
				else
					v0.SpeedCaps[v165][v162] = nil;
				end;
			end;
			return;
		end;
	end;
end;
local v167 = {};
local v168 = {};
v0.GiveStackableAttribute = function(_, v170, v171, v172, v173) --[[ Line: 485 ]] --[[ Name: GiveStackableAttribute ]]
	-- upvalues: v0 (copy), v167 (copy)
	if not v170 then
		return;
	elseif typeof(v170) == "Model" and (not v170 or not v0:IsAlive(v170)) then
		return;
	else
		local v174 = v172 or "Default";
		local v175 = v167[v170];
		if not v175 then
			v175 = {};
			v167[v170] = v175;
			v170.Destroying:Once(function() --[[ Line: 497 ]]
				-- upvalues: v167 (ref), v170 (copy)
				table.clear(v167[v170] or {});
				v167[v170] = nil;
			end);
		end;
		local v176 = v175[v171];
		if not v176 then
			v176 = {};
			v175[v171] = v176;
		end;
		local v177 = if v170:GetAttribute(v171) then if typeof(v170:GetAttribute(v171)) == "number" then v170:GetAttribute(v171) else 1 else 0;
			local v178 = v176[v174];
			if v178 then
				if typeof(v178) == "thread" then
					pcall(task.cancel, v178);
				end;
				v177 = v177 - 1;
			end;
			v176[v174] = nil;
			v170:SetAttribute(v171, v177 + 1);
			if v173 then
				local v180 = task.delay(v173, function() --[[ Line: 529 ]]
					-- upvalues: v0 (ref), v170 (copy), v167 (ref), v176 (ref), v174 (copy), v171 (copy)
					if not v0:IsAlive(v170) then
						return;
					elseif not v167[v170] then
						return;
					else
						v176[v174] = nil;
						if not next(v176) then
							v170:SetAttribute(v171, nil);
							return;
						else
							local v179 = if v170:GetAttribute(v171) then if typeof(v170:GetAttribute(v171)) == "number" then v170:GetAttribute(v171) else 1 else 0;
								v170:SetAttribute(v171, v179 - 1);
								return;
							end;
						end;
					end);
				v176[v174] = v180;
			else
				v176[v174] = true;
			end;
			return;
		end;
	end;
	v0.RemoveStackableAttribute = function(_, v182, v183, v184) --[[ Line: 547 ]] --[[ Name: RemoveStackableAttribute ]]
		-- upvalues: v0 (copy), v167 (copy)
		if not v182 then
			return;
		elseif typeof(v182) == "Model" and (not v182 or not v0:IsAlive(v182)) then
			return;
		else
			local v185 = v167[v182];
			if not v185 then
				return;
			else
				local v186 = v185[v183];
				if not v186 then
					return;
				elseif not v184 then
					for v187, v188 in pairs(v186) do
						if typeof(v188) == "thread" then
							pcall(task.cancel, v188);
						end;
						v186[v187] = nil;
					end;
					table.clear(v186 or {});
					v182:SetAttribute(v183, nil);
					return;
				else
					local v189 = v186[v184];
					if not v189 then
						return;
					else
						if typeof(v189) == "thread" then
							pcall(task.cancel, v189);
						end;
						v186[v184] = nil;
						if not next(v186) then
							v182:SetAttribute(v183, nil);
							return;
						else
							v182:SetAttribute(v183, (if v182:GetAttribute(v183) then if typeof(v182:GetAttribute(v183)) == "number" then v182:GetAttribute(v183) else 1 else 0) - 1);
							return;
						end;
					end;
				end;
			end;
		end;
	end;
	v0.GiveStackableProperty = function(_, v191, v192, v193) --[[ Line: 591 ]] --[[ Name: GiveStackableProperty ]]
		-- upvalues: v168 (copy)
		local v194 = v193 or "Default";
		local v195 = v168[v191];
		if not v195 then
			v195 = {};
			v168[v191] = v195;
			v191.Destroying:Once(function() --[[ Line: 600 ]]
				-- upvalues: v168 (ref), v191 (copy)
				table.clear(v168[v191] or {});
				v168[v191] = nil;
			end);
		end;
		local v196 = v195[v192];
		if not v196 then
			v196 = {};
			v195[v192] = v196;
		end;
		v191[v192] = true;
		v196[v194] = true;
	end;
	v0.RemoveStackableProperty = function(_, v198, v199, v200) --[[ Line: 619 ]] --[[ Name: RemoveStackableProperty ]]
		-- upvalues: v168 (copy)
		if not v198 then
			warn("no instance");
			return;
		else
			local v201 = v168[v198];
			if not v201 then
				warn("property cache never created for this character");
				return;
			else
				local v202 = v201[v199];
				if not v202 then
					warn("this property was never applied");
					return;
				elseif not v200 then
					for v203, _ in pairs(v202) do
						v202[v203] = nil;
					end;
					table.clear(v202 or {});
					v198[v199] = false;
					return;
				elseif not v202[v200] then
					warn(v199, "not applied with reason", v200);
					return;
				else
					v202[v200] = nil;
					if not next(v202) then
						v198[v199] = false;
						return;
					else
						warn("reasons for property", v199, "still present, not removing", v202);
						return;
					end;
				end;
			end;
		end;
	end;
	v0.GiveInvincible = function(_, v206, v207, v208) --[[ Line: 670 ]] --[[ Name: GiveInvincible ]]
		-- upvalues: v0 (copy)
		v0:GiveStackableAttribute(v206, "Invincible", v207, v208);
	end;
	v0.RemoveInvincible = function(_, v210, v211) --[[ Line: 674 ]] --[[ Name: RemoveInvincible ]]
		-- upvalues: v0 (copy)
		v0:RemoveStackableAttribute(v210, "Invincible", v211);
	end;
	v0.ToggleAnchored = function(_, v213, v214, v215) --[[ Line: 678 ]] --[[ Name: ToggleAnchored ]]
		-- upvalues: v0 (copy)
		local v216 = v213 and v213:IsA("Model") and v213.PrimaryPart;
		if not v216 then
			return;
		elseif v215 then
			v0:GiveStackableProperty(v216, "Anchored", v214);
			return;
		else
			v0:RemoveStackableProperty(v216, "Anchored", v214);
			return;
		end;
	end;
	v0.CreateValueMultiplier = function(_, v218, v219, v220, v221, v222, v223) --[[ Line: 691 ]] --[[ Name: CreateValueMultiplier ]]
		-- upvalues: l_TweenService_0 (copy), l_Debris_0 (copy)
		local v224 = v218 and (v218:IsA("Model") and v218 or v218.Character);
		local v225 = v224 and v224:FindFirstChild((("%*Multipliers"):format(v219)));
		local v226 = v225 and v225:FindFirstChild((tostring(v221)));
		local l_NumberValue_0 = Instance.new("NumberValue");
		l_NumberValue_0.Value = v220 or 1;
		l_NumberValue_0.Name = v221 or ("%*Multiplier"):format(v219);
		l_NumberValue_0:SetAttribute("Tick", tick());
		l_NumberValue_0:SetAttribute("Duration", v222);
		l_NumberValue_0.Parent = v225;
		if v222 then
			if v223 then
				task.delay(v222 - 0.3, function() --[[ Line: 701 ]]
					-- upvalues: l_TweenService_0 (ref), l_NumberValue_0 (copy)
					l_TweenService_0:Create(l_NumberValue_0, TweenInfo.new(0.3), {
						Value = 1
					}):Play();
				end);
			end;
			l_Debris_0:AddItem(l_NumberValue_0, v222);
		end;
		if v226 then
			v226:Destroy();
		end;
		return l_NumberValue_0;
	end;
	v0.CreateSpeedMultiplier = function(_, v229, v230, v231, v232, v233) --[[ Line: 707 ]] --[[ Name: CreateSpeedMultiplier ]]
		-- upvalues: v0 (copy)
		return v0:CreateValueMultiplier(v229, "Speed", v230, v231, v232, v233);
	end;
	v0.CreateFOVMultiplier = function(_, v235, v236, v237, v238, v239) --[[ Line: 712 ]] --[[ Name: CreateFOVMultiplier ]]
		-- upvalues: v0 (copy)
		return v0:CreateValueMultiplier(v235, "FOV", v236, v237, v238, v239);
	end;
	v0.CreateResistanceMultiplier = function(_, v241, v242, v243, v244, v245) --[[ Line: 717 ]] --[[ Name: CreateResistanceMultiplier ]]
		-- upvalues: v0 (copy)
		return v0:CreateValueMultiplier(v241, "Resistance", v242, v243, v244, v245);
	end;
	v0.GetSettingValue = function(_, v247, v248) --[[ Line: 722 ]] --[[ Name: GetSettingValue ]]
		-- upvalues: v8 (copy)
		if not v248 then
			v248 = v8 and game.Players.LocalPlayer;
		end;
		if v248 then
			local l_FirstChild_1 = v248.PlayerData.Settings:FindFirstChild(v247, true);
			if l_FirstChild_1 then
				return l_FirstChild_1.Value;
			end;
		end;
	end;
	v0.ApplyOverheal = function(_, v251, v252, v253) --[[ Line: 731 ]] --[[ Name: ApplyOverheal ]]
		local v254 = v251 and (v251:IsA("Model") and v251 or v251.Character);
		local v255 = v254 and v254:FindFirstChild("Humanoid");
		if not v255 then
			return;
		elseif not tonumber(v252) then
			return;
		elseif v252 <= 0 then
			v255:SetAttribute("Overheal", nil);
			v255:SetAttribute("DrainingID", nil);
			return;
		else
			v255:SetAttribute("Overheal", v252);
			if v253 then
				local v256 = math.random(-10000000, 10000000);
				v255:SetAttribute("DrainingID", v256);
				task.spawn(function() --[[ Line: 755 ]]
					-- upvalues: v255 (copy), v256 (copy)
					while v255.Parent and v255.Health > 0 and v256 == v255:GetAttribute("DrainingID") do
						local v257 = task.wait();
						local l_v255_Attribute_0 = v255:GetAttribute("Overheal");
						if l_v255_Attribute_0 then
							local v259 = l_v255_Attribute_0 - 2 * v257;
							if v259 > 0 then
								v255:SetAttribute("Overheal", v259);
							else
								break;
							end;
						else
							break;
						end;
					end;
					if v256 == v255:GetAttribute("DrainingID") then
						v255:SetAttribute("Overheal", nil);
						v255:SetAttribute("DrainingID", nil);
					end;
				end);
			end;
			return;
		end;
	end;
	v0.GetPlayerMousePosition = function(_, v261, ...) --[[ Line: 779 ]] --[[ Name: GetPlayerMousePosition ]]
		-- upvalues: v10 (copy)
		if game["Run Service"]:IsServer() then
			return (v10.Modules.Network:FireClientConnection(v261, "GetMousePosition", "REMOTE_FUNCTION", ...));
		elseif game["Run Service"]:IsClient() then
			return require(game.ReplicatedStorage.Systems.Player.Miscellaneous.GetPlayerMousePosition):GetMousePos(...);
		else
			return;
		end;
	end;
	v0.GetActor = function(_, v263) --[[ Line: 789 ]] --[[ Name: GetActor ]]
		return require(game.ReplicatedStorage.Modules.Actors).CurrentActors[game.Players:GetPlayerFromCharacter(v263)];
	end;
	v0.SetUpCutscene = function(_, v265, v266, v267, v268) --[[ Line: 794 ]] --[[ Name: SetUpCutscene ]]
		-- upvalues: v0 (copy)
		local v269 = v0:GetActor(v265) or v265;
		local v270 = v0:GetActor(v266) or v266;
		v268 = v268 or "Cutscene";
		local l_PrimaryPart_0 = v266.PrimaryPart;
		local l_PrimaryPart_1 = v265.PrimaryPart;
		local v273 = typeof(v269) == "table" and v269:GetPivot().Position or l_PrimaryPart_1.Position;
		local v274 = typeof(v270) == "table" and v270:GetPivot().Position or l_PrimaryPart_0.Position;
		local v275 = CFrame.new(v273, (Vector3.new(v274.X, v273.Y, v274.Z)));
		if v275 ~= v275 then
			v275 = l_PrimaryPart_1.CFrame;
		end;
		v269:PivotTo(v275);
		v270:PivotTo(l_PrimaryPart_1.CFrame * (v267 or CFrame.new()));
		v265.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0, 0);
		v266.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0, 0);
		v0:ToggleAnchored(v265, v268, true);
		v0:ToggleAnchored(v266, v268, true);
	end;
	v0.RagdollLaunch = function(_, v277, v278, v279) --[[ Line: 820 ]] --[[ Name: RagdollLaunch ]]
		local v280 = RaycastParams.new();
		v280.FilterDescendantsInstances = workspace.Players:GetDescendants();
		v280.FilterType = Enum.RaycastFilterType.Exclude;
		local v281 = v277.Rig.PrimaryPart.Size.X / 2;
		local l_Magnitude_0 = v279.Magnitude;
		local v283 = l_Magnitude_0 / 10;
		local v284 = workspace:Raycast(v278.PrimaryPart.Position, v279.Unit * v283, v280);
		local v285 = v284 and v284.Distance or v283;
		local v286 = v279 * game.TweenService:GetValue(v285 / v283, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		v278:SetPrimaryPartCFrame(CFrame.new(v277.Rig.PrimaryPart.Position + v279.Unit * v281));
		v278.PrimaryPart.AssemblyLinearVelocity = v286;
		local v287 = require(game.ReplicatedStorage.Modules.Ragdolls);
		v287.AddProfile(v278, {
			Velocity = v286
		});
		v287.EnableRagdoll(v278, (math.clamp(l_Magnitude_0 / 80, 0.5, 5)));
	end;
	v0.SelectRandomKillers = function(_, v289, v290) --[[ Line: 845 ]] --[[ Name: SelectRandomKillers ]]
		-- upvalues: v0 (copy)
		local v291 = {};
		local v292 = {};
		for _, v294 in pairs(v289) do
			local v295 = v294.Instance and v294.Instance:FindFirstChild("PlayerData");
			local v296 = v295 and v295:FindFirstChild("Stats");
			local v297 = v296 and v296:FindFirstChild("KillerChance", true);
			if v297 then
				v294.KillerChance = v297;
				table.insert(v292, v294);
			end;
		end;
		local v298 = workspace:GetAttribute("ServerType") == "VIP";
		if v298 then
			v0:ShuffleTable(v292);
		else
			table.sort(v292, function(v299, v300) --[[ Line: 869 ]]
				return v299.KillerChance.Value > v300.KillerChance.Value;
			end);
		end;
		local v301 = math.clamp(#v289 - 1, workspace:GetAttribute("ForcedKiller") and 1 or 0, 1e999);
		if v301 >= 1 then
			for _ = 1, math.clamp(v290, 1, v301) do
				local v303 = nil;
				local v304 = nil;
				local l_workspace_Attribute_0 = workspace:GetAttribute("ForcedKiller");
				workspace:SetAttribute("ForcedKiller", nil);
				if l_workspace_Attribute_0 then
					for v306, v307 in pairs(v292) do
						if tostring(v307.Instance) == l_workspace_Attribute_0 then
							v303 = v307;
							v304 = v306;
						end;
					end;
				end;
				if not v303 then
					v303 = v292[1];
					v304 = 1;
				end;
				if v303 and v304 then
					if not v298 then
						v303.KillerChance.Value = 1;
					end;
					table.insert(v291, v303);
					table.remove(v292, v304);
				end;
			end;
		end;
		if not v298 then
			for _, v309 in pairs(v292) do
				v0:AddToPlayerStat(v309.Instance, "KillerChance", 1);
			end;
		end;
		return v291, v292;
	end;
	v0.PreloadAssets = function(_, v311) --[[ Line: 941 ]] --[[ Name: PreloadAssets ]]
		-- upvalues: v8 (copy)
		task.spawn(function() --[[ Line: 942 ]]
			-- upvalues: v8 (ref), v311 (copy)
			local v312 = {};
			local function v313(v314) --[[ Line: 944 ]] --[[ Name: fetchAssets ]]
				-- upvalues: v313 (copy), v8 (ref), v312 (copy)
				for v315, v316 in pairs(v314) do
					if typeof(v316) == "table" then
						v313(v316);
					elseif typeof(v316) == "string" and v316:find("rbxassetid://") then
						if v315 == "Sounds" and v8 then
							local l_Sound_0 = Instance.new("Sound");
							l_Sound_0.Parent = workspace:FindFirstChild("Sounds");
							l_Sound_0.SoundId = v316;
							l_Sound_0.Volume = 0;
							l_Sound_0:Play();
							game.Debris:AddItem(l_Sound_0, 1);
						end;
						table.insert(v312, v316);
					end;
				end;
			end;
			v313(v311);
			game.ContentProvider:PreloadAsync(v312);
		end);
	end;
	v0.ToggleLockForAbilityIcon = function(_, v319, v320, v321) --[[ Line: 967 ]] --[[ Name: ToggleLockForAbilityIcon ]]
		local l_AbilityContainer_0 = game.Players.LocalPlayer.PlayerGui.MainUI:FindFirstChild("AbilityContainer");
		local v323 = l_AbilityContainer_0 and l_AbilityContainer_0:FindFirstChild((tostring(v319)));
		if not v323 then
			return;
		else
			local function _(v324) --[[ Line: 975 ]] --[[ Name: setAbilityIconTitleTransparencies ]]
				-- upvalues: v323 (copy)
				local l_Clipping_0 = v323:FindFirstChild("Clipping");
				local l_CooldownTime_0 = v323:FindFirstChild("CooldownTime");
				if l_Clipping_0 then
					l_Clipping_0.Visible = v324;
				end;
				if l_CooldownTime_0 then
					l_CooldownTime_0.Visible = v324;
				end;
			end;
			if v321 and not v323:FindFirstChild(v320) then
				local v328 = script.AbilityLock:Clone();
				v328.Name = v320;
				v328.Parent = v323;
				local l_Clipping_1 = v323:FindFirstChild("Clipping");
				local l_CooldownTime_1 = v323:FindFirstChild("CooldownTime");
				if l_Clipping_1 then
					l_Clipping_1.Visible = false;
				end;
				if l_CooldownTime_1 then
					l_CooldownTime_1.Visible = false;
					return;
				end;
			elseif not v321 then
				local l_Clipping_2 = v323:FindFirstChild("Clipping");
				local l_CooldownTime_2 = v323:FindFirstChild("CooldownTime");
				if l_Clipping_2 then
					l_Clipping_2.Visible = true;
				end;
				if l_CooldownTime_2 then
					l_CooldownTime_2.Visible = true;
				end;
				l_Clipping_2 = v323:FindFirstChild(v320);
				if l_Clipping_2 then
					l_Clipping_2:Destroy();
				end;
			end;
			return;
		end;
	end;
	v0.ToggleLocksForAbilityIcons = function(_, v334, v335) --[[ Line: 1002 ]] --[[ Name: ToggleLocksForAbilityIcons ]]
		-- upvalues: v0 (copy)
		local l_AbilityContainer_1 = game.Players.LocalPlayer.PlayerGui.MainUI:FindFirstChild("AbilityContainer");
		local v337 = l_AbilityContainer_1 and l_AbilityContainer_1:GetChildren() or {};
		for _, v339 in pairs(v337) do
			if v339:IsA("GuiObject") then
				v0:ToggleLockForAbilityIcon(v339.Name, v334, v335);
			end;
		end;
	end;
	local v340 = nil;
	v0.CreateDisplayUI = function(_, v342) --[[ Line: 1016 ]] --[[ Name: CreateDisplayUI ]]
		-- upvalues: v340 (ref), l_TweenService_0 (copy), l_Debris_0 (copy)
		if not v340 then
			v340 = Instance.new("ScreenGui");
			v340.Name = "KillerIntroUI";
			v340.DisplayOrder = 10;
			v340.ResetOnSpawn = false;
			v340.Parent = game.Players.LocalPlayer.PlayerGui;
		end;
		local v343 = {};
		local l_KillerDisplays_0 = game.ReplicatedStorage.Assets.UI.KillerDisplays;
		local v345 = l_KillerDisplays_0.KillerDisplayBackground:Clone();
		v345.Parent = v340;
		v345.ImageTransparency = 1;
		v345.Title.TextTransparency = 1;
		v345.Title.Text = #v342 > 1 and "This round's killers are..." or "This round's killer is...";
		l_TweenService_0:Create(v345, TweenInfo.new(0.2), {
			ImageTransparency = 0
		}):Play();
		l_TweenService_0:Create(v345.Title, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
			TextTransparency = 0
		}):Play();
		table.insert(v343, v345);
		table.insert(v343, v345.Title);
		task.delay(0.65, function() --[[ Line: 1039 ]]
			-- upvalues: v342 (copy), l_KillerDisplays_0 (copy), v345 (copy), l_TweenService_0 (ref), v343 (copy)
			for v346, v347 in pairs(v342) do
				local v348 = l_KillerDisplays_0.Display:Clone();
				v348.Parent = v345.Displays;
				v348.LayoutOrder = v346;
				v348.KillerName.Text = v347.KillerName;
				v348.PlayerName.Text = ("(%*)"):format(v347.PlayerName);
				v348.KillerName.TextTransparency = 1;
				v348.PlayerName.TextTransparency = 1;
				l_TweenService_0:Create(v348.KillerName, TweenInfo.new(0.2), {
					TextTransparency = 0
				}):Play();
				l_TweenService_0:Create(v348.PlayerName, TweenInfo.new(0.2), {
					TextTransparency = 0.6
				}):Play();
				table.insert(v343, v348.KillerName);
				table.insert(v343, v348.PlayerName);
				if v346 ~= #v342 then
					local v349 = l_KillerDisplays_0.Separator:Clone();
					v349.Parent = v345.Displays;
					v349.LayoutOrder = v346;
					v349.TextTransparency = 1;
					l_TweenService_0:Create(v349, TweenInfo.new(0.2), {
						TextTransparency = 0
					}):Play();
					table.insert(v343, v349);
				end;
			end;
		end);
		task.delay(5, function() --[[ Line: 1065 ]]
			-- upvalues: v343 (copy), l_Debris_0 (ref), l_TweenService_0 (ref)
			for _, v351 in pairs(v343) do
				l_Debris_0:AddItem(v351, 0.5);
				if v351:IsA("TextLabel") then
					l_TweenService_0:Create(v351, TweenInfo.new(0.5), {
						TextTransparency = 1
					}):Play();
				elseif v351:IsA("ImageLabel") then
					l_TweenService_0:Create(v351, TweenInfo.new(0.5), {
						ImageTransparency = 1
					}):Play();
				end;
			end;
		end);
	end;
	local v352 = nil;
	v0.CreateTooltip = function(_, v354) --[[ Line: 1080 ]] --[[ Name: CreateTooltip ]]
		-- upvalues: v352 (ref), v12 (copy), l_UserInputService_0 (copy)
		local l_LocalPlayer_0 = game.Players.LocalPlayer;
		if v352 and (v352.Title.Text ~= tostring(v354) or not v352.Parent) then
			if v352.Parent then
				game.TweenService:Create(v352.Title, TweenInfo.new(0.15), {
					TextSize = 0, 
					TextTransparency = 1
				}):Play();
				game.TweenService:Create(v352.Background, TweenInfo.new(0.15), {
					Size = UDim2.fromScale(), 
					ImageTransparency = 1
				}):Play();
				game.Debris:AddItem(v352, 0.15);
				v12:Play("hoverEnd");
			end;
			v352 = nil;
		elseif not v352 and v354 then
			local v356 = l_UserInputService_0:GetMouseLocation() - game.GuiService:GetGuiInset();
			v352 = script.Tooltip:Clone();
			v352.Title.Text = v354;
			v352.Title.Position = UDim2.fromOffset(v356.X, v356.Y + -28);
			v352.Background.Position = UDim2.fromOffset(v356.X, v356.Y + -28 - v352.Title.AbsoluteSize.Y / 2);
			v352.Background.Size = UDim2.fromOffset(v352.Title.AbsoluteSize.X + 64, v352.Title.AbsoluteSize.Y + 50);
			v352.Parent = l_LocalPlayer_0.PlayerGui:FindFirstChild("MainUI");
			v12:Play("hover");
			task.spawn(function() --[[ Line: 1103 ]]
				-- upvalues: v352 (ref), l_UserInputService_0 (ref)
				while v352 and v352.Parent do
					local v357 = l_UserInputService_0:GetMouseLocation() - game.GuiService:GetGuiInset();
					v352.Title.Position = UDim2.fromOffset(v357.X, v357.Y + -28);
					v352.Background.Position = UDim2.fromOffset(v357.X, v357.Y + -28 - v352.Title.AbsoluteSize.Y / 2);
					v352.Background.Size = UDim2.fromOffset(v352.Title.AbsoluteSize.X + 64, v352.Title.AbsoluteSize.Y + 50);
					task.wait();
				end;
			end);
		end;
		return v352;
	end;
	v0.AddToPlayerStat = function(_, v359, v360, v361, v362) --[[ Line: 1117 ]] --[[ Name: AddToPlayerStat ]]
		-- upvalues: v0 (copy)
		if workspace:GetAttribute("ServerType") == "VIP" and v362 ~= true then
			return;
		else
			local v363 = false;
			if typeof(v359) == "Instance" then
				v363 = v359:FindFirstChild("PlayerData");
			end;
			local v364 = v363 and v363.Stats:FindFirstChild(tostring(v360), true);
			if v364 and v364:IsA("NumberValue") then
				if v360 == "KillerChance" and not v362 and v363.Settings.Game.MaliceDisabled.Value then
					return;
				else
					if v360 == "Money" or v360 == "KillerChance" or v360 == "EXPBoostTime" then
						game.AnalyticsService:LogEconomyEvent(v359, Enum.AnalyticsEconomyFlowType.Source, v360, tonumber(v361) or 0, v364.Value + (tonumber(v361) or 0), Enum.AnalyticsEconomyTransactionType.Gameplay.Name);
					end;
					v364.Value = v364.Value + (tonumber(v361) or 0);
					if v360 == "Money" then
						v0:AddToPlayerStat(v359, "NetWorth", v361);
					end;
				end;
			end;
			return;
		end;
	end;
	v0.CopyTable = function(_, v366) --[[ Line: 1150 ]] --[[ Name: CopyTable ]]
		-- upvalues: v0 (copy)
		local v367 = {};
		for v368, v369 in pairs(v366) do
			if typeof(v369) == "table" then
				v367[v368] = v0:CopyTable(v369);
			else
				v367[v368] = v369;
			end;
		end;
		return v367;
	end;
	v0.JoinTables = function(_, ...) --[[ Line: 1163 ]] --[[ Name: JoinTables ]]
		local v371 = {};
		for _, v373 in ipairs(table.pack(...)) do
			for _, v375 in pairs(v373) do
				table.insert(v371, v375);
			end;
		end;
		return v371;
	end;
	v0.MergeTables = function(_, v377, v378, v379) --[[ Line: 1176 ]] --[[ Name: MergeTables ]]
		-- upvalues: v0 (copy)
		if not v378 then
			return v377;
		else
			local v380 = {
				Voicelines = true, 
				Emotes = true, 
				TerrorRadiusThemes = true
			};
			local v381 = {};
			local l_pairs_1 = pairs;
			local v383 = v377 or {};
			for v384, v385 in l_pairs_1(v383) do
				if typeof(v385) == "table" and typeof(v378[v384]) == "table" then
					v381[v384] = v0:MergeTables(v385, v378[v384], v379);
				else
					v381[v384] = v385;
				end;
			end;
			l_pairs_1 = pairs;
			v383 = v378 or {};
			for v386, v387 in l_pairs_1(v383) do
				if typeof(v387) == "table" and typeof(v377[v386]) == "table" and not v380[v386] then
					v381[v386] = v0:MergeTables(v377[v386], v387, v379);
				elseif not table.find(v379 or {}, v386) then
					v381[v386] = v387;
				end;
			end;
			return v381;
		end;
	end;
	v0.ShuffleTable = function(_, v389) --[[ Line: 1209 ]] --[[ Name: ShuffleTable ]]
		local v390 = nil;
		local v391 = nil;
		for v392 = #v389, 1, -1 do
			v390 = math.random(v392);
			v391 = v389[v392];
			v389[v392] = v389[v390];
			v389[v390] = v391;
		end;
		return v389;
	end;
	v0.ToCommas = function(_, v394) --[[ Line: 1221 ]] --[[ Name: ToCommas ]]
		return tostring(v394):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "");
	end;
	v0.ConvertToAbbreviation = function(_, v396) --[[ Line: 1231 ]] --[[ Name: ConvertToAbbreviation ]]
		local function v398(v397) --[[ Line: 1232 ]] --[[ Name: formatNumber ]]
			if v397 % 1 == 0 then
				return string.format("%.0f", v397);
			elseif v397 * 10 % 1 == 0 then
				return string.format("%.1f", v397);
			else
				return string.format("%.2f", v397);
			end;
		end;
		if v396 >= 1000000000000000 then
			return v398(v396 / 1000000000000000) .. "Q+";
		elseif v396 >= 1000000000000 then
			return v398(v396 / 1000000000000) .. "T+";
		elseif v396 >= 1000000000 then
			return v398(v396 / 1000000000) .. "B+";
		elseif v396 >= 1000000 then
			return v398(v396 / 1000000) .. "M+";
		elseif v396 >= 1000 then
			return v398(v396 / 1000) .. "K+";
		else
			return (tostring(v396));
		end;
	end;
	v0.CalculateLevelFromEXP = function(_, v400) --[[ Line: 1258 ]] --[[ Name: CalculateLevelFromEXP ]]
		-- upvalues: l_sqrt_0 (copy), l_floor_0 (copy)
		local v401 = l_floor_0((l_sqrt_0(v400 * 20 + 11225) + -95) / 10);
		if v401 == 1 then
			return v401, v400, 100;
		else
			return v401, v400 - (v401 * 5 * v401 + v401 * 95 - 110), v401 * 10 + 100;
		end;
	end;
	v0.FormatTime = function(_, v403, v404) --[[ Line: 1274 ]] --[[ Name: FormatTime ]]
		-- upvalues: v10 (copy)
		if not v403 then
			v10.Debug("can't format time due to seconds being nil!");
			return "";
		elseif not v404 then
			v10.Debug("can't format time due to formatType being nil!");
			return "";
		else
			local v405 = math.floor(v403 / 86400);
			local v406 = math.floor(v403 % 86400 / 3600);
			local v407 = math.floor(v403 % 3600 / 60);
			local v408 = math.floor(v403 % 60);
			local v409 = "";
			if v404 == "Clock" then
				if v405 > 0 then
					return (string.format("%d:%02d:%02d:%02d", v405, v406, v407, v408));
				elseif v406 > 0 then
					return (string.format("%02d:%02d:%02d", v406, v407, v408));
				else
					return (string.format("%02d:%02d", v407, v408));
				end;
			else
				if v404 == "String" then
					if v405 > 0 then
						v409 = ("%*%*%*"):format(v409, v405, v405 == 1 and " day" or " days");
					end;
					if v406 > 0 then
						if v409 ~= "" then
							v409 = ("%*%*"):format(v409, (not (not (v405 > 0) or v407 <= 0) or v408 > 0) and ", " or " and ");
						end;
						v409 = ("%*%*%*"):format(v409, v406, v406 == 1 and " hour" or " hours");
					end;
					if v407 > 0 then
						if v409 ~= "" then
							v409 = ("%*%*"):format(v409, (not (v405 <= 0) or v406 > 0) and v408 > 0 and ", " or " and ");
						end;
						v409 = ("%*%*%*"):format(v409, v407, v407 == 1 and " minute" or " minutes");
					end;
					if v408 > 0 then
						if v409 ~= "" then
							v409 = ("%*%*"):format(v409, (not (v405 <= 0 and v406 <= 0) or v407 > 0) and " and " or "");
						end;
						v409 = ("%*%*%*"):format(v409, v408, v408 == 1 and " second" or " seconds");
					end;
				end;
				return v409;
			end;
		end;
	end;
	v0.IntToRoman = function(_, v411) --[[ Line: 1325 ]] --[[ Name: IntToRoman ]]
		if not tonumber(v411) then
			return "IDK";
		else
			v411 = math.round((tonumber(v411)));
			local v412 = {
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
			local v413 = "";
			for _, v415 in pairs(v412) do
				while v415[1] <= v411 do
					v413 = v413 .. v415[2];
					v411 = v411 - v415[1];
				end;
			end;
			return v413;
		end;
	end;
	v0.ApplyCameraShake = function(_, v417, v418) --[[ Line: 1358 ]] --[[ Name: ApplyCameraShake ]]
		if not game.Players.LocalPlayer.PlayerData.Settings.Customization.ScreenShakeEnabled.Value then
			return;
		else
			local v419 = tick();
			local v420 = nil;
			v420 = game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 1368 ]]
				-- upvalues: v419 (copy), v418 (copy), v417 (copy), v420 (ref)
				local v421 = math.clamp((tick() - v419) / v418, 0, 1);
				local v422 = v417 * (1 - v421);
				local v423 = Vector3.new((math.random() - 0.5) * 2 * v422, (math.random() - 0.5) * 2 * v422, (math.random() - 0.5) * 2 * v422);
				local l_CurrentCamera_0 = workspace.CurrentCamera;
				l_CurrentCamera_0.CFrame = l_CurrentCamera_0.CFrame * CFrame.new(v423);
				if v421 >= 1 then
					v420:Disconnect();
					v420 = nil;
					return;
				else
					return;
				end;
			end);
			return;
		end;
	end;
	v0.ApplyCameraShakeTo = function(_, v426, v427, v428) --[[ Line: 1396 ]] --[[ Name: ApplyCameraShakeTo ]]
		-- upvalues: v9 (copy), v11 (copy)
		if not v9 then
			return;
		else
			v11:FireClientConnection(v426, "ShakeCamera", "REMOTE_EVENT", v427, v428);
			return;
		end;
	end;
	v0.RemoveCyclicReferences = function(_, v430, v431) --[[ Line: 1401 ]] --[[ Name: RemoveCyclicReferences ]]
		-- upvalues: v0 (copy)
		v431 = v431 or {};
		local v432 = {};
		for v433 in pairs(v430) do
			if not table.find(v431, v430[v433]) then
				if typeof(v430[v433]) ~= "table" then
					v432[v433] = v430[v433];
				else
					table.insert(v431, v430[v433]);
					v432[v433] = v430[v433];
					local v434 = v0:RemoveCyclicReferences(v430[v433], v431);
					for v435 in pairs(v432[v433]) do
						if not v434[v435] then
							v432[v433][v435] = nil;
						end;
					end;
				end;
			end;
		end;
		return v432;
	end;
	v0.IsOnScreen = function(_, v437, v438) --[[ Line: 1425 ]] --[[ Name: IsOnScreen ]]
		-- upvalues: v16 (copy)
		local v439 = false;
		if typeof(v437) ~= "Instance" then
			return;
		else
			local _ = tick();
			local l_Character_2 = game.Players.LocalPlayer.Character;
			local v442 = false;
			local v443 = require(game.ReplicatedStorage.Systems.Player.Miscellaneous.GetPlayerMousePosition);
			local v444 = {};
			table.insert(v444, v437);
			table.insert(v444, l_Character_2);
			table.insert(v444, workspace.CurrentCamera);
			for v445, _ in pairs(v443.TransparentParts) do
				table.insert(v444, v445);
			end;
			local function v450(v447) --[[ Line: 1446 ]] --[[ Name: checkForVisibility ]]
				-- upvalues: v444 (copy)
				local _, v449 = workspace.CurrentCamera:WorldToViewportPoint(v447.Position);
				if v449 and #workspace.CurrentCamera:GetPartsObscuringTarget({
					workspace.CurrentCamera.CFrame.Position, 
					v447.Position
					}, v444) == 0 then
					return true;
				else
					return;
				end;
			end;
			if v437:IsA("Model") then
				local l_Humanoid_2 = v437:FindFirstChild("Humanoid");
				for _, v453 in pairs(v437:GetChildren()) do
					if v453:IsA("BasePart") and ((if l_Humanoid_2 then v453.Parent == v437 and (v16[v453.Name] and true or false) else false) or v453.Transparency ~= 1 or v438) then
						v442 = v450(v453);
						v439 = v442;
					end;
					if v439 then
						break;
					end;
				end;
				if not v439 then
					return v442;
				end;
			elseif v437:IsA("BasePart") and (v437.Transparency ~= 1 or v438) then
				v442 = v450(v437);
			end;
			v439 = false;
			return v442;
		end;
	end;
	v0.CreateProgressBar = function(_, v455, v456) --[[ Line: 1477 ]] --[[ Name: CreateProgressBar ]]
		v455 = v455 or "Performing Action";
		v456 = tonumber(v456) or 5;
		local l_LocalPlayer_1 = game.Players.LocalPlayer;
		local v458 = game.ReplicatedStorage.Assets.UI.ProgressBar:Clone();
		v458.Title.Text = ("%*."):format(v455);
		v458.Parent = l_LocalPlayer_1.PlayerGui:FindFirstChild("TemporaryUI");
		game.Debris:AddItem(v458, v456);
		task.spawn(function() --[[ Line: 1487 ]]
			-- upvalues: v458 (copy), v456 (ref), v455 (ref)
			local v459 = 0;
			local v460 = 0;
			local v461 = 0;
			while v458.Parent do
				local v462 = v459 / v456;
				local v463 = v462 == 0 and 0 or 1 / v462;
				v458.Bar.Clipping.Size = UDim2.fromScale(v462, 1);
				v458.Bar.Clipping.Top.Size = UDim2.fromScale(v463, 1);
				if v460 >= 0.3 then
					v460 = 0;
					v461 = v461 + 1;
					v458.Title.Text = ("%*%*"):format(v455, (string.rep(".", v461 % 3 + 1)));
				end;
				local v464 = game["Run Service"].Heartbeat:Wait();
				v459 = math.clamp(v459 + v464, 0, v456);
				v460 = v460 + v464;
			end;
		end);
		return v458;
	end;
	local v465 = nil;
	local v466 = nil;
	v0.FadeIn = function(_, v468) --[[ Line: 1520 ]] --[[ Name: FadeIn ]]
		-- upvalues: v466 (ref), v10 (copy), v465 (ref), l_TweenService_0 (copy)
		if not v468 then
			v468 = {};
		end;
		if v466 and v466.Parent then
			v10.Debug("FadeIn cancelled b/c there's already a fade that exists!");
			return;
		else
			if not v465 then
				v465 = Instance.new("ScreenGui");
				v465.Name = "FadeUI";
				v465.IgnoreGuiInset = true;
				v465.ResetOnSpawn = false;
				v465.DisplayOrder = 10;
				v465.Parent = v10.Player.PlayerGui;
			end;
			v466 = Instance.new("Frame");
			v466.Name = "Fade";
			v466.BackgroundTransparency = v468.StartTransparency or 1;
			v466.BackgroundColor3 = v468.Color or Color3.new();
			v466.Size = UDim2.fromScale(1, 1);
			v466.Parent = v465;
			if v468.InstantTween then
				v466.BackgroundTransparency = v468.EndTransparency or 0;
				return;
			else
				local v469 = l_TweenService_0:Create(v466, v468.TweenInfo or TweenInfo.new(v468.Time or 0.325, Enum.EasingStyle.Linear), {
					BackgroundTransparency = v468.EndTransparency or 0
				});
				v469:Play();
				if v468.Yield then
					v469.Completed:Wait();
				end;
				return;
			end;
		end;
	end;
	v0.FadeOut = function(_, v471) --[[ Line: 1558 ]] --[[ Name: FadeOut ]]
		-- upvalues: v466 (ref), v10 (copy), v465 (ref), l_TweenService_0 (copy), l_Debris_0 (copy)
		if not v471 then
			v471 = {};
		end;
		if not v466 then
			v10.Debug("FadeOut cancelled b/c there's no fade that exists!");
			return;
		elseif not v465 then
			v10.Debug("FadeOut called before ever calling FadeIn!");
			return;
		else
			local v472 = l_TweenService_0:Create(v466, v471.TweenInfo or TweenInfo.new(v471.Time or 0.325, Enum.EasingStyle.Linear), {
				BackgroundTransparency = v471.Transparency or 1
			});
			v472:Play();
			l_Debris_0:AddItem(v466, v472.TweenInfo.Time);
			if v471.Yield then
				v472.Completed:Wait();
			end;
			v466 = nil;
			return;
		end;
	end;
	v0.CreateWarning = function(_, v474, v475, v476) --[[ Line: 1580 ]] --[[ Name: CreateWarning ]]
		local l_LocalPlayer_2 = game.Players.LocalPlayer;
		local l_FirstChild_2 = l_LocalPlayer_2.PlayerGui.TemporaryUI:FindFirstChild(v474);
		if l_FirstChild_2 then
			l_FirstChild_2:Destroy();
		end;
		local v479 = (v476 or game.ReplicatedStorage.Assets.UI.Warning):Clone();
		v479.Name = v474;
		v479.Title.Text = tostring(v475);
		v479.Parent = l_LocalPlayer_2.PlayerGui.TemporaryUI;
		task.delay(3, function() --[[ Line: 1593 ]]
			-- upvalues: v479 (copy)
			if v479.Parent then
				if v479:GetAttribute("InstantDeletion") then
					v479:Destroy();
					return;
				else
					game.Debris:AddItem(v479, 1);
					game.TweenService:Create(v479, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						BackgroundTransparency = 1
					}):Play();
					game.TweenService:Create(v479.Title, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						TextTransparency = 1, 
						TextStrokeTransparency = 1, 
						BackgroundTransparency = 1
					}):Play();
				end;
			end;
		end);
	end;
	v0.DisplayBubble = function(_, v481, v482) --[[ Line: 1607 ]] --[[ Name: DisplayBubble ]]
		-- upvalues: v11 (copy)
		if not v481 then
			return;
		elseif game["Run Service"]:IsServer() then
			v11:FireAllClientConnection("DisplayBubble", "REMOTE_EVENT", v481, v482);
			return;
		else
			game.TextChatService:DisplayBubble(v481, v482);
			return;
		end;
	end;
	v0.ToggleControls = function(_, v484) --[[ Line: 1617 ]] --[[ Name: ToggleControls ]]
		-- upvalues: v10 (copy)
		local l_Controls_0 = require(v10.Player.PlayerScripts:WaitForChild("PlayerModule")):GetControls();
		if not v484 then
			l_Controls_0:Disable();
			return;
		else
			l_Controls_0:Enable();
			return;
		end;
	end;
	v0.ToggleResetButton = function(_, v487) --[[ Line: 1629 ]] --[[ Name: ToggleResetButton ]]
		task.spawn(function() --[[ Line: 1630 ]]
			-- upvalues: v487 (copy)
			game:GetService("StarterGui"):SetCore("ResetButtonCallback", v487);
		end);
	end;
	v0.ToggleSprinting = function(_, v489, v490, v491) --[[ Line: 1637 ]] --[[ Name: ToggleSprinting ]]
		-- upvalues: v11 (copy)
		v11:FireConnection("DisableSprinting", v489, not v490);
		if v491 then
			task.delay(v491, function() --[[ Line: 1640 ]]
				-- upvalues: v11 (ref), v489 (copy), v490 (copy)
				v11:FireConnection("DisableSprinting", v489, v490);
			end);
		end;
	end;
	v0.CreateMoneyDisplay = function(_, v493) --[[ Line: 1647 ]] --[[ Name: CreateMoneyDisplay ]]
		-- upvalues: v10 (copy), v12 (copy)
		local l_NumberValue_1 = Instance.new("NumberValue");
		l_NumberValue_1:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 1650 ]]
			-- upvalues: l_NumberValue_1 (copy), v10 (ref), v493 (copy)
			local v495 = math.round(l_NumberValue_1.Value);
			local v496 = v10.Modules.Util:ToCommas(v495);
			v493.CurrentBalance.Text = ("%*$ "):format(v496);
		end);
		local l_FirstChild_3 = game.Players.LocalPlayer:WaitForChild("PlayerData"):WaitForChild("Stats"):FindFirstChild("Money", true);
		l_FirstChild_3:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 1660 ]]
			-- upvalues: l_NumberValue_1 (copy), l_FirstChild_3 (copy), v493 (copy)
			game.TweenService:Create(l_NumberValue_1, TweenInfo.new(1), {
				Value = l_FirstChild_3.Value
			}):Play();
			v493.CurrentBalance.TextSize = v493.CurrentBalance.AbsoluteSize.Y;
		end);
		l_NumberValue_1.Value = l_FirstChild_3.Value;
		v493.CurrentBalance.Text = ("%*$ "):format((v10.Modules.Util:ToCommas((math.round(l_NumberValue_1.Value)))));
		v493.CurrentBalance.TextSize = v493.CurrentBalance.AbsoluteSize.Y;
		v493.BuyMore.MouseEnter:Connect(function() --[[ Line: 1671 ]]
			-- upvalues: v12 (ref)
			v12:Play("hover");
		end);
		v493.BuyMore.MouseLeave:Connect(function() --[[ Line: 1672 ]]
			-- upvalues: v12 (ref)
			v12:Play("hoverEnd");
		end);
		v493.BuyMore.MouseButton1Click:Connect(function() --[[ Line: 1673 ]]
			-- upvalues: v10 (ref)
			local l_Shop_0 = v10.PlayerSystems.Shop;
			v10.PlayerSystems.SidebarHandler.SidebarMenus.Shop:ToggleMenu(true);
			l_Shop_0:SwitchTab("Robux");
		end);
	end;
	v0.ApplyVelocity = function(_, v500, v501, v502, v503) --[[ Line: 1682 ]] --[[ Name: ApplyVelocity ]]
		-- upvalues: l_Players_0 (copy), v7 (copy), l_RunService_0 (copy)
		if v500 and v500:IsA("Model") then
			v500 = v500.PrimaryPart;
		end;
		if not v500 then
			return nil;
		else
			local l_AssemblyMass_0 = v500.AssemblyMass;
			for _, v506 in (v500.Parent:GetDescendants()) do
				if v506:IsA("BasePart") and not v506.Massless and v506 ~= v500 then
					l_AssemblyMass_0 = l_AssemblyMass_0 + v506.AssemblyMass;
				end;
			end;
			local v507 = require(game.ReplicatedStorage.Modules.Actors);
			local l_l_Players_0_PlayerFromCharacter_0 = l_Players_0:GetPlayerFromCharacter(v500.Parent);
			local v509 = l_l_Players_0_PlayerFromCharacter_0 and v507.CurrentActors[l_l_Players_0_PlayerFromCharacter_0];
			local v510 = v509 and v509.GetPivot and v509:GetPivot() or v500.CFrame;
			local l_LinearVelocity_0 = Instance.new("LinearVelocity");
			l_LinearVelocity_0.MaxForce = l_AssemblyMass_0 * 350;
			l_LinearVelocity_0.RelativeTo = Enum.ActuatorRelativeTo.World;
			l_LinearVelocity_0.VelocityConstraintMode = Enum.VelocityConstraintMode.Line;
			l_LinearVelocity_0.LineDirection = Vector3.new(v510.LookVector.X, 0, v510.LookVector.Z);
			l_LinearVelocity_0.LineVelocity = v501 or 0;
			l_LinearVelocity_0.Attachment0 = v500:FindFirstChild("RootAttachment") or v500:FindFirstChildOfClass("Attachment");
			l_LinearVelocity_0.Parent = v500;
			local v512 = v7.new();
			if v502 then
				task.spawn(function() --[[ Line: 1709 ]]
					-- upvalues: v512 (copy), l_RunService_0 (ref), l_LinearVelocity_0 (copy), v500 (ref), v510 (ref), v509 (copy), v503 (copy)
					v512:Add(l_RunService_0.Heartbeat:Connect(function(_) --[[ Line: 1710 ]]
						-- upvalues: l_LinearVelocity_0 (ref), v500 (ref), v512 (ref), v510 (ref), v509 (ref), v503 (ref)
						if not l_LinearVelocity_0.Active or not v500.Parent then
							v512:Destroy();
						end;
						v510 = v509 and v509.GetPivot and v509:GetPivot() or v500.CFrame;
						l_LinearVelocity_0.LineDirection = l_LinearVelocity_0.LineDirection:Lerp(Vector3.new(v510.LookVector.X, 0, v510.LookVector.Z), v503 or 0);
					end));
				end);
			end;
			return l_LinearVelocity_0, v512;
		end;
	end;
	local v514 = TweenInfo.new(0.25);
	local v515 = {};
	local v516 = {};
	v0.RevealPlayerAura = function(_, v518, v519, v520, v521) --[[ Line: 1729 ]] --[[ Name: RevealPlayerAura ]]
		-- upvalues: v515 (copy), v11 (copy), l_Debris_0 (copy), l_TweenService_0 (copy), v514 (copy), v516 (copy), v0 (copy)
		v521 = v521 or -1;
		local v522 = v518 and v518:IsA("Player") and v518.Character or v518;
		local v523 = v522 and game.Players:GetPlayerFromCharacter(v522);
		local l_LocalPlayer_3 = game.Players.LocalPlayer;
		local l_Character_3 = l_LocalPlayer_3.Character;
		if v522 and l_Character_3 and (not v522:GetAttribute("Undetectable") or tostring(v522.Parent) == tostring(l_Character_3.Parent) or #workspace.Players.Survivors:GetChildren() <= 1) then
			local v526 = {
				Killers = Color3.new(1, 0, 0), 
				Survivors = Color3.new(1, 0.75, 0), 
				Spectating = Color3.new(1, 1, 1)
			};
			local v527 = v522:FindFirstChild("PlayerAura") or v515[v522];
			if v527 then
				return;
			else
				local v528 = v520 or v526[tostring(v522.Parent)] or v526[tostring(v522)] or v526.Spectating;
				local l_Value_0 = l_LocalPlayer_3.PlayerData.Settings.Game.AltHighlights.Value;
				if v523 then
					v11:FireServerConnection("RevealedAura", "REMOTE_EVENT", v523, v519);
				end;
				local v530 = nil;
				do
					local l_v530_0 = v530;
					if l_Value_0 then
						if v522:IsA("Model") and not v522.PrimaryPart then
							return;
						else
							l_v530_0 = game.ReplicatedStorage.Assets.UI.Highlight:Clone();
							l_v530_0.Name = "PlayerAura";
							l_v530_0.Adornee = v522:FindFirstChild("Head") or v522:IsA("Model") and v522.PrimaryPart or v522;
							l_v530_0.Container.ImageColor3 = v528;
							l_v530_0.Parent = l_LocalPlayer_3.PlayerGui.TemporaryUI;
							v515[v522] = l_v530_0;
							local l_ViewportFrame_0 = l_v530_0.Container.ViewportFrame;
							local v533 = nil;
							v533 = if v522:IsA("Model") then l_ViewportFrame_0.ModelCenter.CFrame else l_ViewportFrame_0.PartCenter.CFrame;
							local l_Archivable_0 = v522.Archivable;
							v522.Archivable = true;
							local v535 = v522:Clone();
							v522.Archivable = l_Archivable_0;
							if not v535 then
								warn("i don't even know how this happens dude");
								return;
							else
								if v522:IsA("Model") then
									v535:SetPrimaryPartCFrame(v533);
								else
									v535.CFrame = v533;
								end;
								v535.Parent = l_ViewportFrame_0;
								local v536 = {
									l_ViewportFrame_0, 
									l_ViewportFrame_0.Parent
								};
								l_Debris_0:AddItem(l_v530_0, tonumber(v519) or 10);
								if not v527 then
									for _, v538 in pairs(v536) do
										l_TweenService_0:Create(v538, TweenInfo.new(1), {
											ImageTransparency = 0
										}):Play();
									end;
								else
									for _, v540 in pairs(v536) do
										v540.ImageTransparency = 0;
									end;
								end;
								task.delay((tonumber(v519) or 10) - 1, function() --[[ Line: 1825 ]]
									-- upvalues: l_v530_0 (ref), v515 (ref), v522 (copy), v536 (copy), l_TweenService_0 (ref)
									if not l_v530_0 or not l_v530_0.Parent then
										return;
									else
										l_v530_0.Name = "goodbai";
										if v515[v522] == l_v530_0 then
											v515[v522] = nil;
										end;
										for _, v542 in pairs(v536) do
											l_TweenService_0:Create(v542, TweenInfo.new(1), {
												ImageTransparency = 1
											}):Play();
										end;
										return;
									end;
								end);
								local v543 = l_v530_0.Adornee and (l_v530_0.Adornee:IsA("Model") and l_v530_0.Adornee.PrimaryPart or l_v530_0.Adornee:IsA("BasePart") and l_v530_0.Adornee);
								if v543 and v521 > 0 then
									if v521 < (v543.Position - l_Character_3.PrimaryPart.Position).Magnitude then
										for _, v545 in pairs(v536) do
											v545.ImageTransparency = 1;
										end;
									end;
									local v546 = nil;
									while task.wait(0.5) and l_v530_0 and l_v530_0.Parent do
										local v547 = v521 < (v543.Position - l_Character_3.PrimaryPart.Position).Magnitude;
										if v546 ~= v547 then
											v546 = v547;
											for _, v549 in pairs(v536) do
												game.TweenService:Create(v549, v514, {
													ImageTransparency = v547 and 1 or 0
												}):Play();
											end;
										end;
									end;
								end;
							end;
						end;
					else
						local v550 = {};
						if v527 and v516[v527] then
							v550 = v0:CopyTable(v516[v527]);
							table.clear(v516[v527]);
							v516[v527] = nil;
						end;
						for _, v552 in ipairs(v522:GetChildren()) do
							if v552:IsA("Highlight") and v552.Name ~= "PlayerAura" then
								v552.Parent = nil;
								table.insert(v550, v552);
							end;
						end;
						l_v530_0 = Instance.new("Highlight");
						l_v530_0.Name = "PlayerAura";
						l_v530_0.FillColor = v528;
						l_v530_0.OutlineColor = v528;
						l_v530_0.Parent = v522;
						l_Debris_0:AddItem(l_v530_0, tonumber(v519) or 10);
						v516[l_v530_0] = v550;
						do
							local l_v550_0 = v550;
							local v555 = v522.ChildAdded:Connect(function(v554) --[[ Line: 1893 ]]
								-- upvalues: l_v530_0 (ref), l_v550_0 (ref)
								if not l_v530_0 or not l_v530_0.Parent then
									return;
								else
									if v554.ClassName == "Highlight" and v554.Name ~= "PlayerAura" then
										table.insert(l_v550_0, v554);
									end;
									return;
								end;
							end);
							if not v527 then
								l_v530_0.FillTransparency = 1;
								l_v530_0.OutlineTransparency = 1;
								l_TweenService_0:Create(l_v530_0, TweenInfo.new(1), {
									FillTransparency = 0.5, 
									OutlineTransparency = 0
								}):Play();
							end;
							task.delay((tonumber(v519) or 10) - 1, function() --[[ Line: 1909 ]]
								-- upvalues: v555 (copy), l_v530_0 (ref), v522 (copy), l_v550_0 (ref), v516 (ref), l_TweenService_0 (ref)
								v555:Disconnect();
								if l_v530_0 and l_v530_0.Parent then
									if v522 and v522.Parent then
										for _, v557 in pairs(l_v550_0) do
											if v557 or v557.Parent then
												v557.Parent = v522;
											end;
										end;
									else
										for _, v559 in pairs(l_v550_0) do
											v559:Destroy();
										end;
									end;
									table.clear(l_v550_0);
									v516[l_v530_0] = nil;
									l_v530_0.Name = "goodbai";
									l_TweenService_0:Create(l_v530_0, TweenInfo.new(1), {
										FillTransparency = 1, 
										OutlineTransparency = 1
									}):Play();
								end;
							end);
							local v560 = l_v530_0.Parent and (l_v530_0.Parent:IsA("Model") and l_v530_0.Parent.PrimaryPart or l_v530_0.Parent:IsA("BasePart") and l_v530_0.Parent);
							if v560 and v521 > 0 then
								if v521 < (v560.Position - l_Character_3.PrimaryPart.Position).Magnitude then
									l_v530_0.FillTransparency = 1;
									l_v530_0.OutlineTransparency = 1;
								end;
								local v561 = nil;
								while task.wait(0.5) and l_v530_0 and l_v530_0.Parent do
									local v562 = v521 < (v560.Position - l_Character_3.PrimaryPart.Position).Magnitude;
									if v561 ~= v562 then
										v561 = v562;
										game.TweenService:Create(l_v530_0, v514, {
											FillTransparency = v562 and 1 or 0.5, 
											OutlineTransparency = v562 and 1 or 0
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
	v0.ApplyUnsafeTouched = function(_, v564, v565, v566, v567) --[[ Line: 1956 ]] --[[ Name: ApplyUnsafeTouched ]]
		assert(typeof(v564) == "Instance", "Bad instance, must be BasePart.");
		assert(type(v566) == "function", "Bad callback, must be function.");
		v565 = v565 or false;
		v567 = v567 or v564.Size.Magnitude * 2;
		local v568 = nil;
		local v569 = {
			Disconnect = function() --[[ Line: 1965 ]] --[[ Name: Disconnect ]]
				-- upvalues: v568 (ref)
				if v568 then
					v568:Disconnect();
					v568 = nil;
				end;
			end
		};
		v564.CanTouch = true;
		v568 = v564.Touched:Connect(function(v570) --[[ Line: 1974 ]]
			-- upvalues: v564 (copy), v567 (ref), v566 (copy), v569 (copy)
			if (v570.Position - v564.Position).Magnitude > v567 then
				return;
			else
				v566(v569, v570);
				return;
			end;
		end);
		return v569;
	end;
	v0.ApplyOnTouched = function(_, v572, v573, v574) --[[ Line: 1984 ]] --[[ Name: ApplyOnTouched ]]
		assert(typeof(v572) == "Instance", "Bad instance, must be BasePart.");
		assert(type(v574) == "function", "Back callback, must be function.");
		v573 = v573 or false;
		local v575 = nil;
		local v576 = {
			Disconnect = function() --[[ Line: 1992 ]] --[[ Name: Disconnect ]]
				-- upvalues: v575 (ref)
				if v575 then
					v575:Disconnect();
					v575 = nil;
					return;
				else
					warn((("[%*/ApplyOnTouched]: Failed to disconnect __HeartbeatConnection as it does not exist."):format(script)));
					return;
				end;
			end
		};
		v575 = game["Run Service"].Heartbeat:Connect(function(_) --[[ Line: 2002 ]]
			-- upvalues: v572 (copy), v576 (copy), v573 (ref), v574 (copy)
			if not v572 or not v572.Parent then
				v576.Disconnect();
			end;
			local v578 = workspace:Blockcast(v572.CFrame, v572.Size, (Vector3.new(0, 1, 0, 0)));
			if not v578 then
				return;
			else
				local l_Instance_0 = v578.Instance;
				if l_Instance_0 then
					if v573 then
						v576.Disconnect();
					end;
					pcall(v574, v576, l_Instance_0);
				end;
				return;
			end;
		end);
		return v576;
	end;
	v0.RevealPlayerAuraTo = function(_, v581, v582, v583, v584, v585) --[[ Line: 2019 ]] --[[ Name: RevealPlayerAuraTo ]]
		-- upvalues: v11 (copy)
		if v581 and v581:IsA("Model") then
			v581 = game.Players:GetPlayerFromCharacter(v581);
		end;
		v11:FireClientConnection(v581, "RevealPlayerAura", "REMOTE_EVENT", v582, v583, v584, v585);
	end;
	v0.RemovePlayerAuraFrom = function(_, v587, v588) --[[ Line: 2030 ]] --[[ Name: RemovePlayerAuraFrom ]]
		-- upvalues: v9 (copy), v11 (copy), v8 (copy), v516 (copy), l_Debris_0 (copy), l_TweenService_0 (copy), v515 (copy)
		if not v587 then
			return;
		elseif v9 then
			if v588 then
				v11:FireClientConnection(v588, "RemovePlayerAura", "REMOTE_EVENT", v587);
				return;
			else
				v11:FireAllClientConnection("RemovePlayerAura", "REMOTE_EVENT", v587);
				return;
			end;
		else
			if v8 then
				local v589 = v587:IsA("Player") and v587.Character or v587;
				local l_Character_4 = game.Players.LocalPlayer.Character;
				if v589 then
					local l_PlayerAura_0 = v589:FindFirstChild("PlayerAura");
					if l_PlayerAura_0 and tostring(l_Character_4.Parent) ~= tostring(v589.Parent) then
						local v592 = {};
						if v516[l_PlayerAura_0] then
							if v589 and v589.Parent then
								for _, v594 in pairs(v592) do
									if v594 or v594.Parent then
										v594.Parent = v589;
									end;
								end;
							else
								for _, v596 in pairs(v592) do
									v596:Destroy();
								end;
							end;
							table.clear(v516[l_PlayerAura_0]);
							v516[l_PlayerAura_0] = nil;
						end;
						l_PlayerAura_0.Name = "goodbai";
						l_Debris_0:AddItem(l_PlayerAura_0, 1);
						l_TweenService_0:Create(l_PlayerAura_0, TweenInfo.new(1), {
							FillTransparency = 1, 
							OutlineTransparency = 1
						}):Play();
						return;
					elseif v515[v589] then
						v515[v589]:Destroy();
						v515[v589] = nil;
					end;
				end;
			end;
			return;
		end;
	end;
	v0.GetClosestPlayerFromPosition = function(_, v598, v599) --[[ Line: 2078 ]] --[[ Name: GetClosestPlayerFromPosition ]]
		-- upvalues: v0 (copy)
		v599 = v599 or {};
		v599.MaxDistance = v599.MaxDistance or 9999;
		v599.PlayerSelection = v599.PlayerSelection or "Survivors";
		v599.VerticalMultiplier = v599.VerticalMultiplier or 1;
		local v600 = v599.IncludedSelection or {};
		for _, v602 in pairs(workspace.Players:GetChildren()) do
			if (v599.PlayerSelection == "All" or v602.Name == v599.PlayerSelection) and v602.Name ~= "Spectating" then
				for _, v604 in pairs(v602:GetChildren()) do
					if not v604:GetAttribute("Undetectable") or v599.OverrideUndetectable or #workspace.Players.Survivors:GetChildren() <= 1 then
						table.insert(v600, v604);
					end;
				end;
			end;
		end;
		local v605 = {};
		for _, v607 in pairs(v600) do
			if v0:IsAlive(v607) then
				local l_v0_Actor_0 = v0:GetActor(v607);
				local l_Magnitude_1 = (((l_v0_Actor_0 and l_v0_Actor_0.GetPivot and l_v0_Actor_0:GetPivot() or v607.PrimaryPart.CFrame).Position - v598) * Vector3.new(1, v599.VerticalMultiplier, 1)).Magnitude;
				if l_Magnitude_1 and (tonumber(v599.MaxDistance) or 999) >= l_Magnitude_1 then
					table.insert(v605, {
						Player = v607, 
						Distance = l_Magnitude_1
					});
				end;
			end;
		end;
		table.sort(v605, function(v610, v611) --[[ Line: 2110 ]]
			return v610.Distance < v611.Distance;
		end);
		if v599.ReturnTable then
			return v605;
		else
			local v612 = v605[1];
			if v612 then
				return v612.Player, v612.Distance;
			else
				return;
			end;
		end;
	end;
	v0.GetPlayerRootLookVector = function(_, v614) --[[ Line: 2124 ]] --[[ Name: GetPlayerRootLookVector ]]
		-- upvalues: v8 (copy), v11 (copy)
		if v8 or not v614 then
			return;
		else
			local _ = os.clock();
			local v616 = {};
			local v617 = v11:FireClientConnection(v614, "GetLocalPosData", "REMOTE_FUNCTION");
			if v617 then
				v617:gsub("[%d%.%-e]+", function(v618) --[[ Line: 2132 ]]
					-- upvalues: v616 (copy)
					table.insert(v616, (tonumber(v618)));
				end);
				v617 = Vector3.new(v616[4], v616[5], v616[6]);
			end;
			return v617 or v614.Character and v614.Character.PrimaryPart and v614.Character.PrimaryPart.CFrame.LookVector;
		end;
	end;
	v0.OnPlayingStateChanged = function(v619) --[[ Line: 2142 ]] --[[ Name: OnPlayingStateChanged ]]
		local l_LocalPlayer_4 = game.Players.LocalPlayer;
		local v621 = l_LocalPlayer_4.Character or l_LocalPlayer_4.CharacterAdded:Wait();
		task.spawn(v619, (tostring(v621.Parent)));
		v621:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 2146 ]]
			-- upvalues: v619 (copy), v621 (copy)
			v619((tostring(v621.Parent)));
		end);
	end;
	local v622 = {};
	v0.OnPlayerAdded = function(v623) --[[ Line: 2153 ]] --[[ Name: OnPlayerAdded ]]
		-- upvalues: l_Players_0 (copy), l_spawn_0 (copy), v622 (copy)
		for _, v625 in (l_Players_0:GetPlayers()) do
			l_spawn_0(v623, v625);
		end;
		table.insert(v622, v623);
	end;
	l_Players_0.PlayerAdded:Connect(function(v626) --[[ Line: 2161 ]]
		-- upvalues: v622 (copy), l_spawn_0 (copy)
		for _, v628 in v622 do
			l_spawn_0(v628, v626);
		end;
	end);
	v0.OnCharacterAdded = function(v629) --[[ Line: 2167 ]] --[[ Name: OnCharacterAdded ]]
		-- upvalues: v0 (copy)
		v0.OnPlayerAdded(function(v630) --[[ Line: 2168 ]]
			-- upvalues: v629 (copy)
			if v630.Character then
				v629(v630.Character, v630);
			end;
			v630.CharacterAdded:Connect(function() --[[ Line: 2172 ]]
				-- upvalues: v629 (ref), v630 (copy)
				v629(v630.Character, v630);
			end);
		end);
	end;
	v0.ValueBaseToTable = function(_, v632) --[[ Line: 2178 ]] --[[ Name: ValueBaseToTable ]]
		local v633 = {};
		local function v634(v635, v636) --[[ Line: 2181 ]] --[[ Name: recurse ]]
			-- upvalues: v634 (copy)
			for _, v638 in pairs(v635:GetChildren()) do
				local l_Name_0 = v638.Name;
				if v638:IsA("Folder") then
					v636[l_Name_0] = {};
					v634(v638, v636[l_Name_0]);
				else
					v636[l_Name_0] = v638.Value;
				end;
			end;
		end;
		v634(v632, v633);
		return v633;
	end;
	v0.ValueTableToBase = function(_, v641, v642) --[[ Line: 2197 ]] --[[ Name: ValueTableToBase ]]
		local v643 = {
			number = "IntValue", 
			boolean = "BoolValue", 
			string = "StringValue"
		};
		local function v644(v645, v646) --[[ Line: 2204 ]] --[[ Name: recurse ]]
			-- upvalues: v644 (copy), v643 (copy)
			for v647, v648 in pairs(v645) do
				if v647 ~= "NonInstanced" then
					if typeof(v648) == "table" then
						local l_v646_FirstChild_0 = v646:FindFirstChild(v647);
						if not l_v646_FirstChild_0 then
							l_v646_FirstChild_0 = Instance.new("Folder");
							l_v646_FirstChild_0.Name = v647;
							l_v646_FirstChild_0.Parent = v646;
						end;
						v644(v648, l_v646_FirstChild_0);
					else
						local l_v646_FirstChild_1 = v646:FindFirstChild(v647);
						if not l_v646_FirstChild_1 then
							local v651 = v643[typeof(v648)];
							l_v646_FirstChild_1 = Instance.new(v651);
							l_v646_FirstChild_1.Name = v647;
						end;
						l_v646_FirstChild_1.Value = v648;
						l_v646_FirstChild_1.Parent = v646;
					end;
				end;
			end;
		end;
		v644(v641, v642);
	end;
	v0.EmitParticles = function(_, v653) --[[ Line: 2233 ]] --[[ Name: EmitParticles ]]
		if typeof(v653) == "Instance" then
			v653 = v653:GetDescendants();
		end;
		for _, v655 in ipairs(v653) do
			if v655:IsA("ParticleEmitter") then
				local l_v655_Attribute_0 = v655:GetAttribute("EmitCount");
				local l_v655_Attribute_1 = v655:GetAttribute("EmitDelay");
				local v658 = v655:GetAttribute("EmitDuration") or v655:GetAttribute("Toggle") or not l_v655_Attribute_0;
				local function v659() --[[ Line: 2243 ]] --[[ Name: f ]]
					-- upvalues: v658 (copy), v655 (copy), l_v655_Attribute_0 (copy)
					if v658 then
						v655.Enabled = true;
						if typeof(v658) == "number" then
							task.delay(v658, function() --[[ Line: 2248 ]]
								-- upvalues: v655 (ref)
								if v655 then
									v655.Enabled = false;
								end;
							end);
							return;
						end;
					else
						v655:Emit(l_v655_Attribute_0);
					end;
				end;
				if l_v655_Attribute_1 then
					task.delay(l_v655_Attribute_1, v659);
				else
					v659();
				end;
			end;
		end;
	end;
	return table.freeze(v0);