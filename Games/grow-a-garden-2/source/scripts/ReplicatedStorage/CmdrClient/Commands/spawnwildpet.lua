--credit to prince games studio
return {
	Name = "spawnwildpet",
	Description = "Spawn a wild pet of the given species at a random valid spot inside workspace.Map.PetSpawn (or near you with `here`). For testing the SpawnPetService taming flow without waiting for the natural spawn loop.",
	Group = "DefaultAdmin",
	Aliases = { "spawnwildpet", "spawnpet" },
	Args = {
		{
			Type = "string",
			Name = "PetName",
			Description = "Pet species key from PetData (e.g. Raccoon)"
		},
		{
			Type = "positiveInteger",
			Name = "Count",
			Description = "How many to spawn (default 1)",
			Optional = true
		}
	}
,
	ClientRun = function(context, ...)
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local bridge = ReplicatedStorage:WaitForChild("AdminCommandBridge", 10)
		if not bridge then
			return "AdminCommandBridge remote not found."
		end
		return bridge:InvokeServer(context.Name or script.Name, {...})
	end
}