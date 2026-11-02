-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {}
local v_u_2 = require(game.ReplicatedStorage.Modules.Sounds)
local v_u_3 = require(game.ReplicatedStorage.Modules.Util)
local v_u_4 = require(game.ReplicatedStorage.Modules.Hitboxes)
local v_u_5 = require(game.ReplicatedStorage.Modules.Statuses)
local Lighting = require(game.ReplicatedStorage.Modules.Schematics.Lighting)
local v43 = {
	["SeeYou"] = {
		["LayoutOrder"] = 1,
		["Icon"] = "rbxassetid://93874368032471",
		["KeybindType"] = "MainAbility",
		["Cooldown"] = 1.5,
		["Callback"] = function(p_u_6)
			-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_3
			if game["Run Service"]:IsServer() then
				p_u_6.AbilitiesDisabled = true
				task.delay(0.25, function()
					-- upvalues: (ref) v_u_2, (copy) p_u_6
					v_u_2:Play(p_u_6.Config.Sounds.Swing, {
						["Parent"] = p_u_6.Rig.PrimaryPart,
						["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
						["Volume"] = 0.25
					})
				end)
				task.delay(0.33, function()
					-- upvalues: (ref) v_u_4, (copy) p_u_6, (ref) v_u_3, (ref) v_u_2
					local v7 = v_u_4
					local v8 = p_u_6.Player
					local v11 = {
						["Size"] = Vector3.new(4, 6, 7),
						["CFrameOffset"] = CFrame.new(0, 0, -4),
						["Damage"] = p_u_6.Config.FoundYouDMG,
						["Time"] = 0.2,
						["Knockback"] = 2,
						["HitMultiple"] = true,
						["Connections"] = {
							["Hit"] = function(p9, p10)
								-- upvalues: (ref) v_u_3, (ref) v_u_2, (ref) p_u_6
								v_u_3:CreateSpeedMultiplier(p9, 1.5, "HitSpeedBonus", 1.25)
								if p10 then
									v_u_2:Play(p_u_6.Config.Sounds.Hit, {
										["Parent"] = p_u_6.Rig.PrimaryPart,
										["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
										["Volume"] = 1.5
									})
								end
							end
						}
					}
					v7:CreateHitbox(v8, v11)
				end)
				task.delay(0.75, function()
					-- upvalues: (copy) p_u_6
					p_u_6.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_6.Animations.FoundYou:Play(0.175)
			end
		end
	},
	["Flick"] = {
		["LayoutOrder"] = 2,
		["Icon"] = "rbxassetid://93874368032471",
		["KeybindType"] = "AltAbility1",
		["Cooldown"] = 2,
		["Callback"] = function(p_u_12)
			-- upvalues: (copy) v_u_2
			local v13 = game["Run Service"]:IsServer() and p_u_12.Rig.PrimaryPart
			if v13 then
				local v14 = v13.CFrame.LookVector.Unit
				local v15 = v13.Position + v14 * p_u_12.Config.Flick
				v13.CFrame = CFrame.new(v15, v15 + v14)
				v_u_2:Play(p_u_12.Config.Sounds.Flick, {
					["Parent"] = p_u_12.Rig.PrimaryPart,
					["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
					["Volume"] = 1.25
				})
				p_u_12.Rig.Torso.Smoke.Enabled = true
				task.delay(0.2, function()
					-- upvalues: (copy) p_u_12
					p_u_12.Rig.Torso.Smoke.Enabled = false
				end)
			end
		end
	},
	["Stop"] = {
		["LayoutOrder"] = 3,
		["Icon"] = "rbxassetid://93874368032471",
		["KeybindType"] = "AltAbility2",
		["Cooldown"] = 15,
		["Callback"] = function(p_u_16)
			-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_4, (copy) v_u_5
			if game["Run Service"]:IsServer() then
				p_u_16.AbilitiesDisabled = true
				local v17 = v_u_3:CreateSpeedMultiplier(p_u_16.Player, 0.25, "HinderedMovement")
				game.TweenService:Create(v17, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
					["Value"] = 1
				}):Play()
				game.Debris:AddItem(v17, 1.5)
				task.delay(0.8, function()
					-- upvalues: (ref) v_u_3, (copy) p_u_16, (ref) v_u_2, (ref) v_u_4, (ref) v_u_5
					local v18 = v_u_3:GetPlayerMousePosition(p_u_16.Player)
					local v19 = CFrame.lookAt(p_u_16.Rig.PrimaryPart.Position, v18) * CFrame.new(0, 0, -p_u_16.Config.StopSpeed * 10)
					local v_u_20 = script.cobble:Clone()
					v_u_20.CFrame = CFrame.lookAt(p_u_16.Rig.PrimaryPart.Position, v18)
					v_u_20.Parent = workspace.Map.Ingame
					game.Debris:AddItem(v_u_20, 10)
					game.TweenService:Create(v_u_20, TweenInfo.new(10, Enum.EasingStyle.Linear), {
						["Position"] = v19.Position
					}):Play()
					v_u_2:Play(p_u_16.Config.Sounds.Stop, {
						["Parent"] = p_u_16.Rig.PrimaryPart,
						["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
						["Volume"] = 0.25
					})
					local v21 = v_u_4
					local v22 = p_u_16.Player
					local v24 = {
						["Size"] = Vector3.new(3, 3, 3),
						["CFrame"] = function()
							-- upvalues: (copy) v_u_20
							return v_u_20.CFrame
						end,
						["Damage"] = p_u_16.Config.StopDMG,
						["Time"] = 10,
						["Knockback"] = 0.5,
						["HitMultiple"] = true,
						["ExecuteOnKill"] = false,
						["PredictVelocity"] = false,
						["Connections"] = {
							["Hit"] = function(p23)
								-- upvalues: (ref) v_u_3, (ref) p_u_16, (ref) v_u_5, (ref) v_u_2
								v_u_3:RevealPlayerAuraTo(p_u_16.Player, p23, 10)
								v_u_5:ApplyStatus(p23, "Slowness", {
									["Stackable"] = true,
									["Level"] = 1,
									["Duration"] = 10
								})
								v_u_5:ApplyStatus(p23, "Blindness", {
									["Stackable"] = true,
									["Level"] = 1,
									["Duration"] = 5
								})
								v_u_2:Play(p_u_16.Config.Sounds.Hit, {
									["Parent"] = p_u_16.Rig.PrimaryPart,
									["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
									["Volume"] = 0.25
								})
							end
						}
					}
					v21:CreateHitbox(v22, v24)
				end)
				task.delay(2, function()
					-- upvalues: (copy) p_u_16
					p_u_16.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_16.Animations.Stop:Play(0.025)
			end
		end
	},
	["Summon"] = {
		["LayoutOrder"] = 4,
		["Icon"] = "rbxassetid://93874368032471",
		["KeybindType"] = "AltAbility3",
		["Cooldown"] = 35,
		["Callback"] = function(p_u_25)
			-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_5
			if game["Run Service"]:IsServer() then
				p_u_25.AbilitiesDisabled = true
				task.delay(0.75, function()
					-- upvalues: (copy) p_u_25, (ref) v_u_3, (ref) v_u_2, (ref) v_u_5
					for v26 = 1, 2 do
						local v_u_27 = p_u_25.Config.SteveRig:Clone()
						v_u_27:SetAttribute("Team", "Killers")
						v_u_27.PrimaryPart.Anchored = true
						local v_u_28 = v_u_27.Humanoid
						v_u_28.WalkSpeed = p_u_25.Config.PizzaDeliveryGuySpeed
						v_u_28.MaxHealth = p_u_25.Config.PizzaDeliveryGuyHealth
						v_u_28.Health = p_u_25.Config.PizzaDeliveryGuyHealth
						v_u_28.StateChanged:Connect(function(_, _)
							-- upvalues: (copy) v_u_28
							v_u_28.PlatformStand = false
							v_u_28:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
							v_u_28:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
							v_u_28:ChangeState(Enum.HumanoidStateType.GettingUp)
						end)
						v_u_27.Parent = workspace.Map.Ingame
						local v_u_29 = false
						local v30 = p_u_25.Config.PizzaDeliveryGuyLifetime
						task.delay(v30 - 1, function()
							-- upvalues: (ref) v_u_29, (copy) v_u_27
							if not v_u_29 then
								v_u_29 = true
								game.Debris:AddItem(v_u_27, 1)
								for _, v31 in pairs(v_u_27:GetDescendants()) do
									if v31:IsA("BasePart") or v31:IsA("Decal") then
										game.TweenService:Create(v31, TweenInfo.new(1), {
											["Transparency"] = 1
										}):Play()
									end
								end
							end
						end)
						game.Debris:AddItem(v_u_27, p_u_25.Config.PizzaDeliveryGuyLifetime)
						local v_u_32 = v_u_29
						local v_u_33 = {}
						for v34, v35 in pairs(p_u_25.Config.PizzaDeliveryAnimations) do
							v_u_33[v34] = v_u_3:LoadAnimationFromID(v_u_27, v35, true)
						end
						v_u_33.Idle:Play()
						v_u_27:SetPrimaryPartCFrame(p_u_25.Rig.PrimaryPart.CFrame * CFrame.new(v26 % 2 == 0 and 16 or -16, 0, 0))
						v_u_2:Play(p_u_25.Config.Sounds.Flick, {
							["Parent"] = p_u_25.Rig.PrimaryPart,
							["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025)
						})
						task.wait(0.2)
						task.delay(0.15, function()
							-- upvalues: (copy) v_u_27, (copy) v_u_33, (ref) v_u_3, (ref) p_u_25, (ref) v_u_32, (ref) v_u_5, (copy) v_u_28
							if not v_u_27.PrimaryPart then
								return
							end
							v_u_27.PrimaryPart.Anchored = false
							v_u_33.Walk:Play()
							local v36 = require(game.ReplicatedStorage.Modules.SimplePath).new(v_u_27)
							while task.wait() and (v_u_27.Parent and v_u_27.PrimaryPart) do
								local v37, v38 = v_u_3:GetClosestPlayerFromPosition(v_u_27.PrimaryPart.Position)
								local v39 = v37 and v37.PrimaryPart
								if v39 then
									v39 = v37.PrimaryPart.Position
								end
								if p_u_25.Rig.Parent and (v38 and v38 < p_u_25.Config.PizzaDeliveryGuyAttackRadius) then
									task.delay(1, function()
										-- upvalues: (ref) v_u_32, (ref) v_u_27
										if not v_u_32 then
											v_u_32 = true
											game.Debris:AddItem(v_u_27, 1)
											for _, v40 in pairs(v_u_27:GetDescendants()) do
												if v40:IsA("BasePart") or v40:IsA("Decal") then
													game.TweenService:Create(v40, TweenInfo.new(1), {
														["Transparency"] = 1
													}):Play()
												end
											end
										end
									end)
									v_u_33.Walk:Stop(0)
									v_u_33.Hit:Play(0)
									v_u_3:ApplyDamage(v37, p_u_25.Config.PizzaDeliveryGuyDamage)
									v_u_3:RevealPlayerAuraTo(p_u_25.Player, v37, 7.5)
									v_u_5:ApplyStatus(v37, "Slowness", {
										["Level"] = 2,
										["Duration"] = 3
									})
									break
								end
								if not (p_u_25.Rig.Parent and v39) then
									task.delay(1, function()
										-- upvalues: (ref) v_u_32, (ref) v_u_27
										if not v_u_32 then
											v_u_32 = true
											game.Debris:AddItem(v_u_27, 1)
											for _, v41 in pairs(v_u_27:GetDescendants()) do
												if v41:IsA("BasePart") or v41:IsA("Decal") then
													game.TweenService:Create(v41, TweenInfo.new(1), {
														["Transparency"] = 1
													}):Play()
												end
											end
										end
									end)
									v_u_28.WalkSpeed = 0
									v_u_33.Walk:Stop(0)
									break
								end
								v36:Run(v39)
							end
							v36:Destroy()
						end)
					end
				end)
				task.delay(2, function()
					-- upvalues: (copy) p_u_25
					p_u_25.AbilitiesDisabled = false
				end)
			elseif game["Run Service"]:IsClient() then
				local v_u_42 = v_u_3:CreateSpeedMultiplier(p_u_25.Player, 0, "HinderedMovement")
				task.delay(1, function()
					-- upvalues: (copy) v_u_42
					game.TweenService:Create(v_u_42, TweenInfo.new(0.5), {
						["Value"] = 1
					}):Play()
					game.Debris:AddItem(v_u_42, 0.5)
				end)
			end
		end
	}
}
v1.Abilities = v43
v1.OnIntroduction = function(_, killerInfo : {}, cutsceneRig : Model, duration : number)
	local TW = game:GetService("TweenService")
	--game.Lighting:ClearAllChildren()
	Lighting:SetCustomLighting(killerInfo.Config.IntroLighting)
	local background = workspace.Misc:WaitForChild("KillerCutsceneBackground")
	task.delay(0.13, function()
		for i, v in ipairs(background:FindFirstChild("ShrineLights"):GetChildren()) do
			local light = v:FindFirstChildOfClass("PointLight")
			TW:Create(light, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {Brightness = 0.5}):Play()
		end
	end)
	task.delay(1.07, function()
		background.Lights.Part.SpotLight.Brightness = 1
		local surfacelight : SurfaceLight = background.LightningLights.two.SurfaceLight
		surfacelight.Brightness = 1
		TW:Create(surfacelight, TweenInfo.new(0.217, Enum.EasingStyle.Linear), {Brightness = 0}):Play()
		for i, v : Part in ipairs(background:FindFirstChild("Lightning"):GetChildren()) do
			v.Transparency = 0.85
			TW:Create(v, TweenInfo.new(0.45, Enum.EasingStyle.Linear), {Transparency = 1}):Play()
		end
	end)
	task.delay(2.35, function()
		local block = cutsceneRig:FindFirstChild("Sword") and cutsceneRig:FindFirstChild("Sword"):FindFirstChild("bedrock")
		if block then
			block.Transparency = 0
			for i, v in ipairs(block:GetChildren()) do
				if v:IsA("Decal") then
					v.Transparency = 0
				end
			end
		end
		task.wait(0.13)
		if block and block.Parent then
			block.Transparency = 1
			for i, v in ipairs(block:GetChildren()) do
				if v:IsA("Decal") then
					v.Transparency = 1
				end
			end
		end
		local block = cutsceneRig:FindFirstChild("Sword") and cutsceneRig:FindFirstChild("Sword"):FindFirstChild("log")
		if block then
			block.Transparency = 0
			for i, v in ipairs(block:GetChildren()) do
				if v:IsA("Decal") then
					v.Transparency = 0
				end
			end
		end
		task.wait(0.13)
		if block and block.Parent then
			block.Transparency = 1
			for i, v in ipairs(block:GetChildren()) do
				if v:IsA("Decal") then
					v.Transparency = 1
				end
			end
		end
		local block = cutsceneRig:FindFirstChild("Sword") and cutsceneRig:FindFirstChild("Sword"):FindFirstChild("cobble")
		if block then
			block.Transparency = 0
			for i, v in ipairs(block:GetChildren()) do
				if v:IsA("Decal") then
					v.Transparency = 0
				end
			end
		end
		task.wait(0.217)
		if block and block.Parent then
			block.Transparency = 1
			for i, v in ipairs(block:GetChildren()) do
				if v:IsA("Decal") then
					v.Transparency = 1
				end
			end
		end
		if cutsceneRig:FindFirstChild("Sword") then
			cutsceneRig:FindFirstChild("Sword").Transparency = 0
		end
	end)
	task.delay(3.73, function()
		local smoke = background:FindFirstChild("Smoke") and background:FindFirstChild("Smoke"):FindFirstChildOfClass("ParticleEmitter")
		if smoke then
			smoke:Emit(smoke:GetAttribute("EmitCount") or 0)
		end
	end)
end
return v1
