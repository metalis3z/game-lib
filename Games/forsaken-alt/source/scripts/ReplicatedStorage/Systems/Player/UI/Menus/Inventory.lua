-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = {
    "rbxassetid://18912545699", 
    "rbxassetid://18912579017", 
    "rbxassetid://18912582649"
};
v0.SwitchTab = function(_, v3, v4) --[[ Line: 10 ]] --[[ Name: SwitchTab ]]
    -- upvalues: v0 (copy)
    if v0.LastTab == v3 and not v4 then
        return;
    else
        local l_Menu_0 = v0.InventoryMenu.Menu;
        local l_InfoContainer_0 = l_Menu_0.InventoryRoot.InfoContainer;
        local l_SideContainer_0 = l_Menu_0.InventoryRoot.SideContainer;
        local l_InventoryContainer_0 = l_Menu_0.InventoryRoot.InventoryContainer;
        local l_Topbar_0 = l_InventoryContainer_0.Topbar;
        local l_Searchbar_0 = l_Topbar_0.Searchbar;
        if v0.InventoryMenu.Menu.Visible and not v4 then
            require(game.ReplicatedStorage.Modules.Sounds):Play("select");
        end;
        game.TweenService:Create(l_SideContainer_0, TweenInfo.new(0.4), {
            Size = UDim2.fromScale(0, 1)
        }):Play();
        game.TweenService:Create(l_InfoContainer_0, TweenInfo.new(0.4), {
            Size = UDim2.fromScale(0, 1)
        }):Play();
        game.TweenService:Create(l_InventoryContainer_0, TweenInfo.new(0.4), {
            Size = UDim2.fromScale(0.7, 1)
        }):Play();
        l_InventoryContainer_0.Contents.UIPadding.PaddingTop = UDim.new(0, workspace.CurrentCamera.ViewportSize.Y / 40);
        for _, v12 in pairs(l_Topbar_0:GetChildren()) do
            if v12:IsA("ImageButton") then
                game.TweenService:Create(v12, TweenInfo.new(0.25), {
                    ImageColor3 = v3 == v12.Name and Color3.new(1, 1, 1) or Color3.new()
                }):Play();
                game.TweenService:Create(v12.Title, TweenInfo.new(0.25), {
                    TextColor3 = v3 == v12.Name and Color3.new() or Color3.new(1, 1, 1)
                }):Play();
            end;
        end;
        for _, v14 in pairs(l_InventoryContainer_0.Contents:GetChildren()) do
            if v14:IsA("GuiObject") or v14:IsA("Folder") then
                v14.Parent = nil;
            end;
        end;
        local l_FirstChild_0 = script.Tabs:FindFirstChild((tostring(v0.LastTab)));
        local v16 = l_FirstChild_0 and require(l_FirstChild_0);
        if v16 and v16.Selected then
            v16:Deselected(l_Menu_0);
        end;
        local v17 = v0.__tabsData[v3];
        if v17 then
            for _, v19 in pairs(v17) do
                local l_Container_0 = v19:FindFirstChild("Container");
                local v21 = l_Container_0 and l_Container_0:FindFirstChild("Title");
                if v19:IsA("GuiObject") then
                    v19.Visible = not v21 or l_Searchbar_0.TextBox.Text == "" or string.find(v21.Text:lower(), l_Searchbar_0.TextBox.Text:lower());
                end;
                v19.Parent = l_InventoryContainer_0.Contents;
            end;
        end;
        local l_FirstChild_1 = script.Tabs:FindFirstChild(v3);
        local v23 = l_FirstChild_1 and require(l_FirstChild_1);
        if v23 and v23.Selected then
            v23:Selected(l_Menu_0);
        end;
        v0.LastTab = v3;
        return;
    end;
