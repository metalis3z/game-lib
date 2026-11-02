-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
game:GetService("TweenService")
local v_u_3 = game:GetService("RunService")
game:GetService("Lighting")
local v4 = game:GetService("Players")
game:GetService("Debris")
require(v_u_1.Shared.EventTypes)
local v5 = {}
local v_u_6 = require(v_u_1.Controllers.EncryptedAssetsController)
local v_u_7 = require(v_u_1.Controllers.AnimalController)
local v_u_8 = require(v_u_1.Controllers.EffectController)
require(v_u_1.Controllers.CameraController)
local v_u_9 = require(v_u_1.Controllers.SoundController)
local v_u_10 = require(v_u_1.Controllers.EventController)
local v_u_11 = require(v_u_1.Controllers.CycleController)
require(v_u_1.Shared.SharedEventUtils)
require(v_u_1.Packages.CreateTween)
require(v_u_1.Shared.TweenPivot)
local v_u_12 = require(v_u_1.Packages.Observers)
require(v_u_1.Utils.MathUtils)
local v_u_13 = require(v_u_1.Packages.Signal)
require(v_u_1.Packages.Spring)
local v_u_14 = require(v_u_1.Packages.Trove)
require(v_u_1.Packages.Shake)
local v15 = require(v_u_1.Packages.Net)
local v_u_16 = require(v_u_1.Shared.VFX)
local v_u_17 = workspace.Sounds.MexicoEvent
local v_u_18 = v4.LocalPlayer
local _ = workspace.CurrentCamera
local v_u_19 = script.Name
local _ = workspace.RenderedMovingAnimals
local v_u_20 = v15:RemoteEvent("EventService/Mexico/Burst")
local v_u_21 = v_u_14.new()
local function v_u_28(p_u_22)
	return task.spawn(function()
		-- upvalues: (copy) p_u_22
		for _, v23 in p_u_22 do
			v23:Play(0)
		end
		while true do
			local v24 = true
			for _, v25 in p_u_22 do
				if v25.Length == 0 then
					v24 = false
				else
					v25:Stop(0)
				end
			end
			if v24 then
				for _, v26 in p_u_22 do
					v26:Stop(0)
				end
				for _, v27 in p_u_22 do
					v27:Play(0)
				end
				return
			end
			task.wait()
		end
	end)
end
local function v_u_31(p_u_29)
	-- upvalues: (copy) v_u_3, (copy) v_u_17
	return v_u_3.PostSimulation:Connect(function(_)
		-- upvalues: (ref) v_u_17, (copy) p_u_29
		if v_u_17.TimePosition >= 28.5 then
			for _, v30 in p_u_29 do
				v30:AdjustSpeed(1.5)
			end
		end
	end)
