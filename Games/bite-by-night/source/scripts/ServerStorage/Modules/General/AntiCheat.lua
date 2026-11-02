local AntiCheat = {}

-- <- Services -> --
local Players = game:GetService('Players');

-- <- Private Variables -> --
local ExpireAfter = 15

local FlagData = {
	MaxFlags = 5,
	Players = {},
	DefaultData = {
		Flags = 0,
		LastFlagTime = 0,
		LastFlagReason = ''
	}
}

-- <- Private Functions -> --
local function RegisterPlayer(Player: Player): ()
	if FlagData.Players[Player] then
		return
	end
	
	FlagData.Players[Player] = FlagData.DefaultData
end

local function GetPlayerData(Player: Player): {}
	local PlayerFlagData = FlagData.Players[Player]
	if not PlayerFlagData then
		RegisterPlayer(Player);
	end
	
	return PlayerFlagData and PlayerFlagData or FlagData.Players[Player]
end

-- <- Public Functions -> --
function AntiCheat.FlagPlayer(Player: Player, Reason: string): ()
	local PlayerFlagData = GetPlayerData(Player);
	local TimePastSinceLastFlag = PlayerFlagData.LastFlagTime - workspace:GetServerTimeNow()
	if TimePastSinceLastFlag < 1 and PlayerFlagData.Flags > 1 and PlayerFlagData.LastFlagReason == Reason then
		warn(`Player {Player} was going to get mass flagged. Removed the other flags and made it 1. (Reason: {Reason})`);
		
		return
	end
	
	PlayerFlagData.Flags += 1
	PlayerFlagData.LastFlagTime = workspace:GetServerTimeNow();
	PlayerFlagData.LastFlagReason = Reason and Reason or 'None'
	
	FlagData.Players[Player] = PlayerFlagData -- // It just applies the changes btw
end

function AntiCheat.__PlayerAdded(Player: Player): ()
	RegisterPlayer(Player);
end

-- <- Return -> --
return AntiCheat 