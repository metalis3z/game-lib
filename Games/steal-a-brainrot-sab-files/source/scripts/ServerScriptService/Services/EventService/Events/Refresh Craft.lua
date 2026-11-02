local ServerScriptService = game:GetService("ServerScriptService")
local CraftingMachineService = require(ServerScriptService.Services.CraftingMachineService)
local NotificationService = require(ServerScriptService.Services.NotificationService)

local refresh = {}

local cyberCraftName = '<font color="#79dbff"><b>Cyber Craft</b></font>'

function refresh.OnStart()
	local success, err = pcall(function()
		CraftingMachineService:RefreshCraft(true)
	end)

	if not success then 
		warn("Failed to refresh craft on start:", err)
	else
		NotificationService.Broadcast("ADMIN HARDER refreshed the " .. cyberCraftName, 5, "Sounds.Sfx.Success")
	end
end

function refresh.OnStop()
end

return refresh