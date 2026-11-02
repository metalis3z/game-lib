-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	ConvertSecondsToTime = function(p1, p2) --[[ ConvertSecondsToTime | Line: 3 ]]
		local v1 = math.floor(p2 / 60)
		local v2 = p2 % 60
		local v3 = math.floor(v1 / 60)
		local v4 = v1 % 60
		local v5 = math.floor(v3 / 24)
		local v6 = v3 % 24
		local v7 = math.floor(v5 / 365)
		local v8 = v5 % 365
		local v9 = math.floor(v8 / 30)
		local v10 = v8 % 30
		local v11 = math.floor(v7 / 10)
		local v12 = v7 % 10
		local v13 = math.floor(v11 / 10)
		local v14 = v11 % 10
		local v15 = math.floor(v13 / 10)
		local v16 = v13 % 10
		local v17 = math.floor(v15 / 10)
		local v18 = v15 % 10
		local t = {}
		local t2 = {
			Occupies = 1
		}

		t2.Type = if v17 == 1 then "Eon" else "Eons"
		t2.Value = if v17 == 0 then nil else v17

		local t3 = {
			Occupies = 1
		}

		t3.Type = if v18 == 1 then "Millenium" else "Millenia"
		t3.Value = if v18 == 0 then nil else v18

		local t4 = {
			Occupies = 1
		}

		t4.Type = if v16 == 1 then "Century" else "Centuries"
		t4.Value = if v16 == 0 then nil else v16

		local t5 = {
			Occupies = 1
		}

		t5.Type = if v14 == 1 then "Decade" else "Decades"
		t5.Value = if v14 == 0 then nil else v14

		local t6 = {
			Occupies = 1
		}

		t6.Type = if v12 == 1 then "Year" else "Years"
		t6.Value = if v12 == 0 then nil else v12

		local t7 = {
			Occupies = 2
		}

		t7.Type = if v9 == 1 then "Month" else "Months"
		t7.Value = if v9 == 0 then nil else v9

		local t8 = {
			Occupies = 2
		}

		t8.Type = if v10 == 1 then "Day" else "Days"
		t8.Value = if v10 == 0 then nil else v10

		local t9 = {
			Occupies = 1
		}

		t9.Type = if v6 == 1 then "Hour" else "Hours"
		t9.Value = if v6 == 0 then nil else v6

		local t10 = {
			Occupies = 2
		}

		t10.Type = if v4 == 1 then "Minute" else "Minutes"
		t10.Value = if v4 == 0 then nil else v4

		local t11 = {
			Occupies = 2,
			OverwriteOccupy = true
		}

		t11.Type = if v2 == 1 then "Second" else "Seconds"
		t11.Value = if v2 == 0 then nil else v2
		t[1] = t2
		t[2] = t3
		t[3] = t4
		t[4] = t5
		t[5] = t6
		t[6] = t7
		t[7] = t8
		t[8] = t9
		t[9] = t10
		t[10] = t11

		return t
	end,
	GenerateTextFromTime = function(p1, p2, p3) --[[ GenerateTextFromTime | Line: 78 ]]
		local v1 = if p3 == false then false else true
		local v2 = p2 // 86400
		local v3 = p2 % 86400
		local v4 = v3 // 3600
		local v5 = v3 % 3600
		local v6 = v5 // 60
		local v7 = v5 % 60 // 1
		local v8 = ""

		if v2 > 0 then
			v8 = v8 .. v2 .. (if v2 == 1 then " Day" else " Days")
		end

		if v4 > 0 then
			if #v8 > 0 then
				v8 = v8 .. (if v1 then ", " else " ")
			end

			v8 = v8 .. v4 .. (if v4 == 1 then " Hour" else " Hours")
		end

		if v6 > 0 then
			if #v8 > 0 then
				v8 = v8 .. (if v1 then ", " else " ")
			end

			v8 = v8 .. v6 .. (if v6 == 1 then " Minute" else " Minutes")
		end

		if v7 > 0 then
			if #v8 > 0 then
				v8 = v8 .. (if v1 then ", " else " ")
			end

			v8 = v8 .. v7 .. (if v7 == 1 then " Second" else " Seconds")
		end

		if v1 then
			local v16 = string.match(v8, "^(.*), ")

			if v16 then
				v8 = v16 .. " and " .. string.sub(v8, #v16 + 3)
			end
		end

		return v8
	end
}

function t.GenerateColonFormatFromTime(p1, p2) --[[ GenerateColonFormatFromTime | Line: 117 | Upvalues: t (copy) ]]
	local v1 = t:ConvertSecondsToTime(p2)
	local v2 = ""
	local t2 = { "Second", "Seconds", "Minute", "Minutes" }

	for v3, v4 in v1 do
		local v5 = v4.Value
		local Occupies = v4.Occupies
		local v6 = v1[v3 - 1]
		local v7 = v4.OverwriteOccupy or (if v6 then v6.Value else v6)

		if table.find(t2, v4.Type) then
			v5 = v5 or 0
		end

		if v5 then
			local v9 = string.format(v7 and "%0" .. Occupies .. "d" or "%d", v5)

			v2 = if v3 == #v1 then v2 .. v9 else v2 .. v9 .. ":"
		end
	end

	return v2
end

local t2 = {
	{
		Name = "Year",
		Singular = "Year",
		Plural = "Years",
		Value = 31536000
	},
	{
		Name = "Month",
		Singular = "Month",
		Plural = "Months",
		Value = 2592000
	},
	{
		Name = "Day",
		Singular = "Day",
		Plural = "Days",
		Value = 86400
	},
	{
		Name = "Hour",
		Singular = "Hour",
		Plural = "Hours",
		Value = 3600
	},
	{
		Name = "Minute",
		Singular = "Minute",
		Plural = "Minutes",
		Value = 60
	},
	{
		Name = "Second",
		Singular = "Second",
		Plural = "Seconds",
		Value = 1
	}
}

function t.GetLargestTime(p1, p2, p3, p4) --[[ GetLargestTime | Line: 187 | Upvalues: t2 (copy) ]]
	local count, v1, sum, v2, v3 = 0, p4 or 1, p2, {}, p3 or "floor"

	for i, v in ipairs(t2) do
		local v4

		if not (count < v1) then
			break
		end

		local count2 = math.floor(sum / v.Value)

		if count2 > 0 or #v2 == 0 and v.Name == "Second" then
			if count == v1 - 1 and sum % v.Value > 0 and (v3 == "ceil" or v3 == "round" and sum % v.Value >= v.Value / 2) then
				count2 = count2 + 1
			end

			v4 = count2 == 1 and v.Singular or v.Plural
			table.insert(v2, count2 .. " " .. v4)
			sum = sum - count2 * v.Value
			count = count + 1
		end
	end

	if #v2 == 0 then
		return "0 Seconds"
	end

	if #v2 == 1 then
		return v2[1]
	end

	if #v2 == 2 then
		return v2[1] .. " and " .. v2[2]
	end

	local v8 = table.remove(v2)

	return table.concat(v2, ", ") .. " and " .. v8
end

return t