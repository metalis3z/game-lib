-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local t2 = {}

local function hashPosition(p1) --[[ hashPosition | Line: 4 ]]
	return (p1.X * 262144 + p1.Z) * 131072 + p1.Y
end

function t2.Quantize(p1, p2) --[[ Quantize | Line: 8 ]]
	local _epsilon = p1._epsilon

	return Vector3.new(p2.X // _epsilon, p2.Y // _epsilon, p2.Z // _epsilon)
end
function t2.Insert(p1, p2, p3) --[[ Insert | Line: 16 ]]
	local v1 = p1:Quantize(p2)
	local v2 = (v1.X * 262144 + v1.Z) * 131072 + v1.Y

	if not p1._table[v2] then
		p1._table[v2] = {}
	end

	table.insert(p1._table[v2], {
		pos = p2,
		val = p3
	})
end
function t2.Remove(p1, p2, p3) --[[ Remove | Line: 29 ]]
	local v1 = p1:Quantize(p2)
	local v2 = (v1.X * 262144 + v1.Z) * 131072 + v1.Y
	local v3 = p1._table[v2]

	if not v3 then
		return
	end

	for i = #v3, 1, -1 do
		if v3[i].val == p3 then
			table.remove(v3, i)
		end
	end

	if #v3 ~= 0 then
		return
	end

	p1._table[v2] = nil
end
function t2.Collect(p1, p2, p3) --[[ Collect | Line: 44 ]]
	local v1 = p1:Quantize(p2)
	local _table = p1._table
	local v2 = p3 or 1

	assert(v2 <= (p1._maxRange or 5), "range too large")

	local t = {}

	for i = -v2, v2 do
		for j = -v2, v2 do
			for k = -v2, v2 do
				local v4 = v1 + Vector3.new(i, j, k)
				local v5 = _table[(v4.X * 262144 + v4.Z) * 131072 + v4.Y]

				if v5 then
					for i2, v in ipairs(v5) do
						table.insert(t, v.val)
					end
				end
			end
		end
	end

	return t
end
function t2.Query(p1, p2, p3) --[[ Query | Line: 66 ]]
	local v1 = p1:Quantize(p2)
	local _table = p1._table
	local v2 = p3 or 1

	assert(v2 <= (p1._maxRange or 5), "range too large")

	local v4 = nil
	local v5 = nil

	for i = -v2, v2 do
		for j = -v2, v2 do
			for k = -v2, v2 do
				local v6 = v1 + Vector3.new(i, j, k)
				local v7 = _table[(v6.X * 262144 + v6.Z) * 131072 + v6.Y]

				if v7 then
					for i2, v in ipairs(v7) do
						local Magnitude = (v.pos - p2).Magnitude

						if not v4 or Magnitude < v4 then
							v5 = v.val
							v4 = Magnitude
						end
					end
				end
			end
		end
	end

	return v5
end
function t.new(p1, p2) --[[ new | Line: 93 | Upvalues: t2 (copy) ]]
	return setmetatable({
		_table = {},
		_epsilon = p1 or 10,
		_maxRange = p2
	}, {
		__index = t2
	})
end

return t