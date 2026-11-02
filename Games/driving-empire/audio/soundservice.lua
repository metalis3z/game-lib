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
	I[1] = new("SoundGroup", nil, "LocalRev", { Volume = 1.2 })
		I[2] = new("ReverbSoundEffect", I[1], "Cave", { Enabled = false })
		I[3] = new("EqualizerSoundEffect", I[1], "EqualizerSoundEffect", { Enabled = false, HighGain = -10, LowGain = 5, MidGain = -6 })
	I[4] = new("SoundGroup", nil, "MiscRev", { Volume = 1.2 })
		I[5] = new("EqualizerSoundEffect", I[4], "EqualizerSoundEffect", { Enabled = false, HighGain = -10, LowGain = 10, MidGain = -6 })
	I[6] = new("SoundGroup", nil, "Music", { Volume = 1 })
	I[7] = new("SoundGroup", nil, "Radios", { Volume = 1 })
	I[8] = new("SoundGroup", nil, "Rev", { Volume = 1.2 })
		I[9] = new("ReverbSoundEffect", I[8], "Cave", { Enabled = false })
		I[10] = new("EqualizerSoundEffect", I[8], "EqualizerSoundEffect", { Enabled = false, HighGain = -10, LowGain = 5, MidGain = -6 })
	I[11] = new("SoundGroup", nil, "Weather", { Volume = 1 })
		I[12] = new("EqualizerSoundEffect", I[11], "Muffle", { LowGain = 0, MidGain = 0 })
	return { I[1], I[4], I[6], I[7], I[8], I[11] }
end

return build
