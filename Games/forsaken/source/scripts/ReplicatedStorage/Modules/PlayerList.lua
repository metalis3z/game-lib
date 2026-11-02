-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DisplayedStats = {
        "Money", 
        "KillerChance"
    }, 
    ListEnabled = true
};
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local v2 = require(game.ReplicatedStorage.Modules.Util);
local v3 = require(game.ReplicatedStorage.Modules.Sounds);
local v4 = {
    KillerChance = "Malice", 
    RbxSpent = "R$ Spent"
};
local v5 = {
    PC = "rbxassetid://98869991634914", 
    Mobile = "rbxassetid://108753685999771", 
    Console = "rbxassetid://126977428098797", 
    Unknown = "rbxassetid://94182197303121"
};
v0.GetPlayerListUI = function(v6) --[[ Line: 30 ]] --[[ Name: GetPlayerListUI ]]
    if not v6.PlayerList then
        repeat
            task.wait();
        until v6.PlayerList;
    end;
    return v6.PlayerList;
end;
local v7 = nil;
local v8 = true;
v0.TogglePlayerList = function(_, v10, v11) --[[ Line: 39 ]] --[[ Name: TogglePlayerList ]]
    -- upvalues: v0 (copy), v3 (copy), v7 (ref), v8 (ref)
    if v11 then
        v0.ListEnabled = v10;
    elseif not v0.ListEnabled then
        return;
    end;
    if not v11 then
        v3:Play("switch");
    end;
    local l_v0_PlayerListUI_0 = v0:GetPlayerListUI();
    if v7 then
        task.cancel(v7);
    end;
    if v10 then
        v8 = true;
        l_v0_PlayerListUI_0.Close.Text = ">";
        l_v0_PlayerListUI_0.Close.Visible = true;
        l_v0_PlayerListUI_0.Contents.Visible = true;
        l_v0_PlayerListUI_0.Background.Visible = true;
        game.TweenService:Create(l_v0_PlayerListUI_0, TweenInfo.new(0.15), {
            AnchorPoint = script.PlayerListHolder.AnchorPoint, 
            Position = script.PlayerListHolder.Position
        }):Play();
        return;
    else
        v8 = false;
        l_v0_PlayerListUI_0.Close.Text = "<";
        game.TweenService:Create(l_v0_PlayerListUI_0, TweenInfo.new(0.15), {
            AnchorPoint = Vector2.new(), 
            Position = UDim2.new(1, 0, 0, script.PlayerListHolder.Position.Y.Offset)
        }):Play();
        v7 = task.delay(0.15, function() --[[ Line: 69 ]]
            -- upvalues: v11 (copy), l_v0_PlayerListUI_0 (copy)
            if v11 then
                l_v0_PlayerListUI_0.Close.Visible = false;
            end;
            l_v0_PlayerListUI_0.Contents.Visible = false;
            l_v0_PlayerListUI_0.Background.Visible = false;
        end);
        return;
    end;
