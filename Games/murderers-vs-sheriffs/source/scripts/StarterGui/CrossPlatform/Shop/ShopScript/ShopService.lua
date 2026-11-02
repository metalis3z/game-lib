local v0 = {};
local l_UserInputService_0 = game:GetService("UserInputService");
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local l_ItemService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("ItemService"));
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_Button_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("Button"));
local l_Shop_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Shop");
local l_Inventory_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Inventory");
local l_NewShop_0 = l_Sync_0.NewShop;
local l_PolicyManager_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("PolicyManager"));
v0.ItemClicked = Instance.new("BindableEvent");
v0.ItemSelectionGained = Instance.new("BindableEvent");
v0.ItemPurchaseRequested = Instance.new("BindableEvent");
v0.PurchaseGemsRequested = Instance.new("BindableEvent");
local v10 = {
    MysteryBox = "Mystery Box", 
    Event = "Event", 
    Effects = "Effect", 
    ItemBundle = "Bundle", 
    Perks = "Perk"
};
local v11 = {
    Unique = 4, 
    Ancient = 5, 
    Godly = 10, 
    Legendary = 20, 
    Rare = 30, 
    Uncommon = 40, 
    Common = 50
};
local v12 = {
    Weapons = {
        Weapons = true, 
        MysteryBox = true, 
        ItemBundle = true, 
        Materials = true
    }
};
local v13 = {
    Weapons = true, 
    Pets = true, 
    Materials = true
};
local v14 = {
    Key = true, 
    CandyExchange = true
};
v0.CurrencyPriceFrame = script:WaitForChild("CurrencyPriceFrame");
v0.FeaturedItemFrame = script:WaitForChild("FeaturedItemFrame");
v0.ShopItemFrame = script:WaitForChild("ShopItemFrame");
v0.BoxContentItemFrame = script:WaitForChild("BoxContentItemFrame");
v0.ShopItemCurrencyFrame = v0.ShopItemFrame:WaitForChild("Container"):WaitForChild("Prices"):WaitForChild("Gems");
v0.ShopItemFrame:WaitForChild("Container"):WaitForChild("Prices"):WaitForChild("Coins"):Destroy();
v0.ShopItemCurrencyFrame.Parent = script;
local function v20(v15) --[[ Line: 68 ]] --[[ Name: comma_value ]]
    local l_v15_0 = v15;
    local _ = nil;
    repeat
        local v18, v19 = string.gsub(l_v15_0, "^(-?%d+)(%d%d%d)", "%1,%2");
        l_v15_0 = v18;
    until v19 == 0;
    return l_v15_0;
end;
v0.CommaValue = v20;
local v21 = {};
local v22 = {};
local function v46() --[[ Line: 84 ]] --[[ Name: GetSortedItemList ]]
    -- upvalues: l_NewShop_0 (copy), l_ItemService_0 (copy), v0 (copy), v11 (copy)
    local v23 = {};
    for v24, v25 in l_NewShop_0 do
        if l_ItemService_0:FindItemInfo(v24, v25.Type) then
            table.insert(v23, {
                ID = v24, 
                Info = l_ItemService_0:GetItemInfo(v24, v25.Type), 
                Shop = v25
            });
        end;
    end;
    table.sort(v23, function(v26, v27) --[[ Line: 96 ]]
        -- upvalues: v0 (ref), v11 (ref)
        local l_ID_0 = v26.ID;
        local l_Info_0 = v26.Info;
        local l_Shop_1 = v26.Shop;
        local l_ID_1 = v27.ID;
        local l_Info_1 = v27.Info;
        local l_Shop_2 = v27.Shop;
        local v34 = l_Info_0.Rarity or "Common";
        local v35 = l_Info_1.Rarity or "Common";
        local v36 = v0:ItemAlreadyPurchased(l_ID_0);
        if v36 ~= v0:ItemAlreadyPurchased(l_ID_1) then
            return not v36;
        elseif l_Shop_1.Limited and not l_Shop_2.Limited then
            return true;
        elseif l_Shop_2.Limited and not l_Shop_1.Limited then
            return false;
        else
            if v34 == v35 then
                local v37 = l_Shop_1.Price.Coins ~= nil;
                local v38 = l_Shop_2.Price.Coins ~= nil;
                if v37 and v38 then
                    if l_Shop_1.Price.Coins ~= l_Shop_2.Price.Coins then
                        return l_Shop_1.Price.Coins < l_Shop_2.Price.Coins;
                    end;
                elseif v37 ~= v38 then
                    return v37;
                end;
                local v39 = l_Shop_1.Price.Gems ~= nil;
                local v40 = l_Shop_2.Price.Gems ~= nil;
                if v39 and v40 then
                    if l_Shop_1.Price.Gems ~= l_Shop_2.Price.Gems then
                        return l_Shop_1.Price.Gems < l_Shop_2.Price.Gems;
                    end;
                elseif v39 ~= v40 then
                    return v39;
                end;
            end;
            local v41 = v11[v34] or 0;
            local v42 = v11[v35] or 0;
            if v41 ~= v42 then
                return v42 < v41;
            else
                return l_ID_0 < l_ID_1;
            end;
        end;
    end);
    local v43 = {};
    for _, v45 in v23 do
        table.insert(v43, v45.ID);
    end;
    return v43;
