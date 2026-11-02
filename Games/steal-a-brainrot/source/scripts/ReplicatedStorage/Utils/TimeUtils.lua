return {
	["A"] = function(_, p1)
		local v2 = math.ceil(p1)
		local v3 = v2 / 86400
		local v4 = math.floor(v3)
		local v5 = v2 % 86400
		local v6 = v5 / 3600
		local v7 = math.floor(v6)
		local v8 = v5 % 3600
		local v9 = v8 / 60
		local v10 = math.floor(v9)
		local v11 = v8 % 60
		local v12 = ""
		if v4 >= 1 then
			v12 = v12 .. ("%*d "):format(v4)
		end
		if v4 >= 1 or v7 >= 1 then
			v12 = v12 .. ("%*h "):format(v7)
		end
		if v7 >= 1 or v10 >= 1 then
			v12 = v12 .. ("%*m "):format(v10)
		end
		if v7 <= 0 and (v10 <= 0 and v4 <= 0) then
			v12 = v12 .. ("%*s"):format(v11)
		end
		return v12
	end,
	["B"] = function(_, p13)
		local v14 = math.ceil(p13)
		local v15 = v14 / 86400
		local v16 = math.floor(v15)
		local v17 = v14 % 86400
		local v18 = v17 / 3600
		local v19 = math.floor(v18)
		local v20 = v17 % 3600
		local v21 = v20 / 60
		local v22 = math.floor(v21)
		local v23 = v20 % 60
		local v24 = ""
		if v16 >= 1 then
			v24 = v24 .. string.format("%d:", v16)
		end
		if v16 >= 1 or v19 >= 1 then
			v24 = v24 .. string.format("%02d:", v19)
		end
		if v19 >= 1 or (v22 >= 1 or v16 >= 1) then
			v24 = v24 .. string.format("%02d:", v22)
		end
		return v24 .. string.format("%02d", v23)
	end,
	["C"] = function(_, p25)
		local v26 = math.ceil(p25)
		local v27 = math.floor(v26)
		local v28 = math.max(0, v27)
		return string.format("%ds", v28)
	end,
	["D"] = function(_, p29)
		local v30 = math.ceil(p29)
		local v31 = math.floor(v30)
		local v32 = math.max(0, v31)
		local v33 = v32 / 86400
		local v34 = math.floor(v33)
		local v35 = v32 % 86400
		local v36 = v35 / 3600
		local v37 = math.floor(v36)
		local v38 = v35 % 3600
		local v39 = v38 / 60
		local v40 = math.floor(v39)
		local v41 = v38 % 60
		local v42 = ""
		if v34 > 0 then
			return ((v42 .. ("%*d "):format(v34)) .. ("%*h "):format(v37)) .. ("%*m"):format(v40)
		elseif v37 > 0 then
			return ((v42 .. ("%*h "):format(v37)) .. ("%*m "):format(v40)) .. ("%*s"):format(v41)
		elseif v40 > 0 then
			return (v42 .. ("%*m "):format(v40)) .. ("%*s"):format(v41)
		else
			return v42 .. ("%*s"):format(v41)
		end
	end,
	["E"] = function(_, p43)
		local v44 = p43 < 0 and 0 or p43 // 1
		local v45 = v44 // 86400
		local v46 = v44 % 86400
		local v47 = v46 // 3600
		local v48 = v46 % 3600
		local v49 = v48 // 60
		local v50 = v48 % 60
		local v51 = ""
		local v52
		if v45 > 0 then
			v52 = v51 .. ("%*d"):format(v45)
			if v47 > 0 then
				return v52 .. (" %*h"):format(v47)
			end
		elseif v47 > 0 then
			v52 = v51 .. ("%*h"):format(v47)
			if v49 > 0 then
				return v52 .. (" %*m"):format(v49)
			end
		elseif v49 > 0 then
			v52 = v51 .. ("%*m"):format(v49)
			if v50 > 0 then
				return v52 .. (" %*s"):format(v50)
			end
		else
			v52 = v51 .. ("%*s"):format(v50)
		end
		return v52
	end
}