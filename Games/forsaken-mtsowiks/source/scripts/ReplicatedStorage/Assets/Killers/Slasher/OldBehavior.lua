-- Decompiled by Krnl

local v_u_1 = game:GetService("TweenService")
local v_u_2 = game:GetService("ReplicatedStorage")
local v3 = {}
local v_u_4 = require(v_u_2.Modules.Sounds)
local v_u_5 = require(v_u_2.Modules.Util)
local v_u_6 = require(v_u_2.Modules.Hitboxes)
local v_u_7 = require(v_u_2.Modules.Statuses)
local v_u_8 = require(v_u_2.Modules.Network)
local v_u_9 = require(v_u_2.Modules.AchievementUtil)
game:GetService("Debris")
local v_u_10 = require(v_u_2.Modules.Schematics.Lighting)
local v_u_11 = false
local function v_u_15(p12)
	-- upvalues: (copy) v_u_5, (copy) v_u_4, (copy) v_u_8, (copy) v_u_1, (copy) v_u_2
	if p12 and (p12.Enraged and p12.Rig.Parent) then
		p12.Enraged = nil
		if game["Run Service"]:IsServer() then
			v_u_5:RemoveInvincible(p12.Rig, "Raging")
			if p12.EnragedSFX then
				p12.EnragedSFX:Destroy()
				p12.EnragedSFX = nil
			end
			v_u_4:Play(p12.Config.Sounds.EnragedEnd, {
				["Parent"] = p12.Rig.PrimaryPart
			})
			for _, v13 in pairs(p12.Rig:GetDescendants()) do
				if v13.Name == "RagingPace" then
					v13.Enabled = false
				end
			end
			v_u_8:FireClientConnection(p12.Player, "PacifyJason", "REMOTE_EVENT")
			return
		end
		if game["Run Service"]:IsClient() then
			p12.AnimationType = nil
			p12.MovementAnimSpeed = nil
			v_u_8:FireConnection("DisableSprinting", "ENRAGED", false)
			v_u_8:RemoveConnection("PacifyJason", "REMOTE_EVENT")
			if p12.TargetedPlayer then
				v_u_5:RevealPlayerAura(p12.TargetedPlayer, p12.Config.EnragedAuraLingerTime)
				p12.TargetedPlayer = nil
			end
			if p12.SpeedModifier then
				v_u_1:Create(p12.SpeedModifier, TweenInfo.new(1), {
					["Value"] = 1
				}):Play()
				game.Debris:AddItem(p12.SpeedModifier, 1)
			end
			local v14 = v_u_5:CreateSpeedMultiplier(p12.Rig, 0.001, "Pacified")
			v_u_1:Create(v14, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				["Value"] = 1
			}):Play()
			game.Debris:AddItem(v14, 1)
			require(v_u_2.Systems.Character.Game.Sprinting).StaminaCap = nil
		end
	end
