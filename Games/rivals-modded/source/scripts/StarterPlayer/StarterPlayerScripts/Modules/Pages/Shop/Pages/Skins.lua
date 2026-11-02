-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local MonetizationLibrary = require(ReplicatedStorage.Modules.MonetizationLibrary);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
require(ReplicatedStorage.Modules.Utility);
local MonetizationController = require(Players.LocalPlayer.PlayerScripts.Controllers.MonetizationController);
local ComplianceController = require(Players.LocalPlayer.PlayerScripts.Controllers.ComplianceController);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local Spotlight = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Spotlight);
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules.ButtonEffect);
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules.RewardSlot);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 17
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Pages = p2;
    v3.Frame = v3.Pages.Frame:WaitForChild("Skins");
    v3.Container = v3.Frame:WaitForChild("Container");
    v3.SlotsFrame = v3.Container:WaitForChild("Slots");
    v3.InspectFrame = v3.Container:WaitForChild("Inspect");
    v3.InspectRewardsFrame = v3.InspectFrame:WaitForChild("Rewards");
    v3.InspectNameDisplayFrame = v3.InspectFrame:WaitForChild("NameDisplay");
    v3.InspectNameDisplayBackground = v3.InspectNameDisplayFrame:WaitForChild("Background");
    v3.InspectNameDisplayElementsFrame = v3.InspectNameDisplayFrame:WaitForChild("Elements");
    v3.InspectNameDisplayLayout = v3.InspectNameDisplayElementsFrame:WaitForChild("Layout");
    v3.InspectNameDisplayTitleContainerFrame = v3.InspectNameDisplayElementsFrame:WaitForChild("TitleContainer");
    v3.InspectNameDisplayTitle = v3.InspectNameDisplayTitleContainerFrame:WaitForChild("Title");
    v3.InspectNameDisplaySlotFrameContainer = v3.InspectNameDisplayElementsFrame:WaitForChild("Slot"):WaitForChild("Container");
    v3.InspectDescriptionFrame = v3.InspectNameDisplaySlotFrameContainer:WaitForChild("Description");
    v3.InspectDescriptionArrow = v3.InspectDescriptionFrame:WaitForChild("Arrow");
    v3.InspectDescriptionBackground = v3.InspectDescriptionFrame:WaitForChild("Background");
    v3.InspectDescriptionTitle = v3.InspectDescriptionFrame:WaitForChild("Title");
    v3.InspectButtonsFrame = v3.InspectFrame:WaitForChild("Buttons");
    v3.InspectBackButton = v3.InspectButtonsFrame:WaitForChild("Back");
    v3.InspectBuyItemButton = v3.InspectButtonsFrame:WaitForChild("BuyItem");
    v3.InspectBuyItemText = v3.InspectBuyItemButton:WaitForChild("Value");
    v3.InspectBuyBundleButton = v3.InspectButtonsFrame:WaitForChild("BuyBundle");
    v3.InspectBuyBundleText = v3.InspectBuyBundleButton:WaitForChild("Value");
    v3.InspectDiscountTitle = v3.InspectButtonsFrame:WaitForChild("Discount"):WaitForChild("Bubble"):WaitForChild("Title");
    v3.InspectPreviewFrame = v3.InspectFrame:WaitForChild("Preview");
    v3.InspectPreviewContainer = v3.InspectPreviewFrame:WaitForChild("Container");
    v3._inspected_bundle_name = false;
    v3._inspected_bundle_info = nil;
    v3._selected_product_and_reward = nil;
    v3._inspected_reward_slots = {};
    v3._selected_reward_slot = nil;
    v3._preview_reward_slot = nil;
    v3:_Init();

    return v3;
end;

