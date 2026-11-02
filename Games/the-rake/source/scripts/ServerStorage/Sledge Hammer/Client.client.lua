local tool = script.Parent

tool.Equipped:Connect(function()
	
	local plr = game.Players.LocalPlayer
	local char = plr.Character or plr.CharacterAdded:Wait()

	script.Parent.ConnectM6D:FireServer(tool.Base.Handle)
	
	char["Right Arm"].ToolGrip.Part0 = char["Right Arm"]
	char["Right Arm"].ToolGrip.Part1 = tool.Base.Handle
	
end)

tool.Unequipped:Connect(function()

	script.Parent.DisconnectM6D:FireServer()
	
end)