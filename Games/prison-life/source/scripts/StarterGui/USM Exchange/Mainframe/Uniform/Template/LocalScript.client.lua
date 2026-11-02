script.Parent.Activated:connect(function()
	script.Parent.Parent.Parent.Parent.PlayerInfo:WaitForChild("Type").Value = script.Parent.Name
end)