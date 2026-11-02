-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = 0

local function GetEmptyBoard(p1) --[[ GetEmptyBoard | Line: 24 ]]
	local t = {}

	for i = 1, p1 do
		t[i] = {}

		for j = 1, p1 do
			t[i][j] = 0
		end
	end

	return t
end

local function CountFilledNeighbours(p1, p2, p3) --[[ CountFilledNeighbours | Line: 38 ]]
	local v1 = #p1
	local count = 0

	if p2 == 1 or p1[p2 - 1][p3] ~= 0 then
		count = count + 1
	end

	if p2 == v1 or p1[p2 + 1][p3] ~= 0 then
		count = count + 1
	end

	if p3 == 1 or p1[p2][p3 - 1] ~= 0 then
		count = count + 1
	end

	if p3 == v1 or p1[p2][p3 + 1] ~= 0 then
		count = count + 1
	end

	return count
end

local function CountSameColorNeighbours(p1, p2, p3, p4) --[[ CountSameColorNeighbours | Line: 61 ]]
	local v1 = #p1
	local count = 0

	if p2 > 1 and p1[p2 - 1][p3] == p4 then
		count = count + 1
	end

	if p2 < v1 and p1[p2 + 1][p3] == p4 then
		count = count + 1
	end

	if p3 > 1 and p1[p2][p3 - 1] == p4 then
		count = count + 1
	end

	if p3 < v1 and p1[p2][p3 + 1] == p4 then
		count = count + 1
	end

	return count
end

local function HasIsolatedSquares(p1, p2, p3, p4, p5) --[[ HasIsolatedSquares | Line: 84 | Upvalues: CountFilledNeighbours (copy), CountSameColorNeighbours (copy) ]]
	local v1 = #p1

	local function IsIsolatedSquare(p12, p2) --[[ IsIsolatedSquare | Line: 93 | Upvalues: p1 (copy), CountFilledNeighbours (ref), p5 (copy), CountSameColorNeighbours (ref), p4 (copy) ]]
		if p1[p12][p2] ~= 0 then
			return false
		end

		if CountFilledNeighbours(p1, p12, p2) ~= 4 then
			return false
		end

		return not p5 or CountSameColorNeighbours(p1, p12, p2, p4) > 1
	end

	if p2 > 1 then
		local v2 = p2 - 1

		if if p1[v2][p3] == 0 and CountFilledNeighbours(p1, v2, p3) == 4 then not p5 or (if CountSameColorNeighbours(p1, v2, p3, p4) > 1 then true else false) else false then
			return true
		end
	end

	if p2 < v1 then
		local v4 = p2 + 1

		if if p1[v4][p3] == 0 and CountFilledNeighbours(p1, v4, p3) == 4 then not p5 or (if CountSameColorNeighbours(p1, v4, p3, p4) > 1 then true else false) else false then
			return true
		end
	end

	if p3 > 1 then
		local v6 = p3 - 1

		if if p1[p2][v6] == 0 and CountFilledNeighbours(p1, p2, v6) == 4 then not p5 or (if CountSameColorNeighbours(p1, p2, v6, p4) > 1 then true else false) else false then
			return true
		end
	end

	if not (p3 < v1) then
		return false
	end

	local v8 = p3 + 1
	local v9 = if p1[p2][v8] == 0 and CountFilledNeighbours(p1, p2, v8) == 4 then not p5 or CountSameColorNeighbours(p1, p2, v8, p4) > 1 else false

	if v9 then
		return true
	end

	return false
end

local function GetPathExtensionNeighbour(p1, p2, p3, p4) --[[ GetPathExtensionNeighbour | Line: 124 | Upvalues: CountSameColorNeighbours (copy), HasIsolatedSquares (copy) ]]
	local v1 = math.random(4)
	local t = {
		{ -1, 0 },
		{ 0, 1 },
		{ 0, -1 },
		{ 1, 0 }
	}
	local v2 = #p1

	for i = 0, 3 do
		local v3 = t[(v1 + i - 1) % 4 + 1]

		assert(v3, "Expected path extension direction")

		local v4 = p2 + v3[1]
		local v5 = p3 + v3[2]

		if v4 > 0 and (v4 <= v2 and (v5 > 0 and (v5 <= v2 and (p1[v4][v5] == 0 and (p4 <= 0 or CountSameColorNeighbours(p1, v4, v5, p4) <= 1))))) then
			p1[v4][v5] = p4

			if not (HasIsolatedSquares(p1, p2, p3, p4, false) or HasIsolatedSquares(p1, v4, v5, p4, true)) then
				return { v4, v5 }
			end

			p1[v4][v5] = 0
		end
	end

	return { 0, 0 }
