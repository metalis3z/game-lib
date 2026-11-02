-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = {
    "rbxassetid://18912545699", 
    "rbxassetid://18912579017", 
    "rbxassetid://18912582649"
};
local l_floor_0 = math.floor;
local l_format_0 = string.format;
v0.SwitchTab = function(_, v5) --[[ Line: 14 ]] --[[ Name: SwitchTab ]]
    -- upvalues: v0 (copy)
    if v0.LastTab == v5 then
        return;
    else
        local l_Menu_0 = v0.ShopMenu.Menu;
        local l_InfoContainer_0 = l_Menu_0.ShopRoot.InfoContainer;
        local l_SideContainer_0 = l_Menu_0.ShopRoot.SideContainer;
        local l_ShopContainer_0 = l_Menu_0.ShopRoot.ShopContainer;
        local l_Topbar_0 = l_ShopContainer_0.Topbar;
        local l_Searchbar_0 = l_Topbar_0.Searchbar;
        if v0.ShopMenu.Menu.Visible and (v5 ~= "Robux" or v0.ShopMenu.Menu.Size.Y.Scale >= 0.2) then
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
        for _, v13 in pairs(l_Topbar_0:GetChildren()) do
            if v13:IsA("ImageButton") then
                game.TweenService:Create(v13, TweenInfo.new(0.25), {
                    ImageColor3 = v5 == v13.Name and Color3.new(1, 1, 1) or Color3.new()
                }):Play();
                game.TweenService:Create(v13.Title, TweenInfo.new(0.25), {
                    TextColor3 = v5 == v13.Name and Color3.new() or Color3.new(1, 1, 1)
                }):Play();
            end;
        end;
        for _, v15 in pairs(l_ShopContainer_0.Contents:GetChildren()) do
            if v15:IsA("GuiObject") or v15:IsA("Folder") then
                v15.Parent = nil;
            end;
        end;
        local l_FirstChild_0 = script.Tabs:FindFirstChild((tostring(v0.LastTab)));
        local v17 = l_FirstChild_0 and require(l_FirstChild_0);
        if v17 and v17.Selected then
            v17:Deselected(l_Menu_0);
        end;
        local v18 = v0.__tabsData[v5];
        if v18 then
            for _, v20 in pairs(v18) do
                local l_Container_0 = v20:FindFirstChild("Container");
                local v22 = l_Container_0 and l_Container_0:FindFirstChild("Title");
                if v20:IsA("GuiObject") then
                    v20.Visible = not v22 or l_Searchbar_0.TextBox.Text == "" or string.find(v22.Text:lower(), l_Searchbar_0.TextBox.Text:lower());
                end;
                v20.Parent = l_ShopContainer_0.Contents;
            end;
        end;
        local l_FirstChild_1 = script.Tabs:FindFirstChild(v5);
        local v24 = l_FirstChild_1 and require(l_FirstChild_1);
        if v24 and v24.Selected then
            v24:Selected(l_Menu_0);
        end;
        v0.LastTab = v5;
        return;
    end;
