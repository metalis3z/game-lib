local l_WindowService_1 = require(game:GetService("ReplicatedStorage").Modules.WindowService)
l_WindowService_1:RegisterFrame(script.Parent.Parent.ServerSettings, "PrivateServer");
local l_Parent_0 = script.Parent;
local l_SettingsList_0 = l_Parent_0.SettingsContainer.SettingsList;
local l_Remotes_0 = game:GetService("ReplicatedStorage").Remotes;
--local v5 = l_Remotes_0.CustomGames.CanStartDuels:InvokeServer();
local function v14(v9)
    for _, v11 in v9.Options:GetChildren() do
        if v11:IsA("Frame") then
            v11.Button.Activated:Connect(function() --[[ Line: 25 ]]
                if v9.Name == "GameMode" then
					l_Remotes_0.Extras.ChangeServerSetting:FireServer(v11.Name, true);
                else
                    l_Remotes_0.Extras.ChangeServerSetting:FireServer(v9.Name, v11.Name);
                end;
                for _, v13 in v9.Options:GetChildren() do
                    if v13:IsA("Frame") then
                        v13.Button.Style = v13 == v11 and Enum.ButtonStyle.RobloxRoundDefaultButton or Enum.ButtonStyle.RobloxRoundButton;
                    end;
                end;
                if v11.Name == "DuelMode" then
                    l_SettingsList_0.Duel.Visible = true;
                    return;
                else
                    l_SettingsList_0.Duel.Visible = false;
                    return;
                end;
            end);
        end;
    end;
end;
v14(l_SettingsList_0.GameMode);
v14(l_SettingsList_0.RoundTimerOverride);
l_Parent_0.Title.Close.Button.Activated:Connect(function() --[[ Line: 46 ]]
    l_Parent_0.Visible = false;
end);
l_SettingsList_0.Duel.DuelSetup.Button.Activated:Connect(function() --[[ Line: 50 ]]
    l_WindowService_1:ToggleFrame("DuelSetup");
end);
--l_SettingsList_0.GameMode.Options.DuelMode.Visible = v5;