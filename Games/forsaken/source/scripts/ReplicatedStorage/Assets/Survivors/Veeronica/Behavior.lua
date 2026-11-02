-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
require(game.ReplicatedStorage.GlobalTypes)
local v_u_1 = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("Players")
local v_u_5 = game:GetService("ContentProvider")
local v_u_6 = game:GetService("ContextActionService")
local v_u_7 = game:GetService("CollectionService")
local v_u_8 = require(script.Battery)
require(v_u_1.Modules.Misc.Zone)
local v_u_9 = require(v_u_1.Modules.Misc.Maid)
local v_u_10 = require(v_u_1.Modules.Util)
require(script.Utils)
local v_u_11 = require(v_u_1.Modules.Statuses)
local v_u_12 = require(v_u_1.Modules.Network)
local v_u_13 = require(v_u_1.Modules.Sounds)
require(v_u_1.Modules.AchievementUtil)
local v_u_14 = require(v_u_1.Modules.Actors)
local v_u_15 = require(v_u_1.Systems.Character.Game.Sprinting)
local v_u_16 = require(v_u_1.Modules.Hitboxes)
local v_u_17 = require(script.Spray)
local v_u_18 = require(script.SprayVisual)
local v_u_19 = workspace.Gravity
local v_u_20 = nil
local v_u_21 = nil
TweenInfo.new(5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local v_u_22 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v_u_23 = Enum.UserInputType.MouseButton1
local _ = Enum.UserInputType.Touch
local v_u_24 = Enum.KeyCode.ButtonR2
local v_u_25 = Enum.KeyCode.ButtonX
local v_u_26 = Enum.KeyCode.Space
local v_u_27 = {
	["PC"] = "Press <b>[Space]</b>",
	["Mobile"] = "Tap <b>[Sprint]</b>",
	["Console"] = "Press <b>[X]</b>"
}
local v_u_28 = {
	["PC"] = "Hold <b>[Left Click]</b> to Spray<br/>Hold <b>[Space]</b> to Wipe",
	["Console"] = "Hold <b>[Right Trigger]</b> to Spray<br/>Hold <b>[X]</b> to Wipe"
}
local v_u_29 = v_u_2:IsStudio()
local v_u_30 = os.clock
local v_u_31 = table.insert
local v_u_32 = table.remove
local v_u_33 = table.find
local _ = task.wait
local v_u_34 = task.delay
local v_u_35 = math.clamp
local v_u_36 = math.lerp
local v_u_37 = math.abs
local v_u_38 = math.random
local _ = math.rad
local function v_u_43(p39, p40)
	-- upvalues: (copy) v_u_11
	for v41, v42 in pairs(p40) do
		v_u_11:ApplyStatus(p39, v41, v42)
	end
end
local function v_u_47(p44)
	local v45 = 0
	for _, v46 in ipairs(p44:GetChildren()) do
		if v46:IsA("BasePart") and not v46.Massless then
			v45 = v45 + v46.Mass
		end
	end
	return v45
end
local function v_u_53(p_u_48, p_u_49, ...)
	-- upvalues: (copy) v_u_29
	assert(p_u_48, "bad moduleInfo, must be a table")
	local v50, v51 = pcall(function(...)
		-- upvalues: (copy) p_u_48, (copy) p_u_49
		if p_u_48[p_u_49] then
			return p_u_48[p_u_49](p_u_48, ...)
		end
	end, ...)
	if not v50 then
		local v52 = ("Failed to call :%*() due to: %* \n%*"):format(p_u_49, v51, (debug.traceback("Stack:")))
		if v_u_29 then
			warn((("[Veeronica]: %*"):format(v52)))
		end
	end
	return v50, v51
end
local function v_u_58(p54, p55, p56)
	-- upvalues: (copy) v_u_10, (copy) v_u_13
	local v57 = v_u_10:CopyTable(p56 or {
		["PlaybackSpeed"] = 0.975 + Random.new():NextNumber() * 0.04999999999999993
	})
	v57.Parent = p54.Rig.PrimaryPart
	return v_u_13:Play(p54.Config.Sounds[p55], v57)
end
local function v_u_65(p_u_59, p60, p_u_61)
	-- upvalues: (copy) v_u_2, (copy) v_u_35, (copy) v_u_3, (copy) v_u_36
	assert(p_u_59, "bad survivorInfo, must be T.ActorInfo")
	assert(p60, "bad newValue, must be number")
	if p_u_59.ConnectionDictionary.__tweenValueConnection then
		p_u_59.ConnectionDictionary.__tweenValueConnection:Disconnect()
		p_u_59.ConnectionDictionary.__tweenValueConnection = nil
	end
	p_u_59.Config.TVScreenSpeed = p60
	local v_u_62 = 0
	p_u_59.ConnectionDictionary.__tweenValueConnection = v_u_2.RenderStepped:Connect(function(p63)
		-- upvalues: (ref) v_u_62, (copy) p_u_61, (copy) p_u_59, (ref) v_u_35, (ref) v_u_3, (ref) v_u_36
		v_u_62 = v_u_35((v_u_62 + p63) / (p_u_61 or p_u_59.Config.TVScreenInterpolationTime), 0, 1)
		local v64 = v_u_3:GetValue(v_u_62, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		p_u_59.Meta.__TVScreenCurrentSpeed = v_u_36(p_u_59.Meta.__TVScreenCurrentSpeed, p_u_59.Config.TVScreenSpeed, v64)
		if v_u_62 >= 1 and p_u_59.ConnectionDictionary.__tweenValueConnection then
			p_u_59.ConnectionDictionary.__tweenValueConnection:Disconnect()
			p_u_59.ConnectionDictionary.__tweenValueConnection = nil
		end
	end)
end
local function v_u_90(p66, p67)
	-- upvalues: (copy) v_u_17, (copy) v_u_10, (copy) v_u_37
	local v68 = p66.Rig
	local v69
	if v68 then
		v69 = v68:FindFirstChildOfClass("Humanoid")
	else
		v69 = v68
	end
	if v68 then
		local _ = v68.PrimaryPart
	end
	local v_u_70 = p66:GetPivot()
	local v71 = p66.Config.VandalismDistanceCheck
	local v72 = OverlapParams.new()
	v72.FilterType = Enum.RaycastFilterType.Include
	v72.BruteForceAllSlow = true
	for _, v73 in ipairs(p66.SprayObjects) do
		if not v73.Dead then
			v72:AddToFilter(v73.Model.PrimaryPart)
		end
	end
	local v74 = workspace
	local v75 = p66:GetPivot() * CFrame.new(0, 0, -(v71 / 2) - 1)
	local v76 = v71 + 2
	local v77 = v74:GetPartBoundsInBox(v75, Vector3.new(8, 8, v76), v72)
	if v77 and #v77 > 0 then
		table.sort(v77, function(p78, p79)
			-- upvalues: (copy) v_u_70
			return (p78.Position - v_u_70.Position).Magnitude < (p79.Position - v_u_70.Position).Magnitude
		end)
		local v80 = v_u_17.getObject(v77[1].Parent)
		if v80 then
			v80:ChangeProgression(p67 * (100 / p66.Config.VandalismSprayTime))
			return v80
		end
	end
	if #p66.SprayObjects >= 3 then
		return "Max"
	end
	if os.clock() - (p66.Meta.LastSprayCreation or 0) < 1 then
		return "Soon"
	end
	local v81 = RaycastParams.new()
	v81.FilterType = Enum.RaycastFilterType.Exclude
	v81.FilterDescendantsInstances = { workspace.Players }
	if v69.FloorMaterial == Enum.Material.Air then
		return "InAir"
	end
	for _, v82 in p66.SprayObjects do
		if (v_u_70.Position - v82.Model.PrimaryPart.Position).Magnitude > p66.Config.VandalismSprayDistance then
			return "Far"
		end
	end
	local v83 = workspace:Raycast(v_u_70.Position, v_u_70.LookVector * v71, v81)
	if not v83 then
		return "Nothing"
	end
	local v84 = v_u_10:SnapToAxis(v83.Normal)
	if v_u_37(v84.Y) > 0.99 then
		return "InvalidNormal"
	end
	local v85 = v83.Position + v83.Normal * p66.Config.VandalismSprayOffset
	local v86 = Vector3.new(0, 1, 0)
	local v87 = v_u_37((v84:Dot(v86))) > 0.99 and Vector3.new(0, 0, 1) or v86
	p66.Meta.LastSprayCreation = os.clock()
	local v88 = CFrame.lookAt(v85, v85 - v83.Normal, v87)
	local v89 = v_u_17.new(p66, v88, v83.Instance)
	p66:IncrementCharges("Vandalism", -1)
	v89:ChangeProgression(12)
	return v89
end
local function v_u_102(p91, p92)
	-- upvalues: (copy) v_u_17
	local v93 = p91.Rig
	if v93 then
		v93:FindFirstChildOfClass("Humanoid")
	end
	local v94 = p91.Config.VandalismDistanceCheck
	local v95 = OverlapParams.new()
	v95.FilterType = Enum.RaycastFilterType.Include
	v95.MaxParts = 1
	v95.BruteForceAllSlow = true
	for _, v96 in ipairs(p91.SprayObjects) do
		if not v96.Dead then
			v95:AddToFilter(v96.Model.PrimaryPart)
		end
	end
	local v97 = workspace
	local v98 = p91:GetPivot() * CFrame.new(0, 0, -(v94 / 2) - 1)
	local v99 = v94 + 2
	local v100 = v97:GetPartBoundsInBox(v98, Vector3.new(8, 8, v99), v95)
	local v101 = v100 and (#v100 > 0 and v_u_17.getObject(v100[1].Parent))
	if v101 then
		v101:ChangeProgression(p92 * -90)
		return v101
	end
end
local function v_u_110(p103, _)
	p103:GetPivot()
	local v104 = OverlapParams.new()
	v104.FilterType = Enum.RaycastFilterType.Include
	v104.FilterDescendantsInstances = { (p103.Rig:FindFirstChild("QueryHitbox")) }
	for _, v105 in pairs(p103.SprayObjects) do
		if not v105.Dead and v105.Complete then
			local v106 = v105 and v105.Model
			if v106 then
				v106 = v105.Model.PrimaryPart.CFrame
			end
			if v106 then
				local v107 = p103.Config.VandalismRange
				local v108 = p103.Config.VandalismWidth
				local v109 = workspace:GetPartBoundsInBox(v106 * CFrame.new(0, 0, v107 / 2 + 1), vector.create(v108, v108, v107), v104)
				if v109 and #v109 > 0 then
					return v105
				end
			end
		end
	end
	return nil
end
local v_u_111 = {}
local v282 = {
	["Vandalism"] = {
		["LayoutOrder"] = 1,
		["Icon"] = "rbxassetid://99162825735363",
		["KeybindType"] = "AltAbility1",
		["Charges"] = 3,
		["ChargesDisabled"] = true,
		["Callback"] = function(p_u_112, p113)
			-- upvalues: (copy) v_u_2, (copy) v_u_58, (copy) v_u_53, (copy) v_u_90, (copy) v_u_102, (copy) v_u_12, (copy) v_u_34, (copy) v_u_6, (copy) v_u_23, (copy) v_u_24, (copy) v_u_26, (copy) v_u_25, (copy) v_u_4, (copy) v_u_10, (copy) v_u_28
			if v_u_2:IsServer() then
				local v114 = not p_u_112.State.SprayState
				if not v114 then
					p_u_112.Behavior:UnequipSpray(p_u_112)
					return v114
				end
				p_u_112.State.SprayState = "Idle"
				v_u_58(p_u_112, "VandalismEquip")
				v_u_53(p_u_112.Behavior, "ToggleSpraycan", p_u_112, true)
				p_u_112.ConnectionDictionary.VandalListener = v_u_2.PreSimulation:Connect(function(p115)
					-- upvalues: (copy) p_u_112, (ref) v_u_90, (ref) v_u_102
					if p_u_112.State.SprayState then
						if p_u_112.State.SprayState == "Spraying" then
							v_u_90(p_u_112, p115)
						elseif p_u_112.State.SprayState == "Wiping" then
							v_u_102(p_u_112, p115)
						end
					else
						return
					end
				end)
				v_u_12:SetConnection(("%*UpdateSprayInput"):format(p_u_112.Player.Name), "REMOTE_EVENT", function(p116, p117)
					-- upvalues: (copy) p_u_112, (ref) v_u_12
					if p116 == p_u_112.Player then
						if ({
							["Idle"] = true,
							["Spraying"] = true,
							["Wiping"] = true
						})[p117] and p_u_112.State.SprayState then
							p_u_112.State.SprayState = p117
							for _, v118 in ipairs(game.Players:GetPlayers()) do
								if v118 ~= p_u_112.Player then
									v_u_12:FireClientConnection(v118, ("%*UpdateSprayState"):format(p_u_112.Player.Name), "REMOTE_EVENT", p117)
								end
							end
						end
					else
						return
					end
				end)
				return v114
			elseif p113 ~= "Cancelled" then
				local v_u_119 = false
				v_u_34(p_u_112.Config.VandalismSprayWait, function()
					-- upvalues: (ref) v_u_119
					v_u_119 = true
				end)
				local v120 = p_u_112.ConnectionDictionary.SprayClickListener
				if v120 then
					v120:Disconnect()
				end
				if p113 then
					p_u_112.Animations.CanIdle:Play()
					p_u_112.Animations.CanTakeout:Play()
					p_u_112.State.SprayState = "Idle"
					p_u_112.State.ActionThread = nil
					local function v_u_123(p121, p122)
						-- upvalues: (copy) p_u_112, (ref) v_u_119, (ref) v_u_12
						if p_u_112.State.SprayState then
							if v_u_119 then
								if p122 == Enum.UserInputState.Begin then
									if p121 == "SprayInput" then
										if p_u_112.State.SprayState == "Wiping" and p_u_112.State.SprayState ~= "Idle" then
											p_u_112.State.SprayState = "Idle"
											p_u_112.Behavior:OnSprayStateChanged(p_u_112, "Idle")
											p_u_112.State.LastSprayState = "Idle"
											v_u_12:FireServerConnection(("%*UpdateSprayInput"):format(p_u_112.Player.Name), "REMOTE_EVENT", "Idle")
										end
										if p_u_112.State.SprayState == "Spraying" then
											return
										else
											if p_u_112.State.SprayState == "Wiping" and p_u_112.State.SprayState ~= "Idle" then
												p_u_112.State.SprayState = "Idle"
												p_u_112.Behavior:OnSprayStateChanged(p_u_112, "Idle")
												p_u_112.State.LastSprayState = "Idle"
												v_u_12:FireServerConnection(("%*UpdateSprayInput"):format(p_u_112.Player.Name), "REMOTE_EVENT", "Idle")
											end
											if p_u_112.State.SprayState ~= "Spraying" then
												p_u_112.State.SprayState = "Spraying"
												p_u_112.Behavior:OnSprayStateChanged(p_u_112, "Spraying")
												p_u_112.State.LastSprayState = "Spraying"
												v_u_12:FireServerConnection(("%*UpdateSprayInput"):format(p_u_112.Player.Name), "REMOTE_EVENT", "Spraying")
											end
										end
									end
									if p121 == "WipeInput" then
										if p_u_112.State.SprayState == "Spraying" and p_u_112.State.SprayState ~= "Idle" then
											p_u_112.State.SprayState = "Idle"
											p_u_112.Behavior:OnSprayStateChanged(p_u_112, "Idle")
											p_u_112.State.LastSprayState = "Idle"
											v_u_12:FireServerConnection(("%*UpdateSprayInput"):format(p_u_112.Player.Name), "REMOTE_EVENT", "Idle")
										end
										if p_u_112.State.SprayState == "Wiping" then
											return
										else
											if p_u_112.State.SprayState == "Spraying" and p_u_112.State.SprayState ~= "Idle" then
												p_u_112.State.SprayState = "Idle"
												p_u_112.Behavior:OnSprayStateChanged(p_u_112, "Idle")
												p_u_112.State.LastSprayState = "Idle"
												v_u_12:FireServerConnection(("%*UpdateSprayInput"):format(p_u_112.Player.Name), "REMOTE_EVENT", "Idle")
											end
											if p_u_112.State.SprayState ~= "Wiping" then
												p_u_112.State.SprayState = "Wiping"
												p_u_112.Behavior:OnSprayStateChanged(p_u_112, "Wiping")
												p_u_112.State.LastSprayState = "Wiping"
												v_u_12:FireServerConnection(("%*UpdateSprayInput"):format(p_u_112.Player.Name), "REMOTE_EVENT", "Wiping")
											end
										end
									end
								elseif p122 == Enum.UserInputState.End then
									if p121 == "SprayInput" then
										if p_u_112.State.SprayState == "Spraying" then
											if p_u_112.State.SprayState ~= "Idle" then
												p_u_112.State.SprayState = "Idle"
												p_u_112.Behavior:OnSprayStateChanged(p_u_112, "Idle")
												p_u_112.State.LastSprayState = "Idle"
												v_u_12:FireServerConnection(("%*UpdateSprayInput"):format(p_u_112.Player.Name), "REMOTE_EVENT", "Idle")
											end
										else
											return
										end
									end
									if p121 == "WipeInput" then
										if p_u_112.State.SprayState ~= "Wiping" then
											return
										end
										if p_u_112.State.SprayState == "Idle" then
											return
										end
										p_u_112.State.SprayState = "Idle"
										p_u_112.Behavior:OnSprayStateChanged(p_u_112, "Idle")
										p_u_112.State.LastSprayState = "Idle"
										v_u_12:FireServerConnection(("%*UpdateSprayInput"):format(p_u_112.Player.Name), "REMOTE_EVENT", "Idle")
									end
								end
							end
						else
							return
						end
					end
					v_u_6:BindActionAtPriority("SprayInput", v_u_123, false, 900, v_u_23, v_u_24)
					v_u_6:BindActionAtPriority("WipeInput", v_u_123, false, 900, v_u_26, v_u_25)
					local v124 = p_u_112.Player:GetAttribute("Device") or "PC"
					if v124 == "Mobile" then
						local _ = p_u_112.Player.PlayerGui.TemporaryUI
						local v125 = script.SprayButton:Clone()
						local v126 = script.WipeButton:Clone()
						for v_u_127, v128 in ipairs({ v125, v126 }) do
							v125.MouseButton1Down:Connect(function()
								-- upvalues: (copy) v_u_123, (copy) v_u_127
								v_u_123(v_u_127 == 1 and "SprayInput" or "WipeInput", Enum.UserInputState.Begin)
							end)
							v126.MouseButton1Up:Connect(function()
								-- upvalues: (copy) v_u_123, (copy) v_u_127
								v_u_123(v_u_127 == 1 and "SprayInput" or "WipeInput", Enum.UserInputState.End)
							end)
							v128.Parent = v_u_4.LocalPlayer.PlayerGui.TemporaryUI
						end
						p_u_112.SprayUI = { v125, v126 }
					elseif not p_u_112.Meta.SprayTutorialFlag then
						p_u_112.Meta.SprayTutorialFlag = true
						v_u_10:CreateWarning("Sk8SprayTutorial", v_u_28[v124] or "what <b>happened</b> to you", script.Tip)
					end
					for _, v129 in p_u_112.SprayVisuals do
						v129:ToggleBeam(true)
					end
				else
					p_u_112.Behavior:UnequipSpray(p_u_112)
				end
			end
		end
	},
	["Sk8"] = {
		["LayoutOrder"] = 2,
		["Icon"] = "rbxassetid://113273966501923",
		["AltIcon"] = "rbxassetid://113273966501923",
		["AltName"] = "Trick",
		["KeybindType"] = "AltAbility2",
		["Callback"] = function(p_u_130, p131)
			-- upvalues: (copy) v_u_2, (copy) v_u_10, (copy) v_u_58, (copy) v_u_53, (copy) v_u_29, (copy) v_u_1, (copy) v_u_47, (copy) v_u_19, (copy) v_u_3, (copy) v_u_15, (copy) v_u_6, (copy) v_u_111, (copy) v_u_12, (copy) v_u_27, (copy) v_u_26, (copy) v_u_25, (copy) v_u_37, (copy) v_u_11, (copy) v_u_38
			if v_u_2:IsServer() then
				if p_u_130.State.isSkating or not (p_u_130.State.InZone or (p_u_130.State.ClosestSpray or workspace:GetAttribute("CooldownsDisabled"))) or p_u_130.State.SprayState then
					return "BAD"
				end
				local v132 = p_u_130.State.ClosestSpray and not p_u_130.State.InZone and true or false
				p_u_130.AbilitiesDisabled = true
				p_u_130.State.isSkating = true
				v_u_10:GiveStackableAttribute(p_u_130.Rig, "FootstepsMuted", "Sk8")
				v_u_58(p_u_130, "Sk8Start")
				p_u_130.Cache.Sk8LoopSound = v_u_58(p_u_130, "Sk8Loop", {
					["Looped"] = true,
					["Volume"] = 0.4
				})
				v_u_53(p_u_130.Behavior, "ToggleSkateboard", p_u_130, true)
				return v132 and "SPRAY" or "ZONE"
			end
			if v_u_2:IsClient() then
				if p131 == "BAD" then
					if p_u_130.ActiveSprays then
						if p_u_130.State.SprayState then
							v_u_10:CreateWarning("Sk8SprayFail", "Put your Spraycan away!")
						else
							v_u_10:CreateWarning("Sk8SprayFail", "You must be in your Graffiti Zone to skate!")
						end
					else
						v_u_10:CreateWarning("Sk8SprayFail", "Spray some Graffiti first!")
						return
					end
				end
				if p_u_130.State.isSkating then
					if v_u_29 then
						warn("[Veeronica]: Attempted to toggle skating while already skating")
					end
					return
				end
				if not v_u_10:IsAlive(p_u_130.Rig) then
					if v_u_29 then
						warn("[Veeronica]: she\'s dead bruh")
					end
					return
				end
				local v_u_133 = require(game.Players.LocalPlayer.PlayerScripts.PlayerModule.ControlModule)
				local v_u_134 = require(v_u_1.Systems.Player.Game.SmoothShiftLock)
				local v135 = p_u_130.Player
				local v136 = v_u_47(p_u_130.Rig)
				local v_u_137 = p_u_130.Config.Sk8TrickCooldown
				local v_u_138 = os.clock()
				local v_u_139 = p_u_130.Meta.CurrentChannel
				local v_u_140 = p131 == "SPRAY"
				local v141 = v135:GetAttribute("Device") or "PC"
				local v_u_142 = p_u_130.Rig
				local v_u_143 = v_u_142.Humanoid
				local v_u_144 = v_u_142.PrimaryPart
				local v145 = workspace.CurrentCamera.CFrame.LookVector
				local v146 = v145.X
				local v147 = v145.Z
				local v_u_148 = Vector3.new(v146, 0, v147).Unit
				local v_u_149 = Instance.new("Attachment", v_u_144)
				local v_u_150 = Instance.new("Attachment", workspace.Terrain)
				v_u_150.CFrame = v_u_144.CFrame
				local v_u_151 = script.SkatePointer:Clone()
				v_u_151.Parent = v_u_144
				v_u_151.Attachment0 = v_u_149
				v_u_151.Attachment1 = v_u_150
				local v152 = v_u_19 * v136
				local v153 = (1 - p_u_130.Config.Sk8TrickGravity) * v152
				local v_u_154 = vector.create(0, v153, 0)
				local v_u_155 = Instance.new("BodyForce", v_u_144)
				v_u_155.Force = Vector3.new(0, 0, 0)
				local v_u_156 = Instance.new("Highlight", script)
				v_u_156.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				local v_u_157 = false
				local v_u_158 = 0
				local v_u_159 = 0
				local v_u_160 = false
				local v_u_161 = 0
				local v_u_162 = 0
				local v_u_163 = 0
				local v_u_164 = Vector3.new(0, 0, 0)
				local v_u_165 = 0
				local v_u_166 = false
				for v167, v168 in pairs(p_u_130.Config.Sk8TrickHighlightData.TrickReady) do
					v_u_156[v167] = v168
				end
				p_u_130.Instances.Sk8Highlight = v_u_156
				p_u_130.Instances.Sk8Attachment = v_u_150
				local v_u_169 = v_u_58(p_u_130, "Sk8LoopMusic", {
					["Looped"] = true,
					["Volume"] = 0.35
				})
				local v_u_170 = RaycastParams.new()
				v_u_170.CollisionGroup = "Survivors"
				v_u_170.RespectCanCollide = true
				v_u_170.FilterDescendantsInstances = { workspace.Players.Survivors }
				v_u_170.FilterType = Enum.RaycastFilterType.Exclude
				local v_u_171 = RaycastParams.new()
				v_u_171.CollisionGroup = "Survivors"
				v_u_171.RespectCanCollide = true
				v_u_171.FilterDescendantsInstances = { workspace.Players }
				v_u_171.FilterType = Enum.RaycastFilterType.Exclude
				local v_u_172 = RaycastParams.new()
				v_u_172.CollisionGroup = "Survivors"
				v_u_172.RespectCanCollide = true
				v_u_172.FilterDescendantsInstances = { workspace.Players.Killers }
				v_u_172.FilterType = Enum.RaycastFilterType.Include
				local function v_u_176(p173)
					-- upvalues: (copy) v_u_169, (ref) v_u_3, (ref) v_u_10, (copy) v_u_142, (ref) v_u_2, (copy) p_u_130, (ref) v_u_15, (copy) v_u_156, (copy) v_u_155, (copy) v_u_151, (copy) v_u_150, (copy) v_u_149, (ref) v_u_6, (ref) v_u_111, (copy) v_u_143, (ref) v_u_53, (ref) v_u_12
					if v_u_169 then
						v_u_3:Create(v_u_169, TweenInfo.new(0.7), {
							["PlaybackSpeed"] = 0
						}):Play()
						game.Debris:AddItem(v_u_169, 0.7)
					end
					v_u_10:RemoveStackableAttribute(v_u_142, "DisableShiftLockMovement", "SkateboardV")
					v_u_2:UnbindFromRenderStep("Sk8")
					p_u_130.AnimationType = nil
					v_u_15.IsSprinting = false
					v_u_15.BindsEnabled = true
					v_u_15.__sprintedEvent:Fire(false)
					p_u_130.State.isSkating = false
					v_u_15.StaminaGain = p_u_130.State.OGStaminaGain
					v_u_15.StaminaLoss = p_u_130.State.OGStaminaLoss
					v_u_142:SetAttribute("NoFallSlow", nil)
					p_u_130.State.SkatingSpeed:Destroy()
					p_u_130.State.TrickSpeed:Destroy()
					v_u_156:Destroy()
					v_u_155:Destroy()
					v_u_151:Destroy()
					v_u_150:Destroy()
					v_u_149:Destroy()
					v_u_6:UnbindAction("TrickInput")
					for _, v174 in ipairs({ "TrickStartInput", "TrickEndInput" }) do
						if p_u_130.ConnectionDictionary[v174] then
							p_u_130.ConnectionDictionary[v174]:Disconnect()
							p_u_130.ConnectionDictionary[v174] = nil
						end
					end
					p_u_130.Animations.Sk8Skating:Stop(0.25)
					local v175 = p_u_130.Behavior.Abilities.Sk8
					v175.Name = v_u_111.Abilities.Sk8.Name
					v175.Icon = v_u_111.Abilities.Sk8.Icon
					if not v_u_142:GetAttribute("Ragdolling") then
						v_u_143.AutoRotate = true
					end
					v_u_10:ToggleLockForAbilityIcon("Sk8", "NoCharges", not (p_u_130.State.InZone or p_u_130.State.ClosestSpray))
					v_u_53(p_u_130.Behavior, "OnSk8Stop", p_u_130)
					v_u_12:FireServerConnection(("%*StopSkate"):format(p_u_130.Player.Name), "REMOTE_EVENT", p173)
				end
				local function v180(p177, p178)
					-- upvalues: (ref) v_u_157
					if p177 == "TrickInput" then
						local v179
						if p178 == Enum.UserInputState.Begin then
							v179 = true
						elseif p178 == Enum.UserInputState.End then
							v179 = false
						else
							v179 = v_u_157
						end
						v_u_157 = v179
					end
				end
				if not p_u_130.Meta.TutorialFlag then
					p_u_130.Meta.TutorialFlag = true
					v_u_10:CreateWarning("Sk8SprayFail", v_u_27[v141] .. " while glowing to perform a Trick!" or "are you dumb", script.Tip)
				end
				p_u_130.State.isSkating = true
				p_u_130.State.TrickSpeed = v_u_10:CreateSpeedMultiplier(v_u_142, 1, "Sk8Trick")
				p_u_130.State.TrickLandTween = v_u_3:Create(p_u_130.State.TrickSpeed, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					["Value"] = 1
				})
				p_u_130.State.SkatingSpeed = v_u_10:CreateSpeedMultiplier(v_u_142, p_u_130.Config.Sk8Speed, "Sk8")
				p_u_130.State.OGStaminaLoss = v_u_15.StaminaLoss
				p_u_130.State.OGStaminaGain = v_u_15.StaminaGain
				p_u_130.Meta.Sk8AbilityUses = 0
				v_u_15.BindsEnabled = false
				v_u_15.StaminaGain = 0
				v_u_15.IsSprinting = true
				v_u_15.__sprintedEvent:Fire(true)
				p_u_130.AnimationType = false
				p_u_130.HeldAbilities.Sk8 = nil
				p_u_130.Rig:SetAttribute("NoFallSlow", true)
				p_u_130.Cooldowns.Sk8 = {
					["Duration"] = 0.25,
					["TimePast"] = 0
				}
				v_u_6:BindAction("TrickInput", v180, false, v_u_26, v_u_25)
				if v141 == "Mobile" then
					p_u_130.ConnectionDictionary.TrickStartInput = v_u_15.MobileButton.MouseButton1Down:Connect(function()
						-- upvalues: (ref) v_u_157
						local v181 = Enum.UserInputState.Begin
						local v182
						if v181 == Enum.UserInputState.Begin then
							v182 = true
						elseif v181 == Enum.UserInputState.End then
							v182 = false
						else
							v182 = v_u_157
						end
						v_u_157 = v182
					end)
					p_u_130.ConnectionDictionary.TrickEndInput = v_u_15.MobileButton.MouseButton1Up:Connect(function()
						-- upvalues: (ref) v_u_157
						local v183 = Enum.UserInputState.End
						local v184
						if v183 == Enum.UserInputState.Begin then
							v184 = true
						elseif v183 == Enum.UserInputState.End then
							v184 = false
						else
							v184 = v_u_157
						end
						v_u_157 = v184
					end)
				end
				v_u_2:BindToRenderStep("Sk8", Enum.RenderPriority.Character.Value + 1, function(p185)
					-- upvalues: (ref) v_u_10, (copy) p_u_130, (copy) v_u_144, (ref) v_u_15, (copy) v_u_176, (copy) v_u_139, (ref) v_u_158, (copy) v_u_143, (ref) v_u_166, (ref) v_u_159, (copy) v_u_155, (ref) v_u_161, (copy) v_u_138, (copy) v_u_142, (copy) v_u_134, (copy) v_u_133, (ref) v_u_162, (ref) v_u_164, (ref) v_u_148, (copy) v_u_150, (copy) v_u_140, (copy) v_u_170, (copy) v_u_172, (copy) v_u_171, (ref) v_u_37, (ref) v_u_165, (ref) v_u_160, (ref) v_u_12, (ref) v_u_163, (copy) v_u_137, (copy) v_u_156, (ref) v_u_157, (ref) v_u_11, (copy) v_u_154, (ref) v_u_38, (ref) v_u_53
					local v186 = v_u_10
					local v187 = p_u_130
					if v187 then
						v187 = p_u_130.Rig
					end
					if v186:IsAlive(v187) and (not v_u_144.Anchored and (not p_u_130.Rig:GetAttribute("Ragdolling") and v_u_15.Stamina > (v_u_15.MinStamina or 0))) then
						local v188 = v_u_139 == 1
						local v189 = os.clock() - v_u_158
						local v190 = v189 < p_u_130.Config.Sk8PhaseTime
						local v191 = v_u_143.FloorMaterial ~= Enum.Material.Air
						if v_u_166 and (os.clock() - v_u_159 > 0.3 and v191) then
							v_u_166 = false
							v_u_155.Force = Vector3.new(0, 0, 0)
							v_u_161 = os.clock()
							p_u_130.Animations.Sk8TrickLand:Play(0)
							p_u_130.State.TrickLandTween:Play()
						end
						if v190 or (os.clock() - v_u_138 <= 0.4 or (os.clock() - v_u_159 <= 0.5 or v_u_144.AssemblyLinearVelocity.Magnitude >= 4)) then
							local v192 = v_u_142:FindFirstChild("Head")
							local v193 = workspace.CurrentCamera
							local v194
							if ((v_u_134:IsEnabled() or v192.LocalTransparencyModifier > 0.9) and "Camera" or "Keys") == "Camera" then
								v194 = v193.CFrame.LookVector
							else
								v194 = v193.CFrame:VectorToWorldSpace(v_u_133:GetMoveVector())
							end
							if v194 and (v194.Magnitude > 0.001 and os.clock() - v_u_162 > 0.2) then
								local v195 = (v194 * Vector3.new(1, 0, 1)).Unit
								local v196 = v195.X
								local v197 = v195.Z
								v_u_164 = Vector3.new(v196, 0, v197).Unit
								local v198 = v_u_142.PrimaryPart.CFrame
								local v199 = CFrame.lookAt
								local v200 = v198.Position
								local v201 = v198.Position
								local v202 = v_u_148
								local v203 = v202.X
								local v204 = v202.Z
								local v205 = v199(v200, v201 + Vector3.new(v203, 0, v204).Unit.Unit)
								local v206 = v_u_148
								local v207 = v205.RightVector:Dot(v_u_164)
								local v208 = (-v205.RightVector):Dot(v_u_164)
								local v209
								if v205.LookVector:Dot(v_u_164) > 0.999 then
									v209 = 0
								elseif v208 < v207 then
									v209 = -1
								else
									local _ = v207 < v208
									v209 = 1
								end
								if (v_u_164 - v_u_148).Magnitude > 0.005 then
									local v210 = os.clock() - v_u_161
									local v211 = p_u_130.State.InZone
									local v212 = p_u_130.Config[("Sk8Tony%*TurnDuration"):format(v211 and "Charged" or "")]
									local v213 = v_u_166 and 1 or (v_u_139 == 3 and ((v212 - v210) / v212 or 0) or 0)
									local v214 = p_u_130.Config.Sk8TurnControl
									local v215 = p_u_130.Config.Sk8TrickTurnControl
									local v216 = math.clamp(v213, 0, 1)
									local v217 = (v214 + math.lerp(0, v215, v216)) * p185
									local v218 = v205.LookVector:Dot(v_u_164)
									local v219 = math.clamp(v218, -1, 1)
									local v220 = math.acos(v219)
									local v221 = CFrame.Angles
									local v222 = v209 * v217
									local v223 = (v205 * v221(0, math.min(v220, v222), 0)).LookVector
									local v224 = v223.X
									local v225 = v223.Z
									v_u_148 = Vector3.new(v224, 0, v225).Unit.Unit
									if v_u_148 ~= v_u_148 then
										v_u_148 = v206
									end
								end
							end
							v_u_10:GiveStackableAttribute(v_u_142, "DisableShiftLockMovement", "SkateboardV")
							v_u_143.AutoRotate = false
							local v226 = v_u_144.AssemblyLinearVelocity.Unit
							if v226 ~= v226 then
								v226 = v_u_148
							end
							local v227 = v_u_166 and 0.2 or 0.95
							local v228 = v226 * Vector3.new(1, v227, 1)
							local v229 = v_u_142:GetPivot()
							v_u_150.CFrame = CFrame.lookAt(v229.Position, v229.Position + v228)
							v_u_143:Move(v_u_148)
							v_u_15.StaminaLoss = p_u_130.State.OGStaminaLoss * (p_u_130.State.InZone and p_u_130.Config.Sk8StaminaLoss or (v_u_140 and p_u_130.Config.Sk8StaminaLossOutNerfed or p_u_130.Config.Sk8StaminaLossOut))
							if os.clock() - v_u_159 > 0.75 then
								local v230
								if os.clock() - v_u_162 > 0.1 and os.clock() - v_u_158 > 0.75 then
									v230 = workspace:Raycast(v_u_144.Position, v_u_148.Unit * 3, v_u_170)
								else
									v230 = nil
								end
								local v231
								if v_u_139 == 2 or v_u_139 == 1 and (p_u_130.Config.Sk8PhaseTime + 0.5 < v189 and p_u_130.Meta.Sk8AbilityUses < p_u_130.Config.Sk8PhaseUses) then
									v231 = workspace:Spherecast(v_u_144.Position, 4, v_u_148.Unit * (v_u_139 == 2 and 2.5 or 6), v_u_172)
								else
									v231 = nil
								end
								local v232 = v231 or v230
								local v233 = nil
								local v234
								if v232 then
									v234 = v232.Instance.Parent
								else
									v234 = v232
								end
								local v235
								if v234 then
									if v234.Parent.Name == "Killers" then
										v235 = v234:FindFirstChild("Humanoid")
									else
										v235 = false
									end
								else
									v235 = v234
								end
								if not v232 then
									for v236 = -90, 90, 10 do
										local v237 = math.rad(v236)
										local v238 = math.sin(v237) / 6
										local v239 = math.cos(v237)
										local v240 = v_u_148.Unit:Cross(Vector3.new(0, 1, 0)).Unit
										local v241 = v_u_148.Unit * v239 + v240 * v238
										local v242 = workspace
										local v243 = v_u_144.Position
										local v244 = v241 * 12
										local v245
										if v190 then
											v245 = v_u_171
										else
											v245 = v_u_170
										end
										v233 = v242:Raycast(v243, v244, v245)
										if v233 then
											v234 = v233.Instance.Parent
										else
											v234 = v233
										end
										if v234 then
											if v234.Parent.Name == "Killers" then
												v235 = v234:FindFirstChild("Humanoid")
											else
												v235 = false
											end
										else
											v235 = v234
										end
										if v233 and (v_u_37((v233.Normal:Dot(Vector3.new(0, 1, 0)))) < 0.2 or v235) then
											break
										end
									end
								end
								if v232 and (v235 or v_u_37((v232.Normal:Dot(Vector3.new(0, 1, 0)))) < 0.2) and not v190 then
									if not v188 then
										v_u_176(v235 or v232.Instance)
										return
									end
									if v231 and (v188 and v235) then
										local v246 = p_u_130.Meta
										v246.Sk8AbilityUses = v246.Sk8AbilityUses + 1
										v_u_158 = os.clock()
										v_u_165 = 0
										v_u_160 = false
										v_u_12:FireServerConnection(("%*SkatePhase"):format(p_u_130.Player.Name), "REMOTE_EVENT", v234)
									elseif os.clock() - v_u_162 > 0.1 then
										local v247 = v232.Normal
										local v248 = v247.X
										local v249 = v247.Z
										local v250 = Vector3.new(v248, 0, v249).Unit.Unit
										local v251 = v_u_144.AssemblyLinearVelocity
										local v252 = v251.X
										local v253 = v251.Z
										local v254 = Vector3.new(v252, 0, v253).Unit.Unit
										local v255 = v254 - 2 * v254:Dot(v250) * v250
										v_u_148 = v255
										v_u_144.AssemblyLinearVelocity = v255 * 25
										v_u_162 = os.clock()
										v_u_10:CreateSpeedMultiplier(v_u_142, 1.25, "Sk8Rebound", 0.1, true)
										v_u_12:FireServerConnection(("%*SkateRebound"):format(p_u_130.Player.Name), "REMOTE_EVENT")
									end
								elseif v189 > 0.15 and (v233 and v_u_137 < os.clock() - v_u_163) then
									v_u_165 = os.clock()
									local v256 = v233.Normal
									local v257 = v256.X
									local v258 = v256.Z
									v_u_160 = Vector3.new(v257, 0, v258).Unit.Unit
								elseif os.clock() - v_u_165 > 0.125 then
									v_u_160 = false
								end
							else
								v_u_160 = false
							end
							local v259 = v_u_156
							local v260
							if v_u_160 and v_u_137 < os.clock() - v_u_159 then
								v260 = p_u_130.Rig
							else
								v260 = nil
							end
							v259.Adornee = v260
							if p_u_130.HeldAbilities.Sk8 and os.clock() - v_u_163 > 0.25 then
								p_u_130.HeldAbilities.Sk8 = nil
								v_u_176("Manual")
							elseif v_u_157 and (v_u_137 < os.clock() - v_u_163 and (os.clock() - v_u_159 > 0.25 and not v_u_11:PlayerHasStatus(game.Players.LocalPlayer, "Helpless"))) then
								v_u_157 = false
								v_u_163 = os.clock()
								if v_u_160 then
									v_u_159 = os.clock()
									v_u_166 = true
									local v261 = {
										["Duration"] = v_u_137,
										["TimePast"] = 0
									}
									p_u_130.Cooldowns.Sk8 = v261
									local _ = p_u_130.State.InZone
									local v262 = p_u_130.Config.Sk8TrickPower
									local v263 = v_u_160
									local v264
									if v_u_140 then
										v264 = p_u_130.Config.Sk8TrickStaminaNerfed
									else
										v264 = p_u_130.Config.Sk8TrickStamina
									end
									local v265 = v_u_144.AssemblyLinearVelocity
									local v266 = v265.X
									local v267 = v265.Z
									local v268 = Vector3.new(v266, 0, v267).Unit.Unit
									local v269 = (v268 - 2 * v268:Dot(v263) * v263) * v262 + Vector3.new(0, 1, 0) * p_u_130.Config.Sk8TrickJump * v262
									v_u_144.AssemblyLinearVelocity = v269
									v_u_148 = (v269 * Vector3.new(1, 0, 1)).Unit
									local v270 = v_u_15
									local v271 = v_u_15.Stamina + v264
									local v272 = v_u_15.MaxStamina or 100
									v270.Stamina = math.min(v271, v272)
									v_u_15.IsSprinting = true
									v_u_15.__sprintedEvent:Fire(true)
									v_u_155.Force = v_u_154
									p_u_130.State.TrickLandTween:Cancel()
									p_u_130.State.TrickSpeed.Value = p_u_130.Config.Sk8TrickAirborneSpeed
									p_u_130.Animations[("Sk8Trick%*"):format((v_u_38(1, 2)))]:Play(0)
									v_u_53(p_u_130.Behavior, "OnSk8Trick", p_u_130)
									v_u_12:FireServerConnection(("%*SkateTrick"):format(p_u_130.Player.Name), "REMOTE_EVENT")
								end
								v_u_53(p_u_130.Behavior, "TrickCooldownVisual", p_u_130, v_u_160)
							end
						else
							v_u_176("Manual")
							return
						end
					else
						v_u_176("Manual")
						return
					end
				end)
				p_u_130.Animations.Sk8Start:Play(0.1)
				p_u_130.Animations.Sk8Skating:Play(0.1)
				v_u_53(p_u_130.Behavior, "OnSk8Start", p_u_130)
			end
		end
	},
	["Broadcast"] = {
		["LayoutOrder"] = 3,
		["Icon"] = "rbxassetid://99218231350350",
		["KeybindType"] = "AltAbility3",
		["Cooldown"] = 0.5,
		["Callback"] = function(p_u_273, p274)
			-- upvalues: (copy) v_u_2, (ref) v_u_20, (copy) v_u_29, (copy) v_u_34, (copy) v_u_53, (copy) v_u_13
			if v_u_2:IsServer() then
				p_u_273.AbilitiesDisabled = true
				local v275 = p_u_273.Meta.CurrentChannel + 1
				p_u_273.Meta.CurrentChannel = v_u_20 < v275 and 1 or v275
				if v_u_2:IsStudio() then
					local v276 = ("New channel is: %*"):format(p_u_273.Meta.CurrentChannel)
					if v_u_29 then
						warn((("[Veeronica]: %*"):format(v276)))
					end
				end
				v_u_34(0.33, function()
					-- upvalues: (ref) v_u_53, (copy) p_u_273
					v_u_53(p_u_273.Behavior, "OnChannelSwitch", p_u_273)
				end)
				v_u_34(0.5, function()
					-- upvalues: (copy) p_u_273
					p_u_273.AbilitiesDisabled = false
				end)
				return p_u_273.Meta.CurrentChannel
			elseif p274 then
				p_u_273.Animations.BroadcastSwitch:Play(0)
				v_u_13:Play(p_u_273.Config.Sounds.ChannelSwitch, {
					["Looped"] = false,
					["Volume"] = 0.5
				})
				v_u_34(0.33, function()
					-- upvalues: (ref) v_u_53, (copy) p_u_273
					v_u_53(p_u_273.Behavior, "OnChannelSwitch", p_u_273)
				end)
				p_u_273.Meta.CurrentChannel = p274
				local v277 = p_u_273.Config.BroadcastTypeData[p_u_273.Meta.CurrentChannel or 1]
				p_u_273.Behavior.Abilities.Broadcast.Icon = v277.Icon
				p_u_273.Behavior.Abilities.Broadcast.FlavorText = v277.Name or "IDK"
			end
		end
	},
	["ActivateBattery"] = {
		["LayoutOrder"] = 4,
		["Icon"] = "rbxassetid://111551796924061",
		["KeybindType"] = "AltAbility4",
		["Callback"] = function(p278, p279)
			-- upvalues: (copy) v_u_2, (copy) v_u_53, (copy) v_u_10, (copy) v_u_13
			if v_u_2:IsServer() then
				if p278.Meta.CurrentBattery.Charge <= 0 then
					p278:SetCooldownOf("ActivateBattery", 0.75)
					return "You are out of battery! Repair Generators or Bump into the Killer!"
				end
				if p278.Rig.Humanoid.Health >= p278.Rig.Humanoid.MaxHealth then
					p278:SetCooldownOf("ActivateBattery", 0.75)
					return "You are already at full health."
				end
				v_u_53(p278.Behavior, "OnActivateBattery", p278)
				p278.Meta.CurrentBattery:StartHealing(function(p280, p281)
					print(p280, p281)
				end)
				return false
			end
			if p279 then
				v_u_10:CreateWarning("VeeNoBattery", p279)
				v_u_13:Play(p278.Config.Sounds.ActivateBatteryFailure)
			end
		end
	}
}
v_u_111.Abilities = v282
function v_u_111.Created(_, p_u_283)
	-- upvalues: (copy) v_u_9, (ref) v_u_20, (ref) v_u_21, (copy) v_u_2, (copy) v_u_8, (copy) v_u_30, (copy) v_u_31, (copy) v_u_12, (copy) v_u_10, (copy) v_u_16, (copy) v_u_43, (copy) v_u_14, (copy) v_u_58, (copy) v_u_3, (copy) v_u_53, (copy) v_u_34, (copy) v_u_4, (copy) v_u_33, (copy) v_u_32, (copy) v_u_110, (copy) v_u_29, (copy) v_u_35, (copy) v_u_5, (copy) v_u_7, (copy) v_u_18
	p_u_283.Maid = v_u_9.new()
	p_u_283.Tags = {
		["Spray"] = ("%*VeeGraffiti"):format(p_u_283.Player.Name)
	}
	p_u_283.Meta = {}
	p_u_283.Instances = {}
	p_u_283.State = {}
	p_u_283.NetworkConnections = {}
	p_u_283.ConnectionDictionary = {}
	v_u_20 = #p_u_283.Config.BroadcastTypeData
	v_u_21 = #p_u_283.Config.VandalismSprayImages
	p_u_283.Meta.Sk8AbilityUses = 0
	p_u_283.Meta.CurrentChannel = 1
	p_u_283.Rig.Humanoid:SetAttribute("Clanker", true)
	if v_u_2:IsServer() then
		p_u_283.SprayObjects = {}
		p_u_283.Meta.CurrentBattery = v_u_8.new(p_u_283.Rig)
		p_u_283.Meta.CurrentKillers = {}
		p_u_283.Meta.CurrentSprayZone = nil
		p_u_283.Meta.CurrentTrickCombo = 1
		p_u_283.State.SprayState = nil
		p_u_283.State.isSkating = false
		p_u_283.State.InZone = false
		p_u_283.State.ClosestSpray = nil
		p_u_283.State.LastBatteryCharge = v_u_30()
		p_u_283.Rig.Skateboard.Transparency = 1
		p_u_283.Rig.Spray.Transparency = 1
		for _, v_u_284 in ipairs({
			"Charged",
			"Start",
			"Ended",
			"Interrupted",
			"Finished",
			"Discharged"
		}) do
			if p_u_283.Behavior[("OnBattery%*"):format(v_u_284)] then
				p_u_283.Meta.CurrentBattery.Callbacks[v_u_284] = function(...)
					-- upvalues: (copy) p_u_283, (copy) v_u_284
					p_u_283.Behavior[("OnBattery%*"):format(v_u_284)](p_u_283.Behavior, p_u_283, ...)
				end
			end
		end
		v_u_31(p_u_283.NetworkConnections, { ("%*RequestSprayAsync"):format(p_u_283.Player.Name), "REMOTE_FUNCTION" })
		v_u_12:SetConnection(("%*RequestSprayAsync"):format(p_u_283.Player.Name), "REMOTE_FUNCTION", function(p285)
			-- upvalues: (copy) p_u_283, (ref) v_u_10
			if p285.UserId == p_u_283.Player.UserId then
				if not v_u_10:IsAlive(p285.Character) then
					return "Dead"
				end
				local _ = p_u_283.Rig.PrimaryPart
				local _ = p_u_283.Rig.Humanoid
				return "Dead"
			end
			p285:Kick((("\n\nForsakenCheatKiller 012:\nInvalid accessor for: %*RequestSprayAsync\n"):format(p_u_283.Player.Name)))
		end)
		v_u_31(p_u_283.NetworkConnections, { ("%*StopSkate"):format(p_u_283.Player.Name), "REMOTE_EVENT" })
		v_u_12:SetConnection(("%*StopSkate"):format(p_u_283.Player.Name), "REMOTE_EVENT", function(p286, p287)
			-- upvalues: (copy) p_u_283, (ref) v_u_10, (ref) v_u_16, (ref) v_u_43, (ref) v_u_14, (ref) v_u_58, (ref) v_u_3, (ref) v_u_53
			if p286.Name == p_u_283.Player.Name then
				if p_u_283.State.isSkating then
					local v288 = p_u_283.Meta.CurrentChannel == 3
					p_u_283:SetCooldownOf("Sk8", p_u_283.Config.Sk8CD)
					v_u_10:RemoveStackableAttribute(p_u_283.Rig, "FootstepsMuted", "Sk8")
					p_u_283.State.isSkating = false
					p_u_283.Meta.Sk8AbilityUses = 0
					p_u_283.AbilitiesDisabled = nil
					local v289 = typeof(p287) == "Instance"
					if p_u_283.Meta.CurrentChannel == 2 and (v289 and p287:IsA("Humanoid")) then
						local v290 = p287.Parent and p287.Parent:IsA("Model")
						if v290 then
							v290 = p287.Parent.PrimaryPart
						end
						if not v290 then
							return
						end
						if (v290.Position - p_u_283.Rig.PrimaryPart.Position).Magnitude > 20 then
							return
						end
						local v291 = os.clock() - (p287:GetAttribute("LastVeeBump") or 0) < p_u_283.Config.Sk8BumpGlobalCooldown
						p287:SetAttribute("LastVeeBump", os.clock())
						local v292 = v_u_10:GetActor(v290.Parent)
						local v293 = v292 and v292:GetPivot() or v290.CFrame
						v_u_16:CreateHitbox(p_u_283.Player, {
							["CFrame"] = CFrame.new(v293.Position) * p_u_283.Rig.PrimaryPart.CFrame.Rotation,
							["Damage"] = p_u_283.Config[("Sk8Bump%*Damage"):format(p_u_283.State.InZone and "Charged" or "")],
							["Time"] = 0.001,
							["HitMultiple"] = true,
							["PredictVelocity"] = false,
							["Knockback"] = (v291 and 0.1 or 1) * p_u_283.Config[("Sk8Bump%*Power"):format(p_u_283.State.InZone and "Charged" or "")]
						})
						local v294 = p_u_283.Config[("Sk8Bump%*Battery"):format(p_u_283.State.InZone and "Charged" or "")]
						p_u_283.Meta.CurrentBattery:IncrementCharge(v294)
						v_u_43(p_u_283.Rig, p_u_283.State.InZone and p_u_283.Config.Sk8BumpChargedStatuses or p_u_283.Config.Sk8BumpStatuses)
						v_u_14:IncrementActorStats(p_u_283.Player, {
							["Action"] = "Knocked the Killer back with Bumper",
							["Money"] = nil,
							["EXP"] = nil,
							["RewardType"] = "Survivalist"
						})
						v_u_58(p_u_283, "Sk8Bump")
					elseif v289 then
						v_u_10:ApplyDamage(p_u_283.Rig, p_u_283.Config[("Sk8%*BonkDamage"):format(v288 and "Tony" or "")])
						v_u_43(p_u_283.Rig, p_u_283.Config.Sk8BonkStatuses)
						v_u_58(p_u_283, "Sk8Bonk")
					else
						v_u_58(p_u_283, "Sk8Stop")
					end
					p_u_283.Meta.CurrentTrickCombo = 1
					local v295 = p_u_283.Cache.Sk8LoopSound
					if v295 then
						v_u_3:Create(v295, TweenInfo.new(0.3), {
							["Volume"] = 0,
							["PlaybackSpeed"] = 0
						}):Play()
						game.Debris:AddItem(v295, 0.35)
					end
					v_u_53(p_u_283.Behavior, "ToggleSkateboard", p_u_283, false)
				end
			else
				return
			end
		end)
		v_u_31(p_u_283.NetworkConnections, { ("%*SkatePhase"):format(p_u_283.Player.Name), "REMOTE_EVENT" })
		v_u_12:SetConnection(("%*SkatePhase"):format(p_u_283.Player.Name), "REMOTE_EVENT", function(p296, p297)
			-- upvalues: (copy) p_u_283, (ref) v_u_14, (ref) v_u_43, (ref) v_u_58
			if p296.UserId == p_u_283.Player.UserId then
				if p297 and (p297.Parent.Name == "Killers" and p297:FindFirstChild("Humanoid")) then
					if p_u_283.State.isSkating and (p_u_283.Meta.CurrentChannel == 1 and p_u_283.Meta.Sk8AbilityUses < p_u_283.Config.Sk8PhaseUses) then
						v_u_14:IncrementActorStats(p_u_283.Player, {
							["Action"] = "Phased through the Killer",
							["Money"] = nil,
							["EXP"] = nil,
							["RewardType"] = "Survivalist"
						})
						local v298 = p_u_283.Meta
						v298.Sk8AbilityUses = v298.Sk8AbilityUses + 1
						for _, v299 in ipairs(p_u_283.Rig:GetChildren()) do
							if v299:IsA("BasePart") and v299.CanCollide then
								for _, v300 in ipairs(p297:GetChildren()) do
									if v300:IsA("BasePart") and v300.CanCollide then
										local v301 = Instance.new("NoCollisionConstraint", v299)
										v301.Part0 = v299
										v301.Part1 = v300
										game.Debris:AddItem(v301, p_u_283.Sk8PhaseTime)
									end
								end
							end
						end
						local v302 = p_u_283.Config.Sk8PhaseBattery
						p_u_283.Meta.CurrentBattery:IncrementCharge(v302)
						v_u_43(p_u_283.Rig, p_u_283.Config[("Sk8Phase%*Statuses"):format(p_u_283.State.InZone and "Charged" or "")])
						v_u_58(p_u_283, "Sk8Phase")
					end
				else
					return
				end
			else
				p296:Kick((("\n\nForsakenCheatKiller 012:\nInvalid accessor for: %*SkatePhase\n"):format(p_u_283.Player.Name)))
				return
			end
		end)
		local v_u_303 = false
		v_u_31(p_u_283.NetworkConnections, { ("%*SkateRebound"):format(p_u_283.Player.Name), "REMOTE_EVENT" })
		v_u_12:SetConnection(("%*SkateRebound"):format(p_u_283.Player.Name), "REMOTE_EVENT", function(p304)
			-- upvalues: (copy) p_u_283, (ref) v_u_303, (ref) v_u_34, (ref) v_u_10, (ref) v_u_58
			if p304 == p_u_283.Player then
				if p_u_283.State.isSkating then
					if not v_u_303 then
						v_u_303 = true
						v_u_34(0.1, function()
							-- upvalues: (ref) v_u_303
							v_u_303 = false
						end)
						v_u_10:ApplyDamage(p_u_283.Rig, p_u_283.Config.Sk8PhaseReboundDamage)
						v_u_58(p_u_283, "Sk8Rebound")
					end
				else
					return
				end
			else
				return
			end
		end)
		local v_u_305 = false
		v_u_31(p_u_283.NetworkConnections, { ("%*SkateTrick"):format(p_u_283.Player.Name), "REMOTE_EVENT" })
		v_u_12:SetConnection(("%*SkateTrick"):format(p_u_283.Player.Name), "REMOTE_EVENT", function(p306)
			-- upvalues: (copy) p_u_283, (ref) v_u_305, (ref) v_u_34, (ref) v_u_14, (ref) v_u_58, (ref) v_u_53
			if p306.Name == p_u_283.Player.Name then
				if p_u_283.State.isSkating then
					if not v_u_305 then
						v_u_305 = true
						v_u_34(p_u_283.Config.Sk8TrickCooldown - 0.35, function()
							-- upvalues: (ref) v_u_305
							v_u_305 = false
						end)
						if p_u_283.Meta.CurrentTrickCombo == p_u_283.Config.Sk8TrickCombo then
							local v307 = p_u_283.Config.Sk8TrickBattery
							p_u_283.Meta.CurrentBattery:IncrementCharge(v307)
							p_u_283.Meta.CurrentTrickCombo = 1
							v_u_14:IncrementActorStats(p_u_283.Player, {
								["Action"] = "Did 3 Tricks in a row",
								["Money"] = 1,
								["EXP"] = 2,
								["RewardType"] = nil
							})
						else
							local v308 = p_u_283.Meta
							v308.CurrentTrickCombo = v308.CurrentTrickCombo + 1
						end
						v_u_58(p_u_283, "Sk8Trick")
						v_u_53(p_u_283.Behavior, "OnSk8Trick", p_u_283)
					end
				else
					return
				end
			else
				return
			end
		end)
		p_u_283.Maid:Add(v_u_4.PlayerRemoving:Connect(function(p309)
			-- upvalues: (ref) v_u_33, (copy) p_u_283, (ref) v_u_32, (ref) v_u_53
			local v310 = v_u_33(p_u_283.Meta.CurrentKillers, p309)
			local v311
			if v310 then
				v311 = v_u_32(p_u_283.Meta.CurrentKillers, v310)
			else
				v311 = nil
			end
			v_u_53(p_u_283.Behavior, "OnSprayAreaExited", p_u_283, v311)
		end))
		p_u_283.Maid:Add(v_u_2.Heartbeat:Connect(function(p312)
			-- upvalues: (copy) p_u_283, (ref) v_u_30, (ref) v_u_110, (ref) v_u_12, (ref) v_u_29
			local v313 = #p_u_283.Meta.CurrentKillers > 0
			local v314 = v_u_30()
			local v315 = v_u_110(p_u_283, p312)
			if v315 ~= p_u_283.State.ClosestSpray then
				local v316 = v_u_12
				local v317 = p_u_283.Player
				local v318 = "ReplicateClosestSpray"
				local v319 = "REMOTE_EVENT"
				local v320
				if v315 then
					v320 = v315.Model
				else
					v320 = nil
				end
				v316:FireClientConnection(v317, v318, v319, v320)
			end
			p_u_283.State.ClosestSpray = v315
			if v313 and v314 - p_u_283.State.LastBatteryCharge > p_u_283.Config.BatteryRechargeRate then
				p_u_283.State.LastBatteryCharge = v314
				p_u_283.Meta.CurrentBattery:IncrementCharge()
				if v_u_29 then
					local v321 = ("Current battery charge is now: %*"):format(p_u_283.Meta.CurrentBattery.Charge)
					if v_u_29 then
						warn((("[Veeronica]: %*"):format(v321)))
					end
				end
			end
		end))
	else
		local v_u_322 = v_u_4.LocalPlayer == p_u_283.Player
		p_u_283.Meta.__TVScreenCurrentSpeed = p_u_283.Config.TVScreenSpeed
		p_u_283.Instances.IndicationBeams = {}
		p_u_283.SprayVisuals = {}
		local v_u_323 = p_u_283.Rig
		if v_u_323 then
			v_u_323 = p_u_283.Rig.TV.Screen:FindFirstChildOfClass("Texture")
		end
		p_u_283.Maid:Add(v_u_2.Heartbeat:Connect(function(p324)
			-- upvalues: (copy) v_u_323, (copy) p_u_283, (ref) v_u_35
			if v_u_323 and v_u_323.Parent then
				v_u_323.OffsetStudsV = v_u_35(v_u_323.OffsetStudsV - 0.5 * (p324 * p_u_283.Meta.__TVScreenCurrentSpeed), 0, 3)
				if v_u_323.OffsetStudsV <= 0 then
					v_u_323.OffsetStudsV = 3
				end
			end
			for _, v325 in p_u_283.SprayVisuals do
				v325:UpdateBeam((p_u_283.Rig.PrimaryPart.Position - v325.Root:GetPivot().Position).Magnitude <= p_u_283.Config.VandalismSprayDistance)
			end
		end))
		v_u_5:PreloadAsync(p_u_283.Config.VandalismSprayImages, function(p326, p327)
			-- upvalues: (ref) v_u_29
			local v328 = ("Preload Status: %* on ID: %*"):format(p327.Name, p326)
			if v_u_29 then
				warn((("[Veeronica]: %*"):format(v328)))
			end
		end)
		p_u_283.ConnectionDictionary.SprayVisualAdded = v_u_7:GetInstanceAddedSignal(p_u_283.Tags.Spray):Connect(function(p329)
			-- upvalues: (ref) v_u_18, (copy) p_u_283
			v_u_18.new(p_u_283, p329)
		end)
		p_u_283.ConnectionDictionary.SprayVisualRemoved = v_u_7:GetInstanceRemovedSignal(p_u_283.Tags.Spray):Connect(function(p330)
			-- upvalues: (copy) p_u_283
			if p_u_283.SprayVisuals[p330] then
				p_u_283.SprayVisuals[p330]:Destroy()
			end
		end)
		p_u_283.State.LastSprayState = nil
		v_u_31(p_u_283.NetworkConnections, { ("%*UpdateSprayState"):format(p_u_283.Player.Name), "REMOTE_EVENT" })
		v_u_12:SetConnection(("%*UpdateSprayState"):format(p_u_283.Player.Name), "REMOTE_EVENT", function(p331)
			-- upvalues: (copy) v_u_322, (copy) p_u_283, (ref) v_u_53
			if v_u_322 and not p331 then
				p_u_283.Behavior:UnequipSpray(p_u_283)
			else
				p_u_283.State.SprayState = p331
			end
			v_u_53(p_u_283.Behavior, "OnSprayStateChanged", p_u_283, p331)
			p_u_283.State.LastSprayState = p331
		end)
		v_u_31(p_u_283.NetworkConnections, { ("%*ReplicateSprayAreaAsync"):format(p_u_283.Player.Name), "REMOTE_EVENT" })
		v_u_12:SetConnection(("%*ReplicateSprayAreaAsync"):format(p_u_283.Player.Name), "REMOTE_EVENT", function(p332)
			-- upvalues: (copy) p_u_283, (ref) v_u_29, (ref) v_u_53
			if p_u_283.Rig and (p332 and #p332 == 3) then
				if v_u_29 then
					warn("[Veeronica]: [ReplicateSprayAreaAsync]: Successfully got request!")
				end
				p_u_283.ActiveSprays = p332
				v_u_53(p_u_283.Behavior, "CreateZoneVisual", p_u_283, p332)
			end
		end)
		v_u_31(p_u_283.NetworkConnections, { ("%*ReplicateRemovedSprayAreaAsync"):format(p_u_283.Player.Name), "REMOTE_EVENT" })
		v_u_12:SetConnection(("%*ReplicateRemovedSprayAreaAsync"):format(p_u_283.Player.Name), "REMOTE_EVENT", function(p333)
			-- upvalues: (copy) p_u_283, (ref) v_u_53
			table.clear(p_u_283.ActiveSprays or {})
			p_u_283.ActiveSprays = nil
			v_u_53(p_u_283.Behavior, "DestroyZoneVisual", p_u_283, p333)
		end)
		if v_u_322 then
			local v334 = v_u_4.LocalPlayer:WaitForChild("PlayerGui")
			local v_u_335 = p_u_283.Config.BatteryUITemplate:Clone()
			local v_u_336 = v_u_335.Back.Fill.Size.X.Scale
			v_u_335.Parent = v334.TemporaryUI
			local function v346()
				-- upvalues: (copy) p_u_283, (copy) v_u_335, (ref) v_u_3, (copy) v_u_336
				local v337 = p_u_283.Rig:GetAttribute("BatteryPercent") or 0
				v_u_335.Text.Text = tostring(v337) .. "%"
				local v338 = v_u_3
				local v339 = v_u_335.Back.Fill
				local v340 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				local v341 = {
					["Size"] = UDim2.fromScale(v_u_336 * (v337 / 100), v_u_335.Back.Fill.Size.Y.Scale)
				}
				local v342 = Color3.new
				local v343 = (1 - v337 / 100) * 2
				local v344 = math.clamp(v343, 0, 1)
				local v345 = v337 / 100 * 2
				v341.BackgroundColor3 = v342(v344, math.clamp(v345, 0, 1), 0)
				v338:Create(v339, v340, v341):Play()
			end
			v346()
			p_u_283.ConnectionDictionary.OnBatteryChargeChanged = p_u_283.Rig:GetAttributeChangedSignal("BatteryPercent"):Connect(v346)
			local v347 = p_u_283.Config.BroadcastTypeData[p_u_283.Meta.CurrentChannel or 1]
			p_u_283.Behavior.Abilities.Broadcast.Icon = v347.Icon
			p_u_283.Behavior.Abilities.Broadcast.FlavorText = v347.Name or "IDK"
			v_u_10:ToggleLockForAbilityIcon("Sk8", "NoCharges", true)
			v_u_31(p_u_283.NetworkConnections, { "ReplicateZoneStatus", "REMOTE_EVENT" })
			v_u_12:SetConnection("ReplicateZoneStatus", "REMOTE_EVENT", function(p348)
				-- upvalues: (copy) p_u_283, (ref) v_u_10
				p_u_283.State.InZone = p348
				if not p_u_283.State.isSkating then
					v_u_10:ToggleLockForAbilityIcon("Sk8", "NoCharges", not (p348 or p_u_283.State.ClosestSpray))
				end
			end)
			v_u_31(p_u_283.NetworkConnections, { "ReplicateClosestSpray", "REMOTE_EVENT" })
			v_u_12:SetConnection("ReplicateClosestSpray", "REMOTE_EVENT", function(p349)
				-- upvalues: (copy) p_u_283, (ref) v_u_10
				p_u_283.State.ClosestSpray = p349
				for _, v350 in p_u_283.SprayVisuals do
					v350:ToggleInRange(v350.Root == p349)
				end
				if not p_u_283.State.isSkating then
					v_u_10:ToggleLockForAbilityIcon("Sk8", "NoCharges", not (p349 or p_u_283.State.InZone))
				end
			end)
			v_u_31(p_u_283.NetworkConnections, { "SprayDestroyed", "REMOTE_EVENT" })
			v_u_12:SetConnection("SprayDestroyed", "REMOTE_EVENT", function(p351)
				-- upvalues: (ref) v_u_53, (copy) p_u_283
				v_u_53(p_u_283.Behavior, "OnSprayDestroyed", p_u_283, p351)
			end)
		end
	end
end
function v_u_111.Destroyed(_, p352)
	-- upvalues: (copy) v_u_12, (copy) v_u_29, (copy) v_u_2, (copy) v_u_6, (copy) v_u_53
	p352.Maid:Destroy()
	for _, v353 in p352.ConnectionDictionary do
		v353:Disconnect()
	end
	for _, v354 in p352.NetworkConnections do
		v_u_12:RemoveConnection(v354[1], v354[2])
	end
	for _, v355 in p352.Instances do
		if typeof(v355) == "table" then
			for _, v356 in v355 do
				local v357 = ("Removed instance reference: %*"):format(v356)
				if v_u_29 then
					warn((("[Veeronica]: %*"):format(v357)))
				end
				v356:Destroy()
			end
		else
			v355:Destroy()
		end
	end
	if v_u_2:IsServer() then
		for _, v358 in ipairs(p352.SprayObjects) do
			v358:Destroy()
		end
		v_u_12:RemoveConnection(("%*UpdateSprayInput"):format(p352.Player.Name), "REMOTE_EVENT")
	else
		for _, v359 in p352.SprayVisuals or {} do
			v359:Destroy()
		end
		if p352.Player == game.Players.LocalPlayer then
			v_u_6:UnbindAction("TrickInput")
			v_u_6:UnbindAction("SprayInput")
			v_u_6:UnbindAction("WipeInput")
			v_u_12:RemoveConnection(("%*UpdateSprayState"):format(p352.Player.Name), "REMOTE_EVENT")
			v_u_2:UnbindFromRenderStep("Sk8")
		end
		v_u_53(p352.Behavior, "DestroyZoneVisual", p352)
	end
end
function v_u_111.OnObjectiveCompleted(_, p360, p361)
	-- upvalues: (copy) v_u_2
	if v_u_2:IsServer() then
		p360.Meta.CurrentBattery:IncrementCharge(p361 * p360.Config.BatteryGeneratorCharge)
	end
end
function v_u_111.UnequipSpray(_, p362)
	-- upvalues: (copy) v_u_2, (copy) v_u_12, (copy) v_u_53, (copy) v_u_6
	if p362.State.SprayState then
		p362.State.SprayState = nil
		if v_u_2:IsServer() then
			if p362.ConnectionDictionary.VandalListener then
				p362.ConnectionDictionary.VandalListener:Disconnect()
				p362.ConnectionDictionary.VandalListener = nil
			end
			v_u_12:FireAllClientConnection(("%*UpdateSprayState"):format(p362.Player.Name), "REMOTE_EVENT")
			v_u_12:RemoveConnection(("%*UpdateSprayInput"):format(p362.Player.Name), "REMOTE_EVENT")
			v_u_53(p362.Behavior, "ToggleSpraycan", p362, false)
		elseif v_u_2:IsClient() then
			for _, v363 in p362.SprayVisuals do
				v363:ToggleBeam(false)
			end
			if p362.SprayUI then
				for _, v364 in ipairs(p362.SprayUI) do
					v364:Destroy()
				end
				p362.SprayUI = nil
			end
			v_u_6:UnbindAction("SprayInput")
			v_u_6:UnbindAction("WipeInput")
			p362.Animations.CanIdle:Stop()
			p362.Animations.CanTakeout:Stop()
		end
	else
		return
	end
end
function v_u_111.OnSprayDestroyed(_, p365, p366)
	-- upvalues: (copy) v_u_2, (copy) v_u_13, (copy) v_u_3
	if v_u_2:IsClient() and p365.Player == game.Players.LocalPlayer then
		local v367 = Instance.new("Attachment", workspace.Terrain)
		v367.WorldPosition = p366
		game.Debris:AddItem(v367, 3.35)
		v_u_13:Play(p365.Config.Sounds.SprayDestroyedNotif)
		local v_u_368 = p365.Config.VandalismDestroyedUI:Clone()
		local v_u_369 = v_u_368.Spray
		local v_u_370 = v_u_368.Cross
		v_u_369.ImageTransparency = 1
		v_u_370.ImageTransparency = 1
		v_u_370.Size = UDim2.fromScale(3.5, 3.5)
		v_u_370.Rotation = (math.random(1, 2) == 2 and -1 or 1) * 274
		v_u_368.Parent = v367
		local v371 = v_u_3:Create(v_u_369, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			["ImageTransparency"] = 0.25
		})
		local v372 = v_u_3:Create(v_u_370, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			["ImageTransparency"] = 0.3,
			["Rotation"] = 0
		})
		local v373 = v_u_3:Create(v_u_370, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			["Size"] = UDim2.fromScale(1, 1)
		})
		v372:Play()
		v373:Play()
		v371:Play()
		v372.Completed:Wait()
		spawn(function()
			-- upvalues: (copy) v_u_370, (copy) v_u_369, (ref) v_u_3, (copy) v_u_368
			local v374 = os.clock()
			local v375 = v_u_370.Position
			local v376 = v_u_370.Rotation
			v_u_369.ImageColor3 = Color3.fromRGB(255, 0, 0)
			v_u_369.Size = UDim2.fromScale(0.5, 0.5)
			v_u_370.ImageTransparency = 0
			v_u_3:Create(v_u_370, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				["ImageTransparency"] = 0.15
			}):Play()
			v_u_3:Create(v_u_369, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				["ImageColor3"] = Color3.fromRGB(0, 0, 0)
			}):Play()
			v_u_3:Create(v_u_369, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				["Size"] = UDim2.fromScale(1, 1)
			}):Play()
			while os.clock() - v374 < 1 do
				local v377 = 1 - (os.clock() - v374)
				local v378 = v375 + UDim2.fromScale(math.random(-100, 100) * v377 / 900, math.random(-100, 100) * v377 / 900)
				local v379 = v376 + math.random(-100, 100) * v377 / 7
				for _, v380 in { v_u_370, v_u_369 } do
					v380.Position = v378
					v380.Rotation = v379
				end
				game["Run Service"].RenderStepped:Wait()
			end
			v_u_3:Create(v_u_369, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				["ImageTransparency"] = 1,
				["Position"] = UDim2.fromScale(0.5, 1.5),
				["Rotation"] = math.random(0, 50),
				["Size"] = UDim2.fromScale(0, 0)
			}):Play()
			v_u_3:Create(v_u_370, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				["ImageTransparency"] = 1,
				["Position"] = UDim2.fromScale(0.5, 1.5),
				["Rotation"] = math.random(-50, 0),
				["Size"] = UDim2.fromScale(0, 0)
			}):Play()
			task.wait(0.5)
			v_u_368:Destroy()
		end)
	end
