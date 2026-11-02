local RunService = game:GetService("RunService")
local Knit = require(game.ReplicatedStorage.Packages.Knit)

return function(player, data)
	local maxEggs = 3
	if RunService:IsClient() then
		maxEggs += Knit.GetController("FFlagController"):getFFlag("extraEggs") or 0
	else
		maxEggs += Knit.GetService("FFlagService"):getFFlag("extraEggs") or 0
	end
	if data.passes and data.passes.extraEgg then maxEggs += 1 end
	if data.ancientShop and data.ancientShop.extraEggOpen then maxEggs += 1 end
	return maxEggs
end