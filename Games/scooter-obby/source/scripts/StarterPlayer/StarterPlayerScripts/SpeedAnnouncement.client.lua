local Message = game:GetService('ReplicatedStorage').RemoteEvents.Announce

Message.OnClientEvent:Connect(function(Player, Time)

	local TextChatService = game:GetService("TextChatService")
	local TextChannels = TextChatService:WaitForChild("TextChannels")

	TextChannels.RBXSystem:DisplaySystemMessage("<font color = \"rgb(245, 120, 66)\">" .. Player.Name .. " has completed the obby in " .. Time .. "!</font>")

end)