end
function v_u_111.ToggleSpraycan(_, p381, p382)
	p381.Rig.Spray.Transparency = p382 and 0 or 1
end
function v_u_111.ToggleSkateboard(_, p383, p384)
	p383.Rig.Skateboard.Transparency = p384 and 0 or 1
end
function v_u_111.CreateZoneVisual(_, p385, p386)
	-- upvalues: (copy) v_u_3, (copy) v_u_13
	local v387 = Instance.new("Model", workspace.Misc)
	v387.Name = p385.Player.Name .. "SprayZoneVisual"
	local v388 = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	local v389 = nil
	local v390 = {}
	for v391, v392 in ipairs(p386) do
		local v393 = p385.Config.VandalismZoneVisual:Clone()
		v393.Parent = v387
		v393.Position = v392.Position
		v_u_3:Create(v393, v388, {
			["Size"] = Vector3.new(100, 1, 1),
			["Transparency"] = 0.95
		}):Play()
		v_u_3:Create(v393.Beam, v388, {
			["Width0"] = 100,
			["Width1"] = 100
		}):Play()
		v_u_13:Play(p385.Config.Sounds.VandalismZoneCreated, {
			["Parent"] = v393
		})
		if v389 then
			v393.Beam.Attachment1 = v389.AttachmentA
		end
		v390[v391] = v393
		v389 = v393
	end
	v390[1].Beam.Attachment1 = v389.AttachmentA
	p385.SprayArea = v387
