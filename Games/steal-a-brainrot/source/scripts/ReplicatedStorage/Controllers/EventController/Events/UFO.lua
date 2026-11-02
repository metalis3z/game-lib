---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("Players")
game:GetService("Lighting")
require(v_u_1.Shared.EventTypes)
local v4 = require(v_u_1.Packages.Net)
local v_u_5 = require(v_u_1.Shared.ShakePresets)
local v6 = {}
local v_u_7 = require(v_u_1.Controllers.SoundController)
local v_u_8 = require(v_u_1.Controllers.CycleController)
local v_u_9 = require(v_u_1.Packages.CreateTween)
local v_u_10 = require(v_u_1.Packages.Observers)
local v11 = require(v_u_1.Packages.Trove)
local v_u_12 = require(v_u_1.Shared.VFX)
local v_u_13 = v_u_1.Models.Events.UFO.UFO
local v_u_14 = v4:RemoteEvent("EventService/UFO/AbductionBurst")
local v_u_15 = v4:RemoteEvent("EventService/UFO/Spawned")
local v_u_16 = v11.new()
local function v_u_24()
	-- upvalues: (copy) v_u_3, (copy) v_u_9, (copy) v_u_5
	local v17 = v_u_3.LocalPlayer:FindFirstChildOfClass("PlayerGui")
	if v17 then
		local v_u_18 = Instance.new("ScreenGui")
		v_u_18.IgnoreGuiInset = true
		v_u_18.ResetOnSpawn = false
		v_u_18.DisplayOrder = 10000
		v_u_18.Name = "UFO_SpawnFlash"
		local v19 = Instance.new("Frame")
		v19.Size = UDim2.fromScale(1, 1)
		v19.BackgroundColor3 = Color3.fromRGB(60, 255, 120)
		v19.BackgroundTransparency = 1
		v19.Parent = v_u_18
		v_u_18.Parent = v17
		local v20 = v_u_9(v19, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["BackgroundTransparency"] = 0.4
		}, false)
		local v_u_21 = v_u_9(v19, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			["BackgroundTransparency"] = 1
		}, false)
		v20:Play()
		v20.Completed:Once(function()
			-- upvalues: (copy) v_u_21, (copy) v_u_18
			v_u_21:Play()
			v_u_21.Completed:Once(function()
				-- upvalues: (ref) v_u_18
				v_u_18:Destroy()
			end)
		end)
		local v_u_22 = v_u_5.BumpS:Clone()
		v_u_22.Sustain = true
		local v_u_23 = v_u_5.BindShakeToCamera(v_u_22, workspace.CurrentCamera)
		v_u_22:Start()
		task.delay(0.3, function()
			-- upvalues: (copy) v_u_22, (copy) v_u_23
			v_u_22:StopSustain()
			task.delay(0.2, function()
				-- upvalues: (ref) v_u_22, (ref) v_u_23
				v_u_22:Destroy()
				v_u_23()
			end)
		end)
	end
