-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Modules = require(script.Parent.Parent.Modules);
local ScrollFade = require(Modules.Elements.ScrollFade);

local function dprint(...) -- Line: 12
end;

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local SavedOutfits = PlayerGui:WaitForChild("SavedOutfits");
local Catalog = PlayerGui:WaitForChild("Catalog");
local container = SavedOutfits:WaitForChild("container");
local wrapper = container:WaitForChild("wrapper");
local outfitsSection = wrapper:WaitForChild("outfitsSection");
local outfits = outfitsSection:WaitForChild("outfits");
local container2 = outfits:WaitForChild("container");
local noSavedOutfits = outfitsSection:WaitForChild("noSavedOutfits");
local noOutfitsTagged = outfitsSection:WaitForChild("noOutfitsTagged");
local searchContainer = wrapper.topBar.searchContainer;
local searchInput = searchContainer.wrapper.searchInput;
local clear = searchContainer.clear;
searchInput.ClearTextOnFocus = false;
clear.Visible = false;
searchInput:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 35
    -- upvalues: clear (copy), searchInput (copy)
    clear.Visible = searchInput.Text ~= "";
end);
clear.Activated:Connect(function() -- Line: 39
    -- upvalues: searchInput (copy)
    searchInput.Text = "";
    searchInput:CaptureFocus();
end);
local sortDropdown = wrapper.topBar:WaitForChild("sortDropdown");
local button = sortDropdown:WaitForChild("button");
local label = sortDropdown:WaitForChild("label");
local dropdown = sortDropdown:WaitForChild("dropdown");
local configureTagContainer = wrapper.bottomBar.right:WaitForChild("configureTagContainer");
local divider = script:FindFirstChild("divider");
local tagDropdown = wrapper.topBar:WaitForChild("tagDropdown");
local button2 = tagDropdown:WaitForChild("button");
local label2 = tagDropdown:WaitForChild("label");
local dropdown2 = tagDropdown:WaitForChild("dropdown");
local topFade = outfitsSection:FindFirstChild("topFade");
local v1 = outfitsSection:FindFirstChild("bottomFade") or outfitsSection:FindFirstChild("bottomBuffer");
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local Events = script.Parent.Parent.Events;
local ItemButton = require(Modules.Elements.ItemButton);
local CatalogController = require(Modules.Controllers.CatalogController);
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local AvatarPreviewController = require(Modules.Controllers.AvatarPreviewController);
local DropdownController = require(Modules.Elements.DropdownController);
local OutsideClickDetector = require(Modules.Utilities.OutsideClickDetector);
require(Modules.Controllers.ThemeController);
local _ = Enum.EasingStyle.Quad;
local _ = Enum.EasingDirection.Out;
local u2 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u3 = TweenService:Create(container, u2, {
    GroupTransparency = 0
});
local u4 = TweenService:Create(container, u2, {
    GroupTransparency = 1
});
local u5 = {
    IsOpen = false,
    ItemsLoaded = 0,
    IsLoadingNextPage = false,
    CurrentSortMode = "Newest",
    CurrentTagFilter = "All",
    _tagController = nil,
    SortedOutfits = {}
};
local u6 = {};
local u7 = 0;
local u8 = setmetatable({}, {
    __mode = "k"
});
local u9 = false;

local function notifyDeveloperError(p10) -- Line: 99
    -- upvalues: u9 (ref), Events (copy)
    if u9 then
        return;
    end;

    u9 = true;
    Events.Notify:Fire("❌ Couldn\'t render a saved outfit. Please notify a developer with this error: <b>" .. tostring(p10) .. "</b>", 60);
    task.delay(60, function() -- Line: 103
        -- upvalues: u9 (ref)
        u9 = false;
    end);
end;

SavedOutfits.Enabled = false;
local u11 = ScrollFade.new(outfits, topFade, v1);