end;
v0.PurchaseIsRepeatable = function(_, v48) --[[ Line: 163 ]] --[[ Name: PurchaseIsRepeatable ]]
    -- upvalues: l_NewShop_0 (copy), v13 (copy)
    local v49 = l_NewShop_0[v48];
    local l_Type_0 = v49.Type;
    if v49.OneTimePurchase then
        return false;
    elseif v49.DevProductId and not v49.OneTimePurchase then
        return true;
    elseif v13[l_Type_0] or l_Type_0 == "MysteryBox" or l_Type_0 == "Eggs" then
        return true;
    else
        return false;
    end;
end;
v0.HasRequiredPurchases = function(_, v52) --[[ Line: 178 ]] --[[ Name: HasRequiredPurchases ]]
    -- upvalues: l_NewShop_0 (copy), l_ProfileData_0 (copy)
    local v53 = l_NewShop_0[v52];
    if not v53.RequiredPurchases then
        return true;
    else
        local v54 = 0;
        local v55 = 0;
        for _, v57 in v53.RequiredPurchases do
            if l_ProfileData_0.OneTimePurchases[v57] then
                v54 = v54 + 1;
            end;
            v55 = v55 + 1;
        end;
        return v55 <= v54;
    end;
end;
v0.ItemAlreadyPurchased = function(_, v59) --[[ Line: 197 ]] --[[ Name: ItemAlreadyPurchased ]]
    -- upvalues: l_NewShop_0 (copy), l_ProfileData_0 (copy), v13 (copy)
    local v60 = l_NewShop_0[v59];
    local l_Type_1 = v60.Type;
    if v60.DevProductId then
        return false;
    elseif v60.GamepassId and l_ProfileData_0.OneTimePurchases[v59] == true then
        return true;
    elseif v13[l_Type_1] or l_Type_1 == "MysteryBox" or l_Type_1 == "Eggs" then
        return false;
    elseif not l_ProfileData_0[l_Type_1] then
        return false;
    else
        return table.find(l_ProfileData_0[l_Type_1].Owned, v59) ~= nil;
    end;
end;
v0.CanAffordItem = function(_, v63, v64) --[[ Line: 215 ]] --[[ Name: CanAffordItem ]]
    -- upvalues: l_NewShop_0 (copy), l_ProfileData_0 (copy)
    if v64 == "Robux" then
        return true;
    else
        return l_NewShop_0[v63].Price[v64] <= (l_ProfileData_0.Materials.Owned[v64] or l_ProfileData_0.Weapons.Owned[v64] or 0);
    end;
