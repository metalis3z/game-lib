current = nil
script.Parent.Touched:connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if player then
		if game.GamePassService:PlayerHasPass(player,204143218) then
			current = player
			script.Parent.CanCollide = false
			script.Parent.Transparency = 0.3
			coroutine.resume(coroutine.create(function()
				wait(2)
				if current == player then
					script.Parent.CanCollide = true
					script.Parent.Transparency = 0
				end
			end))
		else
			game.MarketplaceService:PromptPurchase(player,204143218)
			if hit.Parent:FindFirstChild("Torso") then
				hit.Parent.Torso.CFrame = hit.Parent.Torso.CFrame + Vector3.new(-10,15,0)
			end
		end
	end
end)