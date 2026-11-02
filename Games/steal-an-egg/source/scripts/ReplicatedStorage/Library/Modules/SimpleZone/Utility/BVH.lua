-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
function traverseBVH(p1, p2) --[[ traverseBVH | Line: 18 ]]
	local t = { p1 }
	local count = 1
	local v1 = false

	local function stop() --[[ stop | Line: 23 | Upvalues: t (copy), v1 (ref) ]]
		table.clear(t)
		v1 = true
	end

	while count > 0 and not v1 do
		local v2 = t[count]

		count = count - 1

		if not (v2.volume < 0.001) and p2(v2, stop) then
			if v2.right then
				count = count + 1
				t[count] = v2.right
			end

			if v2.left then
				count = count + 1
				t[count] = v2.left
			else
				continue
			end
		end
	end
end

local function getBoundingBox(p1) --[[ getBoundingBox | Line: 56 ]]
	local v1 = Vector3.new(inf, inf, inf)
	local v2 = Vector3.new(-inf, -inf, -inf)

	for v3, v4 in p1 do
		local cframe = v4.cframe
		local v5 = v4.size * 0.5
		local t = {}
		local v9 = cframe.Position + vector.create(-v5.X, -v5.Y, -v5.Z)
		local v12 = cframe.Position + vector.create(v5.X, -v5.Y, -v5.Z)
		local v15 = cframe.Position + vector.create(-v5.X, v5.Y, -v5.Z)
		local v17 = cframe.Position + vector.create(v5.X, v5.Y, -v5.Z)
		local v20 = cframe.Position + vector.create(-v5.X, -v5.Y, v5.Z)
		local v22 = cframe.Position + vector.create(v5.X, -v5.Y, v5.Z)
		local v24 = cframe.Position + vector.create(-v5.X, v5.Y, v5.Z)

		t[1] = v9
		t[2] = v12
		t[3] = v15
		t[4] = v17
		t[5] = v20
		t[6] = v22
		t[7] = v24
		t[8] = cframe.Position + vector.create(v5.X, v5.Y, v5.Z)

		for v25, v26 in t do
			v1, v2 = vector.create(math.min(v1.X, v26.X) // 4 * 4, math.min(v1.Y, v26.Y) // 4 * 4, math.min(v1.Z, v26.Z) // 4 * 4), vector.create(math.max(v2.X, v26.X) // 4 * 4, math.max(v2.Y, v26.Y) // 4 * 4, math.max(v2.Z, v26.Z) // 4 * 4)
		end
	end

	return CFrame.new((v1 + v2) / 2), v2 - v1
end

local function determine(p1, p2, p3) --[[ determine | Line: 100 | Upvalues: getBoundingBox (copy) ]]
	if #p3 > 1 then
		local v1, v2 = getBoundingBox(p3)

		p1[p2] = {
			cframe = v1,
			size = v2,
			volume = v2.x * v2.y * v2.z
		}
		split(p1[p2], p3)

		return
	end

	if #p3 ~= 1 then
		return
	end

	local v3 = p3[1]

	p1[p2] = {
		cframe = v3.cframe,
		size = v3.size,
		volume = v3.size.x * v3.size.y * v3.size.z,
		part = v3.part
	}
end

function split(p1, p2) --[[ split | Line: 121 | Upvalues: determine (copy) ]]
	local size = p1.size
	local v1 = nil

	if size.X >= size.Y and size.X >= size.Z then
		v1 = "X"
	elseif size.Y >= size.X and size.Y >= size.Z then
		v1 = "Y"
	elseif size.Z >= size.Y and size.Z >= size.X then
		v1 = "Z"
	end

	table.sort(p2, function(p1, p2) --[[ Line: 133 | Upvalues: v1 (ref) ]]
		return p1.cframe[v1] < p2.cframe[v1]
	end)

	local v2 = #p2
	local v3 = v2 // 2
	local v4 = table.create(v3)
	local v5 = table.create(v3)

	table.move(p2, 1, v3, 1, v4)
	table.move(p2, v3 + 1, v2, 1, v5)
	determine(p1, "left", v4)
	determine(p1, "right", v5)
end

local function createBVH(p1) --[[ createBVH | Line: 149 | Upvalues: getBoundingBox (copy) ]]
	local v1, v2 = getBoundingBox(p1)
	local t = {
		cframe = v1,
		size = v2,
		volume = v2.x * v2.y * v2.z
	}

	split(t, p1)

	return t
end

local function calculateDistance(p1, p2) --[[ calculateDistance | Line: 163 ]]
	return (p1.cframe.Position - p2.cframe.Position).Magnitude
end

local function needsUpdate(p1, p2, p3) --[[ needsUpdate | Line: 170 ]]
	return if p3 < (p1.cframe.Position - p2.cframe.Position).Magnitude then true else p3 < (p1.size - p2.size).Magnitude
end

local function v1(p1, p2, p3, p4) --[[ updateBVHNode | Line: 179 | Upvalues: v1 (copy) ]]
	if not p1 then
		return
	end

	if p1.part then
		local t = {
			cframe = p1.cframe,
			size = p1.size,
			volume = p1.volume,
			part = p1.part
		}
		local v12 = nil

		for v2, v3 in p3 do
			if v3.part == p1.part then
				v12 = v3

				break
			end
		end

		if not v12 then
			return false
		end

		if if p4 < (t.cframe.Position - v12.cframe.Position).Magnitude then true else p4 < (t.size - v12.size).Magnitude then
			p1.cframe = v12.cframe
			p1.size = v12.size
			p1.volume = v12.volume

			return true
		end

		return false
	end

	if not (v1(p1.left, p2, p3, p4) or v1(p1.right, p2, p3, p4)) then
		return false
	end

	local v5 = p1.left and {
		cframe = p1.left.cframe,
		size = p1.left.size,
		volume = p1.left.volume
	}
	local v6 = p1.right and {
		cframe = p1.right.cframe,
		size = p1.right.size,
		volume = p1.right.volume
	}

	if v5 and v6 then
		local Position = v5.cframe.Position
		local Position2 = v6.cframe.Position
		local v16 = vector.create(math.min(Position.X - v5.size.X / 2, Position2.X - v6.size.X / 2) // 4 * 4, math.min(Position.Y - v5.size.Y / 2, Position2.Y - v6.size.Y / 2) // 4 * 4, math.min(Position.Z - v5.size.Z / 2, Position2.Z - v6.size.Z / 2) // 4 * 4)
		local v26 = vector.create(math.max(Position.X + v5.size.X / 2, Position2.X + v6.size.X / 2) // 4 * 4, math.max(Position.Y + v5.size.Y / 2, Position2.Y + v6.size.Y / 2) // 4 * 4, math.max(Position.Z + v5.size.Z / 2, Position2.Z + v6.size.Z / 2) // 4 * 4)
		local v27 = v26 - v16

		p1.cframe = CFrame.new((v16 + v26) / 2)
		p1.size = v27
		p1.volume = v27.x * v27.y * v27.z
	elseif v5 then
		p1.cframe = v5.cframe
		p1.size = v5.size
		p1.volume = v5.volume
	else
		if not v6 then
			return true
		end

		p1.cframe = v6.cframe
		p1.size = v6.size
		p1.volume = v6.volume
	end

	return true
end

local function updateBVH(p1, p2, p3, p4) --[[ updateBVH | Line: 282 | Upvalues: v1 (copy) ]]
	return v1(p1, p2, p3, p4 or 0.1)
end

local function visualize(p1) --[[ visualize | Line: 290 ]]
	traverseBVH(p1, function(p1) --[[ Line: 291 ]]
		local Part = Instance.new("Part")

		Part.Anchored = true
		Part.Transparency = 0.7
		Part.CFrame = p1.cframe
		Part.Size = p1.size
		Part.Parent = workspace
		Part.CanCollide = false
		Part.CanQuery = false

		if p1.right or p1.left then
			return true
		end

		Part.Color = Color3.fromRGB(255, 0, 0)

		return true
	end)
end

return {
	VoxelSize = 4,
	createBVH = createBVH,
	traverseBVH = traverseBVH,
	updateBVH = updateBVH,
	getBoundingBox = getBoundingBox,
	visualize = visualize
}