end
function v_u_111.DestroyZoneVisual(_, p394)
	-- upvalues: (copy) v_u_3, (copy) v_u_13
	local v395 = p394.SprayArea
	if v395 then
		local v396 = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		for _, v397 in ipairs(v395:GetChildren()) do
			v_u_3:Create(v397, v396, {
				["Size"] = Vector3.new(0, 1, 1),
				["Transparency"] = 1
			}):Play()
			v_u_3:Create(v397.Beam, v396, {
				["Width0"] = 0,
				["Width1"] = 0
			}):Play()
			v_u_13:Play(p394.Config.Sounds.VandalismZoneDestroyed, {
				["Parent"] = v397
			})
		end
		game.Debris:AddItem(v395, 3)
		p394.SprayArea = nil
	end
end
function v_u_111.TrickCooldownVisual(_, p_u_398, p_u_399)
	-- upvalues: (copy) v_u_3, (copy) v_u_58
	if p_u_398.Cache.VFXHighlight then
		p_u_398.Cache.VFXHighlight:Destroy()
		p_u_398.Cache.VFXHighlight = nil
	end
	task.spawn(function()
		-- upvalues: (copy) p_u_399, (copy) p_u_398, (ref) v_u_3, (ref) v_u_58
		if p_u_399 then
			local v400 = p_u_398.Config.Sk8TrickCooldown / 3
			local v401 = Instance.new("Highlight", p_u_398.Rig)
			v401.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			v401.Adornee = p_u_398.Rig
			p_u_398.Cache.VFXHighlight = v401
			for _ = 1, 3 do
				for v402, v403 in pairs(p_u_398.Config.Sk8TrickHighlightData.TrickCooldownFlash) do
					v401[v402] = v403
				end
				v_u_3:Create(v401, TweenInfo.new(v400), p_u_398.Config.Sk8TrickHighlightData.TrickCooldownDecay):Play()
				v_u_58(p_u_398, "Sk8CooldownFlash", {
					["Volume"] = 0.35
				})
				task.wait(v400)
			end
			v_u_58(p_u_398, "Sk8CooldownReady", {
				["Volume"] = 0.35
			})
			v401:Destroy()
		else
			local v404 = Instance.new("Highlight", p_u_398.Rig)
			v404.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			v404.Adornee = p_u_398.Rig
			p_u_398.Cache.VFXHighlight = v404
			for v405, v406 in pairs(p_u_398.Config.Sk8TrickHighlightData.TrickCooldownFail) do
				v404[v405] = v406
			end
			v_u_3:Create(v404, TweenInfo.new(p_u_398.Config.Sk8TrickCooldown), {
				["FillTransparency"] = 0.9,
				["OutlineTransparency"] = 1
			}):Play()
			v_u_58(p_u_398, "Sk8CooldownFail", {
				["Volume"] = 0.35
			})
			task.wait(p_u_398.Config.Sk8TrickCooldown)
			v_u_58(p_u_398, "Sk8CooldownReady", {
				["Volume"] = 0.35
			})
			v404:Destroy()
		end
	end)
