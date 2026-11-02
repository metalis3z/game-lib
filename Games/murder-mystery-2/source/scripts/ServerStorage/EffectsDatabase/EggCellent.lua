return function(Knife)
	script.Particles:Clone().Parent = Knife.Handle
	script.ParticleEmitter:Clone().Parent = Knife.Handle
end