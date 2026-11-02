-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Modules = require(script.Parent.Parent.Modules);
local CatalogUtilities = require(Modules.Shared.CatalogUtilities);
local ScrollFade = require(Modules.Elements.ScrollFade);
local LocalPlayer = Players.LocalPlayer;

local function dprint(...) -- Line: 13
end;

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local CommunityOutfits = PlayerGui:WaitForChild("CommunityOutfits");
local Catalog = PlayerGui:WaitForChild("Catalog");
local container = CommunityOutfits:WaitForChild("container");
local wrapper = container:WaitForChild("wrapper");
local outfitsSection = wrapper:WaitForChild("outfitsSection");
local outfits = outfitsSection:WaitForChild("outfits");
local container2 = outfits:WaitForChild("container");
local searchContainer = wrapper.topBar.searchContainer;
local searchInput = searchContainer.wrapper.searchInput;
local clear = searchContainer.clear;
searchInput.ClearTextOnFocus = false;
clear.Visible = false;
searchInput:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 34
    -- upvalues: clear (copy), searchInput (copy)
    clear.Visible = searchInput.Text ~= "";
end);
clear.Activated:Connect(function() -- Line: 38
    -- upvalues: searchInput (copy)
    searchInput.Text = "";
    searchInput:CaptureFocus();
end);
local activeFilters = wrapper:FindFirstChild("activeFilters");
local filter = script:FindFirstChild("filter");
local divider = script:FindFirstChild("divider");
local sortDropdown = wrapper.topBar:WaitForChild("sortDropdown");
local button = sortDropdown:WaitForChild("button");
local label = sortDropdown:WaitForChild("label");
local dropdown = sortDropdown:WaitForChild("dropdown");
local optionsContainer = wrapper.bottomBar.right:WaitForChild("optionsContainer");
local topFade = outfitsSection:FindFirstChild("topFade");
local v1 = outfitsSection:FindFirstChild("bottomFade") or outfitsSection:FindFirstChild("bottomBuffer");
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local Events = script.Parent.Parent.Events;
local ItemButton = require(Modules.Elements.ItemButton);
local CatalogController = require(Modules.Controllers.CatalogController);
local Options = require(script:WaitForChild("Options"));
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local AvatarPreviewController = require(Modules.Controllers.AvatarPreviewController);
local FavoriteController = require(Modules.Controllers.FavoriteController);
local DropdownController = require(Modules.Elements.DropdownController);
local LoadingController = require(Modules.Controllers.LoadingController);
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
    CurrentSortMode = "MostFavorited",
    ItemsLoaded = 0,
    IsLoadingNextPage = false,
    CurrentOffset = 0,
    CanLoadMore = true,
    ReachedEnd = false,
    CanSetActiveFiltersToVisible = true,
    LastTriedOnOutfit = nil,
    LastHoveredOutfit = nil,
    SortedOutfits = {}
};
local u6 = {};
local u7 = nil;
local u8 = false;
local u9 = setmetatable({}, {
    __mode = "k"
});
CommunityOutfits.Enabled = false;
local u10 = ScrollFade.new(outfits, topFade, v1);

local function updateTopBarSize() -- Line: 102
    -- upvalues: wrapper (copy), activeFilters (copy), outfitsSection (copy)
    local topBar = wrapper.topBar;
    local v11 = wrapper;
    local Scale = topBar.Size.Y.Scale;
    local v12 = not (activeFilters and activeFilters.Visible) and 0 or activeFilters.AbsoluteSize.Y;
    local v13 = v11.AbsoluteSize.Y * Scale;
    local v14 = math.max(34, v13) - v13;
    topBar.Size = UDim2.new(1, 0, Scale, v14);

    if outfitsSection then
        outfitsSection.Size = UDim2.new(outfitsSection.Size.X.Scale, outfitsSection.Size.X.Offset, outfitsSection.Size.Y.Scale, -v14 - v12);
    end;

    if activeFilters then
        activeFilters.Position = UDim2.new(0.5, 0, 0, (topBar.AbsolutePosition.Y + topBar.AbsoluteSize.Y + outfitsSection.AbsolutePosition.Y) / 2 - v11.AbsolutePosition.Y);
    end;
end;

function u5.UpdateUI() -- Line: 134
    -- upvalues: updateTopBarSize (copy)
    updateTopBarSize();
end;