end;
v0.Start = function(_) --[[ Line: 82 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy), l_floor_0 (copy), l_format_0 (copy)
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local l_Purchased_0 = l_LocalPlayer_0:WaitForChild("PlayerData"):WaitForChild("Purchased");
    local v28 = require(game.ReplicatedStorage.Initializer);
    local v29 = require(game.ReplicatedStorage.Modules.Network);
    local v30 = require(game.ReplicatedStorage.Modules.Misc.Signal);
    local v31 = require(game.ReplicatedStorage.Modules.Sounds);
    local v32 = v30.new();
    local l_TextService_0 = game:GetService("TextService");
    local l_UserInputService_0 = game:GetService("UserInputService");
    local l_RunService_0 = game:GetService("RunService");
    v0.ShopMenu = v28.PlayerSystems.SidebarHandler:CreateSidebarMenu("Shop", script.ShopScreen);
    local l_Menu_1 = v0.ShopMenu.Menu;
    local l_SideContainer_1 = l_Menu_1.ShopRoot.SideContainer;
    local l_InfoContainer_1 = l_Menu_1.ShopRoot.InfoContainer;
    local l_ShopContainer_1 = l_Menu_1.ShopRoot.ShopContainer;
    local l_SkinsContainer_0 = l_Menu_1.ShopRoot.SkinsContainer;
    local l_PurchaseContainer_0 = l_SideContainer_1.PurchaseContainer;
    local l_Topbar_1 = l_ShopContainer_1.Topbar;
    local l_Searchbar_1 = l_Topbar_1.Searchbar;
    local function _(v44) --[[ Line: 111 ]] --[[ Name: updateCanvasSize ]]
        v44.CanvasSize = UDim2.fromScale(1, 0);
        if v44.AbsoluteCanvasSize.Y > v44.AbsoluteWindowSize.Y then
            v44.CanvasSize = UDim2.new(1, 0, 0, v44.AbsoluteCanvasSize.Y * 1.05);
        end;
    end;
    l_ShopContainer_1.Contents.ChildAdded:Connect(function() --[[ Line: 119 ]]
        -- upvalues: l_ShopContainer_1 (copy)
        local l_Contents_0 = l_ShopContainer_1.Contents;
        l_Contents_0.CanvasSize = UDim2.fromScale(1, 0);
        if l_Contents_0.AbsoluteCanvasSize.Y > l_Contents_0.AbsoluteWindowSize.Y then
            l_Contents_0.CanvasSize = UDim2.new(1, 0, 0, l_Contents_0.AbsoluteCanvasSize.Y * 1.05);
        end;
    end);
    l_ShopContainer_1.Contents.ChildRemoved:Connect(function() --[[ Line: 120 ]]
        -- upvalues: l_ShopContainer_1 (copy)
        local l_Contents_1 = l_ShopContainer_1.Contents;
        l_Contents_1.CanvasSize = UDim2.fromScale(1, 0);
        if l_Contents_1.AbsoluteCanvasSize.Y > l_Contents_1.AbsoluteWindowSize.Y then
            l_Contents_1.CanvasSize = UDim2.new(1, 0, 0, l_Contents_1.AbsoluteCanvasSize.Y * 1.05);
        end;
    end);
    l_ShopContainer_1:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 121 ]]
        -- upvalues: l_ShopContainer_1 (copy)
        local l_Contents_2 = l_ShopContainer_1.Contents;
        l_Contents_2.CanvasSize = UDim2.fromScale(1, 0);
        if l_Contents_2.AbsoluteCanvasSize.Y > l_Contents_2.AbsoluteWindowSize.Y then
            l_Contents_2.CanvasSize = UDim2.new(1, 0, 0, l_Contents_2.AbsoluteCanvasSize.Y * 1.05);
        end;
    end);
    l_SkinsContainer_0.Contents.ChildAdded:Connect(function() --[[ Line: 122 ]]
        -- upvalues: l_SkinsContainer_0 (copy)
        local l_Contents_3 = l_SkinsContainer_0.Contents;
        l_Contents_3.CanvasSize = UDim2.fromScale(1, 0);
        if l_Contents_3.AbsoluteCanvasSize.Y > l_Contents_3.AbsoluteWindowSize.Y then
            l_Contents_3.CanvasSize = UDim2.new(1, 0, 0, l_Contents_3.AbsoluteCanvasSize.Y * 1.05);
        end;
    end);
    l_SkinsContainer_0.Contents.ChildRemoved:Connect(function() --[[ Line: 123 ]]
        -- upvalues: l_SkinsContainer_0 (copy)
        local l_Contents_4 = l_SkinsContainer_0.Contents;
        l_Contents_4.CanvasSize = UDim2.fromScale(1, 0);
        if l_Contents_4.AbsoluteCanvasSize.Y > l_Contents_4.AbsoluteWindowSize.Y then
            l_Contents_4.CanvasSize = UDim2.new(1, 0, 0, l_Contents_4.AbsoluteCanvasSize.Y * 1.05);
        end;
    end);
    l_SideContainer_1.Size = UDim2.fromScale(0, 1);
    l_SideContainer_1.Visible = false;
    v0.ShopMenu.Toggled:Connect(function(_) --[[ Line: 132 ]]
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
        task.delay(0.25, function() --[[ Line: 139 ]]
            -- upvalues: l_ShopContainer_1 (ref)
            l_ShopContainer_1.Visible = true;
        end);
    end);
    local function v53(v52) --[[ Line: 145 ]] --[[ Name: addUIThingies ]]
        -- upvalues: v31 (copy)
        if v52.Name ~= "Money" and (v52:IsA("TextButton") or v52:IsA("ImageButton")) and not v52:GetAttribute("SFXImplemented") then
            v52:SetAttribute("SFXImplemented", true);
            v52.MouseEnter:Connect(function() --[[ Line: 149 ]]
                -- upvalues: v31 (ref)
                v31:Play("hover");
            end);
            v52.MouseLeave:Connect(function() --[[ Line: 153 ]]
                -- upvalues: v31 (ref)
                v31:Play("hoverEnd");
            end);
            if v52.Parent.Name ~= "Topbar" then
                v52.MouseButton1Click:Connect(function() --[[ Line: 158 ]]
                    -- upvalues: v31 (ref)
                    v31:Play("select");
                end);
            end;
        end;
    end;
    for _, v55 in pairs(l_Menu_1:GetDescendants()) do
        v53(v55);
    end;
    l_Menu_1.DescendantAdded:Connect(v53);
    local v56 = require(game.ReplicatedStorage.Modules.Util);
    v56:CreateMoneyDisplay(l_ShopContainer_1.Money);
    local function v60(v57) --[[ Line: 172 ]] --[[ Name: markContentAsPurchased ]]
        -- upvalues: l_Purchased_0 (copy)
        if v57:IsA("Frame") and not v57.Container:FindFirstChild("Purchased") and l_Purchased_0:FindFirstChild(v57.Name, true) then
            local l_Frame_0 = Instance.new("Frame");
            l_Frame_0.Name = "Purchased";
            l_Frame_0.ZIndex = 10;
            l_Frame_0.BorderSizePixel = 0;
            l_Frame_0.BackgroundTransparency = 0.25;
            l_Frame_0.BackgroundColor3 = Color3.new();
            l_Frame_0.Position = UDim2.fromScale(0.5, 0.5);
            l_Frame_0.AnchorPoint = Vector2.new(0.5, 0.5);
            l_Frame_0.Size = UDim2.fromScale(1.05, 1.05);
            l_Frame_0.Parent = v57.Container;
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
            v57.LayoutOrder = v57.LayoutOrder + 100000000;
        end;
    end;
    local function v72(v61) --[[ Line: 202 ]] --[[ Name: promptPurchaseConfirmation ]]
        -- upvalues: v0 (ref), l_Menu_1 (copy), l_Purchased_0 (copy), v29 (copy)
        local v62 = v61 and v61:FindFirstChild("Config") or v0.CurrentlySelected and (v0.CurrentlySelected:FindFirstChild("Config") or v0.CurrentlySelected:IsA("ModuleScript") and v0.CurrentlySelected);
        local v63 = v62 and require(v62);
        if v63 and not l_Menu_1:FindFirstChild("ConfirmPurchase") then
            local v64 = script.Templates.ConfirmPurchase:Clone();
            v64.Size = UDim2.fromScale(0.3, 0);
            v64.Title.Text = ("Are you sure you would like to purchase <b><font color=\"rgb(255,255,255)\">%*</font></b> for <b><font color=\"rgb(255,255,255)\">%*</font></b>?"):format(tostring(v63.DisplayName), v63.Price <= 0 and "FREE" or ("%*$"):format((tostring(v63.Price))));
            v64.Parent = l_Menu_1;
            game.TweenService:Create(v64, TweenInfo.new(0.3), {
                Size = UDim2.fromScale(0.3, 0.3)
            }):Play();
            if v61 and not l_Purchased_0.Killers:FindFirstChild((tostring(v0.CurrentlySelected))) and not l_Purchased_0.Survivors:FindFirstChild((tostring(v0.CurrentlySelected))) then
                v64.Disclaimer.Text = "DISCLAIMER:\nYou don't own this character yet.\nWhatever you're trying to do right now is dumb.";
            elseif v63.DisclaimerText then
                v64.Disclaimer.Text = ("DISCLAIMER:\n%*"):format((tostring(v63.DisclaimerText)));
            end;
            local v65 = false;
            local v66 = false;
            local l_Title_0 = v64.Buttons.Yes.Title;
            local v68 = v61 or v0.CurrentlySelected;
            do
                local l_v65_0, l_v66_0 = v65, v66;
                v64.Buttons.Yes.MouseButton1Click:Connect(function() --[[ Line: 225 ]]
                    -- upvalues: l_v65_0 (ref), l_Title_0 (copy), v29 (ref), v68 (copy), l_v66_0 (ref), v64 (copy)
                    if not l_v65_0 then
                        l_v65_0 = true;
                        l_Title_0.Text = "...";
                        local v71 = v29:FireServerConnection("PurchaseContent", "REMOTE_FUNCTION", v68);
                        if v71 == "success" then
                            l_Title_0.Text = "Bought!";
                            task.wait(0.5);
                            if not l_v66_0 then
                                l_v66_0 = true;
                                game.TweenService:Create(v64, TweenInfo.new(0.3), {
                                    Size = UDim2.fromScale(0.3, 0)
                                }):Play();
                                game.Debris:AddItem(v64, 0.3);
                            end;
                            return;
                        else
                            if v71 == "poor" then
                                l_Title_0.Text = "Insufficient funds!";
                            elseif v71 == "alreadyBought" then
                                l_Title_0.Text = "Already owned!";
                            end;
                            task.delay(0.5, function() --[[ Line: 253 ]]
                                -- upvalues: l_v65_0 (ref), l_Title_0 (ref)
                                l_v65_0 = false;
                                l_Title_0.Text = "Yes";
                            end);
                        end;
                    end;
                end);
                v64.Buttons.No.MouseButton1Click:Connect(function() --[[ Line: 261 ]]
                    -- upvalues: l_v66_0 (ref), v64 (copy)
                    if not l_v66_0 then
                        l_v66_0 = true;
                        game.TweenService:Create(v64, TweenInfo.new(0.3), {
                            Size = UDim2.fromScale(0.3, 0)
                        }):Play();
                        game.Debris:AddItem(v64, 0.3);
                    end;
                end);
            end;
        end;
    end;
    l_PurchaseContainer_0.Purchase.MouseButton1Click:Connect(v72);
    l_SkinsContainer_0.Contents.ChildAdded:Connect(v60);
    l_ShopContainer_1.Contents.ChildAdded:Connect(v60);
    l_Purchased_0.DescendantAdded:Connect(function(v73) --[[ Line: 277 ]]
        -- upvalues: l_ShopContainer_1 (copy), l_SkinsContainer_0 (copy), v60 (copy)
        local v74 = l_ShopContainer_1.Contents:FindFirstChild(v73.Name) or l_SkinsContainer_0.Contents:FindFirstChild(v73.Name);
        if v74 then
            v60(v74);
        end;
    end);
    local v75 = nil;
    local function v138(v76) --[[ Line: 286 ]] --[[ Name: loadActorInfo ]]
        -- upvalues: v75 (ref), l_InfoContainer_1 (copy), l_Menu_1 (copy), l_LocalPlayer_0 (copy), l_UserInputService_0 (copy), l_TextService_0 (copy), v56 (copy)
        if v75 ~= v76 then
            v75 = v76;
            local l_Templates_0 = script.Templates;
            local v78 = {};
            for _, v80 in pairs(l_InfoContainer_1.Contents:GetChildren()) do
                if v80:IsA("GuiObject") then
                    v80:Destroy();
                end;
            end;
            local l_pairs_0 = pairs;
            local v82 = v76 or {};
            for v83, v84 in l_pairs_0(v82) do
                local l_Frame_1 = Instance.new("Frame");
                l_Frame_1.Name = "Content";
                l_Frame_1.BackgroundTransparency = 1;
                l_Frame_1.Size = UDim2.fromScale(1, 0);
                l_Frame_1.AutomaticSize = Enum.AutomaticSize.Y;
                l_Frame_1.LayoutOrder = v83;
                l_Frame_1.Parent = l_InfoContainer_1.Contents;
                local l_UIListLayout_0 = Instance.new("UIListLayout");
                l_UIListLayout_0.Padding = UDim.new(0, 10);
                l_UIListLayout_0.HorizontalAlignment = Enum.HorizontalAlignment.Center;
                l_UIListLayout_0.Parent = l_Frame_1;
                local _ = workspace.CurrentCamera.ViewportSize.Y;
                for v88, v89 in pairs(v84) do
                    if v88 == "Separator" then
                        local v90 = l_Templates_0.Seperator:Clone();
                        v90.Title.Text = tostring(v89);
                        v90.Parent = l_Frame_1;
                    elseif v88 == "Header" then
                        local v91 = l_Templates_0.Header:Clone();
                        v91.Text = tostring(v89);
                        v91.Parent = l_Frame_1;
                    elseif v88 == "Quote" then
                        local v92 = l_Templates_0.Quote:Clone();
                        v92.Text = tostring(v89);
                        v92.Parent = l_Frame_1;
                    elseif v88 == "Text" then
                        local v93 = l_Templates_0.TextContainer:Clone();
                        v93.Title.MaxVisibleGraphemes = 0;
                        v93.Title.Text = tostring(v89);
                        v93.Image.Image = tostring(v84.Image);
                        v93.Image.Visible = v84.Image;
                        v93.Parent = l_Frame_1;
                        table.insert(v78, v93.Title);
                        game.TweenService:Create(v93.Title, TweenInfo.new(5, Enum.EasingStyle.Quint), {
                            MaxVisibleGraphemes = #v93.Title.Text + 10
                        }):Play();
                    end;
                end;
            end;
            task.spawn(function() --[[ Line: 354 ]]
                -- upvalues: v76 (copy), v75 (ref), l_Menu_1 (ref), l_InfoContainer_1 (ref), l_LocalPlayer_0 (ref), l_UserInputService_0 (ref), v78 (copy), l_TextService_0 (ref), v56 (ref)
                local v94 = false;
                local v95 = {};
                local function v96(v97) --[[ Line: 357 ]] --[[ Name: addStatus ]]
                    -- upvalues: v96 (copy), v95 (copy)
                    if v97:IsA("Folder") then
                        for _, v99 in pairs(v97:GetChildren()) do
                            v96(v99);
                        end;
                        return;
                    else
                        if v97:IsA("ModuleScript") then
                            local v100 = require(v97);
                            v95[v97.Name] = v100.Data.Description or "???";
                        end;
                        return;
                    end;
                end;
                v96(game.ReplicatedStorage.Modules.StatusEffects);
                local v101 = nil;
                while task.wait() and v76 and v75 == v76 do
                    if l_Menu_1.Visible and l_InfoContainer_1.Size.X.Scale >= 0.5 and l_LocalPlayer_0.Character and tostring(l_LocalPlayer_0.Character.Parent) == "Spectating" then
                        local v102 = l_UserInputService_0:GetMouseLocation() - game.GuiService:GetGuiInset();
                        local v103 = false;
                        for _, v105 in pairs(v78) do
                            if not v103 then
                                local l_AbsolutePosition_0 = v105.AbsolutePosition;
                                local l_AbsoluteSize_0 = v105.AbsoluteSize;
                                if v102.X >= l_AbsolutePosition_0.X and v102.X <= l_AbsolutePosition_0.X + l_AbsoluteSize_0.X and v102.Y >= l_AbsolutePosition_0.Y and v102.Y <= l_AbsolutePosition_0.Y + l_AbsoluteSize_0.Y then
                                    local v108 = v105.Text:gsub("<.->", "");
                                    local l_Font_0 = v105.Font;
                                    local l_TextSize_0 = v105.TextSize;
                                    local l_X_0 = l_AbsoluteSize_0.X;
                                    local v112 = v108:split("\n");
                                    local v113 = {};
                                    for _, v115 in ipairs(v112) do
                                        local v116 = v115:split(" ");
                                        local v117 = {};
                                        local v118 = 0;
                                        for _, v120 in ipairs(v116) do
                                            local l_l_TextService_0_TextSize_0 = l_TextService_0:GetTextSize(v120, l_TextSize_0, l_Font_0, Vector2.new(l_X_0, 1e999));
                                            local l_X_1 = l_TextService_0:GetTextSize(" ", l_TextSize_0, l_Font_0, Vector2.new(l_X_0, 1e999)).X;
                                            if l_X_0 < v118 + l_l_TextService_0_TextSize_0.X then
                                                table.insert(v113, v117);
                                                v117 = {};
                                                v118 = 0;
                                            end;
                                            table.insert(v117, v120);
                                            v118 = v118 + l_l_TextService_0_TextSize_0.X + l_X_1;
                                        end;
                                        if #v117 > 0 then
                                            table.insert(v113, v117);
                                        end;
                                    end;
                                    local l_Y_1 = l_TextService_0:GetTextSize("Test", l_TextSize_0, l_Font_0, Vector2.new(l_X_0, 1e999)).Y;
                                    local v124 = 0;
                                    for _, v126 in ipairs(v113) do
                                        if not v103 then
                                            local v127 = l_AbsolutePosition_0.Y + v124;
                                            local v128 = v127 + l_Y_1;
                                            if v127 <= v102.Y and v102.Y <= v128 then
                                                local v129 = 0;
                                                for _, v131 in ipairs(v126) do
                                                    local l_l_TextService_0_TextSize_1 = l_TextService_0:GetTextSize(v131, l_TextSize_0, l_Font_0, Vector2.new(l_X_0, 1e999));
                                                    local v133 = l_AbsolutePosition_0.X + v129;
                                                    local v134 = v133 + l_l_TextService_0_TextSize_1.X;
                                                    if v133 <= v102.X and v102.X <= v134 then
                                                        local _ = game.ReplicatedStorage.Modules.StatusEffects;
                                                        local v136 = v95[v131];
                                                        if v136 then
                                                            v103 = true;
                                                            v101 = v56:CreateTooltip(v136);
                                                            v94 = true;
                                                        else
                                                            v94 = true;
                                                        end;
                                                    else
                                                        local l_X_2 = l_TextService_0:GetTextSize(" ", l_TextSize_0, l_Font_0, Vector2.new(l_X_0, 1e999)).X;
                                                        v129 = v129 + l_l_TextService_0_TextSize_1.X + l_X_2;
                                                    end;
                                                    if v94 then
                                                        break;
                                                    end;
                                                    if v94 then
                                                        break;
                                                    end;
                                                end;
                                                if not v94 then
                                                    if not v94 then
                                                        break;
                                                    end;
                                                end;
                                            else
                                                v124 = v124 + l_Y_1;
                                            end;
                                        else
                                            break;
                                        end;
                                        if v94 then
                                            break;
                                        end;
                                        if v94 then
                                            break;
                                        end;
                                    end;
                                end;
                            else
                                break;
                            end;
                            v94 = false;
                        end;
                        if not v103 then
                            v101 = v56:CreateTooltip();
                        end;
                    elseif v101 then
                        v101 = v56:CreateTooltip();
                    end;
                end;
            end);
        end;
    end;
    local v139 = nil;
    local function v172(v140) --[[ Line: 480 ]] --[[ Name: loadActorSkins ]]
        -- upvalues: v139 (ref), l_SkinsContainer_0 (copy), v0 (ref), v32 (copy), l_floor_0 (ref), l_format_0 (ref), v56 (copy), v72 (copy)
        if v140 and v139 ~= v140 then
            v139 = v140;
            for _, v142 in pairs(l_SkinsContainer_0.Contents:GetChildren()) do
                if v142:IsA("GuiObject") then
                    v142:Destroy();
                end;
            end;
            local v143 = v0.CurrentlySelected and v0.CurrentlySelected:FindFirstChild("Config");
            local v144 = v143 and require(v143);
            l_SkinsContainer_0.TitleDisplay.Title.Text = ("%* Skins"):format(v144.DisplayName or tostring(v140.Name));
            task.spawn(function() --[[ Line: 497 ]]
                -- upvalues: v140 (copy), l_SkinsContainer_0 (ref), v32 (ref), l_floor_0 (ref), l_format_0 (ref), v56 (ref), v72 (ref)
                for _, v146 in pairs(v140:GetChildren()) do
                    local l_status_0, l_result_0 = pcall(require, v146.Config);
                    if not l_status_0 then
                        print((("[Shop]: Failed to get information for skin: %*"):format(v146.Name)));
                    elseif not l_result_0.Exclusive then
                        local v149 = script.Templates.CardTemplate:Clone();
                        local l_Container_1 = v149.Container;
                        v149.Name = v146.Name;
                        v149.LayoutOrder = l_result_0.Price or 1000;
                        v149.Parent = l_SkinsContainer_0.Contents;
                        l_Container_1.CharacterRender.Image = l_result_0.RenderImage or "rbxassetid://13373279056";
                        l_Container_1.Title.Text = tostring(l_result_0.DisplayName);
                        l_Container_1.Price.Text = l_result_0.Price <= 0 and "FREE" or ("%*$"):format((tostring(l_result_0.Price)));
                        local l_LimitedTimeData_0 = l_result_0.LimitedTimeData;
                        if l_result_0.LimitedTimeData then
                            local v152 = 0;
                            do
                                local l_v152_0 = v152;
                                local v164 = v32:Connect(function(_) --[[ Line: 520 ]]
                                    -- upvalues: l_v152_0 (ref), l_Container_1 (copy), l_LimitedTimeData_0 (copy), v149 (copy), l_floor_0 (ref), l_format_0 (ref)
                                    local l_UnixTimestamp_0 = DateTime.now().UnixTimestamp;
                                    if l_UnixTimestamp_0 == l_v152_0 then
                                        return;
                                    elseif not l_Container_1 or not l_Container_1.LimitedTime then
                                        return;
                                    else
                                        l_v152_0 = l_UnixTimestamp_0;
                                        local l_StartUnix_0 = l_LimitedTimeData_0.StartUnix;
                                        local l_EndUnix_0 = l_LimitedTimeData_0.EndUnix;
                                        local v158 = l_EndUnix_0 - l_UnixTimestamp_0;
                                        local v159 = false;
                                        if l_StartUnix_0 < l_UnixTimestamp_0 then
                                            v159 = l_UnixTimestamp_0 < l_EndUnix_0;
                                        end;
                                        v149.Visible = v159;
                                        l_Container_1.LimitedTime.Visible = v159;
                                        if not v159 or v158 <= 0 then
                                            return;
                                        else
                                            local v160 = l_floor_0(v158 / 86400);
                                            local v161 = l_floor_0(v158 % 86400 / 3600);
                                            local v162 = v158 % 60;
                                            local v163 = l_format_0("%02dd %02dh %02ds", v160, v161, v162);
                                            if l_Container_1.LimitedTime.Text ~= v163 then
                                                l_Container_1.LimitedTime.Text = v163;
                                            end;
                                            return;
                                        end;
                                    end;
                                end);
                                v149.AncestryChanged:Connect(function(_, v166) --[[ Line: 546 ]]
                                    -- upvalues: v164 (copy)
                                    if v166 == nil then
                                        v164:Disconnect();
                                    end;
                                end);
                            end;
                        end;
                        local v167 = nil;
                        if l_result_0.ExclusiveText then
                            script.Templates.ExclusiveGradient:Clone().Parent = l_Container_1.Outline;
                            l_Container_1.Outline.ImageColor3 = Color3.new(1, 1, 1);
                            v167 = script.Templates.ExclusiveTitle:Clone();
                            v167.Text = tostring(l_result_0.ExclusiveText);
                            v167.Parent = l_Container_1;
                        end;
                        if l_result_0.Uncommon then
                            script.Templates.UncommonGradient:Clone().Parent = l_Container_1.Outline;
                            l_Container_1.Outline.ImageColor3 = Color3.new(1, 1, 1);
                        end;
                        if l_result_0.Epic then
                            script.Templates.EpicGradient:Clone().Parent = l_Container_1.Outline;
                            l_Container_1.Outline.ImageColor3 = Color3.new(1, 1, 1);
                        end;
                        if l_result_0.Legendary then
                            script.Templates.LegendaryGradient:Clone().Parent = l_Container_1.Outline;
                            l_Container_1.Outline.ImageColor3 = Color3.new(1, 1, 1);
                        end;
                        local v168 = require(game.ReplicatedStorage.Modules.Schematics.IngameCollabs)[l_result_0.CollabInfo] or l_result_0.CollabInfo;
                        if typeof(v168) == "table" then
                            local v169 = game.ReplicatedStorage.Assets.UI.ShopCardIcon:Clone();
                            v169.Image = v168.Icon or "rbxassetid://9011713759";
                            v169.Parent = l_Container_1.CardIcons;
                            v169.MouseEnter:Connect(function() --[[ Line: 591 ]]
                                -- upvalues: v56 (ref), v168 (copy)
                                v56:CreateTooltip(v168.Description);
                            end);
                            v169.MouseLeave:Connect(function() --[[ Line: 596 ]]
                                -- upvalues: v56 (ref)
                                v56:CreateTooltip();
                            end);
                        end;
                        local l_Name_0 = v140.Parent.Name;
                        if l_Name_0 == "Survivors" then
                            l_Container_1.Title.TextColor3 = Color3.fromRGB(200, 200, 255);
                        elseif l_Name_0 == "Killers" then
                            l_Container_1.Title.TextColor3 = Color3.fromRGB(255, 200, 200);
                        end;
                        do
                            local l_v167_0 = v167;
                            l_Container_1.MouseEnter:Connect(function() --[[ Line: 610 ]]
                                -- upvalues: l_Container_1 (copy), l_v167_0 (ref)
                                game.TweenService:Create(l_Container_1, TweenInfo.new(0.25), {
                                    Size = UDim2.fromScale(1.05, 1.05)
                                }):Play();
                                if l_v167_0 then
                                    game.TweenService:Create(l_v167_0, TweenInfo.new(0.175), {
                                        TextTransparency = 0, 
                                        TextStrokeTransparency = 0
                                    }):Play();
                                end;
                            end);
                            l_Container_1.MouseLeave:Connect(function() --[[ Line: 615 ]]
                                -- upvalues: l_Container_1 (copy), l_v167_0 (ref)
                                game.TweenService:Create(l_Container_1, TweenInfo.new(0.25), {
                                    Size = UDim2.fromScale(1, 1)
                                }):Play();
                                if l_v167_0 then
                                    game.TweenService:Create(l_v167_0, TweenInfo.new(0.175), {
                                        TextTransparency = 1, 
                                        TextStrokeTransparency = 1
                                    }):Play();
                                end;
                            end);
                            l_Container_1.Interact.MouseButton1Click:Connect(function() --[[ Line: 620 ]]
                                -- upvalues: l_Container_1 (copy), v72 (ref), v146 (copy)
                                if not l_Container_1:FindFirstChild("Purchased") then
                                    v72(v146);
                                end;
                            end);
                        end;
                    end;
                end;
            end);
        end;
    end;
    local v173 = nil;
    local v174 = false;
    l_PurchaseContainer_0.Buttons.ViewInfo.MouseButton1Click:Connect(function() --[[ Line: 633 ]]
        -- upvalues: v174 (ref), v0 (ref), v138 (copy), v173 (ref), l_InfoContainer_1 (copy), l_PurchaseContainer_0 (copy), l_SkinsContainer_0 (copy), l_ShopContainer_1 (copy)
        if v174 then
            return;
        else
            v174 = true;
            local v175 = v0.CurrentlySelected and v0.CurrentlySelected:FindFirstChild("Config");
            local v176 = v175 and require(v175);
            if not v176 or not v176.Information then
                v174 = false;
                return;
            else
                v138(v176.Information);
                if v173 then
                    task.cancel(v173);
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
                    v173 = task.delay(0.25, function() --[[ Line: 653 ]]
                        -- upvalues: l_SkinsContainer_0 (ref), l_InfoContainer_1 (ref)
                        l_SkinsContainer_0.Visible = false;
                        l_InfoContainer_1.Visible = false;
                    end);
                    task.delay(0.175, function() --[[ Line: 654 ]]
                        -- upvalues: v174 (ref)
                        v174 = false;
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
                    v173 = task.delay(0.25, function() --[[ Line: 662 ]]
                        -- upvalues: l_SkinsContainer_0 (ref), l_ShopContainer_1 (ref)
                        l_SkinsContainer_0.Visible = false;
                        l_ShopContainer_1.Visible = false;
                    end);
                    task.delay(0.175, function() --[[ Line: 663 ]]
                        -- upvalues: v174 (ref)
                        v174 = false;
                    end);
                    l_InfoContainer_1.Visible = true;
                    return;
                end;
            end;
        end;
    end);
    l_PurchaseContainer_0.Buttons.ViewSkins.MouseButton1Click:Connect(function() --[[ Line: 669 ]]
        -- upvalues: v174 (ref), v0 (ref), v172 (copy), v173 (ref), l_SkinsContainer_0 (copy), l_PurchaseContainer_0 (copy), l_InfoContainer_1 (copy), l_ShopContainer_1 (copy)
        if v174 then
            return;
        else
            v174 = true;
            if not v0.CurrentlySelected then
                return;
            else
                local l_FirstChild_2 = game.ReplicatedStorage.Assets.Skins:FindFirstChild((tostring(v0.CurrentlySelected.Parent)));
                local v178 = l_FirstChild_2 and l_FirstChild_2:FindFirstChild((tostring(v0.CurrentlySelected)));
                if not v178 then
                    v174 = false;
                    return;
                else
                    v172(v178);
                    if v173 then
                        task.cancel(v173);
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
                        v173 = task.delay(0.25, function() --[[ Line: 690 ]]
                            -- upvalues: l_InfoContainer_1 (ref), l_SkinsContainer_0 (ref)
                            l_InfoContainer_1.Visible = false;
                            l_SkinsContainer_0.Visible = false;
                        end);
                        task.delay(0.175, function() --[[ Line: 691 ]]
                            -- upvalues: v174 (ref)
                            v174 = false;
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
                        v173 = task.delay(0.25, function() --[[ Line: 699 ]]
                            -- upvalues: l_InfoContainer_1 (ref), l_ShopContainer_1 (ref)
                            l_InfoContainer_1.Visible = false;
                            l_ShopContainer_1.Visible = false;
                        end);
                        task.delay(0.175, function() --[[ Line: 700 ]]
                            -- upvalues: v174 (ref)
                            v174 = false;
                        end);
                        l_SkinsContainer_0.Visible = true;
                        return;
                    end;
                end;
            end;
        end;
    end);
    for _, v180 in pairs(l_PurchaseContainer_0.Buttons:GetChildren()) do
        local l_v180_Attribute_0 = v180:GetAttribute("Description");
        if l_v180_Attribute_0 then
            v180.Title.TextTransparency = 0;
            v180.Title.Text = l_v180_Attribute_0;
        end;
    end;
    v0.__tabsData = {};
    for _, v183 in pairs(script.Tabs:GetChildren()) do
        local v184 = require(v183);
        v184.Shop = v0;
        local l_v184_Tab_0 = v184:CreateTab(l_Menu_1);
        v0.__tabsData[v183.Name] = l_v184_Tab_0;
    end;
    v0:SwitchTab("Killers");
    for _, v187 in pairs(l_Topbar_1:GetChildren()) do
        if v187:IsA("ImageButton") then
            v187.MouseButton1Click:Connect(function() --[[ Line: 728 ]]
                -- upvalues: v0 (ref), v187 (copy)
                v0:SwitchTab(v187.Name);
            end);
        end;
    end;
    l_Searchbar_1.TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 735 ]]
        -- upvalues: l_ShopContainer_1 (copy), l_Searchbar_1 (copy)
        for _, v189 in pairs(l_ShopContainer_1.Contents:GetChildren()) do
            if v189:IsA("Frame") then
                local l_Title_1 = v189.Container.Title;
                pcall(function() --[[ Line: 739 ]]
                    -- upvalues: v189 (copy), l_Searchbar_1 (ref), l_Title_1 (copy)
                    local l_v189_0 = v189;
                    local v192 = true;
                    if l_Searchbar_1.TextBox.Text ~= "" then
                        v192 = string.find(l_Title_1.Text:lower(), l_Searchbar_1.TextBox.Text:lower());
                    end;
                    l_v189_0.Visible = v192;
                end);
            end;
        end;
    end);
    l_RunService_0.Heartbeat:Connect(function(v193) --[[ Line: 746 ]]
        -- upvalues: v32 (copy)
        v32:FireDeferred(v193);
    end);
end;
return v0;