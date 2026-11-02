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
	I[1] = new("Sound", nil, "Boing")
	I[2] = new("Sound", nil, "Bomb")
	I[3] = new("Sound", nil, "Break")
	I[4] = new("Sound", nil, "Click")
	I[5] = new("Sound", nil, "Clock")
	I[6] = new("Sound", nil, "Slingshot")
	I[7] = new("Sound", nil, "Page")
	I[8] = new("Sound", nil, "Ping")
	I[9] = new("Sound", nil, "Snap")
	I[10] = new("Sound", nil, "Splat")
	I[11] = new("Sound", nil, "Step")
	I[12] = new("Sound", nil, "StepOn")
	I[13] = new("Sound", nil, "Swoosh")
	I[14] = new("Sound", nil, "Victory")
	return { I[1], I[2], I[3], I[4], I[5], I[6], I[7], I[8], I[9], I[10], I[11], I[12], I[13], I[14] }
end

return build
