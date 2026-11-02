-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local BetterDebris = require(ReplicatedStorage.Modules.BetterDebris);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local CosmeticSlot = require(Players.LocalPlayer.PlayerScripts.Modules.CosmeticSlot);
local CosmeticSlotNotification = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("CosmeticSlotNotification");
local CosmeticSlotEmpty = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("CosmeticSlotEmpty");
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 23
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Customize = p2;
    v3.List = v3.Customize.BottomContainer:WaitForChild("List");
    v3.Container = v3.List:WaitForChild("Container");
    v3.Layout = v3.Container:WaitForChild("Layout");
    v3._cosmetic_slots = {};
    v3._empty_cosmetic_slots = {};
    v3._generate_hash = 0;
    v3:_Init();

    return v3;
end;

function u1.OnCustomizingStateChanged(p4) -- Line: 44
    p4:_BulkUpdateEquipped();
    p4:_BulkUpdateSearch();
end;

function u1.OnStateChanged(p5) -- Line: 49
    p5:_BulkUpdateEquipped();
    task.defer(p5._Generate, p5);
end;

function u1._UpdateFavorited(p6, p7) -- Line: 58
    -- upvalues: PlayerDataController (copy), CosmeticLibrary (copy)
    local v8 = PlayerDataController:Get("FavoritedCosmetics");
    local SelectedWeapon = p6.Customize.Interface.Equipment:GetSelectedWeapon();
    local CustomizingType = p6.Customize.Interface.Equipment:GetCustomizingType();
    local v9 = v8[SelectedWeapon] and v8[SelectedWeapon][CosmeticLibrary:GetNoneSpecificCosmeticName(p7, CustomizingType)];
    p6._cosmetic_slots[p7].Frame.Button.Favorited.Visible = v9;
    p6._cosmetic_slots[p7].Frame.LayoutOrder = p6._cosmetic_slots[p7].OriginalLayoutOrder + (v9 and -9999999 or 0);
    p6._cosmetic_slots[p7].Frame.ZIndex = p6._cosmetic_slots[p7].Frame.LayoutOrder;
end;

function u1._BulkUpdateFavorited(p10) -- Line: 69
    for i in pairs(p10._cosmetic_slots) do
        p10:_UpdateFavorited(i);
    end;
end;

function u1._UpdateSearch(p11, p12) -- Line: 75
    -- upvalues: CosmeticLibrary (copy), Utility (copy)
    local v13 = CosmeticLibrary.Cosmetics[p12];

    if v13 then
        v13 = v13.GetDescription(false);
    end;

    p11._cosmetic_slots[p12].Frame.Visible = p12 == "NONE_COSMETIC" and true or Utility:IsVisibleFromSearch(p11.Customize.Interface.Equipment:GetCosmeticSearchQuery(), p11._cosmetic_slots[p12].Frame.Button.Title.ContentText, p11._cosmetic_slots[p12].Frame.Button.Title, v13, nil);
end;

function u1._BulkUpdateSearch(p14) -- Line: 86
    for i in pairs(p14._cosmetic_slots) do
        p14:_UpdateSearch(i);
    end;
end;

function u1._IsEquipped(p15, p16) -- Line: 92
    -- upvalues: PlayerDataController (copy)
    local SelectedWeapon = p15.Customize.Interface.Equipment:GetSelectedWeapon();
    local CustomizingType = p15.Customize.Interface.Equipment:GetCustomizingType();

    if CustomizingType == "Emote" then
        if p16 == "NONE_COSMETIC" then
            return false;
        end;

        return PlayerDataController:IsEmoteEquipped(p16);
    end;

    local WeaponData = PlayerDataController:GetWeaponData(SelectedWeapon);

    if WeaponData then
        WeaponData = WeaponData[CustomizingType];
    end;

    if p16 == "NONE_COSMETIC" then
        return not WeaponData;
    end;

    if WeaponData then
        WeaponData = p16 == WeaponData.Name;
    end;

    return WeaponData;
end;

function u1._UpdateEquipped(p17, p18) -- Line: 109
    p17._cosmetic_slots[p18].Frame.Button.Equipped.Visible = p17:_IsEquipped(p18);
end;

function u1._BulkUpdateEquipped(p19) -- Line: 113
    if not p19.Customize.Interface.Equipment.IsOpen then
        return;
    end;

    for i in pairs(p19._cosmetic_slots) do
        p19:_UpdateEquipped(i);
    end;
