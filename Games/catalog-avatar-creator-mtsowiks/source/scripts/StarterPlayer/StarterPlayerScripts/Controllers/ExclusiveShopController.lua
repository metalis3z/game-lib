-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("CollectionService");
local Modules = require(script.Parent.Parent.Modules);
local CatalogController = require(Modules.Controllers.CatalogController);
local HumanoidDescriptionController = require(Modules.Controllers.HumanoidDescriptionController);
local AvatarPreviewController = require(Modules.Controllers.AvatarPreviewController);
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local ExclusiveShop = PlayerGui:WaitForChild("ExclusiveShop");
local Catalog = PlayerGui:WaitForChild("Catalog");
local container = ExclusiveShop:WaitForChild("container");
local wrapper = container:WaitForChild("wrapper");
local topBar = wrapper:WaitForChild("topBar");
local backButton = topBar:WaitForChild("backButton");
local searchContainer = topBar:WaitForChild("searchContainer");
local searchInput = searchContainer.wrapper:WaitForChild("searchInput");
local clear = searchContainer:WaitForChild("clear");
local itemsWrapper = wrapper:WaitForChild("shopView"):WaitForChild("itemsWrapper");
local memberCard = itemsWrapper:WaitForChild("heroRow"):WaitForChild("memberCard");
local memberPage = wrapper:WaitForChild("memberPage");
local skyPan = memberPage:WaitForChild("skyView"):WaitForChild("skyPan");
local skyCanvas = skyPan:WaitForChild("skyCanvas");
local Events = script.Parent.Parent.Events;
local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local u1 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
local u2 = TweenService:Create(container, u1, {
    GroupTransparency = 0
});
local u3 = TweenService:Create(container, u1, {
    GroupTransparency = 1
});
local u4 = {
    IsOpen = false,
    IsMemberPageOpen = false
};
local u5 = {};
local u6 = {};

local function clearConnections() -- Line: 46
    -- upvalues: u5 (copy)
    for _, v in u5 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u5);
end;

local function clearThreads() -- Line: 53
    -- upvalues: u6 (copy)
    for _, v in u6 do
        pcall(task.cancel, v);
    end;

    table.clear(u6);
end;

ExclusiveShop.Enabled = false;
searchInput.ClearTextOnFocus = false;
clear.Visible = false;
searchInput:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 63
    -- upvalues: clear (copy), searchInput (copy)
    clear.Visible = searchInput.Text ~= "";
end);
clear.Activated:Connect(function() -- Line: 66
    -- upvalues: searchInput (copy)
    searchInput.Text = "";
    searchInput:CaptureFocus();
end);
local u7 = {
    Tier = "Legend",
    Earned = 612400,
    Balance = 12450,
    MemberSince = 0
};

local function fmt(p8) -- Line: 79
    local v9 = math.floor(p8);

    return tostring(v9):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

local u10 = {
    Member = {
        Color = Color3.fromRGB(196, 136, 84),
        Gems = { "rbxassetid://79309810536493" }
    },
    Silver = {
        Color = Color3.fromRGB(188, 198, 210),
        Gems = { "rbxassetid://91475384736202" }
    },
    Gold = {
        Color = Color3.fromRGB(217, 177, 92),
        Gems = { "rbxassetid://133422099090669" }
    },
    Diamond = {
        Color = Color3.fromRGB(162, 212, 242),
        Gems = { "rbxassetid://86445375944204" }
    },
    Elite = {
        Color = Color3.fromRGB(255, 158, 107),
        Gems = { "rbxassetid://72301251717355", "rbxassetid://86990145593231", "rbxassetid://91153750942451" }
    },
    Legend = {
        Color = Color3.fromRGB(150, 122, 255),
        Gems = { "rbxassetid://81639015375285", "rbxassetid://118098075493791", "rbxassetid://73369236566493" }
    }
};

local function textColor(p11) -- Line: 98
    return p11:Lerp(Color3.new(1, 1, 1), 0.25);
end;

local function shineSequence(p12) -- Line: 104
    local v13 = p12:Lerp(Color3.new(1, 1, 1), 0.25);
    local v14 = v13:Lerp(Color3.new(1, 1, 1), 0.7);

    return ColorSequence.new({
        ColorSequenceKeypoint.new(0, v13),
        ColorSequenceKeypoint.new(0.44, v13),
        ColorSequenceKeypoint.new(0.5, v14),
        ColorSequenceKeypoint.new(0.56, v13),
        ColorSequenceKeypoint.new(1, v13)
    });
end;

