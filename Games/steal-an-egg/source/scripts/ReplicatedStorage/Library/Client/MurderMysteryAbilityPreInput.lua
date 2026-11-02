-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local t2 = {}

function t.Register(p1, p2) --[[ Register | Line: 16 | Upvalues: t2 (copy) ]]
	assert(if type(p1) == "string" then if p1 == "" then false else true else false, "abilityId must be a non-empty string")
	assert(if type(p2) == "function" then true else false, "handler must be a function")

	local v3 = t2[p1]

	if not v3 then
		v3 = {}
		t2[p1] = v3
	end

	table.insert(v3, p2)

	local v4 = false

	return function() --[[ Line: 29 | Upvalues: v4 (ref), t2 (ref), p1 (copy), p2 (copy) ]]
		if v4 then
			return
		end

		v4 = true

		local v1 = t2[p1]

		if not v1 then
			return
		end

		for i = #v1, 1, -1 do
			if v1[i] == p2 then
				table.remove(v1, i)

				break
			end
		end

		if #v1 ~= 0 then
			return
		end

		t2[p1] = nil
	end
end
function t.Run(p1, p2) --[[ Run | Line: 53 | Upvalues: t2 (copy) ]]
	assert(if type(p1) == "string" then if p1 == "" then false else true else false, "abilityId must be a non-empty string")

	local v2 = t2[p1]

	if not v2 or #v2 == 0 then
		return nil
	end

	local v3 = if p2 then p2 else {}
	local v4 = nil

	for i, v in ipairs(v2) do
		local v5 = v(v3)

		if v5 then
			v4 = v5
		end
	end

	return v4
end

return t