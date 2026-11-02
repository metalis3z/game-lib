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
local WeaponStatusHandler = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("WeaponStatusHandler"));
local ButtonEffect = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ButtonEffect"));
local VoteBanFrame = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("VoteBanFrame"));
local Page = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("Page"));
local PickWeaponRandomListSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PickWeaponRandomListSlot");
local PickWeaponListChosenSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PickWeaponListChosenSlot");
local PickWeaponListSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("PickWeaponListSlot");
local u1 = setmetatable({}, Page);
u1.__index = u1;

function u1._new() -- Line: 27
    -- upvalues: Page (copy), u1 (copy)
    local v2 = Page.new(script.Name);
    local v3 = setmetatable(v2, u1);
    v3.ChosenWeaponsFrame = v3.PageFrame:WaitForChild("ChosenWeapons");
    v3.HeaderFrame = v3.PageFrame:WaitForChild("Header");
    v3.FreeWeaponsFrame = v3.HeaderFrame:WaitForChild("FreeWeapons");
    v3.MapFrame = v3.HeaderFrame:WaitForChild("Map");
    v3.MapTitle = v3.MapFrame:WaitForChild("Title");
    v3.ListContainer = v3.PageFrame:WaitForChild("ListContainer");
    v3.List = v3.ListContainer:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3.LastPickedDivider = v3.Container:WaitForChild("LastPickedDivider");
    v3.CantBeClosedFromInputs = true;
    v3._current_slot = 1;
    v3._chosen_weapons = {};
    v3._chosen_weapon_slots = {};
    v3._pick_weapon_slots = {};
    v3._ban_frames = {};
    v3:_Init();

    return v3;
end;

