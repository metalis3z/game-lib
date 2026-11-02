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
            local function v30() --[[ Line: 142 ]] --[[ Name: updateTimePlayed ]]
                -- upvalues: v18 (copy), v2 (ref), v29 (copy)
                v18.TimePlayed.Text = ("Time Played: %*"):format((v2:FormatTime(v29.Value, "Clock")));
            end;
            v18.TimePlayed.Text = ("Time Played: %*"):format((v2:FormatTime(v29.Value, "Clock")));
            table.insert(v13, v29:GetPropertyChangedSignal("Value"):Connect(v30));
        end;
        for _, v32 in pairs({
            "Killer", 
            "Survivor"
        }) do
            local v33 = v26 and v26:FindFirstChild((("%*Stats"):format(v32)));
            local v34 = v33 and v33:FindFirstChild((("%*Wins"):format(v32)));
            if v34 then
                local l_FirstChild_0 = v18.WinInfo:FindFirstChild((("%*Wins"):format(v32)));
                l_FirstChild_0.MouseEnter:Connect(function() --[[ Line: 159 ]]
                    -- upvalues: v2 (ref), v32 (copy)
                    v2:CreateTooltip((("%* Wins"):format(v32)));
                end);
                l_FirstChild_0.MouseLeave:Connect(function() --[[ Line: 160 ]]
                    -- upvalues: v2 (ref)
                    v2:CreateTooltip();
                end);
                local l_l_FirstChild_0_0 = l_FirstChild_0 --[[ copy: 18 -> 22 ]];
                local function v37() --[[ Line: 163 ]] --[[ Name: setScore ]]
                    -- upvalues: l_l_FirstChild_0_0 (copy), v34 (copy)
                    l_l_FirstChild_0_0.Wins.Text = v34.Value;
                end;
                l_FirstChild_0.Wins.Text = v34.Value;
                table.insert(v13, v34:GetPropertyChangedSignal("Value"):Connect(v37));
            end;
            if v27 then
                local v38 = {};
                do
                    local l_v38_0 = v38;
                    local function v52() --[[ Line: 176 ]] --[[ Name: setEquippedIcon ]]
                        -- upvalues: v15 (copy), v32 (copy), l_v38_0 (ref), v18 (copy), v2 (ref)
                        local l_EquippedActorInfo_0, v41 = require(game.ReplicatedStorage.Modules.Actors):GetEquippedActorInfo(v15, v32);
                        local l_FirstChild_1 = game.ReplicatedStorage.Assets:FindFirstChild((("%*s"):format(v32))):FindFirstChild(l_EquippedActorInfo_0);
                        local v43 = l_FirstChild_1 and l_FirstChild_1:FindFirstChild("Config") and require(l_FirstChild_1.Config);
                        local l_FirstChild_2 = game.ReplicatedStorage.Assets.Skins:FindFirstChild((("%*s"):format(v32))):FindFirstChild(l_EquippedActorInfo_0);
                        local v45 = l_FirstChild_2 and l_FirstChild_2:FindFirstChild(v41);
                        local v46 = v45 and v45:FindFirstChild("Config") and require(v45.Config);
                        if v43 then
                            for _, v48 in pairs(l_v38_0) do
                                v48:Disconnect();
                            end;
                            table.clear(l_v38_0);
                            local l_FirstChild_3 = v18.BasicInfo.EquippedCharacters:FindFirstChild(v32);
                            local v50 = ("Equipped %*: <i>%*</i>"):format(v32, v43.DisplayName or tostring(l_FirstChild_1));
                            if v46 then
                                v50 = ("%*\nEquipped Skin: <i>%*</i>"):format(v50, v46.DisplayName or tostring(v45));
                            end;
                            l_FirstChild_3.Image = v46 and v46.RenderImage or v43.RenderImage or "rbxassetid://13373279056";
                            do
                                local l_v50_0 = v50;
                                l_v38_0 = {
                                    l_FirstChild_3.MouseEnter:Connect(function() --[[ Line: 200 ]]
                                        -- upvalues: v2 (ref), l_v50_0 (ref)
                                        v2:CreateTooltip(l_v50_0);
                                    end), 
                                    l_FirstChild_3.MouseLeave:Connect(function() --[[ Line: 201 ]]
                                        -- upvalues: v2 (ref)
                                        v2:CreateTooltip();
                                    end)
                                };
                            end;
                        end;
                    end;
                    local l_v27_FirstChild_0 = v27:FindFirstChild(v32);
                    local l_FirstChild_4 = v27.Skins:FindFirstChild(v32);
                    v52();
                    if l_v27_FirstChild_0 then
                        table.insert(v13, l_v27_FirstChild_0:GetPropertyChangedSignal("Value"):Connect(v52));
                    end;
                    if l_FirstChild_4 then
                        table.insert(v13, l_FirstChild_4:GetPropertyChangedSignal("Value"):Connect(v52));
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
    local v55 = nil;
    v55 = v18.AncestryChanged:Connect(function(_, v57) --[[ Line: 229 ]]
        -- upvalues: v2 (ref), v13 (ref)
        if not v57 then
            v2:CreateTooltip();
            for _, v59 in pairs(v13) do
                v59:Disconnect();
            end;
            table.clear(v13);
        end;
    end);
