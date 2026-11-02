return function(knife)
	script.ParticleEmitter:Clone().Parent = knife.Handle;
	knife.Handle.Transparency = 0.2
end