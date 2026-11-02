-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ShopConsole, time of decompilation: Fri Feb 13 19:21:22 2026 ]]
local l_WindowService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("WindowService"));
local _ = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("ItemService"));
local _ = game:GetService("ContextActionService");
local l_ShopService_0 = require(script.Parent:WaitForChild("ShopService"));
local l_NewShop_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Database"):WaitForChild("Sync")).NewShop;
local l_GuiService_0 = game:GetService("GuiService");
local l_Shop_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Shop");
local l_Inventory_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Inventory");
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local _ = require(game:GetService("ReplicatedStorage"):WaitForChild("ClientServices"):WaitForChild("ItemPopupService"));
local l_EventInfoService_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedServices"):WaitForChild("EventInfoService"));
local l_Console_0 = game.Players.LocalPlayer.PlayerGui:WaitForChild("InputContext"):WaitForChild("Console");
local l_Shop_1 = l_Console_0:WaitForChild("Shop");
local l_Large_0 = script.Parent.Parent:WaitForChild("Large");
local l_Main_0 = l_Large_0:WaitForChild("Main");
local l_Container_0 = l_Main_0:WaitForChild("Container");
local l_Title_0 = l_Large_0:WaitForChild("Title");
local l_Nav_0 = l_Title_0:WaitForChild("Nav");
local l_Info_0 = l_Main_0:WaitForChild("Info");
local l_Processing_0 = l_Main_0:WaitForChild("Processing");
local l_BottomBar_0 = l_Large_0:WaitForChild("BottomBar");
local l_BuyPopup_0 = l_Container_0:WaitForChild("BuyPopup");
local l_Container_1 = l_BuyPopup_0:WaitForChild("Container");
local l_ItemFrame_0 = l_Container_1:WaitForChild("Left"):WaitForChild("ItemContainer"):WaitForChild("ItemFrame");
local l_PriceFrame_0 = l_Container_1:WaitForChild("Right"):WaitForChild("PriceFrame");
local l_TextLabel_0 = l_Container_1:WaitForChild("Right"):WaitForChild("Description"):WaitForChild("TextLabel");
local l_ScrollingFrame_0 = l_Container_0:WaitForChild("PurchaseCurrency"):WaitForChild("Items"):WaitForChild("ScrollingFrame");
local l_ScrollingFrame_1 = l_Container_0:WaitForChild("ViewContents"):WaitForChild("Items"):WaitForChild("ScrollingFrame");
local l_BuyFrame_0 = l_Info_0:WaitForChild("BuyFrame");
local l_ScrollingFrame_2 = l_Container_0:WaitForChild("Featured"):WaitForChild("Items"):WaitForChild("ScrollingFrame");
local l_LargeShopItemFrame_0 = l_ScrollingFrame_2:WaitForChild("LargeShopItemFrame");
local l_ScrollingFrame_3 = l_Main_0:WaitForChild("Container"):WaitForChild("Items"):WaitForChild("Items"):WaitForChild("ScrollingFrame");
local l_LargeBoxContentItem_0 = l_ScrollingFrame_1:WaitForChild("LargeBoxContentItem");
local v33 = {
	"Event",
	"Summer2026Box",
	"BeachBundleEffect",
	"MysteryBox2",
	"MysteryBox1",
	"Decoy",
	"Dual",
	"Electric",
};
local v34 = {
    "Featured", 
    "PurchaseCurrency", 
    "Weapons", 
    "Effects", 
    "Perks", 
    "Emotes", 
    "Pets"
};
local v35 = 1;
local v36 = "Featured";
local v37 = "Featured";
local v38 = nil;
local function v42(v39) --[[ Line: 55 ]] --[[ Name: GoToPage ]]
    -- upvalues: l_Container_0 (copy), l_GuiService_0 (copy), v37 (ref)
    for _, v41 in l_Container_0:GetChildren() do
        if v41:IsA("Frame") then
            v41.Visible = v41.Name == v39;
            if v41.Name == v39 then
                l_GuiService_0:Select(v41);
            end;
        end;
    end;
    v37 = v39;
end;
local function v46(v43) --[[ Line: 68 ]] --[[ Name: GoToTab ]]
    -- upvalues: l_Title_0 (copy), v42 (copy), l_ShopService_0 (copy), l_ScrollingFrame_3 (copy), l_GuiService_0 (copy), l_Nav_0 (copy), v35 (ref), v34 (copy), v36 (ref)
    if v43 == "PurchaseCurrency" then
        l_Title_0.Title.Text = "Get Gems";
        v42("PurchaseCurrency");
    elseif v43 == "Featured" then
        l_Title_0.Title.Text = "Featured";
        v42("Featured");
    else
        l_Title_0.Title.Text = v43;
        l_ShopService_0:SetVisibleItems(l_ScrollingFrame_3, v43);
        v42("Items");
        l_GuiService_0:Select(l_ScrollingFrame_3);
    end;
    for _, v45 in l_Nav_0:GetChildren() do
        if v45:IsA("TextButton") then
            v45.Style = v45.Name == v43 and Enum.ButtonStyle.RobloxRoundDefaultButton or Enum.ButtonStyle.RobloxRoundButton;
        end;
    end;
    v35 = table.find(v34, v43);
    v36 = v43;
