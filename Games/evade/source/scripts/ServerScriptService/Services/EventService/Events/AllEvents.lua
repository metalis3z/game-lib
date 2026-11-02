local All = {}
local EventService = require(game.ServerScriptService.Services.EventService)

local duration = 300

local function isPrivateServer()
	return game.PrivateServerId ~= "" and game.PrivateServerOwnerId ~= 0
end

function All.OnStart()
	if not isPrivateServer() then
		return
	end

	for _, eventModule in pairs(game.ServerScriptService.Services.EventService.Events:GetChildren()) do
		if eventModule:IsA("ModuleScript") then
			EventService:ExecuteEvent(eventModule.Name, duration)
		end
	end
end


function All.OnStop()
	for _, eventModule in pairs(game.ServerScriptService.Services.EventService.Events:GetChildren()) do
		if eventModule:IsA("ModuleScript") then
			EventService:CancelEvent(eventModule.Name, duration)
		end
	end
end

return All
