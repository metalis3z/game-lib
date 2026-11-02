--credit to quartz games studio
return {
	Name = "givepettool",
	Description = "Gives a pet to a player (via GameServerAPI.AddPet)",
	Group = "DefaultAdmin",
	Aliases = { "givepettool" },
	Args = {
		{
			Type = "players",
			Name = "Players",
			Description = "The player(s) to give the pet to"
		},
		{
			Type = "pet",
			Name = "PetName",
			Description = "The name of the pet (must match PetModules.<Name>)"
		},
		{
			Type = "positiveInteger",
			Name = "Amount",
			Description = "How many of the pet to give (default 1)",
			Optional = true
		}
	},
	ClientRun = function(context, players, petName, amount)
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local event = ReplicatedStorage:WaitForChild("CmdrGivePet", 10)
		if not event then
			return "CmdrGivePet remote not found (server handler missing)."
		end
		amount = amount or 1
		event:FireServer(players, petName, amount)
		local who = {}
		for _, plr in ipairs(players) do
			table.insert(who, plr.Name)
		end
		return ("Gave %d x %s to %s"):format(amount, tostring(petName), table.concat(who, ", "))
	end
}