end;
v0.CanPurchaseItem = function(_, v66, v67) --[[ Line: 226 ]] --[[ Name: CanPurchaseItem ]]
    -- upvalues: v0 (copy)
    return v0:CanAffordItem(v66, v67) and not v0:ItemAlreadyPurchased(v66);
end;
v0.GenerateFeaturedItems = function(_, v69, v70) --[[ Line: 231 ]] --[[ Name: GenerateFeaturedItems ]]
    -- upvalues: l_NewShop_0 (copy), v0 (copy), l_ItemService_0 (copy), v10 (copy), l_UserInputService_0 (copy)
    for _, v72 in v69:GetChildren() do
        if v72:IsA("Frame") then
            v72:Destroy();
        end;
    end;
    for v73, v74 in v70 do
        local v75 = l_NewShop_0[v74];
        if not v75 then
            warn("Featured item not found.");
        else
            local v76 = v0.FeaturedItemFrame:Clone();
            local v77 = v75.DisplayInfo or l_ItemService_0:GetDisplayInfo(v74, v75.Type);
            v76.Name = v74;
            v76.Container.Icon.Image = v77.Image;
            v76.ItemName.TextLabel.Text = v77.Name;
            v76.ItemName.BackgroundColor3 = v77.Color;
            v76.Container.Subtitle.Text = v10[v75.Type] or v75.Type;
            v76.Container.Limited.Visible = v75.Limited == true;
            v76.Container.ActionButton.Activated:Connect(function() --[[ Line: 253 ]]
                -- upvalues: v0 (ref), v74 (copy), v75 (copy)
                v0.ItemClicked:Fire(v74, v75.Type);
            end);
            if l_UserInputService_0.GamepadEnabled then
                v76.Container.ActionButton.SelectionGained:Connect(function() --[[ Line: 258 ]]
                    -- upvalues: v0 (ref), v74 (copy), v75 (copy)
                    v0.ItemSelectionGained:Fire(v74, v75.Type);
                end);
            end;
            v76.LayoutOrder = v73;
            v76.Parent = v69;
        end;
    end;
end;
v0.SetVisibleItems = function(_, v79, v80) --[[ Line: 269 ]] --[[ Name: SetVisibleItems ]]
    -- upvalues: l_NewShop_0 (copy), v0 (copy), v12 (copy)
    for _, v82 in v79:GetChildren() do
        if v82:IsA("Frame") then
            local l_Name_0 = v82.Name;
            local l_v82_Attribute_0 = v82:GetAttribute("ItemType");
            local _ = l_NewShop_0[l_Name_0];
            if not l_NewShop_0[l_Name_0] then
                v82.Visible = false;
            elseif not v0:HasRequiredPurchases(l_Name_0) then
                v82.Visible = false;
            elseif v80 == "Weapons" then
                v82.Visible = v12.Weapons[l_v82_Attribute_0];
            elseif v80 == "Emotes" then
                local v86 = true;
                if l_v82_Attribute_0 ~= "Emotes" then
                    v86 = l_v82_Attribute_0 == "Toys";
                end;
                v82.Visible = v86;
            elseif v80 == "Pets" then
                local v87 = true;
                if l_v82_Attribute_0 ~= "Pets" then
                    v87 = l_v82_Attribute_0 == "Eggs";
                end;
                v82.Visible = v87;
            else
                v82.Visible = v82:GetAttribute("ItemType") == v80;
            end;
        end;
    end;
