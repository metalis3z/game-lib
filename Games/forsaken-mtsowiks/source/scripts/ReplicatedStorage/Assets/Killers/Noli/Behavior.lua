-- Decompiled by Krnl

game:GetService("ServerStorage")
local v1 = game:GetService("ServerScriptService")
local v_u_2 = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Players")
local v_u_6 = game:GetService("Debris")
local v_u_7 = game:GetService("CollectionService")
local v_u_8 = require(game.ReplicatedStorage.Modules.AchievementUtil)
local v_u_9 = require(script.Classes.VoidRushUI)
local v10 = {}
local v_u_11 = require(v_u_2.Modules.Schematics.Lighting)
local v_u_12 = require(game.ReplicatedStorage.Modules.Hitboxes)
local v_u_13 = require(game.ReplicatedStorage.Modules.Statuses)
local v_u_14 = require(game.ReplicatedStorage.Modules.Sounds)
local v_u_15 = require(v_u_2.Modules.Ragdolls)
local v_u_16 = require(v_u_2.Modules.Projectiles)
local v_u_17 = require(v_u_2.Modules.Network)
local v_u_18 = require(game.ReplicatedStorage.Modules.Util)
require(v_u_2.Modules.Device)
require(v_u_2.Modules.Items)
require(v_u_2.Modules.Misc.RadialImage)
local v_u_19 = require(game.ReplicatedStorage.Modules.Actors)
if v_u_4:IsServer() then
	require(v1.Server.Systems.Core.ActorHandler)
