-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local MarketplaceService = game:GetService("MarketplaceService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local MonetizationLibrary = require(ReplicatedStorage.Modules.MonetizationLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local MonetizationController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("MonetizationController"));
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local BaseContractSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseContractSlot"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local PromptSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"));
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local UGCEmptySlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("UGCEmptySlot");
local UGCSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("UGCSlot");
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 24
    -- upvalues: Page (copy), u1 (copy), PromptSystem (copy), BaseContractSlot (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.CloseButton = v3.PageFrame:WaitForChild("Close");
    v3.PromptsFrame = v3.PageFrame:WaitForChild("Prompts");
    v3.List = v3.PageFrame:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.SlotsFrame = v3.Container:WaitForChild("Slots");
    v3.SlotsContainer = v3.SlotsFrame:WaitForChild("Container");
    v3.SlotsLayout = v3.SlotsContainer:WaitForChild("Layout");
    v3.CartFrame = v3.Container:WaitForChild("Cart");
    v3.CartContainer = v3.CartFrame:WaitForChild("Container");
    v3.ItemsText = v3.CartContainer:WaitForChild("Items");
    v3.BuyButton = v3.CartContainer:WaitForChild("Buy");
    v3.BuyDisclaimerFrame = v3.BuyButton:WaitForChild("Disclaimer");
    v3.BuyLockedFrame = v3.BuyButton:WaitForChild("Locked");
    v3.BuyRobuxFrame = v3.BuyButton:WaitForChild("Robux");
    v3.BuyText = v3.BuyButton:WaitForChild("Value");
    v3.NextRewardContainer = v3.CartContainer:WaitForChild("NextRewardContainer");
    v3.NextRewardTitle = v3.CartContainer:WaitForChild("NextRewardTitle");
    v3.NextRewardDescription = v3.CartContainer:WaitForChild("NextRewardDescription");
    v3.NextRewardProgressBFrame = v3.CartContainer:WaitForChild("NextRewardProgress");
    v3.NextRewardProgressBar = v3.NextRewardProgressBFrame:WaitForChild("Bar");
    v3.PromptSystem = PromptSystem.new(v3.PromptsFrame);
    v3._next_reward_slot = nil;
    v3._contract_slot = BaseContractSlot.new();
    v3._verified_ugc = false;
    v3._ugc_slots = {};
    v3._robux_prices = {};
    v3._shopping_cart = {};
    v3:_Init();

    return v3;
end;

function u1.Buy(p4, p5) -- Line: 67
    -- upvalues: MonetizationController (copy), MonetizationLibrary (copy)
    MonetizationController:PromptPurchase(MonetizationLibrary.UGCs[p5].AssetID);
end;

function u1.BuyCart(p6) -- Line: 71
    -- upvalues: Utility (copy), MonetizationLibrary (copy), MonetizationController (copy)
    if not next(p6._shopping_cart) then
        Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);

        return;
    end;

    local v7 = {};

    for i in pairs(p6._shopping_cart) do
        local v8 = {
            Type = Enum.MarketplaceProductType.AvatarAsset,
            Id = tostring(MonetizationLibrary.UGCs[i].AssetID)
        };
        table.insert(v7, v8);
    end;

    MonetizationController:PromptBulkPurchase(v7);
end;

function u1.Close(p9, ...) -- Line: 86
    -- upvalues: Page (copy)
    p9:_ClearCart();
    Page.Close(p9, ...);
end;

function u1._GetNumItemsInCart(p10) -- Line: 95
    -- upvalues: MonetizationLibrary (copy)
    local v11 = 0;
    local v12 = 0;
    local v13 = false;

    for i in pairs(p10._shopping_cart) do
        v11 = v11 + 1;
        v12 = v12 + (p10._robux_prices[i] or 0);
        v13 = v13 or MonetizationLibrary.UGCs[i].CanBeMisleading;
    end;

    return v11, v12, v13;
end;

function u1._UpdateCartVisuals(p14) -- Line: 109
    -- upvalues: Utility (copy)
    for i, v in pairs(p14._ugc_slots) do
        v.Enabled.Button.Added.Visible = p14._shopping_cart[i];
    end;

    local v15, v16, v17 = p14:_GetNumItemsInCart();
    p14.BuyText.Text = utf8.char(57346) .. " " .. Utility:PrettyNumber(v16);
    p14.ItemsText.Text = v15 .. " item" .. (v15 == 1 and "" or "s");
    local ItemsText = p14.ItemsText;
    local v18;

    if v15 >= 20 then
        v18 = Color3.fromRGB(255, 50, 50);
    else
        v18 = Color3.fromRGB(255, 255, 255);
    end;

    ItemsText.TextColor3 = v18;
    p14.BuyLockedFrame.Visible = v15 == 0;
    p14.BuyRobuxFrame.Visible = v15 > 0;
    p14.BuyDisclaimerFrame.Visible = v17;