end;
local function v49() --[[ Line: 93 ]] --[[ Name: ConnectPurchaseCurrency ]]
    -- upvalues: l_ScrollingFrame_0 (copy), l_Shop_0 (copy), l_Info_0 (copy)
    for _, v48 in l_ScrollingFrame_0:GetChildren() do
        if v48:IsA("Frame") then
            v48.Container.ActionButton.Activated:Connect(function() --[[ Line: 98 ]]
                -- upvalues: l_Shop_0 (ref), v48 (copy)
                l_Shop_0.PurchaseProduct:FireServer(v48.Name, "Gems");
            end);
            v48.Container.ActionButton.SelectionGained:Connect(function() --[[ Line: 101 ]]
                -- upvalues: l_Info_0 (ref), v48 (copy)
                l_Info_0.ItemContainer.ItemFrame.Container.Icon.Image = v48.Container.Icon.Image;
                l_Info_0.ItemContainer.ItemFrame.ItemName.TextLabel.Text = v48.ItemName.TextLabel.Text;
                l_Info_0.ItemContainer.ItemFrame.ItemName.BackgroundColor3 = v48.ItemName.BackgroundColor3;
            end);
        end;
    end;
end;
local function _(v50, v51) --[[ Line: 110 ]] --[[ Name: viewBoxContents ]]
    -- upvalues: l_ShopService_0 (copy), l_Info_0 (copy), l_ScrollingFrame_1 (copy), l_BuyFrame_0 (copy), v42 (copy), l_GuiService_0 (copy), v38 (ref)
    l_ShopService_0:ViewBoxContents(l_Info_0.ItemContainer.ItemFrame, l_ScrollingFrame_1, l_BuyFrame_0, v50, v51);
    l_Info_0.BuyFrame.Visible = true;
    v42("ViewContents");
    l_GuiService_0:Select(l_Info_0.BuyFrame);
    v38 = v50;
end;
local function _(v53, v54) --[[ Line: 119 ]] --[[ Name: viewBuyPopup ]]
    -- upvalues: l_ShopService_0 (copy), l_ItemFrame_0 (copy), l_TextLabel_0 (copy), l_PriceFrame_0 (copy), l_BuyPopup_0 (copy), l_GuiService_0 (copy), v38 (ref)
    l_ShopService_0:ViewBuyPopup(l_ItemFrame_0, l_TextLabel_0, l_PriceFrame_0, v53, v54);
    l_BuyPopup_0.Visible = true;
    l_GuiService_0:Select(l_PriceFrame_0);
    v38 = v53;
end;
local function v58(v56, v57) --[[ Line: 127 ]] --[[ Name: onItemSelected ]]
    -- upvalues: l_ShopService_0 (copy), l_Info_0 (copy)
    l_ShopService_0:DisplayItem(l_Info_0.ItemContainer.ItemFrame, v56, v57);
    l_Info_0.BuyFrame.Visible = false;
end;
local function v61(v59, v60) --[[ Line: 133 ]] --[[ Name: onItemClicked ]]
    -- upvalues: l_Shop_1 (copy), l_WindowService_0 (copy), l_Console_0 (copy), l_ShopService_0 (copy), l_Info_0 (copy), l_ScrollingFrame_1 (copy), l_BuyFrame_0 (copy), v42 (copy), l_GuiService_0 (copy), v38 (ref), l_ItemFrame_0 (copy), l_TextLabel_0 (copy), l_PriceFrame_0 (copy), l_BuyPopup_0 (copy)
    if v60 == "Event" then
        l_Shop_1.Enabled = false;
        l_WindowService_0:ViewFrame("CurrentEvent");
        l_Console_0.Event.Enabled = true;
        return;
    elseif v60 == "MysteryBox" or v60 == "Eggs" then
        l_ShopService_0:ViewBoxContents(l_Info_0.ItemContainer.ItemFrame, l_ScrollingFrame_1, l_BuyFrame_0, v59, v60);
        l_Info_0.BuyFrame.Visible = true;
        v42("ViewContents");
        l_GuiService_0:Select(l_Info_0.BuyFrame);
        v38 = v59;
        return;
    else
        l_ShopService_0:ViewBuyPopup(l_ItemFrame_0, l_TextLabel_0, l_PriceFrame_0, v59, v60);
        l_BuyPopup_0.Visible = true;
        l_GuiService_0:Select(l_PriceFrame_0);
        v38 = v59;
        return;
    end;
