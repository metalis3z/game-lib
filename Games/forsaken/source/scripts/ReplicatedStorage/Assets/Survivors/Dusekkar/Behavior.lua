-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = {}
local v_u_2 = require(game.ReplicatedStorage.Modules.Util)
local v_u_3 = require(game.ReplicatedStorage.Modules.Sounds)
local v_u_4 = require(game.ReplicatedStorage.Modules.Network)
local v_u_5 = require(game.ReplicatedStorage.Modules.Hitboxes)
local v_u_6 = require(game.ReplicatedStorage.Modules.Statuses)
require(game.ReplicatedStorage.Modules.AchievementUtil)
local v_u_7 = require(game.ReplicatedStorage.Modules.Device)
local v_u_8 = require(game.ReplicatedStorage.Modules.Actors)
local v_u_9 = require(game.ReplicatedStorage.Modules.Misc.Maid)
local function v_u_14(p10, p11)
	-- upvalues: (copy) v_u_7
	if v_u_7:GetPlayerDevice() == "PC" then
		return game:GetService("UserInputService"):GetMouseLocation()
	elseif p11 then
		local v12 = p10.PrimaryPart and workspace.CurrentCamera:WorldToViewportPoint(p10.PrimaryPart.Position) or Vector3.new()
		return Vector2.new(v12.X, v12.Y)
	else
		local v13 = workspace.CurrentCamera:WorldToViewportPoint((workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -500)).Position)
		return Vector2.new(v13.X, v13.Y)
	end
end
local function v_u_22(p15, p16, p17)
	-- upvalues: (copy) v_u_14
	if p15 and p15.PrimaryPart then
		local v18 = v_u_14(p15, p17) + Vector2.new(0, p16 / 100)
		local v19, v20 = workspace.CurrentCamera:WorldToViewportPoint(p15.PrimaryPart.Position)
		print(p15, v20, "on screen check")
		if v20 then
			local v21 = (Vector2.new(v19.X, v19.Y) - v18).Magnitude
			print(v21 <= p16 / 2, v21, "distance check")
			return v21 <= p16 / 2, v21
		end
	end
end
local function v_u_29(p23, p24, p25, p26)
	local v27 = p23.Config.VFXTemplate[p25]:Clone()
	v27.Parent = p24
	if p26 then
		game.Debris:AddItem(v27, p26)
	end
	for _, v28 in pairs(v27:GetChildren()) do
		if v28:IsA("ParticleEmitter") then
			v28:Emit(v28:GetAttribute("EmitCount") or 1)
		end
	end
	return v27
