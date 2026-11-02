-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = require(script.Parent.Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
local LocalPlayer = Players.LocalPlayer;
local CurrentlyWearing = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("CurrentlyWearing");
local container = CurrentlyWearing:WaitForChild("container");
local wrapper = container:WaitForChild("wrapper");
local container2 = wrapper.itemsSection.items.container;
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local Events = script.Parent.Parent.Events;

local function getSetting(p1) -- Line: 18
    -- upvalues: Events (copy)
    if not Events.GetSetting:GetAttribute("bound") then
        Events.GetSetting:GetAttributeChangedSignal("bound"):Wait();
    end;

    return Events.GetSetting:Invoke(p1);
end;

local AvatarPreviewController = require(Modules.Controllers.AvatarPreviewController);
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local ProfileBackgroundController = require(Modules.Controllers.ProfileBackgroundController);
local ItemButton = require(Modules.Elements.ItemButton);
local GetBatchItemDetails = require(Modules.Utilities.GetBatchItemDetails);
local CatalogUtilities = require(Modules.Shared.CatalogUtilities);
local ItemPurchaseService = require(Modules.Services.ItemPurchaseService);
local ItemOwnershipService = require(Modules.Services.ItemOwnershipService);
local TotalPriceResolver = require(Modules.Services.TotalPriceResolver);
local PriceDisplay = require(Modules.Services.PriceDisplay);
local LoadingController = require(Modules.Controllers.LoadingController);
local v2 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u3 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u4 = TweenService:Create(container, v2, {
    GroupTransparency = 0
});
local u5 = TweenService:Create(container, v2, {
    GroupTransparency = 1
});
local u6 = Color3.fromRGB(0, 216, 134);
local u7 = Color3.fromRGB(111, 111, 111);
local u8 = {
    IsOpen = false
};
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = false;
local u16 = false;
local u17 = {};
local u18 = {};
local u19 = {};
local u20 = 0;
local u21 = 0;
local u22 = false;
local u23 = false;
local u24 = nil;
local u25 = nil;

local function clearEquippedItems() -- Line: 71
    -- upvalues: container2 (copy), u19 (copy)
    for _, child in container2:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;

    table.clear(u19);
end;

local function clearConnections() -- Line: 80
    -- upvalues: u18 (copy)
    for _, v in u18 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u18);
end;

local function updateSummary() -- Line: 89
    -- upvalues: container2 (copy), wrapper (copy), u16 (ref), u12 (ref), u15 (ref), u9 (ref), u20 (ref), PriceDisplay (copy)
    local v26 = 0;

    for _, child in container2:GetChildren() do
        if child:IsA("Frame") then
            v26 = v26 + 1;
        end;
    end;

    local title = wrapper.title;
    local v27;

    if u16 then
        v27 = (u12 or "Outfit") .. " (" .. tostring(v26) .. ")";
    elseif u15 then
        v27 = u9.DisplayName .. "\'s Outfit (" .. tostring(v26) .. ")";
    else
        v27 = "Currently Wearing (" .. tostring(v26) .. ")";
    end;

    title.Text = v27;

    if u20 > 0 then
        wrapper.buySection.price.Text = "Getting total price...      <b></b>";
        PriceDisplay.UpdateUpsellButton(wrapper.buySection:FindFirstChild("robloxPlus"), 0, 0, 0);

        return;
    end;

    local v29, v30, _, v31 = PriceDisplay.SumItemFrames(container2, function(p28) -- Line: 108
        if p28:IsA("Frame") then
            return p28:GetAttribute("truePrice") or (tonumber(p28:GetAttribute("price")) or 0), p28:GetAttribute("bundleId");
        end;

        return nil;
    end);
    wrapper.buySection.price.Text = PriceDisplay.TotalPriceText(v29, v30, "Price: ");
    PriceDisplay.UpdateUpsellButton(wrapper.buySection:FindFirstChild("robloxPlus"), v29, v30, v31);
end;

