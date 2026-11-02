-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = {}
local v_u_3 = require(game.ReplicatedStorage.Modules.Sounds)
local v_u_4 = require(game.ReplicatedStorage.Modules.Util)
local v_u_5 = require(game.ReplicatedStorage.Modules.Network)
local v_u_6 = require(game.ReplicatedStorage.Modules.Hitboxes)
local v_u_7 = require(game.ReplicatedStorage.Modules.Statuses)
require(game.ReplicatedStorage.Modules.AchievementUtil)
require(v1.Modules.Sprite)
local v_u_8 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local function v_u_15(p9, p10, p11)
	if p9.KnifeToggles then
		p9.KnifeToggles[p10] = p11 or nil
	end
	local v12 = 0
	for _, _ in p9.KnifeToggles or {} do
		v12 = v12 + 1
	end
	if p11 or v12 <= 0 then
		if p9 and p9.DaggerParts then
			for v13, v14 in pairs(p9.DaggerParts) do
				game.TweenService:Create(v13, TweenInfo.new(0.3), {
					["Transparency"] = p11 and v14 and v14 or 1
				}):Play()
			end
		end
	end
end
local v_u_25 = {
	["CLOSE"] = function(p_u_16, _)
		-- upvalues: (copy) v_u_7
		v_u_7:ApplyStatus(p_u_16.Player, "Speed", {
			["Level"] = 2,
			["Duration"] = p_u_16.Config.CrouchSpeedCloseTime
		})
		p_u_16.StabAmplification = 1.5
		task.delay(p_u_16.Config.CrouchStabAmplifyTime, function()
			-- upvalues: (copy) p_u_16
			if p_u_16 then
				p_u_16.StabAmplification = nil
			end
		end)
	end,
	["DEBUFF_SLOWNESS"] = function(p17, p18)
		-- upvalues: (copy) v_u_7
		local v19 = p17.Config.CrouchDistances.DEBUFF_SLOWNESS[1]
		local v20 = p17.Config.CrouchSlownessDebuffMax
		local v21 = (math.clamp(p18, v19, v20) - p17.Config.CrouchDistances.DEBUFF_SLOWNESS[1]) * 0.2
		local v22 = {
			["Level"] = 2,
			["Duration"] = math.floor(v21)
		}
		v_u_7:ApplyStatus(p17.Player, "Slowness", v22)
	end,
	["DEBUFF_HIGHLIGHT"] = function(p23, _)
		-- upvalues: (copy) v_u_4
		for _, v24 in workspace.Players.Killers:GetChildren() do
			v_u_4:RevealPlayerAuraTo(v24, p23.Player, p23.Config.CrouchRevealTime)
			v_u_4:RevealPlayerAuraTo(p23.Player, p23.Player, p23.Config.CrouchRevealTime)
		end
	end
}
local function v_u_31(p26, p27)
	-- upvalues: (copy) v_u_25
	for v28, v29 in p26.Config.CrouchDistances do
		local v30 = v29[2] > -1 and (v29[2] or (1 / 0)) or (1 / 0)
		if v29[1] <= p27 and p27 <= v30 then
			pcall(v_u_25[v28], p26, p27)
		end
	end
