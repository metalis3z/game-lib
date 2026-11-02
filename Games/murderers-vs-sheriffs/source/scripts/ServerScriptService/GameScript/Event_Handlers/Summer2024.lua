local module = {}
local DataModule = require(script.Parent.Parent.DataModule)
local DataTable = DataModule.GetDataTable()
local EventInfoService = require(game.ReplicatedStorage.SharedServices.EventInfoService)

module.intializeEventToDataTable = function(Player)
	local CurrentEvent = EventInfoService.GetCurrentEvent().Title

	if CurrentEvent then
		if not DataTable[Player.Name][CurrentEvent] then
			DataTable[Player.Name][CurrentEvent] = {}
			for i, v in pairs(EventInfoService.GetCurrentEvent().ProfileData) do
				DataTable[Player.Name][CurrentEvent][i] = v
			end
		end
	end
end

return module