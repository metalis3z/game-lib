-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
v0.Abilities = {
	Punch = {
		LayoutOrder = 1, 
		Icon = "rbxassetid://93874368032471", 
		KeybindType = "MainAbility", 
		Cooldown = 2, 
		Callback = function(v5) --[[ Line: 15 ]] --[[ Name: Callback ]]
			-- upvalues: v1 (copy), v3 (copy), v2 (copy)
			if game["Run Service"]:IsServer() then
				v5.AbilitiesDisabled = true;
				v1:Play(v5.Config.Sounds.Swing, {
					Parent = v5.Rig.PrimaryPart, 
					PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
					Volume = 0.25
				});
				task.delay(0.1, function() --[[ Line: 22 ]]
					-- upvalues: v3 (ref), v5 (copy), v2 (ref), v1 (ref)
					local _ = v3:CreateHitbox(v5.Player, {
						Size = Vector3.new(4.5, 6, 5, 0), 
						CFrameOffset = CFrame.new(0, 0, -1.5), 
						Damage = v5.Config.AttackDamage, 
						Time = 0.3, 
						Knockback = 2, 
						HitMultiple = false, 
						ExecuteOnKill = true, 
						Connections = {
							Hit = function(v6) --[[ Line: 34 ]] --[[ Name: Hit ]]
								-- upvalues: v2 (ref), v1 (ref), v5 (ref)
								v2:CreateSpeedMultiplier(v6, 1.5, "HitSpeedBonus", 1.25);
								v1:Play(v5.Config.Sounds.Hit, {
									Parent = v5.Rig.PrimaryPart, 
									PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
									Volume = 0.25
								});
							end
						}
					});
				end);
				task.delay(0.75, function() --[[ Line: 43 ]]
					-- upvalues: v5 (copy)
					v5.AbilitiesDisabled = false;
				end);
				return;
			else
				if game["Run Service"]:IsClient() then
					v5.Animations.Attack:Play(0.025);
					v5.Animations.Attack:AdjustSpeed(4);
				end;
				return;
			end;
		end
	}, 
	CorruptNature = {
		LayoutOrder = 2, 
		Icon = "rbxassetid://81200466982776", 
		KeybindType = "AltAbility1", 
		Cooldown = 16, 
		Callback = function(v8) --[[ Line: 60 ]] --[[ Name: Callback ]]
			-- upvalues: v1 (copy), v2 (copy), v3 (copy), v4 (copy)
			if game["Run Service"]:IsServer() then
				v8.AbilitiesDisabled = true;
				v1:Play(v8.Config.Sounds.CorruptThrow, {
					Parent = v8.Rig.PrimaryPart
				});
				local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v8.Player, 0.01, "HinderedMovement");
				task.delay(0.4, function() --[[ Line: 68 ]]
					-- upvalues: l_v2_SpeedMultiplier_0 (copy)
					game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
						Value = 1
					}):Play();
					game.Debris:AddItem(l_v2_SpeedMultiplier_0, 0.5);
				end);
				task.delay(0.1, function() --[[ Line: 74 ]]
					-- upvalues: v8 (copy), v2 (ref), v1 (ref), v3 (ref), v4 (ref)
					local l_Position_0 = (v8.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -20)).Position;
					l_Position_0 = if v8.Player:GetAttribute("Device") == "Mobile" then v2:GetPlayerMousePosition(v8.Player, true) else v2:GetPlayerMousePosition(v8.Player);
					local v11 = CFrame.lookAt(v8.Rig.PrimaryPart.Position, l_Position_0) * CFrame.new(0, 0, -500);
					local v12 = v8.Config.Projectile and v8.Config.Projectile:Clone() or Instance.new("Part");
					v12.Name = "HumanoidRootProjectile";
					v12.Anchored = true;
					v12.CanCollide = false;
					if not v8.Config.NoProjectileResize then
						v12.Size = Vector3.new(1, 2, 2, 0);
					end;
					v12.CFrame = v8.Rig.PrimaryPart.CFrame;
					v12.Parent = workspace.Map.Ingame;
					game.Debris:AddItem(v12, 10);
					game.TweenService:Create(v12, TweenInfo.new(10, Enum.EasingStyle.Linear), {
						Position = v11.Position
					}):Play();
					v1:Play(v8.Config.Sounds.CorruptAmbience, {
						Parent = v12, 
						Looped = true
					});
					task.spawn(function() --[[ Line: 97 ]]
						-- upvalues: v8 (ref), v12 (copy)
						if v8.Config.NoProjectileJitter then
							return;
						else
							while task.wait() and v12.Parent do
								v12.Orientation = Vector3.new(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
							end;
							return;
						end;
					end);
					local v13 = 0;
					v3:CreateHitbox(v8.Player, {
						Size = Vector3.new(3, 3, 3, 0), 
						CFrame = function() --[[ Line: 110 ]] --[[ Name: CFrame ]]
							-- upvalues: v12 (copy)
							return v12.CFrame;
						end, 
						Damage = v8.Config.RootPartDamage, 
						Time = 10, 
						Knockback = 0.5, 
						HitMultiple = true, 
						PredictVelocity = false, 
						Connections = {
							Hit = function(v14) --[[ Line: 119 ]] --[[ Name: Hit ]]
								-- upvalues: v13 (ref), v8 (ref), v2 (ref), v4 (ref), v1 (ref)
								v13 = v13 + 1;
								if v13 >= 2 then
									require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v8.Player, "c00lkiddProjectile");
								end;
								v2:RevealPlayerAuraTo(v8.Player, v14, 10);
								v4:ApplyStatus(v14, "Slowness", {
									Level = 1, 
									Duration = 4
								});
								v1:Play(v8.Config.Sounds.CorruptHit, {
									Parent = v14.PrimaryPart, 
									PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
									Volume = 0.4
								});
								if tostring(v14.Parent) == "Survivors" then
									require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v8.Player, {
										Action = "Landed Corrupt Nature hit", 
										RewardType = "RegularKillerAction"
									});
								end;
							end
						}
					});
				end);
				task.delay(1.2, function() --[[ Line: 144 ]]
					-- upvalues: v8 (copy)
					v8.AbilitiesDisabled = false;
				end);
				return;
			else
				if game["Run Service"]:IsClient() then
					v8.Animations.CorruptNature:Play(0.025);
					v8.Animations.CorruptNature:AdjustSpeed(2);
				end;
				return;
			end;
		end
	}, 
	WalkspeedOverride = {
		LayoutOrder = 3, 
		Icon = "rbxassetid://101955457812737", 
		KeybindType = "AltAbility2", 
		Cooldown = 20, 
		Callback = function(v15) --[[ Line: 161 ]] --[[ Name: Callback ]]
			-- upvalues: v2 (copy), v3 (copy), v4 (copy), v1 (copy)
			local l_WalkspeedOverrideTimeout_0 = v15.Config.WalkspeedOverrideTimeout;
			if game["Run Service"]:IsServer() then
				v15.AbilitiesDisabled = true;
				v2:SetSpeedCap(v15.Rig, "C00lkiddWalkspeedOverride", v15.Config.WalkspeedOverrideSpeed);
				task.delay(0.125, function() --[[ Line: 170 ]]
					-- upvalues: v3 (ref), v15 (copy), l_WalkspeedOverrideTimeout_0 (copy), v4 (ref), v2 (ref), v1 (ref)
					local v17 = nil;
					local v18 = nil;
					local l_v3_Hitbox_1 = v3:CreateHitbox(v15.Player, {
						Size = Vector3.new(7, 5, 6, 0), 
						Damage = v15.Config.WalkspeedOverrideDamage, 
						Time = l_WalkspeedOverrideTimeout_0, 
						Knockback = 4.5, 
						HitMultiple = true, 
						Connections = {
							Hit = function(v19) --[[ Line: 182 ]] --[[ Name: Hit ]]
								-- upvalues: v17 (ref), v4 (ref), v15 (ref)
								v17 = v19;
								v4:ApplyStatus(v19, "Burning", {
									Level = 1, 
									Duration = 8
								});
								v15.Rig.firebrand.Transparency = 0;
								task.delay(1.5, function() --[[ Line: 187 ]]
									-- upvalues: v15 (ref)
									game.TweenService:Create(v15.Rig.firebrand, TweenInfo.new(0.5), {
										Transparency = 1
									}):Play();
								end);
								if tostring(v19.Parent) == "Survivors" then
									local v20 = require(game.ReplicatedStorage.Modules.Actors);
									if v19.Humanoid.Health <= 0 then
										v20:IncrementActorStats(v15.Player, {
											Action = "Killed a Survivor with Walkspeed Override", 
											RewardType = "DifficultKillerAction"
										});
										return;
									else
										v20:IncrementActorStats(v15.Player, {
											Action = "Landed Walkspeed Override hit", 
											RewardType = "RegularKillerAction"
										});
									end;
								end;
							end, 
							Ended = function() --[[ Line: 205 ]] --[[ Name: Ended ]]
								-- upvalues: v18 (ref)
								v18 = true;
							end
						}
					});
					local v22 = v2:ApplyVelocity(v15.Rig.PrimaryPart, v15.Config.WalkspeedOverrideSpeed);
					game.Debris:AddItem(v22, l_WalkspeedOverrideTimeout_0 + 3);
					game.TweenService:Create(v22, TweenInfo.new(l_WalkspeedOverrideTimeout_0 * 1.5), {
						LineVelocity = v15.Config.WalkspeedOverrideSpeed / 2
					}):Play();
					v1:Play(v15.Config.Sounds.WalkspeedOverrideLunge, {
						Parent = v15.Rig.PrimaryPart
					});
					local v23 = false;
					local v24 = ("%*C00lkiddCollision"):format(v15.Player.Name);
					local v25 = require(game.ReplicatedStorage.Modules.Network);
					v25:SetConnection(v24, "REMOTE_EVENT", function(v26) --[[ Line: 223 ]]
						-- upvalues: v15 (ref), v23 (ref)
						if v26 == v15.Player then
							v23 = true;
						end;
					end);
					repeat
						task.wait();
					until v17 or v18 or v23;
					local v27 = "IDK";
					if v17 then
						v27 = "Hit";
						v15.Rig:SetAttribute("Invincible", true);
					elseif v23 then
						v27 = "Collide";
					elseif v18 then
						v27 = "Timeout";
					end;
					local l_StringValue_0 = Instance.new("StringValue");
					l_StringValue_0.Name = "Result";
					l_StringValue_0.Value = v27;
					l_StringValue_0.Parent = v15.Rig;
					game.Debris:AddItem(l_StringValue_0, 1.5);
					task.delay(1.5, function() --[[ Line: 251 ]]
						-- upvalues: v15 (ref)
						v15.AbilitiesDisabled = false;
						v15.Rig:SetAttribute("Invincible", nil);
					end);
					game.TweenService:Create(v22, TweenInfo.new(v27 == "Collide" and 0.25 or 0.5), {
						LineVelocity = 0
					}):Play();
					game.Debris:AddItem(v22, 1.5);
					v1:PlayVoiceline(v15, ("WalkspeedOverride%*"):format(v27), {
						Priority = 1.5
					});
					v1:Play(v15.Config.Sounds[("WalkspeedOverride%*"):format(v27)], {
						Parent = v15.Rig.PrimaryPart
					});
					v2:SetSpeedCap(v15.Rig, "C00lkiddWalkspeedOverride", nil);
					v25:RemoveConnection(v24, "REMOTE_EVENT");
					l_v3_Hitbox_1:Cancel();
				end);
				return;
			else
				if game["Run Service"]:IsClient() then
					v15.Animations.WalkspeedOverrideStart:Play();
					v15.Animations.WalkspeedOverrideLoop:Play();
					v15.Rig:SetAttribute("FootstepsMuted", true);
					local l_v2_SpeedMultiplier_1 = v2:CreateSpeedMultiplier(v15.Player, 0, "HinderedMovement");
					local v30 = nil;
					do
						local l_v30_0 = v30;
						task.spawn(function() --[[ Line: 277 ]]
							-- upvalues: l_v30_0 (ref), v15 (copy)
							local v32 = 0;
							local v33 = false;
							while true do
								if not l_v30_0 and v15.Rig.PrimaryPart then
									if v32 >= 0.4 and v15.Rig.PrimaryPart.AssemblyLinearVelocity.Magnitude <= 18 then
										if not v33 then
											require(game.ReplicatedStorage.Modules.Network):FireServerConnection(("%*C00lkiddCollision"):format(v15.Player.Name), "REMOTE_EVENT");
											v33 = true;
										end;
										return;
									else
										v32 = v32 + task.wait();
									end;
								else
									return;
								end;
							end;
						end);
						local v34 = v15.Rig:WaitForChild("Result", 6);
						l_v30_0 = v34 and v34.Value or "IDK BRUH";
						v15.Rig:SetAttribute("FootstepsMuted", nil);
						v15.Animations.WalkspeedOverrideStart:Stop();
						v15.Animations.WalkspeedOverrideLoop:Stop();
						if l_v30_0 == "Hit" then
							v15.Animations.WalkspeedOverrideHit:Play(0);
						elseif not v15.Animations.WalkspeedOverrideTimeout and not v15.Animations.WalkspeedOverrideCollide then
							v15.Animations.WalkspeedOverrideMiss:Play(0.05);
						elseif l_v30_0 == "Timeout" and v15.Animations.WalkspeedOverrideTimeout then
							v15.Animations.WalkspeedOverrideTimeout:Play(0.05);
						elseif l_v30_0 == "Collide" and v15.Animations.WalkspeedOverrideCollide then
							v15.Animations.WalkspeedOverrideCollide:Play(0.05);
						end;
						if v34 then
							repeat
								task.wait();
							until not v34.Parent;
						end;
						game.TweenService:Create(l_v2_SpeedMultiplier_1, TweenInfo.new(0.5), {
							Value = 1
						}):Play();
						game.Debris:AddItem(l_v2_SpeedMultiplier_1, 0.5);
					end;
				end;
				return;
			end;
		end
	}, 
	PizzaDelivery = {
		LayoutOrder = 4, 
		Icon = "rbxassetid://105652328381208", 
		KeybindType = "AltAbility3", 
		Cooldown = 50, 
		Callback = function(v35) --[[ Line: 331 ]] --[[ Name: Callback ]]
			-- upvalues: v1 (copy), v2 (copy), v4 (copy)
			if game["Run Service"]:IsServer() then
				v35.AbilitiesDisabled = true;
				v1:Play(v35.Config.Sounds.PizzaDeliveryPunchGround, {
					Parent = v35.Rig.PrimaryPart
				});
				task.delay(1, function() --[[ Line: 338 ]]
					-- upvalues: v35 (copy), v2 (ref), v1 (ref), v4 (ref)
					for v36 = 1, 2 do
						local l_PizzaDeliveryRig_0 = v35.Config.PizzaDeliveryRig;
						local v38 = (l_PizzaDeliveryRig_0:IsA("Folder") and l_PizzaDeliveryRig_0:GetChildren()[math.random(1, #l_PizzaDeliveryRig_0:GetChildren())] or l_PizzaDeliveryRig_0):Clone();
						v38:SetAttribute("Team", "Killers");
						v38.PrimaryPart.Anchored = true;
						for _, v40 in pairs(v38:GetDescendants()) do
							if v40:IsA("BasePart") then
								v40.Massless = v40 ~= v38.PrimaryPart;
							end;
						end;
						local l_Humanoid_0 = v38.Humanoid;
						l_Humanoid_0.WalkSpeed = v35.Config.PizzaDeliveryGuySpeed;
						l_Humanoid_0.MaxHealth = v35.Config.PizzaDeliveryGuyHealth;
						l_Humanoid_0.Health = v35.Config.PizzaDeliveryGuyHealth;
						l_Humanoid_0.StateChanged:Connect(function(_, _) --[[ Line: 358 ]]
							-- upvalues: l_Humanoid_0 (copy)
							l_Humanoid_0.PlatformStand = false;
							l_Humanoid_0:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
							l_Humanoid_0:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
							l_Humanoid_0:ChangeState(Enum.HumanoidStateType.GettingUp);
						end);
						v38.Parent = workspace.Map.Ingame;
						local v44 = false;
						do
							local l_v44_0 = v44;
							local _ = function(v46) --[[ Line: 370 ]] --[[ Name: removeRigAfter ]]
								-- upvalues: l_v44_0 (ref), v38 (copy)
								task.delay(v46 - 1, function() --[[ Line: 371 ]]
									-- upvalues: l_v44_0 (ref), v38 (ref)
									if not l_v44_0 then
										l_v44_0 = true;
										game.Debris:AddItem(v38, 1);
										for _, v48 in pairs(v38:GetDescendants()) do
											if v48:IsA("BasePart") or v48:IsA("Decal") then
												game.TweenService:Create(v48, TweenInfo.new(1), {
													Transparency = 1
												}):Play();
											end;
										end;
									end;
								end);
							end;
							local l_PizzaDeliveryGuyLifetime_0 = v35.Config.PizzaDeliveryGuyLifetime;
							task.delay(l_PizzaDeliveryGuyLifetime_0 - 1, function() --[[ Line: 371 ]]
								-- upvalues: l_v44_0 (ref), v38 (copy)
								if not l_v44_0 then
									l_v44_0 = true;
									game.Debris:AddItem(v38, 1);
									for _, v52 in pairs(v38:GetDescendants()) do
										if v52:IsA("BasePart") or v52:IsA("Decal") then
											game.TweenService:Create(v52, TweenInfo.new(1), {
												Transparency = 1
											}):Play();
										end;
									end;
								end;
							end);
							game.Debris:AddItem(v38, v35.Config.PizzaDeliveryGuyLifetime);
							l_PizzaDeliveryGuyLifetime_0 = {};
							for v53, v54 in pairs(v35.Config.PizzaDeliveryAnimations) do
								l_PizzaDeliveryGuyLifetime_0[v53] = v2:LoadAnimationFromID(v38, v54, true);
							end;
							l_PizzaDeliveryGuyLifetime_0.Idle:Play();
							l_PizzaDeliveryGuyLifetime_0.Summoned:Play(0);
							v38:SetPrimaryPartCFrame(v35.Rig.PrimaryPart.CFrame * CFrame.new(v36 % 2 == 0 and 6 or -6, 0, 0));
							v1:Play(v35.Config.Sounds.PizzaDeliveryGuySpawned, {
								Parent = v35.Rig.PrimaryPart
							});
							task.wait(0.75);
							task.delay(1.75, function() --[[ Line: 404 ]]
								-- upvalues: v38 (copy), l_PizzaDeliveryGuyLifetime_0 (copy), l_Humanoid_0 (copy), v2 (ref), v35 (ref), l_v44_0 (ref), v4 (ref), v1 (ref)
								if not v38.PrimaryPart then
									return;
								else
									v38.PrimaryPart.Anchored = false;
									l_PizzaDeliveryGuyLifetime_0.Walk:Play();
									local v55 = require(game.ReplicatedStorage.Modules.SimplePath).new(v38);
									while task.wait() and v38.Parent and v38.PrimaryPart and l_Humanoid_0.Health > 0 do
										local l_v2_ClosestPlayerFromPosition_0, v57 = v2:GetClosestPlayerFromPosition(v38.PrimaryPart.Position);
										local v58 = l_v2_ClosestPlayerFromPosition_0 and l_v2_ClosestPlayerFromPosition_0.PrimaryPart and l_v2_ClosestPlayerFromPosition_0.PrimaryPart.Position;
										if v35.Rig.Parent and v57 and v57 < v35.Config.PizzaDeliveryGuyAttackRadius then
											task.delay(1, function() --[[ Line: 371 ]]
												-- upvalues: l_v44_0 (ref), v38 (ref)
												if not l_v44_0 then
													l_v44_0 = true;
													game.Debris:AddItem(v38, 1);
													for _, v60 in pairs(v38:GetDescendants()) do
														if v60:IsA("BasePart") or v60:IsA("Decal") then
															game.TweenService:Create(v60, TweenInfo.new(1), {
																Transparency = 1
															}):Play();
														end;
													end;
												end;
											end);
											l_PizzaDeliveryGuyLifetime_0.Walk:Stop(0);
											l_PizzaDeliveryGuyLifetime_0.Hit:Play(0);
											v2:ApplyDamage(l_v2_ClosestPlayerFromPosition_0, v35.Config.PizzaDeliveryGuyDamage);
											v2:RevealPlayerAuraTo(v35.Player, l_v2_ClosestPlayerFromPosition_0, 7.5);
											v4:ApplyStatus(l_v2_ClosestPlayerFromPosition_0, "Burning", {
												Level = 1, 
												Duration = 3
											});
											v4:ApplyStatus(l_v2_ClosestPlayerFromPosition_0, "Slowness", {
												Level = 2, 
												Duration = 3
											});
											v1:PlayVoiceline(v35, "PizzaDeliveryHit", {
												Priority = 0, 
												Chance = 1
											});
											if tostring(l_v2_ClosestPlayerFromPosition_0.Parent) == "Survivors" then
												require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(v35.Player, {
													Action = "A pizza delivery minion attacked a Survivor", 
													RewardType = "EasyKillerAction"
												});
												break;
											else
												break;
											end;
										elseif v35.Rig.Parent and v58 then
											v55:Run(v58);
										else
											task.delay(1, function() --[[ Line: 371 ]]
												-- upvalues: l_v44_0 (ref), v38 (ref)
												if not l_v44_0 then
													l_v44_0 = true;
													game.Debris:AddItem(v38, 1);
													for _, v62 in pairs(v38:GetDescendants()) do
														if v62:IsA("BasePart") or v62:IsA("Decal") then
															game.TweenService:Create(v62, TweenInfo.new(1), {
																Transparency = 1
															}):Play();
														end;
													end;
												end;
											end);
											l_Humanoid_0.WalkSpeed = 0;
											l_PizzaDeliveryGuyLifetime_0.Walk:Stop(0);
											break;
										end;
									end;
									if v55 then
										v55:Destroy();
									end;
									return;
								end;
							end);
						end;
					end;
				end);
				task.delay(3, function() --[[ Line: 454 ]]
					-- upvalues: v35 (copy)
					v35.AbilitiesDisabled = false;
				end);
				return;
			else
				if game["Run Service"]:IsClient() then
					v35.Animations.SummonPizzaDelivery:Play(0.025);
					local l_v2_SpeedMultiplier_2 = v2:CreateSpeedMultiplier(v35.Player, 0, "HinderedMovement");
					task.delay(2.5, function() --[[ Line: 465 ]]
						-- upvalues: l_v2_SpeedMultiplier_2 (copy)
						game.TweenService:Create(l_v2_SpeedMultiplier_2, TweenInfo.new(0.5), {
							Value = 1
						}):Play();
						game.Debris:AddItem(l_v2_SpeedMultiplier_2, 0.5);
						v35.Animations.SummonPizzaDelivery:Stop(0.025);
					end);
				end;
				return;
			end;
		end
	}
};
v0.OnIntroduction = function(_, v65, v66, v67) --[[ Line: 475 ]] --[[ Name: OnIntroduction ]]
	task.spawn(function() --[[ Line: 476 ]]
		-- upvalues: v66 (copy)
		local v68 = v66:WaitForChild("firebrand", 20);
		if v68 then
			v68.Transparency = 0;
		end;
	end);
	local v69 = nil;
	task.delay(0.5, function() --[[ Line: 484 ]]
		-- upvalues: v69 (ref)
		v69 = game.Lighting.ClockTime;
		game.TweenService:Create(game.Lighting, TweenInfo.new(0.75), {
			ClockTime = 0
		}):Play();
	end);
	task.delay(1.5, function() --[[ Line: 489 ]]
		-- upvalues: v65 (copy), v69 (ref), v67 (copy)
		local v70 = v65.Config.IntroSky:Clone();
		v70.Parent = game.Lighting;
		game.TweenService:Create(game.Lighting, TweenInfo.new(1.5), {
			ClockTime = v69 or 12
		}):Play();
		game.Debris:AddItem(v70, v67 - 1.5);
	end);
end;
v0.OnVictory = function(_, v72, _, v74, _) --[[ Line: 497 ]] --[[ Name: OnVictory ]]
	if v72 == "Start" then
		game.Lighting.ClockTime = 0;
		task.spawn(function() --[[ Line: 500 ]]
			-- upvalues: v74 (copy)
			local v76 = v74:WaitForChild("firebrand", 20);
			if v76 then
				v76.Transparency = 1;
			end;
		end);
		return;
	else
		if v72 == "End" then
			local v77 = require(game.ReplicatedStorage.Modules.Schematics.Lighting);
			v77:SetCustomLighting(v77.Properties);
		end;
		return;
	end;
end;
v0.OnExecution = function(_, v79, v80) --[[ Line: 512 ]] --[[ Name: OnExecution ]]
	local v81 = false;
	if v80.Name == "007n7" then
		v81 = v79.Rig.PrimaryPart.CFrame * CFrame.new(3, -2.75, 2.25) * CFrame.Angles(1.5707963267948966, 0, -0.3490658503988659);
	end;
	local v82 = v80.Name == "007n7" and Vector3.new() or (v79.Rig.PrimaryPart.CFrame * CFrame.new(5, 0.5, 1)).LookVector.Unit * 200;
	local v83 = workspace:GetServerTimeNow() + (v80.Name == "007n7" and 3.6 or 3.5);
	require(game.ReplicatedStorage.Modules.Network):FireAllClientConnection("Ragdoll", "REMOTE_EVENT", v80, v83, ("%*|%*|%*"):format(v82.X, v82.Y, v82.Z), v81);
	task.delay(2.1, function() --[[ Line: 523 ]]
		-- upvalues: v80 (copy)
		local l_Humanoid_1 = v80:FindFirstChild("Humanoid");
		if l_Humanoid_1 then
			l_Humanoid_1.BreakJointsOnDeath = false;
			l_Humanoid_1.Health = 0;
		end;
	end);
end;
return v0;