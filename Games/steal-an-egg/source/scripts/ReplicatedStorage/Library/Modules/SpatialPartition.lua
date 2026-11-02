-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local v1 = t.tuple(t.numberPositive, t.optional(t.boolean), t.optional(t.boolean))
local v2 = t.tuple(t.any, t.CFrame, t.Vector3, t.optional(t.any))
local v3 = t.tuple(t.Vector3, t.numberPositive, t.optional(t.any), t.optional(t.callback), t.optional(t.number))
local v4 = t.tuple(t.CFrame, t.Vector3, t.optional(t.any), t.optional(t.callback), t.optional(t.number))
local v5 = t.tuple(t.Vector3, t.Vector3, t.optional(t.any), t.optional(t.callback), t.optional(t.number))
local Terrain = workspace.Terrain
local max = math.max
local abs = math.abs
local v6 = Vector3.new
local DebugPart = Instance.new("BoxHandleAdornment")

DebugPart.Name = "DebugPart"
DebugPart.Size = Vector3.new(1, 1, 1)
DebugPart.Transparency = 0.9
DebugPart.Color3 = Color3.fromRGB(255, 255, 255)
DebugPart.AlwaysOnTop = false
DebugPart.Adornee = Terrain

local t2 = {}

t2.__index = t2
function t2.new(p1, p2, p3) --[[ new | Line: 69 | Upvalues: v1 (copy), t2 (copy), Trove (copy), DebugPart (copy) ]]
	assert(v1(p1, p2, p3))

	local v3 = setmetatable({}, t2)

	v3._trove = Trove.new()
	v3._size = p1
	v3._debugPartitions = p2
	v3._debugChecks = p3
	v3._nodes = {}
	v3._nodeDestroyConnections = {}
	v3._nodeCount = 0
	v3._debugBoxes = {}
	v3._partitions = {}
	v3._boxTrove = v3._trove:Extend()
	v3._debugTemplate = v3._trove:Clone(DebugPart)
	v3._debugTemplate.Size = Vector3.new(1, 1, 1) * p1

	return v3
end
function t2.GetTotalObjects(p1) --[[ GetTotalObjects | Line: 89 ]]
	return p1._nodeCount
end
function t2.GetObjectsInRadius(p1, p2, p3, p4, p5, p6) --[[ GetObjectsInRadius | Line: 93 | Upvalues: v3 (copy) ]]
	local v1 = p4 or "Default"

	assert(v3(p2, p3, v1, p5, p6))

	local v32, v4 = p1:_getBoundsFromCFrameAndSize(CFrame.new(p2), Vector3.new(1, 1, 1) * p3 * 2)

	return p1:GetObjectsInBounds(v32, v4, v1, function(p1, p22, p32) --[[ Line: 105 | Upvalues: p5 (copy), p2 (copy), p3 (copy) ]]
		return if p5 then p5(p1, p22, p32) and (p32.CFrame.Position - p2).Magnitude <= p3 else (p32.CFrame.Position - p2).Magnitude <= p3
	end, p6)
end
function t2.GetObjectsFromCFrameAndSize(p1, p2, p3, p4, p5, p6) --[[ GetObjectsFromCFrameAndSize | Line: 111 | Upvalues: v4 (copy) ]]
	local v1 = p4 or "Default"

	assert(v4(p2, p3, v1, p5, p6))

	local v3, v42 = p1:_getBoundsFromCFrameAndSize(p2, p3)

	return p1:GetObjectsInBounds(v3, v42, v1, p5, p6)
