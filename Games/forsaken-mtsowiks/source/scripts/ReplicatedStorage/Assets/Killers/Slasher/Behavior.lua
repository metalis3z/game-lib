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
local v_u_26 = v_u_2:IsStudio()
local v_u_27 = TweenInfo.new(1)
local v_u_28 = Random.new()
local v_u_29 = TweenInfo.new(0.2)
local v_u_30
if v_u_24 then
	v_u_30 = v4.LocalPlayer
else
	v_u_30 = v_u_24
end
local v_u_31
if v_u_24 then
	v_u_31 = workspace.CurrentCamera
else
	v_u_31 = v_u_24
end
local function v_u_37(p_u_32, p_u_33, ...)
	-- upvalues: (copy) v_u_26
	assert(p_u_32, "bad moduleInfo, must be a table")
	local v34, v35 = pcall(function(...)
		-- upvalues: (copy) p_u_32, (copy) p_u_33
		if p_u_32[p_u_33] then
			return p_u_32[p_u_33](...)
		end
	end, ...)
	if not v34 then
		local v36 = ("Failed to call :%*() due to: %*"):format(p_u_33, v35)
		if v_u_26 then
			warn((("[Slasher]: %*"):format(v36)))
		end
	end
	return v34, v35
end
local function v_u_42(p38, p39, p40)
	-- upvalues: (copy) v_u_6, (copy) v_u_28
	local v41 = p38.Config.Sounds[p39]
	assert(v41, "bad soundName, does not exist")
	return v_u_6:Play(p38.Config.Sounds[p39], {
		["Parent"] = p38.Rig.PrimaryPart,
		["PlaybackSpeed"] = v_u_28:NextNumber(0.975, 1.025),
		["Looped"] = p40 or false,
		["Volume"] = 0.25
	})
end
local function v_u_48(p43)
	-- upvalues: (copy) v_u_25, (copy) v_u_10, (copy) v_u_6, (copy) v_u_37, (copy) v_u_15, (copy) v_u_24, (copy) v_u_3, (copy) v_u_27, (copy) v_u_5, (copy) v_u_11
	local v44 = p43.Rig
	if p43.State.isEnraged and (v44 and v44.Parent) then
		p43.State.isEnraged = false
		if v_u_25 then
			v_u_10:RemoveInvincible(v44, "Raging")
			p43:ChangeExpression("Default")
			local v45 = p43.Instances.EnragedSFX
			if v45 then
				v45:Destroy()
				p43.Instances.EnragedSFX = nil
			end
			v_u_6:Play(p43.Config.Sounds.EnragedEnd, {
				["Parent"] = p43.Rig.PrimaryPart
			})
			for _, v46 in p43.Instances.EnragedVisuals do
				v46.Enabled = false
			end
			v_u_37(p43.Behavior, "EnragedEnd", p43.Behavior, p43)
			v_u_15:FireClientConnection(p43.Player, ("%*EnrageStateAsync"):format(p43.Player.Name), "REMOTE_EVENT")
			return
		end
		if v_u_24 then
			p43.AnimationType = nil
			p43.MovementAnimSpeed = nil
			v_u_15:FireConnection("DisableSprinting", "ENRAGED", false)
			if p43.Meta.TargetedPlayer then
				v_u_10:RevealPlayerAura(p43.TargetedPlayer, p43.Config.EnragedAuraLingerTime)
				p43.Meta.TargetedPlayer = nil
			end
			if p43.Instances.SpeedModifier then
				v_u_3:Create(p43.Instances.SpeedModifier, v_u_27, {
					["Value"] = 1
				}):Play()
				v_u_5:AddItem(p43.Instances.SpeedModifier, 1)
			end
			local v47 = v_u_10:CreateSpeedMultiplier(p43.Rig, 0.001, "Pacified")
			v_u_3:Create(v47, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				["Value"] = 1
			}):Play()
			v_u_5:AddItem(v47, 1)
			v_u_11.StaminaCap = nil
		end
	end
