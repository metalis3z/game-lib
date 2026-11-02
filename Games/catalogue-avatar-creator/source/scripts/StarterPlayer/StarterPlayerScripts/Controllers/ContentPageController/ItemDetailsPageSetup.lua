-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AvatarEditorService = game:GetService("AvatarEditorService");
local TweenService = game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local Modules = require(script.Parent.Parent.Parent.Modules);
require(Modules.Controllers.ThemeController);
local TimeUtilities = require(Modules.Shared.TimeUtilities);
local CatalogUtilities = require(Modules.Shared.CatalogUtilities);
local Cache = require(Modules.Services.Cache);
local ItemButton = require(Modules.Elements.ItemButton);
local LoadingController = require(Modules.Controllers.LoadingController);
require(Modules.Utilities.OutsideClickDetector);
local FavoriteController = require(Modules.Controllers.FavoriteController);
local FavoriteButton = require(Modules.Elements.FavoriteButton);
local CarouselScrollingFrame = require(Modules.Elements.CarouselScrollingFrame);
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local AvatarPreviewController = require(Modules.Controllers.AvatarPreviewController);
local ItemPreviewService = require(Modules.Services.ItemPreviewService);
local CatalogController = require(Modules.Controllers.CatalogController);
local RecentController = require(Modules.Controllers.RecentController);
local ProfileBackgroundController = require(Modules.Controllers.ProfileBackgroundController);
local PriceDisplay = require(Modules.Services.PriceDisplay);
local ItemPurchaseService = require(Modules.Services.ItemPurchaseService);
local Events = script.Parent.Parent.Parent:WaitForChild("Events");
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local LocalPlayer = Players.LocalPlayer;
LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ContentPage"):WaitForChild("overlay");
script:WaitForChild("priceLimited");
local Readable = require(Modules.Utilities.Readable);
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local v2 = {};

local function addSpaceBeforeCaps(p3) -- Line: 48
    local v4, _ = string.gsub(p3, "(%l)(%u)", "%1 %2");

    return v4;
end;

local function setupItemsList(p5, p6, p7) -- Line: 53
    -- upvalues: CatalogUtilities (copy), ItemButton (copy), CarouselScrollingFrame (copy)
    for _, child in p5.items:GetChildren() do
        if child:GetAttribute("isItem") then
            child:Destroy();
        end;
    end;

    for _, v in p6 do
        v.ItemType = p7.ItemType;

        if v.ItemType == "Bundle" then
            v.BundleType = p7.AssetType;
        else
            v.AssetType = p7.AssetType;
        end;

        if p7.AssetType == "getFromList" then
            local v8 = CatalogUtilities.HumanoidDescriptionAcceptedAssetTypes[v.AssetTypeName];
            v.AssetType = v8;

            if p7.Name then
                local Name = p7.Name;
                local v9, _ = string.gsub(v.AssetType, "(%l)(%u)", "%1 %2");
                v.Name = Name .. " · " .. v9;
            end;

            if p7.CreatorName then
                if v8 == "MoodAnimation" then
                    v.CreatorName = "Roblox";
                    v.CreatorHasVerifiedBadge = true;
                    v.Name = "Mood Animation";
                else
                    v.CreatorName = p7.CreatorName;
                    v.CreatorHasVerifiedBadge = p7.CreatorHasVerifiedBadge;
                end;
            end;
        end;

        v.IsLackingDetails = true;
        local v10 = ItemButton.new({
            IsDetailsPageItem = true,
            AvatarPreviewOnHover = true,
            IsLackingDetails = true,
            AddEquippedOverlay = true,
            IsFavoriteAvailable = true,
            ItemDetails = v
        });

        if p7.ListType == "included" then
            v10.creator:Destroy();
            v10.name.Size = UDim2.fromScale(0.95, 0.14);
        end;

        v10.Parent = p5.items;
    end;

    CarouselScrollingFrame.new({
        IncrementPercentage = 50,
        ScrollingFrame = p5.items,
        ScrollLeftButton = p5.scrollLeft,
        ScrollRightButton = p5.scrollRight,
        LeftFade = p5.leftFade,
        RightFade = p5.rightFade
    });
end;

