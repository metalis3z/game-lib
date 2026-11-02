-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("AnalyticsService");
local v1 = {
	CurrentActors = {}, 
	ActorAdded = nil
};
local l_RunService_0 = game:GetService("RunService");
local _ = l_RunService_0:IsClient();
local v4 = l_RunService_0:IsServer();
local v5 = require(game.ReplicatedStorage.Modules.Network);
local v6 = require(game.ReplicatedStorage.Modules.Sounds);
local v7 = require(game.ReplicatedStorage.Modules.Util);
local v8 = require(game.ReplicatedStorage.Systems.Player.Game.CharacterReplication);
local v9 = {
	Killer = "Slasher", 
	Survivor = "Noob"
};
local v10 = {
	Idle = "rbxassetid://111737198727712", 
	Walk = "rbxassetid://116517954138704", 
	Run = "rbxassetid://89696553696380", 
	InjuredIdle = "rbxassetid://123404194233932", 
	InjuredWalk = "rbxassetid://96815270152213", 
	InjuredRun = "rbxassetid://79815903830434"
};
v1.__len = function(v11) --[[ Line: 36 ]]
	-- upvalues: v1 (copy)
	local v12 = 0;
	for _, v14 in pairs(v1.CurrentActors) do
		local v15 = v14.Rig and v14.Rig:FindFirstChild("Humanoid");
		if v11.ActorName == v14.ActorName and v15 and v15.Health > 0 then
			v12 = v12 + 1;
		end;
	end;
	return v12;
