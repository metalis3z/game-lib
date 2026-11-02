-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local Constant = require(script.Constant)
local Serializer = require(script.Serializer)

t.NULL = Constant.NULL
function t.stringify(p1, p2, p3, p4) --[[ stringify | Line: 8 | Upvalues: Serializer (copy) ]]
	local v1 = p3 or 2
	local v2 = Serializer.new(nil, p4)

	v2:json(p1, p2, v1, v1)

	return v2:toString()
end

return t