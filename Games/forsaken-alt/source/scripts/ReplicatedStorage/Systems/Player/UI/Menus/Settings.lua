-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.Start = function(_) --[[ Line: 3 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local l_Settings_0 = l_LocalPlayer_0:WaitForChild("PlayerData"):WaitForChild("Settings");
    local v4 = require(game.ReplicatedStorage.Initializer);
    v4.PlayerSettings = {};
    v0.SettingsMenu = v4.PlayerSystems.SidebarHandler:CreateSidebarMenu("Settings", script.SettingsScreen);
    local l_Contents_0 = v0.SettingsMenu.Menu.SettingsContainer.Contents;
    local l_Templates_0 = script.Templates;
    local function v7(v8, v9) --[[ Line: 23 ]] --[[ Name: createSettingsUI ]]
        -- upvalues: l_Templates_0 (copy), l_Contents_0 (copy), v7 (copy), l_Settings_0 (copy), l_LocalPlayer_0 (copy), v4 (copy)
        if not v9 then
            v9 = 0;
        end;
        local l_v8_Attribute_0 = v8:GetAttribute("LayoutOrder");
        local l_v8_Attribute_1 = v8:GetAttribute("DisplayTitle");
        local l_v8_Attribute_2 = v8:GetAttribute("DisplayDescription");
        local _ = v8:GetAttribute("PostDisplayTitle");
        if not l_v8_Attribute_0 or not l_v8_Attribute_1 then
            return;
        elseif v8:IsA("Folder") then
            local v14 = l_Templates_0.Seperator:Clone();
            v14.Name = v8.Name;
            v14.LayoutOrder = l_v8_Attribute_0 * 100 + v9;
            v14.Title.Text = l_v8_Attribute_1;
            v14.Parent = l_Contents_0;
            for _, v16 in pairs(v8:GetChildren()) do
                v7(v16, l_v8_Attribute_0 * 100);
            end;
            return;
        else
            if v8:IsA("ValueBase") then
                local l_l_Templates_0_FirstChild_0 = l_Templates_0:FindFirstChild(v8:GetAttribute("TemplateType") or string.gsub(v8.ClassName, "Value", ""));
                for _, v19 in pairs(l_Templates_0:GetChildren()) do
                    if v8.Parent.Name:find(v19.Name) then
                        l_l_Templates_0_FirstChild_0 = v19;
                    end;
                end;
                local v20 = l_l_Templates_0_FirstChild_0 and require(l_l_Templates_0_FirstChild_0);
                if v20 and v20.CreateSettingUI then
                    local l_v20_SettingUI_0 = v20:CreateSettingUI(v8);
                    l_v20_SettingUI_0.Instance.Name = v8.Name;
                    l_v20_SettingUI_0.Instance.LayoutOrder = l_v8_Attribute_0 + v9;
                    l_v20_SettingUI_0.Instance.Parent = l_Contents_0;
                    local l_v8_Attribute_4 = v8:GetAttribute("Requirement");
                    if l_v8_Attribute_4 then
                        local l_l_Settings_0_FirstChild_0 = l_Settings_0:FindFirstChild(l_v8_Attribute_4, true);
                        if l_l_Settings_0_FirstChild_0 then
                            local l_l_l_Settings_0_FirstChild_0_0 = l_l_Settings_0_FirstChild_0 --[[ copy: 10 -> 18 ]];
                            local function v25() --[[ Line: 67 ]] --[[ Name: updateSettingVisibility ]]
                                -- upvalues: l_v20_SettingUI_0 (copy), l_l_l_Settings_0_FirstChild_0_0 (copy)
                                l_v20_SettingUI_0.Instance.Visible = l_l_l_Settings_0_FirstChild_0_0.Value;
                            end;
                            l_v20_SettingUI_0.Instance.Visible = l_l_Settings_0_FirstChild_0.Value;
                            l_l_Settings_0_FirstChild_0:GetPropertyChangedSignal("Value"):Connect(v25);
                        elseif l_v8_Attribute_4 == "VIP" then
                            local function v26() --[[ Line: 73 ]] --[[ Name: updateSettingVisibility ]]
                                -- upvalues: l_v20_SettingUI_0 (copy), l_LocalPlayer_0 (ref)
                                l_v20_SettingUI_0.Instance.Visible = l_LocalPlayer_0:GetAttribute("VIP");
                            end;
                            l_v20_SettingUI_0.Instance.Visible = l_LocalPlayer_0:GetAttribute("VIP");
                            l_LocalPlayer_0:GetAttributeChangedSignal("VIP"):Connect(v26);
                        elseif tostring(l_v8_Attribute_4):find("Device") then
                            local v27 = require(game.ReplicatedStorage.Modules.Device);
                            local l_v27_0 = v27 --[[ copy: 11 -> 17 ]];
                            local function v29() --[[ Line: 80 ]] --[[ Name: updateSettingVisibility ]]
                                -- upvalues: l_v20_SettingUI_0 (copy), l_v27_0 (copy), l_v8_Attribute_4 (copy)
                                l_v20_SettingUI_0.Instance.Visible = ("Device=%*"):format((l_v27_0:GetPlayerDevice())) == l_v8_Attribute_4;
                            end;
                            l_v20_SettingUI_0.Instance.Visible = ("Device=%*"):format((v27:GetPlayerDevice())) == l_v8_Attribute_4;
                            v27.Changed:Connect(v29);
                        end;
                    end;
                    local v30 = require(game.ReplicatedStorage.Modules.Sounds);
                    local v31 = l_Templates_0.Reset:Clone();
                    v31.Parent = l_v20_SettingUI_0.Instance;
                    v31.MouseButton1Click:Connect(function() --[[ Line: 90 ]]
                        -- upvalues: v8 (copy), v30 (copy)
                        require(game.ReplicatedStorage.Modules.Network):FireServerConnection("UpdateSettings", "REMOTE_EVENT", v8);
                        v30:Play("switch");
                    end);
                    v31.MouseEnter:Connect(function() --[[ Line: 95 ]]
                        -- upvalues: v30 (copy)
                        v30:Play("hover");
                    end);
                    v31.MouseLeave:Connect(function() --[[ Line: 98 ]]
                        -- upvalues: v30 (copy)
                        v30:Play("hoverEnd");
                    end);
                    local l_FirstChild_0 = l_v20_SettingUI_0.Instance:FindFirstChild("SettingName", true);
                    local l_FirstChild_1 = l_v20_SettingUI_0.Instance:FindFirstChild("SettingDesc", true);
                    l_FirstChild_0.Text = l_v8_Attribute_1;
                    l_FirstChild_1.Text = l_v8_Attribute_2;
                    l_v20_SettingUI_0.__updatedEvent = Instance.new("BindableEvent");
                    l_v20_SettingUI_0.__updatedEvent.Parent = l_v20_SettingUI_0.Instance;
                    l_v20_SettingUI_0.Updated = l_v20_SettingUI_0.__updatedEvent.Event;
                    local l_FirstChild_2 = script.SettingConnections:FindFirstChild(v8.Name);
                    local v35 = l_FirstChild_2 and require(l_FirstChild_2);
                    if v35 then
                        l_v20_SettingUI_0.Updated:Connect(function() --[[ Line: 117 ]]
                            -- upvalues: v35 (copy), l_v20_SettingUI_0 (copy)
                            v35:Updated(l_v20_SettingUI_0.Value);
                        end);
                    end;
                    local function v36() --[[ Line: 123 ]] --[[ Name: updateSettingsUI ]]
                        -- upvalues: l_v20_SettingUI_0 (copy), v8 (copy)
                        l_v20_SettingUI_0.Value = v8.Value;
                        if l_v20_SettingUI_0.OnUpdate then
                            l_v20_SettingUI_0:OnUpdate();
                        end;
                        l_v20_SettingUI_0.__updatedEvent:Fire();
                    end;
                    l_v20_SettingUI_0.Value = v8.Value;
                    if l_v20_SettingUI_0.OnUpdate then
                        l_v20_SettingUI_0:OnUpdate();
                    end;
                    l_v20_SettingUI_0.__updatedEvent:Fire();
                    v8:GetPropertyChangedSignal("Value"):Connect(v36);
                    v4.PlayerSettings[v8.Name] = l_v20_SettingUI_0;
                    task.wait();
                end;
            end;
            return;
        end;
    end;
    task.spawn(function() --[[ Line: 146 ]]
        -- upvalues: l_Settings_0 (copy), v7 (copy)
        for _, v38 in pairs(l_Settings_0:GetChildren()) do
            v7(v38);
        end;
    end);
end;
return v0;