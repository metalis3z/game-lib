-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = require(script.Parent.Parent.Utility);
local l_FlingPlayer_0 = script.Parent.Parent.Parent.Main.Frames.FlingPlayer;
local v2 = {
    Data = {}
};
v2.Data.Segments = {
    "SelectPlayer", 
    "FireButton"
};
v2.Data.Description = "High values may trip the anticheat.";
v2.Fire = function() --[[ Line: 12 ]]
    -- upvalues: v0 (copy), l_FlingPlayer_0 (copy)
    local l_v0_PlayersFromSelection_0 = v0:GetPlayersFromSelection();
    local v4 = v0:ToVector3(l_FlingPlayer_0.TextBox.Text);
    if v4 then
        v0:Fire({
            Players = l_v0_PlayersFromSelection_0, 
            Vector = v4
        });
    end;
end;
return v2;