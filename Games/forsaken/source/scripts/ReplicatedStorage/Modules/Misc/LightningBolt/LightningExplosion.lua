-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent)
local v_u_2 = require(script.Parent.LightningSparks)
local v_u_3 = Random.new()
local v_u_4 = os.clock
function RandomVectorOffsetBetween(p5, p6, p7)
	-- upvalues: (copy) v_u_3
	local v8 = CFrame.lookAt(Vector3.new(), p5) * CFrame.Angles(0, 0, v_u_3:NextNumber(0, 6.283185307179586))
	local v9 = CFrame.Angles
	local v10 = v_u_3:NextNumber(math.cos(p7), (math.cos(p6)))
	return (v8 * v9(math.acos(v10), 0, 0)).LookVector
end
local v_u_11 = {}
local v_u_12 = {}
v_u_12.__index = v_u_12
function v_u_12.new(p13, p14, p15, p16, p17, p18)
	-- upvalues: (copy) v_u_12, (copy) v_u_3, (copy) v_u_1, (copy) v_u_2, (copy) v_u_4, (copy) v_u_11
	local v19 = v_u_12
	local v20 = setmetatable({}, v19)
	v20.Size = p14 or 1
	v20.NumBolts = p15 or 14
	v20.Color = p16 or ColorSequence.new(Color3.new(1, 0, 0), Color3.new(0, 0, 1))
	v20.BoltColor = p17 or Color3.new(0.3, 0.3, 1)
	v20.UpVector = p18 or Vector3.new(0, 1, 0)
	local v21 = workspace.CurrentCamera
	local v22 = Instance.new("Part")
	v22.Name = "LightningExplosion"
	v22.Anchored = true
	v22.CanCollide = false
	v22.Locked = true
	v22.CastShadow = false
	v22.Transparency = 1
	v22.Size = Vector3.new(0.05, 0.05, 0.05)
	v22.CFrame = CFrame.lookAt(p13 + Vector3.new(0, 0.5, 0), p13 + Vector3.new(0, 0.5, 0) + v20.UpVector) * CFrame.lookAt(Vector3.new(), Vector3.new(0, 1, 0)):inverse()
	v22.Parent = v21
	local v23 = Instance.new("Attachment")
	v23.Parent = v22
	v23.CFrame = CFrame.new()
	local v24 = script.ExplosionBrightspot:Clone()
	local v25 = script.GlareEmitter:Clone()
	local v26 = script.PlasmaEmitter:Clone()
	local v27 = v20.Size
	local v28 = math.clamp(v27, 0, 1)
	v25.Size = NumberSequence.new(v28 * 30)
	v26.Size = NumberSequence.new(v28 * 18)
	v26.Speed = NumberRange.new(v28 * 100)
	v24.Parent = v23
	v25.Parent = v23
	v26.Parent = v23
	local v29 = v20.Color
	if typeof(v29) == "Color3" then
		local v30 = ColorSequence.new(v29)
		local v31 = ColorSequence.new(v29)
		v25.Color = v30
		v26.Color = v31
		local v32, _, v33 = Color3.toHSV(v29)
		v24.Color = ColorSequence.new(Color3.fromHSV(v32, 0.5, v33))
	else
		v25.Color = v29
		v26.Color = v29
		local v34 = v29.Keypoints
		for v35 = 1, #v34 do
			local v36, _, v37 = Color3.toHSV(v34[v35].Value)
			v34[v35] = ColorSequenceKeypoint.new(v34[v35].Time, Color3.fromHSV(v36, 0.5, v37))
		end
		v24.Color = ColorSequence.new(v34)
	end
	v24.Enabled = true
	v25.Enabled = true
	v26.Enabled = true
	local v38 = {}
	for _ = 1, v20.NumBolts do
		local v39 = {}
		local v40 = {}
		local v41 = v23.WorldPosition
		local v42 = RandomVectorOffsetBetween(v20.UpVector, 1.1344640137963142, 1.3962634015954636)
		v39.WorldPosition = v41
		v39.WorldAxis = v42
		local v43 = v23.WorldPosition + v39.WorldAxis * v_u_3:NextNumber(20, 40) * 1.4 * v28
		local v44 = RandomVectorOffsetBetween(-v20.UpVector, 1.2217304763960306, 1.9198621771937625)
		v40.WorldPosition = v43
		v40.WorldAxis = v44
		local v45 = v_u_1.new(v39, v40, 10)
		v45.AnimationSpeed = 0
		v45.Thickness = 1
		v45.Color = v20.BoltColor
		v45.PulseLength = 0.8
		v45.ColorOffsetSpeed = 20
		v45.Frequency = 2
		local v46 = v28 * 4
		v45.MinRadius = 0
		v45.MaxRadius = v46
		v45.FadeLength = 0.4
		v45.PulseSpeed = 5
		v45.MinThicknessMultiplier = 0.7
		v45.MaxThicknessMultiplier = 1
		local v47 = v_u_2.new(v45, 5)
		v47.MinDistance = 7.5
		v47.MaxDistance = 10
		v45.Velocity = (v40.WorldPosition - v39.WorldPosition).Unit * 0.1 * v28
		v38[#v38 + 1] = v45
	end
	v20.Bolts = v38
	v20.Attachment = v23
	v20.Part = v22
	v20.StartT = v_u_4()
	v20.RefIndex = #v_u_11 + 1
	v_u_11[v20.RefIndex] = v20
	return v20
end
function v_u_12.Destroy(p48)
	-- upvalues: (copy) v_u_11
	v_u_11[p48.RefIndex] = nil
	p48.Part:Destroy()
	for v49 = 1, #p48.Bolts do
		p48.Bolts[v49] = nil
	end
end
game:GetService("RunService").Heartbeat:Connect(function()
	-- upvalues: (copy) v_u_11, (copy) v_u_4
	for _, v50 in pairs(v_u_11) do
		local v51 = v_u_4() - v50.StartT
		local v52 = v50.Attachment
		if v51 < 0.7 then
			if v51 > 0.2 then
				local v53 = v52.ExplosionBrightspot
				local v54 = v52.GlareEmitter
				local v55 = v52.PlasmaEmitter
				v53.Enabled = false
				v54.Enabled = false
				v55.Enabled = false
			end
			for v56 = 1, #v50.Bolts do
				local v57 = v50.Bolts[v56]
				v57.Attachment1.WorldPosition = v57.Attachment1.WorldPosition + v57.Velocity
			end
		else
			v50:Destroy()
		end
	end
end)
return v_u_12
