-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t

local function createNode(p1, p2) --[[ createNode | Line: 52 ]]
	local t = {
		cell = p1
	}

	t.stack = if p2 then p2 else {}

	return t
end

local function sameLocation(p1, p2) --[[ sameLocation | Line: 59 ]]
	return if p1.row == p2.row then p1.col == p2.col else false
end

local function isCellInList(p1, p2) --[[ isCellInList | Line: 63 ]]
	for i, v in ipairs(p1) do
		if if v.row == p2.row then if v.col == p2.col then true else false else false then
			return true
		end
	end

	return false
end

local function cloneAndAdd(p1, p2) --[[ cloneAndAdd | Line: 73 ]]
	local v1 = table.clone(p1)

	table.insert(v1, p2)

	return v1
end

function t.new(p1, p2, p3, p4) --[[ new | Line: 79 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.candidates = {}
	v2.from = p2
	v2.grid = p1
	v2.gridSize = #p1
	v2.to = p3
	v2.neighbourCache = {}
	v2.seen = {}
	v2.stack = {
		{
			cell = p2,
			stack = {}
		}
	}
	v2.maxLength = p4 or 1

	return v2
end
function t.generate(p1) --[[ generate | Line: 95 ]]
	while #p1.stack > 0 do
		local v1 = table.remove(p1.stack, 1)

		assert(v1, "Expected current pathfinding node")

		local cell = v1.cell
		local v2 = false

		for i, v in ipairs(p1.seen) do
			if if v.row == cell.row then if v.col == cell.col then true else false else false then
				v2 = true

				break
			end
		end

		if not v2 then
			for i, v in ipairs(p1:neighboursOf(cell)) do
				if p1.grid[v.row][v.col].status == "empty" then
					local v4 = false

					for i2, v3 in ipairs(v1.stack) do
						if if v3.row == v.row then if v3.col == v.col then true else false else false then
							v4 = true

							break
						end
					end

					if not v4 and #v1.stack < p1.maxLength then
						local v6 = table.clone(v1.stack)

						table.insert(v6, cell)

						local t = {
							cell = v
						}

						t.stack = if v6 then v6 else {}

						local to = p1.to

						if if v.row == to.row then if v.col == to.col then true else false else false then
							local v9 = table.clone(t.stack)

							table.insert(v9, v)
							table.remove(v9, 1)
							table.insert(p1.candidates, v9)

							continue
						end

						table.insert(p1.stack, t)
					end
				end
			end

			table.insert(p1.seen, cell)
		end
	end
end
function t.isPathAvailable(p1) --[[ isPathAvailable | Line: 128 ]]
	if #p1.candidates == 0 then
		p1:generate()
	end

	return #p1.candidates > 0
end
function t.neighboursOf(p1, p2) --[[ neighboursOf | Line: 136 ]]
	local v1 = ("%d-%d"):format(p2.row, p2.col)

	if not p1.neighbourCache[v1] then
		local t = {}

		p1.neighbourCache[v1] = t

		for i = -1, 1, 2 do
			for j = 1, 2 do
				local t2 = {
					row = p2.row,
					col = p2.col
				}

				if j == 1 then
					t2.row = t2.row + i
				else
					t2.col = t2.col + i
				end

				if t2.row >= 1 and (t2.row <= p1.gridSize and (t2.col >= 1 and t2.col <= p1.gridSize)) then
					table.insert(t, t2)
				end
			end
		end
	end

	return p1.neighbourCache[v1]
end
function t.shortestPath(p1) --[[ shortestPath | Line: 171 ]]
	if #p1.candidates == 0 then
		p1:generate()
	end

	table.sort(p1.candidates, function(p1, p2) --[[ Line: 176 ]]
		return #p1 < #p2
	end)

	local v1 = p1.candidates[1]

	assert(v1, "Expected shortest path candidate")

	return v1
end

return t