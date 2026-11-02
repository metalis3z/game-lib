local TurkeyEvent = {}

local NotificationService = require(script.Parent.Parent.Parent.NotificationService)

function TurkeyEvent.OnStart()
	
	for _, player in game:GetService("Players"):GetPlayers() do
		NotificationService.Notify(player, "A Turkey has spawned in the map!", 10, "Sounds.Sfx.Success")
	end
	
	local TurkeyModel = script.GobblinoModel:Clone()
	TurkeyModel.Parent = workspace
end

function TurkeyEvent.OnStop()
	if workspace:FindFirstChild("GobblinoModel") and workspace:FindFirstChild("GobblinoModel"):IsA("Folder") then
		workspace:FindFirstChild("GobblinoModel"):Destroy()
	end
end

return TurkeyEvent