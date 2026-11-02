-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Players")
local v_u_6 = game:GetService("Debris")
local v_u_7 = {
	["placedTrap"] = false,
	["sprinting"] = true
}
local v_u_8 = require(v_u_1.Modules.Schematics.Lighting)
local v_u_9 = require(game.ReplicatedStorage.Modules.Hitboxes)
local v_u_10 = require(game.ReplicatedStorage.Modules.Statuses)
local v_u_11 = require(game.ReplicatedStorage.Modules.Sounds)
local v_u_12 = require(v_u_1.Modules.Ragdolls)
local v_u_13 = require(v_u_1.Modules.Network)
local v_u_14 = require(game.ReplicatedStorage.Modules.Util)
local v15 = Color3.fromRGB(186, 66, 255)
local v_u_16 = 0
local v_u_17 = {
	[0] = {
		["Brightness"] = 0,
		["Contrast"] = 0,
		["Saturation"] = 0,
		["TintColor"] = Color3.fromRGB(255, 255, 255)
	},
	[1] = {
		["Brightness"] = -0.05,
		["Contrast"] = 1,
		["Saturation"] = -0.2,
		["TintColor"] = v15
	},
	[2] = {
		["Brightness"] = -0.4,
		["Contrast"] = 1.5,
		["Saturation"] = -0.5,
		["TintColor"] = v15
	},
	[3] = {
		["Brightness"] = -0.7,
		["Contrast"] = 2.5,
		["Saturation"] = -0.9,
		["TintColor"] = Color3.fromRGB(91, 32, 125)
	}
}
local function v_u_25(p_u_18, p19)
	-- upvalues: (copy) v_u_2
	local v_u_20 = nil
	local v_u_21 = nil
	if p19 then
		task.delay(p19, function()
			-- upvalues: (ref) v_u_20, (ref) v_u_21
			if v_u_20 == nil then
				print("waitForInput timed out")
				v_u_21:Disconnect()
				v_u_21 = nil
				v_u_20 = Enum.KeyCode.A
			end
		end)
	end
	v_u_21 = v_u_2.InputBegan:Connect(function(p22, p23)
		-- upvalues: (copy) p_u_18, (ref) v_u_20, (ref) v_u_21
		if not p23 then
			for _, v24 in pairs(p_u_18) do
				if p22.KeyCode == v24 or p22.UserInputType == v24 then
					v_u_20 = p22
					v_u_21:Disconnect()
					print("detected input")
					return
				end
			end
		end
	end)
	repeat
		task.wait()
	until v_u_20 ~= nil
