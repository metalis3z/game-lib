-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local v1 = game:GetService("ServerStorage")
local v_u_2 = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Players")
local v_u_6 = game:GetService("Debris")
local v_u_7 = require(script.Classes.VoidRushUI)
local v8 = {}
local v_u_9 = require(v_u_2.Modules.Schematics.Lighting)
local v_u_10 = require(game.ReplicatedStorage.Modules.Hitboxes)
local v_u_11 = require(game.ReplicatedStorage.Modules.Statuses)
local v_u_12 = require(game.ReplicatedStorage.Modules.Sounds)
require(v_u_2.Modules.Ragdolls)
local v_u_13 = require(v_u_2.Modules.Network)
local v_u_14 = require(game.ReplicatedStorage.Modules.Util)
require(v_u_2.Modules.Device)
require(v_u_2.Modules.Items)
require(v_u_2.Modules.Misc.RadialImage)
local v_u_15 = require(game.ReplicatedStorage.Modules.Actors)
--local v_u_16 = v_u_4:IsServer()
--if v_u_16 then
--	v_u_16 = require(v1.ServerSystems.ActorHandler)
--end
local v_u_17 = v_u_2.Assets.UI.StunProtectionVFX
function v8.Created(_, p_u_18)
	-- upvalues: (copy) v_u_4, (copy) v_u_14, (copy) v_u_13, (copy) v_u_16, (copy) v_u_12, (copy) v_u_17, (copy) v_u_2, (copy) v_u_11, (copy) v_u_5, (copy) v_u_7
	if v_u_4:IsServer() then
		p_u_18.Behavior.VoidstarEnabled = true
		p_u_18.Behavior.VoidRushCombo = 0
		if not p_u_18.Cache then
			p_u_18.Cache = {}
		end
		p_u_18.Cache.Animations = {
			["VoidRush"] = {}
		}
		for v19, v20 in pairs(p_u_18.Config.Animations.VoidRush) do
			p_u_18.Cache.Animations.VoidRush[v19] = v_u_14:LoadAnimationFromID(p_u_18.Rig, v20)
		end
		local v_u_21 = v_u_14:LoadAnimationFromID(p_u_18.Rig, p_u_18.Config.Animations.ObservantTeleport)
		v_u_13:SetConnection(("%*ObservantTeleport"):format(p_u_18.Player.Name), "REMOTE_EVENT", function(p22, p23)
			-- upvalues: (copy) p_u_18, (ref) v_u_16, (copy) v_u_21, (ref) v_u_12, (ref) v_u_17, (ref) v_u_2, (ref) v_u_11, (ref) v_u_14, (ref) v_u_13
			local v24 = workspace.Map.Ingame:FindFirstChild("Map")
			if v24 then
				if p22 == p_u_18.Player and (p23:IsDescendantOf(v24) and (p23:IsA("Model") and p23.Name:find("Generator"))) then
					if (p23:GetPivot().Position - p_u_18.Rig.PrimaryPart.Position).Magnitude >= p_u_18.Config.ObservantMinDistance then
						--if p_u_18.Behavior.Observing and (v_u_16:CanUseAbility(p_u_18, "Observant") and p23) then
							local v25 = p23:FindFirstChild("Positions")
							if v25 then
								v25 = p23.Positions:GetChildren()
							end
							local v_u_26 = v25 and p23.Positions.Center.CFrame or p23:GetPivot()
							v_u_21:Play()
							p_u_18.Behavior.ToggleGeneratorAura(p_u_18, false, p23)
							p_u_18.AbilitiesDisabled = true
							local v_u_27 = v_u_12:Play(p_u_18.Config.Sounds.ObservantTeleportChannel, {
								["Parent"] = p_u_18.Rig.PrimaryPart
							})
							local v_u_28 = nil
							local v_u_36 = task.delay(p_u_18.Config.ObservantTeleportWindup, function()
								-- upvalues: (ref) p_u_18, (ref) v_u_17, (copy) v_u_26, (ref) v_u_2, (ref) v_u_11, (ref) v_u_28
								p_u_18.Rig:SetAttribute("StunnedDisabled", true)
								local v_u_29 = v_u_17.StunProtection:Clone()
								v_u_29.Parent = p_u_18.Rig.PrimaryPart
								task.delay(1.5, function()
									-- upvalues: (ref) p_u_18, (ref) v_u_29
									p_u_18.Rig:SetAttribute("StunnedDisabled", nil)
									v_u_29.Spawn.Enabled = false
									game.Debris:AddItem(v_u_29, v_u_29.Spawn.Lifetime.Max)
								end)
								p_u_18.Behavior.Teleport(p_u_18, v_u_26)
								local startVFX : Instance = p_u_18.Config.ObservantEndVFX:Clone()
								startVFX.Parent = workspace.Map.Ingame
								startVFX.CFrame = CFrame.new(p23:GetPivot().Position - Vector3.new(0, 1.8, 0))
								for i, v in ipairs(startVFX:GetDescendants()) do
									if v:IsA("ParticleEmitter") then
										v:Emit(v:GetAttribute("EmitCount"))
									end
								end
								task.delay(5, function()
									startVFX:Destroy()
								end)
								local v30 = require(v_u_2.Modules.Actors)
								for _, v31 in pairs(v30.CurrentActors) do
									if v31.ActorType == "Survivor" and (v31.Rig and v31.Rig.PrimaryPart) then
										local v32 = (v_u_26.Position - v31.Rig.PrimaryPart.Position).Magnitude
										for v33, v34 in ipairs(p_u_18.Config.ObservantStatusThresholds) do
											if v32 < v34 then
												local v35 = v33 - 1
												if v35 > 0 then
													v_u_11:ApplyStatus(v31.Rig, "Hallucination", {
														["Level"] = v35,
														["Duration"] = p_u_18.Config.ObservantStatusDuration,
														["Killer"] = p_u_18
													})
												end
												break
											end
										end
									end
								end
								v_u_28:Disconnect()
							end)
							v_u_28 = p_u_18.Rig:GetAttributeChangedSignal("Stunned"):Connect(function()
								-- upvalues: (ref) p_u_18, (ref) v_u_28, (copy) v_u_36, (copy) v_u_27
								if p_u_18.Rig:GetAttribute("Stunned") then
									if v_u_28 then
										v_u_28:Disconnect()
									end
									task.cancel(v_u_36)
									if v_u_27 then
										v_u_27:Destroy()
									end
								end
							end)
							v_u_14:CreateSpeedMultiplier(p_u_18.Rig, 0, "ObservantTeleporting", p_u_18.Config.ObservantTeleportWindup + p_u_18.Config.ObservantTeleportEndlag, true)
							p_u_18.Behavior.RevertObservance(p_u_18, true)
							v_u_13:FireClientConnection(p_u_18.Player, ("%*ObservantTeleport"):format(p_u_18.Player.Name), "REMOTE_EVENT")
						--end
					end
				else
					p22:Kick("\n\nPranksterComet 100:\nInvalid Connection Arguments [ObservantTeleport]\n")
					return
				end
			else
				return
			end
		end)
		local v_u_37 = {
			["TOOKDAMAGE"] = {},
			["KILLED"] = {}
		}
		v_u_13:SetConnection(("%*CloneEvent"):format(p_u_18.Player.Name), "REMOTE_EVENT", function(p38, p39)
			-- upvalues: (ref) v_u_2, (copy) v_u_37, (ref) v_u_11, (copy) p_u_18, (ref) v_u_14
			local v40 = require(v_u_2.Modules.StatusEffects.KillerExclusive.Hallucination.HallucinationClass.FakeNoli)
			if not v_u_37[p39] then
				p38:Kick("\n\nPranksterComet 150:\nInvalid Connection Arguments [CloneEvent]\n")
			end
			local v41 = v_u_37[p39] or {}
			local v42 = p38.Character
			local v43
			if v42 then
				v43 = v42.PrimaryPart
			else
				v43 = v42
			end
			local v44 = v_u_11:PlayerHasStatus(p38, "Hallucination")
			if v44 then
				v44 = v44.Level >= v40.ApplyAt
			end
			local v45 = v41[p38]
			if v45 then
				v45 = tick() - v41[p38] < p_u_18.Config.StabCooldown - 0.2
			end
			if v42 and (v43 and (v44 and not v45)) then
				v41[p38] = tick()
				if p39 == "TOOKDAMAGE" then
					v_u_14:ApplyDamage(p38.Character, p_u_18.Config.HallucinationCloneDamage)
					return
				end
				if p39 == "KILLED" and workspace.Hitboxes:FindFirstChild(p38.Name .. "Hitbox") then
					v_u_11:RemoveStatus(p38, "Hallucination")
				end
			end
		end)
		if not v_u_4:IsStudio() then
			p_u_18:SetCooldownOf("Observant", p_u_18.Config.ObservantC00ldown)
		end
		task.spawn(function()
			-- upvalues: (copy) p_u_18
			p_u_18.Behavior.FakeGenerators = {}
			while true do
				task.wait(1)
				local v46 = workspace.Map.Ingame:FindFirstChild("Map")
				local v47
				if v46 then
					v47 = v46:FindFirstChild("GeneratorPositions")
				else
					v47 = v46
				end
				if v47 and v47:FindFirstChildOfClass("CFrameValue") or not (p_u_18 and p_u_18.Behavior.FakeGenerators) then
					local v48 = p_u_18
					if v48 then
						v48 = p_u_18.Behavior.FakeGenerators
					end
					if v46 and v48 then
						local v49 = {}
						for _, v50 in ipairs(v47:GetChildren()) do
							if v50:IsA("CFrameValue") and v50:GetAttribute("Occupied") == nil then
								table.insert(v49, v50)
							end
						end
						if #v49 >= 1 then
							local v51 = #v49
							for _ = 1, math.min(v51, 2) do
								local v52 = math.random(1, #v49)
								local v53 = v49[v52]
								local v54 = script.FakeGenerator:Clone()
								v54:SetPrimaryPartCFrame(v53.Value)
								v54.Parent = v46
								v54.Remotes.BE.Event:Connect(function(p55, p56)
									-- upvalues: (ref) p_u_18
									local v57 = require(game.ReplicatedStorage.Modules.Statuses)
									local v58 = v57:PlayerHasStatus(p55, "Hallucination")
									local v59 = {}
									local v60 = (v58 and v58.Level or 0) + (p56 >= 100 and 3 or 1)
									local level = math.clamp(v60, 1, 3)
									v59.Level = level
									v59.Duration = 15
									v59.Killer = p_u_18
									v57:ApplyStatus(p55, "Hallucination", v59)
									if p56 >= 100 then
										task.spawn(function()
											local scaryaura : Highlight = p_u_18.Config.ObservantHighlightTemplate:Clone()
											scaryaura.FillTransparency = 1
											scaryaura.Parent = v54
											v_u_3:Create(scaryaura, TweenInfo.new(1), {FillTransparency = 3}):Play()
											v_u_3:Create(v54.Instances.Generator.Progress.BarUI.Bar, TweenInfo.new(1), {BackgroundColor3 = Color3.fromRGB(150, 255, 50)}):Play()
											local warning = p_u_18.Config.ObservantWarningTemplate:Clone()
											warning.Parent = v54
											warning.CFrame = v54:GetPivot()
											local sound = v_u_12:Play(p_u_18.Config.Sounds.ObservantGeneratorLoop, {
												Parent = v54.Main
											})
											local prompt = v54.Main.Prompt
											prompt.Parent = game.ServerStorage.Assets.Miscellaneous.TemporaryData
											task.wait(1)
											task.wait(0.5)
											for i, v in ipairs(warning:GetDescendants()) do
												if v:IsA("ParticleEmitter") then
													v.Enabled = false
												end
											end
											if sound and typeof(sound) == "Instance" then
												sound:Destroy()
											end
											v_u_3:Create(scaryaura, TweenInfo.new(1), {FillTransparency = 1}):Play()
											v_u_3:Create(v54.Progress, TweenInfo.new(1), {Value = 0}):Play()
											v_u_3:Create(v54.Instances.Generator.Progress.BarUI.Bar, TweenInfo.new(1), {BackgroundColor3 = Color3.fromRGB(50, 255, 50)}):Play()
											task.wait(1)
											scaryaura:Destroy()
											warning:Destroy()
											v54:SetAttribute("Completed", nil)
											prompt.Parent = v54.Main
										end)
									end
								end)
								for _, v61 in ipairs(v54.Scripts:GetChildren()) do
									if v61:IsA("BaseScript") then
										v61.Enabled = true
									end
								end
								table.insert(v48, v54)
								table.remove(v49, v52)
								v53:Destroy()
							end
						end
					else
						return
					end
				end
			end
		end)
	elseif v_u_4:IsClient() and v_u_5.LocalPlayer == p_u_18.Player then
		v_u_13:SetConnection(("%*VoidRushUpdateUI"):format(p_u_18.Player.Name), "REMOTE_EVENT", function(p62)
			-- upvalues: (ref) v_u_7, (copy) p_u_18
			local v_u_63 = p62 == "Create" and v_u_7.new(p_u_18) or p_u_18.Behavior.VoidRushUI
			if v_u_63 then
				v_u_63.Counter = (v_u_63.Counter or 0) + 1
				if p62 == "Create" then
					p_u_18.Behavior.VoidRushUI = v_u_63
					v_u_63.Blinking = false
					v_u_63:TweenRadial(p_u_18.Config.VoidRushChargeLength, 0, 1)
					v_u_63:SetText("Charge Void Rush by holding down")
					return
				elseif p62 == "ChargeFail" then
					v_u_63.Blinking = false
					v_u_63:SetText(p_u_18.Config.VoidRushStopMessages.FailedToCharge)
					v_u_63:FadeOut(2, false)
					return
				elseif p62 == "Dash" then
					v_u_63.BlinkSpeed = 0.25
					v_u_63.Blinking = true
					v_u_63:TweenRadial(p_u_18.Config.VoidRushDashLength, 1, 0)
					v_u_63:SetText("Release the Void Rush button to cancel")
					return
				elseif p62 == "Hit" then
					v_u_63.Blinking = false
					local v_u_64 = v_u_63.Counter
					v_u_63:SetText(p_u_18.Config.VoidRushStopMessages.Hit)
					v_u_63:TweenRadial(p_u_18.Config.VoidRushHitEndlag, 0, 1)
					task.delay(p_u_18.Config.VoidRushHitEndlag, function()
						-- upvalues: (copy) v_u_63, (copy) v_u_64, (ref) p_u_18
						if v_u_63 and v_u_64 == v_u_63.Counter then
							v_u_63:TweenRadial(p_u_18.Config.VoidRushComboWindow, 1, 0)
						end
					end)
					return
				elseif p62 == "WindowMiss" then
					v_u_63.Blinking = false
					v_u_63:SetText(p_u_18.Config.VoidRushStopMessages.WindowMissed)
					v_u_63:FadeOut(2, false)
					return
				elseif p62:match("Miss_") then
					v_u_63.Blinking = false
					local v65 = p62:sub(6, p62:len())
					v_u_63:SetText(p_u_18.Config.VoidRushStopMessages[v65])
					v_u_63:FadeOut(2, v65 == "HitLarge")
				else
					warn("Invalid server subroutine string", p62)
				end
			else
				warn("Noli client had no UI")
				return
			end
		end)
		v_u_13:SetConnection(("%*ObservantTeleport"):format(p_u_18.Player.Name), "REMOTE_EVENT", function()
			-- upvalues: (copy) p_u_18
			p_u_18.Behavior.RevertObservance(p_u_18)
		end)
	end
end
function v8.Destroyed(_, p66)
	-- upvalues: (copy) v_u_4, (copy) v_u_13, (copy) v_u_5
	if v_u_4:IsServer() then
		p66.Behavior.RevertObservance(p66, false)
		p66.Behavior.ToggleGeneratorAura(p66, false)
		v_u_13:RemoveConnection(("%*ObservantTeleport"):format(p66.Player.Name), "REMOTE_EVENT")
		v_u_13:RemoveConnection(("%*CloneEvent"):format(p66.Player.Name), "REMOTE_EVENT")
		for _, v67 in ipairs(p66.Behavior.FakeGenerators or {}) do
			v67:Destroy()
		end
		p66.Behavior.FakeGenerators = nil
	elseif v_u_4:IsClient() and v_u_5.LocalPlayer == p66.Player then
		v_u_13:RemoveConnection(("%*VoidRushUpdateUI"):format(p66.Player.Name), "REMOTE_EVENT")
		v_u_13:RemoveConnection(("%*ObservantTeleport"):format(p66.Player.Name), "REMOTE_EVENT")
		if p66.Behavior.VoidRushUI then
			p66.Behavior.VoidRushUI:Destroy()
		end
	end
end
function v8.OnIntroduction(_, p68, p_u_69, p70)
	-- upvalues: (copy) v_u_9, (copy) v_u_14, (copy) v_u_5
	v_u_9:SetCustomLighting(p68.Config.IntroLighting)
	if p_u_69:FindFirstChild("FakeCrown") then
		p_u_69.FakeCrown.Transparency = 0
		p_u_69.Voidstar.Transparency = 1
		p_u_69.VoidstarCrown.Transparency = 1
	else
		warn("THIS LOSER HAS NO FAKE CROWN!!!!")
	end
	local v_u_71 = workspace.Misc:FindFirstChild("KillerCutsceneBackground")
	local v_u_72 = true
	task.spawn(function()
		-- upvalues: (ref) v_u_72, (copy) v_u_71
		while v_u_72 do
			for v73, v74 in pairs(v_u_71.Voidstars:GetChildren()) do
				v74.CFrame = v74.CFrame * CFrame.Angles(0, v73 % 2 == 0 and 0.0225 or -0.0225, 0)
			end
			task.wait()
		end
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_72, (copy) v_u_71
		while v_u_72 do
			local v75 = v_u_71.Skybox
			v75.CFrame = v75.CFrame * CFrame.Angles(0, 0.004363323129985824, 0)
			task.wait()
		end
	end)
	local v_u_76 = v_u_14:CreateFOVMultiplier(v_u_5.LocalPlayer, 0.375, "NoliIntroScene", p70)
	task.delay(1.98, function()
		-- upvalues: (copy) v_u_76
		v_u_76.Value = 0.275
	end)
	task.delay(p70, function()
		-- upvalues: (ref) v_u_72, (copy) p_u_69, (ref) v_u_9
		v_u_72 = false
		if p_u_69:FindFirstChild("FakeCrown") then
			p_u_69.FakeCrown.Transparency = 1
		end
		p_u_69.VoidstarCrown.Transparency = 0
		p_u_69.Voidstar.Transparency = 0
		v_u_9:SetAsCurrentLighting()
	end)
end
function v8.OnVictory(_, p77, p_u_78, p_u_79, p80)
	-- upvalues: (copy) v_u_9, (copy) v_u_4, (copy) v_u_3, (copy) v_u_14, (copy) v_u_5
	if p77 == "Start" then
		v_u_9:SetCustomLighting(p_u_78.Config.OutroLighting)
		local v_u_81 = p_u_78.Config.OutroFrameData
		local v82 = p_u_78.Cache.VictoryKillerTrack
		local v_u_83 = p_u_78.Cache.VictoryCameraTrack
		local v_u_84 = {}
		local v_u_85 = Instance.new("ScreenGui")
		v_u_85.Name = "NoliOutroOverlay"
		v_u_85.ResetOnSpawn = false
		v_u_85.IgnoreGuiInset = true
		v_u_85.Parent = game.Players.LocalPlayer.PlayerGui
		v82.Stopped:Once(function()
			-- upvalues: (copy) p_u_79
			if p_u_79 then
				p_u_79:PivotTo(p_u_79:GetPivot() + Vector3.new(0, -20, 0))
			end
		end)
		local function v_u_88(p86)
			-- upvalues: (copy) v_u_84
			for _, v87 in ipairs(p86:GetDescendants()) do
				if v87:IsA("ParticleEmitter") then
					warn("caching", v87.Name)
					v_u_84[v87.Name] = v87
				end
			end
		end
		for _, v89 in ipairs(p_u_79:GetDescendants()) do
			if v89:IsA("Sound") then
				v89:Destroy()
			end
		end
		--game.Players.LocalPlayer:SetAttribute("FOVMultipliersDisabled", true)
		local v_u_92 = v_u_4.RenderStepped:Connect(function()
			-- upvalues: (copy) v_u_83, (copy) v_u_81
			local v90 = (v_u_83.TimePosition + 0.001) * 60
			local v91 = math.ceil(v90)
			if v_u_81.CameraFOV and v_u_81.CameraFOV[v91] then
				workspace.CurrentCamera.FieldOfView = v_u_81.CameraFOV[v91] or v_u_81.CameraFOV[#v_u_81.CameraFOV]
			end
		end)
		local v_u_96 = v82:GetMarkerReachedSignal("EmitParticle"):Connect(function(p93)
			-- upvalues: (copy) v_u_84
			print(v_u_84)
			local v94 = v_u_84[p93]
			print("SIGNAL REACHED: " .. tostring(p93))
			local v95 = v94:GetAttribute("EmitCount")
			if v95 then
				v94:Emit(v95)
			else
				v94.Enabled = not v94.Enabled
			end
		end)
		task.spawn(function()
			-- upvalues: (copy) v_u_88
			print("waiting for killer background")
			local v97 = workspace.Misc:WaitForChild("KillerCutsceneBackground", 3)
			print(v97 == nil and "killer background not found" or typeof(v97) == "Instance" and "killer background found" or "killer background i have no idea")
			if v97 then
				v_u_88(v97.Map.ExplosionGround)
			end
		end)
		print("killer cam rig: should start searching")
		task.spawn(function()
			-- upvalues: (copy) p_u_78, (copy) v_u_88
			local v98 = workspace.Misc:WaitForChild(p_u_78.Player.Name .. "CameraRig", 3)
			if v98 then
				v_u_88(v98)
			end
		end)
		task.delay(3.22, function()
			-- upvalues: (copy) v_u_85, (copy) p_u_79, (ref) v_u_3, (ref) v_u_14
			local v99 = Instance.new("Frame", v_u_85)
			v99.Size = UDim2.new(10, 0, 10, 0)
			v99.AnchorPoint = Vector2.new(0.5, 0.5)
			v99.Position = UDim2.new(0.5, 0, 0.5, 0)
			v99.BackgroundTransparency = 1
			v99.BackgroundColor3 = Color3.new(0, 0, 0)
			local v100 = Instance.new("Highlight")
			v100.FillTransparency = 1
			v100.OutlineTransparency = 1
			v100.OutlineColor = Color3.new(0.4, 0, 1)
			v100.Parent = p_u_79
			game.Debris:AddItem(v100, 3)
			local v101 = Instance.new("ColorCorrectionEffect")
			v101.Parent = game.Lighting
			v101.Name = "NoliBoomCC"
			game.Debris:AddItem(v101, 3)
			local v102 = v_u_3:Create(v101, TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
				["TintColor"] = Color3.fromRGB(125, 66, 155),
				["Brightness"] = -0.1,
				["Contrast"] = 0.5
			})
			v102:Play()
			v_u_3:Create(v100, TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, true, 0), {
				["OutlineTransparency"] = 0.1
			}):Play()
			task.wait(0.65)
			v_u_14:ApplyCameraShake(0.2, 1.2)
			v102:Pause()
			v101.Contrast = 1
			v101.Brightness = 2.8
			v101.TintColor = Color3.fromRGB(70, 0, 155)
			v_u_3:Create(v101, TweenInfo.new(1.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				["Brightness"] = -0.6,
				["TintColor"] = Color3.new(0.623529, 0.623529, 0.623529),
				["Contrast"] = -0.5
			}):Play()
			task.wait(1.1)
			if v99 then
				v_u_3:Create(v99, TweenInfo.new(0.2), {
					["BackgroundTransparency"] = 0,
					["BackgroundColor3"] = Color3.new(0, 0, 0)
				}):Play()
			end
		end)
		task.delay(p80, function()
			-- upvalues: (copy) v_u_92, (copy) v_u_96
			v_u_92:Disconnect()
			v_u_96:Disconnect()
		end)
	elseif p77 == "End" then
		v_u_5.LocalPlayer:SetAttribute("FOVMultipliersDisabled", nil)
		v_u_9:SetAsCurrentLighting()
		if v_u_5.LocalPlayer.PlayerGui:FindFirstChild("NoliOutroOverlay") then
			v_u_5.LocalPlayer.PlayerGui.NoliOutroOverlay:Destroy()
		end
		local v103 = game.Lighting:WaitForChild("NoliBoomCC", 9)
		if v103 then
			v103:Destroy()
		end
	end
