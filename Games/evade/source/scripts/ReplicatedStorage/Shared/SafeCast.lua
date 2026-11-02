-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
return function(p1, p2, p3, p4)
	local v5 = p1.X
	local v6 = p1.Y
	local v7 = p1.Z
	local v8 = p2.X - v5
	local v9 = p2.Y - v6
	local v10 = p2.Z - v7
	local v11 = v8 * v8 + v9 * v9 + v10 * v10
	local v12 = math.sqrt(v11)
	if v12 == 0 then
		return nil
	end
	local v13, v14
	if p3 > 0 then
		v13 = 0.15
		local v15 = workspace
		local v16 = v5 - v8 * v13 / v12
		local v17 = v6 - v9 * v13 / v12
		local v18 = v7 - v10 * v13 / v12
		local v19 = Vector3.new(v16, v17, v18)
		local v20 = v8 * (v12 + v13) / v12
		local v21 = v9 * (v12 + v13) / v12
		local v22 = v10 * (v12 + v13) / v12
		v14 = v15:Spherecast(v19, p3, Vector3.new(v20, v21, v22), p4)
	else
		v13 = 0.001
		local v23 = workspace
		local v24 = v5 - v8 * v13 / v12
		local v25 = v6 - v9 * v13 / v12
		local v26 = v7 - v10 * v13 / v12
		local v27 = Vector3.new(v24, v25, v26)
		local v28 = v8 * (v12 + v13) / v12
		local v29 = v9 * (v12 + v13) / v12
		local v30 = v10 * (v12 + v13) / v12
		v14 = v23:Raycast(v27, Vector3.new(v28, v29, v30), p4)
	end
	if not v14 then
		return nil
	end
	local v31 = (v14.Distance - v13) / v12
	local v32 = math.clamp(v31, 0, 1)
	local v33 = {
		["Alpha"] = v32,
		["Instance"] = v14.Instance,
		["Material"] = v14.Material,
		["Position"] = v14.Position,
		["Normal"] = v14.Normal
	}
	local v34 = v5 + v8 * v32
	local v35 = v6 + v9 * v32
	local v36 = v7 + v10 * v32
	v33.Ending = Vector3.new(v34, v35, v36)
	return v33
end
