-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("AvatarEditorService");
local Modules = require(script.Parent.Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local ShoppingCart = PlayerGui:WaitForChild("ShoppingCart");
local container = ShoppingCart:WaitForChild("container");
local wrapper = container:WaitForChild("wrapper");
local items = wrapper.items;
local item = script:WaitForChild("item");
local Events = script.Parent.Parent.Events;
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
require(Modules.Shared.CatalogUtilities);
local PriceDisplay = require(Modules.Services.PriceDisplay);
local ItemPurchaseService = require(Modules.Services.ItemPurchaseService);
local ItemOwnershipService = require(Modules.Services.ItemOwnershipService);
local Icon = require(ReplicatedStorage:WaitForChild("Icon"));
require(Modules.Services.Cache);
local LoadingController = require(Modules.Controllers.LoadingController);
local OutsideClickDetector = require(Modules.Utilities.OutsideClickDetector);
local GetBatchItemDetails = require(Modules.Utilities.GetBatchItemDetails);
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);

local function escapeRichText(p2) -- Line: 35
    return tostring(p2):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;");
end;

local restriction = script.Parent.Parent.Elements.ItemButton.restriction;
local u3 = {
    CartData = nil,
    IsOpen = false,
    Is100Selected = false,
    CanCheckout = false,
    Connections = {},
    _onCartUpdated = Instance.new("BindableEvent")
};
u3.OnCartUpdated = u3._onCartUpdated.Event;
local u4 = Icon.new():setImage("rbxassetid://121780869748906"):align("Right"):setImageScale(0.7):oneClick():setOrder(2):setCaption("Open Shopping Cart"):bindEvent("deselected", function() -- Line: 60
    -- upvalues: u3 (copy)
    if u3.IsOpen then
        u3.Close();

        return;
    end;

    u3.Open(true);
end);
local u5 = 0;

local function setIconNotices() -- Line: 71
    -- upvalues: u3 (copy), u5 (ref), u4 (copy)
    if not u3.TotalCount then
        return;
    end;

    u5 = u5 + 1;
    local u6 = u5;
    task.spawn(function() -- Line: 75
        -- upvalues: u4 (ref), u3 (ref), u6 (copy), u5 (ref)
        u4:clearNotices();

        for i = 1, math.min(u3.TotalCount, 99) do
            if u6 ~= u5 then
                return;
            end;

            u4:notify();

            if i % 25 == 0 then
                task.wait();
            end;
        end;
    end);
end;

local function update() -- Line: 86
    -- upvalues: u3 (copy), PriceDisplay (copy), items (copy), wrapper (copy), u5 (ref), u4 (copy), ThemeController (copy), TweenService (copy), u1 (copy)
    local v7 = 0;
    local v8 = 0;
    local v9 = 0;
    local v10 = 0;
    local v11 = 0;

    for _, v in u3.CartData do
        v7 = v7 + 1;

        if v.IsSelected then
            v8 = v8 + 1;
            local v12 = typeof(v.Price) ~= "number" and 0 or v.Price;
            v9 = v9 + v12;
            local v13 = PriceDisplay.GetEffectivePrice(v12);

            if typeof(v13) ~= "number" then
                v13 = v12;
            end;

            v11 = v11 + v13;
            local v14 = PriceDisplay.GetHypotheticalEffectivePrice(v12, 10);

            if typeof(v14) == "number" then
                v10 = v10 + (v12 - v14);
            end;
        end;
    end;

    for _, child in items:GetChildren() do
        if child:IsA("Frame") == true then
            local v15 = child:GetAttribute("assetId");
            local v16 = u3.CartData[v15];

            if v16 == nil then
                child:Destroy();
            elseif typeof(v16.Price) == "number" then
                PriceDisplay.ApplyItemPriceText(child.price, v16.Price);
            end;
        end;
    end;

    wrapper.selectedItems.Text = "Selected: " .. tostring(v8) .. "/100 items";
    wrapper.totalPrice.RichText = true;
    wrapper.totalPrice.Text = PriceDisplay.TotalPriceText(v9, v11, "");
    PriceDisplay.UpdateUpsellButton(wrapper:FindFirstChild("robloxPlus"), v9, v11, v10);
    wrapper.title.Text = "Shopping cart (" .. tostring(v7) .. ")";
    u3.Is100Selected = v8 >= 100;
    u3.TotalCount = v7;

    if u3.TotalCount then
        u5 = u5 + 1;
        local u17 = u5;
        task.spawn(function() -- Line: 75
            -- upvalues: u4 (ref), u3 (ref), u17 (copy), u5 (ref)
            u4:clearNotices();

            for i = 1, math.min(u3.TotalCount, 99) do
                if u17 ~= u5 then
                    return;
                end;

                u4:notify();

                if i % 25 == 0 then
                    task.wait();
                end;
            end;
        end);
    end;

    wrapper.empty.Visible = v7 < 1;
    local v18;

    if v8 > 0 then
        v18 = v8 <= 100;
    else
        v18 = false;
    end;

    u3.CanCheckout = v18;
    local v19;

    if v18 then
        v19 = ThemeController.GetColor(Color3.fromRGB(0, 216, 134));
    else
        v19 = ThemeController.GetColor(Color3.fromRGB(111, 111, 111));
    end;

    if u3.IsOpen then
        TweenService:Create(wrapper.checkout, u1, {
            BackgroundColor3 = v19
        }):Play();

        return;
    end;

    wrapper.checkout.BackgroundColor3 = v19;
