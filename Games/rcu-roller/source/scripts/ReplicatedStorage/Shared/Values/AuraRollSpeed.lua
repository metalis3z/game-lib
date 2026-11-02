local Fruits = require(game:GetService("ReplicatedStorage").Shared.List.Items.Fruits)

return function(player, data)
	local speed = 1
	if data.activeBoosts then
		if data.activeBoosts.pineapple then speed += Fruits.pineapple.multiplier end
		if data.activeBoosts.goldenPineapple then speed += Fruits.goldenPineapple.multiplier end
	end
	return speed
end