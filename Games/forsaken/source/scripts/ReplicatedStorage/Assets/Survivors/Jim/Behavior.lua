local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local v4 = require(game.ReplicatedStorage.Modules.Statuses);
local v5 = require(game.ReplicatedStorage.Modules.Network);

local v6 = require(game.ReplicatedStorage.Modules.Actors);

v0.Abilities = {
	Shoot = {
		LayoutOrder = 1, 
		Icon = "rbxassetid://120384661730793", 
		Cooldown = 45, 
		KeybindType = "AltAbility1",
		Callback = function(v7) --[[ Line: 16 ]] --[[ Name: Callback ]]
			-- upvalues: v1 (copy), v3 (copy), v2 (copy)
			if game["Run Service"]:IsServer() then
				v7.AbilitiesDisabled = true;
				v1:Play(v7.Config.Sounds.Shoot, {
					Parent = v7.Rig.PrimaryPart, 
					PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
					Volume = 0.35
				});
				task.delay(0.17, function() --[[ Line: 23 ]]
					-- upvalues: v3 (ref), v7 (copy), v2 (ref), v1 (ref)
					local _ = v3:CreateHitbox(v7.Player, {
						Size = Vector3.new(2.75, 2.75, 65, 0), 
						CFrameOffset = CFrame.new(0, 0, -32.5),
						Damage = 25, 
						Time = 0.25, 
						Knockback = 2, 
						HitMultiple = false, 
						Connections = {
							Hit = function(v8, v9) --[[ Line: 35 ]] --[[ Name: Hit ]]
								-- upvalues: v2 (ref), v1 (ref), v7 (ref)
								v4:ApplyStatus(v8, "Stunned", {
									Duration = 2.5
								});
								
								v6:IncrementActorStats(v7.Player, {
									Action = "Shot The Killer As Jim",
									RewardType = "Offensive"
								})
								
								if v9 then
									v1:Play(v7.Config.Sounds.BulletHit, {
										Parent = v7.Rig.PrimaryPart, 
										PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
										Volume = 0.5
									});
								end;
							end
						}
					});
				end);
				task.delay(0.6, function() --[[ Line: 46 ]]
					-- upvalues: v7 (copy)
					v7.AbilitiesDisabled = false;
				end);
				return;
			else
				if game["Run Service"]:IsClient() then
					v7.Animations.ShootGun:Play(0.025);
				end;
				return;
			end;
		end
	},
	SuperBall = {
		LayoutOrder = 2, 
		Icon = "rbxassetid://138473319781900", 
		KeybindType = "AltAbility2", 
		Cooldown = 50, 
		Callback = function(v8)
			-- upvalues: v1 (copy), v2 (copy), v3 (copy), v4 (copy)
			if game["Run Service"]:IsServer() then
				v8.AbilitiesDisabled = true;

				task.delay(0.6, function()
					v1:Play(v8.Config.Sounds.SuperBall, {
						Parent = v8.Rig.PrimaryPart
					});

					local l_v2_SpeedMultiplier_0 = v2:CreateSpeedMultiplier(v8.Player, 0.01, "HinderedMovement");
					task.delay(0.4, function()
						game.TweenService:Create(l_v2_SpeedMultiplier_0, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
							Value = 1
						}):Play();
						game.Debris:AddItem(l_v2_SpeedMultiplier_0, 0.5);
					end);

					task.delay(0.1, function()
						local l_Position_0 = (v8.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -20)).Position;
						l_Position_0 = if v8.Player:GetAttribute("Device") == "Mobile"
							then v2:GetPlayerMousePosition(v8.Player, true)
							else v2:GetPlayerMousePosition(v8.Player);

						local v11 = CFrame.lookAt(v8.Rig.PrimaryPart.Position, l_Position_0) * CFrame.new(0, 0, -500);
						local ReplicatedStorage = game:GetService("ReplicatedStorage");
						local v12 = v8.Config.Projectile and v8.Config.Projectile:Clone() or Instance.fromExisting(ReplicatedStorage.Assets.Survivors.Jim.Config.SuperBall);
						v12.Name = "HumanoidRootProjectile";
						v12.Anchored = true;
						v12.CanCollide = false;

						if not v8.Config.NoProjectileResize then
							v12.Size = Vector3.new(2.5, 2.5, 2.5, 0);
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

						task.spawn(function()
							if v8.Config.NoProjectileJitter then return end;
							while task.wait() and v12.Parent do
								v12.Orientation = Vector3.new(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
							end;
						end);

						local v13 = 0;
						v3:CreateHitbox(v8.Player, {
							Size = Vector3.new(3, 3, 3, 0),
							CFrame = function() return v12.CFrame end,
							Damage = 25,
							Time = 10,
							Knockback = 20,
							HitMultiple = true,
							PredictVelocity = false,
							Connections = {
								Hit = function(v14)
									v13 = v13 + 1;
									if v13 >= 2 then
										require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(v8.Player, "c00lkiddProjectile");
									end;
									v2:RevealPlayerAuraTo(v8.Player, v14, 10);
									v4:ApplyStatus(v14, "Slowness", {
										Level = 2,
										Duration = 1.5
									});
									v1:Play(v8.Config.Sounds.BallHit, {
										Parent = v14.PrimaryPart,
										PlaybackSpeed = Random.new():NextNumber(0.975, 1.025),
										Volume = 0.4
									});
									v6:IncrementActorStats(v8.Player, {
										Action = "Landed SuperBall hit",
										RewardType = "Offensive"
									})
								end
							}
						});
					end);

					task.delay(1.2, function()
						v8.AbilitiesDisabled = false;
					end);
				end); -- end of 0.75s delay
			else
				if game["Run Service"]:IsClient() then
					v8.Animations.ThrowBall:Play(0.025);
				end;
			end;
		end


	},
	["First Aid Kit"] = {
		LayoutOrder = 3, 
		KeybindType = "AltAbility3", 
		Icon = "rbxassetid://94768747549529", 
		Cooldown = 110, 
		Callback = function(v20, _) --[[ Line: 118 ]] --[[ Name: Callback ]]
			-- upvalues: v1 (copy), v5 (copy), v2 (copy)
			if game["Run Service"]:IsServer() then
				v20.AbilitiesDisabled = true;
				local function v26(v22, v23) --[[ Line: 124 ]] --[[ Name: showChickenRecursive ]]
					for _, v25 in pairs(v22:GetDescendants()) do
						if v25.Name:find("Medkit") and (v25:IsA("BasePart") or v25:IsA("Decal")) and not v25:GetAttribute("Ignored") then
							v25.Transparency = v23;
						end;
					end;
				end;
				v26(v20.Rig, 0);
				if v20.Cache.FirstAidKit then
					v20.Cache.FirstAidKit:Play();
				end;
				v1:Play(v20.Config.Sounds.Heal, {
					Parent = v20.Rig.PrimaryPart
				});
				task.delay(v20.Config.FirstAidKitHealDelay, function() --[[ Line: 142 ]]
					-- upvalues: v20 (copy)
					local l_Humanoid_0 = v20.Rig:FindFirstChild("Humanoid");
					v4:ApplyStatus(v20.Player, "Healed", {
						Level = 1, 
						Duration = 2.5,
						Hidden = true
					});
					if not l_Humanoid_0 then
						return;
					else
						if l_Humanoid_0.Health > 0 then
							l_Humanoid_0.Health = l_Humanoid_0.Health + v20.Config.FirstAidKitHealInitialAmount;
							local v28 = true;
							local l_Health_0 = l_Humanoid_0.Health;
							local v30 = nil;
							v30 = l_Humanoid_0.HealthChanged:Connect(function(v31) --[[ Line: 150 ]]
								-- upvalues: l_Health_0 (copy), v28 (ref), v30 (ref)
								if v31 <= 0 or v31 <= l_Health_0 - 10 then
									v28 = false;
									v30:Disconnect();
									v30 = nil;
								end;
							end);
							local v32 = 0;
							while true do
								if v20.Rig.Parent then
									local v33 = task.wait();
									v32 = v32 + v33;
									if not v28 then
										return;
									elseif not v20.Rig.Parent then
										return;
									elseif v20.Config.FirstAidKitHealOvertimeDuration <= v32 then
										return;
									else
										l_Humanoid_0.Health = l_Humanoid_0.Health + v33 * v20.Config.FirstAidKitHealOvertimeAmount / v20.Config.FirstAidKitHealOvertimeDuration;
									end;
								else
									--[[ close >= 1 ]]
									break;
								end;
							end;
						end;
						return;
					end;
				end);
				task.delay(2.75, function() --[[ Line: 173 ]]
					-- upvalues: v26 (copy), v20 (copy)
					v26(v20.Rig, 1);
				end);
				task.delay(4, function() --[[ Line: 178 ]]
					-- upvalues: v20 (copy)
					v20.AbilitiesDisabled = false;
				end);
				return;
			else
				if game["Run Service"]:IsClient() then
					v20.Animations.FirstAidKit:Play(0.1);
					v5:FireConnection("DisableSprinting", "UseFirstAidKit", true);
					local l_v2_SpeedMultiplier_1 = v2:CreateSpeedMultiplier(v20.Rig, 0.25, "UseFirstAidKit");
					task.delay(v20.Config.FirstAidKitHealDelay + 1.25, function() --[[ Line: 191 ]]
						-- upvalues: v5 (ref), l_v2_SpeedMultiplier_1 (copy)
						v5:FireConnection("DisableSprinting", "UseFirstAidKit", false);
						l_v2_SpeedMultiplier_1:Destroy();
					end);
				end;
				return;
			end;
		end
	}
};
v0.Created = function(_, v59) --[[ Line: 435 ]] --[[ Name: Created ]]
	if game["Run Service"]:IsServer() then
		v59.Rig.Humanoid.MaxHealth = math.random(100, 100);
		v59.Rig.Humanoid.Health = v59.Rig.Humanoid.MaxHealth;
		return;
	else
		if game["Run Service"]:IsClient() then

		end;
		return;
	end;
end;
return v0;