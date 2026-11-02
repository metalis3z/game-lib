-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local _internal = require(script.Parent.Parent._internal)
local t = {}
local t2 = {}
local v1 = _internal.class.create_init_function("IntegerWidth", nil, t2, nil, _internal.class.ImmutabilityType.DEFAULT)

function t2.TruncateAt(p1, p2) --[[ TruncateAt | Line: 13 | Upvalues: _internal (copy), v1 (copy) ]]
	local v12 = _internal.class.try_coerce(1, p1, "IntegerWidth")

	return v1({
		min = v12.min,
		max = if tonumber(p2) and math.ceil(p2) == -1 then -1 else _internal.class.try_coerce_range(1, p2, v12.min, 999)
	})
end
function t.zeroFillTo(p1) --[[ zeroFillTo | Line: 29 | Upvalues: _internal (copy), v1 (copy) ]]
	return v1({
		max = -1,
		min = _internal.class.try_coerce_range(1, p1, 0, 999)
	})
end

return table.freeze(t)