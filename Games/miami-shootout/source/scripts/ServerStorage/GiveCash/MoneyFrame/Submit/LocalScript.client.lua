script.Parent.MouseButton1Click:Connect(function()
	if script.Parent.Parent.Username.Text == nil or script.Parent.Parent.Amount.Text == nil then
		script.Parent.Parent.Parent.Info.Text = "One of the text boxes hasn't been filled out!"
		script.Error:Play()
		wait(3)
		script.Parent.Parent.Parent.Info.Text = ""
	else
		local amount = tonumber(script.Parent.Parent.Amount.Text)
		if amount and amount >= 1 then
			
			local otherPlayer = game.Players:FindFirstChild(script.Parent.Parent.Username.Text)
			
			if otherPlayer then
				
				if game.Players.LocalPlayer.stored.Money.Value >= amount then
					game.ReplicatedStorage.GiveMoney:FireServer(otherPlayer, amount)
					script.Parent.Parent.Parent.Info.Text = "Successfully gave "..otherPlayer.Name.." "..amount.." money!"
					script.ching:Play()
					wait(3)
					script.Parent.Parent.Parent.Info.Text = ""
				else
					script.Parent.Parent.Parent.Info.Text = "you dont got enough cash"
					script.Error:Play()
					wait(3)
					script.Parent.Parent.Parent.Info.Text = ""
				end
				
				
			else
				script.Parent.Parent.Parent.Info.Text = "Player isn't in the server!"
				script.Error:Play()
				wait(3)
				script.Parent.Parent.Parent.Info.Text = ""
				
				
			end
			
		else
			script.Parent.Parent.Parent.Info.Text = "You didn't enter a valid amount!"
			script.Error:Play()
			wait(3)
			script.Parent.Parent.Parent.Info.Text = ""
		end
	end
end)