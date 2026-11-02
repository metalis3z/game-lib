-- Decompiled by Krnl

local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Players")
local v_u_6 = game:GetService("Debris")
local v_u_7 = {
	["sprinting"] = true,
	["enableBezierPreview"] = false,
	["voidStars"] = {},
	["maxVoidStars"] = 3
}
local v_u_8 = require(v_u_1.Modules.Schematics.Lighting)
local v_u_9 = require(game.ReplicatedStorage.Modules.Hitboxes)
local v_u_10 = require(game.ReplicatedStorage.Modules.Statuses)
local v_u_11 = require(game.ReplicatedStorage.Modules.Sounds)
local v_u_12 = require(v_u_1.Modules.Ragdolls)
local v_u_13 = require(v_u_1.Modules.Network)
local v_u_14 = require(game.ReplicatedStorage.Modules.Util)
local v_u_15 = require(v_u_1.Modules.Device)
local v_u_16 = require(v_u_1.Modules.Actors)
function v_u_7.Created(_, p_u_17)
	-- upvalues: (copy) v_u_4, (copy) v_u_13, (copy) v_u_10, (copy) v_u_14, (copy) v_u_7, (copy) v_u_1, (copy) v_u_2
	if v_u_4:IsServer() then
		v_u_13:SetConnection("StaminaStun", "REMOTE_EVENT", function()
			-- upvalues: (ref) v_u_10, (copy) p_u_17
			v_u_10:ApplyStatus(p_u_17.Rig, "Stunned", {
				["Duration"] = p_u_17.Config.StunTimeAfterLosingStamina
			})
		end)
		p_u_17.Rig:FindFirstChild("Humanoid"):SetAttribute("NoliRunningLoss", p_u_17.Config.StaminaLossRunning)
		task.spawn(function()
			-- upvalues: (copy) p_u_17, (ref) v_u_14
			if not p_u_17.Cache then
				p_u_17.Cache = {}
			end
			p_u_17.Cache.ImplantAttackNoli = v_u_14:LoadAnimationFromID(p_u_17.Rig, p_u_17.Config.Animations.ImplantAttackNoli)
			p_u_17.Cache.StardrivenAttackNoli = v_u_14:LoadAnimationFromID(p_u_17.Rig, p_u_17.Config.Animations.StardrivenCharge2HitNoli)
			p_u_17.Cache.StardrivenNormalHit = v_u_14:LoadAnimationFromID(p_u_17.Rig, p_u_17.Config.Animations.StardrivenCharge1Hit)
		end)
		v_u_13:SetConnection("Detonate", "REMOTE_EVENT", function(p18)
			-- upvalues: (copy) p_u_17, (ref) v_u_7
			if p18 == p_u_17.Player then
				local v19 = p18.Character.PrimaryPart
				for _, v20 in pairs(v_u_7.voidStars) do
					local v21 = v20.voidstar
					local v22 = v19.CFrame.LookVector:Dot(v21.CFrame.LookVector)
					print("dot:", v22)
					if v22 < -0.8 then
						print("detonating voidstar")
						v20.explode()
						return
					end
				end
			end
		end)
	end
	if v_u_4:IsClient() and p_u_17.Player == game.Players.LocalPlayer then
		v_u_14:SetSpeedCap(p_u_17.Rig, "NoliWalkSpeed", p_u_17.Config.Speed)
		require(v_u_1.Systems.Character.Game.Sprinting)
		p_u_17.Config.Assets.DecayCC:Clone().Parent = game.Lighting
		v_u_2.InputBegan:Connect(function(p23, p24)
			-- upvalues: (ref) v_u_13
			if not p24 then
				if p23.KeyCode == Enum.KeyCode.F or p23.KeyCode == Enum.KeyCode.ButtonR1 then
					v_u_13:FireServerConnection("Detonate", "REMOTE_EVENT")
				end
			end
		end)
	end
