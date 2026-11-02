local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
local l_Sync_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync"));
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_ItemService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("ItemService"));
local l_ItemPopupService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("ItemPopupService"));
local l_EventInfoService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedServices"):WaitForChild("EventInfoService"));
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_Parent_0 = script.Parent.Parent;
local l_ShopService_0 = require(script.Parent:WaitForChild("ShopService"));
local l_NewShop_0 = l_Sync_0.NewShop;
local l_Shop_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Shop");
local l_Inventory_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Inventory");
local l_Medium_0 = l_Parent_0:WaitForChild("Medium");
local l_Main_0 = l_Medium_0:WaitForChild("Container"):WaitForChild("Container"):WaitForChild("Main");
local l_Title_0 = l_Medium_0:WaitForChild("Title");
local l_Container_0 = l_Medium_0:WaitForChild("Container"):WaitForChild("Container"):WaitForChild("Nav"):WaitForChild("Container");
local l_Processing_0 = l_Medium_0:WaitForChild("Container"):WaitForChild("Processing");
local l_RadioCover_0 = l_Main_0:WaitForChild("Items"):WaitForChild("Container"):WaitForChild("RadioCover");
local l_ViewContents_0 = l_Main_0:WaitForChild("ViewContents");
local l_ItemFrame_0 = l_ViewContents_0:WaitForChild("Container"):WaitForChild("BoxFrame"):WaitForChild("ItemFrame");
local l_Currencies_0 = l_ViewContents_0:WaitForChild("Container"):WaitForChild("BuyFrame"):WaitForChild("Currencies");
local l_Container_1 = l_ViewContents_0:WaitForChild("Container"):WaitForChild("BoxContents"):WaitForChild("Container");
local l_PurchaseOptions_0 = l_ViewContents_0:WaitForChild("Container"):WaitForChild("BuyFrame"):WaitForChild("PurchaseOptions");
local l_BuyPopup_0 = l_Main_0:WaitForChild("BuyPopup");
local l_ItemFrame_1 = l_BuyPopup_0:WaitForChild("Container"):WaitForChild("Left"):WaitForChild("ItemContainer"):WaitForChild("ItemFrame");
local l_TextLabel_0 = l_BuyPopup_0:WaitForChild("Container"):WaitForChild("Right"):WaitForChild("Description"):WaitForChild("TextLabel");
local l_PriceFrame_0 = l_BuyPopup_0:WaitForChild("Container"):WaitForChild("Right"):WaitForChild("PriceFrame");
local l_ScrollFrame_0 = l_Main_0:WaitForChild("Items"):WaitForChild("Container"):WaitForChild("ScrollFrame");
local l_Featured_0 = l_Main_0:WaitForChild("Featured");
local l_Container_2 = l_Featured_0:WaitForChild("HotItems"):WaitForChild("Container");
local v30 = "Featured";
local v31 = "Featured";
local v32 = nil;
local l_OwnedCurrencyFrame_0 = script:WaitForChild("OwnedCurrencyFrame");
local v34 = {
	"Summer2026Box",
	"BeachBundleEffect",
	"Dual",
	"Decoy",
};
local function v37() --[[ Line: 51 ]] --[[ Name: updateNavButtons ]]
    -- upvalues: l_Container_0 (copy), v32 (ref), v30 (ref)
    for _, v36 in l_Container_0:GetChildren() do
        if v36:IsA("TextButton") then
            if v36.Name == v32 then
                if v30 == "Featured" then
                    v36.Back.Visible = false;
                    v36.IsSelected.Visible = true;
                    v36.NotSelected.Visible = false;
                else
                    v36.Back.Visible = true;
                    v36.IsSelected.Visible = false;
                    v36.NotSelected.Visible = false;
                end;
            else
                v36.Back.Visible = false;
                v36.IsSelected.Visible = false;
                v36.NotSelected.Visible = true;
            end;
        end;
    end;
end;
local function v41(v38) --[[ Line: 76 ]] --[[ Name: goToPage ]]
    -- upvalues: l_Main_0 (copy), v31 (ref), v37 (copy)
    for _, v40 in l_Main_0:GetChildren() do
        if v40:IsA("Frame") then
            v40.Visible = v40.Name == v38;
        end;
    end;
    v31 = v38;
    v37();
