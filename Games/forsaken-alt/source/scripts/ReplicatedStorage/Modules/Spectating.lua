-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    CurrentIndx = 1, 
    Spectating = false
};
v0.Toggle = function(_, v2) --[[ Line: 8 ]] --[[ Name: Toggle ]]
    -- upvalues: v0 (copy)
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local l_Character_0 = l_LocalPlayer_0.Character;
    local v5 = l_Character_0 and l_Character_0:FindFirstChild("Humanoid");
    local l_Spectate_0 = require(game.ReplicatedStorage.Initializer).PlayerSystems.SidebarHandler.Sidebar.Buttons.Spectate;
    if not v5 then
        return;
    else
        if l_LocalPlayer_0.Character.Parent ~= workspace.Players.Spectating then
            v2 = false;
        end;
        v0.UI.Visible = v2;
        workspace.CurrentCamera.CameraSubject = v5;
        game.TweenService:Create(l_Spectate_0.Inverted, TweenInfo.new(0.25), {
            ImageTransparency = v2 and 0 or 1
        }):Play();
        game.TweenService:Create(l_Spectate_0.InvertedIcon, TweenInfo.new(0.25), {
            ImageTransparency = v2 and 0 or 1
        }):Play();
        game.TweenService:Create(l_Spectate_0.PulloutHolder.PulloutFrame.Inverted, TweenInfo.new(0.25), {
            ImageTransparency = v2 and 0 or 1
        }):Play();
        game.TweenService:Create(l_Spectate_0.PulloutHolder.PulloutFrame.Title, TweenInfo.new(0.25), {
            TextColor3 = v2 and Color3.new() or Color3.new(1, 1, 1)
        }):Play();
        v0.Spectating = v2;
        return;
    end;
end;
v0.Start = function(_) --[[ Line: 38 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    if game["Run Service"]:IsClient() then
        local l_LocalPlayer_1 = game.Players.LocalPlayer;
        v0.UI = script.Spectate:Clone();
        v0.UI.Visible = false;
        v0.UI.Parent = l_LocalPlayer_1.PlayerGui:WaitForChild("MainUI");
        local v9 = nil;
        do
            local l_v9_0 = v9;
            local function _(v11) --[[ Line: 47 ]] --[[ Name: setHealthConnection ]]
                -- upvalues: l_v9_0 (ref), v0 (ref)
                if l_v9_0 then
                    l_v9_0:Disconnect();
                end;
                l_v9_0 = v11:GetPropertyChangedSignal("Health"):Connect(function() --[[ Line: 49 ]]
                    -- upvalues: v11 (copy), v0 (ref)
                    local v12 = v11.Health / v11.MaxHealth;
                    v0.UI.Health.Text = ("%*%%"):format((math.round(v12 * 100)));
                    v0.UI.Health.TextColor3 = Color3.fromHSV(v12 / 3, 1, 1);
                end);
            end;
            local function v31(v14) --[[ Line: 57 ]] --[[ Name: adjustSpectatorIndex ]]
                -- upvalues: l_LocalPlayer_1 (copy), v0 (ref), l_v9_0 (ref)
                if l_LocalPlayer_1.Character.Parent ~= workspace.Players.Spectating then
                    return;
                else
                    local l_v0_0 = v0;
                    l_v0_0.CurrentIndx = l_v0_0.CurrentIndx + v14;
                    l_v0_0 = {};
                    local function _(v16) --[[ Line: 66 ]] --[[ Name: addToSpectatorTable ]]
                        -- upvalues: l_v0_0 (copy)
                        local l_Humanoid_0 = v16:FindFirstChild("Humanoid");
                        if l_Humanoid_0 and l_Humanoid_0.Health > 0 then
                            table.insert(l_v0_0, v16);
                        end;
                    end;
                    for _, v20 in pairs(workspace.Players.Killers:GetChildren()) do
                        local l_Humanoid_1 = v20:FindFirstChild("Humanoid");
                        if l_Humanoid_1 and l_Humanoid_1.Health > 0 then
                            table.insert(l_v0_0, v20);
                        end;
                    end;
                    for _, v23 in pairs(workspace.Players.Survivors:GetChildren()) do
                        local l_Humanoid_2 = v23:FindFirstChild("Humanoid");
                        if l_Humanoid_2 and l_Humanoid_2.Health > 0 then
                            table.insert(l_v0_0, v23);
                        end;
                    end;
                    local v25 = l_v0_0[v0.CurrentIndx % #l_v0_0 + 1];
                    local v26 = v25 and v25:FindFirstChild("Humanoid");
                    if v26 then
                        if l_v9_0 then
                            l_v9_0:Disconnect();
                        end;
                        l_v9_0 = v26:GetPropertyChangedSignal("Health"):Connect(function() --[[ Line: 49 ]]
                            -- upvalues: v26 (copy), v0 (ref)
                            local v27 = v26.Health / v26.MaxHealth;
                            v0.UI.Health.Text = ("%*%%"):format((math.round(v27 * 100)));
                            v0.UI.Health.TextColor3 = Color3.fromHSV(v27 / 3, 1, 1);
                        end);
                        local v28 = v25:GetAttribute("Username") or v25.Name;
                        local v29 = v25:GetAttribute("Username") and v25.Name or "";
                        local v30 = v26.Health / v26.MaxHealth;
                        v0.UI.Username.Text = v28;
                        v0.UI.ActorName.Text = v29;
                        v0.UI.Health.Text = ("%*%%"):format((math.round(v30 * 100)));
                        v0.UI.Health.TextColor3 = Color3.fromHSV(v30 / 3, 1, 1);
                        workspace.CurrentCamera.CameraSubject = v26;
                    end;
                    return;
                end;
            end;
            for v32, v33 in pairs({
                v0.UI.Next, 
                v0.UI.Back
            }) do
                local v34 = require(game.ReplicatedStorage.Modules.Sounds);
                v33.MouseButton1Click:Connect(function() --[[ Line: 100 ]]
                    -- upvalues: v34 (copy), v31 (copy), v32 (copy)
                    v34:Play("click");
                    v31(v32 == 1 and 1 or -1);
                end);
                v33.MouseEnter:Connect(function() --[[ Line: 105 ]]
                    -- upvalues: v34 (copy), v33 (copy)
                    v34:Play("tick");
                    game.TweenService:Create(v33, TweenInfo.new(0.2), {
                        Size = UDim2.fromScale(0.25, 1.05)
                    }):Play();
                end);
                v33.MouseLeave:Connect(function() --[[ Line: 110 ]]
                    -- upvalues: v34 (copy), v33 (copy)
                    v34:Play("tick");
                    game.TweenService:Create(v33, TweenInfo.new(0.2), {
                        Size = UDim2.fromScale(0.2, 1)
                    }):Play();
                end);
            end;
            local v35 = require(game.ReplicatedStorage.Systems.Player.UI.SidebarHandler);
            v35.Sidebar.Buttons.Spectate.Button.MouseButton1Click:Connect(function() --[[ Line: 122 ]]
                -- upvalues: v35 (copy), v0 (ref)
                if v35.MenusHidden then
                    return;
                else
                    require(game.ReplicatedStorage.Modules.Sounds):Play("select");
                    v0:Toggle(not v0.Spectating);
                    return;
                end;
            end);
        end;
    end;
end;
return v0;