-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Modules.Util);
return {
    DisplayName = "Classic Battlegrounds", 
    Description = "seranok notice me please", 
    Render = "rbxassetid://128356189504959", 
    Ambience = "rbxassetid://115972944595764", 
    AmbienceProperties = {
        Volume = 0.5
    }, 
    Created = function(v2) --[[ Line: 23 ]] --[[ Name: Created ]]
        -- upvalues: v1 (copy)
        local l_Map_0 = v2.Map;
        task.spawn(function() --[[ Line: 28 ]]
            -- upvalues: v2 (copy), v1 (ref)
            local v4 = OverlapParams.new();
            v4.FilterDescendantsInstances = v2.Map.mapmodel.Water:GetDescendants();
            v4.FilterType = Enum.RaycastFilterType.Exclude;
            while task.wait(0.15) and v2.Map.Parent do
                for _, v6 in pairs(v2.Map.mapmodel.Water:GetChildren()) do
                    for _, v8 in (workspace:GetPartBoundsInBox(v6.CFrame, v6.Size, v4)) do
                        if v8.Name == "Trail" then
                            v4:AddToFilter(v8);
                        else
                            local l_Parent_0 = v8.Parent;
                            local v10 = l_Parent_0 and l_Parent_0:FindFirstChild("Humanoid");
                            local l_v1_EntityType_0 = v1:GetEntityType(l_Parent_0);
                            if v10 and l_v1_EntityType_0 then
                                require(game.ReplicatedStorage.Modules.Statuses):ApplyStatus(l_Parent_0, "Poisoned", {
                                    Level = 1, 
                                    Duration = 5
                                });
                            end;
                        end;
                    end;
                end;
            end;
        end);
        task.spawn(function() --[[ Line: 55 ]]
            -- upvalues: v2 (copy)
            local l_Conveyors_0 = v2.Map.MapBoundaries.Conveyors;
            while task.wait(0.1) and l_Conveyors_0.Parent do
                for _, v14 in pairs(l_Conveyors_0:GetChildren()) do
                    v14.AssemblyLinearVelocity = v14.CFrame.LookVector * 25;
                end;
            end;
        end);
        task.spawn(function() --[[ Line: 66 ]]
            -- upvalues: l_Map_0 (copy), v1 (ref)
            local l_TeleportStart_0 = l_Map_0.Teleport.TeleportStart;
            local l_TeleportEnd_0 = l_Map_0.Teleport.TeleportEnd;
            local function v26(v17) --[[ Line: 70 ]] --[[ Name: __createNewTeleportConnection ]]
                -- upvalues: l_TeleportEnd_0 (copy), v1 (ref)
                assert(typeof(v17) == "Instance", "bad teleportPart");
                local l_l_TeleportEnd_0_FirstChild_0 = l_TeleportEnd_0:FindFirstChild(v17.Name);
                if not l_l_TeleportEnd_0_FirstChild_0 then
                    return;
                else
                    local v19 = false;
                    v1:ApplyUnsafeTouched(v17, false, function(_, v21) --[[ Line: 79 ]]
                        -- upvalues: v19 (ref), l_l_TeleportEnd_0_FirstChild_0 (copy)
                        if v19 then
                            return;
                        else
                            v19 = true;
                            if not (game.Players:GetPlayerFromCharacter(v21.Parent) ~= nil) then
                                v19 = false;
                                return;
                            else
                                local l_PrimaryPart_0 = v21.Parent.PrimaryPart;
                                if not l_PrimaryPart_0 then
                                    v19 = false;
                                    return;
                                else
                                    l_PrimaryPart_0:PivotTo(l_l_TeleportEnd_0_FirstChild_0.CFrame + Vector3.new(0, 5, 0, 0));
                                    l_l_TeleportEnd_0_FirstChild_0.Smoke:Play();
                                    l_l_TeleportEnd_0_FirstChild_0.Glitch:Play();
                                    task.spawn(function() --[[ Line: 104 ]]
                                        -- upvalues: l_l_TeleportEnd_0_FirstChild_0 (ref)
                                        local l_PointLight_0 = Instance.new("PointLight");
                                        l_PointLight_0.Color = Color3.fromRGB(255, 0, 0);
                                        l_PointLight_0.Brightness = 15;
                                        l_PointLight_0.Range = 18;
                                        l_PointLight_0.Parent = l_l_TeleportEnd_0_FirstChild_0;
                                        task.wait(2.5);
                                        l_PointLight_0:Destroy();
                                    end);
                                    for _, v25 in (l_l_TeleportEnd_0_FirstChild_0.Particles:GetDescendants()) do
                                        if v25:IsA("ParticleEmitter") then
                                            v25:Emit(v25.Name == "Number" and 30 or 2);
                                        end;
                                    end;
                                    v19 = false;
                                    return;
                                end;
                            end;
                        end;
                    end);
                    return;
                end;
            end;
            for _, v28 in (l_TeleportStart_0:GetChildren()) do
                v26(v28);
            end;
        end);
    end
};