end
local v_u_20 = v_u_2.Assets.UI.StunProtectionVFX
function v10.Created(_, p_u_21)
	-- upvalues: (copy) v_u_4, (copy) v_u_18, (copy) v_u_17, (copy) v_u_2, (copy) v_u_13, (copy) v_u_8, (copy) v_u_5, (copy) v_u_7, (copy) v_u_9
	if v_u_4:IsServer() then
		p_u_21.Behavior.VoidstarEnabled = true
		p_u_21.Behavior.VoidRushCombo = 0
		if not p_u_21.Cache then
			p_u_21.Cache = {}
		end
		p_u_21.Cache.Animations = {
			["VoidRush"] = {}
		}
		for v22, v23 in pairs(p_u_21.Config.Animations.VoidRush) do
			p_u_21.Cache.Animations.VoidRush[v22] = v_u_18:LoadAnimationFromID(p_u_21.Rig, v23)
		end
		p_u_21.Cache.Animations.Observant = v_u_18:LoadAnimationFromID(p_u_21.Rig, p_u_21.Config.Animations.ObservantTeleport)
		p_u_21.Cache.Trails = {}
		for _, v24 in ipairs(p_u_21.Rig:GetDescendants()) do
			if v24:IsA("Trail") then
				local v25 = p_u_21.Cache.Trails
				table.insert(v25, v24)
			end
		end
		v_u_17:SetConnection(("%*ObservantTeleport"):format(p_u_21.Player.Name), "REMOTE_EVENT", function(p26, p27)
			-- upvalues: (copy) p_u_21
			local v28 = workspace.Map.Ingame:FindFirstChild("Map")
			if v28 then
				if p26 == p_u_21.Player and (p27:IsDescendantOf(v28) and (p27:IsA("Model") and p27.Name:find("Generator"))) then
					if (p27:GetPivot().Position - p_u_21.Rig.PrimaryPart.Position).Magnitude >= p_u_21.Config.ObservantMinDistance then
						if p_u_21.Behavior.Observing and p_u_21:CanUseAbility("Observant") then
							p_u_21.Behavior.ObservantUse(p_u_21, p27)
						end
					end
				else
					p26:Kick("\n\nForsakenCheatKiller 100:\nInvalid Connection Arguments [ObservantTeleport]\n")
					return
				end
			else
				return
			end
		end)
		local v_u_29 = {
			["TOOKDAMAGE"] = {},
			["KILLED"] = {}
		}
		v_u_17:SetConnection(("%*CloneEvent"):format(p_u_21.Player.Name), "REMOTE_EVENT", function(p30, p31)
			-- upvalues: (ref) v_u_2, (copy) v_u_29, (ref) v_u_13, (copy) p_u_21, (ref) v_u_18, (ref) v_u_8
			local v32 = require(v_u_2.Modules.StatusEffects.KillerExclusive.Hallucination.HallucinationClass.FakeNoli)
			if not v_u_29[p31] then
				p30:Kick("\n\nForsakenCheatKiller 150:\nInvalid Connection Arguments [CloneEvent]\n")
			end
			local v33 = v_u_29[p31] or {}
			local v34 = p30.Character
			local v35
			if v34 then
				v35 = v34.PrimaryPart
			else
				v35 = v34
			end
			local v36 = v_u_13:PlayerHasStatus(p30, "Hallucination")
			local v37
			if v36 then
				v37 = v36.Level >= v32.ApplyAt
			else
				v37 = v36
			end
			local v38 = v33[p30]
			if v38 then
				v38 = tick() - v33[p30] < p_u_21.Config.StabCooldown - 0.2
			end
			if v34 and (v35 and (v37 and not v38)) then
				v33[p30] = tick()
				if p31 == "TOOKDAMAGE" then
					v_u_18:ApplyDamage(p30.Character, p_u_21.Config.HallucinationCloneDamage)
					local v39 = v36.Data.Duration - v36.TimePast + p_u_21.Config.HallucinationCloneExtension
					local v40 = math.clamp(v39, 0, 20)
					warn(v40)
					v_u_13:ApplyStatus(p30, "Hallucination", {
						["Level"] = v36.Level,
						["Duration"] = v40,
						["Killer"] = p_u_21
					})
					return
				end
				if p31 == "KILLED" then
					workspace.Hitboxes:FindFirstChild(p30.Name .. "Hitbox")
					v_u_13:RemoveStatus(p30, "Hallucination")
					v_u_8:IncrementAchievementProgress(p_u_21.Player, "NoliPranked")
				end
			end
		end)
		if not v_u_4:IsStudio() then
			p_u_21:SetCooldownOf("Observant", p_u_21.Config.ObservantC00ldown)
		end
		task.spawn(function()
			-- upvalues: (copy) p_u_21
			p_u_21.Behavior.FakeGenerators = {}
			while true do
				task.wait(1)
				local v41 = workspace.Map.Ingame:FindFirstChild("Map")
				local v42
				if v41 then
					v42 = v41:FindFirstChild("GeneratorPositions")
				else
					v42 = v41
				end
				if v42 and v42:FindFirstChildOfClass("CFrameValue") or not (p_u_21 and p_u_21.Behavior.FakeGenerators) then
					local v43 = p_u_21
					if v43 then
						v43 = p_u_21.Behavior.FakeGenerators
					end
					if v41 and v43 then
						local v44 = {}
						for _, v45 in ipairs(v42:GetChildren()) do
							if v45:IsA("CFrameValue") then
								table.insert(v44, v45)
							end
						end
						if #v44 >= 1 then
							local v46 = #v44
							for _ = 1, math.min(v46, 2) do
								local v47 = math.random(1, #v44)
								local v48 = v44[v47]
								local v49 = script.FakeGenerator:Clone()
								v49:SetPrimaryPartCFrame(v48.Value)
								v49.Parent = v41
								v49.Remotes.BE.Event:Connect(function(p50, p51)
									-- upvalues: (ref) p_u_21
									local v52 = require(game.ReplicatedStorage.Modules.Statuses)
									local v53 = v52:PlayerHasStatus(p50, "Hallucination")
									local v54 = {}
									local v55 = (v53 and v53.Level or 0) + (p51 >= 100 and 3 or 1)
									v54.Level = math.clamp(v55, 1, 3)
									v54.Duration = 15
									v54.Killer = p_u_21
									v52:ApplyStatus(p50, "Hallucination", v54)
								end)
								for _, v56 in ipairs(v49.Scripts:GetChildren()) do
									if v56:IsA("BaseScript") then
										v56.Enabled = true
									end
								end
								table.insert(v43, v49)
								table.remove(v44, v47)
								v48:Destroy()
							end
						end
					else
						return
					end
				end
			end
		end)
	elseif v_u_4:IsClient() and v_u_5.LocalPlayer == p_u_21.Player then
		local v57 = p_u_21.Player.Name .. "GenHighlight"
		p_u_21.GeneratorHighlights = {}
		p_u_21.GenConnection = v_u_7:GetInstanceAddedSignal(v57):Connect(function(p58)
			-- upvalues: (copy) p_u_21
			if p58.ClassName == "Highlight" then
				for v59, v60 in pairs(p_u_21.Config.ObservantKillerProperties) do
					p58[v59] = v60
				end
			end
		end)
		v_u_17:SetConnection(("%*VoidRushUpdateUI"):format(p_u_21.Player.Name), "REMOTE_EVENT", function(p61)
			-- upvalues: (ref) v_u_9, (copy) p_u_21
			local v_u_62 = p61 == "Create" and v_u_9.new(p_u_21) or p_u_21.Behavior.VoidRushUI
			if v_u_62 then
				v_u_62.Counter = (v_u_62.Counter or 0) + 1
				if p61 == "Create" then
					p_u_21.Behavior.VoidRushUI = v_u_62
					v_u_62.Blinking = false
					v_u_62:TweenRadial(p_u_21.Config.VoidRushChargeLength, 0, 1)
					v_u_62:SetText("Charge Void Rush by holding down")
					return
				elseif p61 == "ChargeFail" then
					v_u_62.Blinking = false
					v_u_62:SetText(p_u_21.Config.VoidRushStopMessages.FailedToCharge)
					v_u_62:FadeOut(2, false)
					return
				elseif p61 == "Dash" then
					v_u_62.BlinkSpeed = 0.25
					v_u_62.Blinking = true
					v_u_62:TweenRadial(p_u_21.Config.VoidRushDashLength, 1, 0)
					v_u_62:SetText("Release the Void Rush button to cancel")
					return
				elseif p61 == "Hit" then
					v_u_62.Blinking = false
					local v_u_63 = v_u_62.Counter
					v_u_62:SetText(p_u_21.Config.VoidRushStopMessages.Hit)
					v_u_62:TweenRadial(p_u_21.Config.VoidRushHitEndlag, 0, 1)
					task.delay(p_u_21.Config.VoidRushHitEndlag, function()
						-- upvalues: (copy) v_u_62, (copy) v_u_63, (ref) p_u_21
						if v_u_62 and v_u_63 == v_u_62.Counter then
							v_u_62:TweenRadial(p_u_21.Config.VoidRushComboWindow, 1, 0)
						end
					end)
					return
				elseif p61 == "WindowMiss" then
					v_u_62.Blinking = false
					v_u_62:SetText(p_u_21.Config.VoidRushStopMessages.WindowMissed)
					v_u_62:FadeOut(2, false)
					return
				elseif p61:match("Miss_") then
					v_u_62.Blinking = false
					local v64 = p61:sub(6, p61:len())
					v_u_62:SetText(p_u_21.Config.VoidRushStopMessages[v64])
					v_u_62:FadeOut(2, v64 == "HitLarge")
				else
					warn("Invalid server subroutine string", p61)
				end
			else
				warn("Noli client had no UI")
				return
			end
		end)
		v_u_17:SetConnection(("%*ObservantTeleport"):format(p_u_21.Player.Name), "REMOTE_EVENT", function()
			-- upvalues: (copy) p_u_21
			p_u_21.Behavior.RevertObservance(p_u_21)
		end)
	end
end
function v10.Destroyed(_, p65)
	-- upvalues: (copy) v_u_4, (copy) v_u_17, (copy) v_u_5
	if v_u_4:IsServer() then
		p65.Behavior.RevertObservance(p65, false)
		p65.Behavior.ToggleGeneratorAura(p65, false)
		v_u_17:RemoveConnection(("%*ObservantTeleport"):format(p65.Player.Name), "REMOTE_EVENT")
		v_u_17:RemoveConnection(("%*CloneEvent"):format(p65.Player.Name), "REMOTE_EVENT")
		for _, v66 in ipairs(p65.Behavior.FakeGenerators or {}) do
			v66:Destroy()
		end
		p65.Behavior.FakeGenerators = nil
	elseif v_u_4:IsClient() and v_u_5.LocalPlayer == p65.Player then
		v_u_17:RemoveConnection(("%*VoidRushUpdateUI"):format(p65.Player.Name), "REMOTE_EVENT")
		v_u_17:RemoveConnection(("%*ObservantTeleport"):format(p65.Player.Name), "REMOTE_EVENT")
		if p65.Behavior.VoidRushUI then
			p65.Behavior.VoidRushUI:Destroy()
		end
		if p65.GenConnection then
			p65.GenConnection:Disconnect()
		end
		p65.Behavior.RevertObservance(p65)
	end
end
function v10.OnIntroduction(_, p67, p_u_68, p69)
	-- upvalues: (copy) v_u_11, (copy) v_u_18, (copy) v_u_5
	v_u_11:SetCustomLighting(p67.Config.IntroLighting)
	local v_u_70 = {}
	if p_u_68:FindFirstChild("Right Arm") and p_u_68["Right Arm"]:FindFirstChild("TentacleBase") then
		for _, v71 in ipairs(p_u_68["Right Arm"].TentacleBase:GetDescendants()) do
			if (v71:IsA("ParticleEmitter") or v71:IsA("Beam")) and v71.Enabled then
				table.insert(v_u_70, v71)
				v71.Enabled = false
			end
		end
	end
	if p_u_68:FindFirstChild("Voidstar") then
		p_u_68.Voidstar:Destroy()
	end
	if p_u_68:FindFirstChild("FakeCrown") then
		p_u_68.FakeCrown.Transparency = 0
		if p_u_68:FindFirstChild("VoidstarCrown") then
			p_u_68.VoidstarCrown:Destroy()
		end
	else
		local v72 = p_u_68:FindFirstChild("VoidstarCrown")
		if v72 then
			local v73 = p_u_68.VoidstarCrown:Clone()
			v73.Name = "FakeCrown"
			v73.Parent = p_u_68
			local v74 = Instance.new("Motor6D", v73)
			v74.C0 = p67.Config.IntroCrownOffset or CFrame.new(0, 0.75, 0)
			v74.Part0 = p_u_68.Head
			v74.Part1 = v73
			v72:Destroy()
		end
	end
	local v_u_75 = workspace.Misc:FindFirstChild("KillerCutsceneBackground")
	local v_u_76 = true
	task.spawn(function()
		-- upvalues: (ref) v_u_76, (copy) v_u_75
		while v_u_76 do
			for v77, v78 in pairs(v_u_75.Voidstars:GetChildren()) do
				v78.CFrame = v78.CFrame * CFrame.Angles(0, v77 % 2 == 0 and 0.0225 or -0.0225, 0)
			end
			task.wait()
		end
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_76, (copy) v_u_75
		while v_u_76 do
			local v79 = v_u_75.Skybox
			v79.CFrame = v79.CFrame * CFrame.Angles(0, 0.004363323129985824, 0)
			task.wait()
		end
	end)
	local v_u_80 = v_u_18:CreateFOVMultiplier(v_u_5.LocalPlayer, 0.375, "NoliIntroScene", p69)
	task.delay(1.98, function()
		-- upvalues: (copy) v_u_80
		v_u_80.Value = 0.275
	end)
	task.delay(p69, function()
		-- upvalues: (ref) v_u_76, (copy) v_u_70, (copy) p_u_68, (ref) v_u_11
		v_u_76 = false
		for _, v81 in ipairs(v_u_70) do
			v81.Enabled = true
		end
		p_u_68:Destroy()
		v_u_11:SetAsCurrentLighting()
	end)
end
function v10.OnVictory(_, p82, p_u_83, p_u_84, p85)
	-- upvalues: (copy) v_u_11, (copy) v_u_4, (copy) v_u_18, (copy) v_u_3, (copy) v_u_5
	if p82 == "Start" then
		v_u_11:SetCustomLighting(p_u_83.Config.OutroLighting)
		local v_u_86 = p_u_83.Config.OutroFrameData
		local v87 = p_u_83.Cache.VictoryKillerTrack
		local v_u_88 = p_u_83.Cache.VictoryCameraTrack
		local v_u_89 = {}
		local v_u_90 = Instance.new("ScreenGui")
		v_u_90.Name = "NoliOutroOverlay"
		v_u_90.ResetOnSpawn = false
		v_u_90.IgnoreGuiInset = true
		v_u_90.Parent = game.Players.LocalPlayer.PlayerGui
		v87.Stopped:Once(function()
			-- upvalues: (copy) p_u_84
			if p_u_84 then
				p_u_84:PivotTo(p_u_84:GetPivot() + Vector3.new(0, -20, 0))
			end
		end)
		local function v_u_93(p91)
			-- upvalues: (copy) v_u_89
			for _, v92 in ipairs(p91:GetDescendants()) do
				if v92:IsA("ParticleEmitter") then
					v_u_89[v92.Name] = v92
				end
			end
		end
		for _, v94 in ipairs(p_u_84:GetDescendants()) do
			if v94:IsA("Sound") then
				v94:Destroy()
			end
		end
		game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true)
		local v_u_97 = v_u_4.RenderStepped:Connect(function()
			-- upvalues: (copy) v_u_88, (copy) v_u_86
			local v95 = (v_u_88.TimePosition + 0.001) * 60
			local v96 = math.ceil(v95)
			if v_u_86.CameraFOV and v_u_86.CameraFOV[v96] then
				workspace.CurrentCamera.FieldOfView = v_u_86.CameraFOV[v96] or v_u_86.CameraFOV[#v_u_86.CameraFOV]
			end
		end)
		if not v_u_18:GetSettingValue("EpilepsyMode") then
			local v_u_101 = v87:GetMarkerReachedSignal("EmitParticle"):Connect(function(p98)
				-- upvalues: (copy) v_u_89
				local v99 = v_u_89[p98]
				local v100 = v99:GetAttribute("EmitCount")
				if v100 then
					v99:Emit(v100)
				else
					v99.Enabled = not v99.Enabled
				end
			end)
			task.delay(p85, function()
				-- upvalues: (copy) v_u_101
				v_u_101:Disconnect()
			end)
		end
		task.spawn(function()
			-- upvalues: (copy) v_u_93
			local v102 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 3)
			if v102 then
				v_u_93(v102.Map.ExplosionGround)
			end
		end)
		task.spawn(function()
			-- upvalues: (copy) p_u_83, (copy) v_u_93
			local v103 = workspace.Misc:WaitForChild(p_u_83.Player.Name .. "CameraRig", 3)
			if v103 then
				v_u_93(v103)
			end
		end)
		task.delay(3.22, function()
			-- upvalues: (ref) v_u_18, (copy) v_u_90, (copy) p_u_84, (ref) v_u_3
			if not v_u_18:GetSettingValue("EpilepsyMode") then
				local v104 = Instance.new("Frame", v_u_90)
				v104.Size = UDim2.new(10, 0, 10, 0)
				v104.AnchorPoint = Vector2.new(0.5, 0.5)
				v104.Position = UDim2.new(0.5, 0, 0.5, 0)
				v104.BackgroundTransparency = 1
				v104.BackgroundColor3 = Color3.new(0, 0, 0)
				local v105 = Instance.new("Highlight")
				v105.FillTransparency = 1
				v105.OutlineTransparency = 1
				v105.OutlineColor = Color3.new(0.4, 0, 1)
				v105.Parent = p_u_84
				game.Debris:AddItem(v105, 3)
				local v106 = Instance.new("ColorCorrectionEffect")
				v106.Parent = game.Lighting
				v106.Name = "NoliBoomCC"
				game.Debris:AddItem(v106, 3)
				local v107 = v_u_3:Create(v106, TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
					["TintColor"] = Color3.fromRGB(125, 66, 155),
					["Brightness"] = -0.1,
					["Contrast"] = 0.5
				})
				v107:Play()
				v_u_3:Create(v105, TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, true, 0), {
					["OutlineTransparency"] = 0.1
				}):Play()
				task.wait(0.65)
				v_u_18:ApplyCameraShake(0.2, 1.2)
				v107:Pause()
				v106.Contrast = 1
				v106.Brightness = 2.8
				v106.TintColor = Color3.fromRGB(70, 0, 155)
				v_u_3:Create(v106, TweenInfo.new(1.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					["Brightness"] = -0.6,
					["TintColor"] = Color3.new(0.623529, 0.623529, 0.623529),
					["Contrast"] = -0.5
				}):Play()
				task.wait(1.1)
				if not v104 then
					return
				end
				v_u_3:Create(v104, TweenInfo.new(0.2), {
					["BackgroundTransparency"] = 0,
					["BackgroundColor3"] = Color3.new(0, 0, 0)
				}):Play()
			end
		end)
		task.delay(p85, function()
			-- upvalues: (copy) v_u_97
			v_u_97:Disconnect()
		end)
	elseif p82 == "End" then
		v_u_5.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil)
		v_u_11:SetAsCurrentLighting()
		if v_u_5.LocalPlayer.PlayerGui:FindFirstChild("NoliOutroOverlay") then
			v_u_5.LocalPlayer.PlayerGui.NoliOutroOverlay:Destroy()
		end
		local v108 = game.Lighting:WaitForChild("NoliBoomCC", 9)
		if v108 then
			v108:Destroy()
		end
	end
