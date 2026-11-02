-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    CreateTab = function(v0, v1) --[[ Line: 3 ]] --[[ Name: CreateTab ]]
        local l_CardTemplate_0 = script.Parent.Parent.Templates.CardTemplate;
        local l_SideContainer_0 = v1.ShopRoot.SideContainer;
        local v4 = {};
        local l_Survivors_0 = game.ReplicatedStorage.Assets.Survivors;
        for _, v7 in pairs(l_Survivors_0:GetChildren()) do
            local v8 = require(v7.Config);
            if not v8.Exclusive then
                local v9 = l_CardTemplate_0:Clone();
                local l_Container_0 = v9.Container;
                v9.Name = v7.Name;
                v9.LayoutOrder = v8.Price or 1000;
                l_Container_0.CharacterRender.Image = v8.RenderImage or "rbxassetid://13373279056";
                l_Container_0.Title.Text = tostring(v8.DisplayName);
                l_Container_0.Price.Text = v8.Price <= 0 and "FREE" or ("%*$"):format((tostring(v8.Price)));
                l_Container_0.Title.TextColor3 = Color3.fromRGB(200, 200, 255);
                l_Container_0.MouseEnter:Connect(function() --[[ Line: 22 ]]
                    -- upvalues: l_Container_0 (copy)
                    game.TweenService:Create(l_Container_0, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(1.05, 1.05)
                    }):Play();
                end);
                l_Container_0.MouseLeave:Connect(function() --[[ Line: 26 ]]
                    -- upvalues: l_Container_0 (copy)
                    game.TweenService:Create(l_Container_0, TweenInfo.new(0.25), {
                        Size = UDim2.fromScale(1, 1)
                    }):Play();
                end);
                l_Container_0.Interact.MouseButton1Click:Connect(function() --[[ Line: 30 ]]
                    -- upvalues: v0 (copy), v7 (copy), l_SideContainer_0 (copy), v8 (copy), l_Container_0 (copy)
                    v0.Shop.CurrentlySelected = v7;
                    l_SideContainer_0.PreviewContainer.Title.Text = tostring(v8.DisplayName);
                    l_SideContainer_0.PreviewContainer.Quote.Text = tostring(v8.Quote);
                    l_SideContainer_0.PreviewContainer.Credits.Text = tostring(v8.Credits);
                    l_SideContainer_0.PreviewContainer.Render.Image = v8.SquareRenderImage or v8.RenderImage or "rbxassetid://13373279056";
                    l_SideContainer_0.PurchaseContainer.Price.Text = l_Container_0.Price.Text;
                    l_SideContainer_0.PurchaseContainer.Buttons.Visible = true;
                    l_SideContainer_0.Visible = true;
                    game.TweenService:Create(l_SideContainer_0, TweenInfo.new(0.4), {
                        Size = UDim2.fromScale(0.3, 1)
                    }):Play();
                end);
                table.insert(v4, v9);
            end;
        end;
        return v4;
    end
};