function u1.SetCurrentSlot(u4, p5) -- Line: 59
    -- upvalues: ItemLibrary (copy), FighterController (copy), Utility (copy), PlayerDataController (copy), PickWeaponListSlot (copy), ButtonEffect (copy), WeaponStatusHandler (copy), VoteBanFrame (copy), PickWeaponRandomListSlot (copy)
    u4._chosen_weapon_slots[u4._current_slot].Button.Hover.Visible = false;
    u4._current_slot = p5;
    u4.ChosenWeaponsFrame:TweenPosition(UDim2.new(0.5 - 0.125 * (u4._current_slot - 1), 0, 0.1, 0), "Out", "Quint", 0.25, true);
    u4._chosen_weapon_slots[u4._current_slot].Button.Hover.Visible = true;
    u4._chosen_weapon_slots[u4._current_slot].Button.Background.ImageTransparency = 0;
    u4._chosen_weapon_slots[u4._current_slot].Button.Hover.Size = UDim2.new(1.5, 0, 1.5, 0);
    u4._chosen_weapon_slots[u4._current_slot].Button.Hover:TweenSize(UDim2.new(1, 8, 1, 8), "Out", "Back", 0.25, true);

    for _, v in pairs(u4._pick_weapon_slots) do
        v:Destroy();
    end;

    u4._pick_weapon_slots = {};
    u4.LastPickedDivider.Visible = false;
    local v6 = {};

    for _, v in pairs(ItemLibrary.ItemsAlphabetized) do
        local v7 = ItemLibrary.Items[v];

        if v7.Class == ItemLibrary.SlotToClass[u4._current_slot].Name or FighterController.LocalFighter:Get("WeaponClassRestrictionDisabled") then
            table.insert(v6, v7);
        end;
    end;

    table.sort(v6, function(p8, p9) -- Line: 87
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

                local v18 = PickWeaponListSlot:Clone();
                v18.LayoutOrder = v17 and -3 or i * 2;
                v18.ZIndex = v18.LayoutOrder;
                v18.Button.Icon.Picture.Image = WeaponData and ItemLibrary:GetViewModelImageFromWeaponData(WeaponData) or (ItemLibrary:GetViewModelImage(v.Name) or "");
                v18.Button.Title.Text = v.Name;
                v18.Parent = u4.Container;
                ButtonEffect:Add(v18.Button, nil, {
                    HoverRatio = 1.025,
                    ReleaseRatio = 1.025
                });
                table.insert(u4._pick_weapon_slots, v18);
                WeaponStatusHandler:ApplyItemStatusToText(v18.Button.Title, v.Status);

                if v16 then
                    v18.Button.Icon.ClipsDescendants = true;
                    v18.Button.Title.Visible = false;
                    local v19 = VoteBanFrame.new(v18.Button, UDim2.new(1, 0, 0.9, 0));
                    table.insert(u4._ban_frames, v19);
                    v19.CreateSound:Connect(function(...) -- Line: 140
                        -- upvalues: Utility (ref)
                        Utility:CreateSound(...);
                    end);
                    task.delay(v13 * 0.125, v19.Play, v19, nil, true);
                    v13 = v13 + 1;
                else
                    v18.Button.MouseButton1Click:Connect(function() -- Line: 147
                        -- upvalues: u4 (copy), v (copy)
                        u4:_InputPickWeapon(v.Name);
                    end);
                    table.insert(u14, v.Name);
                end;

                u4.LastPickedDivider.Visible = u4.LastPickedDivider.Visible or v17;
            end;
        end;
    end;

    if #u14 > 1 then
        local v20 = PickWeaponRandomListSlot:Clone();
        v20.LayoutOrder = -1;
        v20.Parent = u4.Container;
        ButtonEffect:Add(v20.Button, nil, {
            HoverRatio = 1.025,
            ReleaseRatio = 1.025
        });
        table.insert(u4._pick_weapon_slots, v20);
        v20.Button.MouseButton1Click:Connect(function() -- Line: 164
            -- upvalues: u4 (copy), u14 (copy)
            u4:_InputPickWeapon(u14[math.random(#u14)]);
        end);
    end;

    table.sort(u4._pick_weapon_slots, function(p21, p22) -- Line: 169
        return p21.LayoutOrder < p22.LayoutOrder;
    end);

    for i, v in pairs(u4._pick_weapon_slots) do
        v.Button.Size = UDim2.new(0.75, 0, 1, 0);
        v.Button:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Back", 0.05 * i, true);
    end;

    local List = u4.List;
    local v23;

    if FighterController.LocalFighter:Get("WeaponClassRestrictionDisabled") then
        v23 = u4.List.CanvasPosition;
    else
        v23 = Vector2.new(0, 0);
    end;

    List.CanvasPosition = v23;
end;

function u1.PickWeapon(p24, p25, p26) -- Line: 182
    -- upvalues: PlayerDataController (copy), ItemLibrary (copy)
    local WeaponData = PlayerDataController:GetWeaponData(p26);
    p24._chosen_weapons[p25] = p26;
    p24._chosen_weapon_slots[p25].Button.Picture.Image = WeaponData and ItemLibrary:GetViewModelImageFromWeaponData(WeaponData) or (ItemLibrary:GetViewModelImage(p26) or "");
end;

function u1.Finish(p27) -- Line: 189
    -- upvalues: DuelController (copy), Players (copy), ReplicatedStorage (copy), ControlsController (copy), GamepadService (copy)
    local Duel = DuelController:GetDuel(Players.LocalPlayer);

    if Duel and (Duel.LocalDueler and Duel.LocalDueler:GetStaggeredSpawnsTurn()) then
        ReplicatedStorage.Remotes.Duels.PickWeaponsAheadOfTime:FireServer(p27._chosen_weapons);
    else
        ReplicatedStorage.Remotes.Replication.Fighter.PickWeapons:FireServer(p27._chosen_weapons);
    end;

    p27.Closed:Fire();

    if ControlsController.CurrentControls == "Gamepad" then
        GamepadService:DisableGamepadCursor();
    end;
end;

function u1.Start(u28) -- Line: 205
    -- upvalues: FighterController (copy), PickWeaponListChosenSlot (copy), ButtonEffect (copy), ControlsController (copy), GamepadService (copy)
    u28:Clear();

    for i = 1, FighterController.LocalFighter:GetMaxEquippableWeapons() do
        local v29 = PickWeaponListChosenSlot:Clone();
        v29.LayoutOrder = i;
        v29.Parent = u28.ChosenWeaponsFrame;
        ButtonEffect:Add(v29.Button);
        u28._chosen_weapon_slots[i] = v29;
        v29.Button.MouseButton1Click:Connect(function() -- Line: 215
            -- upvalues: i (copy), u28 (copy)
            if i == 1 or u28._chosen_weapons[i - 1] then
                u28:SetCurrentSlot(i);
            end;
        end);
        local _ = i;
    end;

    u28:SetCurrentSlot(1);

    if ControlsController.CurrentControls == "Gamepad" then
        GamepadService:EnableGamepadCursor(u28.ChosenWeaponsFrame);
    end;

    u28:_UpdateMap();
    u28:_UpdateFreeWeapons();
end;

function u1.Clear(p30) -- Line: 232
    for _, v in pairs(p30._chosen_weapon_slots) do
        v:Destroy();
    end;

    for _, v in pairs(p30._pick_weapon_slots) do
        v:Destroy();
    end;

    for _, v in pairs(p30._ban_frames) do
        v:Destroy();
    end;

    p30._current_slot = 1;
    p30._chosen_weapons = {};
    p30._chosen_weapon_slots = {};
    p30._pick_weapon_slots = {};
    p30._ban_frames = {};
end;

function u1.Open(p31, ...) -- Line: 252
    -- upvalues: Page (copy)
    Page.Open(p31, ...);
    p31:Start();
end;

function u1._InputPickWeapon(p32, p33) -- Line: 261
    -- upvalues: FighterController (copy)
    p32:PickWeapon(p32._current_slot, p33);

    if p32._current_slot == FighterController.LocalFighter:GetMaxEquippableWeapons() then
        p32:Finish();

        return;
    end;

    p32:SetCurrentSlot(p32._current_slot + 1);
end;

function u1._UpdateFreeWeapons(p34) -- Line: 271
    -- upvalues: FFlagController (copy)
    p34.FreeWeaponsFrame.Visible = FFlagController:IsFreeWeaponsActive();
    p34.MapFrame.Size = p34.FreeWeaponsFrame.Visible and UDim2.new(1, 0, 1.5, 0) or UDim2.new(1, 0, 1, 0);
    p34.MapTitle.Size = p34.FreeWeaponsFrame.Visible and UDim2.new(0.875, 0, 0.467, 0) or UDim2.new(0.875, 0, 0.7, 0);
    p34:_UpdateMap();
end;

function u1._UpdateMap(p35) -- Line: 278
    -- upvalues: DuelController (copy), Players (copy), FighterController (copy)
    local Duel = DuelController:GetDuel(Players.LocalPlayer);
    local v36 = Duel and Duel.Map and Duel.Map.Name;
    local v37 = FighterController.LocalFighter and FighterController.LocalFighter:Get("IsInShootingRange");
    local v38;

    if v36 or v37 then
        v38 = not p35.FreeWeaponsFrame.Visible;
    else
        v38 = v37;
    end;

    p35.MapFrame.Visible = v38;
    p35.MapTitle.Text = v36 and "Map: " .. v36 or (v37 and "Try out any weapon here for free!" or "");
end;

function u1._Init(u39) -- Line: 288
    u39.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 289
        -- upvalues: u39 (copy)
        u39.List.CanvasSize = UDim2.new(0, 0, 0, u39.Layout.AbsoluteContentSize.Y);
    end);
    u39.List:GetPropertyChangedSignal("CanvasPosition"):Connect(function() -- Line: 293
        -- upvalues: u39 (copy)
        u39.ListContainer.ClipsDescendants = u39.List.CanvasPosition.Y > 5;
    end);
end;

return u1._new();