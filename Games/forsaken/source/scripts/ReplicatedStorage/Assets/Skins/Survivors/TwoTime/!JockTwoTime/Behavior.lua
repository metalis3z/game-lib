-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

return {
	["AddRigSkin"] = function(_, p1, p2)
		if p1.Config.LifeAppearances[p2] then
			if p1.CurrentColor then
				for _, v3 in pairs(p1.Rig:GetDescendants()) do
					local v4 = v3.Name
					local v5 = p1.CurrentColor
					if v4 == tostring(v5) then
						v3:Destroy()
					end
				end
			end
			local v6 = {
				"Red",
				"Blue",
				"Yellow",
				"Green",
				"Black"
			}
			local v7 = v6[math.random(1, #v6)]
			local v8 = 0
			while v7 == p1.CurrentColor and v8 < 25 do
				v8 = v8 + 1
				v7 = v6[math.random(1, #v6)]
			end
			for _, v9 in p1.Rig[("Life%*"):format(p2)]:GetChildren() do
				if v9:IsA("Pants") or v9:IsA("Shirt") then
					v9:Destroy()
				end
			end
			local v10 = script:FindFirstChild(v7)
			if v10 then
				for _, v11 in pairs(v10:GetChildren()) do
					local v12 = v11:Clone()
					v12.Name = v7
					v12.Parent = p1.Rig[("Life%*"):format(p2)]
				end
			end
			p1.CurrentColor = v7
			if p2 == 2 then
				p1.Rig.wing1.Transparency = 0
				p1.Rig.wing2.Transparency = 0
				p1.Rig.graphic.Decal.Transparency = 0
				for _, v13 in pairs(p1.Rig:GetChildren()) do
					v13:IsA("BasePart")
				end
			end
			p1.Config.Expressions = p1.Config.ExpressionsTable[p2] or p1.Config.Expressions
			p1:ChangeExpression("Hurt", 1)
		end
	end
}
