-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = {
    "rbxassetid://18912545699", 
    "rbxassetid://18912579017", 
    "rbxassetid://18912582649"
};
v0.SwitchTab = function(_, v3) --[[ Line: 10 ]] --[[ Name: SwitchTab ]]
    -- upvalues: v0 (copy)
    if v0.LastTab == v3 then
        return;
    else
        local l_Menu_0 = v0.ShopMenu.Menu;
        local l_InfoContainer_0 = l_Menu_0.ShopRoot.InfoContainer;
        local l_SideContainer_0 = l_Menu_0.ShopRoot.SideContainer;
        local l_ShopContainer_0 = l_Menu_0.ShopRoot.ShopContainer;
        local l_Topbar_0 = l_ShopContainer_0.Topbar;
        local l_Searchbar_0 = l_Topbar_0.Searchbar;
        if v0.ShopMenu.Menu.Visible and (v3 ~= "Robux" or v0.ShopMenu.Menu.Size.Y.Scale >= 0.2) then
            require(game.ReplicatedStorage.Modules.Sounds):Play("select");
        end;
        game.TweenService:Create(l_SideContainer_0, TweenInfo.new(0.4), {
            Size = UDim2.fromScale(0, 1)
        }):Play();
        game.TweenService:Create(l_InfoContainer_0, TweenInfo.new(0.4), {
            Size = UDim2.fromScale(0, 1)
        }):Play();
        game.TweenService:Create(l_ShopContainer_0, TweenInfo.new(0.4), {
            Size = UDim2.fromScale(0.7, 1)
        }):Play();
        l_ShopContainer_0.Contents.UIPadding.PaddingTop = UDim.new(0, workspace.CurrentCamera.ViewportSize.Y / 40);
        for _, v11 in pairs(l_Topbar_0:GetChildren()) do
            if v11:IsA("ImageButton") then
                game.TweenService:Create(v11, TweenInfo.new(0.25), {
                    ImageColor3 = v3 == v11.Name and Color3.new(1, 1, 1) or Color3.new()
                }):Play();
                game.TweenService:Create(v11.Title, TweenInfo.new(0.25), {
                    TextColor3 = v3 == v11.Name and Color3.new() or Color3.new(1, 1, 1)
                }):Play();
            end;
        end;
        for _, v13 in pairs(l_ShopContainer_0.Contents:GetChildren()) do
            if v13:IsA("GuiObject") or v13:IsA("Folder") then
                v13.Parent = nil;
            end;
        end;
        local l_FirstChild_0 = script.Tabs:FindFirstChild((tostring(v0.LastTab)));
        local v15 = l_FirstChild_0 and require(l_FirstChild_0);
        if v15 and v15.Selected then
            v15:Deselected(l_Menu_0);
        end;
        local v16 = v0.__tabsData[v3];
        if v16 then
            for _, v18 in pairs(v16) do
                local l_Container_0 = v18:FindFirstChild("Container");
                local v20 = l_Container_0 and l_Container_0:FindFirstChild("Title");
                if v18:IsA("GuiObject") then
                    v18.Visible = not v20 or l_Searchbar_0.TextBox.Text == "" or string.find(v20.Text:lower(), l_Searchbar_0.TextBox.Text:lower());
                end;
                v18.Parent = l_ShopContainer_0.Contents;
            end;
        end;
        local l_FirstChild_1 = script.Tabs:FindFirstChild(v3);
        local v22 = l_FirstChild_1 and require(l_FirstChild_1);
        if v22 and v22.Selected then
            v22:Selected(l_Menu_0);
        end;
        v0.LastTab = v3;
        return;
    end;