end
function v10.OnExecution(_, p_u_109, p_u_110)
	-- upvalues: (copy) v_u_15
	local v_u_111 = p_u_109.Rig
	p_u_109.Behavior.DisableVoidstar(p_u_109)
	p_u_109.Behavior.ToggleTendril(p_u_109, true)
	task.delay(4.2, function()
		-- upvalues: (copy) p_u_109
		p_u_109.Behavior.EnableVoidstar(p_u_109)
		p_u_109.Behavior.ToggleTendril(p_u_109, false)
	end)
	if p_u_109.VoidstarVisibleThread then
		task.cancel(p_u_109.VoidstarVisibleThread)
		p_u_109.VoidstarVisibleThread = nil
	end
	task.delay(2.4, function()
		-- upvalues: (ref) v_u_15, (copy) p_u_110, (copy) v_u_111
		local v112 = {
			["Velocity"] = Vector3.new(0, 50, 0),
			["KillEffects"] = {
				["HeadSquash"] = true
			}
		}
		v_u_15.AddProfile(p_u_110, v112)
		local v113 = p_u_110:FindFirstChild("Head")
		local v114 = p_u_110:FindFirstChild("Humanoid")
		if v114 then
			v114.BreakJointsOnDeath = false
			v114.Health = 0
			if v113 then
				v113:Destroy()
			end
			for _, v115 in ipairs(v_u_111.Voidstar.Crush:GetChildren()) do
				if v115:IsA("ParticleEmitter") then
					v115.Enabled = true
				end
			end
			task.delay(0.125, function()
				-- upvalues: (ref) v_u_111
				for _, v116 in ipairs(v_u_111.Voidstar.Crush:GetChildren()) do
					if v116:IsA("ParticleEmitter") then
						v116.Enabled = false
					end
				end
			end)
		end
	end)
