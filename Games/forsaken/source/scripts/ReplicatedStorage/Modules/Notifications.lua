-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = 0;
local function v11(v2) --[[ Line: 12 ]] --[[ Name: getContentInfoFromDataValue ]]
    local l_Name_0 = v2.Parent.Name;
    local l_FirstChild_0 = game.ReplicatedStorage.Assets:FindFirstChild(l_Name_0);
    local v5 = l_FirstChild_0 and l_FirstChild_0:FindFirstChild(v2.Name);
    if l_Name_0 == "Skins" and l_FirstChild_0 then
        for _, v7 in pairs(l_FirstChild_0:GetChildren()) do
            for _, v9 in pairs(v7:GetChildren()) do
                v5 = v9:FindFirstChild(v2.Name) or v5;
            end;
        end;
    end;
    if v5 then
        local v10 = v5:IsA("ModuleScript") and v5 or v5:FindFirstChild("Config");
        return v10 and require(v10), v5;
    else
        return;
    end;
end;
v0.CreateNotification = function(_, v13) --[[ Line: 32 ]] --[[ Name: CreateNotification ]]
    -- upvalues: v1 (ref), v11 (copy)
    local l_NotificationStorage_0 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("NotificationUI"):FindFirstChild("NotificationStorage");
    v1 = v1 + 1;
    local v15 = (script.NotificationTemplates:FindFirstChild((tostring(v13.NotificationType))) or script.NotificationTemplates.Default):Clone();
    v15.Name = "Notification";
    v15.Parent = l_NotificationStorage_0;
    v15.ZIndex = v1;
    v15.LayoutOrder = v1;
    task.delay(5, function() --[[ Line: 47 ]]
        -- upvalues: v15 (copy)
        game.Debris:AddItem(v15, 6);
        game.TweenService:Create(v15, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.fromScale(1, 0)
        }):Play();
    end);
    v15.Size = UDim2.fromScale(1, 0);
    game.TweenService:Create(v15, TweenInfo.new(1), {
        Size = UDim2.new(1, 0, v13.NotificationType == "Achievement" and 0.25 or 0.2, -10)
    }):Play();
    local l_Titles_0 = v15.Main.Titles;
    l_Titles_0.Primary.Text = tostring(v13.Title);
    l_Titles_0.Primary.Visible = v13.Title;
    l_Titles_0.Secondary.Text = tostring(v13.Subtitle);
    l_Titles_0.Secondary.Visible = v13.Subtitle;
    local l_Card_0 = v15.Main:FindFirstChild("Card");
    if l_Card_0 then
        local v18 = v13.DataValue and v11(v13.DataValue);
        l_Card_0.CharacterRender.Image = v18 and v18.RenderImage or "";
        l_Card_0.Visible = v18;
    end;
    require(game.ReplicatedStorage.Modules.Sounds):Play("notification", {
        PlaybackSpeed = Random.new():NextNumber(0.975, 1.025)
    });
    return v15;
