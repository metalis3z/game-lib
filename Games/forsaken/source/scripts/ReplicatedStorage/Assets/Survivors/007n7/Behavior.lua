-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw
-- Decompiled by Krnl

local v1 = {}
local v_u_2 = require(game.ReplicatedStorage.Modules.Sounds)
local v_u_3 = require(game.ReplicatedStorage.Modules.Util)
require(game.ReplicatedStorage.Modules.Hitboxes)
local v_u_4 = require(game.ReplicatedStorage.Modules.AchievementUtil)
local v_u_5 = require(game.ReplicatedStorage.Modules.Statuses)
local function v_u_14(p6)
	local v7 = workspace.Map.Ingame:FindFirstChild("SpawnPoints", true)
	if v7 then
		local v8 = nil
		local v9 = nil
		for _, v10 in pairs({ "Survivors", "Killers" }) do
			local v11 = v7:FindFirstChild(v10)
			if v11 then
				for _, v12 in ipairs(v11:GetChildren()) do
					if v12:IsA("BasePart") then
						local v13 = (p6.Rig.PrimaryPart.Position - v12.Position).Magnitude
						if not v8 or v9 and v9 <= v13 then
							v9 = v13
							v8 = v12
						end
					end
				end
			end
		end
		return v8
	end
end
local v_u_31 = {
	{
		["Type"] = "aimless",
		["Callback"] = function(_, p_u_15, _)
			local v_u_16 = p_u_15:FindFirstChild("Humanoid")
			if v_u_16 then
				task.spawn(function()
					-- upvalues: (copy) p_u_15, (copy) v_u_16
					while task.wait(math.random(2, 4)) and (p_u_15.Parent and p_u_15.PrimaryPart) do
						local v17 = v_u_16
						local v18 = p_u_15.PrimaryPart.Position
						local v19 = math.random(-100, 100) * 100
						local v20 = math.random(-100, 100) * 100
						v17:MoveTo(v18 + Vector3.new(v19, 0, v20))
					end
				end)
			end
		end
	},
	{
		["Type"] = "pathfind",
		["SpawnRequired"] = true,
		["Callback"] = function(p_u_21, p_u_22, p_u_23)
			local v_u_24 = p_u_22:FindFirstChild("Humanoid")
			if v_u_24 then
				task.spawn(function()
					-- upvalues: (copy) p_u_22, (copy) v_u_24, (copy) p_u_23
					local v25 = require(game.ReplicatedStorage.Modules.SimplePath).new(p_u_22, {
						["AgentRadius"] = 5
					})
					while p_u_22.Parent and (p_u_22.PrimaryPart and v_u_24.Health > 0) do
						v25:Run(p_u_23.Position)
						task.wait(0.12)
					end
					v25:Destroy()
				end)
				task.spawn(function()
					-- upvalues: (copy) p_u_21, (copy) p_u_22, (copy) v_u_24
					local v26 = 0
					while v26 <= p_u_21.Config.CloneControlWindup and (p_u_22.Parent and (p_u_22.PrimaryPart and v_u_24.Health > 0)) do
						v_u_24:MoveTo((p_u_22.PrimaryPart.CFrame * CFrame.new(0, 0, -100)).Position)
						v26 = v26 + task.wait()
					end
				end)
			end
		end
	},
	{
		["Type"] = "cursor",
		["Callback"] = function(p_u_27, p_u_28, _)
			-- upvalues: (copy) v_u_3
			local v_u_29 = p_u_28:FindFirstChild("Humanoid")
			if v_u_29 then
				task.delay(p_u_27.Config.CloneControlWindup, function()
					-- upvalues: (copy) p_u_28, (copy) p_u_27, (ref) v_u_3, (copy) v_u_29
					tick()
					while task.wait() and (p_u_28.Parent and (p_u_28.PrimaryPart and p_u_27.Player.Parent)) do
						local v30 = v_u_3:GetPlayerMousePosition(p_u_27.Player)
						if v30 then
							v_u_29:MoveTo(v30)
							tick()
						end
					end
				end)
			end
		end
	}
}
local v82 = {
	["Clone"] = {
		["LayoutOrder"] = 1,
		["KeybindType"] = "AltAbility1",
		["Icon"] = "rbxassetid://83534637834767",
		["Callback"] = function(p_u_32, _)
			-- upvalues: (copy) v_u_3, (copy) v_u_31, (copy) v_u_14, (copy) v_u_2, (copy) v_u_4, (copy) v_u_5
			if game["Run Service"]:IsServer() then
				p_u_32.AbilitiesDisabled = true
				for v33 = 1, p_u_32.Config.CloneAmount do
					local v_u_34 = true
					local v_u_35 = p_u_32.Rig:Clone()
					v_u_3:AddHitboxes(v_u_35, "Survivors")
					local v_u_36 = v_u_35.Humanoid
					local _ = v_u_35.PrimaryPart
					v_u_35:SetAttribute("Team", "Survivors")
					v_u_35:AddTag("SimulateSurvivor")
					v_u_35.Parent = workspace.Map.Ingame
					v_u_36.WalkSpeed = p_u_32.Config.CloneSpeed
					v_u_36:MoveTo((v_u_35.PrimaryPart.CFrame * CFrame.new(0, 0, -100)).Position)
					game.Debris:AddItem(v_u_35, p_u_32.Config.CloneLifetime + 1)
					v_u_36:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
					v_u_36:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
					v_u_36:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
					local v_u_37 = false
					task.spawn(function()
						-- upvalues: (copy) v_u_36, (copy) p_u_32, (ref) v_u_3, (copy) v_u_35, (ref) v_u_37
						local v38 = v_u_36.Health <= v_u_36.MaxHealth / 2 and "Injured" or ""
						local v_u_39 = {
							["Run"] = true,
							["Idle"] = true
						}
						for v40, _ in pairs(v_u_39) do
							v_u_39[v40] = v_u_3:LoadAnimationFromID(v_u_35, p_u_32.Config.Animations[("%*%*"):format(v38, v40)] or p_u_32.Config.Animations[v40])
							v_u_39[v40].Looped = true
						end
						v_u_36.Running:Connect(function(p41)
							-- upvalues: (ref) v_u_37, (copy) v_u_39
							if p41 <= 0.05 and v_u_37 then
								v_u_37 = false
								v_u_39.Run:Stop(0.01)
								v_u_39.Idle:Play(0.01)
							elseif p41 > 0.05 and not v_u_37 then
								v_u_37 = true
								v_u_39.Run:Play(0.01)
								v_u_39.Idle:Stop(0.01)
							end
						end)
					end)
					task.spawn(function()
						-- upvalues: (ref) v_u_31, (copy) p_u_32, (ref) v_u_3, (copy) v_u_35, (ref) v_u_14, (copy) v_u_36, (ref) v_u_37, (ref) v_u_2
						local v42 = v_u_31[p_u_32.PathfindType] or v_u_31[1]
						local v43 = v_u_3:GetClosestPlayerFromPosition(p_u_32:GetPivot().Position, {
							["MaxDistance"] = 100,
							["PlayerSelection"] = "Killers",
							["OverrideUndetectable"] = true
						})
						if v43 then
							v43 = game.Players:GetPlayerFromCharacter(v43)
						end
						for _, v44 in ipairs(v_u_35:GetDescendants()) do
							if v44:IsA("BasePart") and v44:CanSetNetworkOwnership() then
								v44:SetNetworkOwner(v43)
							end
						end
						local v45 = v_u_14(p_u_32)
						if v42.SpawnRequired and not v45 then
							v42 = v_u_31[1]
						end
						if v42 then
							v42.Callback(p_u_32, v_u_35, v45)
						end
						task.spawn(function()
							-- upvalues: (ref) v_u_35, (ref) v_u_36, (ref) v_u_37, (ref) v_u_2
							local v46 = 0
							local v47 = 0
							while v_u_35.Parent and (v_u_35.PrimaryPart and v_u_36.Health > 0) do
								if v46 >= 0.35 and v_u_37 then
									local v48 = ("footstep%*"):format(require(game.ServerScriptService.Server.Miscellaneous.FootstepReplication).FootstepRenaming[v_u_36.FloorMaterial] or "Cement")
									if v_u_35.PrimaryPart and v_u_35.PrimaryPart.Parent then
										v_u_2:Play(v48, {
											["Parent"] = v_u_35.PrimaryPart,
											["PlaybackSpeed"] = Random.new():NextNumber(0.9, 1.1),
											["Volume"] = 0.25
										})
									end
									v47 = v47 + 1
									v46 = 0
								end
								v46 = v46 + task.wait()
							end
						end)
					end)
					v_u_3:FixCharacter(v_u_35, "Survivors")
					v_u_3:RevealPlayerAuraTo(p_u_32.Player, v_u_35, 600, Color3.new(1, 1, 1))
					task.delay(p_u_32.Config.CloneLifetime, function()
						-- upvalues: (ref) v_u_34, (copy) v_u_36
						v_u_34 = false
						v_u_36.Health = 0
					end)
					local v_u_49 = v_u_36.Health
					v_u_36.HealthChanged:Connect(function(p50)
						-- upvalues: (ref) v_u_49, (ref) v_u_34, (copy) p_u_32
						if p50 < v_u_49 - 10 and v_u_34 then
							require(game.ReplicatedStorage.Modules.Actors):IncrementActorStats(p_u_32.Player, {
								["Action"] = "Tricked the Killer",
								["RewardType"] = "Survivalist"
							})
						end
						v_u_49 = p50
					end)
					v_u_36.Died:Once(function()
						-- upvalues: (ref) v_u_34, (ref) v_u_4, (copy) p_u_32
						if v_u_34 then
							v_u_4:IncrementAchievementProgress(p_u_32.Player, "007n7Clone")
						end
					end)
					if v33 ~= p_u_32.Config.CloneAmount then
						task.wait()
					end
				end
				v_u_5:ApplyStatus(p_u_32.Rig, "Invisibility", {
					["Level"] = p_u_32.Config.InvisibilityLevel or 4,
					["Duration"] = p_u_32.Config.InvisibilityTime
				})
				v_u_5:ApplyStatus(p_u_32.Rig, "Undetectable", {
					["Level"] = 1,
					["Duration"] = p_u_32.Config.InvisibilityTime
				})
				task.delay(p_u_32.Config.InvisibilityTime + 1, function()
					-- upvalues: (copy) p_u_32
					p_u_32.AbilitiesDisabled = false
				end)
			else
				game["Run Service"]:IsClient()
			end
		end
	},
	["c00lgui"] = {
		["LayoutOrder"] = 2,
		["KeybindType"] = "AltAbility2",
		["Icon"] = "rbxassetid://89910721511648",
		["Callback"] = function(p_u_51, _)
			-- upvalues: (copy) v_u_2, (copy) v_u_14, (copy) v_u_3, (copy) v_u_4
			if game["Run Service"]:IsServer() then
				p_u_51.AbilitiesDisabled = true
				p_u_51:ChangeExpression("Concentrating")
				local v_u_52 = p_u_51.Config.c00lguiTemplate:Clone()
				local v_u_53 = v_u_52:FindFirstChild("Label", true)
				if not v_u_53 then
					v_u_53 = {
						["Text"] = "idk"
					}
				end
				v_u_52.CFrame = CFrame.lookAt((p_u_51.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -2.125)).Position, p_u_51.Rig.PrimaryPart.Position + Vector3.new(0, 1.125, 0))
				v_u_53.Text = "click 2 h4x!!1!"
				local v54 = Instance.new("WeldConstraint")
				v54.Parent = v_u_52
				v54.Part1 = v_u_52
				v54.Part0 = p_u_51.Rig.PrimaryPart
				local v55 = v_u_52.Size
				v_u_52.Anchored = false
				v_u_52.CanCollide = false
				v_u_52.Massless = true
				v_u_52.Size = Vector3.new()
				v_u_52.Parent = p_u_51.Rig
				if p_u_51.Behavior.ToggleGUI then
					p_u_51.Behavior:ToggleGUI(v_u_52, true)
				else
					game.TweenService:Create(v_u_52, TweenInfo.new(1.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
						["Size"] = v55
					}):Play()
				end
				local v_u_56 = v_u_2:Play(p_u_51.Config.Sounds.c00lguiActivated, {
					["Parent"] = p_u_51.Rig.PrimaryPart
				})
				local v_u_57 = nil
				local v_u_58 = p_u_51.Rig.Humanoid.Health
				local v_u_60 = p_u_51.Rig.Humanoid.HealthChanged:Connect(function(p59)
					-- upvalues: (ref) v_u_58, (ref) v_u_57
					if p59 < v_u_58 then
						v_u_57 = "failed"
					end
					v_u_58 = p59
				end)
				local v_u_61 = p_u_51.Rig.PrimaryPart:GetPropertyChangedSignal("Anchored"):Connect(function()
					-- upvalues: (ref) v_u_57
					v_u_57 = "failed"
				end)
				local v62 = p_u_51.Rig:FindFirstChild("SpeedMultipliers")
				local v_u_63
				if v62 then
					v_u_63 = v62.ChildAdded:Connect(function(p64)
						-- upvalues: (ref) v_u_57
						if p64.Value <= 0 and p64.Name ~= "Emoting" then
							v_u_57 = "failed"
						end
					end)
				else
					v_u_63 = nil
				end
				task.delay(2.3, function()
					-- upvalues: (ref) v_u_57, (copy) v_u_53
					if not v_u_57 then
						v_u_53.Text = "h4xxing in pr0gr3ss...!!1!"
					end
				end)
				task.delay(p_u_51.Config.c00lguiWindupTime, function()
					-- upvalues: (ref) v_u_57
					if not v_u_57 then
						v_u_57 = "teleported"
					end
				end)
				task.spawn(function()
					-- upvalues: (ref) v_u_57, (copy) p_u_51, (copy) v_u_53, (copy) v_u_56, (copy) v_u_52, (ref) v_u_14, (ref) v_u_3, (ref) v_u_4, (ref) v_u_60, (ref) v_u_61, (ref) v_u_63
					repeat
						task.wait()
					until v_u_57
					p_u_51:ChangeExpression("Default")
					task.spawn(function()
						-- upvalues: (ref) v_u_57, (ref) v_u_53, (ref) v_u_56, (ref) p_u_51, (ref) v_u_52
						if v_u_57 == "teleported" then
							v_u_53.Text = "H4XX3D!!1!1"
						else
							v_u_53.Text = "o noes D:"
							if v_u_56 then
								game.Debris:AddItem(v_u_56, 1)
								game.TweenService:Create(v_u_56, TweenInfo.new(1), {
									["PlaybackSpeed"] = 0
								}):Play()
							end
						end
						task.wait(1)
						if p_u_51.Behavior.ToggleGUI then
							p_u_51.Behavior:ToggleGUI(v_u_52, false)
						else
							game.Debris:AddItem(v_u_52, 0.2)
							game.TweenService:Create(v_u_52, TweenInfo.new(0.2), {
								["Size"] = Vector3.new()
							}):Play()
						end
					end)
					local v65 = v_u_57 == "teleported" and (p_u_51 and (p_u_51.Rig and (p_u_51.Rig.Parent and v_u_14(p_u_51))))
					if v65 then
						local v66 = CFrame.new(v65.Position + Vector3.new(0, 2, 0)) * p_u_51.Rig.PrimaryPart.CFrame.Rotation
						for _, v67 in ipairs(workspace.Players.Killers:GetChildren()) do
							if v_u_3:IsAlive(v67) then
								local v68 = (v67.PrimaryPart.Position - v66.Position).Magnitude
								if (v67.PrimaryPart.Position - p_u_51.Rig.PrimaryPart.Position).Magnitude < 12 then
									v_u_4:IncrementAchievementProgress(p_u_51.Player, "007n7Close")
								end
								if v68 < 8 then
									v_u_4:IncrementAchievementProgress(p_u_51.Player, "007n7Oops")
								end
							end
						end
						p_u_51:PivotTo(v66)
					end
					v_u_60:Disconnect()
					v_u_60 = nil
					v_u_61:Disconnect()
					v_u_61 = nil
					v_u_63:Disconnect()
					v_u_63 = nil
					local v69 = Instance.new("StringValue")
					local v70 = v_u_57
					v69.Value = tostring(v70)
					v69.Name = "Result"
					v69.Parent = p_u_51.Rig
					game.Debris:AddItem(v69, 2)
					task.delay(2, function()
						-- upvalues: (ref) p_u_51
						p_u_51.AbilitiesDisabled = false
					end)
				end)
			elseif game["Run Service"]:IsClient() then
				if p_u_51.Animations.c00lguiStart then
					p_u_51.Animations.c00lguiStart:Play()
				end
				if p_u_51.Animations.c00lguiLoop then
					p_u_51.Animations.c00lguiLoop:Play()
				end
				local v71 = require(game.ReplicatedStorage.Modules.Network)
				v71:FireConnection("DisableSprinting", "c00lgui", true)
				local v72 = v_u_3:CreateSpeedMultiplier(p_u_51.Rig, 0.1, "c00lgui")
				local v73 = v_u_3:CreateProgressBar("Using c00lgui", p_u_51.Config.c00lguiWindupTime)
				local v74 = tick()
				repeat
					task.wait()
				until p_u_51.Rig:FindFirstChild("Result") or tick() >= v74 + p_u_51.Config.c00lguiWindupTime + 1
				if p_u_51.Animations.c00lguiStart then
					p_u_51.Animations.c00lguiStart:Stop()
				end
				if p_u_51.Animations.c00lguiLoop then
					p_u_51.Animations.c00lguiLoop:Stop()
				end
				if p_u_51.Animations.c00lguiEnd then
					p_u_51.Animations.c00lguiEnd:Play(0)
				end
				v71:FireConnection("DisableSprinting", "c00lgui", false)
				v72:Destroy()
				v73:Destroy()
			end
		end
	},
	["Inject"] = {
		["LayoutOrder"] = 3,
		["KeybindType"] = "AltAbility3",
		["Icon"] = "rbxassetid://85844834952266",
		["Callback"] = function(p75, p76)
			-- upvalues: (copy) v_u_31
			if game["Run Service"]:IsServer() then
				p75.PathfindType = p75.PathfindType % #v_u_31 + 1
				return p75.PathfindType
			end
			local v77 = game["Run Service"]:IsClient() and v_u_31[p76]
			if v77 then
				local v78 = p75.Player.PlayerGui.TemporaryUI:FindFirstChild("InjectUI")
				if v78 then
					v78:Destroy()
				end
				local v79 = p75.Config.InjectTemplate:Clone()
				local v80 = v79.Label
				local v81 = v77.Type
				v80.Text = ("clone movement type: %*"):format((tostring(v81)))
				v79.Name = "InjectUI"
				v79.Parent = p75.Player.PlayerGui.TemporaryUI
				game.Debris:AddItem(v79, 2)
				game.TweenService:Create(v79, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
					["BackgroundTransparency"] = 1
				}):Play()
				game.TweenService:Create(v79.Label, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
					["TextTransparency"] = 1
				}):Play()
				game.TweenService:Create(v79.UIStroke, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
					["Transparency"] = 1
				}):Play()
			end
		end
	}
}
v1.Abilities = v82
function v1.Created(_, p_u_83)
	-- upvalues: (copy) v_u_14
	if game["Run Service"]:IsServer() then
		p_u_83.PathfindType = 1
	elseif game["Run Service"]:IsClient() and p_u_83.Player == game.Players.LocalPlayer then
		task.spawn(function()
			-- upvalues: (copy) p_u_83, (ref) v_u_14
			local v_u_84 = p_u_83.Config.DexTemplate:Clone()
			v_u_84.Parent = p_u_83.Player.PlayerGui:FindFirstChild("TemporaryUI")
			p_u_83.Rig.Humanoid.HealthChanged:Connect(function(p85)
				-- upvalues: (copy) v_u_84
				if p85 <= 0 then
					v_u_84:Destroy()
				end
			end)
			p_u_83.Rig.AncestryChanged:Connect(function(_, p86)
				-- upvalues: (copy) v_u_84
				if not p86 then
					v_u_84:Destroy()
				end
			end)
			while task.wait(0.1) and p_u_83.Rig.Parent do
				local v87 = v_u_14(p_u_83)
				if v87 and v_u_84.Adornee ~= v87 then
					v_u_84.Adornee = v87
				end
			end
		end)
	end
end
return v1
