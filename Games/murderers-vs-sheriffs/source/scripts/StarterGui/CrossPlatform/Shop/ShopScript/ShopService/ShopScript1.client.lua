-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ShopScript1, time of decompilation: Fri Feb 13 19:21:20 2026 ]]
local v0 = {
    "Event", 
    "MysteryBox2", 
    "Dual", 
    "Electric"
};
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local l_Button_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("Button"));
local l_ItemService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("ItemService"));
local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_Inventory_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Inventory");
local l_Shop_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Shop");
local l_NewShop_0 = l_Sync_0.NewShop;
local l_Parent_0 = script.Parent;
local v10 = {
    Navigation = {
        ButtonsList = nil
    }, 
    Featured = {
        LatestBox = nil, 
        ItemsList = nil
    }
};
local l_Small_0 = l_Parent_0:WaitForChild("Small");
local l_Container_0 = l_Parent_0:WaitForChild("Small"):WaitForChild("Container");
local l_Main_0 = l_Container_0:WaitForChild("Main");
local l_Container_1 = l_Container_0:WaitForChild("Title"):WaitForChild("Container");
v10.Navigation.ButtonsList = l_Small_0:WaitForChild("Container"):WaitForChild("Main"):WaitForChild("Featured"):WaitForChild("Nav"):WaitForChild("Container");
local l_Featured_0 = l_Main_0:WaitForChild("Featured");
local l_Nav_0 = l_Featured_0:WaitForChild("Nav");
local l_BuyPopup_0 = l_Main_0:WaitForChild("BuyPopup");
local l_ViewContents_0 = l_Main_0:WaitForChild("ViewContents");
local l_ScrollingFrame_0 = l_ViewContents_0:WaitForChild("Container"):WaitForChild("Main"):WaitForChild("BoxContents"):WaitForChild("Container"):WaitForChild("ScrollingFrame");
local l_PurchaseCurrency_0 = l_Main_0:WaitForChild("PurchaseCurrency");
local l_Processing_0 = l_Small_0:WaitForChild("Processing");
local l_ScrollFrame_0 = l_Main_0:WaitForChild("Items"):WaitForChild("Container"):WaitForChild("ScrollFrame");
local l_ItemGridLayout_0 = l_ScrollFrame_0:WaitForChild("ItemGridLayout");
local l_NewItem_0 = l_ScrollFrame_0:WaitForChild("NewItem");
local l_Gems_0 = l_NewItem_0:WaitForChild("Container"):WaitForChild("Prices"):WaitForChild("Gems");
l_Gems_0.Parent = script;
local l_Gems_1 = l_BuyPopup_0:WaitForChild("Container"):WaitForChild("Right"):WaitForChild("PriceFrame"):WaitForChild("Gems");
l_Gems_1.Parent = script;
local l_NewItem_1 = l_ScrollingFrame_0:WaitForChild("NewItem");
l_NewItem_1.Parent = script;
local l_CurrencyFrame_0 = l_ViewContents_0:WaitForChild("Container"):WaitForChild("BuyFrame"):WaitForChild("CurrencyFrame");
l_CurrencyFrame_0.Parent = script;
local l_ItemFrame_0 = l_Featured_0:WaitForChild("Container"):WaitForChild("ItemFrame");
l_ItemFrame_0.Parent = script;
local v30 = {
    Weapons = {
        Weapons = true, 
        MysteryBox = true, 
        ItemBundle = true
    }
};
local v31 = {
    MysteryBox = "Mystery Box", 
    Event = "Event", 
    Effects = "Effect"
};
local v32 = {
    Godly = 10, 
    Legendary = 20, 
    Rare = 30, 
    Uncommon = 40, 
    Common = 50
};
local v33 = {
    "Featured"
};
local function v39(v34) --[[ Line: 93 ]] --[[ Name: comma_value ]]
    local l_v34_0 = v34;
    local _ = nil;
    repeat
        local v37, v38 = string.gsub(l_v34_0, "^(-?%d+)(%d%d%d)", "%1,%2");
        l_v34_0 = v37;
    until v38 == 0;
    return l_v34_0;