end
function v5.OnStart(_)
	-- upvalues: (copy) v_u_10, (copy) v_u_19, (copy) v_u_21, (copy) v_u_8, (copy) v_u_11, (copy) v_u_9, (copy) v_u_12, (copy) v_u_14, (copy) v_u_16, (copy) v_u_31, (copy) v_u_28, (copy) v_u_6, (copy) v_u_17, (copy) v_u_20, (copy) v_u_7, (copy) v_u_1, (copy) v_u_13, (copy) v_u_3, (copy) v_u_18
	local v_u_32 = v_u_10:GetActiveEventData(v_u_19)
	assert(v_u_32)
	v_u_21:Add(function()
		-- upvalues: (ref) v_u_8, (ref) v_u_11, (ref) v_u_9
		v_u_8:Activate("Blink")
		v_u_11:Update()
		v_u_9:UpdateOST()
	end)
	local v33 = v_u_21:Clone(script.Map)
	v33.Parent = workspace
	v_u_21:Add(v_u_12.observeTag("HideInMexico", function(p_u_34)
		local v_u_35 = p_u_34.Parent
		p_u_34.Parent = script
		return function()
			-- upvalues: (copy) p_u_34, (copy) v_u_35
			pcall(function()
				-- upvalues: (ref) p_u_34, (ref) v_u_35
				p_u_34.Parent = v_u_35
			end)
		end
	end, { workspace, script }))
	v_u_8:Activate("Blink")
	v_u_11:Update()
	v_u_9:UpdateOST()
	v_u_8:Run("MexicoEvent", "GrassRecolor")
	v_u_21:Add(function()
		-- upvalues: (ref) v_u_8
		v_u_8:Stop("MexicoEvent", "GrassRecolor")
	end)
	v_u_8:Run("MexicoEvent", "WallRecolor")
	v_u_21:Add(function()
		-- upvalues: (ref) v_u_8
		v_u_8:Stop("MexicoEvent", "WallRecolor")
	end)
	v_u_8:Run("MexicoEvent", "WallBottomRecolor")
	v_u_21:Add(function()
		-- upvalues: (ref) v_u_8
		v_u_8:Stop("MexicoEvent", "WallBottomRecolor")
	end)
	v_u_21:Add(v_u_12.observeTag("Roach", function(p_u_36)
		-- upvalues: (ref) v_u_14, (ref) v_u_12, (ref) v_u_21, (ref) v_u_16, (ref) v_u_31, (copy) v_u_32
		local v_u_37 = v_u_14.new()
		local v38 = p_u_36:WaitForChild("HumanoidRootPart")
		local v_u_39 = v_u_37:Clone(script.Cockroach)
		local v40 = v_u_37:Add(Instance.new("Weld"))
		v40.Part0 = v_u_39.PrimaryPart
		v40.Part1 = v38
		v40.Parent = v_u_39.PrimaryPart
		v_u_39.Parent = p_u_36
		local v_u_41 = v_u_39.AnimationController.Animator
		local v_u_42 = v_u_41:LoadAnimation(script.TakeHat)
		v_u_42.Looped = false
		v_u_42.Priority = Enum.AnimationPriority.Action3
		local v_u_43 = v_u_41:LoadAnimation(script.PutHat)
		v_u_43.Looped = false
		v_u_43.Priority = Enum.AnimationPriority.Action4
		v_u_37:Add(p_u_36:GetAttributeChangedSignal("AttackAnimation"):Connect(function()
			-- upvalues: (copy) v_u_43
			v_u_43:Play()
		end))
		p_u_36:SetAttribute("Shuffle", false)
		v_u_37:Add(v_u_12.observeAttribute(p_u_36, "Shuffle", function(p44)
			-- upvalues: (ref) v_u_14, (copy) v_u_41, (ref) v_u_21, (ref) v_u_12, (copy) p_u_36, (copy) v_u_42, (ref) v_u_16, (copy) v_u_39, (ref) v_u_31
			if not p44 then
				return v_u_12.observeAttribute(p_u_36, "Instrument", function(p_u_45)
					-- upvalues: (ref) v_u_14, (ref) v_u_42, (ref) v_u_16, (ref) v_u_39, (ref) v_u_41, (ref) v_u_21, (ref) v_u_12, (ref) p_u_36, (ref) v_u_31
					local v46 = v_u_14.new()
					if p_u_45 == "Sombrero" then
						v_u_42:Play()
						v_u_16.disable(v_u_39.RootPart.VFX)
					else
						v_u_16.enable(v_u_39.RootPart.VFX)
					end
					local v_u_47 = v_u_41:LoadAnimation(script:FindFirstChild((("RoachWalk%*"):format(p_u_45))) or script.RoachWalk);
					(v46 or v_u_21):Add(function()
						-- upvalues: (copy) v_u_47
						v_u_47:Stop(0)
						v_u_47:Destroy()
					end)
					v_u_47.Priority = Enum.AnimationPriority.Action2
					v46:Add(v_u_12.observeAttribute(p_u_36, "IsRunning", function(p48)
						-- upvalues: (copy) v_u_47
						if p48 then
							v_u_47:Play()
						else
							v_u_47:Stop()
						end
						return nil
					end))
					local v49 = script.Instruments:FindFirstChild(p_u_45)
					local v_u_50
					if v49 then
						v_u_50 = v46:Clone(v49)
						if v_u_50.PrimaryPart then
							local v51 = Instance.new("Weld")
							v51.Part0 = v_u_50.PrimaryPart
							v51.Part1 = v_u_39.PrimaryPart
							v51.C0 = CFrame.new(0, 3.5, 0)
							v51.Parent = v_u_50.PrimaryPart
						end
						for _, v52 in v_u_50:GetChildren() do
							local v53 = v52:FindFirstChildOfClass("RigidConstraint")
							if v53 then
								local v54 = v53.Attachment0
								if v54 then
									local v55 = v_u_39:FindFirstChild(v54.Name, true)
									if v55 then
										v53.Attachment1 = v55
									end
								end
							end
						end
						v_u_50.Parent = v_u_39.PrimaryPart
					else
						v_u_50 = nil
					end
					v46:Add(v_u_12.observeAttribute(p_u_36, "Dance", function(p56)
						-- upvalues: (ref) v_u_14, (copy) p_u_45, (ref) v_u_41, (ref) v_u_21, (ref) v_u_50, (ref) v_u_12, (ref) p_u_36, (ref) v_u_31
						if not p56 then
							return nil
						end
						local v57 = v_u_14.new()
						local v58 = script:FindFirstChild((("Roach%*"):format(p_u_45)))
						local v59
						if v58 then
							local v_u_60 = v_u_41:LoadAnimation(v58);
							(v57 or v_u_21):Add(function()
								-- upvalues: (copy) v_u_60
								v_u_60:Stop(0)
								v_u_60:Destroy()
							end)
							v59 = v_u_60
							v59.Looped = true
							v59.Priority = Enum.AnimationPriority.Action
							v59:Play()
							if p_u_45 == "Maracas" then
								v59:AdjustSpeed(0.65)
							end
						else
							v59 = nil
						end
						local v_u_61 = nil
						if v_u_50 and v_u_50:FindFirstChild("AnimationController") then
							local v62 = script:FindFirstChild(p_u_45)
							if v62 then
								local v_u_63 = v_u_50.AnimationController.Animator:LoadAnimation(v62);
								(v57 or v_u_21):Add(function()
									-- upvalues: (copy) v_u_63
									v_u_63:Stop(0)
									v_u_63:Destroy()
								end)
								v_u_61 = v_u_63
								v_u_61.Looped = true
								v_u_61.Priority = Enum.AnimationPriority.Action
								v_u_61:Play()
								if v59 then
									v_u_21:Add(v59.DidLoop:Connect(function()
										-- upvalues: (ref) v_u_61
										v_u_61.TimePosition = 0
									end))
								end
							end
							local v64 = script:FindFirstChild((("Walk%*"):format(p_u_45)))
							if v64 then
								local v_u_65 = v_u_50.AnimationController.Animator:LoadAnimation(v64);
								(v57 or v_u_21):Add(function()
									-- upvalues: (copy) v_u_65
									v_u_65:Stop(0)
									v_u_65:Destroy()
								end)
								v_u_65.Priority = Enum.AnimationPriority.Action2
								v57:Add(v_u_12.observeAttribute(p_u_36, "IsRunning", function(p66)
									-- upvalues: (copy) v_u_65
									if p66 then
										v_u_65:Play()
									else
										v_u_65:Stop()
									end
									return nil
								end))
							end
						end
						v57:Add(v_u_31({ v59, v_u_61 }))
						return v57:WrapClean()
					end))
					return v46:WrapClean()
				end)
			end
			local v67 = v_u_14.new()
			local v_u_68 = v_u_41:LoadAnimation(script.Shuffle);
			(v67 or v_u_21):Add(function()
				-- upvalues: (copy) v_u_68
				v_u_68:Stop(0)
				v_u_68:Destroy()
			end)
			v_u_68.Looped = true
			v_u_68:Play()
			v_u_68:AdjustSpeed(1.5)
			return v67:WrapClean()
		end))
		local v69 = v_u_32.startedAt + 28.5 - workspace:GetServerTimeNow()
		local v70 = math.max(v69, 0)
		v_u_37:Add(v_u_21:Add(task.delay(v70, function()
			-- upvalues: (copy) p_u_36, (copy) v_u_37, (ref) v_u_21, (ref) v_u_32
			p_u_36:SetAttribute("Shuffle", true)
			local v71 = v_u_37
			local v72 = v_u_21
			local v73 = task.delay
			local v74 = v_u_32.startedAt + 34.5 - workspace:GetServerTimeNow()
			v71:Add(v72:Add(v73(math.max(v74, 0), function()
				-- upvalues: (ref) p_u_36
				p_u_36:SetAttribute("Shuffle", false)
			end)))
		end)))
		return v_u_37:WrapClean()
	end))
	for _, v75 in v33.WallRoaches:GetChildren() do
		local v76 = v75:GetAttribute("Instrument") or "Violin"
		local v77 = v_u_21:Clone(script.Wall)
		v77:PivotTo(v75:GetPivot())
		for _, v78 in v77.Instruments:GetChildren() do
			if v78.Name ~= v76 then
				v78:Destroy()
			end
		end
		v77.Parent = workspace
		local v_u_79 = v77.Cockroach.AnimationController.Animator:LoadAnimation(script[("Roach%*"):format(v76)])
		v_u_21:Add(function()
			-- upvalues: (copy) v_u_79
			v_u_79:Stop(0)
			v_u_79:Destroy()
		end)
		v_u_79:Play()
		local v_u_80 = v77.Instruments[v76].AnimationController.Animator:LoadAnimation(script[v76])
		v_u_21:Add(function()
			-- upvalues: (copy) v_u_80
			v_u_80:Stop(0)
			v_u_80:Destroy()
		end)
		v_u_80:Play()
		v_u_21:Add(v_u_79.DidLoop:Connect(function()
			-- upvalues: (copy) v_u_80
			v_u_80.TimePosition = 0
		end))
		local v81 = { v_u_80, v_u_79 }
		v_u_21:Add(v_u_28(v81))
		v_u_21:Add(v_u_31(v81))
	end
	v_u_21:Add(task.spawn(function()
		-- upvalues: (ref) v_u_6, (ref) v_u_17, (copy) v_u_32, (ref) v_u_21
		v_u_6:WaitForAssetId("rbxassetid://121640094010212")
		v_u_17.SoundId = ""
			v_u_17.SoundId = "rbxassetid://121640094010212"
		while not v_u_17.IsLoaded do
			task.wait()
		end
		v_u_17.TimePosition = workspace:GetServerTimeNow() - v_u_32.startedAt
		v_u_17:Play()
		v_u_21:Add(function()
			-- upvalues: (ref) v_u_17
			v_u_17:Stop()
		end)
	end))
	v_u_21:Add(v_u_20.OnClientEvent:Connect(function(p82)
		-- upvalues: (ref) v_u_7, (ref) v_u_9, (ref) v_u_1, (ref) v_u_16
		local v_u_83
		if typeof(p82) == "string" then
			local v84 = v_u_7:GetAnimals()[p82]
			if not v84 then
				return
			end
			local v85 = v84.AnimalModel
			local v86
			if v85.PrimaryPart then
				v86 = v85.PrimaryPart.CFrame
			else
				v86 = v85:GetPivot()
			end
			v_u_83 = v86.Position
			p82 = v84.AnimalModel.PrimaryPart
		else
			v_u_83 = p82:GetPivot().Position
		end
		task.spawn(function()
			-- upvalues: (ref) v_u_9, (ref) v_u_1, (ref) v_u_83
			v_u_9:PlaySound(v_u_1.Sounds.Events.Mexico.Hit, v_u_83)
		end)
		local v_u_87 = script.Burst:Clone()
		v_u_87:PivotTo(CFrame.new(v_u_83))
		v_u_87.Anchored = false
		local v88 = Instance.new("WeldConstraint")
		v88.Part0 = v_u_87
		v88.Part1 = p82
		v88.Parent = v_u_87
		v_u_87.Parent = workspace
		v_u_16.emit(v_u_87)
		task.delay(5, function()
			-- upvalues: (copy) v_u_87
			v_u_87:Destroy()
		end)
	end))
	local v89 = v_u_21
	local v90 = task.delay
	local v91 = v_u_32.startedAt + 28.5 - workspace:GetServerTimeNow()
	v89:Add(v90(math.max(v91, 0), function()
		-- upvalues: (ref) v_u_21, (ref) v_u_13, (ref) v_u_12, (ref) v_u_14, (ref) v_u_3, (copy) v_u_32, (ref) v_u_18
		v_u_21:Add(v_u_13.new())
		v_u_21:Add(v_u_12.observeCharacters(function(_, p_u_92)
			-- upvalues: (ref) v_u_14, (ref) v_u_3, (ref) v_u_32, (ref) v_u_18
			local v_u_93 = v_u_14.new()
			v_u_93:Add(task.spawn(function()
				-- upvalues: (copy) p_u_92, (copy) v_u_93, (ref) v_u_3, (ref) v_u_32, (ref) v_u_18
				local v_u_94 = p_u_92:WaitForChild("Humanoid")
				if v_u_94 then
					local v95 = v_u_94:WaitForChild("Animator")
					if v95 then
						local v_u_96 = v95:LoadAnimation(script.PlayerDance)
						v_u_96.Priority = Enum.AnimationPriority.Action
						local v_u_97 = nil
						local function v_u_103()
							-- upvalues: (ref) v_u_97, (ref) v_u_93, (ref) p_u_92
							if not v_u_97 then
								local v98 = v_u_93:Clone(script.PlayerMaracas)
								for _, v99 in v98:GetChildren() do
									local v100 = v99:FindFirstChildOfClass("RigidConstraint")
									if v100 then
										local v101 = v100.Attachment0
										if v101 then
											local v102 = p_u_92:FindFirstChild(v101.Name, true)
											if v102 and v102:IsA("Attachment") then
												v100.Attachment1 = v102
											end
										end
									end
								end
								v98.Parent = p_u_92
								v_u_97 = v98
							end
						end
						local v_u_104 = 0
						v_u_93:Add(v_u_3.PostSimulation:Connect(function(p105)
							-- upvalues: (ref) v_u_32, (copy) v_u_96, (copy) v_u_103, (copy) v_u_94, (ref) v_u_18, (ref) v_u_104, (ref) v_u_97, (ref) v_u_93
							debug.profilebegin("Mexico:Player:Dance")
							workspace:GetServerTimeNow()
							local v106 = v_u_32.startedAt + 43.5 - workspace:GetServerTimeNow()
							if math.max(v106, 0) > 0 then
								if not v_u_96.IsPlaying then
									v_u_96:Play()
									v_u_103()
								end
								debug.profileend()
							else
								if v_u_94.MoveDirection == Vector3.new(0, 0, 0) and not v_u_18:GetAttribute("Stealing") then
									if v_u_104 < 3 then
										v_u_104 = v_u_104 + p105
									elseif not v_u_96.IsPlaying then
										v_u_96:Play()
										v_u_103()
									end
								else
									v_u_104 = 0
									if v_u_96.IsPlaying then
										v_u_96:Stop()
										if v_u_97 then
											v_u_93:Remove(v_u_97)
											v_u_97 = nil
										end
									end
								end
								debug.profileend()
							end
						end))
						v_u_93:Add(function()
							-- upvalues: (copy) v_u_96
							v_u_96:Stop()
							v_u_96:Destroy()
						end)
					end
				else
					return
				end
			end))
			return v_u_93:WrapClean()
		end))
	end))
end
function v5.OnStop(_)
	-- upvalues: (copy) v_u_21
	v_u_21:Destroy()
end
function v5.OnLoad(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_6, (copy) v_u_17
	task.spawn(pcall, function()
		-- upvalues: (ref) v_u_2
		v_u_2:PreloadAsync(script:GetChildren())
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_6, (ref) v_u_17, (ref) v_u_2
		v_u_6:WaitForAssetId("rbxassetid://121640094010212")
		v_u_17.SoundId = "rbxassetid://121640094010212"
		v_u_2:PreloadAsync({ v_u_17 })
	end)
end
return v5
