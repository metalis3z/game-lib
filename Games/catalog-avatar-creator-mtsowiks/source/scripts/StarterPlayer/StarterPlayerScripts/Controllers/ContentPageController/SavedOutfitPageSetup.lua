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
local TimeUtilities = require(Modules.Shared.TimeUtilities);
local ItemPurchaseService = require(Modules.Services.ItemPurchaseService);
local ItemOwnershipService = require(Modules.Services.ItemOwnershipService);
local TotalPriceResolver = require(Modules.Services.TotalPriceResolver);
local PriceDisplay = require(Modules.Services.PriceDisplay);
local FavoriteController = require(Modules.Controllers.FavoriteController);
local FavoriteButton = require(Modules.Elements.FavoriteButton);
local SavedOutfitsController = require(Modules.Controllers.SavedOutfitsController);
local ScrollGuard = require(script.Parent.ScrollGuard);
local tag = script:WaitForChild("tag");
local u1 = {
    duplicateTag = "You can\'t have several groups with the same name.",
    emptyName = "Group name can\'t be empty.",
    maxTagsReached = "You\'ve reached the maximum number of groups.",
    invalidName = "Invalid group name.",
    tagNotFound = "That group doesn\'t exist.",
    invalidOutfitId = "Outfit not found.",
    invalidArgs = "Something went wrong. Please try again.",
    internalIssue = "Something went wrong. Please try again."
};
local Events = script.Parent.Parent.Parent:WaitForChild("Events");
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local LocalPlayer = Players.LocalPlayer;
local u2 = Color3.fromRGB(0, 216, 134);
local u3 = Color3.fromRGB(111, 111, 111);
local u4 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local Readable = require(Modules.Utilities.Readable);
local v5 = {};

local function updateSummary(u6, u7, u8) -- Line: 53
    -- upvalues: PriceDisplay (copy)
    table.insert(u8.threads, task.spawn(function() -- Line: 54
        -- upvalues: u8 (copy), u7 (copy), PriceDisplay (ref), u6 (copy)
        local success, result = pcall(function() -- Line: 55
            -- upvalues: u8 (ref), u7 (ref), PriceDisplay (ref), u6 (ref)
            if u8.activeChecks > 0 then
                u7.price.Text = "Getting total price...";
                PriceDisplay.UpdateUpsellButton(u7:FindFirstChild("robloxPlus"), 0, 0, 0);

                return;
            end;

            local v10, v11, _, v12 = PriceDisplay.SumItemFrames(u6, function(p9) -- Line: 62
                if p9:GetAttribute("isItem") then
                    return p9:GetAttribute("truePrice") or (tonumber(p9:GetAttribute("price")) or 0), p9:GetAttribute("bundleId");
                end;

                return nil;
            end);
            u7.price.Text = PriceDisplay.TotalPriceText(v10, v11, "Price: ");
            PriceDisplay.UpdateUpsellButton(u7:FindFirstChild("robloxPlus"), v10, v11, v12);
        end);

        if success == false then
            warn("error while setting total price: " .. tostring(result));
        end;
    end));
end;

local function promptPurchase(p13, p14, p15) -- Line: 77
    -- upvalues: ItemOwnershipService (copy), Events (copy), TweenService (copy), u4 (copy), ThemeController (copy), u3 (copy), ItemPurchaseService (copy), u2 (copy)
    local v16 = 0;
    local v17 = 0;
    local v18 = {};
    local v19 = {};

    for _, child in p13:GetChildren() do
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

    p15.isPurchasing = true;
    TweenService:Create(p14.buy, u4, {
        BackgroundColor3 = ThemeController.GetColor(u3)
    }):Play();
    ItemPurchaseService.PromptBulkPurchase(v19);
    p15.isPurchasing = false;
    TweenService:Create(p14.buy, u4, {
        BackgroundColor3 = ThemeController.GetColor(u2)
    }):Play();
end;

