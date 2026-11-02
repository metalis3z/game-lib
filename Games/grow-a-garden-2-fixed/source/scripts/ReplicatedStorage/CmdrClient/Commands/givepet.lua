--credit to leon games studio
return {
	Name = "givepet",
	Description = "Adds a pet to a player's saved Pets data store",
	Group = "DefaultAdmin",
	Aliases = { "givepet" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give the pet to"
		},
		{
			Type = "pet",
			Name = "Name",
			Description = "Pet name / species (e.g. 'Raccoon')"
		},
		{
			Type = "string",
			Name = "Mutation",
			Description = "Pet mutation, or 'none' / blank for none",
			Optional = true
		},
		{
			Type = "boolean",
			Name = "Equipped",
			Description = "Whether the pet is equipped on grant (default false)",
			Optional = true
		},
		{
			Type = "string",
			Name = "Size",
			Description = "Pet size: 'Big' (2x), 'Huge' (4x), or blank/none for normal",
			Optional = true
		},
		{
			Type = "string",
			Name = "Type",
			Description = "Pet type: 'Rainbow', or blank/none for no type",
			Optional = true
		}
	},
	ClientRun = function(context, players, name, _mutation, _equipped, _size, _type)
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local event = ReplicatedStorage:WaitForChild("CmdrGivePet", 10)
		if not event then
			return "CmdrGivePet remote not found (server handler missing)."
		end
		event:FireServer(players, name, 1)
		local who = {}
		for _, plr in ipairs(players) do
			table.insert(who, plr.Name)
		end
		return ("Gave %s to %s"):format(tostring(name), table.concat(who, ", "))
	end
}
