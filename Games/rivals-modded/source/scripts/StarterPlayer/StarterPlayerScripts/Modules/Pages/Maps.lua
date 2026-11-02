-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local ContractsLibrary = require(ReplicatedStorage.Modules.ContractsLibrary);
local DuelLibrary = require(ReplicatedStorage.Modules.DuelLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local MatchmakingController = require(Players.LocalPlayer.PlayerScripts.Controllers.MatchmakingController);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local ArcadeController = require(Players.LocalPlayer.PlayerScripts.Controllers.ArcadeController);
local Equipment = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface:WaitForChild("Equipment"));
local ContractSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("BaseContractSlot"):WaitForChild("ContractSlot"));
local StatisticsList = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("StatisticsList"));
local LockedMapSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("LockedMapSlot"));
local PromptSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local MapSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("MapSlot"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local ContractDivider = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ContractDivider");
Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("LockedMapSlot");
local PlaySourceLabel = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PlaySourceLabel");
local EmptySlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("EmptySlot");
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 30
    -- upvalues: Page (copy), u1 (copy), PromptSystem (copy), StatisticsList (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.PromptsFrame = v3.PageFrame:WaitForChild("Prompts");
    v3.PageContainer = v3.PageFrame:WaitForChild("Container");
    v3.CloseButton = v3.PageContainer:WaitForChild("Close");
    v3.CloseButtonIcon = v3.CloseButton:WaitForChild("Icon");
    v3.List = v3.PageContainer:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.SlotsFrame = v3.Container:WaitForChild("Slots");
    v3.SlotsContainer = v3.SlotsFrame:WaitForChild("Container");
    v3.SlotsLayout = v3.SlotsContainer:WaitForChild("Layout");
    v3.InspectList = v3.PageContainer:WaitForChild("Inspect");
    v3.InspectContainer = v3.InspectList:WaitForChild("Container");
    v3.InspectLayout = v3.InspectContainer:WaitForChild("Layout");
    v3.InspectDetailsFrame = v3.InspectContainer:WaitForChild("Details");
    v3.InspectDetailsFrameUIScale = v3.InspectDetailsFrame:WaitForChild("UIScale");
    v3.InspectDetailsContainer = v3.InspectDetailsFrame:WaitForChild("Container");
    v3.InspectDetailsLayout = v3.InspectDetailsContainer:WaitForChild("Layout");
    v3.InspectDetailsThumbnail = v3.InspectDetailsContainer:WaitForChild("Thumbnail");
    v3.InspectDetailsTextLabelsFrame = v3.InspectDetailsContainer:WaitForChild("TextLabels");
    v3.InspectDetailsTextLabelsContainer = v3.InspectDetailsTextLabelsFrame:WaitForChild("Container");
    v3.InspectDetailsTextLabelsLayout = v3.InspectDetailsTextLabelsContainer:WaitForChild("Layout");
    v3.InspectDetailsTitle = v3.InspectDetailsTextLabelsContainer:WaitForChild("Title");
    v3.InspectDetailsDescription = v3.InspectDetailsTextLabelsContainer:WaitForChild("Description");
    v3.InspectDetailsCreator = v3.InspectDetailsTextLabelsContainer:WaitForChild("Creator");
    v3.InspectQueuesFrame = v3.InspectContainer:WaitForChild("Queues");
    v3.InspectQueuesFrameUIScale = v3.InspectQueuesFrame:WaitForChild("UIScale");
    v3.InspectQueuesContainer = v3.InspectQueuesFrame:WaitForChild("Container");
    v3.InspectQueuesLabelsFrame = v3.InspectQueuesContainer:WaitForChild("Labels");
    v3.InspectQueuesLabelsLayout = v3.InspectQueuesLabelsFrame:WaitForChild("Layout");
    v3.InspectStatisticsFrame = v3.InspectContainer:WaitForChild("Statistics");
    v3.InspectStatisticsFrameUIScale = v3.InspectStatisticsFrame:WaitForChild("UIScale");
    v3.InspectStatisticsContainer = v3.InspectStatisticsFrame:WaitForChild("Container");
    v3.InspectStatisticsLayout = v3.InspectStatisticsContainer:WaitForChild("Layout");
    v3.InspectStatisticsTextLabelsFrame = v3.InspectStatisticsContainer:WaitForChild("TextLabels");
    v3.InspectStatisticsTextLabelsContainer = v3.InspectStatisticsTextLabelsFrame:WaitForChild("Container");
    v3.InspectStatisticsTextLabelsLayout = v3.InspectStatisticsTextLabelsContainer:WaitForChild("Layout");
    v3.PromptSystem = PromptSystem.new(v3.PromptsFrame);
    v3.StatisticsList = StatisticsList.new(v3.InspectStatisticsTextLabelsContainer, 1, true);
    v3._map_slots = {};
    v3._locked_map_slots = {};
    v3._empty_map_slots = {};
    v3._map_slot_ui_scales = {};
    v3._map_slot_tweens = {};
    v3._inspected_map_name = nil;
    v3._inspected_map_info = nil;
    v3._inspected_map_locked_slot = nil;
    v3._inspected_queue_labels = {};
    v3._inspected_map_contract_slots = {};
    v3._inspect_tweens = {};
    v3:_Init();

    return v3;
end;

function u1.CloseRequest(p4) -- Line: 94
    -- upvalues: Page (copy)
    if p4._inspected_map_name then
        p4:Inspect(nil);

        return;
    end;

    Page.CloseRequest(p4);
end;

function u1.Inspect(u5, p6) -- Line: 102
    -- upvalues: DuelLibrary (copy), LockedMapSlot (copy), PlaySourceLabel (copy), MatchmakingController (copy), ArcadeController (copy), Equipment (copy), PlayerDataController (copy), ContractsLibrary (copy), ContractDivider (copy), ContractSlot (copy), TweenService (copy)
    for _, v in pairs(u5._inspect_tweens) do
        v:Cancel();
    end;

    for _, v in pairs(u5._inspected_queue_labels) do
        v:Destroy();
    end;

    for _, v in pairs(u5._inspected_map_contract_slots) do
        v:Destroy();
    end;

    u5._inspected_map_contract_slots = {};
    u5._inspect_tweens = {};
    u5._inspected_queue_labels = {};

    if u5._inspected_map_locked_slot then
        u5._inspected_map_locked_slot:Destroy();
        u5._inspected_map_locked_slot = nil;
    end;

    u5._inspected_map_name = p6;
    u5._inspected_map_info = DuelLibrary.Maps[u5._inspected_map_name];
    u5.List.Visible = not u5._inspected_map_name;
    u5.InspectList.Visible = u5._inspected_map_name;
    u5.CloseButtonIcon.Image = u5._inspected_map_name and "rbxassetid://17562685319" or "rbxassetid://17838290166";

    if not u5._inspected_map_name then
        u5:_PlayMapSlotsTween();

        return;
    end;

    local v7 = u5:_IsMapUnlocked(u5._inspected_map_name);
    u5.InspectDetailsTitle.Text = v7 and (u5._inspected_map_name or "Discover this map in a duel to learn more!") or "Discover this map in a duel to learn more!";
    u5.InspectDetailsTitle.TextTransparency = v7 and 0 or 0.5;
    u5.InspectDetailsTitle.FontFace = v7 and Font.fromId(12187365977, Enum.FontWeight.Bold, Enum.FontStyle.Normal) or Font.fromId(12187365977, Enum.FontWeight.Medium, Enum.FontStyle.Italic);
    u5.InspectDetailsTitle.Size = v7 and UDim2.new(0.95, 0, 0.066, 0) or UDim2.new(0.95, 0, 0.035, 0);
    u5.InspectDetailsThumbnail.Image = v7 and (u5._inspected_map_info.Image or "") or "";
    u5.InspectDetailsDescription.Text = not v7 and "" or (not u5._inspected_map_info.Description and "" or "• " .. u5._inspected_map_info.Description);
    local InspectDetailsCreator = u5.InspectDetailsCreator;
    local v8;

    if v7 then
        if #u5._inspected_map_info.Contributors > 0 then
            v8 = string.format("• Created by %s with contributions from %s", u5:_GetUsernamesString(u5._inspected_map_info.Creators), u5:_GetUsernamesString(u5._inspected_map_info.Contributors));
        else
            v8 = #u5._inspected_map_info.Creators <= 0 and "" or string.format("• Created by %s", u5:_GetUsernamesString(u5._inspected_map_info.Creators));
        end;
    else
        v8 = "";
    end;

    InspectDetailsCreator.Text = v8;
    u5.InspectDetailsDescription.Visible = u5.InspectDetailsDescription.Text ~= "";
    u5.InspectDetailsCreator.Visible = u5.InspectDetailsCreator.Text ~= "";

    if not v7 then
        u5._inspected_map_locked_slot = LockedMapSlot.new(u5._inspected_map_name, true);
        u5._inspected_map_locked_slot.Frame.Size = UDim2.new(1, 0, 1, 0);
        u5._inspected_map_locked_slot.Frame.SizeConstraint = Enum.SizeConstraint.RelativeXY;
        u5._inspected_map_locked_slot.Frame.Position = UDim2.new(0.5, 0, 0.5, 0);
        u5._inspected_map_locked_slot.Frame.AnchorPoint = Vector2.new(0.5, 0.5);
        u5._inspected_map_locked_slot.Frame.Button.Difficulty.UIStroke.Enabled = false;
        u5._inspected_map_locked_slot:SetParent(u5.InspectDetailsThumbnail);
    end;

    local function create_playsource_label(p9, u10, p11, p12) -- Line: 165
        -- upvalues: DuelLibrary (ref), PlaySourceLabel (ref), u5 (copy), MatchmakingController (ref), ArcadeController (ref), Equipment (ref)
        local u13 = DuelLibrary.PlaySources[u10];

        if u13 and (u13.DatabaseInfo and (typeof(u13.DatabaseInfo.CanBeStartedFromClient) == "function" and not u13.DatabaseInfo.CanBeStartedFromClient())) then
            return;
        end;

        local u14 = p11 or (u13 and u13.AssignedColor or Color3.fromRGB(0, 0, 0));
        local u15 = p12 or u14:Lerp(Color3.fromRGB(0, 0, 0), 0.5);
        local u16 = PlaySourceLabel:Clone();
        u16.LayoutOrder = p9;
        local v17;

        if u13 then
            v17 = u13.DisplayName or u10;
        else
            v17 = u10;
        end;

        u16.Container.Title.Text = v17;
        u16.Play.ImageColor3 = u14;
        u16.Parent = u5.InspectQueuesLabelsFrame;
        table.insert(u5._inspected_queue_labels, u16);
        u16.Container.Title:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line: 182, Name: update
            -- upvalues: u16 (copy)
            u16.Size = UDim2.new(0.05, u16.Container.Title.TextBounds.X, 0.05, 0);
        end);
        u16.Size = UDim2.new(0.05, u16.Container.Title.TextBounds.X, 0.05, 0);

        local function hover() -- Line: 189
            -- upvalues: u16 (copy), u14 (copy), u15 (copy)
            u16.Play.Visible = true;
            u16.Container.Title.Visible = false;
            u16.Container.Title.TextColor3 = u14;
            u16.Background.ImageColor3 = u15;
        end;

        local function unhover() -- Line: 196
            -- upvalues: u16 (copy), u15 (copy), u14 (copy)
            u16.Play.Visible = false;
            u16.Container.Title.Visible = true;
            u16.Container.Title.TextColor3 = u15;
            u16.Background.ImageColor3 = u14;
        end;

        u16.Play.Visible = false;
        u16.Container.Title.Visible = true;
        u16.Container.Title.TextColor3 = u15;
        u16.Background.ImageColor3 = u14;

        if u13 then
            u16.MouseButton1Click:Connect(function() -- Line: 206
                -- upvalues: u13 (copy), MatchmakingController (ref), u10 (copy), ArcadeController (ref), u5 (ref), Equipment (ref)
                local v18;

                if u13.Type == "MatchmakingQueue" then
                    v18 = MatchmakingController:QueueInto(u10);
                elseif u13.Type == "ArcadeMode" then
                    v18 = ArcadeController:ToArcadeServer(u10);
                else
                    v18 = assert(false, "???");
                end;

                if v18 ~= "Success" then
                    u5.PromptSystem:Open("ErrorMessage", "Whoops!", v18 or "Server failed to respond, please try again");

                    return;
                end;

                u5.Closed:Fire();
                Equipment:Close();
            end);
            u16.MouseEnter:Connect(hover);
            u16.SelectionGained:Connect(hover);
            u16.MouseLeave:Connect(unhover);
            u16.SelectionLost:Connect(unhover);
        end;
    end;

    if u5._inspected_map_info.IsHidden then
        create_playsource_label(1, "N/A", Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 255, 255));
    elseif #u5._inspected_map_info.PlaySources == 0 then
        create_playsource_label(1, "Private Servers", Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 255, 255));
    else
        for i, v in pairs(u5._inspected_map_info.PlaySources) do
            create_playsource_label(i, v);
        end;
    end;

    u5.InspectStatisticsFrame.Visible = PlayerDataController:GetMapStatistic(p6, "StatisticPlaytime") > 0;
    u5.StatisticsList:Generate(false, "MapStatistics", p6);

    if v7 then
        local v19 = 50;

        for i, v in pairs(ContractsLibrary:GetMapContracts(u5._inspected_map_name)) do
            if i > 1 then
                local v20 = ContractDivider:Clone();
                v20.LayoutOrder = v19;
                v20.Parent = u5.InspectContainer;
                table.insert(u5._inspected_map_contract_slots, v20);
                v19 = v19 + 1;
            end;

            local MapStatistics = ContractSlot.new("MapStatistics", v);
            MapStatistics.Frame.LayoutOrder = v19;
            MapStatistics.Frame.Parent = u5.InspectContainer;
            table.insert(u5._inspected_map_contract_slots, MapStatistics);
            v19 = v19 + 1;
        end;
    end;

    u5.InspectDetailsFrameUIScale.Scale = 0.5;
    u5.InspectQueuesFrameUIScale.Scale = 0.5;
    u5.InspectStatisticsFrameUIScale.Scale = 0.5;
    local v21 = TweenService:Create(u5.InspectDetailsFrameUIScale, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Scale = 1
    });
    v21:Play();
    table.insert(u5._inspect_tweens, v21);
    local v22 = TweenService:Create(u5.InspectQueuesFrameUIScale, TweenInfo.new(0.375, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Scale = 1
    });
    v22:Play();
    table.insert(u5._inspect_tweens, v22);
    local v23 = TweenService:Create(u5.InspectStatisticsFrameUIScale, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Scale = 1
    });
    v23:Play();
    table.insert(u5._inspect_tweens, v23);
