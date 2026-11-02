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
	I[1] = new("Sound", nil, "TickSFX V3")
	I[2] = new("Sound", nil, "Dial Switch Twisting Sharp Ticking 79 (SFX)")
	I[3] = new("Sound", nil, "sm2_ui_hover", { Volume = 2 })
	I[4] = new("Sound", nil, "Indicator")
	I[5] = new("Sound", nil, "Audio/balloon_pop_cute")
	I[6] = new("Sound", nil, "Jet Set Radio - Spray Sound Effect Ding1", { PlaybackRegion = NumberRange.new(0.3, 60000), PlaybackRegionsEnabled = true })
	I[7] = new("Sound", nil, "snare-drum-36")
	I[8] = new("Sound", nil, "Sound", { RollOffMode = Enum.RollOffMode.InverseTapered })
	I[9] = new("Sound", nil, "Item_Drop_Sound_EffectShort")
	I[10] = new("Sound", nil, "Hit Slime")
	I[11] = new("Sound", nil, "Wobble")
	I[12] = new("Sound", nil, "Sound1", { PlaybackRegion = NumberRange.new(0.3, 60000), PlaybackRegionsEnabled = true, RollOffMode = Enum.RollOffMode.InverseTapered })
	I[13] = new("Sound", nil, "dzwon", { LoopRegion = NumberRange.new(0, 0.38), Looped = true, PlaybackRegionsEnabled = true })
	I[14] = new("Sound", nil, "Magic blast sfx")
	I[15] = new("AudioDeviceOutput", nil, "AudioDeviceOutput")
	I[16] = new("Folder", nil, "music")
		I[17] = new("Sound", I[16], "Diamond Stars")
		I[18] = new("Sound", I[16], "Diamond Stars1", { Volume = 0.428 })
		I[19] = new("Sound", I[16], "Diamond Stars2", { Volume = 0.428 })
	I[20] = new("Sound", nil, "BackgroundMusic", { Playing = true, TimePosition = 55.403, Volume = 0.25 })
	I[21] = new("Sound", nil, "Sound", { PlaybackRegion = NumberRange.new(0.05, 1), PlaybackRegionsEnabled = true, Volume = 1.4 })
	I[22] = new("Sound", nil, "Sound", { Volume = 0.3 })
	I[23] = new("Sound", nil, "Sound")
	I[24] = new("Sound", nil, "Sound", { PlaybackRegion = NumberRange.new(0, 0.38), PlaybackRegionsEnabled = true })
	I[25] = new("Sound", nil, "Sound", { Volume = 2 })
	I[26] = new("Sound", nil, "Sound")
	I[27] = new("Sound", nil, "Sound", { PlaybackRegion = NumberRange.new(0.3, 999), PlaybackRegionsEnabled = true, Volume = 0.7 })
	I[28] = new("Sound", nil, "Sound")
	I[29] = new("Sound", nil, "Sound", { Volume = 0.8 })
	I[30] = new("Sound", nil, "Sound", { PlaybackRegion = NumberRange.new(0.07, 999), PlaybackRegionsEnabled = true, Volume = 0.8 })
	I[31] = new("Sound", nil, "Sound")
	I[32] = new("Sound", nil, "Sound")
	I[33] = new("Sound", nil, "Sound", { Volume = 1 })
	I[34] = new("Sound", nil, "Sound", { Volume = 0.25 })
	I[35] = new("Sound", nil, "Sound", { Volume = 0.25 })
	I[36] = new("Sound", nil, "Sound", { Volume = 0.25 })
	I[37] = new("Sound", nil, "Sound", { Volume = 0.25 })
	I[38] = new("Sound", nil, "Sound", { Volume = 0.25 })
	I[39] = new("Sound", nil, "Sound", { Volume = 0.25 })
	I[40] = new("Sound", nil, "Sound")
	I[41] = new("Sound", nil, "Sound", { Looped = true, Volume = 0.3 })
	I[42] = new("Sound", nil, "Sound", { Volume = 1 })
	I[43] = new("Sound", nil, "Sound", { Volume = 0.8 })
	I[44] = new("Sound", nil, "Sound", { PlaybackRegion = NumberRange.new(0.3, 999), PlaybackRegionsEnabled = true })
	I[45] = new("Sound", nil, "Sound")
	I[46] = new("Sound", nil, "Sound", { Volume = 0.1 })
	I[47] = new("Sound", nil, "Sound", { PlaybackSpeed = 0.8 })
	I[48] = new("Sound", nil, "Sound")
	I[49] = new("Sound", nil, "Sound")
	I[50] = new("Sound", nil, "Sound")
	I[51] = new("Sound", nil, "Sound")
	I[52] = new("Sound", nil, "Sound")
	I[53] = new("Sound", nil, "Sound")
	I[54] = new("Sound", nil, "Sound", { Volume = 0.8 })
	I[55] = new("Sound", nil, "Sound", { Volume = 0.8 })
	I[56] = new("Sound", nil, "Sound")
	I[57] = new("Sound", nil, "Sound")
	I[58] = new("Sound", nil, "Sound")
	I[59] = new("Sound", nil, "Sound")
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[20], I[21], I[22], I[23], I[24], I[25], I[26], I[27], I[28], I[29], I[30], I[31], I[32], I[33], I[34], I[35], I[36], I[37], I[38], I[39], I[40], I[41], I[42], I[43], I[44], I[45], I[46], I[47], I[48], I[49], I[50], I[51], I[52], I[53], I[54], I[55], I[56], I[57], I[58], I[59] }
end

return build