end;
local function _(v42) --[[ Line: 88 ]] --[[ Name: goToTab ]]
    -- upvalues: v41 (copy), l_LocalPlayer_0 (copy), l_RadioCover_0 (copy), l_ShopService_0 (copy), l_ScrollFrame_0 (copy), v32 (ref), v37 (copy)
    v41("Items");
    if v42 == "Radios" then
        l_RadioCover_0.Visible = not l_LocalPlayer_0:GetAttribute("Radio");
    else
        l_RadioCover_0.Visible = false;
    end;
    l_ShopService_0:SetVisibleItems(l_ScrollFrame_0, v42);
    v32 = v42;
    v37();
end;
local function v48(v44, v45) --[[ Line: 104 ]] --[[ Name: onItemPurchaseRequested ]]
    -- upvalues: l_NewShop_0 (copy), l_Processing_0 (copy), l_ShopService_0 (copy), l_Medium_0 (copy), l_Shop_0 (copy), l_ItemPopupService_0 (copy), l_BuyPopup_0 (copy)
    local l_Type_0 = l_NewShop_0[v44].Type;
    if l_Processing_0.Visible == true then
        return;
    elseif l_Type_0 == "MysteryBox" or l_Type_0 == "Eggs" then
        l_Processing_0.Visible = true;
        if l_Type_0 == "MysteryBox" then
            if l_ShopService_0:RequestUnbox(v44, v45, 1) then
                l_Medium_0.Visible = false;
            end;
        elseif l_Type_0 == "Eggs" then
            local v47 = l_Shop_0.OpenCrate:InvokeServer(v44, l_Type_0, v45);
            if v47 then
                l_Medium_0.Visible = false;
                l_Shop_0.EggController:Fire(v44, v47);
            end;
        end;
        l_ItemPopupService_0.ItemClaimsComplete.Event:Once(function() --[[ Line: 126 ]]
            -- upvalues: l_Medium_0 (ref)
            l_Medium_0.Visible = true;
        end);
        l_Processing_0.Visible = false;
        return;
    else
        l_Processing_0.Visible = true;
        if l_Shop_0.BuyItemNew:InvokeServer(v44, v45) then
            l_Medium_0.Visible = false;
            l_BuyPopup_0.Visible = false;
            l_ItemPopupService_0.ItemClaimsComplete.Event:Once(function() --[[ Line: 136 ]]
                -- upvalues: l_Medium_0 (ref)
                l_Medium_0.Visible = true;
            end);
        end;
        l_Processing_0.Visible = false;
        return;
    end;
end;
local v49 = {};
local function v67(v50, v51) --[[ Line: 147 ]] --[[ Name: viewBoxContents ]]
    -- upvalues: l_ShopService_0 (copy), l_ItemFrame_0 (copy), l_Container_1 (copy), l_PurchaseOptions_0 (copy), v49 (copy), l_Currencies_0 (copy), l_NewShop_0 (copy), l_ItemService_0 (copy), l_OwnedCurrencyFrame_0 (copy), l_ProfileData_0 (copy), l_Inventory_0 (copy), l_Sync_0 (copy), l_ViewContents_0 (copy)
    l_ShopService_0:ViewBoxContents(l_ItemFrame_0, l_Container_1, l_PurchaseOptions_0, v50, v51);
    for _, v53 in v49 do
        v53:Disconnect();
    end;
    for _, v55 in l_Currencies_0:GetChildren() do
        if v55:IsA("Frame") then
            v55:Destroy();
        end;
    end;
    for v56, _ in l_NewShop_0[v50].Price do
        if v56 ~= "Coins" and v56 ~= "Gems" then
            local v58 = l_ItemService_0:FindItemInfo(v56, "Materials") or l_ItemService_0:FindItemInfo(v56, "Weapons");
            if v58 then
                local v59 = l_OwnedCurrencyFrame_0:Clone();
                v59.Container.Icon.Image = v58.Image;
                local v60 = l_ProfileData_0.Materials.Owned[v56] or l_ProfileData_0.Weapons.Owned[v56] or 0;
                v59.Container.PriceFrame.PriceLabel.Text = l_ShopService_0.CommaValue(v60);
                v59.LayoutOrder = v60;
                table.insert(v49, l_Inventory_0.InventoryDataChanged.Event:Connect(function(_, v62, v63) --[[ Line: 179 ]]
                    -- upvalues: v56 (copy), v59 (copy), l_ShopService_0 (ref)
                    if v62 == v56 then
                        v59.Container.PriceFrame.PriceLabel.Text = l_ShopService_0.CommaValue(v63 or 0);
                    end;
                end));
                v59.Parent = l_Currencies_0;
            end;
        end;
    end;
    for _, v65 in l_Sync_0[v51][v50].RarityChances do
        local l_FirstChild_0 = l_ViewContents_0.Container.BoxFrame.RarityFrame:FindFirstChild(v65.Rarity);
        if l_FirstChild_0 then
            l_FirstChild_0.Chance.Text = ("%*%%"):format(v65.Chance);
        end;
    end;
    l_ViewContents_0.Container.BoxFrame.RarityFrame.Godly.Chance.Text = ".2%";
