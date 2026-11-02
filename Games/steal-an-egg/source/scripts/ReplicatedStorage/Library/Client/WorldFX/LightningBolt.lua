-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local clock = os.clock
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local BoltPart = Instance.new("Part")

BoltPart.TopSurface = Enum.SurfaceType.Smooth
BoltPart.BottomSurface = Enum.SurfaceType.Smooth
BoltPart.Anchored = true
BoltPart.CanCollide = false
BoltPart.Locked = true
BoltPart.CastShadow = false
BoltPart.Shape = "Cylinder"
BoltPart.Name = "BoltPart"
BoltPart.Material = Enum.Material.Neon
BoltPart.Color = Color3.new(255/255, 255/255, 255/255)
BoltPart.Transparency = 1

local v1 = require(script.PartCache).new(BoltPart, 120)

v1:SetCacheParent(Workspace.CurrentCamera)

local function cubicBezier(p1, p2, p3, p4, p5) --[[ cubicBezier | Line: 21 ]]
	return p2 * (1 - p1) ^ 3 + p3 * 3 * p1 * (1 - p1) ^ 2 + p4 * 3 * (1 - p1) * p1 ^ 2 + p5 * p1 ^ 3
end

local function discretePulse(p1, p2, p3, p4, p5, p6, p7) --[[ discretePulse | Line: 25 ]]
	return math.clamp(p4 / (2 * p5) - math.abs((p1 - p2 * p3 + 0.5 * p4) / p5), p6, p7)
end

local function extrudeCenter(p1) --[[ extrudeCenter | Line: 33 ]]
	return math.exp(-5000 * (p1 - 0.5) ^ 10)
end

local v2 = CFrame.lookAt(Vector3.new(), Vector3.new(1, 0, 0)):Inverse()
local t = {}
local t2 = {
	__type = "LightningBolt"
}

t2.__index = t2
function t2.new(p1, p2, p3) --[[ new | Line: 45 | Upvalues: t2 (copy), cubicBezier (copy), discretePulse (copy), extrudeCenter (copy), v1 (copy), clock (copy), t (copy) ]]
	local v2 = setmetatable({}, t2)

	v2.Enabled = true
	v2.Attachment0 = p1
	v2.Attachment1 = p2
	v2.CurveSize0 = 0
	v2.CurveSize1 = 0
	v2.MinRadius = 0
	v2.MaxRadius = 2.4
	v2.Frequency = 1
	v2.AnimationSpeed = 7
	v2.Thickness = 1
	v2.MinThicknessMultiplier = 0.2
	v2.MaxThicknessMultiplier = 1
	v2.MinTransparency = 0
	v2.MaxTransparency = 1
	v2.PulseSpeed = 2
	v2.PulseLength = 1000000
	v2.FadeLength = 0.2
	v2.ContractFrom = 0.5
	v2.Color = Color3.new(255/255, 255/255, 255/255)
	v2.ColorOffsetSpeed = 3
	v2.SpaceCurveFunction = cubicBezier
	v2.OpacityProfileFunction = discretePulse
	v2.RadialProfileFunction = extrudeCenter
	v2._Parts = {}

	for i = 1, p3 or 30 do
		v2._Parts[i] = v1:GetPart()
	end

	v2._PartsHidden = false
	v2._DisabledTransparency = 1
	v2._StartT = clock()
	v2._RanNum = math.random() * 100
	v2._RefIndex = #t + 1
	v2._Destroyed = false
	v2._DissipateConnection = nil
	t[v2._RefIndex] = v2

	return v2
end
function t2.Destroy(p1) --[[ Destroy | Line: 86 | Upvalues: t (copy), v1 (copy) ]]
	if p1._Destroyed then
		return
	end

	p1._Destroyed = true
	t[p1._RefIndex] = nil

	local _DissipateConnection = p1._DissipateConnection

	if _DissipateConnection then
		_DissipateConnection:Disconnect()
		p1._DissipateConnection = nil
	end

	for i = 1, #p1._Parts do
		v1:ReturnPart(p1._Parts[i])
	end

	table.clear(p1._Parts)