local u15 = Color3.fromRGB(29, 29, 29);
local u16 = Color3.fromRGB(24, 24, 24);
local u17 = Color3.fromRGB(27, 24, 21);

local function cardGradient(p18) -- Line: 123
    -- upvalues: u15 (copy), u16 (copy), u17 (copy)
    return ColorSequence.new({ ColorSequenceKeypoint.new(0, u15:Lerp(p18, 0.05)), ColorSequenceKeypoint.new(0.48, u16:Lerp(p18, 0.015)), ColorSequenceKeypoint.new(1, u17) });
end;

local function applyGemImages(p19, p20) -- Line: 131
    if not p19 then
        return;
    end;

    for i, v in { "L0", "L1", "L2" } do
        local v21 = p19:FindFirstChild(v);

        if v21 then
            v21.Image = p20[i] or "";
        end;
    end;
end;

local u22 = 0;

local function setBackLabel(p23) -- Line: 163
    -- upvalues: backButton (copy)
    local label = backButton.label;

    if label.Text == p23 then
        return;
    end;

    local v24 = backButton:FindFirstChildOfClass("UIAspectRatioConstraint");

    if not v24 then
        label.Text = p23;

        return;
    end;

    local Size = label.Size;
    label.Text = p23;
    label.Size = UDim2.new(20, 0, Size.Y.Scale, Size.Y.Offset);
    task.wait();
    task.wait();
    local X = label.TextBounds.X;
    local Y = backButton.AbsoluteSize.Y;

    if Y <= 0 or X <= 0 then
        label.Size = Size;

        return;
    end;

    local v25 = 1.26 * Y;
    local v26 = v25 + X + 0.34 * Y;
    v24.AspectRatio = v26 / Y;
    local image = backButton.image;
    image.Position = UDim2.new(0.3 * Y / v26, 0, 0.5, 0);
    image.Size = UDim2.new(0.7 * Y / v26, 0, 0.7, 0);
    label.Position = UDim2.new(v25 / v26, 0, 0.5, 0);
    label.Size = UDim2.new(1 - v25 / v26, 0, Size.Y.Scale, 0);
end;

local function collectLivingGems() -- Line: 198
    -- upvalues: memberPage (copy), skyCanvas (copy)
    local u27 = {};

    local function tryAdd(p28) -- Line: 200
        -- upvalues: u27 (copy)
        if not p28 then
            return;
        end;

        local L1 = p28:FindFirstChild("L1");
        local L2 = p28:FindFirstChild("L2");

        if L1 and L2 then
            table.insert(u27, { L1, L2 });
        end;
    end;

    local v29 = memberPage:FindFirstChild("mpHead") and memberPage.mpHead.lockRow:FindFirstChild("gem");
    tryAdd(v29);

    for _, child in skyCanvas:GetChildren() do
        if child:IsA("Frame") then
            tryAdd(child:FindFirstChild("gem"));
        end;
    end;

    return u27;
end;

local function collectShineGradients() -- Line: 213
    -- upvalues: memberPage (copy)
    local v30 = {};
    local v31 = {};
    local v32 = memberPage:FindFirstChild("mpHead") and memberPage.mpHead.lockRow:FindFirstChild("tierName");
    v31[1] = v32;

    for _, label in v31 do
        local gradient = label and label:FindFirstChildOfClass("UIGradient");

        if gradient then
            table.insert(v30, gradient);
        end;
    end;

    return v30;
end;

local function startAnimations() -- Line: 225
    -- upvalues: collectLivingGems (copy), collectShineGradients (copy), u6 (copy)
    local u33 = collectLivingGems();
    local u34 = collectShineGradients();
    table.insert(u6, task.spawn(function() -- Line: 228
        -- upvalues: u33 (copy), u34 (copy)
        local v35 = os.clock();

        while true do
            local v36 = os.clock() - v35;

            for i, v in u33 do
                local v37 = math.sin((v36 + i * 1.15) / 2.5) * 0.9;
                local v38 = math.exp(-((v37 + 0.1) / 0.85) ^ 2);
                local v39 = math.exp(-((v37 - 0.95) / 0.85) ^ 2);
                v[1].ImageTransparency = 1 - v38;
                v[2].ImageTransparency = 1 - v39;
            end;

            local v40 = v36 / 6.5 % 1 * 1.2 - 0.6;

            for _, v in u34 do
                v.Offset = Vector2.new(v40, 0);
            end;

            task.wait();
        end;
    end));
end;

