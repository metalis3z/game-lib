-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        local v2 = require(game.ReplicatedStorage.Modules.Util);
        local v3 = {
            Stats = true, 
            Equipped = true, 
            Settings = true
        };
        v2.OnPlayerAdded(function(v4) --[[ Line: 18 ]]
            -- upvalues: l_LocalPlayer_0 (copy), v3 (copy)
            if l_LocalPlayer_0 ~= v4 then
                local v5 = v4:WaitForChild("PlayerData", 30);
                if v5 then
                    for _, v7 in pairs(v5:GetChildren()) do
                        if not v3[v7.Name] then
                            v7:Destroy();
                        end;
                    end;
                end;
            end;
        end);
    end
};