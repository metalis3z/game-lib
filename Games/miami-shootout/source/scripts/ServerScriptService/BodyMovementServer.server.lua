local RemoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("BodyMovementEvent")
RemoteEvent.OnServerEvent:Connect(function(Player:Player,Joint:Motor6D,Angle:CFrame)
	local Character = Player.Character
	if not (Character and Joint:IsDescendantOf(Character)) then
		return
	end
	RemoteEvent:FireAllClients(Player,Joint,Angle)
end)