game.ReplicatedStorage.GameEventData.Message:GetPropertyChangedSignal("Value"):Connect(function()
	script.Parent.Text = game.ReplicatedStorage.GameEventData.Message.Value
end)