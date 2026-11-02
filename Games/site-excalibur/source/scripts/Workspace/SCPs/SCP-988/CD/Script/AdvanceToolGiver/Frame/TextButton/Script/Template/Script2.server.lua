script.Parent.MouseButton1Click:Connect(function()
	local Tool = script.Parent:WaitForChild("Reference").Value
	local ToolClone = Tool.Value:Clone()
	local Player = game.Players:FindFirstChild(script.Parent.Parent.Name)
	
	ToolClone.Parent = Player.Backpack
	script.Parent:Destroy()
	Tool:Destroy()
	Tool.Value = script
end)