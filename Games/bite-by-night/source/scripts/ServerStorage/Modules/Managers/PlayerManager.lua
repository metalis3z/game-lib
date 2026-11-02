local PlayerManager = {}

-- <- Services -> --
local ReplicatedStorage = game:GetService('ReplicatedStorage');
local Players = game:GetService('Players');

-- <- Modules -> --
local RankTranslation = require('@game/ReplicatedStorage/Modules/Misc/RankTranslations');
local BBNConfig = require('@game/ServerStorage/BBNConfig');

-- <- Private Functions -> --
local function CheckWhitelist(Player: Player): ()
	warn(`Whitelist state: {BBNConfig.IsWhitelistOn}`);
	
	if not BBNConfig.IsWhitelistOn then
		return
	end	
	
	if not table.find(BBNConfig.ManualRanks, Player.UserId) and Player:GetRankInGroupAsync(RankTranslation.GroupID) < 1 then
		Player:Kick('Whitelist is on !');
	end
	
	warn('Meow.');
end

-- <- Public Functions -> --
function PlayerManager.__PlayerAdded(Player: Player): ()
	CheckWhitelist(Player);
end

-- <- Return -> --
return PlayerManager