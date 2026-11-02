-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Modules.CreateBrainrotModel)
return function(p3, p4, p5)
	-- upvalues: (copy) v_u_2
	local v6 = v_u_2(p3, true, {
		["Mutation"] = p4
	})
	if v6 then
		local v7 = p5:FindFirstChildWhichIsA("WorldModel")
		if not v7 then
			v7 = Instance.new("WorldModel")
			v7.Parent = p5
		end
		local v8, v9 = v6:GetBoundingBox()
		local v10 = v6:GetPivot().Position - v8.Position
		local v11 = CFrame.Angles
		local v12 = v6:GetAttribute("Rotation") or 0
		v6:PivotTo(v11(0, 1.5707963267948966 + math.rad(v12), 0) + v10)
		v6.Parent = v7
		local v13 = v9.X
		local v14 = v9.Y
		local v15 = v9.Z
		local v16 = math.max(v13, v14, v15) / 2 / 0.7002075382097097 * 1.1
		local v17 = Instance.new("Camera")
		v17.FieldOfView = 70
		v17.CFrame = CFrame.new(Vector3.new(0, 0, v16), Vector3.new(0, 0, 0))
		v17.Parent = p5
		p5.CurrentCamera = v17
		return v6
	end
end
