game:GetService("ServerScriptService")
local v_u_1 = game:GetService("SoundService")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local v_u_4 = game:GetService("ReplicatedStorage")
local v_u_5 = game:GetService("TweenService")
local v_u_6 = require(v_u_4.Packages.Trove)
local v7 = require(v_u_4.Shared.RegisterTool)
local v_u_8 = require(v_u_4.Controllers.AnimalController)
local v_u_9 = require(v_u_4.Controllers.FishingController)
require(v_u_4.Shared.PID)
local v_u_10 = require(v_u_4.Utils.MathUtils)
local v11 = require(v_u_4.Packages.Net)
local v12 = require(v_u_4.Packages.Spring)
local v_u_13 = workspace.CurrentCamera
local v_u_14 = v3.LocalPlayer
local v_u_15 = v_u_14.PlayerGui:WaitForChild("ToolGuis").Fishing
local v_u_16 = v11:RemoteEvent("FishingRod.Cast")
local v_u_17 = v11:RemoteEvent("FishingRod.Cancel")
local v18 = v11:RemoteEvent("FishingRod.SetupBobber")
local v_u_19 = v11:RemoteEvent("FishingRod.MinigameClick")
local v20 = v11:RemoteEvent("FishingRod.Reward")
local v21 = v11:RemoteEvent("FishingRod.BiteGot")
Random.new()
local v_u_22 = v12.new()
v_u_22.Speed = 45
v_u_22.Damper = 0.8
local v_u_23 = v12.new(0.1)
v_u_23.Speed = 2
v_u_23.Damper = 1
local v_u_24 = v12.new(70)
v_u_24.Speed = 30
v_u_24.Damper = 1
local v_u_25 = v_u_15.Fillbar.Mover
local v_u_26 = false
local v_u_27 = false
v_u_2.Heartbeat:Connect(function()
	-- upvalues: (ref) v_u_26, (copy) v_u_25, (copy) v_u_22, (copy) v_u_24, (copy) v_u_23, (copy) v_u_13, (ref) v_u_27, (copy) v_u_5
	if v_u_26 then
		v_u_25.Rotation = v_u_22.p
		v_u_24.t = 80 + 10 * v_u_23.p
		v_u_13.FieldOfView = v_u_24.p
		v_u_27 = true
	elseif v_u_27 then
		v_u_27 = false
		v_u_24.t = 70
		v_u_24.p = 70
		v_u_24.v = 0
		v_u_5:Create(v_u_13, TweenInfo.new(0.25), {
			["FieldOfView"] = 70
		}):Play()
	end
end)
local v_u_28 = {}
v7("FishingRod", function(p_u_29)
	-- upvalues: (copy) v_u_6, (copy) v_u_14, (copy) v_u_2, (copy) v_u_23, (copy) v_u_1, (copy) v_u_15, (copy) v_u_5, (ref) v_u_26, (copy) v_u_19, (copy) v_u_17, (copy) v_u_16, (copy) v_u_28
	local v30 = v_u_6.new()
	local v_u_31 = v30:Extend()
	local v_u_32 = false
	local v_u_33 = 0
	local v_u_34 = 0
	local v_u_35 = 0
	local v_u_36 = (v_u_14.Character or v_u_14.CharacterAdded:Wait()):WaitForChild("Humanoid")
	local v_u_37 = {}
	local function v43()
		-- upvalues: (ref) v_u_14, (copy) v_u_36, (copy) v_u_37
		local v38 = v_u_14:GetAttribute("EquippedFishingRod")
		for _, v39 in (script:FindFirstChild(v38) or script["Ice Rod"]):GetChildren() do
			local v40 = v39.Name
			local v41 = v_u_36:LoadAnimation(v39)
			v41.Looped = v39:GetAttribute("Looped")
			v41.Priority = v39:GetAttribute("Priority")
			local v42 = v_u_37[v40]
			if v42 then
				if v42.IsPlaying and v42.Looped then
					v41:Play()
				end
				v42:Stop()
			end
			v_u_37[v40] = v41
		end
	end
	v43()
	v30:Add(v_u_14:GetAttributeChangedSignal("EquippedFishingRod"):Connect(v43))
	v30:Add(v_u_2.Stepped:Connect(function()
		-- upvalues: (copy) p_u_29, (ref) v_u_23, (copy) v_u_37
		local v44 = p_u_29:FindFirstChild("Reeling", true)
		if v44 then
			v44.PlaybackSpeed = 0.9 + v_u_23.p * 0.1
			v44.Volume = 0.3 + v_u_23.p * 0.3
		end
		v_u_37.Reeling:AdjustSpeed(v_u_23.p)
	end))
	local function v_u_49()
		-- upvalues: (ref) v_u_33, (copy) p_u_29, (ref) v_u_35, (ref) v_u_23, (ref) v_u_1, (ref) v_u_15, (ref) v_u_5
		if v_u_33 then
			local v45 = v_u_33 / p_u_29:GetAttribute("minigameHP")
			if v_u_35 < v_u_33 then
				local v46 = 0.2 + 0.6 * v45
				local v47 = v_u_23
				local v48 = v_u_23.p + v46
				v47.p = math.clamp(v48, 0.1, 1.3)
				v_u_23.t = 0.1
				v_u_1:PlayLocalSound(v_u_15.Click)
			end
			v_u_5:Create(v_u_15.Fillbar.Fill, TweenInfo.new(0.2), {
				["Size"] = UDim2.fromScale(v45, 1)
			}):Play()
			v_u_5:Create(v_u_15.Fillbar.Mover, TweenInfo.new(0.25), {
				["Position"] = UDim2.fromScale(math.lerp(0, 0.875, v45), 0.5)
			}):Play()
			v_u_35 = v_u_33
		end
	end
	local function v_u_50()
		-- upvalues: (ref) v_u_34, (ref) v_u_15, (ref) v_u_5
		if v_u_34 then
			if string.format("%.3d", v_u_34) == 0 then
				v_u_15.Fillbar.TextLabel.Text = "Click Anywhere!"
			else
				v_u_15.Fillbar.TextLabel.Text = ("Click Anywhere! (x%*)"):format(v_u_34)
			end
			v_u_15.Fillbar.TextLabel.Size = UDim2.fromScale(0.568, 0.75)
			v_u_5:Create(v_u_15.Fillbar.TextLabel, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
				["Size"] = UDim2.fromScale(0.7, 0.85)
			}):Play()
		end
	end
	v30:Add(p_u_29:GetAttributeChangedSignal("minigameHits"):Connect(function()
		-- upvalues: (ref) v_u_33, (copy) p_u_29, (copy) v_u_49
		v_u_33 = p_u_29:GetAttribute("minigameHits")
		v_u_49()
	end))
	v30:Add(p_u_29:GetAttributeChangedSignal("minigameTotalHits"):Connect(function()
		-- upvalues: (ref) v_u_34, (copy) p_u_29, (copy) v_u_50
		v_u_34 = p_u_29:GetAttribute("minigameTotalHits")
		v_u_50()
	end))
	v30:Add(p_u_29:GetAttributeChangedSignal("minigame"):Connect(function()
		-- upvalues: (copy) p_u_29, (copy) v_u_37, (ref) v_u_15, (ref) v_u_26
		if p_u_29:GetAttribute("minigame") then
			print("Found")
			v_u_26 = true
			v_u_37.Reeling:Play()
			v_u_15.Fillbar.Visible = true
		else
			v_u_37.Reeling:Stop()
			v_u_26 = false
			print("not Found")
			-- Stop any tweens on Fill and Mover first
			v_u_5:Create(v_u_15.Fillbar.Fill, TweenInfo.new(0), { Size = UDim2.fromScale(1, 0) }):Play()
			v_u_5:Create(v_u_15.Fillbar.Mover, TweenInfo.new(0), { Position = UDim2.fromScale(0.2, 0) }):Play()

			-- Also reset text
			v_u_15.Fillbar.TextLabel.Text = "Click Anywhere!"

			v_u_15.Fillbar.Visible = false
		end
	end))
	v30:Add(p_u_29:GetAttributeChangedSignal("casted"):Connect(function()
		-- upvalues: (copy) p_u_29, (ref) v_u_23, (copy) v_u_37
		if p_u_29:GetAttribute("casted") and not p_u_29:GetAttribute("minigame") then
			v_u_23.p = 0
			v_u_23.v = 0
			v_u_23.t = 0
			v_u_37.Reeling:Play()
		elseif not (p_u_29:GetAttribute("casted") or p_u_29:GetAttribute("minigame")) then
			v_u_37.Reeling:Stop()
		end
	end))
	v30:Add(p_u_29.Equipped:Connect(function()
		-- upvalues: (ref) v_u_32, (ref) v_u_15, (copy) v_u_37
		v_u_32 = true
		v_u_15.Enabled = true
		v_u_15.Fillbar.Visible = false
		v_u_15.CastBar.Enabled = false
		v_u_37.Idle:Play()
	end))
	v30:Add(p_u_29.Unequipped:Connect(function()
		-- upvalues: (ref) v_u_32, (ref) v_u_15, (copy) v_u_31, (copy) v_u_37
		v_u_32 = false
		v_u_15.Enabled = false
		v_u_31:Destroy()
		for _, v51 in v_u_37 do
			v51:Stop()
		end
	end))
	local v_u_52 = false
	local v_u_53 = -1
	v30:Add(p_u_29.Activated:Connect(function()
		-- upvalues: (ref) v_u_14, (copy) p_u_29, (ref) v_u_53, (ref) v_u_33, (ref) v_u_34, (copy) v_u_50, (copy) v_u_49, (ref) v_u_19, (ref) v_u_17, (ref) v_u_52, (ref) v_u_15, (copy) v_u_31, (copy) v_u_37, (ref) v_u_32, (ref) v_u_16
		local v54 = v_u_14.Character:FindFirstChild("HumanoidRootPart")
		if p_u_29:GetAttribute("minigame") then
			if time() - v_u_53 >= 0.1 then
				v_u_53 = time()
				v_u_33 = v_u_33 + 1
				v_u_34 = v_u_34 + 1
				v_u_50()
				v_u_49()
				v_u_19:FireServer()
			end
		elseif p_u_29:GetAttribute("casted") then
			v_u_17:FireServer()
			return
		elseif p_u_29:GetAttribute("castCooldown") then
			return
		else
			v_u_52 = true
			v_u_15.CastBar.Enabled = true
			v_u_15.CastBar.Adornee = v54
			v_u_31:Add(function()
				-- upvalues: (ref) v_u_15
				v_u_15.CastBar.Enabled = false
			end)
			local v55 = time()
			local v56 = nil
			local v_u_57 = p_u_29:GetAttribute("Luck") or 1
			v_u_31:Add(p_u_29:GetAttributeChangedSignal("Luck"):Connect(function()
				-- upvalues: (ref) v_u_57, (ref) p_u_29
				v_u_57 = p_u_29:GetAttribute("Luck") or 1
			end))
			v_u_37.HoldingCast:Play()
			v_u_37.HoldingCast:AdjustSpeed(1)
			v_u_31:Add(function()
				-- upvalues: (ref) v_u_37
				v_u_37.HoldingCast:Stop()
			end)
			local v58 = v_u_57
			while v_u_52 and v_u_32 do
				local v59 = (time() - v55) % 1
				if v59 > 0.5 then
					v59 = 1 - v59
				end
				local v60 = v59 / 0.5
				if v60 >= 0.85 then
					v56 = 1
				else
					local v61 = v60 / 0.85
					if v61 < 0.5 then
						v56 = 2 * v61 * v61
					else
						v56 = -1 + (4 - 2 * v61) * v61
					end
				end
				v_u_15.CastBar.Bar.Bar.Fill.Size = UDim2.fromScale(1, v56)
				v_u_15.CastBar.Bar.Luck.Size = UDim2.fromScale(8, 0.14 + 0.05 * v56)
				local v62 = v_u_15.CastBar.Bar.Luck
				local v63 = math.lerp(1, v58, v56) * 100
				v62.Text = ("LUCK: %*x"):format(math.floor(v63) / 100)
				if not v_u_37.HoldingCast.IsPlaying then
					v_u_37.HoldingCast:Play()
					v_u_37.HoldingCast.TimePosition = v_u_37.HoldingCast.Length - 0.01
					v_u_37.HoldingCast:AdjustSpeed(0)
				end
				task.wait()
			end
			v_u_31:Destroy()
			if v_u_32 then
				v_u_37.Cast:Play()
				v_u_16:FireServer(v56)
			end
		end
	end))
	v30:Add(p_u_29.Deactivated:Connect(function()
		-- upvalues: (ref) v_u_52, (copy) v_u_31
		v_u_52 = false
		v_u_31:Destroy()
	end))
	v_u_28[p_u_29] = {
		["animTracks"] = v_u_37
	}
	v30:Add(function()
		-- upvalues: (ref) v_u_26, (ref) v_u_32, (ref) v_u_15, (ref) v_u_28, (copy) p_u_29, (copy) v_u_37
		v_u_26 = false
		v_u_32 = false
		v_u_15.Enabled = false
		v_u_28[p_u_29] = nil
		for _, v64 in v_u_37 do
			v64:Stop()
		end
	end)
	return v30:WrapClean()