end
local v267 = {
	["Stab"] = {
		["LayoutOrder"] = 1,
		["Icon"] = "rbxassetid://130161235577806",
		["KeybindType"] = "MainAbility",
		["Callback"] = function(p_u_117, _)
			-- upvalues: (copy) v_u_4, (copy) v_u_14, (copy) v_u_12, (copy) v_u_18, (copy) v_u_13
			if v_u_4:IsServer() then
				p_u_117:PlayVoiceline("Stab", {
					["Priority"] = 1
				})
				p_u_117.AbilitiesDisabled = true
				task.delay(p_u_117.Config.StabEndlag, function()
					-- upvalues: (copy) p_u_117
					p_u_117.AbilitiesDisabled = false
				end)
				v_u_14:Play(p_u_117.Config.Sounds.Swing, {
					["Parent"] = p_u_117.Rig.PrimaryPart,
					["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
					["Volume"] = 0.25,
					["RollOffMaxDistance"] = 25
				})
				p_u_117.Behavior.DisableVoidstar(p_u_117)
				p_u_117.Behavior.ToggleTendril(p_u_117, true)
				task.delay(p_u_117.Config.StabWindup, function()
					-- upvalues: (ref) v_u_12, (copy) p_u_117, (ref) v_u_18, (ref) v_u_14, (ref) v_u_13
					local v118 = v_u_12
					local v119 = p_u_117.Player
					local v122 = {
						["Size"] = Vector3.new(4.5, 6, 7.5),
						["CFrameOffset"] = CFrame.new(0, 0, -2.25),
						["Damage"] = p_u_117.Config.StabDamage,
						["Time"] = p_u_117.Config.StabLinger,
						["Knockback"] = 2,
						["HitMultiple"] = false,
						["ExecuteOnKill"] = true,
						["Connections"] = {
							["Hit"] = function(p120, p121)
								-- upvalues: (ref) v_u_18, (ref) p_u_117, (ref) v_u_14, (ref) v_u_13
								v_u_18:CreateSpeedMultiplier(p120, 1.5, "HitSpeedBonus", 1.25)
								if p121 then
									p_u_117:PlayVoiceline("StabHit", {
										["Priority"] = 2
									})
									v_u_14:Play(p_u_117.Config.Sounds.Hit, {
										["Parent"] = p_u_117.Rig.PrimaryPart,
										["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
										["Volume"] = 0.3,
										["RollOffMaxDistance"] = 25
									})
								end
								v_u_13:RemoveStatus(p120, "Hallucination")
							end
						}
					}
					v118:CreateHitbox(v119, v122)
				end)
				p_u_117.VoidstarVisibleThread = task.delay(p_u_117.Config.StabEndlag, function()
					-- upvalues: (copy) p_u_117
					p_u_117.Behavior.EnableVoidstar(p_u_117)
					p_u_117.Behavior.ToggleTendril(p_u_117, false)
				end)
			elseif v_u_4:IsClient() then
				p_u_117.Animations.Stab:Play(0.175)
			end
		end
	},
	["VoidRush"] = {
		["LayoutOrder"] = 2,
		["Icon"] = "rbxassetid://110747688363796",
		["KeybindType"] = "AltAbility1",
		["FlavorText"] = "[Hold]",
		["Toggle"] = true,
		["Callback"] = function(p_u_123, p124)
			-- upvalues: (copy) v_u_14, (copy) v_u_4, (copy) v_u_18, (copy) v_u_17, (copy) v_u_8, (copy) v_u_12, (copy) v_u_3, (copy) v_u_13, (copy) v_u_19, (copy) v_u_15, (copy) v_u_2
			local v_u_125 = p_u_123.Behavior
			local v_u_126 = ("%*VoidRushCollision"):format(p_u_123.Player.Name)
			local v_u_127 = ("%*VoidRushCancel"):format(p_u_123.Player.Name)
			local v_u_128 = ("%*VoidRushUpdateUI"):format(p_u_123.Player.Name)
			local function v_u_133(p129)
				-- upvalues: (copy) p_u_123, (ref) v_u_14
				local v130 = p_u_123.Config.Sounds
				local v131 = v130[("VoidRush%*"):format(p129)] or v130[p129]
				if v131 then
					local v132 = {
						["Parent"] = p_u_123.Rig.PrimaryPart,
						["PlaybackSpeed"] = Random.new():NextNumber() / 20 + 0.975,
						["Volume"] = 0.7,
						["RollOffMaxDistance"] = 50
					}
					return v_u_14:Play(v131, typeof(v131) == "table" and {
						["Parent"] = p_u_123.Rig.PrimaryPart,
						["PlaybackSpeed"] = 1,
						["RollOffMaxDistance"] = 80,
						["Volume"] = 0.77
					} or v132)
				end
			end
			if v_u_4:IsServer() then
				local function v_u_136(p134, p135)
					-- upvalues: (copy) p_u_123, (ref) v_u_18
					p_u_123.AbilitiesDisabled = true
					v_u_18:CreateSpeedMultiplier(p_u_123.Rig, 0.6, "VoidRushEndlag", p134 + (p135 and p_u_123.Config.VoidRushComboWindow or 0), true)
					if not p135 then
						task.delay(p134, function()
							-- upvalues: (ref) p_u_123
							p_u_123.AbilitiesDisabled = false
						end)
					end
				end
				local v_u_137 = p_u_123.Cache.Animations.VoidRush
				p_u_123.AbilitiesDisabled = true
				p_u_123.Behavior.DisableVoidstar(p_u_123)
				p_u_123.Behavior.ToggleTendril(p_u_123, true)
				task.spawn(function()
					-- upvalues: (copy) v_u_125, (ref) v_u_17, (copy) p_u_123, (copy) v_u_128, (copy) v_u_137, (copy) v_u_133, (ref) v_u_18, (copy) v_u_127, (ref) v_u_4, (ref) v_u_14, (ref) v_u_8, (ref) v_u_12, (copy) v_u_126, (ref) v_u_3, (ref) v_u_13, (ref) v_u_19, (ref) v_u_15, (copy) v_u_136
					if not v_u_125.Endlag then
						v_u_125.Endlag = nil
						v_u_17:FireClientConnection(p_u_123.Player, v_u_128, "REMOTE_EVENT", "Create")
						local v138 = 0
						local v_u_139 = false
						v_u_137.StartCharge:Play(0.15)
						v_u_137.LoopCharge:Play(0.2)
						p_u_123.StartSound = v_u_133("Start")
						v_u_133("Loop")
						p_u_123:PlayVoiceline("VoidRushStart", {
							["Priority"] = 2
						})
						local v140 = v_u_18:CreateSpeedMultiplier(p_u_123.Rig, p_u_123.Config.VoidRushChargingSpeed, "VoidRushCharging", p_u_123.Config.VoidRushChargeLength)
						p_u_123.Rig:SetAttribute("VoidRushState", "Charging")
						v_u_17:SetConnection(v_u_127, "REMOTE_EVENT", function()
							-- upvalues: (ref) v_u_139
							v_u_139 = true
						end)
						p_u_123.Behavior.VoidRushCombo = 0
						local v141 = v_u_139
						repeat
							v138 = v138 + v_u_4.Heartbeat:Wait()
							v141 = p_u_123.Rig:GetAttribute("Stunned") and true or v141
						until p_u_123.Config.VoidRushChargeLength <= v138 or v141
						v_u_17:RemoveConnection(v_u_127)
						v_u_137.StartCharge:Stop()
						v_u_137.LoopCharge:Stop()
						v140:Destroy()
						if v141 then
							p_u_123:SetCooldownOf("VoidRush", p_u_123.Config.VoidRushC00ldown / 16)
							p_u_123.Rig:SetAttribute("VoidRushState", "ChargingCancelled")
							v_u_137.CancelCharge:Play(0.15)
							p_u_123:PlayVoiceline("VoidRushCancel", {
								["Priority"] = 3
							})
							v_u_133("Cancel")
							v_u_17:FireClientConnection(p_u_123.Player, v_u_128, "REMOTE_EVENT", "ChargeFail")
							task.delay(0.2, function()
								-- upvalues: (ref) p_u_123
								p_u_123.Behavior.EnableVoidstar(p_u_123)
								p_u_123.Behavior.ToggleTendril(p_u_123, false)
								p_u_123.AbilitiesDisabled = false
								p_u_123.DisabledAbilities = nil
								p_u_123.Rig:SetAttribute("VoidRushState", nil)
							end)
							if p_u_123.StartSound then
								p_u_123.StartSound:Destroy()
							end
							return
						end
					end
					local v142 = v_u_18
					local v143 = p_u_123
					if v143 then
						v143 = p_u_123.Rig
					end
					if v142:IsAlive(v143) then
						if p_u_123.StartSound then
							p_u_123.StartSound:Destroy()
						end
						if p_u_123.WindowSound then
							p_u_123.WindowSound:Destroy()
						end
						p_u_123.VoidRushChargingSound = v_u_14:Play(p_u_123.Config.Sounds.VoidRushDashLoop, {
							["Parent"] = p_u_123.Rig.PrimaryPart,
							["RollOffMaxDistance"] = 50,
							["Volume"] = 0.75
						})
						p_u_123:PlayVoiceline("VoidRushDash", {
							["Priority"] = 3
						})
						local v144 = p_u_123.Config.VoidRushDashSpeed
						local v145 = v_u_125.Endlag and "Combo" or "Init"
						local v146 = p_u_123.Config.VoidRushDashLength
						local v_u_147 = p_u_123.Config.VoidRushHallucinationLevel
						local v_u_148 = v_u_18:CreateSpeedMultiplier(p_u_123.Rig, v144 / p_u_123.Config.Speed, "VoidRushDash")
						local function v_u_150()
							-- upvalues: (ref) v_u_137
							for _, v149 in ipairs({
								"StartDashInit",
								"LoopDashCombo",
								"LoopDashInit",
								"StartDashCombo"
							}) do
								if v_u_137[v149] then
									v_u_137[v149]:Stop()
								end
							end
						end
						v_u_150()
						v_u_137[("StartDash%*"):format(v145)]:Play(0.05)
						v_u_137[("LoopDash%*"):format(v145)]:Play(0.05)
						local v151 = v_u_133
						local v152 = v_u_125.Endlag and 2 or 1
						v151("Dash" .. tostring(v152))
						if v_u_125.EndlagComboThread then
							task.cancel(v_u_125.EndlagComboThread)
							v_u_125.EndlagComboThread = nil
						end
						local v153 = p_u_123.Behavior
						v153.VoidRushCombo = v153.VoidRushCombo + 1
						v_u_125.Endlag = nil
						if p_u_123.Behavior.VoidRushCombo == 5 then
							v_u_8:IncrementAchievementProgress(p_u_123.Player, "NoliCombo")
						end
						local v_u_154 = false
						local v_u_155 = nil
						local v_u_156 = nil
						local v_u_157 = nil
						local v_u_158 = nil
						local v_u_159 = nil
						local v_u_160 = nil
						p_u_123.Rig:GetAttributeChangedSignal("Stunned"):Once(function()
							-- upvalues: (ref) v_u_158
							v_u_158 = true
						end)
						local v_u_161 = nil
						v_u_161 = v_u_12:CreateHitbox(p_u_123.Player, {
							["Size"] = Vector3.new(6, 6, 4),
							["Damage"] = p_u_123.Config.VoidRushBaseDamage,
							["CFrameOffset"] = CFrame.new(0, 0, -2),
							["Time"] = v146,
							["Knockback"] = 6,
							["HitMultiple"] = true,
							["ExecuteOnKill"] = false,
							["Connections"] = {
								["Hit"] = function(p162)
									-- upvalues: (ref) v_u_154, (ref) v_u_18, (ref) v_u_155, (ref) v_u_8, (ref) p_u_123, (ref) v_u_161, (ref) v_u_160
									if not v_u_154 then
										local v163, v164 = v_u_18:GetEntityType(p162)
										if v163 then
											v_u_154 = true
											v_u_155 = p162
											if v_u_155:GetAttribute("GuestCharging") then
												v_u_8:IncrementAchievementProgress(p_u_123.Player, "NoliCar")
												v_u_8:IncrementAchievementProgress(game.Players:GetPlayerFromCharacter(v_u_155), "NoliCar")
											end
											if v_u_161 then
												v_u_161:Cancel()
												return
											end
										elseif v164 == "Building" then
											v_u_154 = true
											v_u_160 = p162
											if v_u_161 then
												v_u_161:Cancel()
											end
										end
									end
								end,
								["Ended"] = function()
									-- upvalues: (ref) v_u_156
									v_u_156 = true
								end
							}
						})
						local v_u_165 = require(game.ReplicatedStorage.Modules.Network)
						v_u_165:SetConnection(v_u_126, "REMOTE_EVENT", function(p166, p167)
							-- upvalues: (ref) p_u_123, (ref) v_u_157, (ref) v_u_159
							if p166 == p_u_123.Player then
								v_u_157 = p167
								v_u_159 = true
							else
								p166:Kick("not slick at all")
							end
						end)
						v_u_18:CreateSpeedMultiplier(p_u_123.Rig, 1, "VoidRushEndlag", 0)
						v_u_18:CreateSpeedMultiplier(p_u_123.Rig, 1, "VoidRushCharging", 0)
						p_u_123.Rig:SetAttribute("VoidRushState", "Dashing")
						v_u_17:FireClientConnection(p_u_123.Player, v_u_128, "REMOTE_EVENT", "Dash")
						task.spawn(function()
							-- upvalues: (ref) v_u_155, (ref) v_u_156, (ref) v_u_158, (ref) v_u_157, (ref) v_u_159, (ref) v_u_160, (ref) p_u_123, (copy) v_u_148, (copy) v_u_165, (ref) v_u_126, (ref) v_u_161, (ref) v_u_3, (ref) v_u_13, (copy) v_u_147, (ref) v_u_19, (ref) v_u_18, (ref) v_u_133, (ref) v_u_137, (ref) v_u_17, (ref) v_u_128, (ref) v_u_15, (ref) v_u_12, (ref) v_u_125, (ref) v_u_136, (copy) v_u_150
							repeat
								task.wait()
							until v_u_155 or (v_u_156 or (v_u_158 or (v_u_157 or (v_u_159 or (v_u_160 or not p_u_123.Rig.PrimaryPart)))))
							local v168 = v_u_156 and "Timeout" or (v_u_158 and "Stunned" or (v_u_157 and "Crashed" or (v_u_160 and "NonChar" or "Cancelled")))
							v_u_148:Destroy()
							v_u_165:RemoveConnection(v_u_126, "REMOTE_EVENT")
							v_u_161:Cancel()
							if p_u_123.VoidRushChargingSound then
								local v169 = p_u_123.VoidRushChargingSound
								p_u_123.VoidRushChargingSound = nil
								v_u_3:Create(v169, TweenInfo.new(0.4), {
									["PlaybackSpeed"] = 0,
									["Volume"] = v169.Volume / 5
								}):Play()
								game.Debris:AddItem(v169, 0.5)
							end
							if v_u_155 then
								local v170 = v_u_13:PlayerHasStatus(v_u_155, "Hallucination")
								if v170 and (v170.Data and v_u_147 <= v170.Data.Level) then
									v_u_13:RemoveStatus(v_u_155, "Hallucination")
									p_u_123:SetCooldownOf("VoidRush", p_u_123.Config.VoidRushC00ldown)
									v_u_19:IncrementActorStats(p_u_123.Player, {
										["Action"] = "Slammed Survivor with Void Rush",
										["RewardType"] = "RegularKillerAction"
									})
									v_u_18:SetUpCutscene(p_u_123.Rig, v_u_155, CFrame.new(0, 0.01, 0))
									v_u_133("Cutscene")
									v_u_18:GiveInvincible(p_u_123.Rig, "Slam")
									local v171 = v_u_137.CutsceneKillerRig
									v171:Play(0)
									v171.TimePosition = 0
									local v172 = v_u_18:LoadAnimationFromID(v_u_155, p_u_123.Config.Animations.VoidRushVictimRig, true)
									v172:Play(0.05)
									v172.TimePosition = v171.TimePosition
									p_u_123.Rig:SetAttribute("VoidRushState", "HitLarge")
									v_u_17:FireClientConnection(p_u_123.Player, v_u_128, "REMOTE_EVENT", "Miss_HitLarge")
									task.spawn(function()
										-- upvalues: (ref) v_u_155, (ref) p_u_123, (ref) v_u_15, (ref) v_u_12
										v_u_155.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
										task.wait(0.5)
										p_u_123:PlayVoiceline("Slam", {
											["Priority"] = 4
										})
										if v_u_155 then
											v_u_15.AddProfile(v_u_155, {
												["Velocity"] = Vector3.new(0, -5, 0)
											})
											v_u_12:CreateHitbox(p_u_123.Player, {
												["Size"] = Vector3.new(4, 4, 4),
												["CFrame"] = v_u_155.PrimaryPart.CFrame,
												["Damage"] = p_u_123.Config.VoidRushSlamDamage + (p_u_123.Behavior.VoidRushCombo or 0) * p_u_123.Config.VoidRushComboDamage,
												["Time"] = 0.1,
												["Knockback"] = 0,
												["HitMultiple"] = true,
												["PredictVelocity"] = false,
												["ExecuteOnKill"] = false,
												["Connections"] = {}
											})
											local v173 = RaycastParams.new()
											v173.FilterDescendantsInstances = workspace.Players:GetDescendants()
											v173.FilterType = Enum.RaycastFilterType.Exclude
											local v174 = p_u_123.Rig.PrimaryPart.Position
											local v175 = p_u_123.Rig.PrimaryPart.CFrame.LookVector * 2
											local v176 = workspace:Raycast(v174, v175, v173)
											v_u_155:SetPrimaryPartCFrame(v_u_155.PrimaryPart.CFrame + v175 * (v176 and v176.Distance or v175.Magnitude) / 2)
											v_u_155.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
											v_u_155.PrimaryPart.Anchored = false
											v_u_15.EnableRagdoll(v_u_155, 1.75)
										end
										p_u_123.Behavior.EnableVoidstar(p_u_123)
										p_u_123.Behavior.ToggleTendril(p_u_123, false)
									end)
									task.delay(0.5 + p_u_123.Config.VoidRushCutsceneLength, function()
										-- upvalues: (ref) p_u_123, (ref) v_u_18
										p_u_123.Rig:SetAttribute("VoidRushState", nil)
										p_u_123.Rig.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
										p_u_123.Rig.PrimaryPart.Anchored = false
										task.wait(0.5)
										v_u_18:RemoveInvincible(p_u_123.Rig, "Slam")
										p_u_123.AbilitiesDisabled = false
										p_u_123.DisabledAbilities = nil
									end)
									if v_u_125.Endlag then
										p_u_123:SetCooldownOf("VoidRush", p_u_123.Config.VoidRushC00ldown)
									end
								else
									local v177 = p_u_123.Config.VoidRushHitEndlag
									local v178 = p_u_123.Config.VoidRushComboWindow
									v_u_19:IncrementActorStats(p_u_123.Player, {
										["Action"] = "Hit player with Void Rush",
										["RewardType"] = "EasyKillerAction"
									})
									p_u_123.Rig:SetAttribute("VoidRushState", "Hit")
									v_u_17:FireClientConnection(p_u_123.Player, v_u_128, "REMOTE_EVENT", "Hit")
									p_u_123:SetCooldownOf("VoidRush", v177)
									v_u_13:ApplyStatus(v_u_155, "Hallucination", {
										["Duration"] = p_u_123.Config.VoidRushHallucinationDuration,
										["Level"] = v_u_147,
										["Killer"] = p_u_123
									})
									v_u_18:CreateSpeedMultiplier(v_u_155, 1.5, "HitSpeedBonus", 1.25)
									v_u_136(v177, true)
									v_u_125.Endlag = true
									p_u_123.WindowSound = v_u_133("Window")
									v_u_137.WeakHit:Play(0)
									p_u_123:PlayVoiceline("VoidRushWeakHit", {
										["Priority"] = 4
									})
									local v179 = v_u_133
									local v180 = p_u_123.Behavior.VoidRushCombo
									local v181 = math.clamp(v180, 1, 5)
									v179("WeakHit" .. tostring(v181))
									p_u_123.AbilitiesDisabled = false
									p_u_123.DisabledAbilities = {
										["Stab"] = true,
										["Nova"] = true,
										["Observant"] = true
									}
									v_u_125.EndlagComboThread = task.delay(v177 + v178, function()
										-- upvalues: (ref) v_u_125, (ref) p_u_123, (ref) v_u_17, (ref) v_u_128
										v_u_125.Endlag = nil
										p_u_123.AbilitiesDisabled = false
										p_u_123:SetCooldownOf("VoidRush", p_u_123.Config.VoidRushC00ldown)
										p_u_123.Behavior.EnableVoidstar(p_u_123)
										p_u_123.Behavior.ToggleTendril(p_u_123, false)
										p_u_123.DisabledAbilities = nil
										p_u_123.Rig:SetAttribute("VoidRushState", nil)
										v_u_17:FireClientConnection(p_u_123.Player, v_u_128, "REMOTE_EVENT", "WindowMiss")
									end)
								end
							elseif v_u_156 or (v_u_158 or (v_u_157 or (v_u_159 or v_u_160))) then
								v_u_136(p_u_123.Config.VoidRushMissEndlag)
								task.delay(p_u_123.Config.VoidRushMissEndlag, function()
									-- upvalues: (ref) p_u_123
									p_u_123.Behavior.EnableVoidstar(p_u_123)
									p_u_123.Behavior.ToggleTendril(p_u_123, false)
								end)
								p_u_123:SetCooldownOf("VoidRush", p_u_123.Config.VoidRushC00ldown)
								p_u_123.DisabledAbilities = nil
								p_u_123.Rig:SetAttribute("VoidRushState", v168)
								local v182 = "Miss_" .. v168
								v_u_17:FireClientConnection(p_u_123.Player, v_u_128, "REMOTE_EVENT", v182)
								if v_u_137["EndDash" .. v168] then
									v_u_137["EndDash" .. v168]:Play()
								else
									v_u_137.EndDash:Play()
								end
								v_u_133("Miss" .. v168)
								p_u_123:PlayVoiceline("VoidRushMiss" .. v168, {
									["Priority"] = 3
								})
							end
							v_u_150()
						end)
					end
				end)
				local v183 = {}
				local v184 = not v_u_125.Endlag
				if v184 then
					v184 = tick()
				end
				v183.SentTick = v184
				return v183
			end
			if v_u_4:IsClient() then
				local v185 = require(v_u_2.Systems.Character.Game.Sprinting)
				if p124 then
					p124 = p124.SentTick
				end
				v_u_17:FireConnection("DisableSprinting", "VoidRushCharging", true)
				if p124 then
					v185.StaminaCap = v185.Stamina + 1
					local v186 = false
					while v_u_4.Heartbeat:Wait() do
						if p_u_123.HeldAbilities.VoidRush or v186 then
							if p_u_123.Rig:GetAttribute("VoidRushState") ~= "Charging" then
								break
							end
						else
							v_u_17:FireServerConnection(v_u_127, "REMOTE_EVENT")
							v186 = true
						end
					end
				end
				if p_u_123.Rig:GetAttribute("VoidRushState") == "ChargingCancelled" then
					v_u_17:FireConnection("DisableSprinting", "VoidRushCharging", false)
					v185.StaminaCap = nil
					p_u_123.HeldAbilities.VoidRush = nil
					return
				end
				local v_u_187 = 0
				local v_u_188 = false
				local v189 = workspace.CurrentCamera.CFrame.LookVector
				local v190 = v189.X
				local v191 = v189.Z
				local v_u_192 = Vector3.new(v190, 0, v191).Unit
				local v_u_193 = Vector3.new(0, 0, 0)
				v_u_17:FireConnection("DisableSprinting", "VoidRushCharging", true)
				v185.StaminaCap = v185.Stamina + 1
				v_u_4:BindToRenderStep("VoidRushCharging", Enum.RenderPriority.Character.Value + 1, function(p194)
					-- upvalues: (ref) v_u_187, (copy) p_u_123, (ref) v_u_188, (ref) v_u_17, (copy) v_u_126, (ref) v_u_193, (ref) v_u_192, (ref) v_u_3
					v_u_187 = v_u_187 + p194
					if v_u_187 >= 0.3 and p_u_123.Rig.PrimaryPart.Velocity.Magnitude <= p_u_123.Config.VoidRushDashSpeed / 3.5 then
						if not v_u_188 then
							v_u_188 = true
							v_u_17:FireServerConnection(v_u_126, "REMOTE_EVENT", p_u_123.HeldAbilities.VoidRush)
						end
					else
						local v195 = p_u_123.Rig:FindFirstChild("SpeedMultipliers")
						if v195 then
							v195 = v195:FindFirstChild("VoidRushDash")
						end
						if v195 then
							local v196 = p_u_123.Config.VoidRushDashSpeed / p_u_123.Config.Speed
							local v197 = p194 * (p_u_123.HeldAbilities.VoidRush and 1 or -3) * 2 * v196
							local v198 = v195.Value + v197
							v195.Value = math.clamp(v198, 0, v196)
						end
						local v199 = workspace.CurrentCamera.CFrame.LookVector
						local v200 = v199.X
						local v201 = v199.Z
						v_u_193 = Vector3.new(v200, 0, v201).Unit
						local v202 = v_u_193 - v_u_192
						local v203 = v202.Magnitude
						if v203 > 0 then
							local v204 = p_u_123.Config.VoidRushInitialTurnDuration
							local v205 = p_u_123.Config.VoidRushInitialTurnMult * v_u_3:GetValue((v204 - v_u_187) / v204, Enum.EasingStyle.Sine, Enum.EasingDirection.In) + 1
							local v206 = p_u_123.Config.VoidRushTurnSpeed * p194 * v205
							if v203 <= v206 then
								v_u_192 = v_u_193
							else
								v_u_192 = v_u_192 + v202.Unit * v206
							end
							v_u_192 = v_u_192.Unit
						end
						p_u_123.Rig.Humanoid:Move(v_u_192)
					end
				end)
				while p_u_123 and (p_u_123.Rig and p_u_123.Rig:GetAttribute("VoidRushState") == "Dashing") do
					v_u_4.Heartbeat:Wait()
				end
				p_u_123.HeldAbilities.VoidRush = nil
				v185.StaminaCap = nil
				v_u_17:FireConnection("DisableSprinting", "VoidRushCharging", false)
				v_u_4:UnbindFromRenderStep("VoidRushCharging")
			end
		end
	},
	["Nova"] = {
		["LayoutOrder"] = 3,
		["Icon"] = "rbxassetid://70669903126039",
		["KeybindType"] = "AltAbility2",
		["Callback"] = function(p_u_207, p208)
			-- upvalues: (copy) v_u_4, (copy) v_u_18, (copy) v_u_14, (copy) v_u_16, (copy) v_u_17
			local _ = p_u_207.Behavior
			if v_u_4:IsServer() then
				if p_u_207.Behavior.Voidstar then
					p_u_207.AbilitiesDisabled = true
					task.delay(0.2, function()
						-- upvalues: (copy) p_u_207
						p_u_207.AbilitiesDisabled = false
					end)
					p_u_207:SetCooldownOf("Nova", p_u_207.Config.NovaCooldown)
					p_u_207.Behavior.DetonateVoidstar(p_u_207, p_u_207.Behavior.Voidstar, true)
					p_u_207.Behavior.Voidstar = nil
					p_u_207:PlayVoiceline("NovaDetonate", {
						["Priority"] = 4
					})
					return "Detonate"
				end
				local v209 = p_u_207.Config.NovaWindup
				v_u_18:CreateSpeedMultiplier(p_u_207.Rig, p_u_207.Config.NovaWindupSpeed, "NovaWindupSlowness", v209 + 0.3, true)
				p_u_207.AbilitiesDisabled = true
				p_u_207:SetCooldownOf("Nova", v209 + 0.2)
				v_u_14:Play(p_u_207.Config.Sounds.Nova, {
					["Parent"] = p_u_207.Rig.PrimaryPart,
					["RollOffMaxDistance"] = 50
				})
				p_u_207:PlayVoiceline("Nova", {
					["Priority"] = 3
				})
				task.delay(v209, function()
					-- upvalues: (copy) p_u_207, (ref) v_u_18, (ref) v_u_16, (ref) v_u_4
					if p_u_207.Rig:GetAttribute("Stunned") then
						p_u_207.AbilitiesDisabled = false
						return
					else
						p_u_207.Behavior.DisableVoidstar(p_u_207)
						local v210 = p_u_207.Rig.PrimaryPart
						if v210 then
							local v211 = p_u_207.Config.NovaProjectileSpeed
							local v212 = v210.CFrame
							local v213 = (p_u_207.Rig.Humanoid.HipHeight + v210.Size.Y / 2) / 2
							local v214 = v212 + Vector3.new(0, v213, 0)
							local _ = (p_u_207.Rig.PrimaryPart.CFrame * CFrame.new(0, 0, -20)).Position
							local v215
							if p_u_207.Player:GetAttribute("Device") == "Mobile" then
								v215 = v_u_18:GetPlayerMousePosition(p_u_207.Player, true)
							else
								v215 = v_u_18:GetPlayerMousePosition(p_u_207.Player)
							end
							local v216 = (v215 - p_u_207.Rig.PrimaryPart.Position).Unit
							local v217 = p_u_207.Config.NovaProjectile:Clone()
							v217.RootPriority = -2
							local v218 = RaycastParams.new()
							v218.RespectCanCollide = true
							v218.CollisionGroup = "Killers"
							v218.FilterType = Enum.RaycastFilterType.Exclude
							v218.FilterDescendantsInstances = { workspace.Players, v217 }
							local v219 = math.random(-15, 15)
							local v220 = math.random(-15, 15)
							local v221 = math.random
							local v222 = vector.create(v219, v220, v221(-15, 15))
							local v230 = {
								["Owner"] = p_u_207.Player,
								["HitboxConfig"] = {
									["Size"] = Vector3.new(3.5, 3.5, 3.5),
									["Damage"] = 0
								},
								["Lifetime"] = 4,
								["InitialCFrame"] = v214,
								["InitialVelocity"] = v216 * v211,
								["Model"] = v217,
								["CastParams"] = v218,
								["Callbacks"] = {
									["HitHuman"] = function(p223, _)
										-- upvalues: (ref) p_u_207
										p_u_207.Behavior.DetonateVoidstar(p_u_207, p223, false, true)
									end,
									["HitOther"] = function(p224, p225)
										-- upvalues: (ref) p_u_207
										local v226 = (Vector3.new(0, 1, 0)):Dot(p225.Normal)
										local v227 = math.acos(v226)
										local v228 = math.deg(v227) < p_u_207.Config.NovaFloorAngle
										p_u_207.Behavior.DetonateVoidstar(p_u_207, p224, v228)
									end,
									["Validate"] = function(_, p229)
										if p229 then
											p229 = p229.Instance
										end
										return (not p229 or p229.Transparency <= 0.9) and true or false
									end
								}
							}
							local v231 = {}
							local v232 = {
								["Rotation"] = {
									["rotation"] = v222
								}
							}
							v231.OnHeartbeat = v232
							v230.ClientCallbackData = v231
							local v_u_233 = v_u_16.new(v230)
							v_u_233:Launch()
							p_u_207.Behavior.Voidstar = v_u_233
							task.delay(0.2, function()
								-- upvalues: (ref) p_u_207
								p_u_207.AbilitiesDisabled = false
							end)
							local v_u_234 = nil
							v_u_234 = v_u_4.Heartbeat:Connect(function(_)
								-- upvalues: (copy) v_u_233, (ref) p_u_207, (ref) v_u_234
								if not v_u_233 or v_u_233.State ~= "Running" then
									if v_u_233 then
										v_u_233:Destroy()
									end
									p_u_207:SetCooldownOf("Nova", p_u_207.Config.NovaCooldown)
									p_u_207.Behavior.Voidstar = nil
									v_u_234:Disconnect()
									p_u_207.Behavior.EnableVoidstar(p_u_207)
									p_u_207.Behavior.ToggleTendril(p_u_207, false)
								end
							end)
						end
					end
				end)
				return "Throw"
			end
			if v_u_4:IsClient() then
				if p208 == "Detonate" then
					p_u_207.Animations.NovaDet:Play(0.175)
					return
				end
				p_u_207.Animations.NovaThrow:Play(0.175)
				v_u_17:FireConnection("DisableSprinting", "Nova", true)
				task.delay(p_u_207.Config.NovaWindup, function()
					-- upvalues: (ref) v_u_17
					v_u_17:FireConnection("DisableSprinting", "Nova", false)
				end)
			end
		end
	},
	["Observant"] = {
		["LayoutOrder"] = 4,
		["Icon"] = "rbxassetid://86665948552323",
		["KeybindType"] = "AltAbility3",
		["Callback"] = function(p_u_235, p236)
			-- upvalues: (copy) v_u_4, (copy) v_u_14, (copy) v_u_17, (copy) v_u_18, (copy) v_u_3
			if v_u_4:IsServer() then
				if p_u_235.Behavior.Observing then
					p_u_235:PlayVoiceline("ObservantOff", {
						["Priority"] = 4
					})
					v_u_14:Play(p_u_235.Config.Sounds.ObservantOff, {
						["Parent"] = p_u_235.Rig.PrimaryPart
					})
					p_u_235.Behavior.RevertObservance(p_u_235, false)
					p_u_235.Behavior.ToggleGeneratorAura(p_u_235, false)
					return {
						["Result"] = false
					}
				end
				p_u_235:PlayVoiceline("ObservantOn", {
					["Priority"] = 4
				})
				if workspace:FindFirstChild("Map") and (workspace.Map:FindFirstChild("Ingame") and workspace.Map.Ingame:FindFirstChild("Map")) then
					p_u_235.Behavior.ToggleObservantVFX(p_u_235, true)
					p_u_235.Behavior.ToggleGeneratorAura(p_u_235, true)
					v_u_14:Play(p_u_235.Config.Sounds.ObservantOn, {
						["Parent"] = p_u_235.Rig.PrimaryPart
					})
					p_u_235.Behavior.Observing = true
					p_u_235.DisabledAbilities = {
						["VoidRush"] = true,
						["Nova"] = true,
						["Stab"] = true
					}
					p_u_235.AbilitiesDisabled = true
					if p_u_235.ObservantConnection then
						p_u_235.ObservantConnection:Disconnect()
						p_u_235.ObservantConnection = nil
					end
					p_u_235.ObservantConnection = p_u_235.Rig:GetAttributeChangedSignal("Stunned"):Connect(function()
						-- upvalues: (copy) p_u_235, (ref) v_u_17
						if p_u_235.Rig:GetAttribute("Stunned") then
							p_u_235.Behavior.RevertObservance(p_u_235, false)
							p_u_235.Behavior.ToggleGeneratorAura(p_u_235, false)
							v_u_17:FireClientConnection(p_u_235.Player, ("%*ObservantTeleport"):format(p_u_235.Player.Name), "REMOTE_EVENT")
						end
					end)
					v_u_18:CreateSpeedMultiplier(p_u_235.Rig, p_u_235.Config.ObservantSpeed, "NoliObserving")
					task.delay(0.5, function()
						-- upvalues: (copy) p_u_235
						p_u_235.AbilitiesDisabled = false
					end)
					return {
						["Result"] = true
					}
				end
			elseif v_u_4:IsClient() then
				if not p236 then
					return
				end
				p_u_235.Behavior.Observing = p236.Result
				if p_u_235.Behavior.Observing then
					v_u_17:FireConnection("DisableSprinting", "NoliObserving", true)
					p_u_235.Animations.ObservantStart:Play(0.15)
					p_u_235.Animations.ObservantLoop:Play()
					local v_u_237 = RaycastParams.new()
					v_u_237.FilterDescendantsInstances = {}
					v_u_237.FilterType = Enum.RaycastFilterType.Include
					local v_u_238 = {}
					v_u_238.__index = v_u_238
					function v_u_238.new(p239, p240)
						-- upvalues: (copy) v_u_238, (ref) v_u_3, (ref) v_u_18, (copy) p_u_235
						local v241 = v_u_238
						local v_u_242 = setmetatable({}, v241)
						local v243 = p240.Size
						v_u_242.GarbageConnections = {}
						v_u_242.IsHovering = false
						v_u_242.Generator = p239
						v_u_242.Billboard = p240
						v_u_242.Button = p240.ImageButton
						v_u_242.EnterTween = v_u_3:Create(p240, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
							["Size"] = UDim2.new(v243.X.Scale * 1.2, v243.X.Offset * 1.2, v243.Y.Scale * 1.2, v243.Y.Offset * 1.2)
						})
						v_u_242.LeaveTween = v_u_3:Create(p240, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							["Size"] = v243
						})
						if v_u_18:GetSettingValue("EpilepsyMode", game.Players.LocalPlayer) and p_u_235.Config.isScreamerSensitive then
							if v_u_18:GetSettingValue("EpilepsyMode", game.Players.LocalPlayer) and p_u_235.Config.isScreamerSensitive then
								v_u_242.Button.Image = p_u_235.Config.SensitiveScreamerImage or "rbxassetid://89949595020859"
							end
						else
							v_u_242.Button:SetAttribute("Spritesheet", p_u_235.Config.ScreamerSpritesheet or "NoliLaugh")
							v_u_242.Button:SetAttribute("TimeScale", 0.35)
							v_u_242.Button:AddTag("Spritesheet")
						end
						v_u_242.Button.MouseEnter:Connect(function()
							-- upvalues: (copy) v_u_242
							v_u_242:OnMouseEntered()
						end)
						v_u_242.Button.MouseLeave:Connect(function()
							-- upvalues: (copy) v_u_242
							v_u_242:OnMouseLeft()
						end)
						v_u_242.Button.MouseButton1Down:Connect(function()
							-- upvalues: (copy) v_u_242
							v_u_242:OnClicked()
						end)
						local v244 = v_u_242.GarbageConnections
						local v245 = p240.AncestryChanged
						table.insert(v244, v245:Connect(function()
							-- upvalues: (copy) v_u_242
							v_u_242:Destroy()
						end))
						local v246 = v_u_242.GarbageConnections
						local v247 = p239.AncestryChanged
						table.insert(v246, v247:Connect(function()
							-- upvalues: (copy) v_u_242
							v_u_242:Destroy()
						end))
						return v_u_242
					end
					function v_u_238.OnMouseEntered(p248)
						if not p248.IsHovering then
							p248.IsHovering = true
							p248.EnterTween:Play()
							p248.Button:SetAttribute("TimeScale", 1)
						end
					end
					function v_u_238.OnMouseLeft(p249)
						if p249.IsHovering then
							p249.IsHovering = false
							p249.LeaveTween:Play()
							p249.Button:SetAttribute("TimeScale", 0.35)
						end
					end
					function v_u_238.OnClicked(p250)
						-- upvalues: (ref) v_u_17, (copy) p_u_235
						v_u_17:FireServerConnection(("%*ObservantTeleport"):format(p_u_235.Player.Name), "REMOTE_EVENT", p250.Generator)
					end
					function v_u_238.Destroy(p251)
						for _, v252 in ipairs(p251.GarbageConnections or {}) do
							v252:Disconnect()
						end
						if p251.Billboard then
							p251.Billboard:Destroy()
						end
						table.clear(p251)
					end
					local function v_u_256(p253)
						-- upvalues: (copy) p_u_235, (copy) v_u_238, (copy) v_u_237
						local v254 = p_u_235.Config.ObservantTeleportButton:Clone()
						v254.Parent = p_u_235.Player.PlayerGui
						v254.Adornee = p253
						local v255 = {
							["Button"] = v_u_238.new(p253, v254),
							["Instance"] = p253
						}
						p_u_235.Behavior.Generators[p253] = v255
						v_u_237:AddToFilter(p253)
					end
					p_u_235.Behavior.Generators = {}
					p_u_235.Behavior.AddedGeneratorConnection = workspace.Map.Ingame.Map.ChildAdded:Connect(function(p257)
						-- upvalues: (copy) v_u_256
						if p257.Name == "Generator" or p257.Name == "FakeGenerator" then
							v_u_256(p257)
						end
					end)
					for _, v258 in ipairs(workspace.Map.Ingame.Map:GetChildren()) do
						if v258.Name == "Generator" or v258.Name == "FakeGenerator" then
							v_u_256(v258)
						end
					end
					v_u_4:BindToRenderStep("ObservantTeleportValidation", 1, function()
						-- upvalues: (copy) p_u_235, (ref) v_u_4
						for v259, v260 in pairs(p_u_235.Behavior.Generators or {}) do
							if not p_u_235.Behavior.Generators then
								v_u_4:UnbindFromRenderStep("ObservantTeleportValidation")
								return
							end
							local v261 = (v259:GetPivot().Position - p_u_235.Rig.PrimaryPart.Position).Magnitude < p_u_235.Config.ObservantMinDistance
							local v262 = v260.Button.Button
							local v263 = v259:FindFirstChildOfClass("Highlight")
							local v264 = v261 and Enum.HighlightDepthMode.Occluded or Enum.HighlightDepthMode.AlwaysOnTop
							if v263.DepthMode ~= v264 then
								v263.DepthMode = v264
							end
							if v262:GetAttribute("Paused") ~= v261 then
								v262:SetAttribute("Paused", v261)
								if v261 then
									v260.Button:OnMouseLeft()
								end
							end
							local v265 = v261 and Color3.new(0.4, 0.4, 0.4) or Color3.new(1, 1, 1)
							if v262.ImageColor3 ~= v265 then
								v262.ImageColor3 = v265
							end
							local v266 = not v261
							if v262.Interactable ~= v266 then
								v262.Interactable = v266
							end
						end
					end)
					return
				end
				p_u_235.Behavior.RevertObservance(p_u_235, false)
			end
		end
	}
}
v10.Abilities = v267
function v10.ObservantUse(p_u_268, p269)
	-- upvalues: (copy) v_u_14, (copy) v_u_20, (copy) v_u_2, (copy) v_u_13, (copy) v_u_18, (copy) v_u_17
	if p269 then
		local v270 = p269:FindFirstChild("Positions")
		if v270 then
			v270 = p269.Positions:GetChildren()
		end
		local v_u_271 = v270 and p269.Positions.Center.CFrame or p269:GetPivot()
		p_u_268.Cache.Animations.Observant:Play()
		p_u_268.Behavior.ToggleGeneratorAura(p_u_268, false, p269)
		p_u_268.AbilitiesDisabled = true
		local v_u_272 = p_u_268.Behavior.ObservantWindupVFX(p_u_268)
		local function v_u_274()
			-- upvalues: (copy) v_u_272
			for _, v273 in ipairs(v_u_272 or {}) do
				v273:Destroy()
			end
		end
		local v_u_275 = v_u_14:Play(p_u_268.Config.Sounds.ObservantTeleportChannel, {
			["Parent"] = p_u_268.Rig.PrimaryPart,
			["RollOffMaxDistance"] = 45
		})
		local v_u_276 = nil
		local v_u_284 = task.delay(p_u_268.Config.ObservantTeleportWindup, function()
			-- upvalues: (copy) v_u_274, (copy) p_u_268, (ref) v_u_20, (copy) v_u_271, (ref) v_u_2, (ref) v_u_13, (ref) v_u_276
			v_u_274()
			p_u_268.Rig:SetAttribute("StunnedDisabled", true)
			local v_u_277 = v_u_20.StunProtection:Clone()
			v_u_277.Parent = p_u_268.Rig.PrimaryPart
			task.delay(1.5, function()
				-- upvalues: (ref) p_u_268, (ref) v_u_277
				p_u_268.Rig:SetAttribute("StunnedDisabled", nil)
				v_u_277.Spawn.Enabled = false
				game.Debris:AddItem(v_u_277, v_u_277.Spawn.Lifetime.Max)
			end)
			p_u_268.Behavior.Teleport(p_u_268, v_u_271)
			p_u_268:PlayVoiceline("Teleport", {
				["Priority"] = 5
			})
			local v278 = require(v_u_2.Modules.Actors)
			for _, v279 in pairs(v278.CurrentActors) do
				if v279.ActorType == "Survivor" and (v279.Rig and v279.Rig.PrimaryPart) then
					local v280 = (v_u_271.Position - v279.Rig.PrimaryPart.Position).Magnitude
					for v281, v282 in ipairs(p_u_268.Config.ObservantStatusThresholds) do
						if v280 < v282 then
							local v283 = v281 - 1
							if v283 > 0 then
								v_u_13:ApplyStatus(v279.Rig, "Hallucination", {
									["Level"] = v283,
									["Duration"] = p_u_268.Config.ObservantStatusDuration,
									["Killer"] = p_u_268
								})
							end
							break
						end
					end
				end
			end
			v_u_276:Disconnect()
		end)
		v_u_276 = p_u_268.Rig:GetAttributeChangedSignal("Stunned"):Connect(function()
			-- upvalues: (copy) p_u_268, (ref) v_u_276, (copy) v_u_284, (copy) v_u_274, (copy) v_u_275
			if p_u_268.Rig:GetAttribute("Stunned") then
				if v_u_276 then
					v_u_276:Disconnect()
				end
				task.cancel(v_u_284)
				v_u_274()
				if v_u_275 then
					v_u_275:Destroy()
				end
			end
		end)
		v_u_18:CreateSpeedMultiplier(p_u_268.Rig, 0, "ObservantTeleporting", p_u_268.Config.ObservantTeleportWindup + p_u_268.Config.ObservantTeleportEndlag, true)
		p_u_268.Behavior.RevertObservance(p_u_268, true)
		v_u_17:FireClientConnection(p_u_268.Player, ("%*ObservantTeleport"):format(p_u_268.Player.Name), "REMOTE_EVENT")
	end
