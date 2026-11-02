-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Algebra = require(script.Parent.Parent:WaitForChild("Algebra"))
local Vector = require(script.Parent.Parent:WaitForChild("Algebra"):WaitForChild("Vector"))

require(script.Parent.Parent:WaitForChild("Algebra"):WaitForChild("Matrix"))

local Solver = require(script.Parent:WaitForChild("Solver"))
local t = {}

t.__index = t
function t.Get(p1, p2) --[[ Get | Line: 16 | Upvalues: Vector (copy), Algebra (copy) ]]
	local v1 = p1.translateVector(p2)

	if v1.Size <= 3 then
		math.randomseed(p1.Seed)

		local Frequency = p1.Frequency

		assert(typeof(Frequency) == "number")

		return p1:_Compile(v1, 0.5 + math.noise(Frequency * (v1[1] or 0), Frequency * (v1[2] or 0), Frequency * (v1[3] or 0)) * 0.5)
	end

	local v6 = 1 / p1.Frequency
	local v7 = (v1 / v6):Floor() * v6
	local v8 = Vector.one(v1.Size) * v6
	local list = { v7 }

	for i = 1, v1.Size do
		local v9
		local t = {}

		for j = 1, v1.Size do
			table.insert(t, if j <= i then 1 else 0)
		end

		v9 = function(p1, p2, p3) --[[ permutate | Line: 42 | Upvalues: list (copy), v1 (ref), v7 (copy), Vector (ref), v8 (copy), v9 (copy) ]]
			if #list == 2 ^ v1.Size then
				return
			end

			if p2 == 1 then
				table.insert(list, v7 + Vector.new(unpack(p1)) * v8)
			end

			for i = 1, p2 do
				v9(p1, p2 - 1, p3)

				if p2 % 2 == 1 then
					local v3 = p1[1]

					p1[1] = p1[p2]
					p1[p2] = v3

					continue
				end

				local v4 = p1[i]

				p1[i] = p1[p2]
				p1[p2] = v4
			end
		end
		v9(t, #t, #t)
	end

	local t = {}

	for i, v in ipairs(list) do
		t[i] = p1:_Rand(v)
	end

	local function v11(p1, p2) --[[ pairAndLerp | Line: 69 | Upvalues: v1 (ref), Algebra (ref), v11 (copy) ]]
		local t = {}
		local tbl = {}

		for i, v in ipairs(p1) do
			t[v] = p2[i]
		end

		for i = 1, math.floor(#p1 / 2) do
			tbl[p1[i]] = p1[i + #p1 / 2]
		end

		local t2 = {}
		local t3 = {}

		for k, v in pairs(tbl) do
			local Magnitude = (k - v1).Magnitude
			local Magnitude2 = (k - v).Magnitude
			local v4 = math.acos((Magnitude ^ 2 + Magnitude2 ^ 2 - (v - v1).Magnitude ^ 2) / (2 * Magnitude * Magnitude2))

			if v4 ~= v4 then
				v4 = 0
			end

			local v6 = math.min(math.cos(v4) * (v1 - k).Magnitude, (k - v).Magnitude) / Magnitude2
			local v7 = v6 ^ 2 * (3 - 2 * v6)
			local v8 = k:Lerp(v, v7)
			local v9 = Algebra.lerp(t[k], t[v], v7)

			table.insert(t2, v8)
			table.insert(t3, v9)
		end

		if #t2 <= 1 then
			return t3[1]
		end

		return v11(t2, t3)
	end

	return p1:_Compile(v1, (v11(list, t)))
end
function t.Clone(p1) --[[ Clone | Line: 124 | Upvalues: t (copy) ]]
	return p1:_CopyConfiguration((t.new()))
end
function t.new(...) --[[ new | Line: 129 | Upvalues: Solver (copy), t (copy) ]]
	local v1 = Solver.new(...)

	setmetatable(v1, t)

	return v1
end
setmetatable(t, Solver)

return t