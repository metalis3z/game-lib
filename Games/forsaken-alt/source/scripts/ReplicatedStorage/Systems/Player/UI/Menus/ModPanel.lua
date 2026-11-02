-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};

local Testing = false

v0.Start = function(_) --[[ Line: 3 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    v0.ModMenu = require(game.ReplicatedStorage.Initializer).PlayerSystems.SidebarHandler:CreateSidebarMenu("ModPanel", script.ModScreen);
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local l_Contents_0 = v0.ModMenu.Menu.ModContainer.Contents;
    local v4 = require(game.ReplicatedStorage.Modules.Schematics.GroupRankTranslations);
    local l_Templates_0 = game.ReplicatedStorage.Systems.Player.UI.Menus.Settings.Templates;
    local l_Templates_1 = script.Templates;
    task.spawn(function() --[[ Line: 20 ]]
        -- upvalues: l_LocalPlayer_0 (copy), v4 (copy), l_Templates_1 (copy), l_Contents_0 (copy), l_Templates_0 (copy), v0 (ref)
        local v7 = workspace:GetAttribute("ServerOwnerID") == l_LocalPlayer_0.UserId;
        local v8 = 0;
        pcall(function() --[[ Line: 23 ]]
            -- upvalues: v8 (ref), l_LocalPlayer_0 16827775ref)
			v8 = (game["Run Service"]:IsStudio() and 255) or (Testing and 255) or l_LocalPlayer_0:GetRankInGroup(17126300); -- game[RUNSERVICE] ??????? 17126300 66 YO WAHT YOU DOING SKID im trying to make it so you can use panel in studio 
        end);
        local function v39(v9) --[[ Line: 26 ]] --[[ Name: createCommandUI ]]
            -- upvalues: v4 (ref), v8 (ref), l_Templates_1 (ref), l_Contents_0 (ref), l_Templates_0 (ref)
            local v10 = require(v9);
			if v10.RequiredRank and (v4[v10.RequiredRank] or tonumber(v10.RequiredRank) or 1) >= v8 then
                return;
            else
                local v11 = l_Templates_1.Command:Clone();
                v11.Title.Visible = v10.Title;
                v11.Title.Text = tostring(v10.Title);
                v11.LayoutOrder = tonumber(v10.LayoutOrder) or 10000;
                v11.ZIndex = -v11.LayoutOrder;
                v11.Parent = l_Contents_0;
                if v10.DisplayedAttribute then
                    v11.Title.Text = ("%* (Currently: %*)"):format(tostring(v10.Title), (tostring(workspace:GetAttribute(v10.DisplayedAttribute) or v10.DisplayedAttributeDefault or "false")));
                    workspace:GetAttributeChangedSignal((tostring(v10.DisplayedAttribute))):Connect(function() --[[ Line: 45 ]]
                        -- upvalues: v11 (copy), v10 (copy)
                        v11.Title.Text = ("%* (Currently: %*)"):format(tostring(v10.Title), (tostring(workspace:GetAttribute(v10.DisplayedAttribute) or v10.DisplayedAttributeDefault or "false")));
                    end);
                end;
                local v12 = {};
                local v13 = {};
                local function v20() --[[ Line: 52 ]] --[[ Name: resetParamsToDefault ]]
                    -- upvalues: v10 (copy), v12 (copy), v13 (copy)
                    local l_pairs_0 = pairs;
                    local v15 = v10.Parameters or {};
                    for v16, v17 in l_pairs_0(v15) do
                        v12[v16] = v17.DefaultValue;
                    end;
                    for _, v19 in pairs(v13) do
                        v19.Value = v19.DefaultValue;
                        v19:OnUpdate();
                    end;
                end;
                v20();
                local l_pairs_1 = pairs;
                local v22 = v10.Parameters or {};
                for v23, v24 in l_pairs_1(v22) do
                    local l_l_Templates_1_FirstChild_0 = l_Templates_1:FindFirstChild((("%*Parameter"):format((tostring(v24.Type)))));
                    if l_l_Templates_1_FirstChild_0 then
                        local v26 = l_l_Templates_1_FirstChild_0:Clone();
                        v26.LayoutOrder = v23 + 10;
                        v26.Title.Visible = v24.Title;
                        v26.Title.Text = tostring(v24.Title);
                        v26.Parent = v11;
                        local v27 = ({
                            Textbox = "String"
                        })[v24.Type] or v24.Type;
                        if v27 then
                            local v28 = Instance.new((("%*Value"):format(v27)));
                            v28.Value = v24.DefaultValue or v28.Value;
                            v28.Parent = v26;
                            local l_pairs_2 = pairs;
                            local v30 = v24.Metadata or {};
                            for v31, v32 in l_pairs_2(v30) do
                                v28:SetAttribute(v31, typeof(v32) == "function" and v32() or v32);
                            end;
                            if tostring(v24.Title):find("Player") then
                                function l_pairs_2() --[[ Line: 92 ]] --[[ Name: updateOptions ]]
                                    -- upvalues: v24 (copy), v28 (copy)
                                    local v33 = v24.Metadata and v24.Metadata.AllPlayersOptionDisabled and {} or {
                                        "All"
                                    };
                                    for _, v35 in pairs(game.Players:GetPlayers()) do
                                        table.insert(v33, v35.Name);
                                    end;
                                    local v36 = table.concat(v33, "|");
                                    v28:SetAttribute("Options", v36);
                                end;
                                l_pairs_2();
                                game.Players.PlayerAdded:Connect(l_pairs_2);
                                game.Players.PlayerRemoving:Connect(l_pairs_2);
                            end;
                            l_pairs_2 = l_Templates_0:FindFirstChild((tostring(v24.Type)));
                            if l_pairs_2 then
                                local l_SettingUI_0 = require(l_pairs_2):CreateSettingUI(v28, v26, function(v37) --[[ Line: 112 ]]
                                    -- upvalues: v12 (copy), v23 (copy), v10 (copy), v9 (copy), v20 (copy)
                                    v12[v23] = v37;
                                    if not v10.Executable then
                                        require(game.ReplicatedStorage.Modules.Network):FireServerConnection("ExecuteCommand", "REMOTE_EVENT", v9.Name, unpack(v12));
                                        if v10.ResetOnExecution then
                                            v20();
                                        end;
                                    end;
                                end);
                                l_SettingUI_0:OnUpdate();
                                l_SettingUI_0.DefaultValue = v24.DefaultValue;
                                table.insert(v13, l_SettingUI_0);
                            end;
                        end;
                    end;
                end;
                l_pairs_1 = require(game.ReplicatedStorage.Modules.Sounds);
                v11.Execute.Visible = v10.Executable;
                v11.Execute.Title.Text = v10.ExecuteTitle or "Execute";
                v11.Execute.MouseButton1Click:Connect(function() --[[ Line: 127 ]]
                    -- upvalues: v9 (copy), v12 (copy), l_pairs_1 (copy), v10 (copy), v20 (copy)
                    require(game.ReplicatedStorage.Modules.Network):FireServerConnection("ExecuteCommand", "REMOTE_EVENT", v9.Name, unpack(v12));
                    l_pairs_1:Play("switch");
                    if v10.ResetOnExecution then
                        v20();
                    end;
                end);
                v11.Execute.MouseEnter:Connect(function() --[[ Line: 133 ]]
                    -- upvalues: l_pairs_1 (copy)
                    l_pairs_1:Play("hover");
                end);
                v11.Execute.MouseLeave:Connect(function() --[[ Line: 134 ]]
                    -- upvalues: l_pairs_1 (copy)
                    l_pairs_1:Play("hoverEnd");
                end);
                return;
            end;
        end;
        for _, v41 in pairs(game.ReplicatedStorage.Modules.ModeratorCommands:GetChildren()) do
            v39(v41);
        end;
        if v7 or v4.Moderator <= v8 then
            local v42 = nil;
            local v43 = nil;
            local v44 = require(game.ReplicatedStorage.Modules.Icon);
            local _ = require(game.ReplicatedStorage.Modules.Device);
            v43 = v44.new();
            v43:setOrder(1);
            v43:oneClick(true);
            v43:setLabel("Command Panel");
            v43:bindEvent("deselected", function() --[[ Line: 157 ]]
                -- upvalues: v0 (ref)
                v0.ModMenu:ToggleMenu();
            end);
            v42 = game.UserInputService.InputBegan:Connect(function(v46, v47) --[[ Line: 162 ]]
                -- upvalues: v0 (ref)
                if v47 then
                    return;
                else
                    if v46.KeyCode == Enum.KeyCode.M or v46.KeyCode == Enum.KeyCode.ButtonStart then
                        v0.ModMenu:ToggleMenu();
                    end;
                    return;
                end;
            end);
        end;
    end);
end;
return v0;