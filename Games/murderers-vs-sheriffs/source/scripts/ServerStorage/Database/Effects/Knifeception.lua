return function(knife)
	script.ParticleEmitter.Texture = knife.TextureId
	script.ParticleEmitter:Clone().Parent = knife.Handle;
end