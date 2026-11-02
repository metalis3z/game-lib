-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
        local l_Character_0 = game.Players.LocalPlayer.Character;
        if not l_Character_0 then
            return;
        else
            local v2 = require(game.ReplicatedStorage.Modules.Sounds);
            local function _(v3) --[[ Line: 12 ]] --[[ Name: toggleLobbyTheme ]]
                -- upvalues: v2 (copy)
                if v3 == "Spectating" then
                    v2:PlayTheme("lobby", {
                        Priority = 1
                    });
                    return;
                else
                    v2:StopTheme("lobby");
                    return;
                end;
            end;
            if tostring(l_Character_0.Parent) == "Spectating" then
                v2:PlayTheme("lobby", {
                    Priority = 1
                });
            else
                v2:StopTheme("lobby");
            end;
            l_Character_0:GetPropertyChangedSignal("Parent"):Connect(function() --[[ Line: 22 ]]
                -- upvalues: l_Character_0 (copy), v2 (copy)
                if tostring(l_Character_0.Parent) == "Spectating" then
                    v2:PlayTheme("lobby", {
                        Priority = 1
                    });
                    return;
                else
                    v2:StopTheme("lobby");
                    return;
                end;
            end);
            return;
        end;
    end
};