end
function t2.DestroyDissipate(p1, p2, p3) --[[ DestroyDissipate | Line: 106 | Upvalues: clock (copy), RunService (copy) ]]
	if not (p1._Destroyed or p1._DissipateConnection) then
		local v1 = p2 or 0.2
		local v2 = p3 or 0.5
		local v3 = clock()
		local MinTransparency = p1.MinTransparency
		local ContractFrom = p1.ContractFrom
		local v4 = p1.ContractFrom + 1 / (#p1._Parts * p1.FadeLength)
		local MaxRadius = p1.MaxRadius
		local MinThicknessMultiplier = p1.MinThicknessMultiplier
		local v5 = nil

		v5 = RunService.Heartbeat:Connect(function() --[[ Line: 120 | Upvalues: p1 (copy), v5 (ref), clock (ref), v3 (copy), MinThicknessMultiplier (copy), v1 (ref), MinTransparency (copy), ContractFrom (copy), v4 (copy), MaxRadius (copy), v2 (ref) ]]
			if not p1._Destroyed then
				local v12 = clock() - v3

				p1.MinThicknessMultiplier = MinThicknessMultiplier + (-2 - MinThicknessMultiplier) * v12 / v1

				if v12 < v1 * 0.4 then
					p1.MinTransparency = MinTransparency + (ContractFrom - MinTransparency) * (v12 / (v1 * 0.4))

					return
				end

				if v12 < v1 then
					local v22 = (v12 - v1 * 0.4) / (v1 * 0.6)

					p1.MinTransparency = ContractFrom + (v4 - ContractFrom) * v22
					p1.MaxRadius = MaxRadius * (1 + v2 * v22)
					p1.MinRadius = p1.MinRadius + (p1.MaxRadius - p1.MinRadius) * v22

					return
				end

				if clock() - p1._StartT < (p1.PulseLength + 1) / p1.PulseSpeed then
					p1:Destroy()
				end
			end

			v5:Disconnect()
			p1._DissipateConnection = nil
		end)
		p1._DissipateConnection = v5
	end
end
function t2._UpdateGeometry(p1, p2, p3, p4, p5, p6, p7) --[[ _UpdateGeometry | Line: 148 | Upvalues: v2 (copy) ]]
	local v3 = p1.OpacityProfileFunction(p3, p4, p1.PulseSpeed, p1.PulseLength, p1.FadeLength, 1 - p1.MaxTransparency, 1 - p1.MinTransparency)
	local v4 = p1.Thickness * p5 * v3
	local v5 = if v4 > 0 and v3 then v3 else 0
	local v6 = 1 - p1.ContractFrom
	local v7 = #p1._Parts

	if v6 < v5 then
		p2.Size = Vector3.new((p7 - p6).Magnitude, v4, v4)
		p2.CFrame = CFrame.lookAt((p6 + p7) * 0.5, p7) * v2
	else
		if not (v6 - 1 / (v7 * p1.FadeLength) < v5) then
			p2.Transparency = 1

			return
		end

		local v10 = (1 - (v5 - (v6 - 1 / (v7 * p1.FadeLength))) * v7 * p1.FadeLength) * (if p3 < p4 * p1.PulseSpeed - 0.5 * p1.PulseLength then 1 else -1)

		p2.Size = Vector3.new((1 - math.abs(v10)) * (p7 - p6).Magnitude, v4, v4)
		p2.CFrame = CFrame.lookAt(p6 + (p7 - p6) * (math.max(0, v10) + (1 - math.abs(v10)) * 0.5), p7) * v2
	end

	p2.Transparency = 1 - v5
end
function t2._UpdateColor(p1, p2, p3, p4) --[[ _UpdateColor | Line: 183 ]]
	if typeof(p1.Color) == "Color3" then
		p2.Color = p1.Color

		return
	end

	local v1 = (p1._RanNum + p3 - p4 * p1.ColorOffsetSpeed) % 1
	local Keypoints = p1.Color.Keypoints

	for i = 1, #Keypoints - 1 do
		if Keypoints[i].Time < v1 and v1 < Keypoints[i + 1].Time then
			p2.Color = Keypoints[i].Value:lerp(Keypoints[i + 1].Value, (v1 - Keypoints[i].Time) / (Keypoints[i + 1].Time - Keypoints[i].Time))

			return
		end
	end
end
function t2._Disable(p1) --[[ _Disable | Line: 201 ]]
	p1.Enabled = false

	for i, v in ipairs(p1._Parts) do
		v.Transparency = p1._DisabledTransparency
	end
end
RunService.Heartbeat:Connect(function() --[[ Line: 208 | Upvalues: t (copy), clock (copy) ]]
	debug.profilebegin("LightningBolt")

	for k, v in pairs(t) do
		if v.Enabled == true then
			v._PartsHidden = false

			local MinRadius = v.MinRadius
			local MaxRadius = v.MaxRadius
			local _Parts = v._Parts
			local v1 = #_Parts
			local _RanNum = v._RanNum
			local AnimationSpeed = v.AnimationSpeed
			local Frequency = v.Frequency
			local MinThicknessMultiplier = v.MinThicknessMultiplier
			local MaxThicknessMultiplier = v.MaxThicknessMultiplier
			local v2 = clock() - v._StartT
			local SpaceCurveFunction = v.SpaceCurveFunction
			local RadialProfileFunction = v.RadialProfileFunction
			local Attachment0 = v.Attachment0
			local Attachment1 = v.Attachment1
			local WorldPosition = Attachment0.WorldPosition
			local v4 = Attachment0.WorldPosition + Attachment0.WorldAxis * v.CurveSize0
			local v5 = Attachment1.WorldPosition - Attachment1.WorldAxis * v.CurveSize1
			local WorldPosition2 = Attachment1.WorldPosition
			local v6 = SpaceCurveFunction(0, WorldPosition, v4, v5, WorldPosition2)

			if v2 < (v.PulseLength + 1) / v.PulseSpeed then
				local v7 = v6

				for i = 1, v1 do
					local v8
					local v9 = _Parts[i]
					local v10 = i / v1
					local v11 = AnimationSpeed * -v2 + Frequency * 10 * v10 - 0.2 + _RanNum * 4
					local v12 = 5 * (AnimationSpeed * 0.01 * -v2 / 10 + Frequency * v10) + _RanNum * 4
					local v13 = 0.6283185307179586 * (math.noise(5 * v11, 1.5, v12) + 0.5) + 5.654866776461628 * (math.noise(0.5 * v11, 1.5, 0.1 * v12) + 0.5)
					local v14 = (MinRadius + (MaxRadius - MinRadius) * (math.noise(3.4, v12, v11) + 0.5)) * RadialProfileFunction(v10)
					local v15 = MinThicknessMultiplier + (MaxThicknessMultiplier - MinThicknessMultiplier) * (math.noise(2.3, v12, v11) + 0.5)
					local v16 = SpaceCurveFunction(v10, WorldPosition, v4, v5, WorldPosition2)

					if i == v1 then
						v8 = v16
					else
						local v17 = CFrame.new(v7, v16) * CFrame.Angles(0, 0, v13)
						local Angles = CFrame.Angles
						local v19 = math.clamp(6.123233995736766e-17 + 0.9999999999999999 * (math.noise(v12, v11, 2.7) + 0.5), -1, 1)

						v8 = (v17 * Angles(math.acos(v19), 0, 0) * CFrame.new(0, 0, -v14)).Position or v16
					end

					v:_UpdateGeometry(v9, v10, v2, v15, v6, v8)
					v:_UpdateColor(v9, v10, v2)
					v7, v6 = v16, v8
				end

				continue
			end

			v:Destroy()

			continue
		end

		if v._PartsHidden == false then
			v._PartsHidden = true
			v:_Disable()
		end
	end

	debug.profileend()
end)

return t2