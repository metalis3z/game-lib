local Part = script.Parent.Parent

task.spawn(function()
	while true do
		local t_1 = game:GetService("TweenService"):Create(Part, TweenInfo.new(1), {Position = Part.Position - Vector3.new(0,1,0)})
		t_1:Play()
		repeat task.wait() until t_1.PlaybackState == Enum.PlaybackState.Completed
		local t_2 = game:GetService("TweenService"):Create(Part, TweenInfo.new(1), {Position = Part.Position + Vector3.new(0,1,0)})
		t_2:Play()
		repeat task.wait() until t_2.PlaybackState == Enum.PlaybackState.Completed
	end
end)

script.Parent.Parent.Parent.WaitingRegion.Touched:Connect(function(otherPart : BasePart)
	local plr = game.Players:GetPlayerFromCharacter(otherPart.Parent)
	if plr ~= nil then
		game.ReplicatedStorage.Remote.TweenLobby:FireClient(plr)
		game.ReplicatedStorage.Remote.ServerJoinedLift:Fire(plr)
		plr.Character:MoveTo(game.Workspace.Lobby.WaitingArea.WaitTeleport.Position + Vector3.new(0, 3, 0))
	end
end)