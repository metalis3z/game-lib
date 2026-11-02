-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
game:GetService("RunService")
local v_u_1 = script:WaitForChild("avatar")
return function(p2)
	-- upvalues: (copy) v_u_1
	if p2 then
		if p2:IsA("Tool") then
			return
		else
			local v3 = CFrame.Angles(0, p2:GetAttribute("Rotation") or 0, 0)
			local v4 = v_u_1:Clone()
			v4:PivotTo(p2:GetPivot() * v3 * CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.new(-3, -2.35, -3))
			if v4.PrimaryPart then
				v4.Parent = p2
				local v5 = Instance.new("WeldConstraint")
				v5.Part0 = p2.PrimaryPart or p2:FindFirstChildWhichIsA("BasePart")
				v5.Part1 = v4.PrimaryPart
				v5.Parent = v4.PrimaryPart
			end
		end
	else
		return
	end
end
