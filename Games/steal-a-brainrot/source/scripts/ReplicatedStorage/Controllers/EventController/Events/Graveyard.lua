---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("ContextActionService")
local v_u_2 = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local v_u_3 = game:GetService("ContentProvider")
game:GetService("TweenService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Lighting")
local v6 = game:GetService("Players")
local v_u_7 = game:GetService("Debris")
require(v_u_2.Shared.EventTypes)
local v8 = {}
require(v_u_2.Controllers.EncryptedAssetsController)
local v_u_9 = require(v_u_2.Controllers.AnimalController)
local v_u_10 = require(v_u_2.Controllers.EffectController)
require(v_u_2.Controllers.CameraController)
local v_u_11 = require(v_u_2.Controllers.SoundController)
local v_u_12 = require(v_u_2.Controllers.EventController)
local v_u_13 = require(v_u_2.Controllers.CycleController)
require(v_u_2.Shared.SharedEventUtils)
require(v_u_2.Packages.CreateTween)
require(v_u_2.Shared.TweenPivot)
local v_u_14 = require(v_u_2.Packages.Observers)
require(v_u_2.Utils.MathUtils)
local v_u_15 = require(v_u_2.Packages.FFlags)
require(v_u_2.Packages.Signal)
require(v_u_2.Packages.Spring)
local v_u_16 = require(v_u_2.Packages.Trove)
require(v_u_2.Packages.Shake)
local v_u_17 = require(v_u_2.Packages.Spr)
local v18 = require(v_u_2.Packages.Net)
local v_u_19 = require(v_u_2.Shared.VFX)
local v_u_20 = v6.LocalPlayer
local v_u_21 = v_u_20.PlayerGui:WaitForChild("Digging")
local _ = workspace.CurrentCamera
local v_u_22 = script.Name
local v_u_23 = v18:RemoteEvent((("EventService/%*/DigStart"):format(v_u_22)))
local v_u_24 = v18:RemoteEvent((("EventService/%*/DigEnd"):format(v_u_22)))
local v_u_25 = v18:RemoteEvent((("EventService/%*/PlayGraveyardAnimation"):format(v_u_22)))
local v_u_26 = v18:RemoteEvent((("EventService/%*/DigCollectVFX"):format(v_u_22)))
local v_u_27 = v18:RemoteEvent((("EventService/%*/Burst"):format(v_u_22)))
local v_u_28 = v_u_16.new()
function v8.OnStart(_)
	-- upvalues: (copy) v_u_12, (copy) v_u_22, (copy) v_u_28, (copy) v_u_10, (copy) v_u_13, (copy) v_u_11, (copy) v_u_14, (copy) v_u_5, (copy) v_u_20
	local v29 = v_u_12:GetActiveEventData(v_u_22)
	assert(v29)
	v_u_28:Add(function()
		-- upvalues: (ref) v_u_10, (ref) v_u_13, (ref) v_u_11
		v_u_10:Activate("Blink")
		v_u_13:Update()
		v_u_11:UpdateOST()
	end)
	v_u_28:Clone(script.Map).Parent = workspace
	v_u_28:Add(v_u_14.observeTag("HideInGraveyard", function(p_u_30)
		local v_u_31 = p_u_30.Parent
		p_u_30.Parent = script
		return function()
			-- upvalues: (copy) p_u_30, (copy) v_u_31
			pcall(function()
				-- upvalues: (ref) p_u_30, (ref) v_u_31
				p_u_30.Parent = v_u_31
			end)
		end
	end, { workspace, script }))
	v_u_28:Add(v_u_14.observeTag("HideInGraveyardTransparency", function(p_u_32)
		p_u_32.Transparency = 1
		return function()
			-- upvalues: (copy) p_u_32
			p_u_32.Transparency = 0
		end
	end, { workspace }))
	v_u_10:Activate("Blink")
	v_u_13:Update()
	v_u_11:UpdateOST()
	v_u_10:Run("GraveyardEvent", "GrassRecolor")
	v_u_10:Run("GraveyardEvent", "WallRecolor")
	v_u_10:Run("GraveyardEvent", "WallBottomRecolor")
	v_u_28:Add(function()
		-- upvalues: (ref) v_u_10
		v_u_10:Stop("GraveyardEvent", "GrassRecolor")
		v_u_10:Stop("GraveyardEvent", "WallRecolor")
		v_u_10:Stop("GraveyardEvent", "WallBottomRecolor")
	end)
	local v_u_33 = v_u_5:FindFirstChild("Atmosphere")
	if v_u_33 then
		v_u_33.Parent = script
		v_u_28:Add(function()
			-- upvalues: (copy) v_u_33, (ref) v_u_5
			v_u_33.Parent = v_u_5
		end)
	end
	v_u_28:Clone(script.AtmosphereGraveyard).Parent = v_u_5
	v_u_28:Add(v_u_14.observeCharacter(v_u_20, function(_, p_u_34)
		-- upvalues: (ref) v_u_14, (ref) v_u_28
		return v_u_14.observeChildren(p_u_34, function(p35)
			-- upvalues: (copy) p_u_34, (ref) v_u_28
			if not p35:IsA("Tool") or p35.Name ~= "Agarrini Shovel" then
				return nil
			end
			local v36 = p_u_34:FindFirstChildWhichIsA("Animator", true)
			if not v36 then
				return nil
			end
			local v_u_37 = v36:LoadAnimation(script.Idle)
			v_u_28:Add(function()
				-- upvalues: (copy) v_u_37
				v_u_37:Stop(0)
				v_u_37:Destroy()
			end)
			v_u_37:Play(0)
			return function()
				-- upvalues: (copy) v_u_37
				v_u_37:Stop()
			end
		end)
	end))
