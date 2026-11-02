-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    Data = {
        Duration = 10, 
        MaxLevel = 1, 
        Description = "Inverts your controls."
    }
};
local function v8(v1) --[[ Line: 10 ]] --[[ Name: invert ]]
    if game["Run Service"]:IsClient() then
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        local l_PlayerScripts_0 = l_LocalPlayer_0:WaitForChild("PlayerScripts");
        local l_Controls_0 = require(l_PlayerScripts_0:WaitForChild("PlayerModule")):GetControls();
        if v1 then
            l_Controls_0.moveFunction = function(v5, v6, v7) --[[ Line: 18 ]]
                -- upvalues: l_LocalPlayer_0 (copy)
                l_LocalPlayer_0.Move(v5, -v6, v7);
            end;
            return;
        else
            l_Controls_0.moveFunction = l_LocalPlayer_0.Move;
        end;
    end;
end;
v0.Applied = function(_) --[[ Line: 27 ]] --[[ Name: Applied ]]
    -- upvalues: v8 (copy)
    v8(true);
end;
v0.Removed = function(_) --[[ Line: 31 ]] --[[ Name: Removed ]]
    -- upvalues: v8 (copy)
    v8(false);
end;
return v0;