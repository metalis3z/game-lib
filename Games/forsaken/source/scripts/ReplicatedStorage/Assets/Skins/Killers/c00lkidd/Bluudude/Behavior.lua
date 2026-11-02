-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    OnExecution = function(_, v1, v2) --[[ Line: 3 ]] --[[ Name: OnExecution ]]
        local v3 = require(game.ReplicatedStorage.Modules.Ragdolls);
        task.delay(2.1, function() --[[ Line: 10 ]]
            -- upvalues: v3 (copy), v2 (copy), v1 (copy)
            v3.AddProfile(v2, {
                AnchorDelay = true, 
                Velocity = (v1.Rig.PrimaryPart.CFrame * CFrame.new(5, 0.5, 1)).LookVector.Unit * 200, 
                Applied = os.clock() + 10
            });
            local l_Humanoid_0 = v2:FindFirstChild("Humanoid");
            if l_Humanoid_0 then
                l_Humanoid_0.BreakJointsOnDeath = false;
                l_Humanoid_0.Health = 0;
            end;
            task.wait(1.4);
            v2.PrimaryPart.Anchored = false;
        end);
    end
};