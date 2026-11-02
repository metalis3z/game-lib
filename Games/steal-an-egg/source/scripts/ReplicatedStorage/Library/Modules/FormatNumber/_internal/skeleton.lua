-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local formatter_settings = require(script.Parent.formatter_settings)
local enums = require(script.Parent.enums)
local t = {}
local t2 = {
	[enums.SignDisplay.AUTO] = nil,
	[enums.SignDisplay.ALWAYS] = "sign-always",
	[enums.SignDisplay.NEVER] = "sign-never",
	[enums.SignDisplay.EXCEPT_ZERO] = "sign-except-zero",
	[enums.SignDisplay.NEGATIVE] = "sign-negative"
}

local function notation_to_skeleton(p1) --[[ notation_to_skeleton | Line: 14 | Upvalues: enums (copy), t2 (copy) ]]
	local v1, v2

	if p1.type == enums._Internal.NotationType.SCIENTIFIC then
		v1 = true
		v2 = if p1.power10Scale == 3 then "engineering" else "scientific"

		if p1.minExponentDigits ~= 1 then
			v2 = v2 .. "/*" .. string.rep("e", p1.minExponentDigits)
		end

		if p1.exponentSignDisplay ~= enums.SignDisplay.AUTO then
			return v1, v2 .. "/" .. t2[p1.exponentSignDisplay]
		end
	else
		if p1.type == enums._Internal.NotationType.SIMPLE then
			return true, nil
		end

		v1 = false
		v2 = "Compact notation skeleton is not supported for being represented as a skeleton string in this module"
	end

	return v1, v2
end

local function precision_to_skeleton(p1) --[[ precision_to_skeleton | Line: 39 | Upvalues: enums (copy), formatter_settings (copy) ]]
	local v1 = nil
	local v2 = nil
	local v3 = nil
	local v4 = nil
	local v5 = nil
	local v6 = nil
	local v7 = nil

	if p1.type == enums._Internal.PrecisionType.FRACTION then
		v4 = p1.min
		v5 = p1.max
	elseif p1.type == enums._Internal.PrecisionType.SIGNFICANT then
		v6 = p1.min
		v7 = p1.max
	elseif p1.type == enums._Internal.PrecisionType.FRACTION_SIGNIFICANT then
		v4 = p1.minFractionDigits
		v5 = p1.maxFractionDigits

		if p1.sourcedWithSignificantDigits then
			v6 = p1.minSignificantDigits
			v7 = p1.maxSignificantDigits
		elseif p1.roundingPriority == enums.RoundingPriority.RELAXED then
			v6 = p1.maxSignificantDigits
			v7 = formatter_settings.MAX_PRECISION
		else
			v7 = p1.maxSignificantDigits
			v6 = 1
		end
	else
		v1 = "precision-unlimited"
	end

	if v4 and v5 == 0 then
		v2 = "precision-integer"
	elseif v4 then
		local v8 = "." .. string.rep("0", v4)

		v2 = if v5 == formatter_settings.MAX_PRECISION then v8 .. "*" else v8 .. string.rep("#", v5 - v4)
	end

	if v6 then
		local v9 = string.rep("@", v6)

		v3 = if v7 == formatter_settings.MAX_PRECISION then v9 .. "*" else v9 .. string.rep("#", v7 - v6)
	end

	if v2 then
		if v3 then
			v1 = v2 .. "/" .. v3

			if p1.type == enums._Internal.PrecisionType.FRACTION_SIGNIFICANT and p1.sourcedWithSignificantDigits then
				if p1.roundingPriority == enums.RoundingPriority.RELAXED then
					return v1 .. "r"
				end

				return v1 .. "s"
			end
		else
			v1 = v2
		end
	elseif v3 then
		v1 = v3
	end

	return v1
end

local t3 = {
	[enums.RoundingMode.CEILING] = "rounding-mode-ceiling",
	[enums.RoundingMode.FLOOR] = "rounding-mode-floor",
	[enums.RoundingMode.DOWN] = "rounding-mode-down",
	[enums.RoundingMode.UP] = "rounding-mode-up",
	[enums.RoundingMode.HALF_EVEN] = "rounding-mode-half-even",
	[enums.RoundingMode.HALF_DOWN] = "rounding-mode-half-down",
	[enums.RoundingMode.HALF_UP] = "rounding-half-up"
}
local t4 = {
	[enums.GroupingStrategy.OFF] = "group-off",
	[enums.GroupingStrategy.MIN2] = "group-min2",
	[enums.GroupingStrategy.ON_ALIGNED] = "group-on-aligned"
}