end

local function AddPath(p1, p2, p3) --[[ AddPath | Line: 165 | Upvalues: v1 (ref), HasIsolatedSquares (copy), GetPathExtensionNeighbour (copy) ]]
	local v12 = #p1
	local v2 = v12 * v12

	v1 = v1 + 1

	local count = math.floor(math.random() * v2) + 1

	for i = 1, v2 do
		count = count + 1

		if v2 < count then
			count = 1
		end

		local v4 = math.floor((count - 1) / v12) + 1
		local v5 = (count - 1) % v12 + 1

		if p2[v4][v5] == 0 then
			p1[v4][v5] = v1
			p2[v4][v5] = v1

			if HasIsolatedSquares(p2, v4, v5, v1, true) then
				p1[v4][v5] = 0
				p2[v4][v5] = 0
			else
				local v6 = GetPathExtensionNeighbour(p2, v4, v5, v1)

				assert(v6, "Expected generated starting cell")

				if v6[1] == 0 and v6[2] == 0 then
					p1[v4][v5] = 0
					p2[v4][v5] = 0
				else
					count2 = 2
					v8 = v6

					while count2 < p3 do
						local v9 = GetPathExtensionNeighbour(p2, v8[1], v8[2], v1)

						if v9[1] == 0 and v9[2] == 0 then
							break
						end

						count2, v8 = count2 + 1, v9
					end

					p1[v8[1]][v8[2]] = v1

					return true
				end
			end
		end

		if i == v2 then
			break
		end
	end

	v1 = v1 - 1

	return false
end

local function Shuffle(p1) --[[ Shuffle | Line: 230 ]]
	local count = #p1

	while count > 0 do
		local v1 = math.random(count)
		local v3 = p1[count]

		p1[count] = p1[v1]
		p1[v1] = v3
		count = count - 1
	end

	return p1
end

local function ShuffleColors(p1, p2, p3) --[[ ShuffleColors | Line: 246 | Upvalues: Shuffle (copy) ]]
	local t = {}

	for i = 1, p3 do
		table.insert(t, i)
	end

	Shuffle(t)

	local v1 = #p1

	for j = 1, v1 do
		for k = 1, v1 do
			if p1[j][k] ~= 0 then
				p1[j][k] = t[p1[j][k]]
			end

			if p2[j][k] ~= 0 then
				p2[j][k] = t[p2[j][k]]
			end
		end
	end
end

local function GetMaxGeneratedPathLength(p1, p2) --[[ GetMaxGeneratedPathLength | Line: 270 ]]
	local v1 = 0

	for i = 1, p2 do
		local count = 0

		for j = 1, #p1 do
			for k = 1, #p1[j] do
				if p1[j][k] == i then
					count = count + 1
				end
			end
		end

		if v1 < count then
			v1 = count
		end
	end

	return v1
end

local function GenerateBoard(p1) --[[ GenerateBoard | Line: 292 | Upvalues: GetEmptyBoard (copy), v1 (ref), AddPath (copy), GetMaxGeneratedPathLength (copy), ShuffleColors (copy) ]]
	GetEmptyBoard(p1)
	GetEmptyBoard(p1)

	local v2 = math.max(3, (math.min(5, p1)))
	local v3 = math.clamp(p1 - 2, 3, 7)
	local v4, v5

	repeat
		local v6 = GetEmptyBoard(p1)

		v1 = 0
		v4, v5 = v6, GetEmptyBoard(p1)

		repeat

		until not (v1 < v3 and AddPath(v4, v5, v2))
	until v3 <= v1 and GetMaxGeneratedPathLength(v5, v1) <= v2

	ShuffleColors(v4, v5, v1)

	return v4, v5
end

local function BoardToText(p1) --[[ BoardToText | Line: 317 ]]
	local v1 = "\n"

	for i = 1, #p1 do
		v1 = v1 .. table.concat(p1[i], " ") .. "\n"
	end

	return v1
end

local function ExportBoard(p1) --[[ ExportBoard | Line: 327 ]]
	local t = {}

	for i = 1, #p1 do
		for j = 1, #p1[i] do
			local v1 = p1[i][j]

			if v1 ~= 0 then
				if not t[v1] then
					t[v1] = {}
				end

				table.insert(t[v1], {
					row = i,
					col = j
				})
			end
		end
	end

	return t
end

return function(p1) --[[ Generate | Line: 350 | Upvalues: GenerateBoard (copy), ExportBoard (copy), BoardToText (copy) ]]
	local v1, v2 = GenerateBoard(p1)

	return ExportBoard(v1), ExportBoard(v2), BoardToText(v1), BoardToText(v2)
end