end;
local function v70(v68, v69) --[[ Line: 199 ]] --[[ Name: onItemClicked ]]
    -- upvalues: l_WindowService_0 (copy), v30 (ref), v31 (ref), v67 (copy), v32 (ref), v41 (copy), l_ShopService_0 (copy), l_ItemFrame_1 (copy), l_TextLabel_0 (copy), l_PriceFrame_0 (copy), l_BuyPopup_0 (copy)
    if v69 == "Event" then
        l_WindowService_0:ViewFrame("CurrentEvent");
        return;
    elseif v69 == "MysteryBox" or v69 == "Eggs" then
        v30 = v31;
        v67(v68, v69);
        if v69 == "MysteryBox" then
            v32 = "Weapons";
        elseif v69 == "Eggs" then
            v32 = "Pets";
        end;
        v41("ViewContents");
        return;
    else
        l_ShopService_0:ViewBuyPopup(l_ItemFrame_1, l_TextLabel_0, l_PriceFrame_0, v68);
        l_BuyPopup_0.Visible = true;
        return;
    end;
end;
local function _() --[[ Line: 218 ]] --[[ Name: setupCallbacks ]]
    -- upvalues: l_ShopService_0 (copy), v70 (copy)
    l_ShopService_0.ItemClicked.Event:Connect(v70);
end;
local function v72() --[[ Line: 223 ]] --[[ Name: onLatestMysteryBoxActivated ]]
    -- upvalues: v30 (ref), v32 (ref), v67 (copy), v41 (copy)
    v30 = "Featured";
    v32 = "Weapons";
    v67("MysteryBox2", "MysteryBox");
    v41("ViewContents");
end;
local function v74() --[[ Line: 231 ]] --[[ Name: setupFeatured ]]
    -- upvalues: l_Featured_0 (copy), l_ShopService_0 (copy), v72 (copy), l_Container_2 (copy), v34 (copy)
    local l_ItemFrame_2 = l_Featured_0:WaitForChild("Box"):WaitForChild("ItemFrame");
    l_ShopService_0:DisplayItem(l_ItemFrame_2, "MysteryBox2", "MysteryBox");
    l_Featured_0:WaitForChild("Box"):WaitForChild("Buy").Activated:Connect(v72);
    l_ItemFrame_2:WaitForChild("Container"):WaitForChild("ActionButton").Activated:Connect(v72);
    l_ShopService_0:GenerateFeaturedItems(l_Container_2, v34);
