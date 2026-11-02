-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: spring, time of decompilation: Sun May  3 10:09:45 2026 ]]
local graph = require("./graph")
local create_node = graph.create_node
local create_source_node = graph.create_source_node
local assert_stable_scope = graph.assert_stable_scope
local evaluate_node = graph.evaluate_node
local update_descendants = graph.update_descendants
local push_scope_as_child_of = graph.push_scope_as_child_of
local t1 = {
	number = function(p1) -- line: 46
		return vector.create(p1, 0, 0), (Vector3.new(0, 0, 0))
	end,
	CFrame = function(p2) -- line: 50
		return p2.Position, (vector.create(p2:ToEulerAnglesXYZ()))
	end,
	Color3 = function(p3) -- line: 54
		return vector.create(p3.R, p3.G, p3.B), (Vector3.new(0, 0, 0))
	end,
	UDim = function(p4) -- line: 59
		return vector.create(p4.Scale, p4.Offset, 0), (Vector3.new(0, 0, 0))
	end,
	UDim2 = function(p5) -- line: 63
		return vector.create(p5.X.Scale, p5.X.Offset, p5.Y.Scale), (vector.create(p5.Y.Offset, 0, 0))
	end,
	Vector2 = function(p6) -- line: 67
		return vector.create(p6.X, p6.Y, 0), (Vector3.new(0, 0, 0))
	end,
	Vector3 = function(p7) -- line: 71
		return p7, (Vector3.new(0, 0, 0))
	end,
	Rect = function(p8) -- line: 75
		return vector.create(p8.Min.X, p8.Min.Y, p8.Max.X), (vector.create(p8.Max.Y, 0, 0))
	end,
	table = function(p9) -- line: 79
		return vector.create(p9[1] or 0, p9[2] or 0, p9[3] or 0), (vector.create(p9[4] or 0, 0, 0))
	end
}
local t2 = {
	number = function(p10, _) -- line: 85
		return p10.X
	end,
	CFrame = function(p12, p13) -- line: 89
		return CFrame.new(p12) * CFrame.fromEulerAnglesXYZ(p13.X, p13.Y, p13.Z)
	end,
	Color3 = function(p14) -- line: 93
		return Color3.new(math.clamp(p14.X, 0, 1), math.clamp(p14.Y, 0, 1), (math.clamp(p14.Z, 0, 1)))
	end,
	UDim = function(p15) -- line: 97
		return UDim.new(p15.X, (math.round(p15.Y)))
	end,
	UDim2 = function(p16, p17) -- line: 101
		return UDim2.new(p16.X, math.round(p16.Y), p16.Z, (math.round(p17.X)))
	end,
	Vector2 = function(p18) -- line: 105
		return Vector2.new(p18.X, p18.Y)
	end,
	Vector3 = function(p19) -- line: 109
		return p19
	end,
	Rect = function(p20, p21) -- line: 113
		return Rect.new(p20.X, p20.Y, p20.Z, p21.X)
	end,
	table = function(p22, p23) -- line: 117
		return {
			p22.X,
			p22.Y,
			p22.Z,
			p23.X
		}
	end
}
local t3 = {
	__index = function(_, s1: string) --[[ __index ]] -- line: 123
		error(`cannot spring type { s1 }`, 0)
	end
}

setmetatable(t1, t3)
setmetatable(t2, t3)

local t4 = {}

setmetatable(t4, {
	__mode = "v"
})

