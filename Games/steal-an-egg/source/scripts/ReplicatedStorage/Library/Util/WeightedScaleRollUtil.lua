-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(ReplicatedStorage.Library.Types.Eggs)

return {
	RollScale = function(p1, p2, p3, p4, p5) --[[ RollScale | Line: 24 | Upvalues: Asserts (copy) ]]
		Asserts.table(p1)
		Asserts.optional.number(p3)
		Asserts.optional.number(p4)
		Asserts.optional.func(p5)

		local v1 = if p2 then p2 else Random.new()
		local sum = 0

		for i, v in ipairs(p1) do
			Asserts.number(v.min)
			Asserts.number(v.max)
			Asserts.number(v.weight)
			assert(if v.max >= v.min then true else false, "Scale tier max must be greater than or equal to min")
			assert(if v.weight > 0 then true else false, "Scale tier weight must be positive")

			local v4 = if p5 then p5(v.min, v.max) else 1

			Asserts.finite(v4)
			assert(if v4 > 0 then true else false, "Scale tier weight multiplier must be positive")
			sum = sum + v.weight * v4
		end

		assert(if sum > 0 then true else false, "Scale tier table must include positive weight")

		local v7 = p1[1]
		local v8 = v1:NextNumber() * sum
		local sum2 = 0

		for i, v in ipairs(p1) do
			sum2 = sum2 + v.weight * (if p5 then p5(v.min, v.max) else 1)

			if v8 <= sum2 then
				v7 = v

				break
			end
		end

		local v10 = v7.min + v1:NextNumber() * (v7.max - v7.min)
		local v11 = p4 or 0

		if p3 and v11 > 0 then
			while v10 * 2 <= p3 and v1:NextNumber() <= v11 do
				v10 = v10 * 2
			end
		end

		return v10
	end
}