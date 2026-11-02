script.Parent.Base.Touched:Connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	
	if player.Character:GetAttribute("CrucifixEnabled", true) then
		player.Character.Crucifix.Function:Fire(script.Parent.Base)
		script.Parent.Base.CanTouch = false
	end
end)