end
function v8.OnStop(_)
	-- upvalues: (copy) v_u_28
	v_u_28:Destroy()
end
function v8.OnLoad(_)
	-- upvalues: (copy) v_u_3, (copy) v_u_16, (copy) v_u_23, (copy) v_u_21, (copy) v_u_15, (copy) v_u_4, (copy) v_u_17, (copy) v_u_14, (copy) v_u_20, (copy) v_u_28, (copy) v_u_1, (copy) v_u_11, (copy) v_u_2, (copy) v_u_24, (copy) v_u_26, (copy) v_u_19, (copy) v_u_27, (copy) v_u_9, (copy) v_u_7, (copy) v_u_25
	task.spawn(pcall, function()
		-- upvalues: (ref) v_u_3
		v_u_3:PreloadAsync(script:GetChildren())
	end)
	local v_u_38 = v_u_16.new()
	v_u_23.OnClientEvent:Connect(function(p_u_39, p_u_40)
		-- upvalues: (copy) v_u_38, (ref) v_u_21, (ref) v_u_15, (ref) v_u_4, (ref) v_u_17, (ref) v_u_14, (ref) v_u_20, (ref) v_u_16, (ref) v_u_28, (ref) v_u_1, (ref) v_u_11, (ref) v_u_2, (ref) v_u_24
		v_u_38:Clean()
		local v_u_41 = v_u_21.Fillbar.Fill
		local v_u_42 = v_u_21.Fillbar.Mover
		local v_u_43 = v_u_21.Fillbar.LabelHolder.TextLabel
		local v_u_44 = v_u_21.Fillbar.LabelHolder.UIScale
		v_u_21.Fillbar.Visible = true
		local v_u_45 = 0
		local v_u_46 = v_u_15:GetInstant("GraveyardDigDecreaseTimer", 0.7)
		local v_u_47 = v_u_15:GetInstant("GraveyardDigDecreaseAmount", 0.1)
		local v_u_48 = 0
		v_u_38:Add(v_u_4.PostSimulation:Connect(function(p49)
			-- upvalues: (ref) v_u_48, (copy) v_u_46, (copy) v_u_47, (copy) p_u_40, (ref) v_u_45, (ref) v_u_17, (copy) v_u_41, (copy) v_u_42
			v_u_48 = v_u_48 + p49
			if v_u_48 >= v_u_46 then
				v_u_48 = 0
				local v50 = v_u_45 - v_u_47 * p_u_40
				v_u_45 = math.max(v50, 0)
				v_u_17.target(v_u_41, 1, 7, {
					["Size"] = UDim2.fromScale(v_u_45, 1)
				})
				v_u_17.target(v_u_42, 1, 7, {
					["Position"] = UDim2.fromScale(v_u_45, 0.5)
				})
			end
		end))
		local v_u_51 = nil
		v_u_38:Add(v_u_14.observeCharacter(v_u_20, function(_, p52)
			-- upvalues: (ref) v_u_14, (ref) v_u_16, (ref) v_u_28, (ref) v_u_51
			return v_u_14.observeChildren(p52, function(p53)
				-- upvalues: (ref) v_u_14, (ref) v_u_16, (ref) v_u_28, (ref) v_u_51
				if p53:IsA("Humanoid") then
					return v_u_14.observeChildren(p53, function(p54)
						-- upvalues: (ref) v_u_16, (ref) v_u_28, (ref) v_u_51
						if not p54:IsA("Animator") then
							return nil
						end
						local v55 = v_u_16.new()
						local v_u_56 = p54:LoadAnimation(script.Dig)
						v_u_28:Add(function()
							-- upvalues: (copy) v_u_56
							v_u_56:Stop(0)
							v_u_56:Destroy()
						end)
						v_u_51 = v_u_56
						v55:Add(function()
							-- upvalues: (ref) v_u_51, (copy) v_u_56
							if v_u_51 == v_u_56 then
								v_u_51 = nil
							end
						end)
						return v55:WrapClean()
					end)
				else
					return nil
				end
			end)
		end))
		local v_u_57 = v_u_15:GetInstant("GraveyardDigIncreasePerClick", 0.04)
		local v_u_58 = v_u_15:GetInstant("GraveyardDigClickCooldown", 0.05)
		local v_u_59 = 0
		local v_u_60 = 0
		v_u_1:BindActionAtPriority("Dig", function(_, p61, _)
			-- upvalues: (ref) v_u_59, (copy) v_u_58, (ref) v_u_45, (copy) v_u_57, (ref) v_u_60, (copy) v_u_43, (ref) v_u_51, (ref) v_u_11, (ref) v_u_2, (ref) v_u_17, (copy) v_u_41, (copy) v_u_42, (copy) v_u_44, (ref) v_u_24, (copy) p_u_39
			if p61 ~= Enum.UserInputState.Begin then
				return Enum.ContextActionResult.Pass
			end
			local v62 = os.clock()
			if v62 - v_u_59 < v_u_58 then
				return Enum.ContextActionResult.Sink
			end
			local v63 = v_u_45 + v_u_57
			v_u_45 = math.min(v63, 1)
			v_u_59 = v62
			v_u_60 = v_u_60 + 1
			v_u_43.Text = ("Click Anywhere! (%*)"):format((string.format("%0.3d", v_u_60)))
			if v_u_51 and not v_u_51.IsPlaying then
				v_u_51:Play()
				v_u_11:PlaySound(v_u_2.Sounds.Events.Graveyard.Dig, nil, false)
			end
			v_u_17.target(v_u_41, 1, 7, {
				["Size"] = UDim2.fromScale(v_u_45, 1)
			})
			v_u_17.target(v_u_42, 1, 7, {
				["Position"] = UDim2.fromScale(v_u_45, 0.5)
			})
			v_u_17.stop(v_u_44)
			v_u_44.Scale = 1.2
			v_u_17.target(v_u_44, 0.8, 5, {
				["Scale"] = 1
			})
			if v_u_45 >= 1 then
				v_u_24:FireServer(p_u_39)
			end
			return Enum.ContextActionResult.Sink
		end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.ButtonX, Enum.UserInputType.Touch, Enum.UserInputType.MouseButton1)
		v_u_38:Add(function()
			-- upvalues: (ref) v_u_17, (copy) v_u_44, (copy) v_u_42, (copy) v_u_41, (copy) v_u_43
			v_u_17.stop(v_u_44)
			v_u_17.stop(v_u_42)
			v_u_17.stop(v_u_41)
			v_u_41.Size = UDim2.fromScale(0, 1)
			v_u_42.Position = UDim2.fromScale(0, 0.5)
			v_u_44.Scale = 1
			v_u_43.Text = ("Click Anywhere! (%*)"):format((string.format("%0.3d", 0)))
		end)
		v_u_38:Add(function()
			-- upvalues: (ref) v_u_1
			v_u_1:UnbindAction("Dig")
		end)
	end)
	v_u_24.OnClientEvent:Connect(function()
		-- upvalues: (ref) v_u_21, (copy) v_u_38
		v_u_21.Fillbar.Visible = false
		v_u_38:Clean()
	end)
	v_u_26.OnClientEvent:Connect(function(p64, p65)
		-- upvalues: (ref) v_u_19, (ref) v_u_11
		local v66 = script.DigVFX:FindFirstChild(p65)
		if v66 then
			local v_u_67 = v66:Clone()
			v_u_67:PivotTo(p64)
			v_u_67.Parent = workspace
			v_u_19.emit(v_u_67)
			task.delay(5, function()
				-- upvalues: (copy) v_u_67
				v_u_67:Destroy()
			end)
			local v68 = v66:FindFirstChild("SFX")
			if v68 then
				v_u_11:PlaySound(v68, p64.Position + Vector3.new(0, 3, 0), false)
			end
		end
	end)
	v_u_27.OnClientEvent:Connect(function(p69)
		-- upvalues: (ref) v_u_9, (ref) v_u_28, (ref) v_u_19, (ref) v_u_7, (ref) v_u_11, (ref) v_u_2
		local v70 = v_u_9:GetAnimals()[p69]
		if v70 then
			local v71 = v70.AnimalModel
			local v72
			if v71 then
				v72 = v71.PrimaryPart
			else
				v72 = v71
			end
			local v73 = v70.Instance
			local v74
			if v73 then
				v74 = v73.PrimaryPart
			else
				v74 = v73
			end
			if v74 and v72 then
				local v75 = v_u_28:Clone(script.Burst)
				v75:PivotTo(v74.CFrame * CFrame.new(0, (v75.Size.Y + v71:GetExtentsSize().Y) / 2, 0))
				v75.Parent = v73
				local v76 = Instance.new("WeldConstraint")
				v76.Part0 = v75
				v76.Part1 = v70.AnimalModel.PrimaryPart
				v76.Parent = v75
				v_u_19.emit(v75)
				v_u_7:AddItem(v75, 5)
				v_u_11:PlaySound(v_u_2.Sounds.Events.Graveyard.BrainrotHit, v74.CFrame.Position, false)
			end
		else
			return
		end
	end)
	v_u_25.OnClientEvent:Connect(function(p77, p78)
		-- upvalues: (ref) v_u_9
		local v79 = v_u_9:GetAnimals()[p78]
		if v79 then
			local v80 = script.Animations:FindFirstChild(p77)
			if v80 then
				local v81 = v79.AnimalModel
				local v82 = v81:FindFirstChild("AnimationController") or Instance.new("AnimationController", v81)
				local v_u_83 = (v82:FindFirstChild("Animator") or Instance.new("Animator", v82)):LoadAnimation(v80)
				v_u_83.Priority = Enum.AnimationPriority.Action4
				v_u_83.Looped = false
				v_u_83:Play()
				v_u_83.Ended:Connect(function()
					-- upvalues: (copy) v_u_83
					v_u_83:Stop(0)
					v_u_83:Destroy()
				end)
			end
		else
			return
		end
	end)
end
return v8
