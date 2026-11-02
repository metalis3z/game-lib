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
	I[1] = new("AudioDeviceOutput", nil, "AudioDeviceOutput", nil, { ["_lemonadeUniqueId"] = "VCQ3yutDVCQ3" })
	I[2] = new("SoundGroup", nil, "Cutscene", nil, { ["_lemonadeUniqueId"] = "pCJqrNXhpCJq" })
		I[3] = new("SoundGroup", I[2], "WorkspaceSounds", { Volume = 1 }, { ["_lemonadeUniqueId"] = "y4cQNv1fy4cQ" })
			I[4] = new("SoundGroup", I[3], "KarkerMusic", { Volume = 1 }, { ["_lemonadeUniqueId"] = "lh0cxG6elh0c" })
			I[5] = new("SoundGroup", I[3], "EventMusic", { Volume = 1 }, { ["_lemonadeUniqueId"] = "hzxdnM3Vhzxd" })
	I[6] = new("SoundGroup", nil, "Sound Effects", { Volume = 1 }, { ["_lemonadeUniqueId"] = "rrCgR3NJrrCg" })
	I[7] = new("SoundGroup", nil, "ToolsSounds", { Volume = 1 }, { ["_lemonadeUniqueId"] = "YWAL2FdTYWAL" })
		I[8] = new("Folder", I[7], "UI", nil, { ["_lemonadeUniqueId"] = "boeSsH9RboeS" })
			I[9] = new("Sound", I[8], "FreezeRayWrong", { RollOffMode = Enum.RollOffMode.InverseTapered }, { ["_lemonadeUniqueId"] = "6Vxg7oJp6Vxg" })
			I[10] = new("Sound", I[8], "FreezeRayShow", { RollOffMode = Enum.RollOffMode.InverseTapered }, { ["_lemonadeUniqueId"] = "aciu16qMaciu" })
			I[11] = new("Sound", I[8], "FreezeRaySuccess", { RollOffMode = Enum.RollOffMode.InverseTapered }, { ["_lemonadeUniqueId"] = "Ee1SiRBREe1S" })
		I[12] = new("Folder", I[7], "Laser Gun", nil, { ["_lemonadeUniqueId"] = "Zrtsn1kwZrts" })
	I[13] = new("SoundGroup", nil, "EventMusic", nil, { ["_lemonadeUniqueId"] = "iFITKC5ZiFIT" })
	I[14] = new("SoundGroup", nil, "WorkspaceSounds", { Volume = 0.2 }, { ["_lemonadeUniqueId"] = "vZgAYByavZgA" })
	return { I[1], I[2], I[6], I[7], I[13], I[14] }
end

return build
