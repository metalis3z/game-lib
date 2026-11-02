game.Players.PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function(c)
		
		c.ChildAdded:Connect(function(obj)
			--if obj:IsA("Tool") then
			--	if c:FindFirstChildOfClass("ForceField") then
			--		c:FindFirstChildOfClass("ForceField"):Destroy()
			--	end				
			--end
		end)
		
	end)
end)