-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
game:GetService("RunService")
local v_u_1 = script:WaitForChild("avatar")
return function(p2)
	-- upvalues: (copy) v_u_1
	if p2 and not p2:IsA("Tool") then
		local v3 = p2.PrimaryPart or p2:FindFirstChildWhichIsA("BasePart")
		if v3 then
			local v4 = -(p2:GetAttribute("Rotation") or 0)
			local v_u_5 = v_u_1:Clone()
			for _, v6 in v_u_5:GetDescendants() do
				if v6:IsA("BasePart") then
					v6.CanCollide = false
					v6.CanTouch = false
					v6.CanQuery = false
					v6.Massless = true
					v6.Anchored = false
				end
			end
			local v7 = p2:GetPivot()
			local v8 = CFrame.Angles
			local v9 = 90 + v4
			v_u_5:PivotTo(v7 * v8(0, math.rad(v9), 0) * CFrame.new(-3, -2.35, -3))
			v_u_5.Parent = workspace
			local v10 = Instance.new("WeldConstraint")
			v10.Part0 = v3
			v10.Part1 = v_u_5.PrimaryPart
			v10.Parent = v_u_5.PrimaryPart
			local v_u_11 = nil
			v_u_11 = p2.Destroying:Connect(function()
				-- upvalues: (copy) v_u_5, (ref) v_u_11
				v_u_5:Destroy()
				v_u_11:Disconnect()
			end)
		else
			warn("TargetModel has no valid BasePart to weld to.")
		end
	else
		return
	end
end