local function updateTopBarSize() -- Line: 110
    -- upvalues: wrapper (copy), outfitsSection (copy)
    local topBar = wrapper.topBar;
    local Scale = topBar.Size.Y.Scale;
    local v12 = wrapper.AbsoluteSize.Y * Scale;
    local v13 = math.max(34, v12) - v12;
    topBar.Size = UDim2.new(1, 0, Scale, v13);
    outfitsSection.Size = UDim2.new(outfitsSection.Size.X.Scale, outfitsSection.Size.X.Offset, outfitsSection.Size.Y.Scale, -v13);
end;

function u5.UpdateUI() -- Line: 127
    -- upvalues: updateTopBarSize (copy), u11 (copy)
    updateTopBarSize();
    u11:Update();
end;

local function clearConnections() -- Line: 133
    -- upvalues: u6 (copy)
    for _, v in u6 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u6);
end;

local SelectMode = require(script:WaitForChild("SelectMode"));
SelectMode.Init({
    Controller = u5,
    outfitsContainer = container2,
    wrapper = wrapper,
    bottomBar = wrapper.bottomBar,
    configureTagContainer = configureTagContainer,
    remotes = Remotes,
    events = Events,
    OutsideClickDetector = OutsideClickDetector
});

local function createOutfitItemFrame(p14, p15) -- Line: 154
    -- upvalues: HumanoidDescriptionController (copy), ItemButton (copy), u8 (copy), container2 (copy), SelectMode (copy)
    local v16, v17, v18 = HumanoidDescriptionController.DeserializeHumanoidDescription(p14.HumanoidDescription);

    if not v16 then
        error("Failed to deserialize HumanoidDescription for outfit " .. tostring(p14 and (p14.Id or "?") or "?"));
    end;

    local v19, v20 = ItemButton.newOutfit({
        OutfitType = "SavedOutfit",
        IsFavoriteAvailable = true,
        SkeletonLoading = true,
        FitOutfit = true,
        OutfitDetails = {
            Name = p14.Name,
            Id = p14.Id,
            HumanoidDescription = v16,
            RigType = v17,
            AccessoryAdjustments = v18,
            Created = p14.Created,
            IsFavorited = p14.IsFavorited,
            Tags = p14.Tags
        }
    });
    v19.LayoutOrder = p15;
    v19:SetAttribute("serializedDescription", p14.HumanoidDescription);
    u8[v19] = v20;
    v19.Parent = container2;
    SelectMode.OnTileCreated(v19);
end;

local function unloadAllTiles() -- Line: 187
    -- upvalues: container2 (copy), u8 (copy)
    for _, child in container2:GetChildren() do
        if child:GetAttribute("isItem") then
            local v21 = u8[child];

            if v21 and v21.Unload then
                v21.Unload();
            end;
        end;
    end;
end;

local function loadAllTiles() -- Line: 196
    -- upvalues: container2 (copy), u8 (copy)
    task.spawn(function() -- Line: 197
        -- upvalues: container2 (ref), u8 (ref)
        local v22 = 0;

        for _, child in container2:GetChildren() do
            if child:GetAttribute("isItem") then
                local v23 = u8[child];

                if v23 and v23.Load then
                    v23.Load();
                end;

                v22 = v22 + 1;

                if v22 % 8 == 0 then
                    task.wait();
                end;
            end;
        end;
    end);
end;