local function promptPurchase() -- Line: 118
    -- upvalues: container2 (copy), ItemOwnershipService (copy), Events (copy), u23 (ref), TweenService (copy), wrapper (copy), u3 (copy), ThemeController (copy), u7 (copy), ItemPurchaseService (copy), u6 (copy)
    local v32 = 0;
    local v33 = {};
    local v34 = 0;
    local v35 = 0;
    local v36 = {};

    for _, child in container2:GetChildren() do
        if child:IsA("Frame") then
            v32 = v32 + 1;
            local v37 = tonumber(child.Name);
            local v38 = child:GetAttribute("itemType");
            local v39 = child:GetAttribute("assetType");
            local v40 = child:GetAttribute("bundleId");

            if v37 and v38 then
                if v39 == "MoodAnimation" then
                    v32 = v32 - 1;
                elseif ItemOwnershipService.CheckItem({
                    Id = v40 or v37,
                    ItemType = v40 and "Bundle" or "Asset"
                }) then
                    v34 = v34 + 1;
                elseif v40 then
                    if child:GetAttribute("isOffSale") then
                        v35 = v35 + 1;
                    elseif not v36[tostring(v40)] then
                        v36[tostring(v40)] = true;
                        local v41 = {
                            Type = Enum.MarketplaceProductType.AvatarBundle,
                            Id = tostring(v40)
                        };
                        table.insert(v33, v41);
                    end;
                elseif child:GetAttribute("isOffSale") then
                    v35 = v35 + 1;
                else
                    local v42 = {
                        Type = Enum.MarketplaceProductType:FromName("Avatar" .. v38),
                        Id = tostring(v37)
                    };
                    table.insert(v33, v42);
                end;
            end;
        end;
    end;

    if #v33 == 0 then
        if v32 > 0 and v34 == v32 then
            Events.Notify:Fire("✅ You own all items already.", 5);
        else
            Events.Notify:Fire("❌ No items to buy.", 5);
        end;
    end;

    if #v33 > 0 then
        u23 = true;
        TweenService:Create(wrapper.buySection.buy, u3, {
            BackgroundColor3 = ThemeController.GetColor(u7)
        }):Play();
        ItemPurchaseService.PromptBulkPurchase(v33);
        u23 = false;
    end;

    TweenService:Create(wrapper.buySection.buy, u3, {
        BackgroundColor3 = ThemeController.GetColor(u6)
    }):Play();
end;

