-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Comb = require(script.Parent:WaitForChild("Comb"))

return function(...) --[[ Line: 3 | Upvalues: Comb (copy) ]]
	local v1 = table.pack(...)
	local v2 = v1.n - 1
	local sum = 0

	for i = 1, v2 do
		sum = sum + (v1[i] - v1[i + 1]).Magnitude
	end

	local t = {}

	for j = 0, v2 do
		table.insert(t, Comb(v2, j))
	end

	return function(p1) --[[ Line: 14 | Upvalues: v2 (copy), t (copy), v1 (copy) ]]
		local sum = Vector3.new(0, 0, 0)

		for i = 0, v2 do
			sum = sum + v1[i + 1] * (t[i + 1] * math.pow(1 - p1, v2 - i) * math.pow(p1, i))
		end

		return sum
	end, sum
end