end
function v6.OnStart(_)
	-- upvalues: (copy) v_u_16, (copy) v_u_10, (copy) v_u_13, (copy) v_u_1, (copy) v_u_9, (copy) v_u_2, (copy) v_u_14, (copy) v_u_12, (copy) v_u_15, (copy) v_u_24, (copy) v_u_8, (copy) v_u_7
	local v_u_25 = v_u_16:Extend()
	v_u_25:Add(v_u_10.observeTag("GalaxyUFO", function(p_u_26)
		-- upvalues: (copy) v_u_25, (ref) v_u_13, (ref) v_u_1, (ref) v_u_9, (ref) v_u_2
		if not p_u_26:IsA("BasePart") then
			return nil
		end
		local v_u_27 = v_u_25:Extend()
		local v_u_28 = v_u_27:Clone(v_u_13)
		for _, v29 in v_u_28:GetDescendants() do
			if v29:IsA("BasePart") then
				v29.Anchored = true
			end
		end
		local v30 = v_u_1.Sounds.Events.UFO.Flying:Clone()
		v30.Parent = p_u_26
		v30:Play()
		v_u_28.Parent = workspace
		local v31 = v_u_28:FindFirstChild("BeamPart", true)
		local v_u_32
		if v31 then
			v_u_32 = v31:FindFirstChild("att0")
		else
			v_u_32 = v31
		end
		local v_u_33
		if v31 then
			v_u_33 = v31:FindFirstChild("att1")
		else
			v_u_33 = v31
		end
		if not (v31 and (v_u_32 and (v_u_33 and (v_u_32:IsA("Attachment") and v_u_33:IsA("Attachment"))))) then
			v_u_27:Destroy()
			return nil
		end
		local v_u_34 = {}
		for _, v35 in v_u_33:GetChildren() do
			if v35:IsA("Beam") then
				v35.Attachment0 = v_u_32
				v35.Attachment1 = v_u_33
				v35.Enabled = false
				table.insert(v_u_34, v35)
			end
		end
		local v_u_36 = v_u_33.Position
		local v_u_37 = nil
		local function v38()
			-- upvalues: (ref) v_u_37
			if v_u_37 then
				v_u_37:Cancel()
				v_u_37 = nil
			end
		end
		local function v_u_46(p39)
			-- upvalues: (ref) v_u_1, (copy) p_u_26, (copy) v_u_34, (copy) v_u_33, (copy) v_u_32, (copy) v_u_36, (ref) v_u_37, (ref) v_u_9
			if p39 == "down" then
				local v40 = v_u_1.Sounds.Events.UFO.Abducting:Clone()
				v40.Parent = p_u_26
				v40:Play()
				for _, v41 in v_u_34 do
					v41.Enabled = true
				end
				v_u_33.Position = v_u_32.Position
				local v42 = v_u_36
				if v_u_37 then
					v_u_37:Cancel()
					v_u_37 = nil
				end
				v_u_37 = v_u_9(v_u_33, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
					["Position"] = v42
				})
			elseif p39 == "off" then
				local v43 = v_u_32.Position
				if v_u_37 then
					v_u_37:Cancel()
					v_u_37 = nil
				end
				v_u_37 = v_u_9(v_u_33, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
					["Position"] = v43
				})
				local v44 = v_u_37
				if v44 then
					v44.Completed:Wait()
				end
				for _, v45 in v_u_34 do
					v45.Enabled = false
				end
				v_u_33.Position = v_u_36
			end
		end
		v_u_27:Add(p_u_26:GetAttributeChangedSignal("BeamState"):Connect(function()
			-- upvalues: (copy) p_u_26, (copy) v_u_46
			local v47 = p_u_26:GetAttribute("BeamState")
			if typeof(v47) == "string" then
				v_u_46(v47)
			end
		end))
		v_u_27:Add(v_u_2.PostSimulation:Connect(function()
			-- upvalues: (copy) v_u_28, (copy) p_u_26, (copy) v_u_27
			debug.profilebegin("UFO:MoveUFO")
			if v_u_28.PrimaryPart == nil or p_u_26.Parent == nil then
				v_u_27:Destroy()
			else
				v_u_28:PivotTo(p_u_26.CFrame)
			end
			debug.profileend()
		end))
		v_u_27:Add(v38)
		v_u_27:Add(task.spawn(function()
			-- upvalues: (copy) p_u_26, (copy) v_u_46, (copy) v_u_34, (copy) v_u_33, (copy) v_u_36
			local v48 = p_u_26:GetAttribute("BeamState")
			if typeof(v48) == "string" then
				v_u_46(v48)
			else
				for _, v49 in v_u_34 do
					v49.Enabled = false
				end
				v_u_33.Position = v_u_36
			end
		end))
		return function()
			-- upvalues: (copy) v_u_27
			v_u_27:Destroy()
		end
	end))
	v_u_16:Add(v_u_14.OnClientEvent:Connect(function(p50)
		-- upvalues: (ref) v_u_1, (ref) v_u_12, (ref) v_u_16
		local v51 = script.Effects.ufoemit:Clone()
		v51:PivotTo(CFrame.new(p50))
		local v52 = v_u_1.Sounds.Events.UFO.Burst:Clone()
		v52.Parent = v51
		v52:Play()
		v51.Parent = workspace
		v_u_12.emit(v51)
		v_u_16:Add(v51)
		task.wait(1.5)
		v51:Destroy()
	end))
	v_u_16:Add(v_u_15.OnClientEvent:Connect(function(_)
		-- upvalues: (ref) v_u_24
		v_u_24()
	end))
	v_u_1:SetAttribute("UFOEvent", true)
	v_u_16:Add(function()
		-- upvalues: (ref) v_u_1, (ref) v_u_8, (ref) v_u_7
		v_u_1:SetAttribute("UFOEvent", nil)
		v_u_8:Update()
		v_u_7:UpdateOST()
	end)
end
function v6.OnStop(_)
	-- upvalues: (copy) v_u_16
	v_u_16:Destroy()
end
function v6.OnLoad(_) end
return v6
