-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = require(script.Parent.Parent.Utility);
local v1 = {
    Data = {}
};
v1.Data.Segments = {
    "SelectPlayer", 
    "FireButton"
};
v1.Fire = function() --[[ Line: 8 ]]
    -- upvalues: v0 (copy)
    local l_v0_PlayersFromSelection_0 = v0:GetPlayersFromSelection();
    v0:Fire({
        Players = l_v0_PlayersFromSelection_0
    });
end;
return v1;