end)
v18.OnClientEvent:Connect(function(p_u_65, p66)
	-- upvalues: (copy) v_u_4, (copy) v_u_2, (copy) v_u_10, (copy) v_u_9
	local v_u_67 = p_u_65.PrimaryPart
	v_u_67.AssemblyLinearVelocity = p66
	local v_u_68 = Instance.new("BodyVelocity")
	v_u_68.MaxForce = Vector3.new(0, 0, 0)
	v_u_68.Velocity = Vector3.new(0, 0, 0)
	v_u_68.Parent = v_u_67
	require(v_u_4.Shared.PID).new(-16, 16, 36, 1.5, 0.1)
	local v_u_69 = workspace:FindFirstChild("FishingMap") and workspace:FindFirstChild("FishingMap"):QueryDescendants("#CatchZone") or {}
	local v_u_70 = nil
	v_u_70 = v_u_2.Stepped:Connect(function(_)
		-- upvalues: (copy) p_u_65, (ref) v_u_70, (copy) v_u_69, (ref) v_u_10, (copy) v_u_67, (copy) v_u_68, (ref) v_u_9, (ref) v_u_2
		if not (p_u_65 and p_u_65:IsDescendantOf(workspace)) then
			v_u_70:Disconnect()
			return
		end
		local v71 = nil
		for _, v72 in v_u_69 do
			if v_u_10.isPointInVolume(v_u_67.CFrame.Position, v72.CFrame, v72.Size + Vector3.new(0, 1.5, 0)) then
				v71 = v72
				break
			end
		end
		if v71 then
			local v73 = v_u_68
			local v74 = 32 + v_u_67.AssemblyMass * 32
			local v75 = 32 + v_u_67.AssemblyMass * 32
			v73.MaxForce = Vector3.new(v74, 1000000000, v75)
			local v_u_76 = v_u_9:WaterSurfacePoint(v_u_67.Position).Y
			v_u_68.Velocity = Vector3.new(0, 0, 0)
			v_u_2.RenderStepped:Once(function()
				-- upvalues: (ref) v_u_67, (copy) v_u_76
				v_u_67.CFrame = CFrame.new(v_u_67.Position.X, v_u_76, v_u_67.Position.Z)
			end)
		end
	end)
end)
v20.OnClientEvent:Connect(function(p77, p78, p_u_79, _, p_u_80, _)
	-- upvalues: (copy) v_u_14, (copy) v_u_28, (copy) v_u_4, (copy) v_u_2, (copy) v_u_8
	if p77 == v_u_14 then
		v_u_28[p78].animTracks.Catch:Play()
	end
	local v81 = p77.Character
	if v81 then
		v81 = p77.Character:FindFirstChild("HumanoidRootPart")
	end
	if v81 then
		local v_u_82 = v81.Position - Vector3.new(0, 3, 0)
		local v_u_83 = v_u_82:Lerp(p_u_79, 0.3) + Vector3.new(0, 20, 0)
		local v_u_84 = v_u_4.Models.ToolsExtras.FishingCatch:Clone()
		v_u_84.CFrame = CFrame.new(0, 10000, 0)
		v_u_84.Transparency = 1
		v_u_84.Parent = workspace.Debris
		local v_u_85 = nil
		local v_u_86 = 0
		local v_u_87 = nil
		v_u_87 = v_u_2.PreRender:Connect(function(p88)
			-- upvalues: (ref) v_u_86, (ref) v_u_87, (copy) v_u_84, (copy) p_u_79, (copy) v_u_82, (copy) v_u_83, (ref) v_u_8, (copy) p_u_80, (ref) v_u_85
			v_u_86 = v_u_86 + p88
			if v_u_86 >= 0.5 then
				if v_u_87 then
					v_u_87:Disconnect()
				end
				task.wait(2)
				v_u_84:Destroy()
				return
			else
				local v89 = p_u_79
				local v90 = v_u_82
				local v91 = v_u_83
				local v92 = v_u_86 / 0.5
				local v93 = 1 - v92
				local v94 = v89 * (v93 * v93) + v91 * (2 * v93 * v92) + v90 * (v92 * v92)
				local v95 = p_u_79
				local v96 = v_u_82
				local v97 = v_u_83
				local v98 = v_u_86 / 0.5 + 0.01
				local v99 = 1 - v98
				local v100 = v95 * (v99 * v99) + v97 * (2 * v99 * v98) + v96 * (v98 * v98)
				v_u_84.CFrame = CFrame.lookAt(v94, v100)
				local v101 = v_u_8:GetAnimals()[p_u_80]
				if v101 then
					local v102 = v101.AnimalModel
					if not v_u_85 then
						v_u_85 = v102:GetScale()
					end
					local v103 = v_u_85 * v_u_86 / 0.5
					v102:ScaleTo((math.max(v103, 0.01)))
					v102:PivotTo(CFrame.new(v94))
				end
			end
		end)
	end
end)
v21.OnClientEvent:Connect(function(_, _)
	-- remove the p104 check
	local player = game.Players.LocalPlayer  -- the client is always the local player

	local character = player.Character or player.CharacterAdded:Wait()
	local head = character:FindFirstChild("Head")
	if not head then return end

	local exclamation = script.FishingGotBite:Clone()
	exclamation.Adornee = head
	exclamation.Parent = head
	exclamation.Exclamation:Play()

	local textLabel = exclamation.TextLabel
	textLabel.Rotation = 15
	textLabel.Size = UDim2.fromScale(0, 0)
	textLabel.Position = UDim2.fromScale(0.5, 1)
	v_u_5:Create(textLabel, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Rotation = 0,
		Size = UDim2.fromScale(1, 1)
	}):Play()

	task.delay(2, function()
		if textLabel:IsDescendantOf(game) then
			v_u_5:Create(textLabel, TweenInfo.new(2), { TextTransparency = 1 }):Play()
			v_u_5:Create(textLabel.UIStroke, TweenInfo.new(2), { Transparency = 1 }):Play()
		end
		task.wait(2)
		exclamation:Destroy()
	end)
end)
