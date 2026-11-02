-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local _internal = require(script.Parent._internal)
local Notation = require(script.Notation)
local Precision = require(script.Precision)
local IntegerWidth = require(script.IntegerWidth)
local DecimalFormatSymbols = require(script.DecimalFormatSymbols)
local enums = _internal.enums
local t = {}
local t2 = {}
local v1 = _internal.class.create_init_function("NumberFormatter", nil, t2, nil, _internal.class.ImmutabilityType.NUMBER_FORMATTER)

function t2.Notation(p1, p2) --[[ Notation | Line: 26 | Upvalues: _internal (copy), v1 (copy) ]]
	_internal.class.try_coerce(1, p1, "NumberFormatter")

	return v1({
		key = "notation",
		value = _internal.class.try_coerce(2, p2, "Notation"),
		parent = _internal.class.get_data(p1)
	})
end
function t2.Precision(p1, p2) --[[ Precision | Line: 36 | Upvalues: _internal (copy), v1 (copy) ]]
	_internal.class.try_coerce(1, p1, "NumberFormatter")

	return v1({
		key = "precision",
		value = _internal.class.try_coerce(2, p2, "Precision"),
		parent = _internal.class.get_data(p1)
	})
end
function t2.RoundingMode(p1, p2) --[[ RoundingMode | Line: 46 | Upvalues: _internal (copy), enums (copy), v1 (copy) ]]
	_internal.class.try_coerce(1, p1, "NumberFormatter")

	return v1({
		key = "roundingMode",
		value = _internal.class.try_coerce_enum(2, p2, enums.RoundingMode),
		parent = _internal.class.get_data(p1)
	})
end
function t2.Grouping(p1, p2) --[[ Grouping | Line: 56 | Upvalues: _internal (copy), enums (copy), v1 (copy) ]]
	_internal.class.try_coerce(1, p1, "NumberFormatter")

	return v1({
		key = "grouping",
		value = _internal.class.try_coerce_enum(2, p2, enums.GroupingStrategy),
		parent = _internal.class.get_data(p1)
	})
end
function t2.IntegerWidth(p1, p2) --[[ IntegerWidth | Line: 66 | Upvalues: _internal (copy), v1 (copy) ]]
	_internal.class.try_coerce(1, p1, "NumberFormatter")

	return v1({
		key = "integerWidth",
		value = _internal.class.try_coerce(2, p2, "IntegerWidth"),
		parent = _internal.class.get_data(p1)
	})
end
function t2.Symbols(p1, p2) --[[ Symbols | Line: 76 | Upvalues: _internal (copy), v1 (copy) ]]
	_internal.class.try_coerce(1, p1, "NumberFormatter")

	return v1({
		key = "symbols",
		value = _internal.class.try_coerce(2, p2, "DecimalFormatSymbols"),
		parent = _internal.class.get_data(p1)
	})
end
function t2.Sign(p1, p2) --[[ Sign | Line: 86 | Upvalues: _internal (copy), enums (copy), v1 (copy) ]]
	_internal.class.try_coerce(1, p1, "NumberFormatter")

	return v1({
		key = "sign",
		value = _internal.class.try_coerce_enum(2, p2, enums.SignDisplay),
		parent = _internal.class.get_data(p1)
	})
end
function t2.Decimal(p1, p2) --[[ Decimal | Line: 96 | Upvalues: _internal (copy), enums (copy), v1 (copy) ]]
	_internal.class.try_coerce(1, p1, "NumberFormatter")

	return v1({
		key = "decimal",
		value = _internal.class.try_coerce_enum(2, p2, enums.DecimalSeparatorDisplay),
		parent = _internal.class.get_data(p1)
	})
end

local function resolve_nf_data(p1) --[[ resolve_nf_data | Line: 107 | Upvalues: _internal (copy) ]]
	return _internal.formatter_settings.resolve_settings(_internal.formatter_settings.linked_list_to_dict(p1))
end

function t2.Format(p1, p2) --[[ Format | Line: 111 | Upvalues: _internal (copy), resolve_nf_data (copy), enums (copy) ]]
	_internal.class.try_coerce(1, p1, "NumberFormatter")

	if type(p2) == "string" then
		error("Argument #2 as a string interpreted as decimal is not currently supported, please cast the argument to a double if you want the string to be interpreted as a double", 2)
	end

	local v1 = _internal.class.try_coerce(2, p2, "number")
	local v2 = _internal.class.get_resolved_data(p1, resolve_nf_data)
	local symbols = v2.symbols
	local v3, v4, v5, v6

	if v1 == v1 then
		if v1 == (1 / 0) or v1 == (-1 / 0) then
			if v1 < 0 then
				v3 = true
				v4 = v2
			else
				v3 = false
				v4 = v2
			end

			v5 = symbols[enums.ENumberFormatSymbols.kInfinitySymbol]
			v6 = false
		else
			local v8, v9, v10

			if v1 == 0 then
				v3 = math.atan2(v1, -1) < 0
				v8 = nil
				v9 = 0
				v10 = 1
				v4 = v2
			else
				v3 = v1 < 0

				local v11, v12, v13 = _internal.decimal_conversion.from_double((math.abs(v1)))

				v8 = v11
				v9 = v12
				v10 = v13
				v4 = v2
			end

			local v14, v15 = _internal.format.format_unsigned_finite(v8, v9, v10, v3, v4)

			v5 = v14
			v6 = v15
		end
	else
		v3 = string.byte(string.pack(">d", v1)) >= 128
		v5 = symbols[enums.ENumberFormatSymbols.kNaNSymbol]
		v6 = true
		v4 = v2
	end

	return _internal.format.display_sign(v5, v3, v6, v4.displaySignAt, v4.symbols)
end
function t2.ToSkeleton(p1) --[[ ToSkeleton | Line: 168 | Upvalues: _internal (copy) ]]
	return _internal.skeleton.settings_to_skeleton(_internal.formatter_settings.linked_list_to_dict((_internal.class.try_coerce(1, p1, "NumberFormatter"))))
end
function t.with() --[[ with | Line: 174 | Upvalues: v1 (copy) ]]
	return v1(nil)
end
function t.forSkeleton(p1) --[[ forSkeleton | Line: 178 | Upvalues: _internal (copy), v1 (copy) ]]
	local v2, v3 = _internal.skeleton.to_option_linked_list((_internal.class.try_coerce(1, p1, "string")))

	if v2 then
		return v2, v1(v3)
	end

	return v2, v3
end

return table.freeze({
	NumberFormatter = table.freeze(t),
	Notation = Notation,
	Precision = Precision,
	RoundingPriority = enums.RoundingPriority,
	RoundingMode = enums.RoundingMode,
	GroupingStrategy = enums.GroupingStrategy,
	IntegerWidth = IntegerWidth,
	DecimalFormatSymbols = DecimalFormatSymbols,
	ENumberFormatSymbols = enums.ENumberFormatSymbols,
	SignDisplay = enums.SignDisplay,
	DecimalSeparatorDisplay = enums.DecimalSeparatorDisplay
})