end
function v10.DetonateVoidstar(p_u_285, p286, p287, p_u_288)
	-- upvalues: (copy) v_u_4, (copy) v_u_12, (copy) v_u_18, (copy) v_u_6, (copy) v_u_3, (copy) v_u_19, (copy) v_u_5, (copy) v_u_17
	local v289 = v_u_4:IsServer()
	assert(v289, "what are you doing")
	assert(p286, "no voidstar :(")
	local v290 = p286.State == "Running"
	assert(v290, "voidstar is already go boom boom")
	assert(p_u_285, "use dot notation when calling")
	p_u_285.Behavior.VoidstarExplosionVFX(p_u_285, p286.PreviousCFrame)
	local v_u_291 = p_u_285.Config.NovaExplosionRadius / (p287 and 1.5 or 1)
	local v_u_292 = p286.PreviousCFrame
	local v_u_293 = p_u_285.Config.NovaExplosionKnockback or 440
	v_u_12:CreateHitbox(p_u_285.Player, {
		["Size"] = Vector3.new(1, 1, 1) * v_u_291,
		["CFrame"] = v_u_292,
		["Damage"] = p_u_285.Config.NovaExplosionDamage,
		["Time"] = 0.1,
		["HitMultiple"] = true,
		["Knockback"] = 0,
		["ExecuteOnKill"] = false,
		["PredictVelocity"] = false,
		["Shape"] = Enum.PartType.Ball,
		["Connections"] = {
			["Hit"] = function(p294)
				-- upvalues: (ref) v_u_18, (copy) v_u_292, (copy) p_u_288, (copy) v_u_291, (ref) v_u_6, (copy) v_u_293, (ref) v_u_3, (copy) p_u_285, (ref) v_u_19
				local v_u_295 = p294.PrimaryPart
				local v296 = v_u_18:GetActor(p294)
				local v297 = v296 and (v296.GetPivot and v296:GetPivot()) or p294.PrimaryPart.CFrame
				local v298 = (v_u_292.Position - v297.Position).Magnitude
				local v299
				if p_u_288 then
					v299 = 1.35
				else
					local v300 = 1 - v298 / v_u_291
					v299 = math.clamp(v300, 0, 1)
				end
				local v301 = Instance.new("BodyPosition", v_u_295)
				v_u_6:AddItem(v301, 0.35)
				v301.Position = v_u_292.Position
				v301.MaxForce = Vector3.new(10000, 7000, 10000)
				v301.P = v_u_293 * 1500 * (v299 / 2 + 0.5)
				v301.D = 1200 - v_u_293
				task.delay(0.35, function()
					-- upvalues: (copy) v_u_295
					if v_u_295 then
						local v302 = v_u_295
						v302.AssemblyLinearVelocity = v302.AssemblyLinearVelocity / 1000
					end
				end)
				local v303 = 0.5 + v299
				v_u_3:Create(v_u_18:CreateSpeedMultiplier(p294, 0.4 - v299 / 4, "VoidstarExplosion", v303), TweenInfo.new(v303), {
					["Value"] = 1
				}):Play()
				v_u_19:IncrementActorStats(p_u_285.Player, {
					["Action"] = "Hit Survivor with Nova",
					["RewardType"] = "EasyKillerAction"
				})
			end
		}
	})
	for _, v304 in ipairs(v_u_5:GetPlayers()) do
		local v305 = v304.Character and v304.Character.PrimaryPart
		if v305 then
			v305 = v304.Character.PrimaryPart.Position
		end
		if v305 then
			v305 = (p286.PreviousCFrame.Position - v305).Magnitude
		end
		local v306 = p_u_285.Config.NovaExplosionRadius * 2
		if v305 and v305 < v306 then
			local v307 = v_u_17
			local v308 = v306 - v305
			v307:FireClientConnection(v304, "ApplyCameraShake", "REMOTE_EVENT", math.clamp(v308, 0, v306) / v306 * 0.5, 0.7)
		end
	end
	p286:Destroy()
