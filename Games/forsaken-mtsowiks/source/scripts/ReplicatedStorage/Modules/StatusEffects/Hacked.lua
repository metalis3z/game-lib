-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Hacked, time of decompilation: Fri Nov 28 21:06:19 2025 ]]
local v0 = require(game.ReplicatedStorage.Modules.Actors);
return {
    Data = {
        Duration = 5, 
        MaxLevel = 1, 
        Stackable = false, 
        Description = "Freezes all ability cooldowns, excluding your main Attack.\n Abilities already off cooldown will remain usable."
    }, 
    Applied = function(v1) --[[ Line: 12 ]] --[[ Name: Applied ]]
        -- upvalues: v0 (copy)
        v1.TimeActive = 0;
        if game["Run Service"]:IsServer() then
            local l_PlayerFromCharacter_0 = game.Players:GetPlayerFromCharacter(v1.Character);
            local v3 = l_PlayerFromCharacter_0 and v0.CurrentActors[l_PlayerFromCharacter_0];
            local v4 = v3 and v3.Behavior and v3.Behavior.Abilities;
            if not v4 then
                return;
            else
                for _, v6 in pairs(v4) do
                    if v6.KeybindType ~= "MainAbility" and v6.CurrentRechargeThread then
                        v6.ElapsedRecharge = tick() - v6.RechargeStartTime;
                        pcall(task.cancel, v6.CurrentRechargeThread);
                    end;
                end;
            end;
        end;
    end, 
    Heartbeat = function(v7, v8) --[[ Line: 34 ]] --[[ Name: Heartbeat ]]
        -- upvalues: v0 (copy)
        v7.TimeActive = v7.TimeActive + v8;
        if game["Run Service"]:IsServer() then
            local l_PlayerFromCharacter_1 = game.Players:GetPlayerFromCharacter(v7.Character);
            local v10 = l_PlayerFromCharacter_1 and v0.CurrentActors[l_PlayerFromCharacter_1];
            if not v10 or not v10.Cooldowns then
                return;
            else
                local l_Behavior_0 = v10.Behavior;
                local v12 = v10 and v10.Cooldowns;
                for v13, v14 in pairs(v12) do
                    local v15 = l_Behavior_0[v13];
                    if v15 and v15.KeybindType ~= "MainAbility" then
                        v12[v13] = v14 + v8;
                    end;
                end;
            end;
        end;
    end, 
    Removed = function(v16) --[[ Line: 54 ]] --[[ Name: Removed ]]
        -- upvalues: v0 (copy)
        if game["Run Service"]:IsServer() then
            local l_PlayerFromCharacter_2 = game.Players:GetPlayerFromCharacter(v16.Character);
            local v18 = l_PlayerFromCharacter_2 and v0.CurrentActors[l_PlayerFromCharacter_2];
            local v19 = v18 and v18.Behavior and v18.Behavior.Abilities;
            if not v19 then
                return;
            else
                for v20, v21 in pairs(v19) do
                    if v21.KeybindType ~= "MainAbility" and v21.ElapsedRecharge then
                        task.delay(v21.Recharge - v21.ElapsedRecharge, function() --[[ Line: 67 ]]
                            -- upvalues: v21 (copy), v18 (copy), v20 (copy)
                            v21.CurrentRechargeThread = nil;
                            v21.RechargeStartTime = nil;
                            v18:IncrementCharges(v20, 1, v21.Charges);
                        end);
                        v21.ElapsedRecharge = nil;
                    end;
                end;
            end;
        end;
    end
};