end
function v8.OnExecution(_, p104, p_u_105)
	-- upvalues: (copy) v_u_3, (copy) v_u_13
	local v_u_106 = p104.Rig
	v_u_106.Voidstar.Transparency = 1
	task.delay(2.2, function()
		-- upvalues: (ref) v_u_3, (copy) v_u_106
		v_u_3:Create(v_u_106.Voidstar, TweenInfo.new(0.25), {
			["Transparency"] = 0
		}):Play()
		task.wait(1)
		v_u_3:Create(v_u_106.Voidstar, TweenInfo.new(0.25), {
			["Transparency"] = 1
		}):Play()
		task.wait(1)
		v_u_3:Create(v_u_106.Voidstar, TweenInfo.new(0.25), {
			["Transparency"] = 0
		}):Play()
	end)
	v_u_13:FireAllClientConnection("Ragdoll", "REMOTE_EVENT", p_u_105, workspace:GetServerTimeNow() + 2.425, (("%*|%*|%*"):format((Vector3.new(0, 400, 0)).X, (Vector3.new(0, 400, 0)).Y, (Vector3.new(0, 400, 0)).Z)))
	task.delay(2.4, function()
		-- upvalues: (copy) p_u_105, (copy) v_u_106
		local v107 = p_u_105:FindFirstChild("Head")
		local v108 = p_u_105:FindFirstChild("Humanoid")
		if v108 then
			v108.BreakJointsOnDeath = false
			v108.Health = 0
			if v107 then
				v107:Destroy()
			end
			for _, v109 in ipairs(v_u_106.Voidstar.Crush:GetChildren()) do
				if v109:IsA("ParticleEmitter") then
					v109.Enabled = true
				end
			end
			task.delay(0.125, function()
				-- upvalues: (ref) v_u_106
				for _, v110 in ipairs(v_u_106.Voidstar.Crush:GetChildren()) do
					if v110:IsA("ParticleEmitter") then
						v110.Enabled = false
					end
				end
			end)
		end
	end)
