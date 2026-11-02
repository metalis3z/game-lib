-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = {
	["Connections"] = {},
	["KillerIntros"] = {}
}
local v_u_2 = game.Players.LocalPlayer
local v_u_3 = require(game.ReplicatedStorage.Modules.Network)
local v_u_4 = require(game.ReplicatedStorage.Modules.Actors)
local v_u_5 = require(game.ReplicatedStorage.Modules.Util)
local v_u_6 = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)
local v_u_7 = require(game.ReplicatedStorage.Modules.Statuses)
local v_u_8 = require(game.ReplicatedStorage.Systems.Player.Game.CharacterReplication)
function v_u_1.Start(_)
	-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_5, (copy) v_u_1, (copy) v_u_2, (copy) v_u_6, (copy) v_u_7, (copy) v_u_8
	v_u_3:SetConnection("ActorDestroyed", "REMOTE_EVENT", function(p9)
		-- upvalues: (ref) v_u_4
		local v_u_10 = v_u_4.CurrentActors[p9]
		if v_u_10 then
			for _, v11 in pairs({ "Destroyed", "DestroyedPost" }) do
				if v_u_10.CustomBehavior and v_u_10.CustomBehavior[v11] then
					v_u_10.CustomBehavior[v11](v_u_10.CustomBehavior, v_u_10)
				elseif v_u_10.Behavior[v11] then
					v_u_10.Behavior[v11](v_u_10.Behavior, v_u_10)
				end
			end
			task.spawn(function()
				-- upvalues: (copy) v_u_10
				if v_u_10.ActorType:find("Killer") then
					local v12 = require(game.ReplicatedStorage.Systems.Character.Game.ChaseThemes)
					require(game.ReplicatedStorage.Systems.Character.Game.ChaseThemesKiller)
					v12:KillerRemoved(v_u_10)
				end
			end)
			v_u_4.__actorDestroyed:Fire(v_u_10)
		end
		v_u_4.CurrentActors[p9] = nil
	end)
	v_u_3:SetConnection("ActorCreated", "REMOTE_EVENT", function(p_u_13)
		-- upvalues: (ref) v_u_4, (ref) v_u_5, (ref) v_u_1, (ref) v_u_2, (ref) v_u_3, (ref) v_u_6, (ref) v_u_7, (ref) v_u_8
		local v14 = v_u_4:ApplySkinDataToActorInfo(p_u_13)
		p_u_13.CustomBehavior = v14 and (v14:FindFirstChild("Behavior") and require(v14.Behavior)) or {}
		v_u_4.CurrentActors[p_u_13.Player] = p_u_13
		v_u_5:PreloadAssets(p_u_13.Config)
		task.spawn(function()
			-- upvalues: (copy) p_u_13
			if p_u_13.ActorType:find("Killer") then
				local v15 = require(game.ReplicatedStorage.Systems.Character.Game.ChaseThemes)
				local v16 = require(game.ReplicatedStorage.Systems.Character.Game.ChaseThemesKiller)
				v15:KillerAdded(p_u_13)
				v16:KillerAdded(p_u_13)
			end
		end)
		task.spawn(function()
			-- upvalues: (copy) p_u_13, (ref) v_u_1, (ref) v_u_5, (ref) v_u_4, (ref) v_u_2
			for _, v17 in pairs({ "Created", "CreatedPost" }) do
				if p_u_13.CustomBehavior and p_u_13.CustomBehavior[v17] then
					p_u_13.CustomBehavior[v17](p_u_13.CustomBehavior, p_u_13)
				elseif p_u_13.Behavior[v17] then
					p_u_13.Behavior[v17](p_u_13.Behavior, p_u_13)
				end
			end
			if p_u_13.ActorType:find("Killer") then
				if p_u_13.Config.IntroductionsDisabled then
					return
				else
					local v18 = p_u_13.Config.Animations.Introduction
					if #v_u_1.KillerIntros >= 16 then
						table.clear(v_u_1.KillerIntros)
					end
					local v19 = v_u_1.KillerIntros
					local v20 = {}
					local v21 = p_u_13.Player
					v20.PlayerName = tostring(v21)
					local v22 = p_u_13.Config.DisplayName or p_u_13.ActorName
					v20.KillerName = tostring(v22)
					table.insert(v19, v20)
					if #v_u_1.KillerIntros <= 1 then
						task.delay(7.5, function()
							-- upvalues: (ref) v_u_1
							table.clear(v_u_1.KillerIntros)
						end)
					end
					local v23 = require(game.ReplicatedStorage.Initializer)
					if #v_u_1.KillerIntros > 1 or v23.PlayerSettings and (v23.PlayerSettings.SkipIntros and v23.PlayerSettings.SkipIntros.Value) or not (v18 and (v18.KillerRig and v18.CameraRig)) then
						task.wait(0.5)
						v_u_5:FadeOut({
							["Time"] = 0.75
						})
						v_u_5:CreateDisplayUI(v_u_1.KillerIntros)
					elseif #v_u_1.KillerIntros <= 1 then
						local v24 = 0
						if not (p_u_13.Rig.Parent and p_u_13.Rig:FindFirstChild("HumanoidRootPart")) then
							repeat
								local v25 = print
								local v26 = p_u_13.Rig
								v25((("waiting until %* is ready to be accessed"):format((tostring(v26)))))
								v24 = v24 + task.wait()
							until v24 >= 10 or p_u_13.Rig.Parent and p_u_13.Rig:FindFirstChild("HumanoidRootPart")
						end
						if v24 >= 10 then
							return
						end
						task.wait(0.1)
						local v_u_27, v_u_28, v_u_29 = v_u_4:CreateCutsceneActor(p_u_13, "Introduction")
						local v_u_30 = p_u_13.Config.ForcedIntroTime or v_u_29.CameraRig.Length
						local v_u_31 = require(game.ReplicatedStorage.Modules.Schematics.Lighting)
						task.spawn(function()
							-- upvalues: (copy) v_u_31
							local v32 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 5)
							if v32 then
								v32 = v32:WaitForChild("Lighting", 5)
							end
							if v32 then
								v_u_31.isInCutscene = true
								v_u_31:SetCustomLighting(v32)
							end
						end)
						task.spawn(function()
							-- upvalues: (ref) p_u_13
							local v33 = require(game.ReplicatedStorage.Modules.Sounds)
							v33:Play(p_u_13.Config.Sounds.Introduction)
							v33:PlayVoiceline(p_u_13, "Introduction", {
								["Priority"] = 10,
								["Parent"] = workspace:FindFirstChild("Sounds") or workspace.Misc
							})
						end)
						task.spawn(function()
							-- upvalues: (ref) p_u_13, (copy) v_u_29, (copy) v_u_27, (copy) v_u_30, (ref) v_u_1
							if not p_u_13.Cache then
								p_u_13.Cache = {}
							end
							p_u_13.Cache.IntroductionKillerTrack = v_u_29.KillerRig
							p_u_13.Cache.IntroductionCameraTrack = v_u_29.CameraRig
							if p_u_13.CustomBehavior.OnIntroduction then
								p_u_13.CustomBehavior:OnIntroduction(p_u_13, v_u_27, v_u_30, v_u_1.KillerIntros)
							elseif p_u_13.Behavior.OnIntroduction then
								p_u_13.Behavior:OnIntroduction(p_u_13, v_u_27, v_u_30, v_u_1.KillerIntros)
							end
						end)
						v_u_5:FadeOut({
							["Time"] = 0.35
						})
						v_u_2.PlayerGui.MainUI.Enabled = false
						v_u_2.PlayerGui.TemporaryUI.Enabled = false
						task.delay(0.75, function()
							-- upvalues: (ref) v_u_5, (ref) v_u_1
							v_u_5:CreateDisplayUI(v_u_1.KillerIntros)
						end)
						task.delay(v_u_30 - 0.5, function()
							-- upvalues: (ref) v_u_5
							v_u_5:FadeIn({
								["TweenInfo"] = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
							})
						end)
						task.delay(v_u_30, function()
							-- upvalues: (copy) v_u_28, (copy) v_u_27, (copy) v_u_31
							workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
							v_u_28:Destroy()
							v_u_27:Destroy()
							v_u_31.isInCutscene = false
							v_u_31:SetAsCurrentLighting()
						end)
						task.delay(v_u_30 + 0.25, function()
							-- upvalues: (ref) v_u_2, (ref) v_u_5
							v_u_2.PlayerGui.MainUI.Enabled = true
							v_u_2.PlayerGui.TemporaryUI.Enabled = true
							v_u_5:FadeOut({
								["Time"] = 0.75
							})
						end)
					end
				end
			else
				return
			end
		end)
		task.spawn(function()
			-- upvalues: (copy) p_u_13, (ref) v_u_2, (ref) v_u_1, (ref) v_u_5, (ref) v_u_3, (ref) v_u_6, (ref) v_u_7, (ref) v_u_4, (ref) v_u_8
			if p_u_13.Player == v_u_2 then
				v_u_1:Destroy()
				p_u_13.Animations = {}
				for v34, v35 in pairs(p_u_13.Config.Animations) do
					if typeof(v35) == "string" then
						p_u_13.Animations[v34] = v_u_5:LoadAnimationFromID(p_u_13.Rig, v35)
					elseif typeof(v35) == "table" then
						for v36, v37 in pairs(v35) do
							if typeof(v37) == "string" then
								if not p_u_13.Animations[v34] then
									p_u_13.Animations[v34] = {}
								end
								p_u_13.Animations[v34][v36] = v_u_5:LoadAnimationFromID(p_u_13.Rig, v37)
							end
						end
					end
				end
				local v_u_38 = {}
				p_u_13.Animations.Idle.Priority = Enum.AnimationPriority.Core
				p_u_13.Animations.Walk.Priority = Enum.AnimationPriority.Core
				p_u_13.Animations.Run.Priority = Enum.AnimationPriority.Core
				p_u_13.Animations.Idle:Play(0)
				p_u_13.Animations.Idle.Looped = true
				local v39 = p_u_13.Animations.Idle
				table.insert(v_u_38, v39)
				local v_u_40 = false
				local v_u_41 = 0
				local function v_u_44(p42)
					-- upvalues: (copy) v_u_38
					for _, v43 in pairs(v_u_38) do
						v43:Stop(p42)
					end
					table.clear(v_u_38)
				end
				for v45, v46 in pairs(p_u_13.Animations) do
					if v45:find("Walk") or v45:find("Run") then
						v46.KeyframeReached:Connect(function(p47)
							-- upvalues: (ref) v_u_2, (ref) v_u_40, (ref) v_u_41, (ref) v_u_3
							if p47 == "Footstep" and (v_u_2.Character.Humanoid.FloorMaterial ~= Enum.Material.Air and (v_u_2.Character.Humanoid.FloorMaterial ~= Enum.Material.Neon and (v_u_2.Character.PrimaryPart.Velocity.Magnitude > 3 and not (v_u_2.Character.PrimaryPart.Anchored or v_u_2.Character:GetAttribute("FootstepsMuted"))))) then
								if v_u_40 then
									v_u_40 = false
									return
								end
								v_u_41 = v_u_41 + 1
								v_u_3:FireServerConnection("FootstepPlayed", "UREMOTE_EVENT", v_u_41)
							end
						end)
					end
				end
				v_u_2.Character:GetAttributeChangedSignal("Ragdolling"):Connect(function()
					-- upvalues: (ref) v_u_2, (copy) v_u_44, (ref) p_u_13, (copy) v_u_38
					if v_u_2.Character:GetAttribute("Ragdolling") then
						v_u_44(0.1)
					else
						local v48 = v_u_2.Character.Humanoid
						local v49 = v48.Health - (v48:GetAttribute("FakeDamage") or 0)
						local v50 = p_u_13.AnimationType or (v49 <= v48.MaxHealth / 2 and "Injured" or "")
						local v51 = p_u_13.Animations[("%*Idle"):format(v50)]
						if v51 then
							v51:Play(0.1)
							local v52 = v_u_38
							table.insert(v52, v51)
						end
					end
				end)
				local v_u_53 = ""
				v_u_2.Character.Humanoid.Running:Connect(function(p54)
					-- upvalues: (ref) v_u_2, (ref) p_u_13, (ref) v_u_53, (ref) v_u_40, (ref) v_u_6, (copy) v_u_44, (copy) v_u_38
					if not v_u_2.Character:GetAttribute("Ragdolling") then
						local v55 = v_u_2.Character.Humanoid
						local v56 = v55.Health - (v55:GetAttribute("FakeDamage") or 0)
						local v57 = p_u_13.AnimationType or (v56 <= v55.MaxHealth / 2 and "Injured" or "")
						local v58 = p_u_13.Animations[("%*Idle"):format(v57)]
						local v59 = p_u_13.Animations[("%*Walk"):format(v57)]
						local v60 = p_u_13.Animations[("%*Run"):format(v57)]
						local v61 = p_u_13.MovementAnimSpeed or p_u_13.Config.MovementAnimSpeed
						if v61 then
							v59:AdjustSpeed(v61)
							v60:AdjustSpeed(v61)
						else
							local v62 = p_u_13.Config.Speed
							local v63
							if tonumber(v62) then
								local v64 = p_u_13.Config.Speed
								v63 = tonumber(v64) / 1.2 or 10
							else
								v63 = 10
							end
							v59:AdjustSpeed(p54 / v63)
							local v65 = p_u_13.Config.SprintSpeed
							v60:AdjustSpeed(p54 / (tonumber(v65) or 28))
						end
						if p54 > 0.01 and (v_u_53 ~= v57 or not p_u_13.Moving) then
							v_u_40 = true
							p_u_13.Moving = true
							if v_u_6.IsSprinting then
								v_u_44(0.15)
								v60:Play(0.15)
								local v66 = v_u_38
								table.insert(v66, v60)
							else
								v_u_44(0.15)
								v59:Play(0.15)
								local v67 = v_u_38
								table.insert(v67, v59)
							end
						elseif p54 < 0.01 then
							p_u_13.Moving = nil
							v_u_44(0.1)
							v58:Play(0.1)
							local v68 = v_u_38
							table.insert(v68, v58)
						end
						v_u_53 = v57
					end
				end)
				task.spawn(function()
					-- upvalues: (ref) v_u_6, (ref) p_u_13, (ref) v_u_2, (ref) v_u_1, (ref) v_u_5, (ref) v_u_40, (copy) v_u_44, (copy) v_u_38
					if v_u_6.Character ~= p_u_13.Rig or not v_u_6.DefaultsSet then
						local v69 = 0
						repeat
							v69 = v69 + game["Run Service"].Heartbeat:Wait()
						until v_u_6.Character == p_u_13.Rig and v_u_6.DefaultsSet or v69 >= 10
					end
					v_u_6.SprintSpeed = p_u_13.Config.SprintSpeed or v_u_6.SprintSpeed
					v_u_6.StaminaLoss = p_u_13.Config.StaminaLoss or v_u_6.StaminaLoss
					v_u_6.StaminaGain = p_u_13.Config.StaminaGain or v_u_6.StaminaGain
					v_u_6.MaxStamina = p_u_13.Config.MaxStamina or v_u_6.MaxStamina
					v_u_6.MinStamina = p_u_13.Config.MinStamina or v_u_6.MinStamina
					v_u_6.Stamina = v_u_6.MaxStamina
					v_u_6.__staminaChangedEvent:Fire(v_u_6.MaxStamina)
					if v_u_6.MaxStamina == v_u_6.MaxStamina and v_u_6.Stamina == v_u_6.Stamina then
						local v_u_70 = p_u_13.Rig
						if v_u_70 then
							v_u_70 = p_u_13.Rig.PrimaryPart
						end
						if p_u_13.ActorType:find("Killer") and v_u_70 then
							local v_u_71 = 0
							v_u_1.Connections.StaminaDrainConnection = game["Run Service"].RenderStepped:Connect(function(p72)
								-- upvalues: (ref) v_u_71, (ref) v_u_5, (copy) v_u_70, (ref) v_u_6
								v_u_71 = v_u_71 + p72
								if v_u_71 >= 0.1 then
									v_u_71 = 0
									local v73 = v_u_5:GetClosestPlayerFromPosition(v_u_70.Position, {
										["MaxDistance"] = 100,
										["PlayerSelection"] = "Survivors",
										["OverrideUndetectable"] = true,
										["VerticalMultiplier"] = 3
									})
									if v73 then
										v73 = v73.PrimaryPart
									end
									if v73 and v_u_6.StaminaLossDisabled then
										v_u_6.StaminaLossDisabled = false
										return
									end
									if not (v73 or v_u_6.StaminaLossDisabled) then
										v_u_6.StaminaLossDisabled = true
									end
								end
							end)
						end
						v_u_1.Connections.SprintingConnection = v_u_6.SprintToggled:Connect(function(p74, p75)
							-- upvalues: (ref) v_u_5, (ref) p_u_13, (ref) v_u_40, (ref) v_u_2, (ref) v_u_44, (ref) v_u_38
							local v76 = v_u_5
							local v77 = p_u_13
							if v77 then
								v77 = p_u_13.Rig
							end
							if v76:IsAlive(v77) then
								if p_u_13.Moving and p74 ~= p75 then
									v_u_40 = true
									local v78 = v_u_2.Character.Humanoid
									local v79 = p_u_13.AnimationType or (v78.Health - (v78:GetAttribute("FakeDamage") or 0) <= v_u_2.Character.Humanoid.MaxHealth / 2 and "Injured" or "")
									local v80 = p_u_13.Animations[("%*Walk"):format(v79)]
									local v81 = p_u_13.Animations[("%*Run"):format(v79)]
									v_u_44(0.3)
									if p74 then
										v81:Play(0.3)
										local v82 = v_u_38
										table.insert(v82, v81)
										return
									end
									v80:Play(0.3)
									local v83 = v_u_38
									table.insert(v83, v80)
								end
							end
						end)
						local v84 = v_u_2.PlayerGui.MainUI:FindFirstChild("SprintingButton")
						local v85 = v_u_2.PlayerGui.MainUI:FindFirstChild("ShiftLockButton")
						if v84 and v84.Visible then
							v84.AnchorPoint = Vector2.new(0, 0)
							v84.Size = UDim2.fromOffset(125, 125)
							v84.Position = UDim2.new(1, -160, 1, -170)
							v85.Position = UDim2.new(1, -135, 1, -4)
							local v86 = v_u_2.PlayerGui.MainUI:WaitForChild("AbilityContainer")
							v86.AnchorPoint = v84.AnchorPoint
							v86.Position = v84.Position
							v86.Size = v84.Size + UDim2.fromScale(0.075, 0.075)
							Instance.new("UIAspectRatioConstraint").Parent = v86
						end
						return
					else
						task.spawn(function()
							-- upvalues: (ref) v_u_2
							v_u_2:Kick("\n\nForsakenCheatKiller 000:\nStamina exceeds max possible cap\n")
						end)
						while true do

						end
					end
				end)
				local v_u_87 = game.ReplicatedStorage.Systems.Player.UI.CustomBackpack.Backpack:Clone()
				v_u_87.Name = "AbilityContainer"
				v_u_87.Parent = v_u_2.PlayerGui.MainUI
				v_u_1.AbilityHotbar = v_u_87
				local v_u_88 = p_u_13.Behavior.Abilities or {}
				for v89, v90 in pairs(p_u_13.CustomBehavior.Abilities or {}) do
					v_u_88[v89] = v90
				end
				p_u_13.Cooldowns = {}
				v_u_1.Connections.CooldownConnection = game["Run Service"].RenderStepped:Connect(function(p91)
					-- upvalues: (ref) v_u_7, (ref) v_u_2, (copy) v_u_88, (ref) p_u_13, (copy) v_u_87
					local v92 = v_u_7:PlayerHasStatus(v_u_2, "Hacked") and true
					for v93, _ in pairs(v_u_88) do
						local v94 = p_u_13.Cooldowns[v93]
						local v95 = v_u_88[v93] or {}
						local v96 = v_u_87:FindFirstChild(v93)
						local v97 = v95.CurrentCharges
						if v97 then
							v97 = v95.CurrentCharges > 0
						end
						local v98 = v97 and v95.NameCharged or (v95.Name or v93:gsub("(%l)(%u)", "%1 %2"))
						local v99 = v97 and v95.IconCharged or (v95.Icon or "rbxassetid://10724129940")
						if v96.Image ~= v99 then
							v96.Image = v99
						end
						local v100 = v96.Clipping.Top
						if v100.Image ~= v99 then
							v100.Image = v99
						end
						local v101 = v96.AbilityName
						if v101.Text ~= v98 then
							v101.Text = v98
						end
						if v94 then
							local v102 = v94.Duration
							local v103 = v94.TimePast
							local v104 = v103 / v102
							local v105 = math.clamp(v104, 0, 1)
							local v106 = v102 - v103
							local v107
							if v92 then
								v107 = v95.KeybindType ~= "MainAbility"
							else
								v107 = v92
							end
							local v108 = v95.Charges and (v95.CurrentCharges and v95.Recharge)
							if v108 then
								v108 = v95.CurrentCharges < v95.Charges
							end
							if v105 >= 1 and not v108 then
								p_u_13.Cooldowns[v93] = nil
							end
							local v109 = v105 == 0 and 0 or 1 / v105
							if v96 and not v95.Disabled then
								local v110 = v96.Clipping
								local v111 = UDim2.fromScale(1, v105)
								if v110.Size ~= v111 then
									v110.Size = v111
								end
								local v112 = v96.Clipping.Top
								local v113 = UDim2.fromScale(1, v109)
								if v112.Size ~= v113 then
									v112.Size = v113
								end
								local v114 = v96.CooldownTime
								local v115 = v105 >= 1 and "" or ("%*"):format(v106 < 10 and string.format("%.1f", v102 - v103) or math.round(v106))
								if v114.Text ~= v115 then
									v114.Text = v115
								end
							end
							if v95.ChargeDuration and v95.CurrentRecharge then
								if v95.CurrentRecharge < v95.ChargeDuration and v108 then
									local v116 = v96.Charges.Recharge.Fill
									local v117 = UDim2.fromScale(v95.CurrentRecharge / v95.ChargeDuration, 1)
									if v116.Size ~= v117 then
										v116.Size = v117
									end
									local v118 = v96.Charges.Recharge
									if v118.Visible ~= true then
										v118.Visible = true
									end
									if not v107 then
										v95.CurrentRecharge = v95.CurrentRecharge + p91
									end
								else
									local v119 = v96.Charges.Recharge
									if v119.Visible ~= false then
										v119.Visible = false
									end
								end
							end
							if not v107 then
								v94.TimePast = v94.TimePast + p91
							end
						end
					end
				end)
				local v_u_120 = require(game.ReplicatedStorage.Modules.Device)
				local v_u_121
				if v_u_120:GetPlayerDevice() == "Mobile" then
					local v122 = v_u_87:FindFirstChild("UIListLayout")
					if v122 then
						v122:Destroy()
					end
					v_u_121 = script.ButtonPath:Clone()
					v_u_121.Parent = v_u_87
				else
					v_u_121 = nil
				end
				p_u_13.HeldAbilities = {}
				local v_u_123 = require(game.ReplicatedStorage.Initializer)
				local v124 = p_u_13.Config
				for v_u_125, v_u_126 in pairs(v_u_88 or {}) do
					local v_u_127
					if v124 then
						v_u_127 = v124[("%*HoldTime"):format(v_u_125)]
					else
						v_u_127 = v124
					end
					local v_u_128 = v124 and v124[("%*SensitiveButton"):format(v_u_125)] or v_u_126.Sensitive
					local v_u_129 = v124 and v124[("%*ToggleButton"):format(v_u_125)] or v_u_126.Toggle
					local v130 = v_u_126.Name
					local v_u_131 = game.ReplicatedStorage.Assets.UI.AbilityIcon:Clone()
					v_u_131.Clipping.Top.Image = v_u_126.Icon or "rbxassetid://114519105023135"
					v_u_131.Image = v_u_126.Icon or "rbxassetid://114519105023135"
					v_u_131.LayoutOrder = v_u_126.LayoutOrder
					v_u_131.AbilityName.Text = v130 or v_u_125:gsub("(%l)(%u)", "%1 %2")
					v_u_131.Name = v_u_125
					v_u_131.Parent = v_u_87
					v_u_131.MouseButton1Click:Connect(function()
						-- upvalues: (copy) v_u_129, (ref) p_u_13, (copy) v_u_125, (ref) v_u_3, (copy) v_u_127, (copy) v_u_128
						if v_u_129 then
							p_u_13.HeldAbilities[v_u_125] = not p_u_13.HeldAbilities[v_u_125]
							if p_u_13.HeldAbilities[v_u_125] then
								v_u_3:FireServerConnection("UseActorAbility", "REMOTE_EVENT", v_u_125)
								return
							end
						elseif not (v_u_127 or v_u_128) then
							v_u_3:FireServerConnection("UseActorAbility", "REMOTE_EVENT", v_u_125)
						end
					end)
					if not v_u_129 then
						v_u_131.MouseButton1Down:Connect(function()
							-- upvalues: (ref) p_u_13, (copy) v_u_125, (copy) v_u_127, (copy) v_u_128, (ref) v_u_3
							p_u_13.HeldAbilities[v_u_125] = true
							if v_u_127 or v_u_128 then
								v_u_3:FireServerConnection("UseActorAbility", "REMOTE_EVENT", v_u_125)
							end
						end)
						v_u_131.MouseButton1Up:Connect(function()
							-- upvalues: (ref) p_u_13, (copy) v_u_125
							p_u_13.HeldAbilities[v_u_125] = nil
						end)
					end
					if v_u_126.Charges then
						local v132 = v_u_126.Charges > 0
						local v133 = v132 and v_u_126.NameCharged or (v_u_126.Name or v_u_125:gsub("(%l)(%u)", "%1 %2"))
						local v134 = v132 and v_u_126.IconCharged or v_u_126.Icon
						v_u_131.Image = v134
						v_u_131.Clipping.Top.Image = v134
						v_u_131.AbilityName.Text = v133
						local v135 = v_u_131.Charges
						local v136 = v_u_126.Charges
						v135.Text = tostring(v136)
						if v_u_126.Charges <= 0 and not (v_u_126.ChargesOptional or v_u_126.ChargesDisabled) then
							v_u_5:ToggleLockForAbilityIcon(v_u_125, "NoCharges", true)
						end
					end
					if v_u_121 then
						v_u_131.KeybindName.Visible = false
						v_u_131.AnchorPoint = Vector2.new(0.5, 0.5)
						v_u_131.Size = UDim2.fromScale(0.45, 0.45)
					end
					local v137 = v_u_2.PlayerGui.MainUI:FindFirstChild("Backpack")
					if v137 and not v_u_121 then
						v137.Position = UDim2.new(1, -20, 0.9, -55)
					end
					local v_u_138 = {}
					local v_u_139 = v_u_126.KeybindType
					if v_u_139 then
						for _, v140 in pairs({ v_u_123.PlayerSettings[v_u_139], v_u_123.PlayerSettings[("%*~Console"):format(v_u_139)] }) do
							local v141 = v140.Value
							table.insert(v_u_138, v141)
						end
					end
					local v_u_142 = {
						{ "MouseButton1", "LMB" },
						{ "MouseButton2", "RMB" },
						{ "MouseButton3", "MMB" },
						{ "Button", "", true }
					}
					local function v150()
						-- upvalues: (copy) v_u_126, (copy) v_u_120, (copy) v_u_123, (copy) v_u_139, (copy) v_u_131, (copy) v_u_142
						local v143 = v_u_126.FlavorText
						local v144 = v_u_120:GetPlayerDevice() == "PC" and v_u_123.PlayerSettings[v_u_139]
						if not v144 then
							if v_u_120:GetPlayerDevice() == "Console" then
								v144 = v_u_123.PlayerSettings[("%*~Console"):format(v_u_139)]
							else
								v144 = false
							end
						end
						if v144 then
							local v145 = v144.Value
							local v146 = tostring(v145)
							for _, v147 in pairs(v_u_142) do
								local v148 = v147[1]
								local v149 = v147[2]
								if not v147[3] or v_u_120:GetPlayerDevice() == "Console" then
									v146 = v146:gsub(v148, v149)
								end
							end
							v_u_131.KeybindName.Text = v146:gsub("(%l)(%u)", "%1 %2")
							v_u_131.FlavorText.Text = v143 or ""
						else
							v_u_131.KeybindName.Text = v143 or ""
						end
					end
					v150()
					v_u_1.Connections[("%*KeybindUpdatedConnection"):format(v_u_125)] = v_u_120.Changed:Connect(v150)
					local v_u_151 = require(game.ReplicatedStorage.Systems.Character.Game.Emotes)
					if v_u_120:GetPlayerDevice() == "PC" then
						v_u_129 = false
					end
					v_u_1.Connections[("%*InputConnection"):format(v_u_125)] = game.UserInputService.InputBegan:Connect(function(p152, p153)
						-- upvalues: (copy) v_u_138, (copy) v_u_151, (copy) v_u_129, (ref) p_u_13, (copy) v_u_125, (ref) v_u_3
						if not p153 then
							if table.find(v_u_138, p152.KeyCode.Name) or table.find(v_u_138, p152.UserInputType.Name) then
								local v154 = v_u_151.EmoteMenu.CurrentlyVisible
								if v154 then
									v154 = p152.UserInputType == Enum.UserInputType.MouseButton1
								end
								if not v154 then
									if v_u_129 then
										p_u_13.HeldAbilities[v_u_125] = not p_u_13.HeldAbilities[v_u_125]
										if p_u_13.HeldAbilities[v_u_125] then
											v_u_3:FireServerConnection("UseActorAbility", "REMOTE_EVENT", v_u_125)
											return
										end
									else
										p_u_13.HeldAbilities[v_u_125] = true
										v_u_3:FireServerConnection("UseActorAbility", "REMOTE_EVENT", v_u_125)
									end
								end
							end
						end
					end)
					v_u_1.Connections[("%*InputConnectionEnd"):format(v_u_125)] = game.UserInputService.InputEnded:Connect(function(p155, p156)
						-- upvalues: (copy) v_u_129, (copy) v_u_138, (ref) p_u_13, (copy) v_u_125
						if not (p156 or v_u_129) then
							if table.find(v_u_138, p155.KeyCode.Name) or table.find(v_u_138, p155.UserInputType.Name) then
								p_u_13.HeldAbilities[v_u_125] = nil
							end
						end
					end)
				end
				task.delay(0.25, function()
					-- upvalues: (ref) v_u_121, (copy) v_u_87
					while v_u_121 and (v_u_121.Parent and v_u_87.Parent) do
						v_u_121.Thickness = v_u_121.Thickness == 2 and 1 or 2
						local _ = #v_u_121:GetControlPoints()
						local v157 = {}
						for _, v158 in v_u_87:GetChildren() do
							if v158:IsA("GuiObject") then
								table.insert(v157, v158)
							end
						end
						table.sort(v157, function(p159, p160)
							return p159.LayoutOrder < p160.LayoutOrder
						end)
						for v161, v162 in pairs(v157) do
							v162.Position = v_u_121:GetPositionOnCurveArcLength(v161 / (#v157 + 1))
						end
						task.wait(1)
					end
				end)
				local v_u_163 = 0.022222222222222223
				local v_u_164 = 0
				local v_u_165 = v_u_2.Character
				local v166 = v_u_1.Connections
				local v167 = game["Run Service"].Heartbeat
				local function v171(p168)
					-- upvalues: (ref) v_u_4, (ref) v_u_2, (ref) v_u_5, (copy) v_u_165, (ref) v_u_163, (ref) v_u_3, (ref) v_u_8, (ref) v_u_164
					if workspace:GetAttribute("ExperimentalHitboxes") then
						local v169 = v_u_4.CurrentActors[v_u_2]
						if v169 then
							if v169 and v_u_5:IsAlive(v_u_165) then
								v_u_163 = v_u_163 + p168
								if v_u_163 >= 0.022222222222222223 then
									v_u_163 = 0
									local v170 = v_u_165.PrimaryPart.AssemblyLinearVelocity
									v_u_3:FireServerConnection("UpdCF", "UREMOTE_EVENT", v_u_8.Serialize(v_u_165.PrimaryPart.CFrame, v170))
									v_u_164 = tick()
								end
							else
								return
							end
						else
							return
						end
					else
						return
					end
				end
				table.insert(v166, v167:Connect(v171))
			end
		end)
		task.defer(v_u_5.FixCharacter, v_u_5, p_u_13.Rig, p_u_13.ActorType .. "s")
		v_u_4.__actorCreated:Fire(p_u_13)
	end)
	v_u_3:SetConnection("UpdateAbilityCharges", "REMOTE_EVENT", function(p172, p173, p174)
		-- upvalues: (ref) v_u_4, (ref) v_u_2, (ref) v_u_1, (ref) v_u_5
		local v175 = v_u_4.CurrentActors[v_u_2]
		if v175 then
			local v176 = v175.CustomBehavior.Abilities or {}
			local v177 = v175.Behavior.Abilities or {}
			local v178 = v176[p172] or v177[p172]
			local v179 = v_u_1.AbilityHotbar
			if v179 then
				v179 = v_u_1.AbilityHotbar:FindFirstChild(p172)
			end
			local v180 = v175 and v175.Cooldowns
			if v180 then
				v180 = v175.Cooldowns[p172]
			end
			if v178 then
				if v178 and v179 then
					v178.CurrentCharges = p173
					if v178.Recharge and p174 then
						v178.ChargeDuration = v178.Recharge
						v178.CurrentRecharge = 0
					end
					if p173 <= 0 and not (v178.ChargesOptional or v178.ChargesDisabled) then
						v178.Disabled = true
						v179.Clipping.Size = UDim2.fromScale(1, 0)
						v179.Clipping.Top.Size = UDim2.fromScale(1, 0)
						v179.Charges.Text = tostring(p173)
						v179.CooldownTime.Text = ""
						v_u_5:ToggleLockForAbilityIcon(p172, "NoCharges", true)
						return
					end
					v178.Disabled = false
					v179.Clipping.Size = v180 and v179.Clipping.Size or UDim2.fromScale(1, 1)
					v179.Clipping.Top.Size = v180 and v179.Clipping.Top.Size or UDim2.fromScale(1, 1)
					v179.Charges.Text = tostring(p173)
					v179.CooldownTime.Text = ""
					v_u_5:ToggleLockForAbilityIcon(p172, "NoCharges", false)
				end
			else
				local v181 = warn
				local v182 = script
				v181((("[%*]: Ability %* doesn\'t exist"):format(tostring(v182), v178)))
			end
		else
			return
		end
	end)
	v_u_3:SetConnection("UpdateAbilityCooldown", "REMOTE_EVENT", function(p183, p184)
		-- upvalues: (ref) v_u_4, (ref) v_u_2
		local v185 = v_u_4.CurrentActors[v_u_2]
		if v185 then
			local v186 = v185.CustomBehavior.Abilities or {}
			local v187 = v185.Behavior.Abilities or {}
			if (v186[p183] or v187[p183]) and v185.Cooldowns then
				if p184 < 0 then
					if v185.Cooldowns[p183] then
						local v188 = v185.Cooldowns[p183]
						v188.TimePast = v188.TimePast + math.abs(p184)
						return
					end
				else
					v185.Cooldowns[p183] = {
						["Duration"] = p184,
						["TimePast"] = 0
					}
				end
			end
		end
	end)
	v_u_3:SetConnection("UseActorAbility", "REMOTE_EVENT", function(p_u_189, p190)
		-- upvalues: (ref) v_u_4, (ref) v_u_2, (ref) v_u_3
		local v_u_191 = v_u_4.CurrentActors[v_u_2]
		if v_u_191 then
			local v192 = v_u_191.CustomBehavior.Abilities or {}
			local v193 = v_u_191.Config
			local v194 = v_u_191.Behavior.Abilities or {}
			local v195 = v192[p_u_189] or v194[p_u_189]
			if v193 then
				v193 = v193[("%*HoldTime"):format(p_u_189)]
			end
			local v196 = v193 and (typeof(p190) ~= "table" or typeof(p190) == "table" and not p190.ChargeTime) and true or false
			local v197 = p190 and typeof(p190) == "table" and p190.Cooldown
			if not v197 then
				local v198 = v195.Cooldown
				v197 = typeof(v198) == "function" and v195.Cooldown(v_u_191, p_u_189) or (v195.Cooldown or v_u_191.Config[("%*Cooldown"):format(p_u_189)])
			end
			local v199 = tonumber(v197)
			local v200 = typeof(p190) == "table" and p190.Cancelled and 0 or v199
			local v201 = v196 and 0 or (p190 == "Cancelled" and 0 or v200)
			if v201 and (v201 > 0 and (not v_u_191.Cooldowns[p_u_189] or v_u_191.Cooldowns[p_u_189].TimePast > 0.025)) and not workspace:GetAttribute("CooldownsDisabled") then
				v_u_191.Cooldowns[p_u_189] = {
					["Duration"] = v201,
					["TimePast"] = 0
				}
			end
			v195.Callback(v_u_191, p190)
			if v_u_191.Behavior.OnAbilityUsed then
				local v202, v203 = pcall(function()
					-- upvalues: (copy) v_u_191, (copy) p_u_189
					v_u_191.Behavior.OnAbilityUsed(v_u_191, p_u_189)
				end)
				if not v202 then
					warn((("[%*]: Failed to call method \'OnAbilityUsed\' due to: %*"):format(script.Name, v203)))
				end
			end
			if v196 then
				local v204 = tick()
				while (v_u_191.HeldAbilities[p_u_189] or tick() - v204 < v193.Min) and (v_u_2.Character and v_u_2.Character:GetAttribute((("Charging%*"):format(p_u_189)))) do
					game["Run Service"].Heartbeat:Wait()
				end
				if v_u_2.Character and v_u_2.Character:GetAttribute((("Charging%*"):format(p_u_189))) then
					v_u_3:FireServerConnection("UseActorAbility", "REMOTE_EVENT", p_u_189)
				end
			end
		end
	end)
	v_u_2.CharacterAdded:Connect(function(p205)
		-- upvalues: (ref) v_u_1
		if p205.Parent == workspace or p205.Parent == workspace.Players.Spectating then
			v_u_1:Destroy()
		end
	end)
end
function v_u_1.Destroy(_)
	-- upvalues: (copy) v_u_1
	if v_u_1.AbilityHotbar then
		v_u_1.AbilityHotbar:Destroy()
	end
	for _, v206 in pairs(v_u_1.Connections) do
		v206:Disconnect()
	end
	table.clear(v_u_1.Connections)
end
return v_u_1
