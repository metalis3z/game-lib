function onclicked(hit)
	local s=script.Parent.Gui:clone()	if hit.Parent.Humanoid then
		local player=game.Players:GetPlayerFromCharacter(hit.Parent)
		if player.PlayerGui:FindFirstChild("Gui")==nil then
			s.Parent=player.PlayerGui
		end
	end
end
script.Parent.Touched:connect(onclicked)