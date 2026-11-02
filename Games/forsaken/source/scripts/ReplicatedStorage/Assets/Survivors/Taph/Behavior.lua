-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {}
local v_u_2 = require(game.ReplicatedStorage.Modules.Sounds)
local v_u_3 = require(game.ReplicatedStorage.Modules.Util)
require(game.ReplicatedStorage.Modules.Hitboxes)
local v_u_4 = require(game.ReplicatedStorage.Modules.Statuses)
local v_u_5 = require(game.ReplicatedStorage.Modules.Actors)
local function v_u_15(p6, p7, p8)
	local v9 = workspace:GetPartBoundsInRadius(p7.Position, 0.25)
	for _, v10 in pairs(v9) do
		if v10.Transparency < 0.9 or v10.Name == "UnplacableArea" then
			return "collision"
		end
	end
	for _, v11 in pairs(workspace.Map.Ingame:GetChildren()) do
		if v11.Name:find("TaphTripwire") then
			for _, v12 in pairs(v11:GetChildren()) do
				if v12.Name:find("Hook") and (p6.Rig.PrimaryPart.Position - v12.Position).Magnitude < p6.Config.TripwireDistanceBetweenTripwires then
					return "tooClose"
				end
			end
		end
	end
	local v13 = RaycastParams.new()
	v13.FilterType = Enum.RaycastFilterType.Exclude
	v13.FilterDescendantsInstances = { workspace.Players }
	if not workspace:Raycast(p7.Position, Vector3.new(0, -2, 0), v13) then
		return "midair"
	end
	if workspace:Raycast(p6.Rig.PrimaryPart.Position, p6.Rig.PrimaryPart.CFrame.LookVector * 2, v13) then
		return "facingWall"
	end
	if p8 then
		local v14 = (p7.Position - p8.Position).Magnitude
		if workspace:Raycast(p8.Position, CFrame.lookAt(p8.Position, p7.Position).LookVector * v14, v13) then
			return "intersecting"
		end
	end
	return "placed"
