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
	I[1] = new("Folder", nil, "Main")
		I[2] = new("Folder", I[1], "Interface")
			I[3] = new("Sound", I[2], "Confirm")
			I[4] = new("Sound", I[2], "LoadingSound")
			I[5] = new("Sound", I[2], "UiEnter")
			I[6] = new("Sound", I[2], "Notification")
			I[7] = new("Sound", I[2], "UiClick")
			I[8] = new("Sound", I[2], "Error")
		I[9] = new("Folder", I[1], "Music")
			I[10] = new("Sound", I[9], "Song3", { Looped = true, Playing = true, Volume = 0.185 })
	return I[1]
end

return build
