local PlayerDataModule = require('@game/ServerStorage/Modules/General/PlayerData');

return function(Context, Player: Player, Type: string, Character: string, Asset: string): ()
	Type = string.lower(Type);
	
	local PlayerData = PlayerDataModule.GetPlayerData(Player);
	if not PlayerData then
		return
	end
	
	if Type == 'skin' and not table.find(PlayerData.Data.OwnedSkins[Character], Asset) then
		table.insert(PlayerData.Data.OwnedSkins[Character], Asset);
	elseif Type == 'character' and not table.find(PlayerData.Data.OwnedChars, Character) then
		table.insert(PlayerData.Data.OwnedChars, Character);
	elseif Type == 'emote' and not table.find(PlayerData.Data.OwnedEmotes, Character) then
		table.insert(PlayerData.Data.OwnedEmotes, Character);
	end
end