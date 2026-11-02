script.Parent.ConnectM6D.OnServerEvent:Connect(function(plr, location)

	local char = plr.Character
	char["Right Arm"].ToolGrip.Part0 = char["Right Arm"]
	char["Right Arm"].ToolGrip.Part1 = location
	
	char["Left Arm"].ToolGrip2.Part0 = char["Left Arm"]
	char["Left Arm"].ToolGrip2.Part1 = location
end)

script.Parent.DisconnectM6D.OnServerEvent:Connect(function(plr)

	plr.Character["Right Arm"].ToolGrip.Part1 = nil
	plr.Character["Left Arm"].ToolGrip2.Part1 = nil
end)