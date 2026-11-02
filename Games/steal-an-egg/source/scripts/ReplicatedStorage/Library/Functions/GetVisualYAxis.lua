-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 5 ]]
	local v1 = math.abs(p1.RightVector.Y)
	local v2 = math.abs(p1.UpVector.Y)
	local v3 = math.abs(p1.LookVector.Y)

	if v1 <= v2 and v3 <= v2 then
		return Vector3.new(0, 1, 0)
	end

	if v3 <= v1 then
		return Vector3.new(1, 0, 0)
	end

	return Vector3.new(0, 0, 1)
end