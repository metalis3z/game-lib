-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {}
local v_u_2 = require(game.ReplicatedStorage.Modules.Sounds)
local v_u_3 = require(game.ReplicatedStorage.Modules.Util)
require(game.ReplicatedStorage.Modules.Hitboxes)
local v_u_4 = require(game.ReplicatedStorage.Modules.Statuses)
require(game.ReplicatedStorage.Modules.Network)
local function v_u_15(p5, p6)
	-- upvalues: (copy) v_u_2
	if not p6:GetAttribute("Destroyed") then
		p6:SetAttribute("Destroyed", true)
		for _, v7 in pairs(p6:GetDescendants()) do
			if v7:IsA("WeldConstraint") or v7:IsA("JointInstance") then
				v7:Destroy()
			elseif v7:IsA("ParticleEmitter") or v7:IsA("Light") then
				v7.Enabled = false
			end
		end
		for _, v8 in pairs(p6:GetDescendants()) do
			if v8:IsA("Sound") then
				game.TweenService:Create(v8, TweenInfo.new(0.25), {
					["Volume"] = 0
				}):Play()
			end
		end
		if p5 then
			local v9 = string.gsub(p6.Name, "Builderman", "")
			v_u_2:Play(p5.Config.Sounds[("%*Destroyed"):format(v9)], {
				["Parent"] = p6.PrimaryPart
			})
			v_u_2:PlayVoiceline(p5, ("%*Destroyed"):format(v9), {
				["Priority"] = 4
			})
		end
		for _, v_u_10 in pairs(p6:GetChildren()) do
			if v_u_10:IsA("BasePart") and v_u_10.Transparency <= 0.5 then
				local v_u_11 = Instance.new("Fire")
				v_u_11.Parent = v_u_10
				v_u_11.Heat = v_u_10.Size.Magnitude / 5
				v_u_11.Size = v_u_10.Size.Magnitude
				v_u_10.CanCollide = true
				task.delay(math.random(400, 600) / 100, function()
					-- upvalues: (copy) v_u_10, (copy) v_u_11
					game.TweenService:Create(v_u_10, TweenInfo.new(3), {
						["Transparency"] = 1
					}):Play()
					game.TweenService:Create(v_u_11, TweenInfo.new(2), {
						["Heat"] = 0,
						["Size"] = 0
					}):Play()
					task.wait(1)
					v_u_11.Enabled = false
				end)
			end
		end
		local v12 = {}
		for _, v13 in pairs(workspace.Map.Ingame:GetChildren()) do
			if v13.Name == p6.Name and not v13:GetAttribute("Destroyed") then
				table.insert(v12, v13)
			end
		end
		for _, v14 in pairs(v12) do
			v14:SetAttribute("BuildingCount", #v12)
		end
		game.Debris:AddItem(p6, 10)
	end
end
local function v_u_79(p_u_16, p_u_17, p_u_18)
	-- upvalues: (copy) v_u_15, (copy) v_u_3, (copy) v_u_2
	p_u_16.AbilitiesDisabled = true
	local function v_u_30(p19)
		-- upvalues: (copy) p_u_16, (copy) p_u_17
		local v20 = workspace:GetPartBoundsInRadius(p19.Position, 1)
		for _, v21 in pairs(v20) do
			if v21.Transparency < 0.9 or v21.Name == "UnplacableArea" then
				p_u_16:SetCooldownOf(p_u_17, 0)
				return "collision"
			end
		end
		for _, v22 in pairs(workspace.Map.Ingame:GetChildren()) do
			if v22.Name:find("Builderman") and not v22:GetAttribute("Destroyed") then
				local v23 = string.gsub(v22.Name, "Builderman", "")
				local v24 = p_u_16.Config[("%*PlacementRadius"):format(v23)] or p_u_16.Config[("%*PlacementRadius"):format(p_u_17)]
				if (p19.Position - v22.PrimaryPart.Position).Magnitude <= v24 / 2 then
					p_u_16:SetCooldownOf(p_u_17, 0)
					return "tooClose"
				end
			end
		end
		for _, v25 in pairs(workspace.Players.Survivors:GetChildren()) do
			local v26 = v25:GetAttribute("PlacementRadius")
			local v27 = v25.PrimaryPart
			if v25 ~= p_u_16.Rig and (v26 and (v27 and p19.Position - v27.Position <= v26 / 2)) then
				p_u_16:SetCooldownOf(p_u_17, 0)
				return "tooClose"
			end
		end
		local v28 = RaycastParams.new()
		v28.FilterType = Enum.RaycastFilterType.Exclude
		v28.FilterDescendantsInstances = { workspace.Players }
		local v29 = workspace:Raycast(p19.Position, Vector3.new(0, -4, 0), v28)
		if not v29 then
			p_u_16:SetCooldownOf(p_u_17, 0)
			return "midair"
		end
		if v29 and v29.Instance.Name == "Conveyor" then
			p_u_16:SetCooldownOf(p_u_17, 0)
			return "collision"
		end
		if workspace:Raycast(p_u_16.Rig.PrimaryPart.Position, p_u_16.Rig.PrimaryPart.CFrame.LookVector * p_u_16.Config[("%*PositionOffset"):format(p_u_17)], v28) then
			p_u_16:SetCooldownOf(p_u_17, 0)
			return "facingWall"
		end
		p_u_16.Rig:SetAttribute("PlacementRadius", p_u_16.Config[("%*PlacementRadius"):format(p_u_17)] or 70)
		return "placed"
	end
	local v_u_31 = p_u_16.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -p_u_16.Config[("%*PositionOffset"):format(p_u_17)])
	local v32 = v_u_30(v_u_31)
	if v32 ~= "placed" then
		p_u_16.AbilitiesDisabled = false
		return {
			["Cancelled"] = true,
			["Reason"] = v32
		}
	end
	for _, v33 in pairs(p_u_16.Rig:GetChildren()) do
		if v33.Name:find("Wrench") or v33.Name:find("Hammer") then
			v33.Transparency = 0
		end
	end
	local v_u_34 = p_u_16.Config[("%*Template"):format(p_u_17)]:Clone()
	local v35 = p_u_16.Player
	v_u_34:SetAttribute("OwnerName", (tostring(v35)))
	v_u_34:SetAttribute("Team", "Survivors")
	v_u_34.Humanoid.Health = p_u_16.Config[("%*Health"):format(p_u_17)]
	v_u_34.Name = ("Builderman%*"):format(p_u_17)
	v_u_34.Parent = workspace.Map.Ingame
	local v36 = p_u_16.Config[("%*Limit"):format(p_u_17)]
	if not p_u_16[("Constructed%*"):format(p_u_17)] then
		p_u_16[("Constructed%*"):format(p_u_17)] = {}
	end
	if v36 <= #p_u_16[("Constructed%*"):format(p_u_17)] then
		v_u_15(p_u_16, p_u_16[("Constructed%*"):format(p_u_17)][1])
		table.remove(p_u_16[("Constructed%*"):format(p_u_17)], 1)
	end
	local v37 = p_u_16[("Constructed%*"):format(p_u_17)]
	table.insert(v37, v_u_34)
	local v38 = {}
	for _, v39 in pairs(workspace.Map.Ingame:GetChildren()) do
		if v39.Name == ("Builderman%*"):format(p_u_17) and not v39:GetAttribute("Destroyed") then
			table.insert(v38, v39)
		end
	end
	for _, v40 in pairs(v38) do
		v40:SetAttribute("BuildingCount", #v38)
	end
	for _, v41 in pairs(v_u_34:GetDescendants()) do
		if v41:IsA("BasePart") and v41.Transparency ~= 1 then
			v41:SetAttribute("Hidden", true)
			v41.Transparency = 1
		end
	end
	local v_u_42 = {}
	for v43, v44 in pairs(p_u_16.Config[("%*Animations"):format(p_u_17)]) do
		v_u_42[v43] = v_u_3:LoadAnimationFromID(v_u_34, v44)
	end
	p_u_16:ChangeExpression("Concentrating")
	local v_u_45 = nil
	local v_u_46 = p_u_16.Rig.Humanoid.Health
	local v_u_48 = p_u_16.Rig.Humanoid.HealthChanged:Connect(function(p47)
		-- upvalues: (ref) v_u_46, (ref) v_u_45
		if p47 < v_u_46 then
			v_u_45 = "failed"
		end
		v_u_46 = p47
	end)
	local v_u_49 = v_u_34.Humanoid.HealthChanged:Connect(function(_)
		-- upvalues: (ref) v_u_45
		v_u_45 = "failed"
	end)
	v_u_2:Play(p_u_16.Config.Sounds[("%*Building"):format(p_u_17)], {
		["Parent"] = v_u_34.PrimaryPart
	})
	v_u_2:PlayVoiceline(p_u_16, ("%*Constructing"):format(p_u_17), {
		["Priority"] = 2
	})
	task.delay(1.25, function()
		-- upvalues: (ref) v_u_45, (copy) p_u_16, (copy) v_u_34, (copy) v_u_42, (copy) p_u_17, (copy) v_u_30, (copy) v_u_31
		if v_u_45 then
			return
		end
		if not p_u_16.Rig.PrimaryPart then
			return
		end
		for _, v50 in pairs(v_u_34:GetDescendants()) do
			if v50:GetAttribute("Hidden") then
				game.TweenService:Create(v50, TweenInfo.new(1), {
					["Transparency"] = 0
				}):Play()
			end
		end
		v_u_42.Construction:Play(0)
		v_u_42.Construction.Stopped:Connect(function()
			-- upvalues: (ref) v_u_42
			v_u_42.Idle:Play(0)
		end)
		local v51 = p_u_16.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -p_u_16.Config[("%*PositionOffset"):format(p_u_17)])
		if v_u_30(v51) ~= "placed" then
			v51 = v_u_31
		end
		local v52 = RaycastParams.new()
		v52.FilterType = Enum.RaycastFilterType.Exclude
		v52.FilterDescendantsInstances = { workspace.Players }
		local v53 = workspace:Raycast(v51.Position, Vector3.new(0, -100, 0), v52)
		local v56
		if v53 then
			local v54 = v53.Position
			local v55 = v_u_34.PrimaryPart.Size.Y / 2
			v56 = v54 + Vector3.new(0, v55, 0)
		else
			v56 = (v51 - Vector3.new(0, 1.5, 0)).Position
		end
		if v56 then
			--::l16::
			v_u_34:SetPrimaryPartCFrame(CFrame.new(v56) * v51.Rotation)
			p_u_16.Rig:SetAttribute("PlacementRadius", nil)
			return
		end
		--goto l16
	end)
	task.delay(p_u_16.Config[("%*ConstructionDuration"):format(p_u_17)], function()
		-- upvalues: (ref) v_u_45
		if not v_u_45 then
			v_u_45 = "constructed"
		end
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_45, (copy) p_u_16, (copy) p_u_18, (copy) v_u_34, (copy) v_u_42, (ref) v_u_2, (copy) p_u_17, (ref) v_u_15, (ref) v_u_48, (ref) v_u_49
		repeat
			task.wait()
		until v_u_45
		for _, v57 in pairs(p_u_16.Rig:GetChildren()) do
			if v57.Name:find("Wrench") or v57.Name:find("Hammer") then
				v57.Transparency = 1
			end
		end
		p_u_16:ChangeExpression("Default")
		p_u_16.Rig:SetAttribute("PlacementRadius", nil)
		if v_u_45 == "constructed" then
			p_u_18(v_u_34, v_u_42)
			v_u_34:SetAttribute("HitboxPriority", 0)
			v_u_2:PlayVoiceline(p_u_16, ("%*Constructed"):format(p_u_17), {
				["Priority"] = 3
			})
			local v58 = p_u_16.Config.Sounds[("%*BuildingCompleted"):format(p_u_17)]
			local v59 = v58 and v_u_2:Play(v58, {
				["Parent"] = v_u_34.PrimaryPart,
				["Volume"] = 0.5
			})
			if v59 then
				local v60 = v59.Parent
				if tostring(v60) == "Sounds" then
					v59:Destroy()
				end
			end
			if v_u_34.PrimaryPart then
				local v61 = v_u_2:Play(p_u_16.Config.Sounds[("%*Idle"):format(p_u_17)], {
					["Parent"] = v_u_34.PrimaryPart,
					["Volume"] = 0,
					["Looped"] = true
				})
				if v61 then
					game.TweenService:Create(v61, TweenInfo.new(0.5), {
						["Volume"] = 0.5
					}):Play()
				end
				if v61 then
					local v62 = v61.Parent
					if tostring(v62) == "Sounds" then
						v61:Destroy()
					end
				end
			end
			for _, v63 in pairs(v_u_34:GetDescendants()) do
				if (v63:IsA("ParticleEmitter") or v63:IsA("Light")) and v63.Name ~= "Shoot" then
					v63.Enabled = true
				end
			end
			v_u_34.Humanoid.Died:Connect(function()
				-- upvalues: (ref) v_u_34, (ref) p_u_16, (ref) p_u_17, (ref) v_u_15
				local v64 = v_u_34:GetAttribute("DamageDealt") or v_u_34:GetAttribute("TotalHealed") or 0
				local v65 = require(game.ReplicatedStorage.Modules.Actors)
				v65:IncrementActorStats(p_u_16.Player, {
					["Action"] = ("%* Destroyed by Killer"):format(p_u_17),
					["RewardType"] = "Survivalist"
				})
				local v66 = p_u_17
				local v67
				if v66 == "Sentry" then
					local v68 = v64 ^ 0.5 * 1.2
					local v69 = math.clamp(v68, 0, 20)
					v67 = math.ceil(v69)
				elseif v66 == "Dispenser" then
					local v70 = v64 ^ 0.95 * 0.35
					local v71 = math.clamp(v70, 0, 20)
					v67 = math.ceil(v71)
				else
					v67 = nil
				end
				if v67 > 0 then
					local v72 = p_u_16.Player
					local v73 = {}
					local v74 = p_u_17 == "Sentry" and "Dealt" or "Healed"
					local v75 = math.ceil(v64)
					v73.Action = ("%* %* %* with %*"):format(v74, tostring(v75), p_u_17 == "Sentry" and "damage" or "health", p_u_17)
					v73.Money = v67
					local v76 = v67 * 0.5
					v73.EXP = math.ceil(v76)
					v65:IncrementActorStats(v72, v73)
				end
				v_u_15(p_u_16, v_u_34)
			end)
		else
			v_u_15(p_u_16, v_u_34)
		end
		v_u_48:Disconnect()
		v_u_48 = nil
		v_u_49:Disconnect()
		v_u_49 = nil
		local v77 = Instance.new("StringValue")
		local v78 = v_u_45
		v77.Value = tostring(v78)
		v77.Name = "Result"
		v77.Parent = p_u_16.Rig
		game.Debris:AddItem(v77, 1)
		task.delay(2, function()
			-- upvalues: (ref) p_u_16
			p_u_16.AbilitiesDisabled = false
		end)
	end)
