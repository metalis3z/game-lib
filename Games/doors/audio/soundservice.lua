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
	I[1] = new("SoundGroup", nil, "Main", { Volume = 1 })
		I[2] = new("EqualizerSoundEffect", I[1], "EqualizerSoundEffect", { Enabled = false, LowGain = 0, MidGain = 0 })
		I[3] = new("SoundGroup", I[1], "Music", { Volume = 1 })
			I[4] = new("EqualizerSoundEffect", I[3], "EqualizerSoundEffect", { Enabled = false, LowGain = 0, MidGain = 0 })
		I[5] = new("SoundGroup", I[1], "Sound", { Volume = 1 })
			I[6] = new("EqualizerSoundEffect", I[5], "EqualizerSoundEffect", { Enabled = false, LowGain = 0, MidGain = 0 })
		I[7] = new("SoundGroup", I[1], "Ambience", { Volume = 1 })
			I[8] = new("EqualizerSoundEffect", I[7], "EqualizerSoundEffect", { Enabled = false, LowGain = 0, MidGain = 0 })
		I[9] = new("SoundGroup", I[1], "Music_Priority", { Volume = 1 })
			I[10] = new("EqualizerSoundEffect", I[9], "EqualizerSoundEffect", { Enabled = false, LowGain = 0, MidGain = 0 })
		I[11] = new("EqualizerSoundEffect", I[1], "SanityEqualizer", { Enabled = false, LowGain = 0, MidGain = 0 })
	I[12] = new("SoundGroup", nil, "MusicLobby", { Volume = 1 })
		I[13] = new("EqualizerSoundEffect", I[12], "EqualizerSoundEffect", { Enabled = false, LowGain = 0, MidGain = 0 })
	return { I[1], I[12] }
end

return build