end;
v0.GenerateShopItems = function(_, v89) --[[ Line: 302 ]] --[[ Name: GenerateShopItems ]]
    -- upvalues: v46 (copy), l_NewShop_0 (copy), v22 (copy), v14 (copy), l_PolicyManager_0 (copy), v0 (copy), l_ItemService_0 (copy), v21 (copy), v20 (copy), l_UserInputService_0 (copy)
    local v90 = v46();
    for v91, v92 in l_NewShop_0 do
        if not v22[v91] and (not v14[v91] or not l_PolicyManager_0.ArePaidRandomItemsRestricted) and not v92.Hidden then
            local l_Type_2 = v92.Type;
            local v94 = v0.ShopItemFrame:Clone();
            local v95 = v92.DisplayInfo or l_ItemService_0:GetDisplayInfo(v91, l_Type_2);
            v94.Name = v91;
            v94.Container.Icon.Image = v95.Image;
            v94.ItemName.TextLabel.Text = v95.Name;
            v94.ItemName.BackgroundColor3 = v95.Color;
            v94.Container.Limited.Visible = v92.Limited == true;
            v94.LayoutOrder = v92.LayoutOrder or table.find(v90, v91) or 0;
            if v92.Type ~= "MysteryBox" then
                if v0:ItemAlreadyPurchased(v91) then
                    v94.Container.Prices.OwnedPrice.Visible = true;
                else
                    if not v0:PurchaseIsRepeatable(v91) then
                        v21[v91] = v94;
                    end;
                    for v96, v97 in v92.Price do
                        local v98 = nil;
                        if l_ItemService_0:ItemExists(v96, "Materials") then
                            v98 = l_ItemService_0:GetItemInfo(v96, "Materials");
                        elseif l_ItemService_0:ItemExists(v96, "Weapons") then
                            v98 = l_ItemService_0:GetItemInfo(v96, "Weapons");
                        else
                            warn("Currency does not exist");
                            continue;
                        end;
                        local l_l_ItemService_0_ItemImage_0 = l_ItemService_0:GetItemImage(v98);
                        local v100 = v0.ShopItemCurrencyFrame:Clone();
                        v100.Icon.Title.Image = l_l_ItemService_0_ItemImage_0;
                        v100.Price.Text = v20(v97);
                        v100.LayoutOrder = v97;
                        v100.Parent = v94.Container.Prices;
                    end;
                end;
            end;
            v94.Container.ActionButton.Activated:Connect(function() --[[ Line: 354 ]]
                -- upvalues: v0 (ref), v91 (copy), l_Type_2 (copy)
                v0.ItemClicked:Fire(v91, l_Type_2);
            end);
            if l_UserInputService_0.GamepadEnabled then
                v94.Container.ActionButton.SelectionGained:Connect(function() --[[ Line: 359 ]]
                    -- upvalues: v0 (ref), v91 (copy), v92 (copy)
                    v0.ItemSelectionGained:Fire(v91, v92.Type);
                end);
            end;
            v94:SetAttribute("ItemType", l_Type_2);
            v94.Parent = v89;
            v22[v91] = v94;
        end;
    end;
end;
v0.ViewBuyPopup = function(_, v102, v103, v104, v105) --[[ Line: 371 ]] --[[ Name: ViewBuyPopup ]]
    -- upvalues: l_NewShop_0 (copy), l_ItemService_0 (copy), v0 (copy), v20 (copy)
    local v106 = l_NewShop_0[v105];
    local v107 = v106.DisplayInfo or l_ItemService_0:GetDisplayInfo(v105, v106.Type);
    local v108 = l_ItemService_0:FindItemInfo(v105, v106.Type) or {};
    v102.Container.Icon.Image = v107.Image;
    v102.ItemName.TextLabel.Text = v107.Name;
    v102.ItemName.BackgroundColor3 = v107.Color;
    v103.Text = v106.Description or v108.Description or "";
    for _, v110 in v104:GetChildren() do
        if v110:IsA("Frame") then
            v110:Destroy();
        end;
    end;
    for v111, v112 in v106.Price do
        local v113 = nil;
        if l_ItemService_0:ItemExists(v111, "Materials") then
            v113 = l_ItemService_0:GetItemInfo(v111, "Materials");
        elseif l_ItemService_0:ItemExists(v111, "Weapons") then
            v113 = l_ItemService_0:GetItemInfo(v111, "Weapons");
        else
            warn("Currency does not exist");
            continue;
        end;
        local l_l_ItemService_0_ItemImage_1 = l_ItemService_0:GetItemImage(v113);
        local v115 = v0.CurrencyPriceFrame:Clone();
        v115.LayoutOrder = v112;
        v115.Container.Icon.Image = l_l_ItemService_0_ItemImage_1;
        v115.Container.PriceFrame.PriceLabel.Text = v20(v112);
        v115.Buy.Style = v0:CanPurchaseItem(v105, v111) and Enum.ButtonStyle.RobloxRoundDefaultButton or Enum.ButtonStyle.RobloxRoundButton;
        v115.Buy.Activated:Connect(function() --[[ Line: 404 ]]
            -- upvalues: v111 (copy), v0 (ref), v105 (copy)
            if v111 == "Gems" and not v0:ItemAlreadyPurchased(v105, v111) and not v0:CanAffordItem(v105, v111) then
                v0.PurchaseGemsRequested:Fire();
                return;
            elseif not v0:CanPurchaseItem(v105, v111) then
                return;
            else
                v0.ItemPurchaseRequested:Fire(v105, v111);
                return;
            end;
        end);
        v115.LayoutOrder = v112;
        v115.Parent = v104;
    end;