end
local v49 = {}
local v115 = {
	["Slash"] = {
		["LayoutOrder"] = 1,
		["Icon"] = "rbxassetid://97183429269286",
		["KeybindType"] = "MainAbility",
		["Cooldown"] = function(p50, p51)
			return p50.State.isEnraged and p50.Config[("Enraged%*Cooldown"):format(p51)] or p50.Config[("%*Cooldown"):format(p51)]
		end,
		["Callback"] = function(p_u_52)
			-- upvalues: (copy) v_u_25, (copy) v_u_42, (copy) v_u_22, (copy) v_u_10, (copy) v_u_3, (copy) v_u_27, (copy) v_u_5, (copy) v_u_20, (copy) v_u_48, (copy) v_u_12, (copy) v_u_14, (copy) v_u_37, (copy) v_u_24
			if v_u_25 then
				local v_u_53 = p_u_52.Rig
				p_u_52.AbilitiesDisabled = true
				v_u_42(p_u_52, "Swing")
				local _ = p_u_52.State.isEnraged
				if not (p_u_52.State.isEnraged and p_u_52.Config.EnragedSlashDamage) then
					local _ = p_u_52.Config.SlashDamage
				end
				v_u_22(0.075, function()
					-- upvalues: (copy) p_u_52, (ref) v_u_10, (copy) v_u_53, (ref) v_u_3, (ref) v_u_27, (ref) v_u_5, (ref) v_u_20, (ref) v_u_48
					if p_u_52.State.isEnraged then
						local v54 = v_u_10:ApplyVelocity(v_u_53.PrimaryPart, p_u_52.Config.EnragedSlashLungeForce)
						v_u_3:Create(v54, v_u_27, {
							["LineVelocity"] = v54.LineVelocity / 100
						}):Play()
						v_u_5:AddItem(v54, 0.6)
					end
					v_u_20(0.5)
					v_u_48(p_u_52)
					v_u_20(0.275)
					p_u_52.AbilitiesDisabled = false
				end)
				v_u_22(p_u_52.Config.SlashWindup, function()
					-- upvalues: (ref) v_u_12, (copy) p_u_52, (ref) v_u_10, (ref) v_u_14, (ref) v_u_37, (ref) v_u_42
					local v55 = v_u_12
					local v56 = p_u_52.Player
					local v57 = {
						["Size"] = Vector3.new(4.5, 6, 7.5),
						["CFrameOffset"] = CFrame.new(0, 0, -1.25)
					}
					local v58 = p_u_52
					v57.Damage = v58.State.isEnraged and v58.Config.EnragedSlashDamage or v58.Config.SlashDamage
					v57.Time = p_u_52.Config.SlashLinger
					v57.Knockback = 2
					v57.HitMultiple = true
					v57.ExecuteOnKill = true
					v57.Connections = {
						["Hit"] = function(p59, p60)
							-- upvalues: (ref) v_u_10, (ref) v_u_14, (ref) v_u_37, (ref) p_u_52, (ref) v_u_42
							v_u_10:CreateSpeedMultiplier(p59, 1.5, "HitSpeedBonus", 1.25)
							v_u_14:ApplyStatus(p59, "Bleeding", {
								["Level"] = 1,
								["Duration"] = 5
							})
							if p60 then
								v_u_37(p_u_52.Behavior, "OnSlashHit", p_u_52.Behavior, p59)
								v_u_42(p_u_52, "Hit")
							end
						end
					}
					v55:CreateHitbox(v56, v57)
				end)
			elseif v_u_24 then
				p_u_52.Animations.Slash:Play(0.025)
			end
		end
	},
	["Behead"] = {
		["LayoutOrder"] = 2,
		["Icon"] = "rbxassetid://115283980500353",
		["KeybindType"] = "AltAbility1",
		["Cooldown"] = function(p61, p62)
			return p61.State.isEnraged and p61.Config[("Enraged%*Cooldown"):format(p62)] or p61.Config[("%*Cooldown"):format(p62)]
		end,
		["Callback"] = function(p_u_63)
			-- upvalues: (copy) v_u_25, (copy) v_u_42, (copy) v_u_22, (copy) v_u_12, (copy) v_u_17, (copy) v_u_16, (copy) v_u_7, (copy) v_u_10, (copy) v_u_14, (copy) v_u_48, (copy) v_u_20, (copy) v_u_24, (copy) v_u_3, (copy) v_u_5
			if v_u_25 then
				local v_u_64 = p_u_63.Rig
				p_u_63.AbilitiesDisabled = true
				v_u_42(p_u_63, "Swing")
				v_u_22(p_u_63.Config.BeheadWindup, function()
					-- upvalues: (ref) v_u_12, (copy) p_u_63, (ref) v_u_17, (ref) v_u_16, (ref) v_u_7, (ref) v_u_10, (ref) v_u_14, (ref) v_u_42, (ref) v_u_48, (ref) v_u_20, (copy) v_u_64
					local v65 = v_u_12
					local v66 = p_u_63.Player
					local v67 = {
						["Size"] = Vector3.new(8, 2, 7),
						["CFrameOffset"] = CFrame.new(0, 0, -2)
					}
					local v68 = p_u_63
					v67.Damage = v68.State.isEnraged and v68.Config.EnragedBeheadDamage or v68.Config.BeheadDamage
					v67.Time = p_u_63.Config.BeheadLinger
					v67.Knockback = 2
					v67.HitMultiple = true
					v67.Connections = {
						["Hit"] = function(p69, p70)
							-- upvalues: (ref) v_u_17, (ref) v_u_16, (ref) p_u_63, (ref) v_u_7, (ref) v_u_10, (ref) v_u_14, (ref) v_u_42, (ref) v_u_48
							local v71 = p69:FindFirstChildOfClass("Humanoid")
							if v71 and v71.Health <= 0 then
								local v72 = p69:FindFirstChild("Torso") and p69:FindFirstChild("Head")
								if v72 then
									v72 = p69.Torso:FindFirstChild("Neck")
								end
								if v72 then
									v72.Enabled = false
									p69.Head.CanCollide = true
									local v73 = p69.Head
									local v74 = v_u_17(-9, 9)
									local v75 = v_u_17
									v73.Velocity = Vector3.new(v74, 35, v75(-9, 9))
								end
								v_u_16:IncrementAchievementProgress(p_u_63.Player, "JasonBrutality")
								if p69.Parent.Name == "Survivors" then
									v_u_7:IncrementActorStats(p_u_63.Player, {
										["Action"] = "Killed a Survivor with Behead",
										["RewardType"] = "DifficultKillerAction"
									})
								end
							else
								v_u_10:CreateSpeedMultiplier(p69, 1.5, "HitSpeedBonus", 0.9)
								v_u_14:ApplyStatus(p69, "Helpless", {
									["Level"] = 1,
									["Duration"] = 8
								})
								if p69.Parent.Name == "Survivors" then
									v_u_7:IncrementActorStats(p_u_63.Player, {
										["Action"] = "Landed Behead hit",
										["RewardType"] = "EasyKillerAction"
									})
								end
							end
							if p70 then
								v_u_42(p_u_63, "Hit")
								v_u_48(p_u_63)
							end
						end
					}
					v65:CreateHitbox(v66, v67)
					v_u_20(0.2)
					v_u_48(p_u_63)
					v_u_14:ApplyStatus(v_u_64, "Slowness", {
						["Level"] = 1,
						["Duration"] = 2
					})
					v_u_20(1.1)
					p_u_63.AbilitiesDisabled = false
				end)
			elseif v_u_24 then
				p_u_63.Animations.Behead:Play(0.025)
				local v_u_76 = v_u_10:CreateSpeedMultiplier(p_u_63.Rig, 1, "BeheadAbility")
				v_u_3:Create(v_u_76, TweenInfo.new(0.125), {
					["Value"] = p_u_63.State.isEnraged and p_u_63.Config.EnragedBeheadLunge or p_u_63.Config.BeheadLunge
				}):Play()
				v_u_22(0.4, function()
					-- upvalues: (ref) v_u_3, (copy) v_u_76, (ref) v_u_20, (ref) v_u_5
					v_u_3:Create(v_u_76, TweenInfo.new(0.3), {
						["Value"] = 0.2
					}):Play()
					v_u_20(0.6)
					v_u_3:Create(v_u_76, TweenInfo.new(0.3), {
						["Value"] = 1
					}):Play()
					v_u_5:AddItem(v_u_76, 0.3)
				end)
			end
		end
	},
	["GashingWound"] = {
		["LayoutOrder"] = 3,
		["Icon"] = "rbxassetid://96900331272883",
		["KeybindType"] = "AltAbility2",
		["Cooldown"] = function(p77, p78)
			return p77.State.isEnraged and p77.Config[("Enraged%*Cooldown"):format(p78)] or p77.Config[("%*Cooldown"):format(p78)]
		end,
		["Callback"] = function(p_u_79)
			-- upvalues: (copy) v_u_25, (copy) v_u_42, (copy) v_u_18, (copy) v_u_19, (copy) v_u_22, (copy) v_u_12, (copy) v_u_10, (copy) v_u_8, (copy) v_u_37, (copy) v_u_6, (copy) v_u_16, (copy) v_u_7, (copy) v_u_15, (copy) v_u_20, (copy) v_u_48, (copy) v_u_3, (copy) v_u_29
			if v_u_25 then
				p_u_79.AbilitiesDisabled = true
				p_u_79.Cache.GashingWoundStart:Play(0.05)
				v_u_42(p_u_79, "GashingWoundSwing")
				local v_u_80 = p_u_79.State.isEnraged and p_u_79.Config.EnragedGashingWoundDamage or p_u_79.Config.GashingWoundDamage
				local v81 = p_u_79.Config.GashingWoundHitData()
				local v82 = {}
				for v83, _ in pairs(v81) do
					v_u_18(v82, v83)
				end
				v_u_19(v82)
				local v_u_84 = v82[1] + 0.166
				os.clock()
				local v_u_85 = nil
				local v_u_86 = nil
				for v_u_87, v_u_88 in v81 do
					v_u_22(v_u_87, function()
						-- upvalues: (copy) v_u_87, (copy) v_u_84, (ref) v_u_86, (ref) v_u_12, (copy) p_u_79, (copy) v_u_80, (copy) v_u_88, (ref) v_u_42, (ref) v_u_10, (ref) v_u_8, (ref) v_u_37, (ref) v_u_85, (ref) v_u_6, (ref) v_u_16, (ref) v_u_7
						if v_u_84 > v_u_87 or v_u_86 then
							local v89 = v_u_12
							local v90 = p_u_79.Player
							local v98 = {
								["Size"] = Vector3.new(8, 4, 8),
								["CFrameOffset"] = CFrame.new(0, 0, -2.25),
								["Damage"] = v_u_80 / v_u_88.DamageDivisor,
								["Time"] = v_u_88.Time,
								["Knockback"] = 0,
								["HitMultiple"] = true,
								["Connections"] = {
									["Hit"] = function(p91, p92)
										-- upvalues: (ref) v_u_42, (ref) p_u_79, (ref) v_u_87, (ref) v_u_86, (ref) v_u_10, (ref) v_u_8, (ref) v_u_37, (ref) v_u_85, (ref) v_u_6, (ref) v_u_16, (ref) v_u_7
										if p92 then
											v_u_42(p_u_79, "Hit")
										end
										if v_u_87 <= 0.5 and not v_u_86 then
											local v93, _ = v_u_10:GetEntityType(p91)
											if not v93 then
												return
											end
											v_u_8.SetProfile(p91, {
												["AnchorDelay"] = true,
												["Applied"] = os.clock() + 10
											})
											v_u_86 = p91
											v_u_37(p_u_79.Behavior, "GashingWoundStart", p_u_79.Behavior, p_u_79)
											v_u_10:SetUpCutscene(p_u_79.Rig, p91)
											v_u_10:GiveInvincible(p_u_79.Rig, "Gashing")
											local v94 = p_u_79.Cache.GashingWound
											v94:Play(0)
											v94.TimePosition = p_u_79.Cache.GashingWoundStart.TimePosition
											v_u_85 = v_u_10:LoadAnimationFromID(p91, p_u_79.Config.Animations.GashingWound.PlayerRig, true)
											v_u_85:Play(0.05)
											v_u_85.TimePosition = p_u_79.Cache.GashingWoundStart.TimePosition
											p_u_79.Cache.GashingWoundStart:Stop(0)
											v_u_6:PlayVoiceline(p_u_79, "GashingWoundHit", {
												["Priority"] = 2
											})
											if p91.Humanoid.Health <= 0 then
												for _, v95 in workspace.Map.Ingame:GetChildren() do
													local v96 = v95:IsA("Model")
													if v96 then
														v96 = v95.Name == "SubspaceTripmine" and true or string.match(v95.Name, "TaphTripmine$")
													end
													if v96 then
														local v97 = v95.PrimaryPart or v95:FindFirstChildWhichIsA("BasePart")
														if v97 and (v97.Position - p91.HumanoidRootPart.Position).Magnitude <= 20 then
															v_u_16:IncrementAchievementProgress(p_u_79.Player, "JasonFool")
															break
														end
													end
												end
											end
											if p91.Parent.Name == "Survivors" then
												v_u_7:IncrementActorStats(p_u_79.Player, {
													["Action"] = "Landed Gashing Wound hit",
													["RewardType"] = "RegularKillerAction"
												})
											end
										end
									end
								}
							}
							v89:CreateHitbox(v90, v98)
						end
					end)
				end
				v_u_22(v_u_84, function()
					-- upvalues: (ref) v_u_86, (ref) v_u_42, (copy) p_u_79, (ref) v_u_10, (ref) v_u_15, (ref) v_u_20, (ref) v_u_85, (ref) v_u_8, (ref) v_u_48, (ref) v_u_37
					local v99 = v_u_86 and 4.25 or 0.5
					if v_u_86 then
						v_u_42(p_u_79, "GashingWoundHit")
					else
						v_u_10:RemoveInvincible(p_u_79.Rig, "Gashing")
						v_u_42(p_u_79, "GashingWoundMiss")
					end
					v_u_15:FireClientConnection(p_u_79.Player, ("%*GashingWoundStateAsync"):format(p_u_79.Player.Name), "REMOTE_EVENT", v_u_86 and "HIT" or "NONE")
					v_u_20(v99 - 1.75)
					if v_u_85 then
						v_u_85:Stop(0)
					end
					if v_u_86 and v_u_86.PrimaryPart then
						local v100 = RaycastParams.new()
						v100.FilterDescendantsInstances = workspace.Players:GetDescendants()
						v100.FilterType = Enum.RaycastFilterType.Exclude
						local v101 = workspace:Raycast(p_u_79.Rig.PrimaryPart.Position, p_u_79.Rig.PrimaryPart.CFrame.LookVector * 100, v100)
						local v102
						if v101 then
							local v103 = v101.Distance
							v102 = math.clamp(v103, (-1 / 0), 3) or 3
						else
							v102 = 3
						end
						if v102 < 3 then
							v102 = -(v_u_86.PrimaryPart.Size.Z / 2) - (3 - v102) * 2
						end
						local v104 = p_u_79.Rig.PrimaryPart.CFrame.LookVector * (v102 / 3 * 75)
						v_u_86:PivotTo(p_u_79.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, 1))
						v_u_86.PrimaryPart.Anchored = false
						v_u_86.PrimaryPart.Velocity = v104
						v_u_8.SetProfile(v_u_86, {
							["AnchorDelay"] = true,
							["Velocity"] = v104
						})
						v_u_8.EnableRagdoll(v_u_86, 1.25)
					end
					v_u_20(1)
					v_u_48(p_u_79)
					v_u_37(p_u_79.Behavior, "GashingWoundEnd", p_u_79.Behavior, p_u_79)
					if p_u_79.Rig and p_u_79.Rig.PrimaryPart then
						p_u_79.Rig.PrimaryPart.Anchored = false
					end
					v_u_20(0.5)
					p_u_79.AbilitiesDisabled = false
					v_u_20(0.25)
					v_u_10:RemoveInvincible(p_u_79.Rig, "Gashing")
				end)
			else
				local v105 = v_u_10:CreateSpeedMultiplier(p_u_79.Rig, 1, "BeheadAbility")
				v_u_3:Create(v105, v_u_29, {
					["Value"] = 0.001
				}):Play()
				p_u_79.Instances.GashingWoundSlowness = v105
			end
		end
	},
	["RagingPace"] = {
		["LayoutOrder"] = 3,
		["Icon"] = "rbxassetid://86530225037587",
		["KeybindType"] = "AltAbility3",
		["Callback"] = function(p_u_106)
			-- upvalues: (copy) v_u_25, (copy) v_u_22, (copy) v_u_10, (copy) v_u_37, (copy) v_u_42, (copy) v_u_5, (copy) v_u_20, (copy) v_u_48, (copy) v_u_15, (copy) v_u_3, (copy) v_u_2, (copy) v_u_11
			if v_u_25 then
				p_u_106.AbilitiesDisabled = true
				v_u_22(p_u_106.Config.EnragedStartup, function()
					-- upvalues: (copy) p_u_106, (ref) v_u_10, (ref) v_u_37, (ref) v_u_42, (ref) v_u_5, (ref) v_u_20, (ref) v_u_48
					p_u_106:ChangeExpression("Enraged")
					p_u_106.State.isEnraged = true
					v_u_10:GiveInvincible(p_u_106.Rig, "Raging")
					v_u_37(p_u_106.Behavior, "EnragedReveal", p_u_106.Behavior, p_u_106)
					p_u_106.Instances.EnragedSFX = v_u_42(p_u_106, "EnragedStart", false)
					v_u_5:AddItem(p_u_106.Instances.EnragedSFX, p_u_106.Config.EnragedTime)
					for _, v107 in p_u_106.Instances.EnragedVisuals do
						v107.Enabled = true
					end
					v_u_20(p_u_106.Config.EnragedTime - p_u_106.Config.EnragedStartup)
					v_u_48(p_u_106)
				end)
				v_u_22(1, function()
					-- upvalues: (copy) p_u_106
					p_u_106.AbilitiesDisabled = false
				end)
			else
				p_u_106.Animations.EnragedStart:Play(0.025)
				p_u_106.AnimationType = "Enraged"
				p_u_106.MovementAnimSpeed = 1.425
				p_u_106.State.isEnraged = true
				v_u_15:FireConnection("DisableSprinting", "ENRAGED", true)
				local v_u_108 = v_u_10:CreateFOVMultiplier(p_u_106.Player, 1, "RagingZoom")
				game.TweenService:Create(v_u_108, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0), {
					["Value"] = 0.925
				}):Play()
				p_u_106.Instances.SpeedModifier = v_u_10:CreateSpeedMultiplier(p_u_106.Rig, 1, "ENRAGED")
				v_u_3:Create(p_u_106.Instances.SpeedModifier, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					["Value"] = 0.1
				}):Play()
				v_u_22(0.5, function()
					-- upvalues: (ref) v_u_3, (copy) p_u_106
					v_u_3:Create(p_u_106.Instances.SpeedModifier, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						["Value"] = p_u_106.Config.EnragedSpeed / p_u_106.Config.Speed
					}):Play()
				end)
				local v109 = v_u_10:GetClosestPlayerFromPosition(p_u_106.Rig.PrimaryPart.Position)
				if v109 then
					p_u_106.Meta.TargetedPlayer = v109
					v_u_10:RevealPlayerAura(v109, p_u_106.Config.EnragedTime + 2)
				end
				if not v_u_10:GetSettingValue("EpilepsyMode") then
					local v_u_110 = Instance.new("ColorCorrectionEffect")
					v_u_110.Parent = game.Lighting
					v_u_110.Name = "SlasherEvil"
					v_u_110.Brightness = 0
					v_u_110.Contrast = 0
					v_u_110.Saturation = 0
					v_u_110.TintColor = Color3.fromRGB(255, 255, 255)
					v_u_110.Enabled = true
					game:GetService("Debris"):AddItem(v_u_110, 4)
					game.TweenService:Create(v_u_110, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						["TintColor"] = Color3.new(1, 0.894118, 0.894118)
					}):Play()
					game.TweenService:Create(v_u_110, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						["Contrast"] = 0.05
					}):Play()
					game.TweenService:Create(v_u_110, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						["Saturation"] = 0.1
					}):Play()
					task.delay(0.45, function()
						-- upvalues: (copy) v_u_110
						game.TweenService:Create(v_u_110, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
							["TintColor"] = Color3.new(1, 0.6, 0.6)
						}):Play()
						game.TweenService:Create(v_u_110, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
							["Contrast"] = 0.25
						}):Play()
						game.TweenService:Create(v_u_110, TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
							["Saturation"] = 0.5
						}):Play()
					end)
					task.delay(0.55, function()
						-- upvalues: (copy) v_u_110
						game.TweenService:Create(v_u_110, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
							["Contrast"] = 0
						}):Play()
						game.TweenService:Create(v_u_110, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
							["Saturation"] = 0
						}):Play()
						game.TweenService:Create(v_u_110, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
							["TintColor"] = Color3.new(1, 1, 1)
						}):Play()
					end)
				end
				v_u_22(0.5, function()
					-- upvalues: (copy) v_u_108
					game.TweenService:Create(v_u_108, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0), {
						["Value"] = 1
					}):Play()
				end)
				v_u_22(1, function()
					-- upvalues: (copy) v_u_108, (ref) v_u_2, (copy) p_u_106, (ref) v_u_11
					game.Debris:AddItem(v_u_108, 1)
					local v_u_111 = os.clock()
					local v_u_112 = nil
					v_u_112 = v_u_2.Heartbeat:Connect(function(_)
						-- upvalues: (copy) v_u_111, (ref) p_u_106, (ref) v_u_11, (ref) v_u_112
						local v113 = (os.clock() - v_u_111) / p_u_106.Config.EnragedStaminaCapLerpTime
						local v114 = math.clamp(v113, 0, 1)
						v_u_11.StaminaCap = p_u_106.Config.MaxStamina + (p_u_106.Config.EnragedStaminaCap - p_u_106.Config.MaxStamina) * v114
						if not p_u_106.State.isEnraged then
							v_u_112:Disconnect()
							v_u_112 = nil
							v_u_11.StaminaCap = p_u_106.Config.MaxStamina
						end
					end)
					p_u_106.Maid:Add(v_u_112)
				end)
			end
		end
	}
}
v49.Abilities = v115
function v49.Created(_, p_u_116)
	-- upvalues: (copy) v_u_13, (copy) v_u_18, (copy) v_u_25, (copy) v_u_16, (copy) v_u_21, (copy) v_u_10, (copy) v_u_15, (copy) v_u_26, (copy) v_u_48, (copy) v_u_22, (copy) v_u_3, (copy) v_u_29, (copy) v_u_5
	p_u_116.Maid = v_u_13.new()
	p_u_116.Meta = {}
	p_u_116.Instances = {}
	p_u_116.State = {}
	p_u_116.NetworkConnections = {}
	p_u_116.ConnectionDictionary = {}
	p_u_116.State.isEnraged = false
	local v117 = {}
	for _, v118 in p_u_116.Rig:GetDescendants() do
		if v118.Name == "RagingPace" then
			v_u_18(v117, v118)
		end
	end
	p_u_116.Instances.EnragedVisuals = v117
	if v_u_25 then
		if workspace:GetAttribute("JasonSpecialDay") then
			v_u_16:IncrementAchievementProgress(p_u_116.Player, "JasonSpecialDay")
		end
		v_u_21(function()
			-- upvalues: (copy) p_u_116, (ref) v_u_10
			p_u_116.Cache.GashingWoundStart = v_u_10:LoadAnimationFromID(p_u_116.Rig, p_u_116.Config.Animations.GashingWoundStart)
			p_u_116.Cache.GashingWound = v_u_10:LoadAnimationFromID(p_u_116.Rig, p_u_116.Config.Animations.GashingWound.KillerRig)
		end)
	else
		v_u_18(p_u_116.NetworkConnections, { ("%*EnrageStateAsync"):format(p_u_116.Player.Name), "REMOTE_EVENT" })
		v_u_15:SetConnection(("%*EnrageStateAsync"):format(p_u_116.Player.Name), "REMOTE_EVENT", function()
			-- upvalues: (ref) v_u_26, (ref) v_u_48, (copy) p_u_116
			if v_u_26 then
				warn("[Slasher]: EnrageStateAsync was called, resetting enraged state!")
			end
			v_u_48(p_u_116)
		end)
		v_u_18(p_u_116.NetworkConnections, { ("%*GashingWoundStateAsync"):format(p_u_116.Player.Name), "REMOTE_EVENT" })
		v_u_15:SetConnection(("%*GashingWoundStateAsync"):format(p_u_116.Player.Name), "REMOTE_EVENT", function(p119)
			-- upvalues: (ref) v_u_26, (copy) p_u_116, (ref) v_u_22, (ref) v_u_3, (ref) v_u_29, (ref) v_u_5
			local v120 = ("GashingWoundStateAsync was called, new state: %*"):format(p119)
			if v_u_26 then
				warn((("[Slasher]: %*"):format(v120)))
			end
			local v_u_121 = p_u_116.Instances.GashingWoundSlowness
			v_u_22(p119 == "HIT" and 4.75 or 1, function()
				-- upvalues: (ref) v_u_3, (copy) v_u_121, (ref) v_u_29, (ref) v_u_5
				v_u_3:Create(v_u_121, v_u_29, {
					["Value"] = 1
				}):Play()
				v_u_5:AddItem(v_u_121, 0.2)
			end)
		end)
	end
