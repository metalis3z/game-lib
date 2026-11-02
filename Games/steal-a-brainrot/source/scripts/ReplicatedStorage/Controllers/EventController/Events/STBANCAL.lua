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
local v_u_17 = workspace.Sounds.STBANCALEvent
local v_u_18 = v4.LocalPlayer
local _ = workspace.CurrentCamera
local v_u_19 = script.Name
local _ = workspace.RenderedMovingAnimals
local v_u_20 = v15:RemoteEvent("EventService/Mexico/Burst")
local v_u_21 = v_u_14.new()

-- IDs des animations
local WALK_ANIM_ID = "rbxassetid://72830759924789"
local IDLE_ANIM_ID = "rbxassetid://127161535625884"

-- FIX 1 : attendre que toutes les anims soient chargées avant de les jouer
local function v_u_28(p_u_22)
	return task.spawn(function()
		for _, v23 in p_u_22 do
			while v23.Length == 0 do
				task.wait()
			end
		end
		for _, v23 in p_u_22 do
			v23:Play(0)
		end
	end)
end

local function v_u_31(p_u_29)
	return v_u_3.PostSimulation:Connect(function(_)
		if v_u_17.TimePosition >= 28.5 then
			for _, v30 in p_u_29 do
				v30:AdjustSpeed(1.5)
			end
		end
	end)
end

-- Fonction pour charger une animation depuis une asset ID
local function LoadAnimationFromAsset(animator, assetId, looped, priority)
	local animation = Instance.new("Animation")
	animation.AnimationId = assetId
	local track = animator:LoadAnimation(animation)
	track.Looped = looped
	if priority then
		track.Priority = priority
	end
	return track, animation
end

