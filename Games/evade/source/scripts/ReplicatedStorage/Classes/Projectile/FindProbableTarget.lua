-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Shared.SafeCast)
local v_u_3 = math.max
local v_u_4 = math.abs
local v_u_5 = math.clamp
local v_u_6 = math.sqrt
local function v_u_25(p7, p8, p9)
	-- upvalues: (copy) v_u_4
	local v10 = p8 - p7
	local v11 = 0
	local v12 = 1
	local v13, v14
	if v_u_4(v10.X) < 1e-6 then
		if p7.X < -p9.X or p7.X > p9.X then
			return false, 0
		end
		v13 = v12
		v14 = v11
	else
		local v15 = 1 / v10.X
		v13 = (-p9.X - p7.X) * v15
		v14 = (p9.X - p7.X) * v15
		if v14 >= v13 then
			local v16 = v13
			v13 = v14
			v14 = v16
		end
		if v11 >= v14 then
			v14 = v11
		end
		if v13 >= v12 then
			v13 = v12
		end
		if v13 < v14 then
			return false, 0
		end
	end
	if v_u_4(v10.Y) < 1e-6 then
		if p7.Y < -p9.Y or p7.Y > p9.Y then
			return false, 0
		end
	else
		local v17 = 1 / v10.Y
		local v18 = (-p9.Y - p7.Y) * v17
		local v19 = (p9.Y - p7.Y) * v17
		if v19 >= v18 then
			local v20 = v18
			v18 = v19
			v19 = v20
		end
		if v14 >= v19 then
			v19 = v14
		end
		if v18 >= v13 then
			v18 = v13
		end
		if v18 < v19 then
			return false, 0
		end
		v13 = v18
		v14 = v19
	end
	if v_u_4(v10.Z) < 1e-6 then
		if p7.Z < -p9.Z or p7.Z > p9.Z then
			return false, 0
		end
	else
		local v21 = 1 / v10.Z
		local v22 = (-p9.Z - p7.Z) * v21
		local v23 = (p9.Z - p7.Z) * v21
		if v23 >= v22 then
			local v24 = v22
			v22 = v23
			v23 = v24
		end
		if v14 >= v23 then
			v23 = v14
		end
		if v22 >= v13 then
			v22 = v13
		end
		if v22 < v23 then
			return false, 0
		end
		v14 = v23
		v13 = v22
	end
	if v13 < 0 or v14 > 1 then
		return false, 0
	elseif v14 < 0 then
		return true, 0
	else
		return true, v14
	end
end
local function v_u_71(p26, p27, p28, p29)
	-- upvalues: (copy) v_u_5, (copy) v_u_25, (copy) v_u_4, (copy) v_u_3, (copy) v_u_6
	local v30 = p27 - p26
	local v31 = v30.Magnitude
	if v31 < 1e-6 then
		local v32 = p28:PointToObjectSpace(p26)
		local v33 = v_u_5(v32.X, -p29.X, p29.X)
		local v34 = v_u_5(v32.Y, -p29.Y, p29.Y)
		local v35 = v_u_5(v32.Z, -p29.Z, p29.Z)
		return 0, p26, (v32 - Vector3.new(v33, v34, v35)).Magnitude
	end
	local v36 = v30 / v31
	local v37, v38 = v_u_25(p28:PointToObjectSpace(p26), p28:PointToObjectSpace(p27), p29)
	if v37 then
		local v39 = v38 * v31
		return v39, p26 + v36 * v39, 0
	end
	local v40 = 0
	local v41 = v31 - (v31 - v40) * 0.6180339887498949
	local v42 = v40 + (v31 - v40) * 0.6180339887498949
	local v43 = p28:PointToObjectSpace(p26 + v36 * v41)
	local v44 = v_u_3(0, v_u_4(v43.X) - p29.X)
	local v45 = v_u_3(0, v_u_4(v43.Y) - p29.Y)
	local v46 = v_u_3(0, v_u_4(v43.Z) - p29.Z)
	local v47 = v44 * v44 + v45 * v45 + v46 * v46
	local v48 = p28:PointToObjectSpace(p26 + v36 * v42)
	local v49 = v_u_3(0, v_u_4(v48.X) - p29.X)
	local v50 = v_u_3(0, v_u_4(v48.Y) - p29.Y)
	local v51 = v_u_3(0, v_u_4(v48.Z) - p29.Z)
	local v52 = v49 * v49 + v50 * v50 + v51 * v51
	for _ = 1, 22 do
		if v47 < v52 then
			local v53 = v42 - (v42 - v40) * 0.6180339887498949
			local v54 = p28:PointToObjectSpace(p26 + v36 * v53)
			local v55 = v_u_3(0, v_u_4(v54.X) - p29.X)
			local v56 = v_u_3(0, v_u_4(v54.Y) - p29.Y)
			local v57 = v_u_3(0, v_u_4(v54.Z) - p29.Z)
			local v58 = v55 * v55 + v56 * v56 + v57 * v57
			v31 = v42
			v42 = v41
			v41 = v53
			v52 = v47
			v47 = v58
		else
			local v59 = v41 + (v31 - v41) * 0.6180339887498949
			local v60 = p28:PointToObjectSpace(p26 + v36 * v59)
			local v61 = v_u_3(0, v_u_4(v60.X) - p29.X)
			local v62 = v_u_3(0, v_u_4(v60.Y) - p29.Y)
			local v63 = v_u_3(0, v_u_4(v60.Z) - p29.Z)
			local v64 = v61 * v61 + v62 * v62 + v63 * v63
			v47 = v52
			v52 = v64
			v40 = v41
			v41 = v42
			v42 = v59
		end
	end
	local v65 = 0.5 * (v40 + v31)
	local v66 = p26 + v36 * v65
	local v67 = p28:PointToObjectSpace(p26 + v36 * v65)
	local v68 = v_u_3(0, v_u_4(v67.X) - p29.X)
	local v69 = v_u_3(0, v_u_4(v67.Y) - p29.Y)
	local v70 = v_u_3(0, v_u_4(v67.Z) - p29.Z)
	return v65, v66, v_u_6(v68 * v68 + v69 * v69 + v70 * v70)