end;

local function attachDataToItems() -- Line: 139
    -- upvalues: u3 (copy), GetBatchItemDetails (copy)
    u3.AttachedItemData = false;
    u3.CartData = GetBatchItemDetails(u3.CartData);
    u3.AttachedItemData = true;
end;

function u3.AddItem(p20, p21) -- Line: 145
    -- upvalues: Remotes (copy)
    local v22, v23 = Remotes.ShoppingCartAction:InvokeServer("AddItem", p20, p21);

    if v22 ~= true then
        warn("failed cart add item:", v23);
    end;

    return v22, v23;
end;

function u3.RemoveItem(p24, p25) -- Line: 153
    -- upvalues: Remotes (copy)
    local v26, v27 = Remotes.ShoppingCartAction:InvokeServer("RemoveItem", p24, p25);

    if v26 ~= true then
        warn("failed cart remove item:", v27);
    end;

    return v26, v27;
end;

local u28 = nil;

function u3.Open(u29) -- Line: 162
    -- upvalues: u3 (copy), u28 (ref), OutsideClickDetector (copy), container (copy), PlayerGui (copy), Events (copy), wrapper (copy), Remotes (copy), ItemOwnershipService (copy), ItemPurchaseService (copy), ShoppingCart (copy), TweenService (copy), u1 (copy), LoadingController (copy), GetBatchItemDetails (copy), items (copy), item (copy), PriceDisplay (copy), restriction (copy), update (copy)
    if u3.IsOpen then
        return;
    end;

    u3.IsOpen = true;
    u28 = task.spawn(function() -- Line: 166
        -- upvalues: u29 (copy), OutsideClickDetector (ref), container (ref), PlayerGui (ref), u3 (ref), Events (ref), wrapper (ref), Remotes (ref), ItemOwnershipService (ref), ItemPurchaseService (ref), ShoppingCart (ref), TweenService (ref), u1 (ref), LoadingController (ref), GetBatchItemDetails (ref), items (ref), item (ref), PriceDisplay (ref), restriction (ref), update (ref)
        if not u29 then
            local v30 = OutsideClickDetector({ container }, function() -- Line: 170
                -- upvalues: PlayerGui (ref), u3 (ref)
                local ContentPage = PlayerGui:FindFirstChild("ContentPage");

                if ContentPage and ContentPage.Enabled then
                    return;
                end;

                u3.Close();
            end);
            table.insert(u3.Connections, v30);
        end;

        Events.InterfaceAction:Fire("Add", script.Name, u3.Close, not u29);
        table.insert(u3.Connections, wrapper.closeButton.Activated:Connect(function() -- Line: 183
            -- upvalues: u3 (ref)
            u3.Close();
        end));
        table.insert(u3.Connections, wrapper.checkout.Activated:Connect(function() -- Line: 187
            -- upvalues: u3 (ref), Remotes (ref), ItemOwnershipService (ref), ItemPurchaseService (ref)
            if u3.CanCheckout == false then
                return;
            end;

            local u31 = {};
            local v32 = {};

            for i, v in u3.CartData do
                if v.IsSelected then
                    u31[tonumber(i)] = v.ItemType;
                    local v33 = {
                        Type = Enum.MarketplaceProductType:FromName("Avatar" .. v.ItemType),
                        Id = tostring(i)
                    };
                    table.insert(v32, v33);
                end;
            end;

            local v34, _ = Remotes.ShoppingCartAction:InvokeServer("Checkout");

            if v34 ~= true then
                return;
            end;

            local v39 = ItemOwnershipService.OnPurchaseFinished:Connect(function(p35, p36, p37) -- Line: 214
                -- upvalues: u31 (copy), u3 (ref)
                if not p37 then
                    return;
                end;

                local v38 = u31[tonumber(p35)];

                if v38 then
                    u3.RemoveItem(tonumber(p35), v38);
                end;
            end);
            ItemPurchaseService.PromptBulkPurchase(v32);
            task.defer(v39.Disconnect, v39);
        end));
        container.GroupTransparency = 1;
        wrapper.Visible = false;
        ShoppingCart.overlay.Visible = true;
        ShoppingCart.overlay.BackgroundTransparency = 1;
        ShoppingCart.Enabled = true;

        if u29 then
            ShoppingCart.overlay.Visible = false;
            container.Position = UDim2.new(1, -10, 0.5, 0);
        else
            container.Position = UDim2.new(0.96, 0, 0.5, 0);
            TweenService:Create(ShoppingCart.overlay, u1, {
                BackgroundTransparency = 0.6
            }):Play();
        end;

        TweenService:Create(container, u1, {
            GroupTransparency = 0
        }):Play();
        LoadingController.DisplayLoading(wrapper, "overlay");
        wrapper.Visible = true;

        if not u3.AttachedItemData then
            u3.AttachedItemData = false;
            u3.CartData = GetBatchItemDetails(u3.CartData);
            u3.AttachedItemData = true;

            repeat
                task.wait(0.1);
            until u3.AttachedItemData == true;
        end;

        for _, child in items:GetChildren() do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;

        local function createItem(u40, u41) -- Line: 261
            -- upvalues: item (ref), u3 (ref), Events (ref), PriceDisplay (ref), restriction (ref), TweenService (ref), u1 (ref), Remotes (ref), items (ref)
            local u42 = item:Clone();
            local _ = u41.Index == nil;
            u42.LayoutOrder = u41.Index or 0;
            u42.icon.Image = u41.Thumbnail;
            local u43 = tostring(u41.Name):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;");
            u42.name.RichText = true;
            u42.name.Text = u43;
            local inspectButton = u42.name.inspectButton;
            table.insert(u3.Connections, inspectButton.MouseEnter:Connect(function() -- Line: 274
                -- upvalues: u42 (copy), u43 (copy)
                u42.name.Text = "<u>" .. u43 .. "</u>";
            end));
            table.insert(u3.Connections, inspectButton.MouseLeave:Connect(function() -- Line: 277
                -- upvalues: u42 (copy), u43 (copy)
                u42.name.Text = u43;
            end));
            table.insert(u3.Connections, inspectButton.Activated:Connect(function() -- Line: 280
                -- upvalues: Events (ref), u40 (copy), u41 (copy)
                Events.DisplayContentPage:Fire({
                    Type = "ItemDetails",
                    Item = {
                        IsLackingDetails = true,
                        Id = tonumber(u40),
                        ItemType = u41.ItemType
                    }
                });
            end));
            u42:SetAttribute("assetId", u40);

            if typeof(u41.Price) == "number" then
                PriceDisplay.ApplyItemPriceText(u42.price, u41.Price);
            else
                u42.price.Text = u41.Price;
            end;

            if u41.RestrictionType ~= nil then
                local v44 = restriction:Clone();
                v44.Size = UDim2.fromScale(0.7, 0.15);
                v44.Image = u41.RestrictionIcon;
                v44.Parent = u42.icon;
            end;

            u42:SetAttribute("isSelected", u41.IsSelected);
            u42.icon.checkbox.checked.ImageTransparency = u41.IsSelected and 0 or 1;
            table.insert(u3.Connections, u42.icon.checkbox.Activated:Connect(function() -- Line: 306
                -- upvalues: u42 (copy), u3 (ref), TweenService (ref), u1 (ref), Remotes (ref), u40 (copy), u41 (copy)
                local v45 = not u42:GetAttribute("isSelected");

                if v45 == true and u3.Is100Selected then
                    return warn("at 100, no no");
                end;

                TweenService:Create(u42.icon.checkbox.checked, u1, {
                    ImageTransparency = v45 and 0 or 1
                }):Play();
                local v46, v47 = Remotes.ShoppingCartAction:InvokeServer("SetItemSelected", tonumber(u40), u41.ItemType, v45);

                if v46 == true then
                    u42:SetAttribute("isSelected", v47);

                    return;
                end;

                u42.icon.checkbox.checked.ImageTransparency = v45 and 1 or 0;
            end));
            table.insert(u3.Connections, u42.unequip.MouseEnter:Connect(function() -- Line: 320
                -- upvalues: u42 (copy)
                u42.unequip.ImageTransparency = 0.2;
            end));
            table.insert(u3.Connections, u42.unequip.MouseLeave:Connect(function() -- Line: 324
                -- upvalues: u42 (copy)
                u42.unequip.ImageTransparency = 0.82;
            end));
            table.insert(u3.Connections, u42.unequip.Activated:Connect(function() -- Line: 328
                -- upvalues: u42 (copy), Remotes (ref), u40 (copy), u41 (copy)
                u42.unequip.ImageTransparency = 0.82;
                u42.Visible = false;
                local v48, _ = Remotes.ShoppingCartAction:InvokeServer("RemoveItem", tonumber(u40), u41.ItemType);

                if not v48 then
                    u42.Visible = true;
                end;
            end));
            u42.Parent = items;
        end;

        for i, v in u3.CartData do
            createItem(i, v);
        end;

        table.insert(u3.Connections, PriceDisplay.OnChanged:Connect(update));
        local robloxPlus = wrapper:FindFirstChild("robloxPlus");
        local v49 = PriceDisplay.WireUpsellButton(robloxPlus);

        if v49 then
            table.insert(u3.Connections, v49);
        end;

        LoadingController.RemoveLoading();
        update();
    end);
