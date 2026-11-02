--My name is 1eggs. I made the breakfast. It was difficult, to put the meal together. But unfortunately, something went so wrong. And now I can't do anything but sing this stupid song! My name is 1eggs! 1eggs! 1eggs! 1eggs! 1eggs!
require(game.ReplicatedStorage.GlobalTypes)
local v_u_1 = game:GetService("Debris")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local v5 = {}
local v_u_6 = require(v_u_4.Modules.Sounds)
local v_u_7 = require(v_u_4.Modules.Util)
local v_u_8 = require(v_u_4.Modules.Hitboxes)
local v_u_9 = require(v_u_4.Modules.Projectiles)
local v_u_10 = require(v_u_4.Modules.Statuses)
local v_u_11 = require(v_u_4.Modules.Network)
local v_u_12 = require(v_u_4.Modules.AchievementUtil)
local v_u_13 = require(v_u_4.Modules.Schematics.Lighting)
local v_u_14 = {
	"Big",
	"Flames",
	"Shockwave",
	"Small :D",
	"SmokeBLACK",
	"SmokeRed"
}
local function v_u_21(p15, p16)
	if p15 and (p15.Parent and p15:FindFirstChild("ExtraModels")) then
		for v17, v18 in pairs({ p15.ExtraModels.HaxxedSwordLeft, p15.ExtraModels.HaxxedSwordRight }) do
			local v19 = v17 == 1 and "L" or "R"
			v18.Parts[("HaxxedBlade%*2"):format(v19)].Transparency = p16 and 0 or 1
			for _, v20 in pairs(v18.Parts[("HaxxedBlade%*"):format(v19)]:GetChildren()) do
				if v20:IsA("Beam") or v20:IsA("ParticleEmitter") then
					v20.Enabled = p16
				end
			end
		end
	end
end
local function v_u_26(p22, p23)
	-- upvalues: (copy) v_u_10
	if p22.Rig then
		local v24 = p22.Config.MassInfectionShockwaveDamage
		local v25 = p23:FindFirstChild("Humanoid") ~= nil
		if v_u_10:PlayerHasStatus(p23, "Glitched") and v25 then
			v24 = v24 + p22.Config.MassInfectionShockwaveBonusDamage
		end
		return v24
	end
end
local function v_u_32(p_u_27, p28, p_u_29, ...)
	local v30, v31 = pcall(function(...)
		-- upvalues: (copy) p_u_29, (copy) p_u_27
		if p_u_29.Behavior[p_u_27] then
			return p_u_29.Behavior[p_u_27](p_u_29, ...)
		end
	end, ...)
	if not v30 then
		warn((("[%*]: Failed to call .%*() due to: %*"):format(p28, p_u_27, v31)))
	end
	return v31
end
local function v_u_35(p33, p34)
	-- upvalues: (copy) v_u_10
	if p34.Name == "1x1x1x1Zombie" then
		v_u_10:PlayerHasStatus(p33.Player, "Speed")
		v_u_10:ApplyStatus(p33.Rig, "Speed", {
			["Stackable"] = true,
			["MaxLevel"] = 1,
			["Level"] = p33.Config.ZombieKillSpeedLevel,
			["Duration"] = p33.Config.ZombieKillSpeedDuration
		})
		p33:PlayVoiceline("MinionSpeed", {
			["Priority"] = 3
		})
		return true
	end
