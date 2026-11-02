-- Decompiled by Krnl

require(game.ReplicatedStorage.GlobalTypes)
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("TweenService")
local v4 = game:GetService("Players")
local v_u_5 = game:GetService("Debris")
game:GetService("Lighting")
local v_u_6 = require(v1.Modules.Sounds)
local v_u_7 = require(v1.Modules.Actors)
local v_u_8 = require(v1.Modules.Ragdolls)
local v_u_9 = require(v1.Modules.Schematics.Lighting)
local v_u_10 = require(v1.Modules.Util)
local v_u_11 = require(v1.Systems.Character.Game.Sprinting)
local v_u_12 = require(v1.Modules.Hitboxes)
local v_u_13 = require(v1.Modules.Misc.Maid)
local v_u_14 = require(v1.Modules.Statuses)
local v_u_15 = require(v1.Modules.Network)
local v_u_16 = require(v1.Modules.AchievementUtil)
local v_u_17 = math.random
local v_u_18 = table.insert
local v_u_19 = table.sort
local v_u_20 = task.wait
local v_u_21 = task.spawn
local v_u_22 = task.delay
local v_u_23 = coroutine.close
local v_u_24 = v_u_2:IsClient()
local v_u_25 = v_u_2:IsServer()
v_u_2:IsStudio()
local v_u_26 = TweenInfo.new(1)
local v_u_27 = Random.new()
local v_u_28 = TweenInfo.new(0.2)
local v_u_29
if v_u_24 then
	v_u_29 = v4.LocalPlayer
else
	v_u_29 = v_u_24
end
local v_u_30
if v_u_24 then
	v_u_30 = workspace.CurrentCamera
else
	v_u_30 = v_u_24
end
local function v_u_36(p_u_31, p_u_32, ...)
	assert(p_u_31, "bad moduleInfo, must be a table")
	local v33, v34 = pcall(function(...)
		-- upvalues: (copy) p_u_31, (copy) p_u_32
		if p_u_31[p_u_32] then
			return p_u_31[p_u_32](...)
		end
	end, ...)
	if not v33 then
		local v35 = ("Failed to call :%*() due to: %*"):format(p_u_32, v34)
		warn((("[Slasher]: %*"):format(v35)))
	end
	return v33, v34
end
local function v_u_41(p37, p38, p39)
	-- upvalues: (copy) v_u_6, (copy) v_u_27
	local v40 = p37.Config.Sounds[p38]
	assert(v40, "bad soundName, does not exist")
	return v_u_6:Play(p37.Config.Sounds[p38], {
		["Parent"] = p37.Rig.PrimaryPart,
		["PlaybackSpeed"] = v_u_27:NextNumber(0.975, 1.025),
		["Looped"] = p39 or false,
		["Volume"] = 0.25
	})
end
local function v_u_47(p42)
	-- upvalues: (copy) v_u_25, (copy) v_u_10, (copy) v_u_6, (copy) v_u_36, (copy) v_u_15, (copy) v_u_24, (copy) v_u_3, (copy) v_u_26, (copy) v_u_5, (copy) v_u_11
	local v43 = p42.Rig
	if p42.State.isEnraged and (v43 and v43.Parent) then
		p42.State.isEnraged = false
		if v_u_25 then
			v_u_10:RemoveInvincible(v43, "Raging")
			p42:ChangeExpression("Default")
			local v44 = p42.Instances.EnragedSFX
			if v44 then
				v44:Destroy()
				p42.Instances.EnragedSFX = nil
			end
			v_u_6:Play(p42.Config.Sounds.EnragedEnd, {
				["Parent"] = p42.Rig.PrimaryPart
			})
			for _, v45 in p42.Instances.EnragedVisuals do
				v45.Enabled = false
			end
			v_u_36(p42.Behavior, "EnragedEnd", p42.Behavior, p42)
			v_u_15:FireClientConnection(p42.Player, ("%*EnrageStateAsync"):format(p42.Player.Name), "REMOTE_EVENT")
			return
		end
		if v_u_24 then
			p42.AnimationType = nil
			p42.MovementAnimSpeed = nil
			v_u_15:FireConnection("DisableSprinting", "ENRAGED", false)
			if p42.Meta.TargetedPlayer then
				v_u_10:RevealPlayerAura(p42.TargetedPlayer, p42.Config.EnragedAuraLingerTime)
				p42.Meta.TargetedPlayer = nil
			end
			if p42.Instances.SpeedModifier then
				v_u_3:Create(p42.Instances.SpeedModifier, v_u_26, {
					["Value"] = 1
				}):Play()
				v_u_5:AddItem(p42.Instances.SpeedModifier, 1)
			end
			local v46 = v_u_10:CreateSpeedMultiplier(p42.Rig, 0.001, "Pacified")
			v_u_3:Create(v46, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				["Value"] = 1
			}):Play()
			v_u_5:AddItem(v46, 1)
			v_u_11.StaminaCap = nil
		end
	end
