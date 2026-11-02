--credit to quartz games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StableExp10 = require(ReplicatedStorage.UserGenerated.Math.StableExp10)

return function(p1, p2, p3, p4) --[[ RoundFigures | Line: 40 | Upvalues: StableExp10 (copy) ]]
	assert(if type(p1) == "number" then true else false)
	assert(if p2 == nil then true elseif type(p2) == "number" then true else false)
	assert(if p3 == nil then true elseif type(p3) == "number" then true else false)
	assert(if p4 == nil then true elseif type(p4) == "function" then true else false)

	if p1 == p1 and (p1 ~= (1 / 0) and p1 ~= (-1 / 0)) then
		local v6 = p3 or 1
		local v7 = if p4 then p4 else math.round
		local v8 = math.sign(p1)

		if v8 == 0 then
			return 0
		end

		local v9 = p1 * v8
		local v11 = math.floor((math.log10(v9))) - (p2 or 3) + 1

		return StableExp10(v7((StableExp10(if v6 == 1 then v9 else v9 / v6, -v11))) * v6, v11) * v8
	end

	return p1
end