-- GameplayUtility (shared) requires ServerStorage.Services.FFlagService on the server; the flags
-- live in MiscService.

local ServerScriptService = game:GetService("ServerScriptService")

local MiscService = require(ServerScriptService:WaitForChild("Server"):WaitForChild("MiscService"))

local FFlagService = {}

function FFlagService.GetFFlag(_self, name: string)
	return MiscService.FFlags[name]
end

return FFlagService
