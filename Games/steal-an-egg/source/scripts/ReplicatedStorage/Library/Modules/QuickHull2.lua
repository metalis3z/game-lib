-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local NaN = math.NaN
local v1 = 0

local function Cross(p1, p2) --[[ Cross | Line: 15 ]]
	return Vector3.new(p1.y * p2.z - p1.z * p2.y, p1.z * p2.x - p1.x * p2.z, p1.x * p2.y - p1.y * p2.x)
end

local function Dot(p1, p2) --[[ Dot | Line: 19 ]]
	return p1.x * p2.x + p1.y * p2.y + p1.z * p2.z
end

local function PointFaceDistance(p1, p2, p3) --[[ PointFaceDistance | Line: 23 ]]
	local Normal = p3.Normal
	local v1 = p1 - p2

	return Normal.x * v1.x + Normal.y * v1.y + Normal.z * v1.z
end

local function Normal(p1, p2, p3) --[[ Normal | Line: 27 ]]
	local v1 = p2 - p1
	local v2 = p3 - p1

	return Vector3.new(v1.y * v2.z - v1.z * v2.y, v1.z * v2.x - v1.x * v2.z, v1.x * v2.y - v1.y * v2.x).Unit
end

local function AreCoincident(p1, p2) --[[ AreCoincident | Line: 31 ]]
	return (p1 - p2).Magnitude <= 0.0001
end

local function AreCollinear(p1, p2, p3) --[[ AreCollinear | Line: 35 ]]
	local v1 = p3 - p1
	local v2 = p3 - p2

	return Vector3.new(v1.y * v2.z - v1.z * v2.y, v1.z * v2.x - v1.x * v2.z, v1.x * v2.y - v1.y * v2.x).Magnitude <= 0.0001
end

local function AreCoplanar(p1, p2, p3, p4) --[[ AreCoplanar | Line: 39 ]]
	local v1 = p3 - p1
	local v2 = p3 - p2
	local v6 = Vector3.new(v1.y * v2.z - v1.z * v2.y, v1.z * v2.x - v1.x * v2.z, v1.x * v2.y - v1.y * v2.x)
	local v7 = p4 - p1
	local v8 = p4 - p2
	local v12 = Vector3.new(v7.y * v8.z - v7.z * v8.y, v7.z * v8.x - v7.x * v8.z, v7.x * v8.y - v7.y * v8.x)
	local Magnitude = v6.Magnitude
	local Magnitude2 = v12.Magnitude
	local v13

	if Magnitude <= 0.0001 or Magnitude2 <= 0.0001 then
		v13 = true
	else
		local v14 = 1 / Magnitude2 * v12
		local v15 = v14 - Vector3.new(0, 0, 0)
		local v16 = v14 - 1 / Magnitude * v6

		v13 = Vector3.new(v15.y * v16.z - v15.z * v16.y, v15.z * v16.x - v15.x * v16.z, v15.x * v16.y - v15.y * v16.x).Magnitude <= 0.0001
	end

	return v13
end

local function Face(p1, p2, p3, p4, p5, p6, p7) --[[ Face | Line: 49 ]]
	return {
		Vertex0 = p1,
		Vertex1 = p2,
		Vertex2 = p3,
		Opposite0 = p4,
		Opposite1 = p5,
		Opposite2 = p6,
		Normal = p7
	}
end

function FaceEquals(p1, p2) --[[ FaceEquals | Line: 61 ]]
	return if p1.Vertex0 == p2.Vertex0 and (p1.Vertex1 == p2.Vertex1 and (p1.Vertex2 == p2.Vertex2 and (p1.Opposite0 == p2.Opposite0 and (p1.Opposite1 == p2.Opposite1 and p1.Opposite2 == p2.Opposite2)))) then p1.Normal == p2.Normal else false
end

local function PointFace(p1, p2, p3) --[[ PointFace | Line: 71 ]]
	return {
		Point = p1,
		Face = p2,
		Distance = p3
	}
end

local function HorizonEdge(p1, p2, p3) --[[ HorizonEdge | Line: 79 ]]
	return {
		Face = p1,
		Edge0 = p2,
		Edge1 = p3
	}
end

local function Contains(p1, p2) --[[ Contains | Line: 87 ]]
	for k, v in pairs(p1) do
		if p2 == v then
			return true
		end
	end

	return false
end

local function Count(p1) --[[ Count | Line: 96 ]]
	return #p1
end