local function loadNextChunk() -- Line: 210
    -- upvalues: u5 (copy), u7 (ref), createOutfitItemFrame (copy), notifyDeveloperError (copy), u11 (copy)
    if u5.IsLoadingNextPage then
        return;
    end;

    if u5.ItemsLoaded >= #u5.SortedOutfits then
        return;
    end;

    u5.IsLoadingNextPage = true;
    local u24 = u7;
    local u25 = u5.ItemsLoaded + 1;
    local u26 = math.min(u25 + 24 - 1, #u5.SortedOutfits);
    local success, result = pcall(function() -- Line: 220
        -- upvalues: u25 (copy), u26 (copy), u7 (ref), u24 (copy), u5 (ref), createOutfitItemFrame (ref), notifyDeveloperError (ref)
        for i = u25, u26 do
            if u7 ~= u24 then
                return;
            end;

            local v27 = u5.SortedOutfits[i];

            if not v27 then
                return;
            end;

            local success, result = pcall(createOutfitItemFrame, v27, i);

            if not success then
                if v27 then
                    v27 = v27.Id;
                end;

                warn("[SavedOutfitsController] createOutfitItemFrame failed for outfit", v27, ":", result);
                notifyDeveloperError(result);
            end;

            task.wait();
        end;

        if u7 == u24 then
            u5.ItemsLoaded = u26;
        end;
    end);

    if u7 == u24 then
        u5.IsLoadingNextPage = false;
        u11:Update();
    end;

    if not success then
        warn("loadNextChunk failed:", result);
    end;
end;

local function rebuildSortedList(p28) -- Line: 251
    -- upvalues: u5 (copy)
    local Outfits = u5.SavedOutfitsData.Outfits;
    local v29 = not p28 and "" or string.lower(p28);
    local CurrentSortMode = u5.CurrentSortMode;
    local CurrentTagFilter = u5.CurrentTagFilter;
    local v30 = {};

    for _, v in Outfits do
        local v31 = v29 == "" and true or string.find(string.lower(v.Name or ""), v29, 1, true);
        local v32;

        if CurrentTagFilter == "All" then
            v32 = true;
        else
            v32 = false;

            if v.Tags then
                for _, v2 in v.Tags do
                    if v2 == CurrentTagFilter then
                        v32 = true;
                        break;
                    end;
                end;
            end;
        end;

        if v31 and ((CurrentSortMode ~= "Favorited" and true or v.IsFavorited == true) and v32) then
            table.insert(v30, v);
        end;
    end;

    table.sort(v30, function(p33, p34) -- Line: 281
        -- upvalues: CurrentSortMode (copy)
        if CurrentSortMode == "Oldest" then
            return (p33.Created or 0) < (p34.Created or 0);
        end;

        if CurrentSortMode == "AlphabetAZ" then
            return string.lower(p33.Name or "") < string.lower(p34.Name or "");
        end;

        if CurrentSortMode == "AlphabetZA" then
            return string.lower(p33.Name or "") > string.lower(p34.Name or "");
        end;

        return (p33.Created or 0) > (p34.Created or 0);
    end);
    u5.SortedOutfits = v30;
end;

local function loadOutfits() -- Line: 296
    -- upvalues: u7 (ref), outfitsSection (copy), container2 (copy), rebuildSortedList (copy), searchInput (copy), u5 (copy), loadNextChunk (copy), noOutfitsTagged (copy), noSavedOutfits (copy), SelectMode (copy)
    u7 = u7 + 1;
    outfitsSection.Visible = false;

    for i, child in container2:GetChildren() do
        if child:GetAttribute("isItem") then
            child:Destroy();

            if i % 15 == 0 then
                task.wait();
            end;
        end;
    end;

    outfitsSection.Visible = true;
    rebuildSortedList(searchInput.Text);
    u5.ItemsLoaded = 0;
    u5.IsLoadingNextPage = false;
    loadNextChunk();
    local v35 = #u5.SortedOutfits == 0;
    local v36 = u5.CurrentTagFilter ~= "All";
    noOutfitsTagged.Visible = v35 and v36;

    if v35 then
        v35 = not v36;
    end;

    noSavedOutfits.Visible = v35;
    SelectMode.OnOutfitsUpdated();
end;

function u5.Close(p37) -- Line: 412
    -- upvalues: u5 (copy), SelectMode (copy), u6 (copy), Events (copy), u4 (copy), TweenService (copy), Catalog (copy), u2 (copy), SavedOutfits (copy), outfitsSection (copy), unloadAllTiles (copy), CatalogController (copy)
    if not u5.IsOpen then
        return;
    end;

    u5.IsOpen = false;
    SelectMode.Exit();

    for _, v in u6 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u6);

    if p37 ~= true then
        Events.SetButtonsVisible:Fire("All");
    end;

    Events.InterfaceAction:Fire("Remove", script.Name);
    u4:Play();
    TweenService:Create(Catalog.container, u2, {
        GroupTransparency = 1
    }):Play();
    u4.Completed:Once(function() -- Line: 423
        -- upvalues: u5 (ref), SavedOutfits (ref), outfitsSection (ref), unloadAllTiles (ref), CatalogController (ref), Catalog (ref)
        if u5.IsOpen ~= true then
            SavedOutfits.Enabled = false;
            outfitsSection.Visible = false;
            unloadAllTiles();

            if CatalogController.IsOpen ~= true then
                Catalog.Enabled = false;
                Catalog.container.catalogSection.Visible = true;
                CatalogController.ClearConnections();
            end;
        end;
    end);
