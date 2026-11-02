--credit to leon games studio
return {
	Name = "syncdevproducts",
	Description = "Sync developer products to Roblox via Open Cloud and store mapping in DataStore",
	Group = "DefaultAdmin",
	Aliases = { "syncdevproducts" },
	Args = {
		{
			Type = "string",
			Name = "PlaceId",
			Description = "Place id, \"dev\", or \"prod\" \226\128\148 must be in the universe this server is running in (cross-universe sync is not allowed)"
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