end
local v48 = {}
local v118 = {
	["Slash"] = {
		["LayoutOrder"] = 1,
		["Icon"] = "rbxassetid://97183429269286",
		["KeybindType"] = "MainAbility",
		["Cooldown"] = function(p49, p50)
			return p49.State.isEnraged and p49.Config[("Enraged%*Cooldown"):format(p50)] or p49.Config[("%*Cooldown"):format(p50)]
		end,
		["Callback"] = function(p_u_51)
			-- upvalues: (copy) v_u_25, (copy) v_u_41, (copy) v_u_22, (copy) v_u_10, (copy) v_u_3, (copy) v_u_26, (copy) v_u_5, (copy) v_u_20, (copy) v_u_47, (copy) v_u_12, (copy) v_u_14, (copy) v_u_36, (copy) v_u_24
			if v_u_25 then
				local v_u_52 = p_u_51.Rig
				p_u_51.AbilitiesDisabled = true
				v_u_41(p_u_51, "Swing")
				local v_u_53 = p_u_51.State.isEnraged
				if not (p_u_51.State.isEnraged and p_u_51.Config.EnragedSlashDamage) then
					local _ = p_u_51.Config.SlashDamage
				end
				v_u_22(0.075, function()
					-- upvalues: (copy) v_u_53, (ref) v_u_10, (copy) v_u_52, (copy) p_u_51, (ref) v_u_3, (ref) v_u_26, (ref) v_u_5, (ref) v_u_20, (ref) v_u_47
					if v_u_53 then
						local v54 = v_u_10:ApplyVelocity(v_u_52.PrimaryPart, p_u_51.Config.EnragedSlashLungeForce)
						v_u_3:Create(v54, v_u_26, {
							["LineVelocity"] = v54.LineVelocity / 100
						}):Play()
						v_u_5:AddItem(v54, 0.6)
					end
					v_u_20(0.5)
					v_u_47(p_u_51)
					v_u_20(0.275)
					p_u_51.AbilitiesDisabled = false
				end)
				v_u_22(p_u_51.Config.SlashWindup, function()
					-- upvalues: (ref) v_u_12, (copy) p_u_51, (ref) v_u_14, (ref) v_u_10, (ref) v_u_36, (ref) v_u_41, (copy) v_u_53
					local v55 = v_u_12
					local v56 = p_u_51.Player
					local v57 = {
						["Size"] = Vector3.new(4.5, 6, 7.5),
						["CFrameOffset"] = CFrame.new(0, 0, -1.25)
					}
					local v58 = p_u_51
					v57.Damage = v58.State.isEnraged and v58.Config.EnragedSlashDamage or v58.Config.SlashDamage
					v57.Time = p_u_51.Config.SlashLinger
					v57.Knockback = 2
					v57.HitMultiple = true
					v57.ExecuteOnKill = true
					v57.Connections = {
						["Hit"] = function(p59, p60)
							-- upvalues: (ref) v_u_14, (ref) v_u_10, (ref) p_u_51, (ref) v_u_36, (ref) v_u_41, (ref) v_u_53
							local v61 = v_u_14:PlayerHasStatus(p59, "Gouged")
							v_u_10:CreateSpeedMultiplier(p59, 1.5, "HitSpeedBonus", 1.25)
							v_u_14:ApplyStatus(p59, "Bleeding", {
								["Level"] = 1,
								["Duration"] = p_u_51.Config.SlashStatusTime + (v61 and 2 or 0)
							})
							if p60 then
								v_u_36(p_u_51.Behavior, "OnSlashHit", p_u_51.Behavior, p59)
								v_u_41(p_u_51, "Hit")
							end
							if v61 and not v_u_53 then
								v_u_14:RemoveStatus(p59, "Gouged")
							elseif v_u_53 then
								v_u_14:ApplyStatus(p59, "Gouged", {
									["Killer"] = p_u_51,
									["Level"] = 1,
									["Duration"] = 8
								})
							end
						end
					}
					v55:CreateHitbox(v56, v57)
				end)
			elseif v_u_24 then
				p_u_51.Animations.Slash:Play(0.025)
			end
		end
	},
	["Behead"] = {
		["LayoutOrder"] = 2,
		["Icon"] = "rbxassetid://115283980500353",
		["KeybindType"] = "AltAbility1",
		["Cooldown"] = function(p62, p63)
			return p62.State.isEnraged and p62.Config[("Enraged%*Cooldown"):format(p63)] or p62.Config[("%*Cooldown"):format(p63)]
		end,
		["Callback"] = function(p_u_64)
			-- upvalues: (copy) v_u_25, (copy) v_u_41, (copy) v_u_22, (copy) v_u_12, (copy) v_u_17, (copy) v_u_16, (copy) v_u_7, (copy) v_u_10, (copy) v_u_14, (copy) v_u_47, (copy) v_u_20, (copy) v_u_24, (copy) v_u_3, (copy) v_u_5
			if v_u_25 then
				local v_u_65 = p_u_64.State.isEnraged
				local v_u_66 = p_u_64.Rig
				p_u_64.AbilitiesDisabled = true
				v_u_41(p_u_64, "Swing")
				v_u_22(p_u_64.Config.BeheadWindup, function()
					-- upvalues: (ref) v_u_12, (copy) p_u_64, (copy) v_u_65, (ref) v_u_17, (ref) v_u_16, (ref) v_u_7, (ref) v_u_10, (ref) v_u_14, (ref) v_u_41, (ref) v_u_47, (ref) v_u_20, (copy) v_u_66
					local v67 = v_u_12
					local v68 = p_u_64.Player
					local v69 = {
						["Size"] = Vector3.new(8, 2, 7),
						["CFrameOffset"] = CFrame.new(0, 0, -2)
					}
					local v70 = p_u_64
					v69.Damage = v70.State.isEnraged and v70.Config.EnragedBeheadDamage or v70.Config.BeheadDamage
					v69.Time = p_u_64.Config.BeheadLinger
					v69.Knockback = 2
					v69.HitMultiple = true
					v69.Connections = {
						["Hit"] = function(p_u_71, p72)
							-- upvalues: (ref) v_u_65, (ref) p_u_64, (ref) v_u_17, (ref) v_u_16, (ref) v_u_7, (ref) v_u_10, (ref) v_u_14, (ref) v_u_41, (ref) v_u_47
							local v73 = p_u_71:FindFirstChildOfClass("Humanoid")
							if v_u_65 then
								p_u_64:SetCooldownOf("Behead", 0)
							end
							if v73 and v73.Health <= 0 then
								local v74 = p_u_71:FindFirstChild("Torso") and p_u_71:FindFirstChild("Head")
								if v74 then
									v74 = p_u_71.Torso:FindFirstChild("Neck")
								end
								if v74 then
									v74.Enabled = false
									p_u_71.Head.CanCollide = true
									local v75 = p_u_71.Head
									local v76 = v_u_17(-9, 9)
									local v77 = v_u_17
									v75.Velocity = Vector3.new(v76, 35, v77(-9, 9))
								end
								v_u_16:IncrementAchievementProgress(p_u_64.Player, "JasonBrutality")
								if p_u_71.Parent.Name == "Survivors" then
									v_u_7:IncrementActorStats(p_u_64.Player, {
										["Action"] = "Killed a Survivor with Behead",
										["RewardType"] = "DifficultKillerAction"
									})
								end
							else
								v_u_10:CreateSpeedMultiplier(p_u_71, 1.5, "HitSpeedBonus", 0.9)
								v_u_14:ApplyStatus(p_u_71, "Helpless", {
									["Level"] = 1,
									["Duration"] = p_u_64.Config.BeheadStatusTime
								})
								v_u_14:ApplyStatus(p_u_71, "Gouged", {
									["Killer"] = p_u_64,
									["Level"] = 1,
									["Duration"] = p_u_64.Config.BeheadStatusTime
								})
								p_u_71.PrimaryPart.Anchored = true
								task.delay(0.01, function()
									-- upvalues: (copy) p_u_71
									p_u_71.PrimaryPart.Anchored = false
								end)
								if p_u_71.Parent.Name == "Survivors" then
									v_u_7:IncrementActorStats(p_u_64.Player, {
										["Action"] = "Landed Behead hit",
										["RewardType"] = "EasyKillerAction"
									})
								end
							end
							if p72 then
								v_u_41(p_u_64, "Hit")
								v_u_47(p_u_64)
							end
						end
					}
					v67:CreateHitbox(v68, v69)
					v_u_20(0.2)
					v_u_47(p_u_64)
					v_u_14:ApplyStatus(v_u_66, "Slowness", {
						["Level"] = 1,
						["Duration"] = 2
					})
					v_u_20(1.1)
					p_u_64.AbilitiesDisabled = false
				end)
			elseif v_u_24 then
				p_u_64.Animations.Behead:Play(0.025)
				local v_u_78 = v_u_10:CreateSpeedMultiplier(p_u_64.Rig, 1, "BeheadAbility")
				v_u_3:Create(v_u_78, TweenInfo.new(0.125), {
					["Value"] = p_u_64.State.isEnraged and p_u_64.Config.EnragedBeheadLunge or p_u_64.Config.BeheadLunge
				}):Play()
				v_u_22(0.4, function()
					-- upvalues: (ref) v_u_3, (copy) v_u_78, (ref) v_u_20, (ref) v_u_5
					v_u_3:Create(v_u_78, TweenInfo.new(0.3), {
						["Value"] = 0.2
					}):Play()
					v_u_20(0.6)
					v_u_3:Create(v_u_78, TweenInfo.new(0.3), {
						["Value"] = 1
					}):Play()
					v_u_5:AddItem(v_u_78, 0.3)
				end)
			end
		end
	},
	["GashingWound"] = {
		["LayoutOrder"] = 3,
		["Icon"] = "rbxassetid://96900331272883",
		["KeybindType"] = "AltAbility2",
		["Cooldown"] = function(p79, p80)
			return p79.State.isEnraged and p79.Config[("Enraged%*Cooldown"):format(p80)] or p79.Config[("%*Cooldown"):format(p80)]
		end,
		["Callback"] = function(p_u_81)
			-- upvalues: (copy) v_u_25, (copy) v_u_41, (copy) v_u_18, (copy) v_u_19, (copy) v_u_22, (copy) v_u_12, (copy) v_u_14, (copy) v_u_10, (copy) v_u_8, (copy) v_u_36, (copy) v_u_6, (copy) v_u_16, (copy) v_u_7, (copy) v_u_15, (copy) v_u_20, (copy) v_u_47, (copy) v_u_3, (copy) v_u_28
			if v_u_25 then
				p_u_81.AbilitiesDisabled = true
				p_u_81.Cache.GashingWoundStart:Play(0.05)
				v_u_41(p_u_81, "GashingWoundSwing")
				local v_u_82 = p_u_81.State.isEnraged and p_u_81.Config.EnragedGashingWoundDamage or p_u_81.Config.GashingWoundDamage
				local v83 = p_u_81.Config.GashingWoundHitData()
				local v84 = {}
				for v85, _ in pairs(v83) do
					v_u_18(v84, v85)
				end
				v_u_19(v84)
				local v_u_86 = v84[1] + 0.166
				os.clock()
				local v_u_87 = p_u_81.State.isEnraged
				local v_u_88 = nil
				local v_u_89 = 0
				local v_u_90 = nil
				for v_u_91, v_u_92 in v83 do
					v_u_22(v_u_91, function()
						-- upvalues: (copy) v_u_91, (copy) v_u_86, (ref) v_u_88, (ref) v_u_89, (ref) v_u_12, (copy) p_u_81, (copy) v_u_82, (copy) v_u_92, (ref) v_u_41, (ref) v_u_14, (copy) v_u_87, (ref) v_u_10, (ref) v_u_8, (ref) v_u_36, (ref) v_u_90, (ref) v_u_6, (ref) v_u_16, (ref) v_u_7
						if v_u_86 > v_u_91 or v_u_88 then
							v_u_89 = v_u_89 + 1
							local v93 = v_u_12
							local v94 = p_u_81.Player
							local v102 = {
								["Size"] = Vector3.new(8, 4, 8),
								["CFrameOffset"] = CFrame.new(0, 0, -2.25),
								["Damage"] = v_u_82 / v_u_92.DamageDivisor,
								["Time"] = v_u_92.Time,
								["Knockback"] = 0,
								["HitMultiple"] = true,
								["Connections"] = {
									["Hit"] = function(p95, p96)
										-- upvalues: (ref) v_u_41, (ref) p_u_81, (ref) v_u_14, (ref) v_u_87, (ref) v_u_89, (ref) v_u_91, (ref) v_u_88, (ref) v_u_10, (ref) v_u_8, (ref) v_u_36, (ref) v_u_90, (ref) v_u_6, (ref) v_u_16, (ref) v_u_7
										if p96 then
											v_u_41(p_u_81, "Hit")
											if not v_u_14:PlayerHasStatus(p95, "Gouged") then
												v_u_14:ApplyStatus(p95, "Gouged", {
													["Killer"] = p_u_81,
													["Level"] = 1,
													["Duration"] = p_u_81.Config.GashingWoundStatusTime
												})
											end
											if v_u_87 then
												v_u_14:ApplyStatus(p95, "Bleeding", {
													["Level"] = 1,
													["Duration"] = v_u_89
												})
											end
										end
										if v_u_91 <= 0.5 and not v_u_88 then
											local v97, _ = v_u_10:GetEntityType(p95)
											if not v97 then
												return
											end
											v_u_8.SetProfile(p95, {
												["AnchorDelay"] = true,
												["Applied"] = os.clock() + 10
											})
											v_u_88 = p95
											v_u_36(p_u_81.Behavior, "GashingWoundStart", p_u_81.Behavior, p_u_81)
											v_u_10:SetUpCutscene(p_u_81.Rig, p95)
											v_u_10:GiveInvincible(p_u_81.Rig, "Gashing")
											local v98 = p_u_81.Cache.GashingWound
											v98:Play(0)
											v98.TimePosition = p_u_81.Cache.GashingWoundStart.TimePosition
											v_u_90 = v_u_10:LoadAnimationFromID(p95, p_u_81.Config.Animations.GashingWound.PlayerRig, true)
											v_u_90:Play(0.05)
											v_u_90.TimePosition = p_u_81.Cache.GashingWoundStart.TimePosition
											p_u_81.Cache.GashingWoundStart:Stop(0)
											v_u_6:PlayVoiceline(p_u_81, "GashingWoundHit", {
												["Priority"] = 2
											})
											if p95.Humanoid.Health <= 0 then
												for _, v99 in workspace.Map.Ingame:GetChildren() do
													local v100 = v99:IsA("Model")
													if v100 then
														v100 = v99.Name == "SubspaceTripmine" and true or string.match(v99.Name, "TaphTripmine$")
													end
													if v100 then
														local v101 = v99.PrimaryPart or v99:FindFirstChildWhichIsA("BasePart")
														if v101 and (v101.Position - p95.HumanoidRootPart.Position).Magnitude <= 20 then
															v_u_16:IncrementAchievementProgress(p_u_81.Player, "JasonFool")
															break
														end
													end
												end
											end
											if p95.Parent.Name == "Survivors" then
												v_u_7:IncrementActorStats(p_u_81.Player, {
													["Action"] = "Landed Gashing Wound hit",
													["RewardType"] = "RegularKillerAction"
												})
											end
										end
									end
								}
							}
							v93:CreateHitbox(v94, v102)
						end
					end)
				end
				v_u_22(v_u_86, function()
					-- upvalues: (ref) v_u_88, (ref) v_u_41, (copy) p_u_81, (ref) v_u_10, (ref) v_u_15, (ref) v_u_20, (ref) v_u_90, (ref) v_u_8, (ref) v_u_47, (ref) v_u_36
					local v103 = v_u_88 and 4.25 or 0.5
					if v_u_88 then
						v_u_41(p_u_81, "GashingWoundHit")
					else
						v_u_10:RemoveInvincible(p_u_81.Rig, "Gashing")
						v_u_41(p_u_81, "GashingWoundMiss")
					end
					v_u_15:FireClientConnection(p_u_81.Player, ("%*GashingWoundStateAsync"):format(p_u_81.Player.Name), "REMOTE_EVENT", v_u_88 and "HIT" or "NONE")
					v_u_20(v103 - 1.75)
					if v_u_90 then
						v_u_90:Stop(0)
					end
					if v_u_88 and v_u_88.PrimaryPart then
						local v104 = RaycastParams.new()
						v104.FilterDescendantsInstances = workspace.Players:GetDescendants()
						v104.FilterType = Enum.RaycastFilterType.Exclude
						local v105 = workspace:Raycast(p_u_81.Rig.PrimaryPart.Position, p_u_81.Rig.PrimaryPart.CFrame.LookVector * 100, v104)
						local v106
						if v105 then
							local v107 = v105.Distance
							v106 = math.clamp(v107, (-1 / 0), 3) or 3
						else
							v106 = 3
						end
						if v106 < 3 then
							v106 = -(v_u_88.PrimaryPart.Size.Z / 2) - (3 - v106) * 2
						end
						local v108 = p_u_81.Rig.PrimaryPart.CFrame.LookVector * (v106 / 3 * 75)
						v_u_88:PivotTo(p_u_81.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -v106))
						v_u_88.PrimaryPart.Anchored = false
						v_u_88.PrimaryPart.Velocity = v108
						v_u_8.SetProfile(v_u_88, {
							["AnchorDelay"] = true,
							["Velocity"] = v108
						})
						v_u_8.EnableRagdoll(v_u_88, 1.25)
					end
					v_u_20(1)
					v_u_47(p_u_81)
					v_u_36(p_u_81.Behavior, "GashingWoundEnd", p_u_81.Behavior, p_u_81)
					if p_u_81.Rig and p_u_81.Rig.PrimaryPart then
						p_u_81.Rig.PrimaryPart.Anchored = false
					end
					v_u_20(0.5)
					p_u_81.AbilitiesDisabled = false
					v_u_20(0.25)
					v_u_10:RemoveInvincible(p_u_81.Rig, "Gashing")
				end)
			else
				local v109 = v_u_10:CreateSpeedMultiplier(p_u_81.Rig, 1, "BeheadAbility")
				v_u_3:Create(v109, v_u_28, {
					["Value"] = 0.001
				}):Play()
				p_u_81.Instances.GashingWoundSlowness = v109
			end
		end
	},
	["RagingPace"] = {
		["LayoutOrder"] = 3,
		["Icon"] = "rbxassetid://86530225037587",
		["KeybindType"] = "AltAbility3",
		["Callback"] = function(p_u_110)
			-- upvalues: (copy) v_u_25, (copy) v_u_22, (copy) v_u_10, (copy) v_u_36, (copy) v_u_41, (copy) v_u_5, (copy) v_u_20, (copy) v_u_47, (copy) v_u_15, (copy) v_u_3, (copy) v_u_14, (copy) v_u_2, (copy) v_u_11
			if v_u_25 then
				p_u_110.AbilitiesDisabled = true
				v_u_22(p_u_110.Config.EnragedStartup, function()
					-- upvalues: (copy) p_u_110, (ref) v_u_10, (ref) v_u_36, (ref) v_u_41, (ref) v_u_5, (ref) v_u_20, (ref) v_u_47
					p_u_110:ChangeExpression("Enraged")
					p_u_110.State.isEnraged = true
					v_u_10:GiveInvincible(p_u_110.Rig, "Raging")
					v_u_36(p_u_110.Behavior, "EnragedReveal", p_u_110.Behavior, p_u_110)
					p_u_110.Instances.EnragedSFX = v_u_41(p_u_110, "EnragedStart", true)
					v_u_5:AddItem(p_u_110.Instances.EnragedSFX, p_u_110.Config.EnragedTime)
					for _, v111 in p_u_110.Instances.EnragedVisuals do
						v111.Enabled = true
					end
					v_u_20(p_u_110.Config.EnragedTime - p_u_110.Config.EnragedStartup)
					v_u_47(p_u_110)
				end)
				v_u_22(1, function()
					-- upvalues: (copy) p_u_110
					p_u_110.AbilitiesDisabled = false
				end)
			else
				p_u_110.Animations.EnragedStart:Play(0.025)
				p_u_110.AnimationType = "Enraged"
				p_u_110.MovementAnimSpeed = 1.425
				p_u_110.State.isEnraged = true
				v_u_15:FireConnection("DisableSprinting", "ENRAGED", true)
				p_u_110.Instances.SpeedModifier = v_u_10:CreateSpeedMultiplier(p_u_110.Rig, 0.001, "ENRAGED")
				v_u_22(0.75, function()
					-- upvalues: (ref) v_u_3, (copy) p_u_110
					v_u_3:Create(p_u_110.Instances.SpeedModifier, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						["Value"] = p_u_110.Config.EnragedSpeed / p_u_110.Config.Speed
					}):Play()
				end)
				local v112 = v_u_10:GetClosestPlayerFromPosition(p_u_110.Rig.PrimaryPart.Position)
				if v112 then
					p_u_110.Meta.TargetedPlayer = v112
					v_u_10:RevealPlayerAura(v112, p_u_110.Config.EnragedTime + 2)
				end
				for _, v113 in workspace.Players.Survivors:GetChildren() do
					if v_u_14:PlayerHasStatus(v113, "Gouged") then
						v_u_10:RevealPlayerAura(v113, 5)
					end
				end
				v_u_22(1, function()
					-- upvalues: (ref) v_u_2, (copy) p_u_110, (ref) v_u_11
					local v_u_114 = os.clock()
					local v_u_115 = nil
					v_u_115 = v_u_2.Heartbeat:Connect(function(_)
						-- upvalues: (copy) v_u_114, (ref) p_u_110, (ref) v_u_11, (ref) v_u_115
						local v116 = (os.clock() - v_u_114) / p_u_110.Config.EnragedStaminaCapLerpTime
						local v117 = math.clamp(v116, 0, 1)
						v_u_11.StaminaCap = p_u_110.Config.MaxStamina + (p_u_110.Config.EnragedStaminaCap - p_u_110.Config.MaxStamina) * v117
						if v117 >= 1 or not p_u_110.State.isEnraged then
							v_u_115:Disconnect()
							v_u_115 = nil
							v_u_11.StaminaCap = p_u_110.Config.MaxStamina
						end
					end)
					p_u_110.Maid:Add(v_u_115)
				end)
			end
		end
	}
}
v48.Abilities = v118
function v48.Created(_, p_u_119)
	-- upvalues: (copy) v_u_13, (copy) v_u_18, (copy) v_u_25, (copy) v_u_16, (copy) v_u_21, (copy) v_u_10, (copy) v_u_15, (copy) v_u_47, (copy) v_u_22, (copy) v_u_3, (copy) v_u_28, (copy) v_u_5
	p_u_119.Maid = v_u_13.new()
	p_u_119.Meta = {}
	p_u_119.Instances = {}
	p_u_119.State = {}
	p_u_119.NetworkConnections = {}
	p_u_119.ConnectionDictionary = {}
	p_u_119.State.isEnraged = false
	local v120 = {}
	for _, v121 in p_u_119.Rig:GetDescendants() do
		if v121.Name == "RagingPace" then
			v_u_18(v120, v121)
		end
	end
	p_u_119.Instances.EnragedVisuals = v120
	if v_u_25 then
		if workspace:GetAttribute("JasonSpecialDay") then
			v_u_16:IncrementAchievementProgress(p_u_119.Player, "JasonSpecialDay")
		end
		v_u_21(function()
			-- upvalues: (copy) p_u_119, (ref) v_u_10
			p_u_119.Cache.GashingWoundStart = v_u_10:LoadAnimationFromID(p_u_119.Rig, p_u_119.Config.Animations.GashingWoundStart)
			p_u_119.Cache.GashingWound = v_u_10:LoadAnimationFromID(p_u_119.Rig, p_u_119.Config.Animations.GashingWound.KillerRig)
		end)
	else
		v_u_18(p_u_119.NetworkConnections, { ("%*EnrageStateAsync"):format(p_u_119.Player.Name), "REMOTE_EVENT" })
		v_u_15:SetConnection(("%*EnrageStateAsync"):format(p_u_119.Player.Name), "REMOTE_EVENT", function()
			-- upvalues: (ref) v_u_47, (copy) p_u_119
			warn("[Slasher]: EnrageStateAsync was called, resetting enraged state!")
			v_u_47(p_u_119)
		end)
		v_u_18(p_u_119.NetworkConnections, { ("%*GashingWoundStateAsync"):format(p_u_119.Player.Name), "REMOTE_EVENT" })
		v_u_15:SetConnection(("%*GashingWoundStateAsync"):format(p_u_119.Player.Name), "REMOTE_EVENT", function(p122)
			-- upvalues: (copy) p_u_119, (ref) v_u_22, (ref) v_u_3, (ref) v_u_28, (ref) v_u_5
			local v123 = ("GashingWoundStateAsync was called, new state: %*"):format(p122)
			warn((("[Slasher]: %*"):format(v123)))
			local v_u_124 = p_u_119.Instances.GashingWoundSlowness
			v_u_22(p122 == "HIT" and 4.75 or 1, function()
				-- upvalues: (ref) v_u_3, (copy) v_u_124, (ref) v_u_28, (ref) v_u_5
				v_u_3:Create(v_u_124, v_u_28, {
					["Value"] = 1
				}):Play()
				v_u_5:AddItem(v_u_124, 0.2)
			end)
		end)
	end
