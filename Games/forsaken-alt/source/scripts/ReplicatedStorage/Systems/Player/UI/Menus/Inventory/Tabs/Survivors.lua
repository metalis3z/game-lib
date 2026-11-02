-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    CreateTab = function(v0, v1) --[[ Line: 3 ]] --[[ Name: CreateTab ]]
        local l_CardTemplate_0 = script.Parent.Parent.Templates.CardTemplate;
        local l_SideContainer_0 = v1.InventoryRoot.SideContainer;
        local v4 = {};
        local l_PlayerData_0 = game.Players.LocalPlayer.PlayerData;
        local l_Survivors_0 = l_PlayerData_0.Purchased.Survivors;
        local l_Survivor_0 = l_PlayerData_0.Equipped.Survivor;
        local function v18(v8, v9) --[[ Line: 14 ]] --[[ Name: createCard ]]
            -- upvalues: l_CardTemplate_0 (copy), v0 (copy), l_SideContainer_0 (copy), l_Survivor_0 (copy), v4 (copy)
            if not v9 then
                return;
            elseif not v8 then
                return;
            else
                local v10 = require(v8.Config);
                local v11 = l_CardTemplate_0:Clone();
                local l_Container_0 = v11.Container;
                v11.Name = v8.Name;
                v11.LayoutOrder = v10.Price or 1000;
                l_Container_0.CharacterRender.Image = v10.RenderImage or "rbxassetid://13373279056";
                l_Container_0.Title.Text = tostring(v10.DisplayName);
                l_Container_0.Title.TextColor3 = Color3.fromRGB(200, 200, 255);
                l_Container_0.MouseEnter:Connect(function() --[[ Line: 26 ]]
                    -- upvalues: l_Container_0 (copy)
                    game.TweenService:Create(l_Container_0, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(1.05, 1.05)
                    }):Play();
                end);
                l_Container_0.MouseLeave:Connect(function() --[[ Line: 30 ]]
                    -- upvalues: l_Container_0 (copy)
                    game.TweenService:Create(l_Container_0, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(1, 1)
                    }):Play();
                end);
                l_Container_0.Interact.MouseButton1Click:Connect(function() --[[ Line: 34 ]]
                    -- upvalues: v0 (ref), v8 (copy), v9 (copy), l_SideContainer_0 (ref), l_Survivor_0 (ref), v10 (copy)
                    v0.Inventory.CurrentlySelected = v8;
                    local v13, v14, v15 = require(game.ReplicatedStorage.Modules.Util):CalculateLevelFromEXP(v9.Value);
                    local v16 = v14 / v15;
                    local v17 = v16 == 0 and 0 or 1 / v16;
                    l_SideContainer_0.PreviewContainer.EXPBar.Clipping.Size = UDim2.fromScale(v16, 1);
                    l_SideContainer_0.PreviewContainer.EXPBar.Clipping.Top.Size = UDim2.fromScale(v17, 1);
                    l_SideContainer_0.EquipContainer.Equip.Title.Text = l_Survivor_0.Value == v8.Name and "Equipped" or "Equip";
                    l_SideContainer_0.PreviewContainer.Title.Text = tostring(v10.DisplayName);
                    l_SideContainer_0.PreviewContainer.Level.Text = ("Level %*"):format(v13);
                    l_SideContainer_0.PreviewContainer.EXP.Text = v13 == 100 and "MAX LEVEL" or ("%*/%* EXP"):format(v14, v15);
                    l_SideContainer_0.PreviewContainer.Render.Image = v10.SquareRenderImage or v10.RenderImage or "rbxassetid://13373279056";
                    l_SideContainer_0.Visible = true;
                    game.TweenService:Create(l_SideContainer_0, TweenInfo.new(0.4), {
                        Size = UDim2.fromScale(0.3, 1)
                    }):Play();
                end);
                table.insert(v4, v11);
                return;
            end;
        end;
        local l_Survivors_1 = game.ReplicatedStorage.Assets.Survivors;
        for _, v21 in pairs(l_Survivors_1:GetChildren()) do
            v18(v21, l_Survivors_0:FindFirstChild(v21.Name));
        end;
        l_Survivors_0.ChildAdded:Connect(function(v22) --[[ Line: 65 ]]
            -- upvalues: v18 (copy), l_Survivors_1 (copy)
            v18(l_Survivors_1:FindFirstChild(v22.Name), v22);
        end);
        return v4;
    end
};