end
function t2.GetObjectsInBounds(p1, p2, p3, p4, p5, p6) --[[ GetObjectsInBounds | Line: 126 | Upvalues: v5 (copy), Terrain (copy), Debris (copy) ]]
	local v1 = p4 or "Default"

	assert(v5(p2, p3, v1, p5, p6))

	if p1._debugChecks then
		p1._boxTrove:Clean()

		local v3 = p1._boxTrove:Clone(p1._debugTemplate)

		v3.Color3 = Color3.fromRGB(163, 192, 255)
		v3.Size = p3 - p2
		v3.CFrame = CFrame.new(p2:Lerp(p3, 0.5))
		v3.Parent = Terrain
		Debris:AddItem(v3, 1)
	end

	local v4 = p1:_vectorToSpace(p2)
	local v52 = p1:_vectorToSpace(p3)
	local t = {}
	local count = 0
	local t2 = {}

	local function maybePush(p12) --[[ maybePush | Line: 154 | Upvalues: t2 (copy), p1 (copy), p5 (copy), t (copy), count (ref), p6 (copy) ]]
		if t2[p12] then
			return false
		end

		if p5 and not p5(p12, t, p1._nodes[p12]) then
			return false
		end

		t2[p12] = true
		count = count + 1
		t[#t + 1] = p12

		return p6 and p6 <= count and true or false
	end

	local v6, v7 = v4, v52

	for i = v4.X, v52.X do
		for j = v6.Y, v7.Y do
			for k = v6.Z, v7.Z do
				local v8 = p1._partitions[Vector3.new(i, j, k)]
				local v9 = if v8 then v8.ByType[v1] else v8

				if v9 then
					for k2 in pairs(v9) do
						local v10

						if t2[k2] or p5 and not p5(k2, t, p1._nodes[k2]) then
							v10 = false
						else
							t2[k2] = true
							count = count + 1
							t[#t + 1] = k2
							v10 = p6 and p6 <= count and true or false
						end

						if v10 then
							return t, count
						end
					end
				end
			end
		end
	end

	return t, count
end
function t2.RemoveNode(p1, p2) --[[ RemoveNode | Line: 190 | Upvalues: v6 (copy) ]]
	local v1 = p1._nodes[p2]

	if not v1 then
		return
	end

	p1._nodes[p2] = nil
	p1._nodeCount = p1._nodeCount - 1

	local v2 = p1._nodeDestroyConnections[p2]

	if v2 then
		p1._nodeDestroyConnections[p2] = nil
		p1._trove:Remove(v2)
		v2:Disconnect()
	end

	local v3, v4 = p1:_getSpaceBoundsFromCFrameAndSize(v1.CFrame, v1.Size)

	for i = v3.X, v4.X do
		for j = v3.Y, v4.Y do
			for k = v3.Z, v4.Z do
				p1:_removeObjectFromPartition(p2, v6(i, j, k), v1.Type)
			end
		end
	end
end
function t2.SetNodeBox(p1, p2, p3, p4, p5) --[[ SetNodeBox | Line: 216 | Upvalues: v2 (copy) ]]
	local v1 = p5 or "Default"

	assert(v2(p2, p3, p4, v1))

	local v3, v4 = p1:_findOrCreateNode(p2, v1, p3, p4)
	local v5, v6 = p1:_getSpaceBoundsFromCFrameAndSize(p3, p4)
	local v7, v8

	if v4 then
		v7 = nil
		v8 = nil
	else
		local v9, v10 = p1:_getSpaceBoundsFromCFrameAndSize(v3.CFrame, v3.Size)

		v7 = v9
		v8 = v10
	end

	v3.CFrame = p3
	v3.Size = p4
	p1:_setNodeBounds(p2, v1, v7, v8, v5, v6)
end
function t2._findOrCreateNode(p1, p2, p3, p4, p5) --[[ _findOrCreateNode | Line: 239 ]]
	local v1 = p1._nodes[p2]

	if v1 then
		return v1, false
	end

	local t = {
		Size = p5,
		CFrame = p4,
		Type = p3 or "Default"
	}

	p1._nodes[p2] = t
	p1._nodeCount = p1._nodeCount + 1

	if typeof(p2) ~= "Instance" then
		return t, true
	end

	p1._nodeDestroyConnections[p2] = p1._trove:Connect(p2.Destroying, function() --[[ Line: 259 | Upvalues: p1 (copy), p2 (copy) ]]
		p1:RemoveNode(p2)
	end)

	return t, true
end
function t2._getBoundsFromCFrameAndSize(p1, p2, p3) --[[ _getBoundsFromCFrameAndSize | Line: 268 | Upvalues: v6 (copy), abs (copy), max (copy) ]]
	local Position = p2.Position
	local v1 = p2 - Position
	local v2 = p3 * 0.5
	local v3 = v1 * v6(-v2.X, -v2.Y, -v2.Z)
	local v4 = v1 * v6(v2.X, v2.Y, v2.Z)
	local v5 = v1 * v6(-v2.X, v2.Y, -v2.Z)
	local v62 = v1 * v6(-v2.X, -v2.Y, v2.Z)
	local v7 = max(abs(v3.X), abs(v4.X), abs(v5.X), (abs(v62.X)))
	local v8 = max(abs(v3.Y), abs(v4.Y), abs(v5.Y), (abs(v62.Y)))
	local v9 = max(abs(v3.Z), abs(v4.Z), abs(v5.Z), (abs(v62.Z)))

	return v6(Position.X - v7, Position.Y - v8, Position.Z - v9), v6(Position.X + v7, Position.Y + v8, Position.Z + v9)
end
function t2._getSpaceBoundsFromCFrameAndSize(p1, p2, p3) --[[ _getSpaceBoundsFromCFrameAndSize | Line: 284 ]]
	local v1, v2 = p1:_getBoundsFromCFrameAndSize(p2, p3)

	return p1:_vectorToSpace(v1), p1:_vectorToSpace(v2)
end
function t2._vectorToSpace(p1, p2) --[[ _vectorToSpace | Line: 293 | Upvalues: v6 (copy) ]]
	return v6(math.floor(p2.X / p1._size), math.floor(p2.Y / p1._size), (math.floor(p2.Z / p1._size)))
end
function t2._setNodeBounds(p1, p2, p3, p4, p5, p6, p7) --[[ _setNodeBounds | Line: 297 | Upvalues: v6 (copy) ]]
	if p4 == p6 and p5 == p7 then
		return
	end

	if p4 and p5 then
		for i = p4.X, p5.X do
			for j = p4.Y, p5.Y do
				for k = p4.Z, p5.Z do
					if i < p6.X or (p7.X < i or (j < p6.Y or (p7.Y < j or (k < p6.Z or p7.Z < k)))) then
						p1:_removeObjectFromPartition(p2, v6(i, j, k), p3)
					end
				end
			end
		end

		for n = p6.X, p7.X do
			for m = p6.Y, p7.Y do
				for i = p6.Z, p7.Z do
					if n < p4.X or (p5.X < n or (m < p4.Y or (p5.Y < m or (i < p4.Z or p5.Z < i)))) then
						p1:_addObjectToPartition(p2, v6(n, m, i), p3)
					end
				end
			end
		end
	else
		for i = p6.X, p7.X do
			for i2 = p6.Y, p7.Y do
				for i3 = p6.Z, p7.Z do
					p1:_addObjectToPartition(p2, v6(i, i2, i3), p3)
				end
			end
		end
	end
end
function t2._addObjectToPartition(p1, p2, p3, p4) --[[ _addObjectToPartition | Line: 354 ]]
	local v1 = p1._partitions[p3]

	if not v1 then
		local t = {
			Total = 0,
			ByType = {},
			CountByType = {}
		}

		p1._partitions[p3] = t
		p1:_createPartitionBox(p3)
		v1 = t
	end

	local v2 = p4 or "Default"
	local v3 = v1.ByType[v2]

	if not v3 then
		v3 = {}
		v1.ByType[v2] = v3
		v1.CountByType[v2] = 0
	end

	if v3[p2] then
		return
	end

	v3[p2] = true

	local CountByType = v1.CountByType

	CountByType[v2] = CountByType[v2] + 1
	v1.Total = v1.Total + 1
end
function t2._removeObjectFromPartition(p1, p2, p3, p4) --[[ _removeObjectFromPartition | Line: 387 ]]
	local v1 = p1._partitions[p3]

	if not v1 then
		return
	end

	local v2 = p4 or "Default"
	local v3 = v1.ByType[v2]

	if not (v3 and v3[p2]) then
		return
	end

	v3[p2] = nil

	local CountByType = v1.CountByType

	CountByType[v2] = CountByType[v2] - 1
	v1.Total = v1.Total - 1

	if v1.CountByType[v2] <= 0 then
		v1.ByType[v2] = nil
		v1.CountByType[v2] = nil
	end

	if not (v1.Total <= 0) then
		return
	end

	p1:_removePartitionBox(p3)
	p1._partitions[p3] = nil
end
function t2._createDebugBox(p1, p2, p3) --[[ _createDebugBox | Line: 418 | Upvalues: Terrain (copy), Debris (copy) ]]
	if not p1._debugChecks then
		return
	end

	local v1 = p1._boxTrove:Clone(p1._debugTemplate)

	v1.Color3 = p3 and Color3.new(0/255, 255/255, 0/255) or Color3.new(255/255, 0/255, 0/255)
	v1.CFrame = CFrame.new((p2.X + 0.5) * p1._size, (p2.Y + 0.5) * p1._size, (p2.Z + 0.5) * p1._size)
	v1.Transparency = if p3 then 0.8 else 0.99
	v1.AlwaysOnTop = true
	v1.Parent = Terrain
	Debris:AddItem(v1, 1)
end
function t2._createPartitionBox(p1, p2) --[[ _createPartitionBox | Line: 438 | Upvalues: Terrain (copy) ]]
	if p1._debugPartitions and not p1._debugBoxes[p2] then
		local v1 = p1._trove:Clone(p1._debugTemplate)

		p1._debugBoxes[p2] = v1
		v1.CFrame = CFrame.new((p2.X + 0.5) * p1._size, (p2.Y + 0.5) * p1._size, (p2.Z + 0.5) * p1._size)
		v1.Parent = Terrain
	end
end
function t2._removePartitionBox(p1, p2) --[[ _removePartitionBox | Line: 455 ]]
	local v1 = p1._debugPartitions and p1._debugBoxes[p2]

	if not v1 then
		return
	end

	p1._trove:Remove(v1)
	v1:Destroy()
	p1._debugBoxes[p2] = nil
end
function t2.Destroy(p1) --[[ Destroy | Line: 464 ]]
	p1._partitions = nil
	p1._nodes = nil
	p1._debugBoxes = nil
	p1._trove:Destroy()
	p1._trove = nil
end

return t2