local function updateEquipped(p43) -- Line: 194
    -- upvalues: u24 (ref), u20 (ref), u21 (ref), container2 (copy), u19 (copy), GetBatchItemDetails (copy), LoadingController (copy), Events (copy), ItemButton (copy), u15 (ref), CatalogUtilities (copy), updateSummary (copy), TotalPriceResolver (copy), u17 (copy), u22 (ref), promptPurchase (copy)
    if p43 == nil then
        return;
    end;

    if u24 then
        pcall(task.cancel, u24);
        u24 = nil;
    end;

    u24 = coroutine.running();
    u20 = 0;
    u21 = u21 + 1;
    local u44 = u21;
    local v45 = {};

    for i, v in p43 do
        if i ~= "Description" then
            local v46 = tostring(i);

            if not container2:FindFirstChild(v46) and (not u19[v46] and v.ItemType) then
                u19[v46] = true;
                v45[v46] = {
                    ItemType = v.ItemType,
                    AssetType = v.AssetType
                };
            end;
        end;
    end;

    for _, child in container2:GetChildren() do
        if child:IsA("Frame") and not p43[child.Name] then
            u19[child.Name] = nil;
            child:Destroy();
        end;
    end;

    local v47 = GetBatchItemDetails(v45);
    LoadingController.RemoveLoading();

    for _, v in v47 do
        if v.ItemType ~= "Bundle" then
            local v48 = { "Interface", "PreviewCurrentlyWearing" };

            if not Events.GetSetting:GetAttribute("bound") then
                Events.GetSetting:GetAttributeChangedSignal("bound"):Wait();
            end;

            local v49 = Events.GetSetting:Invoke(v48) == true;
            local v50 = ItemButton.new({
                IsFavoriteAvailable = true,
                ItemData = v,
                IsEquipped = not u15,
                AddEquippedOverlay = u15,
                AvatarPreviewOnHover = v49,
                ItemDetails = {
                    Id = v.Id,
                    AssetType = v.AssetType,
                    ItemType = v.ItemType,
                    BundleType = v.BundleType
                }
            });
            local Price = v.Price;

            if typeof(Price) == "string" and (Price ~= "Free" and (v.AssetType ~= "MoodAnimation" and (v.AssetType ~= "HeadShape" and not CatalogUtilities.DefaultRobloxClothingIds[tonumber(v.Id)]))) then
                v50.price.Text = "· · ·";
            end;

            v50:SetAttribute("price", v.Price);
            v50:SetAttribute("itemType", v.ItemType);
            v50:SetAttribute("assetType", v.AssetType);
            v50.LayoutOrder = CatalogUtilities.GetLayoutOrderFromAssetType(v.AssetType, v.ItemType);
            v50.Name = tostring(v.Id);
            v50.Parent = container2;
        end;
    end;

    if u15 then
        ItemButton.UpdateEquipped();
    end;

    u20 = u20 + 1;
    updateSummary();
    TotalPriceResolver.Resolve(container2, v47, {
        threads = u17,

        onUpdate = function() -- Line: 278, Name: onUpdate
            -- upvalues: u44 (copy), u21 (ref), updateSummary (ref)
            if u44 ~= u21 then
                return;
            end;

            updateSummary();
        end,

        onComplete = function() -- Line: 282, Name: onComplete
            -- upvalues: u44 (copy), u21 (ref), u20 (ref), updateSummary (ref), LoadingController (ref), u22 (ref), promptPurchase (ref)
            if u44 == u21 then
                u20 = u20 - 1;
                updateSummary();
            end;

            if u44 == u21 and u20 == 0 then
                LoadingController.RemoveLoading();
            end;

            if u44 == u21 and (u20 == 0 and u22) then
                u22 = false;
                promptPurchase();
            end;
        end
    });
end;

function u8.Close() -- Line: 298
    -- upvalues: u8 (copy), u22 (ref), u23 (ref), u20 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref), Events (copy), u25 (ref), u17 (copy), LoadingController (copy), u18 (copy), u5 (copy), CurrentlyWearing (copy), clearEquippedItems (copy)
    if not u8.IsOpen then
        return;
    end;

    u8.IsOpen = false;
    u22 = false;
    u23 = false;
    u20 = 0;
    u9 = nil;
    u10 = nil;
    u11 = nil;
    u12 = nil;
    u13 = nil;
    u14 = nil;
    u15 = false;
    u16 = false;
    Events.InterfaceAction:Fire("Remove", script.Name);

    if u25 then
        pcall(u25.Destroy, u25);
        u25 = nil;
    end;

    for _, v in u17 do
        pcall(task.cancel, v);
    end;

    table.clear(u17);
    LoadingController.RemoveLoading();

    for _, v in u18 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u18);
    u5:Play();
    u5.Completed:Once(function() -- Line: 329
        -- upvalues: u8 (ref), CurrentlyWearing (ref), clearEquippedItems (ref)
        if u8.IsOpen ~= true then
            CurrentlyWearing.Enabled = false;
            clearEquippedItems();
        end;
    end);
end;

