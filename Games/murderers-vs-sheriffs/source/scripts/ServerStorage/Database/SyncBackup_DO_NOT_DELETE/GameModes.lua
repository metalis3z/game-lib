local TestPlace = game.GameId == 124354393621591;
local workspace_Attribute = workspace:GetAttribute("CurrentEventEnding");
local Halloween = false;
if workspace:GetAttribute("CurrentEvent") == "Halloween" then
	Halloween = not workspace_Attribute;
end;
local GameModes = {
    Standard = {
        DisplayName = "Standard", 
        Image = "rbxassetid://14148051887", 
		PlaceID = require(game.ReplicatedStorage.Constants).Places.Standard, 
		TestID = 124354393621591, 
        Popular = true, 
        PlayerCount = 0, 
        Description = {
			"\226\128\162 Standard" .. require(game.ReplicatedStorage.Constants).Short .. "Gamemode", 
            "\226\128\162 All cosmetics and avatars enabled", 
            "\226\128\162 Full XP and coins"
        }, 
        Order = 10
    }, 
    Disguises = {
        DisplayName = "Disguises", 
        Image = "rbxassetid://14156478096", 
		PlaceID = require(game.ReplicatedStorage.Constants).Places.Disguises, 
        TestID = 0, 
        PlayerCount = 0, 
        Description = {
			"\226\128\162 Standard" .. require(game.ReplicatedStorage.Constants).Short .. "Gamemode", 
            "\226\128\162 Player avatars are disguised", 
            "\226\128\162 Some cosmetics are disabled", 
            "\226\128\162 Full XP and coins"
        }, 
		Order = 20;
    }, 
    Assassin = {
        DisplayName = "Assassin", 
        Image = "rbxassetid://14167876198", 
		PlaceID = require(game.ReplicatedStorage.Constants).Places.Assasin, 
        TestID = 0, 
        PlayerCount = 0, 
        Description = {
            "\226\128\162 Custom game mode", 
            "\226\128\162 All players get a knife, hunt down your target", 
            "\226\128\162 Alternate XP, full Coins", 
            "\226\128\162 All cosmetics and avatars enabled"
        }, 
		Order = 30;
    }, 
    VampireHunt = {
        DisplayName = "Vampire Hunt", 
        Image = "rbxassetid://117092830478669", 
        PlaceID = 0, 
        TestID = 0, 
        LimitedTime = true, 
        PlayerCount = 0, 
        Description = {
            "\226\128\162 24 player servers", 
            "\226\128\162 Teams of 3 vampires and 3 hunters", 
            "\226\128\162 Vampires get custom perk", 
            "\226\128\162 Full XP and coins"
        }, 
        Order = 40, 
        Hidden = true
    }
};
if Halloween then
	GameModes.VampireHunt.Hidden = false;
end;
if TestPlace then
	for _, DataGamemode in GameModes do
		DataGamemode.PlaceID = DataGamemode.TestID;
    end;
end;
local function isGameMode(GamemodeName)
	if not GameModes[GamemodeName] then
        return;
    else
		return game.PlaceId == GameModes[GamemodeName].PlaceID;
    end;
end;
return GameModes;