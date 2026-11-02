return function(Knife)
	local Emitter = Instance.new("ParticleEmitter", Knife.Handle)
	
	Emitter.Texture = "rbxassetid://2701504762"
	Emitter.Size = NumberSequence.new(0.6)
	Emitter.Lifetime = NumberRange.new(2,2.5)
	Emitter.Rate = 5
end