end
function v10.RevertObservance(p_u_309, p310)
	-- upvalues: (copy) v_u_4, (copy) v_u_18, (copy) v_u_17
	if v_u_4:IsServer() then
		p_u_309.Behavior.ToggleObservantVFX(p_u_309, false)
		if p_u_309.Behavior.Observing then
			if p_u_309.ObservantConnection then
				p_u_309.ObservantConnection:Disconnect()
				p_u_309.ObservantConnection = nil
			end
			v_u_4:UnbindFromRenderStep("ObservantTeleportValidation")
			p_u_309.Behavior.Observing = false
			p_u_309:SetCooldownOf("Observant", p_u_309.Config.ObservantC00ldown / (p310 and 1 or 2))
			p_u_309.DisabledAbilities = nil
			p_u_309.AbilitiesDisabled = true
			v_u_18:CreateSpeedMultiplier(p_u_309.Rig, 1, "NoliObserving", 0)
			task.delay(p310 and (p_u_309.Config.ObservantTeleportWindup + p_u_309.Config.ObservantTeleportEndlag or 0.5) or 0.5, function()
				-- upvalues: (copy) p_u_309
				p_u_309.AbilitiesDisabled = false
			end)
		end
	else
		if v_u_4:IsClient() then
			if not p_u_309.Behavior.Generators then
				return
			end
			p_u_309.Animations.ObservantStart:Stop(0.15)
			p_u_309.Animations.ObservantLoop:Stop(0.15)
			for _, v311 in pairs(p_u_309.Behavior.Generators or {}) do
				if v311.Button then
					v311.Button:Destroy()
				end
			end
			table.clear(p_u_309.Behavior.Generators)
			p_u_309.Behavior.Generators = nil
			if p_u_309.Behavior.AddedGeneratorConnection then
				p_u_309.Behavior.AddedGeneratorConnection:Disconnect()
			end
			v_u_17:FireConnection("DisableSprinting", "NoliObserving", false)
		end
		return
	end