end;
local function v44(v40, v41) --[[ Line: 106 ]] --[[ Name: GoToPage ]]
    -- upvalues: l_Container_1 (copy)
    l_Container_1:WaitForChild("Back").Visible = v41 ~= "Featured";
    l_Container_1:WaitForChild("Title").Visible = v41 == "Featured";
    for _, v43 in v40:GetChildren() do
        if v43:IsA("GuiObject") then
            v43.Visible = v43.Name == v41;
        end;
    end;
end;
local function v45() --[[ Line: 118 ]] --[[ Name: GoBack ]]
    -- upvalues: v33 (ref), v44 (copy), l_Main_0 (copy)
    table.remove(v33);
    v44(l_Main_0, v33[#v33]);
end;
local _ = function(v46) --[[ Line: 124 ]] --[[ Name: GetCurrentPage ]]
    for _, v48 in v46:GetChildren() do
        if v48:IsA("GuiObject") and v48.Visible then
            return v48;
        end;
    end;
end;
local function v66() --[[ Line: 136 ]] --[[ Name: GetSortedItemList ]]
    -- upvalues: l_NewShop_0 (copy), l_ItemService_0 (copy), v32 (copy)
    local v50 = {};
    for v51, v52 in l_NewShop_0 do
        if l_ItemService_0:FindItemInfo(v51, v52.Type) then
            table.insert(v50, {
                ID = v51, 
                Info = l_ItemService_0:GetItemInfo(v51, v52.Type), 
                Shop = v52
            });
        end;
    end;
    table.sort(v50, function(v53, v54) --[[ Line: 148 ]]
        -- upvalues: v32 (ref)
        local _ = v53.ID;
        local l_Info_0 = v53.Info;
        local l_Shop_1 = v53.Shop;
        local _ = v54.ID;
        local l_Info_1 = v54.Info;
        local l_Shop_2 = v54.Shop;
        local v61 = l_Info_0.Rarity or "Common";
        local v62 = l_Info_1.Rarity or "Common";
        if v61 == v62 then
            if l_Shop_1.Price.Coins and l_Shop_2.Price.Coins then
                return l_Shop_1.Price.Coins < l_Shop_2.Price.Coins;
            elseif l_Shop_1.Price.Coins and not l_Shop_2.Price.Coins then
                return true;
            elseif l_Shop_1.Price.Gems and l_Shop_2.Price.Gems then
                return l_Shop_1.Price.Gems < l_Shop_2.Price.Gems;
            end;
        end;
        return v32[v61] > v32[v62];
    end);
    local v63 = {};
    for _, v65 in v50 do
        table.insert(v63, v65.ID);
    end;
    return v63;
end;
local function v71(v67, v68) --[[ Line: 180 ]] --[[ Name: onItemPurchaseRequested ]]
    -- upvalues: l_NewShop_0 (copy), l_Processing_0 (copy), l_Shop_0 (copy), l_Small_0 (copy)
    local l_Type_0 = l_NewShop_0[v67].Type;
    if l_Type_0 == "MysteryBox" or l_Type_0 == "Eggs" then
        l_Processing_0.Visible = true;
        local v70 = l_Shop_0.OpenCrate:InvokeServer(v67, l_Type_0, v68);
        l_Small_0.Visible = false;
        l_Processing_0.Visible = false;
        l_Shop_0.BoxController:Fire(v67, v70);
        return;
    else
        l_Processing_0.Visible = true;
        l_Shop_0.BuyItemNew:InvokeServer(v67, v68);
        l_Small_0.Visible = false;
        l_Processing_0.Visible = false;
        return;
    end;
end;
local function v92(v72, v73) --[[ Line: 199 ]] --[[ Name: ViewBoxContents ]]
    -- upvalues: l_ViewContents_0 (copy), l_NewShop_0 (copy), l_ItemService_0 (copy), l_ScrollingFrame_0 (copy), l_NewItem_1 (copy), l_CurrencyFrame_0 (copy), v39 (copy), v71 (copy), v33 (ref), v44 (copy), l_Main_0 (copy)
    local l_ItemContainer_0 = l_ViewContents_0:WaitForChild("Container"):WaitForChild("Main"):WaitForChild("BoxFrame"):WaitForChild("ItemContainer");
    local v75 = l_NewShop_0[v72];
    local l_l_ItemService_0_DisplayInfo_0 = l_ItemService_0:GetDisplayInfo(v72, v73);
    l_ItemContainer_0.Container.Icon.Image = l_l_ItemService_0_DisplayInfo_0.Image;
    l_ItemContainer_0.ItemName.TextLabel.Text = l_l_ItemService_0_DisplayInfo_0.Name;
    l_ItemContainer_0.ItemName.BackgroundColor3 = l_l_ItemService_0_DisplayInfo_0.Color;
    local l_l_ItemService_0_ItemInfo_0 = l_ItemService_0:GetItemInfo(v72, v73);
    local l_Contents_0 = l_l_ItemService_0_ItemInfo_0.Contents;
    for _, v80 in l_ScrollingFrame_0:GetChildren() do
        if v80:IsA("Frame") then
            v80:Destroy();
        end;
    end;
    for v81, v82 in l_Contents_0 do
        local v83 = l_NewItem_1:Clone();
        local l_l_ItemService_0_DisplayInfo_1 = l_ItemService_0:GetDisplayInfo(v82, l_l_ItemService_0_ItemInfo_0.BoxType);
        v83.Container.Icon.Image = l_l_ItemService_0_DisplayInfo_1.Image;
        v83.ItemName.TextLabel.Text = l_l_ItemService_0_DisplayInfo_1.Name;
        v83.ItemName.BackgroundColor3 = l_l_ItemService_0_DisplayInfo_1.Color;
        v83.Container.OwnedText.Visible = false;
        v83.Container.OwnedBackground.Visible = false;
        v83.LayoutOrder = v81;
        v83.Parent = l_ScrollingFrame_0;
    end;
    for _, v86 in l_ViewContents_0.Container.BuyFrame:GetChildren() do
        if v86:IsA("Frame") then
            v86:Destroy();
        end;
    end;
    for v87, v88 in v75.Price do
        local v89 = nil;
        if l_ItemService_0:ItemExists(v87, "Materials") then
            v89 = l_ItemService_0:GetItemInfo(v87, "Materials");
        elseif l_ItemService_0:ItemExists(v87, "Weapons") then
            v89 = l_ItemService_0:GetItemInfo(v87, "Weapons");
        else
            warn("Currency does not exist");
            continue;
        end;
        local l_l_ItemService_0_ItemImage_0 = l_ItemService_0:GetItemImage(v89);
        local v91 = l_CurrencyFrame_0:Clone();
        v91.Container.Icon.Image = l_l_ItemService_0_ItemImage_0;
        v91.Container.PriceFrame.PriceLabel.Text = v39(v88);
        v91.Buy.Activated:Connect(function() --[[ Line: 254 ]]
            -- upvalues: v71 (ref), v72 (copy), v87 (copy)
            v71(v72, v87);
        end);
        v91.LayoutOrder = v88;
        v91.Parent = l_ViewContents_0.Container.BuyFrame;
    end;
    table.insert(v33, "ViewContents");
    v44(l_Main_0, "ViewContents");
end;
local function v105(v93) --[[ Line: 267 ]] --[[ Name: ViewBuyPopup ]]
    -- upvalues: l_NewShop_0 (copy), l_ItemService_0 (copy), l_BuyPopup_0 (copy), l_Gems_1 (copy), v39 (copy), v71 (copy), v33 (ref), v44 (copy), l_Main_0 (copy)
    local v94 = l_NewShop_0[v93];
    local v95 = v94.DisplayInfo or l_ItemService_0:GetDisplayInfo(v93, v94.Type);
    local l_ItemContainer_1 = l_BuyPopup_0:WaitForChild("Container"):WaitForChild("Left"):WaitForChild("ItemFrame"):WaitForChild("ItemContainer");
    local v97 = l_ItemService_0:FindItemInfo(v93, v94.Type) or {};
    l_ItemContainer_1.Container.Icon.Image = v95.Image;
    l_ItemContainer_1.ItemName.TextLabel.Text = v95.Name;
    l_ItemContainer_1.ItemName.BackgroundColor3 = v95.Color;
    l_BuyPopup_0.Container.Right.Description.TextLabel.Text = v94.Description or v97.Description or "";
    for _, v99 in l_BuyPopup_0.Container.Right.PriceFrame:GetChildren() do
        if v99:IsA("Frame") then
            v99:Destroy();
        end;
    end;
    for v100, v101 in v94.Price do
        local v102 = nil;
        if l_ItemService_0:ItemExists(v100, "Materials") then
            v102 = l_ItemService_0:GetItemInfo(v100, "Materials");
        elseif l_ItemService_0:ItemExists(v100, "Weapons") then
            v102 = l_ItemService_0:GetItemInfo(v100, "Weapons");
        else
            warn("Currency does not exist");
            continue;
        end;
        local l_l_ItemService_0_ItemImage_1 = l_ItemService_0:GetItemImage(v102);
        local v104 = l_Gems_1:Clone();
        v104.Container.Icon.Image = l_l_ItemService_0_ItemImage_1;
        v104.Container.PriceFrame.PriceLabel.Text = v39(v101);
        v104.Buy.Activated:Connect(function() --[[ Line: 300 ]]
            -- upvalues: v71 (ref), v93 (copy), v100 (copy)
            v71(v93, v100);
        end);
        v104.LayoutOrder = v101;
        v104.Parent = l_BuyPopup_0.Container.Right.PriceFrame;
    end;
    table.insert(v33, "BuyPopup");
    v44(l_Main_0, "BuyPopup");
end;
local function v108() --[[ Line: 312 ]] --[[ Name: onCurrencyUpdated ]]
    -- upvalues: l_ProfileData_0 (copy), l_Container_1 (copy), v39 (copy)
    local l_Coins_0 = l_ProfileData_0.Coins;
    local l_Gems_2 = l_ProfileData_0.Gems;
    l_Container_1:WaitForChild("Gems"):WaitForChild("Container"):WaitForChild("Amount").Text = v39(l_Gems_2);
    l_Container_1:WaitForChild("Coins"):WaitForChild("Container"):WaitForChild("Amount").Text = v39(l_Coins_0);
end;
local function _(v109, v110) --[[ Line: 320 ]] --[[ Name: onItemClicked ]]
    -- upvalues: l_WindowService_0 (copy), v92 (copy), v105 (copy)
    if v110 == "Event" then
        l_WindowService_0:ViewFrame("CurrentEvent");
        return;
    elseif v110 == "MysteryBox" or v110 == "Eggs" then
        v92(v109, v110);
        return;
    else
        v105(v109);
        return;
    end;
end;
local function v119() --[[ Line: 331 ]] --[[ Name: SetupNavigation ]]
    -- upvalues: l_Nav_0 (copy), v33 (ref), v44 (copy), l_Main_0 (copy), l_ScrollFrame_0 (copy), v30 (copy)
    for _, v113 in l_Nav_0:WaitForChild("Container"):GetChildren() do
        if v113:IsA("TextButton") then
            v113.Activated:Connect(function() --[[ Line: 336 ]]
                -- upvalues: v33 (ref), v44 (ref), l_Main_0 (ref), l_ScrollFrame_0 (ref), v113 (copy), v30 (ref)
                table.insert(v33, "Items");
                v44(l_Main_0, "Items");
                for _, v115 in l_ScrollFrame_0:GetChildren() do
                    if v115:IsA("Frame") then
                        local l_v115_Attribute_0 = v115:GetAttribute("ItemType");
                        if v113.Name == "Weapons" then
                            v115.Visible = v30.Weapons[l_v115_Attribute_0];
                        elseif v113.Name == "Emotes" then
                            local v117 = true;
                            if l_v115_Attribute_0 ~= "Emotes" then
                                v117 = l_v115_Attribute_0 == "Toys";
                            end;
                            v115.Visible = v117;
                        elseif v113.Name == "Pets" then
                            local v118 = true;
                            if l_v115_Attribute_0 ~= "Pets" then
                                v118 = l_v115_Attribute_0 == "Eggs";
                            end;
                            v115.Visible = v118;
                        else
                            v115.Visible = v115:GetAttribute("ItemType") == v113.Name;
                        end;
                    end;
                end;
            end);
        end;
    end;
end;
local function v133() --[[ Line: 359 ]] --[[ Name: GenerateShopItems ]]
    -- upvalues: v66 (copy), l_NewShop_0 (copy), l_NewItem_0 (copy), l_ItemService_0 (copy), l_Gems_0 (copy), v39 (copy), l_WindowService_0 (copy), v92 (copy), v105 (copy), l_ScrollFrame_0 (copy)
    local v120 = v66();
    for v121, v122 in l_NewShop_0 do
        local l_Type_1 = v122.Type;
        local v124 = l_NewItem_0:Clone();
        local v125 = v122.DisplayInfo or l_ItemService_0:GetDisplayInfo(v121, l_Type_1);
        v124.Container.Icon.Image = v125.Image;
        v124.ItemName.TextLabel.Text = v125.Name;
        v124.ItemName.BackgroundColor3 = v125.Color;
        v124.LayoutOrder = v122.LayoutOrder or table.find(v120, v121) or 0;
        if v122.Type ~= "MysteryBox" then
            for v126, v127 in v122.Price do
                local v128 = nil;
                if l_ItemService_0:ItemExists(v126, "Materials") then
                    v128 = l_ItemService_0:GetItemInfo(v126, "Materials");
                elseif l_ItemService_0:ItemExists(v126, "Weapons") then
                    v128 = l_ItemService_0:GetItemInfo(v126, "Weapons");
                else
                    warn("Currency does not exist");
                    continue;
                end;
                local l_l_ItemService_0_ItemImage_2 = l_ItemService_0:GetItemImage(v128);
                local v130 = l_Gems_0:Clone();
                v130.Icon.Title.Image = l_l_ItemService_0_ItemImage_2;
                v130.Price.Text = v39(v127);
                v130.LayoutOrder = v127;
                v130.Parent = v124.Container.Prices;
            end;
        end;
        v124.Container.ActionButton.Activated:Connect(function() --[[ Line: 392 ]]
            -- upvalues: v121 (copy), l_Type_1 (copy), l_WindowService_0 (ref), v92 (ref), v105 (ref)
            local l_v121_0 = v121;
            local l_l_Type_1_0 = l_Type_1;
            if l_l_Type_1_0 == "Event" then
                l_WindowService_0:ViewFrame("CurrentEvent");
                return;
            elseif l_l_Type_1_0 == "MysteryBox" or l_l_Type_1_0 == "Eggs" then
                v92(l_v121_0, l_l_Type_1_0);
                return;
            else
                v105(l_v121_0);
                return;
            end;
        end);
        v124:SetAttribute("ItemType", l_Type_1);
        v124.Parent = l_ScrollFrame_0;
    end;
end;
local function v141() --[[ Line: 402 ]] --[[ Name: GenerateFeaturedItems ]]
    -- upvalues: v0 (copy), l_NewShop_0 (copy), l_ItemFrame_0 (copy), l_ItemService_0 (copy), v31 (copy), l_WindowService_0 (copy), v92 (copy), v105 (copy), l_Featured_0 (copy)
    for v134, v135 in v0 do
        local v136 = l_NewShop_0[v135];
        if not v136 then
            warn("Featured item not found.");
        else
            local v137 = l_ItemFrame_0:Clone();
            local v138 = v136.DisplayInfo or l_ItemService_0:GetDisplayInfo(v135, v136.Type);
            v137.Container.Icon.Image = v138.Image;
            v137.ItemName.TextLabel.Text = v138.Name;
            v137.ItemName.BackgroundColor3 = v138.Color;
            v137.Container.Subtitle.Text = v31[v136.Type] or v136.Type;
            v137.Container.ActionButton.Activated:Connect(function() --[[ Line: 417 ]]
                -- upvalues: v135 (copy), v136 (copy), l_WindowService_0 (ref), v92 (ref), v105 (ref)
                local l_v135_0 = v135;
                local l_Type_2 = v136.Type;
                if l_Type_2 == "Event" then
                    l_WindowService_0:ViewFrame("CurrentEvent");
                    return;
                elseif l_Type_2 == "MysteryBox" or l_Type_2 == "Eggs" then
                    v92(l_v135_0, l_Type_2);
                    return;
                else
                    v105(l_v135_0);
                    return;
                end;
            end);
            v137.LayoutOrder = v134;
            v137.Parent = l_Featured_0:WaitForChild("Container");
        end;
    end;
end;
local function v145() --[[ Line: 427 ]] --[[ Name: SetupPurchaseCurrency ]]
    -- upvalues: l_PurchaseCurrency_0 (copy), l_Button_0 (copy), l_Shop_0 (copy), l_Container_1 (copy), v33 (ref), v44 (copy), l_Main_0 (copy)
    for _, v143 in l_PurchaseCurrency_0:GetChildren() do
        if v143:IsA("Frame") then
            local _ = l_Button_0.createButton(v143, function() --[[ Line: 432 ]]
                -- upvalues: l_Shop_0 (ref), v143 (copy)
                l_Shop_0.PurchaseProduct:FireServer(v143.Name, "Gems");
            end);
        end;
    end;
    l_Container_1:WaitForChild("Gems"):WaitForChild("GetMore"):WaitForChild("Button").Activated:Connect(function() --[[ Line: 437 ]]
        -- upvalues: v33 (ref), v44 (ref), l_Main_0 (ref)
        table.insert(v33, "PurchaseCurrency");
        v44(l_Main_0, "PurchaseCurrency");
    end);
end;
(function() --[[ Line: 444 ]] --[[ Name: onInitialize ]]
    -- upvalues: l_NewItem_0 (copy), l_ItemGridLayout_0 (copy), l_BuyPopup_0 (copy), v44 (copy), l_Main_0 (copy), v133 (copy), v141 (copy), v119 (copy), v145 (copy), v108 (copy), l_Inventory_0 (copy), l_Container_1 (copy), v45 (copy), l_WindowService_0 (copy), l_Parent_0 (copy), v33 (ref)
    local v146 = false;
    if l_NewItem_0.AbsoluteSize.Y < 160 then
        v146 = true;
        l_ItemGridLayout_0.CellSize = UDim2.new(0.333, -4, 1, 0);
    end;
    l_NewItem_0.Parent = script;
    l_NewItem_0:WaitForChild("Container"):WaitForChild("Prices"):WaitForChild("Coins"):Destroy();
    l_BuyPopup_0:WaitForChild("Container"):WaitForChild("Right"):WaitForChild("PriceFrame"):WaitForChild("Coins"):Destroy();
    v44(l_Main_0, "Featured");
    v133();
    v141();
    v119();
    v145();
    v108();
    l_Inventory_0.ProfileDataChanged.Event:Connect(v108);
    l_Container_1:WaitForChild("Back").Activated:Connect(v45);
    l_WindowService_0:RegisterFrame(l_Parent_0:WaitForChild("Small"), "Shop", function() --[[ Line: 465 ]]
        -- upvalues: v33 (ref)
        v33 = {
            "Featured"
        };
    end);
end)();