-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2) --[[ Line: 4 ]]
	local t = {}

	for i, v in ipairs(p1.Keypoints) do
		table.insert(t, NumberSequenceKeypoint.new(v.Time, v.Value * p2, v.Envelope * p2))
	end

	return NumberSequence.new(t)
end