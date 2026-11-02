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
	I[1] = new("Folder", nil, "Music")
		I[2] = new("Sound", I[1], "Song1", { Looped = true })
		I[3] = new("Sound", I[1], "Song2")
		I[4] = new("Sound", I[1], "Song3")
	I[5] = new("Sound", nil, "_HoverPool1", { Volume = 1 })
	I[6] = new("Sound", nil, "_HoverPool2", { Volume = 1 })
	I[7] = new("Sound", nil, "_HoverPool3", { Volume = 1 })
	I[8] = new("Sound", nil, "_HoverPool4", { Volume = 1 })
	I[9] = new("Sound", nil, "_HoverPool5", { Volume = 1 })
	I[10] = new("Sound", nil, "_HoverPool6", { Volume = 1 })
	I[11] = new("Sound", nil, "Sound", { Volume = 0.35 })
	I[12] = new("Sound", nil, "Sound", { Volume = 0.2 })
	I[13] = new("Sound", nil, "_HoverSoundProto", { Volume = 1 })
	I[14] = new("Folder", nil, "Sounds")
		I[15] = new("Sound", I[14], "ClickSound", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 0.1 })
		I[16] = new("Sound", I[14], "PopUpSound", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 0.3 })
		I[17] = new("Sound", I[14], "CashSound", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 0.3 })
		I[18] = new("Sound", I[14], "PurchaseClickSound", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 0.3 })
		I[19] = new("Sound", I[14], "PurchasedSound", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 0.3 })
		I[20] = new("Sound", I[14], "UpgradeSound", { RollOffMode = Enum.RollOffMode.InverseTapered })
		I[21] = new("Sound", I[14], "FireworkSound", { RollOffMode = Enum.RollOffMode.InverseTapered })
		I[22] = new("Sound", I[14], "Wheel", { Volume = 0.7 })
		I[23] = new("Sound", I[14], "PlaceError", { RollOffMode = Enum.RollOffMode.InverseTapered })
		I[24] = new("Sound", I[14], "RobuxSound", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 0.3 })
		I[25] = new("Sound", I[14], "RobuxSound2", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 0.3 })
		I[26] = new("Sound", I[14], "HoverSound", { RollOffMode = Enum.RollOffMode.InverseTapered })
		I[27] = new("Sound", I[14], "UI_3_Clicks_02_Hover", { Volume = 2 })
		I[28] = new("Sound", I[14], "ui-pop-sound-316482", { PlaybackSpeed = 1.4, Volume = 0.2 })
		I[29] = new("Sound", I[14], "ClickUI", { Volume = 0.2 })
		I[30] = new("Sound", I[14], "Ui-click2")
		I[31] = new("Sound", I[14], "axe swing")
		I[32] = new("Sound", I[14], "treehit")
		I[33] = new("Sound", I[14], "ClaimBrainrotSound")
		I[34] = new("Sound", I[14], "PromptSound")
		I[35] = new("Sound", I[14], "SpawnBoardSound")
	return { I[1], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14] }
end

return build
