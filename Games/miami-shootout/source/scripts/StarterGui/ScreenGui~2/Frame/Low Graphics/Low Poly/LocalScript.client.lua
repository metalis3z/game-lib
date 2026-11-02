local Deb = false
script.Parent.MouseButton1Click:Connect(function() 
	if Deb == false then
		Deb = true
		game.Lighting.GlobalShadows = false
		for i,v in pairs(game.Workspace.Map:GetDescendants()) do
			if not v.Parent:IsA("Tool") then
				if v:IsA("MeshPart") then
					v.Material = Enum.Material.SmoothPlastic
				elseif v:IsA("Decal") then
					v:Destroy()
				elseif v:IsA("Part") then
					v.Material = Enum.Material.SmoothPlastic
					v.CastShadow = false
				elseif v:IsA("UnionOperation") then
					v.CastShadow = false
					v.Material = Enum.Material.SmoothPlastic
				elseif v:IsA("Texture") then
					v:Destroy()
				end
			end
		end
		for i,v in pairs(game.Workspace.Nature:GetChildren()) do
			v:Destroy()
		end
	end
end)