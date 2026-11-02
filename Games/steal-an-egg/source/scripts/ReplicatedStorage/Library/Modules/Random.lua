-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

function t.new(p1) --[[ new | Line: 5 | Upvalues: t (copy) ]]
	local v1 = nil

	if p1 == nil then
		v1 = Random.new()
	elseif type(p1) == "number" then
		v1 = Random.new(p1)
	elseif typeof(p1) == "Random" then
		v1 = p1
	else
		error("Unknown alternative seed type: " .. typeof(p1))
	end

	return {
		new = t.new,
		handle = function() --[[ handle | Line: 18 | Upvalues: v1 (ref) ]]
			return v1
		end,
		clone = function() --[[ clone | Line: 21 | Upvalues: t (ref), v1 (ref) ]]
			return t.new(v1:Clone())
		end,
		seed = function(p1) --[[ seed | Line: 24 | Upvalues: v1 (ref) ]]
			v1 = Random.new(p1)
		end,
		number = function(p1, p2) --[[ number | Line: 27 | Upvalues: v1 (ref) ]]
			return p1 and v1:NextNumber(p1, p2) or v1:NextNumber()
		end,
		boolean = function(p1) --[[ boolean | Line: 30 | Upvalues: v1 (ref) ]]
			return v1:NextNumber() < (p1 or 0.5)
		end,
		integer = function(p1, p2) --[[ integer | Line: 33 | Upvalues: v1 (ref) ]]
			return v1:NextInteger(p1, p2)
		end,
		normal = function(p1, p2) --[[ normal | Line: 36 | Upvalues: v1 (ref) ]]
			local v4 = math.sqrt(math.log((math.max(2.2250738585072014e-308, v1:NextNumber()))) * -2) * (p2 or 1)
			local v5 = v1:NextNumber() * 6.283185307179586
			local v6 = p1 or 0

			return v4 * math.cos(v5) + v6, v4 * math.sin(v5) + v6
		end,
		Vector3 = function(p1) --[[ Vector3 | Line: 45 | Upvalues: v1 (ref) ]]
			return v1:NextUnitVector() * (p1 or 1)
		end,
		Vector2 = function(p1) --[[ Vector2 | Line: 48 | Upvalues: v1 (ref) ]]
			local v12 = 6.283185307179586 * v1:NextNumber()

			return Vector2.new(math.cos(v12), (math.sin(v12))) * (p1 or 1)
		end,
		flatVector3 = function(p1) --[[ flatVector3 | Line: 52 | Upvalues: v1 (ref) ]]
			local v12 = 6.283185307179586 * v1:NextNumber()
			local v2 = p1 or 1
			local v3 = math.cos(v12) * v2

			return Vector3.new(v3, 0, math.sin(v12) * v2)
		end
	}
end
t.R = t.new()

return t