end;
v0.CreatePlayerInList = function(_, v61) --[[ Line: 240 ]] --[[ Name: CreatePlayerInList ]]
    -- upvalues: v0 (copy), v2 (copy)
    if not v61 then
        return;
    else
        local v62 = script.PlayerInfoContainer:Clone();
        v62.Name = tostring(v61);
        local l_Name_0 = v61.Name;
        local v64 = false;
        if v61.DisplayName ~= v61.Name then
            v64 = false;
            if v61.DisplayName ~= "" then
                v64 = v61.DisplayName;
            end;
        end;
        v62.PlayerInfo.Username.Text = v64 or l_Name_0;
        v62.ShowStats.MouseButton1Click:Connect(function() --[[ Line: 251 ]]
            -- upvalues: v0 (ref), v61 (copy)
            v0:ShowPlayerStats(v61);
        end);
        if v0.DisplayedStats and v0.DisplayedStats[1] then
            local v65 = v61:WaitForChild("leaderstats", 30);
            if v65 then
                for _, v67 in pairs(v65:GetChildren()) do
                    local v68 = v62.PlayerInfo.Username:Clone();
                    v68.Name = v67 and v67.Name;
                    v68.Size = UDim2.fromScale(0.3, 1);
                    v68.LayoutOrder = table.find(v0.DisplayedStats, v67.Name);
                    v68.TextXAlignment = Enum.TextXAlignment.Center;
                    v68.Parent = v62.PlayerInfo;
                    local function v70() --[[ Line: 269 ]] --[[ Name: updateStat ]]
                        -- upvalues: v67 (copy), v68 (copy), v2 (ref)
						spawn(function() -- change this to .changed if you can because i tried and it only displayed my display name and at other times just didnt update
							while task.wait() do
								local v69 = v67 and v67.Value or "?";
								if v67.Name == "Money" then
									v69 = v61:FindFirstChild("PlayerData").Stats.Currency.Money.Value
								end
								if tonumber(v69) then
									v68.TextColor3 = v69 > 0 and Color3.new(1, 1, 1) or Color3.new(1, 0, 0);
									v69 = v2:ConvertToAbbreviation(v69);
								end;
								if v69.Name == "Money" then
									v69 = ("%* $"):format(v69);
								end;
								v68.Text = tostring(v69);
							end
						end)
                    end;
                    v70();
                    if v67 then
                        v67:GetPropertyChangedSignal("Value"):Connect(v70);
                    end;
                end;
            end;
        end;
        v62.Parent = v0:GetPlayerListUI().Contents.Players;
        v0:__UpdateListSize();
        return;
    end;
end;
v0.RemovePlayerFromList = function(_, v72) --[[ Line: 291 ]] --[[ Name: RemovePlayerFromList ]]
    -- upvalues: v0 (copy)
    local l_FirstChild_5 = v0:GetPlayerListUI().Contents.Players:FindFirstChild((tostring(v72)));
    if l_FirstChild_5 then
        l_FirstChild_5:Destroy();
    end;
    v0:__UpdateListSize();