end;

function u3.Close() -- Line: 354
    -- upvalues: u3 (copy), LoadingController (copy), Events (copy), u28 (ref), TweenService (copy), ShoppingCart (copy), u1 (copy), container (copy), u5 (ref), u4 (copy)
    if not u3.IsOpen then
        return;
    end;

    u3.IsOpen = false;
    LoadingController.RemoveLoading();
    Events.InterfaceAction:Fire("Remove", script.Name);

    if u28 then
        pcall(task.cancel, u28);
    end;

    for _, v in u3.Connections do
        pcall(v.Disconnect, v);
    end;

    u3.Connections = {};
    TweenService:Create(ShoppingCart.overlay, u1, {
        BackgroundTransparency = 1
    }):Play();
    local v50 = TweenService:Create(container, u1, {
        GroupTransparency = 1
    });
    v50.Completed:Once(function() -- Line: 372
        -- upvalues: u3 (ref), ShoppingCart (ref)
        if u3.IsOpen == false then
            ShoppingCart.Enabled = false;
        end;
    end);
    v50:Play();

    if not u3.TotalCount then
        return;
    end;

    u5 = u5 + 1;
    local u51 = u5;
    task.spawn(function() -- Line: 75
        -- upvalues: u4 (ref), u3 (ref), u51 (copy), u5 (ref)
        u4:clearNotices();

        for i = 1, math.min(u3.TotalCount, 99) do
            if u51 ~= u5 then
                return;
            end;

            u4:notify();

            if i % 25 == 0 then
                task.wait();
            end;
        end;
    end);
