script.Parent.MouseButton1Click:Connect(function()
	local announce = script.Parent.Parent.ShoutFrame.Message.Text
	if announce ~= "" then
		if game.ReplicatedStorage.IfSend.Value == false then
			script.Parent.Parent.ShoutFrame.Message.Text = ""
			local filteredtext = game.ReplicatedStorage.FilterText:InvokeServer(announce)
			wait(0.1)
			game.ReplicatedStorage.Send:FireServer(filteredtext)
		else
			script.Parent.TextLabel.Text = "Cooldown"
			wait(1)
			script.Parent.TextLabel.Text = "Announce"
		end
	else
		script.Parent.TextLabel.Text = "Announce"
		wait(1)
		script.Parent.TextLabel.Text = "Announce"
	end
end)