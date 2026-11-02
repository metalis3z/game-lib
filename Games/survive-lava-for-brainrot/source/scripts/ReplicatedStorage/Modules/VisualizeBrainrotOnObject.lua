-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Modules.CreateBrainrotModel)
return function(p3, p4, p5, p_u_6, p_u_7)
	-- upvalues: (copy) v_u_2
	local v_u_8 = v_u_2(p3, true, {
		["Mutation"] = p4
	})
	if v_u_8 then
		v_u_8.Parent = workspace
		local v9 = p5 / v_u_8:GetExtentsSize().Y
		v_u_8:ScaleTo(v_u_8:GetScale() * v9)
		task.defer(function()
			-- upvalues: (copy) p_u_6, (copy) v_u_8, (copy) p_u_7
			local v10 = p_u_6.CFrame
			local v11 = p_u_6.Size
			local _, v12, _ = v10:ToEulerAnglesYXZ()
			local v13, v14 = v_u_8:GetBoundingBox()
			local v15 = Vector3.new(0, 1, 0) * (v_u_8:GetPivot().Position.Y - v13.Position.Y)
			local v16 = Vector3.new(0, 1, 0) * v14.Y * 0.5
			local v17 = v_u_8:GetAttribute("Rotation") or 0
			local v18 = p_u_7 or 0
			local v19 = math.rad(v17) + math.rad(v18)
			local v20 = v10.Position + Vector3.new(0, 1, 0) * v11.Y * 0.5
			v_u_8:PivotTo(CFrame.new(v20 + v15 + v16) * CFrame.Angles(0, v12 + 1.5707963267948966 + v19, 0))
		end)
		return v_u_8
	end
end