end
function v_u_111.OnSprayStateChanged(_, p407, p408)
	-- upvalues: (copy) v_u_2, (copy) v_u_13
	if v_u_2:IsClient() then
		local v409 = game.Players.LocalPlayer == p407.Player
		for _, v410 in ipairs({ "SprayingSound", "WipingSound" }) do
			if p407.Cache[v410] then
				p407.Cache[v410]:Destroy()
				p407.Cache[v410] = nil
			end
		end
		if p408 == "Spraying" then
			p407.Cache.SprayingSound = v_u_13:Play(p407.Config.Sounds.VandalismSpray, {
				["Parent"] = p407.Rig.PrimaryPart,
				["Looped"] = true
			})
		elseif p408 == "Wiping" then
			p407.Cache.WipingSound = v_u_13:Play(p407.Config.Sounds.VandalismWipe, {
				["Parent"] = p407.Rig.PrimaryPart,
				["Looped"] = true
			})
		end
		if v409 then
			if not p408 then
				p407.Animations.CanIdle:Stop()
				p407.Animations.CanSpray:Stop()
				p407.Animations.CanWipe:Stop()
				return
			end
			if p408 == "Wiping" then
				p407.Animations.CanWipe:Play()
				return
			end
			if p408 == "Spraying" then
				p407.Animations.CanSpray:Play()
				return
			end
			if p408 == "Idle" then
				p407.Animations.CanSpray:Stop()
				p407.Animations.CanWipe:Stop()
			end
		end
	end
