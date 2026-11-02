-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ShopPhone, time of decompilation: Fri Feb 13 19:21:21 2026 ]]
local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
local l_ShopService_0 = require(script.Parent:WaitForChild("ShopService"));
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_ItemPopupService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("ItemPopupService"));
local l_Inventory_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Inventory");
local l_Shop_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Shop");
local l_NewShop_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync")).NewShop;
local l_EventInfoService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedServices"):WaitForChild("EventInfoService"));
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_Small_0 = script.Parent.Parent:WaitForChild("Small");
local l_Main_0 = l_Small_0:WaitForChild("Container"):WaitForChild("Main");
local l_Container_0 = l_Small_0:WaitForChild("Container"):WaitForChild("Title"):WaitForChild("Container");
local l_Processing_0 = l_Small_0:WaitForChild("Processing");
local l_Container_1 = l_Main_0:WaitForChild("Featured"):WaitForChild("Nav"):WaitForChild("Container");
local l_Container_2 = l_Main_0:WaitForChild("Featured"):WaitForChild("Container");
local l_RadioCover_0 = l_Main_0:WaitForChild("Items"):WaitForChild("Container"):WaitForChild("RadioCover");
local l_ViewContents_0 = l_Main_0:WaitForChild("ViewContents");
local l_ItemContainer_0 = l_ViewContents_0:WaitForChild("Container"):WaitForChild("Main"):WaitForChild("BoxFrame"):WaitForChild("ItemContainer");
local l_ScrollingFrame_0 = l_ViewContents_0:WaitForChild("Container"):WaitForChild("Main"):WaitForChild("BoxContents"):WaitForChild("Container"):WaitForChild("ScrollingFrame");
local l_BuyFrame_0 = l_ViewContents_0:WaitForChild("Container"):WaitForChild("BuyFrame");
local l_BuyPopup_0 = l_Main_0:WaitForChild("BuyPopup");
local l_ItemContainer_1 = l_BuyPopup_0:WaitForChild("Container"):WaitForChild("Left"):WaitForChild("ItemFrame"):WaitForChild("ItemContainer");
local l_TextLabel_0 = l_BuyPopup_0:WaitForChild("Container"):WaitForChild("Right"):WaitForChild("Description"):WaitForChild("TextLabel");
local l_PriceFrame_0 = l_BuyPopup_0:WaitForChild("Container"):WaitForChild("Right"):WaitForChild("PriceFrame");
local l_ScrollFrame_0 = l_Main_0:WaitForChild("Items"):WaitForChild("Container"):WaitForChild("ScrollFrame");
local l_ItemGridLayout_0 = l_ScrollFrame_0:WaitForChild("ItemGridLayout");
local l_NewItem_0 = l_ScrollFrame_0:WaitForChild("NewItem");
local v27 = {
    "Featured"
};
local v28 = {
	"Summer2026Box",
	"BeachBundleEffect",
	"Dual",
	"Electric",
};
local function v33(v29, v30) --[[ Line: 46 ]] --[[ Name: GoToPage ]]
    -- upvalues: l_Container_0 (copy)
    l_Container_0:WaitForChild("Back").Visible = v30 ~= "Featured";
    l_Container_0:WaitForChild("Title").Visible = v30 == "Featured";
    for _, v32 in v29:GetChildren() do
        if v32:IsA("GuiObject") then
            v32.Visible = v32.Name == v30;
        end;
    end;
