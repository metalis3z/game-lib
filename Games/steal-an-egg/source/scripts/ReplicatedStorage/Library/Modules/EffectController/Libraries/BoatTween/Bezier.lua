-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function Linear(p1) --[[ Linear | Line: 1 ]]
	return p1
end

return function(p1, p2, p3, p4) --[[ Bezier | Line: 5 | Upvalues: Linear (copy) ]]
	if not (p1 and (p2 and (p3 and p4))) then
		error("Need 4 numbers to construct a Bezier curve", 0)
	end

	if not (p1 >= 0 and (p1 <= 1 and (p3 >= 0 and p3 <= 1))) then
		error("The x values must be within range [0, 1]", 0)
	end

	if p1 == p2 and p3 == p4 then
		return Linear
	end

	local t = {}

	for i = 0, 10 do
		local v1 = i / 10

		t[i] = (((1 - 3 * p3 + 3 * p3) * v1 + (3 * p3 - 6 * p1)) * v1 + 3 * p1) * v1
	end

	return function(p12) --[[ Line: 25 | Upvalues: t (copy), p3 (copy), p1 (copy), p4 (copy), p2 (copy) ]]
		if p12 == 0 or p12 == 1 then
			return p12
		end

		local count = 1
		local sum = 0

		while count ~= 10 and t[count] <= p12 do
			count = count + 1
			sum = sum + 0.1
		end

		local v1 = count - 1
		local sum2 = sum + (p12 - t[v1]) / (t[v1 + 1] - t[v1]) / 10
		local v2 = 3 * (1 - 3 * p3 + 3 * p1) * sum2 * sum2 + 2 * (3 * p3 - 6 * p1) * sum2 + 3 * p1
		local v3

		if v2 >= 0.001 then
			for i = 0, 3 do
				sum2 = sum2 - ((((1 - 3 * p3 + 3 * p1) * sum2 + (3 * p3 - 6 * p1)) * sum2 + 3 * p1) * sum2 - p12) / (3 * (1 - 3 * p3 + 3 * p1) * sum2 * sum2 + 2 * (3 * p3 - 6 * p1) * sum2 + 3 * p1)
			end

			v3 = sum2
		elseif v2 == 0 then
			v3 = sum2
		else
			local v4 = 0
			local count2 = nil
			local v5 = sum + 0.1
			local v6 = nil

			while math.abs(v4) > 1e-7 and count2 < 10 do
				v6 = sum + (v5 - sum) / 2
				v4 = (((1 - 3 * p3 + 3 * p1) * v6 + (3 * p3 - 6 * p1)) * v6 + 3 * p1) * v6 - p12

				if v4 > 0 then
					v5 = v6
				else
					sum = v6
				end

				count2 = count2 + 1
			end

			v3 = v6
		end

		return (((1 - 3 * p4 + 3 * p2) * v3 + (3 * p4 - 6 * p2)) * v3 + 3 * p2) * v3
	end
end