end
function v48.Destroyed(_, p125)
	-- upvalues: (copy) v_u_25, (copy) v_u_15
	p125.Maid:Destroy()
	local v126 = ("%* | Destroyed Maid!"):format(v_u_25 and "SERVER" or "CLIENT")
	warn((("[Slasher]: %*"):format(v126)))
	for v127, v128 in p125.ConnectionDictionary do
		local v129 = ("%* | Disconnected connection: %*"):format(v_u_25 and "SERVER" or "CLIENT", v128)
		warn((("[Slasher]: %*"):format(v129)))
		v128:Disconnect()
		p125.ConnectionDictionary[v127] = nil
	end
	for v130, v131 in p125.NetworkConnections do
		local v132 = ("%* | Disconnected network connection: %*/%*"):format(v_u_25 and "SERVER" or "CLIENT", v131[2], v131[1])
		warn((("[Slasher]: %*"):format(v132)))
		v_u_15:RemoveConnection(v131[1], v131[2])
		p125.NetworkConnections[v130] = nil
	end
	for _, v133 in p125.Instances do
		if typeof(v133) == "table" then
			for _, v134 in v133 do
				if v134 and v134.Parent then
					local v135 = ("%* | Removed instance reference: %*"):format(v_u_25 and "SERVER" or "CLIENT", v134)
					warn((("[Slasher]: %*"):format(v135)))
					v134:Destroy()
				end
			end
		else
			v133:Destroy()
		end
	end
