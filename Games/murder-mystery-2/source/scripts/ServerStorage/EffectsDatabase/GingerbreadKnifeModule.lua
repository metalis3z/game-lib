return function(Knife)
	local Emitter = Instance.new("ParticleEmitter", Knife.Handle)
	
	Emitter.Texture = "rbxassetid://2683075854"
	Emitter.Size = NumberSequence.new(0.5)
	Emitter.Lifetime = NumberRange.new(0.5)
	Emitter.Rate = 14
end