-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = script.Wedge_PRESET
local v_u_2 = math.abs
return table.freeze({
	["Generate3DTriangle"] = function(_, p3, p4)
		-- upvalues: (copy) v_u_2, (copy) v_u_1
		assert(p3, "bad points, must be { BasePart }")
		assert(p4, "bad parent, must be Instance")
		local v5 = p3[1].Position
		local v6 = v5.X
		local v7 = p3[1].Position.Y
		local v8 = v5.Z
		local v9 = Vector3.new(v6, v7, v8)
		local v10 = p3[2].Position
		local v11 = v10.X
		local v12 = p3[1].Position.Y
		local v13 = v10.Z
		local v14 = Vector3.new(v11, v12, v13)
		local v15 = p3[3].Position
		local v16 = v15.X
		local v17 = p3[1].Position.Y
		local v18 = v15.Z
		local v19 = Vector3.new(v16, v17, v18)
		local v20 = v14 - v9
		local v21 = v19 - v9
		local v22 = v19 - v14
		local v23 = v20:Dot(v20)
		local v24 = v21:Dot(v21)
		local v25 = v22:Dot(v22)
		if v24 < v23 and v25 < v23 then
			local v26 = v19
			v19 = v9
			v9 = v14
			v14 = v26
		elseif v23 < v24 then
			if v25 >= v24 then
				local v27 = v14
				v14 = v9
				v9 = v27
			end
		else
			local v28 = v14
			v14 = v9
			v9 = v28
		end
		local v29 = v9 - v14
		local v30 = v19 - v14
		local v31 = v19 - v9
		local v32 = v30:Cross(v29).Unit
		local v33 = v31:Cross(v32).Unit
		local v34 = v31.Unit
		local v35 = v_u_2((v29:Dot(v33)))
		local v36 = v_u_1:Clone()
		local v37 = v_u_2((v29:Dot(v34)))
		v36.Size = Vector3.new(100, v35, v37)
		v36.CFrame = CFrame.fromMatrix((v14 + v9) / 2, v32, v33, v34)
		v36.Parent = p4
		local v38 = v_u_1:Clone()
		local v39 = v_u_2((v30:Dot(v34)))
		v38.Size = Vector3.new(100, v35, v39)
		v38.CFrame = CFrame.fromMatrix((v14 + v19) / 2, -v32, v33, -v34)
		v38.Parent = p4
		return { v36, v38 }
	end
})
