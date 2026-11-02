-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: GameplayFormationUtils, time of decompilation: Sun May  3 10:11:20 2026 ]]
local GameplayServiceUtils = require(script.Parent.Parent.GameplayServiceUtils)
local t1 = {}

local function getApproachAngle(vector3: Vector3, vector3_2: Vector3, vector3_3: Vector3) -- line: 61
	local v18 = Vector3.new(vector3_2.X, 0, vector3_2.Z) - Vector3.new(vector3.X, 0, vector3.Z)

	if v18.Magnitude <= 0.001 or v18.Magnitude ~= v18.Magnitude then
		local vector3_4 = Vector3.new(vector3_3.X, 0, vector3_3.Z)
		local Unit

		if vector3_4.Magnitude > 0.001 and vector3_4.Magnitude == vector3_4.Magnitude then
			Unit = vector3_4.Unit
		else
			local vector3_5 = Vector3.new(0, 0, 1)

			Unit = if not (vector3_5.Magnitude > 0.001) or vector3_5.Magnitude ~= vector3_5.Magnitude then Vector3.new(0, 0, 1) else vector3_5.Unit
		end

		v18 = -Unit
	end

	if v18.Magnitude <= 0.001 or v18.Magnitude ~= v18.Magnitude then
		v18 = Vector3.new(0, 0, 1)
	end

	return (math.atan2(v18.Z, v18.X))
end

function t1.getFormationBasis(vector3: Vector3, vector3_6: Vector3?, vector3_7: Vector3?, n1: number) -- line: 74
	local v26 = if not vector3_6 then Vector3.new(0, 0, 0) else Vector3.new(vector3_6.X, 0, vector3_6.Z)
	local vector3_8 = Vector3.new(vector3.X, 0, vector3.Z)
	local Unit

	if vector3_8.Magnitude > 0.001 and vector3_8.Magnitude == vector3_8.Magnitude then
		Unit = vector3_8.Unit
	else
		local vector3_9 = Vector3.new(0, 0, 1)

		Unit = if not (vector3_9.Magnitude > 0.001) or vector3_9.Magnitude ~= vector3_9.Magnitude then Vector3.new(0, 0, 1) else vector3_9.Unit
	end

	if not vector3_7 then
		local vector3_10 = Vector3.new(Unit.Z, 0, -Unit.X)

		if vector3_10.Magnitude > 0.001 and vector3_10.Magnitude == vector3_10.Magnitude then
			return v26, Unit, vector3_10.Unit
		end

		return v26, Unit, (Vector3.new(1, 0, 0))
	end

	local vector3_11 = Vector3.new(vector3_7.X, 0, vector3_7.Z)
	local Unit2

	if vector3_11.Magnitude > 0.001 and vector3_11.Magnitude == vector3_11.Magnitude then
		Unit2 = vector3_11.Unit
	else
		local vector3_12 = Vector3.new(Unit.X, 0, Unit.Z)

		Unit2 = if not (vector3_12.Magnitude > 0.001) or vector3_12.Magnitude ~= vector3_12.Magnitude then Vector3.new(0, 0, 1) else vector3_12.Unit
	end

	local v34 = Unit:Lerp(Unit2, (math.clamp(n1 * 8, 0, 1)))
	local vector3_13 = Vector3.new(v34.X, 0, v34.Z)
	local Unit3

	if vector3_13.Magnitude > 0.001 and vector3_13.Magnitude == vector3_13.Magnitude then
		Unit3 = vector3_13.Unit
	else
		local vector3_14 = Vector3.new(Unit2.X, 0, Unit2.Z)

		Unit3 = if not (vector3_14.Magnitude > 0.001) or vector3_14.Magnitude ~= vector3_14.Magnitude then Vector3.new(0, 0, 1) else vector3_14.Unit
	end

	local vector3_15 = Vector3.new(Unit3.Z, 0, -Unit3.X)

	if vector3_15.Magnitude > 0.001 and vector3_15.Magnitude == vector3_15.Magnitude then
		return v26, Unit3, vector3_15.Unit
	end

	return v26, Unit3, (Vector3.new(1, 0, 0))
end
function t1.getSortedSlimes(t2: {[any]: any}) -- line: 93
	local t3 = {}

	for _, v42 in t2 do
		table.insert(t3, v42)
	end

	table.sort(t3, function(p1, p2) -- line: 99
		return p1.uniqueId < p2.uniqueId
	end)

	return t3
