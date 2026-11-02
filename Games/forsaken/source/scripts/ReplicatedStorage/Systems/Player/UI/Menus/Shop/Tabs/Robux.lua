-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_MarketplaceService_0 = game:GetService("MarketplaceService");
local _ = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local v4 = require(l_ReplicatedStorage_0.Modules.Schematics.Products);
local v5 = require(l_ReplicatedStorage_0.Modules.Device);
local v6 = require(l_ReplicatedStorage_0.Modules.Network);
local v7 = {
    DevProduct = "Product", 
    Gamepass = "GamePass"
};
buildCategorizedProductInfoLookupParallel = function(v8) --[[ Line: 28 ]] --[[ Name: buildCategorizedProductInfoLookupParallel ]]
    -- upvalues: v4 (copy), v7 (copy), l_MarketplaceService_0 (copy), l_RunService_0 (copy)
    local v9 = {};
    local v10 = 0;
    local v11 = 0;
    local v12 = 0;
    for v13, v14 in v4 do
        v9[v13] = {};
        local l_pairs_0 = pairs;
        local v16 = v14.Contents or {};
        for v17, v18 in l_pairs_0(v16) do
            local v19 = v7[v18.ProductType];
            if v19 then
                local v22 = coroutine.create(function() --[[ Line: 44 ]]
                    -- upvalues: l_MarketplaceService_0 (ref), v17 (copy), v19 (copy), v9 (copy), v13 (copy), v10 (ref), v11 (ref)
                    local l_status_0, l_result_0 = pcall(function() --[[ Line: 45 ]]
                        -- upvalues: l_MarketplaceService_0 (ref), v17 (ref), v19 (ref)
                        return l_MarketplaceService_0:GetProductInfo(v17, v19);
                    end);
                    if l_status_0 then
                        v9[v13][v17] = l_result_0;
                        v10 = v10 + 1;
                        return;
                    else
                        warn((("[%*]: Failed to fetch product info for ID %*, reason: %*"):format(script:GetFullName(), tostring(v17), (tostring(l_result_0)))));
                        v11 = v11 + 1;
                        return;
                    end;
                end);
                v12 = v12 + 1;
                coroutine.resume(v22);
            end;
        end;
    end;
    local v23 = os.clock();
    while v10 + v11 < v12 do
        if v8 < os.clock() - v23 then
            warn((("[%*]: Not all GetProductInfo calls completed in time."):format((script:GetFullName()))));
            break;
        else
            l_RunService_0.Heartbeat:Wait();
        end;
    end;
    if v10 ~= v12 then
        warn((("[%*]: Some requests failed. %* succeeded, %* failed."):format(script:GetFullName(), v10, v11)));
    end;
    return v9;
