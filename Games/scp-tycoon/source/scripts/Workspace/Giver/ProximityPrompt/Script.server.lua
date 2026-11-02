local ToolName = "HK416C"

script.Parent.Triggered:Connect(function(Player)
	if not Player.Backpack:FindFirstChild(ToolName) and not Player.Character:FindFirstChild(ToolName) then
		local Tool = game.ReplicatedStorage.Weapons:FindFirstChild(ToolName):Clone()
		Tool.Parent = Player.Backpack
	end
end)