end;
local function v81() --[[ Line: 244 ]] --[[ Name: setupNavigation ]]
    -- upvalues: l_Container_0 (copy), v32 (ref), v30 (ref), v41 (copy), l_LocalPlayer_0 (copy), l_RadioCover_0 (copy), l_ShopService_0 (copy), l_ScrollFrame_0 (copy), v37 (copy), l_BuyPopup_0 (copy)
    for _, v76 in l_Container_0:GetChildren() do
        if v76:IsA("TextButton") then
            local l_Name_0 = v76.Name;
            v76.Activated:Connect(function() --[[ Line: 250 ]]
                -- upvalues: v32 (ref), l_Name_0 (copy), v30 (ref), v41 (ref), l_LocalPlayer_0 (ref), l_RadioCover_0 (ref), l_ShopService_0 (ref), l_ScrollFrame_0 (ref), v37 (ref)
                if v32 == l_Name_0 then
                    if v30 == "Featured" then
                        v32 = nil;
                        v41("Featured");
                        return;
                    elseif v30 == "Items" then
                        v30 = "Featured";
                        local l_l_Name_0_0 = l_Name_0;
                        v41("Items");
                        if l_l_Name_0_0 == "Radios" then
                            l_RadioCover_0.Visible = not l_LocalPlayer_0:GetAttribute("Radio");
                        else
                            l_RadioCover_0.Visible = false;
                        end;
                        l_ShopService_0:SetVisibleItems(l_ScrollFrame_0, l_l_Name_0_0);
                        v32 = l_l_Name_0_0;
                        v37();
                        return;
                    else
                        v30 = "Featured";
                        local l_l_Name_0_1 = l_Name_0;
                        v41("Items");
                        if l_l_Name_0_1 == "Radios" then
                            l_RadioCover_0.Visible = not l_LocalPlayer_0:GetAttribute("Radio");
                        else
                            l_RadioCover_0.Visible = false;
                        end;
                        l_ShopService_0:SetVisibleItems(l_ScrollFrame_0, l_l_Name_0_1);
                        v32 = l_l_Name_0_1;
                        v37();
                        return;
                    end;
                else
                    v30 = "Featured";
                    local l_l_Name_0_2 = l_Name_0;
                    v41("Items");
                    if l_l_Name_0_2 == "Radios" then
                        l_RadioCover_0.Visible = not l_LocalPlayer_0:GetAttribute("Radio");
                    else
                        l_RadioCover_0.Visible = false;
                    end;
                    l_ShopService_0:SetVisibleItems(l_ScrollFrame_0, l_l_Name_0_2);
                    v32 = l_l_Name_0_2;
                    v37();
                    return;
                end;
            end);
        end;
    end;
    l_BuyPopup_0:WaitForChild("Container"):WaitForChild("Close"):WaitForChild("ImageButton").Activated:Connect(function() --[[ Line: 269 ]]
        -- upvalues: l_BuyPopup_0 (ref)
        l_BuyPopup_0.Visible = false;
    end);
    l_BuyPopup_0:WaitForChild("ClickBlock").Activated:Connect(function() --[[ Line: 273 ]]
        -- upvalues: l_BuyPopup_0 (ref)
        l_BuyPopup_0.Visible = false;
    end);
end;
local function v84() --[[ Line: 279 ]] --[[ Name: updateCurrency ]]
    -- upvalues: l_ProfileData_0 (copy), l_Title_0 (copy), l_ShopService_0 (copy)
    local v82 = l_ProfileData_0.Materials.Owned.Coins or 0;
    local v83 = l_ProfileData_0.Materials.Owned.Gems or 0;
    l_Title_0:WaitForChild("Coins"):WaitForChild("Container"):WaitForChild("Amount").Text = l_ShopService_0.CommaValue(v82);
    l_Title_0:WaitForChild("Gems"):WaitForChild("Container"):WaitForChild("Amount").Text = l_ShopService_0.CommaValue(v83);