end;
v1.CreateActor = function(_, v17, v18, v19, v20) --[[ Line: 47 ]] --[[ Name: CreateActor ]]
	-- upvalues: v1 (copy), v9 (copy), v4 (copy), v5 (copy), v6 (copy), v8 (copy), l_RunService_0 (copy), v7 (copy)
	if not v19 then
		local l_v1_EquippedActorInfo_0, v22 = v1:GetEquippedActorInfo(v17, v18);
		v19 = l_v1_EquippedActorInfo_0;
		v20 = v22;
	end;
	local v23 = nil;
	local v24 = nil;
	if typeof(v19) == "Instance" and v19:IsA("Folder") then
		v24 = v19;
	else
		v23 = game.ReplicatedStorage.Assets:FindFirstChild((("%*s"):format((tostring(v18)))));
		v24 = v23 and (v23:FindFirstChild((tostring(v19))) or v23:FindFirstChild((tostring(v9[v18]))));
	end;
	if v24 and v17.Character and v17.Character.PrimaryPart and v17.Character.Humanoid.Health > 0 and not v1.CurrentActors[v17] then
		local v25 = setmetatable({
			Cache = {}, 
			Cooldowns = {}, 
			AbilityDisablers = {}
		}, v1);
		v25.Player = v17;
		v25.Folder = v24;
		v25.ActorType = v18;
		v25.ActorName = v19;
		v25.ActorSkin = v20;
		v1:ApplySkinDataToActorInfo(v25);
		v25.IncrementCharges = function(_, v27, v28, v29) --[[ Line: 76 ]] --[[ Name: IncrementCharges ]]
			-- upvalues: v4 (ref), v25 (copy), v5 (ref), v17 (copy)
			if not v4 then
				warn((("attempt to add charges to %* on client!"):format((tostring(v27)))));
				return;
			else
				local v30 = v25 and v25.Behavior.Abilities and v25.Behavior.Abilities[v27];
				if not v30 then
					return;
				elseif not v30.CurrentCharges then
					return;
				else
					v30.CurrentCharges = math.clamp(v30.CurrentCharges + v28, 0, tonumber(v29) or 1e999);
					local v31 = nil;
					if v30.Recharge and v30.CurrentCharges < v30.Charges and not v30.RechargeStartTime then
						v31 = true;
						v30.RechargeStartTime = tick();
						v30.CurrentRechargeThread = task.delay(v30.Recharge, function() --[[ Line: 94 ]]
							-- upvalues: v30 (copy), v25 (ref), v27 (copy)
							v30.CurrentRechargeThread = nil;
							v30.RechargeStartTime = nil;
							v25:IncrementCharges(v27, 1, v30.Charges);
						end);
					elseif v30.RechargeStartTime and v30.CurrentCharges >= v30.Charges then
						pcall(task.cancel, v30.CurrentRechargeThread);
						v30.CurrentRechargeThread = nil;
						v30.RechargeStartTime = nil;
						v30.ElapsedRecharge = nil;
						v31 = false;
					end;
					v5:FireClientConnection(v17, "UpdateAbilityCharges", "REMOTE_EVENT", v27, v30.CurrentCharges, v31);
					return;
				end;
			end;
		end;
		v25.CanUseAbility = function(_, v33) --[[ Line: 111 ]] --[[ Name: CanUseAbility ]]
			-- upvalues: v25 (copy)
			local l_Player_0 = v25.Player;
			local l_Config_0 = v25.Config;
			local v36 = v25 and v25.Behavior;
			local v37 = v25 and v25.Cooldowns;
			local v38 = v36.Abilities[v33];
			if not l_Player_0 or not l_Config_0 or not v36 or not v37 or not v38 then
				return;
			elseif v37.CANT_ATTACK then
				return;
			elseif v38.CurrentCharges and v38.CurrentCharges <= 0 and not v38.ChargesOptional and not v38.ChargesDisabled and not workspace:GetAttribute("ChargesDisabled") then
				return;
			else
				if not workspace:GetAttribute("CooldownsDisabled") then
					if v25.DisabledAbilities and v25.DisabledAbilities[v33] then
						return;
					elseif v25.AbilitiesDisabled then
						return;
					elseif v25:IsOnCooldown(v33) then
						return;
					end;
				end;
				for _, v40 in pairs(v25.AbilityDisablers) do
					if v40 then
						return;
					end;
				end;
				if not l_Player_0 or not l_Player_0.Character then
					return;
				elseif l_Player_0.Character:GetAttribute("Ragdolling") then
					return;
				elseif l_Player_0.Character:GetAttribute("AbilitiesDisabled") then
					return;
				elseif l_Player_0.Character:GetAttribute("UsingAnimations") then
					return;
				elseif l_Player_0.Character:FindFirstChildOfClass("Tool") then
					return;
				else
					return true;
				end;
			end;
		end;
		v25.PlayVoiceline = function(_, v42, v43) --[[ Line: 142 ]] --[[ Name: PlayVoiceline ]]
			-- upvalues: v6 (ref), v25 (copy)
			v6:PlayVoiceline(v25, v42, v43);
		end;
		local l_pairs_0 = pairs;
		local v45 = v25.Behavior.Abilities or {};
		for _, v47 in l_pairs_0(v45) do
			if v47.Charges then
				v47.CurrentCharges = v47.Charges;
			end;
		end;
		v25.IsOnCooldown = function(_, v49) --[[ Line: 154 ]] --[[ Name: IsOnCooldown ]]
			-- upvalues: v25 (copy)
			local v50 = v25 and v25.Cooldowns;
			if v50[v49] and workspace:GetServerTimeNow() < v50[v49] then
				return v50[v49] - workspace:GetServerTimeNow();
			else
				return false;
			end;
		end;
		v25.SetCooldownOf = function(_, v52, v53) --[[ Line: 163 ]] --[[ Name: SetCooldownOf ]]
			-- upvalues: v25 (copy), v5 (ref), v17 (copy)
			local v54 = v25 and v25.Cooldowns;
			if not (v25 and v25.Behavior.Abilities and v25.Behavior.Abilities[v52]) then
				return;
			else
				if tonumber(v53) and v53 ~= 0 and not workspace:GetAttribute("CooldownsDisabled") then
					local v55 = v53 < 0 and v54[v52] and v54[v52] - workspace:GetServerTimeNow() + v53 or v53;
					v54[v52] = workspace:GetServerTimeNow() + v55;
				else
					v54[v52] = nil;
				end;
				v5:FireClientConnection(v17, "UpdateAbilityCooldown", "REMOTE_EVENT", v52, v53);
				return;
			end;
		end;
		l_pairs_0 = {};
		v25.DisableAbilities = function(_, v57, v58, v59) --[[ Line: 185 ]] --[[ Name: DisableAbilities ]]
			-- upvalues: v25 (copy), l_pairs_0 (copy)
			v25.AbilityDisablers[v57] = v58;
			if v59 then
				if l_pairs_0[v57] then
					pcall(task.cancel, l_pairs_0[v57]);
					l_pairs_0[v57] = nil;
				end;
				l_pairs_0[v57] = task.delay(v59, function() --[[ Line: 193 ]]
					-- upvalues: v25 (ref), v57 (copy), v58 (copy)
					v25.AbilityDisablers[v57] = not v58;
				end);
			end;
		end;
		v25.PivotTo = function(_, v61) --[[ Line: 199 ]] --[[ Name: PivotTo ]]
			-- upvalues: v4 (ref), v25 (copy), v8 (ref)
			assert(v4, "Do not.");
			v25.Rig:PivotTo(v61);
			local _ = require(game.ServerScriptService.Server.Miscellaneous.CharacterReplication);
			local v63 = v25.ClientV or v25.Rig.PrimaryPart.AssemblyLinearVelocity;
			v25.SerializedCF = v8.Serialize(v61, v63);
			v25.ClientCF = v61;
			v25.ClientV = v63;
			v25.LastClientCFUpdateTime = tick();
			if v25.Player and v25.Rig:HasTag("Replicating") then
				local l_QueryHitbox_0 = v25.Rig:FindFirstChild("QueryHitbox");
				if l_QueryHitbox_0 then
					l_QueryHitbox_0.CollisionConnector.Enabled = false;
					l_QueryHitbox_0.Anchored = true;
					l_QueryHitbox_0.CFrame = v61;
				end;
			end;
		end;
		v25.GetPivot = function(_, v66) --[[ Line: 221 ]] --[[ Name: GetPivot ]]
			-- upvalues: v4 (ref), v25 (copy), l_RunService_0 (ref), v17 (copy)
			assert(v4, "Do not.");
			local l_Rig_0 = v25.Rig;
			local v68 = l_Rig_0 and l_Rig_0.PrimaryPart;
			if not v68 then
				return;
			elseif not workspace:GetAttribute("ExperimentalHitboxes") then
				return v68.CFrame;
			elseif v25.LastClientCFUpdateTime and v25.ServerCurrentCF and v25.ClientV and tick() - v25.LastClientCFUpdateTime < 0.35 then
				local l_ServerCurrentCF_0 = v25.ServerCurrentCF;
				local l_ClientV_0 = v25.ClientV;
				--print(l_ClientV_0)
				if v66 then
					local v71 = math.clamp(tick() - v25.LastClientCFUpdateTime, 0, 0.15);
					l_ServerCurrentCF_0 = l_ServerCurrentCF_0 + l_ClientV_0 * ((l_RunService_0:IsStudio() and 0.1 or math.clamp(v17:GetNetworkPing(), 0, 0.125) + 0.04) + v71);
				end;
				return l_ServerCurrentCF_0;
			else
				return v68.CFrame;
			end;
		end;
		v7:PreloadAssets(v25.Config);
		if v25.Behavior.GetRig then
			v25.Rig = v25.Behavior:GetRig(v25);
			v25.RigName = v25.Rig.Name;
		else
			v25.Rig = v25.Rig and v25.Rig:Clone() or nil;
		end;
		if not v25.Rig then
			v17:LoadCharacter();
			return;
		else
			if not v25.Rig:FindFirstChild("Humanoid") then
				v45 = Instance.new("Humanoid");
				v45.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
				v45.Parent = v25.Rig;
				Instance.new("Animator").Parent = v45;
			end;
			v45 = game.ReplicatedStorage.Assets.Skins[("%*s"):format(v18)]:FindFirstChild(v19);
			local v72 = v45 and v45:FindFirstChild((tostring(v20)));
			local v73 = v72 and require(v72.Config);
			local v74 = v17.Character and v17.Character.PrimaryPart;
			local l_Humanoid_0 = v25.Rig.Humanoid;
			l_Humanoid_0.JumpHeight = 0;
			l_Humanoid_0.JumpPower = 0;
			l_Humanoid_0.MaxSlopeAngle = 65;
			l_Humanoid_0.BreakJointsOnDeath = false;
			l_Humanoid_0.HipHeight = v25.Config.HipHeight or 0;
			l_Humanoid_0.WalkSpeed = v25.Config.Speed or 16;
			l_Humanoid_0.MaxHealth = v25.Config.Health or 100;
			l_Humanoid_0.Health = l_Humanoid_0.MaxHealth;
			l_Humanoid_0:SetAttribute("BaseSpeed", l_Humanoid_0.WalkSpeed);
			v25.Rig.Name = v24.Name;
			v25.Rig:SetAttribute("Username", v17.Name);
			v25.Rig:SetAttribute("SkinName", (tostring(v20)));
			v25.Rig:SetAttribute("SkinNameDisplay", v73 and v73.DisplayName or "");
			v25.Rig:SetAttribute("ActorDisplayName", (tostring(v25.Config.DisplayName)));
			if workspace:GetAttribute("ExperimentalReplication") then
				v25.Rig:AddTag("Replicating");
			end;
			if v74 then
				v25.Rig:SetPrimaryPartCFrame(v74.CFrame);
			end;
			if v25.Config.DirectionalMovementDisabled then
				v25.Rig:SetAttribute("DirectionalMovementDisabled", true);
			end;
			if v25.Config.Sounds and v25.Config.Sounds.Ambience then
				v6:Play(v25.Config.Sounds.Ambience, {
					Parent = v25.Rig.PrimaryPart, 
					Looped = true
				});
			end;
			l_Humanoid_0.Died:Once(function() --[[ Line: 308 ]]
				-- upvalues: v25 (copy), v6 (ref), v17 (copy), v1 (ref)
				local l_PrimaryPart_0 = v25.Rig.PrimaryPart;
				if l_PrimaryPart_0 then
					(v6:Play("deadJ" .. v17.Name, {
						Parent = l_PrimaryPart_0
					}) or v6:Play("dead", {
						Parent = l_PrimaryPart_0
					})):SetAttribute("Bypassable", true);
				end;
				v6:PlayVoiceline(v25, "Died", {
					Priority = 10
				});
				v1:CleanupActorFromPlayer(v17);
			end);
			local l_Pants_0 = v25.Rig:FindFirstChildOfClass("Pants");
			local l_Shirt_0 = v25.Rig:FindFirstChildOfClass("Shirt");
			local l_ShirtGraphic_0 = v25.Rig:FindFirstChildOfClass("ShirtGraphic");
			if l_Pants_0 and l_Pants_0.PantsTemplate == "" then
				l_Pants_0.PantsTemplate = l_Pants_0:GetAttribute("ID") or "";
			end;
			if l_Shirt_0 and l_Shirt_0.ShirtTemplate == "" then
				l_Shirt_0.ShirtTemplate = l_Shirt_0:GetAttribute("ID") or "";
			end;
			if l_ShirtGraphic_0 and l_ShirtGraphic_0.Graphic then
				l_ShirtGraphic_0.Graphic = l_ShirtGraphic_0:GetAttribute("ID") or "";
			end;
			require(game.ReplicatedStorage.Modules.Maps):GenerateKillerScene(v25.Rig, "Intro");
			local v80 = v25.RigName and v25.Config[("Expressions%*"):format(v25.RigName)] or v25.Config.Expressions;
			if v80 and not v25.Rig.Head:FindFirstChild("face") then
				local v81 = v25.Rig:FindFirstChild("ExpressionHolder", true) or game.ReplicatedStorage.Assets.Instances.ExpressionHolder:Clone();
				if not v81.Parent then
					v81.Parent = v25.Rig;
					v81.CFrame = v25.Rig.Head.CFrame * CFrame.new(0, 0, -0.005);
					local l_WeldConstraint_0 = Instance.new("WeldConstraint");
					l_WeldConstraint_0.Part0 = v25.Rig.Head;
					l_WeldConstraint_0.Part1 = v81;
					l_WeldConstraint_0.Parent = v81;
				end;
				local v83 = v81:FindFirstChildOfClass("Decal") or Instance.new("Decal");
				if not v83.Parent then
					v83.Parent = v81;
				end;
				v83.Name = "Expression";
				local v84 = nil;
				do
					local l_v84_0 = v84;
					v25.ChangeExpression = function(_, v87, v88) --[[ Line: 362 ]] --[[ Name: ChangeExpression ]]
						-- upvalues: v80 (ref), v25 (copy), l_v84_0 (ref), v83 (copy), l_Humanoid_0 (copy)
						v80 = v25.RigName and v25.Config[("Expressions%*"):format(v25.RigName)] or v25.Config and v25.Config.Expressions;
						if not v25.Rig.Parent then
							return;
						elseif not v80 or not v80[v87] then
							return;
						else
							if l_v84_0 then
								task.cancel(l_v84_0);
							end;
							if v87 == "Default" then
								v83.Texture = l_Humanoid_0.Health <= l_Humanoid_0.MaxHealth / 2 and v80.Injured or v80.Default;
							else
								v83.Texture = v80[v87];
							end;
							pcall(v25.Behavior.onExpressionChanged, v25.Behavior, v25, v87, v88);
							if v88 then
								l_v84_0 = task.delay(v88, function() --[[ Line: 381 ]]
									-- upvalues: l_Humanoid_0 (ref), v80 (ref), v83 (ref), v25 (ref)
									local v89 = l_Humanoid_0.Health <= l_Humanoid_0.MaxHealth / 2;
									if v80 then
										v83.Texture = v89 and v80.Injured or v80.Default;
									end;
									pcall(v25.Behavior.onExpressionChanged, v25.Behavior, v25, v89 and "Injured" or "Default", nil);
								end);
							end;
							return;
						end;
					end;
					v83.Texture = v80.Default or "";
					local l_Health_0 = l_Humanoid_0.Health;
					l_Humanoid_0.HealthChanged:Connect(function(v91) --[[ Line: 396 ]]
						-- upvalues: v25 (copy), l_v84_0 (ref), l_Health_0 (ref), v80 (ref), v6 (ref)
						if v91 <= 0 then
							v25:ChangeExpression("Dead");
							v25.ChangeExpression = function() --[[ Line: 402 ]]

							end;
							if l_v84_0 then
								pcall(task.cancel, l_v84_0);
							end;
							l_v84_0 = nil;
						elseif v91 < l_Health_0 and v80.Hurt then
							v25:ChangeExpression("Hurt", 0.75);
						elseif l_Health_0 + 20 < v91 and v80.Happy then
							v25:ChangeExpression("Happy", 0.75);
						else
							v25:ChangeExpression("Default");
						end;
						if l_Health_0 - v91 >= 15 then
							v6:PlayVoiceline(v25, "Injured", {
								Priority = 5
							});
						end;
						l_Health_0 = v91;
					end);
				end;
			else
				v25.ChangeExpression = function(_, _, _) --[[ Line: 427 ]] --[[ Name: ChangeExpression ]]

				end;
			end;
			for _, v96 in pairs(workspace.Players:GetChildren()) do
				if v96.Name:find(v18) then
					v25.Rig.Parent = v96;
					break;
				end;
			end;
			task.spawn(function() --[[ Line: 439 ]]
				-- upvalues: v25 (copy), v7 (ref)
				for v97, v98 in pairs(v25.Config.Animations) do
					if tostring(v97):find("Execution") and typeof(v98) == "table" then
						v25.Cache[("%*Anim"):format(v97)] = v7:LoadAnimationFromID(v25.Rig, v98.KillerRig, true);
					end;
				end;
			end);
			task.spawn(function() --[[ Line: 448 ]]
				-- upvalues: v25 (copy), v6 (ref)
				if v25.Config.Voicelines and v25.Config.Voicelines.Idle then
					while task.wait(math.random(10, 25)) and v25 and v25.Rig and v25.Rig.PrimaryPart do
						if not v25.Rig.PrimaryPart:FindFirstChild("VoicelineSFX") then
							v6:PlayVoiceline(v25, "Idle", {
								Priority = 0
							});
						end;
					end;
				end;
			end);
			if v17.Character then
				v17.Character:Destroy();
			end;
			v17.Character = v25.Rig;
			v7:FixCharacter(v25.Rig, (("%*s"):format(v18)));
			v7:AddHitboxes(v25, (("%*s"):format(v18)));
			local v99 = v7:CopyTable(v25);
			v99.Information = nil;
			v99.Behavior = nil;
			v99.Config = nil;
			v5:FireAllClientConnection("ActorCreated", "REMOTE_EVENT", v99);
			for _, v101 in pairs({
				"Created", 
				"CreatedPost"
				}) do
				if v25.Behavior[v101] then
					v25.Behavior[v101](v25.Behavior, v25);
				end;
			end;
			local v102 = v25.Config.SprintSpeed or 26;
			local l_l_Humanoid_0_Attribute_0 = l_Humanoid_0:GetAttribute("BaseSpeed");
			v7:SetSpeedCap(v17, "Sprinting", v102 / l_l_Humanoid_0_Attribute_0);
			v1.CurrentActors[v17] = v25;
			v1.__actorCreated:Fire(v25);
			return v25;
		end;
	else
		return;
	end;
