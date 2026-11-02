-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local enums = require(script.Parent.enums)
local formatter_settings = require(script.Parent.formatter_settings)
local t = {}

local function internal_get_digits(p1, p2, p3, p4) --[[ internal_get_digits | Line: 5 ]]
	local v1

	if p3 <= 0 then
		p3, v1 = 1, string.rep("0", -p3 + 1)
	else
		v1 = ""
	end

	local v3 = p4 - math.max(p2, p3 - 1)
	local v4

	if v3 <= 0 then
		v4 = ""
	else
		p4, v4 = p2, string.rep("0", v3)
	end

	return v1 .. (if p2 < p3 then "" else string.char(table.unpack(p1, p3, p4))) .. v4
end

function t.strip_trailing_zero(p1, p2) --[[ strip_trailing_zero | Line: 32 ]]
	if p2 < 0 then
		return 0
	end

	while p1[p2] == 0 do
		p2 = p2 - 1
	end

	return p2
end
function t.round_sig(p1, p2, p3, p4, p5) --[[ round_sig | Line: 43 | Upvalues: enums (copy), t (copy) ]]
	local v1 = 0

	if p3 < p2 then
		local v2 = nil
		local v3 = if p3 < 0 then -1 elseif p1[p3 + 1] > 5 then 1 elseif p1[p3 + 1] == 5 then if p3 + 1 < p2 then 1 else 0 else -1

		if p5 == enums.RoundingMode.CEILING then
			v2 = if p4 then 1 else -2
		elseif p5 == enums.RoundingMode.FLOOR then
			v2 = if p4 then -2 else 1
		elseif p5 == enums.RoundingMode.UP then
			v2 = -2
		elseif p5 == enums.RoundingMode.DOWN then
			v2 = 1
		elseif p5 == enums.RoundingMode.HALF_EVEN then
			v2 = if p3 <= 0 then 0 else p1[p3] % -2
		elseif p5 == enums.RoundingMode.HALF_DOWN then
			v2 = 0
		elseif p5 == enums.RoundingMode.HALF_UP then
			v2 = -1
		end

		local count = p3

		if v2 < v3 then
			while p1[count] == 9 and count > 0 do
				count = count - 1
			end

			if count <= 0 then
				p1[1] = 1
				count = 1
				v1 = 1 - count
			else
				p1[count] = p1[count] + 1
			end
		end

		p2 = t.strip_trailing_zero(p1, count)
	end

	return p2, v1
end
function t.resolve_int_frac(p1, p2, p3, p4, p5, p6, p7) --[[ resolve_int_frac | Line: 108 | Upvalues: internal_get_digits (copy) ]]
	for i = 1, p2 do
		p1[i] = p1[i] + 48
	end

	local v1, v2

	if p3 < p4 and p5 < p3 + 1 then
		v1 = "0"
		v2 = ""
	else
		local v3 = internal_get_digits(p1, p2, p4, p3)

		v1, v2 = v3, internal_get_digits(p1, p2, p3 + 1, p5)
	end

	if p6 and p6 <= p3 - p4 + 1 then
		local v5 = if p7 == "%" then "%0%%" elseif #p7 > 1 then "%0" .. string.reverse(p7) else "%0" .. p7

		v1 = string.reverse((string.gsub(string.reverse(v1), "...", v5, (p3 - p4) / 3)))
	end

	return v1, v2