local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {}
local v2 = -1
local v3 = 0

local function HasEdge(p1, p2, p3) --[[ HasEdge | Line: 108 ]]
	return if p1.Vertex0 == p2 and p1.Vertex1 == p3 or p1.Vertex1 == p2 and p1.Vertex2 == p3 then true elseif p1.Vertex2 == p2 then p1.Vertex0 == p3 else false
end

local function VerifyFaces(p1) --[[ VerifyFaces | Line: 114 | Upvalues: t2 (ref) ]]
	for k, v in pairs(t2) do
		local v1, v2, v3

		assert(t2[v.Opposite0] ~= nil, "faces[face.Opposite0] is nil")
		assert(if t2[v.Opposite1] == nil then false else true, "faces[face.Opposite1] is nil")
		assert(if t2[v.Opposite2] == nil then false else true, "faces[face.Opposite2] is nil")
		assert(if v.Opposite0 == k then false else true, "face.Opposite0 should not equal the current face index")
		assert(if v.Opposite1 == k then false else true, "face.Opposite1 should not equal the current face index")
		assert(if v.Opposite2 == k then false else true, "face.Opposite2 should not equal the current face index")
		assert(if v.Vertex0 == v.Vertex1 then false else true, "face.Vertex0 should not equal face.Vertex1")
		assert(if v.Vertex0 == v.Vertex2 then false else true, "face.Vertex0 should not equal face.Vertex2")
		assert(if v.Vertex1 == v.Vertex2 then false else true, "face.Vertex1 should not equal face.Vertex2")

		local v13 = t2[v.Opposite0]
		local Vertex2 = v.Vertex2
		local Vertex1 = v.Vertex1

		v1 = if v13.Vertex0 == Vertex2 and v13.Vertex1 == Vertex1 or v13.Vertex1 == Vertex2 and v13.Vertex2 == Vertex1 then true elseif v13.Vertex2 == Vertex2 then if v13.Vertex0 == Vertex1 then true else false else false
		assert(v1)

		local v14 = t2[v.Opposite1]
		local Vertex0 = v.Vertex0
		local Vertex22 = v.Vertex2

		v2 = if v14.Vertex0 == Vertex0 and v14.Vertex1 == Vertex22 or v14.Vertex1 == Vertex0 and v14.Vertex2 == Vertex22 then true elseif v14.Vertex2 == Vertex0 then if v14.Vertex0 == Vertex22 then true else false else false
		assert(v2)

		local v15 = t2[v.Opposite2]
		local Vertex12 = v.Vertex1
		local Vertex02 = v.Vertex0

		v3 = if v15.Vertex0 == Vertex12 and v15.Vertex1 == Vertex02 or v15.Vertex1 == Vertex12 and v15.Vertex2 == Vertex02 then true elseif v15.Vertex2 == Vertex12 then if v15.Vertex0 == Vertex02 then true else false else false
		assert(v3)
	end
end

local function ReassignPoints(p1) --[[ ReassignPoints | Line: 161 | Upvalues: v2 (ref), t3 (ref), t4 (ref), t2 (ref), NaN (copy) ]]
	local count = 0

	while count < v2 do
		count = count + 1

		local v1 = t3[count]
		local Face = v1.Face
		local v3 = false

		for k, v in pairs(t4) do
			if Face == v then
				v3 = true

				break
			end
		end

		if v3 then
			local v4 = p1[v1.Point]
			local v5 = false

			for k, v in pairs(t2) do
				local Normal = v.Normal
				local v7 = v4 - p1[v.Vertex0]
				local v8 = Normal.x * v7.x + Normal.y * v7.y + Normal.z * v7.z

				if v8 > 0.0001 then
					v1.Face = k
					v1.Distance = v8
					t3[count] = v1
					v5 = true

					break
				end
			end

			if v5 == false then
				v1.Face = -1
				v1.Distance = NaN
				t3[count] = t3[v2]
				t3[v2] = v1
				count = count - 1
				v2 = v2 - 1
			else
				continue
			end
		end
	end
end

