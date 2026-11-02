while true do
	task.wait(8)
	script.Parent.Text = "You have "..game.ReplicatedStorage.GetNumberOfKeys:InvokeServer().." Keys"
end