end
function v48.OnIntroduction(_, _, p136, p137)
	-- upvalues: (copy) v_u_10, (copy) v_u_29, (copy) v_u_22, (copy) v_u_3
	local v138 = script.IntroWideDoor:Clone()
	v138:PivotTo(p136.PrimaryPart.CFrame)
	v138.Parent = p136
	for _, v139 in v138.Joints:GetChildren() do
		v139.Part1 = v138.Parts:FindFirstChild(v139.Name, true)
		v139.Part0 = p136.PrimaryPart
	end
	local v_u_140 = v_u_10:CreateFOVMultiplier(v_u_29, 0.4, "JasonIntroScene", p137)
	v_u_22(0.78, function()
		-- upvalues: (copy) v_u_140, (ref) v_u_3
		v_u_140.Value = 0.35
		v_u_3:Create(v_u_140, TweenInfo.new(2.5, Enum.EasingStyle.Back), {
			["Value"] = 0.45
		}):Play()
	end)
end
function v48.OnVictory(_, p141, p142, _, _)
	-- upvalues: (copy) v_u_29, (copy) v_u_21, (copy) v_u_30, (copy) v_u_20, (copy) v_u_3, (copy) v_u_23, (copy) v_u_9
	if p141 == "Start" then
		local v143 = v_u_29.PlayerGui
		local v144 = Instance.new("ScreenGui")
		v144.Name = "JasonOutroOverlay"
		v144.ResetOnSpawn = false
		v144.IgnoreGuiInset = true
		v144.Parent = v143
		p142.Meta.StartThread = v_u_21(function()
			-- upvalues: (ref) v_u_30, (ref) v_u_29, (ref) v_u_20, (ref) v_u_3
			v_u_30.FieldOfView = 35
			v_u_29:SetAttribute("FOVMultipliersDisabled", true)
			v_u_20(1.53)
			local v145 = Instance.new("ColorCorrectionEffect")
			v145.Name = "JasonOutroCCEffect"
			v145.Parent = game.Lighting
			local v146 = Instance.new("BlurEffect")
			v146.Name = "JasonOutroBlurEffect"
			v146.Parent = game.Lighting
			v_u_3:Create(v146, TweenInfo.new(0.125), {
				["Size"] = 2
			}):Play()
			v_u_3:Create(v_u_30, TweenInfo.new(0.42), {
				["FieldOfView"] = 46
			}):Play()
			v_u_20(0.42)
			v_u_3:Create(v145, TweenInfo.new(0.125, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
				["TintColor"] = Color3.fromRGB(190, 0, 3),
				["Brightness"] = 0.4,
				["Contrast"] = 0.2,
				["Saturation"] = 0.5
			}):Play()
			v_u_3:Create(v146, TweenInfo.new(0.125, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
				["Size"] = 30
			}):Play()
			v_u_3:Create(v_u_30, TweenInfo.new(0.15), {
				["FieldOfView"] = 32
			}):Play()
			v_u_20(0.17)
			v_u_3:Create(v146, TweenInfo.new(0.125), {
				["Size"] = 2
			}):Play()
			v_u_3:Create(v_u_30, TweenInfo.new(0.15), {
				["FieldOfView"] = 35
			}):Play()
			v_u_20(0.35)
			v_u_3:Create(v145, TweenInfo.new(0.125), {
				["TintColor"] = Color3.fromRGB(255, 105, 105),
				["Brightness"] = 0,
				["Contrast"] = 0,
				["Saturation"] = 0
			}):Play()
			v_u_20(0.61)
			v_u_3:Create(v145, TweenInfo.new(0.125), {
				["TintColor"] = Color3.fromRGB(255, 226, 226)
			}):Play()
			v_u_3:Create(v_u_30, TweenInfo.new(0.15), {
				["FieldOfView"] = 32
			}):Play()
			v_u_20(0.29)
			v_u_3:Create(v146, TweenInfo.new(0.125), {
				["Size"] = 1
			}):Play()
			v_u_3:Create(v145, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				["TintColor"] = Color3.fromRGB(255, 255, 255)
			}):Play()
			v_u_3:Create(v_u_30, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				["FieldOfView"] = 55
			}):Play()
		end)
	elseif p141 == "End" then
		local v147 = v_u_29.PlayerGui:FindFirstChild("JasonOutroOverlay")
		if v147 then
			v147:Destroy()
		end
		v_u_29:SetAttribute("FOVMultipliersDisabled", nil)
		if p142 and p142.Meta.StartThread then
			v_u_23(p142.Meta.StartThread)
		end
		v_u_9:SetAsCurrentLighting()
	end
end
function v48.OnExecution(_, p148, p_u_149)
	-- upvalues: (copy) v_u_22, (copy) v_u_8
	if p148.Rig then
		local v150 = p_u_149.Name == "Guest1337"
		local v_u_151 = (v150 and -p148.Rig.PrimaryPart.CFrame.RightVector or p148.Rig.PrimaryPart.CFrame.LookVector) * 100
		v_u_22(v150 and 4.91 or 1.125, function()
			-- upvalues: (ref) v_u_8, (copy) p_u_149, (copy) v_u_151
			local v152 = {
				["Velocity"] = v_u_151
			}
			v_u_8.AddProfile(p_u_149, v152)
			local v153 = p_u_149:FindFirstChildOfClass("Humanoid")
			if v153 then
				v153.BreakJointsOnDeath = false
				v153.Health = 0
			end
		end)
	end
end
return v48
