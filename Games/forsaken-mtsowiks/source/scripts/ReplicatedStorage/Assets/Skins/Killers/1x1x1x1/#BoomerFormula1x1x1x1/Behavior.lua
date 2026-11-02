-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
local v_u_2 = require(game.ReplicatedStorage.Modules.Sounds)
local v_u_3 = require(game.ReplicatedStorage.Modules.Util)
local v_u_4 = require(game.ReplicatedStorage.Modules.Hitboxes)
local v_u_5 = require(game.ReplicatedStorage.Modules.Statuses)
local v_u_6 = require(game.ReplicatedStorage.Modules.Network)
local function v_u_13(p7, p8)
	if p7 and (p7.Parent and p7:FindFirstChild("ExtraModels")) then
		for v9, v10 in pairs({ p7.ExtraModels.HaxxedSwordLeft, p7.ExtraModels.HaxxedSwordRight }) do
			local v11 = v9 == 1 and "L" or "R"
			v10.Parts[("HaxxedBlade%*2"):format(v11)].Transparency = p8 and 0 or 1
			for _, v12 in pairs(v10.Parts[("HaxxedBlade%*"):format(v11)]:GetChildren()) do
				if v12:IsA("Beam") or v12:IsA("ParticleEmitter") then
					v12.Enabled = p8
				end
			end
		end
	end
