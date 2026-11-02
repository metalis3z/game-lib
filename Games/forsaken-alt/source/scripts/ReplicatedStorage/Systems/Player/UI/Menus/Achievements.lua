-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.Start = function(_) --[[ Line: 3 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    task.spawn(function() --[[ Line: 5 ]]
        -- upvalues: v0 (ref)
        local l_LocalPlayer_0 = game.Players.LocalPlayer;
        local l_Achievements_0 = l_LocalPlayer_0:WaitForChild("PlayerData"):WaitForChild("Achievements");
        local v4 = require(game.ReplicatedStorage.Modules.Sounds);
        local v5 = require(game.ReplicatedStorage.Modules.Util);
        v0.AchievementsMenu = require(game.ReplicatedStorage.Initializer).PlayerSystems.SidebarHandler:CreateSidebarMenu("Achievements", script.AchievementsScreen);
        local l_AchievementsContainer_0 = v0.AchievementsMenu.Menu.AchievementsContainer;
        local l_Contents_0 = l_AchievementsContainer_0.Contents;
        local l_Templates_0 = script.Templates;
        local v9 = 0;
        local v10 = 0;
        local v11 = 0;
        local function _() --[[ Line: 26 ]] --[[ Name: updateAchievementHeader ]]
            -- upvalues: l_AchievementsContainer_0 (copy), v9 (ref), v11 (ref), v10 (ref)
            l_AchievementsContainer_0.MainTitle.Title.Text = ("Achievements -- %*/%*%* Unlocked"):format(v9, v11, v10 > 0 and (" (+%*)"):format(v9) or "");
        end;
        local v13 = nil;
        local function v20(v14, v15) --[[ Line: 32 ]] --[[ Name: createTab ]]
            -- upvalues: l_AchievementsContainer_0 (copy), v13 (ref), l_Contents_0 (copy)
            local v16 = script.Templates.TabButton:Clone();
            v16.Name = v14;
            v16.LayoutOrder = v15;
            v16.Inverted.ImageTransparency = v14 == "All" and 0 or 1;
            v16.Title.TextColor3 = v14 == "All" and Color3.new() or Color3.new(1, 1, 1);
            v16.Title.Text = v14;
            v16.Parent = l_AchievementsContainer_0.Tabs;
            v16.MouseButton1Click:Connect(function() --[[ Line: 43 ]]
                -- upvalues: v13 (ref), v16 (copy), l_Contents_0 (ref), v14 (copy)
                if v13 then
                    game.TweenService:Create(v13.Inverted, TweenInfo.new(0.3), {
                        ImageTransparency = 1
                    }):Play();
                    game.TweenService:Create(v13.Title, TweenInfo.new(0.3), {
                        TextColor3 = Color3.new(1, 1, 1)
                    }):Play();
                end;
                v13 = v16;
                game.TweenService:Create(v16.Inverted, TweenInfo.new(0.3), {
                    ImageTransparency = 0
                }):Play();
                game.TweenService:Create(v16.Title, TweenInfo.new(0.3), {
                    TextColor3 = Color3.new()
                }):Play();
                for _, v18 in pairs(l_Contents_0:GetChildren()) do
                    if v18:IsA("GuiObject") then
                        local v19 = true;
                        if v14 ~= "All" then
                            v19 = v18:GetAttribute("BranchName") == v14;
                        end;
                        v18.Visible = v19;
                    end;
                end;
            end);
            return v16;
        end;
        v13 = v20("All", 0);
        local _ = {};
        local v22 = require(game.ReplicatedStorage.Modules.Schematics.Achievements);
        for v23, v24 in pairs(v22) do
            local v25 = l_Achievements_0:WaitForChild(v23, 5);
            if v25 then
                local v26 = (tonumber(v24.LayoutOrder) or 1) * 1000;
                local v27 = l_Templates_0.Seperator:Clone();
                v27.Name = v23;
                v27.LayoutOrder = v26;
                v27.Title.Text = v24.Title or v23;
                v27.Parent = l_Contents_0;
                v27:SetAttribute("BranchName", v23);
                v20(v23, v26).Title.Text = v27.Title.Text;
                local l_pairs_0 = pairs;
                local v29 = v24.Achievements or {};
                for v30, v31 in l_pairs_0(v29) do
                    local v32 = v25:WaitForChild(v30, 5);
                    if v32 then
                        local v33 = l_Templates_0.Achievement:Clone();
                        v33.Name = v30;
                        v33.LayoutOrder = v26 + (tonumber(v31.LayoutOrder) or 1);
                        v33.Title.Text = v31.Title or v30;
                        v33.Description.Text = tostring(v31.Description);
                        v33.Icon.Image = tostring(v31.Icon);
                        v33.Visible = v31.Hidden;
                        v33.Parent = l_Contents_0;
                        v33:SetAttribute("BranchName", v23);
                        v11 = v11 + 1;
                        if v31.RewardType then
                            if v31.RewardType == "Currency" then
                                v33.RewardOverlay.RewardTitle.Text = ("+ %*$"):format(v31.Amount and tostring(v5:ToCommas(v31.Amount)) or "???");
                            elseif v31.RewardType == "Emote" or v31.RewardType == "Skin" then
                                local v34 = {};
                                local l_pairs_1 = pairs;
                                local v36 = v31.Emotes or {};
                                for _, v38 in l_pairs_1(v36) do
                                    table.insert(v34, (("%* (Emote)"):format((v38:gsub("(%l)(%u)", "%1 %2")))));
                                end;
                                l_pairs_1 = pairs;
                                v36 = v31.Skins or {};
                                for _, v40 in l_pairs_1(v36) do
                                    table.insert(v34, (("%* (Skin)"):format((v40:gsub("(%l)(%u)", "%1 %2")))));
                                end;
                                if v31.Skin then
                                    table.insert(v34, (("%* (Skin)"):format((v31.Skin:gsub("(%l)(%u)", "%1 %2")))));
                                end;
                                if v31.Emote then
                                    table.insert(v34, (("%* (Emote)"):format((v31.Emote:gsub("(%l)(%u)", "%1 %2")))));
                                end;
                                v33.RewardOverlay.RewardTitle.Text = table.concat(v34, " + ");
                            end;
                            v33.MouseEnter:Connect(function() --[[ Line: 118 ]]
                                -- upvalues: v4 (copy), v33 (copy)
                                v4:Play("hover");
                                v33.RewardOverlay.Visible = true;
                            end);
                            v33.MouseLeave:Connect(function() --[[ Line: 119 ]]
                                -- upvalues: v4 (copy), v33 (copy)
                                v4:Play("hoverEnd");
                                v33.RewardOverlay.Visible = false;
                            end);
                        else
                            v33.RewardOverlay:Destroy();
                        end;
                        local function _() --[[ Line: 125 ]] --[[ Name: markAsCompleted ]]
                            -- upvalues: v33 (copy), v31 (copy), v10 (ref), v9 (ref), l_AchievementsContainer_0 (copy), v11 (ref)
                            local l_IncompleteOverlay_0 = v33:FindFirstChild("IncompleteOverlay");
                            if l_IncompleteOverlay_0 then
                                l_IncompleteOverlay_0:Destroy();
                                if v31.Hidden then
                                    v33.Visible = true;
                                    v10 = v10 + 1;
                                else
                                    v9 = v9 + 1;
                                end;
                                l_AchievementsContainer_0.MainTitle.Title.Text = ("Achievements -- %*/%*%* Unlocked"):format(v9, v11, v10 > 0 and (" (+%*)"):format(v9) or "");
                            end;
                        end;
                        local function v48() --[[ Line: 135 ]] --[[ Name: updateProgress ]]
                            -- upvalues: v32 (copy), v33 (copy), v31 (copy), v10 (ref), v9 (ref), l_AchievementsContainer_0 (copy), v11 (ref), l_LocalPlayer_0 (copy)
                            if v32:IsA("BoolValue") then
                                v33.Progress.Visible = false;
                                v33.ProgressBar.Visible = false;
                                if v32.Value then
                                    local l_IncompleteOverlay_1 = v33:FindFirstChild("IncompleteOverlay");
                                    if l_IncompleteOverlay_1 then
                                        l_IncompleteOverlay_1:Destroy();
                                        if v31.Hidden then
                                            v33.Visible = true;
                                            v10 = v10 + 1;
                                        else
                                            v9 = v9 + 1;
                                        end;
                                        l_AchievementsContainer_0.MainTitle.Title.Text = ("Achievements -- %*/%*%* Unlocked"):format(v9, v11, v10 > 0 and (" (+%*)"):format(v9) or "");
                                        return;
                                    end;
                                end;
                            elseif v32:IsA("IntValue") and v31.Requirement then
                                local v44 = typeof(v31.Requirement) == "function" and v31.Requirement(l_LocalPlayer_0) or v31.Requirement;
                                local v45 = math.clamp(v32.Value / v44, 0, 1);
                                local v46 = v45 == 0 and 0 or 1 / v45;
                                v33.ProgressBar.Clipping.Size = UDim2.fromScale(v45, 1);
                                v33.ProgressBar.Clipping.Top.Size = UDim2.fromScale(v46, 1);
                                v33.Progress.Text = ("%*/%*"):format(math.round((math.clamp(v32.Value, 0, v44))), (math.round(v44)));
                                if v44 <= v32.Value then
                                    local l_IncompleteOverlay_2 = v33:FindFirstChild("IncompleteOverlay");
                                    if l_IncompleteOverlay_2 then
                                        l_IncompleteOverlay_2:Destroy();
                                        if v31.Hidden then
                                            v33.Visible = true;
                                            v10 = v10 + 1;
                                        else
                                            v9 = v9 + 1;
                                        end;
                                        l_AchievementsContainer_0.MainTitle.Title.Text = ("Achievements -- %*/%*%* Unlocked"):format(v9, v11, v10 > 0 and (" (+%*)"):format(v9) or "");
                                    end;
                                end;
                            end;
                        end;
                        v32:GetPropertyChangedSignal("Value"):Connect(v48);
                        v48();
                        task.wait();
                    end;
                end;
            end;
        end;
        l_AchievementsContainer_0.MainTitle.Title.Text = ("Achievements -- %*/%*%* Unlocked"):format(v9, v11, v10 > 0 and (" (+%*)"):format(v9) or "");
    end);
end;
return v0;