end
local v74 = {
	["Slash"] = {
		["LayoutOrder"] = 1,
		["Icon"] = "rbxassetid://97183429269286",
		["KeybindType"] = "MainAbility",
		["Cooldown"] = function(p16, p17)
			return p16.Enraged and p16.Config[("Enraged%*Cooldown"):format(p17)] or p16.Config[("%*Cooldown"):format(p17)]
		end,
		["Callback"] = function(p_u_18)
			-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_1, (copy) v_u_6, (copy) v_u_7, (copy) v_u_15
			if game["Run Service"]:IsServer() then
				p_u_18.AbilitiesDisabled = true
				v_u_4:Play(p_u_18.Config.Sounds.Swing, {
					["Parent"] = p_u_18.Rig.PrimaryPart,
					["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
					["Volume"] = 0.25
				})
				task.delay(0.075, function()
					-- upvalues: (copy) p_u_18, (ref) v_u_5, (ref) v_u_1
					if p_u_18.Enraged then
						local v19 = v_u_5:ApplyVelocity(p_u_18.Rig.PrimaryPart, p_u_18.Config.EnragedSlashLungeForce)
						v_u_1:Create(v19, TweenInfo.new(1), {
							["LineVelocity"] = v19.LineVelocity / 100
						}):Play()
						game.Debris:AddItem(v19, 0.6)
					end
				end)
				task.delay(p_u_18.Config.SlashWindup, function()
					-- upvalues: (ref) v_u_6, (copy) p_u_18, (ref) v_u_5, (ref) v_u_7, (ref) v_u_4, (ref) v_u_15
					local v20 = v_u_6
					local v21 = p_u_18.Player
					local v22 = {
						["Size"] = Vector3.new(4.5, 6, 7.5),
						["CFrameOffset"] = CFrame.new(0, 0, -1.25)
					}
					local v23 = p_u_18
					v22.Damage = v23.Enraged and v23.Config.EnragedSlashDamage or v23.Config.SlashDamage
					v22.Time = p_u_18.Config.SlashLinger
					v22.Knockback = 2
					v22.HitMultiple = true
					v22.ExecuteOnKill = true
					v22.Connections = {
						["Hit"] = function(p24, p25)
							-- upvalues: (ref) v_u_5, (ref) v_u_7, (ref) v_u_4, (ref) p_u_18, (ref) v_u_15
							v_u_5:CreateSpeedMultiplier(p24, 1.5, "HitSpeedBonus", 1.25)
							v_u_7:ApplyStatus(p24, "Bleeding", {
								["Level"] = 1,
								["Duration"] = 5
							})
							if p25 then
								v_u_4:Play(p_u_18.Config.Sounds.Hit, {
									["Parent"] = p_u_18.Rig.PrimaryPart,
									["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
									["Volume"] = 0.25
								})
								v_u_15(p_u_18)
							end
						end
					}
					v20:CreateHitbox(v21, v22)
				end)
				task.delay(0.5, function()
					-- upvalues: (ref) v_u_15, (copy) p_u_18
					v_u_15(p_u_18)
				end)
				task.delay(0.85, function()
					-- upvalues: (copy) p_u_18
					p_u_18.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_18.Animations.Slash:Play(0.025)
			end
		end
	},
	["Behead"] = {
		["LayoutOrder"] = 2,
		["Icon"] = "rbxassetid://115283980500353",
		["KeybindType"] = "AltAbility1",
		["Cooldown"] = function(p26, p27)
			return p26.Enraged and p26.Config[("Enraged%*Cooldown"):format(p27)] or p26.Config[("%*Cooldown"):format(p27)]
		end,
		["Callback"] = function(p_u_28)
			-- upvalues: (copy) v_u_4, (copy) v_u_6, (copy) v_u_9, (copy) v_u_2, (copy) v_u_5, (copy) v_u_7, (copy) v_u_15, (copy) v_u_1
			if game["Run Service"]:IsServer() then
				p_u_28.AbilitiesDisabled = true
				v_u_4:Play(p_u_28.Config.Sounds.Swing, {
					["Parent"] = p_u_28.Rig.PrimaryPart,
					["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
					["Volume"] = 0.25
				})
				task.delay(0.45, function()
					-- upvalues: (ref) v_u_6, (copy) p_u_28, (ref) v_u_9, (ref) v_u_2, (ref) v_u_5, (ref) v_u_7, (ref) v_u_4, (ref) v_u_15
					local v29 = v_u_6
					local v30 = p_u_28.Player
					local v31 = {
						["Size"] = Vector3.new(8, 2, 7),
						["CFrameOffset"] = CFrame.new(0, 0, -2)
					}
					local v32 = p_u_28
					v31.Damage = v32.Enraged and v32.Config.EnragedBeheadDamage or v32.Config.BeheadDamage
					v31.Time = 0.15
					v31.Knockback = 2
					v31.HitMultiple = true
					v31.Connections = {
						["Hit"] = function(p33, p34)
							-- upvalues: (ref) v_u_9, (ref) p_u_28, (ref) v_u_2, (ref) v_u_5, (ref) v_u_7, (ref) v_u_4, (ref) v_u_15
							if p33.Humanoid.Health <= 0 then
								local v35 = p33:FindFirstChild("Head")
								if v35 then
									v35:Destroy()
								end
								v_u_9:IncrementAchievementProgress(p_u_28.Player, "JasonBrutality")
								local v36 = p33.Parent
								if tostring(v36) == "Survivors" then
									require(v_u_2.Modules.Actors):IncrementActorStats(p_u_28.Player, {
										["Action"] = "Killed a Survivor with Behead",
										["RewardType"] = "DifficultKillerAction"
									})
								end
							else
								v_u_5:CreateSpeedMultiplier(p33, 1.5, "HitSpeedBonus", 0.9)
								v_u_7:ApplyStatus(p33, "Helpless", {
									["Level"] = 1,
									["Duration"] = 12
								})
								local v37 = p33.Parent
								if tostring(v37) == "Survivors" then
									require(v_u_2.Modules.Actors):IncrementActorStats(p_u_28.Player, {
										["Action"] = "Landed Behead hit",
										["RewardType"] = "EasyKillerAction"
									})
								end
							end
							if p34 then
								v_u_4:Play(p_u_28.Config.Sounds.Hit, {
									["Parent"] = p_u_28.Rig.PrimaryPart,
									["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
									["Volume"] = 0.25
								})
								v_u_15(p_u_28)
							end
						end
					}
					v29:CreateHitbox(v30, v31)
				end)
				task.delay(0.5, function()
					-- upvalues: (ref) v_u_15, (copy) p_u_28
					v_u_15(p_u_28)
				end)
				task.delay(0.55, function()
					-- upvalues: (ref) v_u_7, (copy) p_u_28
					v_u_7:ApplyStatus(p_u_28.Rig, "Slowness", {
						["Level"] = 1,
						["Duration"] = 2
					})
				end)
				task.delay(0.8, function()
					-- upvalues: (copy) p_u_28
					p_u_28.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_28.Animations.Behead:Play(0.025)
				local v_u_38 = v_u_5:CreateSpeedMultiplier(p_u_28.Rig, 1, "BeheadAbility")
				v_u_1:Create(v_u_38, TweenInfo.new(0.125), {
					["Value"] = p_u_28.Enraged and p_u_28.Config.EnragedBeheadLunge or p_u_28.Config.BeheadLunge
				}):Play()
				task.delay(0.4, function()
					-- upvalues: (ref) v_u_1, (copy) v_u_38
					v_u_1:Create(v_u_38, TweenInfo.new(0.3), {
						["Value"] = 0.2
					}):Play()
				end)
				task.delay(1, function()
					-- upvalues: (ref) v_u_1, (copy) v_u_38
					v_u_1:Create(v_u_38, TweenInfo.new(0.3), {
						["Value"] = 1
					}):Play()
					game.Debris:AddItem(v_u_38, 0.3)
				end)
			end
		end
	},
	["GashingWound"] = {
		["LayoutOrder"] = 3,
		["Icon"] = "rbxassetid://96900331272883",
		["KeybindType"] = "AltAbility2",
		["Cooldown"] = function(p39, p40)
			return p39.Enraged and p39.Config[("Enraged%*Cooldown"):format(p40)] or p39.Config[("%*Cooldown"):format(p40)]
		end,
		["Callback"] = function(p_u_41)
			-- upvalues: (ref) v_u_11, (copy) v_u_4, (copy) v_u_6, (copy) v_u_5, (copy) v_u_9, (copy) v_u_2, (copy) v_u_15, (copy) v_u_1
			if game["Run Service"]:IsServer() then
				p_u_41.AbilitiesDisabled = true
				p_u_41.Cache.GashingWoundStart:Play(0.05)
				v_u_11 = true
				v_u_4:Play(p_u_41.Config.Sounds.GashingWoundSwing, {
					["Parent"] = p_u_41.Rig.PrimaryPart,
					["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
					["Volume"] = 0.25
				})
				local v42 = p_u_41.Enraged and p_u_41.Config.EnragedGashingWoundDamage or p_u_41.Config.GashingWoundDamage
				local v43 = {
					[0.333] = {
						["Damage"] = v42 / 5,
						["Time"] = 0.15,
						["DoLunge"] = true
					},
					[0.75] = {
						["Damage"] = v42 / 5,
						["Time"] = 0.15,
						["DoLunge"] = true
					},
					[1.533] = {
						["Damage"] = v42 / 5,
						["Time"] = 0.15,
						["DoLunge"] = true
					},
					[1.966] = {
						["Damage"] = v42 / 10,
						["Time"] = 0.15,
						["DoLunge"] = true
					},
					[2.333] = {
						["Damage"] = v42 / 10,
						["Time"] = 0.15
					},
					[2.983] = {
						["Damage"] = v42 / 5,
						["Time"] = 0.15,
						["DoLunge"] = true
					}
				}
				tick()
				local v_u_44 = nil
				local v_u_45 = nil
				for v_u_46, v_u_47 in pairs(v43) do
					task.delay(v_u_46, function()
						-- upvalues: (copy) v_u_46, (ref) v_u_44, (ref) v_u_6, (copy) p_u_41, (copy) v_u_47, (ref) v_u_4, (ref) v_u_5, (ref) v_u_45, (ref) v_u_9, (ref) v_u_2
						if v_u_46 < 0.5 or v_u_44 then
							local v48 = v_u_6
							local v49 = p_u_41.Player
							local v56 = {
								["Size"] = Vector3.new(8, 4, 8),
								["CFrameOffset"] = CFrame.new(0, 0, -2.25),
								["Damage"] = v_u_47.Damage,
								["Time"] = v_u_47.Time,
								["Knockback"] = 0,
								["HitMultiple"] = true,
								["Connections"] = {
									["Hit"] = function(p50, p51)
										-- upvalues: (ref) v_u_4, (ref) p_u_41, (ref) v_u_46, (ref) v_u_44, (ref) v_u_5, (ref) v_u_45, (ref) v_u_9, (ref) v_u_2
										if p51 then
											v_u_4:Play(p_u_41.Config.Sounds.Hit, {
												["Parent"] = p_u_41.Rig.PrimaryPart,
												["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
												["Volume"] = 0.25
											})
										end
										if v_u_46 <= 0.5 and not v_u_44 then
											v_u_44 = p50
											v_u_5:SetUpCutscene(p_u_41.Rig, v_u_44)
											v_u_5:GiveInvincible(p_u_41.Rig, "Gashing")
											local v52 = p_u_41.Cache.GashingWound
											v52:Play(0)
											v52.TimePosition = p_u_41.Cache.GashingWoundStart.TimePosition
											v_u_45 = v_u_5:LoadAnimationFromID(v_u_44, p_u_41.Config.Animations.GashingWound.PlayerRig, true)
											v_u_45:Play(0.05)
											v_u_45.TimePosition = p_u_41.Cache.GashingWoundStart.TimePosition
											p_u_41.Cache.GashingWoundStart:Stop(0)
											v_u_4:PlayVoiceline(p_u_41, "GashingWoundHit", {
												["Priority"] = 2
											})
											if p50.Humanoid.Health <= 0 then
												for _, v53 in ipairs(workspace:GetDescendants()) do
													if v53:IsA("Model") and (v53.Name == "SubspaceTripmine" or string.match(v53.Name, "TaphTripmine$")) then
														local v54 = v53.PrimaryPart or v53:FindFirstChildWhichIsA("BasePart")
														if v54 and (v54.Position - p50.HumanoidRootPart.Position).Magnitude <= 20 then
															v_u_9:IncrementAchievementProgress(p_u_41.Player, "JasonFool")
															break
														end
													end
												end
											end
											local v55 = p50.Parent
											if tostring(v55) == "Survivors" then
												require(v_u_2.Modules.Actors):IncrementActorStats(p_u_41.Player, {
													["Action"] = "Landed Gashing Wound hit",
													["RewardType"] = "RegularKillerAction"
												})
											end
										end
									end
								}
							}
							v48:CreateHitbox(v49, v56)
						end
					end)
				end
				task.delay(0.5, function()
					-- upvalues: (ref) v_u_44, (ref) v_u_4, (copy) p_u_41, (ref) v_u_5, (ref) v_u_45, (ref) v_u_15, (ref) v_u_11
					local v57 = v_u_44 and 4.25 or 0.5
					if v_u_44 then
						v_u_4:Play(p_u_41.Config.Sounds.GashingWoundHit, {
							["Parent"] = p_u_41.Rig.PrimaryPart
						})
					else
						v_u_4:Play(p_u_41.Config.Sounds.GashingWoundMiss, {
							["Parent"] = p_u_41.Rig.PrimaryPart
						})
						v_u_5:RemoveInvincible(p_u_41.Rig, "Gashing")
					end
					local v58 = Instance.new("StringValue")
					v58.Name = "Result"
					v58.Value = v_u_44 and "HitPlayer" or "HitNothing"
					v58.Parent = p_u_41.Rig
					game.Debris:AddItem(v58, 5)
					task.delay(v57 - 1.85, function()
						-- upvalues: (ref) v_u_45, (ref) v_u_44, (ref) p_u_41
						if v_u_45 then
							v_u_45:Stop(0)
						end
						if v_u_44 and v_u_44.PrimaryPart then
							local v59 = RaycastParams.new()
							v59.FilterDescendantsInstances = workspace.Players:GetDescendants()
							v59.FilterType = Enum.RaycastFilterType.Exclude
							local v60 = workspace:Raycast(p_u_41.Rig.PrimaryPart.Position, p_u_41.Rig.PrimaryPart.CFrame.LookVector * 100, v59)
							local v61
							if v60 then
								local v62 = v60.Distance
								v61 = math.clamp(v62, (-1 / 0), 3) or 3
							else
								v61 = 3
							end
							if v61 < 3 then
								v61 = -(v_u_44.PrimaryPart.Size.Z / 2) - (3 - v61) * 2
							end
							v_u_44:SetPrimaryPartCFrame(p_u_41.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -v61))
							v_u_44.PrimaryPart.Anchored = false
							v_u_44.PrimaryPart.Velocity = p_u_41.Rig.PrimaryPart.CFrame.LookVector * (75 * (v61 / 3))
							local v63 = p_u_41.Rig.PrimaryPart.CFrame.LookVector * (75 * (v61 / 3))
							v_u_44.PrimaryPart.Velocity = v63
							local v64 = require(game.ReplicatedStorage.Modules.Ragdolls)
							v64.AddProfile(v_u_44, {
								["Velocity"] = v63
							})
							v64.EnableRagdoll(v_u_44, 1.25)
						end
					end)
					task.delay(v57 + 0.25, function()
						-- upvalues: (ref) v_u_15, (ref) p_u_41
						v_u_15(p_u_41)
					end)
					task.delay(v57 + 0.75, function()
						-- upvalues: (ref) p_u_41
						p_u_41.Rig.PrimaryPart.Anchored = false
					end)
					task.delay(v57 + 1.25, function()
						-- upvalues: (ref) p_u_41
						p_u_41.AbilitiesDisabled = false
					end)
					task.delay(v57 + 1.5, function()
						-- upvalues: (ref) v_u_11, (ref) v_u_5, (ref) p_u_41
						v_u_11 = false
						v_u_5:RemoveInvincible(p_u_41.Rig, "Gashing")
					end)
				end)
			elseif game["Run Service"]:IsClient() then
				local v_u_65 = v_u_5:CreateSpeedMultiplier(p_u_41.Rig, 1, "BeheadAbility")
				v_u_1:Create(v_u_65, TweenInfo.new(0.2), {
					["Value"] = 0.001
				}):Play()
				local v66 = p_u_41.Rig:WaitForChild("Result", 5)
				if (v66 and v66.Value or "IDK") == "HitPlayer" then
					task.delay(4.75, function()
						-- upvalues: (ref) v_u_1, (copy) v_u_65
						v_u_1:Create(v_u_65, TweenInfo.new(0.2), {
							["Value"] = 1
						}):Play()
						game.Debris:AddItem(v_u_65, 0.2)
					end)
					return
				end
				task.delay(1, function()
					-- upvalues: (ref) v_u_1, (copy) v_u_65
					v_u_1:Create(v_u_65, TweenInfo.new(0.2), {
						["Value"] = 1
					}):Play()
					game.Debris:AddItem(v_u_65, 0.2)
				end)
			end
		end
	},
	["RagingPace"] = {
		["LayoutOrder"] = 3,
		["Icon"] = "rbxassetid://86530225037587",
		["KeybindType"] = "AltAbility3",
		["Callback"] = function(p_u_67)
			-- upvalues: (copy) v_u_5, (copy) v_u_4, (copy) v_u_15, (copy) v_u_8, (copy) v_u_1, (copy) v_u_2
			if game["Run Service"]:IsServer() then
				p_u_67.AbilitiesDisabled = true
				task.delay(0.233, function()
					-- upvalues: (copy) p_u_67, (ref) v_u_5, (ref) v_u_4
					p_u_67.Enraged = true
					v_u_5:GiveInvincible(p_u_67.Rig, "Raging")
					p_u_67.EnragedSFX = v_u_4:Play(p_u_67.Config.Sounds.Enraged, {
						["Parent"] = p_u_67.Rig.PrimaryPart,
						["Looped"] = true,
						["Volume"] = 0.25
					})
					v_u_4:Play(p_u_67.Config.Sounds.EnragedStart, {
						["Parent"] = p_u_67.Rig.PrimaryPart
					})
					if p_u_67.EnragedSFX then
						game.Debris:AddItem(p_u_67.EnragedSFX, p_u_67.Config.EnragedTime)
					end
					for _, v68 in pairs(p_u_67.Rig:GetDescendants()) do
						if v68.Name == "RagingPace" then
							v68.Enabled = true
						end
					end
				end)
				task.delay(p_u_67.Config.EnragedTime, function()
					-- upvalues: (ref) v_u_15, (copy) p_u_67
					v_u_15(p_u_67)
				end)
				task.delay(1, function()
					-- upvalues: (copy) p_u_67
					p_u_67.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_67.Animations.EnragedStart:Play(0.025)
				p_u_67.AnimationType = "Enraged"
				p_u_67.MovementAnimSpeed = 1.425
				p_u_67.Enraged = true
				v_u_8:FireConnection("DisableSprinting", "ENRAGED", true)
				v_u_8:SetConnection("PacifyJason", "REMOTE_EVENT", function()
					-- upvalues: (ref) v_u_15, (copy) p_u_67
					v_u_15(p_u_67)
				end)
				p_u_67.SpeedModifier = v_u_5:CreateSpeedMultiplier(p_u_67.Rig, 0.001, "ENRAGED")
				task.delay(0.75, function()
					-- upvalues: (ref) v_u_1, (copy) p_u_67
					v_u_1:Create(p_u_67.SpeedModifier, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						["Value"] = p_u_67.Config.EnragedSpeed / p_u_67.Config.Speed
					}):Play()
				end)
				local v69 = v_u_5:GetClosestPlayerFromPosition(p_u_67.Rig.PrimaryPart.Position)
				if v69 then
					p_u_67.TargetedPlayer = v69
					v_u_5:RevealPlayerAura(v69, p_u_67.Config.EnragedTime + 2)
				end
				task.delay(1, function()
					-- upvalues: (copy) p_u_67, (ref) v_u_2
					local v70 = tick()
					while task.wait() and (p_u_67.Enraged and p_u_67.Rig.Parent) do
						local v71 = (tick() - v70) / p_u_67.Config.EnragedStaminaCapLerpTime
						local v72 = math.clamp(v71, 0, 1)
						local v73 = p_u_67.Config.MaxStamina + (p_u_67.Config.EnragedStaminaCap - p_u_67.Config.MaxStamina) * v72
						require(v_u_2.Systems.Character.Game.Sprinting).StaminaCap = v73
						if v72 >= 1 then
							break
						end
					end
				end)
			end
		end
	}
}
v3.Abilities = v74
function v3.Created(_, p_u_75)
	-- upvalues: (copy) v_u_9, (copy) v_u_5
	if game["Run Service"]:IsServer() then
		if workspace:GetAttribute("JasonSpecialDay") then
			v_u_9:IncrementAchievementProgress(p_u_75.Player, "JasonSpecialDay")
		end
		task.spawn(function()
			-- upvalues: (copy) p_u_75, (ref) v_u_5
			if not p_u_75.Cache then
				p_u_75.Cache = {}
			end
			p_u_75.Cache.GashingWoundStart = v_u_5:LoadAnimationFromID(p_u_75.Rig, p_u_75.Config.Animations.GashingWoundStart)
			p_u_75.Cache.GashingWound = v_u_5:LoadAnimationFromID(p_u_75.Rig, p_u_75.Config.Animations.GashingWound.KillerRig)
		end)
	end
end
function v3.OnIntroduction(_, _, p76, p77)
	-- upvalues: (copy) v_u_5, (copy) v_u_1
	local v78 = script.IntroWideDoor:Clone()
	v78:SetPrimaryPartCFrame(p76.PrimaryPart.CFrame)
	v78.Parent = p76
	for _, v79 in pairs(v78.Joints:GetChildren()) do
		v79.Part1 = v78.Parts:FindFirstChild(v79.Name, true)
		v79.Part0 = p76.PrimaryPart
	end
	local v_u_80 = v_u_5:CreateFOVMultiplier(game.Players.LocalPlayer, 0.4, "JasonIntroScene", p77)
	task.delay(0.783, function()
		-- upvalues: (copy) v_u_80, (ref) v_u_1
		v_u_80.Value = 0.35
		v_u_1:Create(v_u_80, TweenInfo.new(2.5, Enum.EasingStyle.Back), {
			["Value"] = 0.45
		}):Play()
	end)
end
function v3.OnVictory(_, p81, _, _, _)
	-- upvalues: (copy) v_u_1, (copy) v_u_10
	if p81 == "Start" then
		local v82 = game.Players.LocalPlayer.PlayerGui
		local v_u_83 = Instance.new("ScreenGui")
		v_u_83.Name = "JasonOutroOverlay"
		v_u_83.ResetOnSpawn = false
		v_u_83.IgnoreGuiInset = true
		v_u_83.Parent = v82
		task.spawn(function()
			-- upvalues: (copy) v_u_83, (ref) v_u_1
			local v84 = workspace.CurrentCamera
			v84.FieldOfView = 35
			game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true)
			task.wait(1.53)
			if v_u_83 and v_u_83.Parent and true or false then
				local v85 = Instance.new("ColorCorrectionEffect")
				v85.Name = "JasonOutroCCEffect"
				v85.Parent = game.Lighting
				local v86 = Instance.new("BlurEffect")
				v86.Name = "JasonOutroBlurEffect"
				v86.Parent = game.Lighting
				v_u_1:Create(v86, TweenInfo.new(0.125), {
					["Size"] = 2
				}):Play()
				v_u_1:Create(v84, TweenInfo.new(0.42), {
					["FieldOfView"] = 46
				}):Play()
				task.wait(0.42)
				if v_u_83 and v_u_83.Parent and true or false then
					v_u_1:Create(v85, TweenInfo.new(0.125, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
						["TintColor"] = Color3.fromRGB(190, 0, 3),
						["Brightness"] = 0.4,
						["Contrast"] = 0.2,
						["Saturation"] = 0.5
					}):Play()
					v_u_1:Create(v86, TweenInfo.new(0.125, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
						["Size"] = 30
					}):Play()
					v_u_1:Create(v84, TweenInfo.new(0.15), {
						["FieldOfView"] = 32
					}):Play()
					task.wait(0.17)
					if v_u_83 and v_u_83.Parent and true or false then
						v_u_1:Create(v86, TweenInfo.new(0.125), {
							["Size"] = 2
						}):Play()
						v_u_1:Create(v84, TweenInfo.new(0.15), {
							["FieldOfView"] = 35
						}):Play()
						task.wait(0.35)
						if v_u_83 and v_u_83.Parent and true or false then
							v_u_1:Create(v85, TweenInfo.new(0.125), {
								["TintColor"] = Color3.fromRGB(255, 105, 105),
								["Brightness"] = 0,
								["Contrast"] = 0,
								["Saturation"] = 0
							}):Play()
							task.wait(0.61)
							if v_u_83 and v_u_83.Parent and true or false then
								v_u_1:Create(v85, TweenInfo.new(0.125), {
									["TintColor"] = Color3.fromRGB(255, 226, 226)
								}):Play()
								v_u_1:Create(v84, TweenInfo.new(0.15), {
									["FieldOfView"] = 32
								}):Play()
								task.wait(0.29)
								if v_u_83 and v_u_83.Parent and true or false then
									v_u_1:Create(v86, TweenInfo.new(0.125), {
										["Size"] = 1
									}):Play()
									v_u_1:Create(v85, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
										["TintColor"] = Color3.fromRGB(255, 255, 255)
									}):Play()
									v_u_1:Create(v84, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
										["FieldOfView"] = 55
									}):Play()
								end
							else
								return
							end
						else
							return
						end
					else
						return
					end
				else
					return
				end
			else
				return
			end
		end)
	elseif p81 == "End" then
		if game.Players.LocalPlayer.PlayerGui:FindFirstChild("JasonOutroOverlay") then
			game.Players.LocalPlayer.PlayerGui.JasonOutroOverlay:Destroy()
		end
		game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil)
		v_u_10:SetAsCurrentLighting()
	end
end
function v3.OnExecution(_, p87, p_u_88)
	-- upvalues: (copy) v_u_8
	local v89 = p87.Rig.PrimaryPart.CFrame.LookVector * 100
	v_u_8:FireAllClientConnection("Ragdoll", "REMOTE_EVENT", p_u_88, workspace:GetServerTimeNow() + 1.15, (("%*|%*|%*"):format(v89.X, v89.Y, v89.Z)))
	task.delay(1.125, function()
		-- upvalues: (copy) p_u_88
		local v90 = p_u_88:FindFirstChild("Humanoid")
		if v90 then
			v90.BreakJointsOnDeath = false
			v90.Health = 0
		end
	end)
end
return v3