end
function v_u_7.OnIntroduction(_, p25, p_u_26, p27)
	-- upvalues: (copy) v_u_8, (copy) v_u_14, (copy) v_u_5
	v_u_8:SetCustomLighting(p25.Config.IntroLighting)
	p_u_26.Voidstar.Transparency = 1
	for _, v28 in pairs(p_u_26.Voidstar:GetChildren()) do
		if v28:IsA("MeshPart") then
			v28.Transparency = 1
		end
	end
	p_u_26.VoidstarCrown.Transparency = 1
	local v_u_29 = true
	task.spawn(function()
		-- upvalues: (ref) v_u_29
		while v_u_29 do
			task.wait()
		end
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_29
		while v_u_29 do
			task.wait()
		end
	end)
	local v_u_30 = v_u_14:CreateFOVMultiplier(v_u_5.LocalPlayer, 0.375, "NoliIntroScene", p27)
	task.delay(1.98, function()
		-- upvalues: (copy) v_u_30
		v_u_30.Value = 0.275
	end)
	task.delay(p27, function()
		-- upvalues: (ref) v_u_29, (copy) p_u_26, (ref) v_u_8
		v_u_29 = false
		p_u_26.VoidstarCrown.Transparency = 0
		for _, v31 in pairs(p_u_26.Voidstar:GetChildren()) do
			if v31:IsA("MeshPart") then
				v31.Transparency = 0
			end
		end
		p_u_26.Voidstar.Transparency = 0
		v_u_8:SetAsCurrentLighting()
	end)
end
function v_u_7.KillerRemoved(_)
	local v32 = game.Lighting:FindFirstChild("Decay")
	if v32 then
		v32:Destroy()
	end