function v5.OnStart(_)
	local v_u_32 = v_u_10:GetActiveEventData(v_u_19)
	assert(v_u_32)
	v_u_21:Add(function()
		v_u_8:Activate("Blink")
		v_u_11:Update()
		v_u_9:UpdateOST()
	end)
	local v33 = v_u_21:Clone(script.Map)
	v33.Parent = workspace
	v_u_21:Add(v_u_12.observeTag("HideInSTBANCAL", function(p_u_34)
		local v_u_35 = p_u_34.Parent
		p_u_34.Parent = script
		return function()
			pcall(function()
				p_u_34.Parent = v_u_35
			end)
		end
	end, { workspace, script }))
	v_u_8:Activate("Blink")
	v_u_11:Update()
	v_u_9:UpdateOST()
	v_u_8:Run("STBANCALEvent", "GrassRecolor")
	v_u_21:Add(function()
		v_u_8:Stop("STBANCALEvent", "GrassRecolor")
	end)
	v_u_8:Run("STBANCALEvent", "WallRecolor")
	v_u_21:Add(function()
		v_u_8:Stop("STBANCALEvent", "WallRecolor")
	end)
	v_u_8:Run("STBANCALEvent", "WallBottomRecolor")
	v_u_21:Add(function()
		v_u_8:Stop("STBANCALEvent", "WallBottomRecolor")
	end)
	v_u_21:Add(v_u_12.observeTag("Roach", function(p_u_36)
		local v_u_37 = v_u_14.new()
		local v38 = p_u_36:WaitForChild("HumanoidRootPart")
		local v_u_39 = v_u_37:Clone(script:WaitForChild("Cockroach"))
		local v40 = v_u_37:Add(Instance.new("Weld"))
		v40.Part0 = v_u_39.PrimaryPart
		v40.Part1 = v38
		v40.Parent = v_u_39.PrimaryPart
		v_u_39.Parent = p_u_36
		local v_u_41 = v_u_39.AnimationController.Animator

		-- Création des animations walk et idle
		local walkTrack, walkAnim = LoadAnimationFromAsset(v_u_41, WALK_ANIM_ID, true, Enum.AnimationPriority.Action2)
		local idleTrack, idleAnim = LoadAnimationFromAsset(v_u_41, IDLE_ANIM_ID, true, Enum.AnimationPriority.Action2)

		-- Stocker les animations dans la trove pour nettoyage
		v_u_37:Add(function()
			walkAnim:Destroy()
			idleAnim:Destroy()
			if walkTrack then walkTrack:Destroy() end
			if idleTrack then idleTrack:Destroy() end
		end)

		local currentTrack = nil
		local function SwitchToTrack(track)
			if currentTrack == track then return end
			if currentTrack then
				currentTrack:Stop()
			end
			currentTrack = track
			if track then
				track:Play()
			end
		end

		-- Observer l'attribut IsRunning pour switcher entre walk et idle
		v_u_37:Add(v_u_12.observeAttribute(p_u_36, "IsRunning", function(isRunning)
			if isRunning then
				SwitchToTrack(walkTrack)
			else
				SwitchToTrack(idleTrack)
			end
			return nil
		end))

		local v_u_42 = v_u_41:LoadAnimation(script.TakeHat)
		v_u_42.Looped = false
		v_u_42.Priority = Enum.AnimationPriority.Action3
		local v_u_43 = v_u_41:LoadAnimation(script.PutHat)
		v_u_43.Looped = false
		v_u_43.Priority = Enum.AnimationPriority.Action4
		v_u_37:Add(p_u_36:GetAttributeChangedSignal("AttackAnimation"):Connect(function()
			v_u_43:Play()
		end))

		p_u_36:SetAttribute("Shuffle", false)
		v_u_37:Add(v_u_12.observeAttribute(p_u_36, "Shuffle", function(p44)
			if not p44 then
				return v_u_12.observeAttribute(p_u_36, "Instrument", function(p_u_45)
					local v46 = v_u_14.new()
					if p_u_45 == "Sombrero" then
						v_u_42:Play()
						v_u_16.disable(v_u_39.RootPart.VFX)
					else
						v_u_16.enable(v_u_39.RootPart.VFX)
					end
					local v_u_47 = v_u_41:LoadAnimation(script:FindFirstChild(("RoachWalk%*"):format(p_u_45)) or script.RoachWalk);
					(v46 or v_u_21):Add(function()
						v_u_47:Stop(0)
						v_u_47:Destroy()
					end)
					v_u_47.Priority = Enum.AnimationPriority.Action2

					v46:Add(v_u_12.observeAttribute(p_u_36, "IsRunning", function(p48)
						if p48 then
							v_u_47:Play()
						else
							if v_u_47.IsPlaying then
								v_u_47:Stop()
							end
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
						if not p56 then return nil end
						local v57 = v_u_14.new()
						local v58 = script:FindFirstChild(("Roach%*"):format(p_u_45))
						local v_u_59
						if v58 then
							v_u_59 = v_u_41:LoadAnimation(v58);
							(v57 or v_u_21):Add(function()
								v_u_59:Stop(0)
								v_u_59:Destroy()
							end)
							v_u_59.Looped = true
							v_u_59.Priority = Enum.AnimationPriority.Action
							v_u_59:Play()
							if p_u_45 == "Maracas" then
								v_u_59:AdjustSpeed(0.65)
							end
						else
							v_u_59 = nil
						end
						local v_u_60 = nil
						if v_u_50 and v_u_50:FindFirstChild("AnimationController") then
							local v61 = script:FindFirstChild(p_u_45)
							if v61 then
								local v_u_62 = v_u_50.AnimationController.Animator:LoadAnimation(v61);
								(v57 or v_u_21):Add(function()
									v_u_62:Stop(0)
									v_u_62:Destroy()
								end)
								v_u_60 = v_u_62
								v_u_60.Looped = true
								v_u_60.Priority = Enum.AnimationPriority.Action
								v_u_60:Play()
								if v_u_59 then
									v_u_21:Add(v_u_59.DidLoop:Connect(function()
										v_u_60.TimePosition = 0
									end))
								end
							end
							local v63 = script:FindFirstChild(("Walk%*"):format(p_u_45))
							if v63 then
								local v_u_64 = v_u_50.AnimationController.Animator:LoadAnimation(v63);
								(v57 or v_u_21):Add(function()
									v_u_64:Stop(0)
									v_u_64:Destroy()
								end)
								v_u_64.Priority = Enum.AnimationPriority.Action2

								v57:Add(v_u_12.observeAttribute(p_u_36, "IsRunning", function(p65)
									if p65 then
										v_u_64:Play()
									else
										if v_u_64.IsPlaying then
											v_u_64:Stop()
										end
									end
									return nil
								end))
							end
						end
						v57:Add(v_u_31({ v_u_59, v_u_60 }))
						return v57:WrapClean()
					end))
					return v46:WrapClean()
				end)
			end
			local v66 = v_u_14.new()
			local v_u_67 = v_u_41:LoadAnimation(script.Shuffle);
			(v66 or v_u_21):Add(function()
				v_u_67:Stop(0)
				v_u_67:Destroy()
			end)
			v_u_67.Looped = true
			v_u_67:Play()
			v_u_67:AdjustSpeed(1.5)
			return v66:WrapClean()
		end))

		local v68 = v_u_32.startedAt + 28.5 - workspace:GetServerTimeNow()
		local v69 = math.max(v68, 0)
		v_u_37:Add(v_u_21:Add(task.delay(v69, function()
			p_u_36:SetAttribute("Shuffle", true)
			local v70 = v_u_37
			local v71 = v_u_21
			local v72 = task.delay
			local v73 = v_u_32.startedAt + 34.5 - workspace:GetServerTimeNow()
			v70:Add(v71:Add(v72(math.max(v73, 0), function()
				p_u_36:SetAttribute("Shuffle", false)
			end)))
		end)))
		return v_u_37:WrapClean()
	end))

	for _, v74 in v33.WallRoaches:GetChildren() do
		local v75 = v74:GetAttribute("Instrument") or "Violin"
		local v76 = v_u_21:Clone(script.Wall)
		v76:PivotTo(v74:GetPivot())
		for _, v77 in v76.Instruments:GetChildren() do
			if v77.Name ~= v75 then
				v77:Destroy()
			end
		end
		v76.Parent = workspace
		local v_u_78 = v76.Cockroach.AnimationController.Animator:LoadAnimation(script[("Roach%*"):format(v75)])
		v_u_21:Add(function()
			v_u_78:Stop(0)
			v_u_78:Destroy()
		end)
		v_u_78:Play()
		local v_u_79 = v76.Instruments[v75].AnimationController.Animator:LoadAnimation(script[v75])
		v_u_21:Add(function()
			v_u_79:Stop(0)
			v_u_79:Destroy()
		end)
		v_u_79:Play()
		v_u_21:Add(v_u_78.DidLoop:Connect(function()
			v_u_79.TimePosition = 0
		end))
		local v80 = { v_u_79, v_u_78 }
		v_u_21:Add(v_u_28(v80))
		v_u_21:Add(v_u_31(v80))
	end

	v_u_21:Add(task.spawn(function()
		v_u_6:WaitForAssetId("rbxassetid://101252122546671")
		v_u_17.SoundId = ""
		v_u_17.SoundId = "rbxassetid://101252122546671"
		while not v_u_17.IsLoaded do
			task.wait()
		end
		v_u_17.TimePosition = workspace:GetServerTimeNow() - v_u_32.startedAt
		v_u_17:Play()
		v_u_21:Add(function()
			v_u_17:Stop()
		end)
	end))

	v_u_21:Add(v_u_20.OnClientEvent:Connect(function(p81)
		local v_u_82
		if typeof(p81) == "string" then
			local v83 = v_u_7:GetAnimals()[p81]
			if not v83 then return end
			local v84 = v83.AnimalModel
			local v85
			if v84.PrimaryPart then
				v85 = v84.PrimaryPart.CFrame
			else
				v85 = v84:GetPivot()
			end
			v_u_82 = v85.Position
			p81 = v83.AnimalModel.PrimaryPart
		else
			v_u_82 = p81:GetPivot().Position
		end
		task.spawn(function()
			v_u_9:PlaySound(v_u_1.Sounds.Events.STBANCAL.Hit, v_u_82)
		end)
		local v_u_86 = script.Burst:Clone()
		v_u_86:PivotTo(CFrame.new(v_u_82))
		v_u_86.Anchored = false
		local v87 = Instance.new("WeldConstraint")
		v87.Part0 = v_u_86
		v87.Part1 = p81
		v87.Parent = v_u_86
		v_u_86.Parent = workspace
		v_u_16.emit(v_u_86)
		task.delay(5, function()
			v_u_86:Destroy()
		end)
	end))

	local v88 = v_u_21
	local v89 = task.delay
	local v90 = v_u_32.startedAt + 28.5 - workspace:GetServerTimeNow()
	v88:Add(v89(math.max(v90, 0), function()
		v_u_21:Add(v_u_13.new())
		v_u_21:Add(v_u_12.observeCharacters(function(_, p_u_91)
			local v_u_92 = v_u_14.new()
			v_u_92:Add(task.spawn(function()
				local v_u_93 = p_u_91:WaitForChild("Humanoid")
				if v_u_93 then
					local v94 = v_u_93:WaitForChild("Animator")
					if v94 then
						local v_u_95 = v94:LoadAnimation(script.PlayerDance)
						v_u_95.Priority = Enum.AnimationPriority.Action
						local v_u_96 = nil
						local function v_u_102()
							if not v_u_96 then
								local v97 = v_u_92:Clone(script.PlayerMaracas)
								for _, v98 in v97:GetChildren() do
									local v99 = v98:FindFirstChildOfClass("RigidConstraint")
									if v99 then
										local v100 = v99.Attachment0
										if v100 then
											local v101 = p_u_91:FindFirstChild(v100.Name, true)
											if v101 and v101:IsA("Attachment") then
												v99.Attachment1 = v101
											end
										end
									end
								end
								v97.Parent = p_u_91
								v_u_96 = v97
							end
						end
						local v_u_103 = 0
						v_u_92:Add(v_u_3.PostSimulation:Connect(function(p104)
							debug.profilebegin("STBANCAL:Player:Dance")
							local v105 = v_u_32.startedAt + 43.5 - workspace:GetServerTimeNow()
							if math.max(v105, 0) > 0 then
								if not v_u_95.IsPlaying then
									v_u_95:Play()
									v_u_102()
								end
								debug.profileend()
							else
								if v_u_93.MoveDirection ~= Vector3.new(0, 0, 0) or v_u_18:GetAttribute("Stealing") then
									v_u_103 = 0
									if v_u_95.IsPlaying then
										v_u_95:Stop()
										if v_u_96 then
											v_u_92:Remove(v_u_96)
											v_u_96 = nil
										end
									end
								elseif v_u_103 < 3 then
									v_u_103 = v_u_103 + p104
								elseif not v_u_95.IsPlaying then
									v_u_95:Play()
									v_u_102()
								end
								debug.profileend()
							end
						end))
						v_u_92:Add(function()
							v_u_95:Stop()
							v_u_95:Destroy()
						end)
					end
				else
					return
				end
			end))
			return v_u_92:WrapClean()
		end))
	end))
end

function v5.OnStop(_)
	v_u_21:Destroy()
end

function v5.OnLoad(_)
	task.spawn(pcall, function()
		v_u_2:PreloadAsync(script:GetChildren())
	end)
	task.spawn(function()
		v_u_6:WaitForAssetId("rbxassetid://101252122546671")
		v_u_17.SoundId = "rbxassetid://101252122546671"
		v_u_2:PreloadAsync({ v_u_17 })
	end)
end

return v5