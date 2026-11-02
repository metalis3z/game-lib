script.Parent.Activated:connect(function()
	script.Parent.Parent.Parent.Parent.PlayerInfo:WaitForChild("Paygrade").Value = script.Parent.Name
end)