local function int_width_to_skeleton(p1) --[[ int_width_to_skeleton | Line: 123 ]]
	if p1.max == -1 then
		return "integer-width/*" .. string.rep("0", p1.min)
	end

	if p1.max == 0 and p1.min == 0 then
		return "integer-width-trunc"
	end

	return "integer-width/" .. string.rep("#", p1.max - p1.min) .. string.rep("0", p1.min)
end

local t5 = {
	[enums.DecimalSeparatorDisplay.AUTO] = nil,
	[enums.DecimalSeparatorDisplay.ALWAYS] = "decimal-always"
}

function t.settings_to_skeleton(p1) --[[ settings_to_skeleton | Line: 142 | Upvalues: notation_to_skeleton (copy), precision_to_skeleton (copy), t3 (copy), t4 (copy), int_width_to_skeleton (copy), t5 (copy) ]]
	local t = {}
	local v1 = nil
	local v2

	if p1.notation then
		local v3, v4 = notation_to_skeleton(p1.notation)

		if v3 then
			table.insert(t, v4)
			v2 = v3
		else
			v2 = v3
			v1 = v4
		end
	else
		v2 = true
	end

	if v2 then
		if p1.precision then
			table.insert(t, (precision_to_skeleton(p1.precision)))
		end

		if p1.roundingMode then
			table.insert(t, t3[p1.roundingMode])
		end

		if p1.grouping then
			table.insert(t, t4[p1.grouping])
		end

		if p1.integerWidth then
			table.insert(t, (int_width_to_skeleton(p1.integerWidth)))
		end

		if p1.decimal then
			table.insert(t, t5[p1.decimal])
		end

		v1 = table.concat(t, " ")
	end

	return v2, v1
end

local t6 = {
	["notation-simple"] = "notation",
	["precision-unlimited"] = "precision",
	[".+"] = "precision",
	["rounding-mode-ceiling"] = "roundingMode",
	["rounding-mode-floor"] = "roundingMode",
	["rounding-mode-down"] = "roundingMode",
	["rounding-mode-up"] = "roundingMode",
	["rounding-mode-half-even"] = "roundingMode",
	["rounding-mode-half-down"] = "roundingMode",
	["rounding-mode-half-up"] = "roundingMode",
	["group-off"] = "grouping",
	["group-min2"] = "grouping",
	["group-on-aligned"] = "grouping",
	[",_"] = "grouping",
	[",?"] = "grouping",
	[",!"] = "grouping",
	["sign-auto"] = "sign",
	["sign-always"] = "sign",
	["sign-never"] = "sign",
	["sign-except-zero"] = "sign",
	["sign-negative"] = "sign",
	["+!"] = "sign",
	["+_"] = "sign",
	["+?"] = "sign",
	["+-"] = "sign",
	["decimal-auto"] = "decimal",
	["decimal-always"] = "decimal"
}
local t7 = {
	["notation-simple"] = table.freeze({
		type = enums._Internal.NotationType.SIMPLE
	}),
	["precision-unlimited"] = table.freeze({
		type = enums._Internal.PrecisionType.UNLIMITED
	}),
	[".+"] = table.freeze({
		type = enums._Internal.PrecisionType.UNLIMITED
	}),
	["rounding-mode-ceiling"] = enums.RoundingMode.CEILING,
	["rounding-mode-floor"] = enums.RoundingMode.FLOOR,
	["rounding-mode-down"] = enums.RoundingMode.DOWN,
	["rounding-mode-up"] = enums.RoundingMode.UP,
	["rounding-mode-half-even"] = enums.RoundingMode.HALF_EVEN,
	["rounding-mode-half-down"] = enums.RoundingMode.HALF_DOWN,
	["rounding-mode-half-up"] = enums.RoundingMode.HALF_UP,
	["group-off"] = enums.GroupingStrategy.OFF,
	["group-min2"] = enums.GroupingStrategy.MIN2,
	["group-on-aligned"] = enums.GroupingStrategy.ON_ALIGNED,
	[",_"] = enums.GroupingStrategy.OFF,
	[",?"] = enums.GroupingStrategy.MIN2,
	[",!"] = enums.GroupingStrategy.ON_ALIGNED,
	["sign-auto"] = enums.SignDisplay.AUTO,
	["sign-always"] = enums.SignDisplay.ALWAYS,
	["sign-never"] = enums.SignDisplay.NEVER,
	["sign-except-zero"] = enums.SignDisplay.EXCEPT_ZERO,
	["sign-negative"] = enums.SignDisplay.NEGATIVE,
	["+!"] = enums.SignDisplay.ALWAYS,
	["+_"] = enums.SignDisplay.NEVER,
	["+?"] = enums.SignDisplay.EXCEPT_ZERO,
	["+-"] = enums.SignDisplay.NEGATIVE,
	["decimal-auto"] = enums.DecimalSeparatorDisplay.AUTO,
	["decimal-always"] = enums.DecimalSeparatorDisplay.ALWAYS
}