function u5.UpdateActiveFilters(p15) -- Line: 138
    -- upvalues: u5 (copy), activeFilters (copy), Options (copy), CatalogUtilities (copy), filter (copy)
    if p15 == nil then
        if u5.CanSetActiveFiltersToVisible == false then
            if activeFilters then
                activeFilters.Visible = false;
            end;

            return;
        end;

        p15 = Options.ActiveFilters or {};
    end;

    if not activeFilters then
        return;
    end;

    local v16 = table.clone(p15);

    for _, child in activeFilters:GetChildren() do
        if child:IsA("TextButton") then
            local v17 = v16[child:GetAttribute("filterType")];

            if v17 == nil then
                child:Destroy();
            elseif v17 ~= child:GetAttribute("filterValue") or child:GetAttribute("filterType") and tostring(child:GetAttribute("filterType")):match("Price") then
                child:Destroy();
            end;
        end;
    end;

    for i, v in v16 do
        if not activeFilters:FindFirstChild(i) then
            local v18, v19;

            if i == "CreatorName" then
                v18 = "By " .. v;
                v19 = filter:Clone();
                v19.Name = i;
                v19:SetAttribute("filterType", i);
                v19:SetAttribute("filterValue", v);
                v19.label.Text = v18;
                v19.Activated:Connect(function() -- Line: 203
                    -- upvalues: i (copy), Options (ref), u5 (ref)
                    if i == "MinPrice" or i == "MaxPrice" then
                        Options.ResetActiveFilter({ "MinPrice", "MaxPrice" });
                    else
                        Options.ResetActiveFilter(i);
                    end;

                    u5.UpdateUI();
                end);
                v19.Parent = activeFilters;
            else
                if i == "RigType" then
                    v18 = "Only " .. v;
                    v19 = filter:Clone();
                    v19.Name = i;
                    v19:SetAttribute("filterType", i);
                    v19:SetAttribute("filterValue", v);
                    v19.label.Text = v18;
                    v19.Activated:Connect(function() -- Line: 203
                        -- upvalues: i (copy), Options (ref), u5 (ref)
                        if i == "MinPrice" or i == "MaxPrice" then
                            Options.ResetActiveFilter({ "MinPrice", "MaxPrice" });
                        else
                            Options.ResetActiveFilter(i);
                        end;

                        u5.UpdateUI();
                    end);
                    v19.Parent = activeFilters;
                end;

                if i == "OnlyFavorites" and v == true then
                    v18 = "My Favorites";
                    v19 = filter:Clone();
                    v19.Name = i;
                    v19:SetAttribute("filterType", i);
                    v19:SetAttribute("filterValue", v);
                    v19.label.Text = v18;
                    v19.Activated:Connect(function() -- Line: 203
                        -- upvalues: i (copy), Options (ref), u5 (ref)
                        if i == "MinPrice" or i == "MaxPrice" then
                            Options.ResetActiveFilter({ "MinPrice", "MaxPrice" });
                        else
                            Options.ResetActiveFilter(i);
                        end;

                        u5.UpdateUI();
                    end);
                    v19.Parent = activeFilters;
                end;

                if i == "MinPrice" or i == "MaxPrice" then
                    local MinPrice = activeFilters:FindFirstChild("MinPrice");
                    local MaxPrice = activeFilters:FindFirstChild("MaxPrice");

                    if MinPrice then
                        MinPrice:Destroy();
                    end;

                    if MaxPrice then
                        MaxPrice:Destroy();
                    end;

                    v18 = "Prices ranging from " .. (not v16.MinPrice and "0" or CatalogUtilities.FormatNumberDetailed(v16.MinPrice)) .. " to " .. (not v16.MaxPrice and "∞" or CatalogUtilities.FormatNumberDetailed(v16.MaxPrice));
                    v19 = filter:Clone();
                    v19.Name = i;
                    v19:SetAttribute("filterType", i);
                    v19:SetAttribute("filterValue", v);
                    v19.label.Text = v18;
                    v19.Activated:Connect(function() -- Line: 203
                        -- upvalues: i (copy), Options (ref), u5 (ref)
                        if i == "MinPrice" or i == "MaxPrice" then
                            Options.ResetActiveFilter({ "MinPrice", "MaxPrice" });
                        else
                            Options.ResetActiveFilter(i);
                        end;

                        u5.UpdateUI();
                    end);
                    v19.Parent = activeFilters;
                end;
            end;
        end;
    end;

    local v20;

    if next(v16) == nil then
        v20 = false;
    else
        v20 = u5.CanSetActiveFiltersToVisible ~= false;
    end;

    activeFilters.Visible = v20;
    print("visible:", activeFilters.Visible, v16, u5.CanSetActiveFiltersToVisible);
    u5.UpdateUI();
end;

local function clearConnections() -- Line: 220
    -- upvalues: u6 (copy)
    for _, v in u6 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u6);
end;

