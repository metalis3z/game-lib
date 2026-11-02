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
	I[2] = new("SoundGroup", nil, "EmoteVolume", { Volume = 1 })
	I[3] = new("SoundGroup", nil, "MusicVolume", { Volume = 1 })
	I[4] = new("SoundGroup", nil, "UIVolume", { Volume = 1 })
	I[5] = new("SoundGroup", nil, "Volume", { Volume = 1 })
	return { I[1], I[2], I[3], I[4], I[5] }
end

return build