local function skeleton_to_scientific_notation(p1) --[[ skeleton_to_scientific_notation | Line: 257 | Upvalues: enums (copy), t7 (copy), formatter_settings (copy) ]]
	local v1, v2, v3 = string.match(p1, "^(%a+)/?([^/]*)/?([^/]*)$")
	local v4 = 1
	local AUTO = enums.SignDisplay.AUTO

	if v1 ~= "scientific" and v1 ~= "engineering" then
		return nil
	end

	if string.match(v2, "^[%*%+]e+$") then
		v2, v4 = v3, #v2 - 1
	elseif string.match(v3, "^[%*%+]e+$") then
		v4 = #v3 - 1
	end

	if v2 ~= "" then
		if string.sub(v2, 1, 5) ~= "sign-" then
			return nil
		end

		AUTO = t7[v2]
	end

	if v4 > 999 then
		return nil
	end

	local freeze = table.freeze
	local t = {
		type = enums._Internal.NotationType.SCIENTIFIC
	}

	t.power10Scale = if v1 == "engineering" then 3 else 1
	t.minExponentDigits = v4
	t.exponentSignDisplay = AUTO
	t.displayExponentSignAt = formatter_settings.generate_from_sign_enum(AUTO)

	return freeze(t)
end

local function skeleton_to_scientific_notation_concise(p1) --[[ skeleton_to_scientific_notation_concise | Line: 295 | Upvalues: t7 (copy), enums (copy), formatter_settings (copy) ]]
	local v1, v2 = string.match(p1, "^(EE?)(.+)$")

	if not v1 then
		return nil
	end

	local v3, v4 = string.match(v2, "^(%+[!%?])(.+)$")
	local v5, v6

	if v3 then
		v5 = t7[v3]
		v6 = v4
	else
		v5 = enums.SignDisplay.AUTO
		v6 = v2
	end

	if not string.match(v6, "^0+$") then
		return nil
	end

	if #v6 > 999 then
		return nil
	end

	local freeze = table.freeze
	local t = {
		type = enums._Internal.NotationType.SCIENTIFIC
	}

	t.power10Scale = if v1 == "EE" then 3 else 1
	t.minExponentDigits = #v6
	t.exponentSignDisplay = v5
	t.displayExponentSignAt = formatter_settings.generate_from_sign_enum(v5)

	return freeze(t)
end

