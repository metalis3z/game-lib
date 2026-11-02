-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local t = {
	GetWakingDuration = function() --[[ GetWakingDuration | Line: 23 ]]
		return 0.63
	end,
	ResolveHitDistance = function(p1) --[[ ResolveHitDistance | Line: 27 | Upvalues: Asserts (copy) ]]
		Asserts.optional.number(p1)

		local v1 = p1 or 10

		Asserts.cond(v1 > 0)

		return v1
	end,
	ResolveWalkSpeed = function(p1, p2, p3) --[[ ResolveWalkSpeed | Line: 35 | Upvalues: Asserts (copy) ]]
		Asserts.number(p1)
		Asserts.number(p2)
		Asserts.number(p3)
		Asserts.cond(p1 > 0)
		Asserts.cond(if p2 > 0 then true else false)
		Asserts.cond(if p3 >= 0 then true else false)

		local v4 = math.max(p2, 0.001)

		if p3 <= v4 then
			return p1
		end

		return math.min(p1 * ((p3 / v4 - 1) * 0.5 + 1), p1 * 4)
	end
}

function t.ResolveCatchDuration(p1, p2, p3, p4, p5) --[[ ResolveCatchDuration | Line: 53 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.number(p1)
	Asserts.number(p2)
	Asserts.number(p3)
	Asserts.number(p4)
	Asserts.number(p5)
	Asserts.cond(p1 > 0)
	Asserts.cond(if p2 > 0 then true else false)
	Asserts.cond(if p3 > 0 then true else false)
	Asserts.cond(if p4 >= 0 then true else false)
	Asserts.cond(if p5 >= 0 then true else false)

	if p4 <= p3 then
		return 0
	end

	if t.ResolveWalkSpeed(p1, p2, p3) <= p5 then
		return nil
	end

	local v6 = math.max(p2, 0.001)
	local v7 = v6 * 7
	local sum = 0
	local v8 = math.max(p3, v7)

	if v8 < p4 then
		sum = sum + (p4 - v8) / (p1 * 4 - p5)
	end

	local v9 = math.max(p3, v6)
	local v10 = math.min(p4, v7)

	if v9 < v10 then
		local v11 = p1 * 0.5 / v6
		local v12 = p1 * 0.5

		sum = sum + math.log((v12 + v11 * v10 - p5) / (v12 + v11 * v9 - p5)) / v11
	end

	local v13 = math.min(p4, v6)

	if p3 < v13 then
		sum = sum + (v13 - p3) / (p1 - p5)
	end

	return sum
end

return t