-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Start = function(_) --[[ Line: 4 ]] --[[ Name: Start ]]
        local l_ScreenGui_0 = Instance.new("ScreenGui");
        l_ScreenGui_0.Name = "Notis";
        l_ScreenGui_0.DisplayOrder = 999;
        l_ScreenGui_0.ResetOnSpawn = false;
        l_ScreenGui_0.IgnoreGuiInset = false;
        l_ScreenGui_0.Parent = game.Players.LocalPlayer.PlayerGui;
        local function v6(v2) --[[ Line: 14 ]] --[[ Name: createNotif ]]
            -- upvalues: l_ScreenGui_0 (copy)
            for _, v4 in pairs(l_ScreenGui_0:GetChildren()) do
                if v4.Name == "ProductPurchaseNotif" then
                    v4:SetAttribute("CurrentPos", (v4:GetAttribute("CurrentPos") or v4.Position) + UDim2.fromScale(0, (v4.Size.Y.Offset + 20) / workspace.CurrentCamera.ViewportSize.Y));
                    game.TweenService:Create(v4, TweenInfo.new(0.2), {
                        Position = v4:GetAttribute("CurrentPos")
                    }):Play();
                end;
            end;
            local v5 = script.Notif:Clone();
            v5.Name = "ProductPurchaseNotif";
            v5.Text = v2;
            v5.Position = UDim2.new(0.5, 0, -v5.Size.X.Scale, -v5.Size.X.Offset);
            v5.Parent = l_ScreenGui_0;
            v5:SetAttribute("CurrentPos", script.Notif.Position);
            game.TweenService:Create(v5, TweenInfo.new(0.2), {
                Position = v5:GetAttribute("CurrentPos")
            }):Play();
            task.delay(7, function() --[[ Line: 34 ]]
                -- upvalues: v5 (copy)
                game.TweenService:Create(v5, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    TextTransparency = 1, 
                    TextStrokeTransparency = 1
                }):Play();
                game.Debris:AddItem(v5, 3);
            end);
            return v5;
        end;
        local v7 = require(game.ReplicatedStorage.Modules.Network);
        v7:SetConnection("ProductPurchased", "REMOTE_EVENT", function(v8) --[[ Line: 45 ]]
            -- upvalues: v6 (copy)
            if not v8 then
                local v9 = v6("An error has occurred mid-purchase.\nPlease try again later.");
                if v9 then
                    v9.TextColor3 = Color3.fromRGB(255, 120, 120);
                end;
                return;
            else
                local v10 = require(game.ReplicatedStorage.Modules.Schematics.Products);
                for _, v12 in pairs(v10) do
                    local l_pairs_0 = pairs;
                    local v14 = v12.Contents or {};
                    for v15, v16 in l_pairs_0(v14) do
                        if v8 == v15 then
                            local _ = v6((("Thank you for supporting Forsaken!\n%*"):format(v16.NotificationText or "Enjoy your rewards! <3")));
                            require(game.ReplicatedStorage.Modules.Sounds):Play(v16.SFX or "rbxassetid://95403500173355");
                            break;
                        end;
                    end;
                end;
                return;
            end;
        end);
        local v18 = {
            Objective = {
                TextColor3 = Color3.new(1, 1, 1), 
                Size = UDim2.new(0.8, 0, 0, 32), 
                Font = "Bodoni"
            }
        };
        v7:SetConnection("SendNotif", "REMOTE_EVENT", function(v19, v20) --[[ Line: 82 ]]
            -- upvalues: v6 (copy), v18 (copy)
            if v20 == "Objective" and game.Players.LocalPlayer.PlayerData.Settings.Customization.EXPCashNotifsDisabled.Value then
                return;
            else
                local v21 = v6(v19);
                if v21 then
                    if typeof(v20) == "string" then
                        local v22 = v18[v20];
                        local l_pairs_1 = pairs;
                        local v24 = v22 or {};
                        for v25, v26 in l_pairs_1(v24) do
                            v21[v25] = v26;
                        end;
                        return;
                    elseif typeof(v20) == "Color3" then
                        v21.TextColor3 = v20;
                    end;
                end;
                return;
            end;
        end);
    end
};