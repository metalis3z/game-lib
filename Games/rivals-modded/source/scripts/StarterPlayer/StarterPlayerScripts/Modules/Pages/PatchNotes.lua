-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
require(ReplicatedStorage.Modules.CosmeticLibrary);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("RewardSlot"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local PatchNoteBalancingOverviewSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PatchNoteBalancingOverviewSlot");
local PatchNoteContentSummarySlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PatchNoteContentSummarySlot");
local PatchNoteBalanceChangeSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PatchNoteBalanceChangeSlot");
local PatchNoteViewMoreButton = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PatchNoteViewMoreButton");
local PatchNoteThumbnailSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PatchNoteThumbnailSlot");
local PatchNoteChangeSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PatchNoteChangeSlot");
local PatchNotesSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PatchNotesSlot");
local PatchNotes = Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PatchNotes");
local u1 = { "Release", "FreezeRay", "Matchmaking", "Cosmetics", "NewMaps", "Gamemodes", "2024SpookyEvent", "Weapons", "2024FestiveEvent", "BridgeMap", "Ranked", "TheHunt", "Cosmetics2", "Gamemodes2", "Emotes", "Season1", "2025SpookyEvent", "2025FestiveEvent", "LaborOfLove", "Lucky", "Season3", "2026Summer", "WildcatRelease", "RIA26" };
local u2 = {
    { Color3.fromRGB(100, 255, 50), "rbxassetid://72868042131575" },
    { Color3.fromRGB(255, 50, 50), "rbxassetid://129990470163489" },
    { Color3.fromRGB(166, 166, 166), "rbxassetid://125168324521437" }
};
local u3 = {
    Title = {
        Weight = 600,
        Transparency = 0,
        Size = 1.5,
        Spaces = 3,
        Prefix = "",
        NewLine = 2
    },
    Header = {
        Weight = 500,
        Transparency = 0.25,
        Size = 0.875,
        Spaces = 9,
        Prefix = "",
        NewLine = 0.5
    },
    Description = {
        Weight = 400,
        Transparency = 0.25,
        Size = 0.75,
        Spaces = 12,
        Prefix = "• ",
        NewLine = nil
    },
    Description2 = {
        Weight = 400,
        Transparency = 0.25,
        Size = 0.75,
        Spaces = 18,
        Prefix = "▪  ",
        NewLine = nil
    }
};
local u4 = setmetatable({}, Page);
u4.__index = u4;

function u4._new() -- Line: 50
    -- upvalues: Page (copy), u4 (copy)
    local v5 = Page.new(script.Name);
    local v6 = setmetatable(v5, u4);
    v6.PageContainer = v6.PageFrame:WaitForChild("Container");
    v6.CloseButton = v6.PageContainer:WaitForChild("Close");
    v6.List = v6.PageContainer:WaitForChild("List");
    v6.Container = v6.List:WaitForChild("Container");
    v6.Layout = v6.Container:WaitForChild("Layout");
    v6.ViewMoreButton = v6.Container:WaitForChild("ViewMore");
    v6._num_patch_notes_generated = 0;
    v6._is_generating = false;
    v6._elements = {};
    v6:_Init();

    return v6;
end;

function u4.ScrollTo(p7, p8, p9) -- Line: 73
    -- upvalues: TweenService (copy), BetterDebris (copy), Utility (copy)
    if not p8 then
        return;
    end;

    TweenService:Create(p7.List, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        CanvasPosition = Vector2.new(0, p8.AbsolutePosition.Y - p7.Container.AbsolutePosition.Y)
    }):Play();
    local Frame = Instance.new("Frame");
    Frame.BackgroundColor3 = p9 or Color3.fromRGB(255, 255, 255);
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.new(0.5, 0, 0.5, 0);
    Frame.Size = UDim2.new(1, 0, 20, 0);
    Frame.Parent = p8;
    Frame:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quint", 0.5, true);
    BetterDebris:AddItem(Frame, 3);
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.125, 0),
        NumberSequenceKeypoint.new(0.875, 0),
        NumberSequenceKeypoint.new(1, 1)
    });
    UIGradient.Parent = Frame;
    task.spawn(Utility.RenderstepForLoop, Utility, 0, 100, 1, function(p10) -- Line: 93
        -- upvalues: Frame (copy)
        Frame.BackgroundTransparency = 0 + 1 * (p10 / 100) ^ 4;
    end);
