-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = require(script.Parent.Parent.Utility);
local l_BanPlayer_0 = script.Parent.Parent.Parent.Main.Frames.BanPlayer;
local v2 = {
    Data = {}
};
v2.Data.Segments = {
    "SelectPlayer", 
    "FireButton"
};
v2.Data.Description = "Ban a player. Length in days.";
v2.Fire = function() --[[ Line: 12 ]]
    -- upvalues: v0 (copy), l_BanPlayer_0 (copy)
    local l_v0_PlayersFromSelection_0 = v0:GetPlayersFromSelection();
    if not next(l_v0_PlayersFromSelection_0) then
        l_v0_PlayersFromSelection_0 = tostring(script.Parent.Parent.Parent.Main.Segments.SelectPlayer.Parameter.Text);
    end;
    local l_Text_0 = l_BanPlayer_0.Reason.Text;
    local l_Text_1 = l_BanPlayer_0.InternalReason.Text;
    local v6 = tonumber(l_BanPlayer_0.Length.Text);
    v0:Fire({
        Players = l_v0_PlayersFromSelection_0, 
        Reason = l_Text_0, 
        Length = v6, 
        InternalReason = l_Text_1
    });
end;
return v2;