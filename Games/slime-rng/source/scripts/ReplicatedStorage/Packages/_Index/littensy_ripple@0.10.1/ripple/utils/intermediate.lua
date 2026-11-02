-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: intermediate, time of decompilation: Sun May  3 10:10:47 2026 ]]
local merge = require("./merge")
local oklab = require("./oklab")
local t12 = {
	number = function(t1: {[any]: any}, n1: number) --[[ number ]] -- line: 15
		t1[1] = n1
	end,
	vector = function(t2: {[any]: any}, vector3: Vector3) --[[ vector ]] -- line: 18
		t2[1] = vector3
	end,
	Vector3 = function(t3: {[any]: any}, vector3: Vector3) --[[ Vector3 ]] -- line: 21
		t3[1] = vector3
	end,
	table = function(t4: {[any]: any}, t5: {[any]: any}) --[[ table ]] -- line: 24
		for v13, v14 in t5 do
			t4[v13] = v14
		end
	end,
	Vector2 = function(t6: {[any]: any}, vector2: Vector2) --[[ Vector2 ]] -- line: 29
		t6[1] = vector.create(vector2.X, vector2.Y, 0)
	end,
	CFrame = function(t7: {[any]: any}, cFrame: CFrame) --[[ CFrame ]] -- line: 32
		t7[1] = cFrame.Position
		t7[2] = cFrame.XVector
		t7[3] = cFrame.YVector
		t7[4] = cFrame.ZVector
	end,
	Color3 = function(t8: {[any]: any}, color3: Color3) --[[ Color3 ]] -- line: 38
		-- upvalues: oklab (copy)
		t8[1] = oklab.fromSRGB((vector.create(color3.R, color3.G, color3.B)))
	end,
	UDim = function(t9: {[any]: any}, uDim: UDim) --[[ UDim ]] -- line: 41
		t9[1] = vector.create(uDim.Scale, uDim.Offset, 0)
	end,
	UDim2 = function(t10: {[any]: any}, uDim2: UDim2) --[[ UDim2 ]] -- line: 44
		t10[1] = vector.create(uDim2.X.Scale, uDim2.X.Offset, uDim2.Y.Scale)
		t10[2] = uDim2.Y.Offset
	end,
	Rect = function(t11: {[any]: any}, rect: Rect) --[[ Rect ]] -- line: 48
		t11[1] = vector.create(rect.Min.X, rect.Min.Y, rect.Max.X)
		t11[2] = rect.Max.Y
	end
}
local t23 = {
	number = function(t13: {[any]: any}) --[[ number ]] -- line: 55
		return t13[1]
	end,
	vector = function(t14: {[any]: any}) --[[ vector ]] -- line: 58
		return t14[1]
	end,
	Vector3 = function(t15: {[any]: any}) --[[ Vector3 ]] -- line: 61
		return t15[1]
	end,
	table = function(t16: {[any]: any}) --[[ table ]] -- line: 64
		return table.clone(t16)
	end,
	Vector2 = function(t17: {[any]: any}) --[[ Vector2 ]] -- line: 67
		local v32 = t17[1]

		return Vector2.new(v32.x, v32.y)
	end,
	CFrame = function(t18: {[any]: any}) --[[ CFrame ]] -- line: 71
		return CFrame.fromMatrix(t18[1], t18[2], t18[3], t18[4]):Orthonormalize()
	end,
	Color3 = function(t19: {[any]: any}) --[[ Color3 ]] -- line: 74
		-- upvalues: oklab (copy)
		local v35 = vector.max(oklab.toSRGB(t19[1]), (Vector3.new(0, 0, 0)))

		return Color3.new(v35.x, v35.y, v35.z)
	end,
	UDim = function(t20: {[any]: any}) --[[ UDim ]] -- line: 78
		local v37 = t20[1]

		return UDim.new(v37.x, (math.round(v37.y)))
	end,
	UDim2 = function(t21: {[any]: any}) --[[ UDim2 ]] -- line: 82
		local v39 = t21[1]
		local v40 = t21[2]

		return UDim2.new(v39.x, math.round(v39.y), v39.z, (math.round(v40)))
	end,
	Rect = function(t22: {[any]: any}) --[[ Rect ]] -- line: 87
		local v42 = t22[1]
		local v43 = t22[2]

		return Rect.new(v42.x, v42.y, v42.z, v43)
	end
}

return {
	create = function(p1) --[[ create ]] -- line: 94
		-- upvalues: t12 (copy), t23 (copy)
		local v45 = typeof(p1)
		local t24 = {}
		local v47 = t12[v45]
		local v48 = t23[v45]

		if not v47 or not v48 then
			error(`Unsupported type { v45 } for Ripple animation value`)
		end

		v47(t24, p1)

		return {
			components = t24,
			value = p1,
			encode = v47,
			decode = v48
		}
	end,
	copy = function(t25: {[any]: any}) --[[ copy ]] -- line: 114
		return {
			components = table.clone(t25.components),
			value = t25.value,
			encode = t25.encode,
			decode = t25.decode
		}
	end,
	zero = function(t26: {[any]: any}) --[[ zero ]] -- line: 123
		local components = t26.components

		for v52 in components do
			components[v52] = components[v52] * 0
		end

		t26.dirty = true

		return t26
	end,
	setValue = function(t27: {[any]: any}, p2) --[[ setValue ]] -- line: 146
		-- upvalues: merge (copy)
		local v59

		if t27.dirty then
			v59 = t27.decode(t27.components)
			t27.value = v59
			t27.dirty = nil
		else
			v59 = t27.value
		end

		if type(p2) == "table" then
			p2 = merge(v59, p2)
		end

		if p2 == v59 then
			return false
		end

		t27.encode(t27.components, p2)
		t27.value = p2
		t27.dirty = nil

		return true
	end,
	addValue = function(t28: {[any]: any}, p3) --[[ addValue ]] -- line: 164
		local t29 = {}

		t28.encode(t29, p3)

		for v63, v64 in t29 do
			local components = t28.components

			components[v63] = components[v63] + v64
		end

		t28.dirty = true
	end,
	getValue = function(t30: {[any]: any}) --[[ getValue ]] -- line: 142
		if t30.dirty then
			local v56 = t30.decode(t30.components)

			t30.value = v56
			t30.dirty = nil

			return v56
		end

		return t30.value
	end,
	recomputeValue = function(t31: {[any]: any}) --[[ recomputeValue ]] -- line: 135
		local v54 = t31.decode(t31.components)

		t31.value = v54
		t31.dirty = nil

		return v54
	end,
	assign = function(t32: {[any]: any}, t33: {[any]: any}) --[[ assign ]] -- line: 176
		for v68, v69 in t33.components do
			t32.components[v68] = v69
		end

		local v70

		if t33.dirty then
			v70 = t33.decode(t33.components)
			t33.value = v70
			t33.dirty = nil
		else
			v70 = t33.value
		end

		t32.value = v70
		t32.dirty = nil
	end,
	lerp = function(t34: {[any]: any}, t35: {[any]: any}, t36: {[any]: any}, n2: number) --[[ lerp ]] -- line: 185
		for v75, v76 in t36.components do
			local v77 = t35.components[v75]

			t34.components[v75] = v77 + (v76 - v77) * n2
		end

		t34.dirty = true
	end
}
