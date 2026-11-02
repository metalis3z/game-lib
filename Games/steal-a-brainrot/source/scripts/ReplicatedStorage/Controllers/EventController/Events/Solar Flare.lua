local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("RunService")
game:GetService("Lighting")
game:GetService("Players")
local v_u_4 = game:GetService("Debris")
require(v_u_1.Shared.EventTypes)
local v5 = {}
local v_u_6 = require(v_u_1.Controllers.EventController)
local v_u_7 = require(v_u_1.Packages.Observers)
local v8 = require(v_u_1.Packages.Trove)
require(v_u_1.Packages.Net)
local v_u_9 = require(v_u_1.Packages.Shake)
require(v_u_1.Shared.ShakePresets)
local v_u_10 = script.Name
local v_u_11 = v8.new()
local v_u_12 = v_u_1.Models.Events["Solar Flare"].SolarFlareBeam
local v_u_13 = v_u_12:Clone()
local v_u_14 = workspace.Events["Solar Flare"]
local v_u_15 = v_u_14.MapFloor.Position.Y - v_u_14.MapFloor.Size.Y / 2
local v_u_16 = TweenInfo.new(0.25, Enum.EasingStyle.Back)
local v_u_17 = Color3.fromRGB(49, 49, 49)
local v_u_18 = TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
local v_u_19 = workspace.CurrentCamera
local v_u_20 = nil
local v_u_21 = v_u_9.new()
v_u_21.Frequency = 0.25
v_u_21.Amplitude = 0.2
v_u_21.FadeInTime = 0.1
v_u_21.FadeOutTime = 0.2
v_u_21.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
v_u_21.RotationInfluence = Vector3.new(1, 1, 1)
local v_u_22 = v_u_9.new()
v_u_22.Frequency = 0.06666666666666667
v_u_22.Amplitude = 0.04
v_u_22.Sustain = true
v_u_22.PositionInfluence = Vector3.new(0.75, 0.75, 0.75)
v_u_22.RotationInfluence = Vector3.new(1.25, 0.25, 0.25)
function v5.OnStart(_)
	local v23 = v_u_6:GetActiveEventData(v_u_10)
	assert(v23)
	local v_u_24 = true
	v_u_11:Add(function()
		v_u_24 = false
	end)
end
function v5.OnStop(_)
	v_u_11:Destroy()
