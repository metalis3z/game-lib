-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local AvatarEditorService = game:GetService("AvatarEditorService");
local Modules = require(script.Parent.Parent.Modules);
local Emotes = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Emotes");
local container = Emotes:WaitForChild("container");
local wrapper = container:WaitForChild("wrapper");
local topBar = wrapper:WaitForChild("topBar");
local categoryDropdown = topBar:WaitForChild("categoryDropdown");
local searchContainer = wrapper:WaitForChild("searchContainer");
local searchInput = searchContainer:WaitForChild("wrapper"):WaitForChild("searchInput");
local clear = searchContainer:WaitForChild("clear");
local itemsSection = wrapper:WaitForChild("itemsSection");
local itemsWrapper = itemsSection:WaitForChild("itemsWrapper");
local container2 = itemsWrapper:WaitForChild("container");
local topFade = itemsSection:FindFirstChild("topFade");
local bottomFade = itemsSection:FindFirstChild("bottomFade");
ReplicatedStorage:WaitForChild("Remotes");
local Events = script.Parent.Parent.Events;
local DropdownController = require(Modules.Elements.DropdownController);
local ItemButton = require(Modules.Elements.ItemButton);
local ScrollFade = require(Modules.Elements.ScrollFade);
local LoadingController = require(Modules.Controllers.LoadingController);
local DraggablePanel = require(Modules.Utilities.DraggablePanel);
local v1 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u2 = TweenService:Create(container, v1, {
    GroupTransparency = 0
});
local u3 = TweenService:Create(container, v1, {
    GroupTransparency = 1
});
local u4 = {
    Popular = Enum.CatalogSortType.Relevance,
    Newest = Enum.CatalogSortType.RecentlyCreated,
    MostFavorited = Enum.CatalogSortType.MostFavorited
};
local u5 = { {
        key = "Popular",
        text = "Popular"
    }, {
        key = "Newest",
        text = "Newest"
    }, {
        key = "MostFavorited",
        text = "Most Favorited"
    } };
local u6 = {
    IsOpen = false
};
local u7 = {};
local u8 = nil;
topBar.Active = true;
local u9 = DraggablePanel.new(topBar, container, {
    ScreenGui = Emotes
});
local u10 = ScrollFade.new(itemsWrapper, topFade, bottomFade);
local u11 = {
    pages = nil,
    loading = false,
    active = false,
    keyword = nil,
    reachedEnd = true,
    thread = nil,
    sortType = Enum.CatalogSortType.Relevance
};
searchInput.ClearTextOnFocus = false;
clear.Visible = false;
searchInput:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 83
    -- upvalues: clear (copy), searchInput (copy)
    clear.Visible = searchInput.Text ~= "";
end);
clear.Activated:Connect(function() -- Line: 87
    -- upvalues: searchInput (copy)
    searchInput.Text = "";
    searchInput:CaptureFocus();
end);

local function clearConnections() -- Line: 94
    -- upvalues: u7 (copy)
    for _, v in u7 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u7);
end;

local function clearItems() -- Line: 103
    -- upvalues: container2 (copy)
    for _, child in container2:GetChildren() do
        if child:IsA("Frame") and (child:GetAttribute("isItem") or child.Name == "item") then
            child:Destroy();
        end;
    end;
end;

local function killSearch() -- Line: 111
    -- upvalues: u11 (copy)
    if u11.thread then
        pcall(task.cancel, u11.thread);
    end;

    u11.thread = nil;
    u11.pages = nil;
    u11.keyword = nil;
    u11.loading = false;
    u11.active = false;
    u11.reachedEnd = true;
end;

