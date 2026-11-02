-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {}
local v_u_2 = require(game.ReplicatedStorage.Modules.Sounds)
local v_u_3 = require(game.ReplicatedStorage.Modules.Util)
local v_u_4 = require(game.ReplicatedStorage.Modules.Hitboxes)
local v_u_5 = require(game.ReplicatedStorage.Modules.Statuses)
local v_u_6 = require(game.ReplicatedStorage.Modules.Network)
require(game.ReplicatedStorage.Modules.AchievementUtil)
local v28 = {
	["Combo"] = {
		["LayoutOrder"] = 1,
		["Icon"] = "rbxassetid://132724488499212",
		["KeybindType"] = "AltAbility2",
		["Cooldown"] = 5,
		["Callback"] = function(p_u_7)
			-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_3
			if game["Run Service"]:IsServer() then
				p_u_7.AbilitiesDisabled = true
				p_u_7.Cache.GashingWoundStart:Play(0.05)
				task.delay(0.2, function()
					-- upvalues: (ref) v_u_2, (copy) p_u_7
					v_u_2:Play(p_u_7.Config.Sounds.GashingWoundSwing, {
						["Parent"] = p_u_7.Rig.PrimaryPart,
						["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
						["Volume"] = 0.25
					})
				end)
				tick()
				local v_u_8 = nil
				local v_u_9 = nil
				for v_u_10, v_u_11 in pairs({
					[0.383] = {
						["Damage"] = 10,
						["Time"] = 0.15,
						["DoLunge"] = true
					},
					[1.083] = {
						["Damage"] = 35,
						["Time"] = 0.15,
						["DoLunge"] = true
					},
					[1.717] = {
						["Damage"] = 55,
						["Time"] = 0.15,
						["DoLunge"] = true
					}
				}) do
					task.delay(v_u_10, function()
						-- upvalues: (copy) v_u_10, (ref) v_u_8, (copy) v_u_11, (ref) v_u_4, (copy) p_u_7, (ref) v_u_9, (ref) v_u_3, (ref) v_u_2
						if v_u_10 < 0.4 or v_u_8 then
							local _ = v_u_11.DoLunge
							v_u_4:CreateHitbox(p_u_7.Player, {
								["Size"] = Vector3.new(8, 4, 8),
								["CFrameOffset"] = CFrame.new(0, 0, -2.25),
								["Damage"] = v_u_11.Damage,
								["Time"] = v_u_11.Time,
								["Knockback"] = 0,
								["HitMultiple"] = true,
								["Connections"] = {
									["Hit"] = function(p_u_12, _)
										-- upvalues: (ref) v_u_10, (ref) v_u_8, (ref) p_u_7, (ref) v_u_9, (ref) v_u_3, (ref) v_u_2
										if v_u_10 <= 0.39 and not v_u_8 then
											v_u_8 = p_u_12
											v_u_8:SetPrimaryPartCFrame(p_u_7.Rig.PrimaryPart.CFrame)
											v_u_8.PrimaryPart.Anchored = true
											p_u_7.Rig.PrimaryPart.Anchored = true
											local v13 = p_u_7.Cache.GashingWound
											v13:Play(0)
											v13.TimePosition = p_u_7.Cache.GashingWoundStart.TimePosition
											v_u_9 = v_u_3:LoadAnimationFromID(v_u_8, p_u_7.Config.Animations.GashingWound.PlayerRig, true)
											v_u_9:Play(0.05)
											v_u_9.TimePosition = p_u_7.Cache.GashingWoundStart.TimePosition
											p_u_7.Cache.GashingWoundStart:Stop(0)
											v_u_2:Play(p_u_7.Config.Sounds.GashingWoundHit1, {
												["Parent"] = p_u_7.Rig.PrimaryPart
											})
											task.delay(0.7, function()
												-- upvalues: (ref) v_u_2, (ref) p_u_7
												v_u_2:Play(p_u_7.Config.Sounds.GashingWoundHit2, {
													["Parent"] = p_u_7.Rig.PrimaryPart
												})
											end)
											task.delay(1.334, function()
												-- upvalues: (ref) v_u_2, (ref) p_u_7
												v_u_2:Play(p_u_7.Config.Sounds.GashingWoundHit3, {
													["Parent"] = p_u_7.Rig.PrimaryPart
												})
												v_u_2:Play(p_u_7.Config.Sounds.GashingWoundHit4, {
													["Parent"] = p_u_7.Rig.PrimaryPart,
													["Volume"] = 0.25
												})
											end)
											task.spawn(function()
												-- upvalues: (copy) p_u_12
												local v14 = require(game.ReplicatedStorage.Modules.Actors).CurrentActors[game.Players:GetPlayerFromCharacter(p_u_12)]
												if v14 then
													v14:DisableAbilities("Combo", true, 1.25)
												end
											end)
										end
									end
								}
							})
						end
					end)
				end
				task.delay(1.82, function()
					-- upvalues: (ref) v_u_8, (ref) v_u_2, (copy) p_u_7, (ref) v_u_9
					local v_u_15 = v_u_8 and 1.82 or 0.39
					if not v_u_8 then
						v_u_2:Play(p_u_7.Config.Sounds.GashingWoundMiss, {
							["Parent"] = p_u_7.Rig.PrimaryPart
						})
					end
					local v16 = Instance.new("StringValue")
					v16.Name = "Result"
					v16.Value = v_u_8 and "HitPlayer" or "HitNothing"
					v16.Parent = p_u_7.Rig
					game.Debris:AddItem(v16, 5)
					task.delay(v_u_15 - 1.75, function()
						-- upvalues: (ref) v_u_9, (ref) v_u_8, (ref) p_u_7, (copy) v_u_15
						if v_u_9 then
							v_u_9:Stop(0)
						end
						if v_u_8 and v_u_8.PrimaryPart then
							v_u_8:SetPrimaryPartCFrame(p_u_7.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -3))
							v_u_8.PrimaryPart.Anchored = false
							task.delay(0.02, function()
								-- upvalues: (ref) v_u_8, (ref) p_u_7
								v_u_8.PrimaryPart.Velocity = p_u_7.Rig.PrimaryPart.CFrame.LookVector * 200
							end)
							local v17 = require(game.ReplicatedStorage.Modules.Ragdolls)
							if v_u_8.Humanoid.Health <= 0 then
								local v18 = p_u_7.Rig.PrimaryPart.CFrame.LookVector * 250
								local _ = workspace:GetServerTimeNow() + (v_u_15 - 1.75)
								require(game.ReplicatedStorage.Modules.Network):FireAllClientConnection("Ragdoll", "REMOTE_EVENT", v_u_8, nil, (("%*|%*|%*"):format(v18.X, v18.Y, v18.Z)))
								return
							end
							v17:Enable(v_u_8)
							task.wait(1.25)
							v17:Disable(v_u_8)
							v_u_9:Stop()
						end
					end)
					task.delay(v_u_15 - 1, function()
						-- upvalues: (ref) p_u_7
						p_u_7.Rig.PrimaryPart.Anchored = false
					end)
					task.delay(v_u_15, function()
						-- upvalues: (ref) p_u_7
						p_u_7.AbilitiesDisabled = false
					end)
				end)
			elseif game["Run Service"]:IsClient() then
				local v_u_19 = v_u_3:CreateSpeedMultiplier(p_u_7.Rig, 1, "Combo")
				game.TweenService:Create(v_u_19, TweenInfo.new(0.2), {
					["Value"] = 0.001
				}):Play()
				local v20 = p_u_7.Rig:WaitForChild("Result", 5)
				if (v20 and v20.Value or "IDK") == "HitPlayer" then
					task.delay(0.25, function()
						-- upvalues: (copy) v_u_19
						game.TweenService:Create(v_u_19, TweenInfo.new(0.2), {
							["Value"] = 1
						}):Play()
						game.Debris:AddItem(v_u_19, 0.2)
					end)
					return
				end
				task.delay(0.4, function()
					-- upvalues: (copy) v_u_19
					game.TweenService:Create(v_u_19, TweenInfo.new(0.2), {
						["Value"] = 1
					}):Play()
					game.Debris:AddItem(v_u_19, 0.2)
				end)
			end
		end
	},
	["QuickAttack"] = {
		["LayoutOrder"] = 1,
		["KeybindType"] = "AltAbility1",
		["Cooldown"] = 5,
		["Icon"] = "rbxassetid://85282571177550",
		["Callback"] = function(p_u_21, _)
			-- upvalues: (copy) v_u_5, (copy) v_u_2, (copy) v_u_3, (copy) v_u_4, (copy) v_u_6
			if game["Run Service"]:IsServer() then
				p_u_21.AbilitiesDisabled = true
				task.delay(0.75, function()
					-- upvalues: (copy) p_u_21
					p_u_21.AbilitiesDisabled = false
				end)
				v_u_5:ApplyStatus(p_u_21.Rig, "Resistance", {
					["Level"] = 2,
					["Duration"] = 0.7
				})
				task.delay(0.667, function()
					-- upvalues: (ref) v_u_2, (copy) p_u_21, (ref) v_u_3, (ref) v_u_4, (ref) v_u_5
					v_u_2:Play(p_u_21.Config.Sounds.Slash, {
						["Parent"] = p_u_21.Rig.PrimaryPart
					})
					local v22 = v_u_3:ApplyVelocity(p_u_21.Rig.PrimaryPart, 120)
					game.TweenService:Create(v22, TweenInfo.new(1), {
						["VectorVelocity"] = v22.VectorVelocity / 100
					}):Play()
					game.Debris:AddItem(v22, 0.2)
					local v23 = v_u_4
					local v24 = p_u_21.Player
					local v26 = {
						["Size"] = Vector3.new(4, 6, 20),
						["CFrameOffset"] = CFrame.new(0, 0, -15.25),
						["Damage"] = 100,
						["Time"] = 0.25,
						["Knockback"] = 25,
						["HitMultiple"] = false,
						["Connections"] = {
							["Hit"] = function(p25)
								-- upvalues: (ref) v_u_5, (ref) p_u_21, (ref) v_u_2
								v_u_5:ApplyStatus(p25, "Stunned", {
									["Duration"] = p_u_21.Config.SlashStunTime
								})
								v_u_2:Play(p_u_21.Config.Sounds.GashingWoundHit3, {
									["Parent"] = p_u_21.Rig.PrimaryPart
								})
							end
						}
					}
					v23:CreateHitbox(v24, v26)
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_21.Animations.QuickAttack:Play(0.1)
				v_u_6:FireConnection("DisableSprinting", "QuickAttack", true)
				local v_u_27 = v_u_3:CreateSpeedMultiplier(p_u_21.Rig, 0.01, "StunningKiller")
				task.delay(0.7, function()
					-- upvalues: (ref) v_u_6, (copy) v_u_27
					v_u_6:FireConnection("DisableSprinting", "QuickAttack", false)
					v_u_27:Destroy()
				end)
			end
		end
	}
}
v1.Abilities = v28
function v1.Created(_, p_u_29)
	-- upvalues: (copy) v_u_3
	if game["Run Service"]:IsServer() then
		task.spawn(function()
			-- upvalues: (copy) p_u_29, (ref) v_u_3
			if not p_u_29.Cache then
				p_u_29.Cache = {}
			end
			p_u_29.Cache.GashingWoundStart = v_u_3:LoadAnimationFromID(p_u_29.Rig, p_u_29.Config.Animations.GashingWoundStart)
			p_u_29.Cache.GashingWound = v_u_3:LoadAnimationFromID(p_u_29.Rig, p_u_29.Config.Animations.GashingWound.KillerRig)
		end)
	end
end
return v1
