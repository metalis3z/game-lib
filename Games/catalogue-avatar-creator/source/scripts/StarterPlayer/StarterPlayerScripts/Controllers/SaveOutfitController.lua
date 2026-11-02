-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AvatarEditorService = game:GetService("AvatarEditorService");
local Modules = require(script.Parent.Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
local LocalPlayer = Players.LocalPlayer;

local function dprint(...) -- Line: 12
end;

local SaveOutfit = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("SaveOutfit");
local container = SaveOutfit:WaitForChild("container");
local wrapper = container:WaitForChild("wrapper");
local chooseSaveType = wrapper.chooseSaveType;
local ensureItemsOwned = wrapper.ensureItemsOwned;
local buttons = chooseSaveType.buttons;
local buyUnowned = ensureItemsOwned.buyUnowned;
local readyToSave = ensureItemsOwned.readyToSave;
local save = ensureItemsOwned.save;
ReplicatedStorage:WaitForChild("Remotes");
local Events = script.Parent.Parent.Events;
local AvatarPreviewController = require(Modules.Controllers.AvatarPreviewController);
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local GetBatchItemDetails = require(Modules.Utilities.GetBatchItemDetails);
local ItemOwnershipService = require(Modules.Services.ItemOwnershipService);
local TotalPriceResolver = require(Modules.Services.TotalPriceResolver);
local ItemButton = require(Modules.Elements.ItemButton);
local CatalogUtilities = require(Modules.Shared.CatalogUtilities);
local LoadingController = require(Modules.Controllers.LoadingController);
local ItemPurchaseService = require(Modules.Services.ItemPurchaseService);
local PriceDisplay = require(Modules.Services.PriceDisplay);
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u2 = TweenService:Create(container, u1, {
    GroupTransparency = 0
});
local u3 = TweenService:Create(container, u1, {
    GroupTransparency = 1
});
local u4 = Color3.fromRGB(0, 216, 134);
local u5 = Color3.fromRGB(111, 111, 111);
local u6 = {
    IsOpen = false
};
local u7 = {};
local u8 = {};
local u9 = false;
local u10 = false;
local u11 = nil;
local u12 = 0;
local u13 = nil;
local u14 = nil;

local function clearConnections() -- Line: 64
    -- upvalues: u7 (copy)
    for _, v in u7 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u7);
end;

local function validateOwnership(p15) -- Line: 73
    -- upvalues: CatalogUtilities (copy), dprint (copy), HumanoidDescriptionController (copy), ItemOwnershipService (copy)
    local v16 = {};
    local v17 = {};

    if p15 then
        local v18 = CatalogUtilities.GetEquippedAssetIdsFromDescription(p15);
        dprint(p15, v18);
        v17 = {};

        for _, v in v18 do
            v17[tostring(v.AssetId)] = {
                ItemType = v.ItemType,
                AssetType = v.AssetType
            };
        end;
    else
        for i, v in HumanoidDescriptionController.EquippedDict do
            if i ~= "Description" then
                v17[i] = v;
            end;
        end;
    end;

    for i, i in v17 do
        local v19 = "Asset";

        if typeof(i) == "table" then
            v19 = i.ItemType or "Asset";
        elseif typeof(i) == "number" and i < 1000 then
            local _ = typeof(i) == "number";
        end;

        if not ItemOwnershipService.CheckItem({
            Id = i,
            ItemType = v19
        }) then
            table.insert(v16, {
                Id = i,
                ItemType = v19
            });
        end;
    end;

    return v16;
end;