end
function v10.VoidstarExplosionVFX(p312, p313)
	-- upvalues: (copy) v_u_18, (copy) v_u_14
	local v314 = p312.Config.NovaProjectile:FindFirstChild("Explosion")
	if v314 and v314.ClassName == "Attachment" then
		local v315 = v314:Clone()
		v315.Parent = workspace.Terrain
		v315.WorldCFrame = p313
		v_u_18:EmitParticles(v315)
		v_u_14:Play(p312.Config.Sounds.Explosion, {
			["Parent"] = v315,
			["RollOffMaxDistance"] = 60
		})
		game.Debris:AddItem(v315, 6)
	end
end
function v10.Teleport(p316, p317)
	-- upvalues: (copy) v_u_6, (copy) v_u_18
	if typeof(p317) == "Vector3" then
		p317 = CFrame.new(p317) or p317
	end
	local function v321(p318)
		local v319 = RaycastParams.new()
		v319.CollisionGroup = "Killers"
		v319.FilterDescendantsInstances = { workspace.Map.Ingame }
		v319.FilterType = Enum.RaycastFilterType.Include
		v319.RespectCanCollide = true
		local v320 = workspace:Raycast(p318, Vector3.new(0, -10, 0), v319)
		return v320 and v320.Position or p318 - Vector3.new(0, 10, 0)
	end
	local v322 = p316.Config.ObservantTeleportVFX
	if v322 then
		if v322:FindFirstChild("In") then
			local v323 = v322.In:Clone()
			v323.Position = v321(p316.Rig.PrimaryPart.Position) + Vector3.new(0, 0.06, 0)
			v323.Parent = workspace.Map.Ingame
			v_u_6:AddItem(v323, 6)
			v_u_18:EmitParticles(v323)
		end
		if v322:FindFirstChild("Out") then
			local v324 = p316.Config.ObservantTeleportVFX.Out:Clone()
			v324.Position = v321(p317.Position) + Vector3.new(0, 0.06, 0)
			v324.Parent = workspace.Map.Ingame
			v_u_6:AddItem(v324, 6)
			v_u_18:EmitParticles(v324)
		end
	end
	for _, v325 in ipairs(p316.Cache.Trails or {}) do
		v325.Enabled = false
		v325:Clear()
	end
	p316.Rig.PrimaryPart.CFrame = p317
	for _, v326 in ipairs(p316.Cache.Trails or {}) do
		v326.Enabled = true
	end
