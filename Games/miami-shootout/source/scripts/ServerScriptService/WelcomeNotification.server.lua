local RemoteEvent = game.ReplicatedStorage.RemoteEvents.Notifications
local Prompt = script.Parent
local players = game:GetService("Players")

game.Players.PlayerAdded:Connect(function(player)
	task.wait(10) -- Wait untill the notification
	RemoteEvent:FireClient(player, "Info", "Welcome to the game, "..player.Name.."!", 5)
end)

