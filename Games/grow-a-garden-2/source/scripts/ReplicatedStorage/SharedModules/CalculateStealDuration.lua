--credit to prince games studio
local t = {}
local SellValueData = require(game.ReplicatedStorage.SharedModules.SellValueData)
local MutationData = require(game.ReplicatedStorage.SharedModules.MutationData)

function t.Start(p1) --[[ Start | Line: 6 ]] end
function t.Init(p1) --[[ Init | Line: 10 ]] end
function t.CalculateStealDuration(p1, p2, p3, p4) --[[ CalculateStealDuration | Line: 14 | Upvalues: SellValueData (copy), MutationData (copy) ]]
	if not p2 then
		p2 = "Carrot"
	end

	if p3 == nil then
		p3 = 1
	end

	local v2 = math.floor(SellValueData[p2] * p3 ^ 3)

	if p4 then
		v2 = v2 * MutationData.ReturnPriceMultiplier(p4)
	end

	return math.sqrt(v2)
end

return t