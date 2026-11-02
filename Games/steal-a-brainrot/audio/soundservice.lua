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
	I[1] = new("Sound", nil, "Spinning", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 1 }, { ["ViralWorkerRef"] = "vw_acb38ba84b" })
	I[2] = new("AudioDeviceOutput", nil, "AudioDeviceOutput", nil, { ["ViralWorkerRef"] = "vw_814676f03b" })
	I[3] = new("SoundGroup", nil, "Cutscene", nil, { ["ViralWorkerRef"] = "vw_ab473a01d1" })
		I[4] = new("SoundGroup", I[3], "WorkspaceSounds", { Volume = 1 }, { ["ViralWorkerRef"] = "vw_cacbf744fb" })
			I[5] = new("SoundGroup", I[4], "KarkerMusic", { Volume = 1 }, { ["ViralWorkerRef"] = "vw_142b1051ee" })
			I[6] = new("SoundGroup", I[4], "EventMusic", { Volume = 1 }, { ["ViralWorkerRef"] = "vw_0ac546bdda" })
	I[7] = new("SoundGroup", nil, "Sound Effects", { Volume = 1 }, { ["ViralWorkerRef"] = "vw_e84cde8f56" })
	I[8] = new("SoundGroup", nil, "ToolsSounds", { Volume = 1 }, { ["ViralWorkerRef"] = "vw_c3d36b91e9" })
		I[9] = new("Folder", I[8], "UI", nil, { ["ViralWorkerRef"] = "vw_4e5a4f4ece" })
			I[10] = new("Sound", I[9], "FreezeRayWrong", { RollOffMode = Enum.RollOffMode.InverseTapered }, { ["ViralWorkerRef"] = "vw_3c0b34adf5" })
			I[11] = new("Sound", I[9], "FreezeRayShow", { RollOffMode = Enum.RollOffMode.InverseTapered }, { ["ViralWorkerRef"] = "vw_f1384580c7" })
			I[12] = new("Sound", I[9], "FreezeRaySuccess", { RollOffMode = Enum.RollOffMode.InverseTapered }, { ["ViralWorkerRef"] = "vw_18ecfe6493" })
	return { I[1], I[2], I[3], I[7], I[8] }
end

return build
