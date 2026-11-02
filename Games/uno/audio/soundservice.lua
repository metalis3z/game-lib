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
	I[1] = new("SoundGroup", nil, "Close")
		I[2] = new("PitchShiftSoundEffect", I[1], "PitchShiftSoundEffect", { Octave = 0.75, Priority = 2 })
		I[3] = new("EqualizerSoundEffect", I[1], "EqualizerSoundEffect", { LowGain = 2, MidGain = 4, Priority = 1 })
		I[4] = new("ReverbSoundEffect", I[1], "ReverbSoundEffect", { DryLevel = 0, Priority = 3, WetLevel = -11 })
	I[5] = new("SoundGroup", nil, "Transition")
		I[6] = new("EchoSoundEffect", I[5], "EchoSoundEffect", { Delay = 0.1, Enabled = false, Feedback = 0.56, WetLevel = 2.8 })
		I[7] = new("ChorusSoundEffect", I[5], "ChorusSoundEffect", { Mix = 0.58, Rate = 1.2 })
		I[8] = new("DistortionSoundEffect", I[5], "DistortionSoundEffect", { Level = 0.38, Priority = 2 })
		I[9] = new("PitchShiftSoundEffect", I[5], "PitchShiftSoundEffect", { Octave = 1.475, Priority = 1 })
		I[10] = new("EqualizerSoundEffect", I[5], "EqualizerSoundEffect", { HighGain = -10.6999998, LowGain = 2, MidGain = 4, Priority = 1 })
	I[11] = new("SoundGroup", nil, "Boom")
		I[12] = new("EqualizerSoundEffect", I[11], "EqualizerSoundEffect", { LowGain = -9.8000002, MidGain = -2.5999999 })
	I[13] = new("SoundGroup", nil, "TickDown")
		I[14] = new("PitchShiftSoundEffect", I[13], "PitchShiftSoundEffect", { Octave = 0.8 })
		I[15] = new("ReverbSoundEffect", I[13], "ReverbSoundEffect", { DecayTime = 4.2789998, Priority = 2 })
		I[16] = new("EchoSoundEffect", I[13], "EchoSoundEffect", { Delay = 0.149, Enabled = false, Feedback = 0.6, Priority = 1 })
	I[17] = new("SoundGroup", nil, "CoinUp")
		I[18] = new("PitchShiftSoundEffect", I[17], "PitchShiftSoundEffect", { Octave = 1.145 })
		I[19] = new("ReverbSoundEffect", I[17], "ReverbSoundEffect", { DecayTime = 7.4629998, Priority = 2 })
		I[20] = new("EchoSoundEffect", I[17], "EchoSoundEffect", { Delay = 0.149, Enabled = false, Feedback = 0.6, Priority = 1 })
		I[21] = new("EqualizerSoundEffect", I[17], "EqualizerSoundEffect", { HighGain = -5.3000002, LowGain = 10, MidGain = 5.5, Priority = -1 })
	I[22] = new("SoundGroup", nil, "Draw")
		I[23] = new("PitchShiftSoundEffect", I[22], "Pitch", { Octave = 1 })
	I[24] = new("SoundGroup", nil, "TickUp")
		I[25] = new("PitchShiftSoundEffect", I[24], "PitchShiftSoundEffect", { Octave = 1.3 })
		I[26] = new("ReverbSoundEffect", I[24], "ReverbSoundEffect", { DecayTime = 0.896, Priority = 2 })
		I[27] = new("EchoSoundEffect", I[24], "EchoSoundEffect", { Delay = 0.149, Enabled = false, Feedback = 0.6, Priority = 1 })
	return { I[1], I[5], I[11], I[13], I[17], I[22], I[24] }
end

return build
