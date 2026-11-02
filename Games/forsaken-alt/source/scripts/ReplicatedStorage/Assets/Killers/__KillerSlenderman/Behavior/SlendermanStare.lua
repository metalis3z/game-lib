-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Type = "Client", 
    Start = function(_, v1) --[[ Line: 9 ]] --[[ Name: Start ]]
        local l_Modules_0 = require(game.ReplicatedStorage.Initializer).Modules;
        local l_Network_0 = l_Modules_0.Network;
        local l_Util_0 = l_Modules_0.Util;
        local l_Sounds_0 = l_Modules_0.Sounds;
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        local l_Character_0 = l_LocalPlayer_0.Character;
        local l_Rig_0 = v1.Rig;
        local l_SFX_0 = script.Parent.SFX;
        local function _() --[[ Line: 23 ]] --[[ Name: getDistance ]]
            -- upvalues: l_Rig_0 (copy), l_Character_0 (copy)
            if l_Rig_0.PrimaryPart and l_Character_0.PrimaryPart then
                return (l_Rig_0.PrimaryPart.Position - l_Character_0.PrimaryPart.Position).Magnitude;
            else
                return 150;
            end;
        end;
        local function _() --[[ Line: 31 ]] --[[ Name: playerIsAlive ]]
            -- upvalues: l_Character_0 (copy)
            local v11 = l_Character_0.Parent == workspace.Players.Survivors;
            local l_Humanoid_0 = l_Character_0:FindFirstChild("Humanoid");
            local v13 = l_Humanoid_0 and l_Character_0.Humanoid.Health > 0;
            return v11 and l_Humanoid_0 and v13;
        end;
        l_Network_0:SetConnection("IsOnScreen", "REMOTE_EVENT", function() --[[ Line: 39 ]]
            -- upvalues: l_Character_0 (copy), l_Util_0 (copy), l_Rig_0 (copy)
            local v15 = l_Character_0.Parent == workspace.Players.Survivors;
            local l_Humanoid_1 = l_Character_0:FindFirstChild("Humanoid");
            local v17 = l_Humanoid_1 and l_Character_0.Humanoid.Health > 0;
            if not (v15 and l_Humanoid_1 and v17) then
                return;
            else
                return l_Util_0:IsOnScreen(l_Rig_0) and l_Character_0.Parent;
            end;
        end);
        l_Network_0:SetConnection("SlendermanTeleported", "REMOTE_EVENT", function() --[[ Line: 45 ]]
            -- upvalues: l_Character_0 (copy), l_Rig_0 (copy)
            local v18 = l_Character_0.Parent == workspace.Players.Survivors;
            local l_Humanoid_2 = l_Character_0:FindFirstChild("Humanoid");
            local v20 = l_Humanoid_2 and l_Character_0.Humanoid.Health > 0;
            if not (v18 and l_Humanoid_2 and v20) then
                return;
            else
                l_Rig_0:SetAttribute("SeenBefore", nil);
                return;
            end;
        end);
        l_Character_0:SetAttribute("Static", 0);
        l_Character_0:SetAttribute("StaticResistance", 100);
        local v21 = {};
        local function v24(v22) --[[ Line: 54 ]] --[[ Name: addDeadPixel ]]
            -- upvalues: l_LocalPlayer_0 (copy), v21 (copy)
            local l_Frame_0 = Instance.new("Frame");
            l_Frame_0.Name = "DeadPixel";
            l_Frame_0.Size = UDim2.fromOffset(1, 3);
            l_Frame_0.BorderSizePixel = 0;
            l_Frame_0.BackgroundTransparency = 0.6;
            l_Frame_0.Parent = l_LocalPlayer_0.PlayerGui:WaitForChild("TemporaryUI");
            l_Frame_0.Position = UDim2.fromScale(math.random(1, 999) / 1000, math.random(1, 999) / 1000);
            l_Frame_0:SetAttribute("Pos", l_Frame_0.Position);
            table.insert(v21, l_Frame_0);
            if v22 then
                game.Debris:AddItem(l_Frame_0, math.random(5, 35));
            end;
        end;
        task.spawn(function() --[[ Line: 69 ]]
            -- upvalues: l_Character_0 (copy), v21 (copy), v24 (copy)
            while task.wait(0.04) do
                local v25 = l_Character_0.Parent == workspace.Players.Survivors;
                local l_Humanoid_3 = l_Character_0:FindFirstChild("Humanoid");
                local v27 = l_Humanoid_3 and l_Character_0.Humanoid.Health > 0;
                if v25 and l_Humanoid_3 and v27 then
                    if 95 - #v21 / 3 > l_Character_0:GetAttribute("StaticResistance") then
                        v24();
                    end;
                    for _, v29 in pairs(v21) do
                        v29.Position = v29:GetAttribute("Pos") + UDim2.new(0, math.random(-1, 1), 0, math.random(-1, 1));
                        v29.Size = UDim2.fromOffset(1, math.random(3, 4));
                        v29.BackgroundColor3 = Color3.new(math.random(0, 1), math.random(0, 1), math.random(0, 1));
                        if math.random(1, 400) == 1 then
                            v29.Position = UDim2.fromScale(math.random(1, 999) / 1000, math.random(1, 999) / 1000);
                            v29:SetAttribute("Pos", v29.Position);
                        end;
                    end;
                else
                    break;
                end;
            end;
        end);
        local v30 = tick();
        local function v45() --[[ Line: 87 ]] --[[ Name: functionality ]]
            -- upvalues: l_Character_0 (copy), l_Rig_0 (copy), l_Util_0 (copy), l_Network_0 (copy), v30 (ref), v24 (copy), l_SFX_0 (copy), l_Sounds_0 (copy)
            while task.wait(0.04) do
                local v31 = l_Character_0.Parent == workspace.Players.Survivors;
                local l_Humanoid_4 = l_Character_0:FindFirstChild("Humanoid");
                local v33 = l_Humanoid_4 and l_Character_0.Humanoid.Health > 0;
                if v31 and l_Humanoid_4 and v33 then
                    local v34 = false;
                    v31 = if l_Rig_0.PrimaryPart and l_Character_0.PrimaryPart then (l_Rig_0.PrimaryPart.Position - l_Character_0.PrimaryPart.Position).Magnitude else 150;
                    if l_Util_0:IsOnScreen(l_Rig_0) and v31 <= 150 then
                        v34 = true;
                        l_Character_0:SetAttribute("StaringAtSlender", true);
                        l_Humanoid_4 = l_Character_0:GetAttribute("Static");
                        v33 = l_Character_0:GetAttribute("StaticResistance");
                        local v35 = l_Humanoid_4 + 50 / v31;
                        local v36 = v33 - 3 / v31;
                        l_Character_0:SetAttribute("Static", (math.clamp(v35, 0, 125)));
                        l_Character_0:SetAttribute("StaticResistance", (math.clamp(v36, 0, 100)));
                        if v31 <= 60 then
                            if l_Rig_0.PrimaryPart and l_Character_0.PrimaryPart and l_Rig_0.PrimaryPart.Velocity.Magnitude <= 0.5 then
                                l_Rig_0:SetPrimaryPartCFrame(CFrame.new(l_Rig_0.PrimaryPart.Position, (Vector3.new(l_Character_0.PrimaryPart.Position.X, l_Rig_0.PrimaryPart.Position.Y, l_Character_0.PrimaryPart.Position.Z))));
                            end;
                            l_Network_0:FireServerConnection("LookingAtSlender", "UREMOTE_EVENT", true);
                            if l_Rig_0:GetAttribute("SeenBefore") ~= true then
                                local l_v35_0 = v35 --[[ copy: 4 -> 6 ]];
                                pcall(function() --[[ Line: 117 ]]
                                    -- upvalues: l_Rig_0 (ref), v31 (copy), v30 (ref), v24 (ref), l_Character_0 (ref), l_v35_0 (copy), l_SFX_0 (ref), l_Sounds_0 (ref)
                                    l_Rig_0:SetAttribute("SeenBefore", true);
                                    local v38 = v31 <= 25 and tick() - v30 > 20 and "heavy" or "medium";
                                    if v38 == "heavy" then
                                        for _ = 1, 30 do
                                            v24(true);
                                        end;
                                        l_Character_0:SetAttribute("Static", (math.clamp(l_v35_0 + 20, 0, 80)));
                                        workspace.CurrentCamera.CFrame = CFrame.lookAt(workspace.CurrentCamera.CFrame.Position, l_Rig_0.PrimaryPart.Position);
                                        workspace.CurrentCamera.FieldOfView = 30;
                                        game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(4), {
                                            FieldOfView = 70
                                        }):Play();
                                    end;
                                    local l_Children_0 = (l_SFX_0:FindFirstChild(v38) or l_SFX_0.medium):GetChildren();
                                    local v41 = l_Children_0[math.random(1, #l_Children_0)];
                                    l_Sounds_0:Play(v41, {
                                        Position = l_Rig_0.PrimaryPart.Position
                                    });
                                    v30 = tick();
                                end);
                            end;
                        elseif l_Rig_0:GetAttribute("SeenBefore") ~= true then
                            pcall(function() --[[ Line: 139 ]]
                                -- upvalues: l_Rig_0 (ref), l_SFX_0 (ref), l_Sounds_0 (ref), v30 (ref)
                                l_Rig_0:SetAttribute("SeenBefore", true);
                                local l_Children_1 = l_SFX_0.light:GetChildren();
                                local v43 = l_Children_1[math.random(1, #l_Children_1)];
                                l_Sounds_0:Play(v43, {
                                    Position = l_Rig_0.PrimaryPart.Position
                                });
                                v30 = tick();
                            end);
                        end;
                    end;
                    if not v34 then
                        l_Humanoid_4 = l_Character_0:GetAttribute("Static");
                        v33 = l_Character_0:GetAttribute("StaticResistance");
                        local v44 = l_Humanoid_4 - math.clamp(v31, 0, 30) / 75 / (100 / v33);
                        l_Character_0:SetAttribute("Static", (math.clamp(v44, 0, v33)));
                        l_Character_0:SetAttribute("StaringAtSlender", false);
                        if l_Character_0:GetAttribute("Static") > 0 then
                            l_Network_0:FireServerConnection("LookingAtSlender", "UREMOTE_EVENT");
                        end;
                    end;
                else
                    break;
                end;
            end;
        end;
        task.spawn(function() --[[ Line: 166 ]]
            -- upvalues: l_Character_0 (copy), v45 (copy)
            while task.wait(0.04) do
                local v46 = l_Character_0.Parent == workspace.Players.Survivors;
                local l_Humanoid_5 = l_Character_0:FindFirstChild("Humanoid");
                local v48 = l_Humanoid_5 and l_Character_0.Humanoid.Health > 0;
                if v46 and l_Humanoid_5 and v48 then
                    pcall(v45);
                else
                    break;
                end;
            end;
        end);
    end, 
    Destroy = function(_) --[[ Line: 173 ]] --[[ Name: Destroy ]]
        local l_Network_1 = require(game.ReplicatedStorage.Initializer).Modules.Network;
        l_Network_1:RemoveConnection("IsOnScreen");
        l_Network_1:RemoveConnection("SlendermanTeleported");
        l_Network_1:RemoveConnection("LookingAtSlender");
    end
};