end
function t1.getFollowFormationSlots(t4: {[any]: any}, vector3: Vector3, vector3_16: Vector3, vector3_17: Vector3) -- line: 106
	local t5 = {}
	local n2 = 1
	local n3 = 1

	while n2 <= #t4 do
		local v50 = math.min(n3 * 2 + 1, #t4 - n2 + 1)
		local v51 = math.min((n3 - 1) * 0.1308996938995747 + 1.1344640137963142, 1.3962634015954636)
		local v52 = (n3 - 1) * 4.5 + 5

		if v50 > 1 then
			v52 = math.max(v52, 5.5 / (math.sin(v51 * 2 / (v50 - 1) / 2) * 2))
		end

		for i = 1, v50 do
			local v54 = t4[n2]
			local n4 = 0

			if v50 > 1 then
				local v56 = (i - 1) / (v50 - 1)

				n4 = -v51 + v56 * (v51 * 2)
			end

			local v57 = (-vector3_16 * math.cos(n4) + vector3_17 * math.sin(n4)) * v52

			t5[v54.uniqueId] = vector3 + v57
			n2 += 1
		end

		n3 += 1
	end

	return t5
end
function t1.getAttackFormationSlots(t6: {[any]: any}, t7: {[any]: any}, vector3: Vector3) -- line: 147
	-- upvalues: GameplayServiceUtils (copy), getApproachAngle (copy)
	local t8 = {}
	local t9 = {}
	local slimeStates = GameplayServiceUtils.enums.slimeStates

	for _, v65 in t6 do
		if v65.targetUniqueId and ((v65.state == slimeStates.targeting or v65.state == slimeStates.attacking) and t7[v65.targetUniqueId]) then
			t9[v65.targetUniqueId] = t9[v65.targetUniqueId] or {}
			table.insert(t9[v65.targetUniqueId], v65)
		end
	end

	for v66, v67 in t9 do
		table.sort(v67, function(p3, p4) -- line: 167
			return p3.uniqueId < p4.uniqueId
		end)

		local v68 = t7[v66]

		if v68 then
			local t10 = {}
			local v70 = nil
			local n5 = 1e999

			for _, v73 in v67 do
				local v74 = getApproachAngle(v68.pos, v73.pos, vector3)
				local v75 = v68.pos + Vector3.new(math.cos(v74), 0, (math.sin(v74))) * 8
				local pos = v73.pos
				local Magnitude = (Vector3.new(pos.X, 0, pos.Z) - Vector3.new(v75.X, 0, v75.Z)).Magnitude

				table.insert(t10, {
					slime = v73,
					approachAngle = v74
				})

				if Magnitude < n5 then
					n5 = Magnitude
					v70 = v74
				end
			end

			table.sort(t10, function(p5, p6) -- line: 195
				return p5.approachAngle < p6.approachAngle
			end)

			local v78 = #t10
			local t11 = {}

			if v78 == 1 then
				t11[1] = v70 or 0
			else
				local v80 = 6.283185307179586 / v78
				local n6 = 1e999
				local v82 = nil

				for _, v84 in {
					1,
					-1
				} do
					for i = 0, v78 - 1 do
						local t12 = table.create(v78)
						local n7 = 0

						for v88, v89 in t10 do
							local v90 = (v88 - 1 + i) % v78
							local v91 = (v70 or 0) + v84 * v90 * v80
							local v92 = math.atan2(math.sin(v91), (math.cos(v91)))

							t12[v88] = v92

							local v93 = v89.approachAngle - v92

							n7 += math.abs((math.atan2(math.sin(v93), (math.cos(v93)))))
						end

						if n7 < n6 then
							n6 = n7
							v82 = t12
						end
					end
				end

				t11 = v82 or t11
			end

			for v94, v95 in t10 do
				local v96 = t11[v94] or 0
				local v97 = Vector3.new(math.cos(v96), 0, (math.sin(v96))) * 8
				local uniqueId = v95.slime.uniqueId
				local v99 = v68.pos + v97

				t8[uniqueId] = Vector3.new(v99.X, 0, v99.Z)
			end
		end
	end

	return t8
end

return t1
