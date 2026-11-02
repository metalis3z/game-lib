local frame = script.Parent.Frame

frame.Yes.MouseButton1Click:Connect(function()
	if script.Parent.SendingName.Value == "floor" then
		game.ReplicatedStorage.GiveMoney:FireServer("drop",script.Parent.Amount.Value)
		return script.Parent:Destroy()
	else
		game.ReplicatedStorage.GiveMoney:FireServer(script.Parent.SendingName.Value,script.Parent.Amount.Value)
		return script.Parent:Destroy()
	end
end)

frame.No.MouseButton1Click:Connect(function()
	script.Parent:Destroy()
end)

local char = game.Players.LocalPlayer.Character
char.ChildRemoved:Connect(function(v)
	if v.Name == "Phone" then
		script.Parent:Destroy()
	end
end)
char.Humanoid.Died:Connect(function()
	script.Parent:Destroy()
end)