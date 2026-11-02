-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl
-- Decompiled by regg

local v1 = {}
local v_u_2 = require(game.ReplicatedStorage.Modules.Sounds)
local v_u_3 = require(game.ReplicatedStorage.Modules.Util)
local v_u_4 = require(game.ReplicatedStorage.Modules.Hitboxes)
local v_u_5 = require(game.ReplicatedStorage.Modules.Statuses)
local v_u_6 = require(game.ReplicatedStorage.Modules.Network)
local v29 = {
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
				p_u_7.Behavior:PreSlash(p_u_7)
				p_u_7:ChangeExpression("Concentrating", p_u_7.Config.SlashWindupTime + 0.5)
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
					local v8 = v_u_4
					local v9 = p_u_7.Player
					local v13 = {
						["Size"] = Vector3.new(4, 6, 5),
						["CFrameOffset"] = CFrame.new(0, 0, -0.5),
						["Damage"] = p_u_7.Config.SlashDamage,
						["Time"] = 0.25,
						["Knockback"] = 5,
						["HitMultiple"] = false,
						["Connections"] = {
							["Hit"] = function(p10)
								-- upvalues: (ref) v_u_5, (ref) p_u_7, (ref) v_u_2
								v_u_5:ApplyStatus(p10, "Stunned", {
									["Duration"] = p_u_7.Config.SlashStunTime
								})
								v_u_2:Play(p_u_7.Config.Sounds.Hit, {
									["Parent"] = p_u_7.Rig.Sword
								})
								v_u_2:PlayVoiceline(p_u_7, "SlashHit", {
									["Priority"] = 1
								})
								p_u_7:ChangeExpression("StunnedKiller", 4)
								local v11 = p_u_7
								v11.TotalTimesStunned = v11.TotalTimesStunned + 1
								if p_u_7.TotalTimesStunned == 3 then
									require(game.ReplicatedStorage.Modules.AchievementUtil):IncrementAchievementProgress(p_u_7.Player, "ShedletskyStunner")
								end
								local v12 = p10.Parent
								if tostring(v12) == "Killers" then
									require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(p_u_7.Player, {
										["Action"] = "Stunned Killer as Shedletsky",
										["RewardType"] = "Offensive"
									})
								end
							end
						}
					}
					v8:CreateHitbox(v9, v13)
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_7.Animations.Slash:Play(0.1)
				v_u_6:FireConnection("DisableSprinting", "ShedletskySlash", true)
				local v_u_14 = v_u_3:CreateSpeedMultiplier(p_u_7.Rig, 0.25, "StunningKiller")
				task.delay(p_u_7.Config.SlashWindupTime + 1, function()
					-- upvalues: (ref) v_u_6, (copy) v_u_14
					v_u_6:FireConnection("DisableSprinting", "ShedletskySlash", false)
					v_u_14:Destroy()
				end)
			end
		end
	},
	["FriedChicken"] = {
		["LayoutOrder"] = 2,
		["KeybindType"] = "AltAbility2",
		["Icon"] = "rbxassetid://87451970500470",
		["Charges"] = 2,
		["Callback"] = function(p_u_15, _)
			-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_6
			if game["Run Service"]:IsServer() then
				p_u_15.AbilitiesDisabled = true
				p_u_15:IncrementCharges("FriedChicken", -1, 2)
				local function v_u_19(p16, p17)
					for _, v18 in pairs(p16:GetDescendants()) do
						if v18.Name:find("Chicken") and (v18:IsA("BasePart") or v18:IsA("Decal")) and not v18:GetAttribute("Ignored") then
							v18.Transparency = p17
						end
					end
				end
				v_u_19(p_u_15.Rig, 0)
				if p_u_15.Cache.EatChicken then
					p_u_15.Cache.EatChicken:Play()
				end
				v_u_2:Play(p_u_15.Config.Sounds.EatFriedChicken, {
					["Parent"] = p_u_15.Rig.PrimaryPart
				})
				task.delay(p_u_15.Config.FriedChickenHealDelay, function()
					-- upvalues: (copy) p_u_15, (ref) v_u_3
					local v20 = p_u_15.Rig:FindFirstChild("Humanoid")
					if v20 then
						if v20.Health > 0 then
							v_u_3:Heal(v20, p_u_15.Config.FriedChickenHealInitialAmount)
							local v_u_21 = true
							local v_u_22 = v20.Health
							local v_u_23 = nil
							v_u_23 = v20.HealthChanged:Connect(function(p24)
								-- upvalues: (copy) v_u_22, (ref) v_u_21, (ref) v_u_23
								if p24 <= 0 or p24 <= v_u_22 - 10 then
									v_u_21 = false
									v_u_23:Disconnect()
									v_u_23 = nil
								end
							end)
							local v25 = v_u_21
							local v26 = 0
							while p_u_15.Rig.Parent do
								local v27 = task.wait()
								v26 = v26 + v27
								if not v25 then
									return
								end
								if not p_u_15.Rig.Parent then
									return
								end
								if p_u_15.Config.FriedChickenHealOvertimeDuration <= v26 then
									return
								end
								v_u_3:Heal(v20, v27 * p_u_15.Config.FriedChickenHealOvertimeAmount / p_u_15.Config.FriedChickenHealOvertimeDuration)
							end
						end
					end
				end)
				task.delay(2.75, function()
					-- upvalues: (copy) v_u_19, (copy) p_u_15
					v_u_19(p_u_15.Rig, 1)
				end)
				task.delay(4, function()
					-- upvalues: (copy) p_u_15
					p_u_15.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_15.Animations.EatChicken:Play(0.1)
				v_u_6:FireConnection("DisableSprinting", "EatFriedChicken", true)
				local v_u_28 = v_u_3:CreateSpeedMultiplier(p_u_15.Rig, 0.25, "EatFriedChicken")
				task.delay(p_u_15.Config.FriedChickenHealDelay + 1.25, function()
					-- upvalues: (ref) v_u_6, (copy) v_u_28
					v_u_6:FireConnection("DisableSprinting", "EatFriedChicken", false)
					v_u_28:Destroy()
				end)
			end
		end
	}
}
v1.Abilities = v29
function v1.PreSlash(_, p_u_30)
	for _, v31 in pairs(p_u_30.Rig:GetChildren()) do
		if v31.Name:find("Sword") and not v31:GetAttribute("Ignored") then
			v31.Transparency = 0
		end
	end
	for _, v32 in pairs(p_u_30.Rig.Sword:GetChildren()) do
		if v32:IsA("ParticleEmitter") or (v32:IsA("Light") or v32:IsA("Highlight")) then
			v32.Enabled = true
		end
	end
	task.delay(p_u_30.Config.SlashWindupTime + 0.3, function()
		-- upvalues: (copy) p_u_30
		for _, v33 in pairs(p_u_30.Rig:GetChildren()) do
			if v33.Name:find("Sword") then
				game.TweenService:Create(v33, TweenInfo.new(0.5), {
					["Transparency"] = 1
				}):Play()
			end
		end
		task.wait(0.3)
		for _, v34 in pairs(p_u_30.Rig.Sword:GetChildren()) do
			if v34:IsA("ParticleEmitter") or (v34:IsA("Light") or v34:IsA("Highlight")) then
				v34.Enabled = false
			end
		end
	end)
end
return v1
