-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local CosmeticLibrary = require(ReplicatedStorage.Modules.CosmeticLibrary);
local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 13
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2:_Init();

    return v2;
end;

function u1.GetCareerLevelsRewardMilestone(p3) -- Line: 25
    return 10;
end;

function u1.GetCareerLevelsRewardData(p4) -- Line: 29
    return {
        Name = "Experience",
        Weapon = "IsRandom",
        Quantity = 1
    };
end;

function u1.GetCostToLevelUp(p5, p6, p7) -- Line: 33
    local v8 = not p7 and 0 or p7 / p5:GetXPRequiredToLevelUp(p6);
    local math_floor_ret = math.floor(10 * (1 - v8));

    return math.clamp(math_floor_ret, 1, 10);
end;

function u1.GetCostToRefreshDailyShop(p9, p10) -- Line: 38
    -- The shop is free in this place (the original: math.min(24, 3 * 2 ^ p10) keys).
    return 0;
end;

function u1.GetNextWeaponLevelReward(p11, p12, p13) -- Line: 42
    for i = p12 + 1, 99 do
        local WeaponLevelReward = p11:GetWeaponLevelReward(i, p13);

        if WeaponLevelReward then
            return WeaponLevelReward, i;
        end;

        local _ = i;
    end;
end;

function u1.GetWeaponLevelReward(p14, p15, p16) -- Line: 52
    if p15 == 5 then
        return {
            Name = "Key",
            Quantity = 1
        };
    end;

    if p15 == 50 then
        return {
            Name = "White",
            Weapon = p16
        };
    end;

    if p15 == 99 then
        return {
            Name = "Black",
            Weapon = p16
        };
    end;

    if p15 % 10 == 0 then
        return;
    end;

    local _ = p15 % 5 == 0;
end;

function u1.GetXPRequiredToLevelUp(p17, p18) -- Line: 66
    local v19 = 5 + 4 * (p18 - 1) + (math.min(p18, 99) / 40) ^ 2 * 100;
    local math_floor_ret = math.floor(v19);

    return math.max(50, math_floor_ret);
end;

function u1.GetRecoverStreakCost(p20, p21) -- Line: 70
    return math.clamp(5 * 2 ^ p21, 1, 100);
end;

function u1.CanCosmeticBeEarnedRandomly(p22, p23, p24, p25) -- Line: 74
    -- upvalues: CosmeticLibrary (copy), ShopLibrary (copy), ItemLibrary (copy), CONSTANTS (copy)
    local v26 = CosmeticLibrary.Cosmetics[p23];

    for _, v in pairs(v26.Type == "Skin" and { v26.ItemName } or ShopLibrary.OwnableWeapons) do
        if (v26.Type ~= "Finisher" or ItemLibrary.Items[v].CanEliminate) and ((p25[v] or ShopLibrary:IsWeaponReleased(v, CONSTANTS.WEAPON_EARLY_ACCESS_TIME_OFFSET)) and not CosmeticLibrary:OwnsCosmetic(p24, p23, v)) then
            return true;
        end;
    end;
end;