end;
v0.Start = function(_) --[[ Line: 78 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy)
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local l_Equipped_0 = l_LocalPlayer_0.PlayerData.Equipped;
    local v27 = require(game.ReplicatedStorage.Initializer);
    local v28 = require(game.ReplicatedStorage.Modules.Network);
    local v29 = require(game.ReplicatedStorage.Modules.Sounds);
    local l_TextService_0 = game:GetService("TextService");
    local l_UserInputService_0 = game:GetService("UserInputService");
    v0.InventoryMenu = v27.PlayerSystems.SidebarHandler:CreateSidebarMenu("Inventory", script.InventoryScreen);
    local l_Menu_1 = v0.InventoryMenu.Menu;
    local l_SideContainer_1 = l_Menu_1.InventoryRoot.SideContainer;
    local l_InfoContainer_1 = l_Menu_1.InventoryRoot.InfoContainer;
    local l_SkinsContainer_0 = l_Menu_1.InventoryRoot.SkinsContainer;
    local l_InventoryContainer_1 = l_Menu_1.InventoryRoot.InventoryContainer;
    local l_EquipContainer_0 = l_SideContainer_1.EquipContainer;
    local l_Topbar_1 = l_InventoryContainer_1.Topbar;
    local l_Searchbar_1 = l_Topbar_1.Searchbar;
    local function _(v40) --[[ Line: 102 ]] --[[ Name: updateCanvasSize ]]
        v40.CanvasSize = UDim2.fromScale(1, 0);
        if v40.AbsoluteCanvasSize.Y > v40.AbsoluteWindowSize.Y then
            v40.CanvasSize = UDim2.new(1, 0, 0, v40.AbsoluteCanvasSize.Y * 1.05);
        end;
    end;
    l_InventoryContainer_1.Contents.ChildAdded:Connect(function() --[[ Line: 111 ]]
        -- upvalues: l_InventoryContainer_1 (copy)
        local l_Contents_0 = l_InventoryContainer_1.Contents;
        l_Contents_0.CanvasSize = UDim2.fromScale(1, 0);
        if l_Contents_0.AbsoluteCanvasSize.Y > l_Contents_0.AbsoluteWindowSize.Y then
            l_Contents_0.CanvasSize = UDim2.new(1, 0, 0, l_Contents_0.AbsoluteCanvasSize.Y * 1.05);
        end;
    end);
    l_InventoryContainer_1.Contents.ChildRemoved:Connect(function() --[[ Line: 112 ]]
        -- upvalues: l_InventoryContainer_1 (copy)
        local l_Contents_1 = l_InventoryContainer_1.Contents;
        l_Contents_1.CanvasSize = UDim2.fromScale(1, 0);
        if l_Contents_1.AbsoluteCanvasSize.Y > l_Contents_1.AbsoluteWindowSize.Y then
            l_Contents_1.CanvasSize = UDim2.new(1, 0, 0, l_Contents_1.AbsoluteCanvasSize.Y * 1.05);
        end;
    end);
    l_InventoryContainer_1:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 113 ]]
        -- upvalues: l_InventoryContainer_1 (copy)
        local l_Contents_2 = l_InventoryContainer_1.Contents;
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
    l_EquipContainer_0.ButtonDescription.Title.TextTransparency = 1;
    v0.InventoryMenu.Toggled:Connect(function(_) --[[ Line: 124 ]]
        -- upvalues: v0 (ref), l_EquipContainer_0 (copy), l_SideContainer_1 (copy), l_InfoContainer_1 (copy), l_SkinsContainer_0 (copy), l_InventoryContainer_1 (copy)
        v0:SwitchTab(v0.LastTab or "Killers", true);
        game.TweenService:Create(l_EquipContainer_0.Buttons.ViewSkins.Inverted, TweenInfo.new(0.25), {
            ImageTransparency = 1
        }):Play();
        game.TweenService:Create(l_EquipContainer_0.Buttons.ViewInfo.Inverted, TweenInfo.new(0.25), {
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
        game.TweenService:Create(l_InventoryContainer_1, TweenInfo.new(0.4), {
            Size = UDim2.fromScale(0.7, 1)
        }):Play();
        task.delay(0.25, function() --[[ Line: 132 ]]
            -- upvalues: l_InventoryContainer_1 (ref)
            l_InventoryContainer_1.Visible = true;
        end);
    end);
    local function v49(v48) --[[ Line: 138 ]] --[[ Name: addUIThingies ]]
        -- upvalues: v29 (copy)
        if (v48:IsA("TextButton") or v48:IsA("ImageButton")) and not v48:GetAttribute("SFXImplemented") then
            v48:SetAttribute("SFXImplemented", true);
            v48.MouseEnter:Connect(function() --[[ Line: 142 ]]
                -- upvalues: v29 (ref)
                v29:Play("hover");
            end);
            v48.MouseLeave:Connect(function() --[[ Line: 146 ]]
                -- upvalues: v29 (ref)
                v29:Play("hoverEnd");
            end);
            if v48.Parent.Name ~= "Topbar" then
                v48.MouseButton1Click:Connect(function() --[[ Line: 151 ]]
                    -- upvalues: v29 (ref)
                    v29:Play("select");
                end);
            end;
        end;
    end;
    for _, v51 in pairs(l_Menu_1:GetDescendants()) do
        v49(v51);
    end;
    l_Menu_1.DescendantAdded:Connect(v49);
    local v52 = require(game.ReplicatedStorage.Modules.Util);
    v52:CreateMoneyDisplay(l_InventoryContainer_1.Money);
    l_EquipContainer_0.Equip.MouseButton1Click:Connect(function() --[[ Line: 165 ]]
        -- upvalues: v28 (copy), v0 (ref)
        v28:FireServerConnection("EquipContent", "REMOTE_EVENT", v0.CurrentlySelected);
    end);
    local function v61(v53) --[[ Line: 170 ]] --[[ Name: updateEquips ]]
        -- upvalues: l_InventoryContainer_1 (copy), l_SkinsContainer_0 (copy), l_Equipped_0 (copy)
        for _, v55 in pairs({
            l_InventoryContainer_1.Contents, 
            l_SkinsContainer_0.Contents
        }) do
            for _, v57 in pairs(v55:GetChildren()) do
                if v57:IsA("GuiObject") and not v57:GetAttribute("IgnoreEquipUpdate") then
                    local v58 = nil;
                    for _, v60 in pairs(l_Equipped_0:GetDescendants()) do
                        if v60:IsA("ValueBase") and v60.Value == v57.Name then
                            v58 = true;
                            break;
                        end;
                    end;
                    if v58 and v57.Container.Equipped.ImageTransparency ~= 0 then
                        if v53 then
                            v57.Container.Equipped.ImageTransparency = 0;
                        else
                            game.TweenService:Create(v57.Container.Equipped, TweenInfo.new(0.125), {
                                ImageTransparency = 0
                            }):Play();
                        end;
                    elseif not v58 and v57.Container.Equipped.ImageTransparency ~= 1 then
                        game.TweenService:Create(v57.Container.Equipped, TweenInfo.new(0.125), {
                            ImageTransparency = 1
                        }):Play();
                    end;
                end;
            end;
        end;
    end;
    local v62 = nil;
    local function v125(v63) --[[ Line: 201 ]] --[[ Name: loadActorInfo ]]
        -- upvalues: v62 (ref), l_InfoContainer_1 (copy), l_Menu_1 (copy), l_LocalPlayer_0 (copy), l_UserInputService_0 (copy), l_TextService_0 (copy), v52 (copy)
        if v62 ~= v63 then
            v62 = v63;
            local l_Templates_0 = script.Templates;
            local v65 = {};
            for _, v67 in pairs(l_InfoContainer_1.Contents:GetChildren()) do
                if v67:IsA("GuiObject") then
                    v67:Destroy();
                end;
            end;
            local l_pairs_0 = pairs;
            local v69 = v63 or {};
            for v70, v71 in l_pairs_0(v69) do
                local l_Frame_0 = Instance.new("Frame");
                l_Frame_0.Name = "Content";
                l_Frame_0.BackgroundTransparency = 1;
                l_Frame_0.Size = UDim2.fromScale(1, 0);
                l_Frame_0.AutomaticSize = Enum.AutomaticSize.Y;
                l_Frame_0.LayoutOrder = v70;
                l_Frame_0.Parent = l_InfoContainer_1.Contents;
                local l_UIListLayout_0 = Instance.new("UIListLayout");
                l_UIListLayout_0.Padding = UDim.new(0, 10);
                l_UIListLayout_0.HorizontalAlignment = Enum.HorizontalAlignment.Center;
                l_UIListLayout_0.Parent = l_Frame_0;
                local _ = workspace.CurrentCamera.ViewportSize.Y;
                for v75, v76 in pairs(v71) do
                    if v75 == "Separator" then
                        local v77 = l_Templates_0.Seperator:Clone();
                        v77.Title.Text = tostring(v76);
                        v77.Parent = l_Frame_0;
                    elseif v75 == "Header" then
                        local v78 = l_Templates_0.Header:Clone();
                        v78.Text = tostring(v76);
                        v78.Parent = l_Frame_0;
                    elseif v75 == "Quote" then
                        local v79 = l_Templates_0.Quote:Clone();
                        v79.Text = tostring(v76);
                        v79.Parent = l_Frame_0;
                    elseif v75 == "Text" then
                        local v80 = l_Templates_0.TextContainer:Clone();
                        v80.Title.MaxVisibleGraphemes = 0;
                        v80.Title.Text = tostring(v76);
                        v80.Image.Image = tostring(v71.Image);
                        v80.Image.Visible = v71.Image;
                        v80.Parent = l_Frame_0;
                        table.insert(v65, v80.Title);
                        game.TweenService:Create(v80.Title, TweenInfo.new(5, Enum.EasingStyle.Quint), {
                            MaxVisibleGraphemes = #v80.Title.Text + 10
                        }):Play();
                    end;
                end;
            end;
            task.spawn(function() --[[ Line: 269 ]]
                -- upvalues: v63 (copy), v62 (ref), l_Menu_1 (ref), l_InfoContainer_1 (ref), l_LocalPlayer_0 (ref), l_UserInputService_0 (ref), v65 (copy), l_TextService_0 (ref), v52 (ref)
                local v81 = false;
                local v82 = {};
                local function v83(v84) --[[ Line: 272 ]] --[[ Name: addStatus ]]
                    -- upvalues: v83 (copy), v82 (copy)
                    if v84:IsA("Folder") then
                        for _, v86 in pairs(v84:GetChildren()) do
                            v83(v86);
                        end;
                        return;
                    else
                        if v84:IsA("ModuleScript") then
                            local v87 = require(v84);
                            v82[v84.Name] = v87.Data.Description or "???";
                        end;
                        return;
                    end;
                end;
                v83(game.ReplicatedStorage.Modules.StatusEffects);
                local v88 = nil;
                while task.wait() and v63 and v62 == v63 do
                    if l_Menu_1.Visible and l_InfoContainer_1.Size.X.Scale >= 0.5 and l_LocalPlayer_0.Character and tostring(l_LocalPlayer_0.Character.Parent) == "Spectating" then
                        local v89 = l_UserInputService_0:GetMouseLocation() - game.GuiService:GetGuiInset();
                        local v90 = false;
                        for _, v92 in pairs(v65) do
                            if not v90 then
                                local l_AbsolutePosition_0 = v92.AbsolutePosition;
                                local l_AbsoluteSize_0 = v92.AbsoluteSize;
                                if v89.X >= l_AbsolutePosition_0.X and v89.X <= l_AbsolutePosition_0.X + l_AbsoluteSize_0.X and v89.Y >= l_AbsolutePosition_0.Y and v89.Y <= l_AbsolutePosition_0.Y + l_AbsoluteSize_0.Y then
                                    local v95 = v92.Text:gsub("<.->", "");
                                    local l_Font_0 = v92.Font;
                                    local l_TextSize_0 = v92.TextSize;
                                    local l_X_0 = l_AbsoluteSize_0.X;
                                    local v99 = v95:split("\n");
                                    local v100 = {};
                                    for _, v102 in ipairs(v99) do
                                        local v103 = v102:split(" ");
                                        local v104 = {};
                                        local v105 = 0;
                                        for _, v107 in ipairs(v103) do
                                            local l_l_TextService_0_TextSize_0 = l_TextService_0:GetTextSize(v107, l_TextSize_0, l_Font_0, Vector2.new(l_X_0, 1e999));
                                            local l_X_1 = l_TextService_0:GetTextSize(" ", l_TextSize_0, l_Font_0, Vector2.new(l_X_0, 1e999)).X;
                                            if l_X_0 < v105 + l_l_TextService_0_TextSize_0.X then
                                                table.insert(v100, v104);
                                                v104 = {};
                                                v105 = 0;
                                            end;
                                            table.insert(v104, v107);
                                            v105 = v105 + l_l_TextService_0_TextSize_0.X + l_X_1;
                                        end;
                                        if #v104 > 0 then
                                            table.insert(v100, v104);
                                        end;
                                    end;
                                    local l_Y_1 = l_TextService_0:GetTextSize("Test", l_TextSize_0, l_Font_0, Vector2.new(l_X_0, 1e999)).Y;
                                    local v111 = 0;
                                    for _, v113 in ipairs(v100) do
                                        if not v90 then
                                            local v114 = l_AbsolutePosition_0.Y + v111;
                                            local v115 = v114 + l_Y_1;
                                            if v114 <= v89.Y and v89.Y <= v115 then
                                                local v116 = 0;
                                                for _, v118 in ipairs(v113) do
                                                    local l_l_TextService_0_TextSize_1 = l_TextService_0:GetTextSize(v118, l_TextSize_0, l_Font_0, Vector2.new(l_X_0, 1e999));
                                                    local v120 = l_AbsolutePosition_0.X + v116;
                                                    local v121 = v120 + l_l_TextService_0_TextSize_1.X;
                                                    if v120 <= v89.X and v89.X <= v121 then
                                                        local _ = game.ReplicatedStorage.Modules.StatusEffects;
                                                        local v123 = v82[v118];
                                                        if v123 then
                                                            v90 = true;
                                                            v88 = v52:CreateTooltip(v123);
                                                            v81 = true;
                                                        else
                                                            v81 = true;
                                                        end;
                                                    else
                                                        local l_X_2 = l_TextService_0:GetTextSize(" ", l_TextSize_0, l_Font_0, Vector2.new(l_X_0, 1e999)).X;
                                                        v116 = v116 + l_l_TextService_0_TextSize_1.X + l_X_2;
                                                    end;
                                                    if v81 then
                                                        break;
                                                    end;
                                                    if v81 then
                                                        break;
                                                    end;
                                                end;
                                                if not v81 then
                                                    if not v81 then
                                                        break;
                                                    end;
                                                end;
                                            else
                                                v111 = v111 + l_Y_1;
                                            end;
                                        else
                                            break;
                                        end;
                                        if v81 then
                                            break;
                                        end;
                                        if v81 then
                                            break;
                                        end;
                                    end;
                                end;
                            else
                                break;
                            end;
                            v81 = false;
                        end;
                        if not v90 then
                            v88 = v52:CreateTooltip();
                        end;
                    elseif v88 then
                        v88 = v52:CreateTooltip();
                    end;
                end;
            end);
        end;
    end;
    local function v137(v126) --[[ Line: 394 ]] --[[ Name: loadActorSkins ]]
        -- upvalues: l_SkinsContainer_0 (copy), v0 (ref), l_LocalPlayer_0 (copy), v28 (copy), v61 (copy)
        if v126 then
            for _, v128 in pairs(l_SkinsContainer_0.Contents:GetChildren()) do
                if v128:IsA("GuiObject") then
                    v128:Destroy();
                end;
            end;
            local v129 = v0.CurrentlySelected and v0.CurrentlySelected:FindFirstChild("Config");
            local v130 = v129 and require(v129);
            l_SkinsContainer_0.TitleDisplay.Title.Text = ("%* Skins"):format(v130.DisplayName or tostring(v126.Name));
            for _, v132 in pairs(v126:GetChildren()) do
                if l_LocalPlayer_0.PlayerData.Purchased.Skins:FindFirstChild(v132.Name, true) then
                    local v133 = require(v132.Config);
                    local v134 = script.Templates.CardTemplate:Clone();
                    local l_Container_1 = v134.Container;
                    v134.Name = v132.Name;
                    v134.LayoutOrder = v133.Price or 1000;
                    v134.Parent = l_SkinsContainer_0.Contents;
                    l_Container_1.CharacterRender.Image = v133.RenderImage or "rbxassetid://13373279056";
                    l_Container_1.Title.Text = tostring(v133.DisplayName);
                    if v133.ExclusiveText or v133.Exclusive then
                        script.Templates.ExclusiveGradient:Clone().Parent = l_Container_1.Outline;
                        l_Container_1.Outline.ImageColor3 = Color3.new(1, 1, 1);
                    end;
                    local l_Name_0 = v126.Parent.Name;
                    if l_Name_0 == "Survivors" then
                        l_Container_1.Title.TextColor3 = Color3.fromRGB(200, 200, 255);
                    elseif l_Name_0 == "Killers" then
                        l_Container_1.Title.TextColor3 = Color3.fromRGB(255, 200, 200);
                    end;
                    l_Container_1.MouseEnter:Connect(function() --[[ Line: 440 ]]
                        -- upvalues: l_Container_1 (copy)
                        game.TweenService:Create(l_Container_1, TweenInfo.new(0.25), {
                            Size = UDim2.fromScale(1.05, 1.05)
                        }):Play();
                    end);
                    l_Container_1.MouseLeave:Connect(function() --[[ Line: 444 ]]
                        -- upvalues: l_Container_1 (copy)
                        game.TweenService:Create(l_Container_1, TweenInfo.new(0.25), {
                            Size = UDim2.fromScale(1, 1)
                        }):Play();
                    end);
                    l_Container_1.Interact.MouseButton1Click:Connect(function() --[[ Line: 448 ]]
                        -- upvalues: v28 (ref), v132 (copy), l_Container_1 (copy)
                        v28:FireServerConnection("EquipContent", "REMOTE_EVENT", v132, l_Container_1.Equipped.ImageTransparency < 0.5);
                    end);
                    v61(true);
                end;
            end;
        end;
    end;
    local v138 = nil;
    local v139 = false;
    l_EquipContainer_0.Buttons.ViewInfo.MouseButton1Click:Connect(function() --[[ Line: 461 ]]
        -- upvalues: v139 (ref), v0 (ref), v125 (copy), v138 (ref), l_InfoContainer_1 (copy), l_EquipContainer_0 (copy), l_SkinsContainer_0 (copy), l_InventoryContainer_1 (copy)
        if v139 then
            return;
        else
            v139 = true;
            local v140 = v0.CurrentlySelected and v0.CurrentlySelected:FindFirstChild("Config");
            local v141 = v140 and require(v140);
            if v141 and v141.Information then
                v125(v141.Information);
                if v138 then
                    task.cancel(v138);
                end;
                if l_InfoContainer_1.Size.X.Scale >= 0.35 then
                    game.TweenService:Create(l_EquipContainer_0.Buttons.ViewSkins.Inverted, TweenInfo.new(0.25), {
                        ImageTransparency = 1
                    }):Play();
                    game.TweenService:Create(l_EquipContainer_0.Buttons.ViewInfo.Inverted, TweenInfo.new(0.25), {
                        ImageTransparency = 1
                    }):Play();
                    game.TweenService:Create(l_SkinsContainer_0, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(0, 1)
                    }):Play();
                    game.TweenService:Create(l_InfoContainer_1, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(0, 1)
                    }):Play();
                    game.TweenService:Create(l_InventoryContainer_1, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(0.7, 1)
                    }):Play();
                    v138 = task.delay(0.25, function() --[[ Line: 476 ]]
                        -- upvalues: l_SkinsContainer_0 (ref), l_InfoContainer_1 (ref)
                        l_SkinsContainer_0.Visible = false;
                        l_InfoContainer_1.Visible = false;
                    end);
                    task.delay(0.175, function() --[[ Line: 477 ]]
                        -- upvalues: v139 (ref)
                        v139 = false;
                    end);
                    l_InventoryContainer_1.Visible = true;
                    return;
                else
                    game.TweenService:Create(l_EquipContainer_0.Buttons.ViewSkins.Inverted, TweenInfo.new(0.25), {
                        ImageTransparency = 1
                    }):Play();
                    game.TweenService:Create(l_EquipContainer_0.Buttons.ViewInfo.Inverted, TweenInfo.new(0.25), {
                        ImageTransparency = 0
                    }):Play();
                    game.TweenService:Create(l_SkinsContainer_0, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(0, 1)
                    }):Play();
                    game.TweenService:Create(l_InfoContainer_1, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(0.7, 1)
                    }):Play();
                    game.TweenService:Create(l_InventoryContainer_1, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(0, 1)
                    }):Play();
                    v138 = task.delay(0.25, function() --[[ Line: 485 ]]
                        -- upvalues: l_SkinsContainer_0 (ref), l_InventoryContainer_1 (ref)
                        l_SkinsContainer_0.Visible = false;
                        l_InventoryContainer_1.Visible = false;
                    end);
                    task.delay(0.175, function() --[[ Line: 486 ]]
                        -- upvalues: v139 (ref)
                        v139 = false;
                    end);
                    l_InfoContainer_1.Visible = true;
                end;
            end;
            return;
        end;
    end);
    l_EquipContainer_0.Buttons.ViewSkins.MouseButton1Click:Connect(function() --[[ Line: 493 ]]
        -- upvalues: v139 (ref), v0 (ref), v137 (copy), v138 (ref), l_SkinsContainer_0 (copy), l_EquipContainer_0 (copy), l_InfoContainer_1 (copy), l_InventoryContainer_1 (copy)
        if v139 then
            return;
        else
            v139 = true;
            if not v0.CurrentlySelected then
                return;
            else
                local l_FirstChild_2 = game.ReplicatedStorage.Assets.Skins:FindFirstChild((tostring(v0.CurrentlySelected.Parent)));
                local v143 = l_FirstChild_2 and l_FirstChild_2:FindFirstChild((tostring(v0.CurrentlySelected)));
                if v143 then
                    v137(v143);
                    if v138 then
                        task.cancel(v138);
                    end;
                    if l_SkinsContainer_0.Size.X.Scale >= 0.35 then
                        game.TweenService:Create(l_EquipContainer_0.Buttons.ViewSkins.Inverted, TweenInfo.new(0.25), {
                            ImageTransparency = 1
                        }):Play();
                        game.TweenService:Create(l_EquipContainer_0.Buttons.ViewInfo.Inverted, TweenInfo.new(0.25), {
                            ImageTransparency = 1
                        }):Play();
                        game.TweenService:Create(l_SkinsContainer_0, TweenInfo.new(0.25), {
                            Size = UDim2.fromScale(0, 1)
                        }):Play();
                        game.TweenService:Create(l_InfoContainer_1, TweenInfo.new(0.25), {
                            Size = UDim2.fromScale(0, 1)
                        }):Play();
                        game.TweenService:Create(l_InventoryContainer_1, TweenInfo.new(0.25), {
                            Size = UDim2.fromScale(0.7, 1)
                        }):Play();
                        v138 = task.delay(0.25, function() --[[ Line: 509 ]]
                            -- upvalues: l_InfoContainer_1 (ref), l_SkinsContainer_0 (ref)
                            l_InfoContainer_1.Visible = false;
                            l_SkinsContainer_0.Visible = false;
                        end);
                        task.delay(0.175, function() --[[ Line: 510 ]]
                            -- upvalues: v139 (ref)
                            v139 = false;
                        end);
                        l_InventoryContainer_1.Visible = true;
                        return;
                    else
                        game.TweenService:Create(l_EquipContainer_0.Buttons.ViewSkins.Inverted, TweenInfo.new(0.25), {
                            ImageTransparency = 0
                        }):Play();
                        game.TweenService:Create(l_EquipContainer_0.Buttons.ViewInfo.Inverted, TweenInfo.new(0.25), {
                            ImageTransparency = 1
                        }):Play();
                        game.TweenService:Create(l_SkinsContainer_0, TweenInfo.new(0.25), {
                            Size = UDim2.fromScale(0.7, 1)
                        }):Play();
                        game.TweenService:Create(l_InfoContainer_1, TweenInfo.new(0.25), {
                            Size = UDim2.fromScale(0, 1)
                        }):Play();
                        game.TweenService:Create(l_InventoryContainer_1, TweenInfo.new(0.25), {
                            Size = UDim2.fromScale(0, 1)
                        }):Play();
                        v138 = task.delay(0.25, function() --[[ Line: 518 ]]
                            -- upvalues: l_InfoContainer_1 (ref), l_InventoryContainer_1 (ref)
                            l_InfoContainer_1.Visible = false;
                            l_InventoryContainer_1.Visible = false;
                        end);
                        task.delay(0.175, function() --[[ Line: 519 ]]
                            -- upvalues: v139 (ref)
                            v139 = false;
                        end);
                        l_SkinsContainer_0.Visible = true;
                    end;
                end;
                return;
            end;
        end;
    end);
    for _, v145 in pairs(l_EquipContainer_0.Buttons:GetChildren()) do
        local l_v145_Attribute_0 = v145:GetAttribute("Description");
        if l_v145_Attribute_0 then
            v145.MouseEnter:Connect(function() --[[ Line: 529 ]]
                -- upvalues: l_EquipContainer_0 (copy), l_v145_Attribute_0 (copy)
                l_EquipContainer_0.ButtonDescription.Title.Text = l_v145_Attribute_0;
                game.TweenService:Create(l_EquipContainer_0.ButtonDescription.Title, TweenInfo.new(0.25), {
                    TextTransparency = 0
                }):Play();
            end);
            v145.MouseLeave:Connect(function() --[[ Line: 534 ]]
                -- upvalues: l_EquipContainer_0 (copy), l_v145_Attribute_0 (copy)
                if l_EquipContainer_0.ButtonDescription.Title.Text == l_v145_Attribute_0 then
                    game.TweenService:Create(l_EquipContainer_0.ButtonDescription.Title, TweenInfo.new(0.25), {
                        TextTransparency = 1
                    }):Play();
                end;
            end);
        end;
    end;
    v0.__tabsData = {};
    for _, v148 in pairs(script.Tabs:GetChildren()) do
        local v149 = require(v148);
        v149.Inventory = v0;
        local l_v149_Tab_0 = v149:CreateTab(l_Menu_1);
        v0.__tabsData[v148.Name] = l_v149_Tab_0;
    end;
    v0:SwitchTab("Killers");
    v61();
    for _, v152 in pairs(l_Equipped_0:GetDescendants()) do
        if v152:IsA("ValueBase") then
            v152:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 557 ]]
                -- upvalues: l_SideContainer_1 (copy), v61 (copy)
                l_SideContainer_1.EquipContainer.Equip.Title.Text = "Equipped";
                v61();
            end);
        end;
    end;
    for _, v154 in pairs(l_Topbar_1:GetChildren()) do
        if v154:IsA("ImageButton") then
            v154.MouseButton1Click:Connect(function() --[[ Line: 567 ]]
                -- upvalues: v0 (ref), v154 (copy), v61 (copy)
                v0:SwitchTab(v154.Name);
                v61(true);
            end);
        end;
    end;
    l_Searchbar_1.TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 575 ]]
        -- upvalues: l_InventoryContainer_1 (copy), l_Searchbar_1 (copy)
        for _, v156 in pairs(l_InventoryContainer_1.Contents:GetChildren()) do
            if v156:IsA("Frame") then
                local l_Title_0 = v156.Container.Title;
                local v158 = true;
                if l_Searchbar_1.TextBox.Text ~= "" then
                    v158 = string.find(l_Title_0.Text:lower(), l_Searchbar_1.TextBox.Text:lower());
                end;
                v156.Visible = v158;
            end;
        end;
    end);
end;
return v0;