end;
local v13 = {};
v0.ShowPlayerStats = function(v14, v15) --[[ Line: 79 ]] --[[ Name: ShowPlayerStats ]]
    -- upvalues: v13 (copy), v3 (copy), v0 (copy), v5 (copy), v2 (copy), l_LocalPlayer_0 (copy)
    for _, v17 in pairs(v13) do
        v17:Disconnect();
    end;
    table.clear(v13);
    if v14.__currentlyDisplayedStats and v14.__currentlyDisplayedStats.Parent then
        if tostring(v14.__currentlyDisplayedStats) == tostring(v15) then
            game.TweenService:Create(v14.__currentlyDisplayedStats, TweenInfo.new(0.15), {
                Size = UDim2.fromScale()
            }):Play();
            game.Debris:AddItem(v14.__currentlyDisplayedStats, 0.15);
            v14.__currentlyDisplayedStats = nil;
            return;
        else
            v14.__currentlyDisplayedStats:Destroy();
        end;
    end;
    local v18 = script.PlayerStats:Clone();
    v18.Name = tostring(v15);
    v18.Close.MouseEnter:Connect(function() --[[ Line: 102 ]]
        -- upvalues: v3 (ref)
        v3:Play("hover");
    end);
    v18.Close.MouseLeave:Connect(function() --[[ Line: 103 ]]
        -- upvalues: v3 (ref)
        v3:Play("hoverEnd");
    end);
    v18.Close.MouseButton1Click:Connect(function() --[[ Line: 104 ]]
        -- upvalues: v3 (ref), v0 (ref), v15 (copy)
        v3:Play("select");
        v0:ShowPlayerStats(v15);
    end);
    local v19 = ("@%*"):format(v15.Name);
    local v20 = false;
    if v15.DisplayName ~= v15.Name then
        v20 = false;
        if v15.DisplayName ~= "" then
            v20 = v15.DisplayName;
        end;
    end;
    v18.BasicInfo.PlayerName.Text = v20 or v19;
    v18.BasicInfo.PlayerUsername.Text = v19;
    v18.BasicInfo.PlayerUsername.Visible = v20;
    task.spawn(function() --[[ Line: 116 ]]
        -- upvalues: v15 (copy), v18 (copy)
        local l_UserId_0 = v15.UserId;
        local l_UserThumbnailAsync_0 = game.Players:GetUserThumbnailAsync(l_UserId_0, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
        v18.PlayerIconHolder.Player.Image = l_UserThumbnailAsync_0;
    end);
    local function v24() --[[ Line: 123 ]] --[[ Name: updatePlayerDevice ]]
        -- upvalues: v5 (ref), v15 (copy), v18 (copy)
        local v23 = v5[v15:GetAttribute("Device")] or v5.Unknown;
        v18.PlayerIconHolder.Device.Image = v23;
    end;
    local v25 = v5[v15:GetAttribute("Device")] or v5.Unknown;
    v18.PlayerIconHolder.Device.Image = v25;
    table.insert(v13, v15:GetAttributeChangedSignal("Device"):Connect(v24));
    v25 = v15:FindFirstChild("PlayerData");
    local v26 = v25 and v25:FindFirstChild("Stats");
    local v27 = v25 and v25:FindFirstChild("Equipped");
    if v26 and v27 then
        local l_General_0 = v26:FindFirstChild("General");
        local v29 = l_General_0 and l_General_0:FindFirstChild("TimePlayed");
        if v29 then
            local function v31() --[[ Line: 142 ]] --[[ Name: updateTimePlayed ]]
                -- upvalues: v2 (ref), v15 (copy), v18 (copy), v29 (copy)
                local l_v2_SettingValue_0 = v2:GetSettingValue("HidePlaytime", v15);
                v18.TimePlayed.Text = ("Time Played: %*"):format(l_v2_SettingValue_0 and "<font color=\"rgb(125,125,125)\"><i>(Hidden)</i></font>" or v2:FormatTime(v29.Value, "Clock"));
            end;
            local l_v2_SettingValue_1 = v2:GetSettingValue("HidePlaytime", v15);
            v18.TimePlayed.Text = ("Time Played: %*"):format(l_v2_SettingValue_1 and "<font color=\"rgb(125,125,125)\"><i>(Hidden)</i></font>" or v2:FormatTime(v29.Value, "Clock"));
            table.insert(v13, v29:GetPropertyChangedSignal("Value"):Connect(v31));
        end;
        for _, v34 in pairs({
            "Killer", 
            "Survivor"
        }) do
            local v35 = v26 and v26:FindFirstChild((("%*Stats"):format(v34)));
            local v36 = v35 and v35:FindFirstChild((("%*Wins"):format(v34)));
            if v36 then
                local l_v2_SettingValue_2 = v2:GetSettingValue(("Hide%*Wins"):format(v34), v15);
                local l_FirstChild_0 = v18.WinInfo:FindFirstChild((("%*Wins"):format(v34)));
                local l_l_v2_SettingValue_2_0 = l_v2_SettingValue_2 --[[ copy: 18 -> 22 ]];
                l_FirstChild_0.MouseEnter:Connect(function() --[[ Line: 161 ]]
                    -- upvalues: v2 (ref), v34 (copy), l_l_v2_SettingValue_2_0 (copy)
                    v2:CreateTooltip((("%* Wins%*"):format(v34, l_l_v2_SettingValue_2_0 and " <font color=\"rgb(125,125,125)\"><i>(Hidden)</i></font>" or "")));
                end);
                l_FirstChild_0.MouseLeave:Connect(function() --[[ Line: 162 ]]
                    -- upvalues: v2 (ref)
                    v2:CreateTooltip();
                end);
                local l_l_FirstChild_0_0 = l_FirstChild_0 --[[ copy: 19 -> 23 ]];
                local function v41() --[[ Line: 165 ]] --[[ Name: setScore ]]
                    -- upvalues: l_l_FirstChild_0_0 (copy), l_l_v2_SettingValue_2_0 (copy), v36 (copy)
                    l_l_FirstChild_0_0.Wins.Text = l_l_v2_SettingValue_2_0 and "<font color=\"rgb(125,125,125)\"><i>(Hidden)</i></font>" or v36.Value;
                end;
                l_FirstChild_0.Wins.Text = l_v2_SettingValue_2 and "<font color=\"rgb(125,125,125)\"><i>(Hidden)</i></font>" or v36.Value;
                table.insert(v13, v36:GetPropertyChangedSignal("Value"):Connect(v41));
            end;
            if v27 then
                local v42 = {};
                do
                    local l_v42_0 = v42;
                    local function v56() --[[ Line: 178 ]] --[[ Name: setEquippedIcon ]]
                        -- upvalues: v15 (copy), v34 (copy), l_v42_0 (ref), v18 (copy), v2 (ref)
                        local l_EquippedActorInfo_0, v45 = require(game.ReplicatedStorage.Modules.Actors):GetEquippedActorInfo(v15, v34);
                        local l_FirstChild_1 = game.ReplicatedStorage.Assets:FindFirstChild((("%*s"):format(v34))):FindFirstChild(l_EquippedActorInfo_0);
                        local v47 = l_FirstChild_1 and l_FirstChild_1:FindFirstChild("Config") and require(l_FirstChild_1.Config);
                        local l_FirstChild_2 = game.ReplicatedStorage.Assets.Skins:FindFirstChild((("%*s"):format(v34))):FindFirstChild(l_EquippedActorInfo_0);
                        local v49 = l_FirstChild_2 and l_FirstChild_2:FindFirstChild(v45);
                        local v50 = v49 and v49:FindFirstChild("Config") and require(v49.Config);
                        if v47 then
                            for _, v52 in pairs(l_v42_0) do
                                v52:Disconnect();
                            end;
                            table.clear(l_v42_0);
                            local l_FirstChild_3 = v18.BasicInfo.EquippedCharacters:FindFirstChild(v34);
                            local v54 = ("Equipped %*: <i>%*</i>"):format(v34, v47.DisplayName or tostring(l_FirstChild_1));
                            if v50 then
                                v54 = ("%*\nEquipped Skin: <i>%*</i>"):format(v54, v50.DisplayName or tostring(v49));
                            end;
                            l_FirstChild_3.Image = v50 and v50.RenderImage or v47.RenderImage or "rbxassetid://13373279056";
                            do
                                local l_v54_0 = v54;
                                l_v42_0 = {
                                    l_FirstChild_3.MouseEnter:Connect(function() --[[ Line: 202 ]]
                                        -- upvalues: v2 (ref), l_v54_0 (ref)
                                        v2:CreateTooltip(l_v54_0);
                                    end), 
                                    l_FirstChild_3.MouseLeave:Connect(function() --[[ Line: 203 ]]
                                        -- upvalues: v2 (ref)
                                        v2:CreateTooltip();
                                    end)
                                };
                            end;
                        end;
                    end;
                    local l_v27_FirstChild_0 = v27:FindFirstChild(v34);
                    local l_FirstChild_4 = v27.Skins:FindFirstChild(v34);
                    v56();
                    if l_v27_FirstChild_0 then
                        table.insert(v13, l_v27_FirstChild_0:GetPropertyChangedSignal("Value"):Connect(v56));
                    end;
                    if l_FirstChild_4 then
                        table.insert(v13, l_FirstChild_4:GetPropertyChangedSignal("Value"):Connect(v56));
                    end;
                end;
            end;
        end;
    end;
    if not v14.__currentlyDisplayedStats then
        v18.Size = UDim2.new();
        game.TweenService:Create(v18, TweenInfo.new(0.15), {
            Size = script.PlayerStats.Size
        }):Play();
    end;
    v18.Parent = l_LocalPlayer_0.PlayerGui.TemporaryUI;
    v14.__currentlyDisplayedStats = v18;
    local v59 = nil;
    v59 = v18.AncestryChanged:Connect(function(_, v61) --[[ Line: 231 ]]
        -- upvalues: v2 (ref), v13 (ref)
        if not v61 then
            v2:CreateTooltip();
            for _, v63 in pairs(v13) do
                v63:Disconnect();
            end;
            table.clear(v13);
        end;
    end);
end;
v0.CreatePlayerInList = function(_, v65) --[[ Line: 242 ]] --[[ Name: CreatePlayerInList ]]
    -- upvalues: v0 (copy), v2 (copy)
    if not v65 then
        return;
    else
        local v66 = script.PlayerInfoContainer:Clone();
        v66.Name = tostring(v65);
        local l_Name_0 = v65.Name;
        local v68 = false;
        if v65.DisplayName ~= v65.Name then
            v68 = false;
            if v65.DisplayName ~= "" then
                v68 = v65.DisplayName;
            end;
        end;
        v66.PlayerInfo.Username.Text = v68 or l_Name_0;
        v66.ShowStats.MouseButton1Click:Connect(function() --[[ Line: 253 ]]
            -- upvalues: v0 (ref), v65 (copy)
            v0:ShowPlayerStats(v65);
        end);
        if v0.DisplayedStats and v0.DisplayedStats[1] then
            local v69 = v65:WaitForChild("leaderstats", 30);
            if v69 then
                for _, v71 in pairs(v69:GetChildren()) do
                    local v72 = v66.PlayerInfo.Username:Clone();
                    v72.Name = v71 and v71.Name;
                    v72.Size = UDim2.fromScale(0.3, 1);
                    v72.LayoutOrder = table.find(v0.DisplayedStats, v71.Name);
                    v72.TextXAlignment = Enum.TextXAlignment.Center;
                    v72.Parent = v66.PlayerInfo;
                    local function v74() --[[ Line: 271 ]] --[[ Name: updateStat ]]
                        -- upvalues: v71 (copy), v72 (copy), v2 (ref)
                        local v73 = v71 and v71.Value or "?";
                        if tonumber(v73) then
                            v72.TextColor3 = v73 > 0 and Color3.new(1, 1, 1) or Color3.new(1, 0, 0);
                            v73 = v2:ConvertToAbbreviation(v73);
                        end;
                        if v73.Name == "Money" then
                            v73 = ("%* $"):format(v73);
                        end;
                        v72.Text = tostring(v73);
                    end;
                    v74();
                    if v71 then
                        v71:GetPropertyChangedSignal("Value"):Connect(v74);
                    end;
                end;
            end;
        end;
        v66.Parent = v0:GetPlayerListUI().Contents.Players;
        v0:__UpdateListSize();
        return;
    end;
end;
v0.RemovePlayerFromList = function(_, v76) --[[ Line: 293 ]] --[[ Name: RemovePlayerFromList ]]
    -- upvalues: v0 (copy)
    local l_FirstChild_5 = v0:GetPlayerListUI().Contents.Players:FindFirstChild((tostring(v76)));
    if l_FirstChild_5 then
        l_FirstChild_5:Destroy();
    end;
    v0:__UpdateListSize();
end;
v0.__UpdateListSize = function(_) --[[ Line: 306 ]] --[[ Name: __UpdateListSize ]]
    -- upvalues: v0 (copy)
    local l_v0_PlayerListUI_1 = v0:GetPlayerListUI();
    local l_UIListLayout_0 = l_v0_PlayerListUI_1.Contents.Players.UIListLayout;
    local v81 = l_UIListLayout_0.AbsoluteContentSize.Y + l_UIListLayout_0.Padding.Offset;
    l_v0_PlayerListUI_1.Background.Size = UDim2.fromScale(1, (math.clamp(0.05 + 30 / l_v0_PlayerListUI_1.AbsoluteSize.Y + v81 / l_v0_PlayerListUI_1.AbsoluteSize.Y, 0, 1)));
end;
v0.Start = function(v82) --[[ Line: 315 ]] --[[ Name: Start ]]
    -- upvalues: l_LocalPlayer_0 (copy), v0 (copy), v4 (copy), v2 (copy), v8 (ref), v3 (copy)
    if game["Run Service"]:IsServer() then
        return;
    else
        local v83 = script.PlayerListHolder:Clone();
        local l_Contents_0 = v83.Contents;
        v83.Parent = l_LocalPlayer_0.PlayerGui:WaitForChild("MainUI");
        l_Contents_0:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 324 ]]
            -- upvalues: v0 (ref)
            v0:__UpdateListSize();
        end);
        for v85, v86 in pairs(v0.DisplayedStats) do
            local v87 = l_Contents_0.InfoTypes.Players:Clone();
            v87.Name = v86;
            v87.Text = v4[v86] or v86:gsub("(%l)(%u)", "%1 %2");
            v87.Size = UDim2.fromScale(0.3, 1);
            v87.LayoutOrder = v85 + 1;
            v87.TextXAlignment = Enum.TextXAlignment.Center;
            v87.Parent = l_Contents_0.InfoTypes;
        end;
        v2.OnPlayerAdded(function(v88) --[[ Line: 340 ]]
            -- upvalues: v0 (ref)
            v0:CreatePlayerInList(v88);
        end);
        game.Players.PlayerRemoving:Connect(function(v89) --[[ Line: 345 ]]
            -- upvalues: v0 (ref)
            v0:RemovePlayerFromList(v89);
        end);
        v83.Close.MouseButton1Click:Connect(function() --[[ Line: 350 ]]
            -- upvalues: v0 (ref), v8 (ref)
            v0:TogglePlayerList(not v8);
        end);
        game.UserInputService.InputBegan:Connect(function(v90, v91) --[[ Line: 354 ]]
            -- upvalues: v0 (ref), v8 (ref)
            if v91 then
                return;
            else
                if v90.KeyCode == Enum.KeyCode.Tab then
                    v0:TogglePlayerList(not v8);
                end;
                return;
            end;
        end);
        local function v93(v92) --[[ Line: 362 ]] --[[ Name: addSFX ]]
            -- upvalues: v3 (ref)
            if v92:IsA("ImageButton") or v92:IsA("TextButton") then
                v92.MouseEnter:Connect(function() --[[ Line: 364 ]]
                    -- upvalues: v3 (ref)
                    v3:Play("hover");
                end);
                v92.MouseLeave:Connect(function() --[[ Line: 365 ]]
                    -- upvalues: v3 (ref)
                    v3:Play("hoverEnd");
                end);
                v92.MouseButton1Click:Connect(function() --[[ Line: 366 ]]
                    -- upvalues: v3 (ref)
                    v3:Play("select");
                end);
            end;
        end;
        for _, v95 in pairs(v83:GetDescendants()) do
            v93(v95);
        end;
        v83.DescendantAdded:Connect(v93);
        v82.PlayerList = v83;
        game.StarterGui:SetCoreGuiEnabled("PlayerList", false);
        return;
    end;
end;
return v0;