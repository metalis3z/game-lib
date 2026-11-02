--credit to quartz games studio
require(game.ReplicatedStorage.UserGenerated.Randoms.Base)

local Xorshift128 = require(game.ReplicatedStorage.UserGenerated.Randoms.Xorshift128)

return table.freeze({
	DefaultXorshift128 = Xorshift128.R,
	Xorshift128 = function(p1) --[[ Xorshift128 | Line: 28 | Upvalues: Xorshift128 (copy) ]]
		return Xorshift128.new(p1)
	end,
	UniqueXorshift128 = function(p1) --[[ UniqueXorshift128 | Line: 31 | Upvalues: Xorshift128 (copy) ]]
		return Xorshift128.Unique(p1)
	end
})