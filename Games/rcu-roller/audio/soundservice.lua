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
	I[1] = new("SoundGroup", nil, "Music", { Volume = 0.3 })
		I[2] = new("Sound", I[1], "Music", { Playing = true, TimePosition = 99.8253597, Volume = 0.3 })
	I[3] = new("SoundGroup", nil, "Playing")
	I[4] = new("SoundGroup", nil, "SFX")
		I[5] = new("Sound", I[4], "Chest", { Volume = 0.8 })
		I[6] = new("Sound", I[4], "Chest Thud", { Volume = 0.35 })
		I[7] = new("Sound", I[4], "Click Down")
		I[8] = new("Sound", I[4], "Click Up")
		I[9] = new("Sound", I[4], "Confetti", { RollOffMode = Enum.RollOffMode.InverseTapered })
		I[10] = new("Sound", I[4], "Drum Roll", { Volume = 0.25 })
		I[11] = new("Sound", I[4], "Exclusive Egg Grow", { RollOffMaxDistance = 110, RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 0.45 })
		I[12] = new("Sound", I[4], "Exclusive Egg Hit")
		I[13] = new("Sound", I[4], "Exclusive Egg Pop", { RollOffMaxDistance = 110, RollOffMode = Enum.RollOffMode.InverseTapered })
		I[14] = new("Sound", I[4], "Exclusive Egg Reveal", { RollOffMaxDistance = 110, RollOffMode = Enum.RollOffMode.InverseTapered })
		I[15] = new("Sound", I[4], "Exclusive Egg Reveal Special", { RollOffMaxDistance = 110, RollOffMode = Enum.RollOffMode.InverseTapered })
		I[16] = new("Sound", I[4], "Explosion", { PlaybackSpeed = 1.3, Volume = 0.4 })
		I[17] = new("Sound", I[4], "Falling Star", { Looped = true, RollOffMaxDistance = 30, RollOffMinDistance = 1, RollOffMode = Enum.RollOffMode.Linear, Volume = 1 })
		I[18] = new("Sound", I[4], "Hover")
		I[19] = new("Sound", I[4], "Index Reward")
		I[20] = new("Sound", I[4], "Lever", { RollOffMode = Enum.RollOffMode.InverseTapered })
		I[21] = new("Sound", I[4], "Lightning Hit")
		I[22] = new("Sound", I[4], "Map Unlocked")
		I[23] = new("Sound", I[4], "Message Popup")
		I[24] = new("Sound", I[4], "Mini Chest", { Volume = 0.7 })
		I[25] = new("Sound", I[4], "New Item", { Volume = 0.25 })
		I[26] = new("Sound", I[4], "Notification", { Volume = 0.1 })
		I[27] = new("Sound", I[4], "Orb Collect")
		I[28] = new("Sound", I[4], "Orb Spawn", { RollOffMaxDistance = 20, RollOffMinDistance = 1, RollOffMode = Enum.RollOffMode.Linear, Volume = 0.25 })
		I[29] = new("Sound", I[4], "Pet Reveal")
		I[30] = new("Sound", I[4], "Pop")
		I[31] = new("Sound", I[4], "Prestige", { Volume = 1 })
		I[32] = new("Sound", I[4], "Purchase Completed", { RollOffMode = Enum.RollOffMode.InverseTapered })
		I[33] = new("Sound", I[4], "Purchase Prompt")
		I[34] = new("Sound", I[4], "Quest Completed")
		I[35] = new("Sound", I[4], "Reward")
		I[36] = new("Sound", I[4], "Spin", { Volume = 0.8 })
		I[37] = new("Sound", I[4], "Supporter Pack")
		I[38] = new("Sound", I[4], "Tick", { Volume = 0.25 })
		I[39] = new("Sound", I[4], "Tree Hit")
		I[40] = new("Sound", I[4], "Upgrade")
		I[41] = new("Sound", I[4], "Woosh")
		I[42] = new("SoundGroup", I[4], "Ambience")
			I[43] = new("Sound", I[42], "Birds Chirping", { Looped = true, Playing = true, RollOffMode = Enum.RollOffMode.InverseTapered, TimePosition = 101.4730109, Volume = 0.02 })
		I[44] = new("SoundGroup", I[4], "Reveals")
			I[45] = new("Sound", I[44], "Legendary Reveal", { Volume = 0.7 })
			I[46] = new("Sound", I[44], "Mythical Reveal", { Volume = 0.7 })
			I[47] = new("Sound", I[44], "Eternal Reveal", { Volume = 0.7 })
			I[48] = new("Sound", I[44], "Secret Reveal", { Volume = 0.7 })
			I[49] = new("Sound", I[44], "Supreme Reveal", { Volume = 0.7 })
			I[50] = new("Sound", I[44], "Ultimate Reveal", { Volume = 0.7 })
			I[51] = new("Sound", I[44], "Exclusive Reveal", { Volume = 0.7 })
		I[52] = new("Sound", I[4], "Trade Request")
		I[53] = new("Sound", I[4], "Tutorial Stage")
		I[54] = new("Sound", I[4], "Tutorial Completed")
	return { I[1], I[3], I[4] }
end

return build