end;

function u1._Cleanup(p20) -- Line: 124
    -- upvalues: BetterDebris (copy)
    local v21 = 0;

    for _, v in pairs(p20._cosmetic_slots) do
        v.Frame.Parent = nil;
        BetterDebris:AddItem(v, v21 * 0.1);
        v21 = v21 + 1;
    end;

    for _, v in pairs(p20._empty_cosmetic_slots) do
        v:Destroy();
    end;

    p20._cosmetic_slots = {};
    p20._empty_cosmetic_slots = {};
    p20._generate_hash = p20._generate_hash + 1;
end;

function u1._Generate(u22) -- Line: 148
    -- upvalues: CosmeticLibrary (copy), PlayerDataController (copy), CosmeticSlot (copy), CosmeticSlotNotification (copy), ItemLibrary (copy), ReplicatedStorage (copy), CosmeticSlotEmpty (copy)
    u22:_Cleanup();
    u22._generate_hash = u22._generate_hash + 1;
    local _generate_hash = u22._generate_hash;
    local SelectedWeapon = u22.Customize.Interface.Equipment:GetSelectedWeapon();
    local SelectedCosmetic = u22.Customize.Interface.Equipment:GetSelectedCosmetic();
    local CustomizingType = u22.Customize.Interface.Equipment:GetCustomizingType();
    local u23 = CustomizingType and CosmeticLibrary.Types[CustomizingType] and CosmeticLibrary.Types[CustomizingType].IsWeaponCosmetic;
    local v24 = PlayerDataController:Get("CosmeticNotifications");
    local v25 = PlayerDataController:Get("CosmeticInventory");

    if not (CustomizingType and (not u23 or SelectedWeapon)) then
        return;
    end;

    local v26 = 0;
    local v27 = {};

    for i, v in pairs(CosmeticLibrary.CosmeticsAlphabetized) do
        local v28 = CosmeticLibrary.Cosmetics[v];

        if v28.Type == CustomizingType and (CustomizingType ~= "Skin" and true or v28.ItemName == SelectedWeapon) then
            local v29 = CosmeticLibrary:HasNotification(v24, v, SelectedWeapon);
            local v30 = not CosmeticLibrary:OwnsCosmetic(v25, v, SelectedWeapon);
            local v31 = u22:_IsEquipped(v);
            v26 = v26 + (v30 and 0 or 1);
            table.insert(v27, {
                Name = v,
                HasNotification = v29 or false,
                IsLocked = v30,
                IsEquipped = v31,
                AlphabeticalValue = i
            });
        end;
    end;

    table.sort(v27, function(p32, p33) -- Line: 192
        -- upvalues: CosmeticLibrary (ref)
        local IsEquipped = p32.IsEquipped;

        if IsEquipped ~= p33.IsEquipped then
            return IsEquipped;
        end;

        local IsLocked = p32.IsLocked;

        if IsLocked ~= p33.IsLocked then
            return not IsLocked;
        end;

        local HasNotification = p32.HasNotification;

        if HasNotification ~= p33.HasNotification then
            return HasNotification;
        end;

        local Value = CosmeticLibrary.Rarities[CosmeticLibrary.Cosmetics[p32.Name].Rarity].Value;
        local Value2 = CosmeticLibrary.Rarities[CosmeticLibrary.Cosmetics[p33.Name].Rarity].Value;

        if Value == Value2 then
            return p32.AlphabeticalValue < p33.AlphabeticalValue;
        end;

        return Value2 < Value;
    end);

    if not (SelectedCosmetic or (CustomizingType ~= "Emote" or next(PlayerDataController:Get("EquippedEmotes")))) then
        u22.Customize.Interface.Equipment:SelectCosmetic("Take The L");
    end;

    local u34 = CustomizingType == "Emote" and 1 or 5;
    local u35 = 0;

    local function generate_slot(u36, u37, p38) -- Line: 233
        -- upvalues: CosmeticLibrary (ref), CosmeticSlot (ref), u35 (ref), u22 (copy), CosmeticSlotNotification (ref), PlayerDataController (ref), ItemLibrary (ref), SelectedWeapon (copy), u23 (copy), ReplicatedStorage (ref), CustomizingType (copy), u34 (copy)
        local v39 = CosmeticLibrary.Cosmetics[u36];

        if v39 and (v39.Hidden and u37) then
            return;
        end;

        local v40 = CosmeticSlot.new(u36, u37);
        v40.OriginalLayoutOrder = u35 + (v39 and 0 or -999999999) + (v39 and u22:_IsEquipped(u36) and -99999999 or 0);
        v40.Frame.LayoutOrder = v40.OriginalLayoutOrder;
        v40.Frame.Parent = u22.Container;
        u22._cosmetic_slots[u36] = v40;
        u35 = u35 + 1;
        u22:_UpdateSearch(u36);
        u22:_UpdateEquipped(u36);
        u22:_UpdateFavorited(u36);
        local u41;

        if p38 then
            u41 = CosmeticSlotNotification:Clone();
            u41.Parent = v40.Frame.Button;
        else
            u41 = nil;
        end;

        v40.Frame.Button.MouseButton1Click:Connect(function() -- Line: 264
            -- upvalues: u41 (ref), PlayerDataController (ref), u36 (copy), ItemLibrary (ref), SelectedWeapon (ref), u22 (ref), u37 (copy), u23 (ref), ReplicatedStorage (ref), CustomizingType (ref)
            if u41 then
                u41:Destroy();
                u41 = nil;
                PlayerDataController:SilenceCosmeticNotification(u36, ItemLibrary.Items[SelectedWeapon] and SelectedWeapon or nil);
            end;

            u22.Customize.Interface.Equipment:SelectCosmetic(u36);

            if SelectedWeapon and (not u37 and u23) then
                local WeaponData = PlayerDataController:GetWeaponData(SelectedWeapon);
                local v42;

                if u36 == "NONE_COSMETIC" then
                    v42 = nil;
                else
                    v42 = u36;
                end;

                ReplicatedStorage.Remotes.Data.EquipCosmetic:FireServer(SelectedWeapon, CustomizingType, v42, {
                    IsInverted = WeaponData and (WeaponData.Wrap and WeaponData.Wrap.Inverted) or nil
                });
            end;
        end);

        if not u22.Customize.Interface.Equipment:GetSelectedCosmetic() and u22:_IsEquipped(u36) then
            u22.Customize.Interface.Equipment:SelectCosmetic(u36);
        end;

        if u35 % u34 == 0 then
            wait(0.06);
        end;
    end;

    if u23 then
        generate_slot("NONE_COSMETIC", false);

        if _generate_hash ~= u22._generate_hash then
            return;
        end;
    end;

    if u23 and v26 > 0 then
        generate_slot("RANDOM_COSMETIC", false);

        if _generate_hash ~= u22._generate_hash then
            return;
        end;
    end;

    for _, v in pairs(v27) do
        generate_slot(v.Name, v.IsLocked, v.HasNotification);

        if _generate_hash ~= u22._generate_hash then
            return;
        end;
    end;

    for i = 1, 11 do
        local v43 = CosmeticSlotEmpty:Clone();
        v43.LayoutOrder = 999999999;
        v43.Parent = u22.Container;
        table.insert(u22._empty_cosmetic_slots, v43);
        local _ = i;
    end;
