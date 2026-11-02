-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2) --[[ Line: 1 ]]
	local sum = 0
	local X = p2.X
	local Y = p2.Y
	local Z = p2.Z
	local count = 0

	if p2.X < -p1.X then
		local v1 = X + p1.X

		X = -p1.X
		sum = sum + v1 * v1
	elseif p2.X > p1.X then
		local v2 = X - p1.X

		X = p1.X
		sum = sum + v2 * v2
	else
		count = count + 1
	end

	if p2.Y < -p1.Y then
		local v3 = Y + p1.Y

		Y = -p1.Y
		sum = sum + v3 * v3
	elseif p2.Y > p1.Y then
		local v4 = Y - p1.Y

		Y = p1.Y
		sum = sum + v4 * v4
	else
		count = count + 1
	end

	if p2.Z < -p1.Z then
		local v5 = Z + p1.Z

		Z = -p1.Z
		sum = sum + v5 * v5
	elseif p2.Z > p1.Z then
		local v6 = Z - p1.Z

		Z = p1.Z
		sum = sum + v6 * v6
	else
		count = count + 1
	end

	return math.sqrt(sum), Vector3.new(X, Y, Z), count >= 3
end