local function VerifyOpenSet(p1) --[[ VerifyOpenSet | Line: 237 | Upvalues: t3 (ref), v2 (ref), t2 (ref) ]]
	for i = 1, #t3 do
		if v2 < i then
			assert(t3[i].Face == -1, "Expected openSet[" .. i .. "].Face to be INSIDE when index > openSetTail, got " .. tostring(t3[i].Face))

			continue
		end

		assert(if t3[i].Face == -1 then false else true, "Expected openSet[" .. i .. "].Face not to be INSIDE")
		assert(if t3[i].Face == -2 then false else true, "Expected openSet[" .. i .. "].Face not to be UNASSIGNED")

		local Normal = t2[t3[i].Face].Normal
		local v6 = p1[t3[i].Point] - p1[t2[t3[i].Face].Vertex0]
		local v7 = if Normal.x * v6.x + Normal.y * v6.y + Normal.z * v6.z > 0 then true else false
		local Normal2 = t2[t3[i].Face].Normal
		local v10 = p1[t3[i].Point] - p1[t2[t3[i].Face].Vertex0]

		assert(v7, "Expected point at openSet[" .. i .. "] to be outside its face, but PointFaceDistance returned " .. tostring(Normal2.x * v10.x + Normal2.y * v10.y + Normal2.z * v10.z))
	end
end

local function VerifyHorizon() --[[ VerifyHorizon | Line: 272 | Upvalues: t5 (ref), t2 (ref) ]]
	for i = 1, #t5 do
		local v1
		local v2 = if i == 1 then #t5 else i - 1
		local v3 = if t5[v2].Edge1 == t5[i].Edge0 then true else false

		assert(v3, (("Expected horizon[$%*].Edge1 to equal horizon[$%*].Edge0, got $%* and $%*"):format(v2, i, t5[v2].Edge1, t5[i].Edge0)))

		local v5 = t2[t5[i].Face]
		local Edge1 = t5[i].Edge1
		local Edge0 = t5[i].Edge0

		v1 = if v5.Vertex0 == Edge1 and v5.Vertex1 == Edge0 or v5.Vertex1 == Edge1 and v5.Vertex2 == Edge0 then true elseif v5.Vertex2 == Edge1 then if v5.Vertex0 == Edge0 then true else false else false
		assert(v1)
	end
end

local function v4(p1, p2, p3, p4, p5) --[[ SearchHorizon | Line: 293 | Upvalues: t4 (ref), t2 (ref), t5 (ref), v4 (copy) ]]
	table.insert(t4, p4)

	local v2, v3, v42, v5, v6

	if p3 == p5.Opposite0 then
		v2 = p5.Opposite1
		v3 = p5.Opposite2
		v42 = p5.Vertex2
		v5 = p5.Vertex0
		v6 = p5.Vertex1
	elseif p3 == p5.Opposite1 then
		v2 = p5.Opposite2
		v3 = p5.Opposite0
		v42 = p5.Vertex0
		v5 = p5.Vertex1
		v6 = p5.Vertex2
	else
		v2 = p5.Opposite0
		v3 = p5.Opposite1
		v42 = p5.Vertex1
		v5 = p5.Vertex2
		v6 = p5.Vertex0
	end

	local v8 = v2
	local v9 = false

	for k, v in pairs(t4) do
		if v8 == v then
			v9 = true

			break
		end
	end

	if v9 == false then
		local v10 = t2[v2]
		local Normal = v10.Normal
		local v12 = p2 - p1[v10.Vertex0]

		if Normal.x * v12.x + Normal.y * v12.y + Normal.z * v12.z <= 0 then
			table.insert(t5, {
				Face = v2,
				Edge0 = v42,
				Edge1 = v5
			})
		else
			v4(p1, p2, p4, v2, v10)
		end
	end

	local v15 = v3
	local v16 = false

	for k, v in pairs(t4) do
		if v15 == v then
			v16 = true

			break
		end
	end

	if v16 ~= false then
		return
	end

	local v17 = t2[v3]
	local Normal = v17.Normal
	local v19 = p2 - p1[v17.Vertex0]

	if Normal.x * v19.x + Normal.y * v19.y + Normal.z * v19.z <= 0 then
		table.insert(t5, {
			Face = v3,
			Edge0 = v5,
			Edge1 = v6
		})

		return
	end

	v4(p1, p2, p4, v3, v17)
end