end;
local function _() --[[ Line: 145 ]] --[[ Name: closeShop ]]
    -- upvalues: l_Shop_1 (copy), l_Large_0 (copy), l_GuiService_0 (copy)
    l_Shop_1.Enabled = false;
    l_Large_0.Visible = false;
    l_GuiService_0.SelectedObject = nil;
end;
local function _(v63) --[[ Line: 151 ]] --[[ Name: navigateShop ]]
    -- upvalues: v35 (ref), v34 (copy), v46 (copy)
    v35 = v35 + v63;
    if v35 > #v34 then
        v35 = 1;
    end;
    if v35 <= 0 then
        v35 = #v34;
    end;
    v46(v34[v35]);
end;
local function v65() --[[ Line: 163 ]] --[[ Name: onShopOpened ]]
    -- upvalues: v46 (copy)
    v46("Featured");
end;
local function v71(v66, v67) --[[ Line: 168 ]] --[[ Name: onItemPurchaseRequested ]]
    -- upvalues: l_NewShop_0 (copy), l_Processing_0 (copy), l_ShopService_0 (copy), l_Shop_1 (copy), l_Large_0 (copy), l_GuiService_0 (copy), l_Shop_0 (copy), l_BuyPopup_0 (copy)
    local l_Type_0 = l_NewShop_0[v66].Type;
    if l_Processing_0.Visible == true then
        return;
    elseif l_Type_0 == "MysteryBox" or l_Type_0 == "Eggs" then
        l_Processing_0.Visible = true;
        if l_Type_0 == "MysteryBox" then
            if l_ShopService_0:RequestUnbox(v66, v67, 1) then
                l_Shop_1.Enabled = false;
                l_Large_0.Visible = false;
                l_GuiService_0.SelectedObject = nil;
            end;
        elseif l_Type_0 == "Eggs" then
            local v69 = l_Shop_0.OpenCrate:InvokeServer(v66, l_Type_0, v67);
            if v69 then
                l_Shop_1.Enabled = false;
                l_Large_0.Visible = false;
                l_GuiService_0.SelectedObject = nil;
                l_Shop_0.EggController:Fire(v66, v69);
            end;
        end;
        l_Processing_0.Visible = false;
        return;
    else
        l_Processing_0.Visible = true;
        local v70 = l_Shop_0.BuyItemNew:InvokeServer(v66, v67);
        l_Processing_0.Visible = false;
        if v70 then
            l_BuyPopup_0.Visible = false;
            l_Large_0.Visible = false;
            l_Shop_1.Enabled = false;
        end;
        return;
    end;
end;
local function _() --[[ Line: 205 ]] --[[ Name: selectLastViewedItem ]]
    -- upvalues: l_Container_0 (copy), v37 (ref), l_GuiService_0 (copy), v38 (ref)
    local l_l_Container_0_FirstChild_0 = l_Container_0:FindFirstChild(v37);
    l_GuiService_0:Select(l_l_Container_0_FirstChild_0.Items.ScrollingFrame:FindFirstChild(v38));
end;
local function v76() --[[ Line: 211 ]] --[[ Name: onShopBackPressed ]]
    -- upvalues: v37 (ref), v46 (copy), v36 (ref), l_Container_0 (copy), l_GuiService_0 (copy), v38 (ref), l_BuyPopup_0 (copy), l_Shop_1 (copy), l_Large_0 (copy)
    if v37 == "ViewContents" then
        v46(v36);
        local l_l_Container_0_FirstChild_1 = l_Container_0:FindFirstChild(v37);
        l_GuiService_0:Select(l_l_Container_0_FirstChild_1.Items.ScrollingFrame:FindFirstChild(v38));
        return;
    elseif l_BuyPopup_0.Visible then
        l_BuyPopup_0.Visible = false;
        local l_l_Container_0_FirstChild_2 = l_Container_0:FindFirstChild(v37);
        l_GuiService_0:Select(l_l_Container_0_FirstChild_2.Items.ScrollingFrame:FindFirstChild(v38));
        return;
    else
        l_Shop_1.Enabled = false;
        l_Large_0.Visible = false;
        l_GuiService_0.SelectedObject = nil;
        return;
    end;
end;
local function v79() --[[ Line: 224 ]] --[[ Name: onCurrencyUpdated ]]
    -- upvalues: l_ProfileData_0 (copy), l_BottomBar_0 (copy), l_ShopService_0 (copy)
    local v77 = l_ProfileData_0.Materials.Owned.Coins or 0;
    local v78 = l_ProfileData_0.Materials.Owned.Gems or 0;
    l_BottomBar_0:WaitForChild("Gems"):WaitForChild("Amount").Text = l_ShopService_0.CommaValue(v78);
    l_BottomBar_0:WaitForChild("Coins"):WaitForChild("Amount").Text = l_ShopService_0.CommaValue(v77);