end;
v0.Start = function(_) --[[ Line: 80 ]] --[[ Name: Start ]]
    -- upvalues: v11 (copy), v0 (copy)
    if game["Run Service"]:IsClient() then
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        local l_Purchased_0 = l_LocalPlayer_0.PlayerData:WaitForChild("Purchased");
        local l_ScreenGui_0 = Instance.new("ScreenGui");
        l_ScreenGui_0.Name = "NotificationUI";
        l_ScreenGui_0.ResetOnSpawn = false;
        l_ScreenGui_0.IgnoreGuiInset = false;
        l_ScreenGui_0.DisplayOrder = 500;
        l_ScreenGui_0.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
        l_ScreenGui_0.Parent = l_LocalPlayer_0.PlayerGui;
        script.NotificationStorage:Clone().Parent = l_ScreenGui_0;
        l_Purchased_0.DescendantAdded:Connect(function(v23) --[[ Line: 100 ]]
            -- upvalues: v11 (ref), v0 (ref)
            local v24 = v11(v23);
            local l_Name_1 = v23.Parent.Name;
            local v26 = nil;
            v26 = if l_Name_1 == "Skins" then v24 and v24.DisplayName and ("Received '%*' Skin"):format(v24.DisplayName) or ("Received '%*' Skin"):format(v23.Name) else v24 and v24.DisplayName and ("Received %*"):format(v24.DisplayName) or ("Received %*"):format(v23.Name);
            local _ = v0:CreateNotification({
                Title = v26, 
                Subtitle = v24 and (v24.Quote or v24.Description), 
                DataValue = v23
            });
        end);
        local function v33(v28) --[[ Line: 122 ]] --[[ Name: addLevelUpNotifCheck ]]
            -- upvalues: v11 (ref), v0 (ref)
            local v29 = require(game.ReplicatedStorage.Modules.Util);
            local v30 = v29:CalculateLevelFromEXP(v28.Value);
            v28:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 128 ]]
                -- upvalues: v29 (copy), v28 (copy), v30 (ref), v11 (ref), v0 (ref)
                local v31 = v29:CalculateLevelFromEXP(v28.Value);
                if v30 < v31 then
                    local v32 = v11(v28);
                    v0:CreateNotification({
                        Title = ("%* Leveled Up!"):format(v32 and v32.DisplayName or v28.Name), 
                        Subtitle = ("Level %* -> Level %*"):format(v30, v31), 
                        DataValue = v28
                    });
                end;
                v30 = v31;
            end);
        end;
        for _, v35 in pairs({
            l_Purchased_0:WaitForChild("Killers"), 
            l_Purchased_0:WaitForChild("Survivors")
        }) do
            for _, v37 in pairs(v35:GetChildren()) do
                v33(v37);
            end;
            v35.ChildAdded:Connect(v33);
        end;
        local v38 = require(game.ReplicatedStorage.Modules.Network);
        v38:SetConnection("AchievementCompleted", "REMOTE_EVENT", function(v39) --[[ Line: 152 ]]
            -- upvalues: v0 (ref)
            local v40 = require(game.ReplicatedStorage.Modules.Schematics.Achievements);
            for _, v42 in pairs(v40) do
                local v43 = v42.Achievements and v42.Achievements[v39];
                if v43 then
                    v0:CreateNotification({
                        Title = "Achievement Completed!", 
                        Subtitle = ("%*"):format(v43.Title or v39), 
                        NotificationType = "Achievement"
                    }).Main.Icon.Image = tostring(v43.Icon);
                end;
            end;
        end);
        v38:SetConnection("SendAnnouncement", "REMOTE_EVENT", function(v44, v45) --[[ Line: 168 ]]
            -- upvalues: l_ScreenGui_0 (copy)
            for _, v47 in pairs(l_ScreenGui_0:GetChildren()) do
                if v47.Name == "ServerAnnouncementUI" then
                    game.TweenService:Create(v47, TweenInfo.new(0.25), {
                        Position = UDim2.fromScale(0.5, -0.25)
                    }):Play();
                end;
            end;
            local v48 = script.NotificationTemplates.Announcement:Clone();
            v48.Name = "ServerAnnouncementUI";
            v48.Position = UDim2.fromScale(0.5, 2);
            v48.Title.Text = v44 or "...";
            v48.Sender.Text = v45;
            v48.Parent = l_ScreenGui_0;
            game.TweenService:Create(v48, TweenInfo.new(0.25), {
                Position = script.NotificationTemplates.Announcement.Position
            }):Play();
            local v49 = false;
            local function v53(v50) --[[ Line: 189 ]] --[[ Name: remove ]]
                -- upvalues: v49 (ref), v48 (copy)
                if v49 then
                    return;
                else
                    v49 = true;
                    if not tonumber(v50) then
                        v50 = 0.75;
                    end;
                    game.Debris:AddItem(v48, v50);
                    game.TweenService:Create(v48, TweenInfo.new(v50), {
                        ImageTransparency = 1
                    }):Play();
                    for _, v52 in pairs(v48:GetDescendants()) do
                        if v52:IsA("TextLabel") then
                            game.TweenService:Create(v52, TweenInfo.new(v50), {
                                TextTransparency = 1
                            }):Play();
                        end;
                    end;
                    return;
                end;
            end;
            v48.Close.MouseButton1Click:Connect(v53, 0.175);
            task.delay(6, v53);
        end);
    end;
end;
return v0;