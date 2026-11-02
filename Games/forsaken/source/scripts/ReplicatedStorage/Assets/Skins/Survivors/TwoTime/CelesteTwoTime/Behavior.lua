-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

return {
	["AddRigSkin"] = function(_, p1, p2)
		if p1.Config.LifeAppearances[p2] then
			if p2 == 2 then
				p1.Rig.wing1.Transparency = 0
				p1.Rig.wing2.Transparency = 0
				p1.Rig.graphic.Decal.Transparency = 0.5
				p1.Rig.Shirt.ShirtTemplate = "rbxassetid://16395227285"
				p1.Rig.glove1.Color = Color3.fromRGB(61, 21, 133)
				p1.Rig.glove2.Color = Color3.fromRGB(61, 21, 133)
				for _, v3 in pairs(p1.Rig:GetChildren()) do
					if v3:IsA("Accessory") then
						if v3.Name == ("Life%*Hair"):format(p2) then
							v3.Handle.Transparency = 0
						else
							v3.Handle.Transparency = 1
						end
					end
				end
				local v4 = p1.Rig:FindFirstChildOfClass("BodyColors")
				if v4 then
					v4.LeftArmColor3 = Color3.fromRGB(212, 144, 189)
					v4.RightArmColor3 = Color3.fromRGB(212, 144, 189)
					v4.HeadColor3 = Color3.fromRGB(212, 144, 189)
					v4.TorsoColor3 = Color3.fromRGB(212, 144, 189)
				end
				p1.Rig["Left Arm"].Color = Color3.fromRGB(212, 144, 189)
				p1.Rig["Right Arm"].Color = Color3.fromRGB(212, 144, 189)
				p1.Rig.Head.Color = Color3.fromRGB(212, 144, 189)
				p1.Rig.Torso.Color = Color3.fromRGB(212, 144, 189)
			end
			p1.Config.Expressions = p1.Config.ExpressionsTable[p2] or p1.Config.Expressions
			p1:ChangeExpression("Hurt", 1)
		end
	end
}
