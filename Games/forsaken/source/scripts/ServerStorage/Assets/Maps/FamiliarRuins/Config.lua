-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    DisplayName = "Familiar Ruins", 
    Description = "I have to ESCAPE this FLOOD!", 
    Render = "rbxassetid://108837894952360", 
    Ambience = {
        Normal = "rbxassetid://134031985009500", 
        Classic = "rbxassetid://134031985009500"
    }, 
    AmbienceProperties = {
        Volume = 1
    }, 
    Variants = {
        Normal = 20, 
        Classic = 80
    }, 
    Created = function(v0) --[[ Line: 25 ]] --[[ Name: Created ]]
        task.spawn(function() --[[ Line: 26 ]]
            -- upvalues: v0 (copy)
            local v1 = OverlapParams.new();
            v1.FilterDescendantsInstances = v0.Map.Lava:GetDescendants();
            v1.FilterType = Enum.RaycastFilterType.Exclude;
            local v2 = require(game.ReplicatedStorage.Modules.Util);
            while task.wait(0.15) and v0.Map.Parent do
                for _, v4 in pairs(v0.Map.Lava:GetChildren()) do
                    for _, v6 in (workspace:GetPartBoundsInBox(v4.CFrame, v4.Size, v1)) do
                        if v6.Name == "Trail" then
                            v1:AddToFilter(v6);
                        else
                            local l_Parent_0 = v6.Parent;
                            local v8 = l_Parent_0 and l_Parent_0:FindFirstChild("Humanoid");
                            local l_v2_EntityType_0 = v2:GetEntityType(l_Parent_0);
                            if v8 and l_v2_EntityType_0 then
                                require(game.ReplicatedStorage.Modules.Statuses):ApplyStatus(l_Parent_0, "Burning", {
                                    Level = 1, 
                                    Duration = 4
                                });
                            end;
                        end;
                    end;
                end;
            end;
        end);
        task.spawn(function() --[[ Line: 54 ]]
            -- upvalues: v0 (copy)
            local v10 = OverlapParams.new();
            v10.FilterDescendantsInstances = v0.Map.Water:GetDescendants();
            v10.FilterType = Enum.RaycastFilterType.Exclude;
            local v11 = require(game.ReplicatedStorage.Modules.Util);
            while task.wait(0.15) and v0.Map.Parent do
                for _, v13 in pairs(v0.Map.Water:GetChildren()) do
                    for _, v15 in (workspace:GetPartBoundsInBox(v13.CFrame, v13.Size, v10)) do
                        if v15.Name == "Trail" then
                            v10:AddToFilter(v15);
                        else
                            local l_Parent_1 = v15.Parent;
                            local v17 = l_Parent_1 and l_Parent_1:FindFirstChild("Humanoid");
                            local l_v11_EntityType_0 = v11:GetEntityType(l_Parent_1);
                            if v17 and l_v11_EntityType_0 then
                                require(game.ReplicatedStorage.Modules.Statuses):ApplyStatus(l_Parent_1, "Slowness", {
                                    Level = 2, 
                                    Duration = 2
                                });
                            end;
                        end;
                    end;
                end;
            end;
        end);
        task.spawn(function() --[[ Line: 82 ]]
            -- upvalues: v0 (copy)
            local l_Conveyors_0 = v0.Map.MapBoundaries.Conveyors;
            while task.wait(0.1) and l_Conveyors_0.Parent do
                for _, v21 in pairs(l_Conveyors_0:GetChildren()) do
                    v21.AssemblyLinearVelocity = v21.CFrame.LookVector * 20;
                end;
            end;
        end);
    end
};