end;

function u5.Open(p38) -- Line: 442
    -- upvalues: u5 (copy), Events (copy), Remotes (copy), SavedOutfits (copy), Catalog (copy), CatalogController (copy), container (copy), u3 (copy), TweenService (copy), u2 (copy), u6 (copy), wrapper (copy), searchInput (copy), loadOutfits (copy), UserInputService (copy), DropdownController (copy), button (copy), label (copy), dropdown (copy), button2 (copy), label2 (copy), dropdown2 (copy), divider (copy), configureTagContainer (copy), SelectMode (copy), OutsideClickDetector (copy), outfitsSection (copy), HumanoidDescriptionController (copy), AvatarPreviewController (copy), container2 (copy), u8 (copy), outfits (copy)
    if u5.IsOpen then
        if p38 then
            u5.Close();
        end;

        return;
    end;

    u5.IsOpen = true;
    Events.SetButtonsVisible:Fire({ "Undo", "Redo" });
    pcall(Remotes.AnalyticsEvent.FireServer, Remotes.AnalyticsEvent, "SavedOutfitsOpened");
    Events.InterfaceAction:Fire("Add", script.Name, u5.Close);
    SavedOutfits.Enabled = true;
    Catalog.Enabled = true;
    Catalog.container.catalogSection.Visible = false;
    CatalogController.SetupQuickActions(u5.Open);
    container.GroupTransparency = 1;
    u3:Play();
    TweenService:Create(Catalog.container, u2, {
        GroupTransparency = 0
    }):Play();
    table.insert(u6, wrapper.topBar.closeButton.Activated:Connect(u5.Close));
    table.insert(u6, wrapper.topBar.returnButton.Activated:Connect(function() -- Line: 464
        -- upvalues: u5 (ref), Events (ref)
        u5.Close();
        Events.DisplayOutfits:Fire();
    end));
    table.insert(u6, searchInput.FocusLost:Connect(function(p39) -- Line: 469
        -- upvalues: loadOutfits (ref)
        if p39 then
            loadOutfits();
        end;
    end));
    table.insert(u6, UserInputService.InputBegan:Connect(function(p40, p41) -- Line: 475
        -- upvalues: searchInput (ref), loadOutfits (ref)
        if p41 then
            return;
        end;

        if (p40.KeyCode == Enum.KeyCode.Return or p40.KeyCode == Enum.KeyCode.KeypadEnter) and searchInput:IsFocused() then
            loadOutfits();
        end;
    end));
    local u43 = DropdownController.new({
        reflectSelectionOnLabel = true,
        toggleButton = button,
        label = label,
        dropFrame = dropdown,
        choiceTemplate = dropdown:FindFirstChild("choice"),

        getChoices = function() -- Line: 490, Name: getChoices
            return { {
                    key = "Newest",
                    text = "Newest"
                }, {
                    key = "Oldest",
                    text = "Oldest"
                }, {
                    key = "AlphabetAZ",
                    text = "Alphabetical (A-Z)"
                }, {
                    key = "AlphabetZA",
                    text = "Alphabetical (Z-A)"
                }, {
                    key = "Favorited",
                    text = "Favorited"
                } };
        end,

        onSelect = function(p42) -- Line: 499, Name: onSelect
            -- upvalues: u5 (ref), loadOutfits (ref)
            u5.CurrentSortMode = p42;
            task.spawn(loadOutfits);
        end
    });
    u43:SetCurrentChoice(u5.CurrentSortMode, nil, true);
    table.insert(u6, {
        Disconnect = function() -- Line: 506, Name: Disconnect
            -- upvalues: u43 (copy)
            u43:Destroy();
        end
    });
    u5._tagController = DropdownController.new({
        reflectSelectionOnLabel = true,
        toggleButton = button2,
        label = label2,
        dropFrame = dropdown2,
        choiceTemplate = dropdown2:FindFirstChild("choice"),
        dividerTemplate = divider,

        getChoices = function() -- Line: 518, Name: getChoices
            -- upvalues: u5 (ref)
            local v44 = u5.SavedOutfitsData and u5.SavedOutfitsData.Tags or {};
            local v45 = {
                {
                    key = "All",
                    text = "All",
                    layoutOrder = 0,
                    addDividerAfter = #v44 > 0
                }
            };

            for i, v in v44 do
                table.insert(v45, {
                    key = v,
                    text = v,
                    layoutOrder = i + 1
                });
            end;

            return v45;
        end,

        onSelect = function(p46) -- Line: 526, Name: onSelect
            -- upvalues: u5 (ref), configureTagContainer (ref), SelectMode (ref), loadOutfits (ref)
            u5.CurrentTagFilter = p46;
            local v47;

            if p46 == "All" then
                v47 = false;
            else
                v47 = not SelectMode.IsActive();
            end;

            configureTagContainer.Visible = v47;
            task.spawn(loadOutfits);
        end
    });
    u5._tagController:SetCurrentChoice(u5.CurrentTagFilter, nil, true);
    table.insert(u6, {
        Disconnect = function() -- Line: 534, Name: Disconnect
            -- upvalues: u5 (ref)
            u5._tagController:Destroy();
            u5._tagController = nil;
        end
    });
    local dropdown3 = configureTagContainer.dropdown;
    local button3 = configureTagContainer.button;
    local input = dropdown3.wrapper.name.nameInput.input;
    local button4 = dropdown3.wrapper.actions.delete.button;
    local u48 = nil;
    Color3.fromRGB(240, 239, 249);
    Color3.fromRGB(33, 34, 39);
    Color3.fromRGB(33, 34, 39);
    Color3.fromRGB(255, 255, 255);
    Color3.fromRGB(240, 239, 249);

    local function fadeConfigureDropdown(p49) -- Line: 564
        -- upvalues: dropdown3 (copy), TweenService (ref), u2 (ref)
        for _, descendant in dropdown3:GetDescendants() do
            local v50 = {};
            local u51 = p49 and descendant:GetAttribute("originalTransparency") or 1;

            if u51 == nil then
                pcall(function() -- Line: 570
                    -- upvalues: descendant (copy), u51 (ref)
                    if descendant:IsA("Frame") then
                        u51 = descendant.BackgroundTransparency < 1 and descendant.BackgroundTransparency or 1;

                        return;
                    end;

                    u51 = descendant.Transparency < 1 and descendant.Transparency or 1;
                end);
            end;

            if descendant:IsA("Frame") then
                v50.BackgroundTransparency = u51;
            elseif descendant:IsA("TextLabel") or descendant:IsA("TextBox") then
                v50.BackgroundTransparency = u51;
                v50.TextTransparency = p49 and 0 or 1;
            elseif descendant:IsA("ImageLabel") then
                v50.ImageTransparency = p49 and (descendant:GetAttribute("originalImageTransparency") or 0) or 1;
                v50.BackgroundTransparency = u51;
            elseif descendant:IsA("TextButton") then
                v50.BackgroundTransparency = u51;
                v50.TextTransparency = p49 and 0 or 1;
            elseif descendant:IsA("UIStroke") then
                v50.Transparency = u51;
            else
                v50 = nil;
            end;

            if v50 then
                TweenService:Create(descendant, u2, v50):Play();
            end;
        end;
    end;

    local function toggleConfigureDropdown(p52) -- Line: 600
        -- upvalues: dropdown3 (copy), input (copy), u5 (ref), fadeConfigureDropdown (copy), TweenService (ref), configureTagContainer (ref), u2 (ref), u48 (ref), OutsideClickDetector (ref), toggleConfigureDropdown (copy), button3 (copy)
        if p52 == nil then
            p52 = not dropdown3.Visible;
        end;

        if not p52 then
            TweenService:Create(configureTagContainer.back.UIStroke, u2, {
                Transparency = 1
            }):Play();
            TweenService:Create(configureTagContainer.back.WhiteRing, u2, {
                Transparency = 1
            }):Play();

            if u48 then
                u48:Disconnect();
                u48 = nil;
            end;

            fadeConfigureDropdown(false);
            dropdown3.Visible = false;

            return;
        end;

        input.Text = u5.CurrentTagFilter;
        dropdown3.Visible = true;
        fadeConfigureDropdown(true);
        TweenService:Create(configureTagContainer.back.UIStroke, u2, {
            Transparency = 0
        }):Play();
        TweenService:Create(configureTagContainer.back.WhiteRing, u2, {
            Transparency = 0
        }):Play();

        if u48 then
            u48:Disconnect();
        end;

        u48 = OutsideClickDetector({ dropdown3 }, function() -- Line: 614
            -- upvalues: toggleConfigureDropdown (ref)
            toggleConfigureDropdown(false);
        end, {
            include = { button3 }
        });
    end;

    dropdown3.Visible = false;
    (function() -- Line: 553, Name: setOriginalTransparencies
        -- upvalues: dropdown3 (copy)
        for _, descendant in dropdown3:GetDescendants() do
            pcall(function() -- Line: 555
                -- upvalues: descendant (copy)
                descendant:SetAttribute("originalTransparency", descendant.Transparency);
            end);

            if descendant:IsA("ImageLabel") then
                descendant:SetAttribute("originalImageTransparency", descendant.ImageTransparency);
            end;
        end;
    end)();
    table.insert(u6, button3.Activated:Connect(function() -- Line: 633
        -- upvalues: toggleConfigureDropdown (copy)
        toggleConfigureDropdown();
    end));
    table.insert(u6, input.FocusLost:Connect(function() -- Line: 638
        -- upvalues: input (copy), u5 (ref), Remotes (ref), loadOutfits (ref), Events (ref)
        local Text = input.Text;
        local CurrentTagFilter = u5.CurrentTagFilter;

        if Text == CurrentTagFilter or Text == "" then
            input.Text = CurrentTagFilter;

            return;
        end;

        local v53, _ = Remotes.SavedOutfitAction:InvokeServer({
            Action = "RenameTag",
            Name = CurrentTagFilter,
            NewName = Text
        });

        if not v53 then
            input.Text = CurrentTagFilter;
            Events.Notify:Fire("❌ Failed to rename group.");

            return;
        end;

        u5.CurrentTagFilter = Text;
        task.wait();
        u5._tagController:RebuildChoices();
        u5._tagController:SetCurrentChoice(Text, nil, true);
        task.spawn(loadOutfits);
    end));
    table.insert(u6, button4.Activated:Connect(function() -- Line: 660
        -- upvalues: u5 (ref), Events (ref), Remotes (ref), TweenService (ref), configureTagContainer (ref), u2 (ref), u48 (ref), fadeConfigureDropdown (copy), dropdown3 (copy), loadOutfits (ref)
        local CurrentTagFilter = u5.CurrentTagFilter;

        if not Events.PromptConfirmationDialog:Invoke({
            Title = "Delete Group",
            Description = "Are you sure you want to delete group \'<b>" .. CurrentTagFilter .. "</b>\'?\n\nIt will be removed from all outfits."
        }) then
            return;
        end;

        local v54, _ = Remotes.SavedOutfitAction:InvokeServer({
            Action = "DeleteTag",
            Name = CurrentTagFilter
        });

        if not v54 then
            Events.Notify:Fire("❌ Failed to delete group.");

            return;
        end;

        TweenService:Create(configureTagContainer.back.UIStroke, u2, {
            Transparency = 1
        }):Play();
        TweenService:Create(configureTagContainer.back.WhiteRing, u2, {
            Transparency = 1
        }):Play();

        if u48 then
            u48:Disconnect();
            u48 = nil;
        end;

        fadeConfigureDropdown(false);
        dropdown3.Visible = false;
        u5.CurrentTagFilter = "All";
        configureTagContainer.Visible = false;
        task.wait();
        u5._tagController:RebuildChoices();
        u5._tagController:SetCurrentChoice("All", nil, true);
        task.spawn(loadOutfits);
        Events.Notify:Fire("✅ Group \'<b>" .. CurrentTagFilter .. "</b>\' deleted.");
    end));
    table.insert(u6, {
        Disconnect = function() -- Line: 684, Name: Disconnect
            -- upvalues: u48 (ref)
            if u48 then
                u48:Disconnect();
                u48 = nil;
            end;
        end
    });
    table.insert(u6, wrapper.bottomBar.left.createNewOutfitContainer.button.Activated:Connect(u5.PromptCreateSavedOutfit));
    SelectMode.Setup(u6);
    local v55 = wrapper:GetPropertyChangedSignal("AbsoluteSize");
    table.insert(u6, v55:Connect(u5.UpdateUI));
    u5.UpdateUI();

    if u5._hasLoaded then
        outfitsSection.Visible = true;

        if HumanoidDescriptionController.HumanoidDescription then
            AvatarPreviewController.CurrentCatalogPreviewObject:Update(HumanoidDescriptionController.HumanoidDescription, {
                BypassIsApplied = true
            });
        end;

        AvatarPreviewController.CurrentCatalogPreviewObject:Redraw();
        task.spawn(function() -- Line: 197
            -- upvalues: container2 (ref), u8 (ref)
            local v56 = 0;

            for _, child in container2:GetChildren() do
                if child:GetAttribute("isItem") then
                    local v57 = u8[child];

                    if v57 and v57.Load then
                        v57.Load();
                    end;

                    v56 = v56 + 1;

                    if v56 % 8 == 0 then
                        task.wait();
                    end;
                end;
            end;
        end);

        return;
    end;

    while true do
        local v58, v59 = Remotes.SavedOutfitAction:InvokeServer({
            Action = "Get"
        });

        if v58 == false then
            task.wait(0.5);
        end;

        if v58 ~= false then
            if not (u5.IsOpen and u5._tagController) then
                return;
            end;

            u5.SavedOutfitsData = v59;
            u5._tagController:RebuildChoices();

            if HumanoidDescriptionController.HumanoidDescription then
                AvatarPreviewController.CurrentCatalogPreviewObject:Update(HumanoidDescriptionController.HumanoidDescription, {
                    BypassIsApplied = true
                });
            end;

            AvatarPreviewController.CurrentCatalogPreviewObject:Redraw();
            u5._hasLoaded = true;
            outfits.CanvasPosition = Vector2.new(0, 0);
            loadOutfits();

            return;
        end;
    end;