end
local v69 = {
	["Slash"] = {
		["LayoutOrder"] = 1,
		["Icon"] = "rbxassetid://93874368032471",
		["KeybindType"] = "MainAbility",
		["Callback"] = function(p_u_14)
			-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_3, (copy) v_u_5
			if game["Run Service"]:IsServer() then
				p_u_14.AbilitiesDisabled = true
				v_u_2:Play(p_u_14.Config.Sounds.Swing, {
					["Parent"] = p_u_14.Rig.PrimaryPart,
					["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
					["Volume"] = 0.25
				})
				task.delay(0.4, function()
					-- upvalues: (ref) v_u_4, (copy) p_u_14, (ref) v_u_3, (ref) v_u_5, (ref) v_u_2
					local v15 = v_u_4
					local v16 = p_u_14.Player
					local v19 = {
						["Size"] = Vector3.new(4.5, 6, 7.5),
						["CFrameOffset"] = CFrame.new(0, 0, -1),
						["Damage"] = p_u_14.Config.SlashDamage,
						["Time"] = 0.2,
						["Knockback"] = 2,
						["HitMultiple"] = false,
						["ExecuteOnKill"] = true,
						["Connections"] = {
							["Hit"] = function(p17, p18)
								-- upvalues: (ref) v_u_3, (ref) v_u_5, (ref) p_u_14, (ref) v_u_2
								v_u_3:CreateSpeedMultiplier(p17, 1.5, "HitSpeedBonus", 1.25)
								v_u_5:ApplyStatus(p17, "PoisonedThatKillsYou", {
									["Stackable"] = true,
									["Level"] = p_u_14.Config.SlashPoisonLevel,
									["Duration"] = p_u_14.Config.SlashPoisonDuration
								})
								v_u_5:ApplyStatus(p17, "GlitchedOld", {
									["Stackable"] = true,
									["Level"] = p_u_14.Config.SlashGlitchLevel,
									["Duration"] = p_u_14.Config.SlashGlitchDuration
								})
								if p18 then
									v_u_2:Play(p_u_14.Config.Sounds.Hit, {
										["Parent"] = p_u_14.Rig.PrimaryPart,
										["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
										["Volume"] = 0.25
									})
								end
							end
						}
					}
					v15:CreateHitbox(v16, v19)
				end)
				task.delay(0.075, function()
					-- upvalues: (copy) p_u_14
					p_u_14.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_14.Animations.Slash:Play(0.175)
			end
		end
	},
	["MassInfection"] = {
		["LayoutOrder"] = 2,
		["Icon"] = "rbxassetid://93874368032471",
		["KeybindType"] = "AltAbility1",
		["Callback"] = function(p_u_20)
			-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_3, (copy) v_u_5
			if game["Run Service"]:IsServer() then
				p_u_20.AbilitiesDisabled = true
				v_u_2:Play(p_u_20.Config.Sounds.MassInfectionActivate, {
					["Parent"] = p_u_20.Rig.PrimaryPart,
					["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
					["Volume"] = 0.75
				})
				task.delay(1.6, function()
					-- upvalues: (ref) v_u_4, (copy) p_u_20, (ref) v_u_3, (ref) v_u_5
					local v21 = v_u_4
					local v22 = p_u_20.Player
					local v24 = {
						["Size"] = Vector3.new(6, 2, 6),
						["CFrameOffset"] = CFrame.new(0, 0, -1),
						["Damage"] = p_u_20.Config.MassInfectionSlashDamage,
						["Time"] = 0.125,
						["Knockback"] = 5,
						["HitMultiple"] = true,
						["Connections"] = {
							["Hit"] = function(p23, _)
								-- upvalues: (ref) v_u_3, (ref) v_u_5, (ref) p_u_20
								v_u_3:CreateSpeedMultiplier(p23, 1.5, "HitSpeedBonus", 2.5)
								v_u_5:ApplyStatus(p23, "PoisonedThatKillsYou", {
									["Stackable"] = true,
									["Level"] = p_u_20.Config.MassInfectionSlashPoisonLevel,
									["Duration"] = p_u_20.Config.MassInfectionSlashPoisonDuration
								})
								v_u_5:ApplyStatus(p23, "GlitchedOld", {
									["Stackable"] = true,
									["Level"] = p_u_20.Config.MassInfectionSlashGlitchLevel,
									["Duration"] = p_u_20.Config.MassInfectionSlashGlitchDuration
								})
							end
						}
					}
					v21:CreateHitbox(v22, v24)
				end)
				task.delay(1.7, function()
					-- upvalues: (copy) p_u_20, (ref) v_u_4, (ref) v_u_3, (ref) v_u_5
					if not p_u_20.Rig:GetAttribute("Stunned") then
						local v25 = p_u_20.Config.ShockwaveTemplate:Clone()
						local v_u_26 = v25.PrimaryPart
						v25.Parent = workspace.Map.Ingame
						v25:SetPrimaryPartCFrame(p_u_20.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, 2))
						local v27 = v_u_26.CFrame * CFrame.new(0, 0, -p_u_20.Config.MassInfectionShockwaveSpeed * p_u_20.Config.MassInfectionShockwaveLifetime)
						game.Debris:AddItem(v25, p_u_20.Config.MassInfectionShockwaveLifetime)
						game.TweenService:Create(v_u_26, TweenInfo.new(p_u_20.Config.MassInfectionShockwaveLifetime, Enum.EasingStyle.Linear), {
							["CFrame"] = v27
						}):Play()
						local v28 = v_u_4
						local v29 = p_u_20.Player
						local v31 = {
							["Size"] = Vector3.new(8, 5, 6),
							["CFrame"] = function()
								-- upvalues: (copy) v_u_26
								return v_u_26.CFrame
							end,
							["Damage"] = p_u_20.Config.MassInfectionShockwaveDamage,
							["Time"] = p_u_20.Config.MassInfectionShockwaveLifetime,
							["Knockback"] = 0.5,
							["HitMultiple"] = true,
							["PredictVelocity"] = false,
							["Connections"] = {
								["Hit"] = function(p30)
									-- upvalues: (ref) v_u_3, (ref) p_u_20, (ref) v_u_5
									v_u_3:RevealPlayerAuraTo(p_u_20.Player, p30, p_u_20.Config.MassInfectionShockwaveAuraDuration)
									v_u_5:ApplyStatus(p30, "PoisonedThatKillsYou", {
										["Stackable"] = true,
										["Level"] = p_u_20.Config.MassInfectionShockwavePoisonLevel,
										["Duration"] = p_u_20.Config.MassInfectionShockwavePoisonDuration
									})
									v_u_5:ApplyStatus(p30, "GlitchedOld", {
										["Stackable"] = true,
										["Level"] = p_u_20.Config.MassInfectionShockwaveGlitchLevel,
										["Duration"] = p_u_20.Config.MassInfectionShockwaveGlitchDuration
									})
								end
							}
						}
						v28:CreateHitbox(v29, v31)
					end
				end)
				task.delay(3.5, function()
					-- upvalues: (copy) p_u_20
					p_u_20.AbilitiesDisabled = false
				end)
				task.delay(0.5, function()
					-- upvalues: (copy) p_u_20, (ref) v_u_2
					for v32 = 1, 6 do
						p_u_20.Rig.HumanoidRootPart["Chain" .. v32]["Chain" .. v32].Enabled = true
						p_u_20.Rig.HumanoidRootPart["Chain" .. v32]["Orb" .. v32].Enabled = true
						v_u_2:Play(p_u_20.Config.Sounds.Chains, {
							["Parent"] = p_u_20.Rig.PrimaryPart,
							["PlaybackSpeed"] = 2,
							["Volume"] = 0.1
						})
					end
				end)
				task.delay(1.65, function()
					-- upvalues: (copy) p_u_20
					p_u_20.Rig.Head.EyesFlare.Big.Enabled = true
					p_u_20.Rig.Head.EyesFlare.Flames.Enabled = true
					p_u_20.Rig.Head.EyesFlare.Shockwave.Enabled = true
					p_u_20.Rig.Head.EyesFlare["Small :D"].Enabled = true
					p_u_20.Rig.Head.EyesFlare.SmokeBLACK.Enabled = true
					p_u_20.Rig.Head.EyesFlare.SmokeRed.Enabled = true
				end)
				task.delay(1.8, function()
					-- upvalues: (copy) p_u_20
					p_u_20.Rig.Head.EyesFlare.Big.Enabled = false
					p_u_20.Rig.Head.EyesFlare.Flames.Enabled = false
					p_u_20.Rig.Head.EyesFlare.Shockwave.Enabled = false
					p_u_20.Rig.Head.EyesFlare["Small :D"].Enabled = false
					p_u_20.Rig.Head.EyesFlare.SmokeBLACK.Enabled = false
					p_u_20.Rig.Head.EyesFlare.SmokeRed.Enabled = false
					for v33 = 1, 6 do
						p_u_20.Rig.HumanoidRootPart["Chain" .. v33]["Chain" .. v33].Enabled = false
						p_u_20.Rig.HumanoidRootPart["Chain" .. v33]["Orb" .. v33].Enabled = false
					end
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_20.Animations.MassInfection:Play(0.175)
				v_u_3:CreateSpeedMultiplier(p_u_20.Player, 0.01, "MassInfection", 3, true)
			end
		end
	},
	["Entanglement"] = {
		["LayoutOrder"] = 3,
		["Icon"] = "rbxassetid://93874368032471",
		["KeybindType"] = "AltAbility2",
		["Callback"] = function(p_u_34)
			-- upvalues: (copy) v_u_2, (copy) v_u_13, (copy) v_u_4, (copy) v_u_3, (copy) v_u_5, (copy) v_u_6
			if game["Run Service"]:IsServer() then
				p_u_34.AbilitiesDisabled = true
				v_u_2:Play(p_u_34.Config.Sounds.EntanglementActivate, {
					["Parent"] = p_u_34.Rig.PrimaryPart,
					["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
					["Volume"] = 0.5
				})
				task.delay(0.75, function()
					-- upvalues: (ref) v_u_13, (copy) p_u_34, (ref) v_u_4, (ref) v_u_3, (ref) v_u_5, (ref) v_u_6
					v_u_13(p_u_34.Rig, false)
					local v35 = p_u_34.Config.SwordsTemplate:Clone()
					local v_u_36 = v35.PrimaryPart
					v35.Parent = workspace.Map.Ingame
					v35:SetPrimaryPartCFrame(p_u_34.Rig.PrimaryPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(-0.25, -0.25, 6))
					local v37 = v_u_36.CFrame * CFrame.new(0, 0, p_u_34.Config.EntanglementSpeed * p_u_34.Config.EntanglementLifetime)
					game.Debris:AddItem(v35, p_u_34.Config.EntanglementLifetime)
					game.TweenService:Create(v_u_36, TweenInfo.new(p_u_34.Config.EntanglementLifetime, Enum.EasingStyle.Linear), {
						["CFrame"] = v37
					}):Play()
					local v38 = v_u_4
					local v39 = p_u_34.Player
					local v41 = {
						["Size"] = Vector3.new(4.5, 1.75, 5),
						["CFrame"] = function()
							-- upvalues: (copy) v_u_36
							return v_u_36.CFrame
						end,
						["Damage"] = p_u_34.Config.EntanglementDamage,
						["Time"] = p_u_34.Config.EntanglementLifetime,
						["Knockback"] = 0.5,
						["HitMultiple"] = true,
						["PredictVelocity"] = false,
						["Connections"] = {
							["Hit"] = function(p40)
								-- upvalues: (ref) v_u_3, (ref) p_u_34, (ref) v_u_5, (ref) v_u_6
								v_u_3:RevealPlayerAuraTo(p_u_34.Player, p40, p_u_34.Config.EntanglementAuraDuration)
								p40:SetAttribute("Entangled", true)
								v_u_5:ApplyStatus(p40, "Helpless", {
									["Level"] = 1,
									["Duration"] = p_u_34.Config.EntanglementHelplessDuration
								})
								v_u_5:ApplyStatus(p40, "Slowness", {
									["Level"] = 10,
									["Duration"] = 30
								})
								v_u_6:FireClientConnection(game.Players:GetPlayerFromCharacter(p40), "Entangled", "REMOTE_EVENT")
							end
						}
					}
					v38:CreateHitbox(v39, v41)
				end)
				task.delay(2.25, function()
					-- upvalues: (copy) p_u_34, (ref) v_u_13
					p_u_34.AbilitiesDisabled = false
					v_u_13(p_u_34.Rig, true)
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_34.Animations.Entanglement:Play(0.175)
				v_u_3:CreateSpeedMultiplier(p_u_34.Player, 0.01, "Entanglement", 2, true)
			end
		end
	},
	["UnstableEye"] = {
		["LayoutOrder"] = 4,
		["Icon"] = "rbxassetid://93874368032471",
		["KeybindType"] = "AltAbility3",
		["Callback"] = function(p_u_42)
			-- upvalues: (copy) v_u_2, (copy) v_u_5, (copy) v_u_3
			if game["Run Service"]:IsServer() then
				p_u_42.AbilitiesDisabled = true
				v_u_2:Play(p_u_42.Config.Sounds.UnstableEyeActivate, {
					["Parent"] = p_u_42.Rig.PrimaryPart,
					["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
					["Volume"] = 0.6
				})
				v_u_2:Play(p_u_42.Config.Sounds.UnstableEyeMode, {
					["Parent"] = p_u_42.Rig.PrimaryPart,
					["PlaybackSpeed"] = 1.25,
					["Volume"] = 0.25
				})
				task.delay(0.9, function()
					-- upvalues: (ref) v_u_5, (copy) p_u_42
					v_u_5:ApplyStatus(p_u_42.Player, "Blindness", {
						["Duration"] = p_u_42.Config.UnstableEyeDebuffDuration,
						["Level"] = 3
					})
					v_u_5:ApplyStatus(p_u_42.Player, "Speed", {
						["Duration"] = p_u_42.Config.UnstableEyeBuffDuration,
						["Level"] = 1
					})
				end)
				task.delay(1.5, function()
					-- upvalues: (copy) p_u_42
					p_u_42.AbilitiesDisabled = false
				end)
				task.delay(0.9, function()
					-- upvalues: (copy) p_u_42
					p_u_42.Rig.Head.EyesFlare.Big.Enabled = true
					p_u_42.Rig.Head.EyesFlare.Flames.Enabled = true
					p_u_42.Rig.Head.EyesFlare.Shockwave.Enabled = true
					p_u_42.Rig.Head.EyesFlare["Small :D"].Enabled = true
					p_u_42.Rig.Head.EyesFlare.SmokeBLACK.Enabled = true
					p_u_42.Rig.Head.EyesFlare.SmokeRed.Enabled = true
				end)
				task.delay(1.1, function()
					-- upvalues: (copy) p_u_42
					p_u_42.Rig.Head.EyesFlare.Big.Enabled = false
					p_u_42.Rig.Head.EyesFlare.Flames.Enabled = false
					p_u_42.Rig.Head.EyesFlare.Shockwave.Enabled = false
					p_u_42.Rig.Head.EyesFlare["Small :D"].Enabled = false
					p_u_42.Rig.Head.EyesFlare.SmokeBLACK.Enabled = false
					p_u_42.Rig.Head.EyesFlare.SmokeRed.Enabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_42.Animations.UnstableEye:Play(0.175)
				v_u_3:CreateSpeedMultiplier(p_u_42.Player, 0.01, "UnstableEye", 1.75, true)
				task.delay(0.9, function()
					-- upvalues: (ref) v_u_3, (copy) p_u_42
					for _, v43 in pairs(workspace.Players.Survivors:GetChildren()) do
						v_u_3:RevealPlayerAura(v43, p_u_42.Config.UnstableEyeAuraDuration)
					end
				end)
			end
		end
	},
	["RejuvenateTheRotten"] = {
		["LayoutOrder"] = 5,
		["Icon"] = "rbxassetid://93874368032471",
		["KeybindType"] = "AltAbility4",
		["Charges"] = 0,
		["Callback"] = function(p_u_44)
			-- upvalues: (copy) v_u_2, (copy) v_u_3
			if game["Run Service"]:IsServer() then
				p_u_44.AbilitiesDisabled = true
				v_u_2:Play(p_u_44.Config.Sounds.RejuvenateTheRottenActivate, {
					["Parent"] = p_u_44.Rig.PrimaryPart,
					["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
					["Volume"] = 0.75
				})
				task.delay(1.35, function()
					-- upvalues: (copy) p_u_44, (ref) v_u_3, (ref) v_u_2
					local v_u_45 = p_u_44.Rig.PrimaryPart
					for _, v_u_46 in pairs(p_u_44.KilledLocations or {}) do
						task.spawn(function()
							-- upvalues: (ref) p_u_44, (ref) v_u_3, (copy) v_u_46, (copy) v_u_45, (ref) v_u_2
							local v_u_47 = p_u_44.Config.ZombieTemplate:Clone()
							v_u_47:SetAttribute("Team", "Killers")
							v_u_47.Name = "RotZombie"
							v_u_47.PrimaryPart.Anchored = true
							v_u_47.Humanoid.Health = p_u_44.Config.ZombieHealth
							v_u_47.Humanoid.EvaluateStateMachine = false
							v_u_47.Parent = workspace.Map.Ingame
							for _, v48 in pairs(v_u_47:GetDescendants()) do
								if v48:IsA("BasePart") then
									v48.Massless = true
								end
							end
							local v_u_49 = {}
							for v50, v51 in pairs(p_u_44.Config.ZombieAnimations) do
								v_u_49[v50] = v_u_3:LoadAnimationFromID(v_u_47, v51)
							end
							v_u_49.Summon:Play(0)
							v_u_49.Idle:Play(0)
							local v52 = CFrame.lookAt
							local v53 = v_u_46
							local v54 = v_u_45.Position.X
							local v55 = v_u_46.Y
							local v56 = v_u_45.Position.Z
							v_u_47:SetPrimaryPartCFrame(v52(v53, (Vector3.new(v54, v55, v56))))
							task.wait(2.5)
							local v_u_57 = ""
							v_u_47.Humanoid.Running:Connect(function(p58)
								-- upvalues: (copy) v_u_47, (ref) p_u_44, (ref) v_u_57, (copy) v_u_49
								if p58 > 0.01 then
									if v_u_47.Humanoid.WalkSpeed == p_u_44.Config.ZombieWalkSpeed and v_u_57 ~= "Walk" then
										v_u_49.Walk:Play()
										v_u_49.Run:Stop()
										return
									end
									if v_u_47.Humanoid.WalkSpeed == p_u_44.Config.ZombieSprintSpeed and v_u_57 ~= "Run" then
										v_u_49.Walk:Stop()
										v_u_49.Run:Play()
										return
									end
								else
									v_u_57 = ""
									v_u_49.Walk:Stop()
									v_u_49.Run:Stop()
								end
							end)
							v_u_47.PrimaryPart.Anchored = false
							v_u_47.Humanoid.EvaluateStateMachine = true
							task.spawn(function()
								-- upvalues: (copy) v_u_47, (ref) p_u_44, (copy) v_u_49, (ref) v_u_2, (ref) v_u_3
								local v59 = math.random(6, 12)
								local v60 = require(game.ReplicatedStorage.Modules.SimplePath).new(v_u_47, {
									["AgentRadius"] = 3,
									["AgentCanJump"] = false
								})
								local v61 = nil
								local v62 = 0
								while true do
									if not v_u_47.Parent or (not v_u_47.PrimaryPart or v_u_47.Humanoid.Health <= 0) then
										if v60 then
											v60:Destroy()
										end
										return
									end
									if not v61 or (not v61.PrimaryPart or (v61.Humanoid.Health <= 0 or v61:GetAttribute("Undetectable"))) then
										break
									end
									local v63 = (v61.PrimaryPart.Position - v_u_47.PrimaryPart.Position).Magnitude
									if v63 <= p_u_44.Config.ZombieAttackRange then
										v_u_49.Attack:Play()
										v_u_2:Play(p_u_44.Config.Sounds.Swing, {
											["Parent"] = v_u_47.PrimaryPart,
											["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
											["Volume"] = 0.25
										})
										v_u_3:ApplyDamage(v61, p_u_44.Config.ZombieAttackDamage)
										task.wait(p_u_44.Config.ZombieAttackCooldown)
									else
										if p_u_44.Config.ZombieLoseFocusRange <= v63 then
											v60:Stop()
											v61 = nil
										else
											v_u_47.Humanoid.WalkSpeed = p_u_44.Config.ZombieSprintSpeed
											v60:Run(v61.PrimaryPart.Position)
										end
										-- ERROR
										v61 = v_u_3:GetClosestPlayerFromPosition(v_u_47.PrimaryPart.Position, {
											["PlayerSelection"] = "Survivors",
											["MaxDistance"] = p_u_44.Config.ZombieTargetRange
										}) or v61
										if v59 <= v62 then
											v59 = math.random(6, 12)
											local v64 = v_u_47.Humanoid
											local v65 = v_u_47.PrimaryPart.Position
											local v66 = math.random(-80, 80)
											local v67 = math.random
											v64:MoveTo(v65 + Vector3.new(v66, 0, v67(-80, 80)))
											v62 = 0
										end
										v_u_47.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
										v_u_47.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
										v_u_47.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
										v62 = v62 + game["Run Service"].Heartbeat:Wait()
									end
								end
								v_u_47.Humanoid.WalkSpeed = p_u_44.Config.ZombieWalkSpeed
								v61 = nil
								-- ERROR
							end)
						end)
					end
				end)
				task.delay(4.25, function()
					-- upvalues: (copy) p_u_44
					p_u_44.AbilitiesDisabled = false
				end)
				task.delay(0.98, function()
					-- upvalues: (copy) p_u_44, (ref) v_u_2
					p_u_44.Rig.Head.EyesFlare.Big.Enabled = true
					p_u_44.Rig.Head.EyesFlare.Flames.Enabled = true
					p_u_44.Rig.Head.EyesFlare.Shockwave.Enabled = true
					p_u_44.Rig.Head.EyesFlare["Small :D"].Enabled = true
					p_u_44.Rig.Head.EyesFlare.SmokeBLACK.Enabled = true
					p_u_44.Rig.Head.EyesFlare.SmokeRed.Enabled = true
					p_u_44.Rig.Torso.Blood.Hi.Enabled = true
					p_u_44.Rig.Torso.Blood.Blood.Enabled = true
					for v68 = 1, 6 do
						p_u_44.Rig.HumanoidRootPart["Chain" .. v68]["Chain" .. v68].Enabled = true
						v_u_2:Play(p_u_44.Config.Sounds.Chains, {
							["Parent"] = p_u_44.Rig.PrimaryPart,
							["PlaybackSpeed"] = 1.5,
							["Volume"] = 0.1
						})
					end
				end)
				task.delay(1.35, function()
					-- upvalues: (copy) p_u_44
					p_u_44.Rig.Torso.Blood.Blood.Enabled = false
					p_u_44.Rig.Torso.Blood.Hi.Enabled = false
					p_u_44.Rig.Head.EyesFlare.Big.Enabled = false
					p_u_44.Rig.Head.EyesFlare.Flames.Enabled = false
					p_u_44.Rig.Head.EyesFlare.Shockwave.Enabled = false
					p_u_44.Rig.Head.EyesFlare["Small :D"].Enabled = false
					p_u_44.Rig.Head.EyesFlare.SmokeBLACK.Enabled = false
					p_u_44.Rig.Head.EyesFlare.SmokeRed.Enabled = false
				end)
				task.delay(1.98, function()
					-- upvalues: (copy) p_u_44
					p_u_44.Rig.Torso.Blood2.Hi2.Enabled = true
					p_u_44.Rig.HumanoidRootPart["Chain" .. 1]["Chain" .. 1].Enabled = false
					p_u_44.Rig.HumanoidRootPart["Chain" .. 2]["Chain" .. 2].Enabled = false
					p_u_44.Rig.HumanoidRootPart["Chain" .. 3]["Chain" .. 3].Enabled = false
					p_u_44.Rig.HumanoidRootPart["Chain" .. 4]["Chain" .. 4].Enabled = false
					p_u_44.Rig.HumanoidRootPart["Chain" .. 5]["Chain" .. 5].Enabled = false
					p_u_44.Rig.HumanoidRootPart["Chain" .. 6]["Chain" .. 6].Enabled = false
				end)
				task.delay(2.1, function()
					-- upvalues: (copy) p_u_44
					p_u_44.Rig.Torso.Blood2.Hi2.Enabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_44.Animations.RejuvenateTheRotten:Play(0.175)
				v_u_3:CreateSpeedMultiplier(p_u_44.Player, 0.01, "RejuvenateTheRotten", 3.75, true)
			end
		end
	}
}
v1.Abilities = v69
function v1.Created(_, p_u_70)
	-- upvalues: (copy) v_u_6, (copy) v_u_5
	if game["Run Service"]:IsServer() then
		v_u_6:SetConnection("Entangled", "REMOTE_EVENT", function(p71)
			-- upvalues: (ref) v_u_5, (copy) p_u_70
			if p71.Character and p71.Character:GetAttribute("Entangled") then
				p71.Character:SetAttribute("Entangled", false)
				v_u_5:RemoveStatus(p71, "Slowness")
				v_u_5:ApplyStatus(p71.Character, "Speed", {
					["Duration"] = p_u_70.Config.EntanglementSpeedBuff,
					["Level"] = 1,
					["Instant"] = true
				})
			end
		end)
		p_u_70.KilledLocations = {}
		local function v77(p72)
			-- upvalues: (copy) p_u_70
			local v73 = p72:FindFirstChild("Humanoid")
			local v_u_74 = p72.PrimaryPart
			if v73 and v_u_74 then
				v73.Died:Connect(function()
					-- upvalues: (ref) p_u_70, (copy) v_u_74
					p_u_70:IncrementCharges("RejuvenateTheRotten", 1, 1)
					local v75 = p_u_70.KilledLocations
					local v76 = v_u_74.Position
					table.insert(v75, v76)
				end)
			end
		end
		for _, v78 in pairs(workspace.Players.Survivors:GetChildren()) do
			local v79 = v78:FindFirstChild("Humanoid")
			local v_u_80 = v78.PrimaryPart
			if v79 and v_u_80 then
				v79.Died:Connect(function()
					-- upvalues: (copy) p_u_70, (copy) v_u_80
					p_u_70:IncrementCharges("RejuvenateTheRotten", 1, 1)
					local v81 = p_u_70.KilledLocations
					local v82 = v_u_80.Position
					table.insert(v81, v82)
				end)
			end
		end
		local v_u_83 = workspace.Players.Survivors.ChildAdded:Connect(v77)
		p_u_70.Rig.AncestryChanged:Connect(function(_, p84)
			-- upvalues: (ref) v_u_83
			if not p84 then
				v_u_83:Disconnect()
				v_u_83 = nil
			end
		end)
		if not p_u_70.Config.HighlightDisabled then
			local v85 = Instance.new("Highlight")
			v85.DepthMode = Enum.HighlightDepthMode.Occluded
			v85.Parent = p_u_70.Rig
			for v86, v87 in pairs(p_u_70.Config.HighlightProperties) do
				v85[v86] = v87
			end
		end
	elseif game["Run Service"]:IsClient() then
		v_u_6:SetConnection("Entangled", "REMOTE_EVENT", function()
			-- upvalues: (copy) p_u_70, (ref) v_u_6
			local v88 = p_u_70.Config.PopupsFolder
			for _, v89 in pairs(v88:GetChildren()) do
				local v_u_90 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("TemporaryUI")
				local v_u_91 = v89:Clone()
				v_u_91.Name = "1x1x1x1Popup"
				v_u_91.Position = UDim2.fromScale(0.5, 0.5) + UDim2.fromScale(math.random(-100, 100) / 300, math.random(-100, 100) / 500)
				v_u_91.Parent = v_u_90
				v_u_91.MouseButton1Click:Connect(function()
					-- upvalues: (copy) v_u_91, (copy) v_u_90, (ref) v_u_6
					v_u_91.Name = "aaaahhhh"
					v_u_91:Destroy()
					for _, v92 in pairs(v_u_90 and v_u_90:GetChildren() or {}) do
						if v92.Name == "1x1x1x1Popup" then
							return
						end
					end
					v_u_6:FireServerConnection("Entangled", "REMOTE_EVENT")
				end)
			end
		end)
	end
end
function v1.OnIntroduction(_, p93, p_u_94, p95)
	-- upvalues: (copy) v_u_3
	local v_u_96 = p93.Config.IntroHeadTemplate:Clone()
	v_u_96:SetPrimaryPartCFrame(p_u_94:WaitForChild("Right Arm").CFrame * CFrame.Angles(0, 0, 3.141592653589793) * CFrame.new(0, 0.9, 0.1))
	v_u_96.ArmWeld.Part0 = p_u_94:WaitForChild("Right Arm")
	v_u_96.Parent = workspace
	game.Debris:AddItem(v_u_96, 5)
	task.delay(0.92, function()
		-- upvalues: (copy) v_u_96
		local v97 = v_u_96:FindFirstChild("Root")
		if v97 then
			v97 = v97:FindFirstChild("Blood")
		end
		if v97 then
			v97:Emit(30)
		end
	end)
	task.delay(0.94, function()
		-- upvalues: (copy) p_u_94
		p_u_94.Head.EyesFlare.Big.Enabled = true
		p_u_94.Head.EyesFlare.Flames.Enabled = true
		p_u_94.Head.EyesFlare.Shockwave.Enabled = true
		p_u_94.Head.EyesFlare["Small :D"].Enabled = true
		p_u_94.Head.EyesFlare.SmokeBLACK.Enabled = true
		p_u_94.Head.EyesFlare.SmokeRed.Enabled = true
	end)
	task.delay(0.966, function()
		-- upvalues: (copy) v_u_96
		v_u_96.Head:Destroy()
		v_u_96.Hair:Destroy()
	end)
	task.delay(1.2, function()
		-- upvalues: (copy) p_u_94
		p_u_94.Head.EyesFlare.Big.Enabled = false
		p_u_94.Head.EyesFlare.Flames.Enabled = false
		p_u_94.Head.EyesFlare.Shockwave.Enabled = false
		p_u_94.Head.EyesFlare["Small :D"].Enabled = false
		p_u_94.Head.EyesFlare.SmokeBLACK.Enabled = false
		p_u_94.Head.EyesFlare.SmokeRed.Enabled = false
	end)
	v_u_3:CreateFOVMultiplier(game.Players.LocalPlayer, 0.6, "1x1x1x1IntroScene", p95)
	local v_u_98 = require(game.ReplicatedStorage.Modules.Schematics.Lighting)
	v_u_98:SetCustomLighting(p93.Config.IntroLighting)
	task.delay(p95, function()
		-- upvalues: (copy) v_u_98
		v_u_98:SetAsCurrentLighting()
	end)
end
function v1.OnExecution(_, p_u_99, p_u_100)
	-- upvalues: (copy) v_u_6
	local v_u_101 = p_u_100:FindFirstChild("Humanoid")
	local v_u_102 = p_u_100:FindFirstChild("Head")
	task.delay(2, function()
		-- upvalues: (copy) p_u_99, (copy) v_u_101, (copy) p_u_100, (copy) v_u_102, (ref) v_u_6
		local v_u_103 = p_u_99.Rig["Left Arm"]:FindFirstChild("Blood", true)
		if v_u_103 then
			v_u_103.Enabled = true
			task.delay(0.2, function()
				-- upvalues: (copy) v_u_103
				v_u_103.Enabled = false
			end)
		end
		if v_u_101 then
			v_u_101.BreakJointsOnDeath = false
			v_u_101.Health = 0
			for _, v104 in ipairs(p_u_100 and p_u_100:GetChildren() or {}) do
				if v104:IsA("Accessory") then
					v104:Destroy()
				end
			end
			if v_u_102 then
				v_u_102:Destroy()
			end
			local v105 = p_u_99.Rig.PrimaryPart.CFrame.LookVector.Unit * 35
			v_u_6:FireAllClientConnection("Ragdoll", "REMOTE_EVENT", p_u_100, 0, (("%*|%*|%*"):format(v105.X, v105.Y, v105.Z)))
		end
	end)
end
return v1