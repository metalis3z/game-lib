-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {}
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("Players")
local v_u_4 = require(game.ReplicatedStorage.Modules.Sounds)
local v_u_5 = require(game.ReplicatedStorage.Modules.Util)
local v_u_6 = require(game.ReplicatedStorage.Modules.Hitboxes)
local v_u_7 = require(game.ReplicatedStorage.Modules.Statuses)
local v_u_8 = require(game.ReplicatedStorage.Modules.Network)
local v_u_9 = require(game.ReplicatedStorage.Modules.AchievementUtil)
local v104 = {
	["Slash"] = {
		["LayoutOrder"] = 1,
		["Icon"] = "rbxassetid://92362553672440",
		["KeybindType"] = "MainAbility",
		["Callback"] = function(p_u_10)
			-- upvalues: (copy) v_u_4, (copy) v_u_6, (copy) v_u_5
			if game["Run Service"]:IsServer() then
				p_u_10.AbilitiesDisabled = true
				v_u_4:Play(p_u_10.Config.Sounds.Swing, {
					["Parent"] = p_u_10.Rig.PrimaryPart,
					["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
					["Volume"] = 0.35
				})
				task.delay(p_u_10.Config.SlashWindup, function()
					-- upvalues: (ref) v_u_6, (copy) p_u_10, (ref) v_u_5, (ref) v_u_4
					local v11 = v_u_6
					local v12 = p_u_10.Player
					local v15 = {
						["Size"] = Vector3.new(4.5, 6, 7.5),
						["CFrameOffset"] = CFrame.new(0, 0, -1.25),
						["Damage"] = p_u_10.Config.SlashDamage,
						["Time"] = p_u_10.Config.SlashLinger,
						["Knockback"] = 2,
						["HitMultiple"] = false,
						["ExecuteOnKill"] = true,
						["Connections"] = {
							["Hit"] = function(p13, p14)
								-- upvalues: (ref) v_u_5, (ref) v_u_4, (ref) p_u_10
								v_u_5:CreateSpeedMultiplier(p13, 1.5, "HitSpeedBonus", 1.25)
								if p14 then
									v_u_4:Play(p_u_10.Config.Sounds.Hit, {
										["Parent"] = p_u_10.Rig.PrimaryPart,
										["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
										["Volume"] = 0.5
									})
								end
							end
						}
					}
					v11:CreateHitbox(v12, v15)
				end)
				task.delay(0.75, function()
					-- upvalues: (copy) p_u_10
					p_u_10.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_10.Animations.Slash:Play(0.025)
			end
		end
	},
	["CorruptEnergy"] = {
		["LayoutOrder"] = 2,
		["Icon"] = "rbxassetid://83849304758564",
		["KeybindType"] = "AltAbility1",
		["Callback"] = function(p_u_16)
			-- upvalues: (copy) v_u_4, (copy) v_u_6, (copy) v_u_9, (copy) v_u_5, (copy) v_u_7
			if game["Run Service"]:IsServer() then
				p_u_16.AbilitiesDisabled = true
				v_u_4:Play(p_u_16.Config.Sounds.CorruptEnergy, {
					["Parent"] = p_u_16.Rig.PrimaryPart,
					["Volume"] = 0.4,
					["TimePosition"] = 0.09,
					["PlaybackSpeed"] = 1.2
				})
				p_u_16.Config.StunDuration = p_u_16.Config.UnstoppableDuration
				local v_u_17 = RaycastParams.new()
				v_u_17.FilterDescendantsInstances = { workspace.Players }
				v_u_17.FilterType = Enum.RaycastFilterType.Exclude
				local v_u_18 = false
				local v_u_19 = p_u_16.Rig:GetAttributeChangedSignal("Stunned"):Once(function()
					-- upvalues: (ref) v_u_18
					v_u_18 = true
				end)
				local v_u_20 = {}
				task.delay(2, function()
					-- upvalues: (copy) p_u_16, (ref) v_u_18, (copy) v_u_17, (ref) v_u_4, (ref) v_u_6, (ref) v_u_9, (ref) v_u_5, (ref) v_u_7, (copy) v_u_20
					for v_u_21 = 1, p_u_16.Config.SpikeAmount do
						task.delay(v_u_21 * p_u_16.Config.DelayBetweenSpikeSummons, function()
							-- upvalues: (ref) v_u_18, (ref) p_u_16, (copy) v_u_21, (ref) v_u_17, (ref) v_u_4, (ref) v_u_6, (ref) v_u_9, (ref) v_u_5, (ref) v_u_7, (ref) v_u_20
							if v_u_18 then
								return
							elseif p_u_16.Rig.PrimaryPart then
								if p_u_16.Rig:GetAttribute("Stunned") then
									v_u_18 = true
								else
									local v22 = (p_u_16:GetPivot() * CFrame.new(0, 0, -p_u_16.Config.DistanceBetweenSpikes * v_u_21)).Position
									local v23 = workspace:Raycast(v22, Vector3.new(0, -100, 0), v_u_17) or workspace:Raycast(v22, Vector3.new(0, 100, 0), v_u_17)
									if v23 and v23.Position then
										local v_u_24 = p_u_16.Config.Spike:Clone()
										v_u_24:GetPivot()
										local v_u_25 = p_u_16.Config.SpikeHitboxSize * 0.8
										local v26 = Instance.new("Part")
										v26.Size = v_u_25
										local v27 = v_u_24.PrimaryPart.CFrame
										local v28 = v_u_25.Y / 2
										v26.CFrame = v27 + vector.create(0, v28, 0)
										v26.CanTouch = false
										v26.Transparency = 1
										v26.Name = "BOX_COLLISION"
										v26.Parent = v_u_24
										local v29 = Instance.new("WeldConstraint")
										v29.Part0 = v_u_24.PrimaryPart
										v29.Part1 = v26
										v29.Parent = v_u_24.PrimaryPart
										v_u_24.Parent = workspace.Map.Ingame
										local v30 = CFrame.new(v23.Position)
										local v31 = CFrame.Angles
										local v32 = math.random(0, 360)
										local v33 = v30 * v31(3.141592653589793, math.rad(v32), 0)
										local v34 = v_u_25.Y
										v_u_24:SetPrimaryPartCFrame(v33 - Vector3.new(0, v34, 0))
										local v35 = v_u_24:GetChildren()
										table.insert(v35, v_u_24)
										for _, v36 in ipairs(v35) do
											if v36:IsA("BasePart") and (v36.CanCollide and v36.Name ~= "BOX_COLLISION") then
												v36.CanQuery = false
												v36.CanTouch = false
												v36.CustomPhysicalProperties = p_u_16.Config.SpikeProperties
											end
										end
										local v37 = game.TweenService
										local v38 = v_u_24.PrimaryPart
										local v39 = TweenInfo.new(0.1)
										local v40 = {}
										local v41 = v_u_24.PrimaryPart.CFrame
										local v42 = v_u_25.Y
										v40.CFrame = v41 + Vector3.new(0, v42, 0)
										v37:Create(v38, v39, v40):Play()
										v_u_4:Play(p_u_16.Config.Sounds.CorruptEnergySummon, {
											["Parent"] = v_u_24.PrimaryPart,
											["PlaybackSpeed"] = Random.new():NextNumber(0.8, 1.2),
											["Volume"] = 0.25,
											["TimePosition"] = 0.02
										})
										task.delay(0.1, function()
											-- upvalues: (ref) p_u_16, (copy) v_u_24
											local v43 = p_u_16.CurrentSpikes or {}
											local v44 = v_u_24
											table.insert(v43, v44)
										end)
										for _, v45 in pairs(v_u_24:GetDescendants()) do
											if v45:IsA("ParticleEmitter") and v45.Name == "Number" then
												v45.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, p_u_16.Config.SpikeNumbersColor), ColorSequenceKeypoint.new(1, p_u_16.Config.SpikeNumbersColor) })
											end
										end
										task.delay(p_u_16.Config.SpikeLifetime, function()
											-- upvalues: (copy) v_u_24, (copy) v_u_25, (ref) v_u_4, (ref) p_u_16
											game.Debris:AddItem(v_u_24, 2.5)
											if v_u_24.PrimaryPart then
												local v46 = game.TweenService
												local v47 = v_u_24.PrimaryPart
												local v48 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
												local v49 = {}
												local v50 = v_u_24.PrimaryPart.CFrame
												local v51 = v_u_25.Y * 2
												v49.CFrame = v50 - Vector3.new(0, v51, 0)
												v46:Create(v47, v48, v49):Play()
												v_u_4:Play(p_u_16.Config.Sounds.CorruptEnergyDesummon, {
													["Parent"] = v_u_24.PrimaryPart,
													["PlaybackSpeed"] = Random.new():NextNumber(0.9, 1.1),
													["Volume"] = 0.1,
													["TimePosition"] = 0.02
												})
												task.delay(1, function()
													-- upvalues: (ref) p_u_16, (ref) v_u_24
													local v52 = table.find(p_u_16.CurrentSpikes or {}, v_u_24)
													if v52 then
														table.remove(p_u_16.CurrentSpikes or {}, v52)
													end
												end)
											end
										end)
										v_u_6:CreateHitbox(p_u_16.Player, {
											["Size"] = v_u_25,
											["CFrame"] = function()
												-- upvalues: (copy) v_u_24, (copy) v_u_25
												local v53 = v_u_24.PrimaryPart.CFrame
												local v54 = v_u_25.Y / 2
												return v53 + Vector3.new(0, v54, 0)
											end,
											["Damage"] = p_u_16.Config.CorruptEnergyDamage,
											["Time"] = 0.15,
											["Knockback"] = 5,
											["HitMultiple"] = true,
											["PredictVelocity"] = false,
											["Connections"] = {
												["Hit"] = function(p55, p56)
													-- upvalues: (ref) v_u_9, (ref) p_u_16, (ref) v_u_5, (ref) v_u_7, (ref) v_u_20, (ref) v_u_4
													if p55.Humanoid.Health <= 0 then
														v_u_9:IncrementAchievementProgress(p_u_16.Player, "JohnDoeSpikes")
														local v57 = p55.Parent
														if tostring(v57) == "Survivors" then
															require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(p_u_16.Player, {
																["Action"] = "Killed a Survivor with Corrupt Energy",
																["RewardType"] = "DifficultKillerAction"
															})
														end
													else
														v_u_5:CreateSpeedMultiplier(p55, 1.5, "HitSpeedBonus", 1.25)
														v_u_7:ApplyStatus(p_u_16.Rig, "Speed", {
															["Duration"] = 7,
															["Level"] = 1
														})
														v_u_5:RevealPlayerAuraTo(p_u_16.Player, p55, 2.5)
														if v_u_20[p55] then
															local v58 = v_u_20
															v58[p55] = v58[p55] + 1
															if v_u_20[p55] >= p_u_16.Config.SpikeHitCap then
																v_u_5:GiveInvincible(p55, "SpikeLimit", 1)
															end
														else
															v_u_20[p55] = 1
														end
														local v59 = p55.Parent
														if tostring(v59) == "Survivors" then
															require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(p_u_16.Player, {
																["Action"] = "Damaged a Survivor with Corrupt Energy",
																["RewardType"] = "EasyKillerAction"
															})
														end
													end
													if p56 then
														v_u_4:Play(p_u_16.Config.Sounds.Hit, {
															["Parent"] = p_u_16.Rig.PrimaryPart,
															["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
															["Volume"] = 0.25
														})
													end
												end
											}
										})
									end
								end
							else
								return
							end
						end)
					end
					task.wait(p_u_16.Config.SpikeAmount * p_u_16.Config.DelayBetweenSpikeSummons)
					p_u_16.Config.StunDuration = nil
				end)
				task.delay(3.5, function()
					-- upvalues: (ref) v_u_19, (copy) p_u_16
					pcall(function()
						-- upvalues: (ref) v_u_19
						v_u_19:Disconnect()
					end)
					p_u_16.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_16.Animations.CorruptEnergy:Play(0.025)
				local v_u_60 = false
				local v_u_61 = v_u_5:CreateSpeedMultiplier(p_u_16.Player, 0.001, "CorruptEnergy")
				game.Debris:AddItem(v_u_61, 3.5)
				local v62 = p_u_16.Rig:GetAttributeChangedSignal("Stunned"):Once(function()
					-- upvalues: (copy) v_u_61, (copy) p_u_16, (ref) v_u_60
					v_u_61:Destroy()
					p_u_16.Animations.CorruptEnergy:Stop()
					v_u_60 = true
				end)
				task.delay(3.6, v62.Disconnect, v62)
				local v_u_63 = { 1.067, 1.917 }
				local v_u_64 = 0
				local v_u_65 = 0
				task.spawn(function()
					-- upvalues: (copy) p_u_16, (copy) v_u_63, (ref) v_u_60, (ref) v_u_65, (ref) v_u_64, (ref) v_u_5
					while p_u_16 and (p_u_16.Rig.Parent and (v_u_63[1] and not v_u_60)) do
						v_u_65 = v_u_65 + game["Run Service"].Heartbeat:Wait()
						for v66 = #v_u_63, 1, -1 do
							if v_u_63[v66] and v_u_65 >= v_u_63[v66] then
								table.remove(v_u_63, v66)
								v_u_64 = v_u_64 + 1
								v_u_5:ApplyCameraShake(v_u_64 * 0.2, v_u_64 * 0.35)
							end
						end
					end
				end)
			end
		end
	},
	["DigitalFootprint"] = {
		["LayoutOrder"] = 3,
		["Icon"] = "rbxassetid://83206360003394",
		["KeybindType"] = "AltAbility2",
		["Callback"] = function(p_u_67)
			-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_7
			local v_u_68 = { 0.317, 1.05, 2.067 }
			local v_u_69 = 0
			local v_u_70 = 0
			if game["Run Service"]:IsServer() then
				p_u_67.AbilitiesDisabled = true
				v_u_4:Play(p_u_67.Config.Sounds.DigitalFootprint, {
					["Parent"] = p_u_67.Rig.PrimaryPart,
					["Volume"] = 0.4,
					["TimePosition"] = 0.09,
					["PlaybackSpeed"] = 1.2
				})
				local function v_u_74(p71)
					if p71 and p71.Parent then
						p71.Name = "okByeBye"
						game.Debris:AddItem(p71, 5)
						local v72 = p71:FindFirstChild("ShadowAmbience")
						if v72 then
							game.TweenService:Create(v72, TweenInfo.new(2), {
								["Volume"] = 0
							}):Play()
						end
						for _, v73 in pairs(p71:GetDescendants()) do
							if v73:IsA("ParticleEmitter") then
								v73.Enabled = false
							end
						end
					end
				end
				local v75 = workspace.Map.Ingame
				local v76 = p_u_67.Player
				local v77 = v75:FindFirstChild((("%*Shadows"):format((tostring(v76)))))
				if not v77 then
					v77 = Instance.new("Folder")
					local v78 = p_u_67.Player
					v77.Name = ("%*Shadows"):format((tostring(v78)))
					v77.Parent = workspace.Map.Ingame
				end
				local v79 = v77:GetChildren()
				if #v79 == p_u_67.Config.DigitalFootprintLimit then
					v_u_74(v79[1])
				end
				local v_u_80 = p_u_67.Config.Shadow:Clone()
				v_u_80.Size = Vector3.new(1, 0, 0)
				v_u_80.Parent = v77
				v_u_4:Play(p_u_67.Config.Sounds.DigitalFootprintAmbience, {
					["Parent"] = v_u_80,
					["Name"] = "ShadowAmbience",
					["RollOffMaxDistance"] = 30,
					["Looped"] = true
				})
				local v_u_81 = RaycastParams.new()
				v_u_81.FilterDescendantsInstances = { workspace.Players, v_u_80 }
				v_u_81.FilterType = Enum.RaycastFilterType.Exclude
				task.delay(p_u_67.Config.DigitalFootprintLifetime, function()
					-- upvalues: (copy) v_u_74, (copy) v_u_80
					v_u_74(v_u_80)
				end)
				local v82 = task.delay
				local v83 = v_u_68[#v_u_68]
				v82(tonumber(v83) or 2.55, function()
					-- upvalues: (ref) v_u_5, (copy) v_u_80, (copy) p_u_67, (copy) v_u_74, (ref) v_u_7
					v_u_5:ApplyUnsafeTouched(v_u_80, false, function(_, p84)
						-- upvalues: (ref) v_u_5, (ref) p_u_67, (ref) v_u_80, (ref) v_u_74, (ref) v_u_7
						local v85 = p84.Parent
						local v86
						if v85 then
							v86 = v85:FindFirstChild("Humanoid")
						else
							v86 = v85
						end
						local v87 = v86 and v_u_5:GetEntityType(v85)
						if v87 then
							v87 = v85 ~= p_u_67.Rig
						end
						if v87 and (v86 and (v86.Health > 0 and (v_u_80.Name == "Shadow" and not v85:GetAttribute("ExecutionsDisabled")))) then
							v_u_74(v_u_80)
							v_u_5:RevealPlayerAuraTo(p_u_67.Rig, v85, 10)
							v_u_5:RevealPlayerAuraTo(v85, p_u_67.Rig, 10)
							v_u_7:ApplyStatus(p_u_67.Rig, "Speed", {
								["Level"] = 1,
								["Duration"] = 10
							})
							v_u_7:ApplyStatus(v85, "Slowness", {
								["Level"] = 2,
								["Duration"] = 10
							})
							v_u_7:ApplyStatus(v85, "Corrupted", {
								["Level"] = 1,
								["Duration"] = 10
							})
							require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(p_u_67.Player, {
								["Action"] = "Survivor stepped into a Digital Footprint trap",
								["RewardType"] = "RegularKillerAction"
							})
						end
					end, 14)
				end)
				task.spawn(function()
					-- upvalues: (ref) v_u_69, (copy) v_u_80, (ref) v_u_70, (copy) v_u_68, (copy) p_u_67, (copy) v_u_81
					while v_u_69 ~= 3 and (v_u_80.Parent and v_u_80.Name == "Shadow") do
						v_u_70 = v_u_70 + game["Run Service"].Heartbeat:Wait()
						for v88 = #v_u_68, 1, -1 do
							if v_u_68[v88] and v_u_70 >= v_u_68[v88] then
								table.remove(v_u_68, v88)
								v_u_69 = v_u_69 + 1
								local v89 = (p_u_67.Rig.PrimaryPart.CFrame * CFrame.new(-1.1, 0, -2)).Position
								local v90 = workspace:Raycast(v89, Vector3.new(0, -100, 0), v_u_81)
								v_u_80.Position = (v90 and v90.Position or p_u_67.Rig.PrimaryPart.Position - Vector3.new(0, 2.5, 0)) + Vector3.new(0, 0.5, 0)
								local v91 = game.TweenService
								local v92 = v_u_80
								local v93 = TweenInfo.new(1)
								local v94 = {}
								local v95 = v_u_69 * 6
								local v96 = v_u_69 * 6
								v94.Size = Vector3.new(1, v95, v96)
								v91:Create(v92, v93, v94):Play()
								for _, v97 in pairs(v_u_80:GetDescendants()) do
									if v97:IsA("ParticleEmitter") and v97.Name:find("ShadowPuddle") then
										v97.Enabled = v97.Name == ("ShadowPuddle%*"):format(v_u_69)
									end
								end
							end
						end
					end
				end)
				task.delay(3, function()
					-- upvalues: (copy) p_u_67
					p_u_67.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_67.Animations.DigitalFootprint:Play(0.025)
				local v98 = v_u_5:CreateSpeedMultiplier(p_u_67.Player, 0, "DigitalFootprint")
				game.Debris:AddItem(v98, 3)
				task.spawn(function()
					-- upvalues: (copy) p_u_67, (copy) v_u_68, (ref) v_u_70, (ref) v_u_69, (ref) v_u_5
					while p_u_67 and (p_u_67.Rig.Parent and v_u_68[1]) do
						v_u_70 = v_u_70 + game["Run Service"].Heartbeat:Wait()
						for v99 = #v_u_68, 1, -1 do
							if v_u_68[v99] and v_u_70 >= v_u_68[v99] then
								table.remove(v_u_68, v99)
								v_u_69 = v_u_69 + 1
								v_u_5:ApplyCameraShake(v_u_69 * 0.2, v_u_69 * 0.375)
							end
						end
					end
				end)
			end
		end
	},
	["404Error"] = {
		["Name"] = "404 Error",
		["LayoutOrder"] = 4,
		["Icon"] = "rbxassetid://131116145215571",
		["KeybindType"] = "AltAbility3",
		["Callback"] = function(p_u_100)
			-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_8
			if game["Run Service"]:IsServer() then
				p_u_100.Config.StunDuration = p_u_100.Config.UnstoppableDuration
				p_u_100.AbilitiesDisabled = true
				v_u_4:Play(p_u_100.Config.Sounds["404Error"], {
					["Parent"] = p_u_100.Rig.PrimaryPart,
					["Volume"] = 0.4,
					["TimePosition"] = 0.09,
					["RollOffMaxDistance"] = 200,
					["PlaybackSpeed"] = 1.15
				})
				task.delay(1.625, function()
					-- upvalues: (copy) p_u_100
					p_u_100.Config.StunDuration = nil
					p_u_100.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				local v_u_101 = v_u_5:CreateSpeedMultiplier(p_u_100.Player, 1, "404Error")
				local v_u_102 = v_u_5:CreateFOVMultiplier(p_u_100.Player, 1, "404Error")
				game.TweenService:Create(v_u_101, TweenInfo.new(0.5), {
					["Value"] = 0.25
				}):Play()
				game.TweenService:Create(v_u_102, TweenInfo.new(1.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true), {
					["Value"] = 0.75
				}):Play()
				v_u_8:FireConnection("DisableSprinting", "404Error", true)
				task.delay(1.2, function()
					-- upvalues: (ref) v_u_5, (copy) p_u_100, (ref) v_u_4, (ref) v_u_8, (copy) v_u_101, (copy) v_u_102
					for _, v103 in pairs(workspace.Players.Survivors:GetChildren()) do
						v_u_5:RevealPlayerAura(v103, p_u_100.Config["404ErrorAuraRevealTime"])
					end
					v_u_4:Play(p_u_100.Config.Sounds["404ErrorError"], {
						["Parent"] = p_u_100.Rig.PrimaryPart,
						["Volume"] = 0.4,
						["TimePosition"] = 0.09,
						["PlaybackSpeed"] = Random.new():NextNumber(0.9, 1.1)
					})
					v_u_8:FireConnection("DisableSprinting", "404Error", false)
					game.TweenService:Create(v_u_101, TweenInfo.new(0.6), {
						["Value"] = 1
					}):Play()
					game.Debris:AddItem(v_u_101, 0.4)
					game.Debris:AddItem(v_u_102, 1)
				end)
			end
		end
	}
}
v1.Abilities = v104
function v1.Created(_, p_u_105)
	-- upvalues: (copy) v_u_9, (copy) v_u_5, (copy) v_u_7, (copy) v_u_3
	if game["Run Service"]:IsServer() then
		if workspace:GetAttribute("JohnDoeSpecialDay") then
			v_u_9:IncrementAchievementProgress(p_u_105.Player, "JohnDoeSpecialDay")
		end
		local v_u_106 = Instance.new("Folder")
		v_u_106.Name = "JohnDoeTrail"
		v_u_106.Parent = p_u_105.Rig
		local v107 = p_u_105.Config.TrailLength / 4
		local v108 = math.round(v107)
		for _ = 1, math.clamp(v108, 2, (1 / 0)) do
			local v109 = p_u_105.Config.Trail:Clone()
			v109.Position = p_u_105.Rig.PrimaryPart.Position - Vector3.new(0, 4.5, 0)
			v109.Parent = v_u_106
			v109:SetAttribute("FinishedUpdating", true)
			v_u_5:ApplyOnTouched(v109, false, function(_, p110)
				-- upvalues: (ref) v_u_7
				local v111 = p110.Parent
				local v112 = v111:FindFirstChild("Humanoid")
				if v112 and (v112.Health > 0 and v111:IsDescendantOf(workspace.Players)) then
					local v113 = v111.Parent
					if tostring(v113) ~= "Killers" then
						v_u_7:ApplyStatus(v111, "Corrupted", {
							["Duration"] = 3,
							["Level"] = 2
						})
					end
				end
			end)
		end
		p_u_105.CurrentSpikes = {}
		local v_u_114 = v_u_106:GetChildren()
		local v_u_115 = 0
		local v_u_116 = 0
		local v_u_117 = 0
		local v_u_118 = nil
		v_u_118 = game["Run Service"].Heartbeat:Connect(function(p119)
			-- upvalues: (copy) p_u_105, (copy) v_u_106, (ref) v_u_118, (ref) v_u_117, (ref) v_u_3, (ref) v_u_7, (ref) v_u_116, (copy) v_u_114, (ref) v_u_115
			if p_u_105 and (p_u_105.Rig.Parent and p_u_105.Rig.PrimaryPart) then
				if v_u_117 > 1 and #p_u_105.CurrentSpikes > 0 then
					v_u_117 = 0
					local v120 = RaycastParams.new()
					v120.FilterDescendantsInstances = p_u_105.CurrentSpikes
					v120.FilterType = Enum.RaycastFilterType.Include
					for _, v121 in v_u_3:GetPlayers() do
						local v122 = v121.Character
						if v122 and v122.Parent then
							local v123 = v122:FindFirstChildOfClass("Humanoid")
							if v123 or v123.Health <= 0 then
								local v124 = v122.PrimaryPart
								if workspace:Raycast(v124.Position, Vector3.new(0, -5, 0), v120) then
									v_u_7:ApplyStatus(v121, "Corrupted", {
										["Level"] = 2,
										["Duration"] = 5
									})
								end
							end
						end
					end
				end
				v_u_117 = v_u_117 + p119
				if v_u_116 <= 0.05 then
					v_u_116 = v_u_116 + p119
					return
				else
					v_u_116 = 0
					local v125 = v_u_114[v_u_115 % #v_u_114 + 1]
					local v126 = v_u_114[(v_u_115 - 1) % #v_u_114 + 1]
					if v125 and v126 then
						if v125.Size.Z <= 4 or v125:GetAttribute("FinishedUpdating") then
							if v125:GetAttribute("FinishedUpdating") then
								v125:SetAttribute("FinishedUpdating", nil)
							end
							local v127 = p_u_105:GetPivot().Position - Vector3.new(0, 3, 0)
							v125.CFrame = CFrame.new(v126:GetPivot().Position) * CFrame.lookAt(v126:GetPivot().Position, v127).Rotation * CFrame.Angles(0, 0, 0)
							local v128 = v125.Size.X
							local v129 = v125.Size.Y
							local v130 = (v125.Position - v127).Magnitude
							v125.Size = Vector3.new(v128, v129, v130)
							v125.PivotOffset = CFrame.new(0, 0, -v125.Size.Z / 2)
							v125.CFrame = v125.CFrame * v125.PivotOffset
						else
							v125:SetAttribute("FinishedUpdating", true)
							v_u_115 = v_u_115 + 1
						end
					else
						v_u_115 = v_u_115 + 1
						return
					end
				end
			else
				v_u_106:Destroy()
				v_u_118:Disconnect()
				v_u_118 = nil
				return
			end
		end)
	else
		game["Run Service"]:IsClient()
	end
end
function v1.Destroyed(_, p131)
	if game["Run Service"]:IsServer() then
		for _, v132 in p131.CurrentSpikes do
			v132:Destroy()
		end
	elseif game["Run Service"]:IsClient() and p131.SilencedConnection then
		p131.SilencedConnection:Disconnect()
		for _, v133 in ipairs(p131.Silencers or {}) do
			v133:Destroy()
		end
	end
end
function v1.OnIntroduction(_, p_u_134, p_u_135, p136)
	-- upvalues: (copy) v_u_5
	local v_u_137
	if p_u_134.Config.useClouds == true then
		v_u_137 = Instance.new("Clouds")
		v_u_137.Cover = 0.774
		v_u_137.Density = 1
		v_u_137.Color = Color3.fromRGB(25, 25, 25)
		v_u_137.Parent = workspace:FindFirstChild("Terrain")
		game.Debris:AddItem(v_u_137, p136)
	else
		v_u_137 = nil
	end
	local v_u_138 = script.IntroScreen:Clone()
	v_u_138.Main.Title.Text = p_u_134.Config.IntroText:gsub("PLAYERNAME", p_u_134.Player.DisplayName)
	v_u_138.Parent = game.Players.LocalPlayer.PlayerGui
	game.Debris:AddItem(v_u_138, 1.93333)
	game.TweenService:Create(v_u_138.Main.Title, TweenInfo.new(0.83), {
		["TextTransparency"] = 0
	}):Play()
	task.delay(0.83, function()
		-- upvalues: (copy) v_u_138, (copy) p_u_134
		game.TweenService:Create(v_u_138.Main.Title, TweenInfo.new(0.583), {
			["TextColor3"] = p_u_134.Config.IntroTextColor or Color3.new(1, 0, 0)
		}):Play()
	end)
	task.delay(1, function()
		-- upvalues: (copy) p_u_135
		local v139 = p_u_135:FindFirstChild("JohnDoeTrail")
		if v139 then
			v139:Destroy()
		end
	end)
	local v_u_140 = require(game.ReplicatedStorage.Modules.Schematics.Lighting)
	v_u_140:SetCustomLighting(p_u_134.Config.IntroLighting)
	task.delay(2.717, function()
		-- upvalues: (ref) v_u_137, (copy) p_u_134
		if v_u_137 then
			v_u_137.Color = Color3.fromRGB(25, 0, 0)
		end
		local v141 = game.Lighting:FindFirstChild("AtmosphereDoe")
		if v141 then
			game.TweenService:Create(v141, TweenInfo.new(0.2829, Enum.EasingStyle.Linear), {
				["Color"] = p_u_134.Config.AtmosphereColor or Color3.fromRGB(144, 0, 0),
				["Decay"] = p_u_134.Config.AtmosphereDecay or Color3.fromRGB(255, 0, 0),
				["Density"] = 1
			}):Play()
		end
	end)
	local v_u_142 = v_u_5:CreateFOVMultiplier(game.Players.LocalPlayer, 0.35, "JohnDoeIntroScene")
	task.delay(2.75, function()
		-- upvalues: (copy) v_u_142
		game.TweenService:Create(v_u_142, TweenInfo.new(0.25), {
			["Value"] = 0.95
		}):Play()
	end)
	task.delay(p136, function()
		-- upvalues: (copy) v_u_140, (copy) v_u_142, (copy) v_u_138, (ref) v_u_137
		v_u_140:SetAsCurrentLighting()
		v_u_142:Destroy()
		v_u_138:Destroy()
		if v_u_137 then
			v_u_137:Destroy()
		end
	end)
end
function v1.OnVictory(_, p143, p_u_144, _, _)
	-- upvalues: (copy) v_u_5, (copy) v_u_2
	local v145 = require(game.ReplicatedStorage.Modules.Schematics.Lighting)
	if p143 == "Start" then
		v145:SetCustomLighting(p_u_144.Config.IntroLighting)
		local v146 = v_u_5:CreateFOVMultiplier(game.Players.LocalPlayer, 1.1325, "JohnDoeOutroScene")
		game.Debris:AddItem(v146, 30)
		task.spawn(function()
			-- upvalues: (copy) p_u_144, (ref) v_u_5
			local v147 = tick()
			local v148 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 5)
			if v148 and v148.PrimaryPart then
				local v_u_149 = p_u_144.Config.OutroDummy:Clone()
				v_u_149.Name = "OutroVictim"
				v_u_149.PrimaryPart.Anchored = true
				v_u_149:SetPrimaryPartCFrame(v148.PrimaryPart.CFrame)
				v_u_149.Parent = v148
				local v150 = v_u_5:LoadAnimationFromID(v_u_149, "rbxassetid://79437220196186", true)
				v150:Play(0)
				v150.TimePosition = tick() - v147
				v150.Stopped:Once(function()
					-- upvalues: (copy) v_u_149
					for _, v151 in ipairs(v_u_149:GetDescendants()) do
						if v151:IsA("BasePart") then
							v151.Anchored = true
						end
					end
				end)
				local v152 = false
				for _, v153 in ipairs({
					"Shirt",
					"Pants",
					"Accessory",
					"Hat"
				}) do
					if v_u_149:FindFirstChildOfClass(v153) then
						v152 = true
						break
					end
				end
				if not v152 then
					pcall(function()
						-- upvalues: (ref) p_u_144, (copy) v_u_149
						local v154 = game.Players:GetHumanoidDescriptionFromUserId(p_u_144.Player.UserId)
						v_u_149.Humanoid:ApplyDescription(v154)
					end)
				end
			end
		end)
		task.delay(2.4, function()
			-- upvalues: (ref) v_u_2, (copy) p_u_144
			local v155 = Instance.new("ColorCorrectionEffect", game.Lighting)
			v155.Name = "JohnDoeStabCC"
			local v156 = v_u_2:Create(v155, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
				["Contrast"] = 0.4,
				["Brightness"] = 0.1
			})
			v156:Play()
			task.wait(0.4)
			v156:Pause()
			v155.Brightness = 0.8
			v155.Contrast = 0.3
			v155.TintColor = p_u_144.Config.OutroTintColor or Color3.new(0.631373, 0.0784314, 0.0901961)
			v_u_2:Create(v155, TweenInfo.new(2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
				["TintColor"] = Color3.new(0.196078, 0.196078, 0.196078),
				["Brightness"] = -1,
				["Contrast"] = -0.5,
				["Saturation"] = -1
			}):Play()
		end)
	elseif p143 == "End" then
		v145:SetAsCurrentLighting()
		local v157 = v_u_5:CreateFOVMultiplier(game.Players.LocalPlayer, 1, "JohnDoeOutroScene")
		game.Debris:AddItem(v157, 1)
		local v158 = game.Lighting:WaitForChild("JohnDoeStabCC", 8)
		if v158 then
			v158:Destroy()
		end
	end
end
function v1.OnExecution(_, p159, p_u_160)
	local v_u_161 = require(game.ReplicatedStorage.Modules.Ragdolls)
	local v_u_162 = p_u_160.Name == "JaneDoe" and Vector3.new(0, -2, 0) or (p159.Rig.PrimaryPart.CFrame.LookVector + Vector3.new(0, 0.5, 0)) * 40
	task.delay(0.666, function()
		-- upvalues: (copy) v_u_161, (copy) p_u_160, (copy) v_u_162
		v_u_161.AddProfile(p_u_160, {
			["AnchorDelay"] = true,
			["Applied"] = os.clock() + 5,
			["Velocity"] = v_u_162
		})
		local v163 = p_u_160:FindFirstChild("Humanoid")
		if v163 then
			v163.BreakJointsOnDeath = false
			v163.Health = 0
		end
	end)
	task.delay(1.9, function()
		-- upvalues: (copy) p_u_160
		if p_u_160 and p_u_160.PrimaryPart then
			p_u_160.PrimaryPart.Anchored = false
		end
	end)
end
return v1
