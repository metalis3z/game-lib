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
    local function v54() --[[ Line: 138 ]] --[[ Name: giveDevKillers ]]
        -- upvalues: l_LocalPlayer_0 (copy)
        if workspace:GetAttribute("ServerType") == "VIP" and l_LocalPlayer_0:GetAttribute("VIP") then
            local l_PlayerData_0 = l_LocalPlayer_0:FindFirstChild("PlayerData");
            if not l_PlayerData_0 then
                return;
            else
                for _, v50 in ipairs(require(game.ReplicatedStorage.Modules.Schematics.VIPKillersSchematic)) do
                    if v50.Type and v50.Name then
                        local l_FirstChild_2 = l_PlayerData_0.Purchased:FindFirstChild(v50.Type);
                        local l_FirstChild_3 = game.ReplicatedStorage.Assets:FindFirstChild(v50.Type);
                        if not l_FirstChild_3 or not l_FirstChild_2 then
                            warn((("[%*]: Could not find folder for item type %* in %*"):format(script, v50.Type, not l_FirstChild_3 and "Assets" or ("%*'s PlayerData"):format(l_LocalPlayer_0.Name))));
                        elseif not l_FirstChild_3:FindFirstChild(v50.Name, true) then
                            warn((("[%*]: Could not find folder for item %*"):format(script, v50.Name)));
                        elseif not l_FirstChild_2:FindFirstChild(v50.Name) then
                            local l_NumberValue_0 = Instance.new("NumberValue");
                            l_NumberValue_0:SetAttribute("Temp", true);
                            l_NumberValue_0.Name = v50.Name;
                            l_NumberValue_0.Parent = l_FirstChild_2;
                        end;
                    end;
                end;
            end;
        end;
    end;
    local function v56(v55) --[[ Line: 171 ]] --[[ Name: addUIThingies ]]
        -- upvalues: v29 (copy)
        if (v55:IsA("TextButton") or v55:IsA("ImageButton")) and not v55:GetAttribute("SFXImplemented") then
            v55:SetAttribute("SFXImplemented", true);
            v55.MouseEnter:Connect(function() --[[ Line: 175 ]]
                -- upvalues: v29 (ref)
                v29:Play("hover");
            end);
            v55.MouseLeave:Connect(function() --[[ Line: 179 ]]
                -- upvalues: v29 (ref)
                v29:Play("hoverEnd");
            end);
            if v55.Parent.Name ~= "Topbar" then
                v55.MouseButton1Click:Connect(function() --[[ Line: 184 ]]
                    -- upvalues: v29 (ref)
                    v29:Play("select");
                end);
            end;
        end;
    end;
    for _, v58 in pairs(l_Menu_1:GetDescendants()) do
        v56(v58);
    end;
    l_Menu_1.DescendantAdded:Connect(v56);
    local v59 = require(game.ReplicatedStorage.Modules.Util);
    v59:CreateMoneyDisplay(l_InventoryContainer_1.Money);
    l_EquipContainer_0.Equip.MouseButton1Click:Connect(function() --[[ Line: 198 ]]
        -- upvalues: v28 (copy), v0 (ref)
        v28:FireServerConnection("EquipState", "REMOTE_EVENT", v0.CurrentlySelected);
    end);
    local function v68(v60) --[[ Line: 203 ]] --[[ Name: updateEquips ]]
        -- upvalues: l_InventoryContainer_1 (copy), l_SkinsContainer_0 (copy), l_Equipped_0 (copy)
        for _, v62 in pairs({
            l_InventoryContainer_1.Contents, 
            l_SkinsContainer_0.Contents
        }) do
            for _, v64 in pairs(v62:GetChildren()) do
                if v64:IsA("GuiObject") and not v64:GetAttribute("IgnoreEquipUpdate") then
                    local v65 = nil;
                    for _, v67 in pairs(l_Equipped_0:GetDescendants()) do
                        if v67:IsA("ValueBase") and v67.Value == v64.Name then
                            v65 = true;
                            break;
                        end;
                    end;
                    if v65 and v64.Container.Equipped.ImageTransparency ~= 0 then
                        if v60 then
                            v64.Container.Equipped.ImageTransparency = 0;
                        else
                            game.TweenService:Create(v64.Container.Equipped, TweenInfo.new(0.125), {
                                ImageTransparency = 0
                            }):Play();
                        end;
                    elseif not v65 and v64.Container.Equipped.ImageTransparency ~= 1 then
                        game.TweenService:Create(v64.Container.Equipped, TweenInfo.new(0.125), {
                            ImageTransparency = 1
                        }):Play();
                    end;
                end;
            end;
        end;
    end;
    local v69 = nil;
    local function v132(v70) --[[ Line: 234 ]] --[[ Name: loadActorInfo ]]
        -- upvalues: v69 (ref), l_InfoContainer_1 (copy), l_Menu_1 (copy), l_LocalPlayer_0 (copy), l_UserInputService_0 (copy), l_TextService_0 (copy), v59 (copy)
        if v69 ~= v70 then
            v69 = v70;
            local l_Templates_0 = script.Templates;
            local v72 = {};
            for _, v74 in pairs(l_InfoContainer_1.Contents:GetChildren()) do
                if v74:IsA("GuiObject") then
                    v74:Destroy();
                end;
            end;
            local l_pairs_0 = pairs;
            local v76 = v70 or {};
            for v77, v78 in l_pairs_0(v76) do
                local l_Frame_0 = Instance.new("Frame");
                l_Frame_0.Name = "Content";
                l_Frame_0.BackgroundTransparency = 1;
                l_Frame_0.Size = UDim2.fromScale(1, 0);
                l_Frame_0.AutomaticSize = Enum.AutomaticSize.Y;
                l_Frame_0.LayoutOrder = v77;
                l_Frame_0.Parent = l_InfoContainer_1.Contents;
                local l_UIListLayout_0 = Instance.new("UIListLayout");
                l_UIListLayout_0.Padding = UDim.new(0, 10);
                l_UIListLayout_0.HorizontalAlignment = Enum.HorizontalAlignment.Center;
                l_UIListLayout_0.Parent = l_Frame_0;
                local _ = workspace.CurrentCamera.ViewportSize.Y;
                for v82, v83 in pairs(v78) do
                    if v82 == "Separator" then
                        local v84 = l_Templates_0.Seperator:Clone();
                        v84.Title.Text = tostring(v83);
                        v84.Parent = l_Frame_0;
                    elseif v82 == "Header" then
                        local v85 = l_Templates_0.Header:Clone();
                        v85.Text = tostring(v83);
                        v85.Parent = l_Frame_0;
                    elseif v82 == "Quote" then
                        local v86 = l_Templates_0.Quote:Clone();
                        v86.Text = tostring(v83);
                        v86.Parent = l_Frame_0;
                    elseif v82 == "Text" then
                        local v87 = l_Templates_0.TextContainer:Clone();
                        v87.Title.MaxVisibleGraphemes = 0;
                        v87.Title.Text = tostring(v83);
                        v87.Image.Image = tostring(v78.Image);
                        v87.Image.Visible = v78.Image;
                        v87.Parent = l_Frame_0;
                        table.insert(v72, v87.Title);
                        game.TweenService:Create(v87.Title, TweenInfo.new(5, Enum.EasingStyle.Quint), {
                            MaxVisibleGraphemes = #v87.Title.Text + 10
                        }):Play();
                    end;
                end;
            end;
            task.spawn(function() --[[ Line: 302 ]]
                -- upvalues: v70 (copy), v69 (ref), l_Menu_1 (ref), l_InfoContainer_1 (ref), l_LocalPlayer_0 (ref), l_UserInputService_0 (ref), v72 (copy), l_TextService_0 (ref), v59 (ref)
                local v88 = false;
                local v89 = {};
                local function v90(v91) --[[ Line: 305 ]] --[[ Name: addStatus ]]
                    -- upvalues: v90 (copy), v89 (copy)
                    if v91:IsA("Folder") then
                        for _, v93 in pairs(v91:GetChildren()) do
                            v90(v93);
                        end;
                        return;
                    else
                        if v91:IsA("ModuleScript") then
                            local v94 = require(v91);
                            v89[v91.Name] = v94.Data.Description or "???";
                        end;
                        return;
                    end;
                end;
                v90(game.ReplicatedStorage.Modules.StatusEffects);
                local v95 = nil;
                while task.wait() and v70 and v69 == v70 do
                    if l_Menu_1.Visible and l_InfoContainer_1.Size.X.Scale >= 0.5 and l_LocalPlayer_0.Character and tostring(l_LocalPlayer_0.Character.Parent) == "Spectating" then
                        local v96 = l_UserInputService_0:GetMouseLocation() - game.GuiService:GetGuiInset();
                        local v97 = false;
                        for _, v99 in pairs(v72) do
                            if not v97 then
                                local l_AbsolutePosition_0 = v99.AbsolutePosition;
                                local l_AbsoluteSize_0 = v99.AbsoluteSize;
                                if v96.X >= l_AbsolutePosition_0.X and v96.X <= l_AbsolutePosition_0.X + l_AbsoluteSize_0.X and v96.Y >= l_AbsolutePosition_0.Y and v96.Y <= l_AbsolutePosition_0.Y + l_AbsoluteSize_0.Y then
                                    local v102 = v99.Text:gsub("<.->", "");
                                    local l_Font_0 = v99.Font;
                                    local l_TextSize_0 = v99.TextSize;
                                    local l_X_0 = l_AbsoluteSize_0.X;
                                    local v106 = v102:split("\n");
                                    local v107 = {};
                                    for _, v109 in ipairs(v106) do
                                        local v110 = v109:split(" ");
                                        local v111 = {};
                                        local v112 = 0;
                                        for _, v114 in ipairs(v110) do
                                            local l_l_TextService_0_TextSize_0 = l_TextService_0:GetTextSize(v114, l_TextSize_0, l_Font_0, Vector2.new(l_X_0, 1e999));
                                            local l_X_1 = l_TextService_0:GetTextSize(" ", l_TextSize_0, l_Font_0, Vector2.new(l_X_0, 1e999)).X;
                                            if l_X_0 < v112 + l_l_TextService_0_TextSize_0.X then
                                                table.insert(v107, v111);
                                                v111 = {};
                                                v112 = 0;
                                            end;
                                            table.insert(v111, v114);
                                            v112 = v112 + l_l_TextService_0_TextSize_0.X + l_X_1;
                                        end;
                                        if #v111 > 0 then
                                            table.insert(v107, v111);
                                        end;
                                    end;
                                    local l_Y_1 = l_TextService_0:GetTextSize("Test", l_TextSize_0, l_Font_0, Vector2.new(l_X_0, 1e999)).Y;
                                    local v118 = 0;
                                    for _, v120 in ipairs(v107) do
                                        if not v97 then
                                            local v121 = l_AbsolutePosition_0.Y + v118;
                                            local v122 = v121 + l_Y_1;
                                            if v121 <= v96.Y and v96.Y <= v122 then
                                                local v123 = 0;
                                                for _, v125 in ipairs(v120) do
                                                    local l_l_TextService_0_TextSize_1 = l_TextService_0:GetTextSize(v125, l_TextSize_0, l_Font_0, Vector2.new(l_X_0, 1e999));
                                                    local v127 = l_AbsolutePosition_0.X + v123;
                                                    local v128 = v127 + l_l_TextService_0_TextSize_1.X;
                                                    if v127 <= v96.X and v96.X <= v128 then
                                                        local _ = game.ReplicatedStorage.Modules.StatusEffects;
                                                        local v130 = v89[v125];
                                                        if v130 then
                                                            v97 = true;
                                                            v95 = v59:CreateTooltip(v130);
                                                            v88 = true;
                                                        else
                                                            v88 = true;
                                                        end;
                                                    else
                                                        local l_X_2 = l_TextService_0:GetTextSize(" ", l_TextSize_0, l_Font_0, Vector2.new(l_X_0, 1e999)).X;
                                                        v123 = v123 + l_l_TextService_0_TextSize_1.X + l_X_2;
                                                    end;
                                                    if v88 then
                                                        break;
                                                    end;
                                                    if v88 then
                                                        break;
                                                    end;
                                                end;
                                                if not v88 then
                                                    if not v88 then
                                                        break;
                                                    end;
                                                end;
                                            else
                                                v118 = v118 + l_Y_1;
                                            end;
                                        else
                                            break;
                                        end;
                                        if v88 then
                                            break;
                                        end;
                                        if v88 then
                                            break;
                                        end;
                                    end;
                                end;
                            else
                                break;
                            end;
                            v88 = false;
                        end;
                        if not v97 then
                            v95 = v59:CreateTooltip();
                        end;
                    elseif v95 then
                        v95 = v59:CreateTooltip();
                    end;
                end;
            end);
        end;
    end;
    local function v146(v133) --[[ Line: 427 ]] --[[ Name: loadActorSkins ]]
        -- upvalues: l_SkinsContainer_0 (copy), v0 (ref), l_LocalPlayer_0 (copy), v59 (copy), v28 (copy), v68 (copy)
        if v133 then
            for _, v135 in pairs(l_SkinsContainer_0.Contents:GetChildren()) do
                if v135:IsA("GuiObject") then
                    v135:Destroy();
                end;
            end;
            local v136 = v0.CurrentlySelected and v0.CurrentlySelected:FindFirstChild("Config");
            local v137 = v136 and require(v136);
            l_SkinsContainer_0.TitleDisplay.Title.Text = ("%* Skins"):format(v137.DisplayName or tostring(v133.Name));
            for _, v139 in pairs(v133:GetChildren()) do
                if l_LocalPlayer_0.PlayerData.Purchased.Skins:FindFirstChild(v139.Name, true) then
                    local v140 = require(v139.Config);
                    local v141 = script.Templates.CardTemplate:Clone();
                    local l_Container_1 = v141.Container;
                    v141.Name = v139.Name;
                    v141.LayoutOrder = v140.Price or 1000;
                    v141.Parent = l_SkinsContainer_0.Contents;
                    l_Container_1.CharacterRender.Image = v140.RenderImage or "rbxassetid://13373279056";
                    l_Container_1.Title.Text = tostring(v140.DisplayName);
                    if v140.ExclusiveText or v140.Exclusive then
                        script.Templates.ExclusiveGradient:Clone().Parent = l_Container_1.Outline;
                        l_Container_1.Outline.ImageColor3 = Color3.new(1, 1, 1);
                    end;
                    if v140.SpecialText or v140.Special then
                        script.Templates.SpecialGradient:Clone().Parent = l_Container_1.Outline;
                        l_Container_1.Outline.ImageColor3 = Color3.new(1, 1, 1);
                    end;
                    if v140.Dev and v140.Exclusive then
                        l_Container_1.Outline.ImageColor3 = Color3.new(1, 1, 1);
                        l_Container_1.Outline.Image = "rbxassetid://96503567839232";
                    end;
                    if v140.Uncommon then
                        script.Templates.UncommonGradient:Clone().Parent = l_Container_1.Outline;
                        l_Container_1.Outline.ImageColor3 = Color3.new(1, 1, 1);
                    end;
                    if v140.Epic then
                        script.Templates.EpicGradient:Clone().Parent = l_Container_1.Outline;
                        l_Container_1.Outline.ImageColor3 = Color3.new(1, 1, 1);
                    end;
                    if v140.Legendary then
                        script.Templates.LegendaryGradient:Clone().Parent = l_Container_1.Outline;
                        l_Container_1.Outline.ImageColor3 = Color3.new(1, 1, 1);
                    end;
                    local v143 = require(game.ReplicatedStorage.Modules.Schematics.IngameCollabs)[v140.CollabInfo] or v140.CollabInfo;
                    if typeof(v143) == "table" then
                        local v144 = game.ReplicatedStorage.Assets.UI.ShopCardIcon:Clone();
                        v144.Image = v143.Icon or "rbxassetid://9011713759";
                        v144.Parent = l_Container_1.CardIcons;
                        v144.MouseEnter:Connect(function() --[[ Line: 497 ]]
                            -- upvalues: v59 (ref), v143 (copy)
                            v59:CreateTooltip(v143.Description);
                        end);
                        v144.MouseLeave:Connect(function() --[[ Line: 502 ]]
                            -- upvalues: v59 (ref)
                            v59:CreateTooltip();
                        end);
                    end;
                    local l_Name_0 = v133.Parent.Name;
                    if l_Name_0 == "Survivors" then
                        l_Container_1.Title.TextColor3 = Color3.fromRGB(200, 200, 255);
                    elseif l_Name_0 == "Killers" then
                        l_Container_1.Title.TextColor3 = Color3.fromRGB(255, 200, 200);
                    end;
                    l_Container_1.MouseEnter:Connect(function() --[[ Line: 517 ]]
                        -- upvalues: l_Container_1 (copy)
                        game.TweenService:Create(l_Container_1, TweenInfo.new(0.25), {
                            Size = UDim2.fromScale(1.05, 1.05)
                        }):Play();
                    end);
                    l_Container_1.MouseLeave:Connect(function() --[[ Line: 521 ]]
                        -- upvalues: l_Container_1 (copy)
                        game.TweenService:Create(l_Container_1, TweenInfo.new(0.25), {
                            Size = UDim2.fromScale(1, 1)
                        }):Play();
                    end);
                    l_Container_1.Interact.MouseButton1Click:Connect(function() --[[ Line: 525 ]]
                        -- upvalues: v28 (ref), v139 (copy), l_Container_1 (copy)
                        v28:FireServerConnection("EquipState", "REMOTE_EVENT", v139, l_Container_1.Equipped.ImageTransparency < 0.5);
                    end);
                    v68(true);
                end;
            end;
        end;
    end;
    local v147 = nil;
    local v148 = false;
    l_EquipContainer_0.Buttons.ViewInfo.MouseButton1Click:Connect(function() --[[ Line: 538 ]]
        -- upvalues: v148 (ref), v0 (ref), v132 (copy), v147 (ref), l_InfoContainer_1 (copy), l_EquipContainer_0 (copy), l_SkinsContainer_0 (copy), l_InventoryContainer_1 (copy)
        if v148 then
            return;
        else
            v148 = true;
            local v149 = v0.CurrentlySelected and v0.CurrentlySelected:FindFirstChild("Config");
            local v150 = v149 and require(v149);
            if not v150 or not v150.Information then
                v148 = false;
                return;
            else
                v132(v150.Information);
                if v147 then
                    task.cancel(v147);
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
                    v147 = task.delay(0.25, function() --[[ Line: 558 ]]
                        -- upvalues: l_SkinsContainer_0 (ref), l_InfoContainer_1 (ref)
                        l_SkinsContainer_0.Visible = false;
                        l_InfoContainer_1.Visible = false;
                    end);
                    task.delay(0.175, function() --[[ Line: 559 ]]
                        -- upvalues: v148 (ref)
                        v148 = false;
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
                    v147 = task.delay(0.25, function() --[[ Line: 567 ]]
                        -- upvalues: l_SkinsContainer_0 (ref), l_InventoryContainer_1 (ref)
                        l_SkinsContainer_0.Visible = false;
                        l_InventoryContainer_1.Visible = false;
                    end);
                    task.delay(0.175, function() --[[ Line: 568 ]]
                        -- upvalues: v148 (ref)
                        v148 = false;
                    end);
                    l_InfoContainer_1.Visible = true;
                    return;
                end;
            end;
        end;
    end);
    l_EquipContainer_0.Buttons.ViewSkins.MouseButton1Click:Connect(function() --[[ Line: 574 ]]
        -- upvalues: v148 (ref), v0 (ref), v146 (copy), v147 (ref), l_SkinsContainer_0 (copy), l_EquipContainer_0 (copy), l_InfoContainer_1 (copy), l_InventoryContainer_1 (copy)
        if v148 then
            return;
        else
            v148 = true;
            if not v0.CurrentlySelected then
                return;
            else
                local l_FirstChild_4 = game.ReplicatedStorage.Assets.Skins:FindFirstChild((tostring(v0.CurrentlySelected.Parent)));
                local v152 = l_FirstChild_4 and l_FirstChild_4:FindFirstChild((tostring(v0.CurrentlySelected)));
                if not v152 then
                    v148 = false;
                    return;
                else
                    v146(v152);
                    if v147 then
                        task.cancel(v147);
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
                        v147 = task.delay(0.25, function() --[[ Line: 595 ]]
                            -- upvalues: l_InfoContainer_1 (ref), l_SkinsContainer_0 (ref)
                            l_InfoContainer_1.Visible = false;
                            l_SkinsContainer_0.Visible = false;
                        end);
                        task.delay(0.175, function() --[[ Line: 596 ]]
                            -- upvalues: v148 (ref)
                            v148 = false;
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
                        v147 = task.delay(0.25, function() --[[ Line: 604 ]]
                            -- upvalues: l_InfoContainer_1 (ref), l_InventoryContainer_1 (ref)
                            l_InfoContainer_1.Visible = false;
                            l_InventoryContainer_1.Visible = false;
                        end);
                        task.delay(0.175, function() --[[ Line: 605 ]]
                            -- upvalues: v148 (ref)
                            v148 = false;
                        end);
                        l_SkinsContainer_0.Visible = true;
                        return;
                    end;
                end;
            end;
        end;
    end);
    for _, v154 in pairs(l_EquipContainer_0.Buttons:GetChildren()) do
        local l_v154_Attribute_0 = v154:GetAttribute("Description");
        if l_v154_Attribute_0 then
            v154.Title.TextTransparency = 0;
            v154.Title.Text = l_v154_Attribute_0;
        end;
    end;
    v0.__tabsData = {};
    for _, v157 in pairs(script.Tabs:GetChildren()) do
        local v158 = require(v157);
        v158.Inventory = v0;
        local l_v158_Tab_0 = v158:CreateTab(l_Menu_1);
        v0.__tabsData[v157.Name] = l_v158_Tab_0;
    end;
    v0:SwitchTab("Killers");
    v68();
    for _, v161 in pairs(l_Equipped_0:GetDescendants()) do
        if v161:IsA("ValueBase") then
            v161:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 634 ]]
                -- upvalues: l_SideContainer_1 (copy), v68 (copy)
                l_SideContainer_1.EquipContainer.Equip.Title.Text = "Equipped";
                v68();
            end);
        end;
    end;
    for _, v163 in pairs(l_Topbar_1:GetChildren()) do
        if v163:IsA("ImageButton") then
            v163.MouseButton1Click:Connect(function() --[[ Line: 644 ]]
                -- upvalues: v0 (ref), v163 (copy), v68 (copy)
                v0:SwitchTab(v163.Name);
                v68(true);
            end);
        end;
    end;
    l_Searchbar_1.TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 652 ]]
        -- upvalues: l_InventoryContainer_1 (copy), l_Searchbar_1 (copy)
        for _, v165 in pairs(l_InventoryContainer_1.Contents:GetChildren()) do
            if v165:IsA("Frame") then
                local l_Title_0 = v165.Container.Title;
                local v167 = true;
                if l_Searchbar_1.TextBox.Text ~= "" then
                    v167 = string.find(l_Title_0.Text:lower(), l_Searchbar_1.TextBox.Text:lower());
                end;
                v165.Visible = v167;
            end;
        end;
    end);
    workspace:GetAttributeChangedSignal("ServerType"):Connect(v54);
    l_LocalPlayer_0:GetAttributeChangedSignal("VIP"):Connect(v54);
    v54();
end;
return v0;