function u1.SelectProductAndReward(p4, p5) -- Line: 63
    -- upvalues: MonetizationController (copy), CosmeticLibrary (copy), PlayerDataController (copy), RewardSlot (copy)
    if p4._selected_reward_slot then
        p4._selected_reward_slot:Destroy();
        p4._selected_reward_slot = nil;
    end;

    if p4._preview_reward_slot then
        p4._preview_reward_slot:Destroy();
        p4._preview_reward_slot = nil;
    end;

    p4._selected_product_and_reward = p5;
    p4.InspectNameDisplayFrame.Visible = p4._selected_product_and_reward ~= nil;
    p4.InspectBuyItemButton.Visible = p4._selected_product_and_reward and p4._selected_product_and_reward[1] ~= nil;

    if not p4._selected_product_and_reward then
        return;
    end;

    if p4.InspectBuyItemButton.Visible then
        MonetizationController:SetRobuxText(p4.InspectBuyItemText, p4._selected_product_and_reward and p4._selected_product_and_reward[1]);
    end;

    local v6 = p4._selected_product_and_reward[3];
    local v7 = CosmeticLibrary.Cosmetics[v6.Name];
    p4.InspectNameDisplayTitle.Text = v6.Name .. (not v7 and "" or "  •  " .. v7.Type .. " ");
    p4.InspectDescriptionTitle.Text = (v7 and v7.ItemName and (v6.Weapon or "") or "") .. " not included";
    local InspectDescriptionFrame = p4.InspectDescriptionFrame;
    local v8 = v7 and (v7.ItemName and v6.Weapon) and not PlayerDataController:GetWeaponData(v6.Weapon);
    InspectDescriptionFrame.Visible = v8;
    p4._selected_reward_slot = RewardSlot.new(v6);
    p4._selected_reward_slot:HideWeaponVisual();
    p4._selected_reward_slot:SetNameText("");
    p4._selected_reward_slot:SetInteractable(false);
    p4._selected_reward_slot.Frame.Parent = p4.InspectNameDisplaySlotFrameContainer;
    p4._preview_reward_slot = RewardSlot.new(v6);
    p4._preview_reward_slot:ZoomOutViewportFrame();
    p4._preview_reward_slot:UseHighResolutionImage();
    p4._preview_reward_slot:HideBackground();
    p4._preview_reward_slot:HideWeaponVisual();
    p4._preview_reward_slot:SetNameText("");
    p4._preview_reward_slot:SetInteractable(false);
    p4._preview_reward_slot.Frame.Parent = p4.InspectPreviewContainer;
    p4.InspectPreviewContainer.Position = UDim2.new(0.5, 0, 0.6, 0);
    p4.InspectPreviewContainer:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quint", 0.25, true);
end;

function u1.Inspect(u9, p10) -- Line: 112
    -- upvalues: MonetizationLibrary (copy), MonetizationController (copy), CosmeticLibrary (copy), ComplianceController (copy), RewardSlot (copy)
    if p10 == u9._inspected_bundle_name then
        return;
    end;

    for _, v in pairs(u9._inspected_reward_slots) do
        v:Destroy();
    end;

    u9._inspected_reward_slots = {};
    u9._inspected_bundle_name = p10;
    u9._inspected_bundle_info = u9._inspected_bundle_name and MonetizationLibrary.Bundles[u9._inspected_bundle_name];
    u9:SelectProductAndReward(nil);
    u9.SlotsFrame.Visible = not u9._inspected_bundle_name;
    local SlotsFrame = u9.SlotsFrame;
    local v11;

    if u9.SlotsFrame.Visible then
        v11 = UDim2.new(0.375, 0, 0, 0);
    else
        v11 = UDim2.new(0.5, 0, 0, 0);
    end;

    SlotsFrame.Position = v11;
    u9.SlotsFrame:TweenPosition(UDim2.new(0.5, 0, 0, 0), "Out", "Quint", 0.25, true);
    u9.InspectFrame.Visible = not u9.SlotsFrame.Visible;
    local InspectFrame = u9.InspectFrame;
    local v12;

    if u9.InspectFrame.Visible then
        v12 = UDim2.new(0.625, 0, 0, 0);
    else
        v12 = UDim2.new(0.5, 0, 0, 0);
    end;

    InspectFrame.Position = v12;
    u9.InspectFrame:TweenPosition(UDim2.new(0.5, 0, 0, 0), "Out", "Quint", 0.25, true);

    if not u9._inspected_bundle_name then
        return;
    end;

    MonetizationController:SetRobuxText(u9.InspectBuyBundleText, u9._inspected_bundle_info.ProductID);
    MonetizationController:SetRobuxTextWithFormat("<s>%s</s>", u9.InspectDiscountTitle, table.unpack(u9._inspected_bundle_info.SetRobuxTextArgs));

    for i, v in pairs(u9._inspected_bundle_info.RewardsWithIndividualProductIDs) do
        local v13 = v[3];
        local v14 = CosmeticLibrary.Rewards[v13.Name];

        if not (v14 and (v14.Type == "Lootbox" and ComplianceController:ArePaidRandomItemsRestricted())) then
            local v15 = RewardSlot.new(v13);
            v15.Frame.LayoutOrder = i;
            v15:SetParent(u9.InspectRewardsFrame);
            table.insert(u9._inspected_reward_slots, v15);
            v15:OnClick(function() -- Line: 154
                -- upvalues: u9 (copy), v (copy)
                u9:SelectProductAndReward(v);
            end);

            if not u9._selected_product_and_reward and v[1] then
                u9:SelectProductAndReward(v);
            end;
        end;
    end;

    if not u9._selected_product_and_reward then
        u9:SelectProductAndReward(u9._inspected_bundle_info.RewardsWithIndividualProductIDs[1]);
    end;