local function fadeNewItems(p12) -- Line: 128
    -- upvalues: container2 (copy), TweenService (copy)
    if not container2 then
        return;
    end;

    local v13 = {};

    for _, child in container2:GetChildren() do
        if child:GetAttribute("isItem") and (typeof(child.LayoutOrder) == "number" and p12 <= child.LayoutOrder) then
            local preview = child:FindFirstChild("preview");

            if preview then
                preview = preview:FindFirstChild("image");
            end;

            if preview and (preview:IsA("ImageLabel") and not preview:GetAttribute("Faded")) then
                table.insert(v13, child);
            end;
        end;
    end;

    table.sort(v13, function(p14, p15) -- Line: 144
        return (p14.LayoutOrder or 0) < (p15.LayoutOrder or 0);
    end);

    for i, v in v13 do
        task.delay((i - 1) * 0.035, function() -- Line: 149
            -- upvalues: v (copy), TweenService (ref)
            local preview = v:FindFirstChild("preview");

            if preview then
                preview = preview:FindFirstChild("image");
            end;

            if not preview or (not preview.Parent or preview:GetAttribute("Faded")) then
                return;
            end;

            local v16 = 0;

            while not preview.IsLoaded and v16 < 1 do
                task.wait(0.05);
                v16 = v16 + 0.05;
            end;

            if not preview or (not preview.Parent or preview:GetAttribute("Faded")) then
                return;
            end;

            TweenService:Create(preview, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageTransparency = 0
            }):Play();
            preview:SetAttribute("Faded", true);
        end);
    end;
end;

local function loadItems(p17) -- Line: 167
    -- upvalues: container2 (copy), ItemButton (copy), fadeNewItems (copy), u10 (copy)
    if not p17 or #p17 == 0 then
        return;
    end;

    local v18 = 0;

    for _, child in container2:GetChildren() do
        if child:GetAttribute("isItem") and (typeof(child.LayoutOrder) == "number" and v18 < child.LayoutOrder) then
            v18 = child.LayoutOrder;
        end;
    end;

    local v19 = v18 + 1;

    for i, v in p17 do
        if i % 3 == 0 then
            task.wait();
        end;

        local v20 = ItemButton.new({
            IsCatalogItem = true,
            IsFavoriteAvailable = true,
            AvatarPreviewOnHover = true,
            IsEmote = true,
            ItemDetails = v
        });
        v20.preview.Size = UDim2.fromScale(1, 0.74);
        v20.creator:Destroy();
        v20.name.Size = UDim2.fromScale(0.95, 0.095);
        v20.name.Position = UDim2.fromScale(0, 0.78);
        v20.price.Size = UDim2.fromScale(1, 0.103);
        v20.LayoutOrder = v19;
        v19 = v19 + 1;
        v20.Parent = container2;
    end;

    task.spawn(fadeNewItems, v18 + 1);
    u10:Update();
end;

