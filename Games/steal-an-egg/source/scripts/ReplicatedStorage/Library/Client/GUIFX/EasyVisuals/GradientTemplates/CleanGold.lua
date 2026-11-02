-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function() --[[ Line: 1 ]]
	local UIGradient = Instance.new("UIGradient")

	UIGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.new(255/255, 255/255, 255/255)),
		ColorSequenceKeypoint.new(0.209343, Color3.new(255/255, 255/255, 255/255)),
		ColorSequenceKeypoint.new(0.288927, Color3.new(0.666667)),
		ColorSequenceKeypoint.new(0.33391, Color3.new(255/255, 255/255, 0/255)),
		ColorSequenceKeypoint.new(0.371972, Color3.new(0.666667)),
		ColorSequenceKeypoint.new(0.482699, Color3.new(255/255, 255/255, 255/255)),
		ColorSequenceKeypoint.new(0.681661, Color3.new(255/255, 255/255, 255/255)),
		ColorSequenceKeypoint.new(0.745675, Color3.new(0.666667)),
		ColorSequenceKeypoint.new(0.807958, Color3.new(255/255, 255/255, 0/255)),
		ColorSequenceKeypoint.new(0.854671, Color3.new(0.666667)),
		ColorSequenceKeypoint.new(0.911765, Color3.new(255/255, 255/255, 255/255)),
		ColorSequenceKeypoint.new(1, Color3.new(255/255, 255/255, 255/255))
	})
	UIGradient.Rotation = -35

	return UIGradient
end