end;

function u1.Open(p24, ...) -- Line: 279
    -- upvalues: Page (copy)
    Page.Open(p24, ...);
    p24:Inspect(nil);
    p24:_UpdateMapSlots();
    p24:_PlayMapSlotsTween();
end;

function u1._IsMapUnlocked(p25, p26) -- Line: 290
    -- upvalues: DuelLibrary (copy), PlayerDataController (copy)
    return DuelLibrary.Maps[p26] and #DuelLibrary.Maps[p26].PlaySources == 0 and true or PlayerDataController:GetMapStatistic(p26, "StatisticPlaytime") > 0;
end;

function u1._PlayMapSlotsTween(u27) -- Line: 294
    -- upvalues: TweenService (copy)
    for _, v in pairs(u27._map_slot_tweens) do
        v:Cancel();
    end;

    u27._map_slot_tweens = {};

    local function play(p28, p29) -- Line: 301
        -- upvalues: TweenService (ref), u27 (copy)
        p29.Scale = 0.25;
        local v30 = TweenService:Create(p29, TweenInfo.new(math.sqrt(p28) * 0.1 + 0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Scale = 1
        });
        v30:Play();
        table.insert(u27._map_slot_tweens, v30);
    end;

    for i, v in pairs(u27._map_slots) do
        play(i, v[2].Frame.UIScale);
    end;

    for i, v in pairs(u27._locked_map_slots) do
        play(i, v[2].Frame.UIScale);
    end;

    for i, v in pairs(u27._empty_map_slots) do
        play(#u27._map_slots + i, v.UIScale);
    end;
end;

function u1._GetUsernamesString(p31, p32) -- Line: 321
    local v33 = "";

    for i, v in pairs(p32) do
        v33 = (v33 .. (i == 1 and "" or (i == #p32 and ", & " or ", "))) .. "@" .. v;
    end;

    return v33;
end;

function u1._UpdateMapSlots(p34) -- Line: 332
    if not p34:IsOpen() then
        return;
    end;

    for _, v in pairs(p34._map_slots) do
        v[2].Frame.Visible = p34:_IsMapUnlocked(v[1]);
    end;

    for _, v in pairs(p34._locked_map_slots) do
        v[2].Frame.Visible = not p34:_IsMapUnlocked(v[1]);
    end;
end;

function u1._UpdateList(p35) -- Line: 346
    p35.CloseButton.Position = UDim2.new(0.975, 0, 0.0225, p35.PageFrame.AbsoluteSize.Y * 0.125);
    p35.List.CanvasSize = UDim2.new(0, 0, 0, p35.Layout.AbsoluteContentSize.Y);
    p35.List.Active = p35.Layout.AbsoluteContentSize.Y >= p35.List.AbsoluteSize.Y;
    p35.List.Position = UDim2.new(0.5, 9, 0, p35.PageFrame.AbsoluteSize.Y * 0.125);
    p35.List.Size = UDim2.new(0.85, 0, 0, p35.PageFrame.AbsoluteSize.Y * 0.75);
    p35.InspectList.Position = p35.List.Position;
    p35.InspectList.Size = p35.List.Size;
end;

function u1._Setup(u36) -- Line: 356
    -- upvalues: Utility (copy), DuelLibrary (copy), MapSlot (copy), LockedMapSlot (copy), EmptySlot (copy)
    local v37 = Utility:CloneTable(DuelLibrary.MapOrder);
    table.sort(v37, function(p38, p39) -- Line: 359
        -- upvalues: DuelLibrary (ref)
        return DuelLibrary:SortMaps(p38, p39);
    end);

    local function create_map_slot(p40, u41) -- Line: 363
        -- upvalues: MapSlot (ref), u36 (copy)
        local v42 = MapSlot.new(u41);
        v42.Frame.LayoutOrder = p40;
        v42:SetParent(u36.SlotsContainer);
        table.insert(u36._map_slots, { u41, v42 });
        v42.Frame.Button.MouseButton1Click:Connect(function() -- Line: 369
            -- upvalues: u36 (ref), u41 (copy)
            u36:Inspect(u41);
        end);
        Instance.new("UIScale").Parent = v42.Frame;
    end;

    local function create_locked_map_slot(p43, u44) -- Line: 377
        -- upvalues: DuelLibrary (ref), LockedMapSlot (ref), u36 (copy)
        local _ = DuelLibrary.Maps[u44];
        local v45 = LockedMapSlot.new(u44);
        v45.Frame.LayoutOrder = p43;
        v45:SetParent(u36.SlotsContainer);
        table.insert(u36._locked_map_slots, { u44, v45 });
        v45.Frame.Button.MouseButton1Click:Connect(function() -- Line: 384
            -- upvalues: u36 (ref), u44 (copy)
            u36:Inspect(u44);
        end);
        Instance.new("UIScale").Parent = v45.Frame;
    end;

    for i, v in pairs(v37) do
        create_map_slot(i, v);
        create_locked_map_slot(i, v);
    end;

    for i = 1, math.max(0, 9 - #v37) + (3 - (#v37 <= 9 and 0 or (#v37 - 1) % 3 + 1)) do
        local v46 = EmptySlot:Clone();
        v46.LayoutOrder = 9999999;
        v46.Parent = u36.SlotsContainer;
        table.insert(u36._empty_map_slots, v46);
        Instance.new("UIScale").Parent = v46;
        local _ = i;
    end;
end;

function u1._Init(u47) -- Line: 408
    -- upvalues: PlayerDataController (copy), ButtonEffect (copy)
    u47.CloseButton.MouseButton1Click:Connect(function() -- Line: 409
        -- upvalues: u47 (copy)
        u47:CloseRequest();
    end);
    u47.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 413
        -- upvalues: u47 (copy)
        u47:_UpdateList();
    end);
    u47.SlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 417
        -- upvalues: u47 (copy)
        u47.SlotsFrame.Size = UDim2.new(1, 0, 0, u47.SlotsLayout.AbsoluteContentSize.Y);
    end);
    u47.InspectLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 421
        -- upvalues: u47 (copy)
        u47.InspectList.CanvasSize = UDim2.new(0, 0, 0, u47.InspectLayout.AbsoluteContentSize.Y);
        u47.InspectList.Active = u47.InspectLayout.AbsoluteContentSize.Y >= u47.InspectList.AbsoluteSize.Y;
    end);
    u47.InspectDetailsTextLabelsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 426
        -- upvalues: u47 (copy)
        u47.InspectDetailsTextLabelsFrame.Size = UDim2.new(1, 0, 0, u47.InspectDetailsTextLabelsLayout.AbsoluteContentSize.Y);
    end);
    u47.InspectDetailsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 430
        -- upvalues: u47 (copy)
        u47.InspectDetailsFrame.Size = UDim2.new(1, 0, 0, u47.InspectDetailsLayout.AbsoluteContentSize.Y);
    end);
    u47.InspectQueuesLabelsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 434
        -- upvalues: u47 (copy)
        u47.InspectQueuesFrame.Size = UDim2.new(1, 0, 0.088, u47.InspectQueuesLabelsLayout.AbsoluteContentSize.Y);
    end);
    u47.InspectStatisticsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 438
        -- upvalues: u47 (copy)
        u47.InspectStatisticsFrame.Size = UDim2.new(1, 0, 0, u47.InspectStatisticsLayout.AbsoluteContentSize.Y);
    end);
    u47.InspectStatisticsTextLabelsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 442
        -- upvalues: u47 (copy)
        u47.InspectStatisticsTextLabelsFrame.Size = UDim2.new(1, 0, 0, u47.InspectStatisticsTextLabelsLayout.AbsoluteContentSize.Y);
    end);
    u47.PageFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 446
        -- upvalues: u47 (copy)
        u47:_UpdateList();
    end);
    PlayerDataController.StatisticsUpdated:Connect(function() -- Line: 450
        -- upvalues: u47 (copy)
        u47:_UpdateMapSlots();
    end);
    u47:_Setup();
    u47:_UpdateList();
    u47:_UpdateMapSlots();
    u47:Inspect(nil);
    ButtonEffect:Add(u47.CloseButton);
end;

return u1._new();