local function fitTextRows() -- Line: 253
    -- upvalues: skyCanvas (copy), memberPage (copy)
    task.wait();
    task.wait();

    for _, child in skyCanvas:GetChildren() do
        if child:IsA("Frame") then
            local req = child:FindFirstChild("req");

            if req and req:IsA("Frame") then
                for _, child2 in req:GetChildren() do
                    if child2:IsA("TextLabel") then
                        child2.Size = UDim2.new(0, math.ceil(child2.TextBounds.X) + 1, 1, 0);
                    end;
                end;
            end;
        end;
    end;

    local v41 = skyCanvas:FindFirstChild("stopLegend") and skyCanvas.stopLegend:FindFirstChild("chip");

    if v41 then
        v41 = v41:FindFirstChild("label");
    end;

    if v41 then
        v41.Size = UDim2.new(0, math.ceil(v41.TextBounds.X) + 1, 1, 0);
    end;

    local statRow = memberPage.mpHead.statRow;
    local amount = statRow.earned.numRow.amount;
    statRow.earned.numRow:FindFirstChildOfClass("UIListLayout").Padding = UDim.new(0, 10);
    statRow.earned.Size = UDim2.new(0, math.ceil(statRow.earned.numRow.icon.AbsoluteSize.X + 10 + amount.TextBounds.X) + 2, 1, 0);
    statRow.since.Size = UDim2.new(0, math.ceil(statRow.since.value.TextBounds.X) + 2, 1, 0);
    local tierName = memberPage.mpHead.lockRow:FindFirstChild("tierName");

    if tierName then
        tierName.Size = UDim2.new(0, math.ceil(tierName.TextBounds.X) + 2, tierName.Size.Y.Scale, 0);
    end;
end;

local function applyCredits(p42) -- Line: 304
    -- upvalues: u7 (copy), topBar (copy), memberCard (copy), memberPage (copy), u10 (copy), applyGemImages (copy), shineSequence (copy), cardGradient (copy), fitTextRows (copy)
    if typeof(p42) ~= "table" then
        return;
    end;

    for i, v in p42 do
        u7[i] = v;
    end;

    u7.NextTier = p42.NextTier;
    u7.NextTierThreshold = p42.NextTierThreshold;
    local amount = topBar.balancePill.amount;
    local v43 = math.floor(u7.Balance);
    amount.Text = tostring(v43):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    local inner = memberCard.inner;
    local amount2 = inner.earned.numRow.amount;
    local v44 = math.floor(u7.Balance);
    amount2.Text = tostring(v44):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    inner.tierName.Text = u7.Tier;
    local earnedNote = inner.earnedNote;
    local v45 = math.floor(u7.Earned);
    earnedNote.Text = tostring(v45):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. " earned";
    inner.endLeft.Text = u7.Tier;
    inner.endRight.Text = not u7.NextTier and "Top tier reached" or u7.NextTier;

    if u7.MemberSince and u7.MemberSince > 0 then
        inner.memberSince.Text = "Member since " .. os.date("%B %Y", u7.MemberSince);
    end;

    local mpHead = memberPage.mpHead;
    mpHead.lockRow.tierName.Text = u7.Tier;
    local amount3 = mpHead.statRow.earned.numRow.amount;
    local v46 = math.floor(u7.Earned);
    amount3.Text = tostring(v46):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");

    if u7.MemberSince and u7.MemberSince > 0 then
        mpHead.statRow.since.value.Text = os.date("%B %Y", u7.MemberSince);
    end;

    local v47 = u10[u7.Tier] or u10.Member;
    applyGemImages(inner.gem, v47.Gems);
    applyGemImages(mpHead.lockRow:FindFirstChild("gem"), v47.Gems);
    inner.tierName.TextColor3 = Color3.new(1, 1, 1);
    mpHead.lockRow.tierName.TextColor3 = Color3.new(1, 1, 1);
    local v48 = inner.tierName:FindFirstChildOfClass("UIGradient");

    if v48 then
        v48.Color = shineSequence(v47.Color);
    end;

    local v49 = mpHead.lockRow.tierName:FindFirstChildOfClass("UIGradient");

    if v49 then
        v49.Color = shineSequence(v47.Color);
    end;

    local v50 = memberCard:FindFirstChildOfClass("UIStroke");

    if v50 then
        v50.Color = v47.Color;
    end;

    local v51 = memberCard:FindFirstChildOfClass("UIGradient");

    if v51 then
        v51.Color = cardGradient(v47.Color);
    end;

    local v52;

    if u7.NextTierThreshold then
        local v53 = u7.NextTierThreshold - (u7.TierThreshold or 0);
        v52 = v53 <= 0 and 1 or math.clamp((u7.Earned - u7.TierThreshold) / v53, 0, 1);
    else
        v52 = 1;
    end;

    inner.miniBar.fill.Size = UDim2.new(v52, 0, 1, 0);
    task.spawn(fitTextRows);
