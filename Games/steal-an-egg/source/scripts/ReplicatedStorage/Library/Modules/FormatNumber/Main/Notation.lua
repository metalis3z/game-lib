-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local _internal = require(script.Parent.Parent._internal)
local t = {}
local t2 = {}
local v1 = _internal.class.create_init_function("Notation", nil, t, nil, _internal.class.ImmutabilityType.DEFAULT)
local t3 = {}
local v2 = _internal.class.create_init_function("ScientificNotation", "Notation", t3, t2, _internal.class.ImmutabilityType.DEFAULT)

function t3.WithMinExponentDigits(p1, p2) --[[ WithMinExponentDigits | Line: 17 | Upvalues: _internal (copy), v2 (copy) ]]
	local v1 = _internal.class.try_coerce(1, p1, "ScientificNotation")
	local v22 = _internal.class.try_coerce_range(2, p2, 1, 999)
	local v3 = table.clone(v1)

	v3.minExponentDigits = v22

	return v2(v3)
end
function t3.WithExponentSignDisplay(p1, p2) --[[ WithExponentSignDisplay | Line: 30 | Upvalues: _internal (copy), v2 (copy) ]]
	local v1 = _internal.class.try_coerce(1, p1, "ScientificNotation")
	local v22 = _internal.class.try_coerce_enum(2, p2, _internal.enums.SignDisplay)
	local v3 = table.clone(v1)

	v3.exponentSignDisplay = v22
	v3.displayExponentSignAt = _internal.formatter_settings.generate_from_sign_enum(v22)

	return v2(v3)
end
_internal.class.create_init_function("CompactNotation", "Notation", {}, t2, _internal.class.ImmutabilityType.DEFAULT)
_internal.class.create_init_function("SimpleNotation", "Notation", {}, t2, _internal.class.ImmutabilityType.DEFAULT)
function t.scientific() --[[ scientific | Line: 64 | Upvalues: v2 (copy), _internal (copy) ]]
	return v2({
		power10Scale = 1,
		minExponentDigits = 1,
		type = _internal.enums._Internal.NotationType.SCIENTIFIC,
		exponentSignDisplay = _internal.enums.SignDisplay.AUTO,
		displayExponentSignAt = _internal.formatter_settings.generate_from_sign_enum(_internal.enums.SignDisplay.AUTO)
	})
end
function t.engineering() --[[ engineering | Line: 74 | Upvalues: v2 (copy), _internal (copy) ]]
	return v2({
		power10Scale = 3,
		minExponentDigits = 1,
		type = _internal.enums._Internal.NotationType.SCIENTIFIC,
		exponentSignDisplay = _internal.enums.SignDisplay.AUTO,
		displayExponentSignAt = _internal.formatter_settings.generate_from_sign_enum(_internal.enums.SignDisplay.AUTO)
	})
end
function t.compactWithSuffixThousands(p1) --[[ compactWithSuffixThousands | Line: 84 | Upvalues: _internal (copy), v1 (copy) ]]
	local v12 = _internal.class.try_coerce(1, p1, "{string}")
	local v2 = table.find(v12, "")

	if v2 then
		error(string.format("Index %d is an empty string, please double check the suffixes", v2), 2)
	elseif #v12 == 0 then
		error("Suffixes is empty", 2)
	end

	local v3 = v12

	return v1({
		power10Scale = 3,
		type = _internal.enums._Internal.NotationType.COMPACT,
		suffixes = v3,
		suffixesLength = #v3
	})
end
function t.simple() --[[ simple | Line: 104 | Upvalues: v1 (copy), _internal (copy) ]]
	return v1({
		type = _internal.enums._Internal.NotationType.SIMPLE
	})
end

return table.freeze(t)