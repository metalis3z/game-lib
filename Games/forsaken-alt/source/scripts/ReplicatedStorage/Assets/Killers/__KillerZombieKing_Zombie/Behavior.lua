-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Modules.Util);
local v2 = require(game.ReplicatedStorage.Modules.Sounds);
local v3 = require(game.ReplicatedStorage.Modules.Hitboxes);
local _ = require(game.ReplicatedStorage.Modules.Statuses);
v0.Abilities = {
    Slash = {
        LayoutOrder = 1, 
        Icon = "rbxassetid://93874368032471", 
        KeybindType = "MainAbility", 
        Callback = function(v5) --[[ Line: 14 ]] --[[ Name: Callback ]]
            -- upvalues: v2 (copy), v3 (copy), v1 (copy)
            if game["Run Service"]:IsServer() then
                v5.AbilitiesDisabled = true;
                v2:Play(v5.Config.Sounds.Swing, {
                    Parent = v5.Rig.PrimaryPart, 
                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                    Volume = 0.25
                });
                task.delay(0.1, function() --[[ Line: 21 ]]
                    -- upvalues: v3 (ref), v5 (copy), v1 (ref), v2 (ref)
                    local _ = v3:CreateHitbox(v5.Player, {
                        Size = Vector3.new(4.5, 6, 3.5, 0), 
                        CFrameOffset = CFrame.new(0, 0, -1.5), 
                        Damage = v5.Config.SlashDamage, 
                        Time = 0.3, 
                        Knockback = 2, 
                        HitMultiple = false, 
                        Connections = {
                            Hit = function(v6, v7) --[[ Line: 32 ]] --[[ Name: Hit ]]
                                -- upvalues: v1 (ref), v2 (ref), v5 (ref)
                                v1:CreateSpeedMultiplier(v6, 1.5, "HitSpeedBonus", 1.25);
                                v2:Play(v7 and v5.Config.Sounds.Hit, {
                                    Parent = v5.Rig.PrimaryPart, 
                                    PlaybackSpeed = Random.new():NextNumber(0.975, 1.025), 
                                    Volume = 0.25
                                });
                            end
                        }
                    });
                end);
                task.delay(0.75, function() --[[ Line: 41 ]]
                    -- upvalues: v5 (copy)
                    v5.AbilitiesDisabled = false;
                end);
                return;
            else
                if game["Run Service"]:IsClient() then
                    v5.Animations.Slash:Play(0.025);
                end;
                return;
            end;
        end
    }
};
v0.GetRig = function(_, v10) --[[ Line: 55 ]] --[[ Name: GetRig ]]
    local v11 = require(game.ReplicatedStorage.Modules.Actors);
    local l_Player_0 = v10.Player;
    if l_Player_0 then
        local v13 = nil;
        local v14 = nil;
        local l_v11_EquippedActorInfo_0, v16 = v11:GetEquippedActorInfo(l_Player_0, "Survivor");
        if l_v11_EquippedActorInfo_0 then
            local l_FirstChild_0 = game.ReplicatedStorage.Assets.Survivors:FindFirstChild(l_v11_EquippedActorInfo_0);
            v14 = l_FirstChild_0 and require(l_FirstChild_0.Config);
            v13 = v14 and v14.Rig;
        end;
        if v16 then
            local l_FirstChild_1 = game.ReplicatedStorage.Assets.Skins.Survivors:FindFirstChild(l_v11_EquippedActorInfo_0);
            local v19 = l_FirstChild_1 and l_FirstChild_1:FindFirstChild(v16);
            local v20 = v19 and require(v19.Config);
            if v20 then
                v14 = v20;
                v13 = v20.Rig or v13;
            end;
        end;
        if v13 then
            v13 = v13:Clone();
            local l_BodyColors_0 = v13:FindFirstChildOfClass("BodyColors");
            if l_BodyColors_0 then
                l_BodyColors_0:Destroy();
            end;
            for _, v23 in pairs(v13:GetDescendants()) do
                if v23:IsA("BasePart") then
                    local _, v25, v26 = v23.Color:ToHSV();
                    v23.Color = Color3.fromHSV(0.275, v25 / 2, v26 / 1.25);
                elseif v23:IsA("Shirt") or v23:IsA("Pants") or v23:IsA("ShirtGraphic") then
                    v23.Color3 = Color3.new(0.5, 0.65, 0.5);
                elseif v23:IsA("SpecialMesh") then
                    v23.VertexColor = Vector3.new(0.5, 0.6499999761581421, 0.5, 0);
                end;
            end;
            local v27 = v14 and v14.Expressions and v14.Expressions.Dead or "rbxassetid://11474467887";
            v10.Config.Expressions = {
                Default = v27
            };
        end;
        return v13;
    else
        return;
    end;
