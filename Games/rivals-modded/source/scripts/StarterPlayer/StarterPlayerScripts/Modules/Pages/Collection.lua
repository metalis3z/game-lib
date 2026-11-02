-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local CosmeticSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("CosmeticSlot"));
local PromptSystem = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("PromptSystem"));
local WeaponSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponSlot"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local CosmeticSlotBubble = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("CosmeticSlotBubble");
local u1 = { "Weapon", "Skin", "Wrap", "Charm", "Finisher", "Emote" };
local u2 = setmetatable({}, Page);
u2.__index = u2;

function u2._new() -- Line: 23
    -- upvalues: Page (copy), u2 (copy), PromptSystem (copy)
    local v3 = Page.new(script.Name);
    local v4 = setmetatable(v3, u2);
    v4.CloseButton = v4.PageFrame:WaitForChild("Close");
    v4.PromptsFrame = v4.PageFrame:WaitForChild("Prompts");
    v4.List = v4.PageFrame:WaitForChild("List");
    v4.Container = v4.List:WaitForChild("Container");
    v4.Layout = v4.Container:WaitForChild("Layout");
    v4.TabsFrame = v4.Container:WaitForChild("Tabs");
    v4.SlotsFrame = v4.Container:WaitForChild("Slots");
    v4.SlotsContainer = v4.SlotsFrame:WaitForChild("Container");
    v4.SlotsLayout = v4.SlotsContainer:WaitForChild("Layout");
    v4.SearchFrame = v4.Container:WaitForChild("Search");
    v4.SearchBox = v4.SearchFrame:WaitForChild("Box");
    v4.LockedSlotsFrame = v4.Container:WaitForChild("LockedSlots");
    v4.LockedSlotsContainer = v4.LockedSlotsFrame:WaitForChild("Container");
    v4.LockedSlotsLayout = v4.LockedSlotsContainer:WaitForChild("Layout");
    v4.Divider = v4.Container:WaitForChild("Divider");
    v4.CurrentTab = nil;
    v4.PromptSystem = PromptSystem.new(v4.PromptsFrame);
    v4._slots = {};
    v4._close_bubbles = {};
    v4._generate_hash = 0;
    v4._search_query = "";
    v4:_Init();

    return v4;
end;

function u2.SetTab(p5, p6) -- Line: 59
    -- upvalues: u1 (copy)
    p5.CurrentTab = p6;

    for _, v in pairs(u1) do
        local v7 = v == p5.CurrentTab;
        local v8 = p5.TabsFrame:WaitForChild(v);
        local Background = v8:WaitForChild("Background");
        v8:WaitForChild("Title").TextColor3 = v7 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255);
        Background.ImageColor3 = v7 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0);
        Background.ImageTransparency = v7 and 0 or 0.25;
        Background:WaitForChild("UIGradient").Enabled = not v7;
    end;

    p5:_Generate();
end;

function u2.Open(p9, ...) -- Line: 77
    -- upvalues: Page (copy)
    Page.Open(p9, ...);
    p9.SearchBox.Text = "";
    p9:_Generate();
end;

function u2.Close(p10) -- Line: 83
    -- upvalues: Page (copy)
    Page.Close(p10);
    p10:_Generate();
end;

function u2._UpdateLayouts(p11) -- Line: 92
    p11.List.CanvasSize = UDim2.new(0, 0, 0, p11.Layout.AbsoluteContentSize.Y);
    p11.List.Active = p11.Layout.AbsoluteContentSize.Y >= p11.List.AbsoluteSize.Y;
    p11.SlotsFrame.Size = UDim2.new(1, 0, 0, p11.SlotsLayout.AbsoluteContentSize.Y);
    p11.SlotsFrame.Visible = p11.SlotsLayout.AbsoluteContentSize.Y > 0;
    p11.LockedSlotsFrame.Size = UDim2.new(1, 0, 0, p11.LockedSlotsLayout.AbsoluteContentSize.Y);
    p11.LockedSlotsFrame.Visible = p11.LockedSlotsLayout.AbsoluteContentSize.Y > 0;
end;

function u2._UpdateSearch(p12, p13) -- Line: 101
    -- upvalues: Utility (copy)
    p13.Frame.Visible = Utility:IsVisibleFromSearch(p12._search_query, table.unpack(p13.SearchArgs));
end;

function u2._BulkUpdateSearch(p14) -- Line: 105
    p14._search_query = string.lower(p14.SearchBox.Text);

    for _, v in pairs(p14._slots) do
        p14:_UpdateSearch(v);
    end;
end;

function u2._CloseBubbles(p15) -- Line: 113
    for _, v in pairs(p15._close_bubbles) do
        v();
    end;
end;