local function FindHorizon(p1, p2, p3, p4) --[[ FindHorizon | Line: 383 | Upvalues: t4 (ref), t5 (ref), t2 (ref), v4 (copy) ]]
	t4 = {}
	t5 = {}
	table.insert(t4, p3)

	local v2 = t2[p4.Opposite0]
	local Normal = v2.Normal
	local v42 = p2 - p1[v2.Vertex0]

	if Normal.x * v42.x + Normal.y * v42.y + Normal.z * v42.z <= 0 then
		table.insert(t5, {
			Face = p4.Opposite0,
			Edge0 = p4.Vertex1,
			Edge1 = p4.Vertex2
		})
	else
		v4(p1, p2, p3, p4.Opposite0, v2)
	end

	local Opposite1 = p4.Opposite1
	local v7 = false

	for k, v in pairs(t4) do
		if Opposite1 == v then
			v7 = true

			break
		end
	end

	if v7 == false then
		local v8 = t2[p4.Opposite1]
		local Normal2 = v8.Normal
		local v10 = p2 - p1[v8.Vertex0]

		if Normal2.x * v10.x + Normal2.y * v10.y + Normal2.z * v10.z <= 0 then
			table.insert(t5, {
				Face = p4.Opposite1,
				Edge0 = p4.Vertex2,
				Edge1 = p4.Vertex0
			})
		else
			v4(p1, p2, p3, p4.Opposite1, v8)
		end
	end

	local Opposite2 = p4.Opposite2
	local v13 = false

	for k, v in pairs(t4) do
		if Opposite2 == v then
			v13 = true

			break
		end
	end

	if v13 ~= false then
		return
	end

	local v14 = t2[p4.Opposite2]
	local Normal2 = v14.Normal
	local v16 = p2 - p1[v14.Vertex0]

	if Normal2.x * v16.x + Normal2.y * v16.y + Normal2.z * v16.z <= 0 then
		table.insert(t5, {
			Face = p4.Opposite2,
			Edge0 = p4.Vertex0,
			Edge1 = p4.Vertex1
		})

		return
	end

	v4(p1, p2, p3, p4.Opposite2, v14)
end

local function FindInitialHullIndices(p1) --[[ FindInitialHullIndices | Line: 441 ]]
	local v1 = #p1

	for i = 1, v1 - 2 do
		for j = i + 1, v1 - 1 do
			local v2 = p1[i]
			local v3 = p1[j]

			if not ((v2 - v3).Magnitude <= 0.0001) then
				for k = j + 1, v1 do
					local v5 = p1[k]
					local v6 = v5 - v2
					local v7 = v5 - v3

					if not (Vector3.new(v6.y * v7.z - v6.z * v7.y, v6.z * v7.x - v6.x * v7.z, v6.x * v7.y - v6.y * v7.x).Magnitude <= 0.0001) then
						for n = k + 1, v1 + 1 do
							local v12
							local v13 = p1[n]
							local v14 = v5 - v2
							local v15 = v5 - v3
							local v19 = Vector3.new(v14.y * v15.z - v14.z * v15.y, v14.z * v15.x - v14.x * v15.z, v14.x * v15.y - v14.y * v15.x)
							local v20 = v13 - v2
							local v21 = v13 - v3
							local v25 = Vector3.new(v20.y * v21.z - v20.z * v21.y, v20.z * v21.x - v20.x * v21.z, v20.x * v21.y - v20.y * v21.x)
							local Magnitude = v19.Magnitude
							local Magnitude2 = v25.Magnitude

							if Magnitude <= 0.0001 or Magnitude2 <= 0.0001 then
								v12 = true
							else
								local v26 = 1 / Magnitude2 * v25
								local v27 = v26 - Vector3.new(0, 0, 0)
								local v28 = v26 - 1 / Magnitude * v19

								v12 = Vector3.new(v27.y * v28.z - v27.z * v28.y, v27.z * v28.x - v27.x * v28.z, v27.x * v28.y - v27.y * v28.x).Magnitude <= 0.0001
							end

							if not v12 then
								return i, j, k, n
							end
						end
					end
				end
			end
		end
	end

	error("Can\'t generate hull, points are coplanar")
end