end;
v0.Created = function(_, v29) --[[ Line: 118 ]] --[[ Name: Created ]]
    if game["Run Service"]:IsClient() then
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        if v29.Rig ~= l_LocalPlayer_0.Character then
            return;
        else
            local v31 = tick();
            local v32 = require(game.ReplicatedStorage.Modules.Actors);
            local function _() --[[ Line: 127 ]] --[[ Name: actorLoaded ]]
                -- upvalues: v32 (copy), l_LocalPlayer_0 (copy)
                return v32.CurrentActors[l_LocalPlayer_0] and v32.CurrentActors[l_LocalPlayer_0].Animations;
            end;
            if not (v32.CurrentActors[l_LocalPlayer_0] and v32.CurrentActors[l_LocalPlayer_0].Animations) then
                repeat
                    task.wait();
                until v32.CurrentActors[l_LocalPlayer_0] and v32.CurrentActors[l_LocalPlayer_0].Animations or tick() >= v31 + 3;
            end;
            if not (v32.CurrentActors[l_LocalPlayer_0] and v32.CurrentActors[l_LocalPlayer_0].Animations) then
                return;
            else
                local v34 = nil;
                local l_HumanoidRootPart_0 = v29.Rig:WaitForChild("HumanoidRootPart");
                local l_Humanoid_0 = v29.Rig:WaitForChild("Humanoid");
                local v37 = RaycastParams.new();
                v37.FilterType = Enum.RaycastFilterType.Include;
                v37.FilterDescendantsInstances = {
                    workspace.Map.Ingame, 
                    workspace:FindFirstChild("StudioAssets")
                };
                local v38 = nil;
                do
                    local l_v34_0, l_v38_0 = v34, v38;
                    l_v38_0 = game["Run Service"].Heartbeat:Connect(function() --[[ Line: 146 ]]
                        -- upvalues: v29 (copy), l_v38_0 (ref), v32 (copy), l_LocalPlayer_0 (copy), l_HumanoidRootPart_0 (copy), l_Humanoid_0 (copy), l_v34_0 (ref), v37 (copy)
                        if not v29 or not v29.Rig or not v29.Rig.Parent or not v29.Rig:FindFirstChild("Humanoid") then
                            l_v38_0:Disconnect();
                            l_v38_0 = nil;
                            return;
                        else
                            local v41 = v32.CurrentActors[l_LocalPlayer_0] and v32.CurrentActors[l_LocalPlayer_0].Animations and v32.CurrentActors[l_LocalPlayer_0].Animations.Climb;
                            if not v41 then
                                return;
                            else
                                local v42 = l_HumanoidRootPart_0.CFrame:VectorToObjectSpace(l_Humanoid_0.MoveDirection);
                                local v43 = v42:Dot(Vector3.new(0, 0, -1, 0).Unit) > 0.6;
                                local v44 = v42:Dot(Vector3.new(0, 0, 1, 0).Unit) > 0.6;
                                local v45 = workspace:Raycast(l_HumanoidRootPart_0.Position - Vector3.new(0, l_v34_0 and 2 or 0, 0), l_HumanoidRootPart_0.CFrame.LookVector * 1.5, v37);
                                l_v34_0 = v45 and v45.Instance or nil;
                                if l_v34_0 and (l_Humanoid_0.FloorMaterial == Enum.Material.Air or v43) then
                                    l_Humanoid_0.AutoRotate = false;
                                    if v43 then
                                        v41:AdjustSpeed(1);
                                        l_HumanoidRootPart_0.Velocity = Vector3.new(-l_HumanoidRootPart_0.Velocity.X * 0.6, 9, -l_HumanoidRootPart_0.Velocity.Z * 0.6);
                                    elseif v44 then
                                        v41:AdjustSpeed(-1);
                                        l_HumanoidRootPart_0.Velocity = Vector3.new(-l_HumanoidRootPart_0.Velocity.X * 0.6, -7, -l_HumanoidRootPart_0.Velocity.Z * 0.6) + l_HumanoidRootPart_0.CFrame.LookVector;
                                    else
                                        v41:AdjustSpeed(0);
                                        l_HumanoidRootPart_0.Velocity = Vector3.new(0, 0, 0, 0);
                                    end;
                                    if l_Humanoid_0.FloorMaterial ~= Enum.Material.Air and v43 then
                                        l_HumanoidRootPart_0.Velocity = Vector3.new(l_HumanoidRootPart_0.Velocity.X, l_HumanoidRootPart_0.Velocity.Y + 8, l_HumanoidRootPart_0.Velocity.Z);
                                    end;
                                    if not v41.IsPlaying then
                                        v41:Play();
                                        return;
                                    end;
                                else
                                    l_Humanoid_0.AutoRotate = true;
                                    if v29.Rig.Humanoid:GetState() == Enum.HumanoidStateType.Climbing then
                                        v29.Rig.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false);
                                    end;
                                    v41:Stop();
                                end;
                                return;
                            end;
                        end;
                    end);
                end;
            end;
        end;
    end;
end;
return v0;