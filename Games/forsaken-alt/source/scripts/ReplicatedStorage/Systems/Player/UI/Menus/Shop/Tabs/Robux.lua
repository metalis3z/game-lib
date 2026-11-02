-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    CreateTab = function(_, v1) --[[ Line: 3 ]] --[[ Name: CreateTab ]]
        local l_ProductCardTemplate_0 = script.ProductCardTemplate;
        local _ = v1.ShopRoot.SideContainer;
        local v4 = {};
        local l_Folder_0 = Instance.new("Folder");
        l_Folder_0.Name = "RobuxProducts";
        table.insert(v4, l_Folder_0);
        local l_UIListLayout_0 = Instance.new("UIListLayout");
        l_UIListLayout_0.Padding = UDim.new(0, 15);
        l_UIListLayout_0.FillDirection = Enum.FillDirection.Vertical;
        l_UIListLayout_0.HorizontalAlignment = Enum.HorizontalAlignment.Center;
        l_UIListLayout_0.SortOrder = Enum.SortOrder.LayoutOrder;
        l_UIListLayout_0.Parent = l_Folder_0;
        local v7 = {};
        v1:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 23 ]]
            -- upvalues: v7 (copy), v1 (copy)
            for _, v9 in pairs(v7) do
                local l_Y_0 = v1.AbsoluteSize.Y;
                local v11 = l_Y_0 / 3.65;
                local v12 = l_Y_0 / 35;
                v9.UIGridLayout.CellPadding = UDim2.new(0.01, 0, 0, v12);
                v9.UIGridLayout.CellSize = UDim2.new(0.2, 0, 0, v11);
            end;
        end);
        local v13 = require(game.ReplicatedStorage.Modules.Schematics.Products);
        for v14, v15 in pairs(v13) do
            local v16 = script.Parent.Parent.Templates.Seperator:Clone();
            v16.Title.Text = tostring(v15.Title);
            v16.Size = UDim2.new(0.85, 0, v16.Size.Y.Scale, v16.Size.Y.Offset);
            v16.LayoutOrder = v14 * 10;
            v16.Parent = l_Folder_0;
            local v17 = script.ProductContainer:Clone();
            v17.LayoutOrder = v14 * 10 + 1;
            v17.Parent = l_Folder_0;
            table.insert(v7, v17);
            local l_pairs_0 = pairs;
            local v19 = v15.Contents or {};
            for v20, v21 in l_pairs_0(v19) do
                if not v21.HiddenInVIP or workspace:GetAttribute("ServerType") ~= "VIP" then
                    local v22 = l_ProductCardTemplate_0:Clone();
                    local l_Container_0 = v22.Container;
                    v22.Parent = v17;
                    task.spawn(function() --[[ Line: 56 ]]
                        -- upvalues: v21 (copy), v20 (copy), v22 (copy), l_Container_0 (copy)
                        local v24 = ({
                            DevProduct = "Product", 
                            Gamepass = "GamePass"
                        })[v21.ProductType];
                        if not v24 then
                            return;
                        else
                            local l_ProductInfo_0 = game.MarketplaceService:GetProductInfo(v20, Enum.InfoType[v24]);
                            v22.Name = tostring(l_ProductInfo_0.Name);
                            v22.LayoutOrder = tonumber(v21.LayoutOrder) or tonumber(l_ProductInfo_0.PriceInRobux) or 0;
                            l_Container_0.Header.Text = v21.DisplayName or tostring(l_ProductInfo_0.Name);
                            l_Container_0.Subtitle.Text = ("%* Robux"):format((tostring(l_ProductInfo_0.PriceInRobux)));
                            l_Container_0.Icon.Image = v21.Icon or "rbxassetid://19000746703";
                            return;
                        end;
                    end);
                    l_Container_0.MouseEnter:Connect(function() --[[ Line: 67 ]]
                        -- upvalues: l_Container_0 (copy)
                        game.TweenService:Create(l_Container_0, TweenInfo.new(0.25), {
                            Size = UDim2.fromScale(1.05, 1.05)
                        }):Play();
                    end);
                    l_Container_0.MouseLeave:Connect(function() --[[ Line: 71 ]]
                        -- upvalues: l_Container_0 (copy)
                        game.TweenService:Create(l_Container_0, TweenInfo.new(0.25), {
                            Size = UDim2.fromScale(1, 1)
                        }):Play();
                    end);
                    l_Container_0.Interact.MouseButton1Click:Connect(function() --[[ Line: 75 ]]
                        -- upvalues: v21 (copy), v20 (copy)
                        if v21.ProductType == "Gamepass" then
                            game.MarketplaceService:PromptGamePassPurchase(game.Players.LocalPlayer, v20);
                            return;
                        else
                            game.MarketplaceService:PromptProductPurchase(game.Players.LocalPlayer, v20);
                            return;
                        end;
                    end);
                end;
            end;
        end;
        return v4;
    end
};