end;
v0.Start = function(_) --[[ Line: 78 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local l_Purchased_0 = l_LocalPlayer_0:WaitForChild("PlayerData"):WaitForChild("Purchased");
    local v26 = require(game.ReplicatedStorage.Initializer);
    local v27 = require(game.ReplicatedStorage.Modules.Network);
    local v28 = require(game.ReplicatedStorage.Modules.Sounds);
    local l_TextService_0 = game:GetService("TextService");
    local l_UserInputService_0 = game:GetService("UserInputService");
    v0.ShopMenu = v26.PlayerSystems.SidebarHandler:CreateSidebarMenu("Shop", script.ShopScreen);
    local l_Menu_1 = v0.ShopMenu.Menu;
    local l_SideContainer_1 = l_Menu_1.ShopRoot.SideContainer;
    local l_InfoContainer_1 = l_Menu_1.ShopRoot.InfoContainer;
    local l_ShopContainer_1 = l_Menu_1.ShopRoot.ShopContainer;
    local l_SkinsContainer_0 = l_Menu_1.ShopRoot.SkinsContainer;
    local l_PurchaseContainer_0 = l_SideContainer_1.PurchaseContainer;
    local l_Topbar_1 = l_ShopContainer_1.Topbar;
    local l_Searchbar_1 = l_Topbar_1.Searchbar;
    local function _(v39) --[[ Line: 103 ]] --[[ Name: updateCanvasSize ]]
        v39.CanvasSize = UDim2.fromScale(1, 0);
        if v39.AbsoluteCanvasSize.Y > v39.AbsoluteWindowSize.Y then
            v39.CanvasSize = UDim2.new(1, 0, 0, v39.AbsoluteCanvasSize.Y * 1.05);
        end;
    end;
    l_ShopContainer_1.Contents.ChildAdded:Connect(function() --[[ Line: 111 ]]
        -- upvalues: l_ShopContainer_1 (copy)
        local l_Contents_0 = l_ShopContainer_1.Contents;
        l_Contents_0.CanvasSize = UDim2.fromScale(1, 0);
        if l_Contents_0.AbsoluteCanvasSize.Y > l_Contents_0.AbsoluteWindowSize.Y then
            l_Contents_0.CanvasSize = UDim2.new(1, 0, 0, l_Contents_0.AbsoluteCanvasSize.Y * 1.05);
        end;
    end);
    l_ShopContainer_1.Contents.ChildRemoved:Connect(function() --[[ Line: 112 ]]
        -- upvalues: l_ShopContainer_1 (copy)
        local l_Contents_1 = l_ShopContainer_1.Contents;
        l_Contents_1.CanvasSize = UDim2.fromScale(1, 0);
        if l_Contents_1.AbsoluteCanvasSize.Y > l_Contents_1.AbsoluteWindowSize.Y then
            l_Contents_1.CanvasSize = UDim2.new(1, 0, 0, l_Contents_1.AbsoluteCanvasSize.Y * 1.05);
        end;
    end);
    l_ShopContainer_1:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 113 ]]
        -- upvalues: l_ShopContainer_1 (copy)
        local l_Contents_2 = l_ShopContainer_1.Contents;
        l_Contents_2.CanvasSize = UDim2.fromScale(1, 0);
        if l_Contents_2.AbsoluteCanvasSize.Y > l_Contents_2.AbsoluteWindowSize.Y then
            l_Contents_2.CanvasSize = UDim2.new(1, 0, 0, l_Contents_2.AbsoluteCanvasSize.Y * 1.05);
        end;
    end);
    l_SkinsContainer_0.Contents.ChildAdded:Connect(function() --[[ Line: 114 ]]
        -- upvalues: l_SkinsContainer_0 (copy)
        local l_Contents_3 = l_SkinsContainer_0.Contents;
        l_Contents_3.CanvasSize = UDim2.fromScale(1, 0);
        if l_Contents_3.AbsoluteCanvasSize.Y > l_Contents_3.AbsoluteWindowSize.Y then
            l_Contents_3.CanvasSize = UDim2.new(1, 0, 0, l_Contents_3.AbsoluteCanvasSize.Y * 1.05);
        end;
    end);
    l_SkinsContainer_0.Contents.ChildRemoved:Connect(function() --[[ Line: 115 ]]
        -- upvalues: l_SkinsContainer_0 (copy)
        local l_Contents_4 = l_SkinsContainer_0.Contents;
        l_Contents_4.CanvasSize = UDim2.fromScale(1, 0);
        if l_Contents_4.AbsoluteCanvasSize.Y > l_Contents_4.AbsoluteWindowSize.Y then
            l_Contents_4.CanvasSize = UDim2.new(1, 0, 0, l_Contents_4.AbsoluteCanvasSize.Y * 1.05);
        end;
    end);
    l_SideContainer_1.Size = UDim2.fromScale(0, 1);
    l_SideContainer_1.Visible = false;
    l_PurchaseContainer_0.ButtonDescription.Title.TextTransparency = 1;
    v0.ShopMenu.Toggled:Connect(function(_) --[[ Line: 124 ]]
        -- upvalues: l_PurchaseContainer_0 (copy), l_SideContainer_1 (copy), l_InfoContainer_1 (copy), l_SkinsContainer_0 (copy), l_ShopContainer_1 (copy)
        game.TweenService:Create(l_PurchaseContainer_0.Buttons.ViewSkins.Inverted, TweenInfo.new(0.25), {
            ImageTransparency = 1
        }):Play();
        game.TweenService:Create(l_PurchaseContainer_0.Buttons.ViewInfo.Inverted, TweenInfo.new(0.25), {
            ImageTransparency = 1
        }):Play();
        game.TweenService:Create(l_SideContainer_1, TweenInfo.new(0.4), {
            Size = UDim2.fromScale(0, 1)
        }):Play();
        game.TweenService:Create(l_InfoContainer_1, TweenInfo.new(0.4), {
            Size = UDim2.fromScale(0, 1)
        }):Play();
        game.TweenService:Create(l_SkinsContainer_0, TweenInfo.new(0.4), {
            Size = UDim2.fromScale(0, 1)
        }):Play();
        game.TweenService:Create(l_ShopContainer_1, TweenInfo.new(0.4), {
            Size = UDim2.fromScale(0.7, 1)
        }):Play();
        task.delay(0.25, function() --[[ Line: 131 ]]
            -- upvalues: l_ShopContainer_1 (ref)
            l_ShopContainer_1.Visible = true;
        end);
    end);
    local function v48(v47) --[[ Line: 137 ]] --[[ Name: addUIThingies ]]
        -- upvalues: v28 (copy)
        if v47.Name ~= "Money" and (v47:IsA("TextButton") or v47:IsA("ImageButton")) and not v47:GetAttribute("SFXImplemented") then
            v47:SetAttribute("SFXImplemented", true);
            v47.MouseEnter:Connect(function() --[[ Line: 141 ]]
                -- upvalues: v28 (ref)
                v28:Play("hover");
            end);
            v47.MouseLeave:Connect(function() --[[ Line: 145 ]]
                -- upvalues: v28 (ref)
                v28:Play("hoverEnd");
            end);
            if v47.Parent.Name ~= "Topbar" then
                v47.MouseButton1Click:Connect(function() --[[ Line: 150 ]]
                    -- upvalues: v28 (ref)
                    v28:Play("select");
                end);
            end;
        end;
    end;
    for _, v50 in pairs(l_Menu_1:GetDescendants()) do
        v48(v50);
    end;
    l_Menu_1.DescendantAdded:Connect(v48);
    local v51 = require(game.ReplicatedStorage.Modules.Util);
    v51:CreateMoneyDisplay(l_ShopContainer_1.Money);
    local function v55(v52) --[[ Line: 164 ]] --[[ Name: markContentAsPurchased ]]
        -- upvalues: l_Purchased_0 (copy)
        if v52:IsA("Frame") and not v52.Container:FindFirstChild("Purchased") and l_Purchased_0:FindFirstChild(v52.Name, true) then
            local l_Frame_0 = Instance.new("Frame");
            l_Frame_0.Name = "Purchased";
            l_Frame_0.ZIndex = 10;
            l_Frame_0.BorderSizePixel = 0;
            l_Frame_0.BackgroundTransparency = 0.25;
            l_Frame_0.BackgroundColor3 = Color3.new();
            l_Frame_0.Position = UDim2.fromScale(0.5, 0.5);
            l_Frame_0.AnchorPoint = Vector2.new(0.5, 0.5);
            l_Frame_0.Size = UDim2.fromScale(1.05, 1.05);
            l_Frame_0.Parent = v52.Container;
            local l_TextLabel_0 = Instance.new("TextLabel");
            l_TextLabel_0.Name = "Title";
            l_TextLabel_0.Text = "Owned";
            l_TextLabel_0.BackgroundTransparency = 1;
            l_TextLabel_0.TextScaled = true;
            l_TextLabel_0.Size = UDim2.fromScale(0.85, 0.125);
            l_TextLabel_0.Position = UDim2.fromScale(0.5, 0.5);
            l_TextLabel_0.AnchorPoint = Vector2.new(0.5, 0.5);
            l_TextLabel_0.TextColor3 = Color3.new(1, 1, 1);
            l_TextLabel_0.FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json");
            l_TextLabel_0.Parent = l_Frame_0;
            v52.LayoutOrder = v52.LayoutOrder + 100000000;
        end;
    end;
    local function v67(v56) --[[ Line: 194 ]] --[[ Name: promptPurchaseConfirmation ]]
        -- upvalues: v0 (ref), l_Menu_1 (copy), l_Purchased_0 (copy), v27 (copy)
        local v57 = v56 and v56:FindFirstChild("Config") or v0.CurrentlySelected and (v0.CurrentlySelected:FindFirstChild("Config") or v0.CurrentlySelected:IsA("ModuleScript") and v0.CurrentlySelected);
        local v58 = v57 and require(v57);
        if v58 and not l_Menu_1:FindFirstChild("ConfirmPurchase") then
            local v59 = script.Templates.ConfirmPurchase:Clone();
            v59.Size = UDim2.fromScale(0.3, 0);
            v59.Title.Text = ("Are you sure you would like to purchase <b><font color=\"rgb(255,255,255)\">%*</font></b> for <b><font color=\"rgb(255,255,255)\">%*</font></b>?"):format(tostring(v58.DisplayName), v58.Price <= 0 and "FREE" or ("%*$"):format((tostring(v58.Price))));
            v59.Parent = l_Menu_1;
            game.TweenService:Create(v59, TweenInfo.new(0.3), {
                Size = UDim2.fromScale(0.3, 0.3)
            }):Play();
            if v56 and not l_Purchased_0.Killers:FindFirstChild((tostring(v0.CurrentlySelected))) and not l_Purchased_0.Survivors:FindFirstChild((tostring(v0.CurrentlySelected))) then
                v59.Disclaimer.Text = "DISCLAIMER:\nYou don't own this character yet.\nWhatever you're trying to do right now is dumb.";
            elseif v58.DisclaimerText then
                v59.Disclaimer.Text = ("DISCLAIMER:\n%*"):format((tostring(v58.DisclaimerText)));
            end;
            local v60 = false;
            local v61 = false;
            local l_Title_0 = v59.Buttons.Yes.Title;
            local v63 = v56 or v0.CurrentlySelected;
            do
                local l_v60_0, l_v61_0 = v60, v61;
                v59.Buttons.Yes.MouseButton1Click:Connect(function() --[[ Line: 217 ]]
                    -- upvalues: l_v60_0 (ref), l_Title_0 (copy), v27 (ref), v63 (copy), l_v61_0 (ref), v59 (copy)
                    if not l_v60_0 then
                        l_v60_0 = true;
                        l_Title_0.Text = "...";
                        local v66 = v27:FireServerConnection("PurchaseContent", "REMOTE_FUNCTION", v63);
                        if v66 == "success" then
                            l_Title_0.Text = "Bought!";
                            task.wait(0.5);
                            if not l_v61_0 then
                                l_v61_0 = true;
                                game.TweenService:Create(v59, TweenInfo.new(0.3), {
                                    Size = UDim2.fromScale(0.3, 0)
                                }):Play();
                                game.Debris:AddItem(v59, 0.3);
                            end;
                            return;
                        else
                            if v66 == "poor" then
                                l_Title_0.Text = "Insufficient funds!";
                            elseif v66 == "alreadyBought" then
                                l_Title_0.Text = "Already owned!";
                            end;
                            task.delay(0.5, function() --[[ Line: 245 ]]
                                -- upvalues: l_v60_0 (ref), l_Title_0 (ref)
                                l_v60_0 = false;
                                l_Title_0.Text = "Yes";
                            end);
                        end;
                    end;
                end);
                v59.Buttons.No.MouseButton1Click:Connect(function() --[[ Line: 253 ]]
                    -- upvalues: l_v61_0 (ref), v59 (copy)
                    if not l_v61_0 then
                        l_v61_0 = true;
                        game.TweenService:Create(v59, TweenInfo.new(0.3), {
                            Size = UDim2.fromScale(0.3, 0)
                        }):Play();
                        game.Debris:AddItem(v59, 0.3);
                    end;
                end);
            end;
        end;
    end;
    l_PurchaseContainer_0.Purchase.MouseButton1Click:Connect(v67);
    l_SkinsContainer_0.Contents.ChildAdded:Connect(v55);
    l_ShopContainer_1.Contents.ChildAdded:Connect(v55);
    l_Purchased_0.DescendantAdded:Connect(function(v68) --[[ Line: 269 ]]
        -- upvalues: l_ShopContainer_1 (copy), l_SkinsContainer_0 (copy), v55 (copy)
        local v69 = l_ShopContainer_1.Contents:FindFirstChild(v68.Name) or l_SkinsContainer_0.Contents:FindFirstChild(v68.Name);
        if v69 then
            v55(v69);
        end;
    end);
    local v70 = nil;
    local function v133(v71) --[[ Line: 278 ]] --[[ Name: loadActorInfo ]]
        -- upvalues: v70 (ref), l_InfoContainer_1 (copy), l_Menu_1 (copy), l_LocalPlayer_0 (copy), l_UserInputService_0 (copy), l_TextService_0 (copy), v51 (copy)
        if v70 ~= v71 then
            v70 = v71;
            local l_Templates_0 = script.Templates;
            local v73 = {};
            for _, v75 in pairs(l_InfoContainer_1.Contents:GetChildren()) do
                if v75:IsA("GuiObject") then
                    v75:Destroy();
                end;
            end;
            local l_pairs_0 = pairs;
            local v77 = v71 or {};
            for v78, v79 in l_pairs_0(v77) do
                local l_Frame_1 = Instance.new("Frame");
                l_Frame_1.Name = "Content";
                l_Frame_1.BackgroundTransparency = 1;
                l_Frame_1.Size = UDim2.fromScale(1, 0);
                l_Frame_1.AutomaticSize = Enum.AutomaticSize.Y;
                l_Frame_1.LayoutOrder = v78;
                l_Frame_1.Parent = l_InfoContainer_1.Contents;
                local l_UIListLayout_0 = Instance.new("UIListLayout");
                l_UIListLayout_0.Padding = UDim.new(0, 10);
                l_UIListLayout_0.HorizontalAlignment = Enum.HorizontalAlignment.Center;
                l_UIListLayout_0.Parent = l_Frame_1;
                local _ = workspace.CurrentCamera.ViewportSize.Y;
                for v83, v84 in pairs(v79) do
                    if v83 == "Separator" then
                        local v85 = l_Templates_0.Seperator:Clone();
                        v85.Title.Text = tostring(v84);
                        v85.Parent = l_Frame_1;
                    elseif v83 == "Header" then
                        local v86 = l_Templates_0.Header:Clone();
                        v86.Text = tostring(v84);
                        v86.Parent = l_Frame_1;
                    elseif v83 == "Quote" then
                        local v87 = l_Templates_0.Quote:Clone();
                        v87.Text = tostring(v84);
                        v87.Parent = l_Frame_1;
                    elseif v83 == "Text" then
                        local v88 = l_Templates_0.TextContainer:Clone();
                        v88.Title.MaxVisibleGraphemes = 0;
                        v88.Title.Text = tostring(v84);
                        v88.Image.Image = tostring(v79.Image);
                        v88.Image.Visible = v79.Image;
                        v88.Parent = l_Frame_1;
                        table.insert(v73, v88.Title);
                        game.TweenService:Create(v88.Title, TweenInfo.new(5, Enum.EasingStyle.Quint), {
                            MaxVisibleGraphemes = #v88.Title.Text + 10
                        }):Play();
                    end;
                end;
            end;
            task.spawn(function() --[[ Line: 346 ]]
                -- upvalues: v71 (copy), v70 (ref), l_Menu_1 (ref), l_InfoContainer_1 (ref), l_LocalPlayer_0 (ref), l_UserInputService_0 (ref), v73 (copy), l_TextService_0 (ref), v51 (ref)
                local v89 = false;
                local v90 = {};
                local function v91(v92) --[[ Line: 349 ]] --[[ Name: addStatus ]]
                    -- upvalues: v91 (copy), v90 (copy)
                    if v92:IsA("Folder") then
                        for _, v94 in pairs(v92:GetChildren()) do
                            v91(v94);
                        end;
                        return;
                    else
                        if v92:IsA("ModuleScript") then
                            local v95 = require(v92);
                            v90[v92.Name] = v95.Data.Description or "???";
                        end;
                        return;
                    end;
                end;
                v91(game.ReplicatedStorage.Modules.StatusEffects);
                local v96 = nil;
                while task.wait() and v71 and v70 == v71 do
                    if l_Menu_1.Visible and l_InfoContainer_1.Size.X.Scale >= 0.5 and l_LocalPlayer_0.Character and tostring(l_LocalPlayer_0.Character.Parent) == "Spectating" then
                        local v97 = l_UserInputService_0:GetMouseLocation() - game.GuiService:GetGuiInset();
                        local v98 = false;
                        for _, v100 in pairs(v73) do
                            if not v98 then
                                local l_AbsolutePosition_0 = v100.AbsolutePosition;
                                local l_AbsoluteSize_0 = v100.AbsoluteSize;
                                if v97.X >= l_AbsolutePosition_0.X and v97.X <= l_AbsolutePosition_0.X + l_AbsoluteSize_0.X and v97.Y >= l_AbsolutePosition_0.Y and v97.Y <= l_AbsolutePosition_0.Y + l_AbsoluteSize_0.Y then
                                    local v103 = v100.Text:gsub("<.->", "");
                                    local l_Font_0 = v100.Font;
                                    local l_TextSize_0 = v100.TextSize;
                                    local l_X_0 = l_AbsoluteSize_0.X;
                                    local v107 = v103:split("\n");
                                    local v108 = {};
                                    for _, v110 in ipairs(v107) do
                                        local v111 = v110:split(" ");
                                        local v112 = {};
                                        local v113 = 0;
                                        for _, v115 in ipairs(v111) do
                                            local l_l_TextService_0_TextSize_0 = l_TextService_0:GetTextSize(v115, l_TextSize_0, l_Font_0, Vector2.new(l_X_0, 1e999));
                                            local l_X_1 = l_TextService_0:GetTextSize(" ", l_TextSize_0, l_Font_0, Vector2.new(l_X_0, 1e999)).X;
                                            if l_X_0 < v113 + l_l_TextService_0_TextSize_0.X then
                                                table.insert(v108, v112);
                                                v112 = {};
                                                v113 = 0;
                                            end;
                                            table.insert(v112, v115);
                                            v113 = v113 + l_l_TextService_0_TextSize_0.X + l_X_1;
                                        end;
                                        if #v112 > 0 then
                                            table.insert(v108, v112);
                                        end;
                                    end;
                                    local l_Y_1 = l_TextService_0:GetTextSize("Test", l_TextSize_0, l_Font_0, Vector2.new(l_X_0, 1e999)).Y;
                                    local v119 = 0;
                                    for _, v121 in ipairs(v108) do
                                        if not v98 then
                                            local v122 = l_AbsolutePosition_0.Y + v119;
                                            local v123 = v122 + l_Y_1;
                                            if v122 <= v97.Y and v97.Y <= v123 then
                                                local v124 = 0;
                                                for _, v126 in ipairs(v121) do
                                                    local l_l_TextService_0_TextSize_1 = l_TextService_0:GetTextSize(v126, l_TextSize_0, l_Font_0, Vector2.new(l_X_0, 1e999));
                                                    local v128 = l_AbsolutePosition_0.X + v124;
                                                    local v129 = v128 + l_l_TextService_0_TextSize_1.X;
                                                    if v128 <= v97.X and v97.X <= v129 then
                                                        local _ = game.ReplicatedStorage.Modules.StatusEffects;
                                                        local v131 = v90[v126];
                                                        if v131 then
                                                            v98 = true;
                                                            v96 = v51:CreateTooltip(v131);
                                                            v89 = true;
                                                        else
                                                            v89 = true;
                                                        end;
                                                    else
                                                        local l_X_2 = l_TextService_0:GetTextSize(" ", l_TextSize_0, l_Font_0, Vector2.new(l_X_0, 1e999)).X;
                                                        v124 = v124 + l_l_TextService_0_TextSize_1.X + l_X_2;
                                                    end;
                                                    if v89 then
                                                        break;
                                                    end;
                                                    if v89 then
                                                        break;
                                                    end;
                                                end;
                                                if not v89 then
                                                    if not v89 then
                                                        break;
                                                    end;
                                                end;
                                            else
                                                v119 = v119 + l_Y_1;
                                            end;
                                        else
                                            break;
                                        end;
                                        if v89 then
                                            break;
                                        end;
                                        if v89 then
                                            break;
                                        end;
                                    end;
                                end;
                            else
                                break;
                            end;
                            v89 = false;
                        end;
                        if not v98 then
                            v96 = v51:CreateTooltip();
                        end;
                    elseif v96 then
                        v96 = v51:CreateTooltip();
                    end;
                end;
            end);
        end;
    end;
    local v134 = nil;
    local function v148(v135) --[[ Line: 472 ]] --[[ Name: loadActorSkins ]]
        -- upvalues: v134 (ref), l_SkinsContainer_0 (copy), v0 (ref), v67 (copy)
        if v135 and v134 ~= v135 then
            v134 = v135;
            for _, v137 in pairs(l_SkinsContainer_0.Contents:GetChildren()) do
                if v137:IsA("GuiObject") then
                    v137:Destroy();
                end;
            end;
            local v138 = v0.CurrentlySelected and v0.CurrentlySelected:FindFirstChild("Config");
            local v139 = v138 and require(v138);
            l_SkinsContainer_0.TitleDisplay.Title.Text = ("%* Skins"):format(v139.DisplayName or tostring(v135.Name));
            for _, v141 in pairs(v135:GetChildren()) do
                local v142 = require(v141.Config);
                if not v142.Exclusive then
                    local v143 = script.Templates.CardTemplate:Clone();
                    local l_Container_1 = v143.Container;
                    v143.Name = v141.Name;
                    v143.LayoutOrder = v142.Price or 1000;
                    v143.Parent = l_SkinsContainer_0.Contents;
                    l_Container_1.CharacterRender.Image = v142.RenderImage or "rbxassetid://13373279056";
                    l_Container_1.Title.Text = tostring(v142.DisplayName);
                    l_Container_1.Price.Text = v142.Price <= 0 and "FREE" or ("%*$"):format((tostring(v142.Price)));
                    local v145 = nil;
                    if v142.ExclusiveText then
                        script.Templates.ExclusiveGradient:Clone().Parent = l_Container_1.Outline;
                        l_Container_1.Outline.ImageColor3 = Color3.new(1, 1, 1);
                        v145 = script.Templates.ExclusiveTitle:Clone();
                        v145.Text = tostring(v142.ExclusiveText);
                        v145.Parent = l_Container_1;
                    end;
                    local l_Name_0 = v135.Parent.Name;
                    if l_Name_0 == "Survivors" then
                        l_Container_1.Title.TextColor3 = Color3.fromRGB(200, 200, 255);
                    elseif l_Name_0 == "Killers" then
                        l_Container_1.Title.TextColor3 = Color3.fromRGB(255, 200, 200);
                    end;
                    do
                        local l_v145_0 = v145;
                        l_Container_1.MouseEnter:Connect(function() --[[ Line: 523 ]]
                            -- upvalues: l_Container_1 (copy), l_v145_0 (ref)
                            game.TweenService:Create(l_Container_1, TweenInfo.new(0.25), {
                                Size = UDim2.fromScale(1.05, 1.05)
                            }):Play();
                            if l_v145_0 then
                                game.TweenService:Create(l_v145_0, TweenInfo.new(0.175), {
                                    TextTransparency = 0, 
                                    TextStrokeTransparency = 0
                                }):Play();
                            end;
                        end);
                        l_Container_1.MouseLeave:Connect(function() --[[ Line: 528 ]]
                            -- upvalues: l_Container_1 (copy), l_v145_0 (ref)
                            game.TweenService:Create(l_Container_1, TweenInfo.new(0.25), {
                                Size = UDim2.fromScale(1, 1)
                            }):Play();
                            if l_v145_0 then
                                game.TweenService:Create(l_v145_0, TweenInfo.new(0.175), {
                                    TextTransparency = 1, 
                                    TextStrokeTransparency = 1
                                }):Play();
                            end;
                        end);
                        l_Container_1.Interact.MouseButton1Click:Connect(function() --[[ Line: 533 ]]
                            -- upvalues: l_Container_1 (copy), v67 (ref), v141 (copy)
                            if not l_Container_1:FindFirstChild("Purchased") then
                                v67(v141);
                            end;
                        end);
                    end;
                end;
            end;
        end;
    end;
    local v149 = nil;
    local v150 = false;
    l_PurchaseContainer_0.Buttons.ViewInfo.MouseButton1Click:Connect(function() --[[ Line: 545 ]]
        -- upvalues: v150 (ref), v0 (ref), v133 (copy), v149 (ref), l_InfoContainer_1 (copy), l_PurchaseContainer_0 (copy), l_SkinsContainer_0 (copy), l_ShopContainer_1 (copy)
        if v150 then
            return;
        else
            v150 = true;
            local v151 = v0.CurrentlySelected and v0.CurrentlySelected:FindFirstChild("Config");
            local v152 = v151 and require(v151);
            if v152 and v152.Information then
                v133(v152.Information);
                if v149 then
                    task.cancel(v149);
                end;
                if l_InfoContainer_1.Size.X.Scale >= 0.35 then
                    game.TweenService:Create(l_PurchaseContainer_0.Buttons.ViewSkins.Inverted, TweenInfo.new(0.25), {
                        ImageTransparency = 1
                    }):Play();
                    game.TweenService:Create(l_PurchaseContainer_0.Buttons.ViewInfo.Inverted, TweenInfo.new(0.25), {
                        ImageTransparency = 1
                    }):Play();
                    game.TweenService:Create(l_SkinsContainer_0, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(0, 1)
                    }):Play();
                    game.TweenService:Create(l_InfoContainer_1, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(0, 1)
                    }):Play();
                    game.TweenService:Create(l_ShopContainer_1, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(0.7, 1)
                    }):Play();
                    v149 = task.delay(0.25, function() --[[ Line: 560 ]]
                        -- upvalues: l_SkinsContainer_0 (ref), l_InfoContainer_1 (ref)
                        l_SkinsContainer_0.Visible = false;
                        l_InfoContainer_1.Visible = false;
                    end);
                    task.delay(0.175, function() --[[ Line: 561 ]]
                        -- upvalues: v150 (ref)
                        v150 = false;
                    end);
                    l_ShopContainer_1.Visible = true;
                    return;
                else
                    game.TweenService:Create(l_PurchaseContainer_0.Buttons.ViewSkins.Inverted, TweenInfo.new(0.25), {
                        ImageTransparency = 1
                    }):Play();
                    game.TweenService:Create(l_PurchaseContainer_0.Buttons.ViewInfo.Inverted, TweenInfo.new(0.25), {
                        ImageTransparency = 0
                    }):Play();
                    game.TweenService:Create(l_SkinsContainer_0, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(0, 1)
                    }):Play();
                    game.TweenService:Create(l_InfoContainer_1, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(0.7, 1)
                    }):Play();
                    game.TweenService:Create(l_ShopContainer_1, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(0, 1)
                    }):Play();
                    v149 = task.delay(0.25, function() --[[ Line: 569 ]]
                        -- upvalues: l_SkinsContainer_0 (ref), l_ShopContainer_1 (ref)
                        l_SkinsContainer_0.Visible = false;
                        l_ShopContainer_1.Visible = false;
                    end);
                    task.delay(0.175, function() --[[ Line: 570 ]]
                        -- upvalues: v150 (ref)
                        v150 = false;
                    end);
                    l_InfoContainer_1.Visible = true;
                end;
            end;
            return;
        end;
    end);
    l_PurchaseContainer_0.Buttons.ViewSkins.MouseButton1Click:Connect(function() --[[ Line: 577 ]]
        -- upvalues: v150 (ref), v0 (ref), v148 (copy), v149 (ref), l_SkinsContainer_0 (copy), l_PurchaseContainer_0 (copy), l_InfoContainer_1 (copy), l_ShopContainer_1 (copy)
        if v150 then
            return;
        else
            v150 = true;
            if not v0.CurrentlySelected then
                return;
            else
                local l_FirstChild_2 = game.ReplicatedStorage.Assets.Skins:FindFirstChild((tostring(v0.CurrentlySelected.Parent)));
                local v154 = l_FirstChild_2 and l_FirstChild_2:FindFirstChild((tostring(v0.CurrentlySelected)));
                if v154 then
                    v148(v154);
                    if v149 then
                        task.cancel(v149);
                    end;
                    if l_SkinsContainer_0.Size.X.Scale >= 0.35 then
                        game.TweenService:Create(l_PurchaseContainer_0.Buttons.ViewSkins.Inverted, TweenInfo.new(0.25), {
                            ImageTransparency = 1
                        }):Play();
                        game.TweenService:Create(l_PurchaseContainer_0.Buttons.ViewInfo.Inverted, TweenInfo.new(0.25), {
                            ImageTransparency = 1
                        }):Play();
                        game.TweenService:Create(l_SkinsContainer_0, TweenInfo.new(0.25), {
                            Size = UDim2.fromScale(0, 1)
                        }):Play();
                        game.TweenService:Create(l_InfoContainer_1, TweenInfo.new(0.25), {
                            Size = UDim2.fromScale(0, 1)
                        }):Play();
                        game.TweenService:Create(l_ShopContainer_1, TweenInfo.new(0.25), {
                            Size = UDim2.fromScale(0.7, 1)
                        }):Play();
                        v149 = task.delay(0.25, function() --[[ Line: 593 ]]
                            -- upvalues: l_InfoContainer_1 (ref), l_SkinsContainer_0 (ref)
                            l_InfoContainer_1.Visible = false;
                            l_SkinsContainer_0.Visible = false;
                        end);
                        task.delay(0.175, function() --[[ Line: 594 ]]
                            -- upvalues: v150 (ref)
                            v150 = false;
                        end);
                        l_ShopContainer_1.Visible = true;
                        return;
                    else
                        game.TweenService:Create(l_PurchaseContainer_0.Buttons.ViewSkins.Inverted, TweenInfo.new(0.25), {
                            ImageTransparency = 0
                        }):Play();
                        game.TweenService:Create(l_PurchaseContainer_0.Buttons.ViewInfo.Inverted, TweenInfo.new(0.25), {
                            ImageTransparency = 1
                        }):Play();
                        game.TweenService:Create(l_SkinsContainer_0, TweenInfo.new(0.25), {
                            Size = UDim2.fromScale(0.7, 1)
                        }):Play();
                        game.TweenService:Create(l_InfoContainer_1, TweenInfo.new(0.25), {
                            Size = UDim2.fromScale(0, 1)
                        }):Play();
                        game.TweenService:Create(l_ShopContainer_1, TweenInfo.new(0.25), {
                            Size = UDim2.fromScale(0, 1)
                        }):Play();
                        v149 = task.delay(0.25, function() --[[ Line: 602 ]]
                            -- upvalues: l_InfoContainer_1 (ref), l_ShopContainer_1 (ref)
                            l_InfoContainer_1.Visible = false;
                            l_ShopContainer_1.Visible = false;
                        end);
                        task.delay(0.175, function() --[[ Line: 603 ]]
                            -- upvalues: v150 (ref)
                            v150 = false;
                        end);
                        l_SkinsContainer_0.Visible = true;
                    end;
                end;
                return;
            end;
        end;
    end);
    for _, v156 in pairs(l_PurchaseContainer_0.Buttons:GetChildren()) do
        local l_v156_Attribute_0 = v156:GetAttribute("Description");
        if l_v156_Attribute_0 then
            v156.MouseEnter:Connect(function() --[[ Line: 613 ]]
                -- upvalues: l_PurchaseContainer_0 (copy), l_v156_Attribute_0 (copy)
                l_PurchaseContainer_0.ButtonDescription.Title.Text = l_v156_Attribute_0;
                game.TweenService:Create(l_PurchaseContainer_0.ButtonDescription.Title, TweenInfo.new(0.25), {
                    TextTransparency = 0
                }):Play();
            end);
            v156.MouseLeave:Connect(function() --[[ Line: 618 ]]
                -- upvalues: l_PurchaseContainer_0 (copy), l_v156_Attribute_0 (copy)
                if l_PurchaseContainer_0.ButtonDescription.Title.Text == l_v156_Attribute_0 then
                    game.TweenService:Create(l_PurchaseContainer_0.ButtonDescription.Title, TweenInfo.new(0.25), {
                        TextTransparency = 1
                    }):Play();
                end;
            end);
        end;
    end;
    v0.__tabsData = {};
    for _, v159 in pairs(script.Tabs:GetChildren()) do
        local v160 = require(v159);
        v160.Shop = v0;
        local l_v160_Tab_0 = v160:CreateTab(l_Menu_1);
        v0.__tabsData[v159.Name] = l_v160_Tab_0;
    end;
    v0:SwitchTab("Killers");
    for _, v163 in pairs(l_Topbar_1:GetChildren()) do
        if v163:IsA("ImageButton") then
            v163.MouseButton1Click:Connect(function() --[[ Line: 640 ]]
                -- upvalues: v0 (ref), v163 (copy)
                v0:SwitchTab(v163.Name);
            end);
        end;
    end;
    l_Searchbar_1.TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 647 ]]
        -- upvalues: l_ShopContainer_1 (copy), l_Searchbar_1 (copy)
        for _, v165 in pairs(l_ShopContainer_1.Contents:GetChildren()) do
            if v165:IsA("Frame") then
                local l_Title_1 = v165.Container.Title;
                pcall(function() --[[ Line: 651 ]]
                    -- upvalues: v165 (copy), l_Searchbar_1 (ref), l_Title_1 (copy)
                    local l_v165_0 = v165;
                    local v168 = true;
                    if l_Searchbar_1.TextBox.Text ~= "" then
                        v168 = string.find(l_Title_1.Text:lower(), l_Searchbar_1.TextBox.Text:lower());
                    end;
                    l_v165_0.Visible = v168;
                end);
            end;
        end;
    end);
end;
return v0;