end
local v100 = {
	["SpawnProtection"] = {
		["LayoutOrder"] = 1,
		["KeybindType"] = "AltAbility1",
		["Icon"] = "rbxassetid://136501603087283",
		["Callback"] = function(p_u_30, p_u_31)
			-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_6, (copy) v_u_2, (copy) v_u_29, (copy) v_u_8, (copy) v_u_7, (copy) v_u_22
			if game["Run Service"]:IsServer() then
				local v32 = v_u_4
				local v33 = p_u_30.Player
				local v34 = p_u_30.Player
				local v_u_35 = v32:FireClientConnection(v33, ("%*DusekkarGet"):format((tostring(v34))), "REMOTE_FUNCTION")
				if typeof(v_u_35) ~= "Instance" or v_u_35.Parent ~= workspace.Players.Survivors then
					v_u_35 = false
				end
				local v36
				if v_u_35 then
					if p_u_30.Rig:GetAttribute("Protecting") then
						v36 = "Protecting"
					elseif v_u_35:GetAttribute("Protected") then
						v36 = "TargetProtected"
					elseif v_u_35:GetAttribute("Protecting") then
						v36 = "TargetProtecting"
					elseif v_u_35.PrimaryPart.Anchored then
						v36 = "TargetAnchored"
					elseif tick() - (tonumber(v_u_35:GetAttribute("LastProtection")) or 0) <= p_u_30.Config.SpawnProtectionTimeUntilProtectableAgain then
						v36 = (tonumber(v_u_35:GetAttribute("LastProtection")) or 0) + p_u_30.Config.SpawnProtectionTimeUntilProtectableAgain - tick()
					else
						v36 = false
					end
				else
					v36 = "NoTarget"
				end
				if v36 then
					return {
						["Target"] = v_u_35,
						["Cancelled"] = true,
						["Reason"] = v36
					}
				end
				p_u_30.AbilitiesDisabled = true
				p_u_30.Rig:SetAttribute("Protecting", true)
				v_u_35:SetAttribute("Protected", true)
				v_u_3:Play(p_u_30.Config.Sounds.SpawnProtectionActivate, {
					["Parent"] = p_u_30.Rig.PrimaryPart
				})
				local v_u_37 = v_u_35.Humanoid
				local v_u_38 = p_u_30.Rig.Humanoid
				local function v_u_41()
					local v39 = {}
					for _, v40 in pairs(workspace.Players.Survivors:GetChildren()) do
						if v40:GetAttribute("Protecting") then
							table.insert(v39, v40)
						end
					end
					return v39
				end
				local v42 = v_u_41()
				if p_u_30.Config.SpawnProtectionMaxPlayers - #v42 > 0 then
					local v_u_43 = v_u_2:CreateSpeedMultiplier(p_u_30.Player, 1 - p_u_30.Config.SpawnProtectionSpeedReductionWhileInUse / 100, "SpawnProtection")
					v_u_6:ApplyStatus(p_u_30.Player, "Slowness", p_u_30.Config.SpawnProtectionSlownessData)
					task.delay(0.3, function()
						-- upvalues: (ref) v_u_3, (copy) p_u_30, (ref) v_u_29, (ref) v_u_35, (copy) v_u_38, (copy) v_u_37, (ref) v_u_6, (copy) v_u_41, (ref) v_u_8, (copy) v_u_43
						local v44 = tick()
						local v45 = v_u_3:Play(p_u_30.Config.Sounds.SpawnProtectionLoop, {
							["Parent"] = p_u_30.Rig.PrimaryPart
						})
						v_u_29(p_u_30, v_u_35.PrimaryPart, "Start", 10)
						local v46 = v_u_29(p_u_30, p_u_30.Rig.StaffDetector, "StaffBeam")
						for _, v47 in pairs(v46:GetChildren()) do
							local v48 = v_u_35.PrimaryPart
							if v48 then
								v48 = v_u_35.PrimaryPart:FindFirstChildOfClass("Attachment")
							end
							v47.Attachment1 = v48
						end
						local v49 = v_u_29(p_u_30, p_u_30.Rig.StaffDetector, "StaffMagic")
						for _, v50 in pairs(v49:GetChildren()) do
							if v50:IsA("ParticleEmitter") then
								v50:Emit(v50:GetAttribute("EmitCount") or 1)
							end
							v50.Enabled = true
						end
						local v51 = p_u_30.Config.VFXTemplate.Hold:Clone()
						v51.Parent = v_u_35.PrimaryPart
						for _, v52 in pairs(v51:GetChildren()) do
							if v52:IsA("ParticleEmitter") then
								v52:Emit(v52:GetAttribute("EmitCount") or 1)
							end
							v52.Enabled = true
						end
						local v_u_53 = false
						task.delay(p_u_30.Config.SpawnProtectionMaxDuration, function()
							-- upvalues: (ref) v_u_53, (ref) p_u_30
							if not v_u_53 then
								p_u_30.Rig:SetAttribute("Protecting", nil)
							end
						end)
						while p_u_30.Rig.Parent and (p_u_30.Rig:GetAttribute("Protecting") and (v_u_38.Health > 0 and v_u_37.Health > 0)) do
							v_u_6:ApplyStatus(v_u_35, "Resistance", {
								["Level"] = 5 - #v_u_41(),
								["Duration"] = 1
							})
							task.wait(0.2)
						end
						if tick() - v44 >= 8 then
							v_u_8:IncrementActorStats(p_u_30.Player, {
								["Action"] = "Protected a Survivor for at least 8 seconds",
								["Money"] = 7,
								["EXP"] = 14
							})
						end
						v_u_35:SetAttribute("LastProtection", tick())
						if v_u_35.Parent and v_u_35.PrimaryPart then
							game.TweenService:Create(v45, TweenInfo.new(0.3), {
								["PlaybackSpeed"] = 0
							}):Play()
							v_u_3:Play(p_u_30.Config.Sounds.SpawnProtectionShieldBreak, {
								["Parent"] = v_u_35.PrimaryPart
							})
							task.delay(0.1, function()
								-- upvalues: (ref) v_u_29, (ref) p_u_30, (ref) v_u_35
								v_u_29(p_u_30, v_u_35.PrimaryPart, "Shatter", 10)
							end)
						end
						v46:Destroy()
						for v54, v55 in pairs({ v51, v49 }) do
							game.Debris:AddItem(v55, v54 == 1 and 0.25 or 4)
							for _, v56 in pairs(v55:GetChildren()) do
								if v56:IsA("ParticleEmitter") then
									v56.Enabled = false
								elseif v56:IsA("Light") then
									game.TweenService:Create(v56, TweenInfo.new(0.25), {
										["Brightness"] = 0
									}):Play()
								end
							end
						end
						v_u_35:SetAttribute("Protected", nil)
						v_u_53 = true
						game.TweenService:Create(v_u_43, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
							["Value"] = 1
						}):Play()
						game.Debris:AddItem(v_u_43, 1)
						task.delay(2, function()
							-- upvalues: (ref) p_u_30
							p_u_30.AbilitiesDisabled = false
						end)
					end)
					return {
						["Target"] = v_u_35
					}
				end
				for _, v57 in pairs(v42) do
					v57:SetAttribute("Protecting", nil)
					v_u_6:ApplyStatus(v57, "Blindness", {
						["Level"] = 3,
						["Duration"] = p_u_30.Config.SpawnProtectionOverflowDebuffDuration
					})
					v_u_6:ApplyStatus(v57, "Slowness", {
						["Level"] = 3,
						["Duration"] = p_u_30.Config.SpawnProtectionOverflowDebuffDuration
					})
				end
				v_u_35:SetAttribute("Protected", nil)
				p_u_30.AbilitiesDisabled = false
			elseif game["Run Service"]:IsClient() and typeof(p_u_31) == "table" then
				if p_u_31.Cancelled then
					local v58 = require(game.ReplicatedStorage.Modules.Device):GetPlayerDevice()
					local v59 = ({
						["NoTarget"] = {
							["PC"] = "Cursor not close enough to a Survivor.",
							["Console"] = "Survivor not detected on screen.",
							["Mobile"] = "Survivor not detected on screen."
						},
						["Protecting"] = "You\'re already protecting a Survivor. Dummy.",
						["TargetProtecting"] = "That Dusekkar\'s already protecting another Survivor.",
						["TargetProtected"] = "That Survivor\'s already being protected by another Dusekkar.",
						["TargetAnchored"] = "That Survivor\'s occupied with something."
					})[p_u_31.Reason]
					if not v59 then
						local v60 = p_u_31.Reason
						if typeof(v60) == "number" then
							local v61 = p_u_31.Reason
							v59 = ("That Survivor can\'t be protected for another %* seconds."):format((math.round(v61))) or "Protectable Survivor not detected."
						else
							v59 = "Protectable Survivor not detected."
						end
					end
					v_u_2:CreateWarning("DusekkarWarning", typeof(v59) == "table" and (v59[v58] or "Survivor not detected on screen.") or v59, p_u_30.Config.WarningTemplate)
					return
				end
				if p_u_31.Target then
					p_u_30.Animations.StaffStartup:Play()
					p_u_30.Animations.StaffLoop:Play()
					v_u_2:ToggleSprinting("DusekkarProtect", false)
					local v_u_62 = p_u_30.Player:GetMouse()
					local v63 = p_u_30.Config.SpawnProtectionScaleRadius
					local v_u_64 = workspace.Camera.ViewportSize.Y * v63
					local v_u_65 = p_u_30.Config.SpawnProtectionIndicatorTemplate:Clone()
					v_u_65.Parent = p_u_30.Player.PlayerGui.TemporaryUI
					v_u_65.ImageTransparency = 1
					game.TweenService:Create(v_u_65, TweenInfo.new(0.3), {
						["ImageTransparency"] = 0
					}):Play()
					game.TweenService:Create(v_u_65, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false), {
						["Rotation"] = 360
					}):Play()
					local v_u_66 = p_u_30.Config.SpawnProtectionRadiusTemplate:Clone()
					v_u_66.Parent = p_u_30.Player.PlayerGui.TemporaryUI
					v_u_66.ImageTransparency = 1
					v_u_66.Size = UDim2.fromOffset(v_u_64, v_u_64)
					v_u_66.Rotation = v_u_66.Rotation - 90
					game.TweenService:Create(v_u_66, TweenInfo.new(0.3), {
						["ImageTransparency"] = 0,
						["Rotation"] = v_u_66.Rotation + 90
					}):Play()
					task.spawn(function()
						-- upvalues: (ref) v_u_4, (copy) p_u_30, (ref) v_u_2, (copy) v_u_65, (copy) v_u_66, (copy) p_u_31, (ref) v_u_7, (copy) v_u_62, (ref) v_u_22, (copy) v_u_64
						local v67 = 0
						local v68 = 0
						local v_u_69 = nil
						local function v72()
							-- upvalues: (ref) v_u_69, (ref) v_u_4, (ref) p_u_30, (ref) v_u_2, (ref) v_u_65, (ref) v_u_66
							if not v_u_69 then
								v_u_69 = true
								local v70 = v_u_4
								local v71 = p_u_30.Player
								v70:FireServerConnection(("%*DusekkarCancel"):format((tostring(v71))), "REMOTE_EVENT")
								v_u_2:ToggleSprinting("DusekkarProtect", true)
								p_u_30.Animations.StaffLoop:Stop()
								game.TweenService:Create(v_u_65, TweenInfo.new(0.3), {
									["ImageTransparency"] = 1
								}):Play()
								game.Debris:AddItem(v_u_65, 0.3)
								game.TweenService:Create(v_u_66, TweenInfo.new(0.3), {
									["ImageTransparency"] = 1,
									["Rotation"] = v_u_66.Rotation + 90
								}):Play()
								game.Debris:AddItem(v_u_66, 0.3)
								game.TweenService:Create(v_u_65.Warning, TweenInfo.new(0.3), {
									["TextTransparency"] = 1,
									["TextStrokeTransparency"] = 1
								}):Play()
							end
						end
						while p_u_30.Rig.Parent and v_u_66.Parent do
							local v73 = workspace.CurrentCamera:WorldToViewportPoint(p_u_31.Target.PrimaryPart.Position)
							v_u_65.Position = UDim2.fromOffset(v73.X, v73.Y)
							v_u_65.Warning.Rotation = -v_u_65.Rotation
							v_u_66.Position = v_u_7:GetPlayerDevice() == "PC" and UDim2.fromOffset(v_u_62.X, v_u_62.Y + game.GuiService:GetGuiInset().Y) or v_u_65.Position
							if not p_u_30.Rig.Parent then
								v72()
							end
							if not p_u_30.Rig:GetAttribute("Protecting") then
								v72()
							end
							if not p_u_31.Target.Parent then
								v72()
							end
							if v67 >= 0.05 then
								if v_u_22(p_u_31.Target, v_u_64, true) and p_u_30.Config.SpawnProtectionTimeUntilBrokenByWallInterference > v68 then
									if v_u_2:IsOnScreen(p_u_31.Target, true) then
										if v_u_65.Warning.Visible then
											v_u_65.Warning.Visible = false
											v68 = 0
										end
									else
										v68 = v68 + v67
										local v74 = p_u_30.Config.SpawnProtectionTimeUntilBrokenByWallInterference - v68
										if v74 > 0 then
											local v75 = v_u_65.Warning
											local v76 = v74 * 10
											v75.Text = ("TARGET IS BLOCKED\n\n\n\nCANCELLING IN %*S"):format(math.round(v76) / 10)
											v_u_65.Warning.Visible = true
										end
									end
								else
									v72()
									v_u_65.Warning.Text = "CANCELLED\n\n\n\n:("
								end
								v67 = 0
							end
							v67 = v67 + task.wait()
						end
					end)
				end
			end
		end
	},
	["PlasmaBeam"] = {
		["LayoutOrder"] = 2,
		["KeybindType"] = "AltAbility2",
		["Icon"] = "rbxassetid://83030778673034",
		["Callback"] = function(p_u_77, _)
			-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_4, (copy) v_u_5, (copy) v_u_6, (copy) v_u_8, (copy) v_u_29
			if game["Run Service"]:IsServer() then
				p_u_77.AbilitiesDisabled = true
				task.delay(2, function()
					-- upvalues: (copy) p_u_77
					p_u_77.AbilitiesDisabled = false
				end)
				local v_u_78 = v_u_2:CreateSpeedMultiplier(p_u_77.Player, 1 - p_u_77.Config.PlasmaBeamSpeedReductionWhileInUse / 100, "PlasmaBeam")
				v_u_3:Play(p_u_77.Config.Sounds.PlasmaBeamShoot, {
					["Parent"] = p_u_77.Rig.PrimaryPart
				})
				task.delay(1.5, function()
					-- upvalues: (ref) v_u_4, (copy) p_u_77, (ref) v_u_5, (ref) v_u_6, (ref) v_u_8, (ref) v_u_29, (copy) v_u_78
					local v_u_79 = nil
					local v_u_80 = nil
					local v81 = v_u_4:FireClientConnection(p_u_77.Player, "GetMousePosition", "REMOTE_FUNCTION")
					local v82 = (p_u_77.Rig.PrimaryPart.CFrame * CFrame.new(1.25, 1.5, -3.5)).Position
					local v83 = v_u_5
					local v84 = p_u_77.Player
					local v85 = {}
					local v86 = p_u_77.Config.PlasmaBeamHitboxSize
					local v87 = p_u_77.Config.PlasmaBeamHitboxSize
					local v88 = p_u_77.Config.PlasmaBeamHitboxRange
					v85.Size = Vector3.new(v86, v87, v88)
					v85.CFrame = CFrame.lookAt(v82, v81) * CFrame.new(0, 0, -p_u_77.Config.PlasmaBeamHitboxRange / 2)
					v85.Time = 0.05
					v85.Damage = 0
					v85.FriendlyFire = true
					v85.HitMultiple = true
					v85.PredictVelocity = false
					v85.Connections = {
						["Hit"] = function(p89)
							-- upvalues: (ref) p_u_77, (ref) v_u_79, (ref) v_u_6, (ref) v_u_8, (ref) v_u_29, (ref) v_u_80
							local v90 = p89.PrimaryPart
							if v90 then
								p_u_77:ChangeExpression("HitTarget", 2)
								local v91 = p89.Parent
								if tostring(v91) == "Survivors" and not v_u_79 then
									v_u_79 = true
									v_u_6:ApplyStatus(p89, "Speed", p_u_77.Config.PlasmaBeamSpeedData)
									v_u_8:IncrementActorStats(p_u_77.Player, {
										["Action"] = "Zapped a Survivor",
										["Money"] = 4,
										["EXP"] = 8
									})
									v_u_29(p_u_77, v90, "Zap", 5)
									return
								end
								local v92 = p89.Parent
								if tostring(v92) == "Killers" then
									local v93 = {}
									for v94, v95 in pairs(p_u_77.Config.PlasmaBeamSlownessData) do
										v93[v94] = v95
									end
									local v96 = v93.Duration - (#p_u_77 - 1) * 0.5
									local v97 = v93.Duration
									v93.Duration = math.clamp(v96, 0.5, v97)
									if v93.Duration > 0.5 and not v_u_80 then
										v_u_80 = true
										v_u_6:ApplyStatus(p89, "Slowness", v93)
										v_u_8:IncrementActorStats(p_u_77.Player, {
											["Action"] = "Zapped a Killer",
											["Money"] = 6,
											["EXP"] = 12
										})
										v_u_29(p_u_77, v90, "Zap", 5)
									end
								end
							end
						end
					}
					v83:CreateHitbox(v84, v85)
					local v98 = v_u_4
					local v99 = p_u_77.Player
					v98:FireAllClientConnection(("%*DusekkarReplZap"):format((tostring(v99))), "REMOTE_EVENT", v81, p_u_77.Rig.StaffDetector)
					task.wait(0.25)
					game.TweenService:Create(v_u_78, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
						["Value"] = 1
					}):Play()
					game.Debris:AddItem(v_u_78, 0.5)
				end)
			elseif game["Run Service"]:IsClient() then
				p_u_77.Animations.StaffShot:Play()
				v_u_2:ToggleSprinting("DusekkarBeam", false, 1.6)
			end
		end
	}
}
v1.Abilities = v100
function v1.Created(_, p_u_101)
	-- upvalues: (copy) v_u_4, (copy) v_u_2, (copy) v_u_22, (copy) v_u_9
	if game["Run Service"]:IsServer() then
		local v102 = v_u_4
		local v103 = p_u_101.Player
		v102:SetConnection(("%*DusekkarCancel"):format((tostring(v103))), "REMOTE_EVENT", function(p104)
			-- upvalues: (copy) p_u_101
			if p_u_101.Player == p104 and p_u_101.Rig:GetAttribute("Protecting") then
				p_u_101.Rig:SetAttribute("Protecting", nil)
			end
		end)
	elseif game["Run Service"]:IsClient() then
		if p_u_101.Player == game.Players.LocalPlayer then
			local v105 = v_u_4
			local v106 = p_u_101.Player
			v105:SetConnection(("%*DusekkarGet"):format((tostring(v106))), "REMOTE_FUNCTION", function()
				-- upvalues: (ref) v_u_2, (copy) p_u_101, (ref) v_u_22
				local v107 = v_u_2:GetClosestPlayerFromPosition(p_u_101.Rig.PrimaryPart.Position, {
					["ReturnTable"] = true,
					["MaxDistance"] = p_u_101.Config.SpawnProtectionPlayerMinRadius,
					["PlayerSelection"] = "Survivors"
				})
				local v108 = nil
				local v109 = nil
				for _, v110 in pairs(v107) do
					local v111 = v110.Player
					local v112 = p_u_101.Config.SpawnProtectionScaleRadius
					local v113, v114 = v_u_22(v111, workspace.Camera.ViewportSize.Y * v112)
					if v_u_2:IsOnScreen(v111, true) and (v113 and (v111 ~= p_u_101.Rig and (not v108 or v114 <= v109))) then
						v109 = v114
						v108 = v111
					end
				end
				return v108
			end)
		end
		local v115 = v_u_4
		local v116 = p_u_101.Player
		v115:SetConnection(("%*DusekkarReplZap"):format((tostring(v116))), "REMOTE_EVENT", function(p117, p_u_118)
			-- upvalues: (ref) v_u_9, (copy) p_u_101
			local v_u_119 = v_u_9.new()
			p_u_101.BoltMaid = v_u_119
			local v120 = Instance.new("Attachment", p_u_118)
			v120.WorldPosition = p_u_118.Position
			v_u_119:Add(v120)
			local v121 = Instance.new("Part")
			v_u_119:Add(v121)
			v121.Size = Vector3.new(1, 1, 1)
			v121.Position = p117
			v121.Transparency = 1
			v121.Anchored = true
			v121.CanCollide = false
			v121.Name = "HitPart"
			v121.Parent = game.Workspace.Misc
			local v122 = Instance.new("Attachment", v121)
			v122.WorldPosition = p117
			v_u_119:Add(v122)
			local v123 = require(game.ReplicatedStorage.Modules.Misc.LightningBolt)
			local v124 = p_u_101.Config.PlasmaBeamColor1
			local v125 = p_u_101.Config.PlasmaBeamColor2
			local v_u_126 = v123.new(v120, v122, 10)
			v_u_119:Add(v_u_126)
			v_u_126.PulseSpeed = 15
			v_u_126.MinRadius = 2.5
			v_u_126.MaxRadius = 3
			v_u_126.Frequency = 4
			v_u_126.FadeLength = 0.05
			v_u_126.AnimationSpeed = 5
			v_u_126.Color = v124:Lerp(v125, math.random(0, 1000) / 1000)
			v_u_119:Add((require(game.ReplicatedStorage.Modules.Misc.LightningBolt.LightningSparks).new(v_u_126)))
			local v_u_127 = require(game.ReplicatedStorage.Modules.Misc.Shake)
			local v128 = v_u_127.new()
			v128.Amplitude = 5
			v128.Frequency = 0.05
			v128.FadeInTime = 0.05
			v128.FadeOutTime = 1
			v128.Sustain = false
			v128.RotationInfluence = Vector3.new(1, 1, 1)
			v128.PositionInfluence = Vector3.new(1, 1, 1)
			v_u_119:Add(v128)
			v128:Start()
			v128:BindToRenderStep("ExplosionShake", Enum.RenderPriority.Last.Value, function(p129, p130, _)
				-- upvalues: (copy) p_u_118, (copy) v_u_127
				local v131 = (game.Workspace.CurrentCamera.CFrame.Position - p_u_118.Position).Magnitude
				local v132 = v_u_127.InverseSquare(p129, v131)
				local v133 = v_u_127.InverseSquare(p130, v131)
				local v134 = game.Workspace.CurrentCamera
				v134.CFrame = v134.CFrame * (CFrame.new(v132) * CFrame.Angles(v133.X, v133.Y, v133.Z))
			end)
			task.spawn(function()
				-- upvalues: (copy) v_u_126, (copy) v_u_119
				for _ = 1, 90 do
					local v135 = v_u_126
					v135.MinRadius = v135.MinRadius * 0.8
					local v136 = v_u_126
					v136.MaxRadius = v136.MaxRadius * 0.8
					local v137 = v_u_126
					v137.Frequency = v137.Frequency * 0.8
					local v138 = v_u_126
					v138.MinThicknessMultiplier = v138.MinThicknessMultiplier * 0.8
					local v139 = v_u_126
					v139.MaxThicknessMultiplier = v139.MaxThicknessMultiplier * 0.8
					if v_u_126.MaxRadius < 0.15 then
						break
					end
					task.wait()
				end
				v_u_119:Destroy()
			end)
		end)
	end
end
function v1.Destroyed(_, p140)
	-- upvalues: (copy) v_u_4
	if game["Run Service"]:IsServer() then
		local v141 = v_u_4
		local v142 = p140.Player
		v141:RemoveConnection(("%*DusekkarCancel"):format((tostring(v142))), "REMOTE_EVENT")
	else
		for _, v143 in { "RunMaid", "BoltMaid" } do
			if p140[v143] then
				p140[v143]:Destroy()
				p140[v143] = nil
			end
		end
		local v144 = v_u_4
		local v145 = p140.Player
		v144:RemoveConnection(("%*DusekkarReplZap"):format((tostring(v145))), "REMOTE_EVENT")
		local v146 = v_u_4
		local v147 = p140.Player
		v146:RemoveConnection(("%*DusekkarGet"):format((tostring(v147))), "REMOTE_FUNCTION")
	end
end
return v1