local function skeleton_to_precision(p1) --[[ skeleton_to_precision | Line: 334 | Upvalues: formatter_settings (copy), enums (copy) ]]
	local v1, v2, v3 = string.match(p1, "^%.((0*)#*)(.*)$")
	local v4, v5

	if v1 then
		v4 = v1
		v5 = v3
	else
		local v6, v7 = string.match(p1, "^(precision%-integer)(.*)$")

		v4 = v6
		v5 = v7
	end

	if v4 then
		local v9, v10

		if v4 == "precision-integer" then
			v9 = 0
			v10 = 0
		else
			v9 = #v2
			v10 = #v4
		end

		if string.match(v5, "^[%*%+]") and v2 == v4 then
			v10, v5 = -1, string.sub(v5, 2)
		end

		if v9 > 999 or v10 > 999 then
			return nil
		end

		if v10 == -1 then
			v10 = formatter_settings.MAX_PRECISION
		end

		if string.sub(v5, 1, 1) == "/" then
			local v12 = false
			local v13, v14, v15 = string.match(v5, "^/((@+)#*)([%*%+rs]?)$")

			if not v13 or v15 == "" and v14 ~= "@" then
				return nil
			end

			local v16 = v14
			local v17, v18

			if v15 == "*" or v15 == "+" then
				v17 = v15

				if v16 ~= v13 then
					return nil
				end

				v18 = v13
			else
				v17 = v15
				v18 = v13
			end

			local v19, v20

			if v17 == "" then
				v19 = 1
				v20 = #v18
				v17 = "s"
			elseif v17 == "*" or v17 == "+" then
				v19 = 1
				v20 = #v16
				v17 = "r"
			else
				v19 = #v16
				v20 = #v18
				v12 = true
			end

			if v19 > 999 or v20 > 999 then
				return nil
			end

			local freeze = table.freeze
			local t = {
				type = enums._Internal.PrecisionType.FRACTION_SIGNIFICANT,
				minFractionDigits = v9,
				maxFractionDigits = v10,
				minSignificantDigits = v19,
				maxSignificantDigits = v20
			}

			t.roundingPriority = if v17 == "r" then enums.RoundingPriority.RELAXED else enums.RoundingPriority.STRICT
			t.sourcedWithSignificantDigits = v12

			return freeze(t)
		end

		if v5 == "" then
			return table.freeze({
				type = enums._Internal.PrecisionType.FRACTION,
				min = v9,
				max = v10
			})
		end

		return nil
	end

	local v22, v23, v24 = string.match(p1, "^((@+)#*)([%*%+]?)$")

	if not v22 then
		return nil
	end

	local v25 = #v23
	local v26 = #v22

	if v24 ~= "" then
		if v25 ~= v26 then
			return nil
		end

		string.sub(v24, 2)
		v26 = -1
	end

	if v25 > 999 or v26 > 999 then
		return nil
	end

	if v26 == -1 then
		v26 = formatter_settings.MAX_PRECISION
	end

	return table.freeze({
		type = enums._Internal.PrecisionType.SIGNFICANT,
		min = v25,
		max = v26
	})
end

local function skeleton_to_int_width(p1) --[[ skeleton_to_int_width | Line: 451 ]]
	if p1 == "integer-width-trunc" then
		return table.freeze({
			min = 0,
			max = 0
		})
	end

	local v1 = string.match(p1, "^integer%-width/[%*%+](0*)$")

	if v1 then
		if #v1 > 999 then
			return nil
		end

		return table.freeze({
			max = -1,
			min = #v1
		})
	end

	local v2, v3 = string.match(p1, "^integer%-width/(#*(0*))$")

	if v2 and (v2 ~= "" and not (#v2 > 999 or #v3 > 999)) then
		return table.freeze({
			min = #v3,
			max = #v2
		})
	end

	return nil
end

local function skeleton_to_int_width_concise(p1) --[[ skeleton_to_int_width_concise | Line: 481 ]]
	if string.match(p1, "^0+$") and #p1 < 1000 then
		return table.freeze({
			max = -1,
			min = #p1
		})
	end

	return nil
end

function t.to_option_linked_list(p1) --[[ to_option_linked_list | Line: 490 | Upvalues: t6 (copy), t7 (copy), skeleton_to_scientific_notation (copy), skeleton_to_scientific_notation_concise (copy), skeleton_to_precision (copy), skeleton_to_int_width (copy), skeleton_to_int_width_concise (copy) ]]
	local t = {}
	local v1 = nil

	for v2, v3 in string.gmatch(p1, "()(%S+)") do
		local v4 = t6[v3]
		local v5 = if v4 then t7[v3] else nil

		if not v5 then
			local v6 = skeleton_to_scientific_notation(v3) or skeleton_to_scientific_notation_concise(v3)

			if v6 then
				v5 = v6
				v4 = "notation"
			else
				v5 = v6
			end
		end

		if not v5 then
			local v7 = skeleton_to_precision(v3)

			if v7 then
				v5 = v7
				v4 = "precision"
			else
				v5 = v7
			end
		end

		if not v5 then
			local v8 = skeleton_to_int_width(v3) or skeleton_to_int_width_concise(v3)

			if v8 then
				v4 = "integerWidth"
				v5 = v8
			else
				v5 = v8
			end
		end

		if not v4 or t[v4] then
			return false, string.format("number skeleton syntax error near \'%*\' at position %d", string.gsub(v3, "\'", "\\\'"), v2)
		end

		t[v4] = true
		v1 = {
			key = v4,
			value = v5,
			parent = v1
		}
	end

	return true, v1
end

return t