end;

function u5.PromptCreateSavedOutfit(p60, p61) -- Line: 740
    -- upvalues: Events (copy), Remotes (copy)
    if p60 == "RobloxOutfit" or p60 == "RobloxAvatar" then
        if type(p61) ~= "number" then
            p60 = nil;
            p61 = nil;
        end;
    else
        p60 = nil;
        p61 = nil;
    end;

    local v62 = Events.PromptInputDialog:Invoke({
        Title = "New Outfit",
        Description = "What would you like to name your new outfit?",
        NoText = "Cancel",
        YesText = "Create",
        PlaceholderText = "Name",
        DefaultText = "New Outfit"
    });

    if v62 == false then
        Events.Notify:Fire("❌ Cancelled outfit creation.");

        return;
    end;

    local v63 = {
        Action = "Save",
        Name = v62
    };

    if p60 then
        v63.SourceType = p60;
        v63.SourceId = p61;
    end;

    local v64, v65 = Remotes.SavedOutfitAction:InvokeServer(v63);

    if v64 == true then
        Events.Notify:Fire("✅ Successfully created outfit \'<b>" .. v62 .. "</b>\'!");

        return;
    end;

    if v65 ~= "cooldown" then
        Events.Notify:Fire("❌ Couldn\'t create outfit. Try again.");
    end;