end
function v5.OnLoad(_)
	for _, v25 in v_u_12:GetChildren() do
		if v25.Name ~= "BeamEnd" and v25.Name ~= "Hitbox" then
			v25:Destroy()
		end
	end
	for _, v26 in v_u_12.BeamEnd:GetChildren() do
		if v26.Name ~= "MainAttachment" then
			v26:Destroy()
		end
	end
	local v_u_27 = Instance.new("Part")
	v_u_27.Name = "SolarFlareTrail"
	v_u_27.Anchored = true
	v_u_27.CanCollide = false
	v_u_27.CanQuery = false
	v_u_27.CanTouch = false
	v_u_27.Size = Vector3.new(5, 5, 5)
	v_u_27.Color = v_u_17
	v_u_27.Transparency = 0.4
	v_u_27.Material = Enum.Material.Concrete
	v_u_11:Add(v_u_3.Heartbeat:Connect(function()
		debug.profilebegin("Solar Flare:Camera CFrame Update")
		if v_u_20 then
			v_u_19.CFrame = v_u_20
			v_u_20 = nil
		end
		debug.profileend()
	end))
	local v_u_28 = v_u_11:Extend()
	local v_u_29 = nil
	local v_u_30 = 0
	local v_u_31 = 0
	local v_u_32 = nil
	local v33 = { v_u_14 }
	v_u_7.observeTag("SolarFlareBase", function(p_u_34)
		v_u_28:Clean()
		v_u_29 = p_u_34
		v_u_30 = p_u_34:GetAttribute("NumBeams") or 1
		v_u_31 = p_u_34:GetAttribute("MaxBeams") or 4
		v_u_32 = (p_u_34:GetAttribute("SpawnPosition") or p_u_34.Position).Y
		local function v35()
			v_u_30 = p_u_34:GetAttribute("NumBeams") or v_u_30
		end
		v_u_28:Add(p_u_34:GetAttributeChangedSignal("NumBeams"):Connect(v35))
		v_u_30 = p_u_34:GetAttribute("NumBeams") or v_u_30
		return function()
			v_u_29 = nil
			v_u_28:Destroy()
		end
	end, v33)
	local v36 = { v_u_14 }
	v_u_7.observeTag("SolarFlareHitbox", function(p_u_37)
		while not v_u_29 and v_u_1:GetAttribute("SolarFlareEvent") do
			task.wait()
		end
		local v_u_38 = v_u_28:Extend()
		v_u_38:AttachToInstance(p_u_37)
		local v39 = v_u_30
		local v40 = v_u_38:Add(v_u_13.Beam1:Clone())
		v40:PivotTo(p_u_37:GetPivot())
		v40.Anchored = false
		v40.Name = ("Beam%*"):format(v39)
		v40.BeamEffect:Play()
		local v41 = v_u_11:Add(Instance.new("WeldConstraint"))
		v41.Part0 = v40
		v41.Part1 = p_u_37
		v41.Parent = v40
		local _ = (v39 - 1) * 6.283185307179586 / 4
		local v42 = v40.BeamStartAttachment
		local v43 = v_u_11:Add(v_u_13.BeamEnd.Beam1Attachment:Clone())
		v43.Name = ("Beam%*Attachment"):format(v39)
		local v44 = {}
		for _, v45 in v43:GetChildren() do
			if v45:IsA("Beam") then
				v45.Attachment0 = v42
				if v_u_30 ~= 0 then
					v44[v45] = {
						["Width0"] = v45.Width0,
						["Width1"] = v45.Width1
					}
					v45.Width0 = 0
					v45.Width1 = 0
				end
			end
		end
		v43.Parent = v_u_29
		v40.Parent = v_u_14
		for v46, v47 in v44 do
			local v_u_48 = v_u_38:Add(v_u_2:Create(v46, v_u_16, v47))
			v_u_48.Completed:Once(function()
				v_u_48:Destroy()
			end)
			v_u_48:Play()
		end
		local v49 = v_u_38:Add(v_u_21:Clone())
		v49:Start()
		v49:BindToRenderStep(v_u_9.NextRenderName(), Enum.RenderPriority.Camera.Value + 1, function(p50, p51)
			if not v_u_20 then
				v_u_20 = v_u_19.CFrame
			end
			local v52 = v_u_19
			v52.CFrame = v52.CFrame * (CFrame.new(p50) * CFrame.Angles(p51.X, p51.Y, p51.Z))
		end)
		local function v_u_56(p53)
			local v54 = v_u_38:Add(v_u_27:Clone())
			v54.CFrame = CFrame.new(p53.X, v_u_15 - 1, p53.Z) * CFrame.Angles(math.random() * 6.283185307179586, 0, math.random() * 6.283185307179586)
			v_u_4:AddItem(v54, 0.9)
			v54.Parent = v_u_14
			local v_u_55 = v_u_38:Add(v_u_2:Create(v54, v_u_18, {
				["Transparency"] = 1
			}))
			v_u_55.Completed:Once(function()
				v_u_55:Destroy()
			end)
			v_u_55:Play()
		end
		math.random(1, 100000)
		local v_u_57 = v_u_38:Add(v_u_22:Clone())
		v_u_57:Start()
		v_u_57:BindToRenderStep(v_u_9.NextRenderName(), Enum.RenderPriority.Camera.Value + 1, function()
			local v58, v59 = v_u_57:Update()
			local v60 = (v_u_19.CFrame.Position - p_u_37.Position).Magnitude - 25
			local v61 = 1 - math.max(0, v60) / 75
			local v62 = math.clamp(v61, 0, 1)
			local v63 = v62 * v62
			if v63 >= 0.01 then
				if not v_u_20 then
					v_u_20 = v_u_19.CFrame
				end
				local v64 = v58 * v63
				local v65 = v59 * v63
				local v66 = v_u_19
				v66.CFrame = v66.CFrame * (CFrame.new(v64) * CFrame.Angles(v65.X, v65.Y, v65.Z))
			end
		end)
		local v_u_67 = p_u_37.Position
		v_u_38:Add(v_u_3.PostSimulation:Connect(function()
			debug.profilebegin("Solar Flare:Trail")
			local v68 = p_u_37.Position
			if (v68 - v_u_67).Magnitude >= 1.5 then
				v_u_56(v68)
				v_u_67 = v68
			end
			debug.profileend()
		end))
		return function()
			v_u_38:Destroy()
		end
	end, v36)
end
return v5