end;
v1.CleanupActorFromPlayer = function(_, v105) --[[ Line: 497 ]] --[[ Name: CleanupActorFromPlayer ]]
	-- upvalues: v1 (copy), v5 (copy)
	local v106 = v1.CurrentActors[v105];
	if v106 then
		if v106.Behavior and v106.Behavior.Destroyed then
			v106.Behavior:Destroyed(v106);
		end;
		v5:FireAllClientConnection("ActorDestroyed", "REMOTE_EVENT", v105);
		v1.__actorDestroyed:Fire(v106);
		if v105.Character then
			v105.Character:RemoveTag("Replicating");
		end;
		v1.CurrentActors[v105] = nil;
	end;
end;
v1.GetEquippedActorInfo = function(_, v108, v109) --[[ Line: 521 ]] --[[ Name: GetEquippedActorInfo ]]
	local l_PlayerData_0 = v108:FindFirstChild("PlayerData");
	local v111 = l_PlayerData_0 and l_PlayerData_0:FindFirstChild("Equipped");
	local v112 = v111 and v111:FindFirstChild(v109) and v111[v109].Value or "";
	local v113 = v111 and v111:FindFirstChild("Skins");
	return v112, v113 and v113:FindFirstChild(v112) and v113[v112].Value or "";
end;
v1.GetAmountOfLivingActorsOfClass = function(_, v115) --[[ Line: 533 ]] --[[ Name: GetAmountOfLivingActorsOfClass ]]
	-- upvalues: v1 (copy)
	local v116 = 0;
	for _, v118 in pairs(v1.CurrentActors) do
		if v118.Config and v118.Config.Class == v115 then
			v116 = v116 + 1;
		end;
	end;
	return v116;
