return function(Knife)
	script.ParticleEmitter:Clone().Parent = Knife.Handle
	script.Particles:Clone().Parent = Knife.Handle
	script.sparks:Clone().Parent = Knife.Handle
	script.a:Clone().Parent = Knife.Handle
end