end
local v119 = {
	["Stab"] = {
		["LayoutOrder"] = 1,
		["Icon"] = "rbxassetid://135239660832992",
		["KeybindType"] = "MainAbility",
		["Callback"] = function(p_u_33)
			-- upvalues: (copy) v_u_4, (copy) v_u_11, (copy) v_u_9, (copy) v_u_14
			if v_u_4:IsServer() then
				p_u_33.AbilitiesDisabled = true
				v_u_11:Play(p_u_33.Config.Sounds.Swing, {
					["Parent"] = p_u_33.Rig.PrimaryPart,
					["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
					["Volume"] = 0.25
				})
				p_u_33.Rig["Right Arm"].tentacle.Enabled = true
				task.delay(0.5, function()
					-- upvalues: (ref) v_u_9, (copy) p_u_33, (ref) v_u_14, (ref) v_u_11
					local v34 = v_u_9
					local v35 = p_u_33.Player
					local v39 = {
						["Size"] = Vector3.new(4.5, 6, 9),
						["CFrameOffset"] = CFrame.new(0, 0, -2.5),
						["Damage"] = p_u_33.Config.StabDamage,
						["Time"] = 0.2,
						["Knockback"] = 2,
						["HitMultiple"] = false,
						["ExecuteOnKill"] = true,
						["Connections"] = {
							["Hit"] = function(p36, p37)
								-- upvalues: (ref) v_u_14, (ref) v_u_11, (ref) p_u_33
								v_u_14:CreateSpeedMultiplier(p36, 1.5, "HitSpeedBonus", 1.25)
								if p37 then
									v_u_11:Play(p_u_33.Config.Sounds.Hit, {
										["Parent"] = p_u_33.Rig.PrimaryPart,
										["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
										["Volume"] = 0.25
									})
								end
							end,
							["OnExecution"] = function()
								-- upvalues: (ref) v_u_14, (ref) p_u_33
								for _, v38 in pairs(workspace.Players.Survivors:GetChildren()) do
									v_u_14:RevealPlayerAuraTo(p_u_33.Player, v38, p_u_33.Config.RevealSurvivorsOnKillTime, Color3.new(1, 0.75, 0))
								end
							end
						}
					}
					v34:CreateHitbox(v35, v39)
				end)
				task.delay(1.65, function()
					-- upvalues: (copy) p_u_33
					p_u_33.AbilitiesDisabled = false
					p_u_33.Rig["Right Arm"].tentacle.Enabled = false
				end)
			elseif v_u_4:IsClient() then
				p_u_33.Animations.Stab:Play(0.175)
			end
		end
	},
	["Stardriven"] = {
		["LayoutOrder"] = 2,
		["Icon"] = "rbxassetid://77714746717084",
		["KeybindType"] = "AltAbility1",
		["Callback"] = function(p_u_40)
			-- upvalues: (copy) v_u_4, (copy) v_u_13, (copy) v_u_9, (copy) v_u_10, (copy) v_u_14, (copy) v_u_16, (copy) v_u_11, (copy) v_u_15, (copy) v_u_2, (copy) v_u_3
			local v_u_41 = p_u_40.Rig
			local v_u_42 = p_u_40.Config
			local v_u_43 = p_u_40.Animations
			if v_u_4:IsServer() then
				p_u_40.AbilitiesDisabled = true
				p_u_40.Rig["Right Arm"].tentacle.Enabled = true
				local v_u_44 = 2
				v_u_13:SetConnection("NoliOnDash", "REMOTE_EVENT", function(_)
					-- upvalues: (copy) v_u_42, (ref) v_u_44, (ref) v_u_9, (copy) p_u_40, (ref) v_u_10, (ref) v_u_14, (ref) v_u_16, (ref) v_u_13, (ref) v_u_11, (copy) v_u_41
					local v45 = v_u_42.StardrivenTokenData[v_u_44]
					v_u_44 = v_u_44 - 1
					local v46 = v_u_9
					local v47 = p_u_40.Player
					local v51 = {
						["Size"] = Vector3.new(4, 4, 7),
						["CFrameOffset"] = CFrame.new(0, 0, -5),
						["Time"] = v45.Lifetime + 0.1,
						["Knockback"] = 0.5,
						["HitMultiple"] = false,
						["Damage"] = v45.Damage,
						["Connections"] = {
							["Hit"] = function(p_u_48, p49)
								-- upvalues: (ref) p_u_40, (ref) v_u_42, (ref) v_u_10, (ref) v_u_14, (ref) v_u_44, (ref) v_u_16, (ref) v_u_13, (ref) v_u_11, (ref) v_u_41
								if p49 then
									v_u_10:ApplyStatus(p_u_48, "Hallucination", v_u_14:MergeTables({
										["Level"] = 1,
										["Hidden"] = true,
										["Stackable"] = true
									}, {
										["Duration"] = v_u_42.StardrivenHallucinationDuration
									}))
									print(v_u_44)
									if v_u_44 == 1 then
										v_u_16:IncrementActorStats(p_u_40.Player, {
											["Action"] = "Hit a survivor once with stardriven",
											["Money"] = 5,
											["EXP"] = 5
										})
										v_u_13:FireClientConnection(p_u_40.Player, "NoliStardrivenHit", "REMOTE_EVENT", "Normal")
										v_u_13:FireClientConnection(p_u_40.Player, "ApplyStamina", "UREMOTE_EVENT", p_u_40.Config.StaminaGetOnStardrivenHit)
										print("a")
										return
									end
									p_u_40.Rig["Right Arm"].tentacle.Enabled = false
									v_u_16:IncrementActorStats(p_u_40.Player, {
										["Action"] = "Slammed a survivor with stardriven",
										["Money"] = 8,
										["EXP"] = 8
									})
									v_u_13:FireClientConnection(p_u_40.Player, "NoliStardrivenHit", "REMOTE_EVENT", "Slam")
									v_u_11:Play(v_u_42.Sounds.SecondHit, {
										["Parent"] = v_u_41.PrimaryPart,
										["Volume"] = 1
									})
									print("b")
									v_u_41.HumanoidRootPart.Anchored = true
									p_u_48.HumanoidRootPart.Anchored = true
									v_u_41:SetAttribute("Invincible", true)
									p_u_48:SetPrimaryPartCFrame(v_u_41.PrimaryPart.CFrame)
									local v50 = v_u_14:LoadAnimationFromID(p_u_48, v_u_42.Animations.StardrivenCharge2HitVictim, true)
									p_u_40.Cache.StardrivenAttackNoli:Play(0)
									v50:Play(0)
									task.delay(v50.Length - 0.1, function()
										-- upvalues: (copy) p_u_48
										p_u_48.HumanoidRootPart.Anchored = false
									end)
									task.delay(p_u_40.Cache.StardrivenAttackNoli.Length - 0.1, function()
										-- upvalues: (ref) v_u_41
										v_u_41.HumanoidRootPart.Anchored = false
									end)
								end
							end
						}
					}
					v46:CreateHitbox(v47, v51)
					if v_u_44 == 0 then
						task.delay(2.5, function()
							-- upvalues: (ref) p_u_40
							p_u_40.AbilitiesDisabled = false
						end)
					end
				end)
				return
			end
			local v_u_52 = 2
			local v_u_53 = 0
			local v_u_54 = v_u_15:GetPlayerDevice()
			local v55 = v_u_43.StardrivenTendrilStart
			v55:Play(0, 1, 1)
			task.wait(v55.Length - 0.1)
			local v_u_56 = v_u_43.StardrivenTendrilLoop
			v_u_56:Play(0, 1, 1)
			local v_u_57 = game.ReplicatedStorage.Assets.UI.ProgressBar:Clone()
			v_u_57.Bar.Size = UDim2.fromScale(0, 0.75)
			v_u_57.Bar.Clipping.Top.ImageColor3 = Color3.fromRGB(118, 64, 165)
			v_u_57.Parent = p_u_40.Player.PlayerGui:FindFirstChild("TemporaryUI")
			local v_u_58 = v_u_14:CreateSpeedMultiplier(v_u_41, 0.5, "StardrivenChargeSlowness")
			task.spawn(function()
				-- upvalues: (copy) v_u_57, (ref) v_u_53
				while v_u_57.Visible do
					local v59 = v_u_53
					v_u_57.Bar.Size = UDim2.fromScale(math.clamp(v59, 0, 0.975), 0.75)
					print("ok")
					task.wait()
				end
			end)
			if v_u_54 == "PC" then
				v_u_57.Title.Text = "Charge Stardriven (M2)"
			elseif v_u_54 == "Console" then
				v_u_57.Title.Text = "Charge Stardriven (A)"
			elseif v_u_54 == "Mobile" then
				v_u_57.Title.Text = "Charge Stardriven (Touch)"
			end
			local v_u_60 = false
			--v_u_57.Touch.MouseButton1Down:Connect(function()
			--	-- upvalues: (ref) v_u_60
			--	v_u_60 = true
			--end)
			--v_u_57.Touch.MouseButton1Up:Connect(function()
			--	-- upvalues: (ref) v_u_60
			--	v_u_60 = false
			--end)
			--v_u_57.Touch.MouseLeave:Connect(function()
			--	-- upvalues: (ref) v_u_60
			--	v_u_60 = false
			--end)
			local v_u_61 = v_u_60
			while true do
				if v_u_2:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) or (v_u_2:IsKeyDown(Enum.KeyCode.ButtonA) or v_u_61) then
					v_u_53 = v_u_53 + 0.052500000000000005
					print(v_u_53)
				end
				task.wait()
				if v_u_53 >= 1 then
					v_u_57.Visible = false
					v_u_57:Destroy()
					v_u_53 = 1
					local function v73()
						-- upvalues: (copy) p_u_40, (ref) v_u_2, (ref) v_u_61, (copy) v_u_54, (copy) v_u_58, (ref) v_u_52, (copy) v_u_43, (ref) v_u_14, (copy) v_u_41, (ref) v_u_3, (ref) v_u_13, (copy) v_u_56, (ref) v_u_11, (copy) v_u_42, (ref) v_u_10
						local v62 = game.ReplicatedStorage.Assets.UI.ProgressBar:Clone()
						v62.Bar.Size = UDim2.fromScale(0.975, 0.75)
						v62.Bar.Clipping.Top.ImageColor3 = Color3.fromRGB(118, 64, 165)
						v62.Parent = p_u_40.Player.PlayerGui:FindFirstChild("TemporaryUI")
						local v_u_63 = false
						task.spawn(function()
							-- upvalues: (ref) v_u_2, (ref) v_u_61, (ref) v_u_63
							task.wait(0.5)
							while task.wait() do
								if v_u_2:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or (v_u_2:IsKeyDown(Enum.KeyCode.ButtonA) or v_u_61) then
									v_u_63 = true
									return
								end
							end
						end)
						if v_u_54 == "PC" then
							v62.Title.Text = "Press Stardriven (M1)"
						elseif v_u_54 == "Console" then
							v62.Title.Text = "Press Stardriven (A)"
						elseif v_u_54 == "Mobile" then
							v62.Title.Text = "Press Stardriven (Touch)"
						end
						repeat
							task.wait()
						until v_u_63
						v62.Visible = false
						v62:Destroy()
						p_u_40.Rig["Right Arm"].tentacle.Enabled = true
						v_u_58.Value = 1
						local v64
						if v_u_52 == 2 then
							v64 = v_u_43.StardrivenCharge1Start
						else
							v64 = v_u_43.StardrivenCharge2Start
						end
						local v65
						if v_u_52 == 2 then
							v65 = v_u_43.StardrivenCharge1Loop
						else
							v65 = v_u_43.StardrivenCharge2Loop
						end
						v64:Play(0, 1, 1)
						v65:Play(0.125, 1, 1)
						local v66 = p_u_40.Config.StardrivenTokenData[v_u_52]
						local v_u_67 = v_u_14:ApplyVelocity(v_u_41, v66.Distance / 2, true, 0.1)
						task.spawn(function()
							-- upvalues: (ref) v_u_67, (ref) v_u_41
							game["Run Service"].RenderStepped:Connect(function()
								-- upvalues: (ref) v_u_67, (ref) v_u_41
								if v_u_67 then
									v_u_67.LineDirection = v_u_41.PrimaryPart.CFrame.LookVector
									local v68 = v_u_67
									local v69 = v_u_67.LineDirection.X
									local v70 = v_u_67.LineDirection.Z
									v68.LineDirection = Vector3.new(v69, 0, v70)
								end
							end)
						end)
						v_u_3:Create(v_u_67, TweenInfo.new(0.1), {
							["LineVelocity"] = v66.Distance
						}):Play()
						v_u_13:SetConnection("NoliStardrivenHit", "REMOTE_EVENT", function(p71)
							-- upvalues: (ref) v_u_67, (ref) v_u_43
							v_u_67:Destroy()
							v_u_67 = nil
							if p71 == "Normal" then
								print("yea")
								v_u_43.StardrivenCharge1Hit:Play(0)
							end
						end)
						v_u_13:FireServerConnection("NoliOnDash", "REMOTE_EVENT")
						v_u_52 = v_u_52 - 1
						task.wait(v66.Lifetime)
						v_u_58.Value = 0.5
						local v72
						if v_u_67 then
							v72 = v_u_3:Create(v_u_67, TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
								["LineVelocity"] = 0
							})
							v72:Play()
						else
							v72 = nil
						end
						v65:Stop(0.125)
						if v_u_52 == 0 then
							v_u_58:Destroy()
							v_u_56:Stop(0.125)
						end
						if v72 then
							v_u_41["Right Arm"].tentacle.Enabled = false
							v_u_11:Play(v_u_42.Sounds.StardrivenMiss[math.random(1, 4)], {
								["Parent"] = v_u_41.PrimaryPart,
								["Volume"] = 0.5
							})
							v_u_10:ApplyStatus(v_u_41, "Stunned", {
								["Duration"] = p_u_40.Config.StunTimeAfterFailingStardriven
							})
							v72.Completed:Wait()
							if v_u_67 then
								v_u_67:Destroy()
							end
						end
					end
					v73()
					v73()
					return
				end
			end
		end
	},
	["Implant"] = {
		["LayoutOrder"] = 3,
		["Icon"] = "rbxassetid://88651731892734",
		["KeybindType"] = "AltAbility2",
		["Callback"] = function(p_u_74, _)
			-- upvalues: (copy) v_u_4, (copy) v_u_7, (copy) v_u_11, (copy) v_u_14, (copy) v_u_16, (copy) v_u_13, (copy) v_u_9, (copy) v_u_12, (copy) v_u_6
			local v_u_75 = p_u_74.Rig
			local v_u_76 = p_u_74.Config
			local v77 = p_u_74.Animations
			if v_u_4:IsServer() then
				local function v_u_92(p78)
					-- upvalues: (ref) v_u_7, (copy) v_u_75, (ref) v_u_11, (copy) v_u_76, (ref) v_u_14, (ref) v_u_16, (copy) p_u_74, (ref) v_u_13, (ref) v_u_4
					if #v_u_7.voidStars < v_u_7.maxVoidStars then
						local v_u_79 = v_u_75.Voidstar:Clone()
						if p78 then
							v_u_79.CFrame = p78.HumanoidRootPart.CFrame * CFrame.new(0, 0, -1)
							local v80 = Instance.new("WeldConstraint")
							v80.Part0 = v_u_79
							v80.Part1 = p78.HumanoidRootPart
							v80.Parent = v_u_79
						else
							v_u_79.Anchored = true
							v_u_79.CFrame = v_u_75.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0)
						end
						v_u_79.Parent = workspace.Misc
						local v81 = Instance.new("Highlight")
						v81.FillTransparency = 0.5
						v81.OutlineTransparency = 0.15
						v81.FillColor = Color3.new(0.576471, 0.054902, 0.8)
						v81.OutlineColor = Color3.new(0.843137, 0.592157, 1)
						v81.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
						v81.Parent = v_u_79
						local v_u_82 = {
							["voidstar"] = v_u_79,
							["revealedAuras"] = {},
							["exploding"] = false
						}
						local function v_u_88()
							-- upvalues: (ref) v_u_7, (copy) v_u_82, (ref) v_u_11, (ref) v_u_76, (copy) v_u_79, (ref) v_u_14, (ref) v_u_16, (ref) p_u_74, (ref) v_u_13
							local v83 = #v_u_7.voidStars + 1
							v_u_82.exploding = true
							local v84 = {
								["Parent"] = v_u_79,
								["Volume"] = 0.5
							}
							v_u_11:Play(v_u_76.Sounds.Explosion, v84)
							print("EXPLODE")
							local v85 = v_u_14:GetClosestPlayerFromPosition(v_u_79.Position, {
								["MaxDistance"] = 45,
								["PlayerSelection"] = "Survivors",
								["ReturnTable"] = true
							})
							print(v85)
							for _, v_u_86 in pairs(v85) do
								print((("%* in range of explosion"):format(v_u_86.Player.Name)))
								v_u_14:ApplyDamage(v_u_86.Player, v_u_76.ImplantBaseDamage)
								local v_u_87 = require(game.ReplicatedStorage.Modules.Ragdolls)
								v_u_86.Player.PrimaryPart.Velocity = Vector3.new(0, 50, 0)
								v_u_87:Enable(v_u_86.Player)
								task.delay(1, function()
									-- upvalues: (copy) v_u_87, (copy) v_u_86
									v_u_87:Disable(v_u_86.Player)
								end)
								v_u_16:IncrementActorStats(p_u_74.Player, {
									["Action"] = "Exploded a survivor using implant",
									["Money"] = 7,
									["EXP"] = 6
								})
								v_u_13:FireClientConnection(nil, p_u_74, "Hit", "UREMOTE_EVENT", v_u_76.ImplantBaseDamage, v_u_86.Player.PrimaryPart.Position)
							end
							game.Debris:AddItem(v_u_79, 5)
							if v_u_82.radiusCheck then
								v_u_82.radiusCheck:Disconnect()
							end
							table.remove(v_u_7.voidStars, v83)
						end
						v_u_82.explode = v_u_88
						if not p78 then
							v_u_82.radiusCheck = v_u_4.Heartbeat:Connect(function(_)
								-- upvalues: (copy) v_u_82, (copy) v_u_79, (ref) v_u_14, (ref) p_u_74, (copy) v_u_88
								for _, v89 in pairs(workspace.Players.Survivors:GetChildren()) do
									if v_u_82.exploding then
										print("explodign")
										return
									end
									local v90 = (v_u_79.Position - v89.HumanoidRootPart.Position).Magnitude
									if v90 <= 30 and not v_u_82.revealedAuras[v89] then
										print((("revealing %* aura to noli"):format(v89.Name)))
										v_u_14:RevealPlayerAuraTo(p_u_74.Player, v89, 30, Color3.new(1, 0.75, 0))
										v_u_82.revealedAuras[v89] = true
									end
									if v90 <= 10 then
										v_u_88()
									end
								end
							end)
						end
						v_u_82.decayThread = task.delay(v_u_76.ImplantDecayTime, function()
							-- upvalues: (copy) v_u_88
							v_u_88()
						end)
						local v91 = v_u_7.voidStars
						table.insert(v91, v_u_82)
					end
				end
				v_u_13:SetConnection("NoliImplant", "REMOTE_EVENT", function(p93, p_u_94)
					-- upvalues: (copy) p_u_74, (ref) v_u_9, (copy) v_u_75, (ref) v_u_14, (copy) v_u_76, (ref) v_u_11, (ref) v_u_16, (copy) v_u_92, (ref) v_u_12, (ref) v_u_6, (ref) v_u_7
					if p93 == p_u_74.Player then
						local v_u_95 = false
						local v96 = v_u_9
						local v109 = {
							["Size"] = Vector3.new(8, 8, 8),
							["CFrameOffset"] = CFrame.new(0, 0, -2),
							["Damage"] = 0,
							["Time"] = 0.1,
							["Connections"] = {
								["Hit"] = function(p_u_97, p98)
									-- upvalues: (ref) v_u_95, (ref) v_u_75, (ref) v_u_14, (ref) v_u_76, (ref) p_u_74, (ref) v_u_11, (ref) v_u_16, (ref) v_u_92, (ref) v_u_12, (ref) v_u_6
									v_u_95 = true
									if p98 then
										v_u_75.HumanoidRootPart.Anchored = true
										p_u_97:PivotTo(v_u_75:GetPivot())
										p_u_97.HumanoidRootPart.Anchored = true
										local v99 = v_u_14:LoadAnimationFromID(p_u_97, v_u_76.Animations.ImplantAttackVictim, true)
										local v100 = p_u_74.Cache.ImplantAttackNoli
										v100:Play(0)
										v99:Play(0)
										v_u_11:Play(v_u_76.Sounds.ImplantInject, {
											["Parent"] = v_u_75.PrimaryPart,
											["Volume"] = 0.5
										})
										v_u_16:IncrementActorStats(p_u_74.Player, {
											["Action"] = "Injected a survivor with implant",
											["Money"] = 10,
											["EXP"] = 10
										})
										task.delay(0.2, function()
											-- upvalues: (ref) v_u_92, (copy) p_u_97
											v_u_92(p_u_97)
										end)
										task.delay(0.7, function()
											-- upvalues: (ref) v_u_12, (copy) p_u_97, (ref) v_u_6, (ref) v_u_14
											v_u_12:Enable(p_u_97)
											v_u_6:AddItem(v_u_14:ApplyVelocity(p_u_97, -50), 0.25)
											task.wait(0.1)
											v_u_12:Disable(p_u_97)
										end)
										task.delay(v100.Length, function()
											-- upvalues: (ref) v_u_75
											v_u_75.HumanoidRootPart.Anchored = false
										end)
										task.delay(v99.Length, function()
											-- upvalues: (copy) p_u_97
											p_u_97.HumanoidRootPart.Anchored = false
										end)
									end
								end,
								["Ended"] = function()
									-- upvalues: (ref) v_u_95, (copy) p_u_94, (ref) v_u_92, (ref) v_u_14, (ref) v_u_75, (ref) v_u_76, (ref) v_u_7
									if v_u_95 then
										return
									elseif p_u_94 == "Normal" then
										v_u_92()
									else
										local v101 = v_u_14:ApplyVelocity(v_u_75, 1, true)
										print("throwing bomb")
										v101:Destroy()
										task.wait(0.1)
										local v102 = v_u_75.Voidstar:Clone()
										v102.Anchored = true
										v102.Parent = workspace
										v102.CFrame = v_u_75.Voidstar.CFrame
										local v103 = v102.CFrame
										local v104 = v103 * CFrame.new(0, 0, -v_u_76.ImplantBombThrowBaseRange)
										local v105 = { CFrame.new(v103.Position), CFrame.new(v103:Lerp(v104, 0.5).Position + Vector3.new(0, 5, 0)), CFrame.new(v104.Position) }
										for v106 = 0, 1, 0.1 do
											local v107 = v105[1]:Lerp(v105[2], v106):Lerp(v105[2]:Lerp(v105[3], v106), v106)
											v102.CFrame = v107
											if v_u_7.enableBezierPreview then
												local v108 = v_u_75.Voidstar:Clone()
												v108.BrickColor = BrickColor.Red()
												v108.Transparency = 0.5
												v108.Anchored = true
												v108.CFrame = v107
												v108.Parent = workspace
											end
											print("setting bezier curve to voidstar")
										end
									end
								end
							}
						}
						v96:CreateHitbox(p93, v109)
					end
				end)
			else
				local v110 = "Implant"
				if v_u_75.Humanoid.MoveDirection.Magnitude > 0 then
					v110 = v110 .. "Dash"
					v_u_14:CreateSpeedMultiplier(v_u_75, 0, "NoliPlacingTrap", 0.5)
					v_u_13:FireServerConnection("NoliImplant", "REMOTE_EVENT", "Dash")
				else
					v_u_13:FireServerConnection("NoliImplant", "REMOTE_EVENT", "Normal")
				end
				v77[v110]:Play(0)
			end
		end
	},
	["Hallucination"] = {
		["LayoutOrder"] = 4,
		["Icon"] = "rbxassetid://107117927290267",
		["KeybindType"] = "AltAbility3",
		["Callback"] = function(p_u_111)
			-- upvalues: (copy) v_u_14, (copy) v_u_11, (copy) v_u_10
			if game["Run Service"]:IsServer() then
				local v_u_112 = v_u_14:CreateSpeedMultiplier(p_u_111.Rig, 0, "HallucinationSlowness")
				p_u_111.AbilitiesDisabled = true
				local v_u_113 = p_u_111.Rig.HumanoidRootPart
				v_u_11:Play(p_u_111.Config.Sounds.Hallucination, {
					["Volume"] = 0.75,
					["Parent"] = v_u_113
				})
				task.spawn(function()
					-- upvalues: (copy) p_u_111, (copy) v_u_112, (ref) v_u_14, (copy) v_u_113, (ref) v_u_10
					task.wait(1.65)
					p_u_111.AbilitiesDisabled = false
					v_u_112:Destroy()
					local v114 = v_u_14:GetClosestPlayerFromPosition(v_u_113.Position, {
						["MaxDistance"] = p_u_111.Config.HallucinationMaxDistance,
						["PlayerSelection"] = "Survivors",
						["OverrideUndetectable"] = true,
						["ReturnTable"] = true
					})
					for _, v115 in pairs(v114) do
						v_u_14:RevealPlayerAuraTo(p_u_111.Player, v115.Player, p_u_111.Config.HallucinationAuraRevealDuration, Color3.new(1, 0.75, 0))
						v_u_10:ApplyStatus(v115.Player, "Hallucination", {
							["Level"] = math.random(1, 3),
							["Duration"] = p_u_111.Config.HallucinationDuration,
							["Hidden"] = true
						})
					end
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_111.Animations.Hallucination:Play(0.175)
			end
		end
	},
	["FakeItem"] = {
		["LayoutOrder"] = 5,
		["Icon"] = "rbxassetid://133994175153795",
		["KeybindType"] = "AltAbility4",
		["Callback"] = function(p_u_116)
			-- upvalues: (copy) v_u_14
			if game["Run Service"]:IsServer() then
				local v_u_117 = v_u_14:CreateSpeedMultiplier(p_u_116.Rig, 0, "FakeItemSlowness")
				p_u_116.AbilitiesDisabled = true
				local _ = p_u_116.Rig.HumanoidRootPart
				task.spawn(function()
					-- upvalues: (copy) p_u_116, (copy) v_u_117
					task.wait(1)
					p_u_116.AbilitiesDisabled = false
					v_u_117:Destroy()
					local v118 = require(game.ReplicatedStorage.Modules.Items):CreateItem("FAKEBloxyCola")
					v118.Item:SetAttribute("InfectedBy", p_u_116.Player.Name)
					print(v118.Item)
					v118.Item.Parent = workspace.Map.Ingame
					v118.Item.ItemRoot:PivotTo(p_u_116.Rig.HumanoidRootPart.CFrame * CFrame.new(0, 0, -1.5))
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_116.Animations.Implant:Play(0.175)
			end
		end
	}
}
v_u_7.Abilities = v119
return v_u_7