end
local v131 = {
	["Dagger"] = {
		["LayoutOrder"] = 1,
		["Icon"] = "rbxassetid://129077533212750",
		["KeybindType"] = "AltAbility1",
		["Callback"] = function(p_u_32, p33)
			-- upvalues: (copy) v_u_31, (copy) v_u_15, (copy) v_u_7, (copy) v_u_3, (copy) v_u_6, (copy) v_u_5, (copy) v_u_4
			if game["Run Service"]:IsServer() then
				p_u_32.AbilitiesDisabled = true
				local v_u_34 = p_u_32.Rig:GetAttribute("Crouching")
				if v_u_34 then
					p_u_32.Rig:SetAttribute("Crouching", nil)
					if game["Run Service"]:IsStudio() then
						print((("[TwoTimeRework]: Current distance from nearest killer: %*"):format(p_u_32.CurrentStudsAway)))
					end
					local v35 = p_u_32.CurrentStudsAway
					if p_u_32.CurrentCrouchThread and v35 ~= nil then
						task.cancel(p_u_32.CurrentCrouchThread)
						p_u_32.CurrentCrouchThread = nil
						p_u_32.CurrentStudsAway = nil
						v_u_31(p_u_32, v35)
					end
					local v36 = tick()
					local v37 = p_u_32.Config.CrouchCooldown - (v36 - (p_u_32.TimeCrouched or v36))
					local v38 = p_u_32.Config.CrouchMinCooldown
					local v39 = p_u_32.Config.CrouchCooldown
					p_u_32:SetCooldownOf("Crouch", (math.clamp(v37, v38, v39)))
					p_u_32.TimeCrouched = nil
					v_u_15(p_u_32, "Crouching", false)
					v_u_7:RemoveStatus(p_u_32.Player, "Invisibility")
					v_u_7:RemoveStatus(p_u_32.Player, "Undetectable")
				end
				local v_u_40 = p_u_32.Rig.PrimaryPart
				if v_u_40 then
					local v41 = ("%*Stab"):format(v_u_34 and "Crouch" or "")
					local v42 = {
						["Parent"] = v_u_40
					}
					if p_u_32.CurrentSound then
						p_u_32.CurrentSound:Destroy()
						p_u_32.CurrentSound = nil
					end
					p_u_32.CurrentSound = v_u_3:Play(p_u_32.Config.Sounds[v41], v42)
				end
				v_u_7:ApplyStatus(p_u_32.Player, "Resistance", {
					["Level"] = p_u_32.Config.DaggerResLevel,
					["Duration"] = p_u_32.Config.DaggerResDuration
				})
				v_u_15(p_u_32, "Dagger", true)
				task.delay(v_u_34 and 0.3 or 0.05, function()
					-- upvalues: (copy) v_u_34, (ref) v_u_6, (copy) p_u_32, (ref) v_u_5, (ref) v_u_4, (ref) v_u_7, (copy) v_u_40, (ref) v_u_3, (ref) v_u_15
					local v_u_43 = nil
					local v_u_44 = v_u_34 and 0.415 or 0.25
					task.spawn(function()
						-- upvalues: (ref) v_u_6, (ref) p_u_32, (copy) v_u_44, (ref) v_u_5, (ref) v_u_43, (ref) v_u_4, (ref) v_u_7, (ref) v_u_40, (ref) v_u_3
						local v45 = v_u_6
						local v46 = p_u_32.Player
						local v80 = {
							["Size"] = Vector3.new(4, 6, 6.5),
							["CFrameOffset"] = CFrame.new(0, 0, -2.25),
							["Damage"] = 0,
							["Time"] = v_u_44,
							["Knockback"] = 0,
							["HitMultiple"] = false,
							["Connections"] = {
								["Hit"] = function(p47)
									-- upvalues: (ref) p_u_32, (ref) v_u_5, (ref) v_u_43, (ref) v_u_4, (ref) v_u_7, (ref) v_u_40, (ref) v_u_3
									print((("[TwoTimeRework]: Is currently stunned? %*"):format((p47:GetAttribute("Stunned")))))
									if p47:GetAttribute("Stunned") == true then
										return
									end
									local v48 = p_u_32.Rig.PrimaryPart
									local v49 = p47.PrimaryPart
									local v50 = v_u_5
									local v51 = p_u_32.Player
									local v52 = p_u_32.Player
									local v53 = v50:FireClientConnection(v51, ("%*TwoTimePosition"):format((tostring(v52))), "REMOTE_FUNCTION")
									local v54
									if v48 and v49 then
										v_u_43 = p47
										local v55 = v49.CFrame.LookVector.Unit
										local v56 = (v49.Position - v48.Position).Unit
										local v57 = (v49.Position - v53).Unit
										local v58 = v56:Dot(v55)
										local v59 = v57:Dot(v55)
										local v60 = v48.CFrame.LookVector:Dot(v49.CFrame.LookVector)
										local v61 = math.acos(v60)
										local v62 = math.deg(v61)
										local v63 = p_u_32.Config.DaggerBackstabThreshold
										local v64 = math.rad(v63) / 1.5707963267948966
										local v65
										if 1 - v58 < v64 then
											v65 = v58 > 0
										else
											v65 = false
										end
										local v66
										if 1 - v59 < v64 + 0.45 then
											v66 = v59 > 0
										else
											v66 = false
										end
										v54 = v62 < p_u_32.Config.DaggerLookDirectionAngle
										if v65 then
											if not v66 then
												v54 = v66
											end
										else
											v54 = v65
										end
										if game["Run Service"]:IsStudio() then
											print((("[TwoTimeRework]: Look Direction Angle: %*"):format(v62)))
											print((("[TwoTimeRework]: Server Threshold Comparison: %*, %*"):format(v64, v58)))
											print((("[TwoTimeRework]: Client Threshold Comparison: %*, %*"):format(v64 + 0.1, v59)))
											print((("[TwoTimeRework]: isBackstabbing? %*"):format(v54)))
										end
									else
										v54 = false
									end
									if v54 then
										v_u_4:ApplyDamage(p47, p_u_32.Config.DaggerBackstabDamage * (p_u_32.StabAmplification or 1))
										v_u_7:ApplyStatus(p47, "Stunned", {
											["Duration"] = p_u_32.Config.DaggerBackstabStatusTime
										})
										p_u_32:ChangeExpression("StunnedKiller", 4)
									else
										v_u_4:ApplyDamage(p47, p_u_32.Config.DaggerDamage * (p_u_32.StabAmplification or 1))
										v_u_7:ApplyStatus(p47, "Slowness", {
											["Level"] = 2,
											["Duration"] = p_u_32.Config.DaggerStatusTime - (#p_u_32 - 1) * 0.25
										})
										v_u_7:ApplyStatus(p47, "Helpless", {
											["Level"] = 1,
											["Duration"] = p_u_32.Config.DaggerStatusTime - (#p_u_32 - 1) * 0.25
										})
									end
									local v67 = p47.Parent.Name
									print(v67)
									--if tostring(v67) ~= "Killers" then
										--local v68 = p47.Parent.Name
										if tostring(v67) ~= "Survivors" then
											--::l26::
											local v78 = p_u_32.Rig:FindFirstChild("Humanoid")
											if v78 then
												v_u_4:Heal(v78, v54 and p_u_32.Config.DaggerLifestealFromBack or p_u_32.Config.DaggerLifestealFromFront)
											end
											local v79 = p_u_32
											v79.Blood = v79.Blood + (v54 and p_u_32.Config.BloodFromBack or p_u_32.Config.BloodFromFront)
											if v_u_40 then
												v_u_3:PlayVoiceline(p_u_32, "SlashHit", {
													["Priority"] = 1
												})
												v_u_3:Play(p_u_32.Config.Sounds.Hit, {
													["Parent"] = p_u_32.Rig.GhostFire.GhostfireBlade
												})
											end
											local v69 = v_u_5
											local v70 = p_u_32.Player
											local v71 = p_u_32.Player
											v69:FireClientConnection(v70, ("%*ReplicateNewBlood"):format((tostring(v71))), "REMOTE_EVENT", p_u_32.Blood)
											if p_u_32.RespawnLocation then
												local v72 = p_u_32.RespawnLocation:FindFirstChild("EnabledFloor")
												if v72 then
													local v73 = p_u_32.Blood / p_u_32.Config.BloodRequiredForRespawn
													local v74 = math.clamp(v73, 0, 1) * 8 + 2
													v72.Transparent.Brightness = v74
													for _, v75 in { v72.Specs, v72.Specs2 } do
														v75:Emit(v75:GetAttribute("EmitCount"))
													end
													if v74 >= 9 then
														local v76 = p_u_32.RespawnLocation.EnabledFloor.FullShader
														if v76 then
															v76.Enabled = true
														end
													end
												end
											end
											--local v77 = p47.Parent.Name
											print("[TwoTimeRework]: HMMMMMM")
											if tostring(v67) == "Killers" then
												print("[TwoTimeRework]: UGHHHHHH")
												require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(p_u_32.Player, {
													["Action"] = ("%* Killer as Two Time"):format(v54 and "Backstabbed" or "Stabbed"),
													["RewardType"] = "Offensive"
												})
											end
											return
										end
									end
									--goto l26
								--end
							}
						}
						v45:CreateHitbox(v46, v80)
					end)
					task.delay(v_u_44, function()
						-- upvalues: (ref) v_u_43
						if v_u_43 == nil then
							v_u_43 = false
						end
					end)
					local v_u_81 = v_u_4:ApplyVelocity(p_u_32.Rig.PrimaryPart, v_u_34 and p_u_32.Config.DaggerLungeForce or p_u_32.Config.DaggerUncrouchedLungeForce)
					game.TweenService:Create(v_u_81, TweenInfo.new(v_u_34 and 0.4 or 0.15), {
						["LineVelocity"] = v_u_81.LineVelocity / 3
					}):Play()
					game.Debris:AddItem(v_u_81, v_u_34 and 0.4 or 0.15)
					task.spawn(function()
						-- upvalues: (ref) v_u_43, (ref) p_u_32, (ref) v_u_5, (copy) v_u_81, (ref) v_u_15
						repeat
							task.wait()
						until v_u_43 ~= nil
						p_u_32.AbilitiesDisabled = false
						if game["Run Service"]:IsStudio() then
							print("[TwoTimeRework]: Calling to turn off lunging.")
						end
						v_u_5:FireClientConnection(p_u_32.Player, ("%*TTCollision"):format(p_u_32.Player.Name), "REMOTE_EVENT")
						if v_u_81 then
							local v82 = v_u_43
							game.TweenService:Create(v_u_81, TweenInfo.new(typeof(v82) == "Instance" and 0.05 or 0.15), {
								["LineVelocity"] = 0
							}):Play()
							game.Debris:AddItem(v_u_81, 0.15)
						end
						task.delay(0.15, function()
							-- upvalues: (ref) v_u_15, (ref) p_u_32
							v_u_15(p_u_32, "Dagger", false)
						end)
					end)
				end)
				return v_u_34
			end
			if p33 then
				local v_u_83 = true
				local v_u_84 = false
				v_u_5:SetConnection(("%*TTCollision"):format(p_u_32.Player.Name), "REMOTE_EVENT", function()
					-- upvalues: (ref) v_u_83
					if game["Run Service"]:IsStudio() then
						print("[TwoTimeRework]: Recieved call to turn lunging off.")
					end
					v_u_83 = false
				end)
				p_u_32.Animations.LungeStart:Play(0)
				task.delay(p_u_32.Animations.LungeStart.Length, function()
					-- upvalues: (copy) p_u_32, (ref) v_u_83, (ref) v_u_84, (ref) v_u_5
					p_u_32.Animations.LungeLoop:Play(0)
					task.delay(0.6, function()
						-- upvalues: (ref) v_u_83, (ref) v_u_84
						if v_u_83 then
							if game["Run Service"]:IsStudio() then
								print("[TwoTimeRework]: The time has passed! Getting out of lunge status.")
							end
							v_u_84 = true
						end
					end)
					repeat
						task.wait()
					until v_u_83 == false or v_u_84
					if game["Run Service"]:IsStudio() then
						print((("[TwoTimeRework]: Returned final result: isLunged: %*, isTimePast: %*."):format(v_u_83, v_u_84)))
					end
					v_u_5:RemoveConnection(("%*TTCollision"):format(p_u_32.Player.Name), "REMOTE_EVENT")
					p_u_32.Animations.LungeStart:Stop(0)
					p_u_32.Animations.LungeLoop:Stop(0)
					if not v_u_84 then
						p_u_32.Animations.LungeEnd:Play(0)
					end
				end)
			else
				p_u_32.Animations.Stab:Play(0)
			end
			v_u_4:ToggleSprinting("TwoTimeStab", false, p33 and 2 or 0.3)
			local v85 = v_u_4:CreateSpeedMultiplier(p_u_32.Rig, 1, "TwoTimeStab", 1)
			game.TweenService:Create(v85, TweenInfo.new(0.35), {
				["Value"] = 0.1
			}):Play()
			task.wait(0.45)
			game.TweenService:Create(v85, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
				["Value"] = 1
			}):Play()
		end
	},
	["Crouch"] = {
		["LayoutOrder"] = 2,
		["Icon"] = "rbxassetid://77707049887484",
		["KeybindType"] = "AltAbility2",
		["Callback"] = function(p_u_86)
			-- upvalues: (copy) v_u_3, (copy) v_u_31, (copy) v_u_15, (copy) v_u_7
			if game["Run Service"]:IsServer() then
				local v_u_87 = tick()
				if p_u_86.Rig:GetAttribute("Crouching") then
					p_u_86.Rig:SetAttribute("Crouching", nil)
					local v88 = p_u_86.Rig.PrimaryPart
					if v88 then
						local v89 = {
							["Parent"] = v88
						}
						if p_u_86.CurrentSound then
							p_u_86.CurrentSound:Destroy()
							p_u_86.CurrentSound = nil
						end
						p_u_86.CurrentSound = v_u_3:Play(p_u_86.Config.Sounds.Stand, v89)
					end
					if game["Run Service"]:IsStudio() then
						print((("[TwoTimeRework]: Current distance from nearest killer: %*"):format(p_u_86.CurrentStudsAway)))
					end
					local v90 = p_u_86.CurrentStudsAway
					if p_u_86.CurrentCrouchThread and v90 ~= nil then
						task.cancel(p_u_86.CurrentCrouchThread)
						p_u_86.CurrentStudsAway = nil
						p_u_86.CurrentCrouchThread = nil
						v_u_31(p_u_86, v90)
					end
					local v91 = p_u_86.Config.CrouchCooldown - (v_u_87 - (p_u_86.TimeCrouched or v_u_87))
					local v92 = p_u_86.Config.CrouchMinCooldown
					local v93 = p_u_86.Config.CrouchCooldown
					p_u_86:SetCooldownOf("Crouch", (math.clamp(v91, v92, v93)))
					p_u_86.TimeCrouched = nil
					v_u_15(p_u_86, "Crouching", false)
					v_u_7:RemoveStatus(p_u_86.Player, "Invisibility")
					v_u_7:RemoveStatus(p_u_86.Player, "Undetectable")
					return
				end
				p_u_86.AbilitiesDisabled = true
				p_u_86.Rig:SetAttribute("Crouching", true)
				local v94 = p_u_86.Rig.PrimaryPart
				if v94 then
					local v95 = {
						["Parent"] = v94
					}
					if p_u_86.CurrentSound then
						p_u_86.CurrentSound:Destroy()
						p_u_86.CurrentSound = nil
					end
					p_u_86.CurrentSound = v_u_3:Play(p_u_86.Config.Sounds.Crouch, v95)
				end
				task.delay(0.05, function()
					-- upvalues: (copy) p_u_86
					p_u_86.AbilitiesDisabled = false
				end)
				p_u_86:SetCooldownOf("Crouch", 1)
				p_u_86.TimeCrouched = v_u_87
				if #workspace.Players.Killers:GetChildren() > 0 then
					p_u_86.CurrentCrouchThread = task.spawn(function()
						-- upvalues: (copy) p_u_86
						while task.wait(0.025) do
							for v96, v97 in workspace.Players.Killers:GetChildren() do
								if v97.PrimaryPart and p_u_86.Rig.PrimaryPart then
									local v98 = (p_u_86.Rig.PrimaryPart.Position - v97.PrimaryPart.Position).Magnitude
									if v96 > 1 then
										local v99 = p_u_86
										if p_u_86.CurrentStudsAway < v98 then
											v98 = p_u_86.CurrentStudsAway or v98
										end
										v99.CurrentStudsAway = v98
									else
										p_u_86.CurrentStudsAway = v98
									end
								end
							end
						end
					end)
				end
				v_u_15(p_u_86, "Crouching", true)
				local v100 = p_u_86.Config.CrouchCooldown - p_u_86.Config.CrouchMinCooldown
				v_u_7:ApplyStatus(p_u_86.Player, "Invisibility", {
					["Duration"] = v100,
					["Level"] = p_u_86.Config.CrouchInvisibilityLevel
				})
				v_u_7:ApplyStatus(p_u_86.Player, "Undetectable", {
					["Duration"] = v100,
					["Level"] = p_u_86.Config.CrouchUndetectableLevel
				})
				task.delay(v100, function()
					-- upvalues: (copy) v_u_87, (copy) p_u_86, (ref) v_u_15
					if v_u_87 == p_u_86.TimeCrouched then
						p_u_86.Rig:SetAttribute("Crouching", false)
						p_u_86:SetCooldownOf("Crouch", p_u_86.Config.CrouchMinCooldown)
						p_u_86.TimeCrouched = nil
						v_u_15(p_u_86, false)
					end
				end)
			end
		end
	},
	["Ritual"] = {
		["LayoutOrder"] = 3,
		["Icon"] = "rbxassetid://95580729656404",
		["KeybindType"] = "AltAbility3",
		["Cooldown"] = 5,
		["Charges"] = 1,
		["Callback"] = function(p_u_101, p102)
			-- upvalues: (copy) v_u_15, (copy) v_u_8, (copy) v_u_4, (copy) v_u_3
			if game["Run Service"]:IsServer() then
				local v_u_103 = RaycastParams.new()
				v_u_103.FilterDescendantsInstances = p_u_101.Rig:GetChildren()
				v_u_103.FilterType = Enum.RaycastFilterType.Exclude
				local v104 = p_u_101.Rig.PrimaryPart
				local v105 = workspace:Raycast(v104.Position, Vector3.new(0, -100, 0), v_u_103)
				workspace:Raycast(v104.Position, v104.CFrame.LookVector * 100, v_u_103)
				local v106 = v105.Position + Vector3.new(0, -0.1, 0)
				for _, v108 in workspace.Map.Ingame:GetChildren() do
					if v108.Name:find("RespawnLocation") or v108.Name:find("Builderman") then
						if v108:IsA("Model") then
							local v108 = v108.PrimaryPart
						end
						if (v106 - v108.Position).Magnitude < p_u_101.Config.RespawnLocationDistance then
							p_u_101:IncrementCharges("Ritual", 1, 1)
							return {
								["Cancelled"] = true
							}
						end
					end
				end
				local v109 = workspace:Raycast(v104.Position, Vector3.new(0, -100, 0), v_u_103).Normal:Dot(Vector3.new(0, 1, 0))
				local v110 = math.acos(v109)
				if math.deg(v110) > 5 then
					p_u_101.AbilitiesDisabled = nil
					p_u_101:IncrementCharges("Ritual", 1, 1)
					return {
						["Cancelled"] = true
					}
				end
				p_u_101.AbilitiesDisabled = true
				p_u_101:IncrementCharges("Ritual", 0, 0)
				v_u_15(p_u_101, "Dagger", true)
				local v_u_111 = p_u_101.Config.VFX.Ritual:Clone()
				task.delay(1.5, function()
					-- upvalues: (copy) p_u_101, (copy) v_u_103, (copy) v_u_111, (ref) v_u_8
					local v112 = p_u_101.Rig:FindFirstChild("graphic", true)
					if v112 then
						v112 = v112:FindFirstChildOfClass("Decal")
					end
					if v112 then
						v112.Transparency = 1
					end
					local v113 = p_u_101.Rig.PrimaryPart
					local v114 = workspace:Raycast(v113.Position, Vector3.new(0, -100, 0), v_u_103)
					local v115 = workspace:Raycast(v113.Position, v113.CFrame.LookVector * 100, v_u_103)
					local v116
					if v115 then
						local v117 = v115.Distance
						v116 = math.clamp(v117, (-1 / 0), 2.648) or 2.648
					else
						v116 = 2.648
					end
					local v_u_118 = p_u_101.Config.RespawnLocation:Clone()
					local v119 = v_u_118.Size
					v_u_118.Name = ("%*RespawnLocation"):format(p_u_101.Player.Name)
					v_u_118.Size = v119 + Vector3.new(0.5, 0.5, 0.5)
					p_u_101.RespawnLocation = v_u_118
					local v120 = v_u_111
					v120.CFrame = v120.CFrame + Vector3.new(0, 0.15, 0)
					v_u_111.Parent = v_u_118
					task.delay(0.05, function()
						-- upvalues: (ref) v_u_111, (ref) p_u_101, (copy) v_u_118
						for _, v121 in v_u_111:GetChildren() do
							if v121:IsA("ParticleEmitter") then
								v121:Emit(v121:GetAttribute("EmitCount"))
							end
						end
						local v122 = p_u_101.Config.VFX.EnabledFloor:Clone()
						v122.CFrame = v122.CFrame + Vector3.new(0, 0.15, 0)
						v122.Parent = v_u_118
						for _, v123 in { v122.Shader, v122.Transparent } do
							v123.Enabled = true
						end
					end)
					game.Debris:AddItem(v_u_111, 1.5)
					if v116 < 2.648 then
						v116 = v116 - v_u_118.Size.Z / 2
					end
					local v124 = v114.Position + v113.CFrame.LookVector * v116 + Vector3.new(0, -0.1, 0)
					v_u_118.CFrame = CFrame.lookAt(v124, v124 + v113.CFrame.LookVector)
					v_u_118.Parent = workspace.Map.Ingame
					game.TweenService:Create(v_u_118, v_u_8, {
						["Size"] = v119
					}):Play()
				end)
				task.delay(3.5, function()
					-- upvalues: (copy) p_u_101, (ref) v_u_15
					p_u_101.AbilitiesDisabled = false
					v_u_15(p_u_101, "Dagger", false)
				end)
				return
			elseif typeof(p102) == "table" and p102.Cancelled then
				v_u_4:CreateWarning("TwoTimeWarning", "Cannot place this down!", p_u_101.Config.WarningTemplate)
			else
				p_u_101.Animations.Ritual:Play()
				local v125 = p_u_101.Rig.PrimaryPart
				if v125 then
					local v126 = {
						["Parent"] = v125
					}
					if p_u_101.CurrentSound then
						p_u_101.CurrentSound:Destroy()
						p_u_101.CurrentSound = nil
					end
					p_u_101.CurrentSound = v_u_3:Play(p_u_101.Config.Sounds.Mark, v126)
				end
				local v127 = v_u_4
				local v128 = p_u_101.Player
				local v129 = p_u_101.Player
				local v_u_130 = v127:CreateSpeedMultiplier(v128, 0, (("%*Ritual"):format((tostring(v129)))))
				task.delay(3.5, function()
					-- upvalues: (copy) v_u_130
					game.TweenService:Create(v_u_130, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
						["Value"] = 1
					}):Play()
					game.Debris:AddItem(v_u_130, 1)
				end)
			end
		end
	}
}
v_u_2.Abilities = v131
function v_u_2.AddRig(_, p132, p133)
	local v134 = p132.Config.LifeAppearances[p133]
	if v134 then
		for _, v135 in pairs(p132.Rig:GetDescendants()) do
			if (v135:IsA("BasePart") or v135:IsA("Decal")) and (v135.Name ~= "Expression" and (v135.Name ~= "CollisionHitbox" and v135.Name ~= "QueryHitbox")) then
				v135.Transparency = 1
			end
		end
		local v136 = v134:Clone()
		for _, v137 in pairs(v136:GetDescendants()) do
			if v137:IsA("BasePart") then
				v137.CollisionGroup = "Survivors"
				v137.CanCollide = false
				v137.CanTouch = false
				v137.CanQuery = false
				v137.Massless = true
			end
		end
		for _, v138 in p132.Rig:GetChildren() do
			if v138:IsA("BasePart") then
				v138.RootPriority = 1
			end
		end
		for _, v139 in pairs(v136:GetChildren()) do
			local v140 = p132.Rig:FindFirstChild(v139.Name)
			if v140 then
				if v139:IsA("Humanoid") then
					v139.EvaluateStateMachine = false
				end
				if v140:IsA("BasePart") then
					v139.Anchored = false
					v139.CanCollide = false
					v139.CFrame = v140.CFrame
					local v141 = Instance.new("WeldConstraint")
					v141.Part1 = v139
					v141.Part0 = v140
					v141.Parent = v139
				end
			end
		end
		v136.Parent = p132.Rig
		p132.Config.Expressions = p132.Config.ExpressionsTable[p133] or p132.Config.Expressions
		p132:ChangeExpression("Hurt", 1)
	end
