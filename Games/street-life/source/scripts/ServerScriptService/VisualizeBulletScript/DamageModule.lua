local module = {}

module.CanDamage = function(obj, player)
	if obj:FindFirstChild("Humanoid") then
		local p = game.Players:GetPlayerFromCharacter(obj)
		if obj:FindFirstChild("Creator") then
			p = obj:FindFirstChild("Creator").Value
		end
		if p then
			if p == player then
				return false
			else
				return true
			end
		else
			return true
		end
	end
	return false
end

return module