local function executeSave(p20, p21, p22, p23) -- Line: 123
    -- upvalues: HumanoidDescriptionController (copy), CatalogUtilities (copy), ItemOwnershipService (copy), AvatarEditorService (copy), Events (copy), u8 (ref), u6 (copy)
    local v24 = p22 or HumanoidDescriptionController.GetCurrentDescription();
    local v25 = p23 or HumanoidDescriptionController.GetRigType();

    if p20 == "saveOutfit" then
        AvatarEditorService:PromptCreateOutfit(CatalogUtilities.CreateHumanoidDescriptionWithoutUnownedItems(v24, ItemOwnershipService), v25);
        local Name = AvatarEditorService.PromptCreateOutfitCompleted:Wait().Name;

        if Name == "Success" then
            Events.Notify:Fire("✅ Successfully saved your outfit!");
        elseif Name == "Failed" then
            Events.Notify:Fire("❌ Failed to save your outfit. Try again.");
        elseif Name == "PermissionDenied" then
            Events.Notify:Fire("❌ You need to accept the prompt to save outfits.");
        end;

        if p21 then
            Events.PromptCreateSavedOutfit:Invoke(u8.SourceType, u8.SourceId);
        end;
    elseif p20 == "saveAvatar" then
        AvatarEditorService:PromptSaveAvatar(v24, v25);
        local Name = AvatarEditorService.PromptSaveAvatarCompleted:Wait().Name;

        if Name == "Success" then
            Events.Notify:Fire("✅ Successfully saved as your avatar!");
        elseif Name == "Failed" then
            Events.Notify:Fire("❌ Failed to save your avatar. Try again.");
        elseif Name == "PermissionDenied" then
            Events.Notify:Fire("❌ You need to accept the prompt to save your avatar.");
        end;
    end;

    u6.Close();
end;

function u6.Close(p26) -- Line: 157
    -- upvalues: u6 (copy), u9 (ref), u10 (ref), u12 (ref), u11 (ref), Events (copy), u8 (ref), u7 (copy), u3 (copy), SaveOutfit (copy)
    if not u6.IsOpen then
        return;
    end;

    u6.IsOpen = false;
    u9 = false;
    u10 = false;
    u12 = u12 + 1;

    if u11 then
        pcall(u11.Destroy, u11);
        u11 = nil;
    end;

    Events.InterfaceAction:Fire("Remove", script.Name);

    if p26 ~= true then
        if u8.CustomCallback then
            u8.CustomCallback();
        else
            Events.SetButtonsVisible:Fire("All");
        end;
    end;

    for _, v in u7 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u7);
    u3:Play();
    u3.Completed:Once(function() -- Line: 191
        -- upvalues: u6 (ref), SaveOutfit (ref)
        if u6.IsOpen ~= true then
            SaveOutfit.Enabled = false;
        end;
    end);
end;