end
function v_u_111.OnBatteryCharged(_, _, _) end
function v_u_111.OnBatteryStart(_, p411)
	-- upvalues: (copy) v_u_58
	p411.Meta.BatteryLoopSound = v_u_58(p411, "BatteryLoop", {
		["Looped"] = true,
		["PlaybackSpeed"] = 1
	})
	v_u_58(p411, "BatteryStart")
end
function v_u_111.OnBatteryEnded(_, p412)
	-- upvalues: (copy) v_u_3
	local v413 = p412.Meta.BatteryLoopSound
	if v413 then
		v_u_3:Create(v413, TweenInfo.new(0.2), {
			["PlaybackSpeed"] = 0
		}):Play()
		game.Debris:AddItem(v413, 0.5)
	end
	p412.Meta.BatteryLoopSound = nil
end
function v_u_111.OnBatteryInterrupted(_, p414)
	-- upvalues: (copy) v_u_58
	v_u_58(p414, "BatteryInterrupted")
end
function v_u_111.OnBatteryDischarged(_, p415)
	-- upvalues: (copy) v_u_58
	v_u_58(p415, "BatteryDischarged")
end
function v_u_111.OnBatteryFinished(_, p416)
	-- upvalues: (copy) v_u_58
	v_u_58(p416, "BatteryFinished")
