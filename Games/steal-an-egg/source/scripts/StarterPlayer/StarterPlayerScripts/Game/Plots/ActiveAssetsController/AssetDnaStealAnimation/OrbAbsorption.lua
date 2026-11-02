-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local BBFromModelVisibleOnly = require(ReplicatedStorage.Library.Functions.BBFromModelVisibleOnly)
local RenderStepped = require(ReplicatedStorage.Library.Functions.RenderStepped)
local Config = require(script.Parent.Config)
local t = {}

local function cubic(p1, p2, p3, p4, p5) --[[ cubic | Line: 29 ]]
	local v1 = 1 - p1

	return v1 ^ 3 * p2 + v1 ^ 2 * 3 * p1 * p3 + v1 * 3 * p1 ^ 2 * p4 + p1 ^ 3 * p5
end

local function curveY(p1, p2, p3, p4, p5, p6, p7, p8, p9) --[[ curveY | Line: 34 ]]
	local v1 = 0
	local v2 = 1

	for i = 1, 16 do
		local v3 = (v1 + v2) * 0.5
		local v4 = 1 - v3

		if v4 ^ 3 * p2 + v4 ^ 2 * 3 * v3 * p4 + v4 * 3 * v3 ^ 2 * p6 + v3 ^ 3 * p8 < p1 then
			v1 = v3

			continue
		end

		v2 = v3
	end

	local v5 = (v1 + v2) * 0.5
	local v6 = 1 - v5

	return v6 ^ 3 * p3 + v6 ^ 2 * 3 * v5 * p5 + v6 * 3 * v5 ^ 2 * p7 + v5 ^ 3 * p9
end

local function basicCurve(p1) --[[ basicCurve | Line: 58 | Upvalues: curveY (copy) ]]
	local v1 = math.clamp(p1, 0, 1)

	if v1 <= 0.474 then
		return curveY(v1, 0, 0, 0.2, 0, 0.307, -0.003, 0.474, 0.56)
	end

	return curveY(v1, 0.474, 0.56, 0.599, 0.981, 0.7, 1, 1, 1)
end

local function arcCurve(p1) --[[ arcCurve | Line: 66 | Upvalues: curveY (copy) ]]
	return curveY(math.clamp(p1, 0, 1), 0, 0, 0.25, 0.6, 0.5, 1, 1, 1)
end

local function settleCurve(p1) --[[ settleCurve | Line: 70 | Upvalues: curveY (copy) ]]
	return curveY(math.clamp(p1, 0, 1), 0, 0, 0.45, 0.05, 0.8, 0.4, 1, 1)
end

local function destroyOrbs(p1) --[[ destroyOrbs | Line: 74 ]]
	for i, v in ipairs(p1) do
		v.Part:Destroy()
	end
end