end;
return {
    CreateTab = function(_, v25) --[[ Line: 82 ]] --[[ Name: CreateTab ]]
        -- upvalues: v4 (copy), v7 (copy), v5 (copy), v6 (copy), l_MarketplaceService_0 (copy)
        local l_ProductCardTemplate_0 = script.ProductCardTemplate;
        local _ = v25.ShopRoot.SideContainer;
        local v28 = {};
        local l_Folder_0 = Instance.new("Folder");
        l_Folder_0.Name = "RobuxProducts";
        table.insert(v28, l_Folder_0);
        local l_UIListLayout_0 = Instance.new("UIListLayout");
        l_UIListLayout_0.Padding = UDim.new(0, 15);
        l_UIListLayout_0.FillDirection = Enum.FillDirection.Vertical;
        l_UIListLayout_0.HorizontalAlignment = Enum.HorizontalAlignment.Center;
        l_UIListLayout_0.SortOrder = Enum.SortOrder.LayoutOrder;
        l_UIListLayout_0.Parent = l_Folder_0;
        local v31 = {};
        v25:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 102 ]]
            -- upvalues: v31 (copy), v25 (copy)
            for _, v33 in pairs(v31) do
                local l_Y_0 = v25.AbsoluteSize.Y;
                local v35 = l_Y_0 / 3.65;
                local v36 = l_Y_0 / 35;
                v33.UIGridLayout.CellPadding = UDim2.new(0.01, 0, 0, v36);
                v33.UIGridLayout.CellSize = UDim2.new(0.2, 0, 0, v35);
            end;
        end);
        local l_status_1, l_result_1 = pcall(function() --[[ Line: 112 ]]
            return buildCategorizedProductInfoLookupParallel(60);
        end);
        if not l_status_1 then
            error((("[%*]: Failed to build ProductInfo lookup"):format((script:GetFullName()))));
        end;
        local v39 = false;
        for v40, v41 in v4 do
            local v42 = script.Parent.Parent.Templates.Seperator:Clone();
            v42.Title.Text = tostring(v41.Title);
            v42.Size = UDim2.new(0.85, 0, v42.Size.Y.Scale, v42.Size.Y.Offset);
            v42.LayoutOrder = v40 * 10;
            v42.Parent = l_Folder_0;
            local v43 = script.ProductContainer:Clone();
            v43.LayoutOrder = v40 * 10 + 1;
            v43.Parent = l_Folder_0;
            table.insert(v31, v43);
            local l_pairs_1 = pairs;
            local v45 = v41.Contents or {};
            for v46, v47 in l_pairs_1(v45) do
                if (not v47.HiddenInVIP or workspace:GetAttribute("ServerType") ~= "VIP") and not v47.isOffsale and v7[v47.ProductType] then
                    local v48 = (l_result_1[v40] or {})[v46];
                    if not v48 then
                        warn((("[%*]: Failed to get %*: %* (ID: %*)."):format(script:GetFullName(), v47.ProductType, v47.DisplayName, v46)));
                    elseif v48.IsForSale then
                        local v49 = l_ProductCardTemplate_0:Clone();
                        local l_Container_0 = v49.Container;
                        v49.Parent = v43;
                        l_Container_0.GiftHolder.GiftButton.Position = v5:GetPlayerDevice() == "Mobile" and UDim2.fromScale(0.5, 0) or UDim2.fromScale(0.5, -1);
                        task.spawn(function() --[[ Line: 165 ]]
                            -- upvalues: v49 (copy), v48 (copy), v47 (copy), l_Container_0 (copy)
                            v49.Name = tostring(v48.Name);
                            v49.LayoutOrder = tonumber(v47.LayoutOrder) or tonumber(v48.PriceInRobux) or 0;
                            l_Container_0.Header.Text = v47.DisplayName or tostring(v48.Name);
                            l_Container_0.Subtitle.Text = ("%* Robux"):format((tostring(v48.PriceInRobux)));
                            l_Container_0.Icon.Image = v47.Icon or "rbxassetid://19000746703";
                        end);
                        local v51 = nil;
                        do
                            local l_v51_0 = v51;
                            local function v54(v53) --[[ Line: 174 ]] --[[ Name: toggleGiftingOption ]]
                                -- upvalues: v5 (ref), l_Container_0 (copy), l_v51_0 (ref)
                                if v5:GetPlayerDevice() == "Mobile" then
                                    l_Container_0.GiftHolder.GiftButton.Position = UDim2.fromScale(0.5, 0);
                                    return;
                                else
                                    if l_v51_0 then
                                        l_v51_0:Cancel();
                                    end;
                                    if v53 then
                                        l_Container_0.GiftHolder.GiftButton.Position = UDim2.fromScale(0.5, -1);
                                        l_v51_0 = game.TweenService:Create(l_Container_0.GiftHolder.GiftButton, TweenInfo.new(0.125), {
                                            Position = UDim2.fromScale(0.5, 0)
                                        }):Play();
                                        return;
                                    else
                                        l_Container_0.GiftHolder.GiftButton.Position = UDim2.fromScale(0.5, 0);
                                        l_v51_0 = game.TweenService:Create(l_Container_0.GiftHolder.GiftButton, TweenInfo.new(0.125), {
                                            Position = UDim2.fromScale(0.5, 1)
                                        }):Play();
                                        return;
                                    end;
                                end;
                            end;
                            l_Container_0.MouseEnter:Connect(function() --[[ Line: 189 ]]
                                -- upvalues: l_Container_0 (copy), v54 (copy)
                                game.TweenService:Create(l_Container_0, TweenInfo.new(0.25), {
                                    Size = UDim2.fromScale(1.05, 1.05)
                                }):Play();
                                v54(true);
                            end);
                            l_Container_0.MouseLeave:Connect(function() --[[ Line: 194 ]]
                                -- upvalues: l_Container_0 (copy), v54 (copy)
                                game.TweenService:Create(l_Container_0, TweenInfo.new(0.25), {
                                    Size = UDim2.fromScale(1, 1)
                                }):Play();
                                v54(false);
                            end);
                            l_Container_0.GiftHolder.GiftButton.MouseButton1Click:Connect(function() --[[ Line: 199 ]]
                                -- upvalues: v39 (ref), v47 (copy), v6 (ref), v46 (copy), l_MarketplaceService_0 (ref)
                                if not v39 then
                                    v39 = true;
                                    if v47.ProductType == "Gamepass" and not v47.GiftingID then
                                        warn((("[%*]: Failed to properly gift gamepass: %* as there was no gifting ID."):format(script:GetFullName(), v47.DisplayName)));
                                        v39 = false;
                                        return;
                                    else
                                        local l_LocalPlayer_0 = game.Players.LocalPlayer;
                                        local l_Character_0 = l_LocalPlayer_0.Character;
                                        if not l_Character_0 then
                                            v39 = false;
                                            return;
                                        else
                                            local v57 = script.GiftingMenu:Clone();
                                            v57.Parent = l_LocalPlayer_0.PlayerGui:FindFirstChild("MainUI");
                                            v57.Position = UDim2.fromScale(0.5, -0.75);
                                            game.TweenService:Create(v57, TweenInfo.new(0.3), {
                                                Position = UDim2.fromScale(0.5, 0.5)
                                            }):Play();
                                            local v58 = nil;
                                            local v59 = nil;
                                            do
                                                local l_v58_0, l_v59_0 = v58, v59;
                                                for _, v63 in (game.Players:GetPlayers()) do
                                                    if v63 ~= l_LocalPlayer_0 and (v47.ProductType ~= "Gamepass" or v6:FireServerConnection("PlayerOwnGamepass", "REMOTE_FUNCTION", {
                                                        v63, 
                                                        v46, 
                                                        v47.GiftingID
                                                    }) ~= true) then
                                                        local v64 = script.Player:Clone();
                                                        v64.Name = v63.Name;
                                                        v64.Text = v63.DisplayName == v63.Name and ("@%*"):format(v63.Name) or ("%* <font color=\"rgb(125,125,125)\"><font size=\"22\">(@%*)</font></font>)"):format(v63.DisplayName, v63.Name);
                                                        v64.Parent = v57.Choices;
                                                        v64.MouseButton1Click:Once(function() --[[ Line: 229 ]]
                                                            -- upvalues: l_v58_0 (ref), v63 (copy)
                                                            if not l_v58_0 then
                                                                l_v58_0 = v63;
                                                            end;
                                                        end);
                                                    end;
                                                end;
                                                v57.Cancel.MouseButton1Click:Connect(function() --[[ Line: 235 ]]
                                                    -- upvalues: l_v59_0 (ref)
                                                    l_v59_0 = true;
                                                end);
                                                repeat
                                                    task.wait();
                                                until l_v58_0 or not v57.Parent or not l_Character_0.Parent or l_v59_0;
                                                game.TweenService:Create(v57, TweenInfo.new(0.3), {
                                                    Position = UDim2.fromScale(0.5, 1.75)
                                                }):Play();
                                                game.Debris:AddItem(v57, 0.3);
                                                v39 = false;
                                                if v6:FireServerConnection("SetGiftedPlayer", "REMOTE_FUNCTION", (tostring(l_v58_0))) then
                                                    print(v47.GiftingID);
                                                    l_MarketplaceService_0:PromptProductPurchase(game.Players.LocalPlayer, v47.ProductType == "Gamepass" and v47.GiftingID or v46);
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end);
                            l_Container_0.Interact.MouseButton1Click:Connect(function() --[[ Line: 255 ]]
                                -- upvalues: v39 (ref), v6 (ref), v47 (copy), l_MarketplaceService_0 (ref), v46 (copy)
                                if v39 then
                                    return;
                                else
                                    if not v6:FireServerConnection("SetGiftedPlayer", "REMOTE_FUNCTION") then
                                        if v47.ProductType == "Gamepass" then
                                            l_MarketplaceService_0:PromptGamePassPurchase(game.Players.LocalPlayer, v46);
                                            return;
                                        else
                                            l_MarketplaceService_0:PromptProductPurchase(game.Players.LocalPlayer, v46);
                                        end;
                                    end;
                                    return;
                                end;
                            end);
                        end;
                    end;
                end;
            end;
        end;
        return v28;
    end
};