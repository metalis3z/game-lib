-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Behavior, time of decompilation: Fri Nov 28 21:09:24 2025 ]]
local _ = require(game.ReplicatedStorage.GlobalTypes);
return {
    ChargeStart = function(v1) --[[ Line: 5 ]] --[[ Name: ChargeStart ]]
        local l_Rig_0 = v1.Rig;
        if l_Rig_0 and l_Rig_0.Parent then
            local l_BattleRam_0 = l_Rig_0:FindFirstChild("BattleRam");
            if not l_BattleRam_0 then
                return;
            else
                l_BattleRam_0.Transparency = 0;
            end;
        end;
    end, 
    ChargeEnd = function(v4) --[[ Line: 15 ]] --[[ Name: ChargeEnd ]]
        local l_Rig_1 = v4.Rig;
        if l_Rig_1 and l_Rig_1.Parent then
            local l_BattleRam_1 = l_Rig_1:FindFirstChild("BattleRam");
            if not l_BattleRam_1 then
                return;
            else
                l_BattleRam_1.Transparency = 1;
            end;
        end;
    end
};