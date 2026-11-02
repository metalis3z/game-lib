-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local TableUtil = require(ReplicatedStorage.Library.Modules.Packages.TableUtil)
local Audio = require(ReplicatedStorage.Library.Audio)
local CatmullRomSpline = require(ReplicatedStorage.Library.Modules.CRSplineModules.CatmullRomSpline)

require(ReplicatedStorage.Library.Modules.CRSplineModules.BaseSpline)

local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local v2 = Random.new()
local v3 = false

if not Constants.IS_STUDIO and v3 then
	v1:AtWarning():Log("NEVER let the spline debug be enabled in production!")
	v3 = false
end

local t2 = {
	SPIN_SPEED = 25.132741228718345,
	RANDOMIZE_END_DIR = false,
	END_DIRECTION = nil,
	DEATH_SPLINE_PROPULSION_INFO = TweenInfo.new(1.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
	SPLINE_DIST = { 20, 30 },
	SPLINE_H1 = { 20, 30 },
	SPLINE_H2 = { 10, 20 },
	SPLINE_H3 = { 3, 4 },
	SPLINE_TENSION = { 0.6, 2 }
}
local v4 = t.interface({
	DEATH_SPLINE_PROPULSION_INFO = t.optional(t.TweenInfo),
	SPLINE_DIST = t.optional(t.array(t.number)),
	SPLINE_H1 = t.optional(t.array(t.number)),
	SPLINE_H2 = t.optional(t.array(t.number)),
	SPLINE_H3 = t.optional(t.array(t.number)),
	SPLINE_TENSION = t.optional(t.array(t.number)),
	CUSTOM_TRANSFORM_FN = t.optional(t.callback),
	SPIN_SPEED = t.optional(t.number),
	RANDOMIZE_END_DIR = t.optional(t.boolean),
	END_DIRECTION = t.optional(t.Vector3),
	THROW_SOUND = t.optional(Audio.__types.SoundFile)
})

local function getDefaultSpinTransform(p1) --[[ getDefaultSpinTransform | Line: 100 | Upvalues: Asserts (copy) ]]
	Asserts.number(p1)

	return function(p1, p23) --[[ Line: 103 | Upvalues: p1 (copy) ]]
		return p1 * CFrame.Angles(p23 * p1, 0, 0)
	end
end

local function getPreserveAnglesTransform(p1) --[[ getPreserveAnglesTransform | Line: 109 | Upvalues: Asserts (copy) ]]
	Asserts.CFrame(p1)

	local v1, v2, v3 = p1:ToOrientation()

	return function(p13) --[[ Line: 113 | Upvalues: v1 (copy), v2 (copy), v3 (copy) ]]
		return CFrame.new(p13.Position) * CFrame.Angles(v1, v2, v3)
	end
end

return function(p1, p2, p3) --[[ Line: 118 | Upvalues: Asserts (copy), v4 (copy), TableUtil (copy), t2 (copy), v2 (copy), CatmullRomSpline (copy), v3 (ref), Audio (copy) ]]
	Asserts.BasePart(p1)
	Asserts.optional.func(p3)

	local v1 = if p2 then p2 else {}

	assert(v4(v1))
	p1.Anchored = true

	local v32 = TableUtil.Reconcile(v1, t2)
	local Position = p1.Position
	local END_DIRECTION = v32.END_DIRECTION
	local v42 = nil

	if END_DIRECTION then
		local Magnitude = END_DIRECTION.Magnitude

		if Magnitude > 0.0001 then
			v42 = END_DIRECTION / Magnitude
		end
	end

	local v5 = if v32.RANDOMIZE_END_DIR then v2:NextUnitVector() elseif v42 then v42 else -p1.CFrame.LookVector
	local v7 = Position + v5 * v2:NextNumber(unpack(v32.SPLINE_DIST))
	local v9 = v7 + Vector3.new(0, 1, 0) * v2:NextNumber(unpack(v32.SPLINE_H3))
	local v11 = Position - Vector3.new(0, 1, 0) * v2:NextNumber(unpack(v32.SPLINE_H1))
	local v13 = v9 - Vector3.new(0, 1, 0) * v2:NextNumber(unpack(v32.SPLINE_H2))
	local v14

	if v32.CUSTOM_TRANSFORM_FN then
		v14 = v32.CUSTOM_TRANSFORM_FN
	elseif v32.SPIN_SPEED == 0 then
		local v15 = p1.CFrame

		Asserts.CFrame(v15)

		local v16, v17, v18 = v15:ToOrientation()

		v14 = function(p13) --[[ Line: 113 | Upvalues: v16 (copy), v17 (copy), v18 (copy) ]]
			return CFrame.new(p13.Position) * CFrame.Angles(v16, v17, v18)
		end
	else
		local SPIN_SPEED = v32.SPIN_SPEED

		Asserts.number(SPIN_SPEED)
		v14 = function(p1, p23) --[[ Line: 103 | Upvalues: SPIN_SPEED (copy) ]]
			return p1 * CFrame.Angles(p23 * SPIN_SPEED, 0, 0)
		end
	end

	local v21 = CatmullRomSpline.new({ v11, Position, v9, v13 }, v2:NextNumber(unpack(v32.SPLINE_TENSION)))
	local v222 = v21:CreateTween(p1, v32.DEATH_SPLINE_PROPULSION_INFO, nil, v14)

	if v3 then
		CatmullRomSpline.DebugDrawSpline(v21, 100, workspace, Color3.fromRGB(0, 255, 0))
	end

	if p3 then
		v222.Completed:Once(p3)
	end

	if not v32.THROW_SOUND then
		return v222
	end

	Audio.PlayFromFormattedParams(v32.THROW_SOUND.SoundId, p1.Position, v32.THROW_SOUND.Data)

	return v222
end