end
function t.format_expt(p1, p2, p3, p4) --[[ format_expt | Line: 148 | Upvalues: enums (copy) ]]
	local v1 = ""
	local v2

	if p1 < 0 then
		local v3 = tostring(-p1)

		if p4.negative then
			v1 = p2[enums.ENumberFormatSymbols.kMinusSignSymbol]
		end

		v2 = v3
	elseif p1 == 0 then
		v2 = "0"

		if p4.positiveZero then
			v1 = p2[enums.ENumberFormatSymbols.kPlusSignSymbol]
		end
	else
		local v4 = tostring(p1)

		if p4.positive then
			v1 = p2[enums.ENumberFormatSymbols.kPlusSignSymbol]
		end

		v2 = v4
	end

	return p2[enums.ENumberFormatSymbols.kExponentialSymbol] .. v1 .. string.rep("0", p3 - #v2) .. v2
end
function t.resolve_with_notation(p1, p2, p3, p4, p5) --[[ resolve_with_notation | Line: 173 | Upvalues: enums (copy), t (copy) ]]
	local v1 = nil
	local v2 = nil
	local v3 = nil
	local sum

	if p2 <= 0 then
		if p4.type == enums._Internal.NotationType.SCIENTIFIC then
			sum, v1 = p3, t.format_expt(0, p5, p4.minExponentDigits, p4.displayExponentSignAt)
		else
			sum = p3
		end
	elseif p4.type == enums._Internal.NotationType.SIMPLE then
		sum = p3 + p2
	else
		local power10Scale = p4.power10Scale
		local v5 = p3 + p2 - 1
		local v6 = math.floor(v5 / power10Scale)

		sum = v5 - v6 * power10Scale + 1

		if p4.type == enums._Internal.NotationType.COMPACT then
			local suffixesLength = p4.suffixesLength

			if suffixesLength < v6 then
				v1 = p4.suffixes[suffixesLength]
				sum = sum + (v6 - suffixesLength) * power10Scale
			elseif v6 < 0 then
				sum = sum + v6 * power10Scale
			elseif v6 ~= 0 then
				v1 = p4.suffixes[v6]
			end

			if v6 >= 0 and v6 < suffixesLength then
				v3 = p4.suffixes[v6 + 1]
				v2 = power10Scale
			end
		else
			local v7 = t.format_expt(v6 * power10Scale, p5, p4.minExponentDigits, p4.displayExponentSignAt)

			v1, v2, v3 = v7, power10Scale, t.format_expt((v6 + 1) * power10Scale, p5, p4.minExponentDigits, p4.displayExponentSignAt)
		end
	end

	return sum, v1, v2, v3
end
function t.format_unsigned_finite(p1, p2, p3, p4, p5) --[[ format_unsigned_finite | Line: 230 | Upvalues: t (copy), formatter_settings (copy), enums (copy) ]]
	local min = p5.integerWidth.min
	local max = p5.integerWidth.max
	local symbols = p5.symbols
	local sum, v1, v2, v3 = t.resolve_with_notation(p1, p2, p3, p5.notation, symbols)
	local v4, v5 = formatter_settings.resolve_min_max_sig(p5.precision, sum)
	local v6, v7 = t.round_sig(p1, p2, v5, p4, p5.roundingMode)
	local v8 = v6 == 0
	local v9, v10

	if v7 > 0 then
		if sum == v2 then
			local v11

			if v7 == 1 then
				v11 = true
				v9 = v6
			else
				v11 = false
				v9 = v6
			end

			assert(v11)
			sum = 1
			v1 = v3
		else
			sum, v9 = sum + v7, v6
		end

		local v12, _ = formatter_settings.resolve_min_max_sig(p5.precision, sum)

		v10 = v12
	elseif v8 then
		local v13, _ = formatter_settings.resolve_min_max_sig(p5.precision, 1)

		v10 = v13
		sum = 1
		v9 = v6
	else
		v10 = v4
		v9 = v6
	end

	local v15, v16 = t.resolve_int_frac(p1, v9, sum, math.max(sum, 0) - (if sum < min then min elseif max == -1 or not (max < sum) then sum else max) + 1, math.max(v9, v10), p5.minGrouping, symbols[enums.ENumberFormatSymbols.kGroupingSeparatorSymbol])
	local v17 = if p5.alwaysDisplayDecimal or v16 ~= "" then v15 .. symbols[enums.ENumberFormatSymbols.kDecimalSeparatorSymbol] .. v16 else v15

	if v1 then
		v17 = v17 .. v1
	end

	return v17, v8
end
function t.display_sign(p1, p2, p3, p4, p5) --[[ display_sign | Line: 298 | Upvalues: enums (copy) ]]
	local v1, v2

	if p2 then
		v1 = p5[enums.ENumberFormatSymbols.kMinusSignSymbol]
		v2 = if p3 then p4.negativeZero else p4.negative
	else
		v1 = p5[enums.ENumberFormatSymbols.kPlusSignSymbol]
		v2 = if p3 then p4.positiveZero else p4.positive
	end

	if v2 then
		return v1 .. p1
	end

	return p1
end

return table.freeze(t)