end
local v239 = {
	["Stab"] = {
		["LayoutOrder"] = 1,
		["Icon"] = "rbxassetid://93874368032471",
		["KeybindType"] = "MainAbility",
		["Callback"] = function(p_u_111, _)
			-- upvalues: (copy) v_u_4, (copy) v_u_12, (copy) v_u_10, (copy) v_u_14, (copy) v_u_11
			if v_u_4:IsServer() then
				p_u_111.AbilitiesDisabled = true
				v_u_12:Play(p_u_111.Config.Sounds.Swing, {
					["Parent"] = p_u_111.Rig.PrimaryPart,
					["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
					["Volume"] = 0.25
				})
				p_u_111.Behavior.DisableVoidstar(p_u_111)
				task.delay(p_u_111.Config.StabWindup, function()
					-- upvalues: (ref) v_u_10, (copy) p_u_111, (ref) v_u_14, (ref) v_u_12, (ref) v_u_11
					local v112 = v_u_10
					local v113 = p_u_111.Player
					local v116 = {
						["Size"] = Vector3.new(4.5, 6, 7.5),
						["CFrameOffset"] = CFrame.new(0, 0, -2.5),
						["Damage"] = p_u_111.Config.StabDamage,
						["Time"] = 0.25,
						["Knockback"] = 2,
						["HitMultiple"] = false,
						["ExecuteOnKill"] = true,
						["Connections"] = {
							["Hit"] = function(p114, p115)
								-- upvalues: (ref) v_u_14, (ref) v_u_12, (ref) p_u_111, (ref) v_u_11
								v_u_14:CreateSpeedMultiplier(p114, 1.5, "HitSpeedBonus", 1.25)
								if p115 then
									v_u_12:Play(p_u_111.Config.Sounds.Hit, {
										["Parent"] = p_u_111.Rig.PrimaryPart,
										["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
										["Volume"] = 0.25
									})
								end
								v_u_11:RemoveStatus(p114, "Hallucination")
							end
						}
					}
					v112:CreateHitbox(v113, v116)
				end)
				task.delay(p_u_111.Config.StabEndlag, function()
					-- upvalues: (copy) p_u_111
					p_u_111.AbilitiesDisabled = false
					p_u_111.Behavior.EnableVoidstar(p_u_111)
				end)
			elseif v_u_4:IsClient() then
				p_u_111.Animations.Stab:Play(0.175)
			end
		end
	},
	["VoidRush"] = {
		["LayoutOrder"] = 2,
		["Icon"] = "rbxassetid://93874368032471",
		["KeybindType"] = "AltAbility1",
		["FlavorText"] = "[Hold]",
		["Callback"] = function(p_u_117, p118)
			-- upvalues: (copy) v_u_12, (copy) v_u_4, (copy) v_u_14, (copy) v_u_13, (copy) v_u_10, (copy) v_u_3, (copy) v_u_11, (copy) v_u_15, (copy) v_u_2
			local v_u_119 = p_u_117.Behavior
			local v_u_120 = ("%*VoidRushCollision"):format(p_u_117.Player.Name)
			local v_u_121 = ("%*VoidRushCancel"):format(p_u_117.Player.Name)
			local v_u_122 = ("%*VoidRushUpdateUI"):format(p_u_117.Player.Name)
			local function v_u_126(p123)
				-- upvalues: (copy) p_u_117, (ref) v_u_12
				local v124 = p_u_117.Config.Sounds
				local v125 = v124[("VoidRush%*"):format(p123)] or v124[p123]
				if v125 then
					return v_u_12:Play(v125, {
						["Parent"] = p_u_117.Rig.PrimaryPart,
						["PlaybackSpeed"] = Random.new():NextNumber(0.975, 1.025),
						["Volume"] = 0.85
					})
				end
			end
			if v_u_4:IsServer() then
				local function v_u_129(p127, p128)
					-- upvalues: (copy) p_u_117, (ref) v_u_14, (copy) v_u_119
					p_u_117.AbilitiesDisabled = true
					v_u_14:CreateSpeedMultiplier(p_u_117.Rig, 0.6, "VoidRushEndlag", p127 + (p128 and p_u_117.Config.VoidRushComboWindow or 0))
					v_u_119.EndlagTick = p128 and tick() or nil
					v_u_119.EndlagDuration = p127
					if not p128 then
						task.delay(p127, function()
							-- upvalues: (ref) p_u_117
							p_u_117.AbilitiesDisabled = false
						end)
					end
				end
				local v_u_130 = p_u_117.Cache.Animations.VoidRush
				local v_u_131 = v_u_119.EndlagTick
				if v_u_131 then
					v_u_131 = tick() - v_u_119.EndlagTick < v_u_119.EndlagDuration + p_u_117.Config.VoidRushComboWindow
				end
				p_u_117.AbilitiesDisabled = true
				p_u_117.Behavior.DisableVoidstar(p_u_117)
				task.spawn(function()
					-- upvalues: (copy) v_u_131, (ref) v_u_13, (copy) p_u_117, (copy) v_u_122, (copy) v_u_130, (copy) v_u_126, (ref) v_u_14, (copy) v_u_121, (ref) v_u_4, (ref) v_u_12, (copy) v_u_119, (ref) v_u_10, (copy) v_u_120, (ref) v_u_3, (ref) v_u_11, (ref) v_u_15, (copy) v_u_129
					if not v_u_131 then
						v_u_13:FireClientConnection(p_u_117.Player, v_u_122, "REMOTE_EVENT", "Create")
						local v132 = 0
						local v_u_133 = false
						v_u_130.StartCharge:Play(0.15)
						v_u_130.LoopCharge:Play(0.2)
						v_u_126("Start")
						v_u_126("Loop")
						local v134 = v_u_14:CreateSpeedMultiplier(p_u_117.Rig, p_u_117.Config.VoidRushChargingSpeed, "VoidRushCharging", p_u_117.Config.VoidRushChargeLength)
						p_u_117.Rig:SetAttribute("VoidRushState", "Charging")
						v_u_13:SetConnection(v_u_121, "REMOTE_EVENT", function()
							-- upvalues: (ref) v_u_133
							v_u_133 = true
						end)
						p_u_117.Behavior.VoidRushCombo = 0
						local v135 = v_u_133
						repeat
							v132 = v132 + v_u_4.Heartbeat:Wait()
							v135 = p_u_117.Rig:GetAttribute("Stunned") and true or v135
						until p_u_117.Config.VoidRushChargeLength <= v132 or v135
						v_u_13:RemoveConnection(v_u_121)
						v_u_130.StartCharge:Stop()
						v_u_130.LoopCharge:Stop()
						v134:Destroy()
						if v135 then
							p_u_117:SetCooldownOf("VoidRush", p_u_117.Config.VoidRushC00ldown / 4)
							p_u_117.Rig:SetAttribute("VoidRushState", "ChargingCancelled")
							v_u_130.CancelCharge:Play(0.15)
							v_u_126("Cancel")
							v_u_13:FireClientConnection(p_u_117.Player, v_u_122, "REMOTE_EVENT", "ChargeFail")
							task.delay(0.2, function()
								-- upvalues: (ref) p_u_117
								p_u_117.Behavior.EnableVoidstar(p_u_117)
								p_u_117.AbilitiesDisabled = false
								p_u_117.DisabledAbilities = nil
								p_u_117.Rig:SetAttribute("VoidRushState", nil)
							end)
							return
						end
					end
					p_u_117.VoidRushChargingSound = v_u_12:Play(p_u_117.Config.Sounds.VoidRushDashLoop, {
						["Parent"] = p_u_117.Rig.PrimaryPart,
						["Looped"] = true,
						["RollOffMaxDistance"] = 50
					})
					local v136 = p_u_117.Config.VoidRushDashSpeed
					local v137 = v_u_131 and "Combo" or "Init"
					local v138 = p_u_117.Config.VoidRushDashLength
					local v_u_139 = p_u_117.Config.VoidRushHallucinationLevel
					local v_u_140 = v_u_14:CreateSpeedMultiplier(p_u_117.Rig, v136 / p_u_117.Config.Speed, "VoidRushDash")
					local function v_u_142()
						-- upvalues: (ref) v_u_130
						for _, v141 in ipairs({
							"StartDashInit",
							"LoopDashCombo",
							"LoopDashInit",
							"StartDashCombo"
						}) do
							if v_u_130[v141] then
								v_u_130[v141]:Stop()
							end
						end
					end
					v_u_142()
					v_u_130[("StartDash%*"):format(v137)]:Play(0.05)
					v_u_130[("LoopDash%*"):format(v137)]:Play(0.05)
					local v143 = v_u_131 and 2 or 1
					v_u_126("Dash" .. tostring(v143))
					if v_u_119.EndlagComboThread then
						task.cancel(v_u_119.EndlagComboThread)
						v_u_119.EndlagComboThread = nil
					end
					local v144 = p_u_117.Behavior
					v144.VoidRushCombo = v144.VoidRushCombo + 1
					local v_u_145 = nil
					local v_u_146 = nil
					local v_u_147 = nil
					local v_u_148 = nil
					local v_u_149 = nil
					local v_u_150 = nil
					p_u_117.Rig:GetAttributeChangedSignal("Stunned"):Once(function()
						-- upvalues: (ref) v_u_148
						v_u_148 = true
					end)
					local v_u_152 = v_u_10:CreateHitbox(p_u_117.Player, {
						["Size"] = Vector3.new(6, 6, 4),
						["Damage"] = p_u_117.Config.VoidRushBaseDamage,
						["CFrameOffset"] = CFrame.new(0, 0, -2),
						["Time"] = v138,
						["Knockback"] = 5,
						["HitMultiple"] = false,
						["ExecuteOnKill"] = false,
						["Connections"] = {
							["Hit"] = function(p151)
								-- upvalues: (ref) v_u_145, (ref) v_u_150
								if p151:IsDescendantOf(workspace.Players) then
									v_u_145 = p151
								else
									v_u_150 = p151
									warn("NO! UNACCEPTABLE!")
								end
							end,
							["Ended"] = function()
								-- upvalues: (ref) v_u_146
								v_u_146 = true
							end
						}
					})
					local v_u_153 = require(game.ReplicatedStorage.Modules.Network)
					v_u_153:SetConnection(v_u_120, "REMOTE_EVENT", function(_, p154)
						-- upvalues: (ref) v_u_147, (ref) v_u_149
						v_u_147 = p154
						v_u_149 = true
					end)
					v_u_14:CreateSpeedMultiplier(p_u_117.Rig, 1, "VoidRushEndlag", 0)
					v_u_14:CreateSpeedMultiplier(p_u_117.Rig, 1, "VoidRushCharging", 0)
					p_u_117.Rig:SetAttribute("VoidRushState", "Dashing")
					v_u_13:FireClientConnection(p_u_117.Player, v_u_122, "REMOTE_EVENT", "Dash")
					task.spawn(function()
						-- upvalues: (ref) v_u_145, (ref) v_u_146, (ref) v_u_148, (ref) v_u_147, (ref) v_u_149, (ref) v_u_150, (ref) p_u_117, (copy) v_u_140, (copy) v_u_153, (ref) v_u_120, (copy) v_u_152, (ref) v_u_3, (ref) v_u_11, (copy) v_u_139, (ref) v_u_15, (ref) v_u_14, (ref) v_u_126, (ref) v_u_130, (ref) v_u_13, (ref) v_u_122, (ref) v_u_12, (ref) v_u_10, (ref) v_u_131, (ref) v_u_129, (ref) v_u_119, (copy) v_u_142
						repeat
							task.wait()
						until v_u_145 or (v_u_146 or (v_u_148 or (v_u_147 or (v_u_149 or (v_u_150 or not p_u_117.Rig.PrimaryPart)))))
						warn("we\'ve hit something....", v_u_150)
						local v155 = v_u_146 and "Timeout" or (v_u_148 and "Stunned" or (v_u_147 and "Crashed" or (v_u_150 and "NonChar" or "Cancelled")))
						v_u_140:Destroy()
						v_u_153:RemoveConnection(v_u_120, "REMOTE_EVENT")
						v_u_152:Cancel()
						if p_u_117.VoidRushChargingSound then
							local v156 = p_u_117.VoidRushChargingSound
							p_u_117.VoidRushChargingSound = nil
							v_u_3:Create(v156, TweenInfo.new(0.4), {
								["PlaybackSpeed"] = 0,
								["Volume"] = v156.Volume / 5
							}):Play()
							game.Debris:AddItem(v156, 0.5)
						end
						if v_u_145 then
							local v157 = v_u_11:PlayerHasStatus(v_u_145, "Hallucination")
							if v157 and (v157.Data and v_u_139 <= v157.Data.Level) then
								v_u_11:RemoveStatus(v_u_145, "Hallucination")
								p_u_117:SetCooldownOf("VoidRush", p_u_117.Config.VoidRushC00ldown)
								v_u_15:IncrementActorStats(p_u_117.Player, {
									["Action"] = "Slammed Survivor with Void Rush",
									["RewardType"] = "RegularKillerAction"
								})
								v_u_14:SetUpCutscene(p_u_117.Rig, v_u_145, CFrame.new(0, 0.01, 0))
								v_u_126("Cutscene")
								p_u_117.Rig:SetAttribute("Invincible", true)
								local v158 = v_u_130.CutsceneKillerRig
								v158:Play(0)
								v158.TimePosition = 0
								local v159 = v_u_14:LoadAnimationFromID(v_u_145, p_u_117.Config.Animations.VoidRushVictimRig, true)
								v159:Play(0.05)
								v159.TimePosition = v158.TimePosition
								p_u_117.Rig:SetAttribute("VoidRushState", "HitLarge")
								v_u_13:FireClientConnection(p_u_117.Player, v_u_122, "REMOTE_EVENT", "Miss_HitLarge")
								task.spawn(function()
									-- upvalues: (ref) v_u_12, (ref) p_u_117, (ref) v_u_145, (ref) v_u_10
									task.wait(0.5)
									v_u_12:PlayVoiceline(p_u_117, "Slam", {
										["Priority"] = 8
									})
									if v_u_145 then
										v_u_10:CreateHitbox(p_u_117.Player, {
											["Size"] = Vector3.new(4, 4, 4),
											["CFrameOffset"] = CFrame.new(0, 0, -2.25),
											["Damage"] = p_u_117.Config.VoidRushSlamDamage,
											["Time"] = 0.1,
											["Knockback"] = 0,
											["HitMultiple"] = true,
											["PredictVelocity"] = false,
											["ExecuteOnKill"] = false,
											["Connections"] = {}
										})
										local v160 = RaycastParams.new()
										v160.FilterDescendantsInstances = workspace.Players:GetDescendants()
										v160.FilterType = Enum.RaycastFilterType.Exclude
										local v161 = p_u_117.Rig.PrimaryPart.Position
										local v162 = p_u_117.Rig.PrimaryPart.CFrame.LookVector * 3 + Vector3.new(0, 1, 0)
										local v163 = workspace:Raycast(v161, v162, v160)
										v_u_145:SetPrimaryPartCFrame(CFrame.new(v163 and v163.Position or v161 + v162))
										v_u_145.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
										v_u_145.PrimaryPart.Anchored = false
										local v164 = require(game.ReplicatedStorage.Modules.Ragdolls)
										if v_u_145.Humanoid.Health <= 0 then
											local v165 = workspace:GetServerTimeNow()
											require(game.ReplicatedStorage.Modules.Network):FireAllClientConnection("Ragdoll", "REMOTE_EVENT", v_u_145, v165, (("%*|%*|%*"):format((Vector3.new(0, 0, 0)).X, (Vector3.new(0, 0, 0)).Y, (Vector3.new(0, 0, 0)).Z)))
										else
											v164:Enable(v_u_145)
											task.wait(1.75)
											v164:Disable(v_u_145)
										end
									end
									p_u_117.Behavior.EnableVoidstar(p_u_117)
									task.wait(p_u_117.Config.VoidRushCutsceneLength)
									p_u_117.Rig:SetAttribute("VoidRushState", nil)
									p_u_117.Rig:SetAttribute("Invincible", nil)
									p_u_117.AbilitiesDisabled = false
									p_u_117.DisabledAbilities = nil
									p_u_117.Rig.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
									p_u_117.Rig.PrimaryPart.Anchored = false
								end)
								if v_u_131 then
									p_u_117:SetCooldownOf("VoidRush", p_u_117.Config.VoidRushC00ldown)
								end
							else
								local v166 = p_u_117.Config.VoidRushHitEndlag
								local v167 = p_u_117.Config.VoidRushComboWindow
								v_u_15:IncrementActorStats(p_u_117.Player, {
									["Action"] = "Hit player with Void Rush",
									["RewardType"] = "EasyKillerAction"
								})
								p_u_117.Rig:SetAttribute("VoidRushState", "Hit")
								v_u_13:FireClientConnection(p_u_117.Player, v_u_122, "REMOTE_EVENT", "Hit")
								p_u_117:SetCooldownOf("VoidRush", v166)
								v_u_11:ApplyStatus(v_u_145, "Hallucination", {
									["Duration"] = p_u_117.Config.VoidRushHallucinationDuration,
									["Level"] = v_u_139,
									["Killer"] = p_u_117
								})
								v_u_14:CreateSpeedMultiplier(v_u_145, 1.5, "HitSpeedBonus", 1.25)
								v_u_129(v166, true)
								v_u_130.WeakHit:Play(0)
								local v168 = v_u_126
								local v169 = p_u_117.Behavior.VoidRushCombo
								local v170 = math.clamp(v169, 1, 6)
								v168("WeakHit" .. tostring(v170))
								p_u_117.AbilitiesDisabled = false
								p_u_117.DisabledAbilities = {
									["Stab"] = true,
									["Nova"] = true,
									["Observant"] = true
								}
								v_u_119.EndlagComboThread = task.delay(v166 + v167, function()
									-- upvalues: (ref) p_u_117, (ref) v_u_13, (ref) v_u_122
									p_u_117:SetCooldownOf("VoidRush", p_u_117.Config.VoidRushC00ldown)
									p_u_117.Behavior.EnableVoidstar(p_u_117)
									p_u_117.AbilitiesDisabled = false
									p_u_117.DisabledAbilities = nil
									p_u_117.Rig:SetAttribute("VoidRushState", nil)
									v_u_13:FireClientConnection(p_u_117.Player, v_u_122, "REMOTE_EVENT", "WindowMiss")
								end)
							end
						elseif v_u_146 or (v_u_148 or (v_u_147 or (v_u_149 or v_u_150))) then
							v_u_129(p_u_117.Config.VoidRushMissEndlag)
							task.delay(p_u_117.Config.VoidRushMissEndlag, function()
								-- upvalues: (ref) p_u_117
								p_u_117.Behavior.EnableVoidstar(p_u_117)
							end)
							p_u_117:SetCooldownOf("VoidRush", p_u_117.Config.VoidRushC00ldown)
							p_u_117.DisabledAbilities = nil
							p_u_117.Rig:SetAttribute("VoidRushState", v155)
							local v171 = "Miss_" .. v155
							v_u_13:FireClientConnection(p_u_117.Player, v_u_122, "REMOTE_EVENT", v171)
							v_u_130.EndDash:Play()
							v_u_126("Miss" .. v155)
						end
						v_u_142()
					end)
				end)
				local v172 = {}
				local v173 = not v_u_131
				if v173 then
					v173 = tick()
				end
				v172.SentTick = v173
				return v172
			end
			if v_u_4:IsClient() then
				local v174 = require(v_u_2.Systems.Character.Game.Sprinting)
				if p118 then
					p118 = p118.SentTick
				end
				v_u_13:FireConnection("DisableSprinting", "VoidRushCharging", true)
				if p118 then
					v174.StaminaCap = v174.Stamina + 1
					local v175 = false
					while v_u_4.Heartbeat:Wait() do
						if p_u_117.HeldAbilities.VoidRush or v175 then
							if p_u_117.Rig:GetAttribute("VoidRushState") ~= "Charging" then
								break
							end
						else
							v_u_13:FireServerConnection(v_u_121, "REMOTE_EVENT")
							v175 = true
						end
					end
				end
				if p_u_117.Rig:GetAttribute("VoidRushState") == "ChargingCancelled" then
					v_u_13:FireConnection("DisableSprinting", "VoidRushCharging", false)
					v174.StaminaCap = nil
					return
				end
				local v_u_176 = 0
				local v_u_177 = false
				local v178 = workspace.CurrentCamera.CFrame.LookVector
				local v179 = v178.X
				local v180 = v178.Z
				local v_u_181 = Vector3.new(v179, 0, v180).Unit
				local v_u_182 = Vector3.new(0, 0, 0)
				v_u_13:FireConnection("DisableSprinting", "VoidRushCharging", true)
				v174.StaminaCap = v174.Stamina + 1
				v_u_4:BindToRenderStep("VoidRushCharging", Enum.RenderPriority.Character.Value + 1, function(p183)
					-- upvalues: (ref) v_u_176, (copy) p_u_117, (ref) v_u_177, (ref) v_u_13, (copy) v_u_120, (ref) v_u_182, (ref) v_u_181, (ref) v_u_3
					v_u_176 = v_u_176 + p183
					if v_u_176 >= 0.3 and p_u_117.Rig.PrimaryPart.Velocity.Magnitude <= p_u_117.Config.VoidRushDashSpeed / 3 then
						if not v_u_177 then
							v_u_177 = true
							v_u_13:FireServerConnection(v_u_120, "REMOTE_EVENT", p_u_117.HeldAbilities.VoidRush)
						end
					else
						local v184 = p_u_117.Rig:FindFirstChild("SpeedMultipliers")
						if v184 then
							v184 = v184:FindFirstChild("VoidRushDash")
						end
						if v184 then
							local v185 = p_u_117.Config.VoidRushDashSpeed / p_u_117.Config.Speed
							local v186 = p183 * (p_u_117.HeldAbilities.VoidRush and 1 or -1) * 2 * v185
							local v187 = v184.Value + v186
							v184.Value = math.clamp(v187, 0, v185)
						end
						local v188 = workspace.CurrentCamera.CFrame.LookVector
						local v189 = v188.X
						local v190 = v188.Z
						v_u_182 = Vector3.new(v189, 0, v190).Unit
						local v191 = v_u_182 - v_u_181
						local v192 = v191.Magnitude
						if v192 > 0 then
							local v193 = p_u_117.Config.VoidRushInitialTurnDuration
							local v194 = p_u_117.Config.VoidRushInitialTurnMult * v_u_3:GetValue((v193 - v_u_176) / v193, Enum.EasingStyle.Sine, Enum.EasingDirection.In) + 1
							local v195 = p_u_117.Config.VoidRushTurnSpeed * p183 * v194
							if v192 <= v195 then
								v_u_181 = v_u_182
							else
								v_u_181 = v_u_181 + v191.Unit * v195
							end
							v_u_181 = v_u_181.Unit
						end
						p_u_117.Rig.Humanoid:Move(v_u_181)
					end
				end)
				while v_u_4.Heartbeat:Wait() and (p_u_117 and (p_u_117.Rig and p_u_117.Rig:GetAttribute("VoidRushState") == "Dashing")) do

				end
				v174.StaminaCap = nil
				v_u_13:FireConnection("DisableSprinting", "VoidRushCharging", false)
				v_u_4:UnbindFromRenderStep("VoidRushCharging")
			end
		end
	},
	["Nova"] = {
		["LayoutOrder"] = 3,
		["Icon"] = "rbxassetid://93874368032471",
		["KeybindType"] = "AltAbility2",
		["Callback"] = function(p_u_196, p197)
			-- upvalues: (copy) v_u_4, (copy) v_u_14, (copy) v_u_12, (copy) v_u_10, (copy) v_u_13
			local _ = p_u_196.Behavior
			if v_u_4:IsServer() then
				print("NOVA")
				if p_u_196.Behavior.Voidstar then
					print("DETONATE")
					p_u_196.Behavior.DetonateVoidstar(p_u_196, p_u_196.Behavior.Voidstar, true)
					p_u_196:SetCooldownOf("Nova", p_u_196.Config.NovaCooldown)
					p_u_196.Behavior.Voidstar = nil
					return "Detonate"
				end
				print("THROW")
				local v198 = p_u_196.Config.NovaWindup
				v_u_14:CreateSpeedMultiplier(p_u_196.Rig, p_u_196.Config.NovaWindupSpeed, "NovaWindupSlowness", v198 + 0.3, true)
				local v_u_199 = false
				p_u_196.AbilitiesDisabled = true
				p_u_196:SetCooldownOf("Nova", v198 + 0.2)
				task.delay(v198 + 0.2, function()
					-- upvalues: (copy) p_u_196
					p_u_196.AbilitiesDisabled = false
				end)
				v_u_12:Play(p_u_196.Config.Sounds.Nova, {
					["Parent"] = p_u_196.Rig.PrimaryPart
				})
				task.delay(v198, function()
					-- upvalues: (copy) p_u_196, (ref) v_u_199, (ref) v_u_14, (ref) v_u_10, (ref) v_u_4, (ref) v_u_12
					if p_u_196.Rig:GetAttribute("Stunned") then
						v_u_199 = true
					else
						p_u_196.Behavior.DisableVoidstar(p_u_196)
						local v200 = p_u_196.Rig.PrimaryPart
						local v_u_201 = p_u_196.Config.NovaMaxRange
						local v_u_202 = p_u_196.Config.NovaProjectileSpeed
						local v203 = v200.Position
						local v204 = (p_u_196.Rig.Humanoid.HipHeight + v200.Size.Y / 2) / 2
						local v_u_205 = v203 + Vector3.new(0, v204, 0)
						local v_u_206 = (v_u_14:GetPlayerMousePosition(p_u_196.Player) - p_u_196.Rig.PrimaryPart.Position).Unit
						local v_u_207 = nil
						local v_u_208 = nil
						local v_u_209 = CFrame.Angles(Random.new():NextNumber(-0.5, 0.5), Random.new():NextNumber(-0.5, 0.5), Random.new():NextNumber(-0.5, 0.5))
						local v_u_210 = p_u_196.Config.NovaProjectile:Clone()
						v_u_210.CFrame = p_u_196.Rig.PrimaryPart.CFrame
						v_u_210.Parent = workspace.Map.Ingame
						v_u_210.RootPriority = -2
						p_u_196.Behavior.Voidstar = v_u_210
						local v_u_211 = RaycastParams.new()
						v_u_211.RespectCanCollide = true
						v_u_211.CollisionGroup = "Survivor"
						v_u_211.FilterType = Enum.RaycastFilterType.Exclude
						v_u_211.FilterDescendantsInstances = { workspace.Players, v_u_210 }
						local v_u_212 = nil
						local v_u_213 = nil
						local v216 = {
							["Size"] = Vector3.new(3.3, 3.3, 3.3),
							["CFrame"] = function()
								-- upvalues: (ref) v_u_210
								local v214 = v_u_210
								if v214 then
									v214 = v_u_210.CFrame
								end
								return v214
							end,
							["Damage"] = 0,
							["Time"] = 15,
							["Knockback"] = 0,
							["HitMultiple"] = false,
							["PredictVelocity"] = false,
							["ExecuteOnKill"] = false,
							["IsProjectile"] = true,
							["Connections"] = {
								["Hit"] = function(p215)
									-- upvalues: (ref) v_u_207, (ref) v_u_208, (ref) p_u_196, (ref) v_u_210, (ref) v_u_213
									if not v_u_207 and (not v_u_208 and p_u_196.Behavior.Voidstar) then
										v_u_207 = p215
										v_u_208 = p215
										p_u_196.Behavior.DetonateVoidstar(p_u_196, v_u_210)
										v_u_213:Cancel()
									end
								end
							}
						}
						v_u_213 = v_u_10:CreateHitbox(p_u_196.Player, v216)
						local v_u_217 = v_u_210.Position
						local function v_u_220()
							-- upvalues: (ref) v_u_217, (ref) v_u_210, (copy) v_u_211
							while true do
								local v218 = workspace:Raycast(v_u_217, v_u_210.Position - v_u_217, v_u_211)
								local v219
								if v218 then
									v219 = v218.Instance.Transparency > 0.9
								else
									v219 = v218
								end
								if v219 then
									v_u_211:AddToFilter(v218.Instance)
								end
								if not v218 or v218 and not v219 then
									return v218
								end
							end
						end
						v_u_212 = v_u_4.Heartbeat:Connect(function(p221)
							-- upvalues: (ref) v_u_210, (ref) p_u_196, (copy) v_u_205, (copy) v_u_201, (ref) v_u_207, (ref) v_u_213, (ref) v_u_212, (copy) v_u_209, (copy) v_u_206, (copy) v_u_202, (copy) v_u_220, (ref) v_u_12, (ref) v_u_217
							if v_u_210 and (p_u_196.Behavior.Voidstar and (v_u_201 >= (v_u_210.Position - v_u_205).Magnitude and (not v_u_207 and (p_u_196 and (p_u_196.Rig and v_u_210.Anchored))))) then
								v_u_210.CFrame = v_u_210.CFrame * v_u_209 + v_u_206 * p221 * v_u_202
								local v222 = v_u_220()
								if v222 then
									v_u_207 = v222.Instance
									local v223 = (Vector3.new(0, 1, 0)):Dot(v222.Normal)
									local v224 = math.acos(v223)
									if math.deg(v224) < p_u_196.Config.NovaFloorAngle then
										local v225 = Instance.new("Attachment", workspace.Terrain)
										v225.WorldPosition = v222.Position
										game.Debris:AddItem(v225, 6)
										v_u_12:Play(p_u_196.Config.Sounds.NovaShatter, {
											["Parent"] = v225
										})
										v_u_210:Destroy()
										p_u_196.Behavior.Voidstar = nil
									else
										p_u_196.Behavior.DetonateVoidstar(p_u_196, v_u_210)
									end
									p_u_196:SetCooldownOf("Nova", p_u_196.Config.NovaCooldown)
								end
								local v226 = v_u_210
								if v226 then
									v226 = v_u_210.Position
								end
								v_u_217 = v226
							else
								if v_u_210 then
									v_u_210:Destroy()
								end
								if v_u_213 then
									v_u_213:Cancel()
								end
								p_u_196.Behavior.Voidstar = nil
								p_u_196:SetCooldownOf("Nova", p_u_196.Config.NovaCooldown)
								v_u_212:Disconnect()
								p_u_196.Behavior.EnableVoidstar(p_u_196)
							end
						end)
					end
				end)
				return "Throw"
			end
			if v_u_4:IsClient() then
				if p197 == "Detonate" then
					p_u_196.Animations.NovaDet:Play(0.175)
					return
				end
				p_u_196.Animations.NovaThrow:Play(0.175)
				v_u_13:FireConnection("DisableSprinting", "Nova", true)
				task.delay(p_u_196.Config.NovaWindup, function()
					-- upvalues: (ref) v_u_13
					v_u_13:FireConnection("DisableSprinting", "Nova", false)
				end)
			end
		end
	},
	["Observant"] = {
		["LayoutOrder"] = 4,
		["Icon"] = "rbxassetid://93874368032471",
		["KeybindType"] = "AltAbility3",
		["Callback"] = function(p_u_227, p228)
			-- upvalues: (copy) v_u_4, (copy) v_u_12, (copy) v_u_13, (copy) v_u_14
			if v_u_4:IsServer() then
				if p_u_227.Behavior.Observing then
					v_u_12:Play(p_u_227.Config.Sounds.ObservantOff, {
						["Parent"] = p_u_227.Rig.PrimaryPart
					})
					p_u_227.Behavior.RevertObservance(p_u_227, false)
					p_u_227.Behavior.ToggleGeneratorAura(p_u_227, false)
					return {
						["Result"] = false
					}
				end
				if workspace:FindFirstChild("Map") and (workspace.Map:FindFirstChild("Ingame") and workspace.Map.Ingame:FindFirstChild("Map")) then
					p_u_227.Behavior.ToggleGeneratorAura(p_u_227, true)
					v_u_12:Play(p_u_227.Config.Sounds.ObservantOn, {
						["Parent"] = p_u_227.Rig.PrimaryPart
					})
					p_u_227.Behavior.Observing = true
					p_u_227.DisabledAbilities = {
						["VoidRush"] = true,
						["Nova"] = true,
						["Stab"] = true
					}
					p_u_227.AbilitiesDisabled = true
					if p_u_227.ObservantConnection then
						p_u_227.ObservantConnection:Disconnect()
						p_u_227.ObservantConnection = nil
					end
					p_u_227.ObservantConnection = p_u_227.Rig:GetAttributeChangedSignal("Stunned"):Connect(function()
						-- upvalues: (copy) p_u_227, (ref) v_u_13
						if p_u_227.Rig:GetAttribute("Stunned") then
							p_u_227.Behavior.RevertObservance(p_u_227, false)
							p_u_227.Behavior.ToggleGeneratorAura(p_u_227, false)
							v_u_13:FireClientConnection(p_u_227.Player, ("%*ObservantTeleport"):format(p_u_227.Player.Name), "REMOTE_EVENT")
						end
					end)
					v_u_14:CreateSpeedMultiplier(p_u_227.Rig, p_u_227.Config.ObservantSpeed, "NoliObserving")
					task.delay(0.5, function()
						-- upvalues: (copy) p_u_227
						p_u_227.AbilitiesDisabled = false
					end)
					return {
						["Result"] = true
					}
				end
				warn("MAP NOT FOUND!!!")
			elseif v_u_4:IsClient() then
				if not p228 then
					return
				end
				p_u_227.Behavior.Observing = p228.Result
				if p_u_227.Behavior.Observing then
					v_u_13:FireConnection("DisableSprinting", "NoliObserving", true)
					local v_u_229 = RaycastParams.new()
					v_u_229.FilterDescendantsInstances = {}
					v_u_229.FilterType = Enum.RaycastFilterType.Include
					local function v_u_233(p_u_230)
						-- upvalues: (copy) p_u_227, (ref) v_u_13, (copy) v_u_229
						local v231 = p_u_227.Config.ObservantHighlight:Clone()
						v231.Name = "ObservingHighlight"
						v231.Parent = script
						v231.Adornee = p_u_230
						local v232 = p_u_227.Config.ObservantTeleportButton:Clone()
						v232.Parent = p_u_227.Player.PlayerGui
						v232.Adornee = p_u_230
						v232.ImageButton.MouseButton1Click:Connect(function()
							-- upvalues: (ref) v_u_13, (ref) p_u_227, (copy) p_u_230
							v_u_13:FireServerConnection(("%*ObservantTeleport"):format(p_u_227.Player.Name), "REMOTE_EVENT", p_u_230)
						end)
						p_u_227.Behavior.Generators[p_u_230] = {
							["Highlight"] = v231,
							["Button"] = v232,
							["Instance"] = p_u_230
						}
						v_u_229:AddToFilter(p_u_230)
					end
					p_u_227.Behavior.Generators = {}
					p_u_227.Behavior.AddedGeneratorConnection = workspace.Map.Ingame.Map.ChildAdded:Connect(function(p234)
						-- upvalues: (copy) v_u_233
						if p234.Name == "Generator" or p234.Name == "FakeGenerator" then
							v_u_233(p234)
						end
					end)
					for _, v235 in ipairs(workspace.Map.Ingame.Map:GetChildren()) do
						if v235.Name == "Generator" or v235.Name == "FakeGenerator" then
							v_u_233(v235)
						end
					end
					v_u_4:BindToRenderStep("ObservantTeleportValidation", 1, function()
						-- upvalues: (copy) p_u_227, (ref) v_u_4
						for v236, v237 in pairs(p_u_227.Behavior.Generators or {}) do
							if not p_u_227.Behavior.Generators then
								v_u_4:UnbindFromRenderStep("ObservantTeleportValidation")
								return
							end
							local v238 = (v236:GetPivot().Position - p_u_227.Rig.PrimaryPart.Position).Magnitude
							v237.Highlight.Enabled = p_u_227.Config.ObservantMinDistance <= v238
							v237.Button.Enabled = p_u_227.Config.ObservantMinDistance <= v238
						end
					end)
					return
				end
				p_u_227.Behavior.RevertObservance(p_u_227, false)
			end
		end
	}
}
v8.Abilities = v239
function v8.ToggleGeneratorAura(p_u_240, p241, p242)
	-- upvalues: (copy) v_u_4, (copy) v_u_12, (copy) v_u_3
	local v243 = v_u_4:IsServer()
	assert(v243, "what are you doing")
	local v244 = workspace.Map.Ingame:FindFirstChild("Map")
	local v245 = ("%*NoliWarning"):format(p_u_240.Player.Name)
	if v244 then
		for _, v246 in ipairs(v244:GetChildren()) do
			if v246.Name == "Generator" or v246.Name == "FakeGenerator" then
				if p241 then
					local startVFX : Instance = p_u_240.Config.ObservantStartVFX:Clone()
					startVFX.Parent = workspace.Map.Ingame
					startVFX.CFrame = CFrame.new(v246:GetPivot().Position - Vector3.new(0, 1.8, 0))
					for i, v in ipairs(startVFX:GetDescendants()) do
						if v:IsA("ParticleEmitter") then
							v:Emit(v:GetAttribute("EmitCount"))
						end
					end
					task.delay(5, function()
						startVFX:Destroy()
					end)
					local v247 = p_u_240.Config.ObservantWarningTemplate:Clone()
					v247.Name = v245
					v247.CFrame = v246:GetPivot()-- + Vector3.new(0, 3, 0)
					v247.Parent = v246
					v_u_12:Play(p_u_240.Config.Sounds.ObservantGeneratorStart, {
						["Parent"] = v247,
						["Name"] = "AuraWarningSound"
					})
					v_u_12:Play(p_u_240.Config.Sounds.ObservantGeneratorLoop, {
						["Parent"] = v247,
						["Name"] = "AuraWarningSound",
						["Looped"] = true
					})
				else
					local v248 = p242 == v246
					local v_u_249 = v246:FindFirstChild(v245)
					if v_u_249 then
						v_u_249.Name = v_u_249.Name .. "_Done"
						while v_u_249:FindFirstChild("AuraWarningSound") do
							v_u_249.AuraWarningSound:Destroy()
						end
						v_u_12:Play(p_u_240.Config.Sounds[v248 and "ObservantGeneratorWarning" or "ObservantGeneratorEnd"], {
							["Parent"] = v_u_249,
							["Name"] = "AuraDisappear"
						})
						if v248 then
							task.spawn(function()
								-- upvalues: (copy) v_u_249, (ref) v_u_4, (copy) p_u_240
								local v250 = tick()
								local incoming : Instance = p_u_240.Config.ObservantIncomingTemplate:Clone()
								incoming.Parent = v_u_249.Parent
								incoming.CFrame = v_u_249.CFrame
								v_u_249:Destroy()
								while v_u_4.Heartbeat:Wait() and (v_u_249 and tick() - v250 <= p_u_240.Config.ObservantTeleportWindup) do
									task.wait()
								end
								for i, v in ipairs(incoming:GetDescendants()) do
									if v:IsA("ParticleEmitter") then
										v.Enabled = false
									end
								end
								task.delay(5, function()
									incoming:Destroy()
								end)
							end)
						else
							for i, v in ipairs(v_u_249:GetDescendants()) do
								if v:IsA("ParticleEmitter") then
									v.Enabled = false
								end
							end
							task.delay(5, function()
								v_u_249:Destroy()
							end)
						end
						--game.Debris:AddItem(v_u_249, 5)
					end
				end
			end
		end
	end
end
function v8.RevertObservance(p_u_252, p253)
	-- upvalues: (copy) v_u_4, (copy) v_u_14, (copy) v_u_13
	if v_u_4:IsServer() then
		if p_u_252.Behavior.Observing then
			if p_u_252.ObservantConnection then
				p_u_252.ObservantConnection:Disconnect()
				p_u_252.ObservantConnection = nil
			end
			v_u_4:UnbindFromRenderStep("ObservantTeleportValidation")
			p_u_252.Behavior.Observing = false
			p_u_252:SetCooldownOf("Observant", p_u_252.Config.ObservantC00ldown / (p253 and 1 or 2))
			p_u_252.DisabledAbilities = nil
			p_u_252.AbilitiesDisabled = true
			v_u_14:CreateSpeedMultiplier(p_u_252.Rig, 1, "NoliObserving", 0)
			task.delay(p253 and (p_u_252.Config.ObservantTeleportWindup + p_u_252.Config.ObservantTeleportEndlag or 0.5) or 0.5, function()
				-- upvalues: (copy) p_u_252
				p_u_252.AbilitiesDisabled = false
			end)
		end
	else
		if v_u_4:IsClient() then
			if not p_u_252.Behavior.Generators then
				return
			end
			for _, v254 in pairs(p_u_252.Behavior.Generators or {}) do
				if v254.Highlight then
					v254.Highlight:Destroy()
				end
				if v254.Button then
					v254.Button:Destroy()
				end
			end
			p_u_252.Behavior.Generators = nil
			if p_u_252.Behavior.AddedGeneratorConnection then
				p_u_252.Behavior.AddedGeneratorConnection:Disconnect()
			end
			v_u_13:FireConnection("DisableSprinting", "NoliObserving", false)
		end
		return
	end
end
function v8.Teleport(p255, p256)
	if typeof(p256) == "Vector3" then
		p256 = CFrame.new(p256) or p256
	end
	p255.Rig.PrimaryPart.CFrame = p256
end
function v8.DetonateVoidstar(p_u_257, p_u_258, p259)
	-- upvalues: (copy) v_u_4, (copy) v_u_14, (copy) v_u_12, (copy) v_u_10, (copy) v_u_6, (copy) v_u_3, (copy) v_u_15, (copy) v_u_5, (copy) v_u_13
	local v260 = v_u_4:IsServer()
	assert(v260, "what are you doing")
	assert(p_u_258, "no voidstar :(")
	assert(p_u_257, "use dot notation when calling")
	local _ = p_u_257.Behavior
	local v261 = p_u_258:FindFirstChild("Explosion")
	if v261 and v261.ClassName == "Attachment" then
		local v262 = v261.WorldCFrame
		v261.Parent = workspace.Terrain
		v261.WorldCFrame = v262
		v_u_14:EmitParticles(v261)
		v_u_12:Play(p_u_257.Config.Sounds.Explosion, {
			["Parent"] = v261
		})
		game.Debris:AddItem(v261, 6)
	end
	local _, v263, _ = p_u_258.CFrame:ToEulerAnglesXYZ()
	local v264 = CFrame.new(p_u_258.CFrame.Position) * CFrame.Angles(0, v263, 0)
	local v_u_265 = p_u_257.Config.NovaExplosionKnockback or 440
	v_u_10:CreateHitbox(p_u_257.Player, {
		["Size"] = Vector3.new(1, 1, 1) * p_u_257.Config.NovaExplosionRadius / (p259 and 2 or 1),
		["CFrame"] = v264,
		["Damage"] = p_u_257.Config.NovaExplosionDamage,
		["Time"] = 0.05,
		["HitMultiple"] = true,
		["Knockback"] = false,
		["ExecuteOnKill"] = false,
		["IsProjectile"] = true,
		["PredictVelocity"] = false,
		["Connections"] = {
			["Hit"] = function(p266)
				-- upvalues: (copy) p_u_258, (copy) v_u_265, (ref) v_u_6, (ref) v_u_14, (ref) v_u_3, (copy) p_u_257, (ref) v_u_15
				local v_u_267 = p266.PrimaryPart
				local v268 = Instance.new("BodyPosition", v_u_267)
				v268.Position = p_u_258.Position
				v268.MaxForce = Vector3.new(10000, 7000, 10000)
				v268.P = v_u_265 * 2800
				v268.D = 800 - v_u_265
				v_u_6:AddItem(v268, 0.35)
				task.delay(0.35, function()
					-- upvalues: (copy) v_u_267
					if v_u_267 then
						local v269 = v_u_267
						v269.AssemblyLinearVelocity = v269.AssemblyLinearVelocity / 1000
					end
				end)
				v_u_3:Create(v_u_14:CreateSpeedMultiplier(p266, 0.5, "VoidstarExplosion", 0.7), TweenInfo.new(0.7), {
					["Value"] = 1
				}):Play()
				v_u_15:IncrementActorStats(p_u_257.Player, {
					["Action"] = "Hit Survivor with Nova",
					["RewardType"] = "EasyKillerAction"
				})
			end
		}
	})
	for _, v270 in ipairs(v_u_5:GetPlayers()) do
		local v271 = v270.Character and v270.Character.PrimaryPart
		if v271 then
			v271 = v270.Character.PrimaryPart.Position
		end
		if v271 then
			v271 = (p_u_258.Position - v271).Magnitude
		end
		local v272 = p_u_257.Config.NovaExplosionRadius * 2
		if v271 and v271 < v272 then
			local v273 = v_u_13
			local v274 = v272 - v271
			v273:FireClientConnection(v270, "ApplyCameraShake", "REMOTE_EVENT", math.clamp(v274, 0, v272) / v272 * 0.5, 0.7)
		end
	end
	p_u_258:Destroy()
end
function v8.EnableVoidstar(p275)
	-- upvalues: (copy) v_u_14, (copy) v_u_12
	assert(p275, "must pass killerInfo as argument")
	if not p275.Behavior.VoidstarEnabled then
		p275.Behavior.VoidstarEnabled = true
		local v276 = p275.Rig
		if v276 then
			v276 = v276:FindFirstChild("Voidstar")
		end
		if v276 then
			v276.Transparency = 0
			v276.Main.Main.Enabled = true
			v_u_14:EmitParticles(v_u_14:MergeTables({ v276.Appear1, v276.Appear2 }, v276.AppearT:GetChildren()))
			v_u_12:Play(p275.Config.VoidstarEnable, {
				["Parent"] = v276
			})
		end
	end
end
function v8.DisableVoidstar(p277)
	assert(p277, "must pass killerInfo as argument")
	if p277.Behavior.VoidstarEnabled then
		p277.Behavior.VoidstarEnabled = false
		local v278 = p277.Rig
		if v278 then
			v278 = v278:FindFirstChild("Voidstar")
		end
		if v278 then
			v278.Main.Main.Enabled = false
			v278.Main.Main:Clear()
			v278.Transparency = 1
		end
	end
end
return v8
