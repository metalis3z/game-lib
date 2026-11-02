local PlayerData = require('@game/ServerStorage/Modules/General/PlayerData');

return function(Context, Player: Player, Coins: number): ()	
	local Data = PlayerData.GetPlayerData(Player[1]);
	Data.Data.Stats.FazCoins += Coins

	return `Gave {Player[1]} {Coins} FazCoins !`
end