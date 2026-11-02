-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local l_Debris_0 = game:GetService("Debris");
local v6 = {
	sprinting = true, 
	enableBezierPreview = true, 
	voidStars = {}, 
	maxVoidStars = 3
};
local v7 = require(l_ReplicatedStorage_0.Modules.Schematics.Lighting);
local v8 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v9 = require(game.ReplicatedStorage.Modules.Statuses);
local v10 = require(game.ReplicatedStorage.Modules.Sounds);
local v11 = require(l_ReplicatedStorage_0.Modules.Ragdolls);
local v12 = require(l_ReplicatedStorage_0.Modules.Network);
local v13 = require(game.ReplicatedStorage.Modules.Util);
local v14 = require(l_ReplicatedStorage_0.Modules.Device);
local function v23(v15, v16) --[[ Line: 24 ]] --[[ Name: waitForInput ]]
	-- upvalues: l_UserInputService_0 (copy)
	local v17 = nil;
	local v18 = nil;
	if v16 then
		task.delay(v16, function() --[[ Line: 29 ]]
			-- upvalues: v17 (ref), v18 (ref)
			if v17 == nil then
				print("waitForInput timed out");
				v18:Disconnect();
				v18 = nil;
				v17 = Enum.KeyCode.A;
			end;
		end);
	end;
	v18 = l_UserInputService_0.InputBegan:Connect(function(v19, v20) --[[ Line: 39 ]]
		-- upvalues: v15 (copy), v17 (ref), v18 (ref)
		if v20 then
			return;
		else
			for _, v22 in pairs(v15) do
				if v19.KeyCode == v22 or v19.UserInputType == v22 then
					v17 = v19;
					v18:Disconnect();
					print("detected input");
					return;
				end;
			end;
			return;
		end;
	end);
	repeat
		task.wait();
	until v17 ~= nil;
end;
v6.Created = function(_, v25) --[[ Line: 59 ]] --[[ Name: Created ]]
	-- upvalues: l_RunService_0 (copy), v13 (copy), v12 (copy), v6 (copy), l_ReplicatedStorage_0 (copy), l_UserInputService_0 (copy)
	if l_RunService_0:IsServer() then
		task.spawn(function() --[[ Line: 62 ]]
			-- upvalues: v25 (copy), v13 (ref)
			if not v25.Cache then
				v25.Cache = {};
			end;
			v25.Cache.ImplantAttackNoli = v13:LoadAnimationFromID(v25.Rig, v25.Config.Animations.ImplantAttackNoli);
			v25.Cache.StardrivenAttackNoli = v13:LoadAnimationFromID(v25.Rig, v25.Config.Animations.StardrivenCharge2HitNoli);
			v25.Cache.StardrivenNormalHit = v13:LoadAnimationFromID(v25.Rig, v25.Config.Animations.StardrivenCharge1Hit);
		end);
		v12:SetConnection("Detonate", "REMOTE_EVENT", function(v26) --[[ Line: 69 ]]
			-- upvalues: v25 (copy), v6 (ref)
			if v26 ~= v25.Player then
				return;
			else
				local l_PrimaryPart_0 = v26.Character.PrimaryPart;
				for _, v29 in pairs(v6.voidStars) do
					local l_voidstar_0 = v29.voidstar;
					local v31 = l_PrimaryPart_0.CFrame.LookVector:Dot(l_voidstar_0.CFrame.LookVector);
					print("dot:", v31);
					if v31 < -0.8 then
						print("detonating voidstar");
						v29.explode();
						return;
					end;
				end;
				return;
			end;
		end);
	end;
	if l_RunService_0:IsClient() and v25.Player == game.Players.LocalPlayer then
		v13:SetSpeedCap(v25.Rig, "NoliWalkSpeed", v25.Config.Speed);
		local _ = require(l_ReplicatedStorage_0.Systems.Character.Game.Sprinting);
		v25.Config.Assets.DecayCC:Clone().Parent = game.Lighting;
		l_UserInputService_0.InputBegan:Connect(function(v33, v34) --[[ Line: 101 ]]
			-- upvalues: v12 (ref)
			if v34 then
				return;
			else
				if v33.KeyCode == Enum.KeyCode.F then
					v12:FireServerConnection("Detonate", "REMOTE_EVENT");
				end;
				return;
			end;
		end);
	end;