end;
(function() --[[ Line: 288 ]] --[[ Name: onInitialize ]]
    -- upvalues: v74 (copy), v81 (copy), l_ShopService_0 (copy), v70 (copy), l_Main_0 (copy), l_Medium_0 (copy), v41 (copy), l_ScrollFrame_0 (copy), l_WindowService_0 (copy), v30 (ref), v32 (ref), v67 (copy), l_LocalPlayer_0 (copy), l_RadioCover_0 (copy), v37 (copy), l_ItemFrame_1 (copy), l_TextLabel_0 (copy), l_PriceFrame_0 (copy), l_BuyPopup_0 (copy), v48 (copy), v31 (ref), v84 (copy), l_Inventory_0 (copy), l_Shop_0 (copy), l_EventInfoService_0 (copy), l_Container_2 (copy)
    v74();
    v81();
    l_ShopService_0.ItemClicked.Event:Connect(v70);
    l_ShopService_0:ConnectPurchaseCurrency(l_Main_0:WaitForChild("PurchaseCurrency"));
    l_Medium_0:WaitForChild("Title"):WaitForChild("Gems"):WaitForChild("GetMore"):WaitForChild("Button").Activated:Connect(function() --[[ Line: 295 ]]
        -- upvalues: v41 (ref)
        v41("PurchaseCurrency");
    end);
    l_ShopService_0:GenerateShopItems(l_ScrollFrame_0);
    l_WindowService_0:RegisterFrame(l_Medium_0, "Shop", function(v85) --[[ Line: 300 ]]
        -- upvalues: v30 (ref), v32 (ref), v67 (ref), v41 (ref), l_LocalPlayer_0 (ref), l_RadioCover_0 (ref), l_ShopService_0 (ref), l_ScrollFrame_0 (ref), v37 (ref), l_ItemFrame_1 (ref), l_TextLabel_0 (ref), l_PriceFrame_0 (ref), l_BuyPopup_0 (ref)
        if not v85 then
            return;
        else
            local l_TargetFrame_0 = v85.TargetFrame;
            if not l_TargetFrame_0 then
                return;
            elseif l_TargetFrame_0 == "ViewContents" then
                local l_TargetItem_0 = v85.TargetItem;
                if not l_TargetItem_0 then
                    return;
                else
                    v30 = "Featured";
                    v32 = "Weapons";
                    v67(l_TargetItem_0, "MysteryBox");
                    v41("ViewContents");
                    return;
                end;
            else
                v41("Items");
                if l_TargetFrame_0 == "Radios" then
                    l_RadioCover_0.Visible = not l_LocalPlayer_0:GetAttribute("Radio");
                else
                    l_RadioCover_0.Visible = false;
                end;
                l_ShopService_0:SetVisibleItems(l_ScrollFrame_0, l_TargetFrame_0);
                v32 = l_TargetFrame_0;
                v37();
                if v85.TargetItem then
                    l_ShopService_0:ViewBuyPopup(l_ItemFrame_1, l_TextLabel_0, l_PriceFrame_0, v85.TargetItem);
                    l_BuyPopup_0.Visible = true;
                end;
                return;
            end;
        end;
    end);
    l_ShopService_0.ItemPurchaseRequested.Event:Connect(v48);
    l_ShopService_0.PurchaseGemsRequested.Event:Connect(function() --[[ Line: 327 ]]
        -- upvalues: v30 (ref), v31 (ref), v41 (ref)
        v30 = v31;
        v41("PurchaseCurrency");
    end);
    v84();
    l_Inventory_0:WaitForChild("InventoryDataChanged").Event:Connect(function(_, v89, _) --[[ Line: 333 ]]
        -- upvalues: v84 (ref)
        if v89 == "Gems" or v89 == "Coins" then
            v84();
        end;
    end);
    l_LocalPlayer_0:GetAttributeChangedSignal("Radio"):Connect(function() --[[ Line: 339 ]]
        -- upvalues: l_LocalPlayer_0 (ref), l_RadioCover_0 (ref)
        if l_LocalPlayer_0:GetAttribute("Radio") then
            l_RadioCover_0.Visible = false;
        end;
    end);
    l_RadioCover_0:WaitForChild("Container"):WaitForChild("BuyFrame"):WaitForChild("Buy").Activated:Connect(function() --[[ Line: 345 ]]
        -- upvalues: l_Shop_0 (ref)
        l_Shop_0.GetRadio:FireServer();
    end);
    l_EventInfoService_0:OnEventStarted(function(v91) --[[ Line: 349 ]]
        -- upvalues: l_ShopService_0 (ref), l_Container_2 (ref), l_ScrollFrame_0 (ref)
        if v91.EventStartInfo.FeaturedItems then
            l_ShopService_0:GenerateFeaturedItems(l_Container_2, v91.EventStartInfo.FeaturedItems.Desktop);
        end;
        if v91.EventStartInfo.ShopData then
            l_ShopService_0:GenerateShopItems(l_ScrollFrame_0);
        end;
    end);
    v41("Featured");
end)();