function u8.Open(p51, p52) -- Line: 337
    -- upvalues: u8 (copy), u22 (ref), u23 (ref), u16 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), LocalPlayer (copy), Remotes (copy), Events (copy), CurrentlyWearing (copy), container (copy), wrapper (copy), ThemeController (copy), u6 (copy), u4 (copy), clearEquippedItems (copy), ProfileBackgroundController (copy), u17 (copy), u25 (ref), AvatarPreviewController (copy), LoadingController (copy), CatalogUtilities (copy), updateEquipped (copy), u18 (copy), ItemButton (copy), HumanoidDescriptionController (copy), ItemOwnershipService (copy), container2 (copy), u20 (ref), TweenService (copy), u3 (copy), u7 (copy), promptPurchase (copy), PriceDisplay (copy), updateSummary (copy)
    if u8.IsOpen then
        if p51 then
            u8.Close();
        end;

        return;
    end;

    u8.IsOpen = true;
    u22 = false;
    u23 = false;
    local v53;

    if type(p52) == "table" then
        v53 = p52.HumanoidDescription ~= nil;
    else
        v53 = false;
    end;

    u16 = v53;

    if u16 then
        u9 = nil;
        u10 = p52.HumanoidDescription;
        u11 = p52.RigType;
        u12 = p52.Title;
        u13 = p52.Source;
        u14 = p52.OutfitId or p52.UserId;
        u15 = true;
    else
        u9 = p52 or LocalPlayer;
        u10 = nil;
        u11 = nil;
        u12 = nil;
        u13 = nil;
        u14 = nil;
        u15 = u9 ~= LocalPlayer;
    end;

    pcall(Remotes.AnalyticsEvent.FireServer, Remotes.AnalyticsEvent, u15 and "ViewOtherPlayerOutfit" or "ViewCurrentlyWearing");
    Events.InterfaceAction:Fire("Add", script.Name, u8.Close, u16);
    CurrentlyWearing.Enabled = true;
    container.GroupTransparency = 1;
    wrapper.buySection.Visible = true;
    wrapper.saveSection.Visible = not u15 or u16;
    wrapper.buySection.buy.BackgroundColor3 = ThemeController.GetColor(u6);
    u4:Play();
    clearEquippedItems();
    local background = wrapper.preview:FindFirstChild("background");

    local function updatePreviewBackground() -- Line: 386
        -- upvalues: background (copy), u16 (ref), ProfileBackgroundController (ref), u15 (ref), u9 (ref)
        if not background then
            return;
        end;

        if u16 then
            ProfileBackgroundController.ApplyToImage(background, nil);

            return;
        end;

        if not u15 then
            ProfileBackgroundController.ApplyToImage(background, ProfileBackgroundController.GetEquippedId());

            return;
        end;

        local v54 = u9:GetAttribute(ProfileBackgroundController.Attribute);
        local ApplyToImage = ProfileBackgroundController.ApplyToImage;
        local v55;

        if v54 then
            v55 = tostring(v54);
        else
            v55 = nil;
        end;

        ApplyToImage(background, v55);
    end;

    table.insert(u17, task.spawn(updatePreviewBackground));
    table.insert(u17, task.spawn(function() -- Line: 399
        -- upvalues: u16 (ref), u8 (ref), u25 (ref), AvatarPreviewController (ref), wrapper (ref), u10 (ref), u11 (ref), u9 (ref), LocalPlayer (ref)
        if u16 then
            if not u8.IsOpen or u25 then
                return;
            end;

            u25 = AvatarPreviewController.new(wrapper.preview.viewport, u10, {
                AllowCameraAdjustment = true,
                AllowAnimations = true,
                RigType = u11
            });

            return;
        end;

        local Humanoid = (u9.Character or u9.CharacterAdded:Wait()):WaitForChild("Humanoid");

        if not u8.IsOpen or u25 then
            return;
        end;

        u25 = AvatarPreviewController.new(wrapper.preview.viewport, nil, {
            AllowCameraAdjustment = true,
            AllowAnimations = true,
            Target = u9,
            RigType = Humanoid.RigType,
            UseLiveAdjustments = u9 == LocalPlayer
        });
    end));
    LoadingController.DisplayLoading(wrapper.itemsSection, "overlay");

    local function buildEquippedFromPlayer(p56) -- Line: 425
        -- upvalues: CatalogUtilities (ref), ProfileBackgroundController (ref)
        local Character = p56.Character;

        if not Character then
            return nil;
        end;

        local v57 = Character:FindFirstChildWhichIsA("Humanoid");

        if not v57 then
            return nil;
        end;

        local v58 = v57:GetAppliedDescription();
        local v59 = {};

        for _, v in CatalogUtilities.GetEquippedAssetIdsFromDescription(v58, v57) do
            v59[tostring(v.AssetId)] = {
                ItemType = v.ItemType,
                AssetType = v.AssetType
            };
        end;

        v59.Description = v58;
        local v60 = p56:GetAttribute(ProfileBackgroundController.Attribute);

        if v60 then
            v59[tostring(v60)] = {
                ItemType = "Asset",
                AssetType = "AvatarBackground"
            };
        end;

        return v59;
    end;

    local function withOwnBackground(p61) -- Line: 450
        -- upvalues: ProfileBackgroundController (ref)
        if p61 == nil then
            return nil;
        end;

        local v62 = ProfileBackgroundController.GetEquippedId();

        if not (v62 and ProfileBackgroundController.IsRobloxBackground(v62)) then
            return p61;
        end;

        local v63 = table.clone(p61);
        local v64 = tonumber(v62) or v62;
        v63[tostring(v64)] = {
            ItemType = "Asset",
            AssetType = "AvatarBackground"
        };

        return v63;
    end;

    if u16 then
        table.insert(u17, task.spawn(function() -- Line: 463
            -- upvalues: updateEquipped (ref), CatalogUtilities (ref), u10 (ref)
            updateEquipped(CatalogUtilities.GetEquippedAssetIdsFromDescription(u10, nil, true));
        end));
    elseif u15 then
        table.insert(u17, task.spawn(function() -- Line: 468
            -- upvalues: buildEquippedFromPlayer (copy), u9 (ref), updateEquipped (ref)
            local v65 = buildEquippedFromPlayer(u9);

            if v65 then
                updateEquipped(v65);
            end;
        end));

        local function listenToCharacter(p66) -- Line: 476
            -- upvalues: u8 (ref), u18 (ref), u17 (ref), buildEquippedFromPlayer (copy), u9 (ref), updateEquipped (ref), ItemButton (ref)
            local Humanoid = p66:WaitForChild("Humanoid", 5);

            if not (Humanoid and u8.IsOpen) then
                return;
            end;

            table.insert(u18, Humanoid.ApplyDescriptionFinished:Connect(function() -- Line: 479
                -- upvalues: u17 (ref), buildEquippedFromPlayer (ref), u9 (ref), updateEquipped (ref), ItemButton (ref)
                table.insert(u17, task.spawn(function() -- Line: 480
                    -- upvalues: buildEquippedFromPlayer (ref), u9 (ref), updateEquipped (ref), ItemButton (ref)
                    local v67 = buildEquippedFromPlayer(u9);

                    if v67 then
                        updateEquipped(v67);
                        ItemButton.UpdateEquipped();
                    end;
                end));
            end));
        end;

        if u9.Character then
            listenToCharacter(u9.Character);
        end;

        table.insert(u18, u9.CharacterAdded:Connect(function(u68) -- Line: 494
            -- upvalues: listenToCharacter (copy), u17 (ref), u8 (ref), buildEquippedFromPlayer (copy), u9 (ref), updateEquipped (ref), ItemButton (ref)
            listenToCharacter(u68);
            table.insert(u17, task.spawn(function() -- Line: 497
                -- upvalues: u68 (copy), u8 (ref), buildEquippedFromPlayer (ref), u9 (ref), updateEquipped (ref), ItemButton (ref)
                local Humanoid = u68:WaitForChild("Humanoid", 5);

                if not (Humanoid and u8.IsOpen) then
                    return;
                end;

                Humanoid.ApplyDescriptionFinished:Wait();
                local v69 = buildEquippedFromPlayer(u9);

                if v69 then
                    updateEquipped(v69);
                    ItemButton.UpdateEquipped();
                end;
            end));
        end));
        local v70 = u9:GetAttributeChangedSignal(ProfileBackgroundController.Attribute);
        table.insert(u18, v70:Connect(function() -- Line: 510
            -- upvalues: u17 (ref), updatePreviewBackground (copy), buildEquippedFromPlayer (copy), u9 (ref), updateEquipped (ref)
            table.insert(u17, task.spawn(function() -- Line: 511
                -- upvalues: updatePreviewBackground (ref), buildEquippedFromPlayer (ref), u9 (ref), updateEquipped (ref)
                updatePreviewBackground();
                local v71 = buildEquippedFromPlayer(u9);

                if v71 then
                    updateEquipped(v71);
                end;
            end));
        end));
    else
        table.insert(u17, task.spawn(function() -- Line: 520
            -- upvalues: updateEquipped (ref), withOwnBackground (copy), HumanoidDescriptionController (ref)
            updateEquipped((withOwnBackground(HumanoidDescriptionController.EquippedDict)));
        end));
        table.insert(u18, HumanoidDescriptionController.OnEquippedUpdated:Connect(function(u72) -- Line: 524
            -- upvalues: u17 (ref), updateEquipped (ref), withOwnBackground (copy)
            table.insert(u17, task.spawn(function() -- Line: 525
                -- upvalues: updateEquipped (ref), withOwnBackground (ref), u72 (copy)
                updateEquipped((withOwnBackground(u72)));
            end));
        end));
        table.insert(u18, ProfileBackgroundController.Changed:Connect(function() -- Line: 531
            -- upvalues: u17 (ref), updatePreviewBackground (copy), updateEquipped (ref), withOwnBackground (copy), HumanoidDescriptionController (ref)
            table.insert(u17, task.spawn(function() -- Line: 532
                -- upvalues: updatePreviewBackground (ref), updateEquipped (ref), withOwnBackground (ref), HumanoidDescriptionController (ref)
                updatePreviewBackground();
                updateEquipped((withOwnBackground(HumanoidDescriptionController.EquippedDict)));
            end));
        end));
    end;

    table.insert(u18, ItemOwnershipService.OnPurchaseFinished:Connect(function(p73, p74, p75) -- Line: 539
        -- upvalues: container2 (ref), ItemButton (ref), ThemeController (ref)
        if not p75 then
            return;
        end;

        local v76 = container2:FindFirstChild((tostring(p73)));

        if v76 then
            local v77 = ItemButton.AddLabel(v76, "Owned", -1);
            v77.BackgroundColor3 = ThemeController.GetColor(Color3.fromRGB(254, 254, 255));
            v77.value.TextColor3 = ThemeController.GetColor(Color3.fromRGB(18, 18, 21));
        end;
    end));
    table.insert(u18, wrapper.buySection.buy.Activated:Connect(function() -- Line: 550
        -- upvalues: u23 (ref), u20 (ref), u22 (ref), TweenService (ref), wrapper (ref), u3 (ref), ThemeController (ref), u7 (ref), promptPurchase (ref)
        if u23 then
            return;
        end;

        if u20 <= 0 then
            promptPurchase();

            return;
        end;

        if u22 then
            return;
        end;

        u22 = true;
        TweenService:Create(wrapper.buySection.buy, u3, {
            BackgroundColor3 = ThemeController.GetColor(u7)
        }):Play();
    end));

    if not u15 or u16 then
        local u78;

        if u16 then
            u78 = u10;
        else
            u78 = nil;
        end;

        local u79;

        if u16 then
            u79 = u11;
        else
            u79 = nil;
        end;

        local u80;

        if u16 then
            u80 = u13;
        else
            u80 = nil;
        end;

        local u81;

        if u16 then
            u81 = u14;
        else
            u81 = nil;
        end;

        table.insert(u18, wrapper.saveSection.save.Activated:Connect(function() -- Line: 569
            -- upvalues: u8 (ref), u78 (copy), Events (ref), u79 (copy), u80 (copy), u81 (copy)
            u8.Close();

            if u78 then
                Events.DisplaySaveOutfit:Fire(false, u78, u79, {
                    SourceType = u80,
                    SourceId = u81
                });

                return;
            end;

            Events.DisplaySaveOutfit:Fire();
        end));
    end;

    table.insert(u18, wrapper.closeButton.Activated:Connect(u8.Close));
    table.insert(u18, PriceDisplay.OnChanged:Connect(updateSummary));
    local v82 = PriceDisplay.WireUpsellButton(wrapper.buySection:FindFirstChild("robloxPlus"));

    if v82 then
        table.insert(u18, v82);
    end;
end;

Events.DisplayCurrentlyWearing.Event:Connect(u8.Open);

return u8;