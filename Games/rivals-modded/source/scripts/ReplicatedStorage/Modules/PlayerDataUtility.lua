-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local Signal = require(ReplicatedStorage.Modules.Signal);
local MonetizationLibrary = require(ReplicatedStorage.Modules.MonetizationLibrary);
local StatisticsLibrary = require(ReplicatedStorage.Modules.StatisticsLibrary);
local SettingsLibrary = require(ReplicatedStorage.Modules.SettingsLibrary);
local SeasonLibrary = require(ReplicatedStorage.Modules.SeasonLibrary);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 13
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2:_Init();

    return v2;
end;

function u1.GetRobuxSpent(p3, p4, p5, p6) -- Line: 25
    -- upvalues: MonetizationLibrary (copy)
    local v7 = 0;

    for _, v in pairs(p4 or {}) do
        v7 = v7 + (v.CurrencySpent or 0);
    end;

    for i, v in pairs(p5 or {}) do
        v7 = v7 + (v and (MonetizationLibrary.Gamepasses[i] and MonetizationLibrary.Gamepasses[i].StaticRobuxPrice) or 0);
    end;

    for _, v in pairs(p6 or {}) do
        v7 = v7 + (v.CurrencySpentTotal or 0);
    end;

    return v7;
end;

function u1.GetSetting(p8, p9, p10, p11) -- Line: 43
    -- upvalues: SettingsLibrary (copy)
    local v12 = SettingsLibrary:DoesExist(p10);
    assert(v12, p10);

    return p9:Get("Settings")[p11 or p9:Get("SettingsProfile")][p10];
end;

function u1.GetSettingChangedSignal(u13, u14, p15) -- Line: 49
    -- upvalues: SettingsLibrary (copy), Signal (copy)
    local v16 = SettingsLibrary:DoesExist(p15);
    assert(v16, p15);

    if not next(u14._setting_changed_events) then
        local u17 = u14:Get("SettingsProfile");

        local function update_bulk(p18) -- Line: 55
            -- upvalues: u14 (copy), u13 (copy), u17 (ref)
            local v19 = u14:Get("SettingsProfile");

            for i, v in pairs(u14._setting_changed_events) do
                local v20;

                if p18 then
                    v20 = u13:GetSetting(u14, i, u17);
                else
                    v20 = nil;
                end;

                local v21;

                if p18 then
                    v21 = u13:GetSetting(u14, i, v19);
                else
                    v21 = nil;
                end;

                if p18 then
                    local v22;

                    if typeof(v20) == "number" and typeof(v21) == "number" then
                        v22 = math.abs(v20 - v21) < 0.001;
                    else
                        v22 = v20 == v21;
                    end;

                    if not v22 then
                        v:FireDeferred();
                    end;
                else
                    v:FireDeferred();
                end;
            end;

            u17 = v19;
        end;

        u14:GetDataChangedSignal("SettingsProfile"):Connect(function() -- Line: 76
            -- upvalues: update_bulk (copy)
            update_bulk(true);
        end);
        u14:GetDataChangedSignal("Settings"):Connect(function() -- Line: 80
            -- upvalues: update_bulk (copy)
            update_bulk();
        end);
    end;

    if not u14._setting_changed_events[p15] then
        u14._setting_changed_events[p15] = Signal.new();
    end;

    return u14._setting_changed_events[p15];
end;

function u1.SetSetting(p23, p24, p25, p26, p27) -- Line: 92
    -- upvalues: SettingsLibrary (copy)
    local v28 = SettingsLibrary:DoesExist(p25);
    assert(v28, p25);
    p24:Get("Settings")[p27 or p24:Get("SettingsProfile")][p25] = p26;

    if p24.ReplicateToClient then
        p24.ReplicateToClient:Fire("SettingChanged", p25, p26, p27);
    end;

    if p24._setting_changed_events[p25] then
        p24._setting_changed_events[p25]:Fire(p26, p25);
    end;
