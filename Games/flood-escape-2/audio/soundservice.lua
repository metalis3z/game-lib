-- Generated from audio/soundservice.rbxm by _tools/rbxm2lua.luau
-- Audio pack: require(this)() returns the Sound / SoundGroup instances; parent them where you need them

local function new(class, parent, name, props, attrs, tags)
	local o = Instance.new(class)
	o.Name = name
	if props then
		for k, v in props do
			o[k] = v
		end
	end
	if attrs then
		for k, v in attrs do
			o:SetAttribute(k, v)
		end
	end
	if tags then
		for _, t in tags do
			o:AddTag(t)
		end
	end
	if parent then
		o.Parent = parent
	end
	return o
end

local function build()
	local I = {}
	I[1] = new("SoundGroup", nil, "Boomboxes", { Volume = 1 })
	I[2] = new("SoundGroup", nil, "Underwater", { Volume = 1 })
		I[3] = new("EqualizerSoundEffect", I[2], "Equalizer", { HighGain = -24, LowGain = -2, MidGain = -24 })
		I[4] = new("ReverbSoundEffect", I[2], "Reverb", { DecayTime = 0.2, Density = 0, Diffusion = 0, DryLevel = 2, WetLevel = -10 })
	I[5] = new("SoundGroup", nil, "Spectate_BGM")
		I[6] = new("EqualizerSoundEffect", I[5], "EqualizerSoundEffect", { LowGain = -35, MidGain = -1 })
		I[7] = new("DistortionSoundEffect", I[5], "DistortionSoundEffect", { Level = 0.25 })
	return { I[1], I[2], I[5] }
end

return build
