-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 5 ]] --[[ Name: Start ]]
        local v1 = require(game.ReplicatedStorage.Modules.Util);
        local v2 = require(game.ReplicatedStorage.Modules.Network);
        v2:SetConnection("RevealPlayerAura", "REMOTE_EVENT", function(...) --[[ Line: 12 ]]
            -- upvalues: v1 (copy)
            v1:RevealPlayerAura(...);
        end);
        v2:SetConnection("RemovePlayerAura", "REMOTE_EVENT", function(...) --[[ Line: 16 ]]
            -- upvalues: v1 (copy)
            v1:RemovePlayerAuraFrom(...);
        end);
        v2:SetConnection("DisplayBubble", "REMOTE_EVENT", function(...) --[[ Line: 20 ]]
            -- upvalues: v1 (copy)
            v1:DisplayBubble(...);
        end);
    end
};