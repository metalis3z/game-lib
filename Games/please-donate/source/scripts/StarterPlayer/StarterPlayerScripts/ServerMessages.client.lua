--[[
     Yes bro made by arxx hahahaha
]]

game.ReplicatedStorage.Events.DonationMessages.Tip.OnClientEvent:Connect(function(player, donated, price)
	local textservice = game:GetService("TextChatService")
	local textchannels = textservice:WaitForChild("TextChannels")
	
	local msg = string.format('<font color="rgb(47, 255, 0)" size="18"><b>[SERVER]:</b> %s </font>', "<b>@" .. player.Name .. " tipped " .. "<b>" .. price .. "</b> to @" .. donated .. "</b>") 
	
	
	textchannels.RBXSystem:DisplaySystemMessage(msg)
end)

game.ReplicatedStorage.Events.DonationMessages.Grateful.OnClientEvent:Connect(function(player, donated, price)
	local textservice = game:GetService("TextChatService")
	local textchannels = textservice:WaitForChild("TextChannels")

	local msg = string.format('<font color="rgb(255, 0, 174)" size="18"><b>[SERVER]:</b> %s </font>', "<b>@" .. player.Name .. " donated " .. "<b>" .. price .. "</b> to @" .. donated .. "!</b>") 
	

	textchannels.RBXSystem:DisplaySystemMessage(msg)
	
end)

game.ReplicatedStorage.Events.DonationMessages.thousand.OnClientEvent:Connect(function(player, donated, price)
	local textservice = game:GetService("TextChatService")
	local textchannels = textservice:WaitForChild("TextChannels")

	local msg = string.format('<font color="rgb(255, 225, 0)" size="18"><b>[SERVER]:</b> %s </font>', "<b>@" .. player.Name .. " donated " .. "<b>" .. price .. "</b> to @" .. donated .. "!!</b>") 
	
	
	textchannels.RBXSystem:DisplaySystemMessage(msg)
	
end)

game.ReplicatedStorage.Events.DonationMessages.tenThousand.OnClientEvent:Connect(function(player, donated, price)
	local textservice = game:GetService("TextChatService")
	local textchannels = textservice:WaitForChild("TextChannels")

	local msg = string.format('<font color="rgb(0, 187, 255)" size="18"><b>[SERVER]:</b> %s </font>', ">b>OMG! @" .. player.Name .. " donated " .. "<b>" .. price .. "</b> to @" .. donated .. "!!!</b>") 
	
	
	textchannels.RBXSystem:DisplaySystemMessage(msg)
	
end)