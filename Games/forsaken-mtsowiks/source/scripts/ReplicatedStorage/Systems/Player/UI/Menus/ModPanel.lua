-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.Start = function(_) --[[ Line: 3 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    local v2 = require(game.ReplicatedStorage.Initializer);
    local v3 = require(game.ReplicatedStorage.Modules.Network);
    v0.ModMenu = v2.PlayerSystems.SidebarHandler:CreateSidebarMenu("ModPanel", script.ModScreen);
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local l_Contents_0 = v0.ModMenu.Menu.ModContainer.Contents;
    local v6 = require(game.ReplicatedStorage.Modules.Schematics.GroupRankTranslations);
    local l_Templates_0 = game.ReplicatedStorage.Systems.Player.UI.Menus.Settings.Templates;
    local l_Templates_1 = script.Templates;
    task.spawn(function() --[[ Line: 21 ]]
        -- upvalues: l_LocalPlayer_0 (copy), v6 (copy), l_Templates_1 (copy), l_Contents_0 (copy), l_Templates_0 (copy), v3 (copy), v0 (ref)
        local v9 = workspace:GetAttribute("ServerOwnerID") == l_LocalPlayer_0.UserId;
        local v10 = 0;
        pcall(function() --[[ Line: 24 ]]
            -- upvalues: v10 (ref), l_LocalPlayer_0 (ref)
            v10 = l_LocalPlayer_0:GetAttribute("Rank") or 0
        end);
        if game["Run Service"]:IsStudio() and l_LocalPlayer_0.Name:sub(1, 6) == "Player" then
            v10 = 999;
            v9 = true;
        elseif workspace:GetAttribute("Testing") then
            v9 = true;
        end;
        local function v41(v11) --[[ Line: 35 ]] --[[ Name: createCommandUI ]]
            -- upvalues: v9 (ref), v6 (ref), v10 (ref), l_Templates_1 (ref), l_Contents_0 (ref), l_Templates_0 (ref), v3 (ref)
			if v11.RequiredRank and (not v9 or not v11.AllowedInVIP) and (v6[v11.RequiredRank] or tonumber(v11.RequiredRank) or 255) > v10 then
				print("WHYYY")
                return;
            else
                local v12 = l_Templates_1.Command:Clone();
                v12.Title.Visible = v11.Title;
                v12.Title.Text = tostring(v11.Title);
                v12.LayoutOrder = tonumber(v11.LayoutOrder) or 10000;
                v12.ZIndex = -v12.LayoutOrder;
                v12.Parent = l_Contents_0;
                if v11.DisplayedAttribute then
                    v12.Title.Text = ("%* (Currently: %*)"):format(tostring(v11.Title), (tostring(workspace:GetAttribute(v11.DisplayedAttribute) or v11.DisplayedAttributeDefault or "false")));
                    workspace:GetAttributeChangedSignal((tostring(v11.DisplayedAttribute))):Connect(function() --[[ Line: 54 ]]
                        -- upvalues: v12 (copy), v11 (copy)
                        v12.Title.Text = ("%* (Currently: %*)"):format(tostring(v11.Title), (tostring(workspace:GetAttribute(v11.DisplayedAttribute) or v11.DisplayedAttributeDefault or "false")));
                    end);
                end;
                local v13 = {};
                local v14 = {};
                local function v21() --[[ Line: 61 ]] --[[ Name: resetParamsToDefault ]]
                    -- upvalues: v11 (copy), v13 (copy), v14 (copy)
                    local l_pairs_0 = pairs;
                    local v16 = v11.Parameters or {};
                    for v17, v18 in l_pairs_0(v16) do
                        v13[v17] = v18.DefaultValue;
                    end;
                    for _, v20 in pairs(v14) do
                        v20.Value = v20.DefaultValue;
                        v20:OnUpdate();
                    end;
                end;
                v21();
                local l_pairs_1 = pairs;
                local v23 = v11.Parameters or {};
                for v24, v25 in l_pairs_1(v23) do
                    local l_l_Templates_1_FirstChild_0 = l_Templates_1:FindFirstChild((("%*Parameter"):format((tostring(v25.Type)))));
                    if l_l_Templates_1_FirstChild_0 then
                        local v27 = l_l_Templates_1_FirstChild_0:Clone();
                        v27.LayoutOrder = v24 + 10;
                        v27.Title.Visible = v25.Title;
                        v27.Title.Text = tostring(v25.Title);
                        v27.Parent = v12;
                        local v28 = ({
                            Textbox = "String"
                        })[v25.Type] or v25.Type;
                        if v28 then
                            local v29 = Instance.new((("%*Value"):format(v28)));
                            v29.Value = v25.DefaultValue or v29.Value;
                            v29.Parent = v27;
                            local l_pairs_2 = pairs;
                            local v31 = v25.Metadata or {};
							for v32, v33 in l_pairs_2(v31) do
                                local v34 = require(game.ReplicatedStorage.Modules.Misc.SharedModeratorCommands);
                                v29:SetAttribute(v32, typeof(v33) == "function" and v33() or typeof(v33) == "string" and v34[v33] and v34[v33]() or v33);
                            end;
                            if tostring(v25.Title):find("Player") then
                                l_pairs_2 = function() --[[ Line: 102 ]] --[[ Name: updateOptions ]]
                                    -- upvalues: v25 (copy), v29 (copy)
                                    local v35 = v25.Metadata and v25.Metadata.AllPlayersOptionDisabled and {} or {
                                        "All"
                                    };
                                    for _, v37 in pairs(game.Players:GetPlayers()) do
                                        table.insert(v35, v37.Name);
                                    end;
                                    local v38 = table.concat(v35, "|");
                                    v29:SetAttribute("Options", v38);
                                end;
                                l_pairs_2();
                                game.Players.PlayerAdded:Connect(l_pairs_2);
                                game.Players.PlayerRemoving:Connect(l_pairs_2);
                            end;
                            l_pairs_2 = l_Templates_0:FindFirstChild((tostring(v25.Type)));
                            if l_pairs_2 then
                                local l_SettingUI_0 = require(l_pairs_2):CreateSettingUI(v29, v27, function(v39) --[[ Line: 122 ]]
                                    -- upvalues: v13 (copy), v24 (copy), v11 (copy), v11 (copy), v21 (copy)
                                    v13[v24] = v39;
                                    if not v11.Executable then
                                        require(game.ReplicatedStorage.Modules.Network):FireServerConnection("ExecuteCommand", "REMOTE_EVENT", v11.Name, unpack(v13));
                                        if v11.ResetOnExecution then
                                            v21();
                                        end;
                                    end;
                                end);
                                l_SettingUI_0:OnUpdate();
                                l_SettingUI_0.DefaultValue = v25.DefaultValue;
                                table.insert(v14, l_SettingUI_0);
                            end;
                        end;
                    end;
                end;
                l_pairs_1 = require(game.ReplicatedStorage.Modules.Sounds);
                v12.Execute.Visible = v11.Executable;
                v12.Execute.Title.Text = v11.ExecuteTitle or "Execute";
                v12.Execute.MouseButton1Click:Connect(function() --[[ Line: 137 ]]
                    -- upvalues: v3 (ref), v11 (copy), v13 (copy), l_pairs_1 (copy), v11 (copy), v21 (copy)
                    v3:FireServerConnection("ExecuteCommand", "REMOTE_EVENT", v11.Name, unpack(v13));
                    l_pairs_1:Play("switch");
                    if v11.ResetOnExecution then
                        v21();
                    end;
                end);
                v12.Execute.MouseEnter:Connect(function() --[[ Line: 142 ]]
                    -- upvalues: l_pairs_1 (copy)
                    l_pairs_1:Play("hover");
                end);
                v12.Execute.MouseLeave:Connect(function() --[[ Line: 143 ]]
                    -- upvalues: l_pairs_1 (copy)
                    l_pairs_1:Play("hoverEnd");
                end);
                return;
            end;
        end;
        local v42 = v3:FireServerConnection("GetCommandData", "REMOTE_FUNCTION");
        for _, v44 in pairs(v42) do
            v41(v44);
        end;
        if v9 or v6.Moderator <= v10 then
            local v45 = nil;
            local v46 = nil;
            local v47 = require(game.ReplicatedStorage.Modules.Icon);
            local _ = require(game.ReplicatedStorage.Modules.Device);
            v46 = v47.new();
            v46:setOrder(1);
            v46:oneClick(true);
            v46:setLabel("Command Panel");
            v46:bindEvent("deselected", function() --[[ Line: 167 ]]
                -- upvalues: v0 (ref)
                v0.ModMenu:ToggleMenu();
            end);
            v45 = game.UserInputService.InputBegan:Connect(function(v49, v50) --[[ Line: 172 ]]
                -- upvalues: v0 (ref)
                if v50 then
                    return;
                else
                    if v49.KeyCode == Enum.KeyCode.M or v49.KeyCode == Enum.KeyCode.ButtonStart then
                        v0.ModMenu:ToggleMenu();
                    end;
                    return;
                end;
            end);
        end;
    end);
end;
return v0;