end;
v0.__UpdateListSize = function(_) --[[ Line: 304 ]] --[[ Name: __UpdateListSize ]]
    -- upvalues: v0 (copy)
    local l_v0_PlayerListUI_1 = v0:GetPlayerListUI();
    local l_UIListLayout_0 = l_v0_PlayerListUI_1.Contents.Players.UIListLayout;
    local v77 = l_UIListLayout_0.AbsoluteContentSize.Y + l_UIListLayout_0.Padding.Offset;
    l_v0_PlayerListUI_1.Background.Size = UDim2.fromScale(1, (math.clamp(0.05 + 30 / l_v0_PlayerListUI_1.AbsoluteSize.Y + v77 / l_v0_PlayerListUI_1.AbsoluteSize.Y, 0, 1)));
end;
v0.Start = function(v78) --[[ Line: 313 ]] --[[ Name: Start ]]
    -- upvalues: l_LocalPlayer_0 (copy), v0 (copy), v4 (copy), v2 (copy), v8 (ref), v3 (copy)
    if game["Run Service"]:IsServer() then
        return;
    else
        local v79 = script.PlayerListHolder:Clone();
        local l_Contents_0 = v79.Contents;
        v79.Parent = l_LocalPlayer_0.PlayerGui:WaitForChild("MainUI");
        l_Contents_0:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 322 ]]
            -- upvalues: v0 (ref)
            v0:__UpdateListSize();
        end);
        for v81, v82 in pairs(v0.DisplayedStats) do
            local v83 = l_Contents_0.InfoTypes.Players:Clone();
            v83.Name = v82;
            v83.Text = v4[v82] or v82:gsub("(%l)(%u)", "%1 %2");
            v83.Size = UDim2.fromScale(0.3, 1);
            v83.LayoutOrder = v81 + 1;
            v83.TextXAlignment = Enum.TextXAlignment.Center;
            v83.Parent = l_Contents_0.InfoTypes;
        end;
        v2.OnPlayerAdded(function(v84) --[[ Line: 338 ]]
            -- upvalues: v0 (ref)
            v0:CreatePlayerInList(v84);
        end);
        game.Players.PlayerRemoving:Connect(function(v85) --[[ Line: 343 ]]
            -- upvalues: v0 (ref)
            v0:RemovePlayerFromList(v85);
        end);
        v79.Close.MouseButton1Click:Connect(function() --[[ Line: 348 ]]
            -- upvalues: v0 (ref), v8 (ref)
            v0:TogglePlayerList(not v8);
        end);
        game.UserInputService.InputBegan:Connect(function(v86, v87) --[[ Line: 352 ]]
            -- upvalues: v0 (ref), v8 (ref)
            if v87 then
                return;
            else
                if v86.KeyCode == Enum.KeyCode.Tab then
                    v0:TogglePlayerList(not v8);
                end;
                return;
            end;
        end);
        local function v89(v88) --[[ Line: 360 ]] --[[ Name: addSFX ]]
            -- upvalues: v3 (ref)
            if v88:IsA("ImageButton") or v88:IsA("TextButton") then
                v88.MouseEnter:Connect(function() --[[ Line: 362 ]]
                    -- upvalues: v3 (ref)
                    v3:Play("hover");
                end);
                v88.MouseLeave:Connect(function() --[[ Line: 363 ]]
                    -- upvalues: v3 (ref)
                    v3:Play("hoverEnd");
                end);
                v88.MouseButton1Click:Connect(function() --[[ Line: 364 ]]
                    -- upvalues: v3 (ref)
                    v3:Play("select");
                end);
            end;
        end;
        for _, v91 in pairs(v79:GetDescendants()) do
            v89(v91);
        end;
        v79.DescendantAdded:Connect(v89);
        v78.PlayerList = v79;
        game.StarterGui:SetCoreGuiEnabled("PlayerList", false);
        return;
    end;
end;
return v0;