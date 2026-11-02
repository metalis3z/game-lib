
local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Datas.Mutations)
local v3 = {
	{
		["Price"] = 25,
		["Zone"] = "Spawn",
		["IslandIcon"] = "rbxassetid://77579120948430",
		["JumpIcon"] = "rbxassetid://77579120948430"
	},
	{
		["Price"] = 50,
		["Zone"] = "Normal",
		["IslandIcon"] = v2.Rainbow.Icon,
		["JumpIcon"] = "rbxassetid://77579120948430"
	},
	{
		["Price"] = 100,
		["Zone"] = "Candy",
		["IslandIcon"] = v2.Candy.Icon,
		["JumpIcon"] = "rbxassetid://77579120948430"
	},
	{
		["Price"] = 250,
		["Zone"] = "Lava",
		["IslandIcon"] = v2.Lava.Icon,
		["JumpIcon"] = "rbxassetid://77579120948430"
	},
	{
		["Price"] = 500,
		["Zone"] = "Galaxy",
		["IslandIcon"] = v2.Galaxy.Icon,
		["JumpIcon"] = "rbxassetid://77579120948430"
	},
	{
		["Price"] = 750,
		["Zone"] = "Divine",
		["IslandIcon"] = v2.Divine.Icon,
		["JumpIcon"] = "rbxassetid://77579120948430"
	}
}
return table.freeze(v3)