function t.Play(p1, p2) --[[ Play | Line: 84 | Upvalues: Asserts (copy), BBFromModelVisibleOnly (copy), Config (copy), RenderStepped (copy), basicCurve (copy), curveY (copy) ]]
	Asserts.Model(p1)
	Asserts.Model(p2)

	local v1, v2 = BBFromModelVisibleOnly(p1)
	local v3 = p1:GetPivot()
	local v4 = p1:GetScale()
	local v5 = Config.AbsorptionSeconds / Config.OrbReferenceDuration
	local v6 = v2.Magnitude / Config.OrbReferencePetMagnitude
	local v8 = math.sqrt((math.max(1, v6)))
	local v9 = Random.new(math.random(1, 1000000))
	local v10 = table.create(Config.OrbCount)

	for i = 1, Config.OrbCount do
		local v11, v12, v13 = Config.OrbColor:ToHSV()
		local v14 = v11 + v9:NextNumber(-0.1, 0.1) * 0.3
		local v15 = v13 - v9:NextNumber(0, 0.1)
		local v16 = v12 - v9:NextNumber(0, 0.6)
		local v17 = v9:NextNumber(0, 0.8) * v5
		local v18 = (1.26 + v9:NextNumber(0, 0.8)) * v5
		local v19 = v2 * 0.5
		local v23 = v1:PointToWorldSpace((Vector3.new(v9:NextNumber(-v19.X, v19.X), v9:NextNumber(-v19.Y, v19.Y), v9:NextNumber(-v19.Z, v19.Z))))
		local v24 = Vector3.new(1, 1, 1) * v9:NextNumber(Config.OrbBaseSizeMin, Config.OrbBaseSizeMax) * v8
		local DnaStealOrb = Instance.new("Part")

		DnaStealOrb.Name = "DnaStealOrb"
		DnaStealOrb.Anchored = true
		DnaStealOrb.CanCollide = false
		DnaStealOrb.CanQuery = false
		DnaStealOrb.CanTouch = false
		DnaStealOrb.CastShadow = false
		DnaStealOrb.Material = Enum.Material.Neon
		DnaStealOrb.Shape = Enum.PartType.Ball
		DnaStealOrb.Size = Vector3.new(0, 0, 0)
		DnaStealOrb.Color = Color3.fromHSV(v14, v16, v15):Lerp(Color3.new(255/255, 255/255, 255/255), 0.3)
		DnaStealOrb.Parent = workspace
		table.insert(v10, {
			Part = DnaStealOrb,
			StartPosition = v23,
			Size = v24,
			SpawnTime = v17,
			EndTime = v18,
			RotationSpeed = v9:NextNumber(-3.141592653589793, math.pi)
		})
	end

	local CloneCaptureStartSeconds = Config.CloneCaptureStartSeconds
	local v25 = Config.AbsorptionSeconds - CloneCaptureStartSeconds

	assert(if v25 > 0 then true else false, "Clone capture must begin before absorption ends")
	RenderStepped(function(p12, p22) --[[ Line: 136 | Upvalues: p1 (copy), p2 (copy), Config (ref), BBFromModelVisibleOnly (ref), CloneCaptureStartSeconds (copy), v25 (copy), basicCurve (ref), v4 (copy), v3 (copy), v10 (copy), v5 (copy), curveY (ref), v1 (copy) ]]
		if p1.Parent == nil or p2.Parent == nil then
			return true
		end

		local v12 = p22 * Config.AbsorptionSeconds
		local Position = BBFromModelVisibleOnly(p2).Position
		local v32 = basicCurve((math.clamp((v12 - CloneCaptureStartSeconds) / v25, 0, 1)))

		p1:ScaleTo((math.max(Config.MinScale, v4 * (1 - v32))))
		p1:PivotTo(CFrame.new(v3.Position:Lerp(Position, v32)) * v3.Rotation * CFrame.Angles(1.5707963267948966 * v32, 0, 0))

		for i, v in ipairs(v10) do
			local v8 = math.clamp((v12 - v.SpawnTime) / math.max(0.3 * v5, 0.001), 0, 1)
			local v122 = math.clamp((v12 - v.SpawnTime) / math.max(v.EndTime - v.SpawnTime, 0.001), 0, 1)
			local v13 = basicCurve(v122)
			local v14 = curveY(math.clamp(v122, 0, 1), 0, 0, 0.45, 0.05, 0.8, 0.4, 1, 1)
			local v15 = v1.Position + (v.StartPosition - v1.Position) * math.lerp(1.4, 1, v8)
			local v16 = v15:Lerp(Position, v13)
			local v17 = curveY(math.clamp(v122, 0, 1), 0, 0, 0.25, 0.6, 0.5, 1, 1, 1)
			local v18 = v15:Lerp(v16, v13) + Vector3.new(0, 1, 0) * (v17 * 0.1 * (1 - v14))

			v.Part.CFrame = CFrame.Angles(0, v.RotationSpeed * v12, 0) + v18
			v.Part.Size = v.Size * v8 * (1 - v122) * 1.9
		end

		return nil
	end, Config.AbsorptionSeconds, true):Wait()

	for i, v in ipairs(v10) do
		v.Part:Destroy()
	end

	if p1.Parent == nil then
		return
	end

	p1:Destroy()
end

return t