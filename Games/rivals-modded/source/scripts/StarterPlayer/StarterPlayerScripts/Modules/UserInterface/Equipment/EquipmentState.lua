-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local Signal = require(ReplicatedStorage.Modules.Signal);
local u1 = CONSTANTS.DEFAULT_WEAPONS[1];
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 13
    -- upvalues: u2 (copy), Signal (copy)
    local v4 = setmetatable({}, u2);
    v4.SelectedWeaponChanged = Signal.new();
    v4.CareerPageOpened = Signal.new();
    v4.CareerPageOpened = Signal.new();
    v4.CustomizingChanged = Signal.new();
    v4.CustomizingStateChanged = Signal.new();
    v4.CosmeticSearchChanged = Signal.new();
    v4.Equipment = p3;
    v4.SelectedWeapon = nil;
    v4.IsCareerPageOpen = false;
    v4.CustomizingType = nil;
    v4.SelectedCosmetic = nil;
    v4.CosmeticInverted = nil;
    v4.CosmeticSearchQuery = "";
    v4:_Init();

    return v4;
end;

function u2.SelectWeapon(p5, p6) -- Line: 42
    -- upvalues: ItemLibrary (copy)
    assert(not p6 or ItemLibrary.Items[p6] ~= nil, p6);

    if p6 then
        p5:OpenCareerPage(false);
    end;

    p5.SelectedWeapon = p6;
    p5.SelectedWeaponChanged:Fire();
end;

function u2.OpenCareerPage(p7, p8) -- Line: 53
    local v9 = typeof(p8) == "boolean";
    assert(v9);

    if p8 then
        p7:SelectWeapon(nil);
    end;

    p7.IsCareerPageOpen = p8;
    p7.CareerPageOpened:Fire();
end;

function u2.StartCustomizing(p10, p11) -- Line: 64
    -- upvalues: CosmeticLibrary (copy), u1 (copy)
    local v12 = CosmeticLibrary.Types[p11];
    local v13 = not p11;

    if not v13 then
        if v12 then
            v13 = not v12.NotCosmetic;
        else
            v13 = v12;
        end;
    end;

    assert(v13);

    if p11 then
        p10:OpenCareerPage(p11 == "Emote");
        local v14;

        if v12.IsWeaponCosmetic then
            v14 = p10.SelectedWeapon or (u1 or nil);
        else
            v14 = nil;
        end;

        p10:SelectWeapon(v14);
    else
        p10:SelectCosmetic(nil);
        p10:SetCosmeticInvertedState(nil);
        p10:SetCosmeticSearchQuery(nil);
    end;

    p10.CustomizingType = p11;
    p10.CustomizingChanged:Fire();
end;

function u2.SelectCosmetic(p15, p16) -- Line: 82
    -- upvalues: CosmeticLibrary (copy)
    assert(not p16 or ((p16 == "NONE_COSMETIC" or p16 == "RANDOM_COSMETIC") and true or CosmeticLibrary.Cosmetics[p16] ~= nil), p16);

    if p16 == "NONE_COSMETIC" then
        p16 = nil;
    end;

    p15.SelectedCosmetic = p16;
    p15.CustomizingStateChanged:Fire();
end;

function u2.SetCosmeticInvertedState(p17, p18) -- Line: 89
    p17.CosmeticInverted = p18;
    p17.CustomizingStateChanged:Fire();
end;

function u2.SetCosmeticSearchQuery(p19, p20) -- Line: 94
    p19.CosmeticSearchQuery = p20 and string.lower(p20) or "";
    p19.CosmeticSearchChanged:Fire();
end;

function u2.OnOpen(p21) -- Line: 99
    -- upvalues: u1 (copy)
    if p21.Equipment.IsOpen then
        p21:SelectWeapon(p21.SelectedWeapon or u1);

        return;
    end;

    p21:StartCustomizing(nil);
end;

function u2._Init(p22) -- Line: 111
end;

return u2;