end;

function u1.IsNosniyGamesTeamMemberRaw(p29, p30) -- Line: 106
    -- upvalues: CONSTANTS (copy)
    if p30 then
        p30 = table.find(p30, CONSTANTS.TEAM_GROUP_ROLE_ID);
    end;

    return p30;
end;

function u1.IsNosniyGamesTeamMember(p31, p32) -- Line: 110
    return p31:IsNosniyGamesTeamMemberRaw(p32:Get("GroupRoleIDs"));
end;

function u1.GetWeaponData(p33, p34, p35) -- Line: 114
    for i, v in pairs(p34:Get("WeaponInventory")) do
        if v.Name == p35 then
            return v, i;
        end;
    end;
end;

function u1.HasGamepass(p36, p37, p38) -- Line: 122
    return p37:Get("Gamepasses")[p38];
end;

function u1.AreTasksCompleted(p39, p40, p41) -- Line: 126
    for _, v in pairs(p40:Get(p41 or "Tasks")) do
        if not v.Completed then
            return false;
        end;
    end;

    return true;
end;

function u1.GetUnlockedWeapons(p42, p43, p44) -- Line: 136
    local v45 = {};

    for _, v in pairs(p43:Get("WeaponInventory")) do
        v45[v.Name] = true;
    end;

    if not p44 then
        for i in pairs(p43:Get("FreeWeaponUnlockCheck")) do
            v45[i] = true;
        end;
    end;

    return v45;
end;

function u1.GetStatistic(p46, p47, p48) -- Line: 152
    -- upvalues: StatisticsLibrary (copy)
    local v49 = StatisticsLibrary.Info[p48];
    assert(v49 ~= nil, p48);

    return p47:Get(p48) or v49.DefaultValue;
end;

function u1.GetDirectoryStatistic(p50, u51, u52, u53, p54, p55) -- Line: 160
    -- upvalues: StatisticsLibrary (copy)
    local u56 = StatisticsLibrary.Info[p54];
    assert(u56 ~= nil, p54);
    local u57 = 0;

    local function add(p58) -- Line: 167
        -- upvalues: u51 (copy), u52 (copy), u53 (copy), u56 (copy), u57 (ref)
        local v59 = u51:Get(u52);
        local v60 = v59[u53] and v59[u53][p58] or u56.DefaultValue;

        if u56.ValueType == "number" then
            v60 = u57 + v60;
        end;

        u57 = v60;
    end;

    local v61 = u51:Get(u52);
    local v62 = v61[u53] and v61[u53][p54] or u56.DefaultValue;

    if u56.ValueType == "number" then
        u57 = u57 + v62;
    else
        u57 = v62;
    end;

    for _, v in pairs(p55 or {}) do
        local v63 = u51:Get(u52);
        local v64 = v63[u53] and v63[u53][v] or u56.DefaultValue;

        if u56.ValueType == "number" then
            u57 = u57 + v64;
        else
            u57 = v64;
        end;
    end;

    return u57;
end;

function u1.GetSeasonInfo(p65, p66, p67) -- Line: 182
    -- upvalues: SeasonLibrary (copy)
    local v68 = p66:Get("Seasons")[p67];

    if v68 then
        v68 = v68.RankedPerformances[SeasonLibrary.UNIVERSAL_ELO_NAME];
    end;

    local v69;

    if v68 then
        v69 = v68.CurrentELO;
    else
        v69 = v68;
    end;

    return v69, v68 and v68.Metadata and v68.Metadata.FinalLeaderboardRank;
end;

function u1.GetWeaponStatistic(p70, p71, ...) -- Line: 191
    return p70:GetDirectoryStatistic(p71, "WeaponStatistics", ...);
end;

function u1.GetMapStatistic(p72, p73, ...) -- Line: 195
    return p72:GetDirectoryStatistic(p73, "MapStatistics", ...);
end;

function u1._Init(p74) -- Line: 203
end;

return u1._new();