end;
v6.OnIntroduction = function(_, v36, v37, v38) --[[ Line: 113 ]] --[[ Name: OnIntroduction ]]
	-- upvalues: v7 (copy), v13 (copy), l_Players_0 (copy)
	v7:SetCustomLighting(v36.Config.IntroLighting);
--	v37.FakeCrown.Transparency = 0;
	v37.Voidstar.Transparency = 1;
	v37.VoidstarCrown.Transparency = 1;
--	local l_Default_0 = workspace.Misc:FindFirstChild("Default");
	local v40 = true;
	task.spawn(function() --[[ Line: 123 ]]
		-- upvalues: v40 (ref), l_Default_0 (copy)
		while v40 do
--			for v41, v42 in pairs(l_Default_0.Voidstars:GetChildren()) do
--				v42.CFrame = v42.CFrame * CFrame.Angles(0, v41 % 2 == 0 and 0.0225 or -0.0225, 0);
--			end;
			task.wait();
		end;
	end);
	task.spawn(function() --[[ Line: 132 ]]
		-- upvalues: v40 (ref), l_Default_0 (copy)
		while v40 do
--			local l_Skybox_0 = l_Default_0.Skybox;
	--		l_Skybox_0.CFrame = l_Skybox_0.CFrame * CFrame.Angles(0, 0.004363323129985824, 0);
			task.wait();
		end;
	end);
	local l_v13_FOVMultiplier_0 = v13:CreateFOVMultiplier(l_Players_0.LocalPlayer, 0.375, "NoliIntroScene", v38);
	task.delay(1.98, function() --[[ Line: 141 ]]
		-- upvalues: l_v13_FOVMultiplier_0 (copy)
		l_v13_FOVMultiplier_0.Value = 0.275;
	end);
	task.delay(v38, function() --[[ Line: 145 ]]
		-- upvalues: v40 (ref), v37 (copy), v7 (ref)
		v40 = false;
	--	v37.FakeCrown.Transparency = 1;
		v37.VoidstarCrown.Transparency = 0;
		v37.Voidstar.Transparency = 0;
		v7:SetAsCurrentLighting();
	end);
end;
v6.KillerRemoved = function(_) --[[ Line: 154 ]] --[[ Name: KillerRemoved ]]
	local l_Decay_0 = game.Lighting:FindFirstChild("Decay");
	if l_Decay_0 then
		l_Decay_0:Destroy();
	end;
end;
local _ = function(_, v48, v49, v50) --[[ Line: 162 ]] --[[ Name: applyHallucination ]]
	-- upvalues: v9 (copy), v13 (copy)
	v9:ApplyStatus(v48, "Hallucination", v13:MergeTables({
		Level = v49, 
		Hidden = true, 
		Stackable = true
	}, v50));
end;
local function _(v52, v53) --[[ Line: 170 ]] --[[ Name: quadBezierCFrame ]]
	return v52[1]:Lerp(v52[2], v53):Lerp(v52[2]:Lerp(v52[3], v53), v53);