end;

function u1._Init(u44) -- Line: 332
    -- upvalues: PlayerDataController (copy)
    u44.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() -- Line: 333
        -- upvalues: u44 (copy)
        u44.List.CanvasSize = UDim2.new(0, u44.Layout.AbsoluteContentSize.X, 0, 0);
    end);
    u44.Customize.Interface.Equipment.CosmeticSearchChanged:Connect(function() -- Line: 337
        -- upvalues: u44 (copy)
        u44:_BulkUpdateSearch();
    end);
    PlayerDataController:GetDataChangedSignal("WeaponInventory"):Connect(function() -- Line: 341
        -- upvalues: u44 (copy)
        u44:_BulkUpdateEquipped();
    end);
    PlayerDataController:GetDataChangedSignal("EquippedEmotes"):Connect(function() -- Line: 345
        -- upvalues: u44 (copy)
        u44:_BulkUpdateEquipped();
    end);
    PlayerDataController:GetDataChangedSignal("CosmeticInventory"):Connect(function() -- Line: 349
        -- upvalues: u44 (copy)
        u44:_BulkUpdateEquipped();
    end);
    PlayerDataController:GetDataChangedSignal("FavoritedCosmetics"):Connect(function() -- Line: 353
        -- upvalues: u44 (copy)
        u44:_BulkUpdateFavorited();
    end);
end;

return u1;