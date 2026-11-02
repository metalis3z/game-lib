script.Parent.MouseClick:Connect(function(p)
	if p.Character and not p.Character:FindFirstChild("Box") and not p.Backpack:FindFirstChild("Box") then
		game.ReplicatedStorage.Box:Clone().Parent = p.Backpack
		if p.Backpack:FindFirstChild("Box") then
			p.Character.Humanoid:EquipTool(p.Backpack:FindFirstChild("Box"))
		end
	end
end)