function u6.Open(p27, u28, u29, p30) -- Line: 198
    -- upvalues: u6 (copy), u9 (ref), u10 (ref), Events (copy), u13 (ref), u14 (ref), u8 (ref), dprint (copy), SaveOutfit (copy), container (copy), chooseSaveType (copy), ensureItemsOwned (copy), u2 (copy), u12 (ref), LocalPlayer (copy), AvatarPreviewController (copy), buttons (copy), u11 (ref), u7 (copy), TweenService (copy), u1 (copy), LoadingController (copy), validateOwnership (copy), readyToSave (copy), buyUnowned (copy), ThemeController (copy), u4 (copy), executeSave (copy), GetBatchItemDetails (copy), TotalPriceResolver (copy), ItemOwnershipService (copy), ItemButton (copy), ItemPurchaseService (copy), CatalogUtilities (copy), PriceDisplay (copy), save (copy), u5 (copy), wrapper (copy)
    if u6.IsOpen then
        if p27 then
            u6.Close();
        end;

        return;
    end;

    u6.IsOpen = true;
    u9 = false;
    u10 = false;
    Events.InterfaceAction:Fire("Add", script.Name, u6.Close);
    u13 = nil;
    u14 = nil;
    u8 = p30 or {};
    dprint("currentoptions:", u8);

    if u8.IsCatalogQuickAction == true then
        task.defer(function() -- Line: 217
            -- upvalues: Events (ref)
            Events.SetButtonsVisible:Fire({ "Undo", "Redo" });
        end);
    end;

    SaveOutfit.Enabled = true;
    container.GroupTransparency = 1;
    chooseSaveType.Visible = true;
    ensureItemsOwned.Visible = false;
    u2:Play();
    u12 = u12 + 1;
    local u31 = u12;
    task.spawn(function() -- Line: 234
        -- upvalues: u6 (ref), u31 (copy), u12 (ref), u29 (copy), LocalPlayer (ref), AvatarPreviewController (ref), buttons (ref), u28 (copy), u11 (ref)
        if not u6.IsOpen or u31 ~= u12 then
            return;
        end;

        local v32 = u29 or (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("Humanoid").RigType;

        if not u6.IsOpen or u31 ~= u12 then
            return;
        end;

        local new = AvatarPreviewController.new;
        local viewport = buttons.saveOutfit.preview.viewport;
        local v33 = {
            AllowCameraAdjustment = false
        };
        local v34;

        if u28 then
            v34 = nil;
        else
            v34 = LocalPlayer;
        end;

        v33.Target = v34;
        v33.RigType = v32;
        v33.UseLiveAdjustments = u28 == nil;
        local v35 = new(viewport, u28, v33);

        if not u6.IsOpen or u31 ~= u12 then
            pcall(v35.Destroy, v35);

            return;
        end;

        if u11 then
            pcall(u11.Destroy, u11);
        end;

        u11 = v35;
    end);
    buttons.saveAvatar.icon2.Image = `rbxthumb://type=Avatar&id={LocalPlayer.UserId}&w=720&h=720`;

    local function setupSaveButton(u36) -- Line: 272
        -- upvalues: u7 (ref), u9 (ref), TweenService (ref), u1 (ref), Events (ref), u13 (ref), u14 (ref), LoadingController (ref), validateOwnership (ref), u28 (copy), ensureItemsOwned (ref), chooseSaveType (ref), readyToSave (ref), buyUnowned (ref), ThemeController (ref), u4 (ref), executeSave (ref), u29 (copy), GetBatchItemDetails (ref), TotalPriceResolver (ref), ItemOwnershipService (ref), ItemButton (ref), ItemPurchaseService (ref), CatalogUtilities (ref), PriceDisplay (ref)
        table.insert(u7, u36.MouseEnter:Connect(function() -- Line: 273
            -- upvalues: u9 (ref), TweenService (ref), u36 (copy), u1 (ref)
            if u9 then
                return;
            end;

            TweenService:Create(u36.UIStroke, u1, {
                Transparency = 0
            }):Play();
        end));
        table.insert(u7, u36.MouseLeave:Connect(function() -- Line: 277
            -- upvalues: u9 (ref), TweenService (ref), u36 (copy), u1 (ref)
            if u9 then
                return;
            end;

            TweenService:Create(u36.UIStroke, u1, {
                Transparency = 0.5
            }):Play();
        end));
        table.insert(u7, u36.MouseButton1Down:Connect(function() -- Line: 281
            -- upvalues: u9 (ref), TweenService (ref), u36 (copy), u1 (ref)
            if u9 then
                return;
            end;

            TweenService:Create(u36.UIStroke, u1, {
                Transparency = 1
            }):Play();
        end));
        table.insert(u7, u36.MouseButton1Up:Connect(function() -- Line: 285
            -- upvalues: u9 (ref), TweenService (ref), u36 (copy), u1 (ref)
            if u9 then
                return;
            end;

            TweenService:Create(u36.UIStroke, u1, {
                Transparency = 0
            }):Play();
        end));
        table.insert(u7, u36.Activated:Connect(function() -- Line: 289
            -- upvalues: u9 (ref), u36 (copy), Events (ref), u13 (ref), u14 (ref), LoadingController (ref), validateOwnership (ref), u28 (ref), ensureItemsOwned (ref), chooseSaveType (ref), readyToSave (ref), buyUnowned (ref), ThemeController (ref), u4 (ref), executeSave (ref), u29 (ref), GetBatchItemDetails (ref), TotalPriceResolver (ref), ItemOwnershipService (ref), ItemButton (ref), ItemPurchaseService (ref), CatalogUtilities (ref), PriceDisplay (ref), u7 (ref)
            if u9 then
                return;
            end;

            local v37;

            if u36.Name == "saveOutfit" then
                local v38 = Events.GetSetting:Invoke({ "Miscellaneous", "DefaultSaveAsGameOutfit" });

                if v38 == "Always" then
                    v37 = true;
                elseif v38 == "Never" then
                    v37 = false;
                else
                    v37 = Events.PromptConfirmationDialog:Invoke({
                        Title = "Save Game Outfit",
                        Description = "Would you like to save your outfit in the game as well? <i>(optional)</i>\n\nYou can pick a default option in <b>settings</b>.",
                        NoText = "No",
                        YesText = "Yes"
                    });

                    if v37 == nil then
                        return;
                    end;
                end;
            else
                v37 = nil;
            end;

            u9 = true;
            u13 = u36.Name;
            u14 = v37;
            LoadingController.DisplayLoading(nil, "overlay");
            local v39 = validateOwnership(u28);
            local container2 = ensureItemsOwned.items.container;

            if #v39 > 0 then
                LoadingController.DisplayLoading(ensureItemsOwned, "overlay");
                ensureItemsOwned.title.Text = "Loading unowned items...";
                chooseSaveType.Visible = false;
                ensureItemsOwned.Visible = true;
                readyToSave.Visible = false;
                buyUnowned.BackgroundColor3 = ThemeController.GetColor(u4);

                for _, child in container2:GetChildren() do
                    if child:IsA("Frame") then
                        child:Destroy();
                    end;
                end;
            end;

            if #v39 == 0 then
                LoadingController.RemoveLoading();
                executeSave(u36.Name, v37, u28, u29);

                return;
            end;

            local v40 = {};

            for _, v in v39 do
                v40[tostring(v.Id)] = {
                    ItemType = v.ItemType
                };
            end;

            local v41 = GetBatchItemDetails(v40);
            local v42 = {};

            for _, v in v41 do
                v42[tostring(v.Id)] = v;
            end;

            local v43 = TotalPriceResolver.ResolveBundleIds(v41);
            local v44 = {};
            local v45 = {};

            for _, v in v39 do
                local v46 = tostring(v.Id);
                local v47 = v43[v46];
                local v48;

                if v47 then
                    local v49 = tostring(v47);
                    v48 = true;

                    if not (v44[v49] or ItemOwnershipService.CheckItem({
                        ItemType = "Bundle",
                        Id = v49
                    })) then
                        v44[v49] = true;
                        v45[v49] = {
                            ItemType = "Bundle"
                        };
                    end;
                else
                    v48 = false;
                end;

                if not v48 then
                    v45[v46] = {
                        ItemType = v.ItemType
                    };
                end;
            end;

            local v50 = 0;

            for _ in v45 do
                v50 = v50 + 1;
            end;

            if v50 == 0 then
                LoadingController.RemoveLoading();
                executeSave(u36.Name, v37, u28, u29);
            else
                local v51 = GetBatchItemDetails(v45);
                LoadingController.RemoveLoading();

                for _, v in v51 do
                    local v52 = ItemButton.new({
                        IsEquipped = true,
                        IsFavoriteAvailable = true,
                        ItemData = v,

                        CustomCallback = function() -- Line: 396, Name: CustomCallback
                            -- upvalues: ItemPurchaseService (ref), v (copy)
                            ItemPurchaseService.PromptItemPurchase(v);
                        end
                    });
                    local Price = v.Price;

                    if typeof(Price) == "string" and (Price ~= "Free" and (v.AssetType ~= "MoodAnimation" and not CatalogUtilities.DefaultRobloxClothingIds[tonumber(v.Id)])) then
                        v52.price.Text = "· · ·";
                    end;

                    v52:SetAttribute("price", v.Price);
                    v52:SetAttribute("itemType", v.ItemType);
                    v52.Name = tostring(v.Id);
                    v52.Parent = container2;
                    local v53 = v45[tostring(v.Id)];

                    if v53 and v53.ItemType == "Bundle" then
                        v52:SetAttribute("priceSuffix", " (Bundle)");
                    end;

                    ItemButton.SetPriceLabel(v52, v.Price);

                    if v.Price == "Offsale" then
                        v52:SetAttribute("isOffSale", true);
                    end;
                end;

                local function updateUnownedSummary() -- Line: 425
                    -- upvalues: container2 (copy), PriceDisplay (ref), ensureItemsOwned (ref), CatalogUtilities (ref), readyToSave (ref), buyUnowned (ref)
                    local v54 = 0;

                    for _, child in container2:GetChildren() do
                        if child:IsA("Frame") then
                            v54 = v54 + 1;
                        end;
                    end;

                    local v56, v57, _, v58 = PriceDisplay.SumItemFrames(container2, function(p55) -- Line: 430
                        if p55:IsA("Frame") then
                            return p55:GetAttribute("truePrice") or (tonumber(p55:GetAttribute("price")) or 0), p55:GetAttribute("bundleId");
                        end;

                        return nil;
                    end);
                    ensureItemsOwned.title.RichText = true;
                    ensureItemsOwned.title.Text = PriceDisplay.TotalPriceText(v56, v57, `Unowned items ({v54}) | `, CatalogUtilities.FormatNumberDetailed);
                    readyToSave.Visible = v54 == 0;
                    PriceDisplay.UpdateUpsellButton(buyUnowned:FindFirstChild("robloxPlus"), v56, v57, v58);
                end;

                updateUnownedSummary();
                table.insert(u7, PriceDisplay.OnChanged:Connect(updateUnownedSummary));
                local v59 = PriceDisplay.WireUpsellButton(buyUnowned:FindFirstChild("robloxPlus"));

                if v59 then
                    table.insert(u7, v59);
                end;

                buyUnowned.BackgroundColor3 = ThemeController.GetColor(u4);
                table.insert(u7, ItemOwnershipService.OnPurchaseFinished:Connect(function(p60, p61, p62) -- Line: 448
                    -- upvalues: container2 (copy), updateUnownedSummary (copy)
                    if not p62 then
                        return;
                    end;

                    local v63 = container2:FindFirstChild((tostring(p60)));

                    if v63 then
                        v63:Destroy();
                        updateUnownedSummary();
                    end;
                end));
            end;

            u9 = false;
        end));
    end;

    setupSaveButton(buttons.saveOutfit);
    setupSaveButton(buttons.saveAvatar);
    table.insert(u7, save.Activated:Connect(function() -- Line: 465
        -- upvalues: u9 (ref), u10 (ref), ensureItemsOwned (ref), Events (ref), executeSave (ref), u13 (ref), u14 (ref), u28 (copy), u29 (copy)
        if u9 or u10 then
            return;
        end;

        local v64 = 0;

        for _, child in ensureItemsOwned.items.container:GetChildren() do
            if child:IsA("Frame") then
                v64 = v64 + 1;
            end;
        end;

        if v64 > 0 and not Events.PromptConfirmationDialog:Invoke({
            Title = "Unowned Items",
            NoText = "No",
            YesText = "Yes",
            Description = `You still have <b>{v64}</b> unowned item{v64 == 1 and "" or "s"} which will not be saved to Roblox. Are you sure you want to save your outfit?`
        }) then
            return;
        end;

        executeSave(u13, u14, u28, u29);
    end));
    table.insert(u7, buyUnowned.Activated:Connect(function() -- Line: 490
        -- upvalues: u10 (ref), u9 (ref), buyUnowned (ref), u5 (ref), ThemeController (ref), u4 (ref), ensureItemsOwned (ref), ItemPurchaseService (ref)
        if u10 then
            return;
        end;

        if u9 then
            buyUnowned.BackgroundColor3 = u5;

            repeat
                task.wait();
            until not u9;

            buyUnowned.BackgroundColor3 = ThemeController.GetColor(u4);
        end;

        local v65 = {};
        local v66 = {};

        for _, child in ensureItemsOwned.items.container:GetChildren() do
            if child:IsA("Frame") then
                local v67 = tonumber(child.Name);
                local v68 = child:GetAttribute("itemType");
                local v69 = child:GetAttribute("bundleId");

                if v67 and v68 then
                    if v69 then
                        if not (child:GetAttribute("isOffSale") or v65[tostring(v69)]) then
                            v65[tostring(v69)] = true;
                            local v70 = {
                                Type = Enum.MarketplaceProductType.AvatarBundle,
                                Id = tostring(v69)
                            };
                            table.insert(v66, v70);
                        end;
                    elseif not child:GetAttribute("isOffSale") then
                        local v71 = {
                            Type = Enum.MarketplaceProductType:FromName("Avatar" .. v68),
                            Id = tostring(v67)
                        };
                        table.insert(v66, v71);
                    end;
                end;
            end;
        end;

        if #v66 > 0 then
            u10 = true;
            buyUnowned.BackgroundColor3 = u5;
            ItemPurchaseService.PromptBulkPurchase(v66);
            u10 = false;
            buyUnowned.BackgroundColor3 = ThemeController.GetColor(u4);
        end;
    end));
    table.insert(u7, wrapper.closeButton.Activated:Connect(u6.Close));
end;

Events.DisplaySaveOutfit.Event:Connect(u6.Open);

return u6;