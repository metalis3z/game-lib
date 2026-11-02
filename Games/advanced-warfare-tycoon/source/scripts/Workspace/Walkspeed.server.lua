function enter(player)
	wait(2)
	local plr = game.Workspace:FindFirstChild(player.Name)
	if plr then
		local char = plr
		char.Humanoid.WalkSpeed = 33
	end
end
game.Players.ChildAdded:connect(enter)