local function normalizeOutfitData(p21) -- Line: 229
    -- upvalues: HumanoidDescriptionController (copy)
    local v22, v23;

    if typeof(p21.HumanoidDescription) == "string" then
        v22, v23 = HumanoidDescriptionController.DeserializeHumanoidDescription(p21.HumanoidDescription);
    else
        v22 = p21.HumanoidDescription;
        v23 = p21.RigType or Enum.HumanoidRigType.R15;
    end;

    return {
        Name = p21.Name,
        Id = p21.Id,
        HumanoidDescription = v22,
        CreatorId = p21.CreatorId,
        RigType = v23,
        Created = p21.Created,
        Updated = p21.Updated,
        FavoriteCount = p21.FavoriteCount or 0,
        CommentCount = p21.CommentCount or 0,
        ShareCode = p21.ShareCode,
        ViewCount = p21.ViewCount or 0,
        WornCount = p21.WornCount or 0,
        IsFavorited = p21.IsFavorited,
        TotalPrice = p21.TotalPrice
    };
end;

local function createOutfitItemFrame(u24, p25) -- Line: 257
    -- upvalues: HumanoidDescriptionController (copy), ItemButton (copy), normalizeOutfitData (copy), u5 (copy), u9 (copy), container2 (copy)
    local _, _ = HumanoidDescriptionController.DeserializeHumanoidDescription(u24.HumanoidDescription);
    local v26, v27 = ItemButton.newOutfit({
        OutfitType = "CommunityOutfit",
        IsFavoriteAvailable = true,
        SkeletonLoading = true,
        FitOutfit = true,
        OutfitDetails = normalizeOutfitData(u24),

        OnTryOn = function() -- Line: 266, Name: OnTryOn
            -- upvalues: u5 (ref), u24 (copy)
            u5.LastTriedOnOutfit = u24;
        end
    });
    v27.UpdateName(u24.Name);
    v26.LayoutOrder = u24.LayoutOrder or 1000 + p25;
    v26:SetAttribute("serializedDescription", u24.HumanoidDescription);
    u9[v26] = v27;
    v26.MouseEnter:Connect(function() -- Line: 275
        -- upvalues: u5 (ref), u24 (copy)
        u5.LastHoveredOutfit = u24;
    end);
    v26.Parent = container2;
end;

local function unloadAllTiles() -- Line: 281
    -- upvalues: container2 (copy), u9 (copy)
    for _, child in container2:GetChildren() do
        if child:GetAttribute("isItem") then
            local v28 = u9[child];

            if v28 and v28.Unload then
                v28.Unload();
            end;
        end;
    end;
end;

local function loadAllTiles() -- Line: 290
    -- upvalues: container2 (copy), u9 (copy)
    task.spawn(function() -- Line: 291
        -- upvalues: container2 (ref), u9 (ref)
        local v29 = 0;

        for _, child in container2:GetChildren() do
            if child:GetAttribute("isItem") then
                local v30 = u9[child];

                if v30 and v30.Load then
                    v30.Load();
                end;

                v29 = v29 + 1;

                if v29 % 8 == 0 then
                    task.wait();
                end;
            end;
        end;
    end);
end;

function u5.GetContinueBrowsingOutfit() -- Line: 306
    -- upvalues: u5 (copy)
    if u5.LastTriedOnOutfit then
        return u5.LastTriedOnOutfit;
    end;

    if u5.LastHoveredOutfit then
        return u5.LastHoveredOutfit;
    end;

    return u5.SortedOutfits[1];
end;

local u31 = nil;

local function fetchOutfits(p32, p33) -- Line: 320
    -- upvalues: u5 (copy), Options (copy), u31 (ref), Remotes (copy)
    if not p33 then
        u5.CurrentOffset = 0;
        u5.CanLoadMore = true;
        u5.ReachedEnd = false;
        table.clear(u5.SortedOutfits);
    end;

    local v34 = Options.GetOptions();
    local v35 = {
        Limit = 24,
        Offset = u5.CurrentOffset,
        RigType = v34.RigType,
        CreatorName = v34.CreatorName,
        OnlyFavorites = v34.OnlyFavorites,
        MinPrice = v34.MinPrice,
        MaxPrice = v34.MaxPrice
    };
    local v36;

    if u31 == nil then
        v36 = false;
    else
        v36 = p32 == u31;
    end;

    v35.FromTopic = v36;
    local v37, v38 = Remotes.CommunityOutfitsAction:InvokeServer("SearchOutfits", p32, u5.CurrentSortMode, v35);

    if not (v37 and v38) then
        u5.CanLoadMore = false;

        return;
    end;

    local v39 = #v38;

    if v39 < 24 then
        u5.CanLoadMore = false;
    end;

    for _, v in v38 do
        table.insert(u5.SortedOutfits, v);
    end;

    local v40 = u5;
    v40.CurrentOffset = v40.CurrentOffset + v39;