function u2._GenerateWeapons(u16) -- Line: 119
    -- upvalues: PlayerDataController (copy), ShopLibrary (copy), CONSTANTS (copy), ItemLibrary (copy), WeaponSlot (copy), CosmeticSlotBubble (copy), WeaponStatusHandler (copy)
    local _generate_hash = u16._generate_hash;
    local UnlockedWeapons = PlayerDataController:GetUnlockedWeapons();

    for i, v in pairs(ShopLibrary:GetReleasedOwnableWeapons(CONSTANTS.WEAPON_REVEAL_TIME_OFFSET, ShopLibrary.OwnableWeaponsAlphabetized)) do
        if _generate_hash ~= u16._generate_hash then
            return;
        end;

        local u17 = ItemLibrary.Items[v];
        local v18 = ItemLibrary.Statuses[u17.Status];
        local v19 = not UnlockedWeapons[v];
        local u20 = u17.Status .. " " .. u17.Class;
        local u21 = WeaponSlot.new(v);
        u21.Frame.LayoutOrder = i - v18.Value * 999999;
        u21.Frame.Parent = v19 and u16.LockedSlotsContainer or u16.SlotsContainer;

        if v19 then
            u21:Lock();

            if not ShopLibrary:IsWeaponReleased(v) then
                u21:HideName();
            end;
        end;

        local u22 = nil;

        local function update_background() -- Line: 147
            -- upvalues: u22 (ref)
            u22.Background.Size = UDim2.new(0, u22.Title.TextBounds.X + u22.Background.AbsoluteSize.Y, 1, 0);
        end;

        u16._close_bubbles[v] = function() -- Line: 151
            -- upvalues: u21 (copy), u22 (ref)
            u21.Frame.ZIndex = 0;

            if u22 then
                u22:Destroy();
                u22 = nil;
            end;
        end;

        local function open_bubble() -- Line: 160
            -- upvalues: u16 (copy), u21 (copy), u22 (ref), CosmeticSlotBubble (ref), u20 (copy), WeaponStatusHandler (ref), u17 (copy), update_background (copy)
            u16:_CloseBubbles();
            u21.Frame.ZIndex = 1;
            u22 = CosmeticSlotBubble:Clone();
            u22.Title.Text = u20;
            u22.Parent = u21.Frame.Button;
            WeaponStatusHandler:ApplyItemStatusToText(u22.Title, u17.Status);

            local function update() -- Line: 171
                -- upvalues: u22 (ref)
                u22.Background.Size = UDim2.new(0, u22.Title.TextBounds.X + u22.Background.AbsoluteSize.Y, 1, 0);
            end;

            u22.Background:GetPropertyChangedSignal("AbsoluteSize"):Connect(update_background);
            u22.Title:GetPropertyChangedSignal("TextBounds"):Connect(update_background);
            u22.Background.Size = UDim2.new(0, u22.Title.TextBounds.X + u22.Background.AbsoluteSize.Y, 1, 0);
            u22.Size = UDim2.new(0, 0, 0.125, 0);
            u22:TweenSize(UDim2.new(5, 0, 0.25, 0), "Out", "Quint", 0.25, true);
        end;

        u21.Frame.Button.MouseEnter:Connect(open_bubble);
        u21.Frame.Button.MouseButton1Click:Connect(open_bubble);

        if not v19 then
            u16.Divider.Visible = true;
        end;

        local v23 = {
            Object = u21,
            Frame = u21.Frame,
            SearchArgs = {
                u21.Frame.Button.Title.Text,
                u21.Frame.Button.Title,
                u20,
                nil
            }
        };
        table.insert(u16._slots, v23);
        u16:_UpdateSearch(v23);

        if i % 5 == 0 then
            wait(0.03);
        end;
    end;
end;