end
local v97 = {
	["Tripwire"] = {
		["LayoutOrder"] = 1,
		["KeybindType"] = "AltAbility1",
		["Icon"] = "rbxassetid://135707604176757",
		["Callback"] = function(p_u_16, p17)
			-- upvalues: (copy) v_u_15, (copy) v_u_4, (copy) v_u_3, (copy) v_u_5
			if game["Run Service"]:IsServer() then
				p_u_16.DisabledAbilities = {
					["SubspaceTripmine"] = true
				}
				local v18 = p_u_16.Rig.PrimaryPart.CFrame * CFrame.new(0, -2, -2)
				local v19 = p_u_16.Rig:GetAttribute("TripwireOrigin")
				if v19 then
					local v20 = v_u_15(p_u_16, v18, v19)
					if v20 ~= "placed" then
						p_u_16.DisabledAbilities = nil
						return {
							["Cancelled"] = true,
							["Reason"] = v20
						}
					end
					p_u_16.Rig:SetAttribute("TripwireEnding", v18)
					p_u_16.Placing = nil
				else
					local v21 = v_u_15(p_u_16, v18)
					if v21 ~= "placed" then
						p_u_16.DisabledAbilities = nil
						return {
							["Cancelled"] = true,
							["Reason"] = v21
						}
					end
					p_u_16.Placing = true
					p_u_16:SetCooldownOf("Tripwire", p_u_16.Config.TripwireCooldownWhilePlacing)
					p_u_16.Rig:SetAttribute("PlacingTripwire", true)
					p_u_16.Rig:SetAttribute("TripwireOrigin", p_u_16.Rig.PrimaryPart.CFrame * CFrame.new(0, -2, -2))
					local v_u_22 = p_u_16.Rig.Humanoid.Health
					local v_u_24 = p_u_16.Rig.Humanoid.HealthChanged:Connect(function(p23)
						-- upvalues: (copy) v_u_22, (copy) p_u_16
						if p23 + 4.75 < v_u_22 then
							p_u_16.Placing = nil
						end
					end)
					task.spawn(function()
						-- upvalues: (copy) p_u_16, (ref) v_u_24, (ref) v_u_4, (ref) v_u_3, (ref) v_u_5
						repeat
							task.wait()
						until not (p_u_16.Rig.Parent and p_u_16.Placing)
						if p_u_16.Rig.Parent then
							v_u_24:Disconnect()
							p_u_16.AbilitiesDisabled = true
							p_u_16.DisabledAbilities = nil
							task.delay(2, function()
								-- upvalues: (ref) p_u_16
								p_u_16.AbilitiesDisabled = false
							end)
							local v25 = p_u_16.Rig:GetAttribute("TripwireOrigin")
							local v26 = p_u_16.Rig:GetAttribute("TripwireEnding")
							if v25 and v26 then
								local v_u_27 = Instance.new("Model")
								local v28 = p_u_16.Player
								v_u_27.Name = ("%*TaphTripwire"):format((tostring(v28)))
								v_u_27.Parent = workspace.Map.Ingame
								v_u_27:SetAttribute("HitboxPriority", 0)
								local _, _ = p_u_16.Behavior:CreateTripwireHooks(p_u_16, v_u_27)
								local v29 = (v25.Position - v26.Position).Magnitude
								local v30 = v25.Position:Lerp(v26.Position, 0.5)
								local v31 = CFrame.lookAt(v30, v26.Position)
								local v_u_32 = Instance.new("Part")
								v_u_32.Name = "Wire"
								v_u_32.Transparency = 1
								v_u_32.Anchored = true
								v_u_32.CanCollide = false
								v_u_32.CanQuery = true
								v_u_32.Size = Vector3.new(0.1, 0.1, v29)
								v_u_32.Position = v30 + Vector3.new(0, 0.2, 0)
								v_u_32.CFrame = v31
								v_u_32.Parent = v_u_27
								game.TweenService:Create(v_u_32, TweenInfo.new(1), {
									["Transparency"] = 0.75
								}):Play()
								task.delay(1, function()
									-- upvalues: (copy) v_u_32
									game.TweenService:Create(v_u_32, TweenInfo.new(20, Enum.EasingStyle.Linear), {
										["Transparency"] = 0.8
									}):Play()
								end)
								local v33 = Instance.new("Humanoid")
								v33.Parent = v_u_27
								v33.MaxHealth = p_u_16.Config.TripwireHealth
								v33.Health = p_u_16.Config.TripwireHealth
								v_u_27:SetAttribute("ExecutionsDisabled", true)
								v_u_27:SetAttribute("Team", "Survivors")
								v_u_27.PrimaryPart = v_u_32
								v_u_27:SetAttribute("Invincible", true)
								task.delay(1, function()
									-- upvalues: (copy) v_u_27
									v_u_27:SetAttribute("Invincible", nil)
								end)
								local v_u_34 = false
								local function v_u_36()
									-- upvalues: (ref) v_u_34, (copy) v_u_32, (copy) v_u_27
									if not v_u_34 then
										v_u_34 = true
										v_u_32.Anchored = false
										v_u_32:ApplyImpulse(Vector3.new(0, 0.05, 0))
										game.Debris:AddItem(v_u_27, 1.5)
										for _, v35 in pairs(v_u_27:GetChildren()) do
											if v35:IsA("BasePart") then
												game.TweenService:Create(v35, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
													["Transparency"] = 1
												}):Play()
											end
										end
									end
								end
								if #p_u_16.CurrentTripwires >= p_u_16.Config.TripwireMaxAmount then
									table.remove(p_u_16.CurrentTripwires, 1).Remove()
								end
								local v37 = p_u_16.CurrentTripwires
								table.insert(v37, {
									["Model"] = v_u_27,
									["Remove"] = v_u_36
								})
								local v_u_38 = false
								v_u_32.Touched:Connect(function(p39)
									-- upvalues: (ref) v_u_38, (ref) v_u_34, (copy) v_u_36, (ref) p_u_16, (ref) v_u_4, (ref) v_u_3, (ref) v_u_5
									local v40 = p39:FindFirstAncestorOfClass("Model")
									if v40 then
										local v41 = v40.Parent
										if tostring(v41) == "Killers" and not (v_u_38 or v_u_34) then
											v_u_38 = true
											v_u_36()
											if not v40:GetAttribute("Invincible") then
												local v42 = {
													["Duration"] = p_u_16.Config.TripwireTriggerSlownessData.Duration
												}
												local v43 = p_u_16.Config.TripwireTriggerSlownessData.Level - (#p_u_16 - 1)
												local v44 = p_u_16.Config.TripwireTriggerSlownessData.Level
												v42.Level = math.clamp(v43, 1, v44)
												v_u_4:ApplyStatus(v40, "Slowness", v42)
											end
											local v45 = v40:GetAttribute("Invincible") and p_u_16.Config.TripwireTriggerAuraRevealInvincibleDuration or p_u_16.Config.TripwireTriggerAuraRevealDuration
											local v46 = v_u_3:GetClosestPlayerFromPosition(p_u_16.Rig.PrimaryPart.Position, {
												["ReturnTable"] = true,
												["MaxDistance"] = p_u_16.Config.TripwireTriggerAuraRevealDistance,
												["PlayerSelection"] = "Survivors"
											})
											for _, v47 in pairs(v46) do
												v_u_3:RevealPlayerAuraTo(v47.Player, v40, v45)
											end
											local v48 = p_u_16.Player
											if not v40:GetAttribute((("TripwireTriggerTime%*"):format((tostring(v48))))) then
												--::l15::
												local v49 = p_u_16.Player
												v40:SetAttribute(("TripwireTriggerTime%*"):format((tostring(v49))), tick())
												--goto l2
											end
											local v50 = p_u_16.Player
											if v40:GetAttribute((("TripwireTriggerTime%*"):format((tostring(v50))))) <= tick() - p_u_16.Config.TripwireDurationBetweenRewards then
												v_u_5:IncrementActorStats(p_u_16.Player, {
													["Action"] = "Killer Triggered Tripwire",
													["RewardType"] = "Survivalist"
												})
											end
										end
									end
									--::l2::
								end)
								v33.HealthChanged:Connect(function(p51)
									-- upvalues: (ref) v_u_34, (copy) v_u_36, (copy) v_u_32, (ref) v_u_3, (ref) p_u_16
									print(p51, v_u_34)
									if p51 <= 0 and not v_u_34 then
										v_u_36()
										local v52 = OverlapParams.new()
										v52.FilterType = Enum.RaycastFilterType.Include
										v52.FilterDescendantsInstances = { workspace.Players.Killers }
										local v53 = workspace:GetPartBoundsInBox(v_u_32.CFrame, v_u_32.Size + Vector3.new(7, 7, 7), v52)
										local v54 = {}
										for _, v55 in pairs(v53) do
											local v56 = v55:FindFirstAncestor("Model")
											if v56 and not v54[v56] then
												v54[v56] = true
												for _, v57 in pairs(workspace.Players.Survivors:GetChildren()) do
													v_u_3:RevealPlayerAuraTo(v57, v56, p_u_16.Config.TripwireDestroyedAuraDuration)
												end
											end
										end
									end
								end)
								task.delay(p_u_16.Config.TripwireLifetime - (#p_u_16 - 1) * p_u_16.Config.TripwireLifetimeDecreasePerTaph, v_u_36)
							end
							p_u_16:SetCooldownOf("Tripwire", p_u_16.Config.TripwireCooldown)
							p_u_16.Rig:SetAttribute("PlacingTripwire", nil)
							p_u_16.Rig:SetAttribute("TripwireOrigin", nil)
							p_u_16.Rig:SetAttribute("TripwireEnding", nil)
						end
					end)
				end
				task.delay(p_u_16.Config.TripwireCooldownWhilePlacing, function()
					-- upvalues: (copy) p_u_16
					p_u_16.AbilitiesDisabled = false
				end)
				return p_u_16.Placing
			end
			if game["Run Service"]:IsClient() then
				if typeof(p17) == "table" and p17.Cancelled then
					local v58 = {
						["collision"] = "Tripwire placement point is obstructed by something. Move back a bit.",
						["tooClose"] = "Tripwire placement point is too close to another tripwire.",
						["midair"] = "Tripwire placement point is too high above ground. Turn around and try again.",
						["facingWall"] = "You\'re too close to a wall. Turn around and try again.",
						["intersecting"] = "Your tripwire\'s intersecting with a wall. Make sure that there\'s nothing blocking its origin & end points.",
						["unknown"] = "Something went wrong. Try placing the tripwire somewhere else."
					}
					v_u_3:CreateWarning("BuildermanWarning", v58[p17.Reason] or v58.unknown, p_u_16.Config.WarningTemplate)
					return
				end
				if p17 == true then
					p_u_16.AnimationType = "Tripwire"
					p_u_16.Animations.TripwireIdle:Play()
					p_u_16.Animations.TripwirePlaceStart:Play(0.025)
					p_u_16.MovementAnimSpeed = 1
					v_u_3:ToggleSprinting("TaphTripwire", false)
					local v_u_59 = v_u_3:CreateSpeedMultiplier(p_u_16.Rig, 1, "TaphTripwire")
					game.TweenService:Create(v_u_59, TweenInfo.new(0.25), {
						["Value"] = 0
					}):Play()
					local v_u_60 = false
					local v_u_61 = p_u_16.Rig.Humanoid.Health
					local v_u_63 = p_u_16.Rig.Humanoid.HealthChanged:Connect(function(p62)
						-- upvalues: (copy) v_u_61, (ref) v_u_60
						if p62 + 4.75 < v_u_61 then
							v_u_60 = true
						end
					end)
					task.delay(1, function()
						-- upvalues: (copy) v_u_59, (copy) p_u_16, (ref) v_u_60, (ref) v_u_63, (ref) v_u_3
						game.TweenService:Create(v_u_59, TweenInfo.new(1), {
							["Value"] = p_u_16.Config.TripwireSpeedWhilePlacing / p_u_16.Config.Speed
						}):Play()
						repeat
							task.wait()
						until not p_u_16.Rig:GetAttribute("PlacingTripwire") or (not p_u_16.Rig.Parent or v_u_60)
						if p_u_16.Rig.Parent then
							v_u_63:Disconnect()
							p_u_16.AnimationType = nil
							p_u_16.Animations.TripwireIdle:Stop()
							p_u_16.Animations.TripwirePlaceEnd:Play(0)
							p_u_16.MovementAnimSpeed = nil
							if v_u_60 then
								v_u_59:Destroy()
								v_u_3:ToggleSprinting("TaphTripwire", true)
								p_u_16.Animations.TripwirePlaceEnd:Stop(0.2)
							else
								v_u_59.Value = 0
								task.delay(0.5, function()
									-- upvalues: (ref) v_u_3, (ref) v_u_59
									v_u_3:ToggleSprinting("TaphTripwire", true)
									game.TweenService:Create(v_u_59, TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
										["Value"] = 1
									}):Play()
									game.Debris:AddItem(v_u_59, 0.75)
								end)
							end
						else
							return
						end
					end)
				end
			end
		end
	},
	["SubspaceTripmine"] = {
		["LayoutOrder"] = 2,
		["KeybindType"] = "AltAbility2",
		["Icon"] = "rbxassetid://89334370123950",
		["Callback"] = function(p_u_64, _)
			-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_4, (copy) v_u_5
			if game["Run Service"]:IsServer() then
				p_u_64.AbilitiesDisabled = true
				local v_u_65 = p_u_64.Rig.SubspaceTripmine
				for _, v66 in pairs(v_u_65:GetChildren()) do
					v66.Transparency = 0
				end
				v_u_2:Play(p_u_64.Config.Sounds.SubspaceUse, {
					["Parent"] = p_u_64.Rig.PrimaryPart
				})
				task.delay(1.98, function()
					-- upvalues: (copy) p_u_64, (copy) v_u_65, (ref) v_u_2, (ref) v_u_3, (ref) v_u_4, (ref) v_u_5
					if p_u_64.Rig.Parent and (p_u_64.Rig.PrimaryPart and (not p_u_64.Rig.PrimaryPart.Anchored and p_u_64.Rig.Humanoid.Health > 0)) then
						local v_u_67 = v_u_65:Clone()
						v_u_67:SetAttribute("Team", "Survivors")
						v_u_67:SetAttribute("ExecutionsDisabled", true)
						v_u_67.Parent = workspace.Map.Ingame
						for _, v68 in pairs(v_u_67:GetDescendants()) do
							if v68:IsA("BasePart") then
								v68.Transparency = 0
								v68.CanCollide = true
								v68.CanQuery = true
								v68.CollisionGroup = "Ragdolls"
							end
						end
						v_u_67:SetAttribute("Invincible", true)
						task.delay(1, function()
							-- upvalues: (copy) v_u_67
							v_u_67:SetAttribute("Invincible", nil)
						end)
						for _, v69 in pairs(v_u_65:GetChildren()) do
							v69.Transparency = 1
						end
						v_u_2:Play(p_u_64.Config.Sounds.SubspaceToss, {
							["Parent"] = v_u_67.PrimaryPart
						})
						for _, v70 in pairs(v_u_67:GetDescendants()) do
							if v70:IsA("BasePart") then
								v70.CanCollide = true
								if v70 ~= v_u_67.PrimaryPart then
									local v71 = Instance.new("WeldConstraint")
									v71.Parent = v70
									v71.Part1 = v70
									v71.Part0 = v_u_67.PrimaryPart
								end
								game.TweenService:Create(v70, TweenInfo.new(4, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
									["Transparency"] = p_u_64.Config.SubspaceHiddenTransparency
								}):Play()
							elseif v70:IsA("Light") then
								v70.Brightness = 1
								v70.Range = p_u_64.Config.SubspaceRange
								game.TweenService:Create(v70, TweenInfo.new(4, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
									["Brightness"] = 0
								}):Play()
							end
						end
						v_u_67.PrimaryPart.Velocity = CFrame.lookAt(p_u_64.Rig.PrimaryPart.Position, (p_u_64.Rig.PrimaryPart.CFrame * CFrame.new(-1, 5, -10)).Position).LookVector * p_u_64.Config.SubspaceThrowForce
						local v_u_72 = Instance.new("Humanoid")
						v_u_72.EvaluateStateMachine = false
						v_u_72.BreakJointsOnDeath = false
						v_u_72.RequiresNeck = false
						v_u_72.Health = 1
						v_u_72.Parent = v_u_67
						local v_u_73 = false
						v_u_72.HealthChanged:Connect(function(p74)
							-- upvalues: (copy) v_u_67, (ref) p_u_64, (ref) v_u_3, (ref) v_u_4, (ref) v_u_5, (ref) v_u_2
							if p74 <= 0.1275 then
								for _, v75 in pairs(v_u_67:GetDescendants()) do
									if v75:IsA("BasePart") then
										game.TweenService:Create(v75, TweenInfo.new(p_u_64.Config.SubspaceExplosionDelay, Enum.EasingStyle.Linear), {
											["Transparency"] = 0,
											["Size"] = v75.Size * 1.3
										}):Play()
									elseif v75:IsA("Light") then
										game.TweenService:Create(v75, TweenInfo.new(p_u_64.Config.SubspaceExplosionDelay * 1.275), {
											["Brightness"] = 12
										}):Play()
									end
								end
								task.delay(p_u_64.Config.SubspaceExplosionDelay, function()
									-- upvalues: (ref) v_u_67, (ref) v_u_3, (ref) p_u_64, (ref) v_u_4, (ref) v_u_5, (ref) v_u_2
									local v76, _ = v_u_67:GetBoundingBox()
									local v77 = v_u_3:GetClosestPlayerFromPosition(v76.Position, {
										["ReturnTable"] = true,
										["OverrideUndetectable"] = true,
										["IncludedSelection"] = { p_u_64.Rig },
										["PlayerSelection"] = "Killers",
										["MaxDistance"] = p_u_64.Config.SubspaceRange
									})
									local v78 = nil
									local v79 = nil
									for _, v80 in pairs(v77) do
										if not v80.Player:GetAttribute("TaphSubspaced") or tick() > v80.Player:GetAttribute("TaphSubspaced") + p_u_64.Config.SubspaceEffectDuration then
											v79 = v80.Player == p_u_64.Character and true or v79
											local v81 = v80.Player.Parent
											v78 = tostring(v81) == "Killers" and true or v78
											local v82 = v_u_67:GetAttribute("RecentAttacker")
											local v83 = game.Players
											local v84 = v80.Player
											local v85 = v82 == tostring(v83:GetPlayerFromCharacter(v84))
											v_u_4:ApplyStatus(v80.Player, "Subspaced", {
												["Level"] = v85 and p_u_64.Config.SubspaceEffectHitLevel or p_u_64.Config.SubspaceEffectLevel,
												["Duration"] = p_u_64.Config.SubspaceEffectDuration
											})
											if not (v80.Player:GetAttribute("Invincible") or v85) then
												v_u_4:ApplyStatus(v80.Player, "Helpless", {
													["Level"] = 1,
													["Duration"] = p_u_64.Config.SubspaceHelplessDuration
												})
											end
											v80.Player:SetAttribute("TaphSubspaced", tick())
										end
									end
									if v78 then
										p_u_64:SetCooldownOf("SubspaceTripmine", -p_u_64.Config.SubspaceCooldownReductionOnSuccess)
									end
									if v78 and not v79 then
										v_u_5:IncrementActorStats(p_u_64.Player, {
											["Action"] = "Killer Triggered Subspace Tripmine",
											["RewardType"] = "Offensive"
										})
									end
									v_u_2:Play(p_u_64.Config.Sounds.SubspaceDetonate, {
										["Position"] = v76.Position
									})
									local v86 = p_u_64.Config.SubspaceExplosionVFX:Clone()
									v86:SetPrimaryPartCFrame(v76)
									v86.Name = "TaphTripmineVFX"
									v86.Parent = workspace.Map.Ingame
									game.Debris:AddItem(v86, 2)
									for _, v87 in pairs(v86:GetDescendants()) do
										if v87:IsA("ParticleEmitter") then
											v87:Emit(v87:GetAttribute("EmitCount") or 5)
										elseif v87:IsA("Light") then
											game.TweenService:Create(v87, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
												["Brightness"] = 0
											}):Play()
										end
									end
									v_u_67:Destroy()
								end)
							end
						end)
						task.delay(3, function()
							-- upvalues: (copy) v_u_72, (copy) v_u_67, (ref) v_u_3, (ref) p_u_64, (ref) v_u_73, (ref) v_u_2
							local v88 = tick()
							local v89 = 0
							while v_u_72.Health > 0.125 and v_u_67.PrimaryPart do
								if v_u_3:GetClosestPlayerFromPosition(v_u_67.PrimaryPart.Position, {
									["PlayerSelection"] = "Killers",
									["MaxDistance"] = p_u_64.Config.SubspaceRange
								}) or p_u_64.Config.SubspaceLifetime <= v89 then
									v_u_73 = true
									v_u_72.Health = 0.125
								elseif p_u_64.Config.SubspaceHintCount >= 1 then
									local v90 = tick()
									local v91 = p_u_64.Config.SubspaceLifetime
									local v92 = p_u_64.Config.SubspaceHintCount
									if v88 + v91 / (math.round(v92) + 1) <= v90 then
										v88 = tick()
										v_u_2:Play(p_u_64.Config.Sounds.SubspaceHint, {
											["Parent"] = v_u_67.PrimaryPart
										})
										for _, v93 in pairs(v_u_67:GetDescendants()) do
											if v93:IsA("BasePart") then
												game.TweenService:Create(v93, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut, 0, true), {
													["Transparency"] = p_u_64.Config.SubspaceHintTransparency
												}):Play()
											elseif v93:IsA("Light") then
												game.TweenService:Create(v93, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut, 0, true), {
													["Brightness"] = 0.5
												}):Play()
											end
										end
									end
								end
								v89 = v89 + task.wait()
							end
						end)
					else
						for _, v94 in pairs(v_u_65:GetChildren()) do
							v94.Transparency = 1
						end
					end
				end)
				task.delay(4, function()
					-- upvalues: (copy) p_u_64
					p_u_64.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_64.Animations.ThrowSubspace:Play(0.05)
				local v_u_95 = v_u_3:CreateSpeedMultiplier(p_u_64.Rig, 0.25, "SubspaceTripmine")
				local v_u_96 = require(game.ReplicatedStorage.Modules.Network)
				v_u_96:FireConnection("DisableSprinting", "SubspaceTripmine", true)
				task.delay(2, function()
					-- upvalues: (copy) v_u_95, (copy) v_u_96
					v_u_95:Destroy()
					v_u_96:FireConnection("DisableSprinting", "SubspaceTripmine", false)
				end)
			end
		end
	}
}
v1.Abilities = v97
function v1.Created(_, p_u_98)
	-- upvalues: (copy) v_u_3, (copy) v_u_15
	if game["Run Service"]:IsClient() then
		local v_u_99 = nil
		v_u_99 = workspace.Map.Ingame.ChildAdded:Connect(function(p100)
			-- upvalues: (copy) p_u_98, (ref) v_u_99, (ref) v_u_3
			if p_u_98.Rig.Parent then
				if p100.Name == "TaphTripmineVFX" and v_u_3:GetSettingValue("EpilepsyMode") then
					p100:Destroy()
				end
			else
				v_u_99:Disconnect()
				v_u_99 = nil
			end
		end)
		local v_u_101 = false
		p_u_98.Rig:GetAttributeChangedSignal("TripwireOrigin"):Connect(function()
			-- upvalues: (copy) p_u_98, (ref) v_u_101, (ref) v_u_15
			local v_u_102 = p_u_98.Rig:GetAttribute("TripwireOrigin")
			if v_u_102 then
				v_u_101 = true
				local v_u_103 = p_u_98.Config.TripwireTemplate:Clone()
				v_u_103.Name = "FakeHook"
				v_u_103.Transparency = 1
				v_u_103.CanCollide = false
				v_u_103.CanQuery = false
				v_u_103.Material = Enum.Material.Neon
				v_u_103.Parent = workspace.Map.Ingame
				v_u_103.CFrame = v_u_102 * p_u_98.Config.TripwireCFrameOffset
				game.TweenService:Create(v_u_103, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					["Transparency"] = 0.65
				}):Play()
				if v_u_103:IsA("UnionOperation") then
					v_u_103.UsePartColor = true
				end
				local v_u_104 = Instance.new("Part")
				v_u_104.Name = "FakeWire"
				v_u_104.Transparency = 1
				v_u_104.Anchored = true
				v_u_104.CanCollide = false
				v_u_104.CanQuery = false
				v_u_104.Material = Enum.Material.Neon
				v_u_104.Parent = workspace.Map.Ingame
				game.TweenService:Create(v_u_104, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					["Transparency"] = 0.65
				}):Play()
				local function v110()
					-- upvalues: (ref) p_u_98, (copy) v_u_102, (ref) v_u_15, (copy) v_u_104, (copy) v_u_103
					local v105 = p_u_98.Rig.PrimaryPart.CFrame * CFrame.new(0, -2, -2) + Vector3.new(0, 0.3, 0)
					local v106 = (v_u_102.Position - v105.Position).Magnitude
					local v107 = v_u_102.Position:Lerp(v105.Position, 0.5)
					local v108 = CFrame.lookAt(v107, v105.Position)
					local v109 = v_u_15(p_u_98, v105 - Vector3.new(0, 0.3, 0), v_u_102)
					v_u_104.Position = v107 + Vector3.new(0, 0.2, 0)
					v_u_104.CFrame = v108
					v_u_104.Size = Vector3.new(0.1, 0.1, v106)
					v_u_104.Color = v109 == "placed" and Color3.new(0.4, 1, 0.4) or Color3.new(1, 0.25, 0.25)
					v_u_103.Color = v109 == "placed" and Color3.new(0.4, 1, 0.4) or Color3.new(1, 0.25, 0.25)
					if p_u_98.Config.TripwireLookAt then
						v_u_103.CFrame = CFrame.new(v_u_103.Position, v105.Position) * p_u_98.Config.TripwireCFrameOffset
					end
				end
				v110()
				while task.wait() and (v_u_101 and p_u_98.Rig.Parent) do
					v110()
				end
				for _, v111 in pairs({ v_u_103, v_u_104 }) do
					game.TweenService:Create(v111, TweenInfo.new(1), {
						["Transparency"] = 1
					}):Play()
					game.Debris:AddItem(v111, 1)
				end
			else
				v_u_101 = false
			end
		end)
	else
		p_u_98.CurrentTripwires = {}
	end
end
function v1.CreateTripwireHooks(_, p112, p113)
	local v114 = p112.Rig:GetAttribute("TripwireOrigin")
	local v115 = p112.Rig:GetAttribute("TripwireEnding")
	local v116 = p112.Config.TripwireTemplate:Clone()
	v116.Name = "Hook1"
	v116.CanCollide = false
	v116.Parent = p113
	v116.CFrame = v114 * p112.Config.TripwireCFrameOffset
	local v117 = p112.Config.TripwireTemplate:Clone()
	v117.Name = "Hook2"
	v117.CanCollide = false
	v117.Parent = p113
	v117.CFrame = v115 * p112.Config.TripwireCFrameOffset
	return v116, v117
end
return v1