local function spring(p25: ((...any) -> ...any), n1: number?, n2: number?) -- line: 136
	-- upvalues: assert_stable_scope (copy), create_source_node (copy), t1 (copy), t4 (copy), create_node (copy), evaluate_node (copy), push_scope_as_child_of (copy)
	local v43 = assert_stable_scope()
	local v44 = 6.283185307179586 / (n1 or 1)
	local v45 = n2 or 1
	local v46 = v44 ^ 2
	local v47 = v45 * (2 * v44)

	if v47 > 240 then
		error("spring damping too high, consider reducing damping or increasing period", 0)
	end

	local t5 = {
		x0_123 = Vector3.new(0, 0, 0),
		x_123 = Vector3.new(0, 0, 0),
		x1_123 = Vector3.new(0, 0, 0),
		v_123 = Vector3.new(0, 0, 0),
		x0_456 = Vector3.new(0, 0, 0),
		x_456 = Vector3.new(0, 0, 0),
		x1_456 = Vector3.new(0, 0, 0),
		v_456 = Vector3.new(0, 0, 0),
		source_value = false,
		k = v46,
		c = v47
	}
	local v49 = create_source_node(false)
	local v50 = create_node(v43, function() --[[ updater_effect ]] -- line: 171
		-- upvalues: p25 (copy), t5 (copy), t1 (copy), t4 (copy), v49 (copy)
		local v92 = p25()
		local v93 = t5
		local v94 = t5
		local v95, v96 = t1[typeof(v92)](v92)

		v93.x1_123 = v95
		v94.x1_456 = v96
		t5.source_value = v92
		t4[t5] = v49

		return v92
	end, false)

	evaluate_node(v50)

	local x1_123 = t5.x1_123
	local x1_456 = t5.x1_456

	t5.x_123 = x1_123
	t5.x_456 = x1_456
	v49.cache = t5.source_value

	return function(...) -- line: 213
		-- upvalues: push_scope_as_child_of (copy), v49 (copy), t5 (copy), t1 (copy), t4 (copy)
		if select("#", ...) == 0 then
			push_scope_as_child_of(v49)

			return v49.cache
		end

		local v115 = ...
		local v116 = t5
		local v117 = t5
		local v118, v119 = t1[typeof(v115)](v115)

		v116.x_123 = v118
		v117.x_456 = v119
		t5.v_123 = Vector3.new(0, 0, 0)
		t5.v_456 = Vector3.new(0, 0, 0)
		t4[t5] = v49
		v49.cache = v115

		return v115
	end, function(p26) -- line: 188
		-- upvalues: t1 (copy), t5 (copy), t4 (copy), v49 (copy)
		local position = p26.position
		local velocity = p26.velocity
		local impulse = p26.impulse

		if position then
			local v101, v102 = t1[typeof(position)](position)
			local v103 = t5
			local v104 = t5

			v103.x_123 = v101
			v104.x_456 = v102

			local v105 = t5
			local v106 = t5

			v105.x0_123 = v101
			v106.x0_456 = v102
		end

		if velocity then
			local v107 = t5
			local v108 = t5
			local v109, v110 = t1[typeof(velocity)](velocity)

			v107.v_123 = v109
			v108.v_456 = v110
		end

		if impulse then
			local v111, v112 = t1[typeof(impulse)](impulse)
			local v113 = t5

			v113.v_123 = v113.v_123 + v111

			local v114 = t5

			v114.v_456 = v114.v_456 + v112
		end

		t4[t5] = v49
	end
end
local function step_springs(n3: number) -- line: 249
	-- upvalues: t4 (copy)
	for v56 in t4 do
		local k = v56.k
		local c = v56.c
		local x_123 = v56.x_123
		local x_456 = v56.x_456
		local x1_123 = v56.x1_123
		local x1_456 = v56.x1_456
		local v_123 = v56.v_123
		local v_456 = v56.v_456
		local v65 = x_123 - x1_123
		local v66 = x_456 - x1_456
		local v67 = v65 * -k
		local v68 = v66 * -k
		local v69 = v_123 * -c
		local v70 = v_456 * -c
		local v71 = v67 + v69
		local v72 = v68 + v70
		local v73 = v_123 + v71 * n3
		local v74 = v_456 + v72 * n3
		local v75 = x_123 + v73 * n3
		local v76 = x_456 + v74 * n3

		v56.x_123 = v75
		v56.x_456 = v76
		v56.v_123 = v73
		v56.v_456 = v74
	end
end
local function update_spring_sources() -- line: 286
	-- upvalues: t4 (copy), t2 (copy), update_descendants (copy)
	for v77, v78 in t4 do
		local x0_123 = v77.x0_123
		local x0_456 = v77.x0_456
		local x_123 = v77.x_123
		local x_456 = v77.x_456
		local x1_123 = v77.x1_123
		local x1_456 = v77.x1_456
		local v_123 = v77.v_123
		local v_456 = v77.v_456
		local v87 = x0_123 - x1_123
		local v88 = vector.abs((vector.create(v87.x / 10000, v87.y / 10000, v87.z / 10000)))
		local v89 = x0_456 - x1_456
		local v90 = vector.abs((vector.create(v89.x / 10000, v89.y / 10000, v89.z / 10000)))

		if v88 == vector.max(vector.abs(x_123 - x1_123), v88) and v90 == vector.max(vector.abs(x_456 - x1_456), v90) and v88 == vector.max(vector.abs(v_123 / 10), v88) and v90 == vector.max(vector.abs(v_456 / 10), v90) then
			t4[v77] = nil
			v78.cache = v77.source_value
		else
			v78.cache = t2[typeof(v77.source_value)](x_123, x_456)
		end

		update_descendants(v78)
	end
end

return function() -- line: 315
	-- upvalues: spring (copy), step_springs (copy), update_spring_sources (copy)
	local n4 = 0

	return spring, function(n5: number) -- line: 318
		-- upvalues: n4 (ref), step_springs (copy), update_spring_sources (copy)
		n4 += n5

		while n4 > 0.008333333333333333 do
			n4 -= 0.008333333333333333
			step_springs(0.008333333333333333)
		end

		update_spring_sources()
	end
end