local function startSearch(u21) -- Line: 204
    -- upvalues: u11 (copy), clearItems (copy), LoadingController (copy), itemsSection (copy), AvatarEditorService (copy), Events (copy), itemsWrapper (copy), loadItems (copy), u10 (copy)
    if u11.thread then
        pcall(task.cancel, u11.thread);
    end;

    u11.thread = nil;
    u11.pages = nil;
    u11.keyword = nil;
    u11.loading = false;
    u11.active = false;
    u11.reachedEnd = true;
    clearItems();
    LoadingController.DisplayLoading(itemsSection, "overlay");
    LoadingController.ClearGraphics("emotes");
    u11.active = true;
    u11.reachedEnd = false;
    u11.loading = true;
    u11.keyword = u21;
    u11.thread = task.spawn(function() -- Line: 215
        -- upvalues: u21 (copy), u11 (ref), AvatarEditorService (ref), LoadingController (ref), Events (ref), itemsWrapper (ref), loadItems (ref), u10 (ref)
        local u22 = CatalogSearchParams.new();
        u22.SearchKeyword = u21 or "";
        u22.AssetTypes = { Enum.AvatarAssetType.EmoteAnimation };
        u22.SortType = u11.sortType;
        u22.Limit = 30;
        local success, result = pcall(function() -- Line: 222
            -- upvalues: AvatarEditorService (ref), u22 (copy)
            return AvatarEditorService:SearchCatalog(u22);
        end);

        if not success then
            warn("[EmotesController] SearchCatalog failed:", result);
            u11.reachedEnd = true;
            u11.active = false;
            u11.loading = false;
            LoadingController.RemoveLoading();

            if typeof(result) == "string" and result:match("429") then
                Events.Notify:Fire("⚠️ Too many requests. Please slow down and try again.");
            end;

            return;
        end;

        u11.pages = result;
        local success2, result2 = pcall(function() -- Line: 240
            -- upvalues: result (copy)
            return result:GetCurrentPage();
        end);

        if not success2 then
            warn("[EmotesController] GetCurrentPage failed:", result2);
            u11.reachedEnd = true;
            u11.active = false;
            u11.loading = false;
            LoadingController.RemoveLoading();

            return;
        end;

        local v23 = {};

        for _, v in result2 or {} do
            table.insert(v23, v);
        end;

        while #v23 < 60 and (not result.IsFinished and pcall(function() -- Line: 261
            -- upvalues: result (copy)
            result:AdvanceToNextPageAsync();
        end)) do
            local success3, result3 = pcall(function() -- Line: 263
                -- upvalues: result (copy)
                return result:GetCurrentPage();
            end);

            if not success3 or (not result3 or #result3 == 0) then
                break;
            end;

            for _, v in result3 do
                table.insert(v23, v);
            end;
        end;

        u11.loading = false;
        LoadingController.RemoveLoading();

        if #v23 == 0 then
            LoadingController.DisplayGraphic(itemsWrapper, "emotes", "noResults");
            u11.reachedEnd = true;
            u11.active = false;
        else
            loadItems(v23);
            u11.reachedEnd = result.IsFinished == true;
            u11.active = not u11.reachedEnd;

            if u11.reachedEnd then
                LoadingController.DisplayGraphic(itemsWrapper, "emotes", "reachedEnd");
            end;
        end;

        u10:Update();
    end);
end;

local function loadNextPage() -- Line: 291
    -- upvalues: u11 (copy), LoadingController (copy), itemsWrapper (copy), loadItems (copy), u10 (copy), loadNextPage (copy)
    local pages = u11.pages;

    if not pages or (u11.reachedEnd or (u11.loading or pages.IsFinished)) then
        return;
    end;

    u11.loading = true;
    LoadingController.DisplayLoading(itemsWrapper, "foot");
    u11.thread = task.spawn(function() -- Line: 298
        -- upvalues: pages (copy), u11 (ref), LoadingController (ref), loadItems (ref), itemsWrapper (ref), u10 (ref), loadNextPage (ref)
        if not pcall(function() -- Line: 299
            -- upvalues: pages (ref)
            pages:AdvanceToNextPageAsync();
        end) then
            u11.loading = false;
            LoadingController.RemoveLoading();

            return;
        end;

        local success, result = pcall(function() -- Line: 306
            -- upvalues: pages (ref)
            return pages:GetCurrentPage();
        end);

        if not (success and result) then
            u11.loading = false;
            LoadingController.RemoveLoading();

            return;
        end;

        loadItems(result);
        u11.reachedEnd = pages.IsFinished == true;
        u11.loading = false;
        LoadingController.RemoveLoading();

        if u11.reachedEnd then
            LoadingController.DisplayGraphic(itemsWrapper, "emotes", "reachedEnd");
        end;

        u10:Update();

        if not u11.reachedEnd and isNearBottom() then
            loadNextPage();
        end;
    end);
end;

function isNearBottom()
    -- upvalues: itemsWrapper (copy)
    local Y = itemsWrapper.AbsoluteCanvasSize.Y;
    local Y2 = itemsWrapper.AbsoluteWindowSize.Y;

    if Y <= Y2 then
        return false;
    end;

    return itemsWrapper.CanvasPosition.Y >= Y - Y2 - Y2 * 0.3;
end;

