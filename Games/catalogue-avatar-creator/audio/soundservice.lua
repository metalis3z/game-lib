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
	I[2] = new("SoundGroup", nil, "UI")
	I[3] = new("SoundGroup", nil, "Music", { Volume = 0.35 })
	I[4] = new("SoundGroup", nil, "SFX")
	I[5] = new("Sound", nil, "LoFi Study Calm", { Playing = true, TimePosition = 28.501, Volume = 0.35 })
	I[5].SoundGroup = I[3]
	return { I[1], I[2], I[3], I[4], I[5] }
end

return build
