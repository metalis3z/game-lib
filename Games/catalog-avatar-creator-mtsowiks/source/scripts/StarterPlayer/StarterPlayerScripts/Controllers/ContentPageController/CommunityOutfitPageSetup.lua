-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Modules = require(script.Parent.Parent.Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
local LoadingController = require(Modules.Controllers.LoadingController);
local AvatarPreviewController = require(Modules.Controllers.AvatarPreviewController);
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local ItemButton = require(Modules.Elements.ItemButton);
local GetBatchItemDetails = require(Modules.Utilities.GetBatchItemDetails);
local CatalogUtilities = require(Modules.Shared.CatalogUtilities);
local ItemPurchaseService = require(Modules.Services.ItemPurchaseService);
local ItemOwnershipService = require(Modules.Services.ItemOwnershipService);
local TotalPriceResolver = require(Modules.Services.TotalPriceResolver);
local PriceDisplay = require(Modules.Services.PriceDisplay);
local FavoriteController = require(Modules.Controllers.FavoriteController);
local FavoriteButton = require(Modules.Elements.FavoriteButton);
local CarouselScrollingFrame = require(Modules.Elements.CarouselScrollingFrame);
local TimeUtilities = require(Modules.Shared.TimeUtilities);
local ScrollGuard = require(script.Parent.ScrollGuard);
local Events = script.Parent.Parent.Parent:WaitForChild("Events");
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local LocalPlayer = Players.LocalPlayer;
local u1 = Color3.fromRGB(0, 216, 134);
local u2 = Color3.fromRGB(111, 111, 111);
local u3 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local Readable = require(Modules.Utilities.Readable);
local v4 = {};

local function updateSummary(u5, u6, u7) -- Line: 38
    -- upvalues: PriceDisplay (copy)
    table.insert(u7.threads, task.spawn(function() -- Line: 39
        -- upvalues: u7 (copy), u6 (copy), PriceDisplay (ref), u5 (copy)
        local success, result = pcall(function() -- Line: 40
            -- upvalues: u7 (ref), u6 (ref), PriceDisplay (ref), u5 (ref)
            if u7.activeChecks > 0 then
                u6.price.Text = "Getting total price...";
                PriceDisplay.UpdateUpsellButton(u6:FindFirstChild("robloxPlus"), 0, 0, 0);

                return;
            end;

            local v9, v10, _, v11 = PriceDisplay.SumItemFrames(u5, function(p8) -- Line: 47
                if p8:GetAttribute("isItem") then
                    return p8:GetAttribute("truePrice") or (tonumber(p8:GetAttribute("price")) or 0), p8:GetAttribute("bundleId");
                end;

                return nil;
            end);
            u6.price.Text = PriceDisplay.TotalPriceText(v9, v10, "Price: ");
            PriceDisplay.UpdateUpsellButton(u6:FindFirstChild("robloxPlus"), v9, v10, v11);
        end);

        if success == false then
            warn("error while setting total price: " .. tostring(result));
        end;
    end));
end;

local function promptPurchase(p12, p13, p14, p15) -- Line: 62
    -- upvalues: ItemOwnershipService (copy), Events (copy), TweenService (copy), u3 (copy), ThemeController (copy), u2 (copy), ItemPurchaseService (copy), u1 (copy)
    local v16 = 0;
    local v17 = 0;
    local v18 = {};
    local v19 = {};

    for _, child in p12:GetChildren() do
        if child:GetAttribute("isItem") then
            v16 = v16 + 1;
            local v20 = tonumber(child.Name);
            local v21 = child:GetAttribute("itemType");
            local v22 = child:GetAttribute("assetType");
            local v23 = child:GetAttribute("bundleId");

            if v20 and v21 then
                if v22 == "MoodAnimation" then
                    v16 = v16 - 1;
                elseif ItemOwnershipService.CheckItem({
                    Id = v23 or v20,
                    ItemType = v23 and "Bundle" or "Asset"
                }) then
                    v17 = v17 + 1;
                elseif v23 then
                    if not (child:GetAttribute("isOffSale") or v18[tostring(v23)]) then
                        v18[tostring(v23)] = true;
                        local v24 = {
                            Type = Enum.MarketplaceProductType.AvatarBundle,
                            Id = tostring(v23)
                        };
                        table.insert(v19, v24);
                    end;
                elseif not child:GetAttribute("isOffSale") then
                    local v25 = {
                        Type = Enum.MarketplaceProductType:FromName("Avatar" .. v21),
                        Id = tostring(v20)
                    };
                    table.insert(v19, v25);
                end;
            end;
        end;
    end;

    if #v19 == 0 then
        if v16 > 0 and v17 == v16 then
            Events.Notify:Fire("You own all items already.", 5);

            return;
        end;

        Events.Notify:Fire("No items to buy.", 5);

        return;
    end;

    p14.isPurchasing = true;
    TweenService:Create(p13.buy, u3, {
        BackgroundColor3 = ThemeController.GetColor(u2)
    }):Play();
    ItemPurchaseService.PromptBulkPurchase(v19, typeof(p15) == "string" and {
        Type = "CommunityOutfit",
        OutfitId = p15
    } or nil);
    p14.isPurchasing = false;
    TweenService:Create(p13.buy, u3, {
        BackgroundColor3 = ThemeController.GetColor(u1)
    }):Play();
end;

function v4.SetupPage(u26, u27) -- Line: 132
    -- upvalues: Players (copy), CatalogUtilities (copy), GetBatchItemDetails (copy), Remotes (copy), Readable (copy), Events (copy), TimeUtilities (copy), TweenService (copy), LocalPlayer (copy), HumanoidDescriptionController (copy), ScrollGuard (copy), PriceDisplay (copy), AvatarPreviewController (copy), LoadingController (copy), ItemButton (copy), TotalPriceResolver (copy), promptPurchase (copy), u3 (copy), ThemeController (copy), u2 (copy), FavoriteController (copy), FavoriteButton (copy), CarouselScrollingFrame (copy)
    local success, result = pcall(function() -- Line: 133
        -- upvalues: u27 (copy), Players (ref), CatalogUtilities (ref), GetBatchItemDetails (ref), Remotes (ref), Readable (ref), Events (ref), u26 (copy), TimeUtilities (ref), TweenService (ref), LocalPlayer (ref), HumanoidDescriptionController (ref), ScrollGuard (ref), PriceDisplay (ref), AvatarPreviewController (ref), LoadingController (ref), ItemButton (ref), TotalPriceResolver (ref), promptPurchase (ref), u3 (ref), ThemeController (ref), u2 (ref), FavoriteController (ref), FavoriteButton (ref), CarouselScrollingFrame (ref)
        local Page = u27.Page;
        local OutfitDetails = u27.OutfitDetails;
        local u28 = false;
        OutfitDetails.Name = OutfitDetails.Name or "Outfit";
        print("data:", OutfitDetails);
        local u29 = nil;
        local u30 = false;
        task.spawn(function() -- Line: 143
            -- upvalues: Players (ref), OutfitDetails (copy), u29 (ref), u30 (ref)
            local success, result = pcall(Players.GetNameFromUserIdAsync, Players, OutfitDetails.CreatorId);
            u29 = success and result and result or "Unknown";
            u30 = true;
        end);
        local u31 = CatalogUtilities.GetEquippedAssetIdsFromDescription(OutfitDetails.HumanoidDescription);
        local u32 = nil;
        local u33 = false;
        task.spawn(function() -- Line: 153
            -- upvalues: u31 (copy), u32 (ref), GetBatchItemDetails (ref), u33 (ref)
            if u31 and #u31 > 0 then
                local v34 = {};

                for _, v in u31 do
                    v34[tostring(v.AssetId)] = {
                        ItemType = v.ItemType
                    };
                end;

                u32 = GetBatchItemDetails(v34);
            end;

            u33 = true;
        end);
        local u35 = false;
        local u36 = nil;
        local u37 = false;
        task.spawn(function() -- Line: 167
            -- upvalues: Remotes (ref), OutfitDetails (copy), u35 (ref), u36 (ref), u37 (ref)
            local v38, v39 = Remotes.CommunityOutfitsAction:InvokeServer("SearchOutfits", "", "MostPopular", {
                Limit = 12,
                CreatorId = OutfitDetails.CreatorId
            });
            u35 = v38;
            u36 = v39;
            u37 = true;
        end);

        while not u30 do
            task.wait();
        end;

        local u40 = script.wrapper:Clone();
        u40.Visible = false;
        local outfit = u40.outfit;
        local statistics = u40.statistics;
        local actions = u40.actions;
        local container = outfit.itemsSection.items.container;
        local buySection = outfit.itemsSection.buySection;
        buySection.price.Text = "Getting total price...";
        local u41 = {
            activeChecks = 0,
            isWaitingToBuy = false,
            isPurchasing = false,
            threads = {}
        };
        outfit.name.Text = OutfitDetails.Name;
        outfit.creator.Text = string.format(Readable.creator, u29);
        outfit.creator.MouseEnter:Connect(function() -- Line: 199
            -- upvalues: outfit (copy), Readable (ref), u29 (ref)
            outfit.creator.Text = string.format(Readable.creatorHovered, u29);
        end);
        outfit.creator.MouseLeave:Connect(function() -- Line: 203
            -- upvalues: outfit (copy), Readable (ref), u29 (ref)
            outfit.creator.Text = string.format(Readable.creator, u29);
        end);
        Events.AddTooltipToObject:Fire(outfit.creator, "See creator\'s page", function() -- Line: 207
            -- upvalues: outfit (copy)
            return outfit.creator.TextBounds.X / 2 - outfit.creator.AbsoluteSize.X / 2;
        end);
        outfit.creator.Activated:Connect(function() -- Line: 213
            -- upvalues: Events (ref), OutfitDetails (copy)
            Events.DisplayContentPage:Fire({
                Type = "UserProfile",
                UserId = OutfitDetails.CreatorId
            });
        end);
        local searchByCreator = outfit.searchByCreator;
        Events.AddTooltipToObject:Fire(searchByCreator, "See outfits by this creator");
        searchByCreator.Activated:Connect(function() -- Line: 223
            -- upvalues: u26 (ref), Events (ref), u29 (ref)
            u26.ClosePage();
            Events.DisplayCommunityOutfits:Fire();
            task.defer(function() -- Line: 226
                -- upvalues: Events (ref), u29 (ref)
                Events.SetCommunityOutfitOptionsFilter:Fire({
                    CreatorName = u29
                });
            end);
        end);
        searchByCreator.MouseEnter:Connect(function() -- Line: 233
            -- upvalues: searchByCreator (copy)
            searchByCreator.ImageTransparency = 0;
        end);
        searchByCreator.MouseLeave:Connect(function() -- Line: 237
            -- upvalues: searchByCreator (copy)
            searchByCreator.ImageTransparency = 0.25;
        end);
        local v42 = CatalogUtilities.FormatNumber(OutfitDetails.WornCount);
        statistics.worn.value.Text = v42 .. " time" .. (OutfitDetails.WornCount == 1 and "" or "s");
        local v43 = CatalogUtilities.FormatNumber(OutfitDetails.FavoriteCount);
        statistics.favorites.value.Text = v43;
        local v44 = DateTime.fromUnixTimestamp(OutfitDetails.Created):FormatLocalTime("MMM D, YYYY", "en-us");
        statistics.created.value.Text = v44;
        statistics.created.Active = true;
        Events.AddTooltipToObject:Fire(statistics.created, TimeUtilities.FormatCommentTime(OutfitDetails.Created));

        if OutfitDetails.Updated then
            local v45 = DateTime.fromUnixTimestamp(OutfitDetails.Updated):FormatLocalTime("MMM D, YYYY", "en-us");
            statistics.updated.value.Text = v45;
            statistics.updated.Active = true;
            Events.AddTooltipToObject:Fire(statistics.updated, TimeUtilities.FormatCommentTime(OutfitDetails.Updated));
        else
            statistics.updated.Visible = false;
        end;

        local codeContainer = outfit.preview.codeContainer;

        if OutfitDetails.ShareCode then
            local label = codeContainer.code.button.label;
            label.Text = OutfitDetails.ShareCode;
            codeContainer.code.button.Activated:Connect(function() -- Line: 277
                -- upvalues: label (copy)
                if label.CursorPosition > 0 then
                    label.CursorPosition = 0;
                    label.SelectionStart = 0;

                    return;
                end;

                label.CursorPosition = #label.Text + 1;
                label.SelectionStart = 1;
            end);
            codeContainer.code.MouseEnter:Connect(function() -- Line: 285
                -- upvalues: TweenService (ref), codeContainer (copy)
                TweenService:Create(codeContainer.code.button.back, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    BackgroundTransparency = 0.85
                }):Play();
            end);
            codeContainer.code.MouseLeave:Connect(function() -- Line: 289
                -- upvalues: TweenService (ref), codeContainer (copy)
                TweenService:Create(codeContainer.code.button.back, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    BackgroundTransparency = 1
                }):Play();
            end);
            Events.AddTooltipToObject:Fire(codeContainer.code, "Send this code to friends so they can try this on!");
            label.Focused:Connect(function() -- Line: 267, Name: selectCode
                -- upvalues: label (copy)
                label.CursorPosition = #label.Text + 1;
                label.SelectionStart = 1;
            end);
            label.FocusLost:Connect(function() -- Line: 272, Name: deselectCode
                -- upvalues: label (copy)
                label.CursorPosition = 0;
                label.SelectionStart = 0;
            end);
        else
            codeContainer:Destroy();
        end;

        if OutfitDetails.CreatorId == LocalPlayer.UserId then
            actions.delete.Activated:Connect(function() -- Line: 302
                -- upvalues: Events (ref), OutfitDetails (copy), Remotes (ref), u26 (ref)
                if Events.PromptConfirmationDialog:Invoke({
                    Title = "Delete Community Outfit",
                    Description = "Are you sure you want to delete outfit \'<b>" .. OutfitDetails.Name .. "</b>\'?\n\n<b>You cannot undo this action.</b>"
                }) then
                    Events.Notify:Fire("Deleting outfit \'<b>" .. OutfitDetails.Name .. "</b>\'..");
                    local v46, v47 = Remotes.CommunityOutfitsAction:InvokeServer("DeleteOutfit", OutfitDetails.Id);

                    if v46 then
                        Events.Notify:Fire("✅ Successfully deleted outfit \'<b>" .. OutfitDetails.Name .. "</b>\'.");
                        u26.ClosePage();

                        return;
                    end;

                    Events.Notify:Fire("❌ Something went wrong. Please try again.");
                    Events.Notify:Fire("Error: " .. tostring(v47));
                end;
            end);
            actions.rename.Activated:Connect(function() -- Line: 320
                -- upvalues: Events (ref), OutfitDetails (copy), Remotes (ref), outfit (copy)
                Events.Notify:Fire("⚠️ <b>Warning!</b> Publishing inappropriate outfits is not allowed.", 5);
                local v48 = Events.PromptInputDialog:Invoke({
                    Title = "Rename Community Outfit",
                    Description = "What would you like to rename your community outfit to?",
                    NoText = "Cancel",
                    YesText = "Rename",
                    PlaceholderText = "Name"
                });

                if v48 == false then
                    Events.Notify:Fire("❌ Cancelled outfit renaming.");

                    return;
                end;

                Events.Notify:Fire("Renaming outfit \'<b>" .. OutfitDetails.Name .. "</b>\' to \'<b>" .. v48 .. "</b>\'..");
                local v49, v50 = Remotes.CommunityOutfitsAction:InvokeServer("Rename", OutfitDetails.Id, v48);

                if v49 ~= true then
                    Events.Notify:Fire("❌ Failed to rename outfit.");
                    Events.Notify:Fire("Error: " .. tostring(v50));

                    return;
                end;

                Events.Notify:Fire("✅ Successfully renamed outfit \'<b>" .. OutfitDetails.Name .. "</b>\' to \'<b>" .. v48 .. "</b>\'!");
                Events.Notify:Fire("Please give it time to update everywhere.");
                OutfitDetails.Name = v48;
                outfit.name.Text = v48;
            end);
            actions.update.Activated:Connect(function() -- Line: 346
                -- upvalues: Events (ref), OutfitDetails (copy), Remotes (ref), HumanoidDescriptionController (ref), u26 (ref)
                if Events.PromptConfirmationDialog:Invoke({
                    Title = "Update Outfit",
                    Description = "Are you sure you want to update your outfit \'<b>" .. OutfitDetails.Name .. "</b>\' to your current outfit?\n\n<b>Warning: Inappropriate outfits will result in a ban.</b>"
                }) then
                    Events.Notify:Fire("Updating outfit \'<b>" .. OutfitDetails.Name .. "</b>\'..");
                    local v51, v52, v53 = Remotes.CommunityOutfitsAction:InvokeServer("UpdateOutfit", OutfitDetails.Id);

                    if v51 then
                        Events.Notify:Fire("✅ Successfully updated outfit \'<b>" .. OutfitDetails.Name .. "</b>\'!");
                        Events.Notify:Fire("Please give it time to update everywhere.");
                        local v54, v55 = HumanoidDescriptionController.DeserializeHumanoidDescription(v52);
                        local v56 = table.clone(OutfitDetails);
                        v56.HumanoidDescription = v54;
                        v56.RigType = v55;
                        v56.Updated = v53;
                        u26.ClosePage();
                        Events.DisplayContentPage:Fire({
                            Type = "CommunityOutfit",
                            OutfitDetails = v56
                        });

                        return;
                    end;

                    if typeof(v52) == "string" and v52:find("may not be appropriate") then
                        Events.Notify:Fire("⚠️ " .. v52);

                        return;
                    end;

                    Events.Notify:Fire("❌ Failed to update outfit.");
                    Events.Notify:Fire("Error: " .. tostring(v52));
                end;
            end);
        else
            actions:Destroy();
        end;

        outfit.preview.tryOn.Activated:Connect(function() -- Line: 387
            -- upvalues: Remotes (ref), OutfitDetails (copy), Events (ref), u28 (ref), CatalogUtilities (ref), statistics (copy)
            local v57, _ = Remotes.CommunityOutfitsAction:InvokeServer("TryOnOutfit", OutfitDetails.Id);

            if v57 then
                Events.Notify:Fire("✅ Successfully wore outfit \'<b>" .. OutfitDetails.Name .. "</b>\'!");

                if not u28 then
                    local v58 = OutfitDetails;
                    v58.WornCount = v58.WornCount + 1;
                    local v59 = CatalogUtilities.FormatNumber(OutfitDetails.WornCount);
                    statistics.worn.value.Text = v59 .. " time" .. (OutfitDetails.WornCount == 1 and "" or "s");
                    u28 = true;
                end;
            else
                Events.Notify:Fire("❌ Something went wrong. Please try again.");
            end;
        end);
        outfit.preview.viewport.MouseEnter:Connect(function() -- Line: 404
            -- upvalues: u26 (ref), Page (copy)
            if u26.Current.Page ~= Page then
                return;
            end;

            u26.SetAllScrollingFramesEnabled(false);
        end);
        outfit.preview.viewport.MouseLeave:Connect(function() -- Line: 411
            -- upvalues: u26 (ref)
            u26.SetAllScrollingFramesEnabled(true);
        end);

        if u26.Current and u26.Current.Objects then
            local Objects = u26.Current.Objects;
            local v60 = {
                Destroy = ScrollGuard.Attach(u40, outfit.scrollGuard, outfit.itemsSection.items, outfit.preview.viewport)
            };
            table.insert(Objects, v60);
            local u68 = PriceDisplay.OnChanged:Connect(function() -- Line: 420
                -- upvalues: container (copy), buySection (copy), u41 (copy), PriceDisplay (ref)
                local u61 = container;
                local u62 = buySection;
                local u63 = u41;
                table.insert(u63.threads, task.spawn(function() -- Line: 39
                    -- upvalues: u63 (copy), u62 (copy), PriceDisplay (ref), u61 (copy)
                    local success, result = pcall(function() -- Line: 40
                        -- upvalues: u63 (ref), u62 (ref), PriceDisplay (ref), u61 (ref)
                        if u63.activeChecks > 0 then
                            u62.price.Text = "Getting total price...";
                            PriceDisplay.UpdateUpsellButton(u62:FindFirstChild("robloxPlus"), 0, 0, 0);

                            return;
                        end;

                        local v65, v66, _, v67 = PriceDisplay.SumItemFrames(u61, function(p64) -- Line: 47
                            if p64:GetAttribute("isItem") then
                                return p64:GetAttribute("truePrice") or (tonumber(p64:GetAttribute("price")) or 0), p64:GetAttribute("bundleId");
                            end;

                            return nil;
                        end);
                        u62.price.Text = PriceDisplay.TotalPriceText(v65, v66, "Price: ");
                        PriceDisplay.UpdateUpsellButton(u62:FindFirstChild("robloxPlus"), v65, v66, v67);
                    end);

                    if success == false then
                        warn("error while setting total price: " .. tostring(result));
                    end;
                end));
            end);
            local u69 = PriceDisplay.WireUpsellButton(buySection:FindFirstChild("robloxPlus"));
            table.insert(u26.Current.Objects, {
                Destroy = function() -- Line: 425, Name: Destroy
                    -- upvalues: u68 (copy), u69 (copy), u41 (copy)
                    u68:Disconnect();

                    if u69 then
                        u69:Disconnect();
                    end;

                    for _, v in u41.threads do
                        pcall(task.cancel, v);
                    end;
                end
            });
        end;

        u40.Parent = Page;
        u40.Visible = true;
        u40.comments.Visible = false;
        u40.outfitsByCreator.Visible = false;
        task.spawn(function() -- Line: 442
            -- upvalues: Remotes (ref), OutfitDetails (copy)
            Remotes.CommunityOutfitsAction:InvokeServer("Interact", OutfitDetails.Id, "View");
        end);
        task.defer(function() -- Line: 447
            -- upvalues: u40 (copy), AvatarPreviewController (ref), outfit (copy), OutfitDetails (copy), u26 (ref), Page (copy)
            if u40.Parent == nil then
                return;
            end;

            local v70 = AvatarPreviewController.new(outfit.preview.viewport, OutfitDetails.HumanoidDescription, {
                AllowCameraAdjustment = true,
                AllowAnimations = true,
                Distance = -1,
                AccessoryAdjustments = OutfitDetails.AccessoryAdjustments,
                RigType = OutfitDetails.RigType,
                ScrollGuard = outfit.scrollGuard
            });

            if u26.Current and u26.Current.Page == Page then
                table.insert(u26.Current.Objects, v70);

                return;
            end;

            v70:Destroy();
        end);

        if u31 and #u31 > 0 then
            LoadingController.DisplayLoading(outfit.itemsSection, "overlay");

            while not u33 do
                task.wait();
            end;

            LoadingController.RemoveLoading();

            for _, v in u32 do
                if v.ItemType ~= "Bundle" then
                    local v71 = ItemButton.new({
                        IsFavoriteAvailable = true,
                        AvatarPreviewOnHover = true,
                        ItemData = v,
                        PurchaseContext = typeof(OutfitDetails.Id) == "string" and {
                            Type = "CommunityOutfit",
                            OutfitId = OutfitDetails.Id
                        } or nil
                    });
                    local Price = v.Price;

                    if typeof(Price) == "string" and (Price ~= "Free" and (v.AssetType ~= "MoodAnimation" and not CatalogUtilities.DefaultRobloxClothingIds[tonumber(v.Id)])) then
                        v71.price.Text = "· · ·";
                    end;

                    v71:SetAttribute("isItem", true);
                    v71:SetAttribute("price", v.Price);
                    v71:SetAttribute("itemType", v.ItemType);
                    v71:SetAttribute("assetType", v.AssetType);
                    v71.LayoutOrder = CatalogUtilities.GetLayoutOrderFromAssetType(v.AssetType, v.ItemType);
                    v71.Name = tostring(v.Id);
                    v71.Parent = container;
                end;
            end;

            u41.activeChecks = u41.activeChecks + 1;
            table.insert(u41.threads, task.spawn(function() -- Line: 39
                -- upvalues: u41 (copy), buySection (copy), PriceDisplay (ref), container (copy)
                local success, result = pcall(function() -- Line: 40
                    -- upvalues: u41 (ref), buySection (ref), PriceDisplay (ref), container (ref)
                    if u41.activeChecks > 0 then
                        buySection.price.Text = "Getting total price...";
                        PriceDisplay.UpdateUpsellButton(buySection:FindFirstChild("robloxPlus"), 0, 0, 0);

                        return;
                    end;

                    local v73, v74, _, v75 = PriceDisplay.SumItemFrames(container, function(p72) -- Line: 47
                        if p72:GetAttribute("isItem") then
                            return p72:GetAttribute("truePrice") or (tonumber(p72:GetAttribute("price")) or 0), p72:GetAttribute("bundleId");
                        end;

                        return nil;
                    end);
                    buySection.price.Text = PriceDisplay.TotalPriceText(v73, v74, "Price: ");
                    PriceDisplay.UpdateUpsellButton(buySection:FindFirstChild("robloxPlus"), v73, v74, v75);
                end);

                if success == false then
                    warn("error while setting total price: " .. tostring(result));
                end;
            end));
            TotalPriceResolver.Resolve(container, u32, {
                threads = u41.threads,

                onUpdate = function() -- Line: 505, Name: onUpdate
                    -- upvalues: container (copy), buySection (copy), u41 (copy), PriceDisplay (ref)
                    local u76 = container;
                    local u77 = buySection;
                    local u78 = u41;
                    table.insert(u78.threads, task.spawn(function() -- Line: 39
                        -- upvalues: u78 (copy), u77 (copy), PriceDisplay (ref), u76 (copy)
                        local success, result = pcall(function() -- Line: 40
                            -- upvalues: u78 (ref), u77 (ref), PriceDisplay (ref), u76 (ref)
                            if u78.activeChecks > 0 then
                                u77.price.Text = "Getting total price...";
                                PriceDisplay.UpdateUpsellButton(u77:FindFirstChild("robloxPlus"), 0, 0, 0);

                                return;
                            end;

                            local v80, v81, _, v82 = PriceDisplay.SumItemFrames(u76, function(p79) -- Line: 47
                                if p79:GetAttribute("isItem") then
                                    return p79:GetAttribute("truePrice") or (tonumber(p79:GetAttribute("price")) or 0), p79:GetAttribute("bundleId");
                                end;

                                return nil;
                            end);
                            u77.price.Text = PriceDisplay.TotalPriceText(v80, v81, "Price: ");
                            PriceDisplay.UpdateUpsellButton(u77:FindFirstChild("robloxPlus"), v80, v81, v82);
                        end);

                        if success == false then
                            warn("error while setting total price: " .. tostring(result));
                        end;
                    end));
                end,

                onComplete = function() -- Line: 508, Name: onComplete
                    -- upvalues: u41 (copy), container (copy), buySection (copy), PriceDisplay (ref), promptPurchase (ref), OutfitDetails (copy)
                    local v83 = u41;
                    v83.activeChecks = v83.activeChecks - 1;
                    local u84 = container;
                    local u85 = buySection;
                    local u86 = u41;
                    table.insert(u86.threads, task.spawn(function() -- Line: 39
                        -- upvalues: u86 (copy), u85 (copy), PriceDisplay (ref), u84 (copy)
                        local success, result = pcall(function() -- Line: 40
                            -- upvalues: u86 (ref), u85 (ref), PriceDisplay (ref), u84 (ref)
                            if u86.activeChecks > 0 then
                                u85.price.Text = "Getting total price...";
                                PriceDisplay.UpdateUpsellButton(u85:FindFirstChild("robloxPlus"), 0, 0, 0);

                                return;
                            end;

                            local v88, v89, _, v90 = PriceDisplay.SumItemFrames(u84, function(p87) -- Line: 47
                                if p87:GetAttribute("isItem") then
                                    return p87:GetAttribute("truePrice") or (tonumber(p87:GetAttribute("price")) or 0), p87:GetAttribute("bundleId");
                                end;

                                return nil;
                            end);
                            u85.price.Text = PriceDisplay.TotalPriceText(v88, v89, "Price: ");
                            PriceDisplay.UpdateUpsellButton(u85:FindFirstChild("robloxPlus"), v88, v89, v90);
                        end);

                        if success == false then
                            warn("error while setting total price: " .. tostring(result));
                        end;
                    end));

                    if u41.isWaitingToBuy then
                        u41.isWaitingToBuy = false;
                        promptPurchase(container, buySection, u41, OutfitDetails.Id);
                    end;
                end
            });
        else
            table.insert(u41.threads, task.spawn(function() -- Line: 39
                -- upvalues: u41 (copy), buySection (copy), PriceDisplay (ref), container (copy)
                local success, result = pcall(function() -- Line: 40
                    -- upvalues: u41 (ref), buySection (ref), PriceDisplay (ref), container (ref)
                    if u41.activeChecks > 0 then
                        buySection.price.Text = "Getting total price...";
                        PriceDisplay.UpdateUpsellButton(buySection:FindFirstChild("robloxPlus"), 0, 0, 0);

                        return;
                    end;

                    local v92, v93, _, v94 = PriceDisplay.SumItemFrames(container, function(p91) -- Line: 47
                        if p91:GetAttribute("isItem") then
                            return p91:GetAttribute("truePrice") or (tonumber(p91:GetAttribute("price")) or 0), p91:GetAttribute("bundleId");
                        end;

                        return nil;
                    end);
                    buySection.price.Text = PriceDisplay.TotalPriceText(v92, v93, "Price: ");
                    PriceDisplay.UpdateUpsellButton(buySection:FindFirstChild("robloxPlus"), v92, v93, v94);
                end);

                if success == false then
                    warn("error while setting total price: " .. tostring(result));
                end;
            end));
        end;

        buySection.buy.Activated:Connect(function() -- Line: 521
            -- upvalues: u41 (copy), TweenService (ref), buySection (copy), u3 (ref), ThemeController (ref), u2 (ref), promptPurchase (ref), container (copy), OutfitDetails (copy)
            if u41.isPurchasing then
                return;
            end;

            if u41.activeChecks <= 0 then
                promptPurchase(container, buySection, u41, OutfitDetails.Id);

                return;
            end;

            if u41.isWaitingToBuy then
                return;
            end;

            u41.isWaitingToBuy = true;
            TweenService:Create(buySection.buy, u3, {
                BackgroundColor3 = ThemeController.GetColor(u2)
            }):Play();
        end);
        buySection.save.Activated:Connect(function() -- Line: 532
            -- upvalues: u26 (ref), Events (ref), OutfitDetails (copy)
            u26.ClosePage();
            Events.DisplaySaveOutfit:Fire(false, OutfitDetails.HumanoidDescription, OutfitDetails.RigType, {
                CustomCallback = function() -- Line: 538, Name: CustomCallback
                    -- upvalues: Events (ref), OutfitDetails (ref)
                    Events.DisplayCommunityOutfits:Fire();
                    Events.DisplayContentPage:Fire({
                        Type = "CommunityOutfit",
                        OutfitDetails = OutfitDetails
                    });
                end
            });
        end);
        outfit:SetAttribute("isFavorited", (FavoriteController.IsOutfitFavorited("CommunityOutfit", OutfitDetails.Id)));
        FavoriteButton.OutlineFill({
            Button = outfit.preview.favorite,
            StateHolder = outfit,

            FavoriteAction = function(p95) -- Line: 555, Name: FavoriteAction
                -- upvalues: FavoriteController (ref), OutfitDetails (copy)
                return FavoriteController.SetOutfitFavorited("CommunityOutfit", OutfitDetails.Id, p95);
            end,

            TweenInfo = u3
        });
        outfit:GetAttributeChangedSignal("isFavorited"):Connect(function() -- Line: 561
            -- upvalues: outfit (copy), OutfitDetails (copy), statistics (copy), CatalogUtilities (ref)
            local v96 = outfit:GetAttribute("isFavorited") == true and 1 or -1;
            OutfitDetails.FavoriteCount = math.max(0, (OutfitDetails.FavoriteCount or 0) + v96);
            statistics.favorites.value.Text = CatalogUtilities.FormatNumber(OutfitDetails.FavoriteCount);
        end);
        local report = outfit.report;
        local u97 = false;
        local u98 = false;
        task.spawn(function() -- Line: 572
            -- upvalues: Remotes (ref), u97 (ref), u98 (ref), report (copy)
            local v99, v100 = Remotes.GetFlag:InvokeServer("IsContentModerator");
            local v101, v102 = Remotes.GetFlag:InvokeServer("IsTrialModerator");
            local v103;

            if v99 == true and v100 == true then
                v103 = true;
            elseif v101 == true then
                v103 = v102 == true;
            else
                v103 = false;
            end;

            u97 = v103;
            local v104;

            if v101 == true and v102 == true then
                local v105;

                if v99 == true then
                    v105 = v100 == true;
                else
                    v105 = false;
                end;

                v104 = not v105;
            else
                v104 = false;
            end;

            u98 = v104;

            if u97 then
                report.Text = "Moderate";
            end;
        end);
        report.MouseEnter:Connect(function() -- Line: 582
            -- upvalues: report (copy), u97 (ref)
            report.Text = u97 and "<u>Moderate</u>" or "<u>Report</u>";
        end);
        report.MouseLeave:Connect(function() -- Line: 586
            -- upvalues: report (copy), u97 (ref)
            report.Text = u97 and "Moderate" or "Report";
        end);
        report.Activated:Connect(function() -- Line: 590
            -- upvalues: u97 (ref), u98 (ref), Events (ref), OutfitDetails (copy), Remotes (ref)
            if not u97 then
                local v106 = Events.PromptInputDialog:Invoke({
                    Title = "Report Outfit",
                    Description = "Describe the issue to the best of your ability.\n\n<i>ⓘ Misusing the Reports system <b>will</b> result in punishment.</i>",
                    PlaceholderText = "Describe the issue",
                    YesText = "Submit"
                });

                if v106 ~= false then
                    local v107, v108 = Remotes.CommunityOutfitsAction:InvokeServer("ReportOutfit", OutfitDetails.Id, v106);

                    if v107 == true then
                        Events.Notify:Fire("✅ Thanking you for helping keep the community safe.");

                        return;
                    end;

                    Events.Notify:Fire("❌ Report failed. Issue: " .. tostring(v108));
                end;

                return;
            end;

            local v109 = { {
                    label = "Ban 1 Day"
                }, {
                    label = "Ban 3 Days"
                }, {
                    label = "Ban 7 Days"
                }, {
                    label = "Ban 30 Days"
                } };

            if not u98 then
                table.insert(v109, {
                    label = "Permanent Ban"
                });
            end;

            local v110 = Events.PromptChoice:Invoke({
                title = "Moderate Outfit",
                subtitle = "This removes the outfit and bans the creator for the chosen duration.",
                allowCustom = false,
                options = v109
            });

            if not v110 then
                return;
            end;

            local v111 = ({
                ["Ban 1 Day"] = "ban1Day",
                ["Ban 3 Days"] = "ban3Days",
                ["Ban 7 Days"] = "ban7Days",
                ["Ban 30 Days"] = "ban30Days",
                ["Permanent Ban"] = "permBan"
            })[v110.value];

            if not v111 then
                return;
            end;

            local v112 = Events.PromptChoice:Invoke({
                title = "Reason",
                subtitle = "Be concise and accurate. This is shown to the creator.",
                allowCustom = true,
                placeholder = "Type a custom reason…",
                options = { {
                        label = "Inappropriate or offensive content."
                    }, {
                        label = "Explicit or suggestive content."
                    }, {
                        label = "Violation of our content guidelines."
                    } }
            });

            if not v112 then
                return;
            end;

            if Events.PromptConfirmationDialog:Invoke({
                Title = "Confirm outfit moderation",
                YesText = "Moderate",
                NoText = "Cancel",
                Description = "This removes <b>" .. tostring(OutfitDetails.Name) .. "</b> and bans its creator (" .. v110.value .. ").\n\nReason: " .. v112.value
            }) ~= true then
                return;
            end;

            local v113, v114 = Remotes.CommunityOutfitsAction:InvokeServer("ModerateOutfit", "Ban", OutfitDetails.Id, v111, v112.value);

            if v113 == true then
                Events.Notify:Fire("✅ Outfit moderated.");

                return;
            end;

            Events.Notify:Fire("❌ Something went wrong: " .. tostring(v114));
        end);
        Events.AddTooltipToObject:Fire(report, "Report this outfit");
        local outfitsByCreator = u40.outfitsByCreator;

        while not u37 do
            task.wait();
        end;

        local v115 = u36;

        if v115 and typeof(v115) == "table" then
            for i, v in v115 do
                if v.Id == OutfitDetails.Id then
                    table.remove(v115, i);
                    break;
                end;
            end;
        end;

        if u35 and (v115 and #v115 > 0) then
            outfitsByCreator.label.Text = "Other outfits by " .. tostring(u29);
            outfitsByCreator.Visible = true;

            if #v115 > 0 then
                for _, child in outfitsByCreator.items:GetChildren() do
                    if child:IsA("Frame") then
                        child:Destroy();
                    end;
                end;

                CarouselScrollingFrame.new({
                    IncrementPercentage = 50,
                    ScrollingFrame = outfitsByCreator.items,
                    ScrollLeftButton = outfitsByCreator.scrollLeft,
                    ScrollRightButton = outfitsByCreator.scrollRight,
                    LeftFade = outfitsByCreator.leftFade,
                    RightFade = outfitsByCreator.rightFade
                });
                local v116 = {};

                for _, v in v115 do
                    table.insert(v116, v.Id);
                end;

                local _, v117 = FavoriteController.AreCommunityOutfitsFavorited(v116);
                local v118 = v117 or {};

                for _, v in v115 do
                    local v119, v120 = HumanoidDescriptionController.DeserializeHumanoidDescription(v.HumanoidDescription);
                    local v121, v122 = ItemButton.newOutfit({
                        OutfitType = "CommunityOutfit",
                        IsFavoriteAvailable = true,
                        SkeletonLoading = true,
                        NoPrice = true,
                        OutfitDetails = {
                            Name = v.Name,
                            Id = v.Id,
                            HumanoidDescription = v119,
                            CreatorId = v.CreatorId,
                            RigType = v120,
                            Created = v.Created,
                            Updated = v.Updated,
                            FavoriteCount = v.FavoriteCount or 0,
                            ShareCode = v.ShareCode,
                            ViewCount = v.ViewCount or 0,
                            WornCount = v.WornCount or 0,
                            IsFavorited = v118[v.Id]
                        }
                    });
                    v122.UpdateName(v.Name);
                    v121.Size = UDim2.fromScale(0.19, 0.78);
                    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
                    UIAspectRatioConstraint.AspectRatio = 0.9;
                    UIAspectRatioConstraint.Parent = v121;
                    v121.Parent = outfitsByCreator.items;
                end;
            end;
        end;

        table.insert(u26.Current.Threads, task.spawn(function() -- Line: 749
            -- upvalues: u40 (copy), OutfitDetails (copy), u26 (ref), Players (ref), TimeUtilities (ref), Remotes (ref), Events (ref)
            local comments = u40.comments;
            local container2 = comments.container;
            local loadMore = container2.loadMore;
            local inputContainer = container2.inputContainer;
            local CommentCount = OutfitDetails.CommentCount;
            local u123 = 0;
            comments.label.Text = `Comments ({CommentCount})`;

            local function setMessage(p124, p125) -- Line: 760
                -- upvalues: container2 (copy)
                local v126 = p125 == false;
                container2.inputContainer.Visible = v126;
                container2.loadMore.Visible = v126;
                container2.message.label.Text = p124;
                container2.message.Visible = true;
            end;

            local function openUserProfile(p127) -- Line: 769
                -- upvalues: u26 (ref)
                u26.DisplayPage({
                    Type = "UserProfile",
                    UserId = p127
                });
            end;

            local function loadComment(u128) -- Line: 776
                -- upvalues: Players (ref), TimeUtilities (ref), u26 (ref), container2 (copy)
                local u129 = script.comment:Clone();
                u129.author.Text = "Loading...";
                local u130 = "Loading...";
                task.spawn(function() -- Line: 781
                    -- upvalues: Players (ref), u128 (copy), u129 (copy), u130 (ref)
                    local success, result = pcall(function() -- Line: 782
                        -- upvalues: Players (ref), u128 (ref)
                        return Players:GetNameFromUserIdAsync(u128.AuthorId);
                    end);

                    if success and u129 ~= nil then
                        u130 = "@" .. result;
                    else
                        u130 = "@Unknown";
                    end;

                    u129.author.Text = u130;
                end);
                u129.date.Text = TimeUtilities.FormatCommentTime(u128.Created);
                u129.content.Text = u128.Content;
                u129.icon.Image = `rbxthumb://type=AvatarHeadShot&id={u128.AuthorId}&w=100&h=100`;
                u129.LayoutOrder = -(u128.Created - 1700000000);

                local function hover() -- Line: 798
                    -- upvalues: u129 (copy), u130 (ref)
                    u129.author.Text = "<u>" .. u130 .. "</u>";
                end;

                local function unhover() -- Line: 802
                    -- upvalues: u129 (copy), u130 (ref)
                    u129.author.Text = u130;
                end;

                u129.author.MouseEnter:Connect(hover);
                u129.author.MouseLeave:Connect(unhover);
                u129.icon.MouseEnter:Connect(hover);
                u129.icon.MouseLeave:Connect(unhover);
                u129.author.Activated:Connect(function() -- Line: 810
                    -- upvalues: u128 (copy), u26 (ref)
                    u26.DisplayPage({
                        Type = "UserProfile",
                        UserId = u128.AuthorId
                    });
                end);
                u129.Parent = container2;
            end;

            local function loadComments(p131) -- Line: 817
                -- upvalues: Remotes (ref), OutfitDetails (ref), u123 (ref), Events (ref), loadComment (copy), CommentCount (ref), container2 (copy), loadMore (copy)
                if p131 == nil or typeof(p131) ~= "table" then
                    local v132;
                    v132, p131 = Remotes.CommunityOutfitsAction:InvokeServer("GetComments", OutfitDetails.Id, 10, u123);

                    if v132 == false then
                        Events.Notify:Fire("⚠️ Something went wrong. Please try again.");

                        return;
                    end;
                end;

                for _, v in p131 do
                    loadComment(v);
                end;

                u123 = u123 + #p131;

                if CommentCount > u123 then
                    loadMore.Visible = true;

                    return;
                end;

                container2.inputContainer.Visible = true;
                container2.loadMore.Visible = true;
                container2.message.label.Text = "You\'ve reached the end of the comments.";
                container2.message.Visible = true;
                loadMore.Visible = false;
            end;

            local v133, v134 = Remotes.CommunityOutfitsAction:InvokeServer("GetComments", OutfitDetails.Id, 5, u123);
            comments.Visible = true;

            if v133 == false then
                container2.inputContainer.Visible = false;
                container2.loadMore.Visible = false;
                container2.message.label.Text = "Comments are not available for this outfit.";
                container2.message.Visible = true;
            else
                if #v134 > 0 then
                    loadComments(v134);
                else
                    container2.inputContainer.Visible = true;
                    container2.loadMore.Visible = true;
                    container2.message.label.Text = "There are no comments on this outfit yet. Be the first!";
                    container2.message.Visible = true;
                    loadMore.Visible = false;
                end;

                inputContainer.post.Activated:Connect(function() -- Line: 854
                    -- upvalues: inputContainer (copy), Events (ref), Remotes (ref), OutfitDetails (ref), loadComment (copy), Players (ref), CommentCount (ref), u123 (ref), container2 (copy)
                    local Text = inputContainer.wrapper.input.Text;

                    if #Text < 1 then
                        Events.Notify:Fire("⚠️ You can\'t comment nothing.");

                        return;
                    end;

                    local v135, v136 = Remotes.CommunityOutfitsAction:InvokeServer("PostComment", OutfitDetails.Id, Text);

                    if v135 ~= true then
                        if v136 and typeof(v136) == "string" then
                            if v136 == "cooldown" then
                                Events.Notify:Fire("⚠️ You are going too fast. Please wait and retry.");

                                return;
                            end;

                            Events.Notify:Fire("❌ Something went wrong.");
                            Events.Notify:Fire("Error: " .. tostring(v136));
                        end;

                        return;
                    end;

                    inputContainer.wrapper.input.Text = "";
                    Events.Notify:Fire("✅ Successfully posted comment!");
                    loadComment({
                        AuthorId = Players.LocalPlayer.UserId,
                        Content = Text,
                        Created = os.time()
                    });
                    CommentCount = CommentCount + 1;
                    u123 = u123 + 1;
                    container2.message.Visible = false;
                end);
            end;

            loadMore.button.Activated:Connect(function() -- Line: 890
                -- upvalues: loadComments (copy)
                loadComments(nil);
            end);
        end));
        LoadingController.RemoveLoading();
    end);

    if not success then
        warn("Failed to setup page:", result);
        LoadingController.RemoveLoading();
    end;

    return success, result;
end;

return v4;