end
function v_u_7.Created(_, p_u_26)
	-- upvalues: (copy) v_u_4, (copy) v_u_14, (copy) v_u_1, (copy) v_u_7, (copy) v_u_17, (copy) v_u_3, (ref) v_u_16, (copy) v_u_13, (copy) v_u_10
	if v_u_4:IsServer() then
		task.spawn(function()
			-- upvalues: (copy) p_u_26, (ref) v_u_14
			if not p_u_26.Cache then
				p_u_26.Cache = {}
			end
			p_u_26.Cache.ImplantAttackNoli = v_u_14:LoadAnimationFromID(p_u_26.Rig, p_u_26.Config.Animations.ImplantAttackNoli)
			p_u_26.Cache.StardrivenAttackNoli = v_u_14:LoadAnimationFromID(p_u_26.Rig, p_u_26.Config.Animations.StardrivenCharge2HitNoli)
		end)
	end
	if v_u_4:IsClient() and p_u_26.Player == game.Players.LocalPlayer then
		v_u_14:SetSpeedCap(p_u_26.Rig, "NoliWalkSpeed", p_u_26.Config.Speed)
		local v_u_27 = require(v_u_1.Systems.Character.Game.Sprinting)
		local v_u_28 = p_u_26.Config.Assets.DecayCC:Clone()
		v_u_28.Parent = game.Lighting
		task.spawn(function()
			-- upvalues: (copy) p_u_26, (ref) v_u_7, (copy) v_u_27, (ref) v_u_17, (copy) v_u_28, (ref) v_u_3, (ref) v_u_16, (ref) v_u_13
			while true do
				local v29 = p_u_26.Rig.Parent
				if tostring(v29) ~= "Killers" then
					break
				end
				if v_u_7.sprinting or v_u_27.Stamina >= -30 then
					v_u_27.IsSprinting = true
					v_u_27.CanSprint = true
				else
					v_u_27.IsSprinting = false
					v_u_27.CanSprint = false
				end
				if v_u_27.Stamina <= 0 then
					local v30 = v_u_27.Stamina / 10
					local v31 = math.floor(v30)
					local v32 = math.abs(v31)
					if v_u_17[v32] then
						local v33 = v_u_28
						local v34 = v_u_17[v32]
						v_u_3:Create(v33, TweenInfo.new(0.35), v34):Play()
						v_u_16 = v32
						if v_u_27.Stamina < -29 then
							v_u_27.Stamina = 2
							v_u_13:FireServerConnection("StunNoliSprint", "REMOTE_EVENT")
						end
					end
				else
					if v_u_16 ~= 0 then
						local v35 = v_u_28
						local v36 = v_u_17[0]
						v_u_3:Create(v35, TweenInfo.new(0.35), v36):Play()
					end
					v_u_16 = 0
				end
				task.wait()
			end
		end)
		v_u_13:SetConnection("AddNoliStamina", "REMOTE_EVENT", function(p37)
			-- upvalues: (copy) v_u_27
			if v_u_27.Stamina + p37 > v_u_27.MaxStamina then
				local v38 = v_u_27
				v38.Stamina = v38.Stamina + (v_u_27.MaxStamina - v_u_27.Stamina)
			else
				local v39 = v_u_27
				v39.Stamina = v39.Stamina + p37
			end
		end)
	end
	if v_u_4:IsServer() then
		local v_u_40 = false
		v_u_13:SetConnection("StunNoliSprint", "REMOTE_EVENT", function(p41)
			-- upvalues: (copy) p_u_26, (ref) v_u_40, (ref) v_u_10
			if p41 == p_u_26.Player and not v_u_40 then
				v_u_40 = true
				v_u_10:ApplyStatus(p_u_26.Rig, "Stunned", {
					["Duration"] = p_u_26.Config.StunTimeAfterLosingStamina
				})
				task.delay(p_u_26.Config.StunTimeAfterLosingStamina + 2.25, function()
					-- upvalues: (ref) v_u_10, (ref) p_u_26
					v_u_10:ApplyStatus(p_u_26.Rig, "Speed", {
						["Level"] = 1,
						["Duration"] = p_u_26.Config.SpeedTimeAfterStaminaLossStun
					})
				end)
				task.wait(3.5)
				v_u_40 = false
			end
		end)
	end
end
function v_u_7.OnIntroduction(_, p42, p_u_43, p44)
	-- upvalues: (copy) v_u_8, (copy) v_u_14, (copy) v_u_5
	v_u_8:SetCustomLighting(p42.Config.IntroLighting)
	p_u_43.FakeCrown.Transparency = 0
	p_u_43.Voidstar.Transparency = 1
	p_u_43.VoidstarCrown.Transparency = 1
	local v_u_45 = workspace.Misc:FindFirstChild("KillerCutsceneBackground")
	local v_u_46 = true
	task.spawn(function()
		-- upvalues: (ref) v_u_46, (copy) v_u_45
		while v_u_46 do
			for v47, v48 in pairs(v_u_45.Voidstars:GetChildren()) do
				v48.CFrame = v48.CFrame * CFrame.Angles(0, v47 % 2 == 0 and 0.0225 or -0.0225, 0)
			end
			task.wait()
		end
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_46, (copy) v_u_45
		while v_u_46 do
			local v49 = v_u_45.Skybox
			v49.CFrame = v49.CFrame * CFrame.Angles(0, 0.004363323129985824, 0)
			task.wait()
		end
	end)
	local v_u_50 = v_u_14:CreateFOVMultiplier(v_u_5.LocalPlayer, 0.375, "NoliIntroScene", p44)
	task.delay(1.98, function()
		-- upvalues: (copy) v_u_50
		v_u_50.Value = 0.275
	end)
	task.delay(p44, function()
		-- upvalues: (ref) v_u_46, (copy) p_u_43, (ref) v_u_8
		v_u_46 = false
		p_u_43.FakeCrown.Transparency = 1
		p_u_43.VoidstarCrown.Transparency = 0
		p_u_43.Voidstar.Transparency = 0
		v_u_8:SetAsCurrentLighting()
	end)
