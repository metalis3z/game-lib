-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2) --[[ Line: 1 ]]
	for i, v in ipairs(if type(p1) == "table" then p1 else { p1 }) do
		local t = {}

		for i2, v2 in ipairs(v.Size.Keypoints) do
			table.insert(t, NumberSequenceKeypoint.new(v2.Time, v2.Value * p2, v2.Envelope * p2))
		end

		v.Size = NumberSequence.new(t)
		v.Drag = v.Drag * p2
		v.Speed = NumberRange.new(v.Speed.Min * p2, v.Speed.Max * p2)
		v.Acceleration = Vector3.new(v.Acceleration.X * p2, v.Acceleration.Y * p2, v.Acceleration.Z * p2)
		v.ZOffset = v.ZOffset * p2
	end
end