end;
local function v34() --[[ Line: 58 ]] --[[ Name: GoBack ]]
    -- upvalues: v27 (copy), v33 (copy), l_Main_0 (copy)
    table.remove(v27);
    v33(l_Main_0, v27[#v27]);
end;
local function _(v35, v36) --[[ Line: 64 ]] --[[ Name: viewBoxContents ]]
    -- upvalues: l_ShopService_0 (copy), l_ItemContainer_0 (copy), l_ScrollingFrame_0 (copy), l_BuyFrame_0 (copy), v27 (copy), v33 (copy), l_Main_0 (copy)
    l_ShopService_0:ViewBoxContents(l_ItemContainer_0, l_ScrollingFrame_0, l_BuyFrame_0, v35, v36);
    table.insert(v27, "ViewContents");
    v33(l_Main_0, "ViewContents");
end;
local _ = function(v38, _) --[[ Line: 71 ]] --[[ Name: viewBuyPopup ]]
    -- upvalues: l_ShopService_0 (copy), l_ItemContainer_1 (copy), l_TextLabel_0 (copy), l_PriceFrame_0 (copy), v27 (copy), v33 (copy), l_Main_0 (copy)
    l_ShopService_0:ViewBuyPopup(l_ItemContainer_1, l_TextLabel_0, l_PriceFrame_0, v38);
    table.insert(v27, "BuyPopup");
    v33(l_Main_0, "BuyPopup");
end;
local function _() --[[ Line: 78 ]] --[[ Name: setupScreenSize ]]
    -- upvalues: l_NewItem_0 (copy), l_ItemGridLayout_0 (copy)
    local v41 = false;
    if l_NewItem_0.AbsoluteSize.Y < 160 then
        v41 = true;
        l_ItemGridLayout_0.CellSize = UDim2.new(0.333, -4, 1, 0);
    end;
    l_NewItem_0:Destroy();
end;
local function v45() --[[ Line: 88 ]] --[[ Name: setupNavigation ]]
    -- upvalues: l_Container_1 (copy), v27 (copy), v33 (copy), l_Main_0 (copy), l_ShopService_0 (copy), l_ScrollFrame_0 (copy), l_LocalPlayer_0 (copy), l_RadioCover_0 (copy)
    for _, v44 in l_Container_1:GetChildren() do
        if v44:IsA("TextButton") then
            v44.Activated:Connect(function() --[[ Line: 93 ]]
                -- upvalues: v27 (ref), v33 (ref), l_Main_0 (ref), l_ShopService_0 (ref), l_ScrollFrame_0 (ref), v44 (copy), l_LocalPlayer_0 (ref), l_RadioCover_0 (ref)
                table.insert(v27, "Items");
                v33(l_Main_0, "Items");
                l_ShopService_0:SetVisibleItems(l_ScrollFrame_0, v44.Name);
                if v44.Name == "Radios" then
                    l_RadioCover_0.Visible = not l_LocalPlayer_0:GetAttribute("Radio");
                    return;
                else
                    l_RadioCover_0.Visible = false;
                    return;
                end;
            end);
        end;
    end;
end;
local function v51(v46, v47) --[[ Line: 108 ]] --[[ Name: onItemPurchaseRequested ]]
    -- upvalues: l_NewShop_0 (copy), l_Processing_0 (copy), l_ShopService_0 (copy), l_Small_0 (copy), l_Shop_0 (copy), l_ItemPopupService_0 (copy), v27 (copy), v33 (copy), l_Main_0 (copy)
    local l_Type_0 = l_NewShop_0[v46].Type;
    if l_Processing_0.Visible == true then
        return;
    elseif l_Type_0 == "MysteryBox" or l_Type_0 == "Eggs" then
        l_Processing_0.Visible = true;
        if l_Type_0 == "MysteryBox" then
            local v49 = l_ShopService_0:RequestUnbox(v46, v47, 1);
            l_Processing_0.Visible = false;
            if v49 then
                l_Small_0.Visible = false;
            end;
        elseif l_Type_0 == "Eggs" then
            local v50 = l_Shop_0.OpenCrate:InvokeServer(v46, l_Type_0, v47);
            l_Processing_0.Visible = false;
            if v50 then
                l_Small_0.Visible = false;
                l_Shop_0.EggController:Fire(v46, v50);
            end;
        end;
        l_ItemPopupService_0.ItemClaimsComplete.Event:Once(function() --[[ Line: 133 ]]
            -- upvalues: l_Small_0 (ref)
            l_Small_0.Visible = true;
        end);
        return;
    else
        l_Processing_0.Visible = true;
        if l_Shop_0.BuyItemNew:InvokeServer(v46, v47) then
            table.remove(v27);
            v33(l_Main_0, v27[#v27]);
            l_Small_0.Visible = false;
            l_ItemPopupService_0.ItemClaimsComplete.Event:Once(function() --[[ Line: 142 ]]
                -- upvalues: l_Small_0 (ref)
                l_Small_0.Visible = true;
            end);
        end;
        l_Processing_0.Visible = false;
        return;
    end;
end;
local function v54(v52, v53) --[[ Line: 151 ]] --[[ Name: onItemClicked ]]
    -- upvalues: l_WindowService_0 (copy), l_ShopService_0 (copy), l_ItemContainer_0 (copy), l_ScrollingFrame_0 (copy), l_BuyFrame_0 (copy), v27 (copy), v33 (copy), l_Main_0 (copy), l_ItemContainer_1 (copy), l_TextLabel_0 (copy), l_PriceFrame_0 (copy)
    if v53 == "Event" then
        l_WindowService_0:ViewFrame("CurrentEvent");
        return;
    elseif v53 == "MysteryBox" or v53 == "Eggs" then
        l_ShopService_0:ViewBoxContents(l_ItemContainer_0, l_ScrollingFrame_0, l_BuyFrame_0, v52, v53);
        table.insert(v27, "ViewContents");
        v33(l_Main_0, "ViewContents");
        return;
    else
        l_ShopService_0:ViewBuyPopup(l_ItemContainer_1, l_TextLabel_0, l_PriceFrame_0, v52);
        table.insert(v27, "BuyPopup");
        v33(l_Main_0, "BuyPopup");
        return;
    end;
end;
local function v57() --[[ Line: 162 ]] --[[ Name: onCurrencyUpdated ]]
    -- upvalues: l_ProfileData_0 (copy), l_Container_0 (copy), l_ShopService_0 (copy)
    local v55 = l_ProfileData_0.Materials.Owned.Coins or 0;
    local v56 = l_ProfileData_0.Materials.Owned.Gems or 0;
    l_Container_0:WaitForChild("Gems"):WaitForChild("Container"):WaitForChild("Amount").Text = l_ShopService_0.CommaValue(v56);
    l_Container_0:WaitForChild("Coins"):WaitForChild("Container"):WaitForChild("Amount").Text = l_ShopService_0.CommaValue(v55);
end;
(function() --[[ Line: 171 ]] --[[ Name: onInitialize ]]
    -- upvalues: l_NewItem_0 (copy), l_ItemGridLayout_0 (copy), v45 (copy), l_ShopService_0 (copy), l_ScrollFrame_0 (copy), l_Main_0 (copy), l_Container_2 (copy), v28 (copy), l_Container_0 (copy), v27 (copy), v33 (copy), v34 (copy), l_WindowService_0 (copy), l_Small_0 (copy), l_ItemContainer_0 (copy), l_ScrollingFrame_0 (copy), l_BuyFrame_0 (copy), l_NewShop_0 (copy), l_ItemContainer_1 (copy), l_TextLabel_0 (copy), l_PriceFrame_0 (copy), v57 (copy), l_Inventory_0 (copy), l_LocalPlayer_0 (copy), l_RadioCover_0 (copy), l_Shop_0 (copy), v54 (copy), v51 (copy), l_EventInfoService_0 (copy)
    local v58 = false;
    if l_NewItem_0.AbsoluteSize.Y < 160 then
        v58 = true;
        l_ItemGridLayout_0.CellSize = UDim2.new(0.333, -4, 1, 0);
    end;
    l_NewItem_0:Destroy();
    v45();
    l_ShopService_0:GenerateShopItems(l_ScrollFrame_0);
    l_ShopService_0:ConnectPurchaseCurrency(l_Main_0:WaitForChild("PurchaseCurrency"));
    l_ShopService_0:GenerateFeaturedItems(l_Container_2, v28);
    l_Container_0:WaitForChild("Gems"):WaitForChild("GetMore"):WaitForChild("Button").Activated:Connect(function() --[[ Line: 179 ]]
        -- upvalues: v27 (ref), v33 (ref), l_Main_0 (ref)
        table.insert(v27, "PurchaseCurrency");
        v33(l_Main_0, "PurchaseCurrency");
    end);
    v33(l_Main_0, "Featured");
    l_Container_0:WaitForChild("Back").Activated:Connect(v34);
    l_WindowService_0:RegisterFrame(l_Small_0, "Shop", function(v59) --[[ Line: 187 ]]
        -- upvalues: l_ShopService_0 (ref), l_ItemContainer_0 (ref), l_ScrollingFrame_0 (ref), l_BuyFrame_0 (ref), v27 (ref), v33 (ref), l_Main_0 (ref), l_NewShop_0 (ref), l_ItemContainer_1 (ref), l_TextLabel_0 (ref), l_PriceFrame_0 (ref)
        if not v59 then
            return;
        else
            local l_TargetFrame_0 = v59.TargetFrame;
            if not l_TargetFrame_0 then
                return;
            elseif l_TargetFrame_0 == "ViewContents" then
                local l_TargetItem_0 = v59.TargetItem;
                if not l_TargetItem_0 then
                    return;
                else
                    l_ShopService_0:ViewBoxContents(l_ItemContainer_0, l_ScrollingFrame_0, l_BuyFrame_0, l_TargetItem_0, "MysteryBox");
                    table.insert(v27, "ViewContents");
                    v33(l_Main_0, "ViewContents");
                    return;
                end;
            else
                if v59.TargetItem then
                    local l_TargetItem_1 = v59.TargetItem;
                    local _ = l_NewShop_0[v59.TargetItem].Type;
                    l_ShopService_0:ViewBuyPopup(l_ItemContainer_1, l_TextLabel_0, l_PriceFrame_0, l_TargetItem_1);
                    table.insert(v27, "BuyPopup");
                    v33(l_Main_0, "BuyPopup");
                end;
                return;
            end;
        end;
    end);
    v57();
    l_Inventory_0.InventoryDataChanged.Event:Connect(function(_, v65, _) --[[ Line: 209 ]]
        -- upvalues: v57 (ref)
        if v65 == "Gems" or v65 == "Coins" then
            v57();
        end;
    end);
    l_LocalPlayer_0:GetAttributeChangedSignal("Radio"):Connect(function() --[[ Line: 215 ]]
        -- upvalues: l_LocalPlayer_0 (ref), l_RadioCover_0 (ref)
        if l_LocalPlayer_0:GetAttribute("Radio") then
            l_RadioCover_0.Visible = false;
        end;
    end);
    l_RadioCover_0:WaitForChild("Container"):WaitForChild("BuyFrame"):WaitForChild("Buy").Activated:Connect(function() --[[ Line: 221 ]]
        -- upvalues: l_Shop_0 (ref)
        l_Shop_0.GetRadio:FireServer();
    end);
    l_ShopService_0.PurchaseGemsRequested.Event:Connect(function() --[[ Line: 225 ]]
        -- upvalues: v27 (ref), v33 (ref), l_Main_0 (ref)
        table.insert(v27, "PurchaseCurrency");
        v33(l_Main_0, "PurchaseCurrency");
    end);
    l_ShopService_0.ItemClicked.Event:Connect(v54);
    l_ShopService_0.ItemPurchaseRequested.Event:Connect(v51);
    l_EventInfoService_0:OnEventStarted(function(v67) --[[ Line: 233 ]]
        -- upvalues: l_ShopService_0 (ref), l_Container_2 (ref), l_ScrollFrame_0 (ref)
        if v67.EventStartInfo.FeaturedItems then
            l_ShopService_0:GenerateFeaturedItems(l_Container_2, v67.EventStartInfo.FeaturedItems.Mobile);
        end;
        if v67.EventStartInfo.ShopData then
            l_ShopService_0:GenerateShopItems(l_ScrollFrame_0);
        end;
    end);
end)();