end;

function u3.IsItemInCart(p52) -- Line: 381
    -- upvalues: u3 (copy)
    return (u3.CartData or {})[p52] ~= nil;
end;

function Events.ShoppingCartAddItem.OnInvoke(...) -- Line: 385
    -- upvalues: u3 (copy)
    return u3.AddItem(...);
end;

function Events.ShoppingCartRemoveItem.OnInvoke(...) -- Line: 388
    -- upvalues: u3 (copy)
    return u3.RemoveItem(...);
end;

function Events.IsItemInCart.OnInvoke(...) -- Line: 391
    -- upvalues: u3 (copy)
    return u3.IsItemInCart(...);
end;

Events.ToggleShoppingCart.Event:Connect(function(p53) -- Line: 394
    -- upvalues: u3 (copy)
    if p53 ~= nil then
        if p53 == true then
            u3.Open();
        else
            u3.Close();
        end;

        return;
    end;

    if u3.IsOpen == true then
        u3.Close();

        return;
    end;

    u3.Open();
end);
Events.SetButtonsVisible.Event:Connect(function(p54) -- Line: 409
    -- upvalues: u4 (copy)
    if p54 == "All" or type(p54) == "table" and table.find(p54, "All") then
        u4:setEnabled(true);

        return;
    end;

    u4:setEnabled(table.find(p54, "ShoppingCart") ~= nil);
end);
Remotes.ShoppingCartUpdated.OnClientEvent:Connect(function(p55) -- Line: 417
    -- upvalues: u3 (copy), GetBatchItemDetails (copy), update (copy)
    u3.CartData = p55;
    u3.AttachedItemData = false;

    if u3.IsOpen == true then
        u3.AttachedItemData = false;
        u3.CartData = GetBatchItemDetails(u3.CartData);
        u3.AttachedItemData = true;
    end;

    update();
    u3._onCartUpdated:Fire(p55);
end);
task.spawn(function() -- Line: 429
    -- upvalues: u3 (copy), Remotes (copy), GetBatchItemDetails (copy), update (copy)
    repeat
        u3.CartData = Remotes.ShoppingCartAction:InvokeServer("GetCart");
        task.wait(0.5);
    until u3.CartData ~= nil and typeof(u3.CartData) == "table";

    if next(u3.CartData) then
        local CartData = u3.CartData;
        local v56 = GetBatchItemDetails(CartData);

        if v56 then
            for i, v in CartData do
                if v56[tostring(i)] == nil then
                    u3.RemoveItem(tonumber(i), v.ItemType);
                end;
            end;

            u3.CartData = v56;
            u3.AttachedItemData = true;
        end;
    end;

    update();
    u3._onCartUpdated:Fire(u3.CartData);
end);

return u3;