end;
v1.ApplySkinDataToActorInfo = function(_, v120) --[[ Line: 543 ]] --[[ Name: ApplySkinDataToActorInfo ]]
	-- upvalues: v7 (copy), v10 (copy)
	local v121 = game["Run Service"]:IsServer();
	local l_Folder_0 = v120.Folder;
	local l_ActorType_0 = v120.ActorType;
	local l_ActorName_0 = v120.ActorName;
	local l_ActorSkin_0 = v120.ActorSkin;
	v120.Config = v7:CopyTable(require(l_Folder_0.Config));
	v120.Behavior = v7:CopyTable(require(l_Folder_0.Behavior));
	if v121 then
		v120.Rig = v120.Config.Rig;
	end;
	for v126, v127 in pairs(v10) do
		if not v120.Config.Animations[v126] then
			v120.Config.Animations[v126] = v127;
		end;
	end;
	local l_FirstChild_0 = game.ReplicatedStorage.Assets.Skins:FindFirstChild(tostring(l_ActorType_0) .. "s");
	local v129 = l_FirstChild_0 and l_FirstChild_0:FindFirstChild(l_ActorName_0);
	local v130 = l_ActorSkin_0 and v129 and v129:FindFirstChild(l_ActorSkin_0);
	v120.SkinFolder = v130;
	if v130 then
		local v131 = v130:FindFirstChild("Config") and require(v130.Config);
		local v132 = v130:FindFirstChild("Behavior") and require(v130.Behavior);
		local v133 = v121 and v131 and v131.Rig;
		local v134 = v7:MergeTables(v120.Config, v131, {
			"DisplayName", 
			"TextInteractions"
		});
		local v135 = v7:MergeTables(v120.Behavior, v132);
		v120.Config = v134;
		v120.Behavior = v135;
		v120.SkinFolder = v130;
		if v133 then
			v120.Rig = v133;
		end;
		return v130;
	else
		return;
	end;