end
function v10.ObservantWindupVFX(p327)
	-- upvalues: (copy) v_u_3
	local v_u_328 = {}
	local v329 = {}
	local v330 = {
		["Glitch1"] = 0.25,
		["Glitch2"] = 0.75,
		["Star"] = 1.06
	}
	if p327.Rig:FindFirstChild("Noli") then
		for _, v331 in ipairs(p327.Config.ObservantTeleportVFX.BodyParts:GetChildren()) do
			if v331:IsA("ParticleEmitter") then
				for _, v332 in ipairs(p327.Rig.Noli:GetChildren()) do
					if v332:IsA("BasePart") then
						local v333 = v331:Clone()
						v333.Parent = v332
						v333.Enabled = false
						table.insert(v329, v333)
						v_u_328[v333.Name] = v_u_328[v333.Name] or {}
						local v334 = v_u_328[v333.Name]
						table.insert(v334, v333)
					end
				end
			end
		end
	end
	for v_u_335, v336 in pairs(v330) do
		task.delay(v336, function()
			-- upvalues: (copy) v_u_328, (copy) v_u_335
			for _, v337 in ipairs(v_u_328[v_u_335] or {}) do
				if not (v337 and v337.Parent) then
					return
				end
				v337.Enabled = true
			end
		end)
	end
	local v338 = p327.Config.ObservantTeleportVFX.BodyParts.Highlight:Clone()
	v338.Parent = p327.Rig
	v338.Enabled = true
	v_u_3:Create(v338, TweenInfo.new(p327.Config.ObservantTeleportWindup, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		["FillTransparency"] = 3
	}):Play()
	table.insert(v329, v338)
	return v329
end
function v10.ToggleObservantVFX(p339, p340)
	if p339.Rig.PrimaryPart then
		local v341 = p339.Rig:FindFirstChild("Noli")
		if v341 then
			v341 = p339.Rig.Noli:FindFirstChild("Glow")
		end
		local v342
		if v341 then
			v342 = v341:FindFirstChild("HalluMouth")
		else
			v342 = v341
		end
		if v341 then
			v341 = v341:FindFirstChild("HalluEye")
		end
		if v342 and v341 then
			v342:FindFirstChildOfClass("Beam").Enabled = p340
			v341:FindFirstChildOfClass("Beam").Enabled = p340
		end
	end
end
function v10.ToggleGeneratorAura(p_u_343, p344, p345)
	-- upvalues: (copy) v_u_4, (copy) v_u_14, (copy) v_u_3
	local v346 = v_u_4:IsServer()
	assert(v346, "what are you doing")
	local v347 = workspace.Map.Ingame:FindFirstChild("Map")
	local v_u_348 = ("%*NoliWarning"):format(p_u_343.Player.Name)
	local v349 = ("%*NoliAura"):format(p_u_343.Player.Name)
	if v347 then
		for _, v_u_350 in ipairs(v347:GetChildren()) do
			if v_u_350.Name == "Generator" or v_u_350.Name == "FakeGenerator" then
				if p344 then
					local v351 = p_u_343.Config.ObservantWarningTemplate:Clone()
					v351.Name = v_u_348
					v351.CFrame = v_u_350:GetPivot()
					v351.Parent = v_u_350
					local v352 = p_u_343.Config.ObservantHighlightTemplate:Clone()
					v352.Parent = v_u_350
					v352.Name = v349
					v352:AddTag(p_u_343.Player.Name .. "GenHighlight")
					v_u_14:Play(p_u_343.Config.Sounds.ObservantGeneratorStart, {
						["Parent"] = v351,
						["Name"] = "AuraWarningSound",
						["RollOffMaxDistance"] = 30
					})
					v_u_14:Play(p_u_343.Config.Sounds.ObservantGeneratorLoop, {
						["Parent"] = v351,
						["Name"] = "AuraWarningSound",
						["Looped"] = true,
						["RollOffMaxDistance"] = 30
					})
				else
					local v353 = p345 == v_u_350
					local v354 = v_u_350:FindFirstChild(v_u_348)
					local v_u_355 = v_u_350:FindFirstChild(v349)
					if v354 and v_u_355 then
						v354.Name = v354.Name .. "_Done"
						v_u_355.Name = v_u_355.Name .. "_Done"
						while v354:FindFirstChild("AuraWarningSound") do
							v354.AuraWarningSound:Destroy()
						end
						v_u_14:Play(p_u_343.Config.Sounds[v353 and "ObservantGeneratorWarning" or "ObservantGeneratorEnd"], {
							["Parent"] = v354,
							["Name"] = "AuraDisappear",
							["RollOffMaxDistance"] = 45
						})
						if v353 then
							task.spawn(function()
								-- upvalues: (copy) p_u_343, (copy) v_u_348, (copy) v_u_350, (copy) v_u_355
								local v356 = p_u_343.Config.ObservantIncomingTemplate:Clone()
								v356.Name = v_u_348 .. "Incoming"
								v356.CFrame = v_u_350:GetPivot()
								v356.Parent = v_u_350
								game.Debris:AddItem(v356, 5)
								task.wait(p_u_343.Config.ObservantTeleportWindup)
								for _, v357 in ipairs(v356:GetDescendants()) do
									if v357:IsA("ParticleEmitter") then
										v357.Enabled = false
									end
								end
								v_u_355:Destroy()
							end)
						else
							v_u_3:Create(v_u_355, TweenInfo.new(0.7), {
								["FillTransparency"] = 1,
								["OutlineTransparency"] = 1
							}):Play()
							game.Debris:AddItem(v_u_355, 1)
						end
						for _, v358 in ipairs(v354:GetDescendants()) do
							if v358:IsA("ParticleEmitter") then
								v358.Enabled = false
							end
						end
						game.Debris:AddItem(v354, 5)
					else
						warn("nope")
					end
				end
			end
		end
	end
end
function v10.ToggleTendril(p359, p360)
	local v361 = p359.Rig["Right Arm"]:FindFirstChild("TentacleBase")
	if v361 then
		for _, v362 in ipairs(v361:GetDescendants()) do
			if v362:IsA("Beam") or (v362:IsA("ParticleEmitter") or v362:IsA("Trail")) then
				v362.Enabled = p360
			end
		end
	end
end
function v10.EnableVoidstar(p363)
	-- upvalues: (copy) v_u_18, (copy) v_u_14
	assert(p363, "must pass killerInfo as argument")
	if not p363.Behavior.VoidstarEnabled then
		p363.Behavior.VoidstarEnabled = true
		local v364 = p363.Rig
		if v364 then
			v364 = v364:FindFirstChild("Voidstar")
		end
		if v364 then
			v364.Transparency = 0
			v364.Main.Main.Enabled = true
			v_u_18:EmitParticles(v_u_18:MergeTables({ v364.Appear1, v364.Appear2 }, v364.AppearT:GetChildren()))
			v_u_14:Play(p363.Config.Sounds.VoidstarEnable, {
				["Parent"] = v364,
				["Volume"] = 0.2,
				["RollOffMaxDistance"] = 13
			})
		end
	end
end
function v10.DisableVoidstar(p365)
	assert(p365, "must pass killerInfo as argument")
	if p365.Behavior.VoidstarEnabled then
		p365.Behavior.VoidstarEnabled = false
		local v366 = p365.Rig
		if v366 then
			v366 = v366:FindFirstChild("Voidstar")
		end
		if v366 then
			v366.Main.Main.Enabled = false
			v366.Main.Main:Clear()
			v366.Transparency = 1
		end
	end
end
return v10
