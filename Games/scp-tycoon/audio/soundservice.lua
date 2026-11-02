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
	I[1] = new("SoundGroup", nil, "Footsteps", { Volume = 1 })
		I[2] = new("Sound", I[1], "Marble", { Looped = true, PlaybackSpeed = 1.65, RollOffMinDistance = 100, Volume = 0.3 })
		I[3] = new("Sound", I[1], "Air", { Looped = true, RollOffMinDistance = 100, Volume = 0.6 })
		I[4] = new("Sound", I[1], "nil Sound", { Looped = true, RollOffMinDistance = 100, Volume = 0.6 })
		I[5] = new("Sound", I[1], "WoodPlanks", { Looped = true, RollOffMinDistance = 100, Volume = 0.35 })
		I[6] = new("Sound", I[1], "Wood", { Looped = true, RollOffMinDistance = 100, Volume = 0.35 })
		I[7] = new("Sound", I[1], "Mud", { Looped = true, PlaybackSpeed = 1.25, RollOffMinDistance = 100, Volume = 2 })
		I[8] = new("Sound", I[1], "SmoothPlastic", { Looped = true, PlaybackSpeed = 1.7, RollOffMinDistance = 100, Volume = 0.6 })
		I[9] = new("Sound", I[1], "Asphalt", { Looped = true, RollOffMinDistance = 100, Volume = 0.35 })
		I[10] = new("Sound", I[1], "Limestone", { Looped = true, RollOffMinDistance = 100, Volume = 0.35 })
		I[11] = new("Sound", I[1], "Sandstone", { Looped = true, PlaybackSpeed = 1.25, RollOffMinDistance = 100, Volume = 0.35 })
		I[12] = new("Sound", I[1], "Ground", { Looped = true, RollOffMinDistance = 100, Volume = 2 })
		I[13] = new("Sound", I[1], "Sand", { Looped = true, PlaybackSpeed = 2.5, RollOffMinDistance = 100, Volume = 0.6 })
		I[14] = new("Sound", I[1], "Snow", { Looped = true, PlaybackSpeed = 2.5, RollOffMinDistance = 100, Volume = 0.6 })
		I[15] = new("Sound", I[1], "Slate", { Looped = true, RollOffMinDistance = 100, Volume = 0.35 })
		I[16] = new("Sound", I[1], "Plastic", { Looped = true, PlaybackSpeed = 1.7, RollOffMinDistance = 100, Volume = 0.6 })
		I[17] = new("Sound", I[1], "Neon", { Looped = true, PlaybackSpeed = 1.7, RollOffMinDistance = 100, Volume = 0.6 })
		I[18] = new("Sound", I[1], "Pebble", { Looped = true, PlaybackSpeed = 1.75, RollOffMinDistance = 100, Volume = 0.35 })
		I[19] = new("Sound", I[1], "Metal", { Looped = true, PlaybackSpeed = 1.5, RollOffMinDistance = 100, Volume = 0.35 })
		I[20] = new("Sound", I[1], "Cobblestone", { Looped = true, RollOffMinDistance = 100, Volume = 0.35 })
		I[21] = new("Sound", I[1], "Foil", { Looped = true, PlaybackSpeed = 1.75, RollOffMinDistance = 100, Volume = 0.6 })
		I[22] = new("Sound", I[1], "Granite", { Looped = true, RollOffMinDistance = 100, Volume = 0.35 })
		I[23] = new("Sound", I[1], "Concrete", { Looped = true, PlaybackSpeed = 1.25, RollOffMinDistance = 100, Volume = 0.35 })
		I[24] = new("Sound", I[1], "Pavement", { Looped = true, PlaybackSpeed = 1.25, RollOffMinDistance = 100, Volume = 0.35 })
		I[25] = new("Sound", I[1], "CorrodedMetal", { Looped = true, PlaybackSpeed = 1.5, RollOffMinDistance = 100, Volume = 0.6 })
		I[26] = new("Sound", I[1], "DiamondPlate", { Looped = true, PlaybackSpeed = 1.5, RollOffMinDistance = 100, Volume = 0.35 })
		I[27] = new("Sound", I[1], "Fabric", { Looped = true, PlaybackSpeed = 1.2, RollOffMinDistance = 100, Volume = 0.25 })
		I[28] = new("Sound", I[1], "CrackedLava", { Looped = true, RollOffMinDistance = 100, Volume = 0.6 })
		I[29] = new("Sound", I[1], "ForceField", { Looped = true, PlaybackSpeed = 1.75, RollOffMinDistance = 100, Volume = 0.6 })
		I[30] = new("Sound", I[1], "Glass", { Looped = true, PlaybackSpeed = 1.4, RollOffMinDistance = 100, Volume = 0.6 })
		I[31] = new("Sound", I[1], "Brick", { Looped = true, PlaybackSpeed = 1.25, RollOffMinDistance = 100, Volume = 0.35 })
		I[32] = new("Sound", I[1], "Grass", { Looped = true, RollOffMinDistance = 100, Volume = 2 })
		I[33] = new("Sound", I[1], "Ice", { Looped = true, RollOffMinDistance = 100, Volume = 0.6 })
		I[34] = new("Sound", I[1], "Glacier", { Looped = true, RollOffMinDistance = 100, Volume = 0.6 })
		I[35] = new("Sound", I[1], "Basalt", { Looped = true, PlaybackSpeed = 1.25, RollOffMinDistance = 100, Volume = 0.35 })
		I[36] = new("Sound", I[1], "LeafyGrass", { Looped = true, RollOffMinDistance = 100, Volume = 2 })
		I[37] = new("Sound", I[1], "Salt", { Looped = true, PlaybackSpeed = 2.5, RollOffMinDistance = 100, Volume = 0.6 })
		I[38] = new("Sound", I[1], "Rock", { Looped = true, RollOffMinDistance = 100, Volume = 0.35 })
	return I[1]
end

return build
