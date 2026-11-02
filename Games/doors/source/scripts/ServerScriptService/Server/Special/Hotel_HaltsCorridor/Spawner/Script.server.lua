script.Parent.Parent.RoomHitbox.Touched:Connect(function()
	game.ReplicatedStorage.ClientBricks.Entities.HaltActive:FireAllClients(script.Parent.Parent)
	script.Parent.Parent.RoomHitbox.CanTouch = false
end)