end;

function u5.LoadNextChunk() -- Line: 361
    -- upvalues: u5 (copy), LoadingController (copy), outfits (copy), fetchOutfits (copy), searchInput (copy), FavoriteController (copy), createOutfitItemFrame (copy), u10 (copy)
    if u5.IsLoadingNextPage then
        return;
    end;

    if u5.ReachedEnd then
        return;
    end;

    if #u5.SortedOutfits - u5.ItemsLoaded <= 0 then
        if not u5.CanLoadMore then
            LoadingController.DisplayGraphic(outfits, "foot", "reachedEnd");
            u5.ReachedEnd = true;

            return;
        end;

        u5.IsLoadingNextPage = true;
        LoadingController.DisplayLoading(outfits, "foot");
        fetchOutfits(searchInput.Text, true);
        LoadingController.RemoveLoading();
        u5.IsLoadingNextPage = false;
    end;

    u5.IsLoadingNextPage = true;
    local v41 = u5.ItemsLoaded + 1;
    local v42 = math.min(v41 + 24 - 1, #u5.SortedOutfits);
    local v43 = {};

    for i = v41, v42 do
        table.insert(v43, u5.SortedOutfits[i].Id);
    end;

    local _, v44 = FavoriteController.AreCommunityOutfitsFavorited(v43);
    local v45 = v44 or {};

    for i = v41, v42 do
        local v46 = u5.SortedOutfits[i];

        if v46 then
            v46.IsFavorited = v45[v46.Id];
            createOutfitItemFrame(v46, i);
        end;

        if i % 8 == 0 then
            task.wait();
        end;
    end;

    u5.ItemsLoaded = v42;
    u5.IsLoadingNextPage = false;

    if not u5.CanLoadMore and u5.ItemsLoaded >= #u5.SortedOutfits then
        LoadingController.DisplayGraphic(outfits, "foot", "reachedEnd");
        u5.ReachedEnd = true;
    end;

    u10:Update();
end;

local function loadOutfits() -- Line: 416
    -- upvalues: u7 (ref), LoadingController (copy), outfitsSection (copy), container2 (copy), u5 (copy), fetchOutfits (copy), searchInput (copy), outfits (copy)
    if u7 then
        task.cancel(u7);
    end;

    u7 = task.spawn(function() -- Line: 419
        -- upvalues: LoadingController (ref), outfitsSection (ref), container2 (ref), u5 (ref), fetchOutfits (ref), searchInput (ref), outfits (ref)
        LoadingController.DisplayLoading(outfitsSection, "overlay");
        LoadingController.ClearGraphics("communityOutfits");
        LoadingController.ClearGraphics("foot");
        container2.Visible = false;

        for i, child in container2:GetChildren() do
            if child:GetAttribute("isItem") then
                child:Destroy();

                if i % 5 == 0 then
                    task.wait();
                end;
            end;
        end;

        u5.ItemsLoaded = 0;
        u5.IsLoadingNextPage = false;
        u5.ReachedEnd = false;
        fetchOutfits(searchInput.Text, false);
        container2.Visible = true;
        outfits.CanvasPosition = Vector2.new(0, 0);
        LoadingController.RemoveLoading();

        if #u5.SortedOutfits == 0 then
            LoadingController.DisplayGraphic(outfits, "communityOutfits", "noResults");

            return;
        end;

        u5.LoadNextChunk();
    end);
end;

function u5.Close(p47) -- Line: 456
    -- upvalues: u5 (copy), u6 (copy), Events (copy), u4 (copy), TweenService (copy), Catalog (copy), u2 (copy), CommunityOutfits (copy), outfitsSection (copy), unloadAllTiles (copy), CatalogController (copy)
    if not u5.IsOpen then
        return;
    end;

    u5.IsOpen = false;

    for _, v in u6 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u6);

    if p47 ~= true then
        Events.SetButtonsVisible:Fire("All");
    end;

    Events.InterfaceAction:Fire("Remove", script.Name);
    u4:Play();

    if p47 ~= true then
        TweenService:Create(Catalog.container, u2, {
            GroupTransparency = 1
        }):Play();
    end;

    u4.Completed:Once(function() -- Line: 468
        -- upvalues: u5 (ref), CommunityOutfits (ref), outfitsSection (ref), unloadAllTiles (ref), Catalog (ref), CatalogController (ref)
        if u5.IsOpen ~= true then
            CommunityOutfits.Enabled = false;
            outfitsSection.Visible = false;
            unloadAllTiles();
            Catalog.container.catalogSection.Visible = true;

            if CatalogController.IsOpen ~= true then
                Catalog.Enabled = false;
                CatalogController.ClearConnections();
            end;
        end;
    end);
