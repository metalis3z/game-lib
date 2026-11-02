-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: flatten, time of decompilation: Sun May  3 10:10:13 2026 ]]
require(script.Parent.Parent.Types)

local function flatten(p1, n1: number?) -- line: 30
	-- upvalues: flatten (copy)
	if type(n1) ~= "number" then
		n1 = 1e999
	end

	local t1 = {}

	for k, v in pairs(p1) do
		if type(v) == "table" and n1 > 0 then
			local v7 = flatten(v, n1 - 1)

			for k2, v2 in pairs(t1) do
				v7[k2] = v2
			end

			t1 = v7
		else
			t1[k] = v
		end
	end

	return t1
end

return flatten
