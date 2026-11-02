-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local _internal = require(script.Parent.Parent._internal)
local t = {}
local t2 = {}
local v1 = _internal.class.create_init_function("DecimalFormatSymbols", nil, t2, nil, _internal.class.ImmutabilityType.SYMBOLS)

function t2.GetSymbol(p1, p2) --[[ GetSymbol | Line: 13 | Upvalues: _internal (copy) ]]
	return _internal.class.try_coerce(1, p1, "DecimalFormatSymbols")[_internal.class.try_coerce_enum(2, p2, _internal.enums.ENumberFormatSymbols)]
end
function t2.SetSymbol(p1, p2, p3) --[[ SetSymbol | Line: 20 | Upvalues: _internal (copy) ]]
	_internal.class.try_coerce(1, p1, "DecimalFormatSymbols")[_internal.class.try_coerce_enum(2, p2, _internal.enums.ENumberFormatSymbols)] = _internal.class.try_coerce(3, p3, "string")
end
function t.createWithLastResortData() --[[ createWithLastResortData | Line: 28 | Upvalues: v1 (copy), _internal (copy) ]]
	return v1({
		[_internal.enums.ENumberFormatSymbols.kDecimalSeparatorSymbol] = ".",
		[_internal.enums.ENumberFormatSymbols.kGroupingSeparatorSymbol] = "",
		[_internal.enums.ENumberFormatSymbols.kMinusSignSymbol] = "-",
		[_internal.enums.ENumberFormatSymbols.kPlusSignSymbol] = "+",
		[_internal.enums.ENumberFormatSymbols.kExponentialSymbol] = "E",
		[_internal.enums.ENumberFormatSymbols.kInfinitySymbol] = "\226\136\158",
		[_internal.enums.ENumberFormatSymbols.kNaNSymbol] = "\239\191\189"
	})
end

return table.freeze(t)