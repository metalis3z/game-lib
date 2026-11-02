game.Players.PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function(c)
		local hum = c:WaitForChild("Humanoid")
		
		hum.Died:Connect(function()
			local tools = p.Backpack:GetChildren()
			local hand = p.Character:FindFirstChildWhichIsA("Tool")
			if hand then
				table.insert(tools,hand)
			end
			
			for i,v in pairs(tools) do
				if v:IsA("Tool") then v.CanBeDropped = false end
			end
		end)
	end)
end)