end
return function(p72, p73, p74, p75, p76)
	-- upvalues: (copy) v_u_2, (copy) v_u_71
	local v77 = typeof(p72) == "Vector3"
	assert(v77, "p0 must be Vector3")
	local v78 = typeof(p73) == "Vector3"
	assert(v78, "p1 must be Vector3")
	local v79
	if type(p74) == "number" then
		v79 = p74 >= 0
	else
		v79 = false
	end
	assert(v79, "radius > 0")
	local v80 = typeof(p75) == "RaycastParams"
	assert(v80)
	local v81 = typeof(p76) == "OverlapParams"
	assert(v81)
	local v82 = {}
	local v83 = v_u_2(p72, p73, p74, p75)
	if v83 then
		local v84 = v83.Instance:FindFirstAncestorOfClass("Model")
		local v85
		if v84 then
			v85 = v84.PrimaryPart
			if v85 then
				if not v84:FindFirstChildOfClass("Humanoid") then
					v84 = nil
					v85 = nil
				end
			else
				v84 = nil
				v85 = nil
			end
		else
			v84 = nil
			v85 = nil
		end
		if v84 and v85 then
			local v86 = v84:FindFirstChild("__HITBOX")
			local v87
			if v86 and v86:IsA("BasePart") then
				v87 = v86.CFrame
				local _ = v86.Size
			else
				local v88
				v87, v88 = v84:GetBoundingBox()
			end
			return v87.Position
		end
		p73 = v83.Ending
	end
	local v89 = p73 - p72
	local v90 = v89.Magnitude
	if v90 < 1e-6 then
		return nil
	end
	if p74 <= 0 then
		return nil
	end
	local v91 = v89 / v90
	local v92 = 0.5 * v90
	local v93 = CFrame.lookAt(p72 + v91 * v92, p73)
	local v94 = p74 * 2
	local v95 = p74 * 2
	local v96 = Vector3.new(v94, v95, v90)
	local v97 = workspace:GetPartBoundsInBox(v93, v96, p76)
	local _ = p74 * p74
	local v98 = (1 / 0)
	local v99 = nil
	for _, v100 in ipairs(v97) do
		local v101 = v100:FindFirstAncestorOfClass("Model")
		local v102
		if v101 then
			v102 = v101.PrimaryPart
			if v102 then
				if not v101:FindFirstChildOfClass("Humanoid") then
					v101 = nil
					v102 = nil
				end
			else
				v101 = nil
				v102 = nil
			end
		else
			v101 = nil
			v102 = nil
		end
		if v101 and (v102 and not v82[v101]) then
			v82[v101] = true
			local v103 = v101:FindFirstChild("__HITBOX")
			local v104, v105
			if v103 and v103:IsA("BasePart") then
				v104 = v103.CFrame
				v105 = v103.Size
			else
				v104, v105 = v101:GetBoundingBox()
			end
			local _, _, v106 = v_u_71(p72, p73, v104, v105 * 0.5)
			if p74 > v106 and v106 < v98 then
				v99 = v104.Position
				v98 = v106
			end
		end
	end
	return v99
end