end;

function u4.Open(u11, ...) -- Line: 100
    -- upvalues: Page (copy), RunService (copy)
    Page.Open(u11, ...);
    u11:_UpdateSize();
    local _is_open_hash = u11._is_open_hash;
    task.delay(0.5, function() -- Line: 106
        -- upvalues: u11 (copy), _is_open_hash (copy), RunService (ref)
        for _, v in pairs(u11._elements) do
            if _is_open_hash ~= u11._is_open_hash then
                return;
            end;

            v[1].Parent = v[2];
            RunService.RenderStepped:Wait();
        end;
    end);
end;

function u4.Close(p12, ...) -- Line: 118
    -- upvalues: Page (copy)
    for _, v in pairs(p12._elements) do
        v[1].Parent = nil;
    end;

    Page.Close(p12, ...);
end;

function u4._GenerateNext(u13) -- Line: 130
    -- upvalues: u1 (copy), PatchNotes (copy), PatchNotesSlot (copy), ReplicatedStorage (copy), ButtonEffect (copy), PlayerDataController (copy), Signal (copy), PatchNoteViewMoreButton (copy), RunService (copy), PatchNoteBalancingOverviewSlot (copy), u2 (copy), ItemLibrary (copy), PatchNoteBalanceChangeSlot (copy), PatchNoteContentSummarySlot (copy), RewardSlot (copy), PatchNoteThumbnailSlot (copy), u3 (copy), PatchNoteChangeSlot (copy), WeaponStatusHandler (copy)
    if u13._num_patch_notes_generated >= #u1 then
        return;
    end;

    u13._is_generating = true;
    u13._num_patch_notes_generated = u13._num_patch_notes_generated + 1;
    u13.ViewMoreButton.Visible = u13._num_patch_notes_generated < #u1;
    local v14 = #u1 - u13._num_patch_notes_generated + 1;
    local u15 = require(PatchNotes:WaitForChild(u1[v14]));
    local u16 = PatchNotesSlot:Clone();
    u16.LayoutOrder = u13._num_patch_notes_generated;
    u16.Container.Thumbnail.Image = u15.Image or "";
    u16.Container.Thumbnail.Visible = u16.Container.Thumbnail.Image ~= "";
    u16.Container.Details.Title.Text = u15.Title;
    u16.Container.Details.Changes.Date.Text = u15.Date;
    u16.Parent = u13.Container;
    u16.Container.Details.Changes.CodeButton.Button.MouseButton1Click:Connect(function() -- Line: 150
        -- upvalues: u16 (copy), ReplicatedStorage (ref), u15 (copy)
        u16.Container.Details.Changes.CodeButton.Visible = false;
        ReplicatedStorage.Remotes.Data.RedeemCode:InvokeServer(string.lower(u15.Code));
    end);
    u16.Container.Details.Changes.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 155
        -- upvalues: u16 (copy)
        u16.Size = UDim2.new(1, 0, 0, u16.Container.Details.Changes.AbsolutePosition.Y - u16.AbsolutePosition.Y + u16.Container.Details.Changes.Layout.AbsoluteContentSize.Y);
    end);
    ButtonEffect:Add(u16.Container.Details.Changes.CodeButton.Button);

    if u15.Code and v14 == #u1 then
        task.delay(20, function() -- Line: 162
            -- upvalues: u16 (copy), PlayerDataController (ref), u15 (copy)
            u16.Container.Details.Changes.CodeButton.Visible = not PlayerDataController:Get("RedeemedCodes")[string.lower(u15.Code)];
        end);
    end;

    local u17 = Signal.new();
    local u18 = true;
    local u19 = nil;
    local u20 = 0;
    local u21 = {};
    local u22 = false;
    local u23 = {};
    local u24 = 0;

    local function new_layout_order() -- Line: 176
        -- upvalues: u24 (ref)
        u24 = u24 + 1;

        return u24;
    end;

    local function register_element(p25) -- Line: 181
        -- upvalues: u13 (copy), u16 (copy)
        p25.Parent = u13._is_open and u16.Container.Details.Changes or nil;
        table.insert(u13._elements, { p25, u16.Container.Details.Changes });
    end;

    local function add_to_collapsed_list(p26, p27, p28) -- Line: 186
        -- upvalues: u21 (ref), u20 (ref), PatchNoteViewMoreButton (ref), u18 (ref), u17 (copy), ButtonEffect (ref), RunService (ref)
        if u21 then
            p26.Visible = false;
            table.insert(u21, p26);

            if p27 then
                p27.Visible = false;
                table.insert(u21, p27);
            end;
        else
            if u20 == 10 then
                local UIGradient = Instance.new("UIGradient");
                UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 1) });
                UIGradient.Rotation = 90;
                UIGradient.Parent = p26;
                local u29 = {};
                u21 = u29;
                local u30 = PatchNoteViewMoreButton:Clone();
                u30.Parent = p26;

                local function expand() -- Line: 207
                    -- upvalues: u18 (ref), u29 (copy), UIGradient (copy), u30 (copy)
                    if u18 then
                        return;
                    end;

                    for _, v in pairs(u29) do
                        v.Visible = true;
                    end;

                    UIGradient:Destroy();
                    u30:Destroy();
                end;

                u30.MouseButton1Click:Connect(expand);
                u17:Connect(expand);
                ButtonEffect:Add(u30);
                RunService.RenderStepped:Wait();

                return;
            end;

            u20 = u20 + (p28 or 1);
        end;
    end;

    local function generate_balancing_overview(p31) -- Line: 231
        -- upvalues: u22 (ref), PatchNoteBalancingOverviewSlot (ref), u24 (ref), u2 (ref), ItemLibrary (ref), PatchNoteBalanceChangeSlot (ref), u17 (copy), u13 (copy), u23 (copy), ButtonEffect (ref), u16 (copy)
        u22 = true;
        local u32 = PatchNoteBalancingOverviewSlot:Clone();
        u24 = u24 + 1;
        u32.LayoutOrder = u24;

        for i = 1, 3 do
            local u33 = u2[i];
            local _ = i;

            for _, v in pairs(p31[i + 1] or {}) do
                assert(ItemLibrary.ViewModels[v], v);
                local v34 = PatchNoteBalanceChangeSlot:Clone();
                v34.Button.Label.Icon.Image = u33[2];
                v34.Button.Label.Icon.ImageColor3 = u33[1];
                v34.Button.Background.BackgroundColor3 = u33[1];
                v34.Button.Background.UIStroke.Color = u33[1];
                v34.Button.Graphic.Picture.Image = ItemLibrary.ViewModels[v].ImageCentered or ItemLibrary.Items[v].Image;
                v34.Parent = u32.Slots;
                v34.Button.MouseButton1Click:Connect(function() -- Line: 252
                    -- upvalues: u17 (ref), u13 (ref), u23 (ref), v (copy), u33 (copy)
                    u17:Fire();
                    task.defer(u13.ScrollTo, u13, u23[v], u33[1]);
                end);
                ButtonEffect:Add(v34.Button);
            end;
        end;

        u32.Parent = u13._is_open and u16.Container.Details.Changes or nil;
        table.insert(u13._elements, { u32, u16.Container.Details.Changes });
        local Layout = u32.Slots.Layout;
        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 265, Name: update
            -- upvalues: u32 (copy), Layout (copy)
            u32.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y);
        end);
        u32.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y);
    end;

    local function generate_content_summary(p35) -- Line: 273
        -- upvalues: PatchNoteContentSummarySlot (ref), u24 (ref), RewardSlot (ref), u22 (ref), ItemLibrary (ref), u23 (copy), add_to_collapsed_list (copy), u13 (copy), u16 (copy)
        local v36 = p35[3];

        for i = 1, math.ceil(#v36 / 7) do
            local u37 = PatchNoteContentSummarySlot:Clone();
            u24 = u24 + 1;
            u37.LayoutOrder = u24;
            u37.Slots.Layout.HorizontalAlignment = Enum.HorizontalAlignment[p35[2] or "Center"];
            local _ = i;

            for i2 = (i - 1) * 7 + 1, i * 7 do
                local v38 = v36[i2];
                local v39;

                if v38 then
                    local v40 = typeof(v38) ~= "table" and {
                        Name = v38
                    } or v38;
                    local v41 = RewardSlot.new(v40);
                    v41.Frame.LayoutOrder = i2;
                    v41:SetParent(u37.Slots);

                    if u22 and ItemLibrary.Items[v40.Name] then
                        u23[v40.Name] = u37;
                        v39 = i2;
                    else
                        v39 = i2;
                    end;
                else
                    v39 = i2;
                end;
            end;

            add_to_collapsed_list(u37, nil, 3);
            u37.Parent = u13._is_open and u16.Container.Details.Changes or nil;
            table.insert(u13._elements, { u37, u16.Container.Details.Changes });
            local Layout = u37.Slots.Layout;
            Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 304, Name: update
                -- upvalues: u37 (copy), Layout (copy)
                u37.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y);
            end);
            u37.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y);
        end;
    end;

    local function generate_thumbnail(p42) -- Line: 313
        -- upvalues: PatchNoteThumbnailSlot (ref), u24 (ref), add_to_collapsed_list (copy), u13 (copy), u16 (copy)
        local v43 = p42[2];
        local v44 = p42[3];
        local v45 = PatchNoteThumbnailSlot:Clone();
        u24 = u24 + 1;
        v45.LayoutOrder = u24;
        v45.Thumbnail.Image = v43;
        v45.Title.Text = v44;
        v45.Title.AutoLocalize = false;
        add_to_collapsed_list(v45);
        v45.Parent = u13._is_open and u16.Container.Details.Changes or nil;
        table.insert(u13._elements, { v45, u16.Container.Details.Changes });
    end;

    local function generate_text(p46) -- Line: 327
        -- upvalues: u3 (ref), u19 (ref), u20 (ref), u21 (ref), PatchNoteChangeSlot (ref), u24 (ref), u13 (copy), u16 (copy), u22 (ref), ItemLibrary (ref), WeaponStatusHandler (ref), u23 (copy), add_to_collapsed_list (copy)
        local v47 = p46[1];
        local v48 = p46[2];
        local v49 = u3[v47];
        assert(v49 ~= nil, v47, p46);

        if v47 == "Title" then
            u19 = p46;
            u20 = 0;
            u21 = nil;
        end;

        local v50;

        if v49.NewLine then
            v50 = PatchNoteChangeSlot:Clone();
            u24 = u24 + 1;
            v50.LayoutOrder = u24;
            v50.Text = "";
            v50.Size = UDim2.new(v50.Size.X.Scale, 0, v50.Size.Y.Scale * v49.NewLine, 0);
            v50.AutoLocalize = false;
            v50.Parent = u13._is_open and u16.Container.Details.Changes or nil;
            table.insert(u13._elements, { v50, u16.Container.Details.Changes });
        else
            v50 = nil;
        end;

        local v51 = PatchNoteChangeSlot:Clone();
        u24 = u24 + 1;
        v51.LayoutOrder = u24;
        v51.Text = string.format("%s%s<font weight=\"%s\">%s</font>", string.rep(" ", v49.Spaces), v49.Prefix, v49.Weight, v48);
        v51.TextTransparency = v49.Transparency;
        v51.Size = UDim2.new(v51.Size.X.Scale, 0, v51.Size.Y.Scale * math.ceil(#v48 / 80) * v49.Size, 0);
        v51.AutoLocalize = false;
        v51.Parent = u13._is_open and u16.Container.Details.Changes or nil;
        table.insert(u13._elements, { v51, u16.Container.Details.Changes });

        if u22 and (v47 == "Header" and ItemLibrary.Items[v48]) then
            WeaponStatusHandler:ApplyItemStatusToText(v51, ItemLibrary.Items[v48].Status);
            u23[v48] = v51;
        end;

        add_to_collapsed_list(v51, v50);
    end;

    local function generate(p52) -- Line: 367
        -- upvalues: generate_thumbnail (copy), generate_balancing_overview (copy), generate_content_summary (copy), generate_text (copy)
        local v53 = p52[1];

        if v53 == "Thumbnail" then
            return generate_thumbnail(p52);
        end;

        if v53 == "BalancingOverview" then
            return generate_balancing_overview(p52);
        end;

        if v53 == "ContentSummary" then
            return generate_content_summary(p52);
        end;

        return generate_text(p52);
    end;

    for _, v in pairs(u15.Changes) do
        if typeof(v[1]) == "function" then
            for _, v2 in pairs(v[1](select(2, table.unpack(v)))) do
                local v54 = v2[1];

                if v54 == "Thumbnail" then
                    local v55 = v2[2];
                    local v56 = v2[3];
                    local v57 = PatchNoteThumbnailSlot:Clone();
                    u24 = u24 + 1;
                    v57.LayoutOrder = u24;
                    v57.Thumbnail.Image = v55;
                    v57.Title.Text = v56;
                    v57.Title.AutoLocalize = false;
                    add_to_collapsed_list(v57);
                    local v58;

                    if u13._is_open then
                        v58 = u16.Container.Details.Changes or nil;
                    else
                        v58 = nil;
                    end;

                    v57.Parent = v58;
                    table.insert(u13._elements, { v57, u16.Container.Details.Changes });
                elseif v54 == "BalancingOverview" then
                    generate_balancing_overview(v2);
                elseif v54 == "ContentSummary" then
                    generate_content_summary(v2);
                else
                    generate_text(v2);
                end;
            end;
        else
            local v59 = v[1];

            if v59 == "Thumbnail" then
                local v60 = v[2];
                local v61 = v[3];
                local v62 = PatchNoteThumbnailSlot:Clone();
                u24 = u24 + 1;
                v62.LayoutOrder = u24;
                v62.Thumbnail.Image = v60;
                v62.Title.Text = v61;
                v62.Title.AutoLocalize = false;
                add_to_collapsed_list(v62);
                local v63;

                if u13._is_open then
                    v63 = u16.Container.Details.Changes or nil;
                else
                    v63 = nil;
                end;

                v62.Parent = v63;
                table.insert(u13._elements, { v62, u16.Container.Details.Changes });
            elseif v59 == "BalancingOverview" then
                generate_balancing_overview(v);
            elseif v59 == "ContentSummary" then
                generate_content_summary(v);
            else
                generate_text(v);
            end;
        end;
    end;

    u18 = false;
    u13._is_generating = false;
end;

function u4._UpdateList(p64) -- Line: 395
    p64.CloseButton.Position = UDim2.new(0.975, 0, 0.0225, p64.PageFrame.AbsoluteSize.Y * 0.125);
    p64.List.Position = UDim2.new(0.5, 9, 0, p64.PageFrame.AbsoluteSize.Y * 0.125);
    p64.List.Size = UDim2.new(0.85, 0, 0, p64.PageFrame.AbsoluteSize.Y * 0.75);
    p64.List.CanvasSize = UDim2.new(0, 0, 0, p64.Layout.AbsoluteContentSize.Y);
end;

function u4._UpdateSize(p65) -- Line: 402
    -- upvalues: UILibrary (copy)
    p65.PageContainer.Size = UDim2.new(0, math.min(1000, UILibrary.MainGui.AbsoluteSize.X * 0.875), 1, 0);
end;

function u4._Init(u66) -- Line: 406
    -- upvalues: PlayerDataController (copy), CONSTANTS (copy), ReplicatedStorage (copy), UILibrary (copy), ButtonEffect (copy)
    u66.CloseButton.MouseButton1Click:Connect(function() -- Line: 407
        -- upvalues: PlayerDataController (ref), CONSTANTS (ref), ReplicatedStorage (ref), u66 (copy)
        if PlayerDataController:Get("LastPatchNotesVersion") ~= CONSTANTS.GAME_VERSION then
            ReplicatedStorage.Remotes.Misc.ViewedPatchNotes:FireServer();
        end;

        u66:CloseRequest();
    end);
    u66.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 415
        -- upvalues: u66 (copy)
        u66.List.CanvasSize = UDim2.new(0, 0, 0, u66.Layout.AbsoluteContentSize.Y);
    end);
    u66.List:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line: 419
    end);
    u66.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 425
        -- upvalues: u66 (copy)
        u66:_UpdateList();
    end);
    u66.PageFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 429
        -- upvalues: u66 (copy)
        u66:_UpdateList();
    end);
    u66.ViewMoreButton.MouseButton1Click:Connect(function() -- Line: 433
        -- upvalues: u66 (copy)
        u66:_GenerateNext();
    end);
    UILibrary.MainGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 437
        -- upvalues: u66 (copy)
        u66:_UpdateSize();
    end);
    u66:_UpdateSize();
    u66:_UpdateList();
    task.spawn(u66._GenerateNext, u66);
    ButtonEffect:Add(u66.CloseButton);
    ButtonEffect:Add(u66.ViewMoreButton);
end;

return u4._new();