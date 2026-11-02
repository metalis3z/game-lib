-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
local v_u_2 = require(game.ReplicatedStorage.Modules.Sounds)
local v_u_3 = require(game.ReplicatedStorage.Modules.Util)
local v_u_4 = require(game.ReplicatedStorage.Modules.Hitboxes)
local v_u_5 = require(game.ReplicatedStorage.Modules.Statuses)
local v_u_6 = game:GetService("RunService")
local v_u_7 = require(game.ReplicatedStorage.Modules.Schematics.Lighting)
local v_u_8 = require(game.ReplicatedStorage.Modules.Projectiles)
local v_u_9 = require(game.ReplicatedStorage.Modules.AchievementUtil)
local v105 = {
	["Punch"] = {
		["LayoutOrder"] = 1,
		["Icon"] = "rbxassetid://93874368032471",
		["KeybindType"] = "MainAbility",
		["Cooldown"] = 2,
		["Callback"] = function(p_u_10)
			-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_3
			if game["Run Service"]:IsServer() then
				p_u_10.AbilitiesDisabled = true
				v_u_2:Play(p_u_10.Config.Sounds.Swing, {
					["Parent"] = p_u_10.Rig.PrimaryPart,
					["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
					["Volume"] = 0.25
				})
				task.delay(p_u_10.Config.PunchWindup, function()
					-- upvalues: (ref) v_u_4, (copy) p_u_10, (ref) v_u_3, (ref) v_u_2
					local v11 = v_u_4
					local v12 = p_u_10.Player
					local v14 = {
						["Size"] = Vector3.new(4.5, 6, 5),
						["CFrameOffset"] = CFrame.new(0, 0, -1.5),
						["Damage"] = p_u_10.Config.AttackDamage,
						["Time"] = p_u_10.Config.PunchLinger,
						["Knockback"] = 2,
						["HitMultiple"] = false,
						["ExecuteOnKill"] = true,
						["Connections"] = {
							["Hit"] = function(p13)
								-- upvalues: (ref) v_u_3, (ref) v_u_2, (ref) p_u_10
								v_u_3:CreateSpeedMultiplier(p13, 1.5, "HitSpeedBonus", 1.25)
								v_u_2:Play(p_u_10.Config.Sounds.Hit, {
									["Parent"] = p_u_10.Rig.PrimaryPart,
									["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
									["Volume"] = 0.25
								})
							end
						}
					}
					v11:CreateHitbox(v12, v14)
				end)
				task.delay(0.75, function()
					-- upvalues: (copy) p_u_10
					p_u_10.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_10.Animations.Attack:Play(0.025)
			end
		end
	},
	["CorruptNature"] = {
		["LayoutOrder"] = 2,
		["Icon"] = "rbxassetid://81200466982776",
		["KeybindType"] = "AltAbility1",
		["Cooldown"] = 16,
		["Callback"] = function(p_u_15)
			-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_5, (copy) v_u_8
			if game["Run Service"]:IsServer() then
				p_u_15.AbilitiesDisabled = true
				v_u_2:Play(p_u_15.Config.Sounds.CorruptThrow, {
					["Parent"] = p_u_15.Rig.PrimaryPart
				})
				local v_u_16 = v_u_3:CreateSpeedMultiplier(p_u_15.Player, 0.01, "HinderedMovement")
				task.delay(0.4, function()
					-- upvalues: (copy) v_u_16
					game.TweenService:Create(v_u_16, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
						["Value"] = 1
					}):Play()
					game.Debris:AddItem(v_u_16, 0.5)
				end)
				task.delay(0.1, function()
					-- upvalues: (copy) p_u_15, (ref) v_u_3, (ref) v_u_2, (ref) v_u_5, (ref) v_u_8
					local _ = (p_u_15.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -20)).Position
					local v17
					if p_u_15.Player:GetAttribute("Device") == "Mobile" then
						v17 = v_u_3:GetPlayerMousePosition(p_u_15.Player, true)
					else
						v17 = v_u_3:GetPlayerMousePosition(p_u_15.Player)
					end
					local v18 = CFrame.lookAt(p_u_15.Rig.PrimaryPart.Position, v17) * CFrame.new(0, 0, -500)
					local v19 = p_u_15.Rig.PrimaryPart
					local v20 = p_u_15.Config.Projectile and p_u_15.Config.Projectile:Clone() or Instance.new("Part")
					v20.Name = "HumanoidRootProjectile"
					v20.Anchored = true
					v20.CanCollide = false
					v20.CanQuery = false
					v20.CanTouch = false
					if not p_u_15.Config.NoProjectileResize then
						v20.Size = Vector3.new(1, 2, 2)
					end
					local v21 = v19.CFrame
					local v22 = (p_u_15.Rig.Humanoid.HipHeight + v19.Size.Y / 2) / 2
					local v23 = v21 + Vector3.new(0, v22, 0)
					local v24 = (v18.Position - v23.Position) / 10
					v_u_2:Play(p_u_15.Config.Sounds.CorruptAmbience, {
						["Parent"] = v20,
						["Looped"] = true
					})
					local v_u_25 = 0
					local v28 = {
						["Size"] = Vector3.new(3, 3, 3),
						["Damage"] = p_u_15.Config.RootPartDamage,
						["Time"] = 10,
						["Knockback"] = 0.5,
						["HitMultiple"] = true,
						["PredictVelocity"] = false,
						["Connections"] = {
							["Hit"] = function(p26)
								-- upvalues: (ref) v_u_25, (ref) p_u_15, (ref) v_u_3, (ref) v_u_5, (ref) v_u_2
								v_u_25 = v_u_25 + 1
								if v_u_25 >= 2 then
									require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(p_u_15.Player, "c00lkiddProjectile")
								end
								v_u_3:RevealPlayerAuraTo(p_u_15.Player, p26, 10)
								v_u_5:ApplyStatus(p26, "Slowness", {
									["Level"] = 1,
									["Duration"] = 4
								})
								v_u_2:Play(p_u_15.Config.Sounds.CorruptHit, {
									["Parent"] = p26.PrimaryPart,
									["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
									["Volume"] = 0.4
								})
								local v27 = p26.Parent
								if tostring(v27) == "Survivors" then
									require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(p_u_15.Player, {
										["Action"] = "Landed Corrupt Nature hit",
										["RewardType"] = "RegularKillerAction"
									})
								end
							end
						}
					}
					local v29 = math.random(-360, 360)
					local v30 = math.random(-360, 360)
					local v31 = math.random
					local v32 = vector.create(v29, v30, v31(-360, 360))
					local v33 = {
						["Owner"] = p_u_15.Player,
						["HitboxConfig"] = v28,
						["Lifetime"] = 10,
						["InitialCFrame"] = v23,
						["InitialVelocity"] = v24,
						["Model"] = v20,
						["ClientCallbackData"] = p_u_15.Config.NoProjectileJitter and {} or {
							["OnHeartbeat"] = {
								["Rotation"] = {
									["rotation"] = v32
								}
							}
						}
					}
					v_u_8.new(v33):Launch()
				end)
				task.delay(1.2, function()
					-- upvalues: (copy) p_u_15
					p_u_15.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_15.Animations.CorruptNature:Play(0.025)
			end
		end
	},
	["WalkspeedOverride"] = {
		["LayoutOrder"] = 3,
		["Icon"] = "rbxassetid://101955457812737",
		["KeybindType"] = "AltAbility2",
		["Cooldown"] = 20,
		["Callback"] = function(p_u_34)
			-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_5, (copy) v_u_2
			local v_u_35 = p_u_34.Config.WalkspeedOverrideDuration
			if game["Run Service"]:IsServer() then
				p_u_34.AbilitiesDisabled = true
				v_u_3:SetSpeedCap(p_u_34.Rig, "C00lkiddWalkspeedOverride", p_u_34.Config.WalkspeedOverrideSpeed)
				local v36 = game:GetService("TweenService")
				local v37 = p_u_34.Config.c00lguiTemplate:Clone()
				local v38 = v37:FindFirstChildWhichIsA("JointInstance")
				if v38 and v37:IsA("BasePart") then
					local v39 = {
						["Size"] = v37.Size
					}
					local v40 = v36:Create(v37, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v39)
					local v41 = v36:Create(v37, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
						["Size"] = Vector3.new(0, 0, 0)
					})
					v37.Parent = p_u_34.Rig
					v37.Anchored = false
					v37.Size = Vector3.new(0, 0, 0)
					v38.Part0 = p_u_34.Rig.PrimaryPart
					v40:Play()
					task.delay(0.25, v41.Play, v41)
				end
				game.Debris:AddItem(v37, 1)
				local v42 = ("%*/WalkspeedStart"):format(script.Parent)
				local v_u_43 = "WalkspeedStart"
				local v44, v45 = pcall(function()
					-- upvalues: (copy) p_u_34, (copy) v_u_43
					if p_u_34.Behavior[v_u_43] then
						p_u_34.Behavior[v_u_43](p_u_34)
					end
				end)
				if not v44 then
					warn((("[%*]: Failed to call .%*() due to: %*"):format(v42, "WalkspeedStart", v45)))
				end
				task.delay(p_u_34.Config.WalkspeedOverrideWindup, function()
					-- upvalues: (ref) v_u_4, (copy) p_u_34, (copy) v_u_35, (ref) v_u_5, (ref) v_u_3, (ref) v_u_2
					local v_u_46 = nil
					local v_u_47 = nil
					local v56 = v_u_4:CreateHitbox(p_u_34.Player, {
						["Size"] = Vector3.new(7, 5, 6),
						["Damage"] = p_u_34.Config.WalkspeedOverrideDamage,
						["CFrameOffset"] = CFrame.new(0, 0, -1.5),
						["Time"] = v_u_35,
						["Knockback"] = p_u_34.Config.WalkspeedOverrideKnockback,
						["HitMultiple"] = true,
						["Connections"] = {
							["Hit"] = function(p48)
								-- upvalues: (ref) v_u_46, (ref) v_u_5, (ref) p_u_34
								v_u_46 = p48
								v_u_5:ApplyStatus(p48, "Burning", {
									["Level"] = 1,
									["Duration"] = 8
								})
								v_u_5:ApplyStatus(p48, "Slowness", {
									["Level"] = 10,
									["Duration"] = 0.25,
									["Hidden"] = true
								})
								p_u_34.Rig.firebrand.Transparency = 0
								task.delay(1.5, function()
									-- upvalues: (ref) p_u_34
									game.TweenService:Create(p_u_34.Rig.firebrand, TweenInfo.new(0.5), {
										["Transparency"] = 1
									}):Play()
								end)
								local v49 = ("%*/Start"):format(script.Parent)
								local v_u_50 = p_u_34
								local v_u_51 = "WalkspeedHit"
								local v52, v53 = pcall(function()
									-- upvalues: (copy) v_u_50, (copy) v_u_51
									if v_u_50.Behavior[v_u_51] then
										v_u_50.Behavior[v_u_51](v_u_50)
									end
								end)
								if not v52 then
									warn((("[%*]: Failed to call .%*() due to: %*"):format(v49, "WalkspeedHit", v53)))
								end
								local v54 = p48.Parent
								if tostring(v54) == "Survivors" then
									local v55 = require(game.ReplicatedStorage.Modules.Actors)
									if p48.Humanoid.Health <= 0 then
										v55:IncrementActorStats(p_u_34.Player, {
											["Action"] = "Killed a Survivor with Walkspeed Override",
											["RewardType"] = "DifficultKillerAction"
										})
										return
									end
									v55:IncrementActorStats(p_u_34.Player, {
										["Action"] = "Landed Walkspeed Override hit",
										["RewardType"] = "RegularKillerAction"
									})
								end
							end,
							["Ended"] = function()
								-- upvalues: (ref) v_u_47
								v_u_47 = true
							end
						}
					})
					local v57 = require(game.ReplicatedStorage.Modules.Network)
					local v58 = p_u_34:GetPivot().LookVector
					local v59 = v_u_3:ApplyVelocity(p_u_34.Rig.PrimaryPart, p_u_34.Config.WalkspeedOverrideSpeed)
					v59.LineDirection = (v58 * Vector3.new(1, 0, 1)).Unit
					game.Debris:AddItem(v59, v_u_35 + 3)
					game.TweenService:Create(v59, TweenInfo.new(v_u_35 * 1.5), {
						["LineVelocity"] = p_u_34.Config.WalkspeedOverrideSpeed / 2
					}):Play()
					v_u_2:Play(p_u_34.Config.Sounds.WalkspeedOverrideLunge, {
						["Parent"] = p_u_34.Rig.PrimaryPart
					})
					local v_u_60 = false
					local v61 = ("%*C00lkiddCollision"):format(p_u_34.Player.Name)
					v57:SetConnection(v61, "REMOTE_EVENT", function(p62)
						-- upvalues: (ref) p_u_34, (ref) v_u_60
						if p62 == p_u_34.Player then
							v_u_60 = true
						else
							p62:Kick("not slick at all")
						end
					end)
					repeat
						task.wait()
					until v_u_46 or (v_u_47 or v_u_60)
					local v65 = "IDK"
					local v66
					if v_u_46 then
						v_u_3:GiveInvincible(p_u_34.Rig, "Walkspeed")
						v66 = "Hit"
					else
						v66 = v_u_60 and "Collide" or (v_u_47 and "Timeout" or v65)
					end
					local v67 = Instance.new("StringValue")
					v67.Name = "Result"
					v67.Value = v66
					v67.Parent = p_u_34.Rig
					game.Debris:AddItem(v67, 1.5)
					task.delay(1.5, function()
						-- upvalues: (ref) p_u_34, (ref) v_u_3
						p_u_34.AbilitiesDisabled = false
						v_u_3:RemoveInvincible(p_u_34.Rig, "Walkspeed")
					end)
					game.TweenService:Create(v59, TweenInfo.new(v66 == "Collide" and 0.25 or 0.5), {
						["LineVelocity"] = 0
					}):Play()
					game.Debris:AddItem(v59, 1.5)
					v_u_2:PlayVoiceline(p_u_34, ("WalkspeedOverride%*"):format(v66), {
						["Priority"] = 1.5
					})
					v_u_2:Play(p_u_34.Config.Sounds[("WalkspeedOverride%*"):format(v66)], {
						["Parent"] = p_u_34.Rig.PrimaryPart
					})
					v_u_3:SetSpeedCap(p_u_34.Rig, "C00lkiddWalkspeedOverride", nil)
					v57:RemoveConnection(v61, "REMOTE_EVENT")
					v56:Cancel()
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_34.Animations.WalkspeedOverrideStart:Play()
				p_u_34.Animations.WalkspeedOverrideLoop:Play()
				p_u_34.Rig:SetAttribute("FootstepsMuted", true)
				local v68 = v_u_3:CreateSpeedMultiplier(p_u_34.Player, 0, "HinderedMovement")
				local v_u_69 = nil
				task.spawn(function()
					-- upvalues: (copy) p_u_34, (ref) v_u_69
					p_u_34.Rig.PrimaryPart:WaitForChild("LinearVelocity", 2)
					local v70 = 0
					local v71 = false
					while not v_u_69 and p_u_34.Rig.PrimaryPart do
						if v70 >= 0.2 and p_u_34.Rig.PrimaryPart.AssemblyLinearVelocity.Magnitude <= p_u_34.Config.WalkspeedOverrideSpeed / 3 then
							if not v71 then
								require(game.ReplicatedStorage.Modules.Network):FireServerConnection(("%*C00lkiddCollision"):format(p_u_34.Player.Name), "REMOTE_EVENT")
							end
							return
						end
						v70 = v70 + game["Run Service"].Heartbeat:Wait()
					end
				end)
				local v72 = p_u_34.Rig:WaitForChild("Result", 6)
				v_u_69 = v72 and (v72.Value or "IDK BRUH") or "IDK BRUH"
				p_u_34.Rig:SetAttribute("FootstepsMuted", nil)
				p_u_34.Animations.WalkspeedOverrideStart:Stop()
				p_u_34.Animations.WalkspeedOverrideLoop:Stop()
				if v_u_69 == "Hit" then
					p_u_34.Animations.WalkspeedOverrideHit:Play(0)
				elseif p_u_34.Animations.WalkspeedOverrideDuration or p_u_34.Animations.WalkspeedOverrideCollide then
					if v_u_69 == "Timeout" and p_u_34.Animations.WalkspeedOverrideDuration then
						p_u_34.Animations.WalkspeedOverrideDuration:Play(0.05)
					elseif v_u_69 == "Collide" and p_u_34.Animations.WalkspeedOverrideCollide then
						p_u_34.Animations.WalkspeedOverrideCollide:Play(0.05)
					end
				else
					p_u_34.Animations.WalkspeedOverrideMiss:Play(0.05)
				end
				if v72 then
					repeat
						task.wait()
					until not v72.Parent
				end
				game.TweenService:Create(v68, TweenInfo.new(0.5), {
					["Value"] = 1
				}):Play()
				game.Debris:AddItem(v68, 0.5)
			end
		end
	},
	["PizzaDelivery"] = {
		["LayoutOrder"] = 4,
		["Icon"] = "rbxassetid://105652328381208",
		["KeybindType"] = "AltAbility3",
		["Cooldown"] = 50,
		["Callback"] = function(p_u_73)
			-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_9, (copy) v_u_5
			if game["Run Service"]:IsServer() then
				p_u_73.AbilitiesDisabled = true
				v_u_2:Play(p_u_73.Config.Sounds.PizzaDeliveryPunchGround, {
					["Parent"] = p_u_73.Rig.PrimaryPart
				})
				local v74 = ("%*/Summon"):format(script.Parent)
				local v_u_75 = "MinionSummon"
				local v76, v77 = pcall(function()
					-- upvalues: (copy) p_u_73, (copy) v_u_75
					if p_u_73.Behavior[v_u_75] then
						p_u_73.Behavior[v_u_75](p_u_73)
					end
				end)
				if not v76 then
					warn((("[%*]: Failed to call .%*() due to: %*"):format(v74, "MinionSummon", v77)))
				end
				task.delay(1, function()
					-- upvalues: (copy) p_u_73, (ref) v_u_3, (ref) v_u_2, (ref) v_u_9, (ref) v_u_5
					for v78 = 1, 2 do
						local v79 = p_u_73.Config.PizzaDeliveryRig
						if v79:IsA("Folder") then
							v79 = v79:GetChildren()[math.random(1, #v79:GetChildren())] or v79
						end
						local v_u_80 = v79:Clone()
						v_u_80:SetAttribute("Team", "Killers")
						v_u_80.PrimaryPart.Anchored = true
						v_u_3:FixCharacter(v_u_80, "Killers")
						v_u_3:AddHitboxes(v_u_80, "Killers")
						local v_u_81 = v_u_80.Humanoid
						v_u_81.WalkSpeed = p_u_73.Config.PizzaDeliveryGuySpeed
						v_u_81.MaxHealth = p_u_73.Config.PizzaDeliveryGuyHealth
						v_u_81.Health = p_u_73.Config.PizzaDeliveryGuyHealth
						v_u_81.StateChanged:Connect(function(_, _)
							-- upvalues: (copy) v_u_81
							v_u_81.PlatformStand = false
							v_u_81:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
							v_u_81:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
							v_u_81:ChangeState(Enum.HumanoidStateType.GettingUp)
						end)
						local v_u_82 = v_u_2:Play(p_u_73.Config.Sounds.PizzaDeliveryMinionIdle, {
							["Parent"] = v_u_80.PrimaryPart,
							["Looped"] = true,
							["Volume"] = 0
						})
						game.TweenService:Create(v_u_82, TweenInfo.new(1.75), {
							["Volume"] = 0.5
						}):Play()
						local v_u_83 = false
						local v84 = p_u_73.Config.PizzaDeliveryGuyLifetime
						task.delay(v84 - 1, function()
							-- upvalues: (ref) v_u_83, (copy) v_u_82, (copy) v_u_80
							if not v_u_83 then
								v_u_83 = true
								if v_u_82 and v_u_82.Parent then
									game.TweenService:Create(v_u_82, TweenInfo.new(0.8), {
										["PlaybackSpeed"] = 0
									}):Play()
								end
								game.Debris:AddItem(v_u_80, 1)
								for _, v85 in pairs(v_u_80:GetDescendants()) do
									if v85:IsA("BasePart") or v85:IsA("Decal") then
										game.TweenService:Create(v85, TweenInfo.new(1), {
											["Transparency"] = 1
										}):Play()
									end
								end
							end
						end)
						game.Debris:AddItem(v_u_80, p_u_73.Config.PizzaDeliveryGuyLifetime)
						v_u_80.Parent = workspace.Map.Ingame
						local v_u_86 = v_u_83
						local v_u_87 = {}
						for v88, v89 in pairs(p_u_73.Config.PizzaDeliveryAnimations) do
							v_u_87[v88] = v_u_3:LoadAnimationFromID(v_u_80, v89, true)
						end
						v_u_87.Idle:Play()
						v_u_87.Summoned:Play(0)
						v_u_80:SetPrimaryPartCFrame(p_u_73.Rig.PrimaryPart.CFrame * CFrame.new(v78 % 2 == 0 and 6 or -6, 0, 0))
						v_u_2:Play(p_u_73.Config.Sounds.PizzaDeliveryGuySpawned, {
							["Parent"] = p_u_73.Rig.PrimaryPart
						})
						v_u_80:AddTag("Ragdoll")
						task.wait(0.75)
						task.delay(1.75, function()
							-- upvalues: (copy) v_u_80, (copy) v_u_87, (copy) v_u_81, (ref) v_u_3, (ref) p_u_73, (ref) v_u_2, (ref) v_u_86, (copy) v_u_82, (ref) v_u_9, (ref) v_u_5
							if not v_u_80.PrimaryPart then
								return
							end
							v_u_80.PrimaryPart.Anchored = false
							v_u_87.Walk:Play()
							local v90 = require(game.ReplicatedStorage.Modules.Actors)
							local v91 = require(game.ReplicatedStorage.Modules.SimplePath).new(v_u_80)
							while task.wait() and (v_u_80.Parent and (v_u_80.PrimaryPart and v_u_81.Health > 0)) do
								local v92, v93 = v_u_3:GetClosestPlayerFromPosition(v_u_80.PrimaryPart.Position)
								local v94 = v92 and v92.PrimaryPart
								if v94 then
									v94 = v92.PrimaryPart.Position
								end
								local v95
								if v92 then
									v95 = game.Players:GetPlayerFromCharacter(v92)
								else
									v95 = v92
								end
								if v95 then
									v95 = v90.CurrentActors[v95]
								end
								if p_u_73.Rig.Parent and (v93 and v93 < p_u_73.Config.PizzaDeliveryGuyAttackRadius) then
									require(game.ReplicatedStorage.Modules.Ragdolls).AddProfile(v92, {
										["Velocity"] = (v92.PrimaryPart.Position - v_u_80.PrimaryPart.Position).Unit * 30
									})
									v_u_2:Play(p_u_73.Config.Sounds.PizzaDeliveryMinionHit, {
										["Parent"] = v_u_80.PrimaryPart
									})
									task.delay(1, function()
										-- upvalues: (ref) v_u_86, (ref) v_u_82, (ref) v_u_80
										if not v_u_86 then
											v_u_86 = true
											if v_u_82 and v_u_82.Parent then
												game.TweenService:Create(v_u_82, TweenInfo.new(0.8), {
													["PlaybackSpeed"] = 0
												}):Play()
											end
											game.Debris:AddItem(v_u_80, 1)
											for _, v96 in pairs(v_u_80:GetDescendants()) do
												if v96:IsA("BasePart") or v96:IsA("Decal") then
													game.TweenService:Create(v96, TweenInfo.new(1), {
														["Transparency"] = 1
													}):Play()
												end
											end
										end
									end)
									v_u_87.Walk:Stop(0)
									v_u_87.Hit:Play(0)
									v_u_3:ApplyDamage(v92, p_u_73.Config.PizzaDeliveryGuyDamage)
									if v92.Name == "Elliot" and not v_u_3:IsAlive(v92) then
										v_u_9:IncrementAchievementProgress(p_u_73.Player, "c00lkiddPizzaMinion")
									end
									v_u_3:RevealPlayerAuraTo(p_u_73.Player, v92, 7.5)
									local v97 = ("%*/MinionHit"):format(script.Parent)
									local v_u_98 = p_u_73
									local v_u_99 = "MinionHit"
									local v100, v101 = pcall(function()
										-- upvalues: (copy) v_u_98, (copy) v_u_99
										if v_u_98.Behavior[v_u_99] then
											v_u_98.Behavior[v_u_99](v_u_98)
										end
									end)
									if not v100 then
										warn((("[%*]: Failed to call .%*() due to: %*"):format(v97, "MinionHit", v101)))
									end
									v_u_5:ApplyStatus(v92, "Burning", {
										["Level"] = 1,
										["Duration"] = 3
									})
									v_u_5:ApplyStatus(v92, "Slowness", {
										["Level"] = 2,
										["Duration"] = 3
									})
									v_u_2:PlayVoiceline(p_u_73, "PizzaDeliveryHit", {
										["Priority"] = 0,
										["Chance"] = 1
									})
									local v102 = v92.Parent
									if tostring(v102) == "Survivors" then
										require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(p_u_73.Player, {
											["Action"] = "A pizza delivery minion attacked a Survivor",
											["RewardType"] = "EasyKillerAction"
										})
									end
									if v95 and v95.Behavior then
										v95.Behavior.AILastSeen = nil
									end
									break
								end
								if not (p_u_73.Rig.Parent and v94) then
									task.delay(1, function()
										-- upvalues: (ref) v_u_86, (ref) v_u_82, (ref) v_u_80
										if not v_u_86 then
											v_u_86 = true
											if v_u_82 and v_u_82.Parent then
												game.TweenService:Create(v_u_82, TweenInfo.new(0.8), {
													["PlaybackSpeed"] = 0
												}):Play()
											end
											game.Debris:AddItem(v_u_80, 1)
											for _, v103 in pairs(v_u_80:GetDescendants()) do
												if v103:IsA("BasePart") or v103:IsA("Decal") then
													game.TweenService:Create(v103, TweenInfo.new(1), {
														["Transparency"] = 1
													}):Play()
												end
											end
										end
									end)
									v_u_81.WalkSpeed = 0
									v_u_87.Walk:Stop(0)
									break
								end
								if v95 and v95.Behavior then
									v95.Behavior.AILastSeen = tick()
								end
								v91:Run(v94)
							end
							if v91 and v91.Destroy then
								v91:Destroy()
							end
						end)
					end
				end)
				task.delay(3, function()
					-- upvalues: (copy) p_u_73
					p_u_73.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_73.Animations.SummonPizzaDelivery:Play(0.025)
				local v_u_104 = v_u_3:CreateSpeedMultiplier(p_u_73.Player, 0, "HinderedMovement")
				task.delay(2.5, function()
					-- upvalues: (copy) v_u_104
					game.TweenService:Create(v_u_104, TweenInfo.new(0.5), {
						["Value"] = 1
					}):Play()
					game.Debris:AddItem(v_u_104, 0.5)
				end)
			end
		end
	}
}
v1.Abilities = v105
function v1.OnIntroduction(_, p_u_106, p_u_107, p_u_108)
	task.spawn(function()
		-- upvalues: (copy) p_u_107
		local v109 = p_u_107:WaitForChild("firebrand", 20)
		if v109 then
			v109.Transparency = 0
		end
	end)
	local v_u_110 = nil
	task.delay(0.5, function()
		-- upvalues: (ref) v_u_110
		v_u_110 = game.Lighting.ClockTime
		game.TweenService:Create(game.Lighting, TweenInfo.new(0.75), {
			["ClockTime"] = 0
		}):Play()
	end)
	task.delay(1.5, function()
		-- upvalues: (copy) p_u_106, (ref) v_u_110, (copy) p_u_108
		local v111 = p_u_106.Config.IntroSky:Clone()
		v111.Parent = game.Lighting
		local v112 = {
			["ClockTime"] = v_u_110 or 12
		}
		game.TweenService:Create(game.Lighting, TweenInfo.new(1.5), v112):Play()
		game.Debris:AddItem(v111, p_u_108 - 1.5)
	end)
end
function v1.OnVictory(_, p113, p_u_114, _, p_u_115)
	-- upvalues: (copy) v_u_7, (copy) v_u_6
	if p113 == "Start" then
		v_u_7:SetCustomLighting(p_u_114.Config.OutroLighting)
		tick()
		game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true)
		local v_u_116 = v_u_6.RenderStepped:Connect(function()
			workspace.CurrentCamera.FieldOfView = 25
		end)
		task.delay(p_u_115, function()
			-- upvalues: (copy) v_u_116
			v_u_116:Disconnect()
		end)
		task.spawn(function()
			-- upvalues: (copy) p_u_114, (copy) p_u_115, (ref) v_u_6
			local v117 = p_u_114.Config.IntroSky:Clone()
			v117.Parent = game.Lighting
			game.Debris:AddItem(v117, p_u_115 - 1.5)
			local v_u_118 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 3)
			if v_u_118 then
				local v_u_119 = nil
				v_u_119 = v_u_6.RenderStepped:Connect(function(p120)
					-- upvalues: (copy) v_u_118, (ref) v_u_119
					if v_u_118 and (v_u_118.Parent and v_u_118:FindFirstChild("People")) then
						for v121, v122 in pairs(v_u_118.People:GetChildren()) do
							local v123 = v122.PrimaryPart
							v123.CFrame = v123.CFrame * CFrame.Angles(0, p120 * (v121 % 2 == 0 and 2.25 or -2.25), 0)
						end
						task.wait()
					else
						v_u_119:Disconnect()
					end
				end)
				task.delay(p_u_115, v_u_119.Disconnect, v_u_119)
			end
		end)
	elseif p113 == "End" then
		game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", false)
		game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil)
		v_u_7:SetAsCurrentLighting()
	end
end
function v1.OnExecution(_, p124, p_u_125)
	if p_u_125.Name == "007n7" then
		local _ = p124.Rig.PrimaryPart.CFrame * CFrame.new(3, -2.75, 2.25) * CFrame.Angles(1.5707963267948966, 0, -0.3490658503988659)
	end
	local v_u_126 = p_u_125.Name == "007n7" and Vector3.new() or (p124.Rig.PrimaryPart.CFrame * CFrame.new(5, 0.5, 1)).LookVector.Unit * 200
	local v127 = p_u_125.Name == "007n7" and 3.6 or 3.5
	local v_u_128 = require(game.ReplicatedStorage.Modules.Ragdolls)
	task.delay(2.1, function()
		-- upvalues: (copy) v_u_128, (copy) p_u_125, (copy) v_u_126
		v_u_128.AddProfile(p_u_125, {
			["AnchorDelay"] = true,
			["Applied"] = os.clock() + 5,
			["Velocity"] = v_u_126
		})
		local v129 = p_u_125:FindFirstChild("Humanoid")
		if v129 then
			v129.BreakJointsOnDeath = false
			v129.Health = 0
		end
	end)
	task.delay(v127, function()
		-- upvalues: (copy) p_u_125
		if p_u_125 and p_u_125.PrimaryPart then
			p_u_125.PrimaryPart.Anchored = false
		end
	end)
end
return v1