function v2.SetupPage(u11, u12) -- Line: 118
    -- upvalues: AvatarEditorService (copy), Cache (copy), CatalogUtilities (copy), Remotes (copy), FavoriteController (copy), LoadingController (copy), ProfileBackgroundController (copy), HumanoidDescriptionController (copy), Events (copy), setupItemsList (copy), FavoriteButton (copy), u1 (copy), CollectionService (copy), TimeUtilities (copy), PriceDisplay (copy), ItemPurchaseService (copy), Readable (copy), TweenService (copy), RecentController (copy), LocalPlayer (copy), ItemPreviewService (copy), AvatarPreviewController (copy), CatalogController (copy)
    local success, result = pcall(function() -- Line: 119
        -- upvalues: u12 (copy), AvatarEditorService (ref), Cache (ref), CatalogUtilities (ref), Remotes (ref), FavoriteController (ref), LoadingController (ref), ProfileBackgroundController (ref), HumanoidDescriptionController (ref), Events (ref), setupItemsList (ref), FavoriteButton (ref), u1 (ref), CollectionService (ref), TimeUtilities (ref), PriceDisplay (ref), ItemPurchaseService (ref), u11 (copy), Readable (ref), TweenService (ref), RecentController (ref), LocalPlayer (ref), ItemPreviewService (ref), AvatarPreviewController (ref), CatalogController (ref)
        local Page = u12.Page;
        local Item = u12.Item;
        local PurchaseContext = u12.PurchaseContext;
        local v13 = script.wrapper:Clone();
        local item = v13.item;
        local preview = item.preview;
        local details = item.details;
        local favorite = item.favorite;
        v13.Visible = false;

        if Item.Id == nil then
            error("cant display " .. tostring(Item) .. " as it has no id");

            return;
        end;

        if Item.IsLackingDetails == true then
            local v14, v15;

            repeat
                v14, v15 = pcall(function() -- Line: 142
                    -- upvalues: AvatarEditorService (ref), Item (ref)
                    return AvatarEditorService:GetItemDetailsAsync(Item.Id, Enum.AvatarItemType:FromName(Item.ItemType));
                end);

                if not v14 then
                    task.wait(1);
                end;
            until v14;

            if v14 and (typeof(v15) == "table" and (v15 and v15.Id ~= nil)) then
                local v16 = tostring(v15.Id);
                Cache.Set("ItemDetails", v16, v15, 3600);
                print("getitemdata", v15);
                local v17 = CatalogUtilities.GetItemData(v15);

                if Item.CreatedDate then
                    v17.CreatedDate = Item.CreatedDate;
                end;

                Item = v17;
            end;
        end;

        local v18;

        if Item.AssetType == "AvatarBackground" then
            v18 = nil;
        else
            local v19;
            v19, v18 = Remotes.GetRecommendedAssets:InvokeServer(Item.Id, Item.ItemType, Item.AssetType);

            if v19 == false then
                warn("couldn\'t get recommended assets for", Item.Id, Item.ItemType, Item.AssetType, v18);
                v18 = nil;
            end;
        end;

        local v20, v21 = FavoriteController.GetFavorites();

        if v20 then
            v20 = v21[tostring(Item.Id)] ~= nil;
        end;

        Page:SetAttribute("isFavorited", v20);
        local v22 = nil;
        local v23 = nil;

        if Item.ItemType == "Bundle" then
            local v24, v25 = Remotes.GetBundleDetails:InvokeServer(Item.Id);
            v23 = v25;
            print("bundledetails:", v23);

            if v24 then
                v22 = v23.BundleType;
            end;
        elseif Item.AssetType == "AvatarBackground" then
            v22 = "Background";
        else
            v22 = Item.AssetType;
        end;

        LoadingController.RemoveLoading();
        v13.Parent = Page;
        v13.Visible = true;
        print("display item", Item);
        local u26 = Item.AssetType == "AvatarBackground";

        local function isItemEquipped() -- Line: 199
            -- upvalues: u26 (copy), ProfileBackgroundController (ref), Item (ref), HumanoidDescriptionController (ref)
            if u26 then
                return ProfileBackgroundController.IsEquipped(Item.Id);
            end;

            local v27 = HumanoidDescriptionController.EquippedDict and HumanoidDescriptionController.EquippedDict[tostring(Item.Id)] ~= nil;

            return v27;
        end;

        local u28 = Events.IsItemInCart:Invoke((tostring(Item.Id)));
        local v29 = Item.AssetType or Item.BundleType;

        if v18 == nil then
            print("no recommended assets");
            v13.recommendations:Destroy();
        else
            print("recommended assets:", v18);
            setupItemsList(v13.recommendations, v18, {
                ListType = "recommended",
                AssetType = v29,
                ItemType = Item.ItemType,
                Name = Item.Name
            });
        end;

        if Item.ItemType == "Bundle" then
            local v30;

            if v23 then
                v30 = v23.Items;
            else
                v30 = nil;
            end;

            if v30 then
                setupItemsList(v13.includedItems, v30, {
                    AssetType = "getFromList",
                    ItemType = "Asset",
                    ListType = "included",
                    Name = Item.Name,
                    CreatorName = Item.CreatorName,
                    CreatorHasVerifiedBadge = Item.IsVerifiedCreator
                });
            else
                v13.includedItems:Destroy();
            end;
        else
            v13.includedItems:Destroy();
        end;

        v13.mentionedItems:Destroy();
        local RestrictionIcon = Item.RestrictionIcon;

        if RestrictionIcon then
            preview.restriction.Image = RestrictionIcon;
        else
            preview.restriction:Destroy();
        end;

        FavoriteButton.Icon({
            Container = favorite,
            Icon = favorite:FindFirstChild("icon"),
            StateHolder = Page,

            FavoriteAction = function(p31) -- Line: 259, Name: FavoriteAction
                -- upvalues: FavoriteController (ref), Item (ref)
                return FavoriteController.SetFavorited(Item, p31);
            end,

            TweenInfo = u1
        });
        local v32;

        if u26 then
            v32 = ProfileBackgroundController.IsEquipped(Item.Id);
        else
            v32 = HumanoidDescriptionController.EquippedDict and HumanoidDescriptionController.EquippedDict[tostring(Item.Id)] ~= nil;
        end;

        if v32 == true then
            preview.tryOn.label.Text = "Take Off";
        end;

        item.name.Text = Item.Name;
        details.description.valueContainer.value.Text = (Item.Description == nil or Item.Description == "") and "<i>No description available.</i>" or Item.Description;
        CollectionService:AddTag(details.description.valueContainer.value, "ScaledTextSizeMultiLine");

        if Item.CreatedDate == nil then
            details.created:Destroy();
        else
            local v33 = TimeUtilities.GetRelativeTimeString(DateTime.fromIsoDate(Item.CreatedDate));
            details.created.value.Text = v33;
        end;

        if Item.Thumbnail then
            preview.image.Image = Item.Thumbnail;
        end;

        for _, child in details.price:GetChildren() do
            if child:IsA("GuiObject") then
                child.Visible = false;
            end;
        end;

        if Item.Price then
            print("price:", Item.Price, (typeof(Item.Price)));
            details.price.priceAmount.Text = "";

            if typeof(Item.Price) == "number" then
                if Item.RestrictionType ~= nil and Item.StockString ~= nil then
                    details.price:Destroy();
                    local v34 = script.priceLimited:Clone();
                    v34.Name = "price";
                    v34.stockRemaining.Text = Item.StockString;
                    v34.Parent = details;
                end;

                PriceDisplay.RegisterItemLabel(details.price.priceAmount, function() -- Line: 306
                    -- upvalues: Item (ref)
                    return Item.Price;
                end);
                details.price.buy.Activated:Connect(function() -- Line: 308
                    -- upvalues: ItemPurchaseService (ref), Item (ref), PurchaseContext (copy)
                    ItemPurchaseService.PromptItemPurchase(Item, PurchaseContext);
                end);
            elseif typeof(Item.Price) == "string" then
                if Item.Price == "Offsale" then
                    local function setupNormalOffsale() -- Line: 313
                        -- upvalues: details (copy)
                        details.price:Destroy();
                        local v35 = script.priceOffsale:Clone();
                        v35.Name = "price";
                        v35.Parent = details;
                    end;

                    if Item.ItemType == "Bundle" or Item.AssetType and Item.AssetType == "MoodAnimation" then
                        details.price:Destroy();
                        local v36 = script.priceOffsale:Clone();
                        v36.Name = "price";
                        v36.Parent = details;
                    else
                        task.spawn(function() -- Line: 322
                            -- upvalues: Cache (ref), Item (ref), Remotes (ref), details (copy), u11 (ref), Events (ref), PurchaseContext (copy)
                            local u37 = Cache.GetOrFetchWithTimeout("AssetBundlePrices", tostring(Item.Id), 1800, function() -- Line: 323
                                -- upvalues: Remotes (ref), Item (ref)
                                local success, result = pcall(function() -- Line: 324
                                    -- upvalues: Remotes (ref), Item (ref)
                                    return Remotes.GetAssetBundlePrice:InvokeServer(Item.Id);
                                end);

                                return success and result and result or nil;
                            end, 8);

                            if not u37 then
                                details.price:Destroy();
                                local v38 = script.priceOffsale:Clone();
                                v38.Name = "price";
                                v38.Parent = details;

                                return;
                            end;

                            details.price:Destroy();
                            local v39 = script.pricePartOfBundle:Clone();
                            v39.Name = "price";
                            v39.icon.Image = `rbxthumb://type=BundleThumbnail&id={u37}&w=150&h=150`;
                            v39.viewBundle.Activated:Connect(function() -- Line: 337
                                -- upvalues: u11 (ref), Events (ref), u37 (copy), PurchaseContext (ref)
                                u11.ClosePage();
                                Events.DisplayContentPage:Fire({
                                    Type = "ItemDetails",
                                    Item = {
                                        ItemType = "Bundle",
                                        IsLackingDetails = true,
                                        Id = u37
                                    },
                                    PurchaseContext = PurchaseContext
                                });
                            end);
                            v39.Parent = details;
                        end);
                    end;
                elseif Item.Price == "Free" then
                    details.price:Destroy();
                    local v40 = script.priceFree:Clone();
                    v40.Name = "price";
                    v40.Parent = details;
                    details.price.buy.Activated:Connect(function() -- Line: 361
                        -- upvalues: ItemPurchaseService (ref), Item (ref), PurchaseContext (copy)
                        ItemPurchaseService.PromptItemPurchase(Item, PurchaseContext);
                    end);
                elseif Item.Price == "NoResellers" then
                    details.price:Destroy();
                    local v41 = script.priceOffsale:Clone();
                    v41.priceAmount.Text = "There is no one currently selling this item.";
                    v41.Name = "price";
                    v41.Parent = details;
                end;
            end;
        end;

        local price = details:FindFirstChild("price");

        if price then
            for _, child in price:GetChildren() do
                if child:IsA("GuiObject") then
                    child.Visible = true;
                end;
            end;
        end;

        if v22 then
            local value = details.type.value;
            local v42 = Item.ItemType == "Bundle" and "Bundle · " or "";
            local v43, _ = string.gsub(v22, "(%l)(%u)", "%1 %2");
            value.Text = v42 .. v43;
        end;

        if Item.FavoriteCount then
            item.favorite.favoritesAmount.Text = tostring(CatalogUtilities.FormatNumberDetailed(Item.FavoriteCount));
        end;

        if Item.CreatorDisplay then
            item.creator.Text = string.format(Readable.creator, Item.CreatorDisplay);
            Events.AddTooltipToObject:Fire(item.creator, "See creator\'s page", function() -- Line: 393
                -- upvalues: item (copy)
                return item.creator.TextBounds.X / 2 - item.creator.AbsoluteSize.X / 2;
            end);
            item.creator.MouseEnter:Connect(function() -- Line: 398
                -- upvalues: item (copy), Readable (ref), Item (ref)
                item.creator.Text = string.format(Readable.creatorHovered, Item.CreatorDisplay);
            end);
            item.creator.MouseLeave:Connect(function() -- Line: 402
                -- upvalues: item (copy), Readable (ref), Item (ref)
                item.creator.Text = string.format(Readable.creator, Item.CreatorDisplay);
            end);
            item.creator.Activated:Connect(function() -- Line: 406
                -- upvalues: Item (ref), Events (ref)
                print(Item.CreatorId, typeof(Item.CreatorId), Item);

                if Item.CreatorType == "Group" then
                    Events.DisplayContentPage:Fire({
                        Type = "Group",
                        GroupId = Item.CreatorId
                    });

                    return;
                end;

                Events.DisplayContentPage:Fire({
                    Type = "UserProfile",
                    UserId = Item.CreatorId
                });
            end);
        end;

        local addToCart = details.price:FindFirstChild("addToCart");

        if addToCart then
            local function updateShoppingCartButton(p44) -- Line: 425
                -- upvalues: u28 (ref), addToCart (copy), TweenService (ref), u1 (ref)
                if u28 then
                    addToCart.label.Text = "Remove from Cart";

                    if p44 then
                        addToCart.BackgroundColor3 = Color3.fromRGB(255, 95, 92);

                        return;
                    end;

                    TweenService:Create(addToCart, u1, {
                        BackgroundColor3 = Color3.fromRGB(255, 95, 92)
                    }):Play();

                    return;
                end;

                addToCart.label.Text = "Add to Cart";

                if p44 then
                    addToCart.BackgroundColor3 = Color3.fromRGB(255, 255, 255);

                    return;
                end;

                TweenService:Create(addToCart, u1, {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                }):Play();
            end;

            if u28 then
                addToCart.label.Text = "Remove from Cart";
                addToCart.BackgroundColor3 = Color3.fromRGB(255, 95, 92);
            else
                addToCart.label.Text = "Add to Cart";
                addToCart.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            end;

            addToCart.Activated:Connect(function() -- Line: 444
                -- upvalues: u28 (ref), Events (ref), Item (ref), updateShoppingCartButton (copy)
                local v45;

                if u28 then
                    local v46;
                    v45, v46 = Events.ShoppingCartRemoveItem:Invoke(Item.Id, Item.ItemType);
                else
                    local v47;
                    v45, v47 = Events.ShoppingCartAddItem:Invoke(Item.Id, Item.ItemType);
                end;

                if v45 then
                    u28 = not u28;
                    updateShoppingCartButton();
                end;
            end);
        end;

        preview.tryOn.Activated:Connect(function() -- Line: 459
            -- upvalues: u26 (copy), ProfileBackgroundController (ref), Item (ref), HumanoidDescriptionController (ref), preview (copy), RecentController (ref), CatalogUtilities (ref), Remotes (ref), LocalPlayer (ref), Events (ref), Cache (ref)
            if u26 then
                local v48;

                if u26 then
                    v48 = ProfileBackgroundController.IsEquipped(Item.Id);
                else
                    v48 = HumanoidDescriptionController.EquippedDict and HumanoidDescriptionController.EquippedDict[tostring(Item.Id)] ~= nil;
                end;

                if v48 then
                    if ProfileBackgroundController.Unequip() then
                        preview.tryOn.label.Text = "Try On";

                        return;
                    end;
                elseif ProfileBackgroundController.Equip(Item) then
                    RecentController.TrackItem(Item);
                    preview.tryOn.label.Text = "Take Off";
                end;

                return;
            end;

            local v49;

            if Item.AssetType then
                v49 = CatalogUtilities.GetAssetTypeName(Item.AssetType);
            else
                v49 = nil;
            end;

            local v50 = false;
            local v51;

            if u26 then
                v51 = ProfileBackgroundController.IsEquipped(Item.Id);
            else
                v51 = HumanoidDescriptionController.EquippedDict and HumanoidDescriptionController.EquippedDict[tostring(Item.Id)] ~= nil;
            end;

            local v52, v53;

            if v51 then
                print("attempt to unequip item", Item.ItemType, v49);
                v52, v53 = Remotes.TakeOffItem:InvokeServer(Item.Id, Item.ItemType, v49);
            else
                if v49 == "EmoteAnimation" then
                    local Character = LocalPlayer.Character;

                    if Character then
                        Character = Character:FindFirstChildWhichIsA("Humanoid");
                    end;

                    if Character and Character.RigType == Enum.HumanoidRigType.R6 then
                        Events.Notify:Fire("🕺 You must set your Rig Type to R15 for emotes.");

                        return;
                    end;
                end;

                print("attempt to equip item", Item.ItemType, v49);
                Cache.Set(Item.ItemType .. "Name", tostring(Item.Id), Item.Name, 600);
                v52, v53 = Remotes.TryOnItem:InvokeServer(Item.Id, Item.ItemType, v49);
                v50 = true;
            end;

            if v52 ~= true then
                warn("Something went wrong:", v53);

                return;
            end;

            if not v50 then
                preview.tryOn.label.Text = "Try On";

                return;
            end;

            RecentController.TrackItem(Item);
            preview.tryOn.label.Text = "Take Off";
        end);
        local u54 = nil;
        local u55 = false;
        local u56 = TweenService:Create(preview.image, u1, {
            ImageTransparency = 1
        });
        local u57 = TweenService:Create(preview.image, u1, {
            ImageTransparency = 0
        });
        local u58 = TweenService:Create(preview.viewport, u1, {
            ImageTransparency = 0
        });
        local u59 = TweenService:Create(preview.viewport, u1, {
            ImageTransparency = 1
        });
        preview.viewport.ImageTransparency = 1;
        local u60 = nil;

        if u26 then
            preview.previewItem.Visible = false;
        else
            local v61;
            v61, u60 = ItemPreviewService.GetItemPreview({
                ItemDetails = Item,
                HumanoidDescription = HumanoidDescriptionController.GetCurrentDescription()
            });
        end;

        preview.previewItem.Activated:Connect(function() -- Line: 529
            -- upvalues: u55 (ref), u11 (ref), u57 (copy), u59 (copy), preview (copy), u54 (ref), LocalPlayer (ref), Item (ref), CatalogUtilities (ref), AvatarPreviewController (ref), ItemPreviewService (ref), u60 (ref), Page (copy), u56 (copy), u58 (copy)
            if u55 then
                u55 = false;
                u11.SetAllScrollingFramesEnabled(true);
                u57:Play();
                u59:Play();
                preview.previewItem.label.Text = "Preview";

                if u54 then
                    local u62 = u54;
                    u54 = nil;
                    u59.Completed:Once(function() -- Line: 540
                        -- upvalues: u62 (copy)
                        if u62 and u62.Destroy then
                            pcall(u62.Destroy, u62);
                        end;
                    end);
                end;
            else
                if u54 then
                    return;
                end;

                u55 = true;
                local v63 = {
                    AllowCameraAdjustment = true,
                    UseLiveAdjustments = true,
                    Target = LocalPlayer
                };
                local v64;

                if Item.AssetType then
                    v64 = CatalogUtilities.GetAssetTypeName(Item.AssetType);
                else
                    v64 = nil;
                end;

                if v64 == "EmoteAnimation" then
                    local Character = LocalPlayer.Character;

                    if Character then
                        Character = Character:FindFirstChildWhichIsA("Humanoid");
                    end;

                    if Character and Character.RigType == Enum.HumanoidRigType.R6 then
                        v63.RigType = Enum.HumanoidRigType.R15;
                    end;
                end;

                u54 = AvatarPreviewController.new(preview.viewport, nil, v63);
                table.insert(u11.Current.Objects, u54);
                local v65 = u54:GetRig();
                ItemPreviewService.ApplyPreviewInfoToRig(v65, u60);

                if u11.Current.Page == Page then
                    u11.SetAllScrollingFramesEnabled(false);
                end;

                u56:Play();
                u58:Play();
                preview.previewItem.label.Text = "Picture";
            end;
        end);
        preview.MouseEnter:Connect(function() -- Line: 579
            -- upvalues: u11 (ref), Page (copy), u55 (ref)
            if u11.Current.Page ~= Page then
                return;
            end;

            if u55 then
                u11.SetAllScrollingFramesEnabled(false);
            end;
        end);
        preview.MouseLeave:Connect(function() -- Line: 588
            -- upvalues: u11 (ref)
            u11.SetAllScrollingFramesEnabled(true);
        end);
        local searchByCreator = item.searchByCreator;
        Events.AddTooltipToObject:Fire(searchByCreator, "See items by this creator");
        searchByCreator.Activated:Connect(function() -- Line: 595
            -- upvalues: u11 (ref), CatalogController (ref), Events (ref), Item (ref)
            u11.ClosePage();

            if not CatalogController.IsOpen then
                CatalogController.Open({
                    SkipFrontPage = true
                });
            end;

            Events.SetCatalogOptionsFilter:Fire({
                CreatorName = Item.CreatorName,
                CreatorType = Enum.CreatorTypeFilter:FromName(Item.CreatorType)
            });
        end);
        searchByCreator.MouseEnter:Connect(function() -- Line: 606
            -- upvalues: searchByCreator (copy)
            searchByCreator.ImageTransparency = 0;
        end);
        searchByCreator.MouseLeave:Connect(function() -- Line: 610
            -- upvalues: searchByCreator (copy)
            searchByCreator.ImageTransparency = 0.25;
        end);
    end);

    return success, result;
end;

return v2;