end;
(function() --[[ Line: 232 ]] --[[ Name: onInitialize ]]
    -- upvalues: l_ShopService_0 (copy), l_LargeShopItemFrame_0 (copy), l_LargeBoxContentItem_0 (copy), l_PriceFrame_0 (copy), l_ScrollingFrame_2 (copy), v33 (copy), l_ScrollingFrame_3 (copy), l_Shop_1 (copy), v76 (copy), v35 (ref), v34 (copy), v46 (copy), l_Console_0 (copy), l_WindowService_0 (copy), l_GuiService_0 (copy), v49 (copy), v79 (copy), l_Inventory_0 (copy), v71 (copy), v58 (copy), v61 (copy), l_Large_0 (copy), v65 (copy), l_EventInfoService_0 (copy)
    l_ShopService_0.ShopItemFrame = l_LargeShopItemFrame_0;
    l_ShopService_0.FeaturedItemFrame = l_LargeShopItemFrame_0;
    l_ShopService_0.BoxContentItemFrame = l_LargeBoxContentItem_0;
    l_ShopService_0.ShopItemCurrencyFrame = l_LargeShopItemFrame_0:WaitForChild("Container"):WaitForChild("Prices"):WaitForChild("LargeCurrencyFrame");
    l_ShopService_0.ShopItemCurrencyFrame.Parent = script;
    l_ShopService_0.CurrencyPriceFrame = l_PriceFrame_0:WaitForChild("Gems");
    l_ShopService_0.CurrencyPriceFrame.Parent = script;
    l_LargeShopItemFrame_0:WaitForChild("Container"):WaitForChild("Prices"):WaitForChild("Gems"):Destroy();
    l_LargeShopItemFrame_0.Parent = script;
    l_LargeBoxContentItem_0.Parent = script;
    l_ShopService_0:GenerateFeaturedItems(l_ScrollingFrame_2, v33);
    l_ShopService_0:GenerateShopItems(l_ScrollingFrame_3);
    l_Shop_1:WaitForChild("Back").Pressed:Connect(v76);
    l_Shop_1:WaitForChild("NavigateLeft").Pressed:Connect(function() --[[ Line: 249 ]]
        -- upvalues: v35 (ref), v34 (ref), v46 (ref)
        v35 = v35 + -1;
        if v35 > #v34 then
            v35 = 1;
        end;
        if v35 <= 0 then
            v35 = #v34;
        end;
        v46(v34[v35]);
    end);
    l_Shop_1:WaitForChild("NavigateRight").Pressed:Connect(function() --[[ Line: 252 ]]
        -- upvalues: v35 (ref), v34 (ref), v46 (ref)
        v35 = v35 + 1;
        if v35 > #v34 then
            v35 = 1;
        end;
        if v35 <= 0 then
            v35 = #v34;
        end;
        v46(v34[v35]);
    end);
    l_Console_0:WaitForChild("Event"):WaitForChild("Back").Pressed:Connect(function() --[[ Line: 255 ]]
        -- upvalues: l_WindowService_0 (ref), l_Console_0 (ref), l_GuiService_0 (ref)
        l_WindowService_0:Back();
        l_Console_0.Event.Enabled = false;
        l_GuiService_0.SelectedObject = nil;
    end);
    v49();
    v79();
    l_Inventory_0.InventoryDataChanged.Event:Connect(function(_, v81, _) --[[ Line: 263 ]]
        -- upvalues: v79 (ref)
        if v81 == "Gems" or v81 == "Coins" then
            v79();
        end;
    end);
    l_ShopService_0.PurchaseGemsRequested.Event:Connect(function() --[[ Line: 269 ]]
        -- upvalues: v46 (ref)
        v46("PurchaseCurrency");
    end);
    l_ShopService_0.ItemPurchaseRequested.Event:Connect(v71);
    l_ShopService_0.ItemSelectionGained.Event:Connect(v58);
    l_ShopService_0.ItemClicked.Event:Connect(v61);
    l_WindowService_0:RegisterFrame(l_Large_0, "Shop", v65);
    l_Large_0.Visible = false;
    v46("Featured");
    l_EventInfoService_0:OnEventStarted(function(v83) --[[ Line: 281 ]]
        -- upvalues: l_ShopService_0 (ref), l_ScrollingFrame_2 (ref), l_ScrollingFrame_3 (ref)
        if v83.EventStartInfo.FeaturedItems then
            l_ShopService_0:GenerateFeaturedItems(l_ScrollingFrame_2, v83.EventStartInfo.FeaturedItems.Console);
        end;
        if v83.EventStartInfo.ShopData then
            l_ShopService_0:GenerateShopItems(l_ScrollingFrame_3);
        end;
    end);
end)();