end;

Remotes.CreditsUpdated.OnClientEvent:Connect(applyCredits);
local u54 = TweenService:Create(memberPage, u1, {
    GroupTransparency = 0
});
local u55 = TweenService:Create(memberPage, u1, {
    GroupTransparency = 1
});

local function playJourneyArrival() -- Line: 364
    -- upvalues: skyCanvas (copy), skyPan (copy), TweenService (copy), memberPage (copy), u7 (copy)
    if not skyCanvas:FindFirstChild("stopLegend") then
        return;
    end;

    skyPan.CanvasPosition = Vector2.new(0, 0);
    task.wait();
    local v56 = math.max(0, 0.66 * skyCanvas.AbsoluteSize.X - skyPan.AbsoluteWindowSize.X / 2);
    TweenService:Create(skyPan, TweenInfo.new(1.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        CanvasPosition = Vector2.new(v56, 0)
    }):Play();
    local floorFill = skyCanvas:FindFirstChild("floorFill");

    if floorFill then
        local Size = floorFill.Size;
        floorFill.Size = UDim2.new(0, 0, Size.Y.Scale, Size.Y.Offset);
        TweenService:Create(floorFill, TweenInfo.new(1.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = Size
        }):Play();
    end;

    local amount = memberPage.mpHead.statRow.earned.numRow:FindFirstChild("amount");

    if amount then
        local v57 = os.clock();

        while true do
            local v58 = (os.clock() - v57) / 0.95;
            local v59 = math.min(1, v58);
            local v60 = math.floor(u7.Earned * (1 - (1 - v59) ^ 3) + 0.5);
            amount.Text = tostring(v60):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");

            if v59 >= 1 then
                break;
            end;

            task.wait();
        end;
    end;
end;

function u4.OpenMemberPage() -- Line: 402
    -- upvalues: u4 (copy), u22 (ref), u6 (copy), setBackLabel (copy), memberPage (copy), u54 (copy), playJourneyArrival (copy)
    if u4.IsMemberPageOpen then
        return;
    end;

    u4.IsMemberPageOpen = true;
    u22 = os.clock() + 0.45;
    table.insert(u6, task.spawn(setBackLabel, "Back to Shop"));
    memberPage.GroupTransparency = 1;
    memberPage.Visible = true;
    u54:Play();
    table.insert(u6, task.spawn(playJourneyArrival));
end;

function u4.CloseMemberPage() -- Line: 413
    -- upvalues: u4 (copy), u22 (ref), u6 (copy), setBackLabel (copy), u55 (copy), memberPage (copy)
    if not u4.IsMemberPageOpen then
        return;
    end;

    u4.IsMemberPageOpen = false;
    u22 = os.clock() + 0.45;
    table.insert(u6, task.spawn(setBackLabel, "Back to Catalog"));
    u55:Play();
    u55.Completed:Once(function() -- Line: 419
        -- upvalues: u4 (ref), memberPage (ref)
        if u4.IsMemberPageOpen ~= true then
            memberPage.Visible = false;
        end;
    end);
end;

function u4.Close(p61) -- Line: 427
    -- upvalues: u4 (copy), u5 (copy), clearThreads (copy), Events (copy), u3 (copy), TweenService (copy), Catalog (copy), u1 (copy), ExclusiveShop (copy), memberPage (copy), CatalogController (copy)
    if not u4.IsOpen then
        return;
    end;

    u4.IsOpen = false;

    for _, v in u5 do
        if v then
            v:Disconnect();
        end;
    end;

    table.clear(u5);
    clearThreads();

    if p61 ~= true then
        Events.SetButtonsVisible:Fire("All");
    end;

    Events.InterfaceAction:Fire("Remove", script.Name);
    u3:Play();
    TweenService:Create(Catalog.container, u1, {
        GroupTransparency = 1
    }):Play();
    u3.Completed:Once(function() -- Line: 438
        -- upvalues: u4 (ref), ExclusiveShop (ref), memberPage (ref), CatalogController (ref), Catalog (ref)
        if u4.IsOpen ~= true then
            ExclusiveShop.Enabled = false;
            memberPage.Visible = false;
            u4.IsMemberPageOpen = false;

            if CatalogController.IsOpen ~= true then
                Catalog.Enabled = false;
                Catalog.container.catalogSection.Visible = true;
                CatalogController.ClearConnections();
            end;
        end;
    end);
