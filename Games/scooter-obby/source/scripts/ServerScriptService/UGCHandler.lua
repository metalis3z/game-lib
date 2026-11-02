local ds2 = require(game.ReplicatedStorage.ModuleScripts.DataStore2)
ds2.Combine("DATA", "UGCs")
local rs = game:GetService("ReplicatedStorage")
local marketplaceService = game:GetService("MarketplaceService")

local module = {}

function module.GiveUGC(player, id)
	local rebirthStore = ds2("UGCs", player)
	local rebirths = rebirthStore:Get({})
	id = tonumber(id)
	if not table.find(rebirths, id) then
		table.insert(rebirths, id)
	end
	rebirthStore:Set(rebirths)
	game.ServerScriptService.WaitPrompt.Prompt:Fire(player, id)
	return 
end

function module.GetUGC(player)
	local rebirthStore = ds2("UGCs", player)
	local rebirths = rebirthStore:Get({})
	return rebirths
end

return module
