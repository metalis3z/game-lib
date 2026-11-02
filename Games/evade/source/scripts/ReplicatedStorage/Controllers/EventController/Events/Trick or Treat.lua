-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Lighting")
local v6 = game:GetService("Players")
local v_u_7 = game:GetService("Debris")
require(v_u_1.Shared.EventTypes)
local v8 = {}
require(v_u_1.Controllers.EncryptedAssetsController)
local v_u_9 = require(v_u_1.Controllers.AnimalController)
local v_u_10 = require(v_u_1.Controllers.EffectController)
require(v_u_1.Controllers.CameraController)
local v_u_11 = require(v_u_1.Controllers.SoundController)
local v_u_12 = require(v_u_1.Controllers.EventController)
local v_u_13 = require(v_u_1.Controllers.CycleController)
require(v_u_1.Shared.SharedEventUtils)
local v_u_14 = require(v_u_1.Packages.CreateTween)
require(v_u_1.Shared.TweenPivot)
local v_u_15 = require(v_u_1.Packages.Observers)
local v_u_16 = require(v_u_1.Utils.MathUtils)
local v_u_17 = require(v_u_1.Shared.Animals)
require(v_u_1.Packages.Signal)
local v_u_18 = require(v_u_1.Packages.Trove)
require(v_u_1.Packages.Shake)
local v_u_19 = require(v_u_1.Packages.Spr)
local v20 = require(v_u_1.Packages.Net)
local v_u_21 = require(v_u_1.Shared.VFX)
local v_u_22 = v6.LocalPlayer
local _ = workspace.CurrentCamera
local v_u_23 = script.Name
local v_u_24 = v20:RemoteEvent((("EventService/%*/BrainrotCandyAnimation"):format(v_u_23)))
local v_u_25 = v20:RemoteEvent((("EventService/%*/BrainrotHitAnimation"):format(v_u_23)))
local v_u_26 = v20:RemoteEvent((("EventService/%*/PlayerCandyAnimation"):format(v_u_23)))
local v_u_27 = v20:RemoteEvent((("EventService/%*/ScreenCandyAnimation"):format(v_u_23)))
local v_u_28 = v20:RemoteEvent((("EventService/%*/Burst"):format(v_u_23)))
local v_u_29 = v_u_18.new()
function v8.OnStart(_)
	-- upvalues: (copy) v_u_12, (copy) v_u_23, (copy) v_u_29, (copy) v_u_10, (copy) v_u_13, (copy) v_u_11, (copy) v_u_15, (copy) v_u_19, (copy) v_u_5, (copy) v_u_18, (copy) v_u_17, (copy) v_u_25, (copy) v_u_24, (copy) v_u_21, (copy) v_u_27, (copy) v_u_22, (copy) v_u_14, (copy) v_u_26, (copy) v_u_4, (copy) v_u_3, (copy) v_u_16
	local v30 = v_u_12:GetActiveEventData(v_u_23)
	assert(v30)
	v_u_29:Add(function()
		-- upvalues: (ref) v_u_10, (ref) v_u_13, (ref) v_u_11
		v_u_10:Activate("Blink")
		v_u_13:Update()
		v_u_11:UpdateOST()
	end)
	v_u_29:Clone(script.Map).Parent = workspace
	v_u_29:Add(v_u_15.observeTag("HideInTrickOrTreat", function(p_u_31)
		local v_u_32 = p_u_31.Parent
		p_u_31.Parent = script
		return function()
			-- upvalues: (copy) p_u_31, (copy) v_u_32
			pcall(function()
				-- upvalues: (ref) p_u_31, (ref) v_u_32
				p_u_31.Parent = v_u_32
			end)
		end
	end, { workspace, script }))
	v_u_10:Activate("Blink")
	v_u_13:Update()
	v_u_11:UpdateOST()
	v_u_10:Run("TrickOrTreatEvent", "GrassRecolor")
	v_u_10:Run("TrickOrTreatEvent", "WallRecolor")
	v_u_10:Run("TrickOrTreatEvent", "WallBottomRecolor")
	v_u_29:Add(function()
		-- upvalues: (ref) v_u_10
		v_u_10:Stop("TrickOrTreatEvent", "GrassRecolor")
		v_u_10:Stop("TrickOrTreatEvent", "WallRecolor")
		v_u_10:Stop("TrickOrTreatEvent", "WallBottomRecolor")
	end)
	v_u_29:Add(v_u_15.observeTag("TrickOrTreatDoor", function(p_u_33)
		-- upvalues: (ref) v_u_15, (ref) v_u_19
		local v_u_34 = p_u_33:GetPivot()
		return v_u_15.observeAttribute(p_u_33, "Open", function(p35)
			-- upvalues: (ref) v_u_19, (copy) p_u_33, (copy) v_u_34
			if p35 then
				v_u_19.target(p_u_33, 0.75, 3.5, {
					["Pivot"] = v_u_34 * CFrame.Angles(0, 1.5707963267948966, 0)
				})
			else
				local v36 = {
					["Pivot"] = v_u_34
				}
				v_u_19.target(p_u_33, 0.75, 3.5, v36)
			end
			return nil
		end)
	end))
	local v_u_37 = v_u_5:FindFirstChild("Cartoon")
	if v_u_37 then
		v_u_37.Parent = script
		v_u_29:Add(function()
			-- upvalues: (copy) v_u_37, (ref) v_u_5
			v_u_37.Parent = v_u_5
		end)
	end
	v_u_29:Clone(script.SkyTrickOrTreat).Parent = v_u_5
	local v_u_38 = v_u_5:FindFirstChild("Atmosphere")
	if v_u_38 then
		v_u_38.Parent = script
		v_u_29:Add(function()
			-- upvalues: (copy) v_u_38, (ref) v_u_5
			v_u_38.Parent = v_u_5
		end)
	end
	v_u_29:Clone(script.AtmosphereTrickOrTreat).Parent = v_u_5
	local function v_u_48(p39, p40, p41, p42)
		-- upvalues: (ref) v_u_18, (ref) v_u_17, (ref) v_u_29
		local v_u_43 = v_u_18.new()
		local v44 = v_u_17:GetAnimatedModel(p40, "Idle")
		if v44 then
			v_u_43:Add(v44)
			task.delay(p42 - workspace:GetServerTimeNow(), function()
				-- upvalues: (copy) v_u_43
				v_u_43:Destroy()
			end)
			v44.PrimaryPart.Anchored = true
			v44:PivotTo(p41)
			local v45 = v44:FindFirstChild("AnimationController"):FindFirstChild("Animator")
			local v46 = p39:FindFirstChild(p40)
			if v46 and v46:IsA("Animation") then
				local v_u_47 = v45:LoadAnimation(v46);
				(v_u_43 or v_u_29):Add(function()
					-- upvalues: (copy) v_u_47
					v_u_47:Stop(0)
					v_u_47:Destroy()
				end)
				v_u_47.Priority = Enum.AnimationPriority.Action4
				v_u_47.Looped = false
				task.delay(1, function()
					-- upvalues: (copy) v_u_47
					v_u_47:Play()
				end)
			end
		else
			return
		end
	end
	v_u_29:Add(v_u_25.OnClientEvent:Connect(function(p49, p50, p51)
		-- upvalues: (copy) v_u_48
		v_u_48(script.HitAnimations, p49, p50, p51)
	end))
	v_u_29:Add(v_u_24.OnClientEvent:Connect(function(p52, p53, p54)
		-- upvalues: (copy) v_u_48, (ref) v_u_21
		--v_u_48(script.Animations, p52, p53, p54)
		local v55 = p53 * CFrame.new(0, 0, -3) * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966) + Vector3.new(0, 6, 0)
		local v_u_56 = script.CandyCornThrow:Clone()
		v_u_56.CFrame = v55
		v_u_56.Parent = workspace
		task.delay(1, v_u_21.emit, v_u_56)
		task.delay(6, function()
			-- upvalues: (copy) v_u_56
			v_u_56:Destroy()
		end)
	end))
	v_u_29:Add(v_u_27.OnClientEvent:Connect(function(v_u_300)
		-- upvalues: (ref) v_u_22, (ref) v_u_14
		local v57 = Random.new()
		for i = 1, 20 do
			local v_u_58 = script.Image:Clone()
			v_u_58.Position = UDim2.fromScale(v57:NextNumber(-0.25, 1.25), -0.25)
			v_u_58.Rotation = v57:NextNumber(-120, 120)
			local v59 = v57:NextNumber(0.15, 0.2)
			v_u_58.Size = UDim2.fromScale(v59, v59)
			v_u_58.Parent = v_u_300.PlayerGui:FindFirstChild("Effects")
			v_u_14(v_u_58, TweenInfo.new(v57:NextNumber(0.75, 1.3), Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				["Position"] = v_u_58.Position + UDim2.fromScale(0, 1.5),
				["Rotation"] = v_u_58.Rotation + v57:NextInteger(-3, 3) * 10
			}, true).Completed:Once(function()
				-- upvalues: (copy) v_u_58
				task.wait(1)
				v_u_58:Destroy()
			end)
		end
	end))
	v_u_29:Add(v_u_26.OnClientEvent:Connect(function(p_u_60)
		-- upvalues: (ref) v_u_29, (ref) v_u_4, (ref) v_u_3, (ref) v_u_16
		local v_u_62 = 0
		local v_u_63 = script.CandyCorn:Clone()
		v_u_63.Parent = workspace
		local v_u_64 = nil
		v_u_64 = v_u_29:Add(v_u_4.PostSimulation:Connect(function(p65)
			-- upvalues: (ref) v_u_62, (copy) p_u_61, (copy) p_u_60, (ref) v_u_3, (copy) v_u_63, (ref) v_u_16, (ref) v_u_64, (ref) v_u_29
			debug.profilebegin("Trick or Treat:UpdateCandyCorn")
			v_u_62 = v_u_62 + p65
			local v66 = workspace:FindFirstChild(p_u_60.Name) or p_u_60.Character and p_u_60.Character:GetPivot().Position or Vector3.new(0, 0, 0)
			local v67 = p_u_60 + (v66 - p_u_60) * 0.5 + Vector3.new(0, 15, 0)
			local v68 = v_u_3:GetValue(v_u_62 / 0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
			v_u_63:PivotTo(CFrame.new(v_u_16.quadBezier(v68, p_u_60, v67, v66)))
			if v68 >= 1 and v_u_64 then
				v_u_29:Remove(v_u_64)
				v_u_64 = nil
				for _, v69 in v_u_63:GetDescendants() do
					if v69:IsA("BasePart") then
						v69.Transparency = 1
					end
				end
				task.delay(3, function()
					-- upvalues: (ref) v_u_63
					v_u_63:Destroy()
				end)
			end
			debug.profileend()
		end))
	end))
	v_u_29:Add(v_u_15.observeTag("TrickOrTreatEventPumpkin", function(p70)
		-- upvalues: (ref) v_u_18, (ref) v_u_29, (ref) v_u_15
		local v71 = v_u_18.new()
		local v72 = v71:Clone(script.Pumpkin)
		v72:ScaleTo(p70:GetAttribute("Scale") or 1)
		v72.Parent = workspace
		local v73 = Instance.new("Weld")
		v73.Part0 = v72.PrimaryPart
		v73.Part1 = p70
		v73.C0 = v72.PrimaryPart.PivotOffset
		v73.Parent = v72.PrimaryPart
		local v_u_74 = v72.AnimationController.Animator:LoadAnimation(script.Idle)
		v_u_29:Add(function()
			-- upvalues: (copy) v_u_74
			v_u_74:Stop(0)
			v_u_74:Destroy()
		end)
		v_u_74.Priority = Enum.AnimationPriority.Idle
		v_u_74.Looped = true
		v_u_74:Play()
		local v_u_75 = v72.AnimationController.Animator:LoadAnimation(script.Move)
		v_u_29:Add(function()
			-- upvalues: (copy) v_u_75
			v_u_75:Stop(0)
			v_u_75:Destroy()
		end)
		v_u_75.Priority = Enum.AnimationPriority.Action
		v_u_75.Looped = true
		v71:Add(v_u_15.observeAttribute(p70, "Moving", function(p76)
			-- upvalues: (copy) v_u_75
			if p76 then
				v_u_75:Play()
			else
				v_u_75:Stop()
			end
			return nil
		end))
		return v71:WrapClean()
	end, { workspace }))
end
function v8.OnStop(_)
	-- upvalues: (copy) v_u_29
	v_u_29:Destroy()
end
function v8.OnLoad(_)
	-- upvalues: (copy) v_u_2, (copy) v_u_28, (copy) v_u_9, (copy) v_u_29, (copy) v_u_21, (copy) v_u_7, (copy) v_u_11, (copy) v_u_1
	task.spawn(pcall, function()
		-- upvalues: (ref) v_u_2
		v_u_2:PreloadAsync(script:GetChildren())
	end)
	v_u_28.OnClientEvent:Connect(function(p77)
		-- upvalues: (ref) v_u_9, (ref) v_u_29, (ref) v_u_21, (ref) v_u_7, (ref) v_u_11, (ref) v_u_1
		local v78 = v_u_9:GetAnimals()[p77]
		
		if v78 then
			local v79 = v78.AnimalModel
			local v80
			if v79 then
				v80 = v79.PrimaryPart
			else
				v80 = v79
			end
			local v81 = v78.Instance
			local v82
			if v81 then
				v82 = v81.PrimaryPart
			else
				v82 = v81
			end
			if v82 and v80 then
				local v83 = v_u_29:Clone(script.Burst)
				v83:PivotTo(v82.CFrame * CFrame.new(0, (v83.Size.Y + v79:GetExtentsSize().Y) / 2, 0))
				v83.Parent = v81
				local v84 = Instance.new("WeldConstraint")
				v84.Part0 = v83
				v84.Part1 = v78.AnimalModel.PrimaryPart
				v84.Parent = v83
				v_u_21.emit(v83)
				v_u_7:AddItem(v83, 5)
				v_u_11:PlaySound(v_u_1.Sounds.Events["Trick or Treat"].BrainrotHit, v82.CFrame.Position, false)
			end
		else
			return
		end
	end)
end
return v8
