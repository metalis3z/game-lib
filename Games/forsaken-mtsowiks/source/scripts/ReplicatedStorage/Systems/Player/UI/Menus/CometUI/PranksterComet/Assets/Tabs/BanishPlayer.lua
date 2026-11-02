-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = require(script.Parent.Parent.Utility);
local l_BanishPlayer_0 = script.Parent.Parent.Parent.Main.Frames.BanishPlayer;
local v2 = {
    Data = {}
};
v2.Data.Segments = {
    "SelectPlayer", 
    "FireButton"
};
v2.Data.Description = "Sends a player to another game.";
v2.Fire = function() --[[ Line: 12 ]]
    -- upvalues: v0 (copy), l_BanishPlayer_0 (copy)
    local l_v0_PlayersFromSelection_0 = v0:GetPlayersFromSelection();
    local l_Text_0 = l_BanishPlayer_0.TextBox.Text;
    v0:Fire({
        Players = l_v0_PlayersFromSelection_0, 
        GameID = l_Text_0
    });
end;
return v2;