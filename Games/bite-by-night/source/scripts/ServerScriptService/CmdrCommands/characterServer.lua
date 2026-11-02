local CharacterManager = require('@game/ServerStorage/Modules//Managers/CharacterManager');
local PlayerData = require('@game/ServerStorage/Modules/General/PlayerData');

return function(Context, Player: Player, Team: string, Character: string): ()	
    local Skin = 'Normal'	
	local Data = PlayerData.GetPlayerData(Player[1]);
	local EquippedSkin = Data.Data.EquippedSkins[Character]
	if EquippedSkin then		
		Skin = EquippedSkin
	end
	
	local PlayerMeta = CharacterManager.Players[Player[1]]
	if not PlayerMeta then
		return
	end
	
	PlayerMeta:ForceCharacter(Team, Character, Skin);
	
	return 'Ok meow :3'
end