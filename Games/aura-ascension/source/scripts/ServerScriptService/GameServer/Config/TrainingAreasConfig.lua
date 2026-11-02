local areas = {
	{
		Name = "Fire Bath",
		Requirement = 100000000,
		PassiveMultiplier = 320,
		Order = 1,
	},
	{
		Name = "Lava Heaven",
		Requirement = 1e12,
		PassiveMultiplier = 640,
		Order = 2,
	},
	{
		Name = "Dark Lava",
		Requirement = 1000000000000000,
		PassiveMultiplier = 1050,
		Order = 3,
	},
	{
		Name = "Stone Heads",
		Requirement = 1e18,
		PassiveMultiplier = 2200,
		Order = 4,
	},
	{
		Name = "Ancient Ruins",
		Requirement = 1e20,
		PassiveMultiplier = 3400,
		Order = 5,
	},
	{
		Name = "Electra Field",
		Requirement = 1e26,
		PassiveMultiplier = 9500,
		Order = 6,
	},
	{
		Name = "Divine Realm",
		Requirement = 1e30,
		PassiveMultiplier = 16000,
		Order = 7,
	},
	{
		Name = "Frostcore Shards",
		Requirement = 1e33,
		PassiveMultiplier = 20000,
		Order = 8,
	},
	{
		Name = "Frozen Artifact",
		Requirement = 1e35,
		PassiveMultiplier = 24000,
		Order = 9,
	},
	{
		Name = "Fallen Star",
		Requirement = 1e40,
		PassiveMultiplier = 40000,
		Order = 10,
	},
}

local lookup = {}
for _, area in ipairs(areas) do
	area.DisplayBoost = area.PassiveMultiplier
	area.AuraPerTick = area.PassiveMultiplier
	lookup[area.Name] = area
	for _, alias in ipairs(area.Aliases or {}) do
		lookup[alias] = area
	end
end

return {
	List = areas,
	ByName = lookup,
}