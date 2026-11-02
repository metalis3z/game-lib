local module = {}

module.give = function(playerName)
	
	local player = game.Players:FindFirstChild(playerName)
	
	for i,v in pairs(script:GetChildren()) do
		v:Clone().Parent = player.Backpack
	end
	
end

return module
