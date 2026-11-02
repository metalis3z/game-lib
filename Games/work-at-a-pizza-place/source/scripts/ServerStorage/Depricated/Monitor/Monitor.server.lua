local admins = {"Player1","Dued1","Dert41","jack123","jelloman","billsayshowdy"}
local Monitor = require(script.Parent)

game.Players.PlayerAdded:connect(function(newPlayer)
	
	for _,name in ipairs(admins) do
		if name == newPlayer.Name then
			Monitor.new(newPlayer)
			break
		end
	end
end)