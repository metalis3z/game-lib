--credit to leon games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SellValueData = require(script.Parent.SellValueData)
local MutationData = require(script.Parent.MutationData)
local SeedData = require(script.Parent.SeedData)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local v1 = FastFlags.Replicated("Game.Selling.SizeMultiplier", Asserts.FinitePositive, 1)
local v2 = FastFlags.Replicated("Game.Selling.MutationMultiplier", Asserts.FinitePositive, 1)
local v3 = FastFlags.Replicated("Game.Selling.SizeExponent", Asserts.FinitePositive, 2.65)
local v4 = FastFlags.Replicated("Game.Selling.SizeExponentOverrides", Asserts.Map(Asserts.String, Asserts.FinitePositive), {
	Bamboo = 2.4
})
local t = {}
local t2 = {
	Carrot = 4
}

for v5, v6 in SeedData do
	t[v6.SeedName] = if v6.IsSingleHarvest == true then true else false
end

return function(p1, p2, p3, p4, p5) --[[ Calculate | Line: 30 | Upvalues: SellValueData (copy), MutationData (copy), t (copy), v2 (copy), v4 (copy), v3 (copy), v1 (copy), t2 (copy) ]]
	local v22 = if p3 then MutationData.ReturnPriceMultiplier(p3) else 1

	if t[p1] and v22 > 1 then
		v22 = 1 + (v22 - 1) * 0.25
	end

	if p3 then
		v22 = v22 * v2:Get()
	end

	local v32 = if typeof(p5) == "number" and p5 > 0 then 1 - math.clamp(p5, 0, 1) * 0.8 else 1
	local v42 = v4:Get()[p1] or v3:Get()
	local v5 = (SellValueData[p1] or 0) * p2 ^ v42 * v1:Get() * v22 * v32
	local v7 = math.floor(math.floor(v5) * (1 + (p4:GetAttribute("Friends") or 0) * 0.1))
	local v8 = t2[p1]

	return if v8 then if v7 < v8 then v8 else v7 else v7
end