-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	None = newproxy()
}

function t.DeepFreeze(p1) --[[ DeepFreeze | Line: 14 | Upvalues: t (copy) ]]
	table.freeze(p1)

	for v1, v2 in p1 do
		if type(v2) == "table" then
			t.DeepFreeze(v2)
		end
	end

	return p1
end
function t.DeepCopy(p1) --[[ DeepCopy | Line: 25 | Upvalues: t (copy) ]]
	local v1 = table.clone(p1)

	for v2, v3 in v1 do
		if type(v3) == "table" then
			v1[v2] = t.DeepCopy(v3)
		end
	end

	return v1
end
function t.Extend(p1, p2) --[[ Extend | Line: 37 | Upvalues: t (copy) ]]
	local v1 = t.DeepCopy(p1)

	for v2, v3 in p2 do
		if type(v3) == "table" then
			if type(p1[v2]) == "table" then
				v1[v2] = t.Extend(p1[v2], v3)

				continue
			end

			v1[v2] = t.DeepCopy(v3)

			continue
		end

		if v3 == t.None then
			v1[v2] = nil

			continue
		end

		v1[v2] = v3
	end

	return v1
end

return t