end;
v0.ViewBoxContents = function(_, v117, v118, v119, v120, v121)
    local v122 = l_NewShop_0[v120];
    local l_l_ItemService_0_DisplayInfo_0 = l_ItemService_0:GetDisplayInfo(v120, v121);
    v117.Container.Icon.Image = l_l_ItemService_0_DisplayInfo_0.Image;
    v117.ItemName.TextLabel.Text = l_l_ItemService_0_DisplayInfo_0.Name;
    v117.ItemName.BackgroundColor3 = l_l_ItemService_0_DisplayInfo_0.Color;
    local l_l_ItemService_0_ItemInfo_0 = l_ItemService_0:GetItemInfo(v120, v121);
    local l_Contents_0 = l_l_ItemService_0_ItemInfo_0.Contents;
    for _, v127 in v118:GetChildren() do
        if v127:IsA("Frame") then
            v127:Destroy();
        end;
    end;
    for v128, v129 in l_Contents_0 do
        local v130 = v0.BoxContentItemFrame:Clone();
        local l_l_ItemService_0_DisplayInfo_1 = l_ItemService_0:GetDisplayInfo(v129, l_l_ItemService_0_ItemInfo_0.BoxType);
        v130.Name = v129;
        v130.Container.Icon.Image = l_l_ItemService_0_DisplayInfo_1.Image;
        v130.ItemName.TextLabel.Text = l_l_ItemService_0_DisplayInfo_1.Name;
        v130.ItemName.BackgroundColor3 = l_l_ItemService_0_DisplayInfo_1.Color;
        v130.Container.OwnedText.Visible = false;
        v130.Container.OwnedBackground.Visible = false;
        v130.LayoutOrder = v128;
        v130.Parent = v118;
    end;
    for _, v133 in v119:GetChildren() do
        if v133:IsA("Frame") then
            v133:Destroy();
        end;
    end;
    for v134, v135 in v122.Price do
        local v136 = nil;
        if l_ItemService_0:ItemExists(v134, "Materials") then
            v136 = l_ItemService_0:GetItemInfo(v134, "Materials");
        elseif l_ItemService_0:ItemExists(v134, "Weapons") then
            v136 = l_ItemService_0:GetItemInfo(v134, "Weapons");
        else
            warn("Currency does not exist");
            continue;
        end;
        if v134 ~= "Gems" or not l_PolicyManager_0.ArePaidRandomItemsRestricted then
            local l_l_ItemService_0_ItemImage_2 = l_ItemService_0:GetItemImage(v136);
            local v138 = v0.CurrencyPriceFrame:Clone();
            v138.Container.Icon.Image = l_l_ItemService_0_ItemImage_2;
            v138.Container.PriceFrame.PriceLabel.Text = v20(v135);
            v138.Buy.Style = v0:CanAffordItem(v120, v134) and Enum.ButtonStyle.RobloxRoundDefaultButton or Enum.ButtonStyle.RobloxRoundButton;
            v138.Buy.Activated:Connect(function() --[[ Line: 478 ]]
                -- upvalues: v134 (copy), v0 (ref), v120 (copy)
                if v134 == "Gems" and not v0:ItemAlreadyPurchased(v120, v134) and not v0:CanAffordItem(v120, v134) then
                    v0.PurchaseGemsRequested:Fire();
                    return;
                elseif not v0:CanPurchaseItem(v120, v134) then
                    return;
                else
                    v0.ItemPurchaseRequested:Fire(v120, v134);
                    return;
                end;
            end);
            v138.LayoutOrder = v135;
            v138.Parent = v119;
        end;
    end;
