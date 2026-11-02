-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_54 = {
	["ConvertSecondsToTime"] = function(_, p1)
		local v2 = p1 / 60
		local v3 = math.floor(v2)
		local v4 = p1 % 60
		local v5 = v3 / 60
		local v6 = math.floor(v5)
		local v7 = v3 % 60
		local v8 = v6 / 24
		local v9 = math.floor(v8)
		local v10 = v6 % 24
		local v11 = v9 / 365
		local v12 = math.floor(v11)
		local v13 = v9 % 365
		local v14 = v13 / 30
		local v15 = math.floor(v14)
		local v16 = v13 % 30
		local v17 = v12 / 10
		local v18 = math.floor(v17)
		local v19 = v12 % 10
		local v20 = v18 / 10
		local v21 = math.floor(v20)
		local v22 = v18 % 10
		local v23 = v21 / 10
		local v24 = math.floor(v23)
		local v25 = v21 % 10
		local v26 = v24 / 10
		local v27 = math.floor(v26)
		local v28 = v24 % 10
		local v29 = {}
		local v30 = {
			["Type"] = v27 == 1 and "Eon" or "Eons"
		}
		if v27 == 0 then
			v27 = nil
		end
		v30.Value = v27
		v30.Occupies = 1
		local v31 = {
			["Type"] = v28 == 1 and "Millenium" or "Millenia"
		}
		if v28 == 0 then
			v28 = nil
		end
		v31.Value = v28
		v31.Occupies = 1
		local v32 = {
			["Type"] = v25 == 1 and "Century" or "Centuries"
		}
		if v25 == 0 then
			v25 = nil
		end
		v32.Value = v25
		v32.Occupies = 1
		local v33 = {
			["Type"] = v22 == 1 and "Decade" or "Decades"
		}
		if v22 == 0 then
			v22 = nil
		end
		v33.Value = v22
		v33.Occupies = 1
		local v34 = {
			["Type"] = v19 == 1 and "Year" or "Years"
		}
		if v19 == 0 then
			v19 = nil
		end
		v34.Value = v19
		v34.Occupies = 1
		local v35 = {
			["Type"] = v15 == 1 and "Month" or "Months"
		}
		if v15 == 0 then
			v15 = nil
		end
		v35.Value = v15
		v35.Occupies = 2
		local v36 = {
			["Type"] = v16 == 1 and "Day" or "Days"
		}
		if v16 == 0 then
			v16 = nil
		end
		v36.Value = v16
		v36.Occupies = 2
		local v37 = {
			["Type"] = v10 == 1 and "Hour" or "Hours"
		}
		if v10 == 0 then
			v10 = nil
		end
		v37.Value = v10
		v37.Occupies = 1
		local v38 = {
			["Type"] = v7 == 1 and "Minute" or "Minutes"
		}
		if v7 == 0 then
			v7 = nil
		end
		v38.Value = v7
		v38.Occupies = 2
		local v39 = {
			["Type"] = v4 == 1 and "Second" or "Seconds"
		}
		if v4 == 0 then
			v4 = nil
		end
		v39.Value = v4
		v39.Occupies = 2
		v39.OverwriteOccupy = true
		__set_list(v29, 1, {v30, v31, v32, v33, v34, v35, v36, v37, v38, v39})
		return v29
	end,
	["GenerateColonFormatFromTime"] = function(_, p40)
		-- upvalues: (copy) v_u_54
		local v41 = v_u_54:ConvertSecondsToTime(p40)
		local v42 = ""
		local v43 = {
			"Second",
			"Seconds",
			"Minute",
			"Minutes"
		}
		for v44, v45 in v41 do
			local v46 = v45.Value
			local v47 = v45.Occupies
			local v48 = v45.Type
			local v49 = v41[v44 - 1]
			local v50 = v45.OverwriteOccupy
			if v50 then
				v49 = v50
			elseif v49 then
				v49 = v49.Value
			end
			local v51 = table.find(v43, v48) and (v46 or 0) or v46
			if v51 then
				local v52 = v49 and ("%%0%*d"):format(v47) or "%d"
				local v53 = string.format(v52, v51)
				v42 = #v41 == v44 and ("%*%*"):format(v42, v53) or ("%*%*:"):format(v42, v53)
			end
		end
		return v42
	end
}
return v_u_54