end;
v6.Abilities = {
	Stab = {
		LayoutOrder = 1, 
		Icon = "rbxassetid://93874368032471", 
		KeybindType = "MainAbility", 
		Callback = function(v55) --[[ Line: 182 ]] --[[ Name: Callback ]]
			-- upvalues: l_RunService_0 (copy), v10 (copy), v8 (copy), v13 (copy)
			if l_RunService_0:IsServer() then
				v55.AbilitiesDisabled = true;
				v10:Play(v55.Config.Sounds.Swing, {
					Parent = v55.Rig.PrimaryPart, 
					PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
					Volume = 0.25
				});
				task.delay(0.5, function() --[[ Line: 189 ]]
					-- upvalues: v8 (ref), v55 (copy), v13 (ref), v10 (ref)
					local _ = v8:CreateHitbox(v55.Player, {
						Size = Vector3.new(4.5, 6, 9, 0), 
						CFrameOffset = CFrame.new(0, 0, -2.5), 
						Damage = v55.Config.StabDamage, 
						Time = 0.2, 
						Knockback = 2, 
						HitMultiple = false, 
						ExecuteOnKill = true, 
						Connections = {
							Hit = function(v56, v57) --[[ Line: 201 ]] --[[ Name: Hit ]]
								-- upvalues: v13 (ref), v10 (ref), v55 (ref)
								v13:CreateSpeedMultiplier(v56, 1.5, "HitSpeedBonus", 1.25);
								if v57 then
									v10:Play(v55.Config.Sounds.Hit, {
										Parent = v55.Rig.PrimaryPart, 
										PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
										Volume = 0.25
									});
								end;
							end
						}
					});
				end);
				task.delay(1.65, function() --[[ Line: 212 ]]
					-- upvalues: v55 (copy)
					v55.AbilitiesDisabled = false;
				end);
				return;
			else
				if l_RunService_0:IsClient() then
					v55.Animations.Stab:Play(0.175);
				end;
				return;
			end;
		end
	}, 
	Stardriven = {
		LayoutOrder = 2, 
		Icon = "rbxassetid://93874368032471", 
		KeybindType = "AltAbility1", 
		Callback = function(v59) --[[ Line: 228 ]] --[[ Name: Callback ]]
			-- upvalues: l_RunService_0 (copy), v12 (copy), v8 (copy), v9 (copy), v13 (copy), v14 (copy), l_UserInputService_0 (copy), v23 (copy), l_TweenService_0 (copy)
			local l_Rig_0 = v59.Rig;
			local l_Config_0 = v59.Config;
			local l_Animations_0 = v59.Animations;
			if l_RunService_0:IsServer() then
				v59.AbilitiesDisabled = true;
				local v63 = 2;
				v12:SetConnection("NoliOnDash", "REMOTE_EVENT", function(_) --[[ Line: 237 ]]
					-- upvalues: l_Config_0 (copy), v63 (ref), v8 (ref), v59 (copy), v9 (ref), v13 (ref), v12 (ref), l_Rig_0 (copy)
					local v65 = l_Config_0.StardrivenTokenData[v63];
					v63 = v63 - 1;
					v8:CreateHitbox(v59.Player, {
						Size = Vector3.new(4, 4, 7, 0), 
						CFrameOffset = CFrame.new(0, 0, -5), 
						Time = v65.Lifetime + 0.1, 
						Knockback = 0.5, 
						HitMultiple = false, 
						Damage = v65.Damage, 
						Connections = {
							Hit = function(v66, v67) --[[ Line: 250 ]] --[[ Name: Hit ]]
								-- upvalues: v59 (ref), l_Config_0 (ref), v9 (ref), v13 (ref), v63 (ref), v12 (ref), l_Rig_0 (ref)
								if v67 then
									local l_v59_0 = v59;
									local v69 = {
										Duration = l_Config_0.StardrivenHallucinationDuration
									};
									v9:ApplyStatus(v66, "Hallucination", v13:MergeTables({
										Level = 1, 
										Hidden = true, 
										Stackable = true
									}, v69));
									print(v63);
									if v63 == 1 then
										v12:FireClientConnection(v59.Player, "NoliStardrivenHit", "REMOTE_EVENT", "Normal");
										print("a");
										return;
									else
										v12:FireClientConnection(v59.Player, "NoliStardrivenHit", "REMOTE_EVENT", "Slam");
										print("b");
										l_Rig_0.HumanoidRootPart.Anchored = true;
										v66.HumanoidRootPart.Anchored = true;
										l_Rig_0:SetAttribute("Invincible", true);
										v66:SetPrimaryPartCFrame(l_Rig_0.PrimaryPart.CFrame);
										l_v59_0 = v13:LoadAnimationFromID(v66, l_Config_0.Animations.StardrivenCharge2HitVictim, true);
										v59.Cache.StardrivenAttackNoli:Play(0);
										l_v59_0:Play(0);
										task.delay(l_v59_0.Length - 0.1, function() --[[ Line: 279 ]]
											-- upvalues: v66 (copy)
											v66.HumanoidRootPart.Anchored = false;
										end);
										task.delay(v59.Cache.StardrivenAttackNoli.Length - 0.1, function() --[[ Line: 282 ]]
											-- upvalues: l_Rig_0 (ref)
											l_Rig_0.HumanoidRootPart.Anchored = false;
										end);
									end;
								end;
							end
						}
					});
					if v63 == 0 then
						v59.AbilitiesDisabled = false;
					end;
				end);
				return;
			else
				local v70 = 2;
				local v71 = 0;
				local l_v14_PlayerDevice_0 = v14:GetPlayerDevice();
				local l_StardrivenTendrilStart_0 = l_Animations_0.StardrivenTendrilStart;
				l_StardrivenTendrilStart_0:Play(0, 1, 1);
				task.wait(l_StardrivenTendrilStart_0.Length - 0.1);
				local l_StardrivenTendrilLoop_0 = l_Animations_0.StardrivenTendrilLoop;
				l_StardrivenTendrilLoop_0:Play(0, 1, 1);
				local v75 = game.ReplicatedStorage.Assets.UI.ProgressBar:Clone();
				v75.Bar.Size = UDim2.fromScale(0, 0.75);
				v75.Parent = v59.Player.PlayerGui:FindFirstChild("TemporaryUI");
				local l_v13_SpeedMultiplier_0 = v13:CreateSpeedMultiplier(l_Rig_0, 0.5, "StardrivenChargeSlowness");
				task.spawn(function() --[[ Line: 320 ]]
					-- upvalues: v75 (copy), v71 (ref)
					while v75.Visible do
						v75.Bar.Size = UDim2.fromScale(math.clamp(v71, 0, 0.975), 0.75);
						print("ok");
						task.wait();
					end;
				end);
				if l_v14_PlayerDevice_0 == "PC" then
					v75.Title.Text = "Charge Stardriven (M2)";
					repeat
						if l_UserInputService_0:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
							v71 = v71 + 0.035;
							print(v71);
						end;
						task.wait();
					until v71 >= 1;
				end;
				v75.Visible = false;
				v75:Destroy();
				v71 = 1;
				local function v83() --[[ Line: 347 ]] --[[ Name: dash ]]
					-- upvalues: v23 (ref), l_v13_SpeedMultiplier_0 (copy), v70 (ref), l_Animations_0 (copy), v59 (copy), v13 (ref), l_Rig_0 (copy), l_TweenService_0 (ref), v12 (ref), l_StardrivenTendrilLoop_0 (copy)
					v23({
						Enum.UserInputType.MouseButton1
					});
					l_v13_SpeedMultiplier_0.Value = 1;
					local v77 = if v70 == 2 then l_Animations_0.StardrivenCharge1Start else l_Animations_0.StardrivenCharge2Start;
					local v78 = if v70 == 2 then l_Animations_0.StardrivenCharge1Loop else l_Animations_0.StardrivenCharge2Loop;
					v77:Play(0, 1, 1);
					v78:Play(0.125, 1, 1);
					local v79 = v59.Config.StardrivenTokenData[v70];
					local v80 = v13:ApplyVelocity(l_Rig_0, v79.Distance / 2, true, 0.1);
					l_TweenService_0:Create(v80, TweenInfo.new(0.1), {
						LineVelocity = v79.Distance
					}):Play();
					v12:SetConnection("NoliStardrivenHit", "REMOTE_EVENT", function(v81) --[[ Line: 376 ]]
						-- upvalues: v80 (ref), l_Animations_0 (ref)
						v80:Destroy();
						v80 = nil;
						if v81 == "Normal" then
							l_Animations_0.StardrivenCharge1Hit:Play(0);
						end;
					end);
					v12:FireServerConnection("NoliOnDash", "REMOTE_EVENT");
					v70 = v70 - 1;
					task.wait(v79.Lifetime);
					l_v13_SpeedMultiplier_0.Value = 0.5;
					local v82 = nil;
					if v80 then
						v82 = l_TweenService_0:Create(v80, TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
							LineVelocity = 0
						});
						v82:Play();
					end;
					v78:Stop(0.125);
					if v70 == 0 then
						l_v13_SpeedMultiplier_0:Destroy();
						l_StardrivenTendrilLoop_0:Stop(0.125);
					end;
					if v82 then
						v82.Completed:Wait();
						v80:Destroy();
					end;
				end;
				v83();
				v83();
				return;
			end;
		end
	}, 
	Implant = {
		LayoutOrder = 3, 
		Icon = "rbxassetid://93874368032471", 
		KeybindType = "AltAbility2", 
		Callback = function(v84, _) --[[ Line: 421 ]] --[[ Name: Callback ]]
			-- upvalues: l_RunService_0 (copy), v6 (copy), v13 (copy), v10 (copy), v12 (copy), v8 (copy), v11 (copy), l_Debris_0 (copy)
			local l_Rig_1 = v84.Rig;
			local l_Config_1 = v84.Config;
			local l_Animations_1 = v84.Animations;
			if l_RunService_0:IsServer() then
				local function v103(v89) --[[ Line: 427 ]] --[[ Name: implant ]]
					-- upvalues: v6 (ref), l_Rig_1 (copy), v13 (ref), v10 (ref), l_Config_1 (copy), l_RunService_0 (ref), v84 (copy)
					if #v6.voidStars < v6.maxVoidStars then
						local v90 = l_Rig_1.Voidstar:Clone();
						if v89 then
							v90.CFrame = v89.HumanoidRootPart.CFrame * CFrame.new(0, 0, -1);
							local l_WeldConstraint_0 = Instance.new("WeldConstraint");
							l_WeldConstraint_0.Part0 = v90;
							l_WeldConstraint_0.Part1 = v89.HumanoidRootPart;
							l_WeldConstraint_0.Parent = v90;
						else
							v90.Anchored = true;
							v90.CFrame = l_Rig_1.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0);
						end;
						v90.Parent = workspace.Misc;
						local l_Highlight_0 = Instance.new("Highlight");
						l_Highlight_0.FillTransparency = 0.5;
						l_Highlight_0.OutlineTransparency = 0.15;
						l_Highlight_0.FillColor = Color3.new(0.576471, 0.054902, 0.8);
						l_Highlight_0.OutlineColor = Color3.new(0.843137, 0.592157, 1);
						l_Highlight_0.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
						l_Highlight_0.Parent = v90;
						local v93 = {
							voidstar = v90, 
							revealedAuras = {}, 
							exploding = false
						};
						local function v98() --[[ Line: 457 ]] --[[ Name: explode ]]
							-- upvalues: v6 (ref), v93 (copy), v13 (ref), v90 (copy), v10 (ref), l_Config_1 (ref)
							local v94 = #v6.voidStars + 1;
							v93.exploding = true;
							--v13:EmitParticlesFromAttachment(v90.Explosion);
							v10:Play(l_Config_1.Sounds.Explosion, {
								Parent = v90, 
								Volume = 0.5
							});
							print("EXPLODE");
							local l_v13_ClosestPlayerFromPosition_0 = v13:GetClosestPlayerFromPosition(v90.Position, {
								MaxDistance = 45, 
								PlayerSelection = "Survivors", 
								ReturnTable = true
							});
							print(l_v13_ClosestPlayerFromPosition_0);
							for _, v97 in pairs(l_v13_ClosestPlayerFromPosition_0) do
								print((("%* in range of explosion"):format(v97.Player.Name)));
							end;
							if v93.radiusCheck then
								v93.radiusCheck:Disconnect();
							end;
							table.remove(v6.voidStars, v94);
						end;
						v93.explode = v98;
						if not v89 then
							v93.radiusCheck = l_RunService_0.Heartbeat:Connect(function(_) --[[ Line: 489 ]]
								-- upvalues: v93 (copy), v90 (copy), v13 (ref), v84 (ref), v98 (copy)
								for _, v101 in pairs(workspace.Players.Survivors:GetChildren()) do
									if v93.exploding then
										print("explodign");
										return;
									else
										local l_Magnitude_0 = (v90.Position - v101.HumanoidRootPart.Position).Magnitude;
										if l_Magnitude_0 <= 30 and not v93.revealedAuras[v101] then
											print((("revealing %* aura to noli"):format(v101.Name)));
											v13:RevealPlayerAuraTo(v84.Player, v101, 30, Color3.new(1, 0.75, 0));
											v93.revealedAuras[v101] = true;
										end;
										if l_Magnitude_0 <= 10 then
											v98();
										end;
									end;
								end;
							end);
						end;
						v93.decayThread = task.delay(l_Config_1.ImplantDecayTime, function() --[[ Line: 511 ]]
							-- upvalues: v98 (copy)
							v98();
						end);
						table.insert(v6.voidStars, v93);
					end;
				end;
				v12:SetConnection("NoliImplant", "REMOTE_EVENT", function(v104, v105) --[[ Line: 519 ]]
					-- upvalues: v84 (copy), v8 (ref), l_Rig_1 (copy), v13 (ref), l_Config_1 (copy), v103 (copy), v11 (ref), l_Debris_0 (ref), v6 (ref)
					if v104 ~= v84.Player then
						return;
					else
						local v106 = false;
						v8:CreateHitbox(v104, {
							Size = Vector3.new(8, 8, 8, 0), 
							CFrameOffset = CFrame.new(0, 0, -2), 
							Damage = 0, 
							Time = 0.1, 
							Connections = {
								Hit = function(v107, v108) --[[ Line: 532 ]] --[[ Name: Hit ]]
									-- upvalues: v106 (ref), l_Rig_1 (ref), v13 (ref), l_Config_1 (ref), v84 (ref), v103 (ref), v11 (ref), l_Debris_0 (ref)
									v106 = true;
									if v108 then
										l_Rig_1.HumanoidRootPart.Anchored = true;
										v107:PivotTo(l_Rig_1:GetPivot());
										v107.HumanoidRootPart.Anchored = true;
										local v109 = v13:LoadAnimationFromID(v107, l_Config_1.Animations.ImplantAttackVictim, true);
										local l_ImplantAttackNoli_0 = v84.Cache.ImplantAttackNoli;
										l_ImplantAttackNoli_0:Play(0);
										v109:Play(0);
										task.delay(0.2, function() --[[ Line: 546 ]]
											-- upvalues: v103 (ref), v107 (copy)
											v103(v107);
										end);
										task.delay(0.7, function() --[[ Line: 549 ]]
											-- upvalues: v11 (ref), v107 (copy), l_Debris_0 (ref), v13 (ref)
											v11:Enable(v107);
											l_Debris_0:AddItem(v13:ApplyVelocity(v107, -50), 0.25);
											task.wait(0.1);
											v11:Disable(v107);
										end);
										task.delay(l_ImplantAttackNoli_0.Length, function() --[[ Line: 556 ]]
											-- upvalues: l_Rig_1 (ref)
											l_Rig_1.HumanoidRootPart.Anchored = false;
										end);
										task.delay(v109.Length, function() --[[ Line: 559 ]]
											-- upvalues: v107 (copy)
											v107.HumanoidRootPart.Anchored = false;
										end);
									end;
								end, 
								Ended = function() --[[ Line: 564 ]] --[[ Name: Ended ]]
									-- upvalues: v106 (ref), v105 (copy), v103 (ref), v13 (ref), l_Rig_1 (ref), l_Config_1 (ref), v6 (ref)
									if v106 then
										return;
									elseif v105 == "Normal" then
										v103();
										return;
									else
										local v111 = v13:ApplyVelocity(l_Rig_1, 1, true);
										print("throwing bomb");
										v111:Destroy();
										task.wait(0.1);
										local v112 = l_Rig_1.Voidstar:Clone();
										v112.Anchored = true;
										v112.Parent = workspace;
										v112.CFrame = l_Rig_1.Voidstar.CFrame;
										local l_CFrame_0 = v112.CFrame;
										local v114 = l_CFrame_0 * CFrame.new(0, 0, -l_Config_1.ImplantBombThrowBaseRange);
										local v115 = {
											CFrame.new(l_CFrame_0.Position), 
											CFrame.new(l_CFrame_0:Lerp(v114, 0.5).Position + Vector3.new(0, 5, 0, 0)), 
											CFrame.new(v114.Position)
										};
										for v116 = 0, 1, 0.1 do
											l_CFrame_0 = v115[1]:Lerp(v115[2], v116):Lerp(v115[2]:Lerp(v115[3], v116), v116);
											v112.CFrame = l_CFrame_0;
											if v6.enableBezierPreview then
												local v117 = l_Rig_1.Voidstar:Clone();
												v117.BrickColor = BrickColor.Red();
												v117.Transparency = 0.5;
												v117.Anchored = true;
												v117.CFrame = l_CFrame_0;
												v117.Parent = workspace;
											end;
											print("setting bezier curve to voidstar");
										end;
										return;
									end;
								end
							}
						});
						return;
					end;
				end);
				return;
			else
				local v118 = "Implant";
				if l_Rig_1.Humanoid.MoveDirection.Magnitude > 0 then
					v118 = v118 .. "Dash";
					v13:CreateSpeedMultiplier(l_Rig_1, 0, "NoliPlacingTrap", 0.5);
					v12:FireServerConnection("NoliImplant", "REMOTE_EVENT", "Dash");
				else
					v12:FireServerConnection("NoliImplant", "REMOTE_EVENT", "Normal");
				end;
				l_Animations_1[v118]:Play(0);
				return;
			end;
		end
	}, 
	Hallucination = {
		LayoutOrder = 4, 
		Icon = "rbxassetid://93874368032471", 
		KeybindType = "AltAbility3", 
		Callback = function(v119) --[[ Line: 633 ]] --[[ Name: Callback ]]
			-- upvalues: v13 (copy), v10 (copy), v9 (copy)
			if game["Run Service"]:IsServer() then
				v119.AbilitiesDisabled = true;
				local l_HumanoidRootPart_0 = v119.Rig.HumanoidRootPart;
				local l_v13_ClosestPlayerFromPosition_1 = v13:GetClosestPlayerFromPosition(l_HumanoidRootPart_0.Position, {
					MaxDistance = v119.Config.HallucinationMaxDistance, 
					PlayerSelection = "Survivors", 
					OverrideUndetectable = true, 
					ReturnTable = true
				});
				v10:Play(v119.Config.Sounds.Hallucination, {
					Volume = 0.35, 
					Parent = l_HumanoidRootPart_0
				});
				for _, v123 in pairs(l_v13_ClosestPlayerFromPosition_1) do
					v13:RevealPlayerAura(v123.Player, v119.Config.HallucinationAuraRevealDuration);
					v9:ApplyStatus(v123.Player, "Hallucination", {
						Level = math.random(1, 3), 
						Duration = v119.Config.HallucinationDuration, 
						Hidden = true
					});
				end;
				task.delay(1.65, function() --[[ Line: 663 ]]
					-- upvalues: v119 (copy)
					v119.AbilitiesDisabled = false;
				end);
				return;
			else
				if game["Run Service"]:IsClient() then
					v119.Animations.Hallucination:Play(0.175);
				end;
				return;
			end;
		end
	}
};
return v6;