function u2._GenerateCosmetics(u24) -- Line: 208
    -- upvalues: PlayerDataController (copy), CosmeticLibrary (copy), ShopLibrary (copy), CosmeticSlot (copy), CosmeticSlotBubble (copy)
    local UnlockedWeapons = PlayerDataController:GetUnlockedWeapons();
    local v25 = PlayerDataController:Get("CosmeticInventory");
    local _generate_hash = u24._generate_hash;

    for i, v in pairs(CosmeticLibrary.CosmeticsAlphabetized) do
        if _generate_hash ~= u24._generate_hash then
            return;
        end;

        local u26 = CosmeticLibrary.Cosmetics[v];

        if u26.Type == u24.CurrentTab and (u26.Type ~= "Skin" or (UnlockedWeapons[u26.ItemName] or ShopLibrary:IsWeaponReleased(u26.ItemName))) then
            local u27 = not CosmeticLibrary:OwnsCosmeticForSomething(v25, v);

            if not (u26.Hidden and u27) then
                u24.Divider.Visible = u24.Divider.Visible or not u27;
                local u28 = CosmeticSlot.new(v, u27);
                u28.Frame.LayoutOrder = i - CosmeticLibrary.Rarities[u26.Rarity].Value * 10000 + (u27 and 9999999 or 0);
                u28.Frame.Parent = u27 and u24.LockedSlotsContainer or u24.SlotsContainer;
                local u29 = nil;

                local function u30() -- Line: 242
                    -- upvalues: u29 (ref)
                    u29.Background.Size = UDim2.new(0, u29.Title.TextBounds.X + u29.Background.AbsoluteSize.Y, 1, 0);
                end;

                u24._close_bubbles[v] = function() -- Line: 246
                    -- upvalues: u28 (copy), u29 (ref)
                    u28.Frame.ZIndex = 0;

                    if u29 then
                        u29:Destroy();
                        u29 = nil;
                    end;
                end;

                local function u31() -- Line: 255
                    -- upvalues: u26 (copy), u24 (copy), u28 (copy), u29 (ref), CosmeticSlotBubble (ref), u30 (copy)
                    if not u26.Description then
                        return;
                    end;

                    u24:_CloseBubbles();
                    u28.Frame.ZIndex = 1;
                    u29 = CosmeticSlotBubble:Clone();
                    u29.Title.Text = u26.Description or "";
                    u29.Parent = u28.Frame.Button;

                    local function _() -- Line: 268
                        -- upvalues: u29 (ref)
                        u29.Background.Size = UDim2.new(0, u29.Title.TextBounds.X + u29.Background.AbsoluteSize.Y, 1, 0);
                    end;

                    u29.Title:GetPropertyChangedSignal("TextBounds"):Connect(u30);
                    u29.Background:GetPropertyChangedSignal("AbsoluteSize"):Connect(u30);
                    u29.Background.Size = UDim2.new(0, u29.Title.TextBounds.X + u29.Background.AbsoluteSize.Y, 1, 0);
                    u29.Size = UDim2.new(0, 0, 0.125, 0);
                    u29:TweenSize(UDim2.new(5, 0, 0.25, 0), "Out", "Quint", 0.25, true);
                end;

                u28.Frame.Button.MouseEnter:Connect(u31);
                u28.Frame.Button.MouseButton1Click:Connect(function() -- Line: 282
                    -- upvalues: CosmeticLibrary (ref), u26 (copy), u27 (copy), u24 (copy), v (copy), u31 (copy)
                    if not (CosmeticLibrary.Types[u26.Type].IsWeaponCosmetic and (u26.Type ~= "Skin" and not u27)) then
                        u31();

                        return;
                    end;

                    u24:_CloseBubbles();
                    u24.PromptSystem:Open("InspectCosmetic", v);
                end);
                local v32 = {
                    Object = u28,
                    Frame = u28.Frame,
                    SearchArgs = {
                        u28.Frame.Button.Title.ContentText,
                        u28.Frame.Button.Title,
                        u26.Description,
                        nil
                    }
                };
                table.insert(u24._slots, v32);
                u24:_UpdateSearch(v32);

                if i % 5 == 0 then
                    wait(0.03);
                end;
            end;
        end;
    end;
end;

function u2._Generate(u33) -- Line: 309
    for _, v in pairs(u33._slots) do
        v.Object:Destroy();
    end;

    u33._slots = {};
    u33._close_bubbles = {};
    u33._generate_hash = u33._generate_hash + 1;
    u33.Divider.Visible = false;
    u33:_UpdateLayouts();

    if not u33._is_open then
        return;
    end;

    task.spawn(function() -- Line: 325
        -- upvalues: u33 (copy)
        if u33.CurrentTab == "Weapon" then
            u33:_GenerateWeapons();
        else
            u33:_GenerateCosmetics();
        end;

        u33:_UpdateLayouts();
    end);
end;

function u2._Setup(u34) -- Line: 336
    -- upvalues: u1 (copy), ButtonEffect (copy)
    for _, v in pairs(u1) do
        local v35 = u34.TabsFrame:WaitForChild(v);
        v35.MouseButton1Click:Connect(function() -- Line: 340
            -- upvalues: u34 (copy), v (copy)
            u34:SetTab(v);
        end);
        ButtonEffect:Add(v35);
    end;
end;

function u2._Init(u36) -- Line: 348
    -- upvalues: ButtonEffect (copy)
    u36.CloseButton.MouseButton1Click:Connect(function() -- Line: 349
        -- upvalues: u36 (copy)
        u36:CloseRequest();
    end);
    u36.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 353
        -- upvalues: u36 (copy)
        u36:_UpdateLayouts();
    end);
    u36.SlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 357
        -- upvalues: u36 (copy)
        u36:_UpdateLayouts();
    end);
    u36.LockedSlotsLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 361
        -- upvalues: u36 (copy)
        u36:_UpdateLayouts();
    end);
    u36.SearchBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 365
        -- upvalues: u36 (copy)
        u36:_BulkUpdateSearch();
    end);
    u36:_Setup();
    u36:SetTab("Weapon");
    ButtonEffect:Add(u36.CloseButton);
end;

return u2._new();