end
local function v_u_88(p_u_80, p81, p82)
	-- upvalues: (copy) v_u_3
	if typeof(p82) == "table" and p82.Cancelled then
		local v83 = {
			["collision"] = "Building area is obstructed by something. Build somewhere else.",
			["tooClose"] = "Building area is too close to a pre-existing building. Move further away and try again.",
			["midair"] = "Building area is too high above ground. Turn around and try again.",
			["facingWall"] = "You\'re too close to a wall. Turn around and try again.",
			["unknown"] = "Something went wrong. Try building somewhere else."
		}
		v_u_3:CreateWarning("BuildermanWarning", v83[p82.Reason] or v83.unknown, p_u_80.Config.WarningTemplate)
	else
		local v_u_84 = true
		p_u_80.Animations.ConstructStart:Play()
		task.delay(0.75, function()
			-- upvalues: (ref) v_u_84, (copy) p_u_80
			if v_u_84 then
				p_u_80.Animations.ConstructStart:Stop()
				p_u_80.Animations.ConstructLoop:Play()
			end
		end)
		local v85 = v_u_3:CreateProgressBar(("Building %*"):format(p81), p_u_80.Config[("%*ConstructionDuration"):format(p81)])
		local v86 = v_u_3:CreateSpeedMultiplier(p_u_80.Rig, 0, (("%*Construction"):format(p81)))
		local v87 = p_u_80.Rig:WaitForChild("Result", p_u_80.Config[("%*ConstructionDuration"):format(p81)] + 3)
		local _ = v87 and v87.Value or "IDK"
		v_u_84 = false
		p_u_80.Animations.ConstructStart:Stop()
		p_u_80.Animations.ConstructLoop:Stop()
		v85:Destroy()
		p_u_80.Animations.ConstructEnd:Play()
		game.TweenService:Create(v86, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
			["Value"] = 1
		}):Play()
		game.Debris:AddItem(v86, 1)
	end
