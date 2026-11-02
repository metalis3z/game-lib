local messaging = game:GetService("MessagingService")
local admins = {"baseball8610"}

messaging:SubscribeAsync("Announcements", function(msg)
	game.ReplicatedStorage.IfSend.Value = true
	game.ReplicatedStorage.Recieve:FireAllClients(msg.Data)
	wait(5)
	game.ReplicatedStorage.IfSend.Value = false
end)

game.ReplicatedStorage.Send.OnServerEvent:Connect(function(plr,msg)
	for i,v in pairs(admins) do
		if plr.Name == v then
			messaging:PublishAsync("Announcements",msg)
		end
	end
end)