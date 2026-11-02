-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    OnExecution = function(_, v1, v2) --[[ Line: 3 ]] --[[ Name: OnExecution ]]
        local v3 = (v1.Rig.PrimaryPart.CFrame * CFrame.new(5, 0.5, 1)).LookVector.Unit * 200;
        local v4 = workspace:GetServerTimeNow() + 3.5;
        require(game.ReplicatedStorage.Modules.Network):FireAllClientConnection("Ragdoll", "REMOTE_EVENT", v2, v4, (("%*|%*|%*"):format(v3.X, v3.Y, v3.Z)));
        task.delay(2.1, function() --[[ Line: 13 ]]
            -- upvalues: v2 (copy)
            local l_Humanoid_0 = v2:FindFirstChild("Humanoid");
            if l_Humanoid_0 then
                l_Humanoid_0.BreakJointsOnDeath = false;
                l_Humanoid_0.Health = 0;
            end;
        end);
    end
};