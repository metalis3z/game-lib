-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GamepadService = game:GetService("GamepadService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.CONSTANTS);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
require(ReplicatedStorage.Modules.ShopLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local ControlsController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("ControlsController"));
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FighterController"));
local FFlagController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("FFlagController"));
local DuelController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("DuelController"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local WeaponSlot = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponSlot"));
local UILibrary = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("UILibrary"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local PickWeaponRandomSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PickWeaponRandomSlot");
local PickWeaponChosenSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PickWeaponChosenSlot");
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 26
    -- upvalues: Page (copy), u1 (copy), UILibrary (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.ChosenWeaponsFrame = v3.PageFrame:WaitForChild("ChosenWeapons");
    v3.HeaderFrame = v3.PageFrame:WaitForChild("Header");
    v3.FreeWeaponsFrame = v3.HeaderFrame:WaitForChild("FreeWeapons");
    v3.MapFrame = v3.HeaderFrame:WaitForChild("Map");
    v3.MapTitle = v3.MapFrame:WaitForChild("Title");
    v3.List = v3.PageFrame:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.CantBeClosedFromInputs = true;
    v3._current_slot = 1;
    v3._chosen_weapons = {};
    v3._chosen_weapon_slots = {};
    v3._weapon_slot_cleanup = {};
    v3._ban_frames = {};
    v3._mainframe = UILibrary:GetTo("MainFrame");
    v3:_Init();

    return v3;
end;

function u1.SetCurrentSlot(u4, p5) -- Line: 57
    -- upvalues: ItemLibrary (copy), FighterController (copy), Utility (copy), PlayerDataController (copy), WeaponSlot (copy), PickWeaponRandomSlot (copy), ButtonEffect (copy)
    u4._chosen_weapon_slots[u4._current_slot].Button.Hover.Visible = false;
    u4._current_slot = p5;
    u4._chosen_weapon_slots[u4._current_slot].Button.Hover.Visible = true;
    u4._chosen_weapon_slots[u4._current_slot].Button.Background.ImageTransparency = 0;
    u4._chosen_weapon_slots[u4._current_slot].Button.Hover.Size = UDim2.new(1.5, 0, 1.5, 0);
    u4._chosen_weapon_slots[u4._current_slot].Button.Hover:TweenSize(UDim2.new(1, 8, 1, 8), "Out", "Back", 0.25, true);

    for _, v in pairs(u4._weapon_slot_cleanup) do
        v:Destroy();
    end;

    u4._weapon_slot_cleanup = {};
    local v6 = {};

    for _, v in pairs(ItemLibrary.ItemsAlphabetized) do
        local v7 = ItemLibrary.Items[v];

        if v7.Class == ItemLibrary.SlotToClass[u4._current_slot].Name or FighterController.LocalFighter:Get("WeaponClassRestrictionDisabled") then
            table.insert(v6, v7);
        end;
    end;

    table.sort(v6, function(p8, p9) -- Line: 83
        -- upvalues: ItemLibrary (ref), Utility (ref)
        local v10 = ItemLibrary.Items[p8.Name];
        local v11 = ItemLibrary.Items[p9.Name];

        if v10.Class ~= v11.Class then
            return ItemLibrary.Classes[v10.Class].Slot < ItemLibrary.Classes[v11.Class].Slot;
        end;

        if v10.Status == v11.Status then
            return Utility:StringLessThan(p8.Name, p9.Name);
        end;

        return ItemLibrary.Statuses[v10.Status].Value > ItemLibrary.Statuses[v11.Status].Value;
    end);
    local v12 = FighterController.LocalFighter and FighterController.LocalFighter:Get("LastPickedWeapons");
    local v13 = 0;
    local u14 = {};

    for i, v in pairs(v6) do
        if FighterController.LocalFighter then
            local v15 = FighterController.LocalFighter:Get("WeaponPool");
            local v16;

            if FighterController.LocalFighter:Get("WeaponPoolFilterType") == "Blacklist" then
                v16 = table.find(v15, v.Name);
            else
                v16 = false;
            end;

            if FighterController.LocalFighter and (FighterController.LocalFighter:CanUseWeapon(v.Name) or v16) then
                local WeaponData = PlayerDataController:GetWeaponData(v.Name);
                local v17;

                if v12 then
                    v17 = table.find(v12, v.Name) ~= nil;
                else
                    v17 = v12;
                end;

                local v18 = WeaponSlot.new(v.Name, WeaponData);
                v18.Frame.LayoutOrder = v17 and -999999998 or i;
                v18.Frame.Parent = u4.Container;
                table.insert(u4._weapon_slot_cleanup, v18);
                v18.PlayBanFrameSound:Connect(function(...) -- Line: 123
                    -- upvalues: Utility (ref)
                    Utility:CreateSound(...);
                end);

                if v16 then
                    v18:ToggleBanned(v13 * 0.125, nil);
                    v13 = v13 + 1;
                else
                    v18.Frame.Button.MouseButton1Click:Connect(function() -- Line: 131
                        -- upvalues: u4 (copy), v (copy)
                        u4:_InputPickWeapon(v.Name);
                    end);
                    table.insert(u14, v.Name);
                end;
            end;
        end;
    end;

    if #u14 > 1 then
        local v19 = PickWeaponRandomSlot:Clone();
        v19.LayoutOrder = -9999999999;
        v19.Parent = u4.Container;
        ButtonEffect:Add(v19.Button);
        table.insert(u4._weapon_slot_cleanup, v19);
        v19.Button.MouseButton1Click:Connect(function() -- Line: 146
            -- upvalues: u4 (copy), u14 (copy)
            u4:_InputPickWeapon(u14[math.random(#u14)]);
        end);
    end;

    local List = u4.List;
    local v20;

    if FighterController.LocalFighter:Get("WeaponClassRestrictionDisabled") then
        v20 = u4.List.CanvasPosition;
    else
        v20 = Vector2.new(0, 0);
    end;

    List.CanvasPosition = v20;
end;

function u1.PickWeapon(p21, p22, p23) -- Line: 155
    -- upvalues: PlayerDataController (copy), ItemLibrary (copy)
    local WeaponData = PlayerDataController:GetWeaponData(p23);
    p21._chosen_weapons[p22] = p23;
    p21._chosen_weapon_slots[p22].Button.Picture.Image = WeaponData and ItemLibrary:GetViewModelImageFromWeaponData(WeaponData) or (ItemLibrary:GetViewModelImage(p23) or "");
end;

function u1.Finish(p24) -- Line: 162
    -- upvalues: DuelController (copy), Players (copy), ReplicatedStorage (copy), ControlsController (copy), GamepadService (copy)
    local Duel = DuelController:GetDuel(Players.LocalPlayer);

    if Duel and (Duel.LocalDueler and Duel.LocalDueler:GetStaggeredSpawnsTurn()) then
        ReplicatedStorage.Remotes.Duels.PickWeaponsAheadOfTime:FireServer(p24._chosen_weapons);
    else
        ReplicatedStorage.Remotes.Replication.Fighter.PickWeapons:FireServer(p24._chosen_weapons);
    end;

    p24.Closed:Fire();

    if ControlsController.CurrentControls == "Gamepad" then
        GamepadService:DisableGamepadCursor();
    end;
end;

function u1.Start(u25) -- Line: 178
    -- upvalues: FighterController (copy), PickWeaponChosenSlot (copy), ButtonEffect (copy), ControlsController (copy), GamepadService (copy)
    u25:Clear();

    for i = 1, FighterController.LocalFighter:GetMaxEquippableWeapons() do
        local v26 = PickWeaponChosenSlot:Clone();
        v26.LayoutOrder = i;
        v26.Parent = u25.ChosenWeaponsFrame;
        ButtonEffect:Add(v26.Button);
        u25._chosen_weapon_slots[i] = v26;
        v26.Button.MouseButton1Click:Connect(function() -- Line: 188
            -- upvalues: i (copy), u25 (copy)
            if i == 1 or u25._chosen_weapons[i - 1] then
                u25:SetCurrentSlot(i);
            end;
        end);
        local _ = i;
    end;

    u25:SetCurrentSlot(1);

    if ControlsController.CurrentControls == "Gamepad" then
        GamepadService:EnableGamepadCursor(u25.ChosenWeaponsFrame);
    end;

    u25:_UpdateMap();
    u25:_UpdateFreeWeapons();
end;

function u1.Clear(p27) -- Line: 205
    for _, v in pairs(p27._chosen_weapon_slots) do
        v:Destroy();
    end;

    for _, v in pairs(p27._weapon_slot_cleanup) do
        v:Destroy();
    end;

    for _, v in pairs(p27._ban_frames) do
        v:Destroy();
    end;

    p27._current_slot = 1;
    p27._chosen_weapons = {};
    p27._chosen_weapon_slots = {};
    p27._weapon_slot_cleanup = {};
    p27._ban_frames = {};
end;

function u1.Open(p28, ...) -- Line: 225
    -- upvalues: Page (copy)
    Page.Open(p28, ...);
    p28:Start();
end;

function u1._UpdateList(p29) -- Line: 234
    p29.List.CanvasSize = UDim2.new(0, 0, 0, p29.Layout.AbsoluteContentSize.Y);
    p29.List.ClipsDescendants = p29.List.CanvasPosition.Y > 5;
    p29.List.Size = UDim2.new(1, 0, 0, p29._mainframe.AbsolutePosition.Y + p29._mainframe.AbsoluteSize.Y - p29.List.AbsolutePosition.Y);
end;

function u1._InputPickWeapon(p30, p31) -- Line: 240
    -- upvalues: FighterController (copy)
    p30:PickWeapon(p30._current_slot, p31);

    if p30._current_slot == FighterController.LocalFighter:GetMaxEquippableWeapons() then
        p30:Finish();

        return;
    end;

    p30:SetCurrentSlot(p30._current_slot + 1);
end;

function u1._UpdateFreeWeapons(p32) -- Line: 250
    -- upvalues: FFlagController (copy)
    p32.FreeWeaponsFrame.Visible = FFlagController:IsFreeWeaponsActive();
    p32:_UpdateMap();
end;

function u1._UpdateMap(p33) -- Line: 255
    -- upvalues: DuelController (copy), Players (copy), FighterController (copy)
    local Duel = DuelController:GetDuel(Players.LocalPlayer);
    local v34 = Duel and Duel.Map and Duel.Map.Name;
    local v35 = FighterController.LocalFighter and FighterController.LocalFighter:Get("IsInShootingRange");
    local v36;

    if v34 or v35 then
        v36 = not p33.FreeWeaponsFrame.Visible;
    else
        v36 = v35;
    end;

    p33.MapFrame.Visible = v36;
    p33.MapTitle.Text = v34 and "Map: " .. v34 or (v35 and "Try out any weapon here for free!" or "");
end;

function u1._Init(u37) -- Line: 265
    u37.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 266
        -- upvalues: u37 (copy)
        u37:_UpdateList();
    end);
    u37.List:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line: 270
        -- upvalues: u37 (copy)
        u37:_UpdateList();
    end);
    u37:_UpdateList();
end;

return u1._new();