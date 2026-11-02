local PlayerDataModule = require('@game/ServerStorage/Modules/General/PlayerData');

return function(_, Players: {Players}, Amount: number)
	for _, Player in pairs(Players) do
		local PlayerData = PlayerDataModule.GetPlayerData(Player);
		if not PlayerData then
			return
		end
		
		PlayerData.Data.Stats.KillerChance += Amount -- // woo !
	end
	
	return `Yay, Added {Amount} malice to {#Players} players !`
end