end
function v_u_7.KillerRemoved(_)
	local v51 = game.Lighting:FindFirstChild("Decay")
	if v51 then
		v51:Destroy()
	end
end
local v108 = {
	["Stab"] = {
		["LayoutOrder"] = 1,
		["Icon"] = "rbxassetid://93874368032471",
		["KeybindType"] = "MainAbility",
		["Callback"] = function(p_u_52)
			-- upvalues: (copy) v_u_4, (copy) v_u_11, (copy) v_u_9, (copy) v_u_14, (copy) v_u_13
			if v_u_4:IsServer() then
				p_u_52.AbilitiesDisabled = true
				v_u_11:Play(p_u_52.Config.Sounds.Swing, {
					["Parent"] = p_u_52.Rig.PrimaryPart,
					["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
					["Volume"] = 0.25
				})
				task.delay(0.5, function()
					-- upvalues: (ref) v_u_9, (copy) p_u_52, (ref) v_u_14, (ref) v_u_13, (ref) v_u_11
					local v53 = v_u_9
					local v54 = p_u_52.Player
					local v57 = {
						["Size"] = Vector3.new(4.5, 6, 9),
						["CFrameOffset"] = CFrame.new(0, 0, -2.5),
						["Damage"] = p_u_52.Config.StabDamage,
						["Time"] = 0.2,
						["Knockback"] = 2,
						["HitMultiple"] = false,
						["ExecuteOnKill"] = true,
						["Connections"] = {
							["Hit"] = function(p55, p56)
								-- upvalues: (ref) v_u_14, (ref) p_u_52, (ref) v_u_13, (ref) v_u_11
								v_u_14:CreateSpeedMultiplier(p55, 1.5, "HitSpeedBonus", 1.25)
								if p56 then
									v_u_13:FireClientConnection(p_u_52.Player, "AddNoliStamina", "REMOTE_EVENT", 14)
									v_u_11:Play(p_u_52.Config.Sounds.Hit, {
										["Parent"] = p_u_52.Rig.PrimaryPart,
										["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
										["Volume"] = 0.25
									})
								end
							end
						}
					}
					v53:CreateHitbox(v54, v57)
				end)
				task.delay(1.65, function()
					-- upvalues: (copy) p_u_52
					p_u_52.AbilitiesDisabled = false
				end)
			elseif v_u_4:IsClient() then
				p_u_52.Animations.Stab:Play(0.175)
			end
		end
	},
	["Stardriven"] = {
		["LayoutOrder"] = 2,
		["Icon"] = "rbxassetid://93874368032471",
		["KeybindType"] = "AltAbility1",
		["Callback"] = function(p_u_58)
			-- upvalues: (copy) v_u_4, (copy) v_u_13, (copy) v_u_14, (copy) v_u_9, (copy) v_u_3, (copy) v_u_25
			local _ = p_u_58.Rig.HumanoidRootPart
			if v_u_4:IsServer() then
				p_u_58.AbilitiesDisabled = true
				local v_u_59 = 1
				v_u_13:SetConnection("Stardriven", "REMOTE_EVENT", function(p60)
					-- upvalues: (copy) p_u_58, (ref) v_u_14, (ref) v_u_9, (ref) v_u_13, (ref) v_u_59, (ref) v_u_3
					if p60 == p_u_58.Player then
						local v_u_61 = v_u_14:ApplyVelocity(p_u_58.Rig.HumanoidRootPart, p_u_58.Config.StardrivenSpeed, true, 0.125)
						local v_u_62 = false
						local v_u_63 = false
						local hitbox
						hitbox = v_u_9:CreateHitbox(p60, {
							["Damage"] = p_u_58.Config.StardrivenDamage1,
							["HitMultiple"] = true,
							["Time"] = p_u_58.Config.StardrivenTimeout,
							["Size"] = Vector3.new(7, 7, 7),
							["Knockback"] = 5,
							["Connections"] = {
								["Hit"] = function(p_u_64, p65)
									-- upvalues: (ref) v_u_62, (ref) p_u_58, (ref) v_u_13, (ref) v_u_59, (copy) v_u_61, (ref) v_u_14
									v_u_62 = true
									if p65 then
										v_u_13:FireClientConnection(p_u_58.Player, "AddNoliStamina", "REMOTE_EVENT", 24)
									end
									if p65 and v_u_59 == 2 then
										v_u_61:Destroy()
										p_u_58.Rig.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
										local v66 = v_u_14:LoadAnimationFromID(p_u_64, p_u_58.Config.Animations.StardrivenCharge2HitVictim, true)
										p_u_58.Cache.StardrivenAttackNoli:Play(0)
										v66.TimePosition = p_u_58.Cache.StardrivenAttackNoli.TimePosition
										v66:Play(0)
										p_u_64:PivotTo(p_u_58.Rig.HumanoidRootPart.CFrame)
										p_u_64.PrimaryPart.Anchored = true
										p_u_58.Rig.PrimaryPart.Anchored = true
										p_u_58.Rig:SetAttribute("Invincible", true)
										task.delay(v66.Length - 0.5, function()
											-- upvalues: (copy) p_u_64
											p_u_64.PrimaryPart.Anchored = false
										end)
										task.delay(p_u_58.Cache.StardrivenAttackNoli.Length, function()
											-- upvalues: (ref) p_u_58
											p_u_58.Rig.PrimaryPart.Anchored = false
											p_u_58.Rig:SetAttribute("Invincible", nil)
											p_u_58.AbilitiesDisabled = false
										end)
									end
									hitbox:Cancel()
								end,
								["Ended"] = function()
									-- upvalues: (ref) v_u_63
									v_u_63 = true
								end
							}
						})
						local v67 = v_u_63
						repeat
							task.wait()
						until v_u_62 or v67
						if not v_u_62 or v_u_59 ~= 2 then
							local v68 = v_u_3:Create(v_u_61, TweenInfo.new(0.225), {
								["LineVelocity"] = 0
							})
							v68:Play()
							v68.Completed:Wait()
							v_u_61:Destroy()
						end
						v_u_13:FireSignal("Stardriven", p60, v_u_62)
						if v_u_62 then
							v_u_59 = v_u_59 == 1 and 2 or 1
						else
							task.wait(p_u_58.Config.StardrivenRecoverTime)
							p_u_58.AbilitiesDisabled = false
						end
					end
				end)
				return
			else
				local _ = p_u_58.Player
				local function v71(p69)
					-- upvalues: (copy) p_u_58
					local v70 = p_u_58.Animations
					return {
						["Start"] = v70[("%*Start"):format(p69)],
						["Loop"] = v70[("%*Loop"):format(p69)],
						["Hit"] = v70[("%*Hit"):format(p69)],
						["Miss"] = v70[("%*Miss"):format(p69)]
					}
				end
				local v_u_72 = { Enum.UserInputType.Touch, Enum.UserInputType.MouseButton1, Enum.KeyCode.ButtonA }
				local v_u_73 = v71("StardrivenTendril")
				local v_u_74 = v71("StardrivenCharge1")
				local v_u_75 = v71("StardrivenCharge2")
				local v76 = v_u_14:CreateSpeedMultiplier(p_u_58.Rig, 0.015, "Stardriven")
				local function v80(p77)
					-- upvalues: (copy) v_u_74, (copy) v_u_75, (copy) v_u_73, (ref) v_u_25, (copy) v_u_72, (ref) v_u_13
					local v78 = p77 == 1 and v_u_74 or v_u_75
					if p77 == 1 then
						v_u_73.Start:Play(0)
						task.wait(v_u_73.Start.Length - 0.1)
					end
					v_u_73.Loop:Play(0.1)
					v_u_25(v_u_72, 3.5)
					v_u_73.Loop:Stop(0)
					v78.Start:Play(0)
					task.wait(0.1)
					v78.Loop:Play(0.125)
					v_u_13:FireServerConnection("Stardriven", "REMOTE_EVENT")
					local v79 = v_u_13:SetSignal("Stardriven").Wait()
					v78.Loop:Stop(0.125)
					return v79
				end
				if v80(1)[1] then
					v_u_74.Hit:Play(0)
					task.wait(0.1)
					if v80(2)[1] then
						task.wait(1)
						v76:Destroy()
					else
						v_u_75.Miss:Play(0, 1, 1)
						task.wait(p_u_58.Config.StardrivenRecoverTime)
						v76:Destroy()
					end
				else
					task.wait(p_u_58.Config.StardrivenRecoverTime)
					v76:Destroy()
					return
				end
			end
		end
	},
	["Implant"] = {
		["LayoutOrder"] = 3,
		["Icon"] = "rbxassetid://93874368032471",
		["KeybindType"] = "AltAbility2",
		["Callback"] = function(p_u_81, p82)
			-- upvalues: (copy) v_u_3, (copy) v_u_7, (copy) v_u_9, (copy) v_u_14, (copy) v_u_11, (copy) v_u_6, (copy) v_u_12
			if game["Run Service"]:IsServer() then
				p_u_81.AbilitiesDisabled = true
				local v_u_83 = p_u_81.Rig
				local v_u_84 = v_u_83.HumanoidRootPart
				local v_u_85 = v_u_83.Voidstar
				task.delay(1.65, function()
					-- upvalues: (copy) p_u_81
					p_u_81.AbilitiesDisabled = false
				end)
				local function v_u_86()
					-- upvalues: (ref) v_u_3, (copy) v_u_85
					v_u_3:Create(v_u_85, TweenInfo.new(0.45, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
						["Size"] = Vector3.new(1.41, 1.41, 1.41),
						["Transparency"] = 0
					}):Play()
				end
				local function v_u_87()
					-- upvalues: (ref) v_u_3, (copy) v_u_85
					v_u_3:Create(v_u_85, TweenInfo.new(0.45, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
						["Size"] = Vector3.new(0, 0, 0),
						["Transparency"] = 1
					}):Play()
				end
				local function v_u_89(p88)
					-- upvalues: (ref) v_u_7, (ref) v_u_9, (copy) p_u_81, (ref) v_u_14, (ref) v_u_11, (ref) v_u_6
					if not v_u_7.onCooldown then
						v_u_7.onCooldown = true
						task.delay(0.2, function()
							-- upvalues: (ref) v_u_7
							v_u_7.onCooldown = false
						end)
						if v_u_7.currentDelay then
							task.cancel(v_u_7.currentDelay)
							v_u_7.currentDelay = nil
						end
						if v_u_7.currentDetection then
							print("found detection hitbox")
							v_u_7.currentDetection:Cancel()
							v_u_7.currentDetection = nil
						end
						v_u_7.currentTrap = nil
						v_u_9:CreateHitbox(p_u_81.Player, {
							["CFrame"] = p88.CFrame,
							["Size"] = Vector3.new(16, 16, 16),
							["PredictVelocity"] = false,
							["Damage"] = p_u_81.Config.ImplantDamage,
							["Knockback"] = p_u_81.Config.ImplantKnockback,
							["HitMultiple"] = true,
							["Hide"] = true,
							["Time"] = 0.125
						})
						v_u_14:EmitParticlesFromAttachment(p88.Explosion)
						v_u_11:Play(p_u_81.Config.Sounds.Explosion, {
							["Volume"] = 0.35,
							["Position"] = p88.Position
						})
						p88.Transparency = 1
						v_u_6:AddItem(p88, 3)
					end
				end
				local v_u_90 = v_u_14:GetClosestPlayerFromPosition(v_u_84.Position, {
					["MaxDistance"] = 7,
					["PlayerSelection"] = "Survivors",
					["OverrideUndetectable"] = true
				})
				local v_u_91 = v_u_90 and "Player" or "Trap"
				print("type", v_u_91)
				if v_u_91 == "Trap" then
					local v_u_92 = v_u_14:CreateSpeedMultiplier(p_u_81.Rig, 0.05, "NoliPlacingTrap")
					task.delay(0.5, function()
						-- upvalues: (copy) v_u_92
						v_u_92:Destroy()
					end)
					v_u_11:Play(p_u_81.Config.Sounds.Implant, {
						["Volume"] = 0.35,
						["Parent"] = v_u_84
					})
				end
				task.delay(0.7, function()
					-- upvalues: (ref) v_u_7, (copy) v_u_89, (copy) v_u_85, (copy) v_u_91, (copy) v_u_87, (copy) v_u_86, (ref) v_u_3, (copy) v_u_84, (ref) v_u_9, (copy) p_u_81, (copy) v_u_90, (copy) v_u_83, (ref) v_u_14, (ref) v_u_11, (ref) v_u_6, (ref) v_u_12
					if v_u_7.currentTrap ~= nil then
						v_u_89(v_u_7.currentTrap)
					end
					local v_u_93 = v_u_85:Clone()
					v_u_93.Transparency = 1
					v_u_93.Anchored = true
					v_u_93.CanCollide = false
					v_u_93.Parent = workspace
					v_u_7.currentTrap = v_u_93
					if v_u_91 == "Trap" then
						v_u_93.Transparency = 0
						v_u_87()
						task.delay(1, v_u_86)
						v_u_3:Create(v_u_93, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 1), {
							["Transparency"] = 0.7
						}):Play()
						v_u_93.CFrame = v_u_84.CFrame * CFrame.new(0, -3, -3.25)
						local v94 = v_u_7
						local v95 = v_u_9
						local v96 = p_u_81.Player
						local v97 = {
							["CFrame"] = v_u_93.CFrame,
							["Size"] = Vector3.new(6, 6, 6),
							["PredictVelocity"] = false,
							["Damage"] = 0,
							["Knockback"] = 0,
							["Time"] = p_u_81.Config.ImplantTime,
							["Hide"] = true,
							["Connections"] = {
								["Hit"] = function()
									-- upvalues: (ref) v_u_89, (copy) v_u_93
									v_u_89(v_u_93)
								end,
								["Ended"] = function()
									-- upvalues: (ref) v_u_89, (copy) v_u_93
									v_u_89(v_u_93)
								end
							}
						}
						v94.currentDetection = v95:CreateHitbox(v96, v97)
					else
						local v_u_98 = v_u_90.HumanoidRootPart
						local v_u_99 = v_u_83.HumanoidRootPart
						v_u_93.Transparency = 1
						v_u_83:SetAttribute("Invincible", true)
						v_u_90:PivotTo(v_u_83:GetPivot() * CFrame.new(0, 0, -4.5) * CFrame.Angles(0, 3.141592653589793, 0))
						task.delay(0.1, function()
							-- upvalues: (ref) v_u_90, (ref) v_u_83
							v_u_90:PivotTo(v_u_83:GetPivot() * CFrame.new(0, 0, -3.15) * CFrame.Angles(0, 3.141592653589793, 0))
							task.wait(1)
							v_u_90:PivotTo(v_u_83:GetPivot() * CFrame.new(0, 0, -2.45) * CFrame.Angles(0, 3.141592653589793, 0))
						end)
						v_u_99.Anchored = true
						v_u_98.Anchored = true
						local v100 = p_u_81.Cache.ImplantAttackNoli
						local v101 = v_u_14:LoadAnimationFromID(v_u_90, p_u_81.Config.Animations.ImplantAttackVictim, true)
						v100:Play(0.05)
						v101:Play(0.05)
						local v102 = {
							["Volume"] = 0.75,
							["Parent"] = v_u_84
						}
						v_u_11:Play(p_u_81.Config.Sounds.ImplantInject, v102)
						task.delay(1.735, function()
							-- upvalues: (copy) v_u_99, (copy) v_u_98, (ref) v_u_90, (ref) v_u_83, (ref) v_u_14, (ref) p_u_81, (ref) v_u_6, (ref) v_u_12, (ref) v_u_85, (ref) v_u_86, (copy) v_u_93, (ref) v_u_7, (ref) v_u_89
							v_u_99.Anchored = false
							v_u_98.Anchored = false
							v_u_90:PivotTo(v_u_83:GetPivot() * CFrame.new(0, 0, -7))
							v_u_6:AddItem(v_u_14:ApplyVelocity(v_u_98, p_u_81.Config.ImplantInjectKnockback), p_u_81.Config.ImplantInjectKnockbackDestroyTime)
							v_u_83:SetAttribute("Invincible", false)
							task.spawn(function()
								-- upvalues: (ref) v_u_12, (ref) v_u_90
								v_u_12:Enable(v_u_90)
								task.wait(0.25)
								v_u_12:Disable(v_u_90)
							end)
							v_u_85.Size = Vector3.new(0, 0, 0)
							task.delay(1, v_u_86)
							v_u_93.CFrame = v_u_98.CFrame * CFrame.new(0, 0, -0.25)
							v_u_93.Transparency = 0
							local v_u_103 = Instance.new("Motor6D")
							v_u_103.Part0 = v_u_98
							v_u_103.Part1 = v_u_93
							v_u_103.Parent = v_u_98
							v_u_7.currentDelay = task.delay(p_u_81.Config.ImplantTime, function()
								-- upvalues: (ref) v_u_93, (copy) v_u_103, (ref) v_u_89
								if v_u_93 and v_u_93.Parent then
									v_u_103:Destroy()
									v_u_89(v_u_93)
								end
							end)
							v_u_93.Destroying:Once(function()
								-- upvalues: (copy) v_u_103
								v_u_103:Destroy()
							end)
						end)
					end
				end)
				return v_u_91
			end
			if game["Run Service"]:IsClient() then
				print((("trap type: %*"):format(p82)))
				if p82 == "Trap" then
					p_u_81.Animations.Implant:Play(0.175)
				end
			end
		end
	},
	["Hallucination"] = {
		["LayoutOrder"] = 4,
		["Icon"] = "rbxassetid://93874368032471",
		["KeybindType"] = "AltAbility3",
		["Callback"] = function(p_u_104)
			-- upvalues: (copy) v_u_14, (copy) v_u_11, (copy) v_u_10
			if game["Run Service"]:IsServer() then
				p_u_104.AbilitiesDisabled = true
				local v105 = p_u_104.Rig.HumanoidRootPart
				local v106 = v_u_14:GetClosestPlayerFromPosition(v105.Position, {
					["MaxDistance"] = p_u_104.Config.HallucinationMaxDistance,
					["PlayerSelection"] = "Survivors",
					["OverrideUndetectable"] = true,
					["ReturnTable"] = true
				})
				v_u_11:Play(p_u_104.Config.Sounds.Hallucination, {
					["Volume"] = 0.35,
					["Parent"] = v105
				})
				for _, v107 in pairs(v106) do
					v_u_14:RevealPlayerAuraTo(p_u_104.Player, v107.Player, p_u_104.Config.HallucinationAuraRevealDuration)
					v_u_10:ApplyStatus(v107.Player, "Hallucination", {
						["Level"] = math.random(1, 3),
						["Duration"] = p_u_104.Config.HallucinationDuration,
						["Hidden"] = true,
						Killer = p_u_104
					})
				end
				task.delay(1.65, function()
					-- upvalues: (copy) p_u_104
					p_u_104.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_104.Animations.Hallucination:Play(0.175)
			end
		end
	}
}
v_u_7.Abilities = v108
return v_u_7