local function GenerateInitialHull(p1) --[[ GenerateInitialHull | Line: 478 | Upvalues: FindInitialHullIndices (copy), v3 (ref), t2 (ref), t3 (ref), NaN (copy), v2 (ref) ]]
	local v1, v22, v32, v4 = FindInitialHullIndices(p1)
	local v5 = p1[v1]
	local v6 = p1[v22]
	local v8 = p1[v4] - v6
	local v9 = v6 - v5
	local v10 = p1[v32] - v5
	local v14 = Vector3.new(v9.y * v10.z - v9.z * v10.y, v9.z * v10.x - v9.x * v10.z, v9.x * v10.y - v9.y * v10.x)

	v3 = 0

	if v8.x * v14.x + v8.y * v14.y + v8.z * v14.z > 0 then
		local v18 = p1[v1]
		local v19 = p1[v32] - v18
		local v20 = p1[v22] - v18

		t2[v3 + 1] = {
			Opposite0 = 4,
			Opposite1 = 2,
			Opposite2 = 3,
			Vertex0 = v1,
			Vertex1 = v32,
			Vertex2 = v22,
			Normal = Vector3.new(v19.y * v20.z - v19.z * v20.y, v19.z * v20.x - v19.x * v20.z, v19.x * v20.y - v19.y * v20.x).Unit
		}
		v3 = v3 + 1

		local v26 = p1[v1]
		local v27 = p1[v22] - v26
		local v28 = p1[v4] - v26

		t2[v3 + 1] = {
			Opposite0 = 4,
			Opposite1 = 3,
			Opposite2 = 1,
			Vertex0 = v1,
			Vertex1 = v22,
			Vertex2 = v4,
			Normal = Vector3.new(v27.y * v28.z - v27.z * v28.y, v27.z * v28.x - v27.x * v28.z, v27.x * v28.y - v27.y * v28.x).Unit
		}
		v3 = v3 + 1

		local v34 = p1[v1]
		local v35 = p1[v4] - v34
		local v36 = p1[v32] - v34

		t2[v3 + 1] = {
			Opposite0 = 4,
			Opposite1 = 1,
			Opposite2 = 2,
			Vertex0 = v1,
			Vertex1 = v4,
			Vertex2 = v32,
			Normal = Vector3.new(v35.y * v36.z - v35.z * v36.y, v35.z * v36.x - v35.x * v36.z, v35.x * v36.y - v35.y * v36.x).Unit
		}
		v3 = v3 + 1

		local v42 = p1[v22]
		local v43 = p1[v32] - v42
		local v44 = p1[v4] - v42

		t2[v3 + 1] = {
			Opposite0 = 3,
			Opposite1 = 2,
			Opposite2 = 1,
			Vertex0 = v22,
			Vertex1 = v32,
			Vertex2 = v4,
			Normal = Vector3.new(v43.y * v44.z - v43.z * v44.y, v43.z * v44.x - v43.x * v44.z, v43.x * v44.y - v43.y * v44.x).Unit
		}
	else
		local v50 = p1[v1]
		local v51 = p1[v22] - v50
		local v52 = p1[v32] - v50

		t2[v3 + 1] = {
			Opposite0 = 4,
			Opposite1 = 3,
			Opposite2 = 2,
			Vertex0 = v1,
			Vertex1 = v22,
			Vertex2 = v32,
			Normal = Vector3.new(v51.y * v52.z - v51.z * v52.y, v51.z * v52.x - v51.x * v52.z, v51.x * v52.y - v51.y * v52.x).Unit
		}
		v3 = v3 + 1

		local v58 = p1[v1]
		local v59 = p1[v4] - v58
		local v60 = p1[v22] - v58

		t2[v3 + 1] = {
			Opposite0 = 4,
			Opposite1 = 1,
			Opposite2 = 3,
			Vertex0 = v1,
			Vertex1 = v4,
			Vertex2 = v22,
			Normal = Vector3.new(v59.y * v60.z - v59.z * v60.y, v59.z * v60.x - v59.x * v60.z, v59.x * v60.y - v59.y * v60.x).Unit
		}
		v3 = v3 + 1

		local v66 = p1[v1]
		local v67 = p1[v32] - v66
		local v68 = p1[v4] - v66

		t2[v3 + 1] = {
			Opposite0 = 4,
			Opposite1 = 2,
			Opposite2 = 1,
			Vertex0 = v1,
			Vertex1 = v32,
			Vertex2 = v4,
			Normal = Vector3.new(v67.y * v68.z - v67.z * v68.y, v67.z * v68.x - v67.x * v68.z, v67.x * v68.y - v67.y * v68.x).Unit
		}
		v3 = v3 + 1

		local v74 = p1[v22]
		local v75 = p1[v4] - v74
		local v76 = p1[v32] - v74

		t2[v3 + 1] = {
			Opposite0 = 3,
			Opposite1 = 1,
			Opposite2 = 2,
			Vertex0 = v22,
			Vertex1 = v4,
			Vertex2 = v32,
			Normal = Vector3.new(v75.y * v76.z - v75.z * v76.y, v75.z * v76.x - v75.x * v76.z, v75.x * v76.y - v75.y * v76.x).Unit
		}
	end

	v3 = v3 + 1

	for i = 1, #p1 do
		if i ~= v1 and (i ~= v22 and (i ~= v32 and i ~= v4)) then
			table.insert(t3, {
				Face = -2,
				Distance = 0,
				Point = i
			})
		end
	end

	table.insert(t3, {
		Face = -1,
		Point = v1,
		Distance = NaN
	})
	table.insert(t3, {
		Face = -1,
		Point = v22,
		Distance = NaN
	})
	table.insert(t3, {
		Face = -1,
		Point = v32,
		Distance = NaN
	})
	table.insert(t3, {
		Face = -1,
		Point = v4,
		Distance = NaN
	})
	v2 = #t3 - 4

	local count = 0

	while count < v2 do
		count = count + 1

		local v85 = t3[count]
		local v86 = false

		for j = 1, 4 do
			local v87 = t2[j]
			local Normal = v87.Normal
			local v90 = p1[v85.Point] - p1[v87.Vertex0]
			local v91 = Normal.x * v90.x + Normal.y * v90.y + Normal.z * v90.z

			if v91 > 0 then
				v85.Face = j
				v85.Distance = v91
				t3[count] = v85
				v86 = true

				break
			end
		end

		if v86 == false then
			v85.Face = -1
			v85.Distance = NaN
			t3[count] = t3[v2]
			t3[v2] = v85
			v2 = v2 - 1
			count = count - 1
		end
	end