end;

function u5.Open(p48, p49) -- Line: 487
    -- upvalues: u5 (copy), u31 (ref), searchInput (copy), u7 (ref), LoadingController (copy), outfitsSection (copy), container2 (copy), fetchOutfits (copy), outfits (copy), Events (copy), Remotes (copy), CommunityOutfits (copy), Catalog (copy), CatalogController (copy), container (copy), u3 (copy), TweenService (copy), u2 (copy), u6 (copy), wrapper (copy), UserInputService (copy), u8 (ref), Options (copy), optionsContainer (copy), dprint (copy), DropdownController (copy), button (copy), label (copy), dropdown (copy), divider (copy), normalizeOutfitData (copy), LocalPlayer (copy), HumanoidDescriptionController (copy), AvatarPreviewController (copy), u9 (copy)
    if u5.IsOpen then
        if p48 then
            u5.Close();

            return;
        end;

        if p49 ~= "Trending" and p49 ~= "Newest" then
            if p49 then
                u31 = p49;
                searchInput.Text = p49;
                u5.CurrentSortMode = "Trending";

                if u7 then
                    task.cancel(u7);
                end;

                u7 = task.spawn(function() -- Line: 419
                    -- upvalues: LoadingController (ref), outfitsSection (ref), container2 (ref), u5 (ref), fetchOutfits (ref), searchInput (ref), outfits (ref)
                    LoadingController.DisplayLoading(outfitsSection, "overlay");
                    LoadingController.ClearGraphics("communityOutfits");
                    LoadingController.ClearGraphics("foot");
                    container2.Visible = false;

                    for i, child in container2:GetChildren() do
                        if child:GetAttribute("isItem") then
                            child:Destroy();

                            if i % 5 == 0 then
                                task.wait();
                            end;
                        end;
                    end;

                    u5.ItemsLoaded = 0;
                    u5.IsLoadingNextPage = false;
                    u5.ReachedEnd = false;
                    fetchOutfits(searchInput.Text, false);
                    container2.Visible = true;
                    outfits.CanvasPosition = Vector2.new(0, 0);
                    LoadingController.RemoveLoading();

                    if #u5.SortedOutfits == 0 then
                        LoadingController.DisplayGraphic(outfits, "communityOutfits", "noResults");

                        return;
                    end;

                    u5.LoadNextChunk();
                end);
            end;

            return;
        end;

        u31 = nil;
        searchInput.Text = "";
        u5.CurrentSortMode = p49;

        if u7 then
            task.cancel(u7);
        end;

        u7 = task.spawn(function() -- Line: 419
            -- upvalues: LoadingController (ref), outfitsSection (ref), container2 (ref), u5 (ref), fetchOutfits (ref), searchInput (ref), outfits (ref)
            LoadingController.DisplayLoading(outfitsSection, "overlay");
            LoadingController.ClearGraphics("communityOutfits");
            LoadingController.ClearGraphics("foot");
            container2.Visible = false;

            for i, child in container2:GetChildren() do
                if child:GetAttribute("isItem") then
                    child:Destroy();

                    if i % 5 == 0 then
                        task.wait();
                    end;
                end;
            end;

            u5.ItemsLoaded = 0;
            u5.IsLoadingNextPage = false;
            u5.ReachedEnd = false;
            fetchOutfits(searchInput.Text, false);
            container2.Visible = true;
            outfits.CanvasPosition = Vector2.new(0, 0);
            LoadingController.RemoveLoading();

            if #u5.SortedOutfits == 0 then
                LoadingController.DisplayGraphic(outfits, "communityOutfits", "noResults");

                return;
            end;

            u5.LoadNextChunk();
        end);

        return;
    end;

    u5.IsOpen = true;

    if p49 == "Trending" or p49 == "Newest" then
        u31 = nil;
        searchInput.Text = "";
        u5.CurrentSortMode = p49;
    elseif p49 then
        u31 = p49;
        searchInput.Text = p49;
        u5.CurrentSortMode = "Trending";
    end;

    Events.SetButtonsVisible:Fire({ "Undo", "Redo" });
    pcall(Remotes.AnalyticsEvent.FireServer, Remotes.AnalyticsEvent, "CommunityOpened");
    Events.InterfaceAction:Fire("Add", script.Name, u5.Close);
    CommunityOutfits.Enabled = true;
    Catalog.Enabled = true;
    Catalog.container.catalogSection.Visible = false;
    CatalogController.SetupQuickActions(u5.Open);
    container.GroupTransparency = 1;
    u3:Play();
    TweenService:Create(Catalog.container, u2, {
        GroupTransparency = 0
    }):Play();
    outfitsSection.Visible = true;
    table.insert(u6, wrapper.topBar.closeButton.Activated:Connect(u5.Close));
    table.insert(u6, wrapper.topBar.returnButton.Activated:Connect(function() -- Line: 535
        -- upvalues: u5 (ref), Events (ref)
        u5.Close();
        Events.DisplayOutfits:Fire();
    end));
    table.insert(u6, searchInput.FocusLost:Connect(function(p50) -- Line: 540
        -- upvalues: u7 (ref), LoadingController (ref), outfitsSection (ref), container2 (ref), u5 (ref), fetchOutfits (ref), searchInput (ref), outfits (ref)
        if p50 then
            if u7 then
                task.cancel(u7);
            end;

            u7 = task.spawn(function() -- Line: 419
                -- upvalues: LoadingController (ref), outfitsSection (ref), container2 (ref), u5 (ref), fetchOutfits (ref), searchInput (ref), outfits (ref)
                LoadingController.DisplayLoading(outfitsSection, "overlay");
                LoadingController.ClearGraphics("communityOutfits");
                LoadingController.ClearGraphics("foot");
                container2.Visible = false;

                for i, child in container2:GetChildren() do
                    if child:GetAttribute("isItem") then
                        child:Destroy();

                        if i % 5 == 0 then
                            task.wait();
                        end;
                    end;
                end;

                u5.ItemsLoaded = 0;
                u5.IsLoadingNextPage = false;
                u5.ReachedEnd = false;
                fetchOutfits(searchInput.Text, false);
                container2.Visible = true;
                outfits.CanvasPosition = Vector2.new(0, 0);
                LoadingController.RemoveLoading();

                if #u5.SortedOutfits == 0 then
                    LoadingController.DisplayGraphic(outfits, "communityOutfits", "noResults");

                    return;
                end;

                u5.LoadNextChunk();
            end);
        end;
    end));
    table.insert(u6, UserInputService.InputBegan:Connect(function(p51, p52) -- Line: 546
        -- upvalues: searchInput (ref), u7 (ref), LoadingController (ref), outfitsSection (ref), container2 (ref), u5 (ref), fetchOutfits (ref), outfits (ref)
        if p52 then
            return;
        end;

        if (p51.KeyCode == Enum.KeyCode.Return or p51.KeyCode == Enum.KeyCode.KeypadEnter) and searchInput:IsFocused() then
            if u7 then
                task.cancel(u7);
            end;

            u7 = task.spawn(function() -- Line: 419
                -- upvalues: LoadingController (ref), outfitsSection (ref), container2 (ref), u5 (ref), fetchOutfits (ref), searchInput (ref), outfits (ref)
                LoadingController.DisplayLoading(outfitsSection, "overlay");
                LoadingController.ClearGraphics("communityOutfits");
                LoadingController.ClearGraphics("foot");
                container2.Visible = false;

                for i, child in container2:GetChildren() do
                    if child:GetAttribute("isItem") then
                        child:Destroy();

                        if i % 5 == 0 then
                            task.wait();
                        end;
                    end;
                end;

                u5.ItemsLoaded = 0;
                u5.IsLoadingNextPage = false;
                u5.ReachedEnd = false;
                fetchOutfits(searchInput.Text, false);
                container2.Visible = true;
                outfits.CanvasPosition = Vector2.new(0, 0);
                LoadingController.RemoveLoading();

                if #u5.SortedOutfits == 0 then
                    LoadingController.DisplayGraphic(outfits, "communityOutfits", "noResults");

                    return;
                end;

                u5.LoadNextChunk();
            end);
        end;
    end));
    local v53 = wrapper:GetPropertyChangedSignal("AbsoluteSize");
    table.insert(u6, v53:Connect(u5.UpdateUI));

    if not u8 then
        Options.Setup(optionsContainer);
        u8 = true;
    end;

    if not u5._hasLoaded and p49 == nil then
        local v54, v55 = Remotes.CommunityOutfitsAction:InvokeServer("SearchOutfits", "", "Trending", {
            Offset = 0,
            Limit = 12
        });
        u5.CurrentSortMode = v54 and (typeof(v55) == "table" and #v55 >= 12) and "Trending" or "MostFavorited";
    end;

    table.insert(u6, Options.OnOptionsApplied:Connect(function(p56, p57) -- Line: 577
        -- upvalues: dprint (ref), u5 (ref), u7 (ref), LoadingController (ref), outfitsSection (ref), container2 (ref), fetchOutfits (ref), searchInput (ref), outfits (ref)
        dprint("update filters");
        u5.UpdateActiveFilters(p57);

        if u7 then
            task.cancel(u7);
        end;

        u7 = task.spawn(function() -- Line: 419
            -- upvalues: LoadingController (ref), outfitsSection (ref), container2 (ref), u5 (ref), fetchOutfits (ref), searchInput (ref), outfits (ref)
            LoadingController.DisplayLoading(outfitsSection, "overlay");
            LoadingController.ClearGraphics("communityOutfits");
            LoadingController.ClearGraphics("foot");
            container2.Visible = false;

            for i, child in container2:GetChildren() do
                if child:GetAttribute("isItem") then
                    child:Destroy();

                    if i % 5 == 0 then
                        task.wait();
                    end;
                end;
            end;

            u5.ItemsLoaded = 0;
            u5.IsLoadingNextPage = false;
            u5.ReachedEnd = false;
            fetchOutfits(searchInput.Text, false);
            container2.Visible = true;
            outfits.CanvasPosition = Vector2.new(0, 0);
            LoadingController.RemoveLoading();

            if #u5.SortedOutfits == 0 then
                LoadingController.DisplayGraphic(outfits, "communityOutfits", "noResults");

                return;
            end;

            u5.LoadNextChunk();
        end);
    end));
    u5.UpdateActiveFilters(Options.ActiveFilters);
    local u59 = DropdownController.new({
        reflectSelectionOnLabel = true,
        toggleButton = button,
        label = label,
        dropFrame = dropdown,
        choiceTemplate = dropdown:FindFirstChild("choice"),
        dividerTemplate = divider,

        getChoices = function() -- Line: 592, Name: getChoices
            return { {
                    key = "Trending",
                    text = "Trending",
                    layoutOrder = 1
                }, {
                    key = "MostPopular",
                    text = "Most Popular",
                    layoutOrder = 2
                }, {
                    key = "MostFavorited",
                    text = "Most Favorited",
                    layoutOrder = 3
                }, {
                    key = "Newest",
                    text = "Newest",
                    layoutOrder = 4
                }, {
                    key = "Oldest",
                    text = "Oldest",
                    layoutOrder = 5
                }, {
                    key = "PriceLowToHigh",
                    text = "Price: Low to High",
                    layoutOrder = 6
                }, {
                    key = "PriceHighToLow",
                    text = "Price: High to Low",
                    layoutOrder = 7
                } };
        end,

        onSelect = function(p58) -- Line: 605, Name: onSelect
            -- upvalues: u5 (ref), u7 (ref), LoadingController (ref), outfitsSection (ref), container2 (ref), fetchOutfits (ref), searchInput (ref), outfits (ref)
            u5.CurrentSortMode = p58;

            if u7 then
                task.cancel(u7);
            end;

            u7 = task.spawn(function() -- Line: 419
                -- upvalues: LoadingController (ref), outfitsSection (ref), container2 (ref), u5 (ref), fetchOutfits (ref), searchInput (ref), outfits (ref)
                LoadingController.DisplayLoading(outfitsSection, "overlay");
                LoadingController.ClearGraphics("communityOutfits");
                LoadingController.ClearGraphics("foot");
                container2.Visible = false;

                for i, child in container2:GetChildren() do
                    if child:GetAttribute("isItem") then
                        child:Destroy();

                        if i % 5 == 0 then
                            task.wait();
                        end;
                    end;
                end;

                u5.ItemsLoaded = 0;
                u5.IsLoadingNextPage = false;
                u5.ReachedEnd = false;
                fetchOutfits(searchInput.Text, false);
                container2.Visible = true;
                outfits.CanvasPosition = Vector2.new(0, 0);
                LoadingController.RemoveLoading();

                if #u5.SortedOutfits == 0 then
                    LoadingController.DisplayGraphic(outfits, "communityOutfits", "noResults");

                    return;
                end;

                u5.LoadNextChunk();
            end);
        end
    });
    u59:SetCurrentChoice(u5.CurrentSortMode, nil, true);
    table.insert(u6, {
        Disconnect = function() -- Line: 612, Name: Disconnect
            -- upvalues: u59 (copy)
            u59:Destroy();
        end
    });
    table.insert(u6, wrapper.bottomBar.left.publishOutfitContainer.button.Activated:Connect(function() -- Line: 617
        -- upvalues: Events (ref)
        Events.DisplayPublishOutfit:Fire(false, nil, {
            Source = "Self"
        });
    end));
    table.insert(u6, wrapper.topBar.outfitCodesContainer.button.Activated:Connect(function() -- Line: 625
        -- upvalues: Events (ref), Remotes (ref), normalizeOutfitData (ref)
        local v60 = Events.PromptInputDialog:Invoke({
            Title = "Enter Outfit Code",
            Description = "Enter an outfit code below to view it.\n\n<i>ⓘ Find outfit codes on Community Outfits pages.</i>",
            YesText = "Enter Code",
            PlaceholderText = "Outfit Code"
        });

        if v60 then
            local v61 = v60:gsub("[%s#]", ""):upper();
            print(v61);
            local v62, v63 = Remotes.CommunityOutfitsAction:InvokeServer("GetOutfitByCode", v61);

            if v62 and v63 then
                Events.Notify:Fire("✅ Found outfit!");
                local v64 = normalizeOutfitData(v63);
                Events.DisplayContentPage:Fire({
                    Type = "CommunityOutfit",
                    OutfitDetails = v64
                });

                return;
            end;

            Events.Notify:Fire("❌ Couldn\'t find an outfit with this code.");
        end;
    end));
    table.insert(u6, wrapper.bottomBar.left.myOutfitsContainer.button.Activated:Connect(function() -- Line: 650
        -- upvalues: Options (ref), LocalPlayer (ref)
        Options.SetActiveFilter({
            OnlyFavorites = false,
            CreatorName = LocalPlayer.Name
        });
    end));
    table.insert(u6, wrapper.bottomBar.left.myFavoritesContainer.button.Activated:Connect(function() -- Line: 657
        -- upvalues: Options (ref)
        Options.SetActiveFilter({
            CreatorName = nil,
            OnlyFavorites = true
        });
    end));
    wrapper.bottomBar.left.myOutfitsContainer.image.Image = `rbxthumb://type=AvatarHeadShot&id={LocalPlayer.UserId}&w=100&h=100`;

    if HumanoidDescriptionController.HumanoidDescription then
        AvatarPreviewController.CurrentCatalogPreviewObject:Update(HumanoidDescriptionController.HumanoidDescription, {
            BypassIsApplied = true
        });
    end;

    AvatarPreviewController.CurrentCatalogPreviewObject:Redraw();

    if u5._hasLoaded and not p49 then
        outfitsSection.Visible = true;
        container2.Visible = true;
        task.spawn(function() -- Line: 291
            -- upvalues: container2 (ref), u9 (ref)
            local v65 = 0;

            for _, child in container2:GetChildren() do
                if child:GetAttribute("isItem") then
                    local v66 = u9[child];

                    if v66 and v66.Load then
                        v66.Load();
                    end;

                    v65 = v65 + 1;

                    if v65 % 8 == 0 then
                        task.wait();
                    end;
                end;
            end;
        end);

        return;
    end;

    u5._hasLoaded = true;

    if u7 then
        task.cancel(u7);
    end;

    u7 = task.spawn(function() -- Line: 419
        -- upvalues: LoadingController (ref), outfitsSection (ref), container2 (ref), u5 (ref), fetchOutfits (ref), searchInput (ref), outfits (ref)
        LoadingController.DisplayLoading(outfitsSection, "overlay");
        LoadingController.ClearGraphics("communityOutfits");
        LoadingController.ClearGraphics("foot");
        container2.Visible = false;

        for i, child in container2:GetChildren() do
            if child:GetAttribute("isItem") then
                child:Destroy();

                if i % 5 == 0 then
                    task.wait();
                end;
            end;
        end;

        u5.ItemsLoaded = 0;
        u5.IsLoadingNextPage = false;
        u5.ReachedEnd = false;
        fetchOutfits(searchInput.Text, false);
        container2.Visible = true;
        outfits.CanvasPosition = Vector2.new(0, 0);
        LoadingController.RemoveLoading();

        if #u5.SortedOutfits == 0 then
            LoadingController.DisplayGraphic(outfits, "communityOutfits", "noResults");

            return;
        end;

        u5.LoadNextChunk();
    end);
end;

local function isNearBottom() -- Line: 682
    -- upvalues: outfits (copy)
    local Y = outfits.AbsoluteCanvasSize.Y;
    local Y2 = outfits.AbsoluteWindowSize.Y;

    if Y <= Y2 then
        return false;
    end;

    return outfits.CanvasPosition.Y >= Y - Y2 - Y2 * 0.3;
end;

outfits:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line: 694
    -- upvalues: outfits (copy), u5 (copy)
    local Y = outfits.AbsoluteCanvasSize.Y;
    local Y2 = outfits.AbsoluteWindowSize.Y;
    local v67;

    if Y <= Y2 then
        v67 = false;
    else
        v67 = outfits.CanvasPosition.Y >= Y - Y2 - Y2 * 0.3;
    end;

    if v67 then
        u5.LoadNextChunk();
    end;
end);
Events.DisplayCommunityOutfits.Event:Connect(u5.Open);

return u5;