end
local v179 = {
	["Slash"] = {
		["LayoutOrder"] = 1,
		["Icon"] = "rbxassetid://120590195585579",
		["KeybindType"] = "MainAbility",
		["Callback"] = function(p_u_36)
			-- upvalues: (copy) v_u_6, (copy) v_u_8, (copy) v_u_35, (copy) v_u_7, (copy) v_u_10
			if game["Run Service"]:IsServer() then
				p_u_36.AbilitiesDisabled = true
				v_u_6:Play(p_u_36.Config.Sounds.Swing, {
					["Parent"] = p_u_36.Rig.PrimaryPart,
					["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
					["Volume"] = 0.25
				})
				task.delay(p_u_36.Config.SlashWindup, function()
					-- upvalues: (ref) v_u_8, (copy) p_u_36, (ref) v_u_35, (ref) v_u_7, (ref) v_u_10, (ref) v_u_6
					local v37 = v_u_8
					local v38 = p_u_36.Player
					local v43 = {
						["Size"] = Vector3.new(4.5, 6, 7.5),
						["CFrameOffset"] = CFrame.new(0, 0, -1.75),
						["Damage"] = function(p39)
							-- upvalues: (ref) p_u_36
							local v40 = p39.Name == "1x1x1x1Zombie" and p39:FindFirstChild("Humanoid")
							if v40 then
								return v40.MaxHealth
							else
								return p_u_36.Config.SlashDamage
							end
						end,
						["Time"] = p_u_36.Config.SlashLinger,
						["Knockback"] = 2,
						["HitMultiple"] = false,
						["ExecuteOnKill"] = true,
						["Connections"] = {
							["Hit"] = function(p41, p42)
								-- upvalues: (ref) v_u_35, (ref) p_u_36, (ref) v_u_7, (ref) v_u_10, (ref) v_u_6
								if p41.Name == "1x1x1x1Zombie" then
									v_u_35(p_u_36, p41)
								else
									v_u_35(p_u_36, p41)
									v_u_7:CreateSpeedMultiplier(p41, 1.5, "HitSpeedBonus", 1.25)
									v_u_10:ApplyStatus(p41, "Poisoned", {
										["Stackable"] = true,
										["Level"] = p_u_36.Config.SlashPoisonLevel,
										["Duration"] = p_u_36.Config.SlashPoisonDuration
									})
									v_u_10:ApplyStatus(p41, "Glitched", {
										["Stackable"] = true,
										["Level"] = p_u_36.Config.SlashGlitchLevel,
										["Duration"] = p_u_36.Config.SlashGlitchDuration
									})
									if p42 then
										v_u_6:Play(p_u_36.Config.Sounds.Hit, {
											["Parent"] = p_u_36.Rig.PrimaryPart,
											["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
											["Volume"] = 0.25
										})
									end
								end
							end
						}
					}
					v37:CreateHitbox(v38, v43)
				end)
				task.delay(1, function()
					-- upvalues: (copy) p_u_36
					p_u_36.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_36.Animations.Slash:Play(0.175)
			end
		end
	},
	["MassInfection"] = {
		["LayoutOrder"] = 2,
		["Icon"] = "rbxassetid://112065267803856",
		["KeybindType"] = "AltAbility1",
		["Callback"] = function(p_u_44)
			-- upvalues: (copy) v_u_6, (copy) v_u_7, (copy) v_u_8, (copy) v_u_35, (copy) v_u_10, (copy) v_u_4, (copy) v_u_26, (copy) v_u_9, (copy) v_u_14, (copy) v_u_3, (copy) v_u_1, (copy) v_u_2
			if game["Run Service"]:IsServer() then
				p_u_44.AbilitiesDisabled = true
				v_u_6:Play(p_u_44.Config.Sounds.MassInfectionActivate, {
					["Parent"] = p_u_44.Rig.PrimaryPart,
					["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
					["Volume"] = 0.75,
					["RollOffMaxDistance"] = 50
				})
				local v45 = p_u_44.Rig.HumanoidRootPart:FindFirstChild("MassInfection")
				if v45 then
					v_u_7:EmitParticlesFromAttachment(v45)
				end
				task.delay(1.6, function()
					-- upvalues: (ref) v_u_8, (copy) p_u_44, (ref) v_u_35, (ref) v_u_7, (ref) v_u_6, (ref) v_u_10, (ref) v_u_4
					local v_u_46 = {}
					local v47 = v_u_8
					local v48 = p_u_44.Player
					local v53 = {
						["Size"] = Vector3.new(9.5, 4, 10),
						["CFrame"] = p_u_44.Rig:GetPivot(),
						["CFrameOffset"] = CFrame.new(0, 0, -2),
						["Damage"] = function(p49)
							-- upvalues: (ref) p_u_44
							return p49.Name == "1x1x1x1Zombie" and 0 or p_u_44.Config.MassInfectionSlashDamage
						end,
						["Time"] = 0.125,
						["Knockback"] = 5,
						["HitMultiple"] = true,
						["Connections"] = {
							["Hit"] = function(p_u_50, _)
								-- upvalues: (ref) v_u_35, (ref) p_u_44, (ref) v_u_7, (ref) v_u_6, (ref) v_u_10, (copy) v_u_46, (ref) v_u_4
								if p_u_50.Name ~= "1x1x1x1Zombie" then
									v_u_35(p_u_44, p_u_50)
									v_u_7:CreateSpeedMultiplier(p_u_50, 1.5, "HitSpeedBonus", 2.5)
									v_u_6:Play(p_u_44.Config.Sounds.Hit, {
										["Parent"] = p_u_50.PrimaryPart,
										["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
										["Volume"] = 0.3
									})
									if p_u_44.Config.MassInfectionShockwaveEffects then
										for _, v51 in p_u_44.Config.MassInfectionShockwaveEffects do
											v_u_10:ApplyStatus(p_u_50, table.unpack(v51))
										end
									end
									v_u_46[p_u_50] = true
									task.delay(1, function()
										-- upvalues: (ref) v_u_46, (copy) p_u_50
										v_u_46[p_u_50] = nil
									end)
									local v52 = p_u_50.Parent
									if tostring(v52) == "Survivors" then
										require(v_u_4.Modules.Actors):IncrementActorStats(p_u_44.Player, {
											["Action"] = "Landed Mass Infection up close",
											["RewardType"] = "DifficultKillerAction"
										})
									end
								end
							end
						}
					}
					v47:CreateHitbox(v48, v53)
					p_u_44._massInfectionCloseHits = v_u_46
				end)
				task.delay(1.7, function()
					-- upvalues: (copy) p_u_44, (ref) v_u_6, (ref) v_u_7, (ref) v_u_26, (ref) v_u_35, (ref) v_u_10, (ref) v_u_4, (ref) v_u_9
					if not p_u_44.Rig:GetAttribute("Stunned") then
						local v54 = p_u_44.Config.ShockwaveTemplate:Clone()
						v_u_6:Play(p_u_44.Config.Sounds.MassInfectionProjectile, {
							["Parent"] = v54.PrimaryPart,
							["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
							["Volume"] = 0.3,
							["Looped"] = true
						})
						local v55 = p_u_44.Rig.HumanoidRootPart:FindFirstChild("MassInfection1")
						if v55 then
							v_u_7:EmitParticlesFromAttachment(v55)
						end
						local v61 = {
							["Size"] = Vector3.new(8.8, 5.5, 6.6),
							["Damage"] = function(p56)
								-- upvalues: (ref) v_u_26, (ref) p_u_44
								return p56.Name == "1x1x1x1Zombie" and 0 or v_u_26(p_u_44, p56)
							end,
							["Time"] = p_u_44.Config.MassInfectionShockwaveLifetime,
							["Knockback"] = 0.5,
							["HitMultiple"] = true,
							["PredictVelocity"] = false,
							["Connections"] = {
								["Hit"] = function(p57)
									-- upvalues: (ref) v_u_35, (ref) p_u_44, (ref) v_u_7, (ref) v_u_10, (ref) v_u_6, (ref) v_u_4
									if p57.Name ~= "1x1x1x1Zombie" then
										v_u_35(p_u_44, p57)
										v_u_7:RevealPlayerAuraTo(p_u_44.Player, p57, p_u_44.Config.MassInfectionShockwaveAuraDuration)
										local v58 = p_u_44._massInfectionCloseHits
										if v58 then
											v58 = p_u_44._massInfectionCloseHits[p57]
										end
										if not v58 and p_u_44.Config.MassInfectionSlashEffects then
											for _, v59 in p_u_44.Config.MassInfectionSlashEffects do
												v_u_10:ApplyStatus(p57, table.unpack(v59))
											end
										end
										v_u_6:Play(p_u_44.Config.Sounds.EntanglementHit, {
											["Parent"] = p57.PrimaryPart,
											["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
											["Volume"] = 0.25
										})
										local v60 = p57.Parent
										if tostring(v60) == "Survivors" then
											require(v_u_4.Modules.Actors):IncrementActorStats(p_u_44.Player, {
												["Action"] = "Landed Mass Infection hit",
												["RewardType"] = "EasyKillerAction"
											})
										end
									end
								end
							}
						}
						local v62 = {
							["Owner"] = p_u_44.Player,
							["HitboxConfig"] = v61,
							["Lifetime"] = p_u_44.Config.MassInfectionShockwaveLifetime,
							["InitialCFrame"] = p_u_44:GetPivot() * CFrame.Angles(0, 0, 0) * CFrame.new(-0.25, -0.25, -6),
							["InitialVelocity"] = p_u_44:GetPivot().LookVector * p_u_44.Config.MassInfectionShockwaveSpeed,
							["Model"] = v54
						}
						v_u_9.new(v62):Launch()
					end
				end)
				task.delay(2.75, function()
					-- upvalues: (copy) p_u_44
					p_u_44.AbilitiesDisabled = false
				end)
				task.delay(0.2, function()
					-- upvalues: (copy) p_u_44, (ref) v_u_6
					for v63 = 1, 6 do
						p_u_44.Rig.HumanoidRootPart["Chain" .. v63]["Chain" .. v63].Enabled = true
						p_u_44.Rig.HumanoidRootPart["Chain" .. v63]["Orb" .. v63].Enabled = true
						v_u_6:Play(p_u_44.Config.Sounds.Chains, {
							["Parent"] = p_u_44.Rig.PrimaryPart,
							["PlaybackSpeed"] = 1,
							["Volume"] = 0.1,
							["RollOffMaxDistance"] = 400
						})
					end
				end)
				task.delay(1.65, function()
					-- upvalues: (ref) v_u_14, (copy) p_u_44
					for _, v64 in v_u_14 do
						local v65 = p_u_44.Rig.Head.EyesFlare:FindFirstChild(v64)
						if v65 then
							v65.Enabled = true
						end
					end
				end)
				task.delay(1.8, function()
					-- upvalues: (ref) v_u_14, (copy) p_u_44
					for _, v66 in v_u_14 do
						local v67 = p_u_44.Rig.Head.EyesFlare:FindFirstChild(v66)
						if v67 then
							v67.Enabled = false
						end
					end
					for v68 = 1, 6 do
						p_u_44.Rig.HumanoidRootPart["Chain" .. v68]["Chain" .. v68].Enabled = false
						p_u_44.Rig.HumanoidRootPart["Chain" .. v68]["Orb" .. v68].Enabled = false
					end
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_44.Animations.MassInfection:Play(0.175, 0.9, nil)
				p_u_44.Player.Character:SetAttribute("AbilityStaminaOverride", true)
				local v_u_69 = p_u_44.Config.MassInfectionShockwaveVignette
				local v70
				if v_u_69 then
					v70 = v_u_69:Clone()
				else
					v70 = v_u_69
				end
				local v_u_71 = v70:FindFirstChildOfClass("ImageLabel")
				if v_u_69 then
					v_u_71.ImageTransparency = 1
					v_u_3:Create(v_u_71, TweenInfo.new(1.42, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
						["ImageTransparency"] = 0.81
					}):Play()
					v_u_1:AddItem(v70, 2.4)
					v70.Parent = p_u_44.Player.PlayerGui
				end
				local v_u_72 = require(v_u_4.Systems.Character.Game.Sprinting)
				local v_u_73 = v_u_7:CreateSpeedMultiplier(p_u_44.Player, 1, "MassInfection", 2.4, true)
				game.TweenService:Create(v_u_73, TweenInfo.new(0.35), {
					["Value"] = 0.025
				}):Play()
				task.spawn(function()
					-- upvalues: (copy) p_u_44, (copy) v_u_73, (ref) v_u_2, (copy) v_u_72
					local v74 = p_u_44.Config.StaminaGain * 1
					task.wait(0.2)
					while v_u_73 and v_u_73.Parent do
						if p_u_44.Player.Character and p_u_44.Player.Character:GetAttribute("StaminaPenaltyActive") then
							v_u_2.Heartbeat:Wait()
						else
							local v75 = v_u_72.Stamina + v74 * v_u_2.Heartbeat:Wait()
							local v76 = v_u_72
							local v77 = v_u_72.MinStamina
							local v78 = v_u_72.StaminaCap or v_u_72.MaxStamina
							v76.Stamina = math.clamp(v75, v77, v78)
							v_u_72.__staminaChangedEvent:Fire(v_u_72.Stamina)
						end
					end
					if p_u_44.Player.Character then
						p_u_44.Player.Character:SetAttribute("AbilityStaminaOverride", nil)
					end
				end)
				local v_u_79 = v_u_7:CreateFOVMultiplier(p_u_44.Player, 1, "MassInfection")
				v_u_1:AddItem(v_u_79, 2.4)
				v_u_3:Create(v_u_79, TweenInfo.new(1.7, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0), {
					["Value"] = 0.75
				}):Play()
				task.delay(1.7, function()
					-- upvalues: (ref) v_u_3, (copy) v_u_79, (copy) v_u_69, (copy) v_u_71, (copy) v_u_73, (ref) v_u_7, (copy) p_u_44, (ref) v_u_1
					v_u_3:Create(v_u_79, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0), {
						["Value"] = 1
					}):Play()
					if v_u_69 then
						v_u_3:Create(v_u_71, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							["ImageTransparency"] = 1
						}):Play()
					end
					v_u_73:Destroy()
					v_u_1:AddItem(v_u_7:CreateSpeedMultiplier(p_u_44.Player, 1.25, "MassInfectionBoost", 1, true), 1)
				end)
			end
		end
	},
	["Entanglement"] = {
		["LayoutOrder"] = 3,
		["Icon"] = "rbxassetid://119069138923680",
		["KeybindType"] = "AltAbility2",
		["Callback"] = function(p_u_80)
			-- upvalues: (copy) v_u_6, (copy) v_u_32, (copy) v_u_21, (copy) v_u_35, (copy) v_u_10, (copy) v_u_1, (copy) v_u_7, (copy) v_u_11, (copy) v_u_4, (copy) v_u_9, (copy) v_u_2
			if game["Run Service"]:IsServer() then
				p_u_80.AbilitiesDisabled = true
				v_u_6:Play(p_u_80.Config.Sounds.EntanglementActivate, {
					["Parent"] = p_u_80.Rig.PrimaryPart,
					["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
					["Volume"] = 0.5
				})
				v_u_32("EntangleStart", ("%*/EntangleStart"):format(script.Parent), p_u_80)
				task.delay(0.75, function()
					-- upvalues: (ref) v_u_21, (copy) p_u_80, (ref) v_u_35, (ref) v_u_6, (ref) v_u_10, (ref) v_u_1, (ref) v_u_7, (ref) v_u_11, (ref) v_u_4, (ref) v_u_9
					v_u_21(p_u_80.Rig, false)
					local function v100(p_u_81)
						-- upvalues: (ref) v_u_35, (ref) p_u_80, (ref) v_u_6, (ref) v_u_10, (ref) v_u_1, (ref) v_u_7, (ref) v_u_11, (ref) v_u_4
						if p_u_81.Name == "1x1x1x1Zombie" then
							local v82 = p_u_81:FindFirstChild("Humanoid")
							if v82 then
								v82.Health = 0
							end
							v_u_35(p_u_80, p_u_81)
							return
						else
							v_u_35(p_u_80, p_u_81)
							v_u_6:Play(p_u_80.Config.Sounds.Hit, {
								["Parent"] = p_u_81.PrimaryPart,
								["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
								["Volume"] = 0.25
							})
							if p_u_81 and (p_u_81:IsA("Model") and p_u_81:IsDescendantOf(workspace.Players.Survivors)) then
								local v83 = p_u_81:FindFirstChild("Humanoid")
								if v83 and (v83.Health > 0 and p_u_81.PrimaryPart) then
									local v84 = p_u_81:GetPivot()
									local v85 = p_u_80.Player.Character:GetPivot()
									local v86 = (v84.Position - v85.Position).Magnitude
									local v87 = p_u_80.Config.EntangelmentInFrontOffset or 2.5
									local v88 = p_u_80.Config.EntanglementMaxPullDistance or 10
									local v89 = p_u_80.Config.EntanglementPullFactor or 50
									local v90 = v85.Position + v85.LookVector * v87
									local v91
									if v86 <= v88 then
										v91 = v90
									else
										local v92 = (v85.Position - v84.Position).Unit
										v91 = v84.Position + v92 * v88
									end
									if (v85.Position - v84.Position).Magnitude >= (v91 - v84.Position).Magnitude then
										v90 = v91
									end
									local v93 = (v90 - v84.Position).Unit
									local v94 = (v90 - v84.Position).Magnitude / 10
									local v95 = v89 * math.clamp(v94, 0.5, 2)
									if v_u_10:PlayerHasStatus(p_u_81, "Glitched") then
										v95 = v95 * 1.3
									end
									local v96 = Instance.new("Attachment")
									v96.Parent = p_u_81.PrimaryPart
									local v97 = Instance.new("LinearVelocity")
									v97.Parent = p_u_81.PrimaryPart
									v97.Attachment0 = v96
									v97.MaxForce = 40000
									v97.VectorVelocity = v93 * v95
									v97.RelativeTo = Enum.ActuatorRelativeTo.World
									v_u_1:AddItem(v97, 0.35)
									v_u_1:AddItem(v96, 0.35)
									task.delay(0.35, function()
										-- upvalues: (copy) p_u_81
										if p_u_81.PrimaryPart then
											p_u_81.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
										end
									end)
								end
								v_u_7:RevealPlayerAuraTo(p_u_80.Player, p_u_81, p_u_80.Config.EntanglementAuraDuration)
								for _, v98 in p_u_80.Config.EntanglementEffects do
									v_u_10:ApplyStatus(p_u_81, table.unpack(v98))
								end
								p_u_81:SetAttribute("Entangled", true)
								v_u_10:ApplyStatus(p_u_81, "Helpless", {
									["Level"] = 1,
									["Duration"] = p_u_80.Config.EntanglementHelplessDuration
								})
								v_u_10:ApplyStatus(p_u_81, "Slowness", {
									["Level"] = 10,
									["Duration"] = 1
								})
								v_u_11:FireClientConnection(game.Players:GetPlayerFromCharacter(p_u_81), "Entangled", "REMOTE_EVENT")
								local v99 = p_u_81.Parent
								if tostring(v99) == "Survivors" then
									require(v_u_4.Modules.Actors):IncrementActorStats(p_u_80.Player, {
										["Action"] = "Landed Entanglement hit",
										["RewardType"] = "RegularKillerAction"
									})
								end
							end
						end
					end
					local v101 = {
						["Size"] = Vector3.new(4.5, 1.75, 5),
						["Damage"] = p_u_80.Config.EntanglementDamage,
						["Time"] = p_u_80.Config.EntanglementLifetime,
						["Knockback"] = 0.5,
						["HitMultiple"] = true,
						["PredictVelocity"] = false,
						["Connections"] = {
							["Hit"] = v100
						}
					}
					local v102 = p_u_80.Config.SwordsTemplate:Clone()
					v_u_6:Play(p_u_80.Config.Sounds.EntanglementProjectile, {
						["Parent"] = v102.PrimaryPart,
						["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
						["Volume"] = 0.25,
						["Looped"] = true,
						["RollOffMaxDistance"] = 40
					})
					local v103 = {
						["Owner"] = p_u_80.Player,
						["HitboxConfig"] = v101,
						["Lifetime"] = p_u_80.Config.EntanglementLifetime,
						["InitialCFrame"] = p_u_80:GetPivot() * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(-0.25, -0.25, 6),
						["InitialVelocity"] = p_u_80:GetPivot().LookVector * p_u_80.Config.EntanglementSpeed,
						["Model"] = v102
					}
					v_u_9.new(v103):Launch()
				end)
				task.delay(1.5, function()
					-- upvalues: (copy) p_u_80, (ref) v_u_21
					p_u_80.AbilitiesDisabled = false
					v_u_21(p_u_80.Rig, true)
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_80.Animations.Entanglement:Play(0.175, 0.9, nil)
				p_u_80.Player.Character:SetAttribute("AbilityStaminaOverride", true)
				local v_u_104 = require(v_u_4.Systems.Character.Game.Sprinting)
				local v_u_105 = v_u_7:CreateSpeedMultiplier(p_u_80.Player, 1, "Entanglement", 1.3, true)
				game.TweenService:Create(v_u_105, TweenInfo.new(0.45), {
					["Value"] = 0.1
				}):Play()
				task.spawn(function()
					-- upvalues: (copy) p_u_80, (copy) v_u_105, (ref) v_u_2, (copy) v_u_104
					local v106 = p_u_80.Config.StaminaGain * 1
					task.wait(0.2)
					while v_u_105 and v_u_105.Parent do
						if p_u_80.Player.Character and p_u_80.Player.Character:GetAttribute("StaminaPenaltyActive") then
							v_u_2.Heartbeat:Wait()
						else
							local v107 = v_u_104.Stamina + v106 * v_u_2.Heartbeat:Wait()
							local v108 = v_u_104
							local v109 = v_u_104.MinStamina
							local v110 = v_u_104.StaminaCap or v_u_104.MaxStamina
							v108.Stamina = math.clamp(v107, v109, v110)
							v_u_104.__staminaChangedEvent:Fire(v_u_104.Stamina)
						end
					end
					if p_u_80.Player.Character then
						p_u_80.Player.Character:SetAttribute("AbilityStaminaOverride", nil)
					end
				end)
			end
		end
	},
	["UnstableEye"] = {
		["LayoutOrder"] = 4,
		["Icon"] = "rbxassetid://135373963092918",
		["KeybindType"] = "AltAbility3",
		["Callback"] = function(p_u_111)
			-- upvalues: (copy) v_u_6, (copy) v_u_7, (copy) v_u_10, (copy) v_u_14, (copy) v_u_4, (copy) v_u_2, (copy) v_u_1, (copy) v_u_3
			if game["Run Service"]:IsServer() then
				p_u_111.AbilitiesDisabled = true
				v_u_6:Play(p_u_111.Config.Sounds.UnstableEyeActivate, {
					["Parent"] = p_u_111.Rig.PrimaryPart,
					["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
					["Volume"] = 0.6,
					["RollOffMaxDistance"] = 400
				})
				v_u_6:Play(p_u_111.Config.Sounds.UnstableEyeMode, {
					["Parent"] = p_u_111.Rig.PrimaryPart,
					["PlaybackSpeed"] = 1.25,
					["Volume"] = 0.25
				})
				task.delay(0.9, function()
					-- upvalues: (copy) p_u_111, (ref) v_u_7, (ref) v_u_10
					local v112 = p_u_111.Rig.HumanoidRootPart:FindFirstChild("Unstable")
					if v112 then
						v_u_7:EmitParticlesFromAttachment(v112)
					end
					for _, v113 in p_u_111.Config.UnstableEyeEffects do
						v_u_10:ApplyStatus(p_u_111.Player, table.unpack(v113))
					end
				end)
				task.delay(1.5, function()
					-- upvalues: (copy) p_u_111
					p_u_111.AbilitiesDisabled = false
				end)
				task.delay(0.9, function()
					-- upvalues: (ref) v_u_14, (copy) p_u_111
					for _, v114 in v_u_14 do
						local v115 = p_u_111.Rig.Head.EyesFlare:FindFirstChild(v114)
						if v115 then
							v115.Enabled = true
						end
					end
				end)
				task.delay(1.1, function()
					-- upvalues: (ref) v_u_14, (copy) p_u_111
					for _, v116 in v_u_14 do
						local v117 = p_u_111.Rig.Head.EyesFlare:FindFirstChild(v116)
						if v117 then
							v117.Enabled = false
						end
					end
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_111.Animations.UnstableEye:Play(0.175)
				p_u_111.Player.Character:SetAttribute("AbilityStaminaOverride", true)
				local v_u_118 = require(v_u_4.Systems.Character.Game.Sprinting)
				if p_u_111.__currentMultiplier then
					p_u_111.__currentMultiplier:Destroy()
					p_u_111.__currentMultiplier = nil
				end
				local v_u_119 = v_u_7:CreateSpeedMultiplier(p_u_111.Player, 1, "UnstableEye", 1, true)
				p_u_111.__currentMultiplier = v_u_119
				local v_u_120 = nil
				v_u_120 = v_u_2.Heartbeat:Connect(function()
					-- upvalues: (copy) v_u_119, (ref) v_u_120, (copy) p_u_111, (copy) v_u_118
					if v_u_119 and v_u_119.Parent then
						if v_u_118.IsSprinting then
							v_u_119.Value = p_u_111.Config.Speed / p_u_111.Config.SprintSpeed
						else
							v_u_119.Value = 1
						end
					else
						if v_u_120 then
							v_u_120:Disconnect()
							v_u_120 = nil
						end
						if p_u_111.Player.Character then
							p_u_111.Player.Character:SetAttribute("AbilityStaminaOverride", nil)
						end
						return
					end
				end)
				task.delay(1, function()
					-- upvalues: (ref) v_u_120, (copy) p_u_111
					if v_u_120 then
						v_u_120:Disconnect()
						v_u_120 = nil
					end
					if p_u_111.Player.Character then
						p_u_111.Player.Character:SetAttribute("AbilityStaminaOverride", nil)
					end
				end)
				task.spawn(function()
					-- upvalues: (copy) p_u_111, (copy) v_u_119, (ref) v_u_2, (copy) v_u_118
					local v121 = p_u_111.Config.StaminaGain * 1.05
					task.wait(0.2)
					while v_u_119 and v_u_119.Parent do
						if p_u_111.Player.Character and p_u_111.Player.Character:GetAttribute("StaminaPenaltyActive") then
							v_u_2.Heartbeat:Wait()
						else
							local v122 = v_u_118.Stamina + v121 * v_u_2.Heartbeat:Wait()
							local v123 = v_u_118
							local v124 = v_u_118.MinStamina
							local v125 = v_u_118.StaminaCap or v_u_118.MaxStamina
							v123.Stamina = math.clamp(v122, v124, v125)
							v_u_118.__staminaChangedEvent:Fire(v_u_118.Stamina)
						end
					end
					if p_u_111.Player.Character then
						p_u_111.Player.Character:SetAttribute("AbilityStaminaOverride", nil)
					end
				end)
				local v126 = p_u_111.Config.UnstableEyeVignette
				local v127
				if v126 then
					v127 = v126:Clone()
				else
					v127 = v126
				end
				local v_u_128
				if v127 then
					v_u_128 = v127:FindFirstChildOfClass("ImageLabel")
				else
					v_u_128 = v127
				end
				if v126 and (v127 and v_u_128) then
					v_u_128.ImageTransparency = 1
					v_u_1:AddItem(v127, 3)
					v127.Parent = p_u_111.Player.PlayerGui
				end
				local v_u_129 = v_u_7:CreateFOVMultiplier(p_u_111.Player, 1, "UnstableEye")
				v_u_1:AddItem(v_u_129, 1.5)
				v_u_3:Create(v_u_129, TweenInfo.new(0.85, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					["Value"] = 0.9
				}):Play()
				task.delay(0.85, function()
					-- upvalues: (copy) v_u_129, (copy) v_u_128, (ref) v_u_3
					v_u_129.Value = 0.86
					if v_u_128 then
						v_u_128.ImageTransparency = 0.3
						v_u_3:Create(v_u_128, TweenInfo.new(3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
							["ImageTransparency"] = 1
						}):Play()
					end
					v_u_3:Create(v_u_129, TweenInfo.new(3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
						["Value"] = 1
					}):Play()
				end)
				task.delay(0.9, function()
					-- upvalues: (ref) v_u_7, (copy) p_u_111
					for _, v130 in pairs(workspace.Players.Survivors:GetChildren()) do
						local v131 = v130:FindFirstChild("Humanoid")
						if v131 then
							for _, v132 in pairs(v130:GetDescendants()) do
								if v132:IsA("Highlight") and v132.Name == "PlayerAura" then
									v132:Destroy()
								end
							end
							local v133 = v131.Health / v131.MaxHealth
							local v134 = Color3.fromHSV(v133 / 3, 0.6, 1)
							v_u_7:RevealPlayerAura(v130, p_u_111.Config.UnstableEyeAuraDuration, v134)
						else
							for _, v135 in pairs(v130:GetDescendants()) do
								if v135:IsA("Highlight") and v135.Name == "PlayerAura" then
									v135:Destroy()
								end
							end
							v_u_7:RevealPlayerAura(v130, p_u_111.Config.UnstableEyeAuraDuration)
						end
					end
				end)
			end
		end
	},
	["RejuvenateTheRotten"] = {
		["LayoutOrder"] = 5,
		["Icon"] = "rbxassetid://102037518703784",
		["KeybindType"] = "AltAbility4",
		["Charges"] = 0,
		["Callback"] = function(p_u_136)
			-- upvalues: (copy) v_u_6, (copy) v_u_32, (copy) v_u_7, (copy) v_u_4, (copy) v_u_10, (copy) v_u_14
			if game["Run Service"]:IsServer() then
				p_u_136.AbilitiesDisabled = true
				v_u_6:Play(p_u_136.Config.Sounds.RejuvenateTheRottenActivate, {
					["Parent"] = p_u_136.Rig.PrimaryPart,
					["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
					["Volume"] = 0.75
				})
				task.delay(1, function()
					-- upvalues: (copy) p_u_136, (ref) v_u_32, (ref) v_u_6, (ref) v_u_7, (ref) v_u_4, (ref) v_u_10
					local v_u_137 = p_u_136.Rig.PrimaryPart
					for v138, v_u_139 in pairs(p_u_136.KilledLocations or {}) do
						p_u_136.KilledLocations[v138] = nil
						task.spawn(function()
							-- upvalues: (ref) p_u_136, (ref) v_u_32, (ref) v_u_6, (ref) v_u_7, (copy) v_u_139, (copy) v_u_137, (ref) v_u_4, (ref) v_u_10
							local v_u_140
							if p_u_136.Behavior.GetZombie then
								v_u_140 = v_u_32("GetZombie", ("%*/Abilities/RejuvenateTheRotten"):format(script.Parent), p_u_136)
							else
								v_u_140 = nil
							end
							if not (v_u_140 and p_u_136.Behavior.GetZombie) then
								v_u_140 = p_u_136.Config.ZombieTemplate:IsA("Model") and p_u_136.Config.ZombieTemplate:Clone() or p_u_136.Config.ZombieTemplate:GetChildren()[math.random(1, #p_u_136.Config.ZombieTemplate:GetChildren())]:Clone()
							end
							v_u_140:SetAttribute("ExecutionsDisabled", true)
							v_u_140.Name = "1x1x1x1Zombie"
							v_u_140:SetAttribute("HitboxPriority", 0)
							v_u_140.PrimaryPart.Anchored = true
							v_u_140.Humanoid.Health = p_u_136.Config.ZombieHealth
							v_u_140.Humanoid.EvaluateStateMachine = false
							v_u_140.Parent = workspace.Map.Ingame
							v_u_32("SummonZombie", ("%*/Abilities/RejuvenateTheRotten"):format(script.Parent), p_u_136, v_u_140)
							local v_u_141 = Instance.new("Highlight")
							v_u_141.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
							v_u_141.FillColor = Color3.fromRGB(0, 100, 0)
							v_u_141.OutlineColor = Color3.fromRGB(0, 150, 0)
							v_u_141.FillTransparency = 0.5
							v_u_141.OutlineTransparency = 0
							v_u_141.Adornee = v_u_140
							local v142 = p_u_136.Player:FindFirstChild("PlayerGui")
							if v142 then
								local v143 = v142:FindFirstChild("ZombieHighlights")
								if not v143 then
									v143 = Instance.new("Folder")
									v143.Name = "ZombieHighlights"
									v143.Parent = v142
								end
								v_u_141.Parent = v143
							else
								v_u_141.Parent = v_u_140
							end
							v_u_140.AncestryChanged:Connect(function()
								-- upvalues: (ref) v_u_140, (copy) v_u_141
								if not v_u_140.Parent then
									v_u_141:Destroy()
								end
							end)
							local v_u_144 = v_u_6:Play(p_u_136.Config.Sounds.RejuvenateTheRottenMinionIdle, {
								["Parent"] = v_u_140.PrimaryPart,
								["Looped"] = true,
								["Volume"] = 0
							})
							game.TweenService:Create(v_u_144, TweenInfo.new(2.5), {
								["Volume"] = 0.5
							}):Play()
							v_u_7:FixCharacter(v_u_140, "Killers")
							v_u_7:AddHitboxes(v_u_140, "Killers")
							local v_u_145 = {}
							for v146, v147 in pairs(p_u_136.Config.ZombieAnimations) do
								v_u_145[v146] = v_u_7:LoadAnimationFromID(v_u_140, v147)
							end
							v_u_145.Summon:Play(0)
							v_u_145.Idle:Play(0)
							local v148 = CFrame.lookAt
							local v149 = v_u_139
							local v150 = v_u_137.Position.X
							local v151 = v_u_139.Y
							local v152 = v_u_137.Position.Z
							v_u_140:SetPrimaryPartCFrame(v148(v149, (Vector3.new(v150, v151, v152))))
							v_u_6:Play(p_u_136.Config.Sounds.RejuvenateTheRottenRevive, {
								["Parent"] = v_u_140.PrimaryPart,
								["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
								["Volume"] = 0.5
							})
							task.wait(2.5)
							local v_u_153 = ""
							v_u_140.Humanoid.Running:Connect(function(p154)
								-- upvalues: (ref) v_u_140, (ref) p_u_136, (ref) v_u_153, (copy) v_u_145
								if p154 > 0.01 then
									if v_u_140.Humanoid.WalkSpeed == p_u_136.Config.ZombieWalkSpeed and v_u_153 ~= "Walk" then
										v_u_145.Walk:Play()
										v_u_145.Run:Stop()
										return
									end
									if v_u_140.Humanoid.WalkSpeed == p_u_136.Config.ZombieSprintSpeed and v_u_153 ~= "Run" then
										v_u_145.Walk:Stop()
										v_u_145.Run:Play()
										return
									end
								else
									v_u_153 = ""
									v_u_145.Walk:Stop()
									v_u_145.Run:Stop()
								end
							end)
							task.spawn(function()
								-- upvalues: (ref) p_u_136, (ref) v_u_140, (ref) v_u_6
								local v155 = p_u_136.Config.ZombieSounds
								if v155 then
									local v156 = #v155
									while v_u_140.Parent and v_u_140.PrimaryPart do
										v_u_6:Play(v155[math.random(1, v156)], {
											["Parent"] = v_u_140.PrimaryPart,
											["Volume"] = 0.4,
											["PlaybackSpeed"] = Random.new():NextNumber(0.8, 2)
										})
										task.wait(math.random(10, 25))
									end
								end
							end)
							v_u_140.PrimaryPart.Anchored = false
							v_u_140.Humanoid.EvaluateStateMachine = true
							task.spawn(function()
								-- upvalues: (ref) v_u_4, (ref) v_u_140, (ref) p_u_136, (copy) v_u_145, (ref) v_u_6, (ref) v_u_10, (ref) v_u_7, (copy) v_u_144
								local v157 = require(v_u_4.Modules.Actors)
								local v158 = math.random(6, 12)
								local v159 = require(v_u_4.Modules.SimplePath).new(v_u_140)
								v_u_140:AddTag("Ragdoll")
								local v160 = nil
								local v161 = nil
								local v162 = 0
								while true do
									if not v_u_140.Parent or (not v_u_140.PrimaryPart or v_u_140.Humanoid.Health <= 0) then
										if v_u_144 and v_u_144.Parent then
											game.TweenService:Create(v_u_144, TweenInfo.new(0.8), {
												["PlaybackSpeed"] = 0
											}):Play()
										end
										if v159 then
											v159:Destroy()
										end
										return
									end
									if not v160 or (not v160.PrimaryPart or (v160.Humanoid.Health <= 0 or v160:GetAttribute("Undetectable"))) then
										break
									end
									local v163 = (v160.PrimaryPart.Position - v_u_140.PrimaryPart.Position).Magnitude
									if v163 <= p_u_136.Config.ZombieAttackRange then
										v_u_145.Attack:Play()
										v_u_6:Play(p_u_136.Config.Sounds.Swing, {
											["Parent"] = v_u_140.PrimaryPart,
											["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
											["Volume"] = 0.25
										})
										local v164 = v160:FindFirstChild("Humanoid")
										if v164 then
											v_u_6:Play(p_u_136.Config.Sounds.RejuvenateTheRottenMinionHit, {
												["Parent"] = v_u_140.PrimaryPart
											})
											local v165 = v164.Parent
											local v166 = v_u_10:PlayerHasStatus(v165, "Glitched")
											for _, v167 in p_u_136.Config.ZombieAttackEffects do
												v_u_10:ApplyStatus(v165, table.unpack(v167))
											end
											if v166 then
												v_u_7:ApplyDamage(v165, p_u_136.Config.ZombieAttackDamage)
											else
												local v168 = v164.Health - p_u_136.Config.ZombieAttackDamage
												v164.Health = math.max(1, v168)
											end
											v_u_7:RevealPlayerAuraTo(p_u_136.Player, v165, p_u_136.Config.ZombieRevealTime)
										end
										if v161 and v161.Behavior then
											v161.Behavior.AILastSeen = nil
										end
										task.wait(p_u_136.Config.ZombieAttackCooldown)
									else
										if p_u_136.Config.ZombieLoseFocusRange <= v163 then
											v159:Stop()
											v173 = nil
											v161 = nil
										else
											if v161 and v161.Behavior then
												v161.Behavior.AILastSeen = tick()
											end
											v_u_140.Humanoid.WalkSpeed = p_u_136.Config.ZombieSprintSpeed
											v159:Run(v160.PrimaryPart.Position)
											v173 = v160
										end
										-- ERROR
										v160 = v_u_7:GetClosestPlayerFromPosition(v_u_140.PrimaryPart.Position, {
											["PlayerSelection"] = "Survivors",
											["MaxDistance"] = p_u_136.Config.ZombieTargetRange
										})
										if v160 then
											v161 = game.Players:GetPlayerFromCharacter(v160)
											if v161 then
												v161 = v157.CurrentActors[v161]
											end
										else
											v160 = v173
										end
										if v158 <= v162 then
											v158 = math.random(6, 12)
											local v169 = v_u_140.Humanoid
											local v170 = v_u_140.PrimaryPart.Position
											local v171 = math.random(-80, 80)
											local v172 = math.random
											v169:MoveTo(v170 + Vector3.new(v171, 0, v172(-80, 80)))
											v162 = 0
										end
										v_u_140.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
										v_u_140.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
										v_u_140.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
										v162 = v162 + game["Run Service"].Heartbeat:Wait()
									end
								end
								v_u_140.Humanoid.WalkSpeed = p_u_136.Config.ZombieWalkSpeed
								local v173 = nil
								v161 = nil
								-- ERROR
							end)
						end)
					end
				end)
				task.delay(4.25, function()
					-- upvalues: (copy) p_u_136
					p_u_136.AbilitiesDisabled = false
				end)
				task.delay(0.98, function()
					-- upvalues: (ref) v_u_14, (copy) p_u_136, (ref) v_u_6
					for _, v174 in v_u_14 do
						local v175 = p_u_136.Rig.Head.EyesFlare:FindFirstChild(v174)
						if v175 then
							v175.Enabled = true
						end
					end
					for v176 = 1, 6 do
						p_u_136.Rig.HumanoidRootPart["Chain" .. v176]["Chain" .. v176].Enabled = true
						v_u_6:Play(p_u_136.Config.Sounds.Chains, {
							["Parent"] = p_u_136.Rig.PrimaryPart,
							["PlaybackSpeed"] = 0.75,
							["Volume"] = 0.1
						})
					end
				end)
				task.delay(1.35, function()
					-- upvalues: (ref) v_u_14, (copy) p_u_136
					for _, v177 in v_u_14 do
						local v178 = p_u_136.Rig.Head.EyesFlare:FindFirstChild(v177)
						if v178 then
							v178.Enabled = false
						end
					end
				end)
				task.delay(1.98, function()
					-- upvalues: (copy) p_u_136
					p_u_136.Rig.HumanoidRootPart["Chain" .. 1]["Chain" .. 1].Enabled = false
					p_u_136.Rig.HumanoidRootPart["Chain" .. 2]["Chain" .. 2].Enabled = false
					p_u_136.Rig.HumanoidRootPart["Chain" .. 3]["Chain" .. 3].Enabled = false
					p_u_136.Rig.HumanoidRootPart["Chain" .. 4]["Chain" .. 4].Enabled = false
					p_u_136.Rig.HumanoidRootPart["Chain" .. 5]["Chain" .. 5].Enabled = false
					p_u_136.Rig.HumanoidRootPart["Chain" .. 6]["Chain" .. 6].Enabled = false
				end)
				task.delay(2.1, function() end)
			elseif game["Run Service"]:IsClient() then
				p_u_136.Animations.RejuvenateTheRotten:Play(0.175)
				v_u_7:CreateSpeedMultiplier(p_u_136.Player, 0.01, "RejuvenateTheRotten", 3.75, true)
			end
		end
	}
}
v5.Abilities = v179
function v5.Created(_, p_u_180)
	-- upvalues: (copy) v_u_11, (copy) v_u_32
	if game["Run Service"]:IsServer() then
		p_u_180.KilledLocations = {}
		local function v186(p181)
			-- upvalues: (copy) p_u_180
			local v182 = p181:FindFirstChild("Humanoid")
			local v_u_183 = p181.PrimaryPart
			if v182 and v_u_183 then
				v182.Died:Once(function()
					-- upvalues: (ref) p_u_180, (copy) v_u_183
					p_u_180:IncrementCharges("RejuvenateTheRotten", 1, 1)
					local v184 = p_u_180.KilledLocations
					local v185 = v_u_183.Position
					table.insert(v184, v185)
				end)
			end
		end
		for _, v187 in pairs(workspace.Players.Survivors:GetChildren()) do
			local v188 = v187:FindFirstChild("Humanoid")
			local v_u_189 = v187.PrimaryPart
			if v188 and v_u_189 then
				v188.Died:Once(function()
					-- upvalues: (copy) p_u_180, (copy) v_u_189
					p_u_180:IncrementCharges("RejuvenateTheRotten", 1, 1)
					local v190 = p_u_180.KilledLocations
					local v191 = v_u_189.Position
					table.insert(v190, v191)
				end)
			end
		end
		local v_u_192 = workspace.Players.Survivors.ChildAdded:Connect(v186)
		p_u_180.Rig.AncestryChanged:Connect(function(_, p193)
			-- upvalues: (ref) v_u_192
			if not p193 then
				v_u_192:Disconnect()
				v_u_192 = nil
			end
		end)
		if not p_u_180.Config.HighlightDisabled then
			local v194 = Instance.new("Highlight")
			v194.DepthMode = Enum.HighlightDepthMode.Occluded
			v194.Parent = p_u_180.Rig
			for v195, v196 in pairs(p_u_180.Config.HighlightProperties) do
				v194[v195] = v196
			end
		end
		p_u_180:SetCooldownOf("UnstableEye", p_u_180.Config.UnstableEyeCooldown / 2)
	elseif game["Run Service"]:IsClient() then
		v_u_11:SetConnection("Entangled", "REMOTE_EVENT", function()
			-- upvalues: (ref) v_u_32, (copy) p_u_180
			v_u_32("cl_Entangled", "feel my entanglement", p_u_180)
		end)
	end
end
function v5.OnIntroduction(_, p_u_197, p198, p199)
	-- upvalues: (copy) v_u_13, (copy) v_u_1, (copy) v_u_14, (copy) v_u_7
	v_u_13:SetCustomLighting(p_u_197.Config.IntroLighting)
	local v_u_200 = p_u_197.Config.IntroHeadTemplate:Clone()
	v_u_200:SetPrimaryPartCFrame(p198:WaitForChild("Right Arm").CFrame * CFrame.Angles(0, 0, 3.141592653589793) * CFrame.new(0, 0.9, 0.1))
	v_u_200.ArmWeld.Part0 = p198:WaitForChild("Right Arm")
	v_u_200.Parent = workspace
	v_u_1:AddItem(v_u_200, 5)
	task.delay(0.92, function()
		-- upvalues: (copy) v_u_200
		local v201 = v_u_200:FindFirstChild("Root")
		if v201 then
			v201 = v201:FindFirstChild("Blood")
		end
		if v201 then
			v201:Emit(30)
		end
	end)
	task.delay(0.94, function()
		-- upvalues: (ref) v_u_14, (copy) p_u_197
		for _, v202 in v_u_14 do
			local v203 = p_u_197.Rig.Head.EyesFlare:FindFirstChild(v202)
			if v203 then
				v203.Enabled = true
			end
		end
	end)
	task.delay(0.966, function()
		-- upvalues: (copy) v_u_200
		v_u_200.Head:Destroy()
		v_u_200.Hair:Destroy()
	end)
	task.delay(1.2, function()
		-- upvalues: (ref) v_u_14, (copy) p_u_197
		for _, v204 in v_u_14 do
			local v205 = p_u_197.Rig.Head.EyesFlare:FindFirstChild(v204)
			if v205 then
				v205.Enabled = false
			end
		end
	end)
	v_u_7:CreateFOVMultiplier(game.Players.LocalPlayer, 0.6, "1x1x1x1IntroScene", p199)
	task.delay(p199, function()
		-- upvalues: (ref) v_u_13
		v_u_13:SetAsCurrentLighting()
	end)
end
function v5.OnKill(p206, p207)
	-- upvalues: (copy) v_u_12
	if p207.Name == "Shedletsky" then
		v_u_12:IncrementAchievementProgress(p206.Player, "1x1x1x1Hunt")
	end
end
function v5.OnExecution(_, p_u_208, p_u_209)
	local v210 = p_u_209:FindFirstChild("Sword")
	local v_u_211 = p_u_209:FindFirstChild("Humanoid")
	local v_u_212 = p_u_209:FindFirstChild("Head")
	local v_u_213 = require(game.ReplicatedStorage.Modules.Ragdolls)
	if p_u_209.Name == "Shedletsky" then
		v210.Transparency = 0
		local _ = workspace:GetServerTimeNow() + 3.23
		task.delay(3.23, function()
			-- upvalues: (copy) v_u_211, (copy) v_u_213, (copy) p_u_209, (copy) v_u_212
			if v_u_211 then
				v_u_213.AddProfile(p_u_209, {
					["Velocity"] = Vector3.new(0, 50, 0),
					["KillEffects"] = {
						["HeadSquash"] = true
					}
				})
				v_u_211.Health = 0
				for _, v214 in ipairs(p_u_209 and p_u_209:GetChildren() or {}) do
					if v214:IsA("Accessory") then
						v214:Destroy()
					end
				end
				if v_u_212 then
					v_u_212:Destroy()
				end
			end
		end)
	else
		local _ = workspace:GetServerTimeNow() + 2
		task.delay(2, function()
			-- upvalues: (copy) p_u_208, (copy) v_u_211, (copy) v_u_213, (copy) p_u_209
			local v_u_215 = p_u_208.Rig["Left Arm"]:FindFirstChild("Blood", true)
			if v_u_215 then
				v_u_215.Enabled = true
				task.delay(0.2, function()
					-- upvalues: (copy) v_u_215
					v_u_215.Enabled = false
				end)
			end
			if v_u_211 then
				local v216 = v_u_213.AddProfile
				local v217 = p_u_209
				local v218 = {
					["Velocity"] = p_u_208.Rig.PrimaryPart.CFrame.LookVector.Unit * 35,
					["KillEffects"] = {
						["HeadSquash"] = true
					}
				}
				v216(v217, v218)
				v_u_211.Health = 0
			end
		end)
	end
end
function v5.OnVictory(_, p219, p220, p_u_221, p222)
	-- upvalues: (copy) v_u_13, (copy) v_u_7, (copy) v_u_3, (copy) v_u_2
	local v223 = game.Players.LocalPlayer
	if p219 == "Start" then
		v_u_13:SetCustomLighting(p220.Config.OutroLighting)
		local v_u_224 = tick()
		local v_u_225 = p220.Config.OutroVFXFolder
		local _ = p220.Cache.VictoryKillerTrack
		local v_u_226 = p220.Cache.VictoryCameraTrack
		local v_u_227 = {}
		task.spawn(function()
			-- upvalues: (copy) v_u_225, (copy) p_u_221, (copy) v_u_227, (copy) v_u_226, (ref) v_u_7, (copy) v_u_224, (ref) v_u_3
			local v_u_228 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 5)
			if v_u_228 and v_u_228:FindFirstChild("Dummies") then
				for _, v229 in ipairs(v_u_225:GetChildren()) do
					if v229:IsA("Attachment") then
						local v230 = v229:GetAttribute("adornee")
						local v231 = v229:GetAttribute("dummyName")
						local v232 = v231 and v_u_228.Dummies[v231] or p_u_221
						local v233 = v229:Clone()
						v233.Parent = v232[v230]
						v_u_227[v229.Name] = v233
					end
				end
				v_u_226:GetMarkerReachedSignal("emit"):Connect(function(p234)
					-- upvalues: (ref) v_u_227, (ref) v_u_7
					local v235 = v_u_227[p234]
					local v236 = ("No attachment called %* in VFX folder."):format(p234)
					assert(v235, v236)
					v_u_7:EmitParticles(v_u_227[p234])
				end)
				local v237 = tick() - v_u_224
				local v_u_238 = v_u_228.Shockwave
				local v239 = task.delay
				local v240 = 1.1 - v237
				v239(math.max(0.1, v240), function()
					-- upvalues: (ref) v_u_3, (copy) v_u_238, (copy) v_u_228
					local v241 = v_u_3:Create(v_u_238.Root, TweenInfo.new(0.4), {
						["CFrame"] = v_u_228.ShockwaveHitPoint.CFrame
					})
					v241:Play()
					v241.Completed:Wait()
					local v242 = 0.02
					while v_u_238 and v_u_238.Parent do
						v_u_238:PivotTo(v_u_238:GetPivot() * CFrame.new(0, 0, v242 * -70))
						v242 = task.wait()
					end
				end)
			end
		end)
		task.spawn(function()
			-- upvalues: (ref) v_u_3
			local v243 = game.Lighting:WaitForChild("1xCC", 5)
			if v243 then
				v_u_3:Create(v243, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					["Saturation"] = 0.125
				}):Play()
				task.wait(2.8)
				v_u_3:Create(v243, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					["Contrast"] = 0.2,
					["Brightness"] = 0.04,
					["TintColor"] = Color3.new(0.666667, 1, 0.717647)
				}):Play()
				task.wait(0.2)
				v_u_3:Create(v243, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					["Contrast"] = 0,
					["Brightness"] = 0.04,
					["Saturation"] = 0.4,
					["TintColor"] = Color3.new(1, 0.309804, 0.309804)
				}):Play()
				task.wait(0.2)
				v_u_3:Create(v243, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					["Contrast"] = 0,
					["Brightness"] = 0,
					["Saturation"] = 0,
					["TintColor"] = Color3.new(1, 1, 1)
				}):Play()
				task.wait(1.3)
				v_u_3:Create(v243, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					["Contrast"] = 0.1,
					["Brightness"] = -0.1
				}):Play()
				task.wait(0.3)
				v_u_3:Create(v243, TweenInfo.new(1.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
					["Contrast"] = 0.3,
					["Brightness"] = 0.2,
					["Saturation"] = 0.3,
					["TintColor"] = Color3.new(0.721569, 1, 0.752941)
				}):Play()
			end
		end)
		local v_u_244 = workspace.CurrentCamera
		v223:SetAttribute("FOVMultipliersDisabled", true)
		v_u_2:BindToRenderStep("1x1x1x1Outro", 1, function()
			-- upvalues: (copy) v_u_244
			v_u_244.FieldOfView = 50
		end)
		v_u_7:PlayDummyCutsceneAnimations(p220, p222, "Victory")
	else
		v_u_2:UnbindFromRenderStep("1x1x1x1Outro")
		v223:SetAttribute("FOVMultipliersDisabled", nil)
		v_u_13:SetAsCurrentLighting()
	end
end
function v5.cl_Entangled(p245)
	-- upvalues: (copy) v_u_7, (copy) v_u_1, (copy) v_u_3, (copy) v_u_2
	warn("ABOGEYWOOGEYWOO")
	local v_u_246 = v_u_7:GetSettingValue("EpilepsyMode", game.Players.LocalPlayer)
	local v247 = p245.Config.PopupsFolder
	local v_u_248 = {}
	local function v_u_258(p249)
		-- upvalues: (copy) v_u_246
		local v250 = {}
		for _ = 1, 18 do
			local v251 = Random.new()
			local v252 = v251:NextInteger(0, 1)
			local v253 = Instance.new("Frame", p249)
			v253.Size = UDim2.fromScale(v251:NextNumber() / 2 + 0.2 + (v_u_246 and 0.1 or 0), v251:NextNumber() / 3 + 0.15 + (v_u_246 and 0.05 or 0))
			local v254 = v_u_246 and Color3.new(0, 0, 0)
			if not v254 then
				local v255 = Color3.new
				local v256 = v252 / 8
				local v257 = v252 - v251:NextNumber(0, 0.1)
				v254 = v255(v256, math.clamp(v257, 0, 1), v252 / 8)
			end
			v253.BackgroundColor3 = v254
			v253.Position = UDim2.fromScale(v251:NextNumber(), v251:NextNumber())
			v253.AnchorPoint = Vector2.new(0.5, 0.5)
			v253.BorderSizePixel = 0
			v253.ZIndex = 3
			table.insert(v250, v253)
		end
		return v250
	end
	for _ = 1, p245.Config.EntanglementPopupCount do
		local v259 = v247:GetChildren()
		local v260 = v259[math.random(1, #v259)]
		table.insert(v_u_248, v260:Clone())
	end
	local v_u_261 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("TemporaryUI")
	for _, v_u_262 in pairs(v_u_248) do
		local v_u_263 = {}
		local v264 = math.random(120, 260) / 100
		local v_u_265 = TweenInfo.new(v264 - 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
		local v266 = math.random(90, 130) / 100
		local v267 = UDim2.fromOffset(v_u_262.Size.X.Offset * v266, v_u_262.Size.Y.Offset * v266)
		v_u_262.Name = "1x1x1x1Popup"
		v_u_262.ImageTransparency = 1
		v_u_262.Selectable = false
		v_u_262.Size = v267
		v_u_262.Position = UDim2.fromScale(0.5, 0.5) + UDim2.fromScale(math.random(-100, 100) / 300, math.random(-100, 100) / 300)
		v_u_262:SetAttribute("OGPos", v_u_262.Position)
		v_u_262.Parent = v_u_261
		v_u_1:AddItem(v_u_262, v264)
		task.spawn(function()
			-- upvalues: (copy) v_u_262, (copy) v_u_261, (ref) v_u_263, (copy) v_u_258, (ref) v_u_3, (copy) v_u_265
			local v268 = os.clock()
			while v_u_262 and (v_u_262.Parent == v_u_261 and os.clock() - v268 < 0.15) do
				for _, v269 in ipairs(v_u_263) do
					v269:Destroy()
				end
				table.clear(v_u_263)
				v_u_263 = v_u_258(v_u_262)
				task.wait()
			end
			v_u_262.ImageTransparency = 0
			v_u_3:Create(v_u_262, v_u_265, {
				["ImageTransparency"] = 1
			}):Play()
			for _, v270 in ipairs(v_u_263) do
				v270:Destroy()
			end
		end)
	end
	local v_u_271 = os.clock()
	local v_u_275 = v_u_2.RenderStepped:Connect(function(_)
		-- upvalues: (copy) v_u_248, (copy) v_u_271
		for _, v272 in pairs(v_u_248) do
			if v272 and v272.Parent then
				local v273 = v272:GetAttribute("OGPos")
				local v274 = os.clock() - v_u_271
				v272.Position = v273 + UDim2.fromScale(math.random(-100, 100) / (10000 + v274 * 12000), math.random(-100, 100) / (10000 + v274 * 12000))
			end
		end
	end)
	task.delay(3, function()
		-- upvalues: (copy) v_u_275
		v_u_275:Disconnect()
	end)
end
return v5