end
function v49.Destroyed(_, p122)
	-- upvalues: (copy) v_u_25, (copy) v_u_26, (copy) v_u_15
	p122.Maid:Destroy()
	local v123 = ("%* | Destroyed Maid!"):format(v_u_25 and "SERVER" or "CLIENT")
	if v_u_26 then
		warn((("[Slasher]: %*"):format(v123)))
	end
	for v124, v125 in p122.ConnectionDictionary do
		local v126 = ("%* | Disconnected connection: %*"):format(v_u_25 and "SERVER" or "CLIENT", v125)
		if v_u_26 then
			warn((("[Slasher]: %*"):format(v126)))
		end
		v125:Disconnect()
		p122.ConnectionDictionary[v124] = nil
	end
	for v127, v128 in p122.NetworkConnections do
		local v129 = ("%* | Disconnected network connection: %*/%*"):format(v_u_25 and "SERVER" or "CLIENT", v128[2], v128[1])
		if v_u_26 then
			warn((("[Slasher]: %*"):format(v129)))
		end
		v_u_15:RemoveConnection(v128[1], v128[2])
		p122.NetworkConnections[v127] = nil
	end
	for _, v130 in p122.Instances do
		if typeof(v130) == "table" then
			for _, v131 in v130 do
				if v131 and v131.Parent then
					local v132 = ("%* | Removed instance reference: %*"):format(v_u_25 and "SERVER" or "CLIENT", v131)
					if v_u_26 then
						warn((("[Slasher]: %*"):format(v132)))
					end
					v131:Destroy()
				end
			end
		else
			v130:Destroy()
		end
	end
