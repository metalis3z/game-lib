-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {}
local v_u_2 = require(game.ReplicatedStorage.Modules.Sounds)
local v_u_3 = require(game.ReplicatedStorage.Modules.Util)
local v_u_4 = require(game.ReplicatedStorage.Modules.Hitboxes)
local v_u_5 = require(game.ReplicatedStorage.Modules.Statuses)
local v_u_6 = require(game.ReplicatedStorage.Modules.Network)
local v37 = {
	["Slash"] = {
		["LayoutOrder"] = 1,
		["KeybindType"] = "AltAbility1",
		["Icon"] = "rbxassetid://85282571177550",
		["Callback"] = function(p_u_7, _)
			-- upvalues: (copy) v_u_2, (copy) v_u_5, (copy) v_u_4, (copy) v_u_6, (copy) v_u_3
			if game["Run Service"]:IsServer() then
				p_u_7.AbilitiesDisabled = true
				task.delay(p_u_7.Config.SlashWindupTime * 3, function()
					-- upvalues: (copy) p_u_7
					p_u_7.AbilitiesDisabled = false
				end)
				for _, v8 in pairs(p_u_7.Rig:GetChildren()) do
					if v8.Name:find("Sword") and not v8:GetAttribute("Ignored") then
						v8.Transparency = 0
					end
				end
				for _, v9 in pairs(p_u_7.Rig.Sword:GetChildren()) do
					if v9:IsA("ParticleEmitter") or (v9:IsA("Light") or v9:IsA("Highlight")) then
						v9.Enabled = true
					end
				end
				task.delay(p_u_7.Config.SlashWindupTime + 0.3, function()
					-- upvalues: (copy) p_u_7
					for _, v10 in pairs(p_u_7.Rig:GetChildren()) do
						if v10.Name:find("Sword") then
							game.TweenService:Create(v10, TweenInfo.new(0.5), {
								["Transparency"] = 1
							}):Play()
						end
					end
					task.wait(0.3)
					for _, v11 in pairs(p_u_7.Rig.Sword:GetChildren()) do
						if v11:IsA("ParticleEmitter") or (v11:IsA("Light") or v11:IsA("Highlight")) then
							v11.Enabled = false
						end
					end
				end)
				v_u_2:Play(p_u_7.Config.Sounds.Unsheath, {
					["Parent"] = p_u_7.Rig.Sword
				})
				v_u_5:ApplyStatus(p_u_7.Rig, "Resistance", {
					["Level"] = 2,
					["Duration"] = p_u_7.Config.SlashWindupTime
				})
				if not p_u_7.TotalTimesStunned then
					p_u_7.TotalTimesStunned = 0
				end
				task.delay(p_u_7.Config.SlashWindupTime, function()
					-- upvalues: (ref) v_u_2, (copy) p_u_7, (ref) v_u_4, (ref) v_u_5
					v_u_2:Play(p_u_7.Config.Sounds.Slash, {
						["Parent"] = p_u_7.Rig.Sword
					})
					local v12 = v_u_4
					local v13 = p_u_7.Player
					local v17 = {
						["Size"] = Vector3.new(4, 6, 5),
						["CFrameOffset"] = CFrame.new(0, 0, -2.25),
						["Damage"] = p_u_7.Config.SlashDamage,
						["Time"] = 0.25,
						["Knockback"] = 5,
						["HitMultiple"] = false,
						["Connections"] = {
							["Hit"] = function(p14)
								-- upvalues: (ref) v_u_5, (ref) p_u_7, (ref) v_u_2
								v_u_5:ApplyStatus(p14, "Stunned", {
									["Duration"] = p_u_7.Config.SlashStunTime
								})
								v_u_2:Play(p_u_7.Config.Sounds.Hit, {
									["Parent"] = p_u_7.Rig.Sword
								})
								v_u_2:PlayVoiceline(p_u_7, "SlashHit", {
									["Priority"] = 1
								})
								p_u_7:ChangeExpression("StunnedKiller", 4)
								local v15 = p_u_7
								v15.TotalTimesStunned = v15.TotalTimesStunned + 1
								if p_u_7.TotalTimesStunned == 3 then
									require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(p_u_7.Player, "ShedletskyStunner")
								end
								local v16 = p14.Parent
								if tostring(v16) == "Killers" then
									require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(p_u_7.Player, {
										["Action"] = "Stunned Killer as Shedletsky",
										["RewardType"] = "Offensive"
									})
								end
							end
						}
					}
					v12:CreateHitbox(v13, v17)
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_7.Animations.Slash:Play(0.1)
				v_u_6:FireConnection("DisableSprinting", "ShedletskySlash", true)
				local v_u_18 = v_u_3:CreateSpeedMultiplier(p_u_7.Rig, 0.25, "StunningKiller")
				task.delay(p_u_7.Config.SlashWindupTime + 1, function()
					-- upvalues: (ref) v_u_6, (copy) v_u_18
					v_u_6:FireConnection("DisableSprinting", "ShedletskySlash", false)
					v_u_18:Destroy()
				end)
			end
		end
	},
	["FriedChicken"] = {
		["LayoutOrder"] = 2,
		["KeybindType"] = "AltAbility2",
		["Icon"] = "rbxassetid://87451970500470",
		["Charges"] = 2,
		["Callback"] = function(p_u_19, _)
			-- upvalues: (copy) v_u_2, (copy) v_u_5, (copy) v_u_6, (copy) v_u_3
			if game["Run Service"]:IsServer() then
				p_u_19.AbilitiesDisabled = true
				local function v_u_23(p20, p21)
					-- upvalues: (copy) v_u_23
					for _, v22 in pairs(p20:GetChildren()) do
						if v22.Name:find("Chicken") and (v22:IsA("BasePart") or v22:IsA("Decal")) and not v22:GetAttribute("Ignored") then
							v22.Transparency = p21
							v_u_23(v22, p21)
						end
					end
				end
				v_u_23(p_u_19.Rig, 0)
				local function v_u_27(p24, p25)
					-- upvalues: (copy) v_u_27
					for _, v26 in pairs(p24:GetChildren()) do
						if v26.Name:find("Wings") and (v26:IsA("BasePart") or v26:IsA("Decal")) and not v26:GetAttribute("Ignored") then
							v26.Transparency = p25
							v_u_27(v26, p25)
						end
					end
				end
				v_u_27(p_u_19.Rig, 0)
				if p_u_19.Cache.EatChicken then
					p_u_19.Cache.EatChicken:Play()
				end
				v_u_2:Play(p_u_19.Config.Sounds.EatFriedChicken, {
					["Parent"] = p_u_19.Rig.PrimaryPart
				})
				task.delay(p_u_19.Config.FriedChickenHealDelay, function()
					-- upvalues: (ref) v_u_5, (copy) p_u_19
					v_u_5:ApplyStatus(p_u_19.Player, "Speed", {
						["Level"] = 1,
						["Duration"] = 10
					})
					v_u_5:ApplyStatus(p_u_19.Player, "Strength", {
						["Level"] = 20,
						["Duration"] = 10
					})
					v_u_5:ApplyStatus(p_u_19.Player, "Resistance", {
						["Level"] = 1,
						["Duration"] = 15
					})
					local v28 = p_u_19.Rig:FindFirstChild("Humanoid")
					if v28 then
						if v28.Health > 0 then
							v28.Health = v28.Health + p_u_19.Config.FriedChickenHealInitialAmount
							local v_u_29 = true
							local v_u_30 = v28.Health
							local v_u_31 = nil
							v_u_31 = v28.HealthChanged:Connect(function(p32)
								-- upvalues: (copy) v_u_30, (ref) v_u_29, (ref) v_u_31
								if p32 <= 0 or p32 <= v_u_30 - 10 then
									v_u_29 = false
									v_u_31:Disconnect()
									v_u_31 = nil
								end
							end)
							local v33 = v_u_29
							local v34 = 0
							while p_u_19.Rig.Parent do
								local v35 = task.wait()
								v34 = v34 + v35
								if not v33 then
									return
								end
								if not p_u_19.Rig.Parent then
									return
								end
								if p_u_19.Config.FriedChickenHealOvertimeDuration <= v34 then
									return
								end
								v28.Health = v28.Health + v35 * p_u_19.Config.FriedChickenHealOvertimeAmount / p_u_19.Config.FriedChickenHealOvertimeDuration
							end
						end
					end
				end)
				task.delay(2.75, function()
					-- upvalues: (copy) v_u_23, (copy) p_u_19
					v_u_23(p_u_19.Rig, 1)
				end)
				task.delay(10, function()
					-- upvalues: (copy) v_u_27, (copy) p_u_19
					v_u_27(p_u_19.Rig, 1)
				end)
				task.delay(4, function()
					-- upvalues: (copy) p_u_19
					p_u_19.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_19.Animations.EatChicken:Play(0.1)
				v_u_6:FireConnection("DisableSprinting", "EatFriedChicken", true)
				local v_u_36 = v_u_3:CreateSpeedMultiplier(p_u_19.Rig, 0.25, "EatFriedChicken")
				task.delay(p_u_19.Config.FriedChickenHealDelay + 1.25, function()
					-- upvalues: (ref) v_u_6, (copy) v_u_36
					v_u_6:FireConnection("DisableSprinting", "EatFriedChicken", false)
					v_u_36:Destroy()
				end)
			end
		end
	}
}
v1.Abilities = v37
return v1
