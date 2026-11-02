-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AvatarEditorService = game:GetService("AvatarEditorService");
game:GetService("CaptureService");
game:GetService("AssetService");
game:GetService("GuiService");
local Modules = require(script.Parent.Parent.Modules);
local ThemeController = require(Modules.Controllers.ThemeController);
local LocalPlayer = Players.LocalPlayer;
local ModeratorPanel = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ModeratorPanel");
local container = ModeratorPanel:WaitForChild("container");
local wrapper = container:WaitForChild("wrapper");
local bottomBar = wrapper.bottomBar;
local sidebar = wrapper.sidebar;
local categoriesContainer = sidebar.categoriesContainer;
local mainSection = wrapper.mainSection;
local communityOutfitReports = mainSection.communityOutfitReports;
local layoutBypass = communityOutfitReports.layoutBypass;
local playerOutfitReports = mainSection.playerOutfitReports;
local layoutBypass2 = playerOutfitReports.layoutBypass;
local reviewPlayer = mainSection.reviewPlayer;
task.spawn(function() -- Line: 34
    -- upvalues: ModeratorPanel (copy), mainSection (copy)
    ModeratorPanel:SetAttribute("ReferenceResolution", Vector2.new(1780, 945));
    local dashboard = mainSection:WaitForChild("dashboard", 10);

    if not dashboard then
        return;
    end;

    dashboard:SetAttribute("SkipTheme", true);

    for _, descendant in ipairs(dashboard:GetDescendants()) do
        if descendant:IsA("GuiObject") or (descendant:IsA("UIStroke") or descendant:IsA("UIGradient")) then
            descendant:SetAttribute("SkipTheme", true);
        end;
    end;

    local CollectionService = game:GetService("CollectionService");

    for _, v in {
        dashboard.home.actionsCard.explore,
        dashboard.home.typesCard.explore,
        dashboard.home.modsCard.explore,
        dashboard.home.trendsCard.explore,
        dashboard.home.detectionCard.explore,
        dashboard.home.serverCard.explore,
        dashboard.detail.back
    } do
        CollectionService:AddTag(v, "UIEffect");
    end;
end);
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local Events = script.Parent.Parent.Events;
local u1 = { {
        label = "Inappropriate or offensive content."
    }, {
        label = "Explicit or suggestive content."
    }, {
        label = "Violation of our content guidelines."
    } };
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
require(Modules.Utilities.GetBatchItemDetails);
require(Modules.Services.ItemOwnershipService);
require(Modules.Elements.ItemButton);
require(Modules.Shared.CatalogUtilities);
require(Modules.Controllers.LoadingController);
local AvatarPreviewController = require(Modules.Controllers.AvatarPreviewController);
local TimeUtilities = require(Modules.Shared.TimeUtilities);
local u2 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u3 = TweenService:Create(container, u2, {
    GroupTransparency = 0
});
local u4 = TweenService:Create(container, u2, {
    GroupTransparency = 1
});
local u5 = {
    IsOpen = false,
    CurrentCategory = nil,
    CategoryConnections = {}
};
local u6 = {};
local u7 = nil;
local u8 = false;
task.spawn(function() -- Line: 91
    -- upvalues: Remotes (copy), u8 (ref)
    while true do
        local v9, v10 = Remotes.GetFlag:InvokeServer("IsContentModerator");
        local v11, v12 = Remotes.GetFlag:InvokeServer("IsTrialModerator");

        if v9 ~= true or v11 ~= true then
            task.wait(1);
        end;

        if v9 == true and v11 == true then
            local v13;

            if v12 == true then
                v13 = not (v10 == true);
            else
                v13 = false;
            end;

            u8 = v13;

            return;
        end;
    end;
end);
local remainingReports = bottomBar:WaitForChild("remainingReports");

local function captureViewportSnapshot(p14) -- Line: 120
    return nil;
end;

local u15 = {};
u15.__index = u15;

function u15.new(p16) -- Line: 184
    -- upvalues: u15 (copy)
    local v17 = setmetatable({}, u15);
    v17.Container = p16.Container;
    v17.PageLayout = p16.Container.UIPageLayout;
    v17.EmptyLabel = p16.EmptyLabel;
    v17.FetchPage = p16.FetchPage;
    v17.FetchCount = p16.FetchCount;
    v17.RenderCard = p16.RenderCard;
    v17.IsActive = p16.IsActive;
    v17.ClaimKind = p16.ClaimKind;
    v17.ClaimId = p16.ClaimId;
    v17.claimedId = nil;
    v17.claimThread = nil;
    v17.lastFetchFailed = false;
    v17.retryScheduled = false;
    v17.emptyDefaultText = p16.EmptyLabel and p16.EmptyLabel.Text or nil;
    v17.pending = {};
    v17.cursor = 0;
    v17.isLoading = false;
    v17.hasMore = true;
    v17.remaining = nil;
    v17.currentCard = nil;
    v17.currentInfo = nil;
    v17.layoutCounter = 0;
    v17.generation = 0;
    v17.advancing = false;

    return v17;
end;

function u15._clearCards(p18) -- Line: 214
    for _, child in p18.Container:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;

    p18.currentCard = nil;
    p18.currentInfo = nil;
end;

function u15._setEmpty(p19, p20) -- Line: 222
    if p19.EmptyLabel then
        p19.EmptyLabel.Visible = p20;
    end;
end;

function u15._updateRemaining(p21) -- Line: 226
    -- upvalues: remainingReports (copy)
    if not (p21.IsActive and p21.IsActive()) then
        return;
    end;

    if p21.remaining == nil then
        remainingReports.Visible = false;

        return;
    end;

    remainingReports.Visible = true;
    local v22 = math.max(0, p21.remaining);
    remainingReports.Text = "Remaining reports: " .. tostring(v22);
end;

function u15._refreshCount(u23) -- Line: 236
    if not u23.FetchCount then
        return;
    end;

    local generation = u23.generation;
    task.spawn(function() -- Line: 239
        -- upvalues: u23 (copy), generation (copy)
        local success, result = pcall(u23.FetchCount);

        if generation ~= u23.generation then
            return;
        end;

        if success and type(result) == "number" then
            if u23.remaining ~= nil and (u23.remaining < result and os.clock() - (u23.lastResolveClock or (-1 / 0)) < 5) then
                task.delay(5, function() -- Line: 249
                    -- upvalues: generation (ref), u23 (ref)
                    if generation == u23.generation then
                        u23:_refreshCount();
                    end;
                end);

                return;
            end;

            u23.remaining = result;
            u23:_updateRemaining();
        end;
    end);
end;

function u15._fetchPage(p24) -- Line: 263
    -- upvalues: LocalPlayer (copy)
    if p24.isLoading or not p24.hasMore then
        return;
    end;

    p24.isLoading = true;
    local generation = p24.generation;
    local success, result = pcall(p24.FetchPage, p24.cursor);

    if generation ~= p24.generation then
        p24.isLoading = false;

        return;
    end;

    if success and type(result) == "table" then
        p24.lastFetchFailed = false;

        if #result == 0 then
            p24.hasMore = false;
        else
            for _, v in result do
                if v.Anchor and v.Anchor > p24.cursor then
                    p24.cursor = v.Anchor;
                end;

                table.insert(p24.pending, v);
            end;

            local v25 = {};
            local v26 = {};

            for _, v in p24.pending do
                local v27;

                if v.ClaimedBy == nil then
                    v27 = false;
                else
                    v27 = v.ClaimedBy ~= LocalPlayer.UserId;
                end;

                table.insert(v27 and v25 and v25 or v26, v);
            end;

            p24.pending = v26;

            for _, v in v25 do
                table.insert(p24.pending, v);
            end;
        end;
    else
        p24.lastFetchFailed = true;
        warn("[ReportViewer] page fetch failed:", result);
    end;

    p24.isLoading = false;
    p24:_refreshCount();
end;

function u15._topUp(u28) -- Line: 311
    if #u28.pending >= 3 then
        return;
    end;

    if u28.isLoading or not u28.hasMore then
        return;
    end;

    task.spawn(function() -- Line: 314
        -- upvalues: u28 (copy)
        u28:_fetchPage();
    end);
end;

function u15._ensureFetched(p29) -- Line: 319
    while p29.isLoading do
        local generation = p29.generation;
        task.wait(0.05);

        if generation ~= p29.generation then
            return;
        end;
    end;

    if #p29.pending > 0 then
        return;
    end;

    p29:_fetchPage();
end;

function u15._markClaimedByOther(p30, p31, u32) -- Line: 334
    -- upvalues: Players (copy)
    local preview = p31:FindFirstChild("preview");

    if not preview or preview:FindFirstChild("claimedNotice") then
        return;
    end;

    local u33 = script.statisticsLabel:Clone();
    u33.Name = "claimedNotice";
    u33.Text = "<b>In review by:</b> " .. tostring(u32);
    u33.Visible = true;
    u33.AnchorPoint = Vector2.new(0, 1);
    u33.Position = UDim2.new(0.0115, 0, 0.915, 0);
    u33.Size = UDim2.new(0.6, 0, 0.03, 0);
    u33.TextTransparency = 0;
    u33.TextStrokeTransparency = 1;
    u33.ZIndex = 4;
    u33.Parent = preview;
    task.spawn(function() -- Line: 352
        -- upvalues: Players (ref), u32 (copy), u33 (copy)
        pcall(function() -- Line: 353
            -- upvalues: Players (ref), u32 (ref), u33 (ref)
            u33.Text = "<b>In review by:</b> @" .. Players:GetNameFromUserIdAsync(u32);
        end);
    end);
end;

function u15._releaseClaim(p34) -- Line: 362
    -- upvalues: Remotes (copy)
    if p34.claimThread then
        task.cancel(p34.claimThread);
        p34.claimThread = nil;
    end;

    local claimedId = p34.claimedId;

    if not claimedId then
        return;
    end;

    p34.claimedId = nil;
    local ClaimKind = p34.ClaimKind;
    task.spawn(function() -- Line: 371
        -- upvalues: Remotes (ref), ClaimKind (copy), claimedId (copy)
        pcall(function() -- Line: 372
            -- upvalues: Remotes (ref), ClaimKind (ref), claimedId (ref)
            Remotes.CommunityOutfitsAction:InvokeServer("ModerationClaim", "Release", ClaimKind, claimedId);
        end);
    end);
end;

function u15._claimCurrent(u35, u36, p37) -- Line: 380
    -- upvalues: Remotes (copy)
    if not (u35.ClaimKind and u35.ClaimId) then
        return;
    end;

    local u38 = u35.ClaimId(p37);

    if type(u38) ~= "string" or u38 == "" then
        return;
    end;

    u35.claimedId = u38;
    local generation = u35.generation;
    u35.claimThread = task.spawn(function() -- Line: 388
        -- upvalues: Remotes (ref), u35 (copy), u38 (copy), generation (copy), u36 (copy)
        while true do
            local v39, v40, v41 = pcall(function() -- Line: 390
                -- upvalues: Remotes (ref), u35 (ref), u38 (ref)
                return Remotes.CommunityOutfitsAction:InvokeServer("ModerationClaim", "Claim", u35.ClaimKind, u38);
            end);

            if generation ~= u35.generation or u35.currentCard ~= u36 then
                break;
            end;

            if v39 and (v40 == true and (typeof(v41) == "table" and v41.Acquired ~= true)) then
                u35:_markClaimedByOther(u36, v41.ClaimedBy);
            end;

            task.wait(240);
        end;
    end);
end;

function u15._scheduleRetry(u42) -- Line: 404
    if u42.retryScheduled then
        return;
    end;

    u42.retryScheduled = true;
    local generation = u42.generation;
    task.delay(5, function() -- Line: 408
        -- upvalues: u42 (copy), generation (copy)
        u42.retryScheduled = false;

        if generation ~= u42.generation then
            return;
        end;

        if not (u42.IsActive and u42.IsActive()) then
            return;
        end;

        if u42.currentCard then
            return;
        end;

        u42:_showNext(false);
    end);
end;

function u15._showNext(p43, p44) -- Line: 417
    p43:_ensureFetched();
    local currentCard = p43.currentCard;
    p43:_releaseClaim();

    if #p43.pending == 0 then
        if currentCard then
            currentCard:Destroy();
        end;

        p43.currentCard = nil;
        p43.currentInfo = nil;

        if not p43.lastFetchFailed then
            if p43.EmptyLabel and p43.emptyDefaultText then
                p43.EmptyLabel.Text = p43.emptyDefaultText;
            end;

            p43:_setEmpty(true);

            return;
        end;

        if p43.EmptyLabel then
            p43.EmptyLabel.Text = "Reports couldn\'t load. Retrying...";
        end;

        p43:_setEmpty(true);
        p43:_scheduleRetry();

        return;
    end;

    local v45 = table.remove(p43.pending, 1);
    p43.layoutCounter = p43.layoutCounter + 1;
    local v46 = p43.RenderCard(p43, v45);
    v46.LayoutOrder = p43.layoutCounter;
    v46.Parent = p43.Container;
    p43.currentCard = v46;
    p43.currentInfo = v45;
    p43:_setEmpty(false);
    p43:_claimCurrent(v46, v45);
    p43:_topUp();

    if not (p44 and currentCard) then
        if currentCard then
            currentCard:Destroy();

            return;
        end;

        p43.PageLayout:JumpTo(v46);

        return;
    end;

    p43.PageLayout:Next();
    p43.PageLayout.Stopped:Wait();
    currentCard:Destroy();
end;

function u15.Advance(u47, p48) -- Line: 469
    if u47.advancing then
        return;
    end;

    u47.advancing = true;

    if p48 then
        u47.lastResolveClock = os.clock();

        if u47.remaining ~= nil then
            u47.remaining = u47.remaining - 1;
            u47:_updateRemaining();
        end;
    elseif u47.currentInfo then
        table.insert(u47.pending, u47.currentInfo);
    end;

    local success, result = pcall(function() -- Line: 484
        -- upvalues: u47 (copy)
        u47:_showNext(true);
    end);
    u47.advancing = false;

    if not success then
        warn("[ReportViewer] advance failed:", result);
    end;
end;

function u15.Load(p49) -- Line: 490
    p49:Reset();
    p49:_showNext(false);
end;

function u15.Reset(p50) -- Line: 496
    p50:_releaseClaim();
    p50.generation = p50.generation + 1;
    p50.lastFetchFailed = false;
    p50.pending = {};
    p50.cursor = 0;
    p50.isLoading = false;
    p50.hasMore = true;
    p50.remaining = nil;
    p50.layoutCounter = 0;
    p50.advancing = false;
    p50:_clearCards();
    p50:_setEmpty(false);
    p50:_updateRemaining();
end;

local function clearConnections() -- Line: 512
    -- upvalues: u6 (copy)
    for _, v in u6 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u6);
end;

local function clearCategories() -- Line: 521
    -- upvalues: categoriesContainer (copy)
    for _, child in categoriesContainer:GetChildren() do
        if child:IsA("TextButton") then
            child:Destroy();
        end;
    end;
end;

local u92 = u15.new({
    ClaimKind = "Outfit",
    Container = communityOutfitReports,
    EmptyLabel = layoutBypass.noPendingReports,

    IsActive = function() -- Line: 715, Name: IsActive
        -- upvalues: u5 (copy)
        return u5.CurrentCategory == "communityOutfitReports";
    end,

    RenderCard = function(u51, p52) -- Line: 529, Name: loadOutfitReport
        -- upvalues: u8 (ref), HumanoidDescriptionController (copy), AvatarPreviewController (copy), u5 (copy), Players (copy), TimeUtilities (copy), communityOutfitReports (copy), Events (copy), Remotes (copy), u1 (copy)
        local u53 = script.report:Clone();
        local v54 = u8 and u53.preview.actions:FindFirstChild("permBan");

        if v54 then
            v54:Destroy();
        end;

        local function addLabel(p55, p56) -- Line: 536
            -- upvalues: u53 (copy)
            local v57 = script.statisticsLabel:Clone();
            v57.Name = p55;
            v57.Text = "<b>" .. p55 .. "</b>: " .. tostring(p56);
            v57.LayoutOrder = #u53.preview.statistics:GetChildren();
            v57.Parent = u53.preview.statistics;
        end;

        local OutfitDetails = p52.OutfitDetails;
        local v58, v59 = HumanoidDescriptionController.DeserializeHumanoidDescription(OutfitDetails.HumanoidDescription);
        AvatarPreviewController.new(u53.preview.viewport, v58, {
            AllowCameraAdjustment = true,
            RigType = v59
        });

        if p52.Detection and u5._attachDetectionBadge then
            u5._attachDetectionBadge(u53.preview, p52.Detection, v58);
        end;

        local Name = OutfitDetails.Name;
        local v60 = script.statisticsLabel:Clone();
        v60.Name = "Name";
        v60.Text = "<b>" .. "Name" .. "</b>: " .. tostring(Name);
        v60.LayoutOrder = #u53.preview.statistics:GetChildren();
        v60.Parent = u53.preview.statistics;
        local Id = OutfitDetails.Id;
        local v61 = script.statisticsLabel:Clone();
        v61.Name = "InternalId";
        v61.Text = "<b>" .. "InternalId" .. "</b>: " .. tostring(Id);
        v61.LayoutOrder = #u53.preview.statistics:GetChildren();
        v61.Parent = u53.preview.statistics;
        local Name2 = v59.Name;
        local v62 = script.statisticsLabel:Clone();
        v62.Name = "RigType";
        v62.Text = "<b>" .. "RigType" .. "</b>: " .. tostring(Name2);
        v62.LayoutOrder = #u53.preview.statistics:GetChildren();
        v62.Parent = u53.preview.statistics;
        local v63 = os.date("%Y-%m-%d %H:%M:%S", OutfitDetails.Created);
        local v64 = script.statisticsLabel:Clone();
        v64.Name = "Created";
        v64.Text = "<b>" .. "Created" .. "</b>: " .. tostring(v63);
        v64.LayoutOrder = #u53.preview.statistics:GetChildren();
        v64.Parent = u53.preview.statistics;
        local v65 = not OutfitDetails.Updated and "Never" or os.date("%Y-%m-%d %H:%M:%S", OutfitDetails.Updated);
        local v66 = script.statisticsLabel:Clone();
        v66.Name = "Updated";
        v66.Text = "<b>" .. "Updated" .. "</b>: " .. tostring(v65);
        v66.LayoutOrder = #u53.preview.statistics:GetChildren();
        v66.Parent = u53.preview.statistics;
        local CreatorId = OutfitDetails.CreatorId;
        local v67 = script.statisticsLabel:Clone();
        v67.Name = "CreatorId";
        v67.Text = "<b>" .. "CreatorId" .. "</b>: " .. tostring(CreatorId);
        v67.LayoutOrder = #u53.preview.statistics:GetChildren();
        v67.Parent = u53.preview.statistics;
        local CommentCount = OutfitDetails.CommentCount;
        local v68 = script.statisticsLabel:Clone();
        v68.Name = "Comments";
        v68.Text = "<b>" .. "Comments" .. "</b>: " .. tostring(CommentCount);
        v68.LayoutOrder = #u53.preview.statistics:GetChildren();
        v68.Parent = u53.preview.statistics;
        local FavoriteCount = OutfitDetails.FavoriteCount;
        local v69 = script.statisticsLabel:Clone();
        v69.Name = "Favorites";
        v69.Text = "<b>" .. "Favorites" .. "</b>: " .. tostring(FavoriteCount);
        v69.LayoutOrder = #u53.preview.statistics:GetChildren();
        v69.Parent = u53.preview.statistics;
        local WornCount = OutfitDetails.WornCount;
        local v70 = script.statisticsLabel:Clone();
        v70.Name = "Worn";
        v70.Text = "<b>" .. "Worn" .. "</b>: " .. tostring(WornCount);
        v70.LayoutOrder = #u53.preview.statistics:GetChildren();
        v70.Parent = u53.preview.statistics;
        local ShareCode = OutfitDetails.ShareCode;
        local v71 = script.statisticsLabel:Clone();
        v71.Name = "ShareCode";
        v71.Text = "<b>" .. "ShareCode" .. "</b>: " .. tostring(ShareCode);
        v71.LayoutOrder = #u53.preview.statistics:GetChildren();
        v71.Parent = u53.preview.statistics;
        local ReportCount = p52.ReportCount;
        local v72 = script.statisticsLabel:Clone();
        v72.Name = "CurrentReports";
        v72.Text = "<b>" .. "CurrentReports" .. "</b>: " .. tostring(ReportCount);
        v72.LayoutOrder = #u53.preview.statistics:GetChildren();
        v72.Parent = u53.preview.statistics;
        local v73 = not p52.LatestReport and "Never" or os.date("%Y-%m-%d %H:%M:%S", p52.LatestReport);
        local v74 = script.statisticsLabel:Clone();
        v74.Name = "LatestReport";
        v74.Text = "<b>" .. "LatestReport" .. "</b>: " .. tostring(v73);
        v74.LayoutOrder = #u53.preview.statistics:GetChildren();
        v74.Parent = u53.preview.statistics;
        u53.name.Text = "<b>Name:</b> " .. OutfitDetails.Name;
        u53.creator.Text = "<b>Creator:</b> " .. tostring(OutfitDetails.CreatorId);
        task.spawn(function() -- Line: 573
            -- upvalues: Players (ref), OutfitDetails (copy), u53 (copy)
            pcall(function() -- Line: 574
                -- upvalues: Players (ref), OutfitDetails (ref), u53 (ref)
                local v75 = Players:GetNameFromUserIdAsync(OutfitDetails.CreatorId);
                u53.creator.Text = "<b>Creator:</b> " .. tostring(v75) .. ` ({OutfitDetails.CreatorId})`;
            end);
        end);
        u53.reportCount.Text = "Reports (" .. tostring(p52.ReportCount) .. ")";
        local v76 = {};

        for _, v in p52.Reports do
            if not v76[tostring(v.ReporterId)] then
                v76[tostring(v.ReporterId)] = true;
                local u77 = script.testimony:Clone();
                u77.content.Text = v.Reason;
                u77.date.Text = TimeUtilities.FormatCommentTime(v.Timestamp);
                u77.image.Image = `rbxthumb://type=AvatarHeadShot&id={v.ReporterId}&w=100&h=100`;
                u77.name.Text = tostring(v.ReporterId);
                task.spawn(function() -- Line: 591
                    -- upvalues: Players (ref), v (copy), u77 (copy)
                    pcall(function() -- Line: 592
                        -- upvalues: Players (ref), v (ref), u77 (ref)
                        local v78 = Players:GetNameFromUserIdAsync(v.ReporterId);

                        if v78 then
                            u77.name.Text = `@{v78} ({v.ReporterId})`;
                        end;
                    end);
                end);
                u77.LayoutOrder = v.Id;
                u77.Parent = u53.testimonies;
            end;
        end;

        local function unhover() -- Line: 612
            -- upvalues: u53 (copy)
            for _, child in u53.preview.statistics:GetChildren() do
                if child:IsA("TextLabel") then
                    child.TextTransparency = 0.9;
                    child.TextStrokeTransparency = 0.9;
                end;
            end;
        end;

        unhover();
        local _ = communityOutfitReports.UIPageLayout;
        u53.preview.statistics.MouseEnter:Connect(function() -- Line: 603, Name: hover
            -- upvalues: u53 (copy)
            for _, child in u53.preview.statistics:GetChildren() do
                if child:IsA("TextLabel") then
                    child.TextTransparency = 0;
                    child.TextStrokeTransparency = 0;
                end;
            end;
        end);
        u53.preview.statistics.MouseLeave:Connect(unhover);
        u53.next.Activated:Connect(function() -- Line: 627
            -- upvalues: u51 (copy)
            u51:Advance(false);
        end);

        local function setModerateButtonsVisible(p79) -- Line: 631
            -- upvalues: u53 (copy)
            for _, child in u53.preview.actions:GetChildren() do
                if child:IsA("TextButton") then
                    if table.find({ "approve", "moderate" }, child.Name) then
                        child.Visible = not p79;
                    else
                        child.Visible = p79;
                    end;
                end;
            end;
        end;

        for _, child in u53.preview.actions:GetChildren() do
            if child:IsA("TextButton") then
                local Name3 = child.Name;
                setModerateButtonsVisible(false);
                child.Activated:Connect(function() -- Line: 649
                    -- upvalues: Name3 (copy), setModerateButtonsVisible (copy), Events (ref), u51 (copy), Remotes (ref), OutfitDetails (copy), u53 (copy), u1 (ref)
                    if Name3 == "goBack" then
                        setModerateButtonsVisible(false);

                        return;
                    end;

                    if Name3 == "moderate" then
                        setModerateButtonsVisible(true);

                        return;
                    end;

                    if Name3 == "approve" then
                        if Events.PromptConfirmationDialog:Invoke({
                            Title = "Approve Outfit",
                            Description = "Are you sure?",
                            YesText = "Approve",
                            NoText = "Cancel"
                        }) == false then
                            return;
                        end;

                        u51:Advance(true);
                        task.spawn(function() -- Line: 666
                            -- upvalues: Remotes (ref), OutfitDetails (ref), Events (ref)
                            local v80, v81 = Remotes.CommunityOutfitsAction:InvokeServer("ModerateOutfit", "Approve", OutfitDetails.Id);

                            if v80 then
                                Events.Notify:Fire("✅ Successfully approved outfit.");

                                return;
                            end;

                            Events.Notify:Fire("❌ Approve didn\'t go through: " .. tostring(v81) .. " The report will reappear later.");
                        end);

                        return;
                    end;

                    local _ = u53.preview.viewport;
                    local u82 = nil;
                    local v83 = Events.PromptChoice:Invoke({
                        subtitle = "This bans the reported outfit. Be concise and accurate.",
                        allowCustom = true,
                        placeholder = "Type a custom reason…",
                        title = "Mod Action: " .. Name3,
                        options = u1
                    });

                    if not v83 then
                        return;
                    end;

                    local value = v83.value;

                    if Events.PromptConfirmationDialog:Invoke({
                        Title = "Confirm outfit moderation",
                        YesText = "Moderate",
                        NoText = "Cancel",
                        Description = "This will moderate the reported outfit and ban it.\n\nReason: " .. value
                    }) ~= true then
                        return;
                    end;

                    u51:Advance(true);
                    task.spawn(function() -- Line: 696
                        -- upvalues: Remotes (ref), OutfitDetails (ref), Name3 (ref), value (copy), u82 (copy), Events (ref)
                        local v84, v85 = Remotes.CommunityOutfitsAction:InvokeServer("ModerateOutfit", "Ban", OutfitDetails.Id, Name3, value, u82);

                        if v84 then
                            Events.Notify:Fire("✅ Successfully moderated outfit. Ban Type: " .. Name3);

                            return;
                        end;

                        Events.Notify:Fire("❌ Ban didn\'t go through: " .. tostring(v85) .. " The report will reappear later.");
                    end);
                end);
            end;
        end;

        return u53;
    end,

    ClaimId = function(p86) -- Line: 718, Name: ClaimId
        return p86.OutfitDetails and p86.OutfitDetails.Id;
    end,

    FetchPage = function(p87) -- Line: 719, Name: FetchPage
        -- upvalues: Remotes (copy)
        local v88, v89 = Remotes.CommunityOutfitsAction:InvokeServer("GetReports", "Oldest", 8, p87);

        if not v88 then
            error((tostring(v89)));
        end;

        return v89;
    end,

    FetchCount = function() -- Line: 724, Name: FetchCount
        -- upvalues: Remotes (copy)
        local v90, v91 = Remotes.CommunityOutfitsAction:InvokeServer("GetReportsCount");

        if not v90 then
            error((tostring(v91)));
        end;

        return v91;
    end
});
local u145 = u15.new({
    ClaimKind = "Player",
    Container = playerOutfitReports,
    EmptyLabel = layoutBypass2.noPendingReports,

    IsActive = function() -- Line: 973, Name: IsActive
        -- upvalues: u5 (copy)
        return u5.CurrentCategory == "playerOutfitReports";
    end,

    RenderCard = function(u93, p94) -- Line: 731, Name: loadPlayerReport
        -- upvalues: u8 (ref), Players (copy), HumanoidDescriptionController (copy), AvatarPreviewController (copy), u5 (copy), TimeUtilities (copy), Events (copy), Remotes (copy), u1 (copy)
        local u95 = script.playerReport:Clone();
        local v96 = u8 and u95.preview.actions:FindFirstChild("permBan");

        if v96 then
            v96:Destroy();
        end;

        local ReportedUserId = p94.ReportedUserId;
        local CompressedDescription = p94.CompressedDescription;
        u95.creatorUserId.Text = "<b>User ID:</b> " .. tostring(ReportedUserId);
        u95.creatorUsername.Text = "<b>Username:</b> Loading...";
        task.spawn(function() -- Line: 743
            -- upvalues: Players (ref), ReportedUserId (copy), u95 (copy)
            pcall(function() -- Line: 744
                -- upvalues: Players (ref), ReportedUserId (ref), u95 (ref)
                local v97 = Players:GetNameFromUserIdAsync(ReportedUserId);
                u95.creatorUsername.Text = "<b>Username:</b> " .. tostring(v97);
            end);
        end);
        u95.reportCount.Text = "Reports (" .. tostring(p94.ReportCount) .. ")";

        if p94.HumanoidDescription then
            local v98, v99 = HumanoidDescriptionController.DeserializeHumanoidDescription(p94.HumanoidDescription);
            AvatarPreviewController.new(u95.preview.viewport, v98, {
                AllowCameraAdjustment = true,
                RigType = v99
            });

            if p94.Detection and u5._attachDetectionBadge then
                u5._attachDetectionBadge(u95.preview, p94.Detection, v98);
            end;

            local function _(p100, p101) -- Line: 763
                -- upvalues: u95 (copy)
                local v102 = script.statisticsLabel:Clone();
                v102.Name = p100;
                v102.Text = "<b>" .. p100 .. "</b>: " .. tostring(p101);
                v102.LayoutOrder = #u95.preview.statistics:GetChildren();
                v102.Parent = u95.preview.statistics;
            end;

            local v103 = script.statisticsLabel:Clone();
            v103.Name = "ReportedUserId";
            v103.Text = "<b>" .. "ReportedUserId" .. "</b>: " .. tostring(ReportedUserId);
            v103.LayoutOrder = #u95.preview.statistics:GetChildren();
            v103.Parent = u95.preview.statistics;
            local Name = v99.Name;
            local v104 = script.statisticsLabel:Clone();
            v104.Name = "RigType";
            v104.Text = "<b>" .. "RigType" .. "</b>: " .. tostring(Name);
            v104.LayoutOrder = #u95.preview.statistics:GetChildren();
            v104.Parent = u95.preview.statistics;
            local ReportCount = p94.ReportCount;
            local v105 = script.statisticsLabel:Clone();
            v105.Name = "TotalReports";
            v105.Text = "<b>" .. "TotalReports" .. "</b>: " .. tostring(ReportCount);
            v105.LayoutOrder = #u95.preview.statistics:GetChildren();
            v105.Parent = u95.preview.statistics;
            local v106 = not p94.LatestReport and "Never" or os.date("%Y-%m-%d %H:%M:%S", p94.LatestReport);
            local v107 = script.statisticsLabel:Clone();
            v107.Name = "LatestReport";
            v107.Text = "<b>" .. "LatestReport" .. "</b>: " .. tostring(v106);
            v107.LayoutOrder = #u95.preview.statistics:GetChildren();
            v107.Parent = u95.preview.statistics;

            if p94.PlayerStatistics then
                local PlayerStatistics = p94.PlayerStatistics;
                local v108 = PlayerStatistics.Sessions or 0;
                local v109 = script.statisticsLabel:Clone();
                v109.Name = "Sessions";
                v109.Text = "<b>" .. "Sessions" .. "</b>: " .. tostring(v108);
                v109.LayoutOrder = #u95.preview.statistics:GetChildren();
                v109.Parent = u95.preview.statistics;
                local v110 = PlayerStatistics.DaysPlayed or 0;
                local v111 = script.statisticsLabel:Clone();
                v111.Name = "DaysPlayed";
                v111.Text = "<b>" .. "DaysPlayed" .. "</b>: " .. tostring(v110);
                v111.LayoutOrder = #u95.preview.statistics:GetChildren();
                v111.Parent = u95.preview.statistics;
                local v112 = PlayerStatistics.LastLoginDate or "Unknown";
                local v113 = script.statisticsLabel:Clone();
                v113.Name = "LastLogin";
                v113.Text = "<b>" .. "LastLogin" .. "</b>: " .. tostring(v112);
                v113.LayoutOrder = #u95.preview.statistics:GetChildren();
                v113.Parent = u95.preview.statistics;
                local v114 = PlayerStatistics.RobuxSpent or 0;
                local v115 = script.statisticsLabel:Clone();
                v115.Name = "RobuxSpent";
                v115.Text = "<b>" .. "RobuxSpent" .. "</b>: " .. tostring(v114);
                v115.LayoutOrder = #u95.preview.statistics:GetChildren();
                v115.Parent = u95.preview.statistics;

                if p94.TotalPlaytime then
                    local TotalPlaytime = p94.TotalPlaytime;
                    local v116;

                    if TotalPlaytime < 3600 then
                        v116 = string.format("%d minutes", (math.floor(TotalPlaytime / 60)));
                    else
                        local v117 = math.floor(TotalPlaytime / 3600);
                        v116 = string.format("%d hours", v117);
                    end;

                    local v118 = script.statisticsLabel:Clone();
                    v118.Name = "Playtime";
                    v118.Text = "<b>" .. "Playtime" .. "</b>: " .. tostring(v116);
                    v118.LayoutOrder = #u95.preview.statistics:GetChildren();
                    v118.Parent = u95.preview.statistics;
                end;
            end;

            local function v119() -- Line: 805
                -- upvalues: u95 (copy)
                for _, child in u95.preview.statistics:GetChildren() do
                    if child:IsA("TextLabel") then
                        child.TextTransparency = 0.9;
                        child.TextStrokeTransparency = 0.9;
                    end;
                end;
            end;

            v119();
            u95.preview.statistics.MouseEnter:Connect(function() -- Line: 796, Name: hover
                -- upvalues: u95 (copy)
                for _, child in u95.preview.statistics:GetChildren() do
                    if child:IsA("TextLabel") then
                        child.TextTransparency = 0;
                        child.TextStrokeTransparency = 0;
                    end;
                end;
            end);
            u95.preview.statistics.MouseLeave:Connect(v119);
        end;

        local v120 = {};

        for _, v in p94.Reports do
            if not v120[tostring(v.ReporterId)] then
                v120[tostring(v.ReporterId)] = true;
                local u121 = u95.testimonies.testimony:Clone();
                u121.content.Text = v.Reason;
                u121.date.Text = TimeUtilities.FormatCommentTime(v.Timestamp);
                u121.image.Image = `rbxthumb://type=AvatarHeadShot&id={v.ReporterId}&w=100&h=100`;
                u121.name.Text = tostring(v.ReporterId);
                task.spawn(function() -- Line: 830
                    -- upvalues: Players (ref), v (copy), u121 (copy)
                    pcall(function() -- Line: 831
                        -- upvalues: Players (ref), v (ref), u121 (ref)
                        local v122 = Players:GetNameFromUserIdAsync(v.ReporterId);

                        if v122 then
                            u121.name.Text = `@{v122} ({v.ReporterId})`;
                        end;
                    end);
                end);
                u121.LayoutOrder = v.Id or 0;
                u121.Visible = true;
                u121.Parent = u95.testimonies;
            end;
        end;

        if u95.testimonies:FindFirstChild("testimony") then
            u95.testimonies.testimony.Visible = false;
        end;

        u95.next.Activated:Connect(function() -- Line: 848
            -- upvalues: u93 (copy)
            u93:Advance(false);
        end);

        local function u124(p123) -- Line: 853
            -- upvalues: u95 (copy)
            for _, child in u95.preview.actions:GetChildren() do
                if child:IsA("TextButton") then
                    if table.find({ "approve", "moderate", "resetOutfit" }, child.Name) then
                        child.Visible = not p123;
                    else
                        child.Visible = p123;
                    end;
                end;
            end;
        end;

        u124(false);

        for _, child in u95.preview.actions:GetChildren() do
            if child:IsA("TextButton") then
                local Name = child.Name;
                child.Activated:Connect(function() -- Line: 870
                    -- upvalues: Name (copy), u124 (copy), Events (ref), u93 (copy), Remotes (ref), CompressedDescription (copy), ReportedUserId (copy), u95 (copy), u1 (ref)
                    if Name == "goBack" then
                        u124(false);

                        return;
                    end;

                    if Name == "moderate" then
                        u124(true);

                        return;
                    end;

                    if Name == "approve" then
                        if Events.PromptConfirmationDialog:Invoke({
                            Title = "Dismiss Outfit Reports",
                            Description = "This will dismiss all reports for this specific outfit snapshot. Other reports for this player (with different outfits) will remain.",
                            YesText = "Dismiss",
                            NoText = "Cancel"
                        }) == false then
                            return;
                        end;

                        u93:Advance(true);
                        task.spawn(function() -- Line: 886
                            -- upvalues: Remotes (ref), CompressedDescription (ref), ReportedUserId (ref), Events (ref)
                            local v125, v126 = Remotes.CommunityOutfitsAction:InvokeServer("ModeratePlayerReport", "Dismiss", CompressedDescription, ReportedUserId);

                            if v125 then
                                Events.Notify:Fire("✅ Outfit reports dismissed.");

                                return;
                            end;

                            Events.Notify:Fire("❌ Dismiss didn\'t go through: " .. tostring(v126) .. " The report will reappear later.");
                        end);

                        return;
                    end;

                    if Name == "resetOutfit" then
                        local _ = u95.preview.viewport;
                        local u127 = nil;
                        local v128 = Events.PromptChoice:Invoke({
                            title = "Reset Player Outfit",
                            subtitle = "This resolves reports and clears their saved outfit without banning.",
                            allowCustom = true,
                            placeholder = "Type a custom reason…",
                            options = u1
                        });

                        if not v128 then
                            return;
                        end;

                        local value = v128.value;

                        if Events.PromptConfirmationDialog:Invoke({
                            Title = "Confirm reset",
                            YesText = "Reset Outfit",
                            NoText = "Cancel",
                            Description = "This resolves reports and clears this player\'s saved outfit. They will not be banned.\n\nReason: " .. value
                        }) ~= true then
                            return;
                        end;

                        u93:Advance(true);
                        task.spawn(function() -- Line: 916
                            -- upvalues: Remotes (ref), CompressedDescription (ref), ReportedUserId (ref), value (copy), u127 (copy), Events (ref)
                            local v129, v130 = Remotes.CommunityOutfitsAction:InvokeServer("ModeratePlayerReport", "Reset", CompressedDescription, ReportedUserId, value, u127);

                            if v129 then
                                Events.Notify:Fire("✅ Player outfit has been reset.");

                                return;
                            end;

                            Events.Notify:Fire("❌ Reset didn\'t go through: " .. tostring(v130) .. " The report will reappear later.");
                        end);

                        return;
                    end;

                    local _ = u95.preview.viewport;
                    local u131 = nil;
                    local v132 = Events.PromptChoice:Invoke({
                        subtitle = "This resolves reports for this outfit and bans the player.",
                        allowCustom = true,
                        placeholder = "Type a custom reason…",
                        title = "Ban Player: " .. Name,
                        options = u1
                    });

                    if not v132 then
                        return;
                    end;

                    local value = v132.value;
                    local v133 = Name == "permBan";
                    local v134 = ({
                        ban1Day = "1 day",
                        ban3Days = "3 days",
                        ban7Days = "7 days",
                        ban30Days = "30 days",
                        permBan = "permanent"
                    })[Name] or Name;
                    local v135;

                    if v133 then
                        v135 = "This will PERMANENTLY ban the player. This cannot be undone.\n\nReason: " .. value;
                    else
                        v135 = "This will ban the player for " .. v134 .. " and resolve reports for this outfit.\n\nReason: " .. value;
                    end;

                    if Events.PromptConfirmationDialog:Invoke({
                        NoText = "Cancel",
                        Title = v133 and "Confirm PERMANENT ban" or "Confirm ban",
                        Description = v135,
                        YesText = v133 and "Permanently Ban" or "Ban Player"
                    }) ~= true then
                        return;
                    end;

                    u93:Advance(true);
                    task.spawn(function() -- Line: 953
                        -- upvalues: Remotes (ref), CompressedDescription (ref), ReportedUserId (ref), Name (ref), value (copy), u131 (copy), Events (ref)
                        local v136, v137, v138 = Remotes.CommunityOutfitsAction:InvokeServer("ModeratePlayerReport", "Ban", CompressedDescription, ReportedUserId, Name, value, u131);

                        if v136 then
                            Events.Notify:Fire("✅ Player banned. Ban Type: " .. Name);

                            return;
                        end;

                        if v138 == "AlreadyBanned" then
                            Events.Notify:Fire("⚠️ " .. tostring(v137));

                            return;
                        end;

                        Events.Notify:Fire("❌ Ban didn\'t go through: " .. tostring(v137) .. " The report will reappear later.");
                    end);
                end);
            end;
        end;

        return u95;
    end,

    ClaimId = function(p139) -- Line: 976, Name: ClaimId
        return p139.CompressedDescription;
    end,

    FetchPage = function(p140) -- Line: 977, Name: FetchPage
        -- upvalues: Remotes (copy)
        local v141, v142 = Remotes.CommunityOutfitsAction:InvokeServer("GetPlayerReports", "Oldest", 8, p140);

        if not v141 then
            error((tostring(v142)));
        end;

        return v142;
    end,

    FetchCount = function() -- Line: 982, Name: FetchCount
        -- upvalues: Remotes (copy)
        local v143, v144 = Remotes.CommunityOutfitsAction:InvokeServer("GetPlayerReportsCount");

        if not v143 then
            error((tostring(v144)));
        end;

        return v144;
    end
});

local function fetchPlayerReview(p146) -- Line: 989
    -- upvalues: reviewPlayer (copy), Remotes (copy), Events (copy), HumanoidDescriptionController (copy), AvatarPreviewController (copy), Players (copy)
    local v147 = reviewPlayer;
    local v148, v149 = Remotes.CommunityOutfitsAction:InvokeServer("ReviewPlayer", p146);

    if not v148 then
        Events.Notify:Fire("❌ " .. tostring(v149));

        return;
    end;

    Events.Notify:Fire("✅ Found player: " .. tostring(v149.Username));

    if v147:FindFirstChild("playerReview") then
        v147.playerReview:Destroy();
    end;

    v147.noOutfitLoaded.Visible = false;
    local u150 = script.outfit:Clone();
    u150.Name = "playerReview";
    u150.name.Text = "<b>Player:</b> " .. tostring(v149.Username) .. " (" .. tostring(v149.UserId) .. ")";
    u150.creator.Text = "<b>Status:</b> " .. (v149.IsBanned and "🔴 Banned" or "🟢 Not Banned");

    if v149.Pending then
        u150.creator.Text = u150.creator.Text .. " (pending)";
    end;

    u150.restore.Visible = false;

    local function _(p151, p152) -- Line: 1020
        -- upvalues: u150 (copy)
        local v153 = script.statisticsLabel:Clone();
        v153.Name = p151;
        v153.Text = "<b>" .. p151 .. "</b>: " .. tostring(p152);
        v153.LayoutOrder = #u150.preview.statistics:GetChildren();
        v153.Parent = u150.preview.statistics;
    end;

    local v154 = v149.CurrentBan and v149.CurrentBan.Evidence;
    local v155;

    if v154 and v154.Type == "PlayerOutfit" then
        v155 = v154.DecompressedDescription or nil;
    else
        v155 = nil;
    end;

    local v156 = v155 or v149.CurrentOutfit;

    if v156 then
        local v157, v158 = HumanoidDescriptionController.DeserializeHumanoidDescription(v156);

        if v157 then
            AvatarPreviewController.new(u150.preview.viewport, v157, {
                AllowCameraAdjustment = true,
                RigType = v158
            });
            local v159 = script.statisticsLabel:Clone();
            v159.Name = "Showing";
            v159.Text = "<b>" .. "Showing" .. "</b>: " .. tostring(v155 and "Banned outfit" or "Current outfit");
            v159.LayoutOrder = #u150.preview.statistics:GetChildren();
            v159.Parent = u150.preview.statistics;
            local Name = v158.Name;
            local v160 = script.statisticsLabel:Clone();
            v160.Name = "RigType";
            v160.Text = "<b>" .. "RigType" .. "</b>: " .. tostring(Name);
            v160.LayoutOrder = #u150.preview.statistics:GetChildren();
            v160.Parent = u150.preview.statistics;
        else
            local v161 = script.statisticsLabel:Clone();
            v161.Name = "Outfit";
            v161.Text = "<b>" .. "Outfit" .. "</b>: " .. tostring(v155 and "Could not load banned outfit" or "Could not load current outfit");
            v161.LayoutOrder = #u150.preview.statistics:GetChildren();
            v161.Parent = u150.preview.statistics;
        end;
    else
        local v162 = script.statisticsLabel:Clone();
        v162.Name = "Outfit";
        v162.Text = "<b>" .. "Outfit" .. "</b>: " .. tostring("Not available");
        v162.LayoutOrder = #u150.preview.statistics:GetChildren();
        v162.Parent = u150.preview.statistics;
    end;

    if v149.Statistics then
        local Statistics = v149.Statistics;
        local v163 = v149.TotalPlaytime or (Statistics.Playtime or 0);
        local v164;

        if v163 < 3600 then
            v164 = string.format("%d minutes", (math.floor(v163 / 60)));
        else
            v164 = string.format("%d hours", (math.floor(v163 / 3600)));
        end;

        local v165 = script.statisticsLabel:Clone();
        v165.Name = "Playtime";
        v165.Text = "<b>" .. "Playtime" .. "</b>: " .. tostring(v164);
        v165.LayoutOrder = #u150.preview.statistics:GetChildren();
        v165.Parent = u150.preview.statistics;
        local v166 = Statistics.Sessions or 0;
        local v167 = script.statisticsLabel:Clone();
        v167.Name = "Sessions";
        v167.Text = "<b>" .. "Sessions" .. "</b>: " .. tostring(v166);
        v167.LayoutOrder = #u150.preview.statistics:GetChildren();
        v167.Parent = u150.preview.statistics;
        local v168 = Statistics.DaysPlayed or 0;
        local v169 = script.statisticsLabel:Clone();
        v169.Name = "DaysPlayed";
        v169.Text = "<b>" .. "DaysPlayed" .. "</b>: " .. tostring(v168);
        v169.LayoutOrder = #u150.preview.statistics:GetChildren();
        v169.Parent = u150.preview.statistics;
        local v170 = Statistics.LastLoginDate or "Unknown";
        local v171 = script.statisticsLabel:Clone();
        v171.Name = "LastLogin";
        v171.Text = "<b>" .. "LastLogin" .. "</b>: " .. tostring(v170);
        v171.LayoutOrder = #u150.preview.statistics:GetChildren();
        v171.Parent = u150.preview.statistics;
        local v172 = Statistics.Customizations or 0;
        local v173 = script.statisticsLabel:Clone();
        v173.Name = "Customizations";
        v173.Text = "<b>" .. "Customizations" .. "</b>: " .. tostring(v172);
        v173.LayoutOrder = #u150.preview.statistics:GetChildren();
        v173.Parent = u150.preview.statistics;
        local v174 = Statistics.RobuxSpent or 0;
        local v175 = script.statisticsLabel:Clone();
        v175.Name = "RobuxSpent";
        v175.Text = "<b>" .. "RobuxSpent" .. "</b>: " .. tostring(v174);
        v175.LayoutOrder = #u150.preview.statistics:GetChildren();
        v175.Parent = u150.preview.statistics;
        local v176 = Statistics.RobuxSavedByPlus or 0;
        local v177 = script.statisticsLabel:Clone();
        v177.Name = "RobuxSaved";
        v177.Text = "<b>" .. "RobuxSaved" .. "</b>: " .. tostring(v176);
        v177.LayoutOrder = #u150.preview.statistics:GetChildren();
        v177.Parent = u150.preview.statistics;
    end;

    local CurrentBan = v149.CurrentBan;

    if CurrentBan then
        u150.moderatorName.Text = "<b>Moderator:</b> " .. tostring(CurrentBan.ModeratorId or "N/A");
        task.spawn(function() -- Line: 1071
            -- upvalues: CurrentBan (copy), Players (ref), u150 (copy)
            if CurrentBan.ModeratorId then
                pcall(function() -- Line: 1073
                    -- upvalues: Players (ref), CurrentBan (ref), u150 (ref)
                    local v178 = Players:GetNameFromUserIdAsync(CurrentBan.ModeratorId);
                    u150.moderatorName.Text = "<b>Moderator:</b> " .. tostring(v178) .. " (" .. tostring(CurrentBan.ModeratorId) .. ")";
                end);
            end;
        end);
        u150.moderationDate.Text = "<b>Banned at:</b> " .. (not CurrentBan.BannedTimestamp and "N/A" or os.date("%Y-%m-%d %H:%M:%S", CurrentBan.BannedTimestamp));
        local v179;

        if CurrentBan.Duration and CurrentBan.Duration > 0 then
            local v180 = math.floor(CurrentBan.Duration / 86400);

            if v180 > 0 then
                v179 = tostring(v180) .. (v180 == 1 and " day" or " days");
            else
                local v181 = math.floor(CurrentBan.Duration / 3600);
                v179 = tostring(v181) .. (v181 == 1 and " hour" or " hours");
            end;

            if CurrentBan.BannedTimestamp then
                local v182 = CurrentBan.Duration - (os.time() - CurrentBan.BannedTimestamp);

                if v182 > 0 then
                    v179 = v179 .. " (" .. math.floor(v182 / 86400) .. "d " .. math.floor(v182 % 86400 / 3600) .. "h remaining)";
                else
                    v179 = v179 .. " (expired)";
                end;
            end;
        else
            v179 = "Permanent";
        end;

        u150.moderationAction.Text = "<b>Duration:</b> " .. v179;
        u150.reasonContainer.reason.Text = CurrentBan.Reason or "No reason provided";
        u150.label.Text = "Ban reason:";

        if CurrentBan.Evidence then
            if CurrentBan.Evidence.Type == "PlayerOutfit" then
                local v183 = script.statisticsLabel:Clone();
                v183.Name = "Evidence";
                v183.Text = "<b>" .. "Evidence" .. "</b>: " .. tostring("Player Outfit Snapshot (shown in preview)");
                v183.LayoutOrder = #u150.preview.statistics:GetChildren();
                v183.Parent = u150.preview.statistics;
            elseif CurrentBan.Evidence.Type == "CommunityOutfit" and CurrentBan.Evidence.OutfitId then
                local v184 = script.statisticsLabel:Clone();
                v184.Name = "Evidence";
                v184.Text = "<b>" .. "Evidence" .. "</b>: " .. tostring("Community Outfit");
                v184.LayoutOrder = #u150.preview.statistics:GetChildren();
                v184.Parent = u150.preview.statistics;
                local OutfitId = CurrentBan.Evidence.OutfitId;
                local v185 = script.statisticsLabel:Clone();
                v185.Name = "OutfitId";
                v185.Text = "<b>" .. "OutfitId" .. "</b>: " .. tostring(OutfitId);
                v185.LayoutOrder = #u150.preview.statistics:GetChildren();
                v185.Parent = u150.preview.statistics;
                task.spawn(function() -- Line: 1116
                    -- upvalues: Remotes (ref), CurrentBan (copy), u150 (copy)
                    local v186, v187 = Remotes.CommunityOutfitsAction:InvokeServer("GetOutfit", CurrentBan.Evidence.OutfitId);

                    if not (v186 and v187) then
                        local v188 = script.statisticsLabel:Clone();
                        v188.Name = "EvidenceStatus";
                        v188.Text = "<b>" .. "EvidenceStatus" .. "</b>: " .. tostring("Outfit deleted or unavailable");
                        v188.LayoutOrder = #u150.preview.statistics:GetChildren();
                        v188.Parent = u150.preview.statistics;

                        return;
                    end;

                    local Name = v187.Name;
                    local v189 = script.statisticsLabel:Clone();
                    v189.Name = "OutfitName";
                    v189.Text = "<b>" .. "OutfitName" .. "</b>: " .. tostring(Name);
                    v189.LayoutOrder = #u150.preview.statistics:GetChildren();
                    v189.Parent = u150.preview.statistics;
                    local v190 = v187.ShareCode or "N/A";
                    local v191 = script.statisticsLabel:Clone();
                    v191.Name = "ShareCode";
                    v191.Text = "<b>" .. "ShareCode" .. "</b>: " .. tostring(v190);
                    v191.LayoutOrder = #u150.preview.statistics:GetChildren();
                    v191.Parent = u150.preview.statistics;
                end);
            end;
        else
            u150.label.Text = "Ban reason (no evidence stored):";
        end;
    else
        u150.moderatorName.Text = "";
        u150.moderationDate.Text = "";
        u150.moderationAction.Text = "";
        u150.reasonContainer.reason.Text = "Not currently banned.";
        u150.label.Text = "";
    end;

    if v149.History and #v149.History > 0 then
        local v192 = tostring(#v149.History) .. " previous ban(s)";
        local v193 = script.statisticsLabel:Clone();
        v193.Name = "BanHistory";
        v193.Text = "<b>" .. "BanHistory" .. "</b>: " .. tostring(v192);
        v193.LayoutOrder = #u150.preview.statistics:GetChildren();
        v193.Parent = u150.preview.statistics;
    end;

    u150.Parent = v147;
end;

local function fetchModeratedOutfit(p194) -- Line: 1145
    -- upvalues: mainSection (copy), Remotes (copy), Events (copy), HumanoidDescriptionController (copy), AvatarPreviewController (copy), Players (copy)
    local restoreCommunityOutfits = mainSection.restoreCommunityOutfits;
    local v195, u196 = Remotes.CommunityOutfitsAction:InvokeServer("GetModeratedOutfit", p194);

    if not v195 then
        Events.Notify:Fire("❌ Something went wrong: " .. tostring(u196));

        return;
    end;

    Events.Notify:Fire("✅ Found outfit.");

    if restoreCommunityOutfits:FindFirstChild("outfit") then
        restoreCommunityOutfits.outfit:Destroy();
    end;

    restoreCommunityOutfits.noOutfitLoaded.Visible = false;
    local v197, v198 = HumanoidDescriptionController.DeserializeHumanoidDescription(u196.HumanoidDescription);
    local u199 = script.outfit:Clone();
    AvatarPreviewController.new(u199.preview.viewport, v197, {
        AllowCameraAdjustment = true,
        RigType = v198
    });

    local function _(p200, p201) -- Line: 1167
        -- upvalues: u199 (copy)
        local v202 = script.statisticsLabel:Clone();
        v202.Name = p200;
        v202.Text = "<b>" .. p200 .. "</b>: " .. tostring(p201);
        v202.LayoutOrder = #u199.preview.statistics:GetChildren();
        v202.Parent = u199.preview.statistics;
    end;

    local Name = u196.Name;
    local v203 = script.statisticsLabel:Clone();
    v203.Name = "Name";
    v203.Text = "<b>" .. "Name" .. "</b>: " .. tostring(Name);
    v203.LayoutOrder = #u199.preview.statistics:GetChildren();
    v203.Parent = u199.preview.statistics;
    local Id = u196.Id;
    local v204 = script.statisticsLabel:Clone();
    v204.Name = "InternalId";
    v204.Text = "<b>" .. "InternalId" .. "</b>: " .. tostring(Id);
    v204.LayoutOrder = #u199.preview.statistics:GetChildren();
    v204.Parent = u199.preview.statistics;
    local Name2 = v198.Name;
    local v205 = script.statisticsLabel:Clone();
    v205.Name = "RigType";
    v205.Text = "<b>" .. "RigType" .. "</b>: " .. tostring(Name2);
    v205.LayoutOrder = #u199.preview.statistics:GetChildren();
    v205.Parent = u199.preview.statistics;
    local v206 = os.date("%Y-%m-%d %H:%M:%S", u196.Created);
    local v207 = script.statisticsLabel:Clone();
    v207.Name = "Created";
    v207.Text = "<b>" .. "Created" .. "</b>: " .. tostring(v206);
    v207.LayoutOrder = #u199.preview.statistics:GetChildren();
    v207.Parent = u199.preview.statistics;
    local v208 = not u196.Updated and "Never" or os.date("%Y-%m-%d %H:%M:%S", u196.Updated);
    local v209 = script.statisticsLabel:Clone();
    v209.Name = "Updated";
    v209.Text = "<b>" .. "Updated" .. "</b>: " .. tostring(v208);
    v209.LayoutOrder = #u199.preview.statistics:GetChildren();
    v209.Parent = u199.preview.statistics;
    local CreatorId = u196.CreatorId;
    local v210 = script.statisticsLabel:Clone();
    v210.Name = "CreatorId";
    v210.Text = "<b>" .. "CreatorId" .. "</b>: " .. tostring(CreatorId);
    v210.LayoutOrder = #u199.preview.statistics:GetChildren();
    v210.Parent = u199.preview.statistics;
    local CommentCount = u196.CommentCount;
    local v211 = script.statisticsLabel:Clone();
    v211.Name = "Comments";
    v211.Text = "<b>" .. "Comments" .. "</b>: " .. tostring(CommentCount);
    v211.LayoutOrder = #u199.preview.statistics:GetChildren();
    v211.Parent = u199.preview.statistics;
    local FavoriteCount = u196.FavoriteCount;
    local v212 = script.statisticsLabel:Clone();
    v212.Name = "Favorites";
    v212.Text = "<b>" .. "Favorites" .. "</b>: " .. tostring(FavoriteCount);
    v212.LayoutOrder = #u199.preview.statistics:GetChildren();
    v212.Parent = u199.preview.statistics;
    local WornCount = u196.WornCount;
    local v213 = script.statisticsLabel:Clone();
    v213.Name = "Worn";
    v213.Text = "<b>" .. "Worn" .. "</b>: " .. tostring(WornCount);
    v213.LayoutOrder = #u199.preview.statistics:GetChildren();
    v213.Parent = u199.preview.statistics;
    local ShareCode = u196.ShareCode;
    local v214 = script.statisticsLabel:Clone();
    v214.Name = "ShareCode";
    v214.Text = "<b>" .. "ShareCode" .. "</b>: " .. tostring(ShareCode);
    v214.LayoutOrder = #u199.preview.statistics:GetChildren();
    v214.Parent = u199.preview.statistics;
    u199.name.Text = "<b>Name:</b> " .. u196.Name;
    u199.creator.Text = "<b>Creator:</b> " .. tostring(u196.CreatorId);
    task.spawn(function() -- Line: 1189
        -- upvalues: Players (ref), u196 (copy), u199 (copy)
        pcall(function() -- Line: 1190
            -- upvalues: Players (ref), u196 (ref), u199 (ref)
            local v215 = Players:GetNameFromUserIdAsync(u196.CreatorId);
            u199.creator.Text = "<b>Creator:</b> " .. tostring(v215) .. ` ({u196.CreatorId})`;
        end);
    end);
    u199.moderatorName.Text = "<b>Moderator:</b> " .. tostring(u196.ModeratorId);
    task.spawn(function() -- Line: 1197
        -- upvalues: Players (ref), u196 (copy), u199 (copy)
        pcall(function() -- Line: 1198
            -- upvalues: Players (ref), u196 (ref), u199 (ref)
            local v216 = Players:GetNameFromUserIdAsync(u196.ModeratorId);
            u199.moderatorName.Text = "<b>Moderator:</b> " .. tostring(v216) .. ` ({u196.ModeratorId})`;
        end);
    end);
    u199.moderationDate.Text = "<b>Moderated at:</b> " .. os.date("%Y-%m-%d %H:%M:%S", u196.ModerationDate);
    u199.moderationAction.Text = "<b>Moderation action:</b> " .. tostring(u196.BanType);
    u199.reasonContainer.reason.Text = tostring(u196.ModerationReason);
    u199.restore.Activated:Connect(function() -- Line: 1208
        -- upvalues: Events (ref), Remotes (ref), u196 (copy)
        if Events.PromptConfirmationDialog:Invoke({
            Title = "Confirm Outfit Restoration",
            Description = "Are you sure you want to restore this outfit?",
            YesText = "Restore",
            NoText = "Cancel"
        }) then
            local v217, v218 = Remotes.CommunityOutfitsAction:InvokeServer("ModerateOutfit", "Restore", u196.Id);

            if v217 then
                if v218.success == true then
                    Events.Notify:Fire("✅ Outfit restored.");

                    return;
                end;

                if v218.message then
                    Events.Notify:Fire("❌ Something went wrong: " .. v218.message);
                end;
            else
                Events.Notify:Fire("❌ Failed to restore outfit.");
            end;
        end;
    end);
    u199.Parent = restoreCommunityOutfits;
end;

local OutsideClickDetector = require(Modules.Utilities.OutsideClickDetector);
local u219 = {
    generation = 0,
    data = nil,
    windowDays = 28
};
local u220 = {};
local u221 = {};
local u222 = false;

local function resolveUsername(p223, p224) -- Line: 1250
    -- upvalues: u220 (copy), u221 (ref), u222 (ref)
    local v225 = tonumber(p223);

    if not v225 or v225 <= 0 then
        task.spawn(p224, nil);

        return;
    end;

    local v226 = u220[v225];

    if v226 then
        task.spawn(p224, v226);

        return;
    end;

    local v227 = u221[v225];

    if v227 then
        table.insert(v227, p224);
    else
        u221[v225] = { p224 };
    end;

    if u222 then
        return;
    end;

    u222 = true;
    task.delay(0.2, function() -- Line: 1269
        -- upvalues: u222 (ref), u221 (ref), u220 (ref)
        u222 = false;
        local v228 = u221;
        u221 = {};
        local v229 = {};

        for i in v228 do
            table.insert(v229, i);
        end;

        local UserService = game:GetService("UserService");

        for i = 1, #v229, 200 do
            local v230 = {};

            for i2 = i, math.min(i + 199, #v229) do
                table.insert(v230, v229[i2]);
            end;

            local success, result = pcall(UserService.GetUserInfosByUserIdsAsync, UserService, v230);

            if not success then
                warn("[ModeratorPanel] username batch failed:", result);
            end;

            if success and typeof(result) == "table" then
                for _, v in result do
                    if v.Id and v.Username then
                        u220[v.Id] = v.Username;
                    end;
                end;
            end;
        end;

        for i, v in v228 do
            for _, v2 in v do
                task.spawn(v2, u220[i]);
            end;
        end;
    end);
end;

local u231 = {
    blue = Color3.fromRGB(60, 100, 250),
    violet = Color3.fromRGB(179, 132, 251),
    text = Color3.fromRGB(255, 255, 255),
    mut = Color3.fromRGB(184, 185, 191),
    mut2 = Color3.fromRGB(213, 215, 221),
    line = Color3.fromRGB(49, 51, 57),
    green = Color3.fromRGB(57, 197, 130),
    red = Color3.fromRGB(244, 91, 82),
    track = Color3.fromRGB(35, 36, 41)
};
local u232 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Regular);
local u233 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.SemiBold);
local u234 = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Bold);
local u235 = {
    ban1Day = "1-day ban",
    ban3Days = "3-day ban",
    ban7Days = "7-day ban",
    ban30Days = "30-day ban",
    permBan = "Permanent ban",
    Reset = "Outfit reset",
    Dismiss = "Dismissed reports",
    Approve = "Dismissed reports",
    Restore = "Outfit restored",
    autoDetection = "Automated ban",
    Dismissed = "Dismissed reports"
};
local u236 = {
    {
        key = "Dismissed",
        label = "Dismissed reports",
        short = "Dismissed",
        color = Color3.fromRGB(57, 197, 130)
    },
    {
        key = "OutfitBan",
        label = "Outfit bans",
        short = "Outfit bans",
        color = Color3.fromRGB(60, 100, 250)
    },
    {
        key = "PlayerBan",
        label = "Player bans",
        short = "Player bans",
        color = Color3.fromRGB(179, 132, 251)
    },
    {
        key = "Reset",
        label = "Outfit resets",
        short = "Resets",
        color = Color3.fromRGB(244, 91, 82)
    },
    {
        key = "Restore",
        label = "Restores",
        short = "Restores",
        color = Color3.fromRGB(240, 185, 60)
    }
};

local function dashDayTotal(p237) -- Line: 1336
    -- upvalues: u236 (copy)
    local v238 = 0;

    for _, v in u236 do
        v238 = v238 + (p237[v.key] or 0);
    end;

    return v238;
end;

local function dashComma(p239) -- Line: 1344
    local v240 = tonumber(p239) or 0;
    local v241 = math.floor(v240);

    return tostring(v241):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

local function dashTimeAgo(p242) -- Line: 1350
    if not p242 then
        return "--";
    end;

    local v243 = os.time() - p242;
    local v244 = math.max(0, v243);

    if v244 < 60 then
        return "just now";
    end;

    if v244 < 3600 then
        return math.floor(v244 / 60) .. " min ago";
    end;

    if v244 < 86400 then
        return math.floor(v244 / 3600) .. " h ago";
    end;

    return math.floor(v244 / 86400) .. " d ago";
end;

local function dashAge(p245) -- Line: 1359
    if not p245 then
        return "--";
    end;

    local v246 = os.time() - p245;
    local v247 = math.max(0, v246);

    if v247 < 3600 then
        return math.floor(v247 / 60) .. " min";
    end;

    if v247 < 86400 then
        return math.floor(v247 / 3600) .. " h";
    end;

    return math.floor(v247 / 86400) .. " d";
end;

local function dashUsername(p248, u249, u250) -- Line: 1367
    -- upvalues: u220 (copy), resolveUsername (copy)
    if not p248 or p248 <= 0 then
        u249.Text = "Automated";

        return;
    end;

    local v251 = u220[p248];

    if v251 then
        u249.Text = (u250 or "") .. v251;

        return;
    end;

    u249.Text = (u250 or "") .. tostring(p248);
    resolveUsername(p248, function(p252) -- Line: 1378
        -- upvalues: u249 (copy), u250 (copy)
        if p252 and u249.Parent then
            u249.Text = (u250 or "") .. p252;
        end;
    end);
end;

local function dashMk(p253, p254, p255) -- Line: 1385
    -- upvalues: u232 (copy), u231 (copy)
    local v256 = Instance.new(p253);
    v256.BorderSizePixel = 0;
    v256:SetAttribute("SkipTheme", true);

    if p253 == "TextLabel" or p253 == "TextButton" then
        v256.BackgroundTransparency = 1;
        v256.FontFace = u232;
        v256.TextColor3 = u231.text;
        v256.TextSize = 21;
        v256.TextXAlignment = Enum.TextXAlignment.Left;
        v256.Text = "";

        if p253 == "TextButton" then
            v256.AutoButtonColor = false;
        end;
    elseif p253 == "Frame" then
        v256.BackgroundColor3 = u231.text;
    end;

    for i, v in p254 do
        v256[i] = v;
    end;

    v256.Parent = p255;

    return v256;
end;

local function dashContainer() -- Line: 1406
    -- upvalues: mainSection (copy)
    return mainSection:FindFirstChild("dashboard");
end;

local function dashClear(p257) -- Line: 1410
    for _, child in p257:GetChildren() do
        if not child:IsA("UIListLayout") then
            child:Destroy();
        end;
    end;
end;

local function dashSkeletonBlock(p258, p259, p260, p261, p262) -- Line: 1419
    -- upvalues: u231 (copy), TweenService (copy)
    local v263 = {
        Name = "_skeleton",
        BackgroundTransparency = 0.35,
        BackgroundColor3 = u231.track,
        Position = UDim2.fromOffset(p259, p260),
        Size = UDim2.fromOffset(p261, p262)
    };
    local Frame = Instance.new("Frame");
    Frame.BorderSizePixel = 0;
    Frame:SetAttribute("SkipTheme", true);
    Frame.BackgroundColor3 = u231.text;

    for i, v in v263 do
        Frame[i] = v;
    end;

    Frame.Parent = p258;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 8);
    UICorner.Parent = Frame;
    TweenService:Create(Frame, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        BackgroundTransparency = 0.62
    }):Play();

    return Frame;
end;

local function dashHideSkeletons(p264) -- Line: 1434
    for _, descendant in p264:GetDescendants() do
        if descendant.Name == "_skeleton" then
            descendant:Destroy();
        end;
    end;
end;

local function dashSizeChip(u265, u266) -- Line: 1444
    task.spawn(function() -- Line: 1445
        -- upvalues: u265 (copy), u266 (copy)
        local u267 = nil;
        pcall(function() -- Line: 1447
            -- upvalues: u265 (ref), u267 (ref)
            local GetTextBoundsParams = Instance.new("GetTextBoundsParams");
            GetTextBoundsParams.Text = u265.Text;
            GetTextBoundsParams.Font = u265.FontFace;
            GetTextBoundsParams.Size = u265.TextSize;
            GetTextBoundsParams.Width = 1000;
            u267 = game:GetService("TextService"):GetTextBoundsAsync(GetTextBoundsParams).X;
        end);

        if u267 and u265.Parent then
            u265.Size = UDim2.fromOffset(math.ceil(u267) + (u266 or 10) * 2, u265.Size.Y.Offset);
        end;
    end);
end;

local function dashShowHomeSkeleton() -- Line: 1463
    -- upvalues: mainSection (copy), dashHideSkeletons (copy), dashClear (copy), dashSkeletonBlock (copy)
    local dashboard = mainSection:FindFirstChild("dashboard");

    if not dashboard then
        return;
    end;

    local home = dashboard.home;
    dashHideSkeletons(home);
    dashClear(home.actionsCard.plot);
    dashClear(home.actionsCard.axis);
    dashClear(home.typesCard.bars);
    dashClear(home.modsCard.table);
    dashClear(home.feedCard.feed);
    dashClear(home.trendsCard.plot);
    dashClear(home.trendsCard.axis);
    dashClear(home.trendsCard.legend);
    dashClear(home.detectionCard.stats);
    dashClear(home.detectionCard.plot);
    dashClear(home.detectionCard.axis);
    dashClear(home.detectionCard.legend);
    local pill = home.actionsCard:FindFirstChild("pill");

    if pill then
        pill:Destroy();
    end;

    for _, child in home.kpis:GetChildren() do
        local value = child:FindFirstChild("value");

        if value then
            value.Text = "";
            dashSkeletonBlock(child, 0, 38, 110, 28);
        end;
    end;

    home.actionsCard.total.Text = "";
    dashSkeletonBlock(home.actionsCard, 0, 82, 220, 30);
    dashSkeletonBlock(home.actionsCard.plot, 0, 0, 624, 214);

    for i = 1, 5 do
        dashSkeletonBlock(home.typesCard.bars, 0, (i - 1) * 54 + 6, 372, 34);
    end;

    dashSkeletonBlock(home.modsCard.table, 0, 6, 624, 40);
    dashSkeletonBlock(home.modsCard.table, 0, 60, 624, 40);
    dashSkeletonBlock(home.modsCard.table, 0, 114, 624, 40);
    dashSkeletonBlock(home.modsCard.table, 0, 168, 624, 40);
    dashSkeletonBlock(home.feedCard.feed, 0, 6, 372, 40);
    dashSkeletonBlock(home.feedCard.feed, 0, 60, 372, 40);
    dashSkeletonBlock(home.feedCard.feed, 0, 114, 372, 40);
    dashSkeletonBlock(home.feedCard.feed, 0, 168, 372, 40);
    dashSkeletonBlock(home.trendsCard.plot, 0, 0, 1048, 224);
    dashSkeletonBlock(home.detectionCard.stats, 0, 0, 1048, 64);
    dashSkeletonBlock(home.detectionCard.plot, 0, 0, 1048, 166);
end;

local u268 = nil;

local function dashCloseInspect() -- Line: 1509
    -- upvalues: u268 (ref), mainSection (copy)
    if u268 then
        pcall(function() -- Line: 1511
            -- upvalues: u268 (ref)
            u268:Destroy();
        end);
        u268 = nil;
    end;

    local dashboard = mainSection:FindFirstChild("dashboard");
    local v269 = dashboard and dashboard.detail:FindFirstChild("_inspect");

    if v269 then
        v269:Destroy();
    end;
end;

local function dashInspectEntry(u270, u271) -- Line: 1521
    -- upvalues: mainSection (copy), Events (copy), dashCloseInspect (copy), u231 (copy), HumanoidDescriptionController (copy), u268 (ref), AvatarPreviewController (copy), resolveUsername (copy), u235 (copy), u5 (copy)
    local dashboard = mainSection:FindFirstChild("dashboard");

    if not dashboard then
        return;
    end;

    if not u270.HumanoidDescription then
        Events.Notify:Fire("⚠️ No stored evidence for this action.");

        return;
    end;

    dashCloseInspect();
    local v272 = {
        Name = "_inspect",
        ZIndex = 20,
        BackgroundColor3 = Color3.fromRGB(18, 18, 21),
        Size = UDim2.new(1, 0, 1, 0)
    };
    local detail = dashboard.detail;
    local Frame = Instance.new("Frame");
    Frame.BorderSizePixel = 0;
    Frame:SetAttribute("SkipTheme", true);
    Frame.BackgroundColor3 = u231.text;

    for i, v in v272 do
        Frame[i] = v;
    end;

    Frame.Parent = detail;
    local v273, v274 = HumanoidDescriptionController.DeserializeHumanoidDescription(u270.HumanoidDescription);
    local u275 = script.outfit:Clone();
    u268 = AvatarPreviewController.new(u275.preview.viewport, v273, {
        AllowCameraAdjustment = true,
        RigType = v274
    });

    local function _(p276, p277) -- Line: 1541
        -- upvalues: u275 (copy)
        local v278 = script.statisticsLabel:Clone();
        v278.Name = p276;
        v278.Text = "<b>" .. p276 .. "</b>: " .. tostring(p277);
        v278.LayoutOrder = #u275.preview.statistics:GetChildren();
        v278.Parent = u275.preview.statistics;
    end;

    local Type = u270.Type;
    local v279 = script.statisticsLabel:Clone();
    v279.Name = "Type";
    v279.Text = "<b>" .. "Type" .. "</b>: " .. tostring(Type);
    v279.LayoutOrder = #u275.preview.statistics:GetChildren();
    v279.Parent = u275.preview.statistics;
    local Name = v274.Name;
    local v280 = script.statisticsLabel:Clone();
    v280.Name = "RigType";
    v280.Text = "<b>" .. "RigType" .. "</b>: " .. tostring(Name);
    v280.LayoutOrder = #u275.preview.statistics:GetChildren();
    v280.Parent = u275.preview.statistics;

    if u270.Type == "Outfit" then
        local OutfitId = u270.OutfitId;
        local v281 = script.statisticsLabel:Clone();
        v281.Name = "OutfitId";
        v281.Text = "<b>" .. "OutfitId" .. "</b>: " .. tostring(OutfitId);
        v281.LayoutOrder = #u275.preview.statistics:GetChildren();
        v281.Parent = u275.preview.statistics;
        local CreatorId = u270.CreatorId;
        local v282 = script.statisticsLabel:Clone();
        v282.Name = "CreatorId";
        v282.Text = "<b>" .. "CreatorId" .. "</b>: " .. tostring(CreatorId);
        v282.LayoutOrder = #u275.preview.statistics:GetChildren();
        v282.Parent = u275.preview.statistics;
    else
        local ReportedUserId = u270.ReportedUserId;
        local v283 = script.statisticsLabel:Clone();
        v283.Name = "ReportedUserId";
        v283.Text = "<b>" .. "ReportedUserId" .. "</b>: " .. tostring(ReportedUserId);
        v283.LayoutOrder = #u275.preview.statistics:GetChildren();
        v283.Parent = u275.preview.statistics;

        if u270.ReportCount then
            local ReportCount = u270.ReportCount;
            local v284 = script.statisticsLabel:Clone();
            v284.Name = "Reports";
            v284.Text = "<b>" .. "Reports" .. "</b>: " .. tostring(ReportCount);
            v284.LayoutOrder = #u275.preview.statistics:GetChildren();
            v284.Parent = u275.preview.statistics;
        end;
    end;

    local v285 = u270.Type == "Outfit";
    local u286 = v285 and u270.CreatorId or u270.ReportedUserId;
    local u287 = v285 and "Creator" or "User";
    u275.name.Text = "<b>Name:</b> " .. tostring(u270.Name or u270.Type .. " snapshot");
    u275.creator.Text = "<b>" .. u287 .. ":</b> " .. tostring(u286);
    resolveUsername(u286, function(p288) -- Line: 1562
        -- upvalues: u275 (copy), u287 (copy), u286 (copy)
        if p288 and u275.Parent then
            u275.creator.Text = "<b>" .. u287 .. ":</b> @" .. p288 .. ` ({u286})`;
        end;
    end);
    u275.moderatorName.Text = "<b>Moderator:</b> " .. tostring(u270.ModeratorId);
    resolveUsername(u270.ModeratorId, function(p289) -- Line: 1568
        -- upvalues: u275 (copy), u270 (copy)
        if p289 and u275.Parent then
            u275.moderatorName.Text = "<b>Moderator:</b> @" .. p289 .. ` ({u270.ModeratorId})`;
        end;
    end);
    u275.moderationDate.Text = "<b>Actioned at:</b> " .. (u270.ActionedAt and (os.date("%Y-%m-%d %H:%M:%S", u270.ActionedAt) or "Unknown") or "Unknown");
    u275.moderationAction.Text = "<b>Action:</b> " .. (u235[u270.Action] or tostring(u270.Action));
    u275.reasonContainer.reason.Text = u270.Reason and tostring(u270.Reason) ~= "" and (tostring(u270.Reason) or "(no reason recorded)") or "(no reason recorded)";
    u275.restore.label.Text = "Close";
    u275.restore.Activated:Connect(function() -- Line: 1577
        -- upvalues: dashCloseInspect (ref), u271 (copy)
        dashCloseInspect();

        if u271 then
            u271();
        end;
    end);

    if u270.Detection and u5._attachDetectionBadge then
        u5._attachDetectionBadge(u275.preview, u270.Detection, v273);
    end;

    u275.Parent = Frame;
end;

local function dashHoverCard(p290) -- Line: 1592
    -- upvalues: u231 (copy), u233 (copy), u232 (copy)
    local v291 = {
        Name = "_hoverCard",
        Visible = false,
        ZIndex = 30,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    };
    local Frame = Instance.new("Frame");
    Frame.BorderSizePixel = 0;
    Frame:SetAttribute("SkipTheme", true);
    Frame.BackgroundColor3 = u231.text;

    for i, v in v291 do
        Frame[i] = v;
    end;

    Frame.Parent = p290;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 8);
    UICorner.Parent = Frame;

    return {
        show = function(p292, p293, p294, p295, p296) -- Line: 1605, Name: show
            -- upvalues: Frame (copy), u233 (ref), u232 (ref), u231 (ref)
            for _, child in Frame:GetChildren() do
                if child:IsA("TextLabel") or child:IsA("Frame") then
                    child:Destroy();
                end;
            end;

            local v297 = utf8.len(p294) or #p294;
            local v298 = math.max(140, v297 * 9 + 24);
            local v299 = {
                TextSize = 16,
                ZIndex = 31,
                Text = p294,
                FontFace = u233,
                TextColor3 = Color3.fromRGB(18, 18, 21),
                Position = UDim2.fromOffset(12, 8),
                Size = UDim2.fromOffset(360, 20)
            };
            local TextLabel = Instance.new("TextLabel");
            TextLabel.BorderSizePixel = 0;
            TextLabel:SetAttribute("SkipTheme", true);
            TextLabel.BackgroundTransparency = 1;
            TextLabel.FontFace = u232;
            TextLabel.TextColor3 = u231.text;
            TextLabel.TextSize = 21;
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel.Text = "";

            for i, v in v299 do
                TextLabel[i] = v;
            end;

            TextLabel.Parent = Frame;

            for i, v in p295 do
                local v300 = 34 + (i - 1) * 24;
                local v301;

                if v.color then
                    local v302 = {
                        ZIndex = 31,
                        BackgroundColor3 = v.color,
                        Position = UDim2.fromOffset(12, v300 + 5),
                        Size = UDim2.fromOffset(9, 9)
                    };
                    local Frame2 = Instance.new("Frame");
                    Frame2.BorderSizePixel = 0;
                    Frame2:SetAttribute("SkipTheme", true);
                    Frame2.BackgroundColor3 = u231.text;

                    for i2, v2 in v302 do
                        Frame2[i2] = v2;
                    end;

                    Frame2.Parent = Frame;
                    local UICorner2 = Instance.new("UICorner");
                    UICorner2.CornerRadius = UDim.new(1, 0);
                    UICorner2.Parent = Frame2;
                    v301 = 28;
                else
                    v301 = 12;
                end;

                local v303 = {
                    TextSize = 16,
                    ZIndex = 31,
                    Text = v.label,
                    TextColor3 = Color3.fromRGB(96, 97, 102),
                    Position = UDim2.fromOffset(v301, v300),
                    Size = UDim2.fromOffset(300, 20)
                };
                local TextLabel2 = Instance.new("TextLabel");
                TextLabel2.BorderSizePixel = 0;
                TextLabel2:SetAttribute("SkipTheme", true);
                TextLabel2.BackgroundTransparency = 1;
                TextLabel2.FontFace = u232;
                TextLabel2.TextColor3 = u231.text;
                TextLabel2.TextSize = 21;
                TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
                TextLabel2.Text = "";

                for i2, v2 in v303 do
                    TextLabel2[i2] = v2;
                end;

                TextLabel2.Parent = Frame;
                local v304 = {
                    TextSize = 16,
                    ZIndex = 31,
                    Text = tostring(v.value),
                    FontFace = u233,
                    TextColor3 = Color3.fromRGB(18, 18, 21),
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Position = UDim2.fromOffset(0, v300),
                    Size = UDim2.new(1, -12, 0, 20)
                };
                local TextLabel3 = Instance.new("TextLabel");
                TextLabel3.BorderSizePixel = 0;
                TextLabel3:SetAttribute("SkipTheme", true);
                TextLabel3.BackgroundTransparency = 1;
                TextLabel3.FontFace = u232;
                TextLabel3.TextColor3 = u231.text;
                TextLabel3.TextSize = 21;
                TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
                TextLabel3.Text = "";

                for i2, v2 in v304 do
                    TextLabel3[i2] = v2;
                end;

                TextLabel3.Parent = Frame;
                local v305 = v301 + ((utf8.len(v.label) or #v.label) + #tostring(v.value)) * 9 + 44;
                v298 = math.max(v298, v305);
            end;

            local v306 = #p295 * 24 + 38;
            Frame.Size = UDim2.fromOffset(v298, v306);
            Frame.Position = UDim2.new(p292, p296 and p293 - v298 - 18 or p293 + 18, 0.5, -v306 / 2);
            Frame.Visible = true;
        end,

        hide = function() -- Line: 1660, Name: hide
            -- upvalues: Frame (copy)
            Frame.Visible = false;
        end
    };
end;

function u5._attachDetectionBadge(p307, p308, u309) -- Line: 1672
    -- upvalues: TweenService (copy), u2 (copy), AvatarEditorService (copy)
    if not p307 or typeof(p308) ~= "table" then
        return;
    end;

    local TextService = game:GetService("TextService");
    local CollectionService = game:GetService("CollectionService");
    local v310 = tonumber(p308.Score) or 0;
    local v311 = {
        Reset = Color3.fromRGB(244, 91, 82),
        Hide = Color3.fromRGB(240, 185, 60),
        Near = Color3.fromRGB(184, 185, 191),
        Clean = Color3.fromRGB(57, 197, 130)
    };
    local v312 = v311[p308.Band] or v311.Clean;
    local v313 = ({
        Reset = "#F45B52",
        Hide = "#F0B93C",
        Near = "#B8B9BF",
        Clean = "#39C582"
    })[p308.Band] or "#39C582";
    local u314 = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold);
    local v315 = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium);
    local v316 = Color3.fromRGB(24, 25, 33);
    local v317 = Color3.fromRGB(70, 68, 77);
    local v318 = Color3.fromRGB(213, 215, 221);
    local v319 = Color3.fromRGB(214, 213, 222);
    local actions = p307:FindFirstChild("actions");
    local v320 = actions and (actions.Position.X.Scale or 0.0115) or 0.0115;
    local v321 = actions and actions.Size.Y.Scale or 0.0734;
    local u322 = "Detection Score: " .. v310;
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "detectionBadge";
    TextButton.AnchorPoint = Vector2.new(0, 1);
    TextButton.Position = UDim2.new(v320, 0, 1 - v321, -8);
    TextButton.Size = UDim2.new(0, 240, 0, 40);
    TextButton.BackgroundColor3 = v316;
    TextButton.BackgroundTransparency = 0.1;
    TextButton.BorderSizePixel = 0;
    TextButton.AutoButtonColor = false;
    TextButton.Text = "";
    TextButton.Style = Enum.ButtonStyle.Custom;
    TextButton.ZIndex = 6;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0.2, 0);
    UICorner.Parent = TextButton;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = v317;
    UIStroke.Thickness = 1.5;
    UIStroke.Transparency = 0.3;
    UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke.Parent = TextButton;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "label";
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = u314;
    TextLabel.RichText = true;
    TextLabel.Text = ("Detection Score: <font color=\"%s\">%d</font>"):format(v313, v310);
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
    TextLabel.TextSize = 21;
    TextLabel.TextWrapped = false;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.TextYAlignment = Enum.TextYAlignment.Center;
    TextLabel.AnchorPoint = Vector2.new(0, 0.5);
    TextLabel.Position = UDim2.new(0, 16, 0.5, 0);
    TextLabel.Size = UDim2.new(1, -60, 1, 0);
    TextLabel.ZIndex = 7;
    TextLabel.Parent = TextButton;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "chevron";
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = "rbxassetid://131607777349580";
    ImageLabel.ImageColor3 = v319;
    ImageLabel.ScaleType = Enum.ScaleType.Fit;
    ImageLabel.AnchorPoint = Vector2.new(1, 0.5);
    ImageLabel.Position = UDim2.new(1, -14, 0.5, 0);
    ImageLabel.Size = UDim2.new(0, 20, 0, 20);
    ImageLabel.Rotation = 180;
    ImageLabel.ZIndex = 7;
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint.AspectRatio = 1;
    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height;
    UIAspectRatioConstraint.Parent = ImageLabel;
    ImageLabel.Parent = TextButton;
    TextButton.Parent = p307;
    CollectionService:AddTag(TextButton, "UIEffectSoundOnly");
    task.spawn(function() -- Line: 1769
        -- upvalues: u322 (copy), u314 (copy), TextService (copy), TextButton (copy)
        local u323 = nil;
        pcall(function() -- Line: 1771
            -- upvalues: u322 (ref), u314 (ref), u323 (ref), TextService (ref)
            local GetTextBoundsParams = Instance.new("GetTextBoundsParams");
            GetTextBoundsParams.Text = u322;
            GetTextBoundsParams.Font = u314;
            GetTextBoundsParams.Size = 21;
            GetTextBoundsParams.Width = 1000;
            u323 = TextService:GetTextBoundsAsync(GetTextBoundsParams).X;
        end);

        if not u323 or TextButton.Parent == nil then
            return;
        end;

        TextButton.Size = UDim2.new(0, math.ceil(u323) + 16 + 12 + 20 + 14, 0, 40);
    end);
    local v324 = {};
    local v325 = {};

    for _, v in p308.Items or {} do
        local v326 = tonumber(v.Id);

        if v326 and v326 > 0 then
            v324[v326] = v.Score;
        else
            local v327 = {
                color = v312,
                label = v.Label or "Stack rule",
                value = "+" .. tostring(v.Score)
            };
            table.insert(v325, v327);
        end;
    end;

    local v328 = {};
    local u329 = {};

    for i, v in v324 do
        local v330 = {
            id = i,
            contribution = tonumber(v) or 0
        };
        table.insert(v328, v330);
    end;

    table.sort(v328, function(p331, p332) -- Line: 1802
        return p331.contribution > p332.contribution;
    end);

    for _, v in v328 do
        local v333 = {
            color = v.contribution >= 40 and v311.Reset or v311.Hide,
            label = tostring(v.id),
            value = "+" .. tostring(v.contribution),
            id = v.id
        };
        table.insert(u329, v333);
    end;

    local u334 = {};
    pcall(function() -- Line: 1812
        -- upvalues: u334 (ref), u309 (copy)
        u334 = u309:GetAccessories(true);
    end);
    local v335 = math.max(4, 14 - #u329);
    local v336 = 0;
    local v337 = 0;

    for _, v in u334 do
        local v338 = tonumber(v.AssetId);

        if not (v338 and v324[v338]) then
            v336 = v336 + 1;

            if v337 < v335 then
                v337 = v337 + 1;
                local v339 = {
                    value = "",
                    label = tostring(v338),
                    id = v338
                };
                table.insert(u329, v339);
            end;
        end;
    end;

    if v337 < v336 then
        table.insert(u329, {
            value = "",
            label = "+ " .. v336 - v337 .. " more accessories"
        });
    end;

    for _, v in v325 do
        table.insert(u329, v);
    end;

    if #u329 == 0 then
        table.insert(u329, {
            label = "No accessories worn",
            value = ""
        });
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "detectionBreakdown";
    Frame.AnchorPoint = Vector2.new(0, 1);
    Frame.Position = UDim2.new(v320, 0, 1 - v321, -56);
    Frame.Size = UDim2.new(0, 360, 0, #u329 * 34 + 24);
    Frame.BackgroundColor3 = v316;
    Frame.BackgroundTransparency = 0.05;
    Frame.BorderSizePixel = 0;
    Frame.Visible = false;
    Frame.ZIndex = 10;
    local UICorner2 = Instance.new("UICorner");
    UICorner2.CornerRadius = UDim.new(0.06, 0);
    UICorner2.Parent = Frame;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Color = v317;
    UIStroke2.Thickness = 1.5;
    UIStroke2.Transparency = 0.3;
    UIStroke2.LineJoinMode = Enum.LineJoinMode.Round;
    UIStroke2.Parent = Frame;

    for i, v in u329 do
        local v340 = 12 + (i - 1) * 34;

        if v.color then
            local Frame2 = Instance.new("Frame");
            Frame2.BackgroundColor3 = v.color;
            Frame2.BorderSizePixel = 0;
            Frame2.AnchorPoint = Vector2.new(0, 0.5);
            Frame2.Position = UDim2.new(0, 16, 0, v340 + 17);
            Frame2.Size = UDim2.new(0, 10, 0, 10);
            Frame2.ZIndex = 11;
            Frame2.Parent = Frame;
            local UICorner3 = Instance.new("UICorner");
            UICorner3.CornerRadius = UDim.new(1, 0);
            UICorner3.Parent = Frame2;
        end;

        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.FontFace = v315;
        TextLabel2.Text = v.label;
        local v341;

        if v.color then
            v341 = Color3.fromRGB(255, 255, 255) or v318;
        else
            v341 = v318;
        end;

        TextLabel2.TextColor3 = v341;
        TextLabel2.TextTransparency = v.color and 0 or 0.3;
        TextLabel2.TextSize = 19;
        TextLabel2.TextWrapped = false;
        TextLabel2.TextTruncate = Enum.TextTruncate.AtEnd;
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel2.TextYAlignment = Enum.TextYAlignment.Center;
        TextLabel2.Position = UDim2.new(0, 34, 0, v340);
        TextLabel2.Size = UDim2.new(1, -104, 0, 34);
        TextLabel2.ZIndex = 11;
        TextLabel2.Parent = Frame;
        v.labelInstance = TextLabel2;

        if v.value ~= "" then
            local TextLabel3 = Instance.new("TextLabel");
            TextLabel3.BackgroundTransparency = 1;
            TextLabel3.FontFace = u314;
            TextLabel3.Text = v.value;
            TextLabel3.TextColor3 = v.color or v318;
            TextLabel3.TextSize = 19;
            TextLabel3.TextWrapped = false;
            TextLabel3.TextXAlignment = Enum.TextXAlignment.Right;
            TextLabel3.AnchorPoint = Vector2.new(1, 0);
            TextLabel3.Position = UDim2.new(1, -16, 0, v340);
            TextLabel3.Size = UDim2.new(0, 54, 0, 34);
            TextLabel3.ZIndex = 11;
            TextLabel3.Parent = Frame;
        end;
    end;

    Frame.Parent = p307;
    local u342 = false;
    TextButton.Activated:Connect(function() -- Line: 1913
        -- upvalues: u342 (ref), Frame (copy), TweenService (ref), ImageLabel (copy), u2 (ref)
        u342 = not u342;
        Frame.Visible = u342;
        TweenService:Create(ImageLabel, u2, {
            Rotation = u342 and 0 or 180
        }):Play();
    end);
    task.spawn(function() -- Line: 1920
        -- upvalues: u329 (copy), AvatarEditorService (ref)
        local u343 = {};

        for _, v in u329 do
            if v.id then
                table.insert(u343, v.id);
            end;
        end;

        if #u343 == 0 then
            return;
        end;

        local success, result = pcall(function() -- Line: 1928
            -- upvalues: AvatarEditorService (ref), u343 (copy)
            return AvatarEditorService:GetBatchItemDetails(u343, Enum.AvatarItemType.Asset);
        end);

        if not success or typeof(result) ~= "table" then
            return;
        end;

        local v344 = {};

        for _, v in result do
            if v.Id and v.Name then
                v344[v.Id] = v.Name;
            end;
        end;

        for _, v in u329 do
            local v345 = v.id and v344[v.id];

            if v345 and (v.labelInstance and v.labelInstance.Parent) then
                local v346 = tostring(v345);

                if #v346 > 26 then
                    v346 = string.sub(v346, 1, 24) .. "...";
                end;

                v.labelInstance.Text = string.format("%s (%d)", v346, v.id);
            end;
        end;
    end);
end;

local function dashServerCleanup() -- Line: 1953
    -- upvalues: u219 (copy)
    u219.serverToken = nil;

    if u219.serverRows then
        for _, v in u219.serverRows do
            if v.preview then
                pcall(function() -- Line: 1958
                    -- upvalues: v (copy)
                    v.preview:Destroy();
                end);
            end;
        end;

        u219.serverRows = nil;
    end;
end;

local function dashboardCleanup() -- Line: 1967
    -- upvalues: u219 (copy), dashCloseInspect (copy), dashServerCleanup (copy), mainSection (copy), dashClear (copy)
    local v347 = u219;
    v347.generation = v347.generation + 1;
    u219.data = nil;
    u219.backTo = nil;
    dashCloseInspect();
    dashServerCleanup();
    local dashboard = mainSection:FindFirstChild("dashboard");

    if not dashboard then
        return;
    end;

    local home = dashboard.home;
    dashClear(home.actionsCard.plot);
    dashClear(home.actionsCard.axis);
    dashClear(home.typesCard.bars);
    dashClear(home.modsCard.table);
    dashClear(home.feedCard.feed);
    dashClear(home.trendsCard.plot);
    dashClear(home.trendsCard.axis);
    dashClear(home.trendsCard.legend);
    dashClear(home.detectionCard.stats);
    dashClear(home.detectionCard.plot);
    dashClear(home.detectionCard.axis);
    dashClear(home.detectionCard.legend);
    dashClear(dashboard.detail.body);
    local _loading = home:FindFirstChild("_loading");

    if _loading then
        _loading:Destroy();
    end;

    for _, child in home.kpis:GetChildren() do
        if child:IsA("Frame") and child:FindFirstChild("value") then
            child.value.Text = "--";
        end;
    end;

    dashboard.home.Visible = true;
    dashboard.home.CanvasPosition = Vector2.zero;
    dashboard.detail.Visible = false;
end;

local function dashShowPage(p348, p349) -- Line: 1999
    -- upvalues: mainSection (copy), dashCloseInspect (copy), dashServerCleanup (copy)
    local dashboard = mainSection:FindFirstChild("dashboard");

    if not dashboard then
        return;
    end;

    dashCloseInspect();
    dashServerCleanup();

    if p348 == "home" then
        dashboard.home.Visible = true;
        dashboard.detail.Visible = false;

        return;
    end;

    dashboard.home.Visible = false;
    dashboard.detail.Visible = true;
    dashboard.detail.body.CanvasPosition = Vector2.zero;
    dashboard.detail.crumbs.Text = `<font color="#B8B9BF">Dashboard  /  </font>{p349}`;
end;

local function dashRenderColumns(p350, p351, p352, p353) -- Line: 2016
    -- upvalues: dashClear (copy), u236 (copy), u231 (copy), u232 (copy), dashHoverCard (copy)
    dashClear(p350);
    dashClear(p351);
    local Days = p352.Days;
    local u354 = #Days;
    local v355 = 1;

    for _, v in Days do
        local v356 = 0;

        for _, v2 in u236 do
            v356 = v356 + (v[v2.key] or 0);
        end;

        v355 = math.max(v355, v356);
    end;

    local v357 = math.log10(v355);
    local v358 = 10 ^ math.floor(v357);
    local v359 = math.ceil(v355 / v358) * v358;
    local v360 = v359 < 4 and 4 or v359;

    if v360 % 2 == 1 then
        v360 = v360 + 1;
    end;

    for _, v in { 0, 0.5, 1 } do
        local v361 = 1 - v;
        local v362 = {
            BackgroundColor3 = u231.line,
            Position = UDim2.new(0, 44, v361, 0),
            Size = UDim2.new(1, -44, 0, 1),
            AnchorPoint = Vector2.new(0, 1)
        };
        local Frame = Instance.new("Frame");
        Frame.BorderSizePixel = 0;
        Frame:SetAttribute("SkipTheme", true);
        Frame.BackgroundColor3 = u231.text;

        for i, v2 in v362 do
            Frame[i] = v2;
        end;

        Frame.Parent = p350;
        local v363 = {
            TextSize = 18
        };
        local v364 = math.floor(v360 * v);
        v363.Text = tostring(v364);
        v363.TextColor3 = u231.mut;
        v363.TextXAlignment = Enum.TextXAlignment.Right;
        v363.Position = UDim2.new(0, 0, v361, -10);
        v363.Size = UDim2.new(0, 36, 0, 20);
        v363.AnchorPoint = Vector2.new(0, 0.5);
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BorderSizePixel = 0;
        TextLabel:SetAttribute("SkipTheme", true);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = u232;
        TextLabel.TextColor3 = u231.text;
        TextLabel.TextSize = 21;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Text = "";

        for i, v2 in v363 do
            TextLabel[i] = v2;
        end;

        TextLabel.Parent = p350;
    end;

    local u365 = p352.GeneratedAt or os.time();
    local u366 = dashHoverCard(p350);

    for i = 1, u354 do
        local v367 = Days[i];
        local v368 = {
            Position = UDim2.new((i - 1) / u354, (i - 1) / u354 * -44 + 44, 0, 0),
            Size = UDim2.new(1 / u354, -44 / u354, 1, 0)
        };
        local TextButton = Instance.new("TextButton");
        TextButton.BorderSizePixel = 0;
        TextButton:SetAttribute("SkipTheme", true);
        TextButton.BackgroundTransparency = 1;
        TextButton.FontFace = u232;
        TextButton.TextColor3 = u231.text;
        TextButton.TextSize = 21;
        TextButton.TextXAlignment = Enum.TextXAlignment.Left;
        TextButton.Text = "";
        TextButton.AutoButtonColor = false;

        for i2, v in v368 do
            TextButton[i2] = v;
        end;

        TextButton.Parent = p350;
        local v369 = 0;

        for _, v in u236 do
            local v370 = v367[v.key] or 0;

            if v370 > 0 then
                local v371 = {
                    BackgroundColor3 = v.color,
                    AnchorPoint = Vector2.new(0.5, 1),
                    Position = UDim2.new(0.5, 0, 1 - v369 / v360, 0),
                    Size = UDim2.new(0.62, 0, v370 / v360, 0)
                };
                local Frame = Instance.new("Frame");
                Frame.BorderSizePixel = 0;
                Frame:SetAttribute("SkipTheme", true);
                Frame.BackgroundColor3 = u231.text;

                for i2, v2 in v371 do
                    Frame[i2] = v2;
                end;

                Frame.Parent = TextButton;
                v369 = v369 + v370;
            end;
        end;

        local v372 = u365 - (u354 - i) * 86400;

        if (i - 1) % 4 == 0 or i == u354 then
            local v373 = {
                TextSize = 18,
                Text = os.date("%b %d", v372),
                TextColor3 = u231.mut,
                TextXAlignment = Enum.TextXAlignment.Center,
                Position = UDim2.new((i - 0.5) / u354, 44 - (i - 0.5) / u354 * 44, 0, 0),
                AnchorPoint = Vector2.new(0.5, 0),
                Size = UDim2.new(0, 64, 1, 0)
            };
            local TextLabel = Instance.new("TextLabel");
            TextLabel.BorderSizePixel = 0;
            TextLabel:SetAttribute("SkipTheme", true);
            TextLabel.BackgroundTransparency = 1;
            TextLabel.FontFace = u232;
            TextLabel.TextColor3 = u231.text;
            TextLabel.TextSize = 21;
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel.Text = "";

            for i2, v in v373 do
                TextLabel[i2] = v;
            end;

            TextLabel.Parent = p351;
        end;
    end;

    local v374 = {
        ZIndex = 24,
        Size = UDim2.new(1, 0, 1, 0)
    };
    local TextButton = Instance.new("TextButton");
    TextButton.BorderSizePixel = 0;
    TextButton:SetAttribute("SkipTheme", true);
    TextButton.BackgroundTransparency = 1;
    TextButton.FontFace = u232;
    TextButton.TextColor3 = u231.text;
    TextButton.TextSize = 21;
    TextButton.TextXAlignment = Enum.TextXAlignment.Left;
    TextButton.Text = "";
    TextButton.AutoButtonColor = false;
    local u375 = p353 or 624;

    for i, v in v374 do
        TextButton[i] = v;
    end;

    TextButton.Parent = p350;
    TextButton.MouseMoved:Connect(function(p376) -- Line: 2094
        -- upvalues: TextButton (copy), u375 (ref), u354 (copy), Days (copy), u236 (ref), u366 (copy), u365 (copy)
        local v377 = ((p376 - TextButton.AbsolutePosition.X) / math.max(TextButton.AbsoluteSize.X, 1) * u375 - 44) / math.max(u375 - 44, 1) * u354;
        local v378 = math.floor(v377) + 1;
        local v379 = math.clamp(v378, 1, u354);
        local v380 = Days[v379];
        local v381 = (v379 - 0.5) / u354;
        local v382 = {};

        for _, v in u236 do
            table.insert(v382, {
                color = v.color,
                label = v.label,
                value = v380[v.key] or 0
            });
        end;

        u366.show(v381, 44 - v381 * 44, os.date("%b %d", u365 - (u354 - v379) * 86400), v382, u354 * 0.58 < v379);
    end);
    TextButton.MouseLeave:Connect(u366.hide);
end;

local function dashRenderTypeBars(p383, p384, p385) -- Line: 2110
    -- upvalues: dashClear (copy), u231 (copy), u235 (copy), u232 (copy), u233 (copy)
    dashClear(p383);
    local v386 = p384.ActionTypes or {};
    local v387 = 1;

    for _, v in v386 do
        v387 = math.max(v387, v.Count);
    end;

    for i, v in v386 do
        if p385 < i then
            break;
        end;

        local v388 = {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, (i - 1) * 54),
            Size = UDim2.new(1, 0, 0, 44)
        };
        local Frame = Instance.new("Frame");
        Frame.BorderSizePixel = 0;
        Frame:SetAttribute("SkipTheme", true);
        Frame.BackgroundColor3 = u231.text;

        for i2, v2 in v388 do
            Frame[i2] = v2;
        end;

        Frame.Parent = p383;
        local v389 = {
            Text = u235[v.Action] or tostring(v.Action),
            TextColor3 = u231.mut2,
            Size = UDim2.new(0, 220, 0, 26)
        };
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BorderSizePixel = 0;
        TextLabel:SetAttribute("SkipTheme", true);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = u232;
        TextLabel.TextColor3 = u231.text;
        TextLabel.TextSize = 21;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Text = "";

        for i2, v2 in v389 do
            TextLabel[i2] = v2;
        end;

        TextLabel.Parent = Frame;
        local v390 = {
            BackgroundColor3 = u231.track,
            Position = UDim2.new(0, 0, 0, 30),
            Size = UDim2.new(1, -72, 0, 8)
        };
        local Frame2 = Instance.new("Frame");
        Frame2.BorderSizePixel = 0;
        Frame2:SetAttribute("SkipTheme", true);
        Frame2.BackgroundColor3 = u231.text;

        for i2, v2 in v390 do
            Frame2[i2] = v2;
        end;

        Frame2.Parent = Frame;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(0, 4);
        UICorner.Parent = Frame2;
        local v391 = {
            BackgroundColor3 = u231.blue,
            Size = UDim2.new(math.max(0.02, v.Count / v387), 0, 1, 0)
        };
        local Frame3 = Instance.new("Frame");
        Frame3.BorderSizePixel = 0;
        Frame3:SetAttribute("SkipTheme", true);
        Frame3.BackgroundColor3 = u231.text;

        for i2, v2 in v391 do
            Frame3[i2] = v2;
        end;

        Frame3.Parent = Frame2;
        local UICorner2 = Instance.new("UICorner");
        UICorner2.CornerRadius = UDim.new(0, 4);
        UICorner2.Parent = Frame3;
        local v392 = {};
        local v393 = tonumber(v.Count) or 0;
        local v394 = math.floor(v393);
        v392.Text = tostring(v394):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
        v392.FontFace = u233;
        v392.TextXAlignment = Enum.TextXAlignment.Right;
        v392.Position = UDim2.new(1, -64, 0, 22);
        v392.Size = UDim2.new(0, 64, 0, 26);
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.BorderSizePixel = 0;
        TextLabel2:SetAttribute("SkipTheme", true);
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.FontFace = u232;
        TextLabel2.TextColor3 = u231.text;
        TextLabel2.TextSize = 21;
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel2.Text = "";

        for i2, v2 in v392 do
            TextLabel2[i2] = v2;
        end;

        TextLabel2.Parent = Frame;
    end;

    if #v386 == 0 then
        local v395 = {
            Text = "No actions in this window.",
            TextColor3 = u231.mut,
            TextXAlignment = Enum.TextXAlignment.Center,
            Size = UDim2.new(1, 0, 0, 40)
        };
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BorderSizePixel = 0;
        TextLabel:SetAttribute("SkipTheme", true);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = u232;
        TextLabel.TextColor3 = u231.text;
        TextLabel.TextSize = 21;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Text = "";

        for i, v in v395 do
            TextLabel[i] = v;
        end;

        TextLabel.Parent = p383;
    end;
end;

local function dashRenderModTable(p396, p397, p398, p399) -- Line: 2162
    -- upvalues: dashClear (copy), u231 (copy), u232 (copy), u233 (copy), u220 (copy), resolveUsername (copy), dashTimeAgo (copy)
    dashClear(p396);
    local v400 = {
        {
            label = "Moderator",
            x = 0,
            w = 0.38,
            align = Enum.TextXAlignment.Left
        },
        {
            label = "Outfit bans",
            x = 0.4,
            w = 0.18,
            align = Enum.TextXAlignment.Right
        },
        {
            label = "Player actions",
            x = 0.6,
            w = 0.18,
            align = Enum.TextXAlignment.Right
        },
        {
            label = "Last active",
            x = 0.8,
            w = 0.2,
            align = Enum.TextXAlignment.Right
        }
    };
    local v401 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 28)
    };
    local Frame = Instance.new("Frame");
    Frame.BorderSizePixel = 0;
    Frame:SetAttribute("SkipTheme", true);
    Frame.BackgroundColor3 = u231.text;
    local v402 = p399 or 26;

    for i, v in v401 do
        Frame[i] = v;
    end;

    Frame.Parent = p396;

    for _, v in v400 do
        local v403 = {
            TextSize = 18,
            Text = v.label,
            TextColor3 = u231.mut,
            TextXAlignment = v.align,
            Position = UDim2.new(v.x, 0, 0, 0),
            Size = UDim2.new(v.w, 0, 1, 0)
        };
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BorderSizePixel = 0;
        TextLabel:SetAttribute("SkipTheme", true);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = u232;
        TextLabel.TextColor3 = u231.text;
        TextLabel.TextSize = 21;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Text = "";

        for i, v2 in v403 do
            TextLabel[i] = v2;
        end;

        TextLabel.Parent = Frame;
    end;

    local v404 = {
        BackgroundColor3 = u231.line,
        Position = UDim2.new(0, 0, 0, 30),
        Size = UDim2.new(1, 0, 0, 1)
    };
    local Frame2 = Instance.new("Frame");
    Frame2.BorderSizePixel = 0;
    Frame2:SetAttribute("SkipTheme", true);
    Frame2.BackgroundColor3 = u231.text;

    for i, v in v404 do
        Frame2[i] = v;
    end;

    Frame2.Parent = p396;
    local v405 = p397.Moderators or {};

    for i, v in v405 do
        if p398 < i then
            break;
        end;

        local v406 = {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, 34 + (i - 1) * v402),
            Size = UDim2.new(1, 0, 0, v402)
        };
        local Frame3 = Instance.new("Frame");
        Frame3.BorderSizePixel = 0;
        Frame3:SetAttribute("SkipTheme", true);
        Frame3.BackgroundColor3 = u231.text;

        for i2, v2 in v406 do
            Frame3[i2] = v2;
        end;

        Frame3.Parent = p396;
        local v407 = {
            FontFace = u233,
            TextTruncate = Enum.TextTruncate.AtEnd,
            Size = UDim2.new(v400[1].w, 0, 1, 0)
        };
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BorderSizePixel = 0;
        TextLabel:SetAttribute("SkipTheme", true);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = u232;
        TextLabel.TextColor3 = u231.text;
        TextLabel.TextSize = 21;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Text = "";

        for i2, v2 in v407 do
            TextLabel[i2] = v2;
        end;

        TextLabel.Parent = Frame3;
        local ModeratorId = v.ModeratorId;

        if ModeratorId and ModeratorId > 0 then
            local v408 = u220[ModeratorId];

            if v408 then
                TextLabel.Text = "@" .. v408;
            else
                TextLabel.Text = "@" .. tostring(ModeratorId);
                local u409 = "@";
                resolveUsername(ModeratorId, function(p410) -- Line: 1378
                    -- upvalues: TextLabel (copy), u409 (copy)
                    if p410 and TextLabel.Parent then
                        TextLabel.Text = (u409 or "") .. p410;
                    end;
                end);
            end;
        else
            TextLabel.Text = "Automated";
        end;

        local v411 = {};
        local v412 = tonumber(v.Outfit) or 0;
        local v413 = math.floor(v412);
        v411.Text = tostring(v413):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
        v411.TextXAlignment = Enum.TextXAlignment.Right;
        v411.Position = UDim2.new(v400[2].x, 0, 0, 0);
        v411.Size = UDim2.new(v400[2].w, 0, 1, 0);
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.BorderSizePixel = 0;
        TextLabel2:SetAttribute("SkipTheme", true);
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.FontFace = u232;
        TextLabel2.TextColor3 = u231.text;
        TextLabel2.TextSize = 21;
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel2.Text = "";

        for i2, v2 in v411 do
            TextLabel2[i2] = v2;
        end;

        TextLabel2.Parent = Frame3;
        local v414 = {};
        local v415 = tonumber(v.Player) or 0;
        local v416 = math.floor(v415);
        v414.Text = tostring(v416):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
        v414.TextXAlignment = Enum.TextXAlignment.Right;
        v414.Position = UDim2.new(v400[3].x, 0, 0, 0);
        v414.Size = UDim2.new(v400[3].w, 0, 1, 0);
        local TextLabel3 = Instance.new("TextLabel");
        TextLabel3.BorderSizePixel = 0;
        TextLabel3:SetAttribute("SkipTheme", true);
        TextLabel3.BackgroundTransparency = 1;
        TextLabel3.FontFace = u232;
        TextLabel3.TextColor3 = u231.text;
        TextLabel3.TextSize = 21;
        TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel3.Text = "";

        for i2, v2 in v414 do
            TextLabel3[i2] = v2;
        end;

        TextLabel3.Parent = Frame3;
        local v417 = {
            Text = dashTimeAgo(v.LastAt),
            TextColor3 = u231.mut2,
            TextXAlignment = Enum.TextXAlignment.Right,
            Position = UDim2.new(v400[4].x, 0, 0, 0),
            Size = UDim2.new(v400[4].w, 0, 1, 0)
        };
        local TextLabel4 = Instance.new("TextLabel");
        TextLabel4.BorderSizePixel = 0;
        TextLabel4:SetAttribute("SkipTheme", true);
        TextLabel4.BackgroundTransparency = 1;
        TextLabel4.FontFace = u232;
        TextLabel4.TextColor3 = u231.text;
        TextLabel4.TextSize = 21;
        TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel4.Text = "";

        for i2, v2 in v417 do
            TextLabel4[i2] = v2;
        end;

        TextLabel4.Parent = Frame3;
    end;

    if #v405 == 0 then
        local v418 = {
            Text = "No moderation actions in this window.",
            TextColor3 = u231.mut,
            TextXAlignment = Enum.TextXAlignment.Center,
            Position = UDim2.new(0, 0, 0, 38),
            Size = UDim2.new(1, 0, 0, 40)
        };
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BorderSizePixel = 0;
        TextLabel:SetAttribute("SkipTheme", true);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = u232;
        TextLabel.TextColor3 = u231.text;
        TextLabel.TextSize = 21;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Text = "";

        for i, v in v418 do
            TextLabel[i] = v;
        end;

        TextLabel.Parent = p396;
    end;
end;

local function dashRenderFeed(p419, p420, p421, p422) -- Line: 2234
    -- upvalues: dashClear (copy), u231 (copy), u235 (copy), u232 (copy), resolveUsername (copy), dashTimeAgo (copy), dashHoverCard (copy), Events (copy), mainSection (copy), dashCloseInspect (copy), dashServerCleanup (copy), dashInspectEntry (copy)
    dashClear(p419);
    local u423 = {
        Outfit = u231.red,
        Player = u231.blue
    };
    local v424 = p422 or 30;

    for i, v in p420.Recent or {} do
        if p421 < i then
            break;
        end;

        local v425 = {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, (i - 1) * v424),
            Size = UDim2.new(1, 0, 0, v424)
        };
        local Frame = Instance.new("Frame");
        Frame.BorderSizePixel = 0;
        Frame:SetAttribute("SkipTheme", true);
        Frame.BackgroundColor3 = u231.text;

        for i2, v2 in v425 do
            Frame[i2] = v2;
        end;

        Frame.Parent = p419;
        local v426 = {
            BackgroundColor3 = u423[v.Type] or u231.mut,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, 2, 0.5, 0),
            Size = UDim2.new(0, 7, 0, 7)
        };
        local Frame2 = Instance.new("Frame");
        Frame2.BorderSizePixel = 0;
        Frame2:SetAttribute("SkipTheme", true);
        Frame2.BackgroundColor3 = u231.text;

        for i2, v2 in v426 do
            Frame2[i2] = v2;
        end;

        Frame2.Parent = Frame;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(1, 0);
        UICorner.Parent = Frame2;
        local u427 = u235[v.Action] or tostring(v.Action);
        local v428;

        if v.Type == "Outfit" then
            v428 = `"{v.Name or "outfit"}"`;
        else
            v428 = "player " .. tostring(v.ReportedUserId);
        end;

        local v429 = {
            Text = u427 .. " - " .. v428,
            TextColor3 = u231.mut2,
            TextTruncate = Enum.TextTruncate.AtEnd,
            Position = UDim2.new(0, 18, 0, 0),
            Size = UDim2.new(1, -112, 1, 0)
        };
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BorderSizePixel = 0;
        TextLabel:SetAttribute("SkipTheme", true);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = u232;
        TextLabel.TextColor3 = u231.text;
        TextLabel.TextSize = 21;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Text = "";

        for i2, v2 in v429 do
            TextLabel[i2] = v2;
        end;

        TextLabel.Parent = Frame;

        if v.Type ~= "Outfit" and tonumber(v.ReportedUserId) then
            resolveUsername(v.ReportedUserId, function(p430) -- Line: 2264
                -- upvalues: TextLabel (copy), u427 (copy)
                if p430 and TextLabel.Parent then
                    TextLabel.Text = u427 .. " - @" .. p430;
                end;
            end);
        end;

        local v431 = {
            TextSize = 18,
            Text = dashTimeAgo(v.ActionedAt),
            TextColor3 = u231.mut,
            TextXAlignment = Enum.TextXAlignment.Right,
            Position = UDim2.new(1, -88, 0, 0),
            Size = UDim2.new(0, 88, 1, 0)
        };
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.BorderSizePixel = 0;
        TextLabel2:SetAttribute("SkipTheme", true);
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.FontFace = u232;
        TextLabel2.TextColor3 = u231.text;
        TextLabel2.TextSize = 21;
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel2.Text = "";

        for i2, v2 in v431 do
            TextLabel2[i2] = v2;
        end;

        TextLabel2.Parent = Frame;
        local u432 = dashHoverCard(Frame);
        Frame.MouseEnter:Connect(function() -- Line: 2279
            -- upvalues: v (copy), u432 (copy), u427 (copy), u423 (copy), u231 (ref)
            local v433 = v.Reason and (v.Reason ~= "" and v.Reason or "no reason recorded") or "no reason recorded";

            if #v433 > 46 then
                v433 = string.sub(v433, 1, 44) .. "...";
            end;

            u432.show(0, 6, u427, {
                {
                    value = "",
                    color = u423[v.Type] or u231.mut,
                    label = v433
                }
            }, true);
        end);
        Frame.MouseLeave:Connect(u432.hide);
        local v434 = {
            ZIndex = 2,
            Size = UDim2.new(1, 0, 1, 0)
        };
        local TextButton = Instance.new("TextButton");
        TextButton.BorderSizePixel = 0;
        TextButton:SetAttribute("SkipTheme", true);
        TextButton.BackgroundTransparency = 1;
        TextButton.FontFace = u232;
        TextButton.TextColor3 = u231.text;
        TextButton.TextSize = 21;
        TextButton.TextXAlignment = Enum.TextXAlignment.Left;
        TextButton.Text = "";
        TextButton.AutoButtonColor = false;

        for i2, v2 in v434 do
            TextButton[i2] = v2;
        end;

        TextButton.Parent = Frame;
        game:GetService("CollectionService"):AddTag(TextButton, "UIEffectSoundOnly");
        TextButton.Activated:Connect(function() -- Line: 2297
            -- upvalues: v (copy), Events (ref), mainSection (ref), dashCloseInspect (ref), dashServerCleanup (ref), dashInspectEntry (ref)
            if not v.HumanoidDescription then
                Events.Notify:Fire("⚠️ No stored evidence for this action.");

                return;
            end;

            local dashboard = mainSection:FindFirstChild("dashboard");

            if dashboard then
                dashCloseInspect();
                dashServerCleanup();
                dashboard.home.Visible = false;
                dashboard.detail.Visible = true;
                dashboard.detail.body.CanvasPosition = Vector2.zero;
                dashboard.detail.crumbs.Text = "<font color=\"#B8B9BF\">Dashboard  /  </font>Recent action";
            end;

            dashInspectEntry(v, function() -- Line: 2303
                -- upvalues: mainSection (ref), dashCloseInspect (ref), dashServerCleanup (ref)
                local dashboard2 = mainSection:FindFirstChild("dashboard");

                if not dashboard2 then
                    return;
                end;

                dashCloseInspect();
                dashServerCleanup();
                dashboard2.home.Visible = true;
                dashboard2.detail.Visible = false;
            end);
        end);
    end;
end;

local u435 = {
    Color3.fromRGB(60, 100, 250),
    Color3.fromRGB(179, 132, 251),
    Color3.fromRGB(57, 197, 130),
    Color3.fromRGB(244, 91, 82),
    Color3.fromRGB(240, 185, 60),
    Color3.fromRGB(65, 211, 255),
    Color3.fromRGB(255, 60, 219),
    Color3.fromRGB(213, 215, 221)
};

local function dashLineChart(u436, u437, u438, u439, u440, u441) -- Line: 2325
    -- upvalues: u231 (copy), u232 (copy), dashHoverCard (copy)
    local u442;

    if u441 then
        u442 = u441.percent;
    else
        u442 = u441;
    end;

    local v443 = 0;

    for _, v in u439 do
        for _, v2 in v.Days do
            v443 = math.max(v443, v2);
        end;
    end;

    local v444 = math.max(v443, u442 and 0.01 or 1);
    local v445 = math.log10(v444);
    local v446 = 10 ^ math.floor(v445);
    local u447 = math.ceil(v444 / v446) * v446;

    if not u442 then
        u447 = u447 < 4 and 4 or u447;

        if u447 % 2 == 1 then
            u447 = u447 + 1;
        end;
    end;

    for _, v in { 0, 0.5, 1 } do
        local v448 = u438 * (1 - v);
        local v449 = {
            BackgroundColor3 = u231.line,
            Position = UDim2.fromOffset(44, v448 - 1),
            Size = UDim2.new(1, -44, 0, 1)
        };
        local Frame = Instance.new("Frame");
        Frame.BorderSizePixel = 0;
        Frame:SetAttribute("SkipTheme", true);
        Frame.BackgroundColor3 = u231.text;

        for i, v2 in v449 do
            Frame[i] = v2;
        end;

        Frame.Parent = u436;
        local v450 = {
            TextSize = 18
        };
        local v451 = u442 and string.format("%.2g%%", u447 * v);

        if not v451 then
            local v452 = math.floor(u447 * v);
            v451 = tostring(v452);
        end;

        v450.Text = v451;
        v450.TextColor3 = u231.mut;
        v450.TextXAlignment = Enum.TextXAlignment.Right;
        v450.Position = UDim2.fromOffset(0, v448 - 10);
        v450.Size = UDim2.fromOffset(36, 20);
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BorderSizePixel = 0;
        TextLabel:SetAttribute("SkipTheme", true);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = u232;
        TextLabel.TextColor3 = u231.text;
        TextLabel.TextSize = 21;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Text = "";

        for i, v2 in v450 do
            TextLabel[i] = v2;
        end;

        TextLabel.Parent = u436;
    end;

    if u440 < 2 then
        return;
    end;

    for _, v in u439 do
        local v453 = table.create(u440);

        for i = 1, u440 do
            v453[i] = Vector2.new((44 + (i - 1) / (u440 - 1) * (u437 - 44)) / u437, 1 - (v.Days[i] or 0) / u447);
        end;

        local v454 = table.create(u440);

        for i = 1, u440 do
            local Y = v453[math.max(i - 1, 1)].Y;
            local Y2 = v453[math.min(i + 1, u440)].Y;
            local v455 = (v453[math.min(i + 1, u440)] - v453[math.max(i - 1, 1)]) / 6;

            if Y <= v453[i].Y and Y2 <= v453[i].Y or v453[i].Y <= Y and v453[i].Y <= Y2 then
                v455 = Vector2.new(v455.X, 0);
            end;

            local v456 = math.min(v453[i].Y, 1 - v453[i].Y);

            if v456 < math.abs(v455.Y) then
                v455 = Vector2.new(v455.X, v456 * math.sign(v455.Y));
            end;

            v454[i] = Path2DControlPoint.new(UDim2.fromScale(v453[i].X, v453[i].Y), UDim2.fromScale(-v455.X, -v455.Y), UDim2.fromScale(v455.X, v455.Y));
        end;

        local Path2D = Instance.new("Path2D");
        Path2D:SetAttribute("SkipTheme", true);
        Path2D.Color3 = v.Color;
        Path2D.Thickness = 2;
        Path2D:SetControlPoints(v454);
        Path2D.Parent = u436;
    end;

    local v457 = false;

    for _, v in u439 do
        if v.Label then
            v457 = true;
        end;
    end;

    if v457 then
        local u458 = dashHoverCard(u436);
        local v459 = {
            ZIndex = 24,
            Size = UDim2.new(1, 0, 1, 0)
        };
        local TextButton = Instance.new("TextButton");
        TextButton.BorderSizePixel = 0;
        TextButton:SetAttribute("SkipTheme", true);
        TextButton.BackgroundTransparency = 1;
        TextButton.FontFace = u232;
        TextButton.TextColor3 = u231.text;
        TextButton.TextSize = 21;
        TextButton.TextXAlignment = Enum.TextXAlignment.Left;
        TextButton.Text = "";
        TextButton.AutoButtonColor = false;
        local u460 = {};

        for i, v in v459 do
            TextButton[i] = v;
        end;

        TextButton.Parent = u436;
        TextButton.MouseMoved:Connect(function(p461) -- Line: 2419
            -- upvalues: TextButton (copy), u437 (copy), u440 (copy), u460 (copy), u439 (copy), u438 (copy), u447 (ref), u436 (copy), u231 (ref), u441 (copy), u442 (copy), u458 (copy)
            local v462 = math.max(TextButton.AbsoluteSize.X, 1);
            local v463 = ((p461 - TextButton.AbsolutePosition.X) / v462 * u437 - 44) / math.max(u437 - 44, 1) * (u440 - 1) + 0.5;
            local v464 = math.floor(v463) + 1;
            local v465 = math.clamp(v464, 1, u440);
            local v466 = 44 + (v465 - 1) / (u440 - 1) * (u437 - 44);

            for _, v in u460 do
                v:Destroy();
            end;

            table.clear(u460);
            local v467 = {};

            for _, v in u439 do
                local v468 = v.Days[v465] or 0;
                local v469 = {
                    ZIndex = 26,
                    BackgroundColor3 = v.Color,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromOffset(v466, u438 * (1 - v468 / u447)),
                    Size = UDim2.fromOffset(11, 11)
                };
                local Frame = Instance.new("Frame");
                Frame.BorderSizePixel = 0;
                Frame:SetAttribute("SkipTheme", true);
                Frame.BackgroundColor3 = u231.text;

                for i, v2 in v469 do
                    Frame[i] = v2;
                end;

                Frame.Parent = u436;
                local UICorner = Instance.new("UICorner");
                UICorner.CornerRadius = UDim.new(1, 0);
                UICorner.Parent = Frame;
                local UIStroke = Instance.new("UIStroke");
                UIStroke.Color = Color3.fromRGB(255, 255, 255);
                UIStroke.Thickness = 2;
                UIStroke.Parent = Frame;
                table.insert(u460, Frame);
                local v470;

                if u441 and u441.format then
                    v470 = u441.format(v468);
                elseif u442 then
                    v470 = string.format("%.2f%%", v468);
                else
                    local v471 = tonumber(v468) or 0;
                    local v472 = math.floor(v471);
                    v470 = tostring(v472):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
                end;

                table.insert(v467, {
                    color = v.Color,
                    label = v.Label or "",
                    value = v470
                });
            end;

            local v473 = u441 and u441.now or os.time();
            u458.show(0, v466, os.date("%b %d", v473 - (u440 - v465) * 86400), v467, u437 * 0.58 < v466);
        end);
        TextButton.MouseLeave:Connect(function() -- Line: 2414, Name: clearHover
            -- upvalues: u458 (copy), u460 (copy)
            u458.hide();

            for _, v in u460 do
                v:Destroy();
            end;

            table.clear(u460);
        end);
    end;
end;

local function dashLineAxis(p474, p475, p476) -- Line: 2461
    -- upvalues: u231 (copy), u232 (copy)
    local v477 = #(p476.Days or {});

    if v477 < 2 then
        return;
    end;

    local v478 = p476.GeneratedAt or os.time();

    for i = 1, v477 do
        if (i - 1) % 7 == 0 or i == v477 then
            local v479 = {
                TextSize = 18,
                Text = os.date("%b %d", v478 - (v477 - i) * 86400),
                TextColor3 = u231.mut,
                TextXAlignment = Enum.TextXAlignment.Center,
                AnchorPoint = Vector2.new(0.5, 0),
                Position = UDim2.fromOffset(44 + (i - 1) / (v477 - 1) * (p475 - 44), 0),
                Size = UDim2.new(0, 80, 1, 0)
            };
            local TextLabel = Instance.new("TextLabel");
            TextLabel.BorderSizePixel = 0;
            TextLabel:SetAttribute("SkipTheme", true);
            TextLabel.BackgroundTransparency = 1;
            TextLabel.FontFace = u232;
            TextLabel.TextColor3 = u231.text;
            TextLabel.TextSize = 21;
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel.Text = "";

            for i2, v in v479 do
                TextLabel[i2] = v;
            end;

            TextLabel.Parent = p474;
        end;
    end;
end;

local function dashHourBars(p480, p481, p482, u483, u484, u485, p486, u487) -- Line: 2482
    -- upvalues: dashHoverCard (copy), u232 (copy), u231 (copy)
    local v488 = 1;

    for _, v in u483 do
        v488 = math.max(v488, v);
    end;

    local u489 = p481 / 24;
    local u490 = dashHoverCard(p480);

    for i = 0, 23 do
        local v491 = u483[i + 1] or 0;
        local v492 = {
            Position = UDim2.fromOffset(math.floor(i * u489), 0),
            Size = UDim2.fromOffset(math.ceil(u489), p482)
        };
        local TextButton = Instance.new("TextButton");
        TextButton.BorderSizePixel = 0;
        TextButton:SetAttribute("SkipTheme", true);
        TextButton.BackgroundTransparency = 1;
        TextButton.FontFace = u232;
        TextButton.TextColor3 = u231.text;
        TextButton.TextSize = 21;
        TextButton.TextXAlignment = Enum.TextXAlignment.Left;
        TextButton.Text = "";
        TextButton.AutoButtonColor = false;

        for i2, v in v492 do
            TextButton[i2] = v;
        end;

        TextButton.Parent = p480;
        local v493 = {
            BackgroundColor3 = v491 > 0 and u484 and u484 or u231.track,
            AnchorPoint = Vector2.new(0.5, 1),
            Position = UDim2.new(0.5, 0, 1, 0)
        };
        local fromOffset = UDim2.fromOffset;
        local v494 = math.floor(u489) - 5;
        local v495 = math.max(v494, 3);
        local v496;

        if v491 > 0 then
            local v497 = math.floor(p482 * v491 / v488);
            v496 = math.max(v497, 3) or 2;
        else
            v496 = 2;
        end;

        v493.Size = fromOffset(v495, v496);
        local Frame = Instance.new("Frame");
        Frame.BorderSizePixel = 0;
        Frame:SetAttribute("SkipTheme", true);
        Frame.BackgroundColor3 = u231.text;

        for i2, v in v493 do
            Frame[i2] = v;
        end;

        Frame.Parent = TextButton;
    end;

    local v498 = {
        ZIndex = 24,
        Size = UDim2.new(1, 0, 1, 0)
    };
    local TextButton = Instance.new("TextButton");
    TextButton.BorderSizePixel = 0;
    TextButton:SetAttribute("SkipTheme", true);
    TextButton.BackgroundTransparency = 1;
    TextButton.FontFace = u232;
    TextButton.TextColor3 = u231.text;
    TextButton.TextSize = 21;
    TextButton.TextXAlignment = Enum.TextXAlignment.Left;
    TextButton.Text = "";
    TextButton.AutoButtonColor = false;

    for i, v in v498 do
        TextButton[i] = v;
    end;

    TextButton.Parent = p480;
    TextButton.MouseMoved:Connect(function(p499) -- Line: 2506
        -- upvalues: TextButton (copy), u483 (copy), u490 (copy), u489 (copy), u485 (copy), u484 (copy), u487 (copy)
        local v500 = (p499 - TextButton.AbsolutePosition.X) / math.max(TextButton.AbsoluteSize.X, 1) * 24;
        local v501 = math.floor(v500);
        local v502 = math.clamp(v501, 0, 23);
        local v503 = u483[v502 + 1] or 0;
        local show = u490.show;
        local v504 = math.floor(v502 * u489) + u489 / 2;
        local v505 = string.format("%02d:00 - %02d:00 (%s)", v502, (v502 + 1) % 24, u485 or "UTC");
        local v506 = {};
        local v507 = {
            color = u484,
            label = u487 or "actions"
        };
        local v508 = tonumber(v503) or 0;
        local v509 = math.floor(v508);
        v507.value = tostring(v509):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
        v506[1] = v507;
        show(0, v504, v505, v506, v502 > 13);
    end);
    TextButton.MouseLeave:Connect(u490.hide);
end;

local function dashDeltaPill(p510, p511, p512, p513, p514, p515) -- Line: 2521
    -- upvalues: u231 (copy), u232 (copy)
    if not p514 or p514 <= 0 then
        return;
    end;

    local v516 = (p513 - p514) / p514 * 100;

    if math.abs(v516) >= 0.05 then
        local v517 = v516 > 0;
        local v518;

        if p515 then
            v518 = not v517 or not p515 and v517;
        else
            v518 = not p515 and v517;
        end;

        local v519 = (v517 and "▲ " or "▼ ") .. string.format("%.1f%%", (math.abs(v516)));
        local v520 = {
            Name = "pill",
            TextSize = 16,
            BackgroundTransparency = 0.84,
            Text = v519,
            TextColor3 = v518 and u231.green or Color3.fromRGB(247, 247, 248),
            TextXAlignment = Enum.TextXAlignment.Center,
            BackgroundColor3 = v518 and u231.green or Color3.fromRGB(208, 217, 251),
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.fromOffset(p511, p512),
            Size = UDim2.fromOffset(18 + (utf8.len(v519) or #v519) * 9, 26)
        };
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BorderSizePixel = 0;
        TextLabel:SetAttribute("SkipTheme", true);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = u232;
        TextLabel.TextColor3 = u231.text;
        TextLabel.TextSize = 21;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Text = "";

        for i, v in v520 do
            TextLabel[i] = v;
        end;

        TextLabel.Parent = p510;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(0, 5);
        UICorner.Parent = TextLabel;
        local u521 = 10;
        task.spawn(function() -- Line: 1445
            -- upvalues: TextLabel (copy), u521 (copy)
            local u522 = nil;
            pcall(function() -- Line: 1447
                -- upvalues: TextLabel (ref), u522 (ref)
                local GetTextBoundsParams = Instance.new("GetTextBoundsParams");
                GetTextBoundsParams.Text = TextLabel.Text;
                GetTextBoundsParams.Font = TextLabel.FontFace;
                GetTextBoundsParams.Size = TextLabel.TextSize;
                GetTextBoundsParams.Width = 1000;
                u522 = game:GetService("TextService"):GetTextBoundsAsync(GetTextBoundsParams).X;
            end);

            if u522 and TextLabel.Parent then
                TextLabel.Size = UDim2.fromOffset(math.ceil(u522) + (u521 or 10) * 2, TextLabel.Size.Y.Offset);
            end;
        end);

        return TextLabel;
    end;
end;

local u523 = {
    {
        key = "Reset",
        label = "Resets",
        color = Color3.fromRGB(244, 91, 82)
    },
    {
        key = "Hide",
        label = "Silent hides",
        color = Color3.fromRGB(240, 185, 60)
    },
    {
        key = "PublishReject",
        label = "Publish rejections",
        color = Color3.fromRGB(179, 132, 251)
    },
    {
        key = "NearMiss",
        label = "Near-misses",
        color = Color3.fromRGB(184, 185, 191)
    }
};
local u524 = nil;

local function dashRenderTrends(p525) -- Line: 2556
    -- upvalues: mainSection (copy), dashClear (copy), u231 (copy), u232 (copy), u435 (copy), u220 (copy), resolveUsername (copy), dashLineChart (copy), dashLineAxis (copy), u233 (copy), u219 (copy), u524 (ref)
    local dashboard = mainSection:FindFirstChild("dashboard");

    if not dashboard then
        return;
    end;

    local trendsCard = dashboard.home.trendsCard;
    dashClear(trendsCard.plot);
    dashClear(trendsCard.axis);
    dashClear(trendsCard.legend);
    local v526 = p525.Moderators or {};
    local v527 = math.min(#v526, 5);

    if v527 ~= 0 then
        local v528 = {};

        for i = 1, v527 do
            local ModeratorId = v526[i].ModeratorId;
            local u529 = {
                Days = v526[i].Days or {},
                Color = u435[(i - 1) % #u435 + 1],
                Label = ModeratorId and ModeratorId > 0 and ("@" .. tostring(u220[ModeratorId] or ModeratorId) or "Automated") or "Automated"
            };
            table.insert(v528, u529);

            if ModeratorId and (ModeratorId > 0 and not u220[ModeratorId]) then
                resolveUsername(ModeratorId, function(p530) -- Line: 2586
                    -- upvalues: u529 (copy)
                    if p530 then
                        u529.Label = "@" .. p530;
                    end;
                end);
            end;
        end;

        dashLineChart(trendsCard.plot, 1048, 224, v528, #(p525.Days or {}));
        dashLineAxis(trendsCard.axis, 1048, p525);

        for i = 1, v527 do
            local u531 = v526[i];
            local v532 = {
                BackgroundTransparency = 1,
                Position = UDim2.fromOffset((i - 1) * 205, 0),
                Size = UDim2.fromOffset(200, 26)
            };
            local legend = trendsCard.legend;
            local Frame = Instance.new("Frame");
            Frame.BorderSizePixel = 0;
            Frame:SetAttribute("SkipTheme", true);
            Frame.BackgroundColor3 = u231.text;

            for i2, v in v532 do
                Frame[i2] = v;
            end;

            Frame.Parent = legend;
            local v533 = {
                BackgroundColor3 = u435[(i - 1) % #u435 + 1],
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.fromOffset(0, 13),
                Size = UDim2.fromOffset(10, 10)
            };
            local Frame2 = Instance.new("Frame");
            Frame2.BorderSizePixel = 0;
            Frame2:SetAttribute("SkipTheme", true);
            Frame2.BackgroundColor3 = u231.text;

            for i2, v in v533 do
                Frame2[i2] = v;
            end;

            Frame2.Parent = Frame;
            local UICorner = Instance.new("UICorner");
            UICorner.CornerRadius = UDim.new(1, 0);
            UICorner.Parent = Frame2;
            local v534 = {
                TextSize = 18,
                TextColor3 = u231.mut2,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Position = UDim2.fromOffset(18, 0),
                Size = UDim2.fromOffset(122, 26)
            };
            local TextLabel = Instance.new("TextLabel");
            TextLabel.BorderSizePixel = 0;
            TextLabel:SetAttribute("SkipTheme", true);
            TextLabel.BackgroundTransparency = 1;
            TextLabel.FontFace = u232;
            TextLabel.TextColor3 = u231.text;
            TextLabel.TextSize = 21;
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel.Text = "";

            for i2, v in v534 do
                TextLabel[i2] = v;
            end;

            TextLabel.Parent = Frame;
            local ModeratorId = u531.ModeratorId;

            if ModeratorId and ModeratorId > 0 then
                local v535 = u220[ModeratorId];

                if v535 then
                    TextLabel.Text = "@" .. v535;
                else
                    TextLabel.Text = "@" .. tostring(ModeratorId);
                    local u536 = "@";
                    resolveUsername(ModeratorId, function(p537) -- Line: 1378
                        -- upvalues: TextLabel (copy), u536 (copy)
                        if p537 and TextLabel.Parent then
                            TextLabel.Text = (u536 or "") .. p537;
                        end;
                    end);
                end;
            else
                TextLabel.Text = "Automated";
            end;

            local v538 = {
                TextSize = 18
            };
            local v539 = tonumber(u531.Total or (u531.Outfit or 0) + (u531.Player or 0)) or 0;
            local v540 = math.floor(v539);
            v538.Text = tostring(v540):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
            v538.FontFace = u233;
            v538.Position = UDim2.fromOffset(146, 0);
            v538.Size = UDim2.fromOffset(54, 26);
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.BorderSizePixel = 0;
            TextLabel2:SetAttribute("SkipTheme", true);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.FontFace = u232;
            TextLabel2.TextColor3 = u231.text;
            TextLabel2.TextSize = 21;
            TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel2.Text = "";

            for i2, v in v538 do
                TextLabel2[i2] = v;
            end;

            TextLabel2.Parent = Frame;
            local v541 = {
                Size = UDim2.new(1, 0, 1, 0)
            };
            local TextButton = Instance.new("TextButton");
            TextButton.BorderSizePixel = 0;
            TextButton:SetAttribute("SkipTheme", true);
            TextButton.BackgroundTransparency = 1;
            TextButton.FontFace = u232;
            TextButton.TextColor3 = u231.text;
            TextButton.TextSize = 21;
            TextButton.TextXAlignment = Enum.TextXAlignment.Left;
            TextButton.Text = "";
            TextButton.AutoButtonColor = false;

            for i2, v in v541 do
                TextButton[i2] = v;
            end;

            TextButton.Parent = Frame;
            TextButton.Activated:Connect(function() -- Line: 2625
                -- upvalues: u219 (ref), u524 (ref), u531 (copy), i (copy)
                if u219.data then
                    u524("staff", u219.data, u531, i);
                end;
            end);
        end;

        return;
    end;

    local v542 = {
        Text = "No moderator actions in this window.",
        TextColor3 = u231.mut,
        TextXAlignment = Enum.TextXAlignment.Center,
        Position = UDim2.new(0, 0, 0.5, -20),
        Size = UDim2.new(1, 0, 0, 40)
    };
    local plot = trendsCard.plot;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BorderSizePixel = 0;
    TextLabel:SetAttribute("SkipTheme", true);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = u232;
    TextLabel.TextColor3 = u231.text;
    TextLabel.TextSize = 21;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Text = "";

    for i, v in v542 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = plot;
end;

local function dashRenderDetection(p543) -- Line: 2631
    -- upvalues: mainSection (copy), dashClear (copy), u231 (copy), u232 (copy), u234 (copy), dashDeltaPill (copy), u523 (copy), dashLineChart (copy), dashLineAxis (copy)
    local dashboard = mainSection:FindFirstChild("dashboard");

    if not dashboard then
        return;
    end;

    local detectionCard = dashboard.home.detectionCard;
    dashClear(detectionCard.stats);
    dashClear(detectionCard.plot);
    dashClear(detectionCard.axis);
    dashClear(detectionCard.legend);
    local Detection = p543.Detection;

    if Detection then
        local v544 = Detection.totals or {};
        local v545 = Detection.prevTotals or {};

        for i, v in {
            { "Players affected", Detection.uniqueAffected or 0, Detection.prevUniqueAffected },
            { "Resets", v544.Reset or 0, v545.Reset },
            { "Silent hides", v544.Hide or 0, v545.Hide },
            { "Publish rejections", v544.PublishReject or 0, v545.PublishReject },
            { "Near-misses", v544.NearMiss or 0, v545.NearMiss }
        } do
            local u546 = (i - 1) * 210;
            local v547 = {
                TextSize = 18,
                Text = v[1],
                TextColor3 = u231.mut,
                Position = UDim2.fromOffset(u546, 0),
                Size = UDim2.fromOffset(200, 20)
            };
            local stats = detectionCard.stats;
            local TextLabel = Instance.new("TextLabel");
            TextLabel.BorderSizePixel = 0;
            TextLabel:SetAttribute("SkipTheme", true);
            TextLabel.BackgroundTransparency = 1;
            TextLabel.FontFace = u232;
            TextLabel.TextColor3 = u231.text;
            TextLabel.TextSize = 21;
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel.Text = "";

            for i2, v2 in v547 do
                TextLabel[i2] = v2;
            end;

            TextLabel.Parent = stats;
            local v548 = tonumber(v[2]) or 0;
            local v549 = math.floor(v548);
            local u550 = tostring(v549):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
            local v551 = {
                TextSize = 30,
                Text = u550,
                FontFace = u234,
                Position = UDim2.fromOffset(u546, 28),
                Size = UDim2.fromOffset(140, 34)
            };
            local stats2 = detectionCard.stats;
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.BorderSizePixel = 0;
            TextLabel2:SetAttribute("SkipTheme", true);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.FontFace = u232;
            TextLabel2.TextColor3 = u231.text;
            TextLabel2.TextSize = 21;
            TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel2.Text = "";

            for i2, v2 in v551 do
                TextLabel2[i2] = v2;
            end;

            TextLabel2.Parent = stats2;
            local u552 = dashDeltaPill(detectionCard.stats, u546 + #u550 * 18 + 10, 45, v[2], v[3], true);

            if u552 then
                task.spawn(function() -- Line: 2679
                    -- upvalues: u550 (copy), TextLabel2 (copy), u552 (copy), u546 (copy)
                    local u553 = nil;
                    pcall(function() -- Line: 2681
                        -- upvalues: u550 (ref), TextLabel2 (ref), u553 (ref)
                        local GetTextBoundsParams = Instance.new("GetTextBoundsParams");
                        GetTextBoundsParams.Text = u550;
                        GetTextBoundsParams.Font = TextLabel2.FontFace;
                        GetTextBoundsParams.Size = TextLabel2.TextSize;
                        GetTextBoundsParams.Width = 1000;
                        u553 = game:GetService("TextService"):GetTextBoundsAsync(GetTextBoundsParams).X;
                    end);

                    if u553 and u552.Parent then
                        u552.Position = UDim2.fromOffset(u546 + math.ceil(u553) + 12, 45);
                    end;
                end);
            end;
        end;

        local v554 = {};

        for _, v in u523 do
            table.insert(v554, {
                Days = Detection.series and (Detection.series[v.key] or {}) or {},
                Color = v.color,
                Label = v.label
            });
        end;

        dashLineChart(detectionCard.plot, 1048, 166, v554, Detection.days or 28);
        dashLineAxis(detectionCard.axis, 1048, p543);
        local v555 = 0;

        for _, v in u523 do
            local label = v.label;
            local v556 = tonumber(Detection.totals and (Detection.totals[v.key] or 0) or 0) or 0;
            local v557 = math.floor(v556);
            local v558 = label .. "  " .. tostring(v557):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
            local v559 = {
                BackgroundColor3 = v.color,
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.fromOffset(v555, 10),
                Size = UDim2.fromOffset(10, 10)
            };
            local legend = detectionCard.legend;
            local Frame = Instance.new("Frame");
            Frame.BorderSizePixel = 0;
            Frame:SetAttribute("SkipTheme", true);
            Frame.BackgroundColor3 = u231.text;

            for i, v2 in v559 do
                Frame[i] = v2;
            end;

            Frame.Parent = legend;
            local UICorner = Instance.new("UICorner");
            UICorner.CornerRadius = UDim.new(1, 0);
            UICorner.Parent = Frame;
            local v560 = {
                TextSize = 16,
                Text = v558,
                TextColor3 = u231.mut2,
                Position = UDim2.fromOffset(v555 + 17, 0),
                Size = UDim2.fromOffset(240, 20)
            };
            local legend2 = detectionCard.legend;
            local TextLabel = Instance.new("TextLabel");
            TextLabel.BorderSizePixel = 0;
            TextLabel:SetAttribute("SkipTheme", true);
            TextLabel.BackgroundTransparency = 1;
            TextLabel.FontFace = u232;
            TextLabel.TextColor3 = u231.text;
            TextLabel.TextSize = 21;
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel.Text = "";

            for i, v2 in v560 do
                TextLabel[i] = v2;
            end;

            TextLabel.Parent = legend2;
            v555 = v555 + (#v558 * 8 + 17 + 28);
        end;

        return;
    end;

    local v561 = {
        Text = "No detection data available.",
        TextColor3 = u231.mut,
        TextXAlignment = Enum.TextXAlignment.Center,
        Position = UDim2.new(0, 0, 0.5, -20),
        Size = UDim2.new(1, 0, 0, 40)
    };
    local plot = detectionCard.plot;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BorderSizePixel = 0;
    TextLabel:SetAttribute("SkipTheme", true);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = u232;
    TextLabel.TextColor3 = u231.text;
    TextLabel.TextSize = 21;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Text = "";

    for i, v in v561 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = plot;
end;

local function dashRenderHome(p562) -- Line: 2725
    -- upvalues: mainSection (copy), dashHideSkeletons (copy), u236 (copy), dashDeltaPill (copy), dashRenderColumns (copy), dashClear (copy), u231 (copy), u232 (copy), dashRenderTypeBars (copy), dashRenderModTable (copy), dashRenderFeed (copy), dashRenderTrends (copy), dashRenderDetection (copy), Players (copy)
    local dashboard = mainSection:FindFirstChild("dashboard");

    if not dashboard then
        return;
    end;

    local home = dashboard.home;
    dashHideSkeletons(home);
    local kpis = home.kpis;
    local value = kpis.openOutfit.value;
    local v563;

    if p562.OpenOutfitReports then
        local v564 = tonumber(p562.OpenOutfitReports) or 0;
        local v565 = math.floor(v564);
        v563 = tostring(v565):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") or "--";
    else
        v563 = "--";
    end;

    value.Text = v563;
    local value2 = kpis.openPlayer.value;
    local v566;

    if p562.OpenPlayerReports then
        local v567 = tonumber(p562.OpenPlayerReports) or 0;
        local v568 = math.floor(v567);
        v566 = tostring(v568):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") or "--";
    else
        v566 = "--";
    end;

    value2.Text = v566;
    local v569 = 0;

    for _, v in p562.Days or {} do
        local v570 = 0;

        for _, v2 in u236 do
            v570 = v570 + (v[v2.key] or 0);
        end;

        v569 = v569 + v570;
    end;

    local v571 = tonumber(v569) or 0;
    local v572 = math.floor(v571);
    local v573 = tostring(v572):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");

    if p562.WindowComplete == false then
        v573 = v573 .. "+";
    end;

    local v574 = p562.WindowDays or 28;
    kpis.actions28.cap.Text = v574 == 1 and "Actions (today)" or "Actions (" .. v574 .. " days)";
    kpis.actions28.value.Text = v573;
    local value3 = kpis.allTime.value;
    local v575;

    if p562.Totals then
        local v576 = tonumber((p562.Totals.Outfits or 0) + (p562.Totals.Players or 0)) or 0;
        local v577 = math.floor(v576);
        v575 = tostring(v577):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") or "--";
    else
        v575 = "--";
    end;

    value3.Text = v575;
    local value4 = kpis.oldest.value;
    local OldestOpenReport = p562.OldestOpenReport;
    local v578;

    if OldestOpenReport then
        local v579 = os.time() - OldestOpenReport;
        local v580 = math.max(0, v579);

        if v580 < 3600 then
            v578 = math.floor(v580 / 60) .. " min";
        elseif v580 < 86400 then
            v578 = math.floor(v580 / 3600) .. " h";
        else
            v578 = math.floor(v580 / 86400) .. " d";
        end;
    else
        v578 = "--";
    end;

    value4.Text = v578;
    local u581 = v573 .. (v569 == 1 and " action" or " actions");
    home.actionsCard.total.Text = u581;
    local pill = home.actionsCard:FindFirstChild("pill");

    if pill then
        pill:Destroy();
    end;

    local u582 = dashDeltaPill(home.actionsCard, #u581 * 18 + 12, 100, v569, p562.PrevWindowTotal);

    if u582 then
        task.spawn(function() -- Line: 2751
            -- upvalues: u581 (copy), home (copy), u582 (copy)
            local u583 = nil;
            pcall(function() -- Line: 2753
                -- upvalues: u581 (ref), home (ref), u583 (ref)
                local GetTextBoundsParams = Instance.new("GetTextBoundsParams");
                GetTextBoundsParams.Text = u581;
                GetTextBoundsParams.Font = home.actionsCard.total.FontFace;
                GetTextBoundsParams.Size = home.actionsCard.total.TextSize;
                GetTextBoundsParams.Width = 1000;
                u583 = game:GetService("TextService"):GetTextBoundsAsync(GetTextBoundsParams).X;
            end);

            if u583 and u582.Parent then
                u582.Position = UDim2.fromOffset(math.ceil(u583) + 14, 100);
            end;
        end);
    end;

    dashRenderColumns(home.actionsCard.plot, home.actionsCard.axis, p562, 624);
    dashClear(home.actionsCard.legend);

    for _, v in u236 do
        local v584 = {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, #v.short * 8 + 24, 1, 0)
        };
        local legend = home.actionsCard.legend;
        local Frame = Instance.new("Frame");
        Frame.BorderSizePixel = 0;
        Frame:SetAttribute("SkipTheme", true);
        Frame.BackgroundColor3 = u231.text;

        for i, v2 in v584 do
            Frame[i] = v2;
        end;

        Frame.Parent = legend;
        local v585 = {
            BackgroundColor3 = v.color,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, 0, 0.5, 0),
            Size = UDim2.fromOffset(10, 10)
        };
        local Frame2 = Instance.new("Frame");
        Frame2.BorderSizePixel = 0;
        Frame2:SetAttribute("SkipTheme", true);
        Frame2.BackgroundColor3 = u231.text;

        for i, v2 in v585 do
            Frame2[i] = v2;
        end;

        Frame2.Parent = Frame;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(1, 0);
        UICorner.Parent = Frame2;
        local v586 = {
            TextSize = 16,
            Text = v.short,
            TextColor3 = u231.mut2,
            Position = UDim2.fromOffset(16, 0),
            Size = UDim2.new(1, -16, 1, 0)
        };
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BorderSizePixel = 0;
        TextLabel:SetAttribute("SkipTheme", true);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = u232;
        TextLabel.TextColor3 = u231.text;
        TextLabel.TextSize = 21;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Text = "";

        for i, v2 in v586 do
            TextLabel[i] = v2;
        end;

        TextLabel.Parent = Frame;
    end;

    dashRenderTypeBars(home.typesCard.bars, p562, 6);
    dashRenderModTable(home.modsCard.table, p562, 6, 30);
    dashRenderFeed(home.feedCard.feed, p562, 7, 30);
    dashRenderTrends(p562);
    dashRenderDetection(p562);
    local v587 = 0;

    for _, v in Players:GetPlayers() do
        if v:GetAttribute("AvatarAutoHidden") == true then
            v587 = v587 + 1;
        end;
    end;

    home.serverCard.stats.Text = #Players:GetPlayers() .. " players online, " .. v587 .. " auto-hidden in this server";
end;

u524 = function(p588, p589, u590, p591) -- Line: 2806, Name: dashRenderDetail
    -- upvalues: mainSection (copy), dashClear (copy), dashCloseInspect (copy), dashServerCleanup (copy), u231 (copy), u232 (copy), dashRenderColumns (copy), u236 (copy), dashRenderTypeBars (copy), dashRenderModTable (copy), u219 (copy), u435 (copy), u233 (copy), u220 (copy), resolveUsername (copy), dashTimeAgo (copy), u524 (ref), u234 (copy), dashLineChart (copy), dashLineAxis (copy), dashHourBars (copy), u235 (copy), dashInspectEntry (copy), Remotes (copy), u523 (copy), dashHoverCard (copy), OutsideClickDetector (copy), u5 (copy), reviewPlayer (copy), fetchPlayerReview (copy), dashSkeletonBlock (copy), Events (copy), LocalPlayer (copy), dashHideSkeletons (copy), HumanoidDescriptionController (copy), AvatarPreviewController (copy), u1 (copy)
    local dashboard = mainSection:FindFirstChild("dashboard");

    if not dashboard then
        return;
    end;

    local body = dashboard.detail.body;
    dashClear(body);

    if p588 == "actions" then
        local dashboard2 = mainSection:FindFirstChild("dashboard");

        if dashboard2 then
            dashCloseInspect();
            dashServerCleanup();
            dashboard2.home.Visible = false;
            dashboard2.detail.Visible = true;
            dashboard2.detail.body.CanvasPosition = Vector2.zero;
            dashboard2.detail.crumbs.Text = "<font color=\"#B8B9BF\">Dashboard  /  </font>Moderation actions";
        end;

        local v592 = {
            Text = "Daily moderation actions, last " .. (p589.WindowDays or 28) .. " days",
            TextColor3 = u231.mut,
            Size = UDim2.new(1, 0, 0, 24)
        };
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BorderSizePixel = 0;
        TextLabel:SetAttribute("SkipTheme", true);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = u232;
        TextLabel.TextColor3 = u231.text;
        TextLabel.TextSize = 21;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Text = "";

        for i, v in v592 do
            TextLabel[i] = v;
        end;

        TextLabel.Parent = body;
        local v593 = {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, 48),
            Size = UDim2.new(1, 0, 0, 540)
        };
        local Frame = Instance.new("Frame");
        Frame.BorderSizePixel = 0;
        Frame:SetAttribute("SkipTheme", true);
        Frame.BackgroundColor3 = u231.text;

        for i, v in v593 do
            Frame[i] = v;
        end;

        Frame.Parent = body;
        local v594 = {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, 596),
            Size = UDim2.new(1, 0, 0, 24)
        };
        local Frame2 = Instance.new("Frame");
        Frame2.BorderSizePixel = 0;
        Frame2:SetAttribute("SkipTheme", true);
        Frame2.BackgroundColor3 = u231.text;

        for i, v in v594 do
            Frame2[i] = v;
        end;

        Frame2.Parent = body;
        dashRenderColumns(Frame, Frame2, p589, 1052);
        local v595 = {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, 636),
            Size = UDim2.new(1, 0, 0, 24)
        };
        local Frame3 = Instance.new("Frame");
        Frame3.BorderSizePixel = 0;
        Frame3:SetAttribute("SkipTheme", true);
        Frame3.BackgroundColor3 = u231.text;

        for i, v in v595 do
            Frame3[i] = v;
        end;

        Frame3.Parent = body;
        local UIListLayout = Instance.new("UIListLayout");
        UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
        UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
        UIListLayout.Padding = UDim.new(0, 18);
        UIListLayout.Parent = Frame3;

        for _, v in u236 do
            local v596 = {
                BackgroundTransparency = 1,
                Size = UDim2.new(0, #v.label * 9 + 26, 1, 0)
            };
            local Frame4 = Instance.new("Frame");
            Frame4.BorderSizePixel = 0;
            Frame4:SetAttribute("SkipTheme", true);
            Frame4.BackgroundColor3 = u231.text;

            for i, v2 in v596 do
                Frame4[i] = v2;
            end;

            Frame4.Parent = Frame3;
            local v597 = {
                BackgroundColor3 = v.color,
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new(0, 0, 0.5, 0),
                Size = UDim2.new(0, 8, 0, 8)
            };
            local Frame5 = Instance.new("Frame");
            Frame5.BorderSizePixel = 0;
            Frame5:SetAttribute("SkipTheme", true);
            Frame5.BackgroundColor3 = u231.text;

            for i, v2 in v597 do
                Frame5[i] = v2;
            end;

            Frame5.Parent = Frame4;
            local UICorner = Instance.new("UICorner");
            UICorner.CornerRadius = UDim.new(1, 0);
            UICorner.Parent = Frame5;
            local v598 = {
                TextSize = 18,
                Text = v.label,
                TextColor3 = u231.mut2,
                Position = UDim2.new(0, 15, 0, 0),
                Size = UDim2.new(1, -15, 1, 0)
            };
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.BorderSizePixel = 0;
            TextLabel2:SetAttribute("SkipTheme", true);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.FontFace = u232;
            TextLabel2.TextColor3 = u231.text;
            TextLabel2.TextSize = 21;
            TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel2.Text = "";

            for i, v2 in v598 do
                TextLabel2[i] = v2;
            end;

            TextLabel2.Parent = Frame4;
        end;

        body.CanvasSize = UDim2.new(0, 0, 0, 684);

        return;
    end;

    if p588 == "types" then
        local dashboard2 = mainSection:FindFirstChild("dashboard");

        if dashboard2 then
            dashCloseInspect();
            dashServerCleanup();
            dashboard2.home.Visible = false;
            dashboard2.detail.Visible = true;
            dashboard2.detail.body.CanvasPosition = Vector2.zero;
            dashboard2.detail.crumbs.Text = "<font color=\"#B8B9BF\">Dashboard  /  </font>Actions by type";
        end;

        local v599 = {
            Text = "Action types across the last " .. (p589.WindowDays or 28) .. " days",
            TextColor3 = u231.mut,
            Size = UDim2.new(1, 0, 0, 24)
        };
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BorderSizePixel = 0;
        TextLabel:SetAttribute("SkipTheme", true);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = u232;
        TextLabel.TextColor3 = u231.text;
        TextLabel.TextSize = 21;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Text = "";

        for i, v in v599 do
            TextLabel[i] = v;
        end;

        TextLabel.Parent = body;
        local v600 = math.min(#(p589.ActionTypes or {}), 13);
        local v601 = math.max(v600, 1) * 54 - 10;
        local v602 = {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, 48),
            Size = UDim2.new(1, 0, 0, v601)
        };
        local Frame = Instance.new("Frame");
        Frame.BorderSizePixel = 0;
        Frame:SetAttribute("SkipTheme", true);
        Frame.BackgroundColor3 = u231.text;

        for i, v in v602 do
            Frame[i] = v;
        end;

        Frame.Parent = body;
        dashRenderTypeBars(Frame, p589, 13);
        body.CanvasSize = UDim2.new(0, 0, 0, v601 + 48 + 10);

        return;
    end;

    if p588 == "moderators" then
        local dashboard2 = mainSection:FindFirstChild("dashboard");

        if dashboard2 then
            dashCloseInspect();
            dashServerCleanup();
            dashboard2.home.Visible = false;
            dashboard2.detail.Visible = true;
            dashboard2.detail.body.CanvasPosition = Vector2.zero;
            dashboard2.detail.crumbs.Text = "<font color=\"#B8B9BF\">Dashboard  /  </font>Moderator activity";
        end;

        local v603 = {
            Text = "Actions per moderator, last " .. (p589.WindowDays or 28) .. " days",
            TextColor3 = u231.mut,
            Size = UDim2.new(1, 0, 0, 24)
        };
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BorderSizePixel = 0;
        TextLabel:SetAttribute("SkipTheme", true);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = u232;
        TextLabel.TextColor3 = u231.text;
        TextLabel.TextSize = 21;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Text = "";

        for i, v in v603 do
            TextLabel[i] = v;
        end;

        TextLabel.Parent = body;
        local v604 = math.min(#(p589.Moderators or {}), 30);
        local v605 = math.max(v604, 1) * 34 + 34 + 6;
        local v606 = {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, 48),
            Size = UDim2.new(1, 0, 0, v605)
        };
        local Frame = Instance.new("Frame");
        Frame.BorderSizePixel = 0;
        Frame:SetAttribute("SkipTheme", true);
        Frame.BackgroundColor3 = u231.text;

        for i, v in v606 do
            Frame[i] = v;
        end;

        Frame.Parent = body;
        dashRenderModTable(Frame, p589, 30, 34);
        body.CanvasSize = UDim2.new(0, 0, 0, v605 + 48 + 10);

        return;
    end;

    if p588 == "modtrends" then
        local dashboard2 = mainSection:FindFirstChild("dashboard");

        if dashboard2 then
            dashCloseInspect();
            dashServerCleanup();
            dashboard2.home.Visible = false;
            dashboard2.detail.Visible = true;
            dashboard2.detail.body.CanvasPosition = Vector2.zero;
            dashboard2.detail.crumbs.Text = "<font color=\"#B8B9BF\">Dashboard  /  </font>Staff";
        end;

        u219.backTo = nil;
        local v607 = {
            Text = "Per-moderator activity, last " .. (p589.WindowDays or 28) .. " days. Select a moderator for full statistics.",
            TextColor3 = u231.mut,
            Size = UDim2.new(1, 0, 0, 24)
        };
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BorderSizePixel = 0;
        TextLabel:SetAttribute("SkipTheme", true);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = u232;
        TextLabel.TextColor3 = u231.text;
        TextLabel.TextSize = 21;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Text = "";

        for i, v in v607 do
            TextLabel[i] = v;
        end;

        TextLabel.Parent = body;
        local v608 = p589.Moderators or {};
        local v609 = math.min(#v608, 30);
        local v610 = {
            {
                label = "Moderator",
                x = 16,
                w = 300,
                align = Enum.TextXAlignment.Left
            },
            {
                label = "Actions",
                x = 332,
                w = 100,
                align = Enum.TextXAlignment.Right
            },
            {
                label = "Outfit / Player",
                x = 452,
                w = 150,
                align = Enum.TextXAlignment.Right
            },
            {
                label = "Active days",
                x = 622,
                w = 110,
                align = Enum.TextXAlignment.Right
            },
            {
                label = "Hours",
                x = 752,
                w = 100,
                align = Enum.TextXAlignment.Right
            },
            {
                label = "Last active",
                x = 872,
                w = 164,
                align = Enum.TextXAlignment.Right
            }
        };
        local v611 = {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, 44),
            Size = UDim2.new(1, 0, 0, 24)
        };
        local Frame = Instance.new("Frame");
        Frame.BorderSizePixel = 0;
        Frame:SetAttribute("SkipTheme", true);
        Frame.BackgroundColor3 = u231.text;

        for i, v in v611 do
            Frame[i] = v;
        end;

        Frame.Parent = body;

        for _, v in v610 do
            local v612 = {
                TextSize = 18,
                Text = v.label,
                TextColor3 = u231.mut,
                TextXAlignment = v.align,
                Position = UDim2.fromOffset(v.x, 0),
                Size = UDim2.fromOffset(v.w, 24)
            };
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.BorderSizePixel = 0;
            TextLabel2:SetAttribute("SkipTheme", true);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.FontFace = u232;
            TextLabel2.TextColor3 = u231.text;
            TextLabel2.TextSize = 21;
            TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel2.Text = "";

            for i, v2 in v612 do
                TextLabel2[i] = v2;
            end;

            TextLabel2.Parent = Frame;
        end;

        for i = 1, v609 do
            local u613 = v608[i];
            local v614 = u435[(i - 1) % #u435 + 1];
            local v615 = {
                BackgroundTransparency = 0,
                BackgroundColor3 = u231.track,
                Position = UDim2.new(0, 0, 0, (i - 1) * 62 + 76),
                Size = UDim2.new(1, 0, 0, 54)
            };
            local TextButton = Instance.new("TextButton");
            TextButton.BorderSizePixel = 0;
            TextButton:SetAttribute("SkipTheme", true);
            TextButton.BackgroundTransparency = 1;
            TextButton.FontFace = u232;
            TextButton.TextColor3 = u231.text;
            TextButton.TextSize = 21;
            TextButton.TextXAlignment = Enum.TextXAlignment.Left;
            TextButton.Text = "";
            TextButton.AutoButtonColor = false;

            for i2, v in v615 do
                TextButton[i2] = v;
            end;

            TextButton.Parent = body;
            local UICorner = Instance.new("UICorner");
            UICorner.CornerRadius = UDim.new(0, 8);
            UICorner.Parent = TextButton;
            game:GetService("CollectionService"):AddTag(TextButton, "UIEffect");
            local v616 = {
                BackgroundColor3 = v614,
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new(0, 16, 0.5, 0),
                Size = UDim2.fromOffset(12, 12)
            };
            local Frame2 = Instance.new("Frame");
            Frame2.BorderSizePixel = 0;
            Frame2:SetAttribute("SkipTheme", true);
            Frame2.BackgroundColor3 = u231.text;

            for i2, v in v616 do
                Frame2[i2] = v;
            end;

            Frame2.Parent = TextButton;
            local UICorner2 = Instance.new("UICorner");
            UICorner2.CornerRadius = UDim.new(1, 0);
            UICorner2.Parent = Frame2;
            local v617 = {
                TextSize = 22,
                FontFace = u233,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Position = UDim2.new(0, 38, 0, 0),
                Size = UDim2.new(0, 278, 1, 0)
            };
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.BorderSizePixel = 0;
            TextLabel2:SetAttribute("SkipTheme", true);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.FontFace = u232;
            TextLabel2.TextColor3 = u231.text;
            TextLabel2.TextSize = 21;
            TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel2.Text = "";

            for i2, v in v617 do
                TextLabel2[i2] = v;
            end;

            TextLabel2.Parent = TextButton;
            local ModeratorId = u613.ModeratorId;

            if ModeratorId and ModeratorId > 0 then
                local v618 = u220[ModeratorId];

                if v618 then
                    TextLabel2.Text = "@" .. v618;
                else
                    TextLabel2.Text = "@" .. tostring(ModeratorId);
                    local u619 = "@";
                    resolveUsername(ModeratorId, function(p620) -- Line: 1378
                        -- upvalues: TextLabel2 (copy), u619 (copy)
                        if p620 and TextLabel2.Parent then
                            TextLabel2.Text = (u619 or "") .. p620;
                        end;
                    end);
                end;
            else
                TextLabel2.Text = "Automated";
            end;

            local v621 = {};
            local v622 = tonumber(u613.Total or (u613.Outfit or 0) + (u613.Player or 0)) or 0;
            local v623 = math.floor(v622);
            v621.Text = tostring(v623):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
            v621.FontFace = u233;
            v621.TextXAlignment = Enum.TextXAlignment.Right;
            v621.Position = UDim2.new(0, 332, 0, 0);
            v621.Size = UDim2.new(0, 100, 1, 0);
            local TextLabel3 = Instance.new("TextLabel");
            TextLabel3.BorderSizePixel = 0;
            TextLabel3:SetAttribute("SkipTheme", true);
            TextLabel3.BackgroundTransparency = 1;
            TextLabel3.FontFace = u232;
            TextLabel3.TextColor3 = u231.text;
            TextLabel3.TextSize = 21;
            TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel3.Text = "";

            for i2, v in v621 do
                TextLabel3[i2] = v;
            end;

            TextLabel3.Parent = TextButton;
            local v624 = {};
            local v625 = tonumber(u613.Outfit or 0) or 0;
            local v626 = math.floor(v625);
            local v627 = tostring(v626):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
            local v628 = tonumber(u613.Player or 0) or 0;
            local v629 = math.floor(v628);
            v624.Text = v627 .. " / " .. tostring(v629):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
            v624.TextColor3 = u231.mut2;
            v624.TextXAlignment = Enum.TextXAlignment.Right;
            v624.Position = UDim2.new(0, 452, 0, 0);
            v624.Size = UDim2.new(0, 150, 1, 0);
            local TextLabel4 = Instance.new("TextLabel");
            TextLabel4.BorderSizePixel = 0;
            TextLabel4:SetAttribute("SkipTheme", true);
            TextLabel4.BackgroundTransparency = 1;
            TextLabel4.FontFace = u232;
            TextLabel4.TextColor3 = u231.text;
            TextLabel4.TextSize = 21;
            TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel4.Text = "";

            for i2, v in v624 do
                TextLabel4[i2] = v;
            end;

            TextLabel4.Parent = TextButton;
            local v630;

            if u613.Days then
                v630 = 0;

                for _, v in u613.Days do
                    if v > 0 then
                        v630 = v630 + 1;
                    end;
                end;
            else
                v630 = nil;
            end;

            local v631 = {
                Text = v630 and (v630 .. " / " .. (p589.WindowDays or 28) or "--") or "--",
                TextColor3 = u231.mut2,
                TextXAlignment = Enum.TextXAlignment.Right,
                Position = UDim2.new(0, 622, 0, 0),
                Size = UDim2.new(0, 110, 1, 0)
            };
            local TextLabel5 = Instance.new("TextLabel");
            TextLabel5.BorderSizePixel = 0;
            TextLabel5:SetAttribute("SkipTheme", true);
            TextLabel5.BackgroundTransparency = 1;
            TextLabel5.FontFace = u232;
            TextLabel5.TextColor3 = u231.text;
            TextLabel5.TextSize = 21;
            TextLabel5.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel5.Text = "";

            for i2, v in v631 do
                TextLabel5[i2] = v;
            end;

            TextLabel5.Parent = TextButton;
            local v632 = {
                Text = u613.Presence and u613.Presence.TotalMinutes and (string.format("%.1f h", u613.Presence.TotalMinutes / 60) or "--") or "--",
                TextColor3 = u231.mut2,
                TextXAlignment = Enum.TextXAlignment.Right,
                Position = UDim2.new(0, 752, 0, 0),
                Size = UDim2.new(0, 100, 1, 0)
            };
            local TextLabel6 = Instance.new("TextLabel");
            TextLabel6.BorderSizePixel = 0;
            TextLabel6:SetAttribute("SkipTheme", true);
            TextLabel6.BackgroundTransparency = 1;
            TextLabel6.FontFace = u232;
            TextLabel6.TextColor3 = u231.text;
            TextLabel6.TextSize = 21;
            TextLabel6.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel6.Text = "";

            for i2, v in v632 do
                TextLabel6[i2] = v;
            end;

            TextLabel6.Parent = TextButton;
            local v633 = {
                Text = dashTimeAgo(u613.LastAt),
                TextColor3 = u231.mut2,
                TextXAlignment = Enum.TextXAlignment.Right,
                Position = UDim2.new(0, 872, 0, 0),
                Size = UDim2.new(0, 164, 1, 0)
            };
            local TextLabel7 = Instance.new("TextLabel");
            TextLabel7.BorderSizePixel = 0;
            TextLabel7:SetAttribute("SkipTheme", true);
            TextLabel7.BackgroundTransparency = 1;
            TextLabel7.FontFace = u232;
            TextLabel7.TextColor3 = u231.text;
            TextLabel7.TextSize = 21;
            TextLabel7.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel7.Text = "";

            for i2, v in v633 do
                TextLabel7[i2] = v;
            end;

            TextLabel7.Parent = TextButton;
            TextButton.Activated:Connect(function() -- Line: 2991
                -- upvalues: u219 (ref), u524 (ref), u613 (copy), i (copy)
                if u219.data then
                    u524("staff", u219.data, u613, i);
                end;
            end);
        end;

        if v609 == 0 then
            local v634 = {
                Text = "No moderator actions in this window.",
                TextColor3 = u231.mut,
                TextXAlignment = Enum.TextXAlignment.Center,
                Position = UDim2.new(0, 0, 0, 90),
                Size = UDim2.new(1, 0, 0, 40)
            };
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.BorderSizePixel = 0;
            TextLabel2:SetAttribute("SkipTheme", true);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.FontFace = u232;
            TextLabel2.TextColor3 = u231.text;
            TextLabel2.TextSize = 21;
            TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel2.Text = "";

            for i, v in v634 do
                TextLabel2[i] = v;
            end;

            TextLabel2.Parent = body;
        end;

        body.CanvasSize = UDim2.new(0, 0, 0, math.max(v609, 1) * 62 + 86 + 10);

        return;
    end;

    if p588 == "staff" then
        if not u590 then
            return;
        end;

        local v635 = u435[((p591 or 1) - 1) % #u435 + 1];
        local dashboard2 = mainSection:FindFirstChild("dashboard");

        if dashboard2 then
            dashCloseInspect();
            dashServerCleanup();
            dashboard2.home.Visible = false;
            dashboard2.detail.Visible = true;
            dashboard2.detail.body.CanvasPosition = Vector2.zero;
            dashboard2.detail.crumbs.Text = "<font color=\"#B8B9BF\">Dashboard  /  </font>Staff";
        end;

        u219.backTo = "modtrends";
        local crumbs = dashboard.detail.crumbs;
        local ModeratorId = u590.ModeratorId;

        if ModeratorId and ModeratorId > 0 then
            if u220[ModeratorId] then
                crumbs.Text = "<font color=\"#B8B9BF\">Dashboard  /  Staff  /  </font>" .. "@" .. u220[ModeratorId];
            else
                crumbs.Text = "<font color=\"#B8B9BF\">Dashboard  /  Staff  /  </font>" .. "@" .. tostring(ModeratorId);
                resolveUsername(ModeratorId, function(p636) -- Line: 3020
                    -- upvalues: crumbs (copy)
                    if p636 and crumbs.Parent then
                        crumbs.Text = "<font color=\"#B8B9BF\">Dashboard  /  Staff  /  </font>" .. "@" .. p636;
                    end;
                end);
            end;
        else
            crumbs.Text = "<font color=\"#B8B9BF\">Dashboard  /  Staff  /  </font>Automated";
        end;

        local v637 = (u590.Outfit or 0) + (u590.Player or 0);

        if u590.Days then
            local v638 = 0;

            for _, v in u590.Days do
                if v > 0 then
                    v638 = v638 + 1;
                end;
            end;
        end;

        local function rotateToLocal(p639) -- Line: 3034
            if not p639 then
                return nil;
            end;

            local v640 = os.time();
            local v641 = ((tonumber(os.date("%H", v640)) or 0) - (tonumber(os.date("!%H", v640)) or 0)) % 24;
            local v642 = table.create(24, 0);

            for i = 0, 23 do
                v642[i + 1] = p639[(i - v641) % 24 + 1] or 0;
            end;

            return v642;
        end;

        local function peakHourText(p643) -- Line: 3044
            local v644 = 0;
            local v645 = nil;

            for i, v in p643 or {} do
                if v644 < v then
                    v645 = i - 1;
                    v644 = v;
                end;
            end;

            return v645 and string.format("%02d:00 - %02d:00", v645, (v645 + 1) % 24) or "--";
        end;

        local function mkTile(p646, p647, p648, p649, p650) -- Line: 3051
            -- upvalues: u231 (ref), body (copy), u232 (ref), u234 (ref)
            local v651 = {
                BackgroundColor3 = u231.track,
                Position = UDim2.fromOffset(p646, p647),
                Size = UDim2.fromOffset(p648, 92)
            };
            local Frame = Instance.new("Frame");
            Frame.BorderSizePixel = 0;
            Frame:SetAttribute("SkipTheme", true);
            Frame.BackgroundColor3 = u231.text;

            for i, v in v651 do
                Frame[i] = v;
            end;

            Frame.Parent = body;
            local UICorner = Instance.new("UICorner");
            UICorner.CornerRadius = UDim.new(0, 12);
            UICorner.Parent = Frame;
            local v652 = {
                TextSize = 18,
                Text = p649,
                TextColor3 = u231.mut,
                Position = UDim2.fromOffset(16, 14),
                Size = UDim2.fromOffset(p648 - 32, 22)
            };
            local TextLabel = Instance.new("TextLabel");
            TextLabel.BorderSizePixel = 0;
            TextLabel:SetAttribute("SkipTheme", true);
            TextLabel.BackgroundTransparency = 1;
            TextLabel.FontFace = u232;
            TextLabel.TextColor3 = u231.text;
            TextLabel.TextSize = 21;
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel.Text = "";

            for i, v in v652 do
                TextLabel[i] = v;
            end;

            TextLabel.Parent = Frame;
            local v653 = {
                TextSize = 26,
                Text = p650,
                FontFace = u234,
                Position = UDim2.fromOffset(16, 44),
                Size = UDim2.fromOffset(p648 - 32, 32)
            };
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.BorderSizePixel = 0;
            TextLabel2:SetAttribute("SkipTheme", true);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.FontFace = u232;
            TextLabel2.TextColor3 = u231.text;
            TextLabel2.TextSize = 21;
            TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel2.Text = "";

            for i, v in v653 do
                TextLabel2[i] = v;
            end;

            TextLabel2.Parent = Frame;
        end;

        local function mkCaption(p654, p655) -- Line: 3075
            -- upvalues: u231 (ref), body (copy), u232 (ref)
            local v656 = {
                TextSize = 18,
                Text = p655,
                TextColor3 = u231.mut,
                Position = UDim2.fromOffset(0, p654),
                Size = UDim2.fromOffset(500, 22)
            };
            local TextLabel = Instance.new("TextLabel");
            TextLabel.BorderSizePixel = 0;
            TextLabel:SetAttribute("SkipTheme", true);
            TextLabel.BackgroundTransparency = 1;
            TextLabel.FontFace = u232;
            TextLabel.TextColor3 = u231.text;
            TextLabel.TextSize = 21;
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel.Text = "";

            for i, v in v656 do
                TextLabel[i] = v;
            end;

            TextLabel.Parent = body;
        end;

        local function mkHourLabels(p657) -- Line: 3084
            -- upvalues: u231 (ref), body (copy), u232 (ref)
            for _, v in { { 0, "0h" }, { 6, "6h" }, { 12, "12h" }, { 18, "18h" }, { 23, "23h" } } do
                local v658 = {
                    TextSize = 18,
                    Text = v[2],
                    TextColor3 = u231.mut,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    AnchorPoint = Vector2.new(0.5, 0),
                    Position = UDim2.fromOffset((v[1] + 0.5) * 43.833333333333336, p657),
                    Size = UDim2.fromOffset(40, 20)
                };
                local TextLabel = Instance.new("TextLabel");
                TextLabel.BorderSizePixel = 0;
                TextLabel:SetAttribute("SkipTheme", true);
                TextLabel.BackgroundTransparency = 1;
                TextLabel.FontFace = u232;
                TextLabel.TextColor3 = u231.text;
                TextLabel.TextSize = 21;
                TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
                TextLabel.Text = "";

                for i, v2 in v658 do
                    TextLabel[i] = v2;
                end;

                TextLabel.Parent = body;
            end;
        end;

        local v659 = 0;
        local v660 = u590.Actions or {};
        local v661 = (v660.ban1Day or 0) + (v660.ban3Days or 0) + (v660.ban7Days or 0) + (v660.ban30Days or 0) + (v660.permBan or 0);
        mkCaption(v659, "Enforcement");
        local v662 = {};
        local v663 = {};
        local v664 = tonumber(u590.Total or v637) or 0;
        local v665 = math.floor(v664);
        v663[1], v663[2] = "Total actions", tostring(v665):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
        local v666 = {};
        local v667;

        if u590.Actions then
            local v668 = tonumber(v661) or 0;
            local v669 = math.floor(v668);
            v667 = tostring(v669):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") or "--";
        else
            v667 = "--";
        end;

        v666[1], v666[2] = "Bans", v667;
        local v670 = {};
        local v671;

        if u590.Actions then
            local v672 = tonumber(v660.Reset or 0) or 0;
            local v673 = math.floor(v672);
            v671 = tostring(v673):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") or "--";
        else
            v671 = "--";
        end;

        v670[1], v670[2] = "Resets", v671;
        local v674 = {};
        local v675;

        if u590.Actions then
            local v676 = tonumber(v660.Restore or 0) or 0;
            local v677 = math.floor(v676);
            v675 = tostring(v677):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") or "--";
        else
            v675 = "--";
        end;

        v674[1], v674[2] = "Restores", v675;
        v662[1], v662[2], v662[3], v662[4] = v663, v666, v670, v674;

        for i, v in v662 do
            mkTile((i - 1) * 266, v659 + 30, 252, v[1], v[2]);
        end;

        local v678 = v659 + 138;
        mkCaption(v678, "Report reviews");
        local v679 = {};
        local v680 = {};
        local v681;

        if u590.Actions then
            local v682 = tonumber((v660.Approve or 0) + (v660.Dismiss or 0)) or 0;
            local v683 = math.floor(v682);
            v681 = tostring(v683):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") or "--";
        else
            v681 = "--";
        end;

        v680[1], v680[2] = "Reports dismissed", v681;
        v679[1] = v680;

        for i, v in v679 do
            mkTile((i - 1) * 266, v678 + 30, 252, v[1], v[2]);
        end;

        local v684 = v678 + 152;
        mkCaption(v684, "Daily actions");
        local v685 = {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(0, v684 + 30),
            Size = UDim2.fromOffset(1052, 200)
        };
        local Frame = Instance.new("Frame");
        Frame.BorderSizePixel = 0;
        Frame:SetAttribute("SkipTheme", true);
        Frame.BackgroundColor3 = u231.text;

        for i, v in v685 do
            Frame[i] = v;
        end;

        Frame.Parent = body;
        dashLineChart(Frame, 1052, 200, {
            {
                Label = "Actions",
                Days = u590.Days or {},
                Color = v635
            }
        }, #(p589.Days or {}));
        local v686 = {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(0, v684 + 236),
            Size = UDim2.fromOffset(1052, 20)
        };
        local Frame2 = Instance.new("Frame");
        Frame2.BorderSizePixel = 0;
        Frame2:SetAttribute("SkipTheme", true);
        Frame2.BackgroundColor3 = u231.text;

        for i, v in v686 do
            Frame2[i] = v;
        end;

        Frame2.Parent = body;
        dashLineAxis(Frame2, 1052, p589);
        local v687 = v684 + 278;
        mkCaption(v687, "Actions by hour of day (your time)");
        local v688 = {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(0, v687 + 30),
            Size = UDim2.fromOffset(1052, 140)
        };
        local Frame3 = Instance.new("Frame");
        Frame3.BorderSizePixel = 0;
        Frame3:SetAttribute("SkipTheme", true);
        Frame3.BackgroundColor3 = u231.text;

        for i, v in v688 do
            Frame3[i] = v;
        end;

        Frame3.Parent = body;
        dashHourBars(Frame3, 1052, 140, rotateToLocal(u590.Hours) or {}, v635, "your time");
        mkHourLabels(v687 + 176);
        local v689 = v687 + 206;
        local v690 = {
            BackgroundColor3 = u231.line,
            Position = UDim2.fromOffset(0, v689),
            Size = UDim2.new(1, 0, 0, 1)
        };
        local Frame4 = Instance.new("Frame");
        Frame4.BorderSizePixel = 0;
        Frame4:SetAttribute("SkipTheme", true);
        Frame4.BackgroundColor3 = u231.text;

        for i, v in v690 do
            Frame4[i] = v;
        end;

        Frame4.Parent = body;
        local v691 = {
            Text = "Active time",
            TextSize = 24,
            FontFace = u233,
            Position = UDim2.fromOffset(0, v689 + 16),
            Size = UDim2.fromOffset(300, 28)
        };
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BorderSizePixel = 0;
        TextLabel:SetAttribute("SkipTheme", true);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = u232;
        TextLabel.TextColor3 = u231.text;
        TextLabel.TextSize = 21;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Text = "";

        for i, v in v691 do
            TextLabel[i] = v;
        end;

        TextLabel.Parent = body;
        local v692 = {
            Text = "In-game presence across all servers",
            TextSize = 18,
            TextColor3 = u231.mut,
            TextXAlignment = Enum.TextXAlignment.Right,
            Position = UDim2.new(1, -500, 0, v689 + 20),
            Size = UDim2.new(0, 500, 0, 22)
        };
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.BorderSizePixel = 0;
        TextLabel2:SetAttribute("SkipTheme", true);
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.FontFace = u232;
        TextLabel2.TextColor3 = u231.text;
        TextLabel2.TextSize = 21;
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel2.Text = "";

        for i, v in v692 do
            TextLabel2[i] = v;
        end;

        TextLabel2.Parent = body;
        local v693 = v689 + 58;
        local Presence = u590.Presence;
        local v694;

        if Presence and Presence.Days then
            local Days = Presence.Days;
            local v695 = Presence.TotalMinutes or 0;
            local v696 = table.create(#Days, 0);
            local v697 = 0;

            for i, v in Days do
                if v > 0 then
                    v697 = v697 + 1;
                end;

                v696[i] = v / 60;
            end;

            for i, v in {
                { "Total hours", string.format("%.1f h", v695 / 60) },
                { "Days online", v697 .. " of " .. (p589.WindowDays or 28) },
                { "Avg per online day", v697 > 0 and string.format("%.1f h", v695 / 60 / v697) or "--" },
                { "Peak online hour", (peakHourText((rotateToLocal(Presence.Hours)))) }
            } do
                mkTile((i - 1) * 266, v693, 252, v[1], v[2]);
            end;

            local v698 = v693 + 106;
            mkCaption(v698, "Hours per day");
            local v699 = {
                BackgroundTransparency = 1,
                Position = UDim2.fromOffset(0, v698 + 30),
                Size = UDim2.fromOffset(1052, 180)
            };
            local Frame5 = Instance.new("Frame");
            Frame5.BorderSizePixel = 0;
            Frame5:SetAttribute("SkipTheme", true);
            Frame5.BackgroundColor3 = u231.text;

            for i, v in v699 do
                Frame5[i] = v;
            end;

            Frame5.Parent = body;
            dashLineChart(Frame5, 1052, 180, {
                {
                    Label = "Hours online",
                    Days = v696,
                    Color = u231.green
                }
            }, #Days, {
                format = function(p700) -- Line: 3188, Name: format
                    return string.format("%.1f h", p700);
                end
            });
            local v701 = {
                BackgroundTransparency = 1,
                Position = UDim2.fromOffset(0, v698 + 216),
                Size = UDim2.fromOffset(1052, 20)
            };
            local Frame6 = Instance.new("Frame");
            Frame6.BorderSizePixel = 0;
            Frame6:SetAttribute("SkipTheme", true);
            Frame6.BackgroundColor3 = u231.text;

            for i, v in v701 do
                Frame6[i] = v;
            end;

            Frame6.Parent = body;
            dashLineAxis(Frame6, 1052, p589);
            local v702 = v698 + 258;
            mkCaption(v702, "Online by hour of day (your time)");
            local v703 = {
                BackgroundTransparency = 1,
                Position = UDim2.fromOffset(0, v702 + 30),
                Size = UDim2.fromOffset(1052, 140)
            };
            local Frame7 = Instance.new("Frame");
            Frame7.BorderSizePixel = 0;
            Frame7:SetAttribute("SkipTheme", true);
            Frame7.BackgroundColor3 = u231.text;

            for i, v in v703 do
                Frame7[i] = v;
            end;

            Frame7.Parent = body;
            dashHourBars(Frame7, 1052, 140, rotateToLocal(Presence.Hours) or {}, u231.green, "your time", "min", "min");
            mkHourLabels(v702 + 176);
            v694 = v702 + 216;
        else
            local v704 = {
                Text = "No presence data yet. Active time starts recording once updated servers are live.",
                TextColor3 = u231.mut,
                Position = UDim2.fromOffset(0, v693),
                Size = UDim2.new(1, 0, 0, 24)
            };
            local TextLabel3 = Instance.new("TextLabel");
            TextLabel3.BorderSizePixel = 0;
            TextLabel3:SetAttribute("SkipTheme", true);
            TextLabel3.BackgroundTransparency = 1;
            TextLabel3.FontFace = u232;
            TextLabel3.TextColor3 = u231.text;
            TextLabel3.TextSize = 21;
            TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel3.Text = "";

            for i, v in v704 do
                TextLabel3[i] = v;
            end;

            TextLabel3.Parent = body;
            v694 = v693 + 54;
        end;

        local v705 = {
            BackgroundColor3 = u231.line,
            Position = UDim2.fromOffset(0, v694),
            Size = UDim2.new(1, 0, 0, 1)
        };
        local Frame5 = Instance.new("Frame");
        Frame5.BorderSizePixel = 0;
        Frame5:SetAttribute("SkipTheme", true);
        Frame5.BackgroundColor3 = u231.text;

        for i, v in v705 do
            Frame5[i] = v;
        end;

        Frame5.Parent = body;
        local v706 = {
            Text = "Action history",
            TextSize = 24,
            FontFace = u233,
            Position = UDim2.fromOffset(0, v694 + 16),
            Size = UDim2.fromOffset(300, 28)
        };
        local TextLabel3 = Instance.new("TextLabel");
        TextLabel3.BorderSizePixel = 0;
        TextLabel3:SetAttribute("SkipTheme", true);
        TextLabel3.BackgroundTransparency = 1;
        TextLabel3.FontFace = u232;
        TextLabel3.TextColor3 = u231.text;
        TextLabel3.TextSize = 21;
        TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel3.Text = "";

        for i, v in v706 do
            TextLabel3[i] = v;
        end;

        TextLabel3.Parent = body;
        local v707 = {
            Text = "Most recent first. Select an action to inspect the evidence.",
            TextSize = 18,
            TextColor3 = u231.mut,
            TextXAlignment = Enum.TextXAlignment.Right,
            Position = UDim2.new(1, -600, 0, v694 + 20),
            Size = UDim2.new(0, 600, 0, 22)
        };
        local TextLabel4 = Instance.new("TextLabel");
        TextLabel4.BorderSizePixel = 0;
        TextLabel4:SetAttribute("SkipTheme", true);
        TextLabel4.BackgroundTransparency = 1;
        TextLabel4.FontFace = u232;
        TextLabel4.TextColor3 = u231.text;
        TextLabel4.TextSize = 21;
        TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel4.Text = "";

        for i, v in v707 do
            TextLabel4[i] = v;
        end;

        TextLabel4.Parent = body;
        local v708 = v694 + 58;
        local v709 = {
            Text = "Loading actions...",
            TextColor3 = u231.mut,
            Position = UDim2.fromOffset(0, v708),
            Size = UDim2.new(1, 0, 0, 24)
        };
        local TextLabel5 = Instance.new("TextLabel");
        TextLabel5.BorderSizePixel = 0;
        TextLabel5:SetAttribute("SkipTheme", true);
        TextLabel5.BackgroundTransparency = 1;
        TextLabel5.FontFace = u232;
        TextLabel5.TextColor3 = u231.text;
        TextLabel5.TextSize = 21;
        TextLabel5.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel5.Text = "";

        for i, v in v709 do
            TextLabel5[i] = v;
        end;

        TextLabel5.Parent = body;
        body.CanvasSize = UDim2.new(0, 0, 0, v708 + 60);
        local u710 = v708;
        local generation = u219.generation;
        local u711 = nil;
        local u712 = false;
        local u713 = 0;
        local u714 = nil;
        local u715 = nil;
        local u716 = {
            Outfit = u231.red,
            Player = u231.blue
        };

        local function histRenderRow(u717) -- Line: 3251
            -- upvalues: u231 (ref), u710 (ref), body (copy), u232 (ref), u716 (copy), u235 (ref), resolveUsername (ref), dashTimeAgo (ref), dashInspectEntry (ref)
            local v718 = {
                BackgroundTransparency = 0,
                BackgroundColor3 = u231.track,
                Position = UDim2.fromOffset(0, u710),
                Size = UDim2.new(1, 0, 0, 46)
            };
            local TextButton = Instance.new("TextButton");
            TextButton.BorderSizePixel = 0;
            TextButton:SetAttribute("SkipTheme", true);
            TextButton.BackgroundTransparency = 1;
            TextButton.FontFace = u232;
            TextButton.TextColor3 = u231.text;
            TextButton.TextSize = 21;
            TextButton.TextXAlignment = Enum.TextXAlignment.Left;
            TextButton.Text = "";
            TextButton.AutoButtonColor = false;

            for i, v in v718 do
                TextButton[i] = v;
            end;

            TextButton.Parent = body;
            local UICorner = Instance.new("UICorner");
            UICorner.CornerRadius = UDim.new(0, 8);
            UICorner.Parent = TextButton;
            game:GetService("CollectionService"):AddTag(TextButton, "UIEffect");
            local v719 = {
                BackgroundColor3 = u717.Action == "Dismiss" and u231.mut or (u716[u717.Type] or u231.mut),
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new(0, 16, 0.5, 0),
                Size = UDim2.fromOffset(10, 10)
            };
            local Frame6 = Instance.new("Frame");
            Frame6.BorderSizePixel = 0;
            Frame6:SetAttribute("SkipTheme", true);
            Frame6.BackgroundColor3 = u231.text;

            for i, v in v719 do
                Frame6[i] = v;
            end;

            Frame6.Parent = TextButton;
            local UICorner2 = Instance.new("UICorner");
            UICorner2.CornerRadius = UDim.new(1, 0);
            UICorner2.Parent = Frame6;
            local u720 = u235[u717.Action] or tostring(u717.Action);
            local v721;

            if u717.Type == "Outfit" then
                v721 = `"{u717.Name or "outfit"}"`;
            else
                v721 = "player " .. tostring(u717.ReportedUserId);
            end;

            local u722 = u717.Reason and u717.Reason ~= "" and (" - " .. u717.Reason or "") or "";
            local v723 = {
                Text = u720 .. " - " .. v721 .. u722,
                TextColor3 = u231.mut2,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Position = UDim2.new(0, 36, 0, 0),
                Size = UDim2.new(1, -156, 1, 0)
            };
            local TextLabel6 = Instance.new("TextLabel");
            TextLabel6.BorderSizePixel = 0;
            TextLabel6:SetAttribute("SkipTheme", true);
            TextLabel6.BackgroundTransparency = 1;
            TextLabel6.FontFace = u232;
            TextLabel6.TextColor3 = u231.text;
            TextLabel6.TextSize = 21;
            TextLabel6.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel6.Text = "";

            for i, v in v723 do
                TextLabel6[i] = v;
            end;

            TextLabel6.Parent = TextButton;

            if u717.Type ~= "Outfit" and tonumber(u717.ReportedUserId) then
                resolveUsername(u717.ReportedUserId, function(p724) -- Line: 3282
                    -- upvalues: TextLabel6 (copy), u720 (copy), u722 (copy)
                    if p724 and TextLabel6.Parent then
                        TextLabel6.Text = u720 .. " - @" .. p724 .. u722;
                    end;
                end);
            end;

            local v725 = {
                TextSize = 18,
                Text = dashTimeAgo(u717.ActionedAt),
                TextColor3 = u231.mut,
                TextXAlignment = Enum.TextXAlignment.Right,
                Position = UDim2.new(1, -116, 0, 0),
                Size = UDim2.new(0, 100, 1, 0)
            };
            local TextLabel7 = Instance.new("TextLabel");
            TextLabel7.BorderSizePixel = 0;
            TextLabel7:SetAttribute("SkipTheme", true);
            TextLabel7.BackgroundTransparency = 1;
            TextLabel7.FontFace = u232;
            TextLabel7.TextColor3 = u231.text;
            TextLabel7.TextSize = 21;
            TextLabel7.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel7.Text = "";

            for i, v in v725 do
                TextLabel7[i] = v;
            end;

            TextLabel7.Parent = TextButton;
            TextButton.Activated:Connect(function() -- Line: 3296
                -- upvalues: dashInspectEntry (ref), u717 (copy)
                dashInspectEntry(u717);
            end);
            u710 = u710 + 52;
        end;

        local function histUpdateFooter() -- Line: 3302
            -- upvalues: u711 (ref), u714 (ref), u233 (ref), body (copy), u232 (ref), u231 (ref), u715 (ref), u710 (ref), TextLabel5 (copy)
            if u711 then
                if not u714 then
                    local v726 = {
                        Text = "Load older actions",
                        TextSize = 18,
                        BackgroundTransparency = 0.88,
                        FontFace = u233,
                        TextXAlignment = Enum.TextXAlignment.Center,
                        BackgroundColor3 = Color3.fromRGB(208, 217, 251),
                        Size = UDim2.new(1, 0, 0, 40)
                    };
                    local TextButton = Instance.new("TextButton");
                    TextButton.BorderSizePixel = 0;
                    TextButton:SetAttribute("SkipTheme", true);
                    TextButton.BackgroundTransparency = 1;
                    TextButton.FontFace = u232;
                    TextButton.TextColor3 = u231.text;
                    TextButton.TextSize = 21;
                    TextButton.TextXAlignment = Enum.TextXAlignment.Left;
                    TextButton.Text = "";
                    TextButton.AutoButtonColor = false;

                    for i, v in v726 do
                        TextButton[i] = v;
                    end;

                    TextButton.Parent = body;
                    u714 = TextButton;
                    local UICorner = Instance.new("UICorner");
                    UICorner.CornerRadius = UDim.new(0, 8);
                    UICorner.Parent = u714;
                    game:GetService("CollectionService"):AddTag(u714, "UIEffectSoundOnly");
                    u714.Activated:Connect(function() -- Line: 3318
                        -- upvalues: u715 (ref)
                        u715();
                    end);
                end;

                u714.Visible = true;
                u714.Position = UDim2.fromOffset(0, u710);
                TextLabel5.Position = UDim2.fromOffset(0, u710 + 52);
            else
                if u714 then
                    u714.Visible = false;
                end;

                TextLabel5.Position = UDim2.fromOffset(0, u710 + 6);
            end;

            TextLabel5.Text = "Approve and restore entries show the outfit\'s current stored look.";
            body.CanvasSize = UDim2.new(0, 0, 0, TextLabel5.Position.Y.Offset + 60);
        end;

        u715 = function() -- Line: 3333
            -- upvalues: u712 (ref), u714 (ref), Remotes (ref), u590 (copy), u711 (ref), generation (copy), u219 (ref), TextLabel5 (copy), histRenderRow (copy), u713 (ref), body (copy), u710 (ref), histUpdateFooter (copy)
            if u712 then
                return;
            end;

            u712 = true;

            if u714 then
                u714.Text = "Loading...";
            end;

            task.spawn(function() -- Line: 3337
                -- upvalues: Remotes (ref), u590 (ref), u711 (ref), u712 (ref), generation (ref), u219 (ref), TextLabel5 (ref), u714 (ref), histRenderRow (ref), u713 (ref), body (ref), u710 (ref), histUpdateFooter (ref)
                local success, result = pcall(function() -- Line: 3338
                    -- upvalues: Remotes (ref), u590 (ref), u711 (ref)
                    return { Remotes.CommunityOutfitsAction:InvokeServer("GetModeratorActions", u590.ModeratorId, 15, u711) };
                end);
                u712 = false;

                if generation ~= u219.generation or not TextLabel5.Parent then
                    return;
                end;

                if u714 then
                    u714.Text = "Load older actions";
                end;

                local v727;

                if success then
                    v727 = result[1];
                else
                    v727 = success;
                end;

                if success then
                    success = result[2];
                end;

                if not v727 or typeof(success) ~= "table" then
                    TextLabel5.Text = "Couldn\'t load this moderator\'s actions.";

                    return;
                end;

                for _, v in success.Entries or {} do
                    histRenderRow(v);
                    u713 = u713 + 1;
                end;

                u711 = success.NextBefore;

                if u713 ~= 0 then
                    histUpdateFooter();

                    return;
                end;

                TextLabel5.Text = "No recorded actions with stored evidence.";
                body.CanvasSize = UDim2.new(0, 0, 0, u710 + 60);
            end);
        end;

        u715();

        return;
    end;

    if p588 ~= "detection" then
        if p588 ~= "servers" then
            if p588 == "server" then
                local dashboard2 = mainSection:FindFirstChild("dashboard");

                if dashboard2 then
                    dashCloseInspect();
                    dashServerCleanup();
                    dashboard2.home.Visible = false;
                    dashboard2.detail.Visible = true;
                    dashboard2.detail.body.CanvasPosition = Vector2.zero;
                    dashboard2.detail.crumbs.Text = "<font color=\"#B8B9BF\">Dashboard  /  </font>This server";
                end;

                u219.backTo = nil;
                local v728 = {
                    Text = "Live outfits and detection scores for everyone in this server. Updates automatically. Select a player to inspect their outfit.",
                    TextColor3 = u231.mut,
                    Size = UDim2.new(1, 0, 0, 24)
                };
                local TextLabel = Instance.new("TextLabel");
                TextLabel.BorderSizePixel = 0;
                TextLabel:SetAttribute("SkipTheme", true);
                TextLabel.BackgroundTransparency = 1;
                TextLabel.FontFace = u232;
                TextLabel.TextColor3 = u231.text;
                TextLabel.TextSize = 21;
                TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
                TextLabel.Text = "";

                for i, v in v728 do
                    TextLabel[i] = v;
                end;

                TextLabel.Parent = body;
                local v729 = {
                    Text = "",
                    TextColor3 = u231.mut,
                    Position = UDim2.fromOffset(0, 48),
                    Size = UDim2.new(1, 0, 0, 24)
                };
                local TextLabel2 = Instance.new("TextLabel");
                TextLabel2.BorderSizePixel = 0;
                TextLabel2:SetAttribute("SkipTheme", true);
                TextLabel2.BackgroundTransparency = 1;
                TextLabel2.FontFace = u232;
                TextLabel2.TextColor3 = u231.text;
                TextLabel2.TextSize = 21;
                TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
                TextLabel2.Text = "";

                for i, v in v729 do
                    TextLabel2[i] = v;
                end;

                TextLabel2.Parent = body;
                local u730 = TextLabel2;
                dashSkeletonBlock(body, 0, 48, 1052, 64);
                dashSkeletonBlock(body, 0, 120, 1052, 64);
                dashSkeletonBlock(body, 0, 192, 1052, 64);
                dashSkeletonBlock(body, 0, 264, 1052, 64);
                dashSkeletonBlock(body, 0, 336, 1052, 64);
                body.CanvasSize = UDim2.new(0, 0, 0, 160);
                local u731 = {
                    Reset = Color3.fromRGB(244, 91, 82),
                    Hide = Color3.fromRGB(240, 185, 60),
                    Near = Color3.fromRGB(184, 185, 191),
                    Clean = Color3.fromRGB(57, 197, 130)
                };
                local u732 = {
                    Reset = "reset band",
                    Hide = "hide band",
                    Near = "near-miss",
                    Clean = "clean"
                };
                local u733 = {};
                local u734 = {};
                u219.serverToken = u734;
                u219.serverRows = u733;
                local generation = u219.generation;

                local function rowKey(p735) -- Line: 4299
                    return table.concat({
                        tostring(p735.Score or "-"),
                        tostring(p735.Band or "-"),
                        p735.Hidden and "1" or "0",
                        tostring(#(p735.Flagged or {})),
                        tostring(p735.OutfitVersion or 0),
                        tostring(p735.RoleplayName or ""),
                        (tostring(p735.DisplayName or ""))
                    }, "|");
                end;

                local function buildRow(u736, u737) -- Line: 4311
                    -- upvalues: u231 (ref), body (copy), u232 (ref), HumanoidDescriptionController (ref), AvatarPreviewController (ref), u233 (ref), u731 (copy), u732 (copy), LocalPlayer (ref), Events (ref), u1 (ref), Remotes (ref), dashInspectEntry (ref)
                    local v738 = {
                        BackgroundTransparency = 0,
                        BackgroundColor3 = u231.track,
                        Size = UDim2.new(1, 0, 0, 64)
                    };
                    local TextButton = Instance.new("TextButton");
                    TextButton.BorderSizePixel = 0;
                    TextButton:SetAttribute("SkipTheme", true);
                    TextButton.BackgroundTransparency = 1;
                    TextButton.FontFace = u232;
                    TextButton.TextColor3 = u231.text;
                    TextButton.TextSize = 21;
                    TextButton.TextXAlignment = Enum.TextXAlignment.Left;
                    TextButton.Text = "";
                    TextButton.AutoButtonColor = false;

                    for i, v in v738 do
                        TextButton[i] = v;
                    end;

                    TextButton.Parent = body;
                    local UICorner = Instance.new("UICorner");
                    UICorner.CornerRadius = UDim.new(0, 8);
                    UICorner.Parent = TextButton;
                    game:GetService("CollectionService"):AddTag(TextButton, "UIEffect");

                    if u737.serialized then
                        local ViewportFrame = Instance.new("ViewportFrame");
                        ViewportFrame:SetAttribute("SkipTheme", true);
                        ViewportFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 21);
                        ViewportFrame.BackgroundTransparency = 0;
                        ViewportFrame.Ambient = Color3.fromRGB(202, 202, 202);
                        ViewportFrame.LightColor = Color3.fromRGB(221, 221, 221);
                        ViewportFrame.LightDirection = Vector3.new(0.5, -1, 0.5);
                        ViewportFrame.AnchorPoint = Vector2.new(0, 0.5);
                        ViewportFrame.Position = UDim2.new(0, 8, 0.5, 0);
                        ViewportFrame.Size = UDim2.fromOffset(52, 52);
                        ViewportFrame.ZIndex = 2;
                        ViewportFrame.Parent = TextButton;
                        local UICorner2 = Instance.new("UICorner");
                        UICorner2.CornerRadius = UDim.new(0, 8);
                        UICorner2.Parent = ViewportFrame;
                        task.spawn(function() -- Line: 4342
                            -- upvalues: HumanoidDescriptionController (ref), u737 (copy), AvatarPreviewController (ref), ViewportFrame (copy), TextButton (copy)
                            local v739, v740, v741 = pcall(HumanoidDescriptionController.DeserializeHumanoidDescription, u737.serialized);

                            if not (v739 and v740) then
                                return;
                            end;

                            local success, result = pcall(AvatarPreviewController.new, ViewportFrame, v740, {
                                RigType = v741
                            });

                            if success and result then
                                if ViewportFrame.Parent and TextButton.Parent then
                                    u737.preview = result;

                                    return;
                                end;

                                pcall(function() -- Line: 4350
                                    -- upvalues: result (copy)
                                    result:Destroy();
                                end);
                            end;
                        end);
                    else
                        local ImageLabel = Instance.new("ImageLabel");
                        ImageLabel.BackgroundTransparency = 1;
                        ImageLabel:SetAttribute("SkipTheme", true);
                        ImageLabel:SetAttribute("SkipThemeImage", true);
                        ImageLabel.Image = `rbxthumb://type=AvatarHeadShot&id={u736.UserId}&w=100&h=100`;
                        ImageLabel.AnchorPoint = Vector2.new(0, 0.5);
                        ImageLabel.Position = UDim2.new(0, 8, 0.5, 0);
                        ImageLabel.Size = UDim2.fromOffset(52, 52);
                        ImageLabel.ZIndex = 2;
                        ImageLabel.Parent = TextButton;
                        local UICorner2 = Instance.new("UICorner");
                        UICorner2.CornerRadius = UDim.new(0, 8);
                        UICorner2.Parent = ImageLabel;
                    end;

                    local v742 = u736.RoleplayName or (u736.DisplayName or u736.Name);
                    local v743 = {
                        TextSize = 20,
                        Text = tostring(v742),
                        FontFace = u233,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        Position = UDim2.fromOffset(72, 8),
                        Size = UDim2.fromOffset(310, 24)
                    };
                    local TextLabel3 = Instance.new("TextLabel");
                    TextLabel3.BorderSizePixel = 0;
                    TextLabel3:SetAttribute("SkipTheme", true);
                    TextLabel3.BackgroundTransparency = 1;
                    TextLabel3.FontFace = u232;
                    TextLabel3.TextColor3 = u231.text;
                    TextLabel3.TextSize = 21;
                    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
                    TextLabel3.Text = "";

                    for i, v in v743 do
                        TextLabel3[i] = v;
                    end;

                    TextLabel3.Parent = TextButton;
                    local v744 = "@" .. tostring(u736.Name);

                    if u736.DisplayName and (u736.DisplayName ~= v742 and u736.DisplayName ~= u736.Name) then
                        v744 = v744 .. "  ·  " .. u736.DisplayName;
                    end;

                    local v745 = {
                        TextSize = 15,
                        Text = v744,
                        TextColor3 = u231.mut,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        Position = UDim2.fromOffset(72, 34),
                        Size = UDim2.fromOffset(310, 20)
                    };
                    local TextLabel4 = Instance.new("TextLabel");
                    TextLabel4.BorderSizePixel = 0;
                    TextLabel4:SetAttribute("SkipTheme", true);
                    TextLabel4.BackgroundTransparency = 1;
                    TextLabel4.FontFace = u232;
                    TextLabel4.TextColor3 = u231.text;
                    TextLabel4.TextSize = 21;
                    TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
                    TextLabel4.Text = "";

                    for i, v in v745 do
                        TextLabel4[i] = v;
                    end;

                    TextLabel4.Parent = TextButton;
                    local v746 = u736.Band or "Clean";
                    local v747 = u731[v746] or u731.Clean;
                    local u748;

                    if u736.Score then
                        u748 = tostring(u736.Score) .. "  " .. (u732[v746] or v746);
                    else
                        v747 = Color3.fromRGB(184, 185, 191);
                        u748 = "no outfit data";
                    end;

                    local v749 = 24 + (utf8.len(u748) or #u748) * 9;
                    local v750 = {
                        TextSize = 16,
                        BackgroundTransparency = 0.84,
                        Text = u748,
                        FontFace = u233,
                        TextXAlignment = Enum.TextXAlignment.Center
                    };
                    local v751;

                    if v746 == "Near" then
                        v751 = Color3.fromRGB(247, 247, 248) or v747;
                    else
                        v751 = v747;
                    end;

                    v750.TextColor3 = v751;
                    v750.BackgroundColor3 = v747;
                    v750.AnchorPoint = Vector2.new(0, 0.5);
                    v750.Position = UDim2.new(0, 400, 0.5, 0);
                    v750.Size = UDim2.fromOffset(v749, 28);
                    local TextLabel5 = Instance.new("TextLabel");
                    TextLabel5.BorderSizePixel = 0;
                    TextLabel5:SetAttribute("SkipTheme", true);
                    TextLabel5.BackgroundTransparency = 1;
                    TextLabel5.FontFace = u232;
                    TextLabel5.TextColor3 = u231.text;
                    TextLabel5.TextSize = 21;
                    TextLabel5.TextXAlignment = Enum.TextXAlignment.Left;
                    TextLabel5.Text = "";

                    for i, v in v750 do
                        TextLabel5[i] = v;
                    end;

                    TextLabel5.Parent = TextButton;
                    local UICorner2 = Instance.new("UICorner");
                    UICorner2.CornerRadius = UDim.new(0, 6);
                    UICorner2.Parent = TextLabel5;
                    local u752;

                    if u736.Hidden then
                        local v753 = {
                            Text = "hidden here",
                            TextSize = 16,
                            BackgroundTransparency = 0.84,
                            FontFace = u233,
                            TextXAlignment = Enum.TextXAlignment.Center,
                            TextColor3 = Color3.fromRGB(240, 185, 60),
                            BackgroundColor3 = Color3.fromRGB(240, 185, 60),
                            AnchorPoint = Vector2.new(0, 0.5),
                            Position = UDim2.new(0, 400 + v749 + 12, 0.5, 0),
                            Size = UDim2.fromOffset(120, 28)
                        };
                        u752 = Instance.new("TextLabel");
                        u752.BorderSizePixel = 0;
                        u752:SetAttribute("SkipTheme", true);
                        u752.BackgroundTransparency = 1;
                        u752.FontFace = u232;
                        u752.TextColor3 = u231.text;
                        u752.TextSize = 21;
                        u752.TextXAlignment = Enum.TextXAlignment.Left;
                        u752.Text = "";

                        for i, v in v753 do
                            u752[i] = v;
                        end;

                        u752.Parent = TextButton;
                        local UICorner3 = Instance.new("UICorner");
                        UICorner3.CornerRadius = UDim.new(0, 6);
                        UICorner3.Parent = u752;
                        local u754 = 12;
                        task.spawn(function() -- Line: 1445
                            -- upvalues: u752 (copy), u754 (copy)
                            local u755 = nil;
                            pcall(function() -- Line: 1447
                                -- upvalues: u752 (ref), u755 (ref)
                                local GetTextBoundsParams = Instance.new("GetTextBoundsParams");
                                GetTextBoundsParams.Text = u752.Text;
                                GetTextBoundsParams.Font = u752.FontFace;
                                GetTextBoundsParams.Size = u752.TextSize;
                                GetTextBoundsParams.Width = 1000;
                                u755 = game:GetService("TextService"):GetTextBoundsAsync(GetTextBoundsParams).X;
                            end);

                            if u755 and u752.Parent then
                                u752.Size = UDim2.fromOffset(math.ceil(u755) + (u754 or 10) * 2, u752.Size.Y.Offset);
                            end;
                        end);
                    else
                        u752 = nil;
                    end;

                    task.spawn(function() -- Line: 4437
                        -- upvalues: u748 (ref), TextLabel5 (copy), u752 (ref)
                        local u756 = nil;
                        pcall(function() -- Line: 4439
                            -- upvalues: u748 (ref), TextLabel5 (ref), u756 (ref)
                            local GetTextBoundsParams = Instance.new("GetTextBoundsParams");
                            GetTextBoundsParams.Text = u748;
                            GetTextBoundsParams.Font = TextLabel5.FontFace;
                            GetTextBoundsParams.Size = TextLabel5.TextSize;
                            GetTextBoundsParams.Width = 1000;
                            u756 = game:GetService("TextService"):GetTextBoundsAsync(GetTextBoundsParams).X;
                        end);

                        if not u756 then
                            return;
                        end;

                        local v757 = math.ceil(u756) + 24;

                        if TextLabel5.Parent then
                            TextLabel5.Size = UDim2.fromOffset(v757, 28);
                        end;

                        if u752 and u752.Parent then
                            u752.Position = UDim2.new(0, v757 + 400 + 12, 0.5, 0);
                        end;
                    end);

                    if u736.Score then
                        local v758 = #(u736.Flagged or {});
                        local v759 = {
                            TextSize = 18,
                            Text = v758 .. (v758 == 1 and " flagged item" or " flagged items"),
                            TextColor3 = u231.mut,
                            TextXAlignment = Enum.TextXAlignment.Right,
                            Position = UDim2.new(1, -334, 0, 0),
                            Size = UDim2.new(0, 180, 1, 0)
                        };
                        local TextLabel6 = Instance.new("TextLabel");
                        TextLabel6.BorderSizePixel = 0;
                        TextLabel6:SetAttribute("SkipTheme", true);
                        TextLabel6.BackgroundTransparency = 1;
                        TextLabel6.FontFace = u232;
                        TextLabel6.TextColor3 = u231.text;
                        TextLabel6.TextSize = 21;
                        TextLabel6.TextXAlignment = Enum.TextXAlignment.Left;
                        TextLabel6.Text = "";

                        for i, v in v759 do
                            TextLabel6[i] = v;
                        end;

                        TextLabel6.Parent = TextButton;
                    end;

                    if u736.UserId ~= LocalPlayer.UserId then
                        local v760 = {
                            Text = "Moderate",
                            TextSize = 18,
                            BackgroundTransparency = 0.88,
                            ZIndex = 3,
                            FontFace = u233,
                            TextXAlignment = Enum.TextXAlignment.Center,
                            BackgroundColor3 = Color3.fromRGB(208, 217, 251),
                            AnchorPoint = Vector2.new(1, 0.5),
                            Position = UDim2.new(1, -12, 0.5, 0),
                            Size = UDim2.fromOffset(110, 36)
                        };
                        local TextButton2 = Instance.new("TextButton");
                        TextButton2.BorderSizePixel = 0;
                        TextButton2:SetAttribute("SkipTheme", true);
                        TextButton2.BackgroundTransparency = 1;
                        TextButton2.FontFace = u232;
                        TextButton2.TextColor3 = u231.text;
                        TextButton2.TextSize = 21;
                        TextButton2.TextXAlignment = Enum.TextXAlignment.Left;
                        TextButton2.Text = "";
                        TextButton2.AutoButtonColor = false;

                        for i, v in v760 do
                            TextButton2[i] = v;
                        end;

                        TextButton2.Parent = TextButton;
                        local UICorner3 = Instance.new("UICorner");
                        UICorner3.CornerRadius = UDim.new(0, 8);
                        UICorner3.Parent = TextButton2;
                        game:GetService("CollectionService"):AddTag(TextButton2, "UIEffectSoundOnly");
                        TextButton2.Activated:Connect(function() -- Line: 4484
                            -- upvalues: Events (ref), u736 (copy), u1 (ref), Remotes (ref)
                            local u761 = Events.PromptChoice:Invoke({
                                subtitle = "Actions their current outfit directly. Every action is recorded.",
                                allowCustom = false,
                                title = "Moderate @" .. tostring(u736.Name),
                                options = { {
                                        label = "Reset outfit"
                                    }, {
                                        label = "Ban 1 day"
                                    }, {
                                        label = "Ban 3 days"
                                    }, {
                                        label = "Ban 7 days"
                                    }, {
                                        label = "Ban 30 days"
                                    }, {
                                        label = "Permanent ban"
                                    } }
                            });

                            if not u761 then
                                return;
                            end;

                            local u762 = ({
                                ["Reset outfit"] = "Reset",
                                ["Ban 1 day"] = "ban1Day",
                                ["Ban 3 days"] = "ban3Days",
                                ["Ban 7 days"] = "ban7Days",
                                ["Ban 30 days"] = "ban30Days",
                                ["Permanent ban"] = "permBan"
                            })[u761.value];

                            if not u762 then
                                return;
                            end;

                            local u763 = Events.PromptChoice:Invoke({
                                subtitle = "Be concise and accurate.",
                                allowCustom = true,
                                placeholder = "Type a custom reason…",
                                title = "Reason: " .. u761.value,
                                options = u1
                            });

                            if not u763 then
                                return;
                            end;

                            if Events.PromptConfirmationDialog:Invoke({
                                Title = "Confirm moderation",
                                NoText = "Cancel",
                                Description = (u762 == "Reset" and "This resets @" .. tostring(u736.Name) .. "\'s current outfit." or "This bans @" .. tostring(u736.Name) .. " (" .. u761.value .. ") and resets their outfit.") .. "\n\nReason: " .. u763.value,
                                YesText = u762 == "Reset" and "Reset Outfit" or "Ban Player"
                            }) ~= true then
                                return;
                            end;

                            task.spawn(function() -- Line: 4526
                                -- upvalues: Remotes (ref), u736 (ref), u762 (copy), u763 (copy), Events (ref), u761 (copy)
                                local success, result = pcall(function() -- Line: 4527
                                    -- upvalues: Remotes (ref), u736 (ref), u762 (ref), u763 (ref)
                                    return { Remotes.CommunityOutfitsAction:InvokeServer("DirectModeratePlayer", u736.UserId, u762, u763.value) };
                                end);
                                local v764;

                                if success then
                                    v764 = result[1];
                                else
                                    v764 = success;
                                end;

                                local v765;

                                if success then
                                    v765 = result[2];
                                else
                                    v765 = success;
                                end;

                                if success then
                                    success = result[3];
                                end;

                                if v764 then
                                    Events.Notify:Fire("✅ Applied <b>" .. u761.value .. "</b> to <b>@" .. tostring(u736.Name) .. "</b>.");

                                    return;
                                end;

                                if success == "AlreadyBanned" then
                                    Events.Notify:Fire("⚠️ " .. tostring(v765));

                                    return;
                                end;

                                Events.Notify:Fire("❌ " .. tostring(v765));
                            end);
                        end);
                    end;

                    TextButton.Activated:Connect(function() -- Line: 4546
                        -- upvalues: u737 (copy), u736 (copy), Events (ref), dashInspectEntry (ref), u732 (ref)
                        local v766 = u737.latest or u736;

                        if not u737.serialized then
                            Events.Notify:Fire("⚠️ No outfit data for this player yet.");

                            return;
                        end;

                        local v767 = {};

                        for _, v in v766.Flagged or {} do
                            table.insert(v767, {
                                Id = v.AssetId,
                                Score = v.Score,
                                Label = v.Label
                            });
                        end;

                        local v768 = #v767;
                        dashInspectEntry({
                            Type = "Player",
                            ModeratorId = "-",
                            ReportedUserId = v766.UserId,
                            HumanoidDescription = u737.serialized,
                            Action = "Live outfit, score " .. tostring(v766.Score or 0),
                            Detection = {
                                Score = v766.Score or 0,
                                Band = v766.Band or "Clean",
                                Items = v767
                            },
                            Reason = "Score " .. tostring(v766.Score or 0) .. " (" .. (u732[v766.Band or "Clean"] or "clean") .. "), " .. v768 .. (v768 == 1 and " flagged item" or " flagged items"),
                            ActionedAt = os.time()
                        });
                    end);

                    return TextButton;
                end;

                local function applySnapshot(p769) -- Line: 4573
                    -- upvalues: dashHideSkeletons (ref), body (copy), u730 (ref), u733 (copy), rowKey (copy), buildRow (copy)
                    dashHideSkeletons(body);

                    if u730 and u730.Parent then
                        if #p769 == 0 then
                            u730.Text = "No players in this server.";
                        else
                            u730:Destroy();
                            u730 = nil;
                        end;
                    end;

                    local v770 = {};

                    for i, v in p769 do
                        v770[v.UserId] = true;
                        local u771 = u733[v.UserId];

                        if not u771 then
                            u771 = {
                                version = -1
                            };
                            u733[v.UserId] = u771;
                        end;

                        if v.HumanoidDescription then
                            u771.serialized = v.HumanoidDescription;
                        end;

                        u771.latest = v;
                        local v772 = rowKey(v);

                        if u771.key ~= v772 or not u771.frame then
                            if u771.preview then
                                pcall(function() -- Line: 4598
                                    -- upvalues: u771 (ref)
                                    u771.preview:Destroy();
                                end);
                                u771.preview = nil;
                            end;

                            if u771.frame then
                                u771.frame:Destroy();
                            end;

                            u771.frame = buildRow(v, u771);
                            u771.key = v772;
                        end;

                        u771.version = v.OutfitVersion or 0;
                        u771.frame.Position = UDim2.fromOffset(0, 48 + (i - 1) * 72);
                    end;

                    for i, v in u733 do
                        if not v770[i] then
                            if v.preview then
                                pcall(function() -- Line: 4615
                                    -- upvalues: v (copy)
                                    v.preview:Destroy();
                                end);
                            end;

                            if v.frame then
                                v.frame:Destroy();
                            end;

                            u733[i] = nil;
                        end;
                    end;

                    body.CanvasSize = UDim2.new(0, 0, 0, math.max(#p769, 1) * 72 + 48 + 20);
                end;

                task.spawn(function() -- Line: 4630
                    -- upvalues: u219 (ref), u734 (copy), generation (copy), u733 (copy), Remotes (ref), applySnapshot (copy), u730 (ref), dashHideSkeletons (ref), body (copy)
                    while u219.serverToken == u734 and generation == u219.generation do
                        local u773 = {};

                        for i, v in u733 do
                            u773[tostring(i)] = v.version;
                        end;

                        local success, result = pcall(function() -- Line: 4636
                            -- upvalues: Remotes (ref), u773 (copy)
                            return { Remotes.CommunityOutfitsAction:InvokeServer("GetServerPlayers", u773) };
                        end);

                        if u219.serverToken ~= u734 or generation ~= u219.generation then
                            break;
                        end;

                        local v774;

                        if success then
                            v774 = result[1];
                        else
                            v774 = success;
                        end;

                        if success then
                            success = result[2];
                        end;

                        if v774 and typeof(success) == "table" then
                            applySnapshot(success);
                        elseif u730 and u730.Parent then
                            dashHideSkeletons(body);
                            u730.Text = "Couldn\'t load server players.";
                        end;

                        task.wait(5);
                    end;
                end);
            end;

            return;
        end;

        local dashboard2 = mainSection:FindFirstChild("dashboard");

        if dashboard2 then
            dashCloseInspect();
            dashServerCleanup();
            dashboard2.home.Visible = false;
            dashboard2.detail.Visible = true;
            dashboard2.detail.body.CanvasPosition = Vector2.zero;
            dashboard2.detail.crumbs.Text = "<font color=\"#B8B9BF\">Dashboard  /  </font>All servers";
        end;

        u219.backTo = nil;
        dashServerCleanup();
        local v775 = {
            Text = "Every public server, most offending first. Updates every 30 seconds. Join a server to moderate it in person.",
            TextColor3 = u231.mut,
            Size = UDim2.new(1, 0, 0, 24)
        };
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BorderSizePixel = 0;
        TextLabel:SetAttribute("SkipTheme", true);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = u232;
        TextLabel.TextColor3 = u231.text;
        TextLabel.TextSize = 21;
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Text = "";

        for i, v in v775 do
            TextLabel[i] = v;
        end;

        TextLabel.Parent = body;
        local v776 = {
            Text = "",
            TextColor3 = u231.mut,
            Position = UDim2.fromOffset(0, 52),
            Size = UDim2.new(1, 0, 0, 24)
        };
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.BorderSizePixel = 0;
        TextLabel2:SetAttribute("SkipTheme", true);
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.FontFace = u232;
        TextLabel2.TextColor3 = u231.text;
        TextLabel2.TextSize = 21;
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel2.Text = "";

        for i, v in v776 do
            TextLabel2[i] = v;
        end;

        TextLabel2.Parent = body;
        dashSkeletonBlock(body, 0, 128, 1052, 54);
        dashSkeletonBlock(body, 0, 190, 1052, 54);
        dashSkeletonBlock(body, 0, 252, 1052, 54);
        dashSkeletonBlock(body, 0, 314, 1052, 54);
        body.CanvasSize = UDim2.new(0, 0, 0, 160);
        local u777 = {
            Reset = Color3.fromRGB(244, 91, 82),
            Hide = Color3.fromRGB(240, 185, 60),
            Near = Color3.fromRGB(184, 185, 191),
            Clean = Color3.fromRGB(57, 197, 130)
        };
        local u778 = {};
        u219.serverToken = u778;
        local generation = u219.generation;
        local v779 = {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(0, 96),
            Size = UDim2.new(1, 0, 0, 0)
        };
        local Frame = Instance.new("Frame");
        Frame.BorderSizePixel = 0;
        Frame:SetAttribute("SkipTheme", true);
        Frame.BackgroundColor3 = u231.text;
        local u780 = nil;
        local u781 = { {
                key = "FlaggedScore",
                label = "Flagged score"
            }, {
                key = "TotalScore",
                label = "Total score"
            }, {
                key = "AvgScore",
                label = "Avg score / player"
            } };
        local u782 = 1;

        for i, v in v779 do
            Frame[i] = v;
        end;

        Frame.Parent = body;
        local u783 = {
            {
                label = "Server",
                x = 64,
                w = 240,
                align = Enum.TextXAlignment.Left
            },
            {
                label = "Players",
                x = 310,
                w = 80,
                align = Enum.TextXAlignment.Right
            },
            {
                label = "Hidden",
                x = 400,
                w = 80,
                align = Enum.TextXAlignment.Right
            },
            {
                label = "Flagged",
                x = 490,
                w = 100,
                align = Enum.TextXAlignment.Right
            },
            {
                label = "Total",
                x = 600,
                w = 90,
                align = Enum.TextXAlignment.Right
            },
            {
                label = "Avg",
                x = 700,
                w = 80,
                align = Enum.TextXAlignment.Right
            },
            {
                label = "Worst",
                x = 806,
                w = 130,
                align = Enum.TextXAlignment.Left
            }
        };

        local function renderList() -- Line: 4005
            -- upvalues: Frame (copy), u780 (ref), u781 (copy), u782 (ref), u231 (ref), u232 (ref), u783 (copy), u233 (ref), dashTimeAgo (ref), u777 (copy), Events (ref), LocalPlayer (ref), body (copy)
            for _, child in Frame:GetChildren() do
                child:Destroy();
            end;

            if not u780 then
                return;
            end;

            local v784 = {};

            for _, v in u780.Servers or {} do
                local v785 = table.clone(v);
                v785.AvgScore = (v785.TotalScore or 0) / math.max(v785.Scored or 0, 1);
                table.insert(v784, v785);
            end;

            local key = u781[u782].key;
            table.sort(v784, function(p786, p787) -- Line: 4017
                -- upvalues: key (copy)
                return (p786[key] or 0) > (p787[key] or 0);
            end);
            local v788 = {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 24)
            };
            local Frame2 = Instance.new("Frame");
            Frame2.BorderSizePixel = 0;
            Frame2:SetAttribute("SkipTheme", true);
            Frame2.BackgroundColor3 = u231.text;

            for i, v in v788 do
                Frame2[i] = v;
            end;

            Frame2.Parent = Frame;
            local v789 = {
                Text = "#",
                TextSize = 18,
                TextColor3 = u231.mut,
                Position = UDim2.fromOffset(16, 0),
                Size = UDim2.fromOffset(40, 24)
            };
            local TextLabel3 = Instance.new("TextLabel");
            TextLabel3.BorderSizePixel = 0;
            TextLabel3:SetAttribute("SkipTheme", true);
            TextLabel3.BackgroundTransparency = 1;
            TextLabel3.FontFace = u232;
            TextLabel3.TextColor3 = u231.text;
            TextLabel3.TextSize = 21;
            TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel3.Text = "";

            for i, v in v789 do
                TextLabel3[i] = v;
            end;

            TextLabel3.Parent = Frame2;

            for _, v in u783 do
                local v790 = {
                    TextSize = 18,
                    Text = v.label,
                    TextColor3 = u231.mut,
                    TextXAlignment = v.align,
                    Position = UDim2.fromOffset(v.x, 0),
                    Size = UDim2.fromOffset(v.w, 24)
                };
                local TextLabel4 = Instance.new("TextLabel");
                TextLabel4.BorderSizePixel = 0;
                TextLabel4:SetAttribute("SkipTheme", true);
                TextLabel4.BackgroundTransparency = 1;
                TextLabel4.FontFace = u232;
                TextLabel4.TextColor3 = u231.text;
                TextLabel4.TextSize = 21;
                TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
                TextLabel4.Text = "";

                for i, v2 in v790 do
                    TextLabel4[i] = v2;
                end;

                TextLabel4.Parent = Frame2;
            end;

            for i, v in v784 do
                if i > 100 then
                    break;
                end;

                local v791 = u780.ThisJobId and v.JobId == u780.ThisJobId;
                local v792 = {
                    BackgroundColor3 = u231.track,
                    Position = UDim2.new(0, 0, 0, 32 + (i - 1) * 62),
                    Size = UDim2.new(1, 0, 0, 54)
                };
                local Frame3 = Instance.new("Frame");
                Frame3.BorderSizePixel = 0;
                Frame3:SetAttribute("SkipTheme", true);
                Frame3.BackgroundColor3 = u231.text;

                for i2, v2 in v792 do
                    Frame3[i2] = v2;
                end;

                Frame3.Parent = Frame;
                local UICorner = Instance.new("UICorner");
                UICorner.CornerRadius = UDim.new(0, 8);
                UICorner.Parent = Frame3;
                local v793 = {
                    Text = tostring(i),
                    TextColor3 = u231.mut,
                    Position = UDim2.fromOffset(16, 0),
                    Size = UDim2.new(0, 40, 1, 0)
                };
                local TextLabel4 = Instance.new("TextLabel");
                TextLabel4.BorderSizePixel = 0;
                TextLabel4:SetAttribute("SkipTheme", true);
                TextLabel4.BackgroundTransparency = 1;
                TextLabel4.FontFace = u232;
                TextLabel4.TextColor3 = u231.text;
                TextLabel4.TextSize = 21;
                TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
                TextLabel4.Text = "";

                for i2, v2 in v793 do
                    TextLabel4[i2] = v2;
                end;

                TextLabel4.Parent = Frame3;
                local v794 = tostring(v.JobId or "?");
                local u795 = string.sub(v794, 1, 8);
                local v796 = {
                    TextSize = 19,
                    Text = u795 .. (v791 and "  (this server)" or ""),
                    FontFace = u233,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    Position = UDim2.fromOffset(64, 8),
                    Size = UDim2.fromOffset(240, 22)
                };
                local TextLabel5 = Instance.new("TextLabel");
                TextLabel5.BorderSizePixel = 0;
                TextLabel5:SetAttribute("SkipTheme", true);
                TextLabel5.BackgroundTransparency = 1;
                TextLabel5.FontFace = u232;
                TextLabel5.TextColor3 = u231.text;
                TextLabel5.TextSize = 21;
                TextLabel5.TextXAlignment = Enum.TextXAlignment.Left;
                TextLabel5.Text = "";

                for i2, v2 in v796 do
                    TextLabel5[i2] = v2;
                end;

                TextLabel5.Parent = Frame3;
                local v797 = {
                    TextSize = 14,
                    Text = "updated " .. dashTimeAgo(v.At),
                    TextColor3 = u231.mut,
                    Position = UDim2.fromOffset(64, 32),
                    Size = UDim2.fromOffset(240, 16)
                };
                local TextLabel6 = Instance.new("TextLabel");
                TextLabel6.BorderSizePixel = 0;
                TextLabel6:SetAttribute("SkipTheme", true);
                TextLabel6.BackgroundTransparency = 1;
                TextLabel6.FontFace = u232;
                TextLabel6.TextColor3 = u231.text;
                TextLabel6.TextSize = 21;
                TextLabel6.TextXAlignment = Enum.TextXAlignment.Left;
                TextLabel6.Text = "";

                for i2, v2 in v797 do
                    TextLabel6[i2] = v2;
                end;

                TextLabel6.Parent = Frame3;
                local v798 = {};
                local v799 = {};
                local v800 = u783[2];
                local v801 = tonumber(v.Players or 0) or 0;
                local v802 = math.floor(v801);
                v799[1], v799[2] = v800, tostring(v802):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
                local v803 = {};
                local v804 = u783[3];
                local v805 = tonumber(v.Hidden or 0) or 0;
                local v806 = math.floor(v805);
                v803[1], v803[2] = v804, tostring(v806):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
                local v807 = {};
                local v808 = u783[4];
                local v809 = tonumber(v.FlaggedScore or 0) or 0;
                local v810 = math.floor(v809);
                v807[1], v807[2] = v808, tostring(v810):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
                local v811 = {};
                local v812 = u783[5];
                local v813 = tonumber(v.TotalScore or 0) or 0;
                local v814 = math.floor(v813);
                v811[1], v811[2] = v812, tostring(v814):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
                v798[1], v798[2], v798[3], v798[4], v798[5] = v799, v803, v807, v811, { u783[6], string.format("%.1f", v.AvgScore or 0) };

                for _, v2 in v798 do
                    local v815 = {
                        TextSize = 19,
                        Text = v2[2],
                        TextXAlignment = Enum.TextXAlignment.Right,
                        Position = UDim2.fromOffset(v2[1].x, 0),
                        Size = UDim2.new(0, v2[1].w, 1, 0)
                    };
                    local TextLabel7 = Instance.new("TextLabel");
                    TextLabel7.BorderSizePixel = 0;
                    TextLabel7:SetAttribute("SkipTheme", true);
                    TextLabel7.BackgroundTransparency = 1;
                    TextLabel7.FontFace = u232;
                    TextLabel7.TextColor3 = u231.text;
                    TextLabel7.TextSize = 21;
                    TextLabel7.TextXAlignment = Enum.TextXAlignment.Left;
                    TextLabel7.Text = "";

                    for i2, v3 in v815 do
                        TextLabel7[i2] = v3;
                    end;

                    TextLabel7.Parent = Frame3;
                end;

                local v816 = v.WorstBand or "Clean";
                local v817 = u777[v816] or u777.Clean;
                local v818 = {
                    TextSize = 16,
                    BackgroundTransparency = 0.84,
                    Text = tostring(v.WorstScore or 0),
                    FontFace = u233,
                    TextXAlignment = Enum.TextXAlignment.Center
                };
                local v819;

                if v816 == "Near" then
                    v819 = Color3.fromRGB(247, 247, 248) or v817;
                else
                    v819 = v817;
                end;

                v818.TextColor3 = v819;
                v818.BackgroundColor3 = v817;
                v818.AnchorPoint = Vector2.new(0, 0.5);
                v818.Position = UDim2.new(0, 806, 0.5, 0);
                v818.Size = UDim2.fromOffset(64, 28);
                local TextLabel7 = Instance.new("TextLabel");
                TextLabel7.BorderSizePixel = 0;
                TextLabel7:SetAttribute("SkipTheme", true);
                TextLabel7.BackgroundTransparency = 1;
                TextLabel7.FontFace = u232;
                TextLabel7.TextColor3 = u231.text;
                TextLabel7.TextSize = 21;
                TextLabel7.TextXAlignment = Enum.TextXAlignment.Left;
                TextLabel7.Text = "";

                for i2, v2 in v818 do
                    TextLabel7[i2] = v2;
                end;

                TextLabel7.Parent = Frame3;
                local UICorner2 = Instance.new("UICorner");
                UICorner2.CornerRadius = UDim.new(0, 6);
                UICorner2.Parent = TextLabel7;

                if not v791 then
                    local v820 = {
                        Text = "Join",
                        TextSize = 18,
                        BackgroundTransparency = 0.88,
                        ZIndex = 3,
                        FontFace = u233,
                        TextXAlignment = Enum.TextXAlignment.Center,
                        BackgroundColor3 = Color3.fromRGB(208, 217, 251),
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(1, -12, 0.5, 0),
                        Size = UDim2.fromOffset(90, 36)
                    };
                    local TextButton = Instance.new("TextButton");
                    TextButton.BorderSizePixel = 0;
                    TextButton:SetAttribute("SkipTheme", true);
                    TextButton.BackgroundTransparency = 1;
                    TextButton.FontFace = u232;
                    TextButton.TextColor3 = u231.text;
                    TextButton.TextSize = 21;
                    TextButton.TextXAlignment = Enum.TextXAlignment.Left;
                    TextButton.Text = "";
                    TextButton.AutoButtonColor = false;

                    for i2, v2 in v820 do
                        TextButton[i2] = v2;
                    end;

                    TextButton.Parent = Frame3;
                    local UICorner3 = Instance.new("UICorner");
                    UICorner3.CornerRadius = UDim.new(0, 8);
                    UICorner3.Parent = TextButton;
                    game:GetService("CollectionService"):AddTag(TextButton, "UIEffectSoundOnly");
                    TextButton.Activated:Connect(function() -- Line: 4119
                        -- upvalues: Events (ref), u795 (copy), v (copy), LocalPlayer (ref)
                        if Events.PromptConfirmationDialog:Invoke({
                            Title = "Join server",
                            YesText = "Join",
                            NoText = "Cancel",
                            Description = "Teleport to server " .. u795 .. " to moderate it in person?"
                        }) ~= true then
                            return;
                        end;

                        pcall(function() -- Line: 4127
                            -- upvalues: v (ref), LocalPlayer (ref)
                            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.JobId, LocalPlayer);
                        end);
                    end);
                end;
            end;

            if #v784 == 0 then
                local v821 = {
                    Text = "No servers reporting yet. Summaries publish within a minute of server start.",
                    TextColor3 = u231.mut,
                    Position = UDim2.fromOffset(0, 32),
                    Size = UDim2.new(1, 0, 0, 24)
                };
                local TextLabel4 = Instance.new("TextLabel");
                TextLabel4.BorderSizePixel = 0;
                TextLabel4:SetAttribute("SkipTheme", true);
                TextLabel4.BackgroundTransparency = 1;
                TextLabel4.FontFace = u232;
                TextLabel4.TextColor3 = u231.text;
                TextLabel4.TextSize = 21;
                TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
                TextLabel4.Text = "";

                for i, v in v821 do
                    TextLabel4[i] = v;
                end;

                TextLabel4.Parent = Frame;
            end;

            local v822 = math.max(#v784, 1) * 62 + 32;
            Frame.Size = UDim2.new(1, 0, 0, v822);
            body.CanvasSize = UDim2.new(0, 0, 0, v822 + 96 + 20);
        end;

        local v823 = {
            BackgroundTransparency = 0,
            ZIndex = 5,
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.fromOffset(1052, 40),
            Size = UDim2.fromOffset(280, 48),
            BackgroundColor3 = u231.track
        };
        local TextButton = Instance.new("TextButton");
        TextButton.BorderSizePixel = 0;
        TextButton:SetAttribute("SkipTheme", true);
        TextButton.BackgroundTransparency = 1;
        TextButton.FontFace = u232;
        TextButton.TextColor3 = u231.text;
        TextButton.TextSize = 21;
        TextButton.TextXAlignment = Enum.TextXAlignment.Left;
        TextButton.Text = "";
        TextButton.AutoButtonColor = false;

        for i, v in v823 do
            TextButton[i] = v;
        end;

        TextButton.Parent = body;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(0, 8);
        UICorner.Parent = TextButton;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = Color3.fromRGB(49, 51, 57);
        UIStroke.Thickness = 1;
        UIStroke.Parent = TextButton;
        local v824 = {
            TextSize = 22,
            ZIndex = 6,
            Text = "Sort: " .. u781[u782].label,
            Position = UDim2.fromOffset(18, 0),
            Size = UDim2.new(1, -52, 1, 0)
        };
        local TextLabel3 = Instance.new("TextLabel");
        TextLabel3.BorderSizePixel = 0;
        TextLabel3:SetAttribute("SkipTheme", true);
        TextLabel3.BackgroundTransparency = 1;
        TextLabel3.FontFace = u232;
        TextLabel3.TextColor3 = u231.text;
        TextLabel3.TextSize = 21;
        TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel3.Text = "";

        for i, v in v824 do
            TextLabel3[i] = v;
        end;

        TextLabel3.Parent = TextButton;
        local v825 = {
            Text = "▼",
            TextSize = 14,
            ZIndex = 6,
            TextColor3 = u231.mut,
            TextXAlignment = Enum.TextXAlignment.Center,
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -12, 0, 0),
            Size = UDim2.fromOffset(20, 48)
        };
        local TextLabel4 = Instance.new("TextLabel");
        TextLabel4.BorderSizePixel = 0;
        TextLabel4:SetAttribute("SkipTheme", true);
        TextLabel4.BackgroundTransparency = 1;
        TextLabel4.FontFace = u232;
        TextLabel4.TextColor3 = u231.text;
        TextLabel4.TextSize = 21;
        TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel4.Text = "";

        for i, v in v825 do
            TextLabel4[i] = v;
        end;

        TextLabel4.Parent = TextButton;
        game:GetService("CollectionService"):AddTag(TextButton, "UIEffectSoundOnly");
        local v826 = {
            BackgroundTransparency = 0,
            Visible = false,
            ZIndex = 10,
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.fromOffset(1052, 92),
            Size = UDim2.fromOffset(280, #u781 * 48 + 12),
            BackgroundColor3 = u231.track
        };
        local Frame2 = Instance.new("Frame");
        Frame2.BorderSizePixel = 0;
        Frame2:SetAttribute("SkipTheme", true);
        Frame2.BackgroundColor3 = u231.text;

        for i, v in v826 do
            Frame2[i] = v;
        end;

        Frame2.Parent = body;
        local UICorner2 = Instance.new("UICorner");
        UICorner2.CornerRadius = UDim.new(0, 8);
        UICorner2.Parent = Frame2;
        local UIStroke2 = Instance.new("UIStroke");
        UIStroke2.Color = Color3.fromRGB(49, 51, 57);
        UIStroke2.Thickness = 1;
        UIStroke2.Parent = Frame2;
        local u827 = nil;

        local function closeMenu() -- Line: 4196
            -- upvalues: Frame2 (copy), u827 (ref)
            Frame2.Visible = false;

            if u827 then
                u827:Disconnect();
                u827 = nil;
            end;
        end;

        for i, v in u781 do
            local v828 = {
                BackgroundTransparency = 1,
                ZIndex = 11,
                Position = UDim2.fromOffset(6, 6 + (i - 1) * 48),
                Size = UDim2.fromOffset(268, 48),
                BackgroundColor3 = Color3.fromRGB(208, 217, 251)
            };
            local TextButton2 = Instance.new("TextButton");
            TextButton2.BorderSizePixel = 0;
            TextButton2:SetAttribute("SkipTheme", true);
            TextButton2.BackgroundTransparency = 1;
            TextButton2.FontFace = u232;
            TextButton2.TextColor3 = u231.text;
            TextButton2.TextSize = 21;
            TextButton2.TextXAlignment = Enum.TextXAlignment.Left;
            TextButton2.Text = "";
            TextButton2.AutoButtonColor = false;

            for i2, v2 in v828 do
                TextButton2[i2] = v2;
            end;

            TextButton2.Parent = Frame2;
            local UICorner3 = Instance.new("UICorner");
            UICorner3.CornerRadius = UDim.new(0, 6);
            UICorner3.Parent = TextButton2;
            local v829 = {
                TextSize = 22,
                ZIndex = 12,
                Text = v.label,
                Position = UDim2.fromOffset(14, 0),
                Size = UDim2.new(1, -14, 1, 0)
            };
            local TextLabel5 = Instance.new("TextLabel");
            TextLabel5.BorderSizePixel = 0;
            TextLabel5:SetAttribute("SkipTheme", true);
            TextLabel5.BackgroundTransparency = 1;
            TextLabel5.FontFace = u232;
            TextLabel5.TextColor3 = u231.text;
            TextLabel5.TextSize = 21;
            TextLabel5.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel5.Text = "";

            for i2, v2 in v829 do
                TextLabel5[i2] = v2;
            end;

            TextLabel5.Parent = TextButton2;
            TextButton2.MouseEnter:Connect(function() -- Line: 4221
                -- upvalues: TextButton2 (copy)
                TextButton2.BackgroundTransparency = 0.88;
            end);
            TextButton2.MouseLeave:Connect(function() -- Line: 4224
                -- upvalues: TextButton2 (copy)
                TextButton2.BackgroundTransparency = 1;
            end);
            TextButton2.Activated:Connect(function() -- Line: 4227
                -- upvalues: u782 (ref), i (copy), TextLabel3 (copy), v (copy), Frame2 (copy), u827 (ref), renderList (copy)
                u782 = i;
                TextLabel3.Text = "Sort: " .. v.label;
                Frame2.Visible = false;

                if u827 then
                    u827:Disconnect();
                    u827 = nil;
                end;

                renderList();
            end);
        end;

        TextButton.Activated:Connect(function() -- Line: 4234
            -- upvalues: Frame2 (copy), u827 (ref), OutsideClickDetector (ref), closeMenu (copy), TextButton (copy)
            if Frame2.Visible then
                Frame2.Visible = false;

                if u827 then
                    u827:Disconnect();
                    u827 = nil;
                end;
            else
                Frame2.Visible = true;
                u827 = OutsideClickDetector({ Frame2 }, closeMenu, {
                    include = { TextButton }
                });
            end;
        end);
        task.spawn(function() -- Line: 4242
            -- upvalues: u219 (ref), u778 (copy), generation (copy), Remotes (ref), u780 (ref), dashHideSkeletons (ref), body (copy), TextLabel2 (ref), renderList (copy)
            while u219.serverToken == u778 and generation == u219.generation do
                local success, result = pcall(function() -- Line: 4244
                    -- upvalues: Remotes (ref)
                    return { Remotes.CommunityOutfitsAction:InvokeServer("GetServerOverview") };
                end);

                if u219.serverToken ~= u778 or generation ~= u219.generation then
                    break;
                end;

                local v830;

                if success then
                    v830 = result[1];
                else
                    v830 = success;
                end;

                if success then
                    success = result[2];
                end;

                if v830 and typeof(success) == "table" then
                    u780 = success;
                    dashHideSkeletons(body);

                    if TextLabel2 and TextLabel2.Parent then
                        TextLabel2:Destroy();
                        TextLabel2 = nil;
                    end;

                    renderList();
                elseif TextLabel2 and TextLabel2.Parent then
                    dashHideSkeletons(body);
                    TextLabel2.Text = "Couldn\'t load the server overview.";
                end;

                task.wait(30);
            end;
        end);

        return;
    end;

    local dashboard2 = mainSection:FindFirstChild("dashboard");

    if dashboard2 then
        dashCloseInspect();
        dashServerCleanup();
        dashboard2.home.Visible = false;
        dashboard2.detail.Visible = true;
        dashboard2.detail.body.CanvasPosition = Vector2.zero;
        dashboard2.detail.crumbs.Text = "<font color=\"#B8B9BF\">Dashboard  /  </font>Automated detection";
    end;

    u219.backTo = nil;
    local v831 = {
        Text = "Automated detection impact, last " .. (p589.WindowDays or 28) .. " days.",
        TextColor3 = u231.mut,
        Size = UDim2.new(1, 0, 0, 24)
    };
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BorderSizePixel = 0;
    TextLabel:SetAttribute("SkipTheme", true);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = u232;
    TextLabel.TextColor3 = u231.text;
    TextLabel.TextSize = 21;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Text = "";

    for i, v in v831 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = body;
    local Detection = p589.Detection;

    if not Detection then
        local v832 = {
            Text = "No detection data available.",
            TextColor3 = u231.mut,
            Position = UDim2.fromOffset(0, 60),
            Size = UDim2.new(1, 0, 0, 24)
        };
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.BorderSizePixel = 0;
        TextLabel2:SetAttribute("SkipTheme", true);
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.FontFace = u232;
        TextLabel2.TextColor3 = u231.text;
        TextLabel2.TextSize = 21;
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel2.Text = "";

        for i, v in v832 do
            TextLabel2[i] = v;
        end;

        TextLabel2.Parent = body;
        body.CanvasSize = UDim2.new(0, 0, 0, 160);

        return;
    end;

    local v833 = Detection.totals or {};
    local u834 = Detection.days or (p589.WindowDays or 28);
    local u835 = 48;

    local function mkCap(p836) -- Line: 3385
        -- upvalues: u231 (ref), u835 (ref), body (copy), u232 (ref)
        local v837 = {
            TextSize = 18,
            Text = p836,
            TextColor3 = u231.mut,
            Position = UDim2.fromOffset(0, u835),
            Size = UDim2.fromOffset(600, 22)
        };
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.BorderSizePixel = 0;
        TextLabel2:SetAttribute("SkipTheme", true);
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.FontFace = u232;
        TextLabel2.TextColor3 = u231.text;
        TextLabel2.TextSize = 21;
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel2.Text = "";

        for i, v in v837 do
            TextLabel2[i] = v;
        end;

        TextLabel2.Parent = body;
    end;

    local function mkStatTile(p838, p839, p840, p841, p842) -- Line: 3394
        -- upvalues: u231 (ref), u835 (ref), body (copy), u232 (ref), u234 (ref)
        local v843 = {
            BackgroundColor3 = u231.track,
            Position = UDim2.fromOffset(p838, u835),
            Size = UDim2.fromOffset(p839, 104)
        };
        local Frame = Instance.new("Frame");
        Frame.BorderSizePixel = 0;
        Frame:SetAttribute("SkipTheme", true);
        Frame.BackgroundColor3 = u231.text;

        for i, v in v843 do
            Frame[i] = v;
        end;

        Frame.Parent = body;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(0, 12);
        UICorner.Parent = Frame;
        local v844 = {
            TextSize = 18,
            Text = p840,
            TextColor3 = u231.mut,
            Position = UDim2.fromOffset(16, 12),
            Size = UDim2.fromOffset(p839 - 32, 20)
        };
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.BorderSizePixel = 0;
        TextLabel2:SetAttribute("SkipTheme", true);
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.FontFace = u232;
        TextLabel2.TextColor3 = u231.text;
        TextLabel2.TextSize = 21;
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel2.Text = "";

        for i, v in v844 do
            TextLabel2[i] = v;
        end;

        TextLabel2.Parent = Frame;
        local v845 = {
            TextSize = 26,
            Text = p841,
            FontFace = u234,
            Position = UDim2.fromOffset(16, 38),
            Size = UDim2.fromOffset(p839 - 32, 32)
        };
        local TextLabel3 = Instance.new("TextLabel");
        TextLabel3.BorderSizePixel = 0;
        TextLabel3:SetAttribute("SkipTheme", true);
        TextLabel3.BackgroundTransparency = 1;
        TextLabel3.FontFace = u232;
        TextLabel3.TextColor3 = u231.text;
        TextLabel3.TextSize = 21;
        TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel3.Text = "";

        for i, v in v845 do
            TextLabel3[i] = v;
        end;

        TextLabel3.Parent = Frame;

        if p842 then
            local v846 = {
                TextSize = 15,
                Text = p842,
                TextColor3 = u231.mut,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Position = UDim2.fromOffset(16, 74),
                Size = UDim2.fromOffset(p839 - 32, 20)
            };
            local TextLabel4 = Instance.new("TextLabel");
            TextLabel4.BorderSizePixel = 0;
            TextLabel4:SetAttribute("SkipTheme", true);
            TextLabel4.BackgroundTransparency = 1;
            TextLabel4.FontFace = u232;
            TextLabel4.TextColor3 = u231.text;
            TextLabel4.TextSize = 21;
            TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel4.Text = "";

            for i, v in v846 do
                TextLabel4[i] = v;
            end;

            TextLabel4.Parent = Frame;
        end;
    end;

    local v847 = tonumber(Detection.uniqueAffected or 0) or 0;
    local v848 = math.floor(v847);
    local v849 = tostring(v848):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    local v850 = nil;
    local v851 = "no daily player data yet";
    local v852 = "Players affected (28d)";

    for i = u834, 1, -1 do
        if ((Detection.dauByDay or {})[i] or 0) > 0 and ((Detection.affectedByDay or {})[i] or 0) > 0 then
            v850 = i;
            break;
        end;
    end;

    if v850 then
        local v853 = Detection.affectedByDay[v850];
        local v854 = Detection.dauByDay[v850];
        local v855 = (Detection.generatedAt or os.time()) - (u834 - v850) * 86400;

        if v850 == u834 then
            local format = string.format;
            local v856 = tonumber(v854) or 0;
            local v857 = math.floor(v856);
            v851 = format("%.1f%% of %s players so far", v853 / v854 * 100, (tostring(v857):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")));
            v852 = "Players affected (today)";
        else
            v852 = "Players affected (" .. os.date("%b %d", v855) .. ")";
            local format = string.format;
            local v858 = tonumber(v854) or 0;
            local v859 = math.floor(v858);
            v851 = format("%.1f%% of %s daily players", v853 / v854 * 100, (tostring(v859):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")));
        end;
    end;

    local u860 = Detection.affectedTiers or {};
    local v861 = u860.Reset and (u860.Reset.unique or 0) or 0;
    local v862 = u860.Hide and (u860.Hide.unique or 0) or 0;
    local v863 = u860.PublishReject and (u860.PublishReject.unique or 0) or 0;
    local v864 = {};
    local v865 = {};
    local v866 = tonumber(v861) or 0;
    local v867 = math.floor(v866);
    local v868 = tostring(v867):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    local v869 = tonumber(v862) or 0;
    local v870 = math.floor(v869);
    local v871 = v868 .. " / " .. tostring(v870):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    local v872 = tonumber(v863) or 0;
    local v873 = math.floor(v872);
    v865[1], v865[2], v865[3] = "Reset / hidden (28d)", v871, "unique players; " .. tostring(v873):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. " publish rejected";
    local v874 = {};
    local v875 = tonumber(#(Detection.repeatOffenders or {})) or 0;
    local v876 = math.floor(v875);
    v874[1], v874[2], v874[3] = "Repeat offenders", tostring(v876):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""), "players with 2+ events";
    local v877 = {};
    local v878 = tonumber(v833.Unhide or 0) or 0;
    local v879 = math.floor(v878);
    local v880 = tostring(v879):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    local v881 = tonumber(v833.Hide or 0) or 0;
    local v882 = math.floor(v881);
    v877[1], v877[2], v877[3] = "Hides later cleared", v880, "of " .. tostring(v882):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. " silent hides";
    local v883 = {};
    local v884 = tonumber(v833.NearMiss or 0) or 0;
    local v885 = math.floor(v884);
    v883[1], v883[2], v883[3] = "Near-misses", tostring(v885):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""), "observed, no action taken";
    v864[1], v864[2], v864[3], v864[4], v864[5] = { v852, v849, v851 }, v865, v874, v877, v883;

    for i, v in v864 do
        mkStatTile((i - 1) * 213, 199, v[1], v[2], v[3]);
    end;

    u835 = u835 + 128;
    mkCap("Players affected per day");
    local v886 = {};

    local function tierByDay(p887) -- Line: 3475
        -- upvalues: u860 (copy), u834 (copy)
        local v888 = u860[p887];
        local v889 = table.create(u834, 0);

        for i = 1, u834 do
            v889[i] = v888 and v888.byDay and (v888.byDay[i] or 0) or 0;
        end;

        return v889;
    end;

    for i = 1, u834 do
        v886[i] = (Detection.affectedByDay or {})[i] or 0;
    end;

    local v890 = {
        {
            Label = "Total affected",
            Days = v886,
            Color = Color3.fromRGB(60, 100, 250)
        },
        {
            Label = "Reset",
            Days = tierByDay("Reset"),
            Color = Color3.fromRGB(244, 91, 82)
        },
        {
            Label = "Hidden",
            Days = tierByDay("Hide"),
            Color = Color3.fromRGB(240, 185, 60)
        },
        {
            Label = "Publish rejected",
            Days = tierByDay("PublishReject"),
            Color = Color3.fromRGB(179, 132, 251)
        }
    };
    local v891 = {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, u835 + 30),
        Size = UDim2.fromOffset(1052, 170)
    };
    local Frame = Instance.new("Frame");
    Frame.BorderSizePixel = 0;
    Frame:SetAttribute("SkipTheme", true);
    Frame.BackgroundColor3 = u231.text;

    for i, v in v891 do
        Frame[i] = v;
    end;

    Frame.Parent = body;
    dashLineChart(Frame, 1052, 170, v890, u834);
    local v892 = {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, u835 + 206),
        Size = UDim2.fromOffset(1052, 20)
    };
    local Frame2 = Instance.new("Frame");
    Frame2.BorderSizePixel = 0;
    Frame2:SetAttribute("SkipTheme", true);
    Frame2.BackgroundColor3 = u231.text;

    for i, v in v892 do
        Frame2[i] = v;
    end;

    Frame2.Parent = body;
    dashLineAxis(Frame2, 1052, p589);
    local v893 = {
        Detection.uniqueAffected or 0,
        v861,
        v862,
        v863
    };
    local v894 = 0;

    for i, v in v890 do
        local Label = v.Label;
        local v895 = tonumber(v893[i] or 0) or 0;
        local v896 = math.floor(v895);
        local v897 = Label .. "  " .. tostring(v896):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
        local v898 = {
            BackgroundColor3 = v.Color,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.fromOffset(v894, u835 + 240),
            Size = UDim2.fromOffset(10, 10)
        };
        local Frame3 = Instance.new("Frame");
        Frame3.BorderSizePixel = 0;
        Frame3:SetAttribute("SkipTheme", true);
        Frame3.BackgroundColor3 = u231.text;

        for i2, v2 in v898 do
            Frame3[i2] = v2;
        end;

        Frame3.Parent = body;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(1, 0);
        UICorner.Parent = Frame3;
        local v899 = {
            TextSize = 16,
            Text = v897,
            TextColor3 = u231.mut2,
            Position = UDim2.fromOffset(v894 + 17, u835 + 230),
            Size = UDim2.fromOffset(260, 20)
        };
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.BorderSizePixel = 0;
        TextLabel2:SetAttribute("SkipTheme", true);
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.FontFace = u232;
        TextLabel2.TextColor3 = u231.text;
        TextLabel2.TextSize = 21;
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel2.Text = "";

        for i2, v2 in v899 do
            TextLabel2[i2] = v2;
        end;

        TextLabel2.Parent = body;
        v894 = v894 + (17 + #v897 * 8 + 28);
    end;

    u835 = u835 + 274;
    mkCap("Share of daily players affected");
    local v900 = false;

    for i = 1, u834 do
        if ((Detection.dauByDay or {})[i] or 0) > 0 then
            v900 = true;
            break;
        end;
    end;

    if v900 then
        local function toPct(p901) -- Line: 3538
            -- upvalues: u834 (copy), Detection (copy)
            local v902 = table.create(u834, 0);

            for i = 1, u834 do
                local v903 = (Detection.dauByDay or {})[i] or 0;

                if v903 > 0 then
                    v902[i] = (p901[i] or 0) / v903 * 100;
                end;
            end;

            return v902;
        end;

        local v904 = {};

        for _, v in v890 do
            local v905 = {
                Days = toPct(v.Days),
                Color = v.Color,
                Label = v.Label
            };
            table.insert(v904, v905);
        end;

        local v906 = {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(0, u835 + 30),
            Size = UDim2.fromOffset(1052, 170)
        };
        local Frame3 = Instance.new("Frame");
        Frame3.BorderSizePixel = 0;
        Frame3:SetAttribute("SkipTheme", true);
        Frame3.BackgroundColor3 = u231.text;

        for i, v in v906 do
            Frame3[i] = v;
        end;

        Frame3.Parent = body;
        dashLineChart(Frame3, 1052, 170, v904, u834, {
            percent = true
        });
        local v907 = {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(0, u835 + 206),
            Size = UDim2.fromOffset(1052, 20)
        };
        local Frame4 = Instance.new("Frame");
        Frame4.BorderSizePixel = 0;
        Frame4:SetAttribute("SkipTheme", true);
        Frame4.BackgroundColor3 = u231.text;

        for i, v in v907 do
            Frame4[i] = v;
        end;

        Frame4.Parent = body;
        dashLineAxis(Frame4, 1052, p589);
        u835 = u835 + 250;
    else
        local v908 = {
            Text = "No daily-player data yet. This chart fills in once updated servers report player counts.",
            TextColor3 = u231.mut,
            Position = UDim2.fromOffset(0, u835 + 30),
            Size = UDim2.new(1, 0, 0, 24)
        };
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.BorderSizePixel = 0;
        TextLabel2:SetAttribute("SkipTheme", true);
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.FontFace = u232;
        TextLabel2.TextColor3 = u231.text;
        TextLabel2.TextSize = 21;
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel2.Text = "";

        for i, v in v908 do
            TextLabel2[i] = v;
        end;

        TextLabel2.Parent = body;
        u835 = u835 + 78;
    end;

    mkCap("Daily incidents by type");
    local v909 = {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, u835 + 30),
        Size = UDim2.fromOffset(1052, 200)
    };
    local Frame3 = Instance.new("Frame");
    Frame3.BorderSizePixel = 0;
    Frame3:SetAttribute("SkipTheme", true);
    Frame3.BackgroundColor3 = u231.text;

    for i, v in v909 do
        Frame3[i] = v;
    end;

    Frame3.Parent = body;
    local v910 = {};

    for _, v in u523 do
        table.insert(v910, {
            Days = Detection.series and (Detection.series[v.key] or {}) or {},
            Color = v.color,
            Label = v.label
        });
    end;

    dashLineChart(Frame3, 1052, 200, v910, u834);
    local v911 = {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, u835 + 236),
        Size = UDim2.fromOffset(1052, 20)
    };
    local Frame4 = Instance.new("Frame");
    Frame4.BorderSizePixel = 0;
    Frame4:SetAttribute("SkipTheme", true);
    Frame4.BackgroundColor3 = u231.text;

    for i, v in v911 do
        Frame4[i] = v;
    end;

    Frame4.Parent = body;
    dashLineAxis(Frame4, 1052, p589);
    local v912 = 0;

    for _, v in u523 do
        local label = v.label;
        local v913 = tonumber(Detection.totals and (Detection.totals[v.key] or 0) or 0) or 0;
        local v914 = math.floor(v913);
        local v915 = label .. "  " .. tostring(v914):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
        local v916 = {
            BackgroundColor3 = v.color,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.fromOffset(v912, u835 + 270),
            Size = UDim2.fromOffset(10, 10)
        };
        local Frame5 = Instance.new("Frame");
        Frame5.BorderSizePixel = 0;
        Frame5:SetAttribute("SkipTheme", true);
        Frame5.BackgroundColor3 = u231.text;

        for i, v2 in v916 do
            Frame5[i] = v2;
        end;

        Frame5.Parent = body;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(1, 0);
        UICorner.Parent = Frame5;
        local v917 = {
            TextSize = 16,
            Text = v915,
            TextColor3 = u231.mut2,
            Position = UDim2.fromOffset(v912 + 17, u835 + 260),
            Size = UDim2.fromOffset(260, 20)
        };
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.BorderSizePixel = 0;
        TextLabel2:SetAttribute("SkipTheme", true);
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.FontFace = u232;
        TextLabel2.TextColor3 = u231.text;
        TextLabel2.TextSize = 21;
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel2.Text = "";

        for i, v2 in v917 do
            TextLabel2[i] = v2;
        end;

        TextLabel2.Parent = body;
        v912 = v912 + (17 + #v915 * 8 + 28);
    end;

    u835 = u835 + 296;
    mkCap("Score distribution (5-point buckets, all scored events)");
    local u918 = Detection.scoreHists or {};
    local v919 = {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, u835 + 30),
        Size = UDim2.fromOffset(1052, 218)
    };
    local Frame5 = Instance.new("Frame");
    Frame5.BorderSizePixel = 0;
    Frame5:SetAttribute("SkipTheme", true);
    Frame5.BackgroundColor3 = u231.text;
    local u920 = { {
            key = "today",
            label = "Today"
        }, {
            key = "d7",
            label = "Last 7 days"
        }, {
            key = "d28",
            label = "Last 28 days"
        }, {
            key = "all",
            label = "All time"
        } };
    local u921 = 3;

    for i, v in v919 do
        Frame5[i] = v;
    end;

    Frame5.Parent = body;
    local v922 = Detection.Config or {};
    local u923 = tonumber(v922.HIDE_THRESHOLD) or 75;
    local u924 = tonumber(v922.RESET_THRESHOLD) or 110;
    local v925 = math.ceil(u924 * 1.4 / 25) * 25;
    local u926 = math.clamp(v925, 100, 200);
    local u927 = u926 / 5 + 1;
    local u928 = 1052 / u927;

    local function renderHist() -- Line: 3640
        -- upvalues: Frame5 (copy), u918 (copy), u920 (copy), u921 (ref), Detection (copy), u927 (copy), dashHoverCard (ref), u924 (copy), u923 (copy), u928 (copy), u232 (ref), u231 (ref), u926 (copy)
        for _, child in Frame5:GetChildren() do
            child:Destroy();
        end;

        local v929 = u918[u920[u921].key] or Detection.scoreHist or {};
        local u930 = table.create(u927, 0);

        for i = 1, 41 do
            local v931 = math.min(i, u927);
            u930[v931] = (u930[v931] or 0) + (v929[i] or 0);
        end;

        local v932 = 1;
        local v933 = 0;

        for _, v in u930 do
            v932 = math.max(v932, v);
            v933 = v933 + v;
        end;

        local u934 = dashHoverCard(Frame5);

        for i = 0, u927 - 1 do
            local v935 = u930[i + 1] or 0;
            local v936 = i * 5;
            local v937 = u924 <= v936 and Color3.fromRGB(244, 91, 82) or (u923 <= v936 and Color3.fromRGB(240, 185, 60) or Color3.fromRGB(184, 185, 191));
            local v938 = {
                Position = UDim2.fromOffset(math.floor(i * u928), 0),
                Size = UDim2.fromOffset(math.ceil(u928), 190)
            };
            local TextButton = Instance.new("TextButton");
            TextButton.BorderSizePixel = 0;
            TextButton:SetAttribute("SkipTheme", true);
            TextButton.BackgroundTransparency = 1;
            TextButton.FontFace = u232;
            TextButton.TextColor3 = u231.text;
            TextButton.TextSize = 21;
            TextButton.TextXAlignment = Enum.TextXAlignment.Left;
            TextButton.Text = "";
            TextButton.AutoButtonColor = false;

            for i2, v in v938 do
                TextButton[i2] = v;
            end;

            TextButton.Parent = Frame5;
            local v939 = {
                BackgroundColor3 = v935 > 0 and v937 and v937 or u231.track,
                AnchorPoint = Vector2.new(0.5, 1),
                Position = UDim2.new(0.5, 0, 1, 0)
            };
            local fromOffset = UDim2.fromOffset;
            local v940 = math.floor(u928) - 6;
            local v941 = math.max(v940, 3);
            local v942;

            if v935 > 0 then
                local v943 = math.floor(190 * v935 / v932);
                v942 = math.max(v943, 3) or 2;
            else
                v942 = 2;
            end;

            v939.Size = fromOffset(v941, v942);
            local Frame6 = Instance.new("Frame");
            Frame6.BorderSizePixel = 0;
            Frame6:SetAttribute("SkipTheme", true);
            Frame6.BackgroundColor3 = u231.text;

            for i2, v in v939 do
                Frame6[i2] = v;
            end;

            Frame6.Parent = TextButton;
        end;

        local v944 = {
            ZIndex = 24,
            Size = UDim2.new(1, 0, 0, 190)
        };
        local TextButton = Instance.new("TextButton");
        TextButton.BorderSizePixel = 0;
        TextButton:SetAttribute("SkipTheme", true);
        TextButton.BackgroundTransparency = 1;
        TextButton.FontFace = u232;
        TextButton.TextColor3 = u231.text;
        TextButton.TextSize = 21;
        TextButton.TextXAlignment = Enum.TextXAlignment.Left;
        TextButton.Text = "";
        TextButton.AutoButtonColor = false;

        for i, v in v944 do
            TextButton[i] = v;
        end;

        TextButton.Parent = Frame5;
        TextButton.MouseMoved:Connect(function(p945) -- Line: 3679
            -- upvalues: TextButton (copy), u927 (ref), u930 (copy), u924 (ref), u923 (ref), u926 (ref), u934 (copy), u928 (ref)
            local v946 = (p945 - TextButton.AbsolutePosition.X) / math.max(TextButton.AbsoluteSize.X, 1) * u927;
            local v947 = math.floor(v946);
            local v948 = math.clamp(v947, 0, u927 - 1);
            local v949 = u930[v948 + 1] or 0;
            local v950 = v948 * 5;
            local v951 = u924 <= v950 and Color3.fromRGB(244, 91, 82) or (u923 <= v950 and Color3.fromRGB(240, 185, 60) or Color3.fromRGB(184, 185, 191));
            local show = u934.show;
            local v952 = math.floor(v948 * u928) + u928 / 2;
            local v953 = {};
            local v954 = {
                label = "events",
                color = v951
            };
            local v955 = tonumber(v949) or 0;
            local v956 = math.floor(v955);
            v954.value = tostring(v956):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
            v953[1] = v954;
            show(0, v952, "Score " .. (u927 - 1 <= v948 and u926 .. "+" or v950 .. " - " .. v950 + 4), v953, math.floor(u927 * 0.6) < v948);
        end);
        TextButton.MouseLeave:Connect(u934.hide);

        for _, v in {
            { u923, "Hide " .. u923, Color3.fromRGB(240, 185, 60) },
            { u924, "Reset " .. u924, Color3.fromRGB(244, 91, 82) }
        } do
            local v957 = math.clamp(v[1] / 5, 0, u927) * u928;
            local v958 = math.floor(v957);
            local v959 = {
                BackgroundTransparency = 0.35,
                ZIndex = 2,
                BackgroundColor3 = v[3],
                Position = UDim2.fromOffset(v958, 0),
                Size = UDim2.fromOffset(2, 190)
            };
            local Frame6 = Instance.new("Frame");
            Frame6.BorderSizePixel = 0;
            Frame6:SetAttribute("SkipTheme", true);
            Frame6.BackgroundColor3 = u231.text;

            for i, v2 in v959 do
                Frame6[i] = v2;
            end;

            Frame6.Parent = Frame5;
            local v960 = v958 > 932;
            local v961 = {
                TextSize = 15,
                ZIndex = 2,
                Text = v[2],
                TextColor3 = v[3],
                TextXAlignment = v960 and Enum.TextXAlignment.Right or Enum.TextXAlignment.Left,
                AnchorPoint = v960 and Vector2.new(1, 0) or Vector2.new(0, 0),
                Position = UDim2.fromOffset(v960 and v958 - 6 or v958 + 6, 0),
                Size = UDim2.fromOffset(110, 18)
            };
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.BorderSizePixel = 0;
            TextLabel2:SetAttribute("SkipTheme", true);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.FontFace = u232;
            TextLabel2.TextColor3 = u231.text;
            TextLabel2.TextSize = 21;
            TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel2.Text = "";

            for i, v2 in v961 do
                TextLabel2[i] = v2;
            end;

            TextLabel2.Parent = Frame5;
        end;

        for i = 0, u926, 25 do
            local v962 = {
                TextSize = 16,
                Text = tostring(i) .. (i == u926 and "+" or ""),
                TextColor3 = u231.mut,
                TextXAlignment = Enum.TextXAlignment.Center,
                AnchorPoint = Vector2.new(0.5, 0),
                Position = UDim2.fromOffset(i / 5 * u928 + u928 / 2, 198),
                Size = UDim2.fromOffset(50, 18)
            };
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.BorderSizePixel = 0;
            TextLabel2:SetAttribute("SkipTheme", true);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.FontFace = u232;
            TextLabel2.TextColor3 = u231.text;
            TextLabel2.TextSize = 21;
            TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel2.Text = "";

            for i2, v in v962 do
                TextLabel2[i2] = v;
            end;

            TextLabel2.Parent = Frame5;
        end;

        if v933 == 0 then
            local v963 = {
                Text = "No scored events in this range.",
                ZIndex = 3,
                TextColor3 = u231.mut,
                TextXAlignment = Enum.TextXAlignment.Center,
                Position = UDim2.new(0, 0, 0, 83),
                Size = UDim2.new(1, 0, 0, 24)
            };
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.BorderSizePixel = 0;
            TextLabel2:SetAttribute("SkipTheme", true);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.FontFace = u232;
            TextLabel2.TextColor3 = u231.text;
            TextLabel2.TextSize = 21;
            TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel2.Text = "";

            for i, v in v963 do
                TextLabel2[i] = v;
            end;

            TextLabel2.Parent = Frame5;
        end;
    end;

    renderHist();
    local v964 = {
        BackgroundTransparency = 0,
        ZIndex = 5,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.fromOffset(1052, u835 - 8),
        Size = UDim2.fromOffset(200, 36),
        BackgroundColor3 = u231.track
    };
    local TextButton = Instance.new("TextButton");
    TextButton.BorderSizePixel = 0;
    TextButton:SetAttribute("SkipTheme", true);
    TextButton.BackgroundTransparency = 1;
    TextButton.FontFace = u232;
    TextButton.TextColor3 = u231.text;
    TextButton.TextSize = 21;
    TextButton.TextXAlignment = Enum.TextXAlignment.Left;
    TextButton.Text = "";
    TextButton.AutoButtonColor = false;

    for i, v in v964 do
        TextButton[i] = v;
    end;

    TextButton.Parent = body;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 8);
    UICorner.Parent = TextButton;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(49, 51, 57);
    UIStroke.Thickness = 1;
    UIStroke.Parent = TextButton;
    local v965 = {
        TextSize = 18,
        ZIndex = 6,
        Text = u920[u921].label,
        Position = UDim2.fromOffset(14, 0),
        Size = UDim2.new(1, -44, 1, 0)
    };
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.BorderSizePixel = 0;
    TextLabel2:SetAttribute("SkipTheme", true);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = u232;
    TextLabel2.TextColor3 = u231.text;
    TextLabel2.TextSize = 21;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.Text = "";

    for i, v in v965 do
        TextLabel2[i] = v;
    end;

    TextLabel2.Parent = TextButton;
    local v966 = {
        Text = "▼",
        TextSize = 12,
        ZIndex = 6,
        TextColor3 = u231.mut,
        TextXAlignment = Enum.TextXAlignment.Center,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -8, 0, 0),
        Size = UDim2.fromOffset(20, 36)
    };
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.BorderSizePixel = 0;
    TextLabel3:SetAttribute("SkipTheme", true);
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = u232;
    TextLabel3.TextColor3 = u231.text;
    TextLabel3.TextSize = 21;
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel3.Text = "";

    for i, v in v966 do
        TextLabel3[i] = v;
    end;

    TextLabel3.Parent = TextButton;
    game:GetService("CollectionService"):AddTag(TextButton, "UIEffectSoundOnly");
    local v967 = {
        BackgroundTransparency = 0,
        Visible = false,
        ZIndex = 10,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.fromOffset(1052, u835 + 32),
        Size = UDim2.fromOffset(200, #u920 * 40 + 12),
        BackgroundColor3 = u231.track
    };
    local Frame6 = Instance.new("Frame");
    Frame6.BorderSizePixel = 0;
    Frame6:SetAttribute("SkipTheme", true);
    Frame6.BackgroundColor3 = u231.text;

    for i, v in v967 do
        Frame6[i] = v;
    end;

    Frame6.Parent = body;
    local UICorner2 = Instance.new("UICorner");
    UICorner2.CornerRadius = UDim.new(0, 8);
    UICorner2.Parent = Frame6;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Color = Color3.fromRGB(49, 51, 57);
    UIStroke2.Thickness = 1;
    UIStroke2.Parent = Frame6;
    local u968 = nil;

    local function closeHistMenu() -- Line: 3791
        -- upvalues: Frame6 (copy), u968 (ref)
        Frame6.Visible = false;

        if u968 then
            u968:Disconnect();
            u968 = nil;
        end;
    end;

    for i, v in u920 do
        local v969 = {
            BackgroundTransparency = 1,
            ZIndex = 11,
            Position = UDim2.fromOffset(6, 6 + (i - 1) * 40),
            Size = UDim2.fromOffset(188, 40),
            BackgroundColor3 = Color3.fromRGB(208, 217, 251)
        };
        local TextButton2 = Instance.new("TextButton");
        TextButton2.BorderSizePixel = 0;
        TextButton2:SetAttribute("SkipTheme", true);
        TextButton2.BackgroundTransparency = 1;
        TextButton2.FontFace = u232;
        TextButton2.TextColor3 = u231.text;
        TextButton2.TextSize = 21;
        TextButton2.TextXAlignment = Enum.TextXAlignment.Left;
        TextButton2.Text = "";
        TextButton2.AutoButtonColor = false;

        for i2, v2 in v969 do
            TextButton2[i2] = v2;
        end;

        TextButton2.Parent = Frame6;
        local UICorner3 = Instance.new("UICorner");
        UICorner3.CornerRadius = UDim.new(0, 6);
        UICorner3.Parent = TextButton2;
        local v970 = {
            TextSize = 18,
            ZIndex = 12,
            Text = v.label,
            Position = UDim2.fromOffset(10, 0),
            Size = UDim2.new(1, -10, 1, 0)
        };
        local TextLabel4 = Instance.new("TextLabel");
        TextLabel4.BorderSizePixel = 0;
        TextLabel4:SetAttribute("SkipTheme", true);
        TextLabel4.BackgroundTransparency = 1;
        TextLabel4.FontFace = u232;
        TextLabel4.TextColor3 = u231.text;
        TextLabel4.TextSize = 21;
        TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel4.Text = "";

        for i2, v2 in v970 do
            TextLabel4[i2] = v2;
        end;

        TextLabel4.Parent = TextButton2;
        TextButton2.MouseEnter:Connect(function() -- Line: 3816
            -- upvalues: TextButton2 (copy)
            TextButton2.BackgroundTransparency = 0.88;
        end);
        TextButton2.MouseLeave:Connect(function() -- Line: 3819
            -- upvalues: TextButton2 (copy)
            TextButton2.BackgroundTransparency = 1;
        end);
        TextButton2.Activated:Connect(function() -- Line: 3822
            -- upvalues: u921 (ref), i (copy), TextLabel2 (copy), v (copy), Frame6 (copy), u968 (ref), renderHist (copy)
            u921 = i;
            TextLabel2.Text = v.label;
            Frame6.Visible = false;

            if u968 then
                u968:Disconnect();
                u968 = nil;
            end;

            renderHist();
        end);
    end;

    TextButton.Activated:Connect(function() -- Line: 3829
        -- upvalues: Frame6 (copy), u968 (ref), OutsideClickDetector (ref), closeHistMenu (copy), TextButton (copy)
        if Frame6.Visible then
            Frame6.Visible = false;

            if u968 then
                u968:Disconnect();
                u968 = nil;
            end;
        else
            Frame6.Visible = true;
            u968 = OutsideClickDetector({ Frame6 }, closeHistMenu, {
                include = { TextButton }
            });
        end;
    end);
    u835 = u835 + 264;
    mkCap("Repeat offenders");
    local v971 = {
        Text = "Top flagged items",
        TextSize = 18,
        TextColor3 = u231.mut,
        Position = UDim2.fromOffset(592, u835),
        Size = UDim2.fromOffset(400, 22)
    };
    local TextLabel4 = Instance.new("TextLabel");
    TextLabel4.BorderSizePixel = 0;
    TextLabel4:SetAttribute("SkipTheme", true);
    TextLabel4.BackgroundTransparency = 1;
    TextLabel4.FontFace = u232;
    TextLabel4.TextColor3 = u231.text;
    TextLabel4.TextSize = 21;
    TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel4.Text = "";

    for i, v in v971 do
        TextLabel4[i] = v;
    end;

    TextLabel4.Parent = body;
    local v972 = Detection.repeatOffenders or {};
    local v973 = Detection.topItems or {};
    local u974 = {};

    for i, v in v972 do
        if i > 10 then
            break;
        end;

        local v975 = u835 + 30 + (i - 1) * 30;
        local v976 = {
            FontFace = u233,
            TextTruncate = Enum.TextTruncate.AtEnd,
            Position = UDim2.fromOffset(0, v975),
            Size = UDim2.fromOffset(230, 26)
        };
        local TextLabel5 = Instance.new("TextLabel");
        TextLabel5.BorderSizePixel = 0;
        TextLabel5:SetAttribute("SkipTheme", true);
        TextLabel5.BackgroundTransparency = 1;
        TextLabel5.FontFace = u232;
        TextLabel5.TextColor3 = u231.text;
        TextLabel5.TextSize = 21;
        TextLabel5.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel5.Text = "";

        for i2, v2 in v976 do
            TextLabel5[i2] = v2;
        end;

        TextLabel5.Parent = body;
        local playerId = v.playerId;

        if playerId and playerId > 0 then
            local v977 = u220[playerId];

            if v977 then
                TextLabel5.Text = "@" .. v977;
            else
                TextLabel5.Text = "@" .. tostring(playerId);
                local u978 = "@";
                resolveUsername(playerId, function(p979) -- Line: 1378
                    -- upvalues: TextLabel5 (copy), u978 (copy)
                    if p979 and TextLabel5.Parent then
                        TextLabel5.Text = (u978 or "") .. p979;
                    end;
                end);
            end;
        else
            TextLabel5.Text = "Automated";
        end;

        local v980 = {
            Text = v.count .. (v.count == 1 and " event" or " events"),
            TextColor3 = u231.mut2,
            TextXAlignment = Enum.TextXAlignment.Right,
            Position = UDim2.fromOffset(240, v975),
            Size = UDim2.fromOffset(110, 26)
        };
        local TextLabel6 = Instance.new("TextLabel");
        TextLabel6.BorderSizePixel = 0;
        TextLabel6:SetAttribute("SkipTheme", true);
        TextLabel6.BackgroundTransparency = 1;
        TextLabel6.FontFace = u232;
        TextLabel6.TextColor3 = u231.text;
        TextLabel6.TextSize = 21;
        TextLabel6.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel6.Text = "";

        for i2, v2 in v980 do
            TextLabel6[i2] = v2;
        end;

        TextLabel6.Parent = body;
        local v981 = {
            Text = "max " .. tostring(v.maxScore),
            TextColor3 = u231.mut2,
            TextXAlignment = Enum.TextXAlignment.Right,
            Position = UDim2.fromOffset(360, v975),
            Size = UDim2.fromOffset(90, 26)
        };
        local TextLabel7 = Instance.new("TextLabel");
        TextLabel7.BorderSizePixel = 0;
        TextLabel7:SetAttribute("SkipTheme", true);
        TextLabel7.BackgroundTransparency = 1;
        TextLabel7.FontFace = u232;
        TextLabel7.TextColor3 = u231.text;
        TextLabel7.TextSize = 21;
        TextLabel7.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel7.Text = "";

        for i2, v2 in v981 do
            TextLabel7[i2] = v2;
        end;

        TextLabel7.Parent = body;
        local v982 = {
            Text = dashTimeAgo(v.lastAt),
            TextColor3 = u231.mut,
            TextXAlignment = Enum.TextXAlignment.Right,
            Position = UDim2.fromOffset(460, v975),
            Size = UDim2.fromOffset(100, 26)
        };
        local TextLabel8 = Instance.new("TextLabel");
        TextLabel8.BorderSizePixel = 0;
        TextLabel8:SetAttribute("SkipTheme", true);
        TextLabel8.BackgroundTransparency = 1;
        TextLabel8.FontFace = u232;
        TextLabel8.TextColor3 = u231.text;
        TextLabel8.TextSize = 21;
        TextLabel8.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel8.Text = "";

        for i2, v2 in v982 do
            TextLabel8[i2] = v2;
        end;

        TextLabel8.Parent = body;
        local v983 = {
            ZIndex = 2,
            Position = UDim2.fromOffset(0, v975 - 2),
            Size = UDim2.fromOffset(560, 30)
        };
        local TextButton2 = Instance.new("TextButton");
        TextButton2.BorderSizePixel = 0;
        TextButton2:SetAttribute("SkipTheme", true);
        TextButton2.BackgroundTransparency = 1;
        TextButton2.FontFace = u232;
        TextButton2.TextColor3 = u231.text;
        TextButton2.TextSize = 21;
        TextButton2.TextXAlignment = Enum.TextXAlignment.Left;
        TextButton2.Text = "";
        TextButton2.AutoButtonColor = false;

        for i2, v2 in v983 do
            TextButton2[i2] = v2;
        end;

        TextButton2.Parent = body;
        game:GetService("CollectionService"):AddTag(TextButton2, "UIEffectSoundOnly");
        TextButton2.Activated:Connect(function() -- Line: 3888
            -- upvalues: u5 (ref), reviewPlayer (ref), v (copy), fetchPlayerReview (ref)
            if u5._setCategory then
                u5._setCategory("reviewPlayer");

                if reviewPlayer:FindFirstChild("input") then
                    reviewPlayer.input.Text = tostring(v.playerId);
                end;

                task.spawn(fetchPlayerReview, (tostring(v.playerId)));
            end;
        end);
    end;

    if #v972 == 0 then
        local v984 = {
            Text = "No repeat offenders in this window.",
            TextColor3 = u231.mut,
            Position = UDim2.fromOffset(0, u835 + 30),
            Size = UDim2.fromOffset(560, 26)
        };
        local TextLabel5 = Instance.new("TextLabel");
        TextLabel5.BorderSizePixel = 0;
        TextLabel5:SetAttribute("SkipTheme", true);
        TextLabel5.BackgroundTransparency = 1;
        TextLabel5.FontFace = u232;
        TextLabel5.TextColor3 = u231.text;
        TextLabel5.TextSize = 21;
        TextLabel5.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel5.Text = "";

        for i, v in v984 do
            TextLabel5[i] = v;
        end;

        TextLabel5.Parent = body;
    end;

    for i, v in v973 do
        if i > 10 then
            break;
        end;

        local v985 = u835 + 30 + (i - 1) * 30;
        local v986 = {
            Text = tostring(v.assetId),
            TextTruncate = Enum.TextTruncate.AtEnd,
            Position = UDim2.fromOffset(592, v985),
            Size = UDim2.fromOffset(330, 26)
        };
        local TextLabel5 = Instance.new("TextLabel");
        TextLabel5.BorderSizePixel = 0;
        TextLabel5:SetAttribute("SkipTheme", true);
        TextLabel5.BackgroundTransparency = 1;
        TextLabel5.FontFace = u232;
        TextLabel5.TextColor3 = u231.text;
        TextLabel5.TextSize = 21;
        TextLabel5.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel5.Text = "";

        for i2, v2 in v986 do
            TextLabel5[i2] = v2;
        end;

        TextLabel5.Parent = body;
        u974[v.assetId] = TextLabel5;
        local v987 = {};
        local v988 = tonumber(v.count) or 0;
        local v989 = math.floor(v988);
        v987.Text = tostring(v989):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
        v987.FontFace = u233;
        v987.TextXAlignment = Enum.TextXAlignment.Right;
        v987.Position = UDim2.fromOffset(932, v985);
        v987.Size = UDim2.fromOffset(120, 26);
        local TextLabel6 = Instance.new("TextLabel");
        TextLabel6.BorderSizePixel = 0;
        TextLabel6:SetAttribute("SkipTheme", true);
        TextLabel6.BackgroundTransparency = 1;
        TextLabel6.FontFace = u232;
        TextLabel6.TextColor3 = u231.text;
        TextLabel6.TextSize = 21;
        TextLabel6.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel6.Text = "";

        for i2, v2 in v987 do
            TextLabel6[i2] = v2;
        end;

        TextLabel6.Parent = body;
    end;

    if #v973 == 0 then
        local v990 = {
            Text = "No flagged items recorded.",
            TextColor3 = u231.mut,
            Position = UDim2.fromOffset(592, u835 + 30),
            Size = UDim2.fromOffset(400, 26)
        };
        local TextLabel5 = Instance.new("TextLabel");
        TextLabel5.BorderSizePixel = 0;
        TextLabel5:SetAttribute("SkipTheme", true);
        TextLabel5.BackgroundTransparency = 1;
        TextLabel5.FontFace = u232;
        TextLabel5.TextColor3 = u231.text;
        TextLabel5.TextSize = 21;
        TextLabel5.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel5.Text = "";

        for i, v in v990 do
            TextLabel5[i] = v;
        end;

        TextLabel5.Parent = body;
    end;

    if next(u974) then
        task.spawn(function() -- Line: 3934
            -- upvalues: u974 (copy)
            local u991 = {};

            for i in u974 do
                table.insert(u991, i);
            end;

            local success, result = pcall(function() -- Line: 3939
                -- upvalues: u991 (copy)
                return game:GetService("AvatarEditorService"):GetBatchItemDetails(u991, Enum.AvatarItemType.Asset);
            end);

            if success and typeof(result) == "table" then
                for _, v in result do
                    local v992 = u974[v.Id];

                    if v992 and (v992.Parent and v.Name) then
                        v992.Text = v.Name;
                    end;
                end;
            end;
        end);
    end;

    local v993 = math.min(#v972, 10);
    local v994 = math.min(#v973, 10);
    u835 = u835 + (math.max(v993, v994, 1) * 30 + 30 + 20);
    body.CanvasSize = UDim2.new(0, 0, 0, u835 + 20);
end;

local u995 = { {
        days = 1,
        label = "Today"
    }, {
        days = 3,
        label = "Last 3 days"
    }, {
        days = 7,
        label = "Last 7 days"
    }, {
        days = 28,
        label = "Last 28 days"
    }, {
        days = 56,
        label = "Last 56 days"
    }, {
        days = 90,
        label = "Last 90 days"
    } };

local function dashboardOpen() -- Line: 4665
    -- upvalues: mainSection (copy), dashCloseInspect (copy), dashServerCleanup (copy), u219 (copy), dashShowHomeSkeleton (copy), Remotes (copy), dashHideSkeletons (copy), Events (copy), dashRenderHome (copy), u5 (copy), u524 (ref), u995 (copy), u231 (copy), u232 (copy), OutsideClickDetector (copy)
    local dashboard = mainSection:FindFirstChild("dashboard");

    if not dashboard then
        return;
    end;

    local dashboard2 = mainSection:FindFirstChild("dashboard");

    if dashboard2 then
        dashCloseInspect();
        dashServerCleanup();
        dashboard2.home.Visible = true;
        dashboard2.detail.Visible = false;
    end;

    local v996 = u219;
    v996.generation = v996.generation + 1;
    local generation = u219.generation;

    local function fetchHome() -- Line: 4674
        -- upvalues: u219 (ref), dashShowHomeSkeleton (ref), Remotes (ref), generation (copy), dashHideSkeletons (ref), dashboard (copy), Events (ref), dashRenderHome (ref)
        local u997 = u219.windowDays or 28;
        dashShowHomeSkeleton();
        task.spawn(function() -- Line: 4677
            -- upvalues: Remotes (ref), u997 (copy), generation (ref), u219 (ref), dashHideSkeletons (ref), dashboard (ref), Events (ref), dashRenderHome (ref)
            local success, result = pcall(function() -- Line: 4678
                -- upvalues: Remotes (ref), u997 (ref)
                return { Remotes.CommunityOutfitsAction:InvokeServer("GetModerationDashboard", u997) };
            end);

            if generation ~= u219.generation or u997 ~= (u219.windowDays or 28) then
                return;
            end;

            local v998;

            if success then
                v998 = result[1];
            else
                v998 = success;
            end;

            if success then
                success = result[2];
            end;

            if v998 and typeof(success) == "table" then
                u219.data = success;
                dashRenderHome(success);

                return;
            end;

            dashHideSkeletons(dashboard.home);
            Events.Notify:Fire("❌ Couldn\'t load the dashboard. Try again shortly.");
        end);
    end;

    local home = dashboard.home;
    table.insert(u5.CategoryConnections, home.actionsCard.explore.Activated:Connect(function() -- Line: 4695
        -- upvalues: u219 (ref), u524 (ref)
        if u219.data then
            u524("actions", u219.data);
        end;
    end));
    table.insert(u5.CategoryConnections, home.typesCard.explore.Activated:Connect(function() -- Line: 4698
        -- upvalues: u219 (ref), u524 (ref)
        if u219.data then
            u524("types", u219.data);
        end;
    end));
    table.insert(u5.CategoryConnections, home.modsCard.explore.Activated:Connect(function() -- Line: 4701
        -- upvalues: u219 (ref), u524 (ref)
        if u219.data then
            u524("moderators", u219.data);
        end;
    end));
    table.insert(u5.CategoryConnections, home.trendsCard.explore.Activated:Connect(function() -- Line: 4704
        -- upvalues: u219 (ref), u524 (ref)
        if u219.data then
            u524("modtrends", u219.data);
        end;
    end));
    table.insert(u5.CategoryConnections, home.detectionCard.explore.Activated:Connect(function() -- Line: 4707
        -- upvalues: u219 (ref), u524 (ref)
        if u219.data then
            u524("detection", u219.data);
        end;
    end));
    table.insert(u5.CategoryConnections, home.serverCard.explore.Activated:Connect(function() -- Line: 4713
        -- upvalues: u524 (ref), u219 (ref)
        u524("server", u219.data or {});
    end));
    table.insert(u5.CategoryConnections, home.serverCard.allServers.Activated:Connect(function() -- Line: 4716
        -- upvalues: u524 (ref), u219 (ref)
        u524("servers", u219.data or {});
    end));
    table.insert(u5.CategoryConnections, dashboard.detail.back.Activated:Connect(function() -- Line: 4719
        -- upvalues: u219 (ref), u524 (ref), mainSection (ref), dashCloseInspect (ref), dashServerCleanup (ref)
        local backTo = u219.backTo;
        u219.backTo = nil;

        if backTo and u219.data then
            u524(backTo, u219.data);

            return;
        end;

        local dashboard3 = mainSection:FindFirstChild("dashboard");

        if not dashboard3 then
            return;
        end;

        dashCloseInspect();
        dashServerCleanup();
        dashboard3.home.Visible = true;
        dashboard3.detail.Visible = false;
    end));
    local _windowSel = home:FindFirstChild("_windowSel");

    if _windowSel then
        _windowSel:Destroy();
    end;

    local _windowMenu = home:FindFirstChild("_windowMenu");

    if _windowMenu then
        _windowMenu:Destroy();
    end;

    local v999 = 4;

    for i, v in u995 do
        if v.days == (u219.windowDays or 28) then
            v999 = i;
        end;
    end;

    local v1000 = {
        Name = "_windowSel",
        BackgroundTransparency = 0,
        ZIndex = 5,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.fromOffset(1044, 0),
        Size = UDim2.fromOffset(280, 48),
        BackgroundColor3 = u231.track
    };
    local TextButton = Instance.new("TextButton");
    TextButton.BorderSizePixel = 0;
    TextButton:SetAttribute("SkipTheme", true);
    TextButton.BackgroundTransparency = 1;
    TextButton.FontFace = u232;
    TextButton.TextColor3 = u231.text;
    TextButton.TextSize = 21;
    TextButton.TextXAlignment = Enum.TextXAlignment.Left;
    TextButton.Text = "";
    TextButton.AutoButtonColor = false;

    for i, v in v1000 do
        TextButton[i] = v;
    end;

    TextButton.Parent = home;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 8);
    UICorner.Parent = TextButton;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(49, 51, 57);
    UIStroke.Thickness = 1;
    UIStroke.Parent = TextButton;
    local v1001 = {
        TextSize = 22,
        ZIndex = 6,
        Text = u995[v999].label,
        Position = UDim2.fromOffset(18, 0),
        Size = UDim2.new(1, -52, 1, 0)
    };
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BorderSizePixel = 0;
    TextLabel:SetAttribute("SkipTheme", true);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = u232;
    TextLabel.TextColor3 = u231.text;
    TextLabel.TextSize = 21;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Text = "";

    for i, v in v1001 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = TextButton;
    local v1002 = {
        Text = "▼",
        TextSize = 14,
        ZIndex = 6,
        TextColor3 = u231.mut,
        TextXAlignment = Enum.TextXAlignment.Center,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -12, 0, 0),
        Size = UDim2.fromOffset(20, 48)
    };
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.BorderSizePixel = 0;
    TextLabel2:SetAttribute("SkipTheme", true);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = u232;
    TextLabel2.TextColor3 = u231.text;
    TextLabel2.TextSize = 21;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.Text = "";

    for i, v in v1002 do
        TextLabel2[i] = v;
    end;

    TextLabel2.Parent = TextButton;
    game:GetService("CollectionService"):AddTag(TextButton, "UIEffectSoundOnly");
    local v1003 = {
        Name = "_windowMenu",
        BackgroundTransparency = 0,
        Visible = false,
        ZIndex = 30,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.fromOffset(1044, 56),
        Size = UDim2.fromOffset(280, #u995 * 48 + 12),
        BackgroundColor3 = u231.track
    };
    local Frame = Instance.new("Frame");
    Frame.BorderSizePixel = 0;
    Frame:SetAttribute("SkipTheme", true);
    Frame.BackgroundColor3 = u231.text;

    for i, v in v1003 do
        Frame[i] = v;
    end;

    Frame.Parent = home;
    local UICorner2 = Instance.new("UICorner");
    UICorner2.CornerRadius = UDim.new(0, 8);
    UICorner2.Parent = Frame;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Color = Color3.fromRGB(49, 51, 57);
    UIStroke2.Thickness = 1;
    UIStroke2.Parent = Frame;
    local u1004 = nil;

    local function u1005() -- Line: 4793
        -- upvalues: Frame (copy), u1004 (ref)
        Frame.Visible = false;

        if u1004 then
            u1004:Disconnect();
            u1004 = nil;
        end;
    end;

    for i, v in u995 do
        local v1006 = {
            BackgroundTransparency = 1,
            ZIndex = 31,
            Position = UDim2.fromOffset(6, 6 + (i - 1) * 48),
            Size = UDim2.fromOffset(268, 48),
            BackgroundColor3 = Color3.fromRGB(208, 217, 251)
        };
        local TextButton2 = Instance.new("TextButton");
        TextButton2.BorderSizePixel = 0;
        TextButton2:SetAttribute("SkipTheme", true);
        TextButton2.BackgroundTransparency = 1;
        TextButton2.FontFace = u232;
        TextButton2.TextColor3 = u231.text;
        TextButton2.TextSize = 21;
        TextButton2.TextXAlignment = Enum.TextXAlignment.Left;
        TextButton2.Text = "";
        TextButton2.AutoButtonColor = false;

        for i2, v2 in v1006 do
            TextButton2[i2] = v2;
        end;

        TextButton2.Parent = Frame;
        local UICorner3 = Instance.new("UICorner");
        UICorner3.CornerRadius = UDim.new(0, 6);
        UICorner3.Parent = TextButton2;
        local v1007 = {
            TextSize = 22,
            ZIndex = 32,
            Text = v.label,
            Position = UDim2.fromOffset(14, 0),
            Size = UDim2.new(1, -14, 1, 0)
        };
        local TextLabel3 = Instance.new("TextLabel");
        TextLabel3.BorderSizePixel = 0;
        TextLabel3:SetAttribute("SkipTheme", true);
        TextLabel3.BackgroundTransparency = 1;
        TextLabel3.FontFace = u232;
        TextLabel3.TextColor3 = u231.text;
        TextLabel3.TextSize = 21;
        TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel3.Text = "";

        for i2, v2 in v1007 do
            TextLabel3[i2] = v2;
        end;

        TextLabel3.Parent = TextButton2;
        TextButton2.MouseEnter:Connect(function() -- Line: 4818
            -- upvalues: TextButton2 (copy)
            TextButton2.BackgroundTransparency = 0.88;
        end);
        TextButton2.MouseLeave:Connect(function() -- Line: 4821
            -- upvalues: TextButton2 (copy)
            TextButton2.BackgroundTransparency = 1;
        end);
        TextButton2.Activated:Connect(function() -- Line: 4824
            -- upvalues: Frame (copy), u1004 (ref), u219 (ref), v (copy), TextLabel (copy), dashShowHomeSkeleton (ref), Remotes (ref), generation (copy), dashHideSkeletons (ref), dashboard (copy), Events (ref), dashRenderHome (ref)
            Frame.Visible = false;

            if u1004 then
                u1004:Disconnect();
                u1004 = nil;
            end;

            if (u219.windowDays or 28) == v.days then
                return;
            end;

            u219.windowDays = v.days;
            TextLabel.Text = v.label;
            local u1008 = u219.windowDays or 28;
            dashShowHomeSkeleton();
            task.spawn(function() -- Line: 4677
                -- upvalues: Remotes (ref), u1008 (copy), generation (ref), u219 (ref), dashHideSkeletons (ref), dashboard (ref), Events (ref), dashRenderHome (ref)
                local success, result = pcall(function() -- Line: 4678
                    -- upvalues: Remotes (ref), u1008 (ref)
                    return { Remotes.CommunityOutfitsAction:InvokeServer("GetModerationDashboard", u1008) };
                end);

                if generation ~= u219.generation or u1008 ~= (u219.windowDays or 28) then
                    return;
                end;

                local v1009;

                if success then
                    v1009 = result[1];
                else
                    v1009 = success;
                end;

                if success then
                    success = result[2];
                end;

                if v1009 and typeof(success) == "table" then
                    u219.data = success;
                    dashRenderHome(success);

                    return;
                end;

                dashHideSkeletons(dashboard.home);
                Events.Notify:Fire("❌ Couldn\'t load the dashboard. Try again shortly.");
            end);
        end);
    end;

    TextButton.Activated:Connect(function() -- Line: 4832
        -- upvalues: Frame (copy), u1004 (ref), OutsideClickDetector (ref), u1005 (copy), TextButton (copy)
        if Frame.Visible then
            Frame.Visible = false;

            if u1004 then
                u1004:Disconnect();
                u1004 = nil;
            end;
        else
            Frame.Visible = true;
            u1004 = OutsideClickDetector({ Frame }, u1005, {
                include = { TextButton }
            });
        end;
    end);
    local u1010 = u219.windowDays or 28;
    dashShowHomeSkeleton();
    task.spawn(function() -- Line: 4677
        -- upvalues: Remotes (ref), u1010 (copy), generation (copy), u219 (ref), dashHideSkeletons (ref), dashboard (copy), Events (ref), dashRenderHome (ref)
        local success, result = pcall(function() -- Line: 4678
            -- upvalues: Remotes (ref), u1010 (ref)
            return { Remotes.CommunityOutfitsAction:InvokeServer("GetModerationDashboard", u1010) };
        end);

        if generation ~= u219.generation or u1010 ~= (u219.windowDays or 28) then
            return;
        end;

        local v1011;

        if success then
            v1011 = result[1];
        else
            v1011 = success;
        end;

        if success then
            success = result[2];
        end;

        if v1011 and typeof(success) == "table" then
            u219.data = success;
            dashRenderHome(success);

            return;
        end;

        dashHideSkeletons(dashboard.home);
        Events.Notify:Fire("❌ Couldn\'t load the dashboard. Try again shortly.");
    end);
end;

local u1012 = { {
        key = "NEAR_MISS_THRESHOLD",
        label = "Near-miss threshold",
        desc = "Telemetry-only tier. Scores at or above this are logged for tuning; the player is not affected."
    }, {
        key = "HIDE_THRESHOLD",
        label = "Hide threshold",
        desc = "Silent shadow-hide tier. The wearer sees their outfit normally; everyone else sees them parked out of the world."
    }, {
        key = "RESET_THRESHOLD",
        label = "Reset threshold",
        desc = "Outfit reset tier. The avatar is wiped and the player receives a system warning."
    }, {
        key = "PUBLISH_THRESHOLD",
        label = "Publish gate (total score)",
        desc = "Community publishing is rejected when the outfit\'s total score reaches this value."
    }, {
        key = "PUBLISH_SINGLE_ITEM_MAX",
        label = "Publish gate (single item)",
        desc = "Community publishing is rejected when any single worn item scores this value or higher."
    } };

local function detectionConfigOpen(u1013) -- Line: 4852
    -- upvalues: u234 (copy), u232 (copy), u231 (copy), u1012 (copy), dashSkeletonBlock (copy), Remotes (copy), u5 (copy), dashHideSkeletons (copy), u233 (copy), Events (copy)
    for _, child in u1013:GetChildren() do
        child:Destroy();
    end;

    local v1014 = {
        Text = "Automated detection settings",
        TextSize = 28,
        FontFace = u234,
        Position = UDim2.fromOffset(24, 18),
        Size = UDim2.fromOffset(700, 34)
    };
    local TextLabel = Instance.new("TextLabel");
    TextLabel.BorderSizePixel = 0;
    TextLabel:SetAttribute("SkipTheme", true);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = u232;
    TextLabel.TextColor3 = u231.text;
    TextLabel.TextSize = 21;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Text = "";

    for i, v in v1014 do
        TextLabel[i] = v;
    end;

    TextLabel.Parent = u1013;
    local v1015 = {
        Text = "Changes apply to this server instantly and to every other server within 3 minutes.",
        TextSize = 18,
        TextColor3 = u231.mut,
        Position = UDim2.fromOffset(24, 56),
        Size = UDim2.fromOffset(900, 22)
    };
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.BorderSizePixel = 0;
    TextLabel2:SetAttribute("SkipTheme", true);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = u232;
    TextLabel2.TextColor3 = u231.text;
    TextLabel2.TextSize = 21;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.Text = "";

    for i, v in v1015 do
        TextLabel2[i] = v;
    end;

    TextLabel2.Parent = u1013;
    local v1016 = {
        Text = "",
        TextSize = 20,
        TextColor3 = u231.mut,
        Position = UDim2.fromOffset(24, 110),
        Size = UDim2.fromOffset(600, 24)
    };
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.BorderSizePixel = 0;
    TextLabel3:SetAttribute("SkipTheme", true);
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = u232;
    TextLabel3.TextColor3 = u231.text;
    TextLabel3.TextSize = 21;
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel3.Text = "";

    for i, v in v1016 do
        TextLabel3[i] = v;
    end;

    TextLabel3.Parent = u1013;

    for i = 1, #u1012 do
        dashSkeletonBlock(u1013, 24, (i - 1) * 124 + 100, 1044, 112);
    end;

    task.spawn(function() -- Line: 4880
        -- upvalues: Remotes (ref), u5 (ref), TextLabel3 (copy), dashHideSkeletons (ref), u1013 (copy), u1012 (ref), u231 (ref), u233 (ref), u232 (ref), Events (ref)
        local success, result = pcall(function() -- Line: 4881
            -- upvalues: Remotes (ref)
            return { Remotes.CommunityOutfitsAction:InvokeServer("GetDetectionConfig") };
        end);

        if u5.CurrentCategory ~= "detectionConfig" or not TextLabel3.Parent then
            return;
        end;

        local v1017;

        if success then
            v1017 = result[1];
        else
            v1017 = success;
        end;

        if success then
            success = result[2];
        end;

        if not v1017 or typeof(success) ~= "table" then
            dashHideSkeletons(u1013);
            TextLabel3.Text = "Couldn\'t load detection settings.";

            return;
        end;

        dashHideSkeletons(u1013);
        TextLabel3:Destroy();

        for i, v in u1012 do
            local v1018 = success[v.key];
            local v1019 = {
                BackgroundColor3 = u231.track,
                Position = UDim2.fromOffset(24, 100 + (i - 1) * 124),
                Size = UDim2.fromOffset(1044, 112)
            };
            local Frame = Instance.new("Frame");
            Frame.BorderSizePixel = 0;
            Frame:SetAttribute("SkipTheme", true);
            Frame.BackgroundColor3 = u231.text;

            for i2, v2 in v1019 do
                Frame[i2] = v2;
            end;

            Frame.Parent = u1013;
            local UICorner = Instance.new("UICorner");
            UICorner.CornerRadius = UDim.new(0, 12);
            UICorner.Parent = Frame;
            local v1020 = {
                TextSize = 22,
                Text = v.label,
                FontFace = u233,
                Position = UDim2.fromOffset(20, 14),
                Size = UDim2.fromOffset(500, 26)
            };
            local TextLabel4 = Instance.new("TextLabel");
            TextLabel4.BorderSizePixel = 0;
            TextLabel4:SetAttribute("SkipTheme", true);
            TextLabel4.BackgroundTransparency = 1;
            TextLabel4.FontFace = u232;
            TextLabel4.TextColor3 = u231.text;
            TextLabel4.TextSize = 21;
            TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel4.Text = "";

            for i2, v2 in v1020 do
                TextLabel4[i2] = v2;
            end;

            TextLabel4.Parent = Frame;
            local v1021 = {
                TextSize = 16,
                TextWrapped = true,
                Text = v.desc,
                TextColor3 = u231.mut,
                TextYAlignment = Enum.TextYAlignment.Top,
                Position = UDim2.fromOffset(20, 48),
                Size = UDim2.fromOffset(640, 52)
            };
            local TextLabel5 = Instance.new("TextLabel");
            TextLabel5.BorderSizePixel = 0;
            TextLabel5:SetAttribute("SkipTheme", true);
            TextLabel5.BackgroundTransparency = 1;
            TextLabel5.FontFace = u232;
            TextLabel5.TextColor3 = u231.text;
            TextLabel5.TextSize = 21;
            TextLabel5.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel5.Text = "";

            for i2, v2 in v1021 do
                TextLabel5[i2] = v2;
            end;

            TextLabel5.Parent = Frame;
            local TextBox = Instance.new("TextBox");
            TextBox.Name = "input";
            TextBox.BorderSizePixel = 0;
            TextBox:SetAttribute("SkipTheme", true);
            TextBox.BackgroundColor3 = Color3.fromRGB(18, 18, 21);
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255);
            TextBox.FontFace = u233;
            TextBox.TextSize = 22;
            TextBox.TextXAlignment = Enum.TextXAlignment.Center;
            TextBox.ClearTextOnFocus = false;
            TextBox.Text = tostring(v1018 and (v1018.Value or "") or "");
            TextBox.Position = UDim2.fromOffset(764, 26);
            TextBox.Size = UDim2.fromOffset(140, 44);
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Color = Color3.fromRGB(70, 68, 77);
            UIStroke.Thickness = 1;
            UIStroke.Parent = TextBox;
            local UICorner2 = Instance.new("UICorner");
            UICorner2.CornerRadius = UDim.new(0, 8);
            UICorner2.Parent = TextBox;
            TextBox.Parent = Frame;
            local v1022 = {
                TextSize = 14,
                Text = v1018 and v1018.Min .. " - " .. v1018.Max or "",
                TextColor3 = u231.mut,
                TextXAlignment = Enum.TextXAlignment.Center,
                Position = UDim2.fromOffset(764, 76),
                Size = UDim2.fromOffset(140, 16)
            };
            local TextLabel6 = Instance.new("TextLabel");
            TextLabel6.BorderSizePixel = 0;
            TextLabel6:SetAttribute("SkipTheme", true);
            TextLabel6.BackgroundTransparency = 1;
            TextLabel6.FontFace = u232;
            TextLabel6.TextColor3 = u231.text;
            TextLabel6.TextSize = 21;
            TextLabel6.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel6.Text = "";

            for i2, v2 in v1022 do
                TextLabel6[i2] = v2;
            end;

            TextLabel6.Parent = Frame;
            local v1023 = {
                Text = "Apply",
                TextSize = 18,
                BackgroundTransparency = 0.88,
                FontFace = u233,
                TextXAlignment = Enum.TextXAlignment.Center,
                BackgroundColor3 = Color3.fromRGB(208, 217, 251),
                Position = UDim2.fromOffset(920, 26),
                Size = UDim2.fromOffset(104, 44)
            };
            local TextButton = Instance.new("TextButton");
            TextButton.BorderSizePixel = 0;
            TextButton:SetAttribute("SkipTheme", true);
            TextButton.BackgroundTransparency = 1;
            TextButton.FontFace = u232;
            TextButton.TextColor3 = u231.text;
            TextButton.TextSize = 21;
            TextButton.TextXAlignment = Enum.TextXAlignment.Left;
            TextButton.Text = "";
            TextButton.AutoButtonColor = false;

            for i2, v2 in v1023 do
                TextButton[i2] = v2;
            end;

            TextButton.Parent = Frame;
            local UICorner3 = Instance.new("UICorner");
            UICorner3.CornerRadius = UDim.new(0, 8);
            UICorner3.Parent = TextButton;
            game:GetService("CollectionService"):AddTag(TextButton, "UIEffectSoundOnly");
            local u1024 = false;

            local function submit() -- Line: 4963
                -- upvalues: u1024 (ref), TextBox (copy), Events (ref), v (copy), TextButton (copy), Remotes (ref)
                if u1024 then
                    return;
                end;

                local u1025 = tonumber(TextBox.Text);

                if not u1025 then
                    Events.Notify:Fire("⚠️ Enter a number for " .. v.label .. ".");

                    return;
                end;

                u1024 = true;
                TextButton.Text = "...";
                task.spawn(function() -- Line: 4972
                    -- upvalues: Remotes (ref), v (ref), u1025 (copy), u1024 (ref), TextButton (ref), TextBox (ref), Events (ref)
                    local success2, result2 = pcall(function() -- Line: 4973
                        -- upvalues: Remotes (ref), v (ref), u1025 (ref)
                        return { Remotes.CommunityOutfitsAction:InvokeServer("SetDetectionConfig", v.key, u1025) };
                    end);
                    u1024 = false;

                    if not TextButton.Parent then
                        return;
                    end;

                    TextButton.Text = "Apply";
                    local v1026;

                    if success2 then
                        v1026 = result2[1];
                    else
                        v1026 = success2;
                    end;

                    if success2 then
                        success2 = result2[2];
                    end;

                    if not v1026 or typeof(success2) ~= "table" then
                        Events.Notify:Fire("❌ " .. tostring(success2));

                        return;
                    end;

                    TextBox.Text = tostring(success2.Value);
                    Events.Notify:Fire("✅ " .. v.label .. " is now <b>" .. tostring(success2.Value) .. "</b>.");
                end);
            end;

            table.insert(u5.CategoryConnections, TextButton.Activated:Connect(submit));
            table.insert(u5.CategoryConnections, TextBox.FocusLost:Connect(function(p1027) -- Line: 4989
                -- upvalues: submit (copy)
                if p1027 then
                    submit();
                end;
            end));
        end;
    end);
end;

function u5.Close(p1028) -- Line: 4996
    -- upvalues: u5 (copy), Events (copy), u92 (copy), u145 (copy), dashboardCleanup (copy), remainingReports (copy), u6 (copy), u4 (copy), ModeratorPanel (copy)
    if not u5.IsOpen then
        return;
    end;

    u5.IsOpen = false;
    Events.InterfaceAction:Fire("Remove", script.Name);

    if p1028 ~= true then
        Events.SetButtonsVisible:Fire("All");
    end;

    u92:Reset();
    u145:Reset();
    dashboardCleanup();
    remainingReports.Visible = false;

    for _, v in u6 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u6);
    u4:Play();
    u4.Completed:Once(function() -- Line: 5011
        -- upvalues: u5 (ref), ModeratorPanel (ref)
        if u5.IsOpen ~= true then
            ModeratorPanel.Enabled = false;
        end;
    end);
end;

local function deAnonymize() -- Line: 5018
    -- upvalues: u7 (ref), LocalPlayer (copy), wrapper (copy)
    if u7 then
        u7:Destroy();
        u7 = nil;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "placeholderContainer";
    Frame.BackgroundTransparency = 1;
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.ClipsDescendants = true;
    local v1029 = { "dummy", "Todo", "UNUSED", "UNUSEDDDDAGAIN", "automaticsizex", "autosizeOld", "oldd", "old", "olldest", "old2", "label", "debugaaaaaaaa", "offset", "offsetold", "working", "a", "scaledO", "d" };

    for _ = 1, math.random(5, 10) do
        local TextLabel = Instance.new("TextLabel");
        TextLabel.BackgroundTransparency = 1;
        TextLabel.TextSize = 11;
        TextLabel.TextColor3 = Color3.fromRGB(0);
        TextLabel.Name = v1029[math.random(#v1029)];
        TextLabel.Text = LocalPlayer.UserId / 2;
        TextLabel.TextScaled = true;
        TextLabel.TextTransparency = 0.85;
        TextLabel.Position = UDim2.fromScale(math.random(), math.random());
        TextLabel.Size = UDim2.fromScale(0.1, 0.1);
        TextLabel.ZIndex = 999;
        TextLabel.Parent = Frame;
    end;

    Frame.Parent = wrapper;
    u7 = Frame;
end;

function u5.Open(p1030) -- Line: 5070
    -- upvalues: u5 (copy), Events (copy), ModeratorPanel (copy), container (copy), u3 (copy), sidebar (copy), LocalPlayer (copy), deAnonymize (copy), remainingReports (copy), clearCategories (copy), TweenService (copy), categoriesContainer (copy), u2 (copy), dashboardCleanup (copy), mainSection (copy), ThemeController (copy), u92 (copy), u145 (copy), reviewPlayer (copy), fetchPlayerReview (copy), fetchModeratedOutfit (copy), dashboardOpen (copy), detectionConfigOpen (copy), Remotes (copy), u6 (copy), wrapper (copy)
    if u5.IsOpen then
        if p1030 then
            u5.Close();
        end;

        return;
    end;

    u5.IsOpen = true;
    Events.InterfaceAction:Fire("Add", script.Name, u5.Close);
    Events.SetButtonsVisible:Fire({});
    ModeratorPanel.Enabled = true;
    container.GroupTransparency = 1;
    u3:Play();
    local identifierContainer = sidebar:FindFirstChild("identifierContainer");
    identifierContainer.image.Image = `rbxthumb://type=AvatarHeadShot&id={LocalPlayer.UserId}&w=100&h=100`;
    identifierContainer.username.Text = `@{LocalPlayer.Name}`;
    identifierContainer.id.Text = LocalPlayer.UserId;
    deAnonymize();
    remainingReports.Visible = false;
    clearCategories();
    local u1031 = 0;

    local function nextNavOrder() -- Line: 5098
        -- upvalues: u1031 (ref)
        u1031 = u1031 + 1;

        return u1031;
    end;

    local function setupSection(p1032) -- Line: 5105
        -- upvalues: u1031 (ref), TweenService (ref), categoriesContainer (ref)
        local TextButton = Instance.new("TextButton");
        TextButton.Name = p1032 .. "Section";
        TextButton.BackgroundTransparency = 1;
        TextButton.BorderSizePixel = 0;
        TextButton.Text = "";
        TextButton.AutoButtonColor = false;
        TextButton.Size = UDim2.new(1, 0, 0, 40);
        u1031 = u1031 + 1;
        TextButton.LayoutOrder = u1031;
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = "title";
        TextLabel.BackgroundTransparency = 1;
        TextLabel.BorderSizePixel = 0;
        TextLabel.Position = UDim2.new(0, 14, 0, 0);
        TextLabel.Size = UDim2.new(1, -56, 1, 0);
        TextLabel.FontFace = Font.new(script.category.label.FontFace.Family, Enum.FontWeight.Bold);
        TextLabel.TextSize = 22;
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.TextWrapped = false;
        TextLabel.Text = p1032;
        TextLabel.Parent = TextButton;
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Name = "chevron";
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.BorderSizePixel = 0;
        ImageLabel.AnchorPoint = Vector2.new(1, 0.5);
        ImageLabel.Position = UDim2.new(1, -12, 0.5, 0);
        ImageLabel.Size = UDim2.new(0, 18, 0, 18);
        ImageLabel.Image = "rbxassetid://131607777349580";
        ImageLabel.ImageColor3 = Color3.fromRGB(214, 213, 222);
        ImageLabel.ScaleType = Enum.ScaleType.Fit;
        ImageLabel.Rotation = 180;
        ImageLabel.Parent = TextButton;
        local u1033 = {};
        local u1034 = true;
        TextButton.Activated:Connect(function() -- Line: 5144
            -- upvalues: u1034 (ref), u1033 (copy), TweenService (ref), ImageLabel (copy)
            u1034 = not u1034;

            for _, v in u1033 do
                v.Visible = u1034;
            end;

            TweenService:Create(ImageLabel, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Rotation = u1034 and 180 or 0
            }):Play();
        end);
        TextButton.Parent = categoriesContainer;

        return function(p1035) -- Line: 5153
            -- upvalues: u1033 (copy)
            table.insert(u1033, p1035);
        end;
    end;

    local function setupCategoryButton(p1036, u1037, p1038, p1039) -- Line: 5161
        -- upvalues: u1031 (ref), u5 (ref), TweenService (ref), u2 (ref), categoriesContainer (ref)
        local u1040 = script.category:Clone();
        u1040.Name = u1037;
        u1040.label.Text = p1036;
        u1040.BackgroundTransparency = 0.95;
        u1040:SetAttribute("isCategory", true);
        u1031 = u1031 + 1;
        u1040.LayoutOrder = u1031;

        if p1039 then
            u1040.label.Position = UDim2.new(0, 28, 0, 0);
            u1040.label.Size = UDim2.new(1, -42, 1, 0);
        end;

        u1040.MouseEnter:Connect(function() -- Line: 5173
            -- upvalues: u5 (ref), u1037 (copy), TweenService (ref), u1040 (copy), u2 (ref)
            if u5.CurrentCategory ~= u1037 then
                TweenService:Create(u1040, u2, {
                    BackgroundTransparency = 0.875
                }):Play();
            end;
        end);
        u1040.MouseLeave:Connect(function() -- Line: 5179
            -- upvalues: u5 (ref), u1037 (copy), TweenService (ref), u1040 (copy), u2 (ref)
            if u5.CurrentCategory ~= u1037 then
                TweenService:Create(u1040, u2, {
                    BackgroundTransparency = 0.95
                }):Play();
            end;
        end);
        u1040.Activated:Connect(p1038);
        u1040.Parent = categoriesContainer;

        return u1040;
    end;

    local function setCategory(p1041, p1042) -- Line: 5190
        -- upvalues: u5 (ref), dashboardCleanup (ref), mainSection (ref), categoriesContainer (ref), TweenService (ref), u2 (ref), ThemeController (ref), remainingReports (ref), u92 (ref), u145 (ref), reviewPlayer (ref), fetchPlayerReview (ref), fetchModeratedOutfit (ref), dashboardOpen (ref), detectionConfigOpen (ref)
        if u5.CurrentCategory == p1041 and not p1042 then
            return;
        end;

        u5.CurrentCategory = p1041;

        for _, v in u5.CategoryConnections do
            v:Disconnect();
        end;

        table.clear(u5.CategoryConnections);
        dashboardCleanup();
        local u1043 = nil;

        for _, child in mainSection:GetChildren() do
            child.Visible = child.Name == p1041;

            if child.Name == p1041 then
                u1043 = child;
            end;

            if not child.Visible then
                local layoutBypass3 = child:FindFirstChild("layoutBypass");

                if layoutBypass3 then
                    layoutBypass3 = layoutBypass3:FindFirstChild("noPendingReports");
                end;

                if layoutBypass3 then
                    layoutBypass3.Visible = false;
                end;
            end;
        end;

        for _, child in categoriesContainer:GetChildren() do
            if string.lower(string.gsub(child.Name, " ", "")) == string.lower(p1041) then
                TweenService:Create(child, u2, {
                    BackgroundTransparency = 0
                }):Play();
                TweenService:Create(child.label, u2, {
                    TextColor3 = ThemeController.GetColor(Color3.fromRGB(18, 18, 21))
                }):Play();
            elseif child:IsA("TextButton") and child:GetAttribute("isCategory") then
                TweenService:Create(child, u2, {
                    BackgroundTransparency = 0.95
                }):Play();
                TweenService:Create(child.label, u2, {
                    TextColor3 = ThemeController.GetColor(Color3.fromRGB(255, 255, 255))
                }):Play();
            end;
        end;

        remainingReports.Visible = false;

        if p1041 == "communityOutfitReports" then
            u92:Load();
        elseif p1041 == "playerOutfitReports" then
            u145:Load();
        elseif p1041 == "reviewPlayer" then
            if reviewPlayer:FindFirstChild("playerReview") then
                reviewPlayer.playerReview:Destroy();
            end;

            reviewPlayer.noOutfitLoaded.Visible = true;
            table.insert(u5.CategoryConnections, reviewPlayer.input.FocusLost:Connect(function(p1044) -- Line: 5244
                -- upvalues: reviewPlayer (ref), fetchPlayerReview (ref)
                if p1044 then
                    if reviewPlayer.input.Text == "" then
                        return;
                    end;

                    fetchPlayerReview(reviewPlayer.input.Text);
                end;
            end));
        elseif p1041 == "restoreCommunityOutfits" then
            table.insert(u5.CategoryConnections, u1043.input.FocusLost:Connect(function(p1045) -- Line: 5251
                -- upvalues: u1043 (ref), fetchModeratedOutfit (ref)
                if p1045 then
                    if u1043.input.Text == "" then
                        return;
                    end;

                    fetchModeratedOutfit(u1043.input.Text);
                end;
            end));
        elseif p1041 == "dashboard" then
            dashboardOpen();
        elseif p1041 == "detectionConfig" then
            detectionConfigOpen(u1043);
        end;
    end;

    u5._setCategory = setCategory;
    local v1046, v1047 = Remotes.GetFlag:InvokeServer("IsContentAdministrator");
    local v1048;

    if v1046 == true then
        v1048 = v1047 == true;
    else
        v1048 = false;
    end;

    if v1048 then
        setupCategoryButton("Dashboard", "dashboard", function() -- Line: 5270
            -- upvalues: setCategory (copy)
            setCategory("dashboard");
        end);
    end;

    local v1049 = setupSection("Reports");
    v1049((setupCategoryButton("Outfit Reports", "communityOutfitReports", function() -- Line: 5276
        -- upvalues: setCategory (copy)
        setCategory("communityOutfitReports");
    end, true)));
    v1049((setupCategoryButton("Player Reports", "playerOutfitReports", function() -- Line: 5279
        -- upvalues: setCategory (copy)
        setCategory("playerOutfitReports");
    end, true)));
    v1049((setupCategoryButton("Review Player", "reviewPlayer", function() -- Line: 5282
        -- upvalues: setCategory (copy)
        setCategory("reviewPlayer");
    end, true)));

    if v1048 then
        local v1050 = setupSection("Admin");
        v1050((setupCategoryButton("Restore", "restoreCommunityOutfits", function() -- Line: 5288
            -- upvalues: setCategory (copy)
            setCategory("restoreCommunityOutfits");
        end, true)));
        v1050((setupCategoryButton("Detection", "detectionConfig", function() -- Line: 5291
            -- upvalues: setCategory (copy)
            setCategory("detectionConfig");
        end, true)));
    end;

    if u5.CurrentCategory == nil then
        setCategory(v1048 and "dashboard" or "communityOutfitReports", true);
    else
        setCategory(u5.CurrentCategory, true);
    end;

    table.insert(u6, wrapper.closeButton.Activated:Connect(u5.Close));
end;

Events.DisplayModeration.Event:Connect(u5.Open);

return u5;