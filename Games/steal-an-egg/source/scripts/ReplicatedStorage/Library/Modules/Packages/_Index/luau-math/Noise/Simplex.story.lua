-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	print("Running")

	local v1 = require(script.Parent)
	local v2 = v1.Simplex.new()

	v2:SetSeed(1277)
	v2:SetFrequency(4)
	v2:SetAmplitude(0.5)
	v2:SetLacunarity(2)
	v2:SetPersistence(0.5)

	local v3 = v1.Simplex.new()

	v3:SetSeed(2554)
	v2:InsertOctave(v3)

	local v4 = v3:Clone()

	v4:SetSeed(3831)
	v2:InsertOctave(v4)

	local v5 = v2:ToMatrix(64)

	print("Drawing")
	v2:Debug(p1, 5, v5)
	print("Done")

	return function() --[[ Line: 28 ]] end
end