end;

function u1.Open(p16) -- Line: 168
    p16:Inspect(nil);
end;

function u1.Close(p17) -- Line: 172
    p17:Inspect(nil);
end;

function u1.Setup(u18) -- Line: 176
    -- upvalues: MonetizationLibrary (copy), Spotlight (copy), ButtonEffect (copy), CosmeticLibrary (copy), ComplianceController (copy), RewardSlot (copy)
    for i, v in pairs(MonetizationLibrary.Bundles) do
        if v.IsCosmeticBundle then
            local Container = u18.SlotsFrame:WaitForChild(i):WaitForChild("Container");
            local Rewards = Container:WaitForChild("Rewards");
            Container:WaitForChild("Title").Text = v.DisplayName;
            Container.MouseButton1Click:Connect(function() -- Line: 189
                -- upvalues: u18 (copy), i (copy)
                u18:Inspect(i);
            end);
            Container.MouseEnter:Connect(function() -- Line: 193
                -- upvalues: Spotlight (ref), Container (copy)
                Spotlight:ChangeSubject(Container);
            end);
            Container.MouseLeave:Connect(function() -- Line: 197
                -- upvalues: Spotlight (ref), Container (copy)
                Spotlight:ChangeSubject(nil, Container);
            end);
            ButtonEffect:Add(Container, nil, {
                HoverRatio = 1.025,
                ReleaseRatio = 1.025
            });

            for i2, v2 in pairs(v.RewardsWithIndividualProductIDs) do
                if v2[1] then
                    local v19 = v2[3];
                    local v20 = CosmeticLibrary.Rewards[v19.Name];

                    if not (v20 and (v20.Type == "Lootbox" and ComplianceController:ArePaidRandomItemsRestricted())) then
                        local v21 = RewardSlot.new(v19);
                        v21.Frame.LayoutOrder = i2;
                        v21:SetInteractable(false);
                        v21:SetNameText("");
                        v21:HideWeaponVisual();
                        v21:SetParent(Rewards);
                    end;
                end;
            end;
        end;
    end;

    u18:Inspect(nil);
end;

function u1._UpdateLayout(p22) -- Line: 231
    p22.InspectNameDisplayTitleContainerFrame.Size = UDim2.new(0, p22.InspectNameDisplayTitle.TextBounds.X, 0.75, 0);
    p22.InspectNameDisplayBackground.Size = UDim2.new(0, p22.InspectNameDisplayLayout.AbsoluteContentSize.X + p22.InspectNameDisplayTitleContainerFrame.AbsoluteSize.Y * 0.5, 1, 0);
    p22.InspectDescriptionBackground.Size = UDim2.new(0, p22.InspectDescriptionTitle.TextBounds.X + p22.InspectDescriptionFrame.AbsoluteSize.Y, 1, 0);
end;

function u1._Init(u23) -- Line: 237
    -- upvalues: MonetizationController (copy), ButtonEffect (copy)
    u23.InspectBuyBundleButton.MouseButton1Click:Connect(function() -- Line: 238
        -- upvalues: MonetizationController (ref), u23 (copy)
        MonetizationController:PromptProductPurchase(u23._inspected_bundle_info.ProductID);
    end);
    u23.InspectBuyItemButton.MouseButton1Click:Connect(function() -- Line: 242
        -- upvalues: MonetizationController (ref), u23 (copy)
        MonetizationController:PromptProductPurchase(u23._selected_product_and_reward[1]);
    end);
    u23.InspectBackButton.MouseButton1Click:Connect(function() -- Line: 246
        -- upvalues: u23 (copy)
        u23:Inspect(nil);
    end);
    u23.InspectNameDisplayTitle:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 250
        -- upvalues: u23 (copy)
        u23:_UpdateLayout();
    end);
    u23.InspectNameDisplayTitleContainerFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 254
        -- upvalues: u23 (copy)
        u23:_UpdateLayout();
    end);
    u23.InspectNameDisplayLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 258
        -- upvalues: u23 (copy)
        u23:_UpdateLayout();
    end);
    u23.InspectDescriptionTitle:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 262
        -- upvalues: u23 (copy)
        u23:_UpdateLayout();
    end);
    u23.Pages.Shop.CurrentPageChanged:Connect(function() -- Line: 266
        -- upvalues: u23 (copy)
        u23:Inspect(nil);
    end);
    u23:_UpdateLayout();
    ButtonEffect:Add(u23.InspectBackButton);
    ButtonEffect:Add(u23.InspectBuyItemButton);
    ButtonEffect:Add(u23.InspectBuyBundleButton);
end;

return u1;