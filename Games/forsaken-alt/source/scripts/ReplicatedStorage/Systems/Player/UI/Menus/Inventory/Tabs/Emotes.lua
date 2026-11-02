-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.CreateTab = function(_, _) --[[ Line: 3 ]] --[[ Name: CreateTab ]]
    -- upvalues: v0 (copy)
    local l_Templates_0 = script.Parent.Parent.Templates;
    local v4 = {};
    local l_PlayerData_0 = game.Players.LocalPlayer.PlayerData;
    local l_Emotes_0 = l_PlayerData_0.Purchased.Emotes;
    local l_Emotes_1 = l_PlayerData_0.Equipped.Emotes;
    local v8 = l_Templates_0.EmoteMenuHolder:Clone();
    v0.EmoteWheel = v8;
    local v9 = false;
    local function v24(v10) --[[ Line: 19 ]] --[[ Name: makeEmoteMenu ]]
        -- upvalues: v9 (ref), v8 (copy), v0 (ref), l_Templates_0 (copy), l_Emotes_0 (copy)
        if v9 then
            return;
        else
            v9 = true;
            task.delay(0.5, function() --[[ Line: 22 ]]
                -- upvalues: v9 (ref)
                v9 = false;
            end);
            for _, v12 in pairs(v8.Emotes:GetChildren()) do
                v12.ZIndex = v12 == v10 and 2 or 1;
            end;
            if v0.EquipMenu then
                game.TweenService:Create(v0.EquipMenu, TweenInfo.new(0.2), {
                    Size = UDim2.fromScale(0, 0)
                }):Play();
                game.Debris:AddItem(v0.EquipMenu, 0.2);
            end;
            local v13 = l_Templates_0.EmoteEquipMenu:Clone();
            v13.Size = UDim2.fromScale();
            v13.Parent = v10;
            v0.EquipMenu = v13;
            game.TweenService:Create(v13, TweenInfo.new(0.2), {
                Size = UDim2.fromScale(4, 2.75)
            }):Play();
            for _, v15 in pairs({
                v13.Cancel, 
                v13.Unequip
            }) do
                v15.MouseButton1Click:Connect(function() --[[ Line: 44 ]]
                    -- upvalues: v13 (copy), v0 (ref), v15 (copy), v10 (copy)
                    if v13 == v0.EquipMenu then
                        v0.EquipMenu = nil;
                        game.TweenService:Create(v13, TweenInfo.new(0.2), {
                            Size = UDim2.fromScale(0, 0)
                        }):Play();
                        game.Debris:AddItem(v13, 0.2);
                        if v15.Name == "Unequip" then
                            require(game.ReplicatedStorage.Modules.Network):FireServerConnection("EquipContent", "REMOTE_EVENT", "Emotes", (tonumber(v10.Name)));
                        end;
                    end;
                end);
            end;
            v13.Searchbar.TextBox:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 61 ]]
                -- upvalues: v13 (copy)
                for _, v17 in pairs(v13.EmoteList:GetChildren()) do
                    if v17:IsA("GuiObject") then
                        local v18 = true;
                        if v13.Searchbar.TextBox.Text ~= "" then
                            v18 = v17.Name:lower():find(v13.Searchbar.TextBox.Text:lower());
                        end;
                        v17.Visible = v18;
                    end;
                end;
            end);
            for _, v20 in pairs(l_Emotes_0:GetChildren()) do
                local l_FirstChild_0 = game.ReplicatedStorage.Assets.Emotes:FindFirstChild(v20.Name);
                local v22 = l_FirstChild_0 and require(l_FirstChild_0);
                if v22 then
                    local v23 = l_Templates_0.EmoteHolder:Clone();
                    v23.Name = v22.DisplayName or l_FirstChild_0.Name;
                    v23.Title.Text = v23.Name;
                    v23.Button.Icon.Image = v22.RenderImage or "";
                    v23.Parent = v13.EmoteList;
                    v23.Button.MouseButton1Click:Connect(function() --[[ Line: 80 ]]
                        -- upvalues: v13 (copy), v0 (ref), l_FirstChild_0 (copy), v10 (copy)
                        if v13 == v0.EquipMenu then
                            v0.EquipMenu = nil;
                            game.TweenService:Create(v13, TweenInfo.new(0.2), {
                                Size = UDim2.fromScale(0, 0)
                            }):Play();
                            game.Debris:AddItem(v13, 0.2);
                            require(game.ReplicatedStorage.Modules.Network):FireServerConnection("EquipContent", "REMOTE_EVENT", l_FirstChild_0, (tonumber(v10.Name)));
                        end;
                    end);
                end;
            end;
            return;
        end;
    end;
    for _, v26 in pairs(v8.Emotes:GetChildren()) do
        v26.MouseButton1Click:Connect(function() --[[ Line: 98 ]]
            -- upvalues: v24 (copy), v26 (copy)
            v24(v26);
        end);
    end;
    local function v33() --[[ Line: 104 ]] --[[ Name: setEquippedEmotes ]]
        -- upvalues: l_Emotes_1 (copy), v8 (copy)
        local v27 = string.split(l_Emotes_1.Value, "|");
        for v28, v29 in pairs(v27) do
            local l_FirstChild_1 = v8.Emotes:FindFirstChild(v28);
            if l_FirstChild_1 then
                local l_FirstChild_2 = game.ReplicatedStorage.Assets.Emotes:FindFirstChild(v29);
                local v32 = l_FirstChild_2 and require(l_FirstChild_2);
                l_FirstChild_1.Asset.Image = v32 and v32.RenderImage or "";
                l_FirstChild_1.Title.Text = v32 and v32.DisplayName or "";
            end;
        end;
    end;
    v33();
    l_Emotes_1:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 119 ]]
        -- upvalues: v33 (copy)
        require(game.ReplicatedStorage.Systems.Character.Game.Emotes):BuildMenu();
        v33();
    end);
    return v4;
end;
v0.Selected = function(_, v35) --[[ Line: 128 ]] --[[ Name: Selected ]]
    -- upvalues: v0 (copy)
    local l_InventoryContainer_0 = v35.InventoryRoot.InventoryContainer;
    if not v0.EmoteWheel.Parent then
        v0.EmoteWheel.Parent = l_InventoryContainer_0;
    end;
end;
v0.Deselected = function(_, _) --[[ Line: 135 ]] --[[ Name: Deselected ]]
    -- upvalues: v0 (copy)
    v0.EmoteWheel.Parent = nil;
    if v0.EquipMenu then
        v0.EquipMenu:Destroy();
        v0.EquipMenu = nil;
    end;
end;
return v0;