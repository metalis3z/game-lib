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
	I[1] = new("Sound", nil, "Click", { Volume = 0.75 })
	I[2] = new("Sound", nil, "Hover2", { PlaybackSpeed = 1.5, Volume = 2 })
	I[3] = new("Sound", nil, "Success2", { PlaybackSpeed = 1.5 })
	I[4] = new("Sound", nil, "WorldCupSong")
	I[5] = new("Sound", nil, "Club", { Volume = 1 })
		I[6] = new("ReverbSoundEffect", I[5], "ReverbSoundEffect", { WetLevel = -13 })
		I[7] = new("EqualizerSoundEffect", I[5], "EqualizerSoundEffect", { HighGain = 5, LowGain = 10, MidGain = 5, Priority = 1 })
		I[8] = new("DistortionSoundEffect", I[5], "DistortionSoundEffect", { Level = 0.5 })
	I[9] = new("Sound", nil, "DonationSent", { Volume = 1 })
	I[10] = new("Sound", nil, "Hover")
	I[11] = new("Sound", nil, "ItemUnlocked", { Volume = 1 })
	I[12] = new("Sound", nil, "KaChing", { Volume = 1.5 })
	I[13] = new("Sound", nil, "ShopOpening", { PlayOnRemove = true, Volume = 4 })
	I[14] = new("Sound", nil, "Success", { Volume = 1 })
	I[15] = new("Sound", nil, "ItemUnlocked2", { Volume = 1 })
	I[16] = new("Sound", nil, "Streak", { Volume = 0.2 })
	I[17] = new("Sound", nil, "dudu", { Looped = true, Playing = true, Volume = 5 })
	I[18] = new("Folder", nil, "SFXSounds")
		I[19] = new("Sound", I[18], "DonationLevel1", { RollOffMaxDistance = 40, RollOffMode = Enum.RollOffMode.Linear, Volume = 1 })
		I[20] = new("Sound", I[18], "DonationLevel2", { RollOffMaxDistance = 60, RollOffMinDistance = 20, RollOffMode = Enum.RollOffMode.Linear, Volume = 1 })
		I[21] = new("Sound", I[18], "DonationLevel3", { RollOffMaxDistance = 80, RollOffMinDistance = 30, RollOffMode = Enum.RollOffMode.Linear, Volume = 1 })
		I[22] = new("Sound", I[18], "DonationLevel4", { RollOffMaxDistance = 100, RollOffMinDistance = 40, RollOffMode = Enum.RollOffMode.Linear, Volume = 1 })
		I[23] = new("Sound", I[18], "DonationLevel5", { RollOffMaxDistance = 250, RollOffMinDistance = 50, RollOffMode = Enum.RollOffMode.Linear, Volume = 1 })
		I[24] = new("Sound", I[18], "FallingCoins", { Looped = true, PlaybackSpeed = 1.5, RollOffMaxDistance = 40, RollOffMode = Enum.RollOffMode.Linear, Volume = 1 })
		I[25] = new("Sound", I[18], "DonationLevel6", { RollOffMaxDistance = 250, RollOffMinDistance = 50, RollOffMode = Enum.RollOffMode.Linear, Volume = 1 })
		I[26] = new("Sound", I[18], "DonationLevel7", { RollOffMaxDistance = 250, RollOffMinDistance = 50, RollOffMode = Enum.RollOffMode.Linear, Volume = 1 })
		I[27] = new("Sound", I[18], "DonationLevel6", { RollOffMaxDistance = 750, RollOffMode = Enum.RollOffMode.InverseTapered, TimePosition = 1.39, Volume = 3 })
	I[28] = new("Sound", nil, "Fail", { Volume = 1 })
	return { I[1], I[2], I[3], I[4], I[5], I[9], I[10], I[11], I[12], I[13], I[14], I[15], I[16], I[17], I[18], I[28] }
end

return build
