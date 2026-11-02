--!native
local skip = {}
local ServerScriptService = game:GetService("ServerScriptService")
local AnimalService = require(ServerScriptService.Services.AnimalService)

function skip.OnStart()
	AnimalService.SetAprilFoolsMode(true)
end

function skip.OnStop()
	AnimalService.SetAprilFoolsMode(false)
end

return skip