end;
v0.RequestUnbox = function(_, v140, v141, v142) --[[ Line: 494 ]] --[[ Name: RequestUnbox ]]
    -- upvalues: l_Shop_0 (copy)
    if v142 <= 0 or v142 > 3 then
        return;
    else
        local v143 = {};
        for v144 = 1, v142 do
            local v145 = l_Shop_0.OpenCrate:InvokeServer(v140, "MysteryBox", v141);
            if v145 then
                v143[v144] = {
                    MysteryBoxId = v140, 
                    RewardedItemId = v145
                };
            end;
        end;
        l_Shop_0.BoxController:Fire(v143);
        return v143;
    end;
end;
v0.ConnectPurchaseCurrency = function(_, v147) --[[ Line: 513 ]] --[[ Name: ConnectPurchaseCurrency ]]
    -- upvalues: l_Button_0 (copy), l_Shop_0 (copy)
    for _, v149 in v147:GetChildren() do
        if v149:IsA("Frame") then
            local _ = l_Button_0.createButton(v149, function() --[[ Line: 518 ]]
                -- upvalues: l_Shop_0 (ref), v149 (copy)
                l_Shop_0.BuyItemNew:InvokeServer(v149.Name, "Robux");
            end);
        end;
    end;
end;
v0.DisplayItem = function(_, v152, v153, v154, v155) --[[ Line: 525 ]] --[[ Name: DisplayItem ]]
    -- upvalues: l_NewShop_0 (copy), l_ItemService_0 (copy)
    local shopData = l_NewShop_0[v153];
    local v156 = (shopData and shopData.DisplayInfo) or l_ItemService_0:GetDisplayInfo(v153, v154);
    v152.Container.Icon.Image = v156.Image;
    v152.ItemName.TextLabel.Text = v156.Name;
    v152.ItemName.BackgroundColor3 = v156.Color;
    v152.Container.Subtitle.Text = v155 or "";
end;
l_Shop_0:WaitForChild("ProductPurchaseComplete").OnClientEvent:Connect(function(v157, _) --[[ Line: 536 ]]
    -- upvalues: v22 (copy), l_NewShop_0 (copy), v0 (copy), v21 (copy)
    for v159, v160 in v22 do
        local v161 = l_NewShop_0[v159];
        if v161.RequiredPurchases and table.find(v161.RequiredPurchases, v157) and v0:HasRequiredPurchases(v159) and v22[v157] and v22[v157].Visible then
            v160.Visible = true;
        end;
    end;
    if v21[v157] then
        for _, v163 in v21[v157].Container.Prices:GetChildren() do
            if v163:IsA("Frame") then
                v163.Visible = v163.Name == "OwnedPrice";
            end;
        end;
    end;
end);
l_Inventory_0:WaitForChild("InventoryDataChanged").Event:Connect(function(_, v165, v166) --[[ Line: 555 ]]
    -- upvalues: v21 (copy)
    if v21[v165] and v166 > 0 then
        for _, v168 in v21[v165].Container.Prices:GetChildren() do
            if v168:IsA("Frame") then
                v168.Visible = v168.Name == "OwnedPrice";
            end;
        end;
    end;
end);
v0.Initialize = function(_) --[[ Line: 568 ]] --[[ Name: Initialize ]]

end;
return v0;