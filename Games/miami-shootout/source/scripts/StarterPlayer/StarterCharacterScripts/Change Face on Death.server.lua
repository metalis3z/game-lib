function onDeath()
	local rbxlink = "rbxassetid://" 
	local facetexture = "15324577" 
	local head = script.Parent:FindFirstChild("Head")
	if head ~= nil then
		for i,v in pairs(head:GetChildren()) do
			if v:IsA("Decal") then
				pcall(function()
					local Decal = game.InsertService:LoadAsset(facetexture):GetChildren()[1]
					Decal.Parent = head
				end)	
				v.Texture = rbxlink..facetexture
			end
		end
	end 
end

script.Parent.Humanoid.Died:Connect(onDeath)