end
function v49.OnIntroduction(_, _, p133, p134)
	-- upvalues: (copy) v_u_10, (copy) v_u_30, (copy) v_u_22, (copy) v_u_3
	local v135 = script.IntroWideDoor:Clone()
	v135:PivotTo(p133.PrimaryPart.CFrame)
	v135.Parent = p133
	for _, v136 in v135.Joints:GetChildren() do
		v136.Part1 = v135.Parts:FindFirstChild(v136.Name, true)
		v136.Part0 = p133.PrimaryPart
	end
	local v_u_137 = v_u_10:CreateFOVMultiplier(v_u_30, 0.4, "JasonIntroScene", p134)
	v_u_22(0.78, function()
		-- upvalues: (copy) v_u_137, (ref) v_u_3
		v_u_137.Value = 0.35
		v_u_3:Create(v_u_137, TweenInfo.new(2.5, Enum.EasingStyle.Back), {
			["Value"] = 0.45
		}):Play()
	end)
end
function v49.OnVictory(_, p138, p139, _, _)
	-- upvalues: (copy) v_u_30, (copy) v_u_21, (copy) v_u_31, (copy) v_u_20, (copy) v_u_3, (copy) v_u_23, (copy) v_u_9
	if p138 == "Start" then
		local v140 = v_u_30.PlayerGui
		local v141 = Instance.new("ScreenGui")
		v141.Name = "JasonOutroOverlay"
		v141.ResetOnSpawn = false
		v141.IgnoreGuiInset = true
		v141.Parent = v140
		p139.Meta.StartThread = v_u_21(function()
			-- upvalues: (ref) v_u_31, (ref) v_u_30, (ref) v_u_20, (ref) v_u_3
			v_u_31.FieldOfView = 35
			v_u_30:SetAttribute("FOVMultipliersDisabled", true)
			v_u_20(1.53)
			local v142 = Instance.new("ColorCorrectionEffect")
			v142.Name = "JasonOutroCCEffect"
			v142.Parent = game.Lighting
			local v143 = Instance.new("BlurEffect")
			v143.Name = "JasonOutroBlurEffect"
			v143.Parent = game.Lighting
			v_u_3:Create(v143, TweenInfo.new(0.125), {
				["Size"] = 2
			}):Play()
			v_u_3:Create(v_u_31, TweenInfo.new(0.42), {
				["FieldOfView"] = 46
			}):Play()
			v_u_20(0.42)
			v_u_3:Create(v142, TweenInfo.new(0.125, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
				["TintColor"] = Color3.fromRGB(190, 0, 3),
				["Brightness"] = 0.4,
				["Contrast"] = 0.2,
				["Saturation"] = 0.5
			}):Play()
			v_u_3:Create(v143, TweenInfo.new(0.125, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
				["Size"] = 30
			}):Play()
			v_u_3:Create(v_u_31, TweenInfo.new(0.15), {
				["FieldOfView"] = 32
			}):Play()
			v_u_20(0.17)
			v_u_3:Create(v143, TweenInfo.new(0.125), {
				["Size"] = 2
			}):Play()
			v_u_3:Create(v_u_31, TweenInfo.new(0.15), {
				["FieldOfView"] = 35
			}):Play()
			v_u_20(0.35)
			v_u_3:Create(v142, TweenInfo.new(0.125), {
				["TintColor"] = Color3.fromRGB(255, 105, 105),
				["Brightness"] = 0,
				["Contrast"] = 0,
				["Saturation"] = 0
			}):Play()
			v_u_20(0.61)
			v_u_3:Create(v142, TweenInfo.new(0.125), {
				["TintColor"] = Color3.fromRGB(255, 226, 226)
			}):Play()
			v_u_3:Create(v_u_31, TweenInfo.new(0.15), {
				["FieldOfView"] = 32
			}):Play()
			v_u_20(0.29)
			v_u_3:Create(v143, TweenInfo.new(0.125), {
				["Size"] = 1
			}):Play()
			v_u_3:Create(v142, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				["TintColor"] = Color3.fromRGB(255, 255, 255)
			}):Play()
			v_u_3:Create(v_u_31, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				["FieldOfView"] = 55
			}):Play()
		end)
	elseif p138 == "End" then
		local v144 = v_u_30.PlayerGui:FindFirstChild("JasonOutroOverlay")
		if v144 then
			v144:Destroy()
		end
		v_u_30:SetAttribute("FOVMultipliersDisabled", nil)
		if p139 and p139.Meta.StartThread then
			v_u_23(p139.Meta.StartThread)
		end
		v_u_9:SetAsCurrentLighting()
	end
end
function v49.OnExecution(_, p145, p_u_146)
	-- upvalues: (copy) v_u_22, (copy) v_u_8
	if p145.Rig then
		local v147 = p_u_146.Name == "Guest1337"
		local v_u_148 = (v147 and -p145.Rig.PrimaryPart.CFrame.RightVector or p145.Rig.PrimaryPart.CFrame.LookVector) * 100
		v_u_22(v147 and 4.91 or 1.125, function()
			-- upvalues: (ref) v_u_8, (copy) p_u_146, (copy) v_u_148
			local v149 = {
				["Velocity"] = v_u_148
			}
			v_u_8.AddProfile(p_u_146, v149)
			local v150 = p_u_146:FindFirstChildOfClass("Humanoid")
			if v150 then
				v150.BreakJointsOnDeath = false
				v150.Health = 0
			end
		end)
	end
end
return v49