function v5.SetupPage(u26, u27) -- Line: 144
    -- upvalues: Readable (copy), LocalPlayer (copy), Events (copy), TimeUtilities (copy), Remotes (copy), HumanoidDescriptionController (copy), SavedOutfitsController (copy), tag (copy), TweenService (copy), u1 (copy), AvatarPreviewController (copy), ScrollGuard (copy), PriceDisplay (copy), CatalogUtilities (copy), LoadingController (copy), GetBatchItemDetails (copy), ItemButton (copy), TotalPriceResolver (copy), promptPurchase (copy), u4 (copy), ThemeController (copy), u3 (copy), FavoriteController (copy), FavoriteButton (copy)
    local success, result = pcall(function() -- Line: 145
        -- upvalues: u27 (copy), Readable (ref), LocalPlayer (ref), Events (ref), TimeUtilities (ref), Remotes (ref), u26 (copy), HumanoidDescriptionController (ref), SavedOutfitsController (ref), tag (ref), TweenService (ref), u1 (ref), AvatarPreviewController (ref), ScrollGuard (ref), PriceDisplay (ref), CatalogUtilities (ref), LoadingController (ref), GetBatchItemDetails (ref), ItemButton (ref), TotalPriceResolver (ref), promptPurchase (ref), u4 (ref), ThemeController (ref), u3 (ref), FavoriteController (ref), FavoriteButton (ref)
        local Page = u27.Page;
        local OutfitDetails = u27.OutfitDetails;
        OutfitDetails.Name = OutfitDetails.Name or "My Outfit";
        print("data:", OutfitDetails);
        local u28 = script.wrapper:Clone();
        u28.Visible = false;
        local outfit = u28.outfit;
        local bottomField = u28.bottomField;
        local actions = bottomField.actions;
        local container = outfit.itemsSection.items.container;
        local buySection = outfit.itemsSection.buySection;
        local u29 = {
            activeChecks = 0,
            isWaitingToBuy = false,
            isPurchasing = false,
            threads = {}
        };
        outfit.name.Text = OutfitDetails.Name;
        outfit.creator.Text = string.format(Readable.creator, LocalPlayer.DisplayName);
        outfit.creator.MouseEnter:Connect(function() -- Line: 170
            -- upvalues: outfit (copy), Readable (ref), LocalPlayer (ref)
            outfit.creator.Text = string.format(Readable.creatorHovered, LocalPlayer.DisplayName);
        end);
        outfit.creator.MouseLeave:Connect(function() -- Line: 174
            -- upvalues: outfit (copy), Readable (ref), LocalPlayer (ref)
            outfit.creator.Text = string.format(Readable.creator, LocalPlayer.DisplayName);
        end);
        Events.AddTooltipToObject:Fire(outfit.creator, "See creator\'s page", function() -- Line: 178
            -- upvalues: outfit (copy)
            return outfit.creator.TextBounds.X / 2 - outfit.creator.AbsoluteSize.X / 2;
        end);
        outfit.creator.Activated:Connect(function() -- Line: 184
            -- upvalues: Events (ref), LocalPlayer (ref)
            Events.DisplayContentPage:Fire({
                Type = "UserProfile",
                UserId = LocalPlayer.UserId
            });
        end);
        local v30 = DateTime.fromUnixTimestamp(OutfitDetails.Created):FormatLocalTime("MMM D, YYYY", "en-us");
        bottomField.created.value.Text = v30;
        bottomField.created.Active = true;
        Events.AddTooltipToObject:Fire(bottomField.created, TimeUtilities.FormatCommentTime(OutfitDetails.Created));

        if OutfitDetails.Updated then
            local v31 = DateTime.fromUnixTimestamp(OutfitDetails.Updated):FormatLocalTime("MMM D, YYYY", "en-us");
            bottomField.updated.value.Text = v31;
            bottomField.updated.Active = true;
            Events.AddTooltipToObject:Fire(bottomField.updated, TimeUtilities.FormatCommentTime(OutfitDetails.Updated));
        else
            bottomField.updated.value.Visible = false;
            bottomField.updated.title.Visible = false;
        end;

        actions.delete.Activated:Connect(function() -- Line: 206
            -- upvalues: Events (ref), OutfitDetails (copy), Remotes (ref), u26 (ref)
            if Events.PromptConfirmationDialog:Invoke({
                Title = "Delete Outfit",
                Description = "Are you sure you want to delete outfit \'<b>" .. OutfitDetails.Name .. "</b>\'?\n\n<b>You cannot undo this action.</b>"
            }) then
                Events.Notify:Fire("Deleting outfit \'<b>" .. OutfitDetails.Name .. "</b>\'..");
                local v32, v33 = Remotes.SavedOutfitAction:InvokeServer({
                    Action = "Delete",
                    Id = OutfitDetails.Id
                });

                if v32 then
                    Events.Notify:Fire("✅ Successfully deleted outfit \'<b>" .. OutfitDetails.Name .. "</b>\'.");
                    u26.ClosePage();

                    return;
                end;

                Events.Notify:Fire("❌ Something went wrong. Please try again.");
                Events.Notify:Fire("Error: " .. tostring(v33));
            end;
        end);
        actions.rename.Activated:Connect(function() -- Line: 224
            -- upvalues: Events (ref), OutfitDetails (copy), Remotes (ref), outfit (copy)
            local v34 = Events.PromptInputDialog:Invoke({
                Title = "Rename Outfit",
                Description = "What would you like to rename your outfit to?",
                NoText = "Cancel",
                YesText = "Rename",
                PlaceholderText = "Name"
            });

            if v34 == false then
                Events.Notify:Fire("❌ Cancelled outfit renaming.");

                return;
            end;

            Events.Notify:Fire("Renaming outfit \'<b>" .. OutfitDetails.Name .. "</b>\' to \'<b>" .. v34 .. "</b>\'..");
            local v35, v36 = Remotes.SavedOutfitAction:InvokeServer({
                Action = "Rename",
                Id = OutfitDetails.Id,
                Name = v34
            });

            if v35 ~= true then
                Events.Notify:Fire("❌ Failed to rename outfit.");
                Events.Notify:Fire("Error: " .. tostring(v36));

                return;
            end;

            Events.Notify:Fire("✅ Successfully renamed outfit \'<b>" .. OutfitDetails.Name .. "</b>\' to \'<b>" .. v34 .. "</b>\'!");
            OutfitDetails.Name = v34;
            outfit.name.Text = v34;
        end);
        actions.update.Activated:Connect(function() -- Line: 248
            -- upvalues: Events (ref), OutfitDetails (copy), Remotes (ref), HumanoidDescriptionController (ref), u26 (ref)
            if Events.PromptConfirmationDialog:Invoke({
                Title = "Update Outfit",
                Description = "Are you sure you want to update your outfit \'<b>" .. OutfitDetails.Name .. "</b>\' to your current outfit?\n\n<b>You cannot undo this action.</b>"
            }) then
                Events.Notify:Fire("Updating outfit \'<b>" .. OutfitDetails.Name .. "</b>\'..");
                local v37, v38 = Remotes.SavedOutfitAction:InvokeServer({
                    Action = "Update",
                    Id = OutfitDetails.Id
                });

                if v37 then
                    Events.Notify:Fire("✅ Successfully updated outfit \'<b>" .. OutfitDetails.Name .. "</b>\'!");
                    local v39, v40 = HumanoidDescriptionController.DeserializeHumanoidDescription(v38.HumanoidDescription);
                    v38.HumanoidDescription = v39;
                    v38.RigType = v40;
                    u26.ClosePage();
                    Events.DisplayContentPage:Fire({
                        Type = "SavedOutfit",
                        OutfitDetails = v38
                    });

                    return;
                end;

                Events.Notify:Fire("❌ Failed to update outfit.");
                Events.Notify:Fire("Error: " .. tostring(v38));
            end;
        end);
        actions.publish.Activated:Connect(function() -- Line: 276
            -- upvalues: u28 (copy), Events (ref), OutfitDetails (copy)
            u28.Parent.Visible = false;
            Events.DisplayPublishOutfit:Fire(false, function() -- Line: 278
                -- upvalues: u28 (ref)
                u28.Parent.Visible = true;
            end, {
                Source = "SavedOutfit",
                HumanoidDescription = OutfitDetails.HumanoidDescription,
                RigType = OutfitDetails.RigType,
                Info = {
                    OutfitId = OutfitDetails.Id
                }
            });
        end);
        local tags = u28.layoutBypass.tags;
        local container2 = tags.container;
        local u41 = OutfitDetails.Tags or {};
        local u42 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);

        local function refreshTagsList() -- Line: 298
            -- upvalues: container2 (copy), SavedOutfitsController (ref), u41 (copy), tag (ref), Remotes (ref), OutfitDetails (copy), TweenService (ref), u42 (copy)
            for _, child in container2:GetChildren() do
                if child:IsA("TextButton") then
                    child:Destroy();
                end;
            end;

            for i, v in SavedOutfitsController.SavedOutfitsData and SavedOutfitsController.SavedOutfitsData.Tags or {} do
                local v43 = false;

                for _, v2 in u41 do
                    if v2 == v then
                        v43 = true;
                        break;
                    end;
                end;

                local v44 = tag:Clone();
                v44.Name = v;
                v44.LayoutOrder = i;
                v44.tagName.Text = v;
                local checked = v44.checkbox.back.checked;
                checked.ImageTransparency = v43 and 0 or 1;
                v44.Activated:Connect(function() -- Line: 324
                    -- upvalues: checked (copy), Remotes (ref), OutfitDetails (ref), v (copy), TweenService (ref), u42 (ref), u41 (ref)
                    if checked.ImageTransparency < 0.5 then
                        if Remotes.SavedOutfitAction:InvokeServer({
                            Action = "UntagOutfit",
                            Id = OutfitDetails.Id,
                            Tag = v
                        }) then
                            TweenService:Create(checked, u42, {
                                ImageTransparency = 1
                            }):Play();

                            for i2 = #u41, 1, -1 do
                                if u41[i2] == v then
                                    table.remove(u41, i2);
                                end;
                            end;
                        end;
                    elseif Remotes.SavedOutfitAction:InvokeServer({
                        Action = "TagOutfit",
                        Id = OutfitDetails.Id,
                        Tag = v
                    }) then
                        TweenService:Create(checked, u42, {
                            ImageTransparency = 0
                        }):Play();
                        table.insert(u41, v);
                    end;
                end);
                v44.Visible = true;
                v44.Parent = container2;
            end;
        end;

        local function positionTagsContainer() -- Line: 350
            -- upvalues: actions (copy), tags (copy), u28 (copy)
            local AbsolutePosition = actions.tags.AbsolutePosition;
            local AbsoluteSize = tags.AbsoluteSize;
            local AbsolutePosition2 = u28.AbsolutePosition;
            local AbsoluteSize2 = u28.AbsoluteSize;
            local CanvasPosition = u28.CanvasPosition;
            local v45 = AbsolutePosition.Y - AbsoluteSize.Y - AbsoluteSize2.Y * 0.004 - AbsolutePosition2.Y + CanvasPosition.Y;
            local v46 = AbsoluteSize2.X * 0.0075;
            local v47 = math.clamp(AbsolutePosition.X + actions.tags.AbsoluteSize.X / 2 - AbsoluteSize.X / 2 - AbsolutePosition2.X + CanvasPosition.X, v46, AbsoluteSize2.X - AbsoluteSize.X - v46);
            local v48 = math.max(v45, CanvasPosition.Y);
            tags.Position = UDim2.fromOffset(v47, v48);
        end;

        actions.tags:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() -- Line: 374
            -- upvalues: tags (copy), positionTagsContainer (copy)
            if tags.Visible then
                positionTagsContainer();
            end;
        end);
        actions.tags.Activated:Connect(function() -- Line: 380
            -- upvalues: tags (copy), refreshTagsList (copy), positionTagsContainer (copy)
            tags.Visible = not tags.Visible;

            if tags.Visible then
                refreshTagsList();
                positionTagsContainer();
            end;
        end);
        tags.createTag.Activated:Connect(function() -- Line: 388
            -- upvalues: Events (ref), Remotes (ref), refreshTagsList (copy), u1 (ref)
            local v49 = Events.PromptInputDialog:Invoke({
                Title = "Create Group",
                Description = "What would you like to name your new group?",
                NoText = "Cancel",
                YesText = "Create",
                PlaceholderText = "Group name"
            });

            if v49 and v49 ~= false then
                local v50, v51 = Remotes.SavedOutfitAction:InvokeServer({
                    Action = "CreateTag",
                    Name = v49
                });

                if v50 then
                    task.wait();
                    refreshTagsList();

                    return;
                end;

                Events.Notify:Fire("❌ " .. (u1[v51] or "Failed to create group."));
            end;
        end);
        outfit.preview.tryOn.Activated:Connect(function() -- Line: 407
            -- upvalues: Remotes (ref), OutfitDetails (copy), Events (ref)
            local v52, _ = Remotes.TryOnSavedOutfit:InvokeServer(OutfitDetails.Id);

            if v52 then
                Events.Notify:Fire("✅ Successfully wore outfit \'<b>" .. OutfitDetails.Name .. "</b>\'!");

                return;
            end;

            Events.Notify:Fire("❌ Something went wrong. Please try again.");
        end);
        outfit.preview.viewport.MouseEnter:Connect(function() -- Line: 416
            -- upvalues: u26 (ref), Page (copy)
            if u26.Current.Page ~= Page then
                return;
            end;

            u26.SetAllScrollingFramesEnabled(false);
        end);
        outfit.preview.viewport.MouseLeave:Connect(function() -- Line: 423
            -- upvalues: u26 (ref)
            u26.SetAllScrollingFramesEnabled(true);
        end);
        local v53 = AvatarPreviewController.new(outfit.preview.viewport, OutfitDetails.HumanoidDescription, {
            AllowCameraAdjustment = true,
            AllowAnimations = true,
            AccessoryAdjustments = OutfitDetails.AccessoryAdjustments,
            RigType = OutfitDetails.RigType,
            ScrollGuard = outfit.scrollGuard
        });

        if u26.Current and u26.Current.Objects then
            table.insert(u26.Current.Objects, v53);
            local Objects = u26.Current.Objects;
            local v54 = {
                Destroy = ScrollGuard.Attach(u28, outfit.scrollGuard, outfit.itemsSection.items, outfit.preview.viewport)
            };
            table.insert(Objects, v54);
            local u62 = PriceDisplay.OnChanged:Connect(function() -- Line: 440
                -- upvalues: container (copy), buySection (copy), u29 (copy), PriceDisplay (ref)
                local u55 = container;
                local u56 = buySection;
                local u57 = u29;
                table.insert(u57.threads, task.spawn(function() -- Line: 54
                    -- upvalues: u57 (copy), u56 (copy), PriceDisplay (ref), u55 (copy)
                    local success, result = pcall(function() -- Line: 55
                        -- upvalues: u57 (ref), u56 (ref), PriceDisplay (ref), u55 (ref)
                        if u57.activeChecks > 0 then
                            u56.price.Text = "Getting total price...";
                            PriceDisplay.UpdateUpsellButton(u56:FindFirstChild("robloxPlus"), 0, 0, 0);

                            return;
                        end;

                        local v59, v60, _, v61 = PriceDisplay.SumItemFrames(u55, function(p58) -- Line: 62
                            if p58:GetAttribute("isItem") then
                                return p58:GetAttribute("truePrice") or (tonumber(p58:GetAttribute("price")) or 0), p58:GetAttribute("bundleId");
                            end;

                            return nil;
                        end);
                        u56.price.Text = PriceDisplay.TotalPriceText(v59, v60, "Price: ");
                        PriceDisplay.UpdateUpsellButton(u56:FindFirstChild("robloxPlus"), v59, v60, v61);
                    end);

                    if success == false then
                        warn("error while setting total price: " .. tostring(result));
                    end;
                end));
            end);
            local u63 = PriceDisplay.WireUpsellButton(buySection:FindFirstChild("robloxPlus"));
            table.insert(u26.Current.Objects, {
                Destroy = function() -- Line: 445, Name: Destroy
                    -- upvalues: u62 (copy), u63 (copy), u29 (copy)
                    u62:Disconnect();

                    if u63 then
                        u63:Disconnect();
                    end;

                    for _, v in u29.threads do
                        pcall(task.cancel, v);
                    end;
                end
            });
        end;

        local v64 = CatalogUtilities.GetEquippedAssetIdsFromDescription(OutfitDetails.HumanoidDescription);

        if v64 and #v64 > 0 then
            local v65 = {};

            for _, v in v64 do
                v65[tostring(v.AssetId)] = {
                    ItemType = v.ItemType
                };
            end;

            LoadingController.DisplayLoading(outfit.itemsSection, "overlay");
            local v66 = GetBatchItemDetails(v65);
            LoadingController.RemoveLoading();

            for _, v in v66 do
                if v.ItemType ~= "Bundle" then
                    local v67 = ItemButton.new({
                        IsFavoriteAvailable = true,
                        AvatarPreviewOnHover = true,
                        ItemData = v
                    });
                    local Price = v.Price;

                    if typeof(Price) == "string" and (Price ~= "Free" and (v.AssetType ~= "MoodAnimation" and not CatalogUtilities.DefaultRobloxClothingIds[tonumber(v.Id)])) then
                        v67.price.Text = "· · ·";
                    end;

                    v67:SetAttribute("isItem", true);
                    v67:SetAttribute("price", v.Price);
                    v67:SetAttribute("itemType", v.ItemType);
                    v67:SetAttribute("assetType", v.AssetType);
                    v67.LayoutOrder = CatalogUtilities.GetLayoutOrderFromAssetType(v.AssetType, v.ItemType);
                    v67.Name = tostring(v.Id);
                    v67.Parent = container;
                end;
            end;

            u29.activeChecks = u29.activeChecks + 1;
            table.insert(u29.threads, task.spawn(function() -- Line: 54
                -- upvalues: u29 (copy), buySection (copy), PriceDisplay (ref), container (copy)
                local success, result = pcall(function() -- Line: 55
                    -- upvalues: u29 (ref), buySection (ref), PriceDisplay (ref), container (ref)
                    if u29.activeChecks > 0 then
                        buySection.price.Text = "Getting total price...";
                        PriceDisplay.UpdateUpsellButton(buySection:FindFirstChild("robloxPlus"), 0, 0, 0);

                        return;
                    end;

                    local v69, v70, _, v71 = PriceDisplay.SumItemFrames(container, function(p68) -- Line: 62
                        if p68:GetAttribute("isItem") then
                            return p68:GetAttribute("truePrice") or (tonumber(p68:GetAttribute("price")) or 0), p68:GetAttribute("bundleId");
                        end;

                        return nil;
                    end);
                    buySection.price.Text = PriceDisplay.TotalPriceText(v69, v70, "Price: ");
                    PriceDisplay.UpdateUpsellButton(buySection:FindFirstChild("robloxPlus"), v69, v70, v71);
                end);

                if success == false then
                    warn("error while setting total price: " .. tostring(result));
                end;
            end));
            TotalPriceResolver.Resolve(container, v66, {
                threads = u29.threads,

                onUpdate = function() -- Line: 499, Name: onUpdate
                    -- upvalues: container (copy), buySection (copy), u29 (copy), PriceDisplay (ref)
                    local u72 = container;
                    local u73 = buySection;
                    local u74 = u29;
                    table.insert(u74.threads, task.spawn(function() -- Line: 54
                        -- upvalues: u74 (copy), u73 (copy), PriceDisplay (ref), u72 (copy)
                        local success, result = pcall(function() -- Line: 55
                            -- upvalues: u74 (ref), u73 (ref), PriceDisplay (ref), u72 (ref)
                            if u74.activeChecks > 0 then
                                u73.price.Text = "Getting total price...";
                                PriceDisplay.UpdateUpsellButton(u73:FindFirstChild("robloxPlus"), 0, 0, 0);

                                return;
                            end;

                            local v76, v77, _, v78 = PriceDisplay.SumItemFrames(u72, function(p75) -- Line: 62
                                if p75:GetAttribute("isItem") then
                                    return p75:GetAttribute("truePrice") or (tonumber(p75:GetAttribute("price")) or 0), p75:GetAttribute("bundleId");
                                end;

                                return nil;
                            end);
                            u73.price.Text = PriceDisplay.TotalPriceText(v76, v77, "Price: ");
                            PriceDisplay.UpdateUpsellButton(u73:FindFirstChild("robloxPlus"), v76, v77, v78);
                        end);

                        if success == false then
                            warn("error while setting total price: " .. tostring(result));
                        end;
                    end));
                end,

                onComplete = function() -- Line: 502, Name: onComplete
                    -- upvalues: u29 (copy), container (copy), buySection (copy), PriceDisplay (ref), promptPurchase (ref)
                    local v79 = u29;
                    v79.activeChecks = v79.activeChecks - 1;
                    local u80 = container;
                    local u81 = buySection;
                    local u82 = u29;
                    table.insert(u82.threads, task.spawn(function() -- Line: 54
                        -- upvalues: u82 (copy), u81 (copy), PriceDisplay (ref), u80 (copy)
                        local success, result = pcall(function() -- Line: 55
                            -- upvalues: u82 (ref), u81 (ref), PriceDisplay (ref), u80 (ref)
                            if u82.activeChecks > 0 then
                                u81.price.Text = "Getting total price...";
                                PriceDisplay.UpdateUpsellButton(u81:FindFirstChild("robloxPlus"), 0, 0, 0);

                                return;
                            end;

                            local v84, v85, _, v86 = PriceDisplay.SumItemFrames(u80, function(p83) -- Line: 62
                                if p83:GetAttribute("isItem") then
                                    return p83:GetAttribute("truePrice") or (tonumber(p83:GetAttribute("price")) or 0), p83:GetAttribute("bundleId");
                                end;

                                return nil;
                            end);
                            u81.price.Text = PriceDisplay.TotalPriceText(v84, v85, "Price: ");
                            PriceDisplay.UpdateUpsellButton(u81:FindFirstChild("robloxPlus"), v84, v85, v86);
                        end);

                        if success == false then
                            warn("error while setting total price: " .. tostring(result));
                        end;
                    end));

                    if u29.isWaitingToBuy then
                        u29.isWaitingToBuy = false;
                        promptPurchase(container, buySection, u29);
                    end;
                end
            });
        else
            table.insert(u29.threads, task.spawn(function() -- Line: 54
                -- upvalues: u29 (copy), buySection (copy), PriceDisplay (ref), container (copy)
                local success, result = pcall(function() -- Line: 55
                    -- upvalues: u29 (ref), buySection (ref), PriceDisplay (ref), container (ref)
                    if u29.activeChecks > 0 then
                        buySection.price.Text = "Getting total price...";
                        PriceDisplay.UpdateUpsellButton(buySection:FindFirstChild("robloxPlus"), 0, 0, 0);

                        return;
                    end;

                    local v88, v89, _, v90 = PriceDisplay.SumItemFrames(container, function(p87) -- Line: 62
                        if p87:GetAttribute("isItem") then
                            return p87:GetAttribute("truePrice") or (tonumber(p87:GetAttribute("price")) or 0), p87:GetAttribute("bundleId");
                        end;

                        return nil;
                    end);
                    buySection.price.Text = PriceDisplay.TotalPriceText(v88, v89, "Price: ");
                    PriceDisplay.UpdateUpsellButton(buySection:FindFirstChild("robloxPlus"), v88, v89, v90);
                end);

                if success == false then
                    warn("error while setting total price: " .. tostring(result));
                end;
            end));
        end;

        buySection.buy.Activated:Connect(function() -- Line: 515
            -- upvalues: u29 (copy), TweenService (ref), buySection (copy), u4 (ref), ThemeController (ref), u3 (ref), promptPurchase (ref), container (copy)
            if u29.isPurchasing then
                return;
            end;

            if u29.activeChecks <= 0 then
                promptPurchase(container, buySection, u29);

                return;
            end;

            if u29.isWaitingToBuy then
                return;
            end;

            u29.isWaitingToBuy = true;
            TweenService:Create(buySection.buy, u4, {
                BackgroundColor3 = ThemeController.GetColor(u3)
            }):Play();
        end);
        buySection.save.Activated:Connect(function() -- Line: 526
            -- upvalues: u26 (ref), Events (ref), OutfitDetails (copy)
            u26.ClosePage();
            Events.DisplaySaveOutfit:Fire(false, OutfitDetails.HumanoidDescription, OutfitDetails.RigType, {
                CustomCallback = function() -- Line: 532, Name: CustomCallback
                    -- upvalues: Events (ref), OutfitDetails (ref)
                    Events.DisplaySavedOutfits:Fire();
                    Events.DisplayContentPage:Fire({
                        Type = "SavedOutfit",
                        OutfitDetails = OutfitDetails
                    });
                end
            });
        end);
        outfit:SetAttribute("isFavorited", (FavoriteController.IsOutfitFavorited("SavedOutfit", OutfitDetails.Id)));
        FavoriteButton.OutlineFill({
            Button = outfit.preview.favorite,
            StateHolder = outfit,

            FavoriteAction = function(p91) -- Line: 549, Name: FavoriteAction
                -- upvalues: FavoriteController (ref), OutfitDetails (copy)
                return FavoriteController.SetOutfitFavorited("SavedOutfit", OutfitDetails.Id, p91);
            end,

            TweenInfo = u4
        });
        LoadingController.RemoveLoading();
        u28.Parent = Page;
        u28.Visible = true;
    end);

    if not success then
        warn("Failed to setup page:", result);
        LoadingController.RemoveLoading();
    end;

    return success, result;
end;

return v5;