-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local DeepEquals = require(script.Parent.DeepEquals)
local DeepEqualsUnsafe = require(script.Parent.DeepEqualsUnsafe)

return function(p1, p2, p3) --[[ Line: 14 | Upvalues: DeepEqualsUnsafe (copy), DeepEquals (copy) ]]
	if typeof(p1) ~= "table" or typeof(p2) ~= "table" then
		return {}, {}
	end

	local v1 = if typeof(p3) == "table" and p3 then p3 else {}
	local SkipKeys = v1.SkipKeys
	local v2, v3 = v1, {}

	for v4, v5 in p2 do
		if not (SkipKeys and SkipKeys[v4]) then
			local v6 = p1[v4]

			if v6 ~= v5 and (if typeof(v5) == typeof(v6) and typeof(v5) == "table" then if v2.DeepEqualsUnsafe then not DeepEqualsUnsafe(v5, v6) else not DeepEquals(v5, v6) else true) then
				v3[v4] = v5
			end
		end
	end

	local t = {}

	for k in pairs(p1) do
		if not (SkipKeys and SkipKeys[k]) and p2[k] == nil then
			t[k] = true
		end
	end

	return v3, t
end