end;
v1.CreateChatInteraction = function(_, v137, v138, v139) --[[ Line: 591 ]] --[[ Name: CreateChatInteraction ]]
	-- upvalues: v1 (copy), v7 (copy)
	if typeof(v137) == "Instance" then
		v137 = v1.CurrentActors[v137] or v1.CurrentActors[game.Players:GetPlayerFromCharacter(v137)];
	end;
	if typeof(v139) == "Instance" then
		v139 = v1.CurrentActors[v139] or v1.CurrentActors[game.Players:GetPlayerFromCharacter(v139)];
	end;
	if not v137 then
		return;
	else
		local l_TextInteractions_0 = v137.Config.TextInteractions;
		if not l_TextInteractions_0 then
			return;
		else
			local l_l_TextInteractions_0_0 = l_TextInteractions_0;
			local v142 = string.split(v138, "/");
			for _, v144 in pairs(v142) do
				l_l_TextInteractions_0_0 = l_l_TextInteractions_0_0[("%*%*"):format(v139 and tostring(v139.ActorSkin):gsub(v139.ActorName, "") or "", v144)] or l_l_TextInteractions_0_0[v144] or l_l_TextInteractions_0_0.Regular;
				if not l_l_TextInteractions_0_0 then
					return;
				end;
			end;
			local v145 = l_l_TextInteractions_0_0[math.random(#l_l_TextInteractions_0_0)];
			if v145 then
				if typeof(v145) == "table" then
					task.spawn(function() --[[ Line: 613 ]]
						-- upvalues: v145 (copy), v137 (ref), v139 (ref), v7 (ref)
						for _, v147 in pairs(v145) do
							local v148 = nil;
							local v149 = string.split(v147, " ");
							if v149[1]:find(":") then
								if v149[1]:find(v137.ActorName) then
									v148 = v137.Rig;
								elseif v139 and v149[1]:find(v139.ActorName) then
									v148 = v139.Rig;
								end;
								table.remove(v149, 1);
							end;
							v7:DisplayBubble(v148, table.concat(v149, " "));
							task.wait((math.clamp(#v149 / 2 + v147:len(), 1, 4)));
						end;
					end);
				else
					v7:DisplayBubble(v137.Rig, v145);
				end;
			end;
			return;
		end;
	end;
end;
v1.IncrementActorStats = function(_, v151, v152) --[[ Line: 637 ]] --[[ Name: IncrementActorStats ]]
	-- upvalues: v1 (copy), v7 (copy), v5 (copy)
	if workspace:GetAttribute("ServerType") == "VIP" then
		return;
	elseif typeof(v151) ~= "Instance" and not v151:IsA("Player") then
		return;
	else
		local v153 = ({
			Support = {
				Money = 8, 
				EXP = 12, 
				KillerChance = 0.5
			}, 
			Offensive = {
				Money = 5, 
				EXP = 15, 
				KillerChance = 0.75
			}, 
			Survivalist = {
				Money = 3, 
				EXP = 12, 
				KillerChance = 0.25
			}, 
			VeryDifficultKillerAction = {
				Money = 20, 
				EXP = 60
			}, 
			DifficultKillerAction = {
				Money = 12, 
				EXP = 36
			}, 
			RegularKillerAction = {
				Money = 8, 
				EXP = 24
			}, 
			EasyKillerAction = {
				Money = 4, 
				EXP = 12
			}
		})[v152.RewardType];
		if v153 then
			v152.Money = tonumber(v153.Money) or v152.Money;
			v152.EXP = tonumber(v153.EXP) or v152.EXP;
		end;
		task.spawn(function() --[[ Line: 685 ]]
			-- upvalues: v152 (copy), v1 (ref), v151 (copy), v7 (ref), v5 (ref)
			local v154 = false;
			if v152.EXP then
				local v155 = v1.CurrentActors[v151];
				local v156 = v155 and v155.Folder;
				if v156 then
					local l_PlayerData_1 = v151:FindFirstChild("PlayerData");
					local v158 = l_PlayerData_1 and l_PlayerData_1:FindFirstChild("Purchased");
					local v159 = v158 and v158:FindFirstChild((("%*s"):format((tostring(v155 and v155.ActorType)))));
					if v159 then
						local v160 = require(game.ServerScriptService.Server.Miscellaneous.TrackPlayerFriendBoost);
						local v161 = v151:GetAttribute("EXPMultiplier") or 1;
						local l_l_PlayerData_1_FirstChild_0 = l_PlayerData_1:FindFirstChild("EXPBoostTime", true);
						if l_l_PlayerData_1_FirstChild_0 and l_l_PlayerData_1_FirstChild_0.Value > 0 then
							v161 = v161 + 0.25;
						end;
						local l_v160_PlayerBoost_0 = v160:GetPlayerBoost(v151);
						if l_v160_PlayerBoost_0 then
							warn((("[%* :: IncrementActorStats]: Got friend EXP: %* for %*"):format(script, l_v160_PlayerBoost_0, v151)));
							v161 = v161 + l_v160_PlayerBoost_0;
						end;
						if tonumber(v152.EXP) then
							local l_v152_0 = v152;
							l_v152_0.EXP = l_v152_0.EXP * v161;
						end;
						v152.EXP = tonumber(string.format("%.2f", v152.EXP));
						local l_v159_FirstChild_0 = v159:FindFirstChild(v156.Name);
						if l_v159_FirstChild_0 then
							l_v159_FirstChild_0.Value = l_v159_FirstChild_0.Value + tonumber(v152.EXP);
							v154 = true;
						end;
					end;
				end;
			end;
			v7:AddToPlayerStat(v151, "Money", v152.Money);
			v7:AddToPlayerStat(v151, "KillerChance", v152.KillerChance);
			if typeof(v152.Action) == "string" then
				local v166 = tostring(v152.Action);
				local v167 = {
					v152.Money and ("%*$"):format((tostring(v152.Money))), 
					v154 and v152.EXP and ("%* EXP"):format((tostring(v152.EXP))) or nil
				};
				local v168 = table.concat(v167, " & ");
				v5:FireClientConnection(v151, "SendNotif", "REMOTE_EVENT", ("+ %*: %*"):format(v168, v166), "Objective");
			end;
		end);
		return;
	end;
end;
v1.CreateCutsceneActor = function(_, v170, v171) --[[ Line: 737 ]] --[[ Name: CreateCutsceneActor ]]
	-- upvalues: v7 (copy)
	local v172 = v170.Config.Animations[v171];
	if not v172 then
		return;
	else
		local v173 = {
			"KillerRig", 
			"CameraRig"
		};
		local v174 = v170.Rig:Clone();
		v174:RemoveTag("Replicating");
		for _, v176 in ipairs(v174:GetChildren()) do
			if v176:GetAttribute("Hitbox") then
				v176:Destroy();
			end;
		end;
		local v177 = (v170.SkinFolder and v170.SkinFolder:FindFirstChild((("%*CameraRig"):format(v171))) or v170.Folder:FindFirstChild((("%*CameraRig"):format(v171))) or v170.SkinFolder and v170.SkinFolder:FindFirstChild("CameraRig") or v170.Folder:FindFirstChild("CameraRig") or game.ReplicatedStorage.Assets.Instances.CameraRig):Clone();
		game.Debris:AddItem(v174, 30);
		game.Debris:AddItem(v177, 30);
		v174:WaitForChild("HumanoidRootPart").Anchored = true;
		v177:WaitForChild(v177:GetAttribute("RootName") or "HumanoidRootPart").Anchored = true;
		v174:SetPrimaryPartCFrame(CFrame.new(0, 10000, 0));
		v177:SetPrimaryPartCFrame(CFrame.new(0, 10000, 0));
		v174.Name = v170.Player.Name .. "ActorRig";
		v177.Name = v170.Player.Name .. "CameraRig";
		v174.Parent = workspace.Misc;
		v177.Parent = workspace.Misc;
		local v178 = {};
		for _, v180 in pairs(v173) do
			local v181 = v172[v180];
			local v182 = v172[("%*Loop"):format(v180)];
			if v181 then
				v178[v180] = v7:LoadAnimationFromID(v180:find("Killer") and v174 or v177, v181, true);
			end;
			if v182 then
				v178[("%*Loop"):format(v180)] = v7:LoadAnimationFromID(v180:find("Killer") and v174 or v177, v182, true);
			end;
		end;
		local _ = task.spawn(function() --[[ Line: 798 ]]
			-- upvalues: v177 (copy)
			local l_CurrentCamera_0 = workspace.CurrentCamera;
			local v184 = v177:GetAttribute("CameraName") or "CameraPart";
			local l_v177_FirstChild_0 = v177:FindFirstChild(v184);
			while v177.Parent do
				if l_v177_FirstChild_0 then
					l_CurrentCamera_0.CameraType = Enum.CameraType.Scriptable;
					l_CurrentCamera_0.CFrame = l_v177_FirstChild_0.CFrame;
				end;
				task.wait();
			end;
			local l_LocalPlayer_0 = game.Players.LocalPlayer;
			local v187 = l_LocalPlayer_0.Character and l_LocalPlayer_0.Character:FindFirstChild("Humanoid");
			if v187 then
				l_CurrentCamera_0.CameraSubject = v187;
			end;
			l_CurrentCamera_0.CameraType = Enum.CameraType.Custom;
		end);
		task.delay(v178.CameraRig.Length - 0.1, function() --[[ Line: 821 ]]
			-- upvalues: v178 (copy)
			for v189, v190 in pairs(v178) do
				if not v189:find("Loop") then
					if v178[("%*Loop"):format(v189)] then
						v178[("%*Loop"):format(v189)]:Play(0);
						v190:Stop();
					else
						v190:AdjustSpeed(0);
					end;
				end;
			end;
		end);
		for _, v192 in pairs(v178) do
			v192:Play(0);
		end;
		return v174, v177, v178;
	end;
end;
v1.Start = function(_) --[[ Line: 841 ]] --[[ Name: Start ]]
	-- upvalues: v4 (copy), v1 (copy), v5 (copy)
	if v4 then
		local v194 = require(game.ServerScriptService.Server.Miscellaneous.CharacterReplication);
		game.Players.PlayerRemoving:Connect(function(v195) --[[ Line: 846 ]]
			-- upvalues: v1 (ref)
			v1:CleanupActorFromPlayer(v195);
		end);
		v5:SetConnection("UpdCF", "UREMOTE_EVENT", v194.Received);
	end;
	local v196 = {
		__actorCreated = "ActorAdded", 
		__actorDestroyed = "ActorRemoved"
	};
	for v197, v198 in pairs(v196) do
		v1[v197] = Instance.new("BindableEvent");
		v1[v197].Name = v197;
		v1[v197].Parent = script;
		v1[v198] = v1[v197].Event;
	end;
end;
return v1;