end
function v_u_111.OnSprayAreaEntered(_, _, _) end
function v_u_111.OnSprayAreaExited(_, _, _) end
function v_u_111.OnChannelSwitch(_, p_u_417)
	-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_22, (copy) v_u_65, (copy) v_u_34
	if v_u_2:IsServer() then
		p_u_417:ChangeExpression("Hurt", 0.25)
	else
		local v418 = p_u_417.Rig
		if v418 then
			v418 = p_u_417.Rig.TV.Screen.SurfaceGui.Static
		end
		if v418 then
			if v418:GetTags()[1] ~= "Spritesheet" then
				v418:SetAttribute("Spritesheet", "Static")
				v418:AddTag("Spritesheet")
			end
			v418.ImageTransparency = 0
			v_u_3:Create(v418, v_u_22, {
				["ImageTransparency"] = 1
			}):Play()
		end
		v_u_65(p_u_417, 8, 0.015)
		v_u_34(0.015, function()
			-- upvalues: (ref) v_u_65, (copy) p_u_417
			v_u_65(p_u_417, 1, 3.5)
		end)
	end
end
function v_u_111.OnSk8Start(_, p419)
	-- upvalues: (copy) v_u_2
	if not v_u_2:IsServer() then
		local v420 = p419.Config.S8EffectsTemplate
		if v420 and p419.Rig.PrimaryPart then
			local v421 = v420:Clone()
			v421.CFrame = p419.Rig.PrimaryPart.CFrame
			v421.Name = "S8VFX"
			v421.Parent = p419.Rig.PrimaryPart
			local v422 = Instance.new("WeldConstraint")
			v422.Part0 = p419.Rig.PrimaryPart
			v422.Part1 = v421
			v422.Parent = v422.Part1
			local v423 = v421:FindFirstChild("Wheel1")
			if v423 then
				v423 = v421.Wheel1:FindFirstChildOfClass("Trail")
			end
			if v423 then
				v423.Enabled = true
			end
			p419.Instances.S8EFFECTS = v421
		end
	end
end
function v_u_111.OnSk8Stop(_, p424)
	-- upvalues: (copy) v_u_2
	if not v_u_2:IsServer() then
		local v425 = p424.Rig.PrimaryPart:FindFirstChild("S8VFX")
		if v425 then
			v425:Destroy()
		end
	end
end
function v_u_111.OnSk8Trick(_, p426)
	-- upvalues: (copy) v_u_2
	if not v_u_2:IsServer() then
		local v427 = p426.Rig.PrimaryPart:FindFirstChild("S8VFX")
		if v427 and v427:FindFirstChild("Trick") then
			local v428 = v427.Trick:FindFirstChild("Sparkles")
			if v428 and v428:IsA("ParticleEmitter") then
				v428:Emit(10)
			end
		end
	end
end
function v_u_111.ZoneCharge(_, p429, p430)
	p429.Rig.Head.TennaA.ParticleEmitter.Enabled = p430
	p429.Rig.Head.TennaB.ParticleEmitter.Enabled = p430
end
return v_u_111