end

local function ConstructCone(p1, p2) --[[ ConstructCone | Line: 659 | Upvalues: t4 (ref), t2 (ref), v3 (ref), t5 (ref) ]]
	for k, v in pairs(t4) do
		t2[v] = nil
	end

	local v1 = v3

	for i = 1, #t5 do
		local Edge0 = t5[i].Edge0
		local Edge1 = t5[i].Edge1
		local v4 = v3 + 1

		v3 = v3 + 1

		local v6 = p1[p2]
		local v7 = p1[Edge0] - v6
		local v8 = p1[Edge1] - v6

		t2[v4] = {
			Vertex0 = p2,
			Vertex1 = Edge0,
			Vertex2 = Edge1,
			Opposite0 = t5[i].Face,
			Opposite1 = if i == #t5 then v1 + 1 else v1 + i + 1,
			Opposite2 = if i == 1 then v1 + #t5 else v1 + i - 1,
			Normal = Vector3.new(v7.y * v8.z - v7.z * v8.y, v7.z * v8.x - v7.x * v8.z, v7.x * v8.y - v7.y * v8.x).Unit
		}

		local v12 = t2[t5[i].Face]

		if v12.Vertex0 == Edge0 then
			v12.Opposite1 = v4
		elseif v12.Vertex1 == Edge0 then
			v12.Opposite2 = v4
		else
			v12.Opposite0 = v4
		end

		t2[t5[i].Face] = v12
	end
end

local function GrowHull(p1) --[[ GrowHull | Line: 732 | Upvalues: v1 (ref), t3 (ref), v2 (ref), FindHorizon (copy), t2 (ref), ConstructCone (copy), ReassignPoints (copy) ]]
	v1 = v1 + 1

	local Distance = t3[1].Distance
	local v12 = 1

	for i = 2, v2 do
		if Distance < t3[i].Distance then
			Distance = t3[i].Distance
			v12 = i
		end
	end

	FindHorizon(p1, p1[t3[v12].Point], t3[v12].Face, t2[t3[v12].Face])
	ConstructCone(p1, t3[v12].Point)
	ReassignPoints(p1)
end

function t.GenerateHull(p1, p2) --[[ GenerateHull | Line: 771 | Upvalues: v3 (ref), v2 (ref), t2 (ref), t3 (ref), t4 (ref), t5 (ref), GenerateInitialHull (copy), GrowHull (copy) ]]
	if #p2 < 4 then
		return nil
	end

	v3 = 0
	v2 = -1
	t2 = {}
	t3 = {}
	t4 = {}
	t5 = {}
	GenerateInitialHull(p2)

	while v2 >= 1 do
		GrowHull(p2)
	end

	local t = {}

	for k, v in pairs(t2) do
		local t6 = {}

		table.insert(t6, p2[v.Vertex0])
		table.insert(t6, p2[v.Vertex1])
		table.insert(t6, p2[v.Vertex2])
		table.insert(t, t6)
	end

	return t
end

return t