itemsWrapper:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line: 344
    -- upvalues: u11 (copy), loadNextPage (copy)
    if not u11.active or (u11.reachedEnd or u11.loading) then
        return;
    end;

    if isNearBottom() then
        loadNextPage();
    end;
end);

local function onCategorySelected(p24, p25) -- Line: 353
    -- upvalues: u4 (copy), u11 (copy), searchInput (copy), startSearch (copy)
    local v26 = u4[p24] or Enum.CatalogSortType.Relevance;

    if v26 == u11.sortType and u11.keyword == searchInput.Text then
        return;
    end;

    u11.sortType = v26;
    startSearch(searchInput.Text);
end;

function u6.Close(p27) -- Line: 362
    -- upvalues: u6 (copy), Events (copy), u8 (ref), u7 (copy), u3 (copy), Emotes (copy)
    if not u6.IsOpen then
        return;
    end;

    u6.IsOpen = false;
    Events.InterfaceAction:Fire("Remove", script.Name);

    if p27 ~= true then
        Events.SetButtonsVisible:Fire("All");
    end;

    if u8 then
        u8:Close("EmotesClose");
    end;

    for _, v in u7 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u7);
    u3:Play();
    u3.Completed:Once(function() -- Line: 376
        -- upvalues: u6 (ref), Emotes (ref)
        if u6.IsOpen ~= true then
            Emotes.Enabled = false;
        end;
    end);
end;

function u6.Open(p28) -- Line: 383
    -- upvalues: u6 (copy), Events (copy), u9 (copy), Emotes (copy), container (copy), u2 (copy), u8 (ref), DropdownController (copy), categoryDropdown (copy), u5 (copy), onCategorySelected (copy), u7 (copy), topBar (copy), searchInput (copy), startSearch (copy), UserInputService (copy), container2 (copy), itemsWrapper (copy), u10 (copy)
    if u6.IsOpen then
        if p28 then
            u6.Close();
        end;

        return;
    end;

    u6.IsOpen = true;
    Events.InterfaceAction:Fire("Add", script.Name, u6.Close);
    Events.SetButtonsVisible:Fire("All", { "emotes", "pose", "booth", "settings" });
    u9:Reset();
    Emotes.Enabled = true;
    container.GroupTransparency = 1;
    u2:Play();

    if not u8 then
        u8 = DropdownController.new({
            reflectSelectionOnLabel = true,
            toggleButton = categoryDropdown.button,
            label = categoryDropdown.label,
            dropFrame = categoryDropdown.dropdown,
            choiceTemplate = categoryDropdown.dropdown.choice,
            getChoices = u5,
            onSelect = onCategorySelected
        });
        u8:SetCurrentChoice("Popular", "Popular", true);
    end;

    table.insert(u7, topBar.closeButton.Activated:Connect(u6.Close));
    table.insert(u7, searchInput.FocusLost:Connect(function(p29) -- Line: 415
        -- upvalues: startSearch (ref), searchInput (ref)
        if p29 then
            startSearch(searchInput.Text);
        end;
    end));
    table.insert(u7, UserInputService.InputBegan:Connect(function(p30, p31) -- Line: 421
        -- upvalues: searchInput (ref), startSearch (ref)
        if p31 then
            return;
        end;

        if (p30.KeyCode == Enum.KeyCode.Return or p30.KeyCode == Enum.KeyCode.KeypadEnter) and searchInput:IsFocused() then
            startSearch(searchInput.Text);
        end;
    end));
    local v32 = false;

    for _, child in container2:GetChildren() do
        if child:GetAttribute("isItem") then
            v32 = true;
            break;
        end;
    end;

    if v32 then
        u10:Update();

        return;
    end;

    itemsWrapper.CanvasPosition = Vector2.new(0, 0);
    startSearch(searchInput.Text);
end;

Emotes.Enabled = false;

for _, child in container2:GetChildren() do
    if child:IsA("Frame") and child.Name == "item" then
        child:Destroy();
    end;
end;

Events.DisplayEmotes.Event:Connect(u6.Open);

return u6;