end
local v134 = {
	["Sentry"] = {
		["LayoutOrder"] = 1,
		["KeybindType"] = "AltAbility1",
		["Icon"] = "rbxassetid://104441527277654",
		["Callback"] = function(p_u_89, p90)
			-- upvalues: (copy) v_u_79, (copy) v_u_3, (copy) v_u_2, (copy) v_u_4, (copy) v_u_88
			if game["Run Service"]:IsServer() then
				return v_u_79(p_u_89, "Sentry", function(p_u_91, p_u_92)
					-- upvalues: (copy) p_u_89, (ref) v_u_3, (ref) v_u_2, (ref) v_u_4
					task.spawn(function()
						-- upvalues: (copy) p_u_91, (ref) p_u_89, (ref) v_u_3, (ref) v_u_2, (copy) p_u_92, (ref) v_u_4
						local v93 = p_u_91.Torso.Neck.C0
						local v94 = RaycastParams.new()
						v94.FilterType = Enum.RaycastFilterType.Exclude
						v94.FilterDescendantsInstances = { p_u_91 }
						local v95 = false
						local v96 = 0
						while p_u_91.Parent do
							local v97 = task.wait(0.2)
							local _ = p_u_91.PrimaryPart
							if not p_u_91.Parent then
								return
							end
							if not p_u_91.PrimaryPart then
								return
							end
							if p_u_91:GetAttribute("Destroyed") then
								return
							end
							local v98 = (p_u_91:GetAttribute("BuildingCount") or 1) - 1
							local v99 = p_u_89.Config.SentryDamageRadius / 2
							local v100 = v99 * (1 - v98 * p_u_89.Config.SentryRangeReductionPercentage / 100)
							local v101 = p_u_89.Config.SentryMinimumRange
							local v102 = math.clamp(v100, v101, v99)
							if p_u_91:GetAttribute("EffectRadiusSize") ~= v102 then
								p_u_91:SetAttribute("EffectRadiusSize", v102)
							end
							local v103 = v_u_3:GetClosestPlayerFromPosition(p_u_91.PrimaryPart.Position, {
								["PlayerSelection"] = "Killers",
								["MaxDistance"] = v102
							})
							if v103 and (v103.PrimaryPart and v103.Humanoid.Health > 0) then
								local v104 = p_u_91.PrimaryPart.Position
								local v105 = CFrame.lookAt(v104, v103.PrimaryPart.Position).LookVector
								local v106 = workspace:Raycast(v104, v105 * v102, v94)
								if v106 then
									if v106.Instance:IsDescendantOf(v103) then
										if not v95 then
											v_u_2:Play(p_u_89.Config.Sounds.SentryTargeted, {
												["Parent"] = p_u_91.PrimaryPart
											})
											v95 = true
										end
										local v107 = CFrame.lookAt(p_u_91.Head.Position, v103.PrimaryPart.Position, p_u_91.Torso.CFrame.UpVector)
										local v108 = game.TweenService
										local v109 = p_u_91.Torso.Neck
										local v110 = TweenInfo.new(0.5)
										local v111 = {}
										local v112 = p_u_91.Torso.Neck
										local v113 = v112.Part1.CFrame
										local v114 = v112.C1
										local v115 = v112.C0
										local v116 = v115 * v114:Inverse() * v113:Inverse() * v107 * v114
										v111.C0 = (v116 - v116.Position + v115.Position) * CFrame.Angles(-1.5707963267948966, 0, 0)
										v108:Create(v109, v110, v111):Play()
										if p_u_92.Shoot then
											p_u_92.Shoot:Play(0)
										end
										v_u_2:Play(p_u_89.Config.Sounds.SentryShoot, {
											["Parent"] = p_u_91.PrimaryPart
										})
										for _, v_u_117 in pairs(p_u_91:GetDescendants()) do
											if (v_u_117:IsA("ParticleEmitter") or v_u_117:IsA("Light")) and v_u_117.Name == "Shoot" then
												task.spawn(function()
													-- upvalues: (copy) v_u_117
													v_u_117.Enabled = true
													task.wait(0.05)
													v_u_117.Enabled = false
												end)
											end
										end
										local v118 = v103:FindFirstChild("Humanoid")
										if v118 then
											local v119 = p_u_89.Config.SentryDamagePerSec * v97
											v118.Health = v118.Health - v119
											v96 = v96 + v119
										end
										p_u_91:SetAttribute("DamageDealt", v96)
										v_u_4:ApplyStatus(v103, "Slowness", {
											["Duration"] = p_u_89.Config.SentrySlownessDuration,
											["Level"] = p_u_89.Config.SentrySlownessLevel
										})
									else
										v95 = false
									end
								end
							else
								game.TweenService:Create(p_u_91.Torso.Neck, TweenInfo.new(0.5), {
									["C0"] = v93
								}):Play()
								v95 = false
							end
						end
					end)
				end)
			end
			if game["Run Service"]:IsClient() then
				v_u_88(p_u_89, "Sentry", p90)
			end
		end
	},
	["Dispenser"] = {
		["LayoutOrder"] = 2,
		["KeybindType"] = "AltAbility2",
		["Icon"] = "rbxassetid://102952736333903",
		["Callback"] = function(p_u_120, p121)
			-- upvalues: (copy) v_u_79, (copy) v_u_3, (copy) v_u_88
			if game["Run Service"]:IsServer() then
				return v_u_79(p_u_120, "Dispenser", function(p_u_122)
					-- upvalues: (copy) p_u_120, (ref) v_u_3
					task.spawn(function()
						-- upvalues: (copy) p_u_122, (ref) p_u_120, (ref) v_u_3
						task.delay(120, function()
							-- upvalues: (ref) p_u_122, (ref) p_u_120
							if p_u_122.Parent and not p_u_122:GetAttribute("Destroyed") then
								require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(p_u_120.Player, "BuildermanDispenser")
							end
						end)
						local v123 = 0
						while p_u_122.Parent do
							local v124 = game["Run Service"].Heartbeat:Wait()
							if not p_u_122.Parent then
								return
							end
							if not p_u_122.PrimaryPart then
								return
							end
							if p_u_122:GetAttribute("Destroyed") then
								return
							end
							local v125 = (p_u_122:GetAttribute("BuildingCount") or 1) - 1
							local v126 = p_u_120.Config.DispenserHealingPerSec
							local v127 = v126 * (1 - v125 * p_u_120.Config.DispenserHealingReductionPercentage / 100)
							local v128 = p_u_120.Config.DispenserMinimumHealing
							math.clamp(v127, v128, v126)
							local v129 = v_u_3:GetClosestPlayerFromPosition(p_u_122.PrimaryPart.Position, {
								["PlayerSelection"] = "Survivors",
								["MaxDistance"] = p_u_120.Config.DispenserHealingRadius / 2,
								["ReturnTable"] = true
							})
							for _, v130 in pairs(v129 or {}) do
								local v131 = v130.Player
								if v131 then
									v131 = v131:FindFirstChild("Humanoid")
								end
								if v131 then
									local v132 = v131.MaxHealth - v131.Health
									v_u_3:Heal(v131, v126 * v124)
									local v133 = v126 * v124
									v123 = v123 + math.min(v132, v133)
								end
							end
							p_u_122:SetAttribute("TotalHealed", v123)
						end
					end)
				end)
			end
			if game["Run Service"]:IsClient() then
				v_u_88(p_u_120, "Dispenser", p121)
			end
		end
	}
}
v1.Abilities = v134
function v1.Created(_, p_u_135)
	-- upvalues: (copy) v_u_15
	if game["Run Service"]:IsServer() then
		p_u_135.Rig.Humanoid.Died:Connect(function()
			-- upvalues: (copy) p_u_135, (ref) v_u_15
			for _, v136 in pairs(workspace.Map.Ingame:GetChildren()) do
				if v136.Name:find("Builderman") then
					local v137 = v136:GetAttribute("OwnerName")
					local v138 = p_u_135.Player
					if v137 == tostring(v138) then
						v_u_15(p_u_135, v136)
					end
				end
			end
		end)
	elseif game["Run Service"]:IsClient() and p_u_135.Rig == game.Players.LocalPlayer.Character then
		p_u_135.RadiusStorages = {}
		local v139 = Color3.fromRGB(70, 155, 255)
		local v140 = Instance.new("Model")
		v140.Parent = workspace.Map.Ingame
		v140.Name = "PlacementRange"
		p_u_135.RadiusStorages.PlacementRange = v140
		local v141 = Instance.new("Highlight")
		v141.DepthMode = Enum.HighlightDepthMode.Occluded
		v141.FillTransparency = 0.875
		v141.OutlineTransparency = 0.6
		v141.FillColor = v139
		v141.Parent = v140
		local v142 = Color3.fromRGB(255, 80, 80)
		local v143 = Instance.new("Model")
		v143.Parent = workspace.Map.Ingame
		v143.Name = "BuildermanSentryEffectRange"
		p_u_135.RadiusStorages.BuildermanSentryEffectRange = v143
		local v144 = Instance.new("Highlight")
		v144.DepthMode = Enum.HighlightDepthMode.Occluded
		v144.FillTransparency = 0.875
		v144.OutlineTransparency = 0.6
		v144.FillColor = v142
		v144.Parent = v143
		local v145 = Color3.fromRGB(80, 255, 80)
		local v146 = Instance.new("Model")
		v146.Parent = workspace.Map.Ingame
		v146.Name = "BuildermanDispenserEffectRange"
		p_u_135.RadiusStorages.BuildermanDispenserEffectRange = v146
		local v147 = Instance.new("Highlight")
		v147.DepthMode = Enum.HighlightDepthMode.Occluded
		v147.FillTransparency = 0.875
		v147.OutlineTransparency = 0.6
		v147.FillColor = v145
		v147.Parent = v146
		local function v_u_152(p148, p149)
			-- upvalues: (copy) p_u_135
			local v150 = p_u_135.RadiusStorages[p148]
			if v150 then
				if p149 then
					local v151 = Instance.new("Part")
					v151.CanCollide = false
					v151.Anchored = true
					v151.Transparency = 1
					v151.Position = Vector3.new(0, -100, 0)
					v151.Orientation = Vector3.new(0, 0, 90)
					v151.Size = Vector3.new(0.25, p149, p149)
					v151.Material = Enum.Material.Glass
					v151.Shape = Enum.PartType.Cylinder
					v151.Parent = v150
					return v151
				end
			end
		end
		p_u_135.Connection = workspace.Map.Ingame.ChildAdded:Connect(function(p_u_153)
			-- upvalues: (copy) p_u_135, (copy) v_u_152
			if p_u_153.Name:find("Builderman") then
				local v154 = p_u_153:WaitForChild("Humanoid", 10)
				if not v154 then
					return
				end
				local v_u_155 = p_u_153:WaitForChild("Root", 10)
				if not v_u_155 then
					return
				end
				local v156 = {
					["BuildermanSentryPlacementRange"] = p_u_135.Config.SentryPlacementRadius,
					["BuildermanSentryEffectRange"] = p_u_135.Config.SentryDamageRadius,
					["BuildermanDispenserPlacementRange"] = p_u_135.Config.DispenserPlacementRadius,
					["BuildermanDispenserEffectRange"] = p_u_135.Config.DispenserHealingRadius
				}
				local v157 = ("%*PlacementRange"):format(p_u_153.Name)
				local v158 = ("%*EffectRange"):format(p_u_153.Name)
				local v_u_159 = v_u_152("PlacementRange", v156[v157])
				local v_u_160 = v_u_152(v158, v156[v158])
				v_u_155:GetPropertyChangedSignal("Position"):Connect(function()
					-- upvalues: (copy) v_u_159, (copy) v_u_155, (copy) v_u_160
					if v_u_159 then
						local v161 = v_u_159
						local v162 = v_u_155.Position
						local v163 = v_u_155.Size.Y / 2 + 0.075
						v161.Position = v162 - Vector3.new(0, v163, 0)
					end
					if v_u_160 then
						local v164 = v_u_160
						local v165 = v_u_155.Position
						local v166 = v_u_155.Size.Y / 2 + 0
						v164.Position = v165 - Vector3.new(0, v166, 0)
					end
				end)
				p_u_153:GetAttributeChangedSignal("EffectRadiusSize"):Connect(function()
					-- upvalues: (copy) p_u_153, (copy) v_u_160
					local v167 = p_u_153:GetAttribute("EffectRadiusSize")
					if v_u_160 then
						local v168 = game.TweenService
						local v169 = v_u_160
						local v170 = TweenInfo.new(1)
						local v171 = {}
						local v172 = v167 * 2
						local v173 = v167 * 2
						v171.Size = Vector3.new(0.25, v172, v173)
						v168:Create(v169, v170, v171):Play()
					end
				end)
				v154.HealthChanged:Connect(function(p174)
					-- upvalues: (copy) v_u_159, (copy) v_u_160
					if p174 <= 0 then
						if v_u_159 then
							v_u_159:Destroy()
						end
						if v_u_160 then
							v_u_160:Destroy()
						end
					end
				end)
				p_u_153.AncestryChanged:Connect(function(_, p175)
					-- upvalues: (copy) v_u_159, (copy) v_u_160
					if not p175 then
						if v_u_159 then
							v_u_159:Destroy()
						end
						if v_u_160 then
							v_u_160:Destroy()
						end
					end
				end)
			end
		end)
		p_u_135.Rig.AncestryChanged:Connect(function(_, p176)
			-- upvalues: (copy) p_u_135
			if not p176 then
				if p_u_135.Connection then
					p_u_135.Connection:Disconnect()
				end
				for _, v177 in pairs(p_u_135.RadiusStorages) do
					v177:Destroy()
				end
			end
		end)
	end
end
return v1
