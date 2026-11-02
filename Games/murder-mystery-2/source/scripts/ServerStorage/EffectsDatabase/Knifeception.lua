return function(knife)
	script.ParticleEmitter:Clone().Parent = knife.Handle;
	script.ParticleEmitter.Texture = knife.TextureId;
end