end;

function u1._ClearCart(p19) -- Line: 124
    if not next(p19._shopping_cart) then
        return false;
    end;

    p19._shopping_cart = {};
    p19:_UpdateCartVisuals();

    return true;
end;

function u1._AddToCart(p20, p21) -- Line: 135
    if p20._shopping_cart[p21] or p20:_GetNumItemsInCart() >= 20 then
        return false;
    end;

    p20._shopping_cart[p21] = true;
    p20:_UpdateCartVisuals();

    return true;
end;

function u1._RemoveFromCart(p22, p23) -- Line: 146
    if not p22._shopping_cart[p23] then
        return false;
    end;

    p22._shopping_cart[p23] = nil;
    p22:_UpdateCartVisuals();

    return true;
end;

function u1._UpdateContractSlot(p24) -- Line: 157
    -- upvalues: PlayerDataController (copy)
    p24._contract_slot:SetProgress(#PlayerDataController:Get("UGCPurchased"));
end;

function u1._UpdateNextReward(p25) -- Line: 161
    -- upvalues: PlayerDataController (copy), MonetizationLibrary (copy), RewardSlot (copy)
    if p25._next_reward_slot then
        p25._next_reward_slot:Destroy();
        p25._next_reward_slot = nil;
    end;

    local v26 = #PlayerDataController:Get("UGCPurchased");
    local NextUGCMilestone, v27 = MonetizationLibrary:GetNextUGCMilestone(v26);
    local v28 = NextUGCMilestone ~= nil;
    p25.NextRewardContainer.Visible = v28;
    p25.NextRewardTitle.Visible = v28;
    p25.NextRewardDescription.Visible = v28;
    p25.NextRewardProgressBFrame.Visible = v28;
    p25.NextRewardProgressBar.Visible = v28;
    p25.CartFrame.Size = UDim2.new(1, 0, v28 and 0.2 or 0.1, 0);

    if not v28 then
        return;
    end;

    local v29 = NextUGCMilestone.PurchaseRequirement - v26;
    local v30 = not v27 and 0 or v27.PurchaseRequirement;
    p25.NextRewardProgressBar.Size = UDim2.new(math.clamp((v26 - v30) / (NextUGCMilestone.PurchaseRequirement - v30), 0, 1), 0, 1, 2);
    p25.NextRewardDescription.Text = string.format("Purchase %s more UGC item%s for a FREE reward!", v29, v29 == 1 and "" or "s");

    if NextUGCMilestone.Reward then
        p25._next_reward_slot = RewardSlot.new(NextUGCMilestone.Reward);
        p25._next_reward_slot:SetParent(p25.NextRewardContainer);
    end;
end;

function u1._UpdateLayout(p31) -- Line: 195
    p31.List.CanvasSize = UDim2.new(0, 0, 0, p31.Layout.AbsoluteContentSize.Y);
    p31.SlotsFrame.Size = UDim2.new(1, 0, 0, p31.SlotsLayout.AbsoluteContentSize.Y + p31.SlotsFrame.AbsoluteSize.X * 0.042);
end;

function u1._Setup(u32) -- Line: 200
    -- upvalues: MonetizationLibrary (copy), UGCSlot (copy), ButtonEffect (copy), PlayerDataController (copy), Utility (copy), MarketplaceService (copy), Players (copy), MonetizationController (copy), UGCEmptySlot (copy)
    u32._contract_slot:SetTitle("Exclusive Rewards");
    u32._contract_slot:SetImage("rbxassetid://71823401853501", UDim2.new(1.5, 0, 0.75, 0));
    u32._contract_slot:SetContractImage("rbxassetid://17619445340", UDim2.new(0.05, 0, 0.5, 0));
    u32._contract_slot:SetDescription("Purchase UGC items for exclusive rewards in the game (RIVALS)");

    for _, v in pairs(MonetizationLibrary.UGCMilestoneOrder) do
        local v33 = MonetizationLibrary.UGCMilestones[v];
        u32._contract_slot:AddMilestone(v33.PurchaseRequirement, v33.Reward);
    end;

    u32._contract_slot.Frame.Parent = u32.Container;

    for i, v in pairs(MonetizationLibrary.UGCOrder) do
        local u34 = MonetizationLibrary.UGCs[v];
        local u35 = nil;
        local u36 = UGCSlot:Clone();
        u36.Enabled.Visible = false;
        u36.Waiting.Visible = true;
        u36.Waiting.Dots:AddTag("UILoadingDots");
        u36.LayoutOrder = i;
        u36.Parent = u32.SlotsContainer;
        ButtonEffect:Add(u36.Enabled.Button);
        u32._ugc_slots[v] = u36;

        local function check_is_owned() -- Line: 227
            -- upvalues: PlayerDataController (ref), v (copy)
            return table.find(PlayerDataController:Get("UGCPurchased"), v);
        end;

        u36.Enabled.Button.MouseButton1Click:Connect(function() -- Line: 231
            -- upvalues: PlayerDataController (ref), v (copy), Utility (ref), u32 (copy)
            if table.find(PlayerDataController:Get("UGCPurchased"), v) then
                Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);

                return;
            end;

            if not u32._robux_prices[v] then
                u32:Buy(v);

                return;
            end;

            if u32._shopping_cart[v] then
                u32:_RemoveFromCart(v);

                return;
            end;

            if not u32:_AddToCart(v) then
                Utility:CreateSound("rbxassetid://17153811469", 2, 1, script, true, 5);
            end;
        end);

        local function update_owned() -- Line: 248
            -- upvalues: PlayerDataController (ref), v (copy), u36 (copy), u35 (ref), Utility (ref), u32 (copy)
            local table_find_ret = table.find(PlayerDataController:Get("UGCPurchased"), v);
            u36.Enabled.Button.Description.Text = table_find_ret and "✅ Owned" or (not u35 and "• • •" or utf8.char(57346) .. " " .. Utility:PrettyNumber(u35.PriceInRobux or 0));

            if table_find_ret then
                u32:_RemoveFromCart(v);
            end;
        end;

        PlayerDataController:GetDataChangedSignal("UGCPurchased"):Connect(update_owned);
        update_owned();
        task.spawn(function() -- Line: 263
            -- upvalues: MarketplaceService (ref), u34 (copy), u35 (ref), u32 (copy), v (copy), PlayerDataController (ref), Players (ref), MonetizationController (ref), u36 (copy)
            local success, result = pcall(MarketplaceService.GetProductInfoAsync, MarketplaceService, u34.AssetID, Enum.InfoType.Asset);

            if not success then
                return;
            end;

            u35 = result;
            u32._robux_prices[v] = u35.PriceInRobux;

            if not table.find(PlayerDataController:Get("UGCPurchased"), v) then
                local success2, result2 = pcall(MarketplaceService.PlayerOwnsAssetAsync, MarketplaceService, Players.LocalPlayer, u34.AssetID);

                if not success2 then
                    return;
                end;

                if result2 and not u32._verified_ugc then
                    u32._verified_ugc = true;
                    MonetizationController:VerifyUGC();
                end;
            end;

            u36.Waiting.Visible = false;
            u36.Enabled.Visible = true;
            u36.Enabled.Button.Icon.Image = "rbxthumb://type=Asset&id=" .. u34.AssetID .. "&w=150&h=150";
            u36.Enabled.Button.Title.Text = u35.Name or "";
        end);
    end;

    for i = 1, 6 - ((#MonetizationLibrary.UGCOrder - 1) % 6 + 1) do
        local v37 = UGCEmptySlot:Clone();
        v37.LayoutOrder = 65535;
        v37.Parent = u32.SlotsContainer;
        local _ = i;
    end;
end;

function u1._Init(u38) -- Line: 300
    -- upvalues: PlayerDataController (copy), ButtonEffect (copy)
    u38.CloseButton.MouseButton1Click:Connect(function() -- Line: 301
        -- upvalues: u38 (copy)
        u38:CloseRequest();
    end);
    u38.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 305
        -- upvalues: u38 (copy)
        u38:_UpdateLayout();
    end);
    u38.SlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 309
        -- upvalues: u38 (copy)
        u38:_UpdateLayout();
    end);
    u38.SlotsFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 313
        -- upvalues: u38 (copy)
        u38:_UpdateLayout();
    end);
    u38.BuyButton.MouseButton1Click:Connect(function() -- Line: 317
        -- upvalues: u38 (copy)
        u38:BuyCart();
    end);
    PlayerDataController:GetDataChangedSignal("UGCPurchased"):Connect(function() -- Line: 321
        -- upvalues: u38 (copy)
        u38:_UpdateNextReward();
        u38:_UpdateContractSlot();
    end);
    u38:_Setup();
    u38:_UpdateLayout();
    u38:_UpdateNextReward();
    u38:_UpdateContractSlot();
    u38:_UpdateCartVisuals();
    ButtonEffect:Add(u38.BuyButton);
    ButtonEffect:Add(u38.CloseButton);
end;

return u1._new();