function u1.GetWeightedLootboxOutcome(p27, p28) -- Line: 93
    local v29 = 0;
    local v30 = {};

    for _, v in pairs(p28) do
        v29 = v29 + v.Weight;
        table.insert(v30, { v.Weight, v.Reward });
    end;

    table.sort(v30, function(p31, p32) -- Line: 102
        return p31[1] < p32[1];
    end);
    local v33 = math.random() * v29;
    local v34 = 0;

    for i, v in pairs(v30) do
        v34 = v34 + v[1];

        if v33 < v34 or i == #v30 then
            return v[2];
        end;
    end;

    return v30[#v30] or nil;
end;

function u1.GetLootboxPossibilities(u35, p36, u37, u38, u39, p40) -- Line: 120
    -- upvalues: CosmeticLibrary (copy), ShopLibrary (copy), CONSTANTS (copy)
    if not p36 then
        return u37, {}, {};
    end;

    local u41 = p40 or "IsRandom";
    local u42 = {};
    local u43 = {};
    local u44 = {};

    local function attempt_cosmetic(p45, p46) -- Line: 132
        -- upvalues: CosmeticLibrary (ref), u39 (copy), ShopLibrary (ref), CONSTANTS (ref), u43 (ref), u41 (copy), u35 (copy), u38 (copy), u44 (ref), u42 (copy)
        local Name = p45.Reward.Name;
        local v47 = CosmeticLibrary.Cosmetics[Name];

        if v47.Type == "Skin" and not (u39[v47.ItemName] or ShopLibrary:IsWeaponReleased(v47.ItemName, CONSTANTS.WEAPON_EARLY_ACCESS_TIME_OFFSET)) then
            return;
        end;

        if v47.ItemName and not p46 and not u39[v47.ItemName] then
            table.insert(u43, p45);

            return;
        end;

        local v48;

        if u41 == "IsRandom" then
            v48 = not u35:CanCosmeticBeEarnedRandomly(Name, u38, u39);
        elseif u41 == "IsUniversal" then
            v48 = CosmeticLibrary:OwnsCosmeticUniversally(u38, Name);
        else
            v48 = CosmeticLibrary:OwnsCosmetic(u38, Name, u41);
        end;

        if v48 then
            table.insert(u44, p45);

            return;
        end;

        table.insert(u42, p45);
    end;

    local function attempt_reward(p49) -- Line: 161
        -- upvalues: CosmeticLibrary (ref), u39 (copy), u44 (ref), u42 (copy)
        local Name = p49.Reward.Name;

        if CosmeticLibrary.Rewards[Name].Type ~= "Weapon" then
            table.insert(u42, p49);

            return;
        end;

        if u39[Name] then
            table.insert(u44, p49);

            return;
        end;

        table.insert(u42, p49);
    end;

    local function populate(p50) -- Line: 179
        -- upvalues: u37 (copy), CosmeticLibrary (ref), attempt_cosmetic (copy), u39 (copy), u44 (ref), u42 (copy)
        for _, v in pairs(u37) do
            if CosmeticLibrary.Cosmetics[v.Reward.Name] then
                attempt_cosmetic(v, p50);
            elseif CosmeticLibrary.Rewards[v.Reward.Name] then
                local Name = v.Reward.Name;

                if CosmeticLibrary.Rewards[Name].Type == "Weapon" then
                    if u39[Name] then
                        table.insert(u44, v);
                    else
                        table.insert(u42, v);
                    end;
                else
                    table.insert(u42, v);
                end;
            else
                assert(false, v.Reward.Name);
            end;
        end;
    end;

    populate();

    if #u42 == 0 then
        u43 = {};
        u44 = {};
        populate(true);
    end;

    return u42, u43, u44;
end;

function u1.GetUnlockedWeaponsForSelection(p51, p52, p53, u54, u55) -- Line: 202
    -- upvalues: CosmeticLibrary (copy), ItemLibrary (copy), ShopLibrary (copy), CONSTANTS (copy)
    local function is_valid_option(p56) -- Line: 203
        -- upvalues: u54 (copy), CosmeticLibrary (ref), u55 (copy), ItemLibrary (ref)
        if not u54 then
            return true;
        end;

        local v57 = CosmeticLibrary.Cosmetics[u54];
        local v58 = not CosmeticLibrary:OwnsCosmetic(u55, u54, p56);
        local v59;

        if v57.Type == "Skin" and p56 ~= v57.ItemName then
            v59 = true;
        elseif v57.Type == "Finisher" then
            v59 = not ItemLibrary.Items[p56].CanEliminate;
        else
            v59 = false;
        end;

        if v58 then
            v58 = not v59;
        end;

        return v58;
    end;

    local v60 = {};

    for _, v in pairs(p52) do
        local Name = v.Name;
        local v61;

        if u54 then
            local v62 = CosmeticLibrary.Cosmetics[u54];
            v61 = not CosmeticLibrary:OwnsCosmetic(u55, u54, Name);
            local v63;

            if v62.Type == "Skin" and Name ~= v62.ItemName then
                v63 = true;
            elseif v62.Type == "Finisher" then
                v63 = not ItemLibrary.Items[Name].CanEliminate;
            else
                v63 = false;
            end;

            if v61 then
                v61 = not v63;
            end;
        else
            v61 = true;
        end;

        if v61 then
            table.insert(v60, v.Name);
        end;
    end;

    if #v60 > 0 then
        return v60;
    end;

    if not p53 then
        return {};
    end;

    local v64 = {};

    for _, v in pairs(ShopLibrary:GetReleasedOwnableWeapons(CONSTANTS.WEAPON_EARLY_ACCESS_TIME_OFFSET)) do
        local v65;

        if u54 then
            local v66 = CosmeticLibrary.Cosmetics[u54];
            v65 = not CosmeticLibrary:OwnsCosmetic(u55, u54, v);
            local v67;

            if v66.Type == "Skin" and v ~= v66.ItemName then
                v67 = true;
            elseif v66.Type == "Finisher" then
                v67 = not ItemLibrary.Items[v].CanEliminate;
            else
                v67 = false;
            end;

            if v65 then
                v65 = not v67;
            end;
        else
            v65 = true;
        end;

        if v65 then
            table.insert(v64, v);
        end;
    end;

    return v64;
end;

function u1.GetRandomUnlockedWeapon(p68, ...) -- Line: 242
    local UnlockedWeaponsForSelection = p68:GetUnlockedWeaponsForSelection(...);

    if UnlockedWeaponsForSelection and #UnlockedWeaponsForSelection ~= 0 then
        return UnlockedWeaponsForSelection[math.random(#UnlockedWeaponsForSelection)];
    end;

    return nil;
end;

function u1._Init(p69) -- Line: 256
end;

return u1._new();