end
function v_u_2.OnHelpless(_, p142)
	-- upvalues: (copy) v_u_15, (copy) v_u_7
	if p142.Rig:GetAttribute("Crouching") then
		p142.Rig:SetAttribute("Crouching", nil)
		local v143 = tick()
		local v144 = p142.Config.CrouchCooldown - (v143 - (p142.TimeCrouched or v143))
		local v145 = p142.Config.CrouchMinCooldown
		local v146 = p142.Config.CrouchCooldown
		p142:SetCooldownOf("Crouch", (math.clamp(v144, v145, v146)))
		p142.TimeCrouched = nil
		v_u_15(p142, "Crouching", false)
		v_u_7:RemoveStatus(p142.Player, "Invisibility")
		v_u_7:RemoveStatus(p142.Player, "Undetectable")
	end
end
function v_u_2.OnHit(_, p_u_147, p148, p149, p150)
	-- upvalues: (copy) v_u_5, (copy) v_u_3, (copy) v_u_4
	if p150 or p_u_147.Blood >= p_u_147.Config.BloodRequiredForRespawn and (p_u_147.LivesUsed < p_u_147.Config.Lives and (p_u_147.Rig.Humanoid.Health <= p149 and (p_u_147.RespawnLocation and #workspace.Players.Survivors:GetChildren() > 1))) then
		if p148 then
			p148.TimePast = 9999
		end
		p_u_147.Blood = 0
		p_u_147.LivesUsed = p_u_147.LivesUsed + 1
		if p_u_147.Rig.PrimaryPart.Anchored then
			p_u_147.Rig:SetAttribute("Invincible", true)
			local v151 = p_u_147.Rig.Humanoid.MaxHealth
			local v152 = p_u_147.Rig.Humanoid.Health
			p_u_147.Rig.Humanoid.Health = 1
			repeat
				task.wait()
			until p_u_147.Rig.PrimaryPart.Anchored == false
			p_u_147.Rig.Humanoid.MaxHealth = v151
			p_u_147.Rig.Humanoid.Health = v152
			p_u_147.Rig:SetAttribute("Invincible", nil)
		end
		p_u_147.TimeSinceLastLife = tick()
		p_u_147.Behavior:AddRig(p_u_147, p_u_147.LivesUsed)
		pcall(function()
			-- upvalues: (copy) p_u_147
			p_u_147.Behavior:AddRigSkin(p_u_147, p_u_147.LivesUsed)
		end)
		p_u_147:IncrementCharges("Ritual", 0, 0)
		local v153 = v_u_5
		local v154 = p_u_147.Player
		local v155 = p_u_147.Player
		v153:FireClientConnection(v154, ("%*TwoTimeBar"):format((tostring(v155))), "REMOTE_EVENT", "DESTROY")
		local v156 = p_u_147.RespawnLocation and p_u_147.RespawnLocation:FindFirstChild("EnabledFloor")
		if v156 then
			v156:Destroy()
		end
		local v_u_157 = p_u_147.Config.VFX.Respawned:Clone()
		v_u_157.CFrame = v_u_157.CFrame + Vector3.new(0, 0.15, 0)
		v_u_157.Parent = p_u_147.RespawnLocation
		task.delay(0.05, function()
			-- upvalues: (copy) v_u_157
			for _, v158 in v_u_157:GetChildren() do
				if v158:IsA("ParticleEmitter") then
					v158:Emit(v158:GetAttribute("EmitCount"))
				end
			end
		end)
		if p150 then
			p_u_147.Rig.Humanoid.MaxHealth = p_u_147.Config.LastSurvivorMaxHealth
			local v159 = p_u_147.Rig.Humanoid
			v159.Health = v159.Health + p_u_147.Config.LastSurvivorHealthBonus
		else
			local v160 = p_u_147.Rig.Humanoid
			v160.MaxHealth = v160.MaxHealth / p_u_147.Config.NextLifeHealthDivisor
			p_u_147.Rig.Humanoid.Health = p_u_147.Rig.Humanoid.MaxHealth
		end
		local v161 = p_u_147.Rig.PrimaryPart
		if v161 then
			v_u_3:Play(p_u_147.Config.Sounds.Respawn, {
				["Parent"] = v161
			})
		end
		v_u_5:FireAllClientConnection(("%*TwoTimeReplicateAudio"):format(p_u_147.Player), "REMOTE_EVENT", p_u_147.Rig.PrimaryPart.Position)
		local _, v162 = p_u_147.Rig:GetBoundingBox()
		if p_u_147.RespawnLocation then
			local v163 = p_u_147.Rig
			local v164 = p_u_147.RespawnLocation.CFrame
			local v165 = v162.Y / 2
			v163:PivotTo(v164 + vector.create(0, v165, 0))
			if p_u_147.LivesUsed >= p_u_147.Config.Lives then
				game.Debris:AddItem(p_u_147.RespawnLocation, 2)
				p_u_147.RespawnLocation = nil
			end
		end
		for _, v166 in workspace.Players.Killers:GetChildren() do
			v_u_4:RevealPlayerAuraTo(v166, p_u_147.Player, 2)
			v_u_4:RevealPlayerAuraTo(p_u_147.Player, p_u_147.Player, 2)
		end
		local v167 = require(game.ReplicatedStorage.Modules.Statuses)
		v167:RemoveStatuses(p_u_147.Player, true)
		v167:ApplyStatus(p_u_147.Player, "Speed", {
			["Level"] = 2,
			["Duration"] = 6,
			["Instant"] = true
		})
		if not p150 then
			v167:ApplyStatus(p_u_147.Player, "Weakness", {
				["Level"] = 5,
				["Duration"] = 12
			})
		end
		require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(p_u_147.Player, {
			["Action"] = "Respawned as Two Time",
			["RewardType"] = "Survivalist"
		})
	end
end
function v_u_2.Created(_, p_u_168)
	-- upvalues: (copy) v_u_2, (copy) v_u_5, (copy) v_u_8, (copy) v_u_4, (copy) v_u_3
	if game["Run Service"]:IsServer() then
		p_u_168.LivesUsed = 1
		p_u_168.Blood = 0
		p_u_168.Behavior:AddRig(p_u_168, p_u_168.LivesUsed)
		pcall(function()
			-- upvalues: (copy) p_u_168
			p_u_168.Behavior:AddRigSkin(p_u_168, p_u_168.LivesUsed)
		end)
		p_u_168.Rig.Humanoid.Died:Connect(function()
			-- upvalues: (copy) p_u_168
			if p_u_168.TimeSinceLastLife and tick() - p_u_168.TimeSinceLastLife <= 10 then
				require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(p_u_168.Player, "TwoTimeDeath")
			end
		end)
		local function v_u_170()
			-- upvalues: (copy) p_u_168, (ref) v_u_2
			local v169 = p_u_168.Rig
			if v169 then
				v169 = p_u_168.Rig:FindFirstChild("Humanoid")
			end
			if v169 and (v169.Health > 0 and (p_u_168.LivesUsed <= 1 and #workspace.Players.Survivors:GetChildren() <= 1)) then
				v_u_2:OnHit(p_u_168, {}, 0, true)
			end
		end
		task.delay(0.5, v_u_170)
		local v_u_171 = nil
		v_u_171 = workspace.Players.Survivors.ChildRemoved:Connect(function()
			-- upvalues: (copy) p_u_168, (copy) v_u_170, (ref) v_u_171
			if p_u_168.Rig.Parent then
				v_u_170()
			else
				v_u_171:Disconnect()
				v_u_171 = nil
			end
		end)
		local v172 = p_u_168.Config.DaggerTemplate:Clone()
		local v173 = v172:FindFirstChildOfClass("Motor6D")
		if v173 then
			v173.Part0 = p_u_168.Rig.PrimaryPart
			v172.Parent = p_u_168.Rig
		else
			v172:Destroy()
		end
		p_u_168.KnifeToggles = {}
		p_u_168.DaggerParts = {}
		for _, v174 in pairs(v172:GetDescendants()) do
			local v175 = v174:IsA("BasePart")
			if v175 or v174:IsA("Decal") then
				p_u_168.DaggerParts[v174] = v174.Transparency
				v174.Transparency = 1
				if v175 then
					v174.CanCollide = false
				end
			end
		end
		return
	elseif game["Run Service"]:IsClient() and p_u_168.Rig == game.Players.LocalPlayer.Character then
		p_u_168.Rig:WaitForChild("Humanoid"):GetPropertyChangedSignal("MaxHealth"):Connect(function()
			-- upvalues: (copy) p_u_168
			if p_u_168.Rig.Humanoid.MaxHealth <= 70 then
				local v176 = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)
				local v177 = v176.Stamina + 40
				local v178 = v176.MaxStamina or 100
				v176.Stamina = math.clamp(v177, 0, v178)
			end
		end)
		local v_u_179 = p_u_168.Config.HealthBar:Clone()
		v_u_179.Bar.Inner.Size = UDim2.fromScale(1, 0)
		v_u_179.Parent = p_u_168.Player.PlayerGui.MainUI
		p_u_168.HealthbarDisplay = v_u_179
		local v_u_180 = v_u_179.Display
		local v_u_181 = require(v_u_179.Display.Idle)
		task.spawn(function()
			-- upvalues: (copy) v_u_180, (copy) v_u_181
			while v_u_180.Visible do
				for _, v182 in pairs(v_u_181) do
					local v183 = v182[1]
					local v184 = v182[2]
					local v185 = v182[3]
					local v186 = v182[4]
					v_u_180.ImageRectOffset = Vector2.new(v183, v184)
					v_u_180.ImageRectSize = Vector2.new(v185, v186)
					task.wait(0.03125)
				end
				task.wait()
			end
		end)
		local v_u_187 = v_u_179.Full
		local v_u_188 = require(v_u_179.Full.Full)
		task.spawn(function()
			-- upvalues: (copy) v_u_187, (copy) v_u_188
			while v_u_187.Visible do
				for _, v189 in pairs(v_u_188) do
					local v190 = v189[1]
					local v191 = v189[2]
					local v192 = v189[3]
					local v193 = v189[4]
					v_u_187.ImageRectOffset = Vector2.new(v190, v191)
					v_u_187.ImageRectSize = Vector2.new(v192, v193)
					task.wait(0.03125)
				end
				task.wait()
			end
		end)
		local v_u_194 = v_u_179.Full.Vines
		local v_u_195 = require(v_u_179.Full.Vines.Sprite)
		task.spawn(function()
			-- upvalues: (copy) v_u_194, (copy) v_u_195
			while v_u_194.Visible do
				for _, v196 in pairs(v_u_195) do
					local v197 = v196[1]
					local v198 = v196[2]
					local v199 = v196[3]
					local v200 = v196[4]
					v_u_194.ImageRectOffset = Vector2.new(v197, v198)
					v_u_194.ImageRectSize = Vector2.new(v199, v200)
					task.wait(0.03125)
				end
				task.wait()
			end
		end)
		local v_u_201 = v_u_179.Full.Wings
		local v_u_202 = require(v_u_179.Full.Wings.Sprite)
		task.spawn(function()
			-- upvalues: (copy) v_u_201, (copy) v_u_202
			while v_u_201.Visible do
				for _, v203 in pairs(v_u_202) do
					local v204 = v203[1]
					local v205 = v203[2]
					local v206 = v203[3]
					local v207 = v203[4]
					v_u_201.ImageRectOffset = Vector2.new(v204, v205)
					v_u_201.ImageRectSize = Vector2.new(v206, v207)
					task.wait(0.03125)
				end
				task.wait()
			end
		end)
		local v208 = v_u_5
		local v209 = p_u_168.Player
		v208:SetConnection(("%*ReplicateNewBlood"):format((tostring(v209))), "REMOTE_EVENT", function(p210)
			-- upvalues: (copy) p_u_168, (ref) v_u_8, (copy) v_u_179
			if not p_u_168.isCompletedWithBlood then
				if p_u_168.tweenThread then
					task.cancel(p_u_168.tweenThread)
				end
				local v_u_211 = p_u_168.HealthbarDisplay
				if v_u_211 then
					local v_u_212 = TweenInfo.new(0.65, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
					local function v_u_214(p213)
						-- upvalues: (copy) v_u_211, (copy) v_u_212
						game.TweenService:Create(v_u_211, v_u_212, {
							["Position"] = UDim2.fromScale(p213 and 1.025 or 1.175, 0.5),
							["Size"] = UDim2.fromScale(1, p213 and 0.532 or 0.4)
						}):Play()
					end
					v_u_214(true)
					local v215 = game.TweenService
					local v216 = v_u_211.Bar.Inner
					local v217 = v_u_8
					local v218 = {}
					local v219 = UDim2.fromScale
					local v220 = p210 / p_u_168.Config.BloodRequiredForRespawn
					v218.Size = v219(1, (math.clamp(v220, 0, 1)))
					v215:Create(v216, v217, v218):Play()
					p_u_168.tweenThread = task.delay(v_u_8.Time * 20, function()
						-- upvalues: (copy) v_u_214, (ref) p_u_168
						v_u_214(false)
						p_u_168.tweenThread = nil
					end)
					if p_u_168.Config.BloodRequiredForRespawn <= p210 then
						v_u_179.Display.Visible = false
						v_u_179.Full.Visible = true
						game.TweenService:Create(v_u_211, v_u_212, {
							["Position"] = UDim2.fromScale(1, 0.5)
						}):Play()
						p_u_168.isCompletedWithBlood = true
					end
				end
			end
		end)
		local v221 = v_u_5
		local v222 = p_u_168.Player
		v221:SetConnection(("%*TwoTimePosition"):format((tostring(v222))), "REMOTE_FUNCTION", function()
			-- upvalues: (copy) p_u_168
			return p_u_168.Rig.PrimaryPart.Position
		end)
		local v223 = v_u_5
		local v224 = p_u_168.Player
		v223:SetConnection(("%*TwoTimeBar"):format((tostring(v224))), "REMOTE_EVENT", function(p225)
			-- upvalues: (copy) p_u_168
			local v226 = p225 == "DESTROY" and p_u_168.HealthbarDisplay
			if v226 then
				v226:Destroy()
				p_u_168.HealthbarDisplay = nil
			end
		end)
		p_u_168.Rig:GetAttributeChangedSignal("Crouching"):Connect(function()
			-- upvalues: (copy) p_u_168, (ref) v_u_4
			require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)
			local v227 = p_u_168.Config.CrouchSpeed / p_u_168.Config.Speed
			if p_u_168.Rig:GetAttribute("Crouching") then
				p_u_168.Animations.CrouchStart:Play()
				p_u_168.AnimationType = "Crouch"
				p_u_168.MovementAnimSpeed = 1
				task.delay(p_u_168.Animations.CrouchStart.Length, function()
					-- upvalues: (ref) p_u_168
					if p_u_168.AnimationType then
						if not p_u_168.Animations.CrouchIdle.IsPlaying then
							p_u_168.Animations.CrouchIdle:Play()
						end
					end
				end)
				local v228 = v_u_4:CreateSpeedMultiplier(p_u_168.Rig, 1, "TwoTimeCrouching")
				game.TweenService:Create(v228, TweenInfo.new(0.75, Enum.EasingStyle.Quint), {
					["Value"] = 0.15
				}):Play()
				task.wait(0.75)
				game.TweenService:Create(v228, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					["Value"] = v227
				}):Play()
			else
				p_u_168.Animations.CrouchIdle:Stop(0.4)
				p_u_168.AnimationType = nil
				p_u_168.MovementAnimSpeed = nil
				local v229 = v_u_4:CreateSpeedMultiplier(p_u_168.Rig, v227, "TwoTimeCrouching")
				game.TweenService:Create(v229, TweenInfo.new(0.75, Enum.EasingStyle.Quint), {
					["Value"] = 1
				}):Play()
				game.Debris:AddItem(v229, 0.75)
			end
		end)
	else
		v_u_5:SetConnection(("%*TwoTimeReplicateAudio"):format(p_u_168.Player), "REMOTE_EVENT", function(p230)
			-- upvalues: (copy) p_u_168, (ref) v_u_3
			if p_u_168.Rig ~= game.Players.LocalPlayer.Character then
				local v231 = p_u_168.Config.AudioReplication:Clone()
				v231.Position = p230
				v_u_3:Play(p_u_168.Config.Sounds.Respawn, {
					["Parent"] = v231
				})
				game.Debris:AddItem(v231, p_u_168.Config.Sounds.Respawn.TimeLength)
			end
		end)
	end
end
function v_u_2.Destroyed(_, p232)
	-- upvalues: (copy) v_u_5
	if game["Run Service"]:IsClient() then
		local v233 = v_u_5
		local v234 = p232.Player
		v233:RemoveConnection((("%*TwoTimePosition"):format((tostring(v234)))))
		local v235 = v_u_5
		local v236 = p232.Player
		v235:RemoveConnection((("%*ReplicateNewBlood"):format((tostring(v236)))))
		v_u_5:RemoveConnection((("%*TwoTimeReplicateAudio"):format(p232.Player)))
		v_u_5:RemoveConnection((("%*TTCollision"):format(p232.Player.Name)))
		local v237 = v_u_5
		local v238 = p232.Player
		v237:RemoveConnection((("%*TwoTimeBar"):format((tostring(v238)))))
		p232.isCompletedWithBlood = false
		if p232.HealthbarDisplay then
			p232.HealthbarDisplay:Destroy()
			p232.HealthbarDisplay = nil
			return
		end
	elseif p232.RespawnLocation then
		p232.RespawnLocation:Destroy()
		p232.RespawnLocation = nil
	end
end
return v_u_2
