-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: NotificationDisplay, time of decompilation: Fri Nov 28 21:12:39 2025 ]]
local v0 = {};
local v1 = {
    Objective = {
        TextColor3 = Color3.new(1, 1, 1), 
        Size = UDim2.new(0.8, 0, 0, 32), 
        Font = "Bodoni"
    }
};
local function v7(v2, v3) --[[ Line: 15 ]] --[[ Name: createNotif ]]
    -- upvalues: v0 (copy)
    for _, v5 in pairs(v2:GetChildren()) do
        if v5.Name == "ProductPurchaseNotif" then
            v5:SetAttribute("CurrentPos", (v5:GetAttribute("CurrentPos") or v5.Position) + UDim2.fromScale(0, (v5.Size.Y.Offset + 20) / workspace.CurrentCamera.ViewportSize.Y));
            game.TweenService:Create(v5, TweenInfo.new(0.2), {
                Position = v5:GetAttribute("CurrentPos")
            }):Play();
        end;
    end;
    if #v0 + 1 > 3 then
        v0[1]:Destroy();
        table.remove(v0, 1);
    end;
    local v6 = script.Notif:Clone();
    v6.Name = "ProductPurchaseNotif";
    v6.Text = v3;
    v6.Position = UDim2.new(0.5, 0, -v6.Size.X.Scale, -v6.Size.X.Offset);
    v6.Parent = v2;
    v6:SetAttribute("CurrentPos", script.Notif.Position);
    game.TweenService:Create(v6, TweenInfo.new(0.2), {
        Position = v6:GetAttribute("CurrentPos")
    }):Play();
    table.insert(v0, v6);
    task.delay(7, function() --[[ Line: 43 ]]
        -- upvalues: v6 (copy)
        game.TweenService:Create(v6, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            TextTransparency = 1, 
            TextStrokeTransparency = 1
        }):Play();
        game.Debris:AddItem(v6, 3);
    end);
    return v6;
end;
local function v17(v8, v9, v10) --[[ Line: 52 ]] --[[ Name: __displayNotification ]]
    -- upvalues: v7 (copy), v1 (copy)
    if v10 == "Objective" and game.Players.LocalPlayer.PlayerData.Settings.Customization.EXPCashNotifsDisabled.Value then
        return;
    else
        local v11 = v7(v8, v9);
        if v11 then
            if typeof(v10) == "string" then
                local v12 = v1[v10];
                local l_pairs_0 = pairs;
                local v14 = v12 or {};
                for v15, v16 in l_pairs_0(v14) do
                    v11[v15] = v16;
                end;
                return v11;
            elseif typeof(v10) == "Color3" then
                v11.TextColor3 = v10;
            end;
        end;
        return v11;
    end;
end;
return {
    Start = function(v18) --[[ Line: 81 ]] --[[ Name: Start ]]
        -- upvalues: v7 (copy), v17 (copy)
        local l_ScreenGui_0 = Instance.new("ScreenGui");
        l_ScreenGui_0.Name = "Notis";
        l_ScreenGui_0.DisplayOrder = 999;
        l_ScreenGui_0.ResetOnSpawn = false;
        l_ScreenGui_0.IgnoreGuiInset = false;
        l_ScreenGui_0.Parent = game.Players.LocalPlayer.PlayerGui;
        v18.UI = l_ScreenGui_0;
        local v20 = require(game.ReplicatedStorage.Modules.Network);
        v20:SetConnection("ProductPurchased", "REMOTE_EVENT", function(v21, v22) --[[ Line: 93 ]]
            -- upvalues: v7 (ref), l_ScreenGui_0 (copy)
            if not v21 then
                local v23 = v7(l_ScreenGui_0, "An error has occurred mid-purchase.\nPlease try again later.");
                if v23 then
                    v23.TextColor3 = Color3.fromRGB(255, 120, 120);
                end;
                return;
            else
                local v24 = require(game.ReplicatedStorage.Modules.Schematics.Products);
                for _, v26 in pairs(v24) do
                    local l_pairs_1 = pairs;
                    local v28 = v26.Contents or {};
                    for v29, v30 in l_pairs_1(v28) do
                        if v21 == v29 then
                            local _ = v7(l_ScreenGui_0, (("Thank you for supporting Forsaken!\n%*"):format(v22 and v30.GiftNotificationText:gsub("USERNAME", v22) or v30.NotificationText or "Enjoy your rewards! <3")));
                            require(game.ReplicatedStorage.Modules.Sounds):Play(v30.SFX or "rbxassetid://95403500173355");
                            break;
                        end;
                    end;
                end;
                return;
            end;
        end);
        v20:SetConnection("SendNotif", "REMOTE_EVENT", function(v32, v33) --[[ Line: 121 ]]
            -- upvalues: v17 (ref), l_ScreenGui_0 (copy)
            v17(l_ScreenGui_0, v32, v33);
        end);
    end, 
    DisplayNotification = function(v34, v35, v36) --[[ Line: 126 ]] --[[ Name: DisplayNotification ]]
        -- upvalues: v17 (copy)
        return v17(v34.UI, v35, v36);
    end
};