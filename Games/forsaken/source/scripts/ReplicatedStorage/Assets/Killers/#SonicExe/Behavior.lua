local v1 = {}
local v_u_2 = require(game.ReplicatedStorage.Modules.Sounds)
local v_u_3 = require(game.ReplicatedStorage.Modules.Util)
local v_u_4 = require(game.ReplicatedStorage.Modules.Hitboxes)
local v_u_5 = require(game.ReplicatedStorage.Modules.Statuses)
local v41 = {
	["Godspeed"] = {
		["LayoutOrder"] = 2,
		["Icon"] = "rbxassetid://122958613367274",
		["KeybindType"] = "AltAbility1",
		["Cooldown"] = 40,
		["Callback"] = function(p_u_6)
			-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_5, (copy) v_u_2
			local v_u_7 = p_u_6.Config.GodspeedTimeout
			if game["Run Service"]:IsServer() then
				task.delay(0.125, function()
					-- upvalues: (copy) p_u_6, (ref) v_u_3, (ref) v_u_4, (copy) v_u_7, (ref) v_u_5, (ref) v_u_2
					p_u_6.AbilitiesDisabled = true
					v_u_3:SetSpeedCap(p_u_6.Player, "ExeGodspeed", p_u_6.Config.GodspeedSpeedMultiplier)
					local v_u_8 = nil
					local v_u_9 = nil
					local v11 = v_u_4:CreateHitbox(p_u_6.Player, {
						["Size"] = Vector3.new(5, 5, 5),
						["Damage"] = p_u_6.Config.WalkspeedOverrideDamage,
						["Time"] = v_u_7,
						["Knockback"] = 4.5,
						["HitMultiple"] = true,
						["Connections"] = {
							["Hit"] = function(p10)
								-- upvalues: (ref) v_u_8, (ref) v_u_5
								v_u_8 = p10
								v_u_5:ApplyStatus(p10, "Slowness", {
									["Level"] = 2,
									["Duration"] = 2,
									["Instant"] = true
								})
							end,
							["Ended"] = function()
								-- upvalues: (ref) v_u_9
								v_u_9 = true
							end
						}
					})
					local v12 = v_u_2:Play(p_u_6.Config.Sounds.GodspeedLoop, {
						["Parent"] = p_u_6.Rig.PrimaryPart
					})
					local v13 = v_u_9
					repeat
						task.wait()
					until v_u_8 or (v13 or v11.TimePast > 0.35 and p_u_6.Rig.PrimaryPart.Velocity.Magnitude <= 6)
					local v14 = "IDK"
					local v15
					if v_u_8 then
						v_u_2:Play(p_u_6.Config.Sounds.Hit, {
							["Parent"] = p_u_6.Rig.PrimaryPart
						})
						v15 = "Hit"
					else
						v15 = p_u_6.Rig.PrimaryPart.Velocity.Magnitude <= 6 and "Collide" or (v13 and "Timeout" or v14)
					end
					v12:Destroy()
					v11:Cancel()
					v_u_3:SetSpeedCap(p_u_6.Player, "ExeGodspeed", nil)
					local v16 = Instance.new("StringValue")
					v16.Name = "Result"
					v16.Value = v15
					v16.Parent = p_u_6.Rig
					game.Debris:AddItem(v16, 1.5)
					task.delay(1.5, function()
						-- upvalues: (ref) p_u_6
						p_u_6.AbilitiesDisabled = false
					end)
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_6.Animations.Fly:Play(0.3)
				p_u_6.Rig:SetAttribute("FootstepsMuted", true)
				local v17 = require(game.ReplicatedStorage.Modules.Network)
				v17:FireConnection("DisableSprinting", "Godspeed", true)
				local v18 = v_u_3:CreateSpeedMultiplier(p_u_6.Player, 1, "FasterMovement")
				local v19 = v_u_3:CreateFOVMultiplier(p_u_6.Player, 1, "FOVIncrease")
				game.TweenService:Create(v18, TweenInfo.new(0.35), {
					["Value"] = p_u_6.Config.GodspeedSpeedMultiplier
				}):Play()
				game.TweenService:Create(v19, TweenInfo.new(0.35), {
					["Value"] = 1.35
				}):Play()
				local v_u_20 = p_u_6.Rig.PrimaryPart
				local v_u_21 = p_u_6.Rig:FindFirstChild("Humanoid")
				game["Run Service"]:BindToRenderStep("moveForwards", Enum.RenderPriority.Character.Value + 1, function()
					-- upvalues: (copy) v_u_20, (copy) v_u_21
					if v_u_20 and (v_u_20.Parent and (v_u_21 and v_u_21.Parent)) then
						v_u_21:Move(v_u_20.CFrame.LookVector)
					else
						game["Run Service"]:UnbindFromRenderStep("moveForwards")
					end
				end)
				local v22 = p_u_6.Rig:WaitForChild("Result", v_u_7)
				local v23 = v22 and (v22.Value or "IDK BRUH") or "IDK BRUH"
				game.TweenService:Create(v18, TweenInfo.new(0.5), {
					["Value"] = 1
				}):Play()
				game.Debris:AddItem(v18, 0.5)
				game.TweenService:Create(v19, TweenInfo.new(0.5), {
					["Value"] = 1
				}):Play()
				game.Debris:AddItem(v19, 0.5)
				p_u_6.Animations.Fly:Stop(0.1)
				p_u_6.Rig:SetAttribute("FootstepsMuted", false)
				game["Run Service"]:UnbindFromRenderStep("moveForwards")
				local _ = v23 == "Hit"
				if v22 then
					repeat
						task.wait()
					until not v22.Parent
				end
				v17:FireConnection("DisableSprinting", "Godspeed", false)
			end
		end
	},
	["FoundYou"] = {
		["LayoutOrder"] = 3,
		["Icon"] = "rbxassetid://103346224281360",
		["KeybindType"] = "AltAbility2",
		["Cooldown"] = 45,
		["Callback"] = function(p_u_24)
			-- upvalues: (copy) v_u_2
			if game["Run Service"]:IsServer() then
				p_u_24.AbilitiesDisabled = true
				local v_u_25 = require(game.ReplicatedStorage.Modules.Util):CreateSpeedMultiplier(p_u_24.Player, 0.01, "HinderedMovement")
				game.Debris:AddItem(v_u_25, 3)
				local v26 = {}
				for _, v27 in pairs(workspace.Players.Survivors:GetChildren()) do
					local v28 = v27:FindFirstChild("Humanoid")
					if v28 and v28.Health > 0 then
						table.insert(v26, v27)
					end
				end
				local v29 = math.random
				local v30 = #v26
				local v31 = v26[v29(1, (math.clamp(v30, 1, (1 / 0))))]
				local v32
				if v31 then
					v32 = v31.PrimaryPart
				else
					v32 = v31
				end
				local v33 = game.Players:GetPlayerFromCharacter(v31)
				if v33 then
					require(game.ReplicatedStorage.Modules.Network):FireClientConnection(v33, "ExeJumpscare", "UREMOTE_EVENT")
				end
				if v32 then
					p_u_24.Rig:SetPrimaryPartCFrame(v32.CFrame)
				end
				v_u_2:Play(p_u_24.Config.Sounds.FoundYou, {
					["Parent"] = p_u_24.Rig.PrimaryPart
				})
				task.delay(1.5, function()
					-- upvalues: (copy) v_u_25
					game.TweenService:Create(v_u_25, TweenInfo.new(1.75), {
						["Value"] = 1
					}):Play()
				end)
				task.delay(3, function()
					-- upvalues: (copy) p_u_24
					p_u_24.AbilitiesDisabled = nil
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_24.Animations.FoundYou:Play(0)
				local v34 = game.Players.LocalPlayer.PlayerGui.TemporaryUI:FindFirstChild("static")
				if v34 then
					v34.ImageTransparency = 0
					game.TweenService:Create(v34, TweenInfo.new(0.5), {
						["ImageTransparency"] = 1
					}):Play()
				end
			end
		end
	},
	["Attack"] = {
		["LayoutOrder"] = 1,
		["Icon"] = "rbxassetid://120560249303986",
		["KeybindType"] = "MainAbility",
		["Cooldown"] = 1.3,
		["Callback"] = function(p_u_35)
			-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_3
			if game["Run Service"]:IsServer() then
				p_u_35.AbilitiesDisabled = true
				v_u_2:Play(p_u_35.Config.Sounds.Swing, {
					["Parent"] = p_u_35.Rig.PrimaryPart,
					["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
					["Volume"] = 0.25
				})
				task.delay(0.1, function()
					-- upvalues: (ref) v_u_4, (copy) p_u_35, (ref) v_u_3, (ref) v_u_2
					local v36 = v_u_4
					local v37 = p_u_35.Player
					local v40 = {
						["Size"] = Vector3.new(4.5, 6, 7.5),
						["CFrameOffset"] = CFrame.new(0, 0, -1),
						["Damage"] = p_u_35.Config.AttackDamage,
						["Time"] = 0.3,
						["Knockback"] = 2,
						["HitMultiple"] = false,
						["ExecuteOnKill"] = true,
						["Connections"] = {
							["Hit"] = function(p38)
								-- upvalues: (ref) v_u_3, (ref) v_u_2, (ref) p_u_35
								v_u_3:CreateSpeedMultiplier(p38, 1.5, "HitSpeedBonus", 1.25)
								v_u_2:Play(p_u_35.Config.Sounds.Hit, {
									["Parent"] = p_u_35.Rig.PrimaryPart,
									["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
									["Volume"] = 0.25
								})
								local v39 = p_u_35.Rig:FindFirstChild("HandBlood")
								if v39 then
									if v39.LeftBlood.Transparency == 1 then
										v39.LeftBlood.Transparency = 0
										return
									end
									if v39.RightBlood.Transparency == 1 then
										v39.RightBlood.Transparency = 0
									end
								end
							end
						}
					}
					v36:CreateHitbox(v37, v40)
				end)
				task.delay(0.75, function()
					-- upvalues: (copy) p_u_35
					p_u_35.AbilitiesDisabled = nil
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_35.Animations.Attack:Play(0.2)
			end
		end
	}
}
v1.Abilities = v41
function v1.Created(_, p42)
	local v43 = require(game.ReplicatedStorage.Initializer)
	for _, v44 in pairs(script.Systems:GetChildren()) do
		if v44:IsA("ModuleScript") then
			local v45 = require(v44)
			if v45.Type == "Server" and game["Run Service"]:IsServer() or v45.Type == "Client" and game["Run Service"]:IsClient() then
				v45.__index = v45
				v43.RoundSystems[v44.Name] = setmetatable({}, v45)
				if v43.RoundSystems[v44.Name].Start then
					v43.RoundSystems[v44.Name]:Start(p42)
				end
			end
		end
	end
end
function v1.OnIntroduction(_, _, p46, p47)
	-- upvalues: (copy) v_u_3
	local v48 = script.Instances.Background:Clone()
	v48:SetPrimaryPartCFrame(CFrame.new(0, 10000, 0))
	v48.Parent = workspace
	game.Debris:AddItem(v48, p47)
	local v49 = p46:WaitForChild("HandBlood")
	v49:WaitForChild("RightBlood").Transparency = 0
	v49:WaitForChild("LeftBlood").Transparency = 0
	local v50 = v_u_3:CreateFOVMultiplier(game.Players.LocalPlayer, 1, "IntroCutscene")
	game.TweenService:Create(v50, TweenInfo.new(1), {
		["Value"] = 0.4
	}):Play()
	game.Debris:AddItem(v50, p47 - 0.5)
	task.delay(2.8, function()
		local v51 = script.Instances.Intro2011X:Clone()
		v51.Parent = game.Players.LocalPlayer.PlayerGui
		game.Debris:AddItem(v51.Title, 3)
		game.Debris:AddItem(v51, 6)
		local v52 = require(game.ReplicatedStorage.Modules.Sounds)
		v52:Play(script.SFX.appear)
		task.wait(2.75)
		v52:Play(script.SFX.laugh)
	end)
end
function v1.OnExecution(_, p_u_53, p_u_54)
	task.delay(2.3, function()
		-- upvalues: (copy) p_u_53
		local v55 = (p_u_53.Rig.HumanoidRootPart.CFrame * CFrame.new(-0.575, 0, -5.2)).Position
		local v56 = math.random(-100, 100) / 80
		local v57 = math.random(-100, 100) / 80
		local v58 = v55 - Vector3.new(v56, 10, v57)
		local v59 = script.Instances.Spike:Clone()
		v59.Parent = workspace.Map.Ingame
		v59.CFrame = CFrame.new(v58, v55) * CFrame.Angles(-1.5707963267948966, 0, 0)
		game.TweenService:Create(v59, TweenInfo.new(0.3), {
			["CFrame"] = v59.CFrame * CFrame.new(0, (v58 - v55).Magnitude - 4, 0)
		}):Play()
	end)
	task.delay(4, function()
		-- upvalues: (copy) p_u_54
		local v60 = {
			"NeckAttachment",
			"FaceFrontAttachment",
			"FaceCenterAttachment",
			"FaceFrontAttachment",
			"HairAttachment",
			"HatAttachment"
		}
		local v61 = Instance.new("Model")
		local v62 = p_u_54
		v61.Name = ("%*Head"):format((tostring(v62)))
		v61.Parent = workspace.Map.Ingame
		local v63 = p_u_54:FindFirstChild("Head")
		if v63 then
			local v64 = v63:Clone()
			v64.Anchored = true
			v64.Parent = v61
			v63.Transparency = 1
			v63.CanCollide = false
		end
		for _, v65 in p_u_54:GetChildren() do
			if v65:IsA("Accessory") then
				local v66 = v65:FindFirstChild("Handle")
				if v66 then
					local v67 = false
					for _, v68 in v60 do
						if v66:FindFirstChild(v68) then
							v67 = true
							break
						end
					end
					if v67 then
						local v69 = v65:Clone()
						v69.Handle.Anchored = true
						v69.Parent = v61
						v65:Destroy()
					end
				end
			end
		end
	end)
end
function v1.OnChase(_, p70, p_u_71)
	if p70 == "Started" then
		local v_u_72 = game.Players.LocalPlayer
		local v_u_73 = v_u_72.Character
		local v_u_74
		if v_u_73 then
			v_u_74 = v_u_73:FindFirstChild("Humanoid")
		else
			v_u_74 = v_u_73
		end
		local v_u_75
		if v_u_73 then
			v_u_75 = v_u_73:FindFirstChild("HumanoidRootPart")
		else
			v_u_75 = v_u_73
		end
		v_u_72.PlayerGui.TemporaryUI:FindFirstChild("static")
		p_u_71.Rig:FindFirstChild("HumanoidRootPart")
		if v_u_74 and v_u_75 then
			p_u_71.Cache.Chasing = true
			task.spawn(function()
				-- upvalues: (copy) v_u_74, (copy) p_u_71, (copy) v_u_72, (copy) v_u_75, (copy) v_u_73
				while v_u_74.Parent and (v_u_74.Health > 0 and p_u_71.Cache.Chasing) do
					local v_u_76 = Instance.new("ViewportFrame")
					v_u_76.BackgroundTransparency = 1
					v_u_76.BackgroundColor3 = Color3.new()
					v_u_76.ImageTransparency = 1
					v_u_76.Size = UDim2.fromScale(1, 1)
					v_u_76.CurrentCamera = workspace.CurrentCamera
					v_u_76.Parent = v_u_72.PlayerGui.TemporaryUI
					game.Debris:AddItem(v_u_76, 16)
					local v77 = Instance.new("WorldModel")
					v77.Parent = v_u_76
					local v78 = math.random(25, 75)
					local v79 = math.random(1, 2) == 1 and v78 and v78 or -v78
					local v80 = math.random(25, 75)
					local v81 = math.random(1, 2) == 1 and v80 and v80 or -v80
					local v82 = p_u_71.Rig:Clone()
					v82.PrimaryPart.Anchored = true
					v82:SetPrimaryPartCFrame(CFrame.lookAt((v_u_75.CFrame + Vector3.new(v79, 0.425, v81)).Position, v_u_75.Position + Vector3.new(0, 0.425, 0)))
					v82.Parent = v77
					local v83 = require(game.ReplicatedStorage.Modules.Util)
					local v84 = p_u_71.Config.Animations.Hallucinations
					local v85 = v83:LoadAnimationFromID(v82, v84[math.random(1, #v84)])
					v85.Priority = Enum.AnimationPriority.Action4
					v85.Looped = true
					v85:Play(0)
					local v86 = Instance.new("Part")
					v86.Transparency = 1
					v86.Anchored = true
					v86.CanCollide = false
					v86.Size = Vector3.new(16, 16, 16)
					v86.CFrame = v82.PrimaryPart.CFrame
					v86.Parent = workspace.Map.Ingame
					if not require(game.ReplicatedStorage.Initializer).PlayerSettings.EpilepsyMode.Value then
						game.TweenService:Create(v_u_76, TweenInfo.new(0.2), {
							["ImageTransparency"] = 0.1
						}):Play()
						game.TweenService:Create(v_u_76, TweenInfo.new(math.random(25, 50) / 150, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
							["ImageColor3"] = Color3.new(0.5, 0.5, 0.5)
						}):Play()
						task.wait(0.2)
						game.TweenService:Create(v_u_76, TweenInfo.new(math.random(25, 50) / 150, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
							["ImageTransparency"] = 0.5
						}):Play()
					end
					local v_u_87 = false
					v86.Touched:Connect(function(p88)
						-- upvalues: (ref) v_u_73, (ref) v_u_87, (copy) v_u_76
						if p88.Parent == v_u_73 and not v_u_87 then
							require(game.ReplicatedStorage.Modules.Network):FireServerConnection("RevealPlayerLocation", "UREMOTE_EVENT")
							game.TweenService:Create(v_u_76, TweenInfo.new(0.25), {
								["ImageTransparency"] = 1
							}):Play()
							v_u_87 = true
						end
					end)
					task.wait(math.random(20, 65) / 10)
				end
			end)
			return
		end
	elseif p70 == "Ended" then
		p_u_71.Cache.Chasing = false
		local v89 = game.Players.LocalPlayer.PlayerGui.TemporaryUI:FindFirstChild("static")
		if v89 then
			v89.ImageTransparency = 0
			game.TweenService:Create(v89, TweenInfo.new(0.5), {
				["ImageTransparency"] = 1
			}):Play()
		end
	end
end
return v1
