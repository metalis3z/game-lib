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
	I[1] = new("AudioDeviceOutput", nil, "AudioDeviceOutput")
	I[2] = new("SoundGroup", nil, "Cutscene")
		I[3] = new("SoundGroup", I[2], "WorkspaceSounds", { Volume = 1 })
			I[4] = new("SoundGroup", I[3], "KarkerMusic", { Volume = 1 })
			I[5] = new("SoundGroup", I[3], "EventMusic", { Volume = 1 })
	I[6] = new("SoundGroup", nil, "Sound Effects", { Volume = 1 })
	I[7] = new("SoundGroup", nil, "ToolsSounds", { Volume = 1 })
		I[8] = new("Folder", I[7], "UI")
			I[9] = new("Sound", I[8], "FreezeRayWrong", { RollOffMode = Enum.RollOffMode.InverseTapered })
			I[10] = new("Sound", I[8], "FreezeRayShow", { RollOffMode = Enum.RollOffMode.InverseTapered })
			I[11] = new("Sound", I[8], "FreezeRaySuccess", { RollOffMode = Enum.RollOffMode.InverseTapered })
		I[12] = new("Folder", I[7], "Laser Gun")
	return { I[1], I[2], I[6], I[7] }
end

return build