end;

function u4.Open(p62) -- Line: 453
    -- upvalues: ReplicatedStorage (copy), u4 (copy), Events (copy), ExclusiveShop (copy), Catalog (copy), CatalogController (copy), container (copy), memberPage (copy), u22 (ref), u2 (copy), TweenService (copy), u1 (copy), HumanoidDescriptionController (copy), AvatarPreviewController (copy), u5 (copy), topBar (copy), backButton (copy), memberCard (copy), itemsWrapper (copy), collectLivingGems (copy), collectShineGradients (copy), u6 (copy), fitTextRows (copy), Remotes (copy), applyCredits (copy), setBackLabel (copy)
    if not ReplicatedStorage:GetAttribute("ExclusiveShopEnabled") then
        return;
    end;

    if u4.IsOpen then
        if p62 then
            u4.Close();
        end;

        return;
    end;

    u4.IsOpen = true;
    Events.SetButtonsVisible:Fire({ "Undo", "Redo" });
    Events.InterfaceAction:Fire("Add", script.Name, u4.Close);
    ExclusiveShop.Enabled = true;
    Catalog.Enabled = true;
    Catalog.container.catalogSection.Visible = false;
    CatalogController.SetupQuickActions(u4.Open);
    container.GroupTransparency = 1;
    memberPage.Visible = false;
    u4.IsMemberPageOpen = false;
    u22 = os.clock() + 0.45;
    u2:Play();
    TweenService:Create(Catalog.container, u1, {
        GroupTransparency = 0
    }):Play();

    if HumanoidDescriptionController.HumanoidDescription then
        AvatarPreviewController.CurrentCatalogPreviewObject:Update(HumanoidDescriptionController.HumanoidDescription, {
            BypassIsApplied = true
        });
    end;

    AvatarPreviewController.CurrentCatalogPreviewObject:Redraw();
    table.insert(u5, topBar.closeButton.Activated:Connect(u4.Close));
    table.insert(u5, backButton.button.Activated:Connect(function() -- Line: 484
        -- upvalues: u22 (ref), u4 (ref), CatalogController (ref)
        if os.clock() < u22 then
            return;
        end;

        u22 = os.clock() + 0.45;

        if u4.IsMemberPageOpen then
            u4.CloseMemberPage();

            return;
        end;

        u4.Close();
        CatalogController.Open();
    end));
    table.insert(u5, topBar.getCredits.Activated:Connect(function() -- Line: 494
        -- upvalues: Events (ref)
        Events.Notify:Fire("Credit packs aren\'t available yet.");
    end));
    table.insert(u5, memberCard.clickCatcher.Activated:Connect(u4.OpenMemberPage));
    itemsWrapper.CanvasPosition = Vector2.new(0, 0);
    local u63 = collectLivingGems();
    local u64 = collectShineGradients();
    table.insert(u6, task.spawn(function() -- Line: 228
        -- upvalues: u63 (copy), u64 (copy)
        local v65 = os.clock();

        while true do
            local v66 = os.clock() - v65;

            for i, v in u63 do
                local v67 = math.sin((v66 + i * 1.15) / 2.5) * 0.9;
                local v68 = math.exp(-((v67 + 0.1) / 0.85) ^ 2);
                local v69 = math.exp(-((v67 - 0.95) / 0.85) ^ 2);
                v[1].ImageTransparency = 1 - v68;
                v[2].ImageTransparency = 1 - v69;
            end;

            local v70 = v66 / 6.5 % 1 * 1.2 - 0.6;

            for _, v in u64 do
                v.Offset = Vector2.new(v70, 0);
            end;

            task.wait();
        end;
    end));
    table.insert(u6, task.spawn(fitTextRows));
    table.insert(u6, task.spawn(function() -- Line: 506
        -- upvalues: Remotes (ref), applyCredits (ref)
        local v71, v72 = Remotes.CreditsAction:InvokeServer({
            Action = "Get"
        });

        if v71 then
            applyCredits(v72);
        end;
    end));
    table.insert(u6, task.spawn(function() -- Line: 512
        -- upvalues: backButton (ref), setBackLabel (ref)
        task.wait();
        backButton.label.Text = "";
        setBackLabel("Back to Catalog");
    end));
end;

Events.DisplayExclusiveShop.Event:Connect(u4.Open);

return u4;