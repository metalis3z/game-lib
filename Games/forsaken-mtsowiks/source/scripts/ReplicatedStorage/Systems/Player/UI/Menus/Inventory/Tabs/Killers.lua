-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    CreateTab = function(v0, v1) --[[ Line: 5 ]] --[[ Name: CreateTab ]]
        local l_CardTemplate_0 = script.Parent.Parent.Templates.CardTemplate;
        local l_SideContainer_0 = v1.InventoryRoot.SideContainer;
        local v4 = {};
        local l_PlayerData_0 = game.Players.LocalPlayer.PlayerData;
        local l_Killers_0 = l_PlayerData_0.Purchased.Killers;
        local l_Killer_0 = l_PlayerData_0.Equipped.Killer;
        local l_DisplayExtraLevel_0 = l_PlayerData_0.Settings.Customization.DisplayExtraLevel;
        local function v22(v9, v10) --[[ Line: 17 ]] --[[ Name: createCard ]]
            -- upvalues: l_CardTemplate_0 (copy), l_DisplayExtraLevel_0 (copy), l_SideContainer_0 (copy), l_Killer_0 (copy), v0 (copy), v4 (copy)
            if not v10 then
                return;
            elseif not v9 then
                return;
            else
                local v11 = require(v9.Config);
                local v12 = l_CardTemplate_0:Clone();
                local l_Container_0 = v12.Container;
                v12.Name = v9.Name;
                v12.LayoutOrder = v11.Price or 1000;
                l_Container_0.CharacterRender.Image = v11.RenderImage or "rbxassetid://13373279056";
                l_Container_0.Title.Text = tostring(v11.DisplayName);
                l_Container_0.Title.TextColor3 = Color3.fromRGB(255, 200, 200);
                l_Container_0.MouseEnter:Connect(function() --[[ Line: 29 ]]
                    -- upvalues: l_Container_0 (copy)
                    game.TweenService:Create(l_Container_0, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(1.05, 1.05)
                    }):Play();
                end);
                l_Container_0.MouseLeave:Connect(function() --[[ Line: 33 ]]
                    -- upvalues: l_Container_0 (copy)
                    game.TweenService:Create(l_Container_0, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(1, 1)
                    }):Play();
                end);
                local function v21() --[[ Line: 37 ]] --[[ Name: __changeLevelDisplay ]]
                    -- upvalues: v10 (copy), l_DisplayExtraLevel_0 (ref), l_SideContainer_0 (ref), l_Killer_0 (ref), v9 (copy), v11 (copy)
                    local v14, v15, v16 = require(game.ReplicatedStorage.Modules.Util):CalculateLevelFromEXP(v10.Value);
                    local v17 = v14 > 100 and ("MAX LEVEL%*"):format(l_DisplayExtraLevel_0.Value and (" (+%*)"):format((math.floor(v14 - 100))) or "") or v14 == 100 and "MAX LEVEL" or ("%*/%* EXP"):format(v15, v16);
                    local v18 = v14 < 100;
                    local v19 = v15 / v16;
                    local v20 = v19 == 0 and 0 or 1 / v19;
                    l_SideContainer_0.PreviewContainer.EXPBar.Visible = v18;
                    l_SideContainer_0.PreviewContainer.EXPBar.Clipping.Size = UDim2.fromScale(v19, 1);
                    l_SideContainer_0.PreviewContainer.EXPBar.Clipping.Top.Size = UDim2.fromScale(v20, 1);
                    l_SideContainer_0.EquipContainer.Equip.Title.Text = l_Killer_0.Value == v9.Name and "Equipped" or "Equip";
                    l_SideContainer_0.PreviewContainer.Title.Text = tostring(v11.DisplayName);
                    l_SideContainer_0.PreviewContainer.Level.Text = ("Level %*"):format((math.min(v14, 100)));
                    l_SideContainer_0.PreviewContainer.EXP.Text = v17;
                    l_SideContainer_0.PreviewContainer.Render.Image = v11.SquareRenderImage or v11.RenderImage or "rbxassetid://13373279056";
                end;
                l_DisplayExtraLevel_0.Changed:Connect(v21);
                l_Container_0.Interact.MouseButton1Click:Connect(function() --[[ Line: 61 ]]
                    -- upvalues: v0 (ref), v9 (copy), v21 (copy), l_SideContainer_0 (ref)
                    v0.Inventory.CurrentlySelected = v9;
                    v21();
                    l_SideContainer_0.Visible = true;
                    game.TweenService:Create(l_SideContainer_0, TweenInfo.new(0.4), {
                        Size = UDim2.fromScale(0.3, 1)
                    }):Play();
                end);
                table.insert(v4, v12);
                return;
            end;
        end;
        local l_Killers_1 = game.ReplicatedStorage.Assets.Killers;
        for _, v25 in pairs(l_Killers_1:GetChildren()) do
            v22(v25, l_Killers_0:FindFirstChild(v25.Name));
        end;
        l_Killers_0.ChildAdded:Connect(function(v26) --[[ Line: 78 ]]
            -- upvalues: v22 (copy), l_Killers_1 (copy)
            v22(l_Killers_1:FindFirstChild(v26.Name), v26);
        end);
        return v4;
    end
};