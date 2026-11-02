-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Name = "SetupGenerators", 
    Title = "Setup Generators", 
    Description = "Complete the puzzles on each generator to get them up & running. (<PROGRESS>/<REQUIREMENT>)", 
    RequiredProgress = 5, 
    Order = 1, 
    YieldUntilCompleted = true, 
    NoStatsAdded = true, 
	OnCreation = function(v0) --[[ Line: 12 ]] --[[ Name: OnCreation ]]
		warn(v0)
        for _ = 1, v0.RequiredProgress do
            local v2 = script.Generator:Clone();
            local v3 = v0.Map and v0.Map:FindFirstChild("GeneratorPositions") and v0.Map.GeneratorPositions:GetChildren();
            local v4 = v3 and v3[math.random(1, #v3)];
            if v2 and v4 then
                v2:SetPrimaryPartCFrame(v4.CFrame);
                v2.Parent = v0.Map;
                v4:Destroy();
                for _, v6 in pairs(v2.Scripts:GetChildren()) do
                    v6.Enabled = true;
                end;
                v2.Remotes.BE.Event:Connect(function(v7, v8) --[[ Line: 31 ]]
                    -- upvalues: v0 (copy)
                    require(game.ReplicatedStorage.Modules.Util):AddToPlayerStat(v7, "KillerChance", 0.5);
                    v0:RemoveTime(3.5);
                    if v8 >= 100 then
                        v0:AddProgress(v7);
                    end;
                end);
                v2.Destroying:Connect(function() --[[ Line: 45 ]]
                    -- upvalues: v0 (copy)
                    v0:AddProgress();
                end);
            else
                v0:AddProgress();
            end;
        end;
        local v9 = v0.Map and v0.Map:FindFirstChild("GeneratorPositions") and v0.Map.GeneratorPositions:GetChildren();
        local l_pairs_0 = pairs;
        local v11 = v9 or {};
        for _, v13 in l_pairs_0(v11) do
            v13:Destroy();
        end;
    end, 
    OnProgression = function(_) --[[ Line: 59 ]] --[[ Name: OnProgression ]]

    end, 
    OnCompletion = function(v15) --[[ Line: 64 ]] --[[ Name: OnCompletion ]]
        task.delay(5, function() --[[ Line: 66 ]]
            -- upvalues: v15 (copy)
            v15:Destroy();
        end);
    end
};