script.Parent.ChildAdded:connect(function(child)
	if child.Name=="SeatWeld" and child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
		local p=game.Players:GetPlayerFromCharacter(child.Part1.Parent)
		local c = p.Character
		Animation = c.Humanoid:LoadAnimation(script.Animation)
		Animation:Play()
	end
end)

script.Parent.ChildRemoved:connect(function(child)
	if child.Name=="SeatWeld" and child:IsA("Weld") and game.Players:GetPlayerFromCharacter(child.Part1.Parent)~=nil then
		local p=game.Players:GetPlayerFromCharacter(child.Part1.Parent)
		local c = p.Character
		Animation:Stop()
	end
end)