-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.CreateTab = function(_, _) --[[ Line: 3 ]] --[[ Name: CreateTab ]]
    -- upvalues: v0 (copy)
    local v3 = require(game.ReplicatedStorage.Modules.Sounds);
    local l_Templates_0 = script.Parent.Parent.Templates;
    local v5 = {};
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local l_PlayerData_0 = l_LocalPlayer_0.PlayerData;
    local l_Emotes_0 = l_PlayerData_0.Purchased.Emotes;
    local l_Emotes_1 = l_PlayerData_0.Equipped.Emotes;
    local l_ExtraEmotes_0 = l_PlayerData_0.Equipped.ExtraEmotes;
    local l_l_LocalPlayer_0_Attribute_0 = l_LocalPlayer_0:GetAttribute("ExtraEmotes");
    local v12 = false;
    local v13 = nil;
    local v14 = l_Templates_0.EmoteMenuHolder:Clone();
    v0.EmoteWheel = v14;
    local v15 = false;
    local function v29(v16, v17) --[[ Line: 25 ]] --[[ Name: makeEmoteEquipList ]]
        -- upvalues: v15 (ref), v0 (ref), l_Templates_0 (copy), l_Emotes_0 (copy)
        if v15 then
            return;
        else
            v15 = true;
            task.delay(0.5, function() --[[ Line: 28 ]]
                -- upvalues: v15 (ref)
                v15 = false;
            end);
            if v0.EquipMenu then
                game.TweenService:Create(v0.EquipMenu, TweenInfo.new(0.2), {
                    Size = UDim2.fromScale(0, 0)
                }):Play();
                game.Debris:AddItem(v0.EquipMenu, 0.2);
            end;
            local v18 = l_Templates_0.EmoteEquipMenu:Clone();
            v18.Size = UDim2.fromScale();
            v18.Parent = v16.Parent;
            v18.Position = v16.Position;
            v18.ZIndex = 4;
            v0.EquipMenu = v18;
            game.TweenService:Create(v18, TweenInfo.new(0.2), {
                Size = UDim2.fromScale(0.56, 0.41)
            }):Play();
            for _, v20 in pairs({
                v18.Cancel, 
                v18.Unequip
            }) do
                v20.MouseButton1Click:Connect(function() --[[ Line: 47 ]]
                    -- upvalues: v18 (copy), v0 (ref), v20 (copy), v17 (copy), v16 (copy)
                    if v18 == v0.EquipMenu then
                        v0.EquipMenu = nil;
                        game.TweenService:Create(v18, TweenInfo.new(0.2), {
                            Size = UDim2.fromScale(0, 0)
                        }):Play();
                        game.Debris:AddItem(v18, 0.2);
                        if v20.Name == "Unequip" then
                            require(game.ReplicatedStorage.Modules.Network):FireServerConnection("EquipState", "REMOTE_EVENT", "Emotes", (v17.Name == "ExtraEmotes" and 8 or 0) + tonumber(v16.Name));
                        end;
                    end;
                end);
            end;
            v18.Searchbar.TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 64 ]]
                -- upvalues: v18 (copy)
                for _, v22 in pairs(v18.EmoteList:GetChildren()) do
                    if v22:IsA("GuiObject") then
                        local v23 = true;
                        if v18.Searchbar.TextBox.Text ~= "" then
                            v23 = v22.Name:lower():find(v18.Searchbar.TextBox.Text:lower());
                        end;
                        v22.Visible = v23;
                    end;
                end;
            end);
            for _, v25 in pairs(l_Emotes_0:GetChildren()) do
                local l_FirstChild_0 = game.ReplicatedStorage.Assets.Emotes:FindFirstChild(v25.Name);
                local v27 = l_FirstChild_0 and require(l_FirstChild_0);
                if v27 then
                    local v28 = l_Templates_0.EmoteHolder:Clone();
                    v28.Name = v27.DisplayName or l_FirstChild_0.Name;
                    v28.Title.Text = v28.Name;
                    v28.Button.Icon.Image = v27.RenderImage or "";
                    v28.Parent = v18.EmoteList;
                    v28.Button.MouseButton1Click:Connect(function() --[[ Line: 83 ]]
                        -- upvalues: v18 (copy), v0 (ref), l_FirstChild_0 (copy), v17 (copy), v16 (copy)
                        if v18 == v0.EquipMenu then
                            v0.EquipMenu = nil;
                            game.TweenService:Create(v18, TweenInfo.new(0.2), {
                                Size = UDim2.fromScale(0, 0)
                            }):Play();
                            game.Debris:AddItem(v18, 0.2);
                            require(game.ReplicatedStorage.Modules.Network):FireServerConnection("EquipState", "REMOTE_EVENT", l_FirstChild_0, (v17.Name == "ExtraEmotes" and 8 or 0) + tonumber(v16.Name));
                        end;
                    end);
                    v28.ZIndex = 4;
                    v28.Title.ZIndex = 7;
                    v28.Button.ZIndex = 5;
                    v28.Button.Icon.ZIndex = 6;
                end;
            end;
            return;
        end;
    end;
    local function v30() --[[ Line: 103 ]] --[[ Name: updateExtraEmoteUI ]]
        -- upvalues: l_l_LocalPlayer_0_Attribute_0 (ref), l_LocalPlayer_0 (copy), v14 (copy), v13 (ref), v3 (copy), v12 (ref)
        l_l_LocalPlayer_0_Attribute_0 = l_LocalPlayer_0:GetAttribute("ExtraEmotes") == true;
        v14.ExtraSwitch.Visible = l_l_LocalPlayer_0_Attribute_0;
        v14.ExtraSwitch.Interactable = l_l_LocalPlayer_0_Attribute_0;
        v14.EmoteType.Position = l_l_LocalPlayer_0_Attribute_0 and UDim2.fromScale(0.5, 0.413) or UDim2.fromScale(0.5, 0.5);
        if l_l_LocalPlayer_0_Attribute_0 then
            v13 = v14.ExtraSwitch.MouseButton1Click:Connect(function() --[[ Line: 111 ]]
                -- upvalues: v3 (ref), v12 (ref), v14 (ref)
                v3:Play("switch");
                v12 = not v12;
                v14.Emotes.Visible = not v12;
                v14.ExtraEmotes.Visible = v12;
            end);
            return;
        else
            if v13 then
                v13:Disconnect();
                v13 = nil;
            end;
            return;
        end;
    end;
    for _, v32 in ipairs({
        v14.Emotes, 
        v14.ExtraEmotes
    }) do
        for _, v34 in ipairs(v32:GetChildren()) do
            v34.MouseButton1Click:Connect(function() --[[ Line: 129 ]]
                -- upvalues: v29 (copy), v34 (copy), v32 (copy)
                v29(v34, v32);
            end);
        end;
    end;
    local function v44() --[[ Line: 136 ]] --[[ Name: setEquippedEmotes ]]
        -- upvalues: l_ExtraEmotes_0 (copy), l_Emotes_1 (copy), v14 (copy)
        for _, v36 in ipairs({
            "Emotes", 
            "ExtraEmotes"
        }) do
            local v37 = v36 == "ExtraEmotes" and l_ExtraEmotes_0 or l_Emotes_1;
            local v38 = string.split(v37.Value, "|");
            for v39, v40 in pairs(v38) do
                local l_FirstChild_1 = v14[v36]:FindFirstChild(v39);
                if l_FirstChild_1 then
                    local l_FirstChild_2 = game.ReplicatedStorage.Assets.Emotes:FindFirstChild(v40);
                    local v43 = l_FirstChild_2 and require(l_FirstChild_2);
                    l_FirstChild_1.Asset.Image = v43 and v43.RenderImage or "";
                    l_FirstChild_1.Title.Text = v43 and v43.DisplayName or "";
                end;
            end;
        end;
    end;
    local function v45() --[[ Line: 152 ]] --[[ Name: onEquippedEmoteChanged ]]
        -- upvalues: v44 (copy)
        require(game.ReplicatedStorage.Systems.Character.Game.Emotes):BuildMenu();
        v44();
    end;
    v44();
    l_Emotes_1:GetPropertyChangedSignal("Value"):Connect(v45);
    l_ExtraEmotes_0:GetPropertyChangedSignal("Value"):Connect(v45);
    v30();
    l_LocalPlayer_0:GetAttributeChangedSignal("ExtraEmotes"):Connect(v30);
    return v5;
end;
v0.Selected = function(_, v47) --[[ Line: 171 ]] --[[ Name: Selected ]]
    -- upvalues: v0 (copy)
    local l_InventoryContainer_0 = v47.InventoryRoot.InventoryContainer;
    if not v0.EmoteWheel.Parent then
        v0.EmoteWheel.Parent = l_InventoryContainer_0;
    end;
end;
v0.Deselected = function(_, _) --[[ Line: 178 ]] --[[ Name: Deselected ]]
    -- upvalues: v0 (copy)
    v0.EmoteWheel.Parent = nil;
    if v0.EquipMenu then
        v0.EquipMenu:Destroy();
        v0.EquipMenu = nil;
    end;
end;
return v0;