end;

local function isNearBottom() -- Line: 772
    -- upvalues: outfits (copy)
    local Y = outfits.AbsoluteCanvasSize.Y;
    local Y2 = outfits.AbsoluteWindowSize.Y;

    if Y <= Y2 then
        return false;
    end;

    return outfits.CanvasPosition.Y >= Y - Y2 - Y2 * 0.3;
end;

outfits:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line: 784
    -- upvalues: outfits (copy), loadNextChunk (copy)
    local Y = outfits.AbsoluteCanvasSize.Y;
    local Y2 = outfits.AbsoluteWindowSize.Y;
    local v66;

    if Y <= Y2 then
        v66 = false;
    else
        v66 = outfits.CanvasPosition.Y >= Y - Y2 - Y2 * 0.3;
    end;

    if v66 then
        loadNextChunk();
    end;
end);
Events.DisplaySavedOutfits.Event:Connect(u5.Open);
Events.PromptCreateSavedOutfit.OnInvoke = u5.PromptCreateSavedOutfit;
Remotes.SavedOutfitsUpdated.OnClientEvent:Connect(function(p67) -- Line: 323, Name: updateOutfits
    -- upvalues: u5 (copy), rebuildSortedList (copy), searchInput (copy), container2 (copy), createOutfitItemFrame (copy), notifyDeveloperError (copy), dprint (copy), noOutfitsTagged (copy), noSavedOutfits (copy), SelectMode (copy), u11 (copy)
    u5.SavedOutfitsData = p67;

    if u5._tagController then
        u5._tagController:RebuildChoices();
    end;

    if u5.IsOpen ~= true then
        return;
    end;

    rebuildSortedList(searchInput.Text);
    local v68 = {};

    for _, child in container2:GetChildren() do
        if child:GetAttribute("isItem") then
            v68[child:GetAttribute("outfitId")] = child;
        end;
    end;

    local v69 = math.max(u5.ItemsLoaded, 24);
    local v70 = {};

    for i = 1, math.min(v69, #u5.SortedOutfits) do
        local v71 = u5.SortedOutfits[i];
        v70[v71.Id] = true;
        local v72 = v68[v71.Id];

        if v72 then
            if v72:GetAttribute("serializedDescription") == v71.HumanoidDescription then
                v72.LayoutOrder = i;
                local name = v72:FindFirstChild("name");
                dprint(v71);

                if name and name.Text ~= v71.Name then
                    name.Text = v71.Name or "My Outfit";
                end;

                local IsFavorited = v71.IsFavorited;

                if IsFavorited ~= v72:GetAttribute("isFavorited") then
                    v72:SetAttribute("isFavorited", IsFavorited);
                end;
            else
                v72:Destroy();
                local success, result = pcall(createOutfitItemFrame, v71, i);

                if not success then
                    if v71 then
                        v71 = v71.Id;
                    end;

                    warn("[SavedOutfitsController] createOutfitItemFrame failed for outfit", v71, ":", result);
                    notifyDeveloperError(result);
                end;
            end;
        else
            local success, result = pcall(createOutfitItemFrame, v71, i);

            if not success then
                if v71 then
                    v71 = v71.Id;
                end;

                warn("[SavedOutfitsController] createOutfitItemFrame failed for outfit", v71, ":", result);
                notifyDeveloperError(result);
            end;
        end;
    end;

    for i, v in v68 do
        if not v70[i] then
            v:Destroy();
        end;
    end;

    local v73 = 0;

    for _, child in container2:GetChildren() do
        if child:GetAttribute("isItem") then
            v73 = v73 + 1;
        end;
    end;

    u5.ItemsLoaded = v73;
    local v74 = #u5.SortedOutfits == 0;
    local v75 = u5.CurrentTagFilter ~= "All";
    noOutfitsTagged.Visible = v74 and v75;

    if v74 then
        v74 = not v75;
    end;

    noSavedOutfits.Visible = v74;
    SelectMode.OnOutfitsUpdated();
    u11:Update();
end);

return u5;