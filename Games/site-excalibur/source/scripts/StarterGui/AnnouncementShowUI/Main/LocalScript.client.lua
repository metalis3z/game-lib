game.ReplicatedStorage.Reci.OnClientEvent:Connect(function(msg, player)
	script.Parent.ShoutFrame.Shout.Text = msg
	script.Parent.Title.TextLabel.Text = "Announcement from "..player
	script.Parent:TweenPosition(UDim2.new(0.314, 0,0.02, 0), "Out", "Sine", 0.5)
	wait(5)
	script.Parent:TweenPosition(UDim2.new(0.314, 0,-0.3, 0), "Out", "Sine", 0.5)
end)