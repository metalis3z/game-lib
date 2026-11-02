return function(Knife)
	local Emitter = Instance.new("Fire", Knife.Handle)

	Emitter.Size = NumberSequence.new(0.5)
	Emitter.Color = Color3.fromRGB(0, 0, 0)
	Emitter.SecondaryColor = Color3.fromRGB(31, 31, 31)
end