-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local EnumLibrary = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("EnumLibrary"));
local Signal = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Signal"));
local ClientPlayerData = require(Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("Modules"):WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientPlayerData"));
local Data = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Data");
local RequestPlayerData = Data:WaitForChild("RequestPlayerData");
local PlayerDataChanged = Data:WaitForChild("PlayerDataChanged");
local PlayerDataAdded = Data:WaitForChild("PlayerDataAdded");
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 16
    -- upvalues: u1 (copy), Signal (copy)
    local v2 = setmetatable({}, u1);
    v2.PlayerDataAdded = Signal.new();
    v2.StatisticsUpdated = Signal.new();
    v2.SettingsSliderChanged = Signal.new();
    v2.CurrentData = nil;
    v2._setting_changed_events = {};
    v2:_Init();

    return v2;
end;

function u1.Get(p3, ...) -- Line: 36
    return p3.CurrentData:Get(...);
end;

function u1.Set(p4, ...) -- Line: 40
    return p4.CurrentData:Set(...);
end;

function u1.GetDataChangedSignal(p5, ...) -- Line: 44
    return p5.CurrentData:GetDataChangedSignal(...);
end;

function u1.GetSetting(p6, ...) -- Line: 48
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage.Modules.PlayerDataUtility):GetSetting(p6, ...);
end;

function u1.GetSettingChangedSignal(p7, ...) -- Line: 53
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage.Modules.PlayerDataUtility):GetSettingChangedSignal(p7, ...);
end;

function u1.SetSetting(p8, ...) -- Line: 58
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage.Modules.PlayerDataUtility):SetSetting(p8, ...);
end;

function u1.IsNosniyGamesTeamMember(p9, ...) -- Line: 63
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage.Modules.PlayerDataUtility):IsNosniyGamesTeamMember(p9, ...);
end;

function u1.GetWeaponData(p10, ...) -- Line: 68
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage.Modules.PlayerDataUtility):GetWeaponData(p10, ...);
end;

function u1.HasGamepass(p11, ...) -- Line: 73
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage.Modules.PlayerDataUtility):HasGamepass(p11, ...);
end;

function u1.GetStatistic(p12, ...) -- Line: 78
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage.Modules.PlayerDataUtility):GetStatistic(p12, ...);
end;

function u1.GetDirectoryStatistic(p13, ...) -- Line: 83
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage.Modules.PlayerDataUtility):GetDirectoryStatistic(p13, ...);
end;

function u1.GetWeaponStatistic(p14, ...) -- Line: 88
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage.Modules.PlayerDataUtility):GetWeaponStatistic(p14, ...);
end;

function u1.GetMapStatistic(p15, ...) -- Line: 93
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage.Modules.PlayerDataUtility):GetMapStatistic(p15, ...);
end;

function u1.GetUnlockedWeapons(p16, ...) -- Line: 98
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage.Modules.PlayerDataUtility):GetUnlockedWeapons(p16, ...);
end;

function u1.AreTasksCompleted(p17, ...) -- Line: 103
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage.Modules.PlayerDataUtility):AreTasksCompleted(p17, ...);
end;

function u1.GetFavoritedWeapons(p18) -- Line: 108
    local v19 = {};

    for _, v in pairs(p18:Get("WeaponInventory")) do
        if v.IsFavorited then
            v19[v.Name] = true;
        end;
    end;

    return v19;
end;

function u1.OwnsAllWeapons(p20, p21, p22, p23) -- Line: 120
    -- upvalues: ReplicatedStorage (copy)
    local ItemLibrary = require(ReplicatedStorage.Modules.ItemLibrary);
    local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
    local v24 = 0;
    local v25 = 0;

    for _, v in pairs(ShopLibrary:GetReleasedOwnableWeapons()) do
        if (not p21 or ItemLibrary.Items[v].Status == p21) and ((not p23 or ShopLibrary:IsWeaponReleased(v)) and (not p22 or ShopLibrary.Weapons[v].KeyPrice)) then
            v24 = v24 + 1;
        end;
    end;

    for _, v in pairs(p20:Get("WeaponInventory")) do
        if not p21 or ItemLibrary.Items[v.Name].Status == p21 then
            local v26 = not p23 or ShopLibrary:IsWeaponReleased(v.Name);

            if v26 and (not p22 or ShopLibrary.Weapons[v.Name] and ShopLibrary.Weapons[v.Name].KeyPrice) then
                v25 = v25 + 1;
            end;
        end;
    end;

    return v24 <= v25;
end;

function u1.GetNumTasksCompleted(p27, p28) -- Line: 156
    local v29 = 0;

    for _, v in pairs(p27:Get(p28 or "Tasks")) do
        if v.Completed then
            v29 = v29 + 1;
        end;
    end;

    return v29;
end;

function u1.IsEmoteEquipped(p30, p31) -- Line: 168
    for _, v in pairs(p30:Get("EquippedEmotes")) do
        if v.Name == p31 then
            return true;
        end;
    end;
end;

function u1.SilenceCosmeticNotification(p32, p33, p34) -- Line: 176
    -- upvalues: ReplicatedStorage (copy)
    if not p33 then
        p32.CurrentData:SetReplicate("CosmeticNotifications", {});
        ReplicatedStorage.Remotes.Data.SilenceCosmeticNotification:FireServer(nil, nil);

        return;
    end;

    local v35 = p32:Get("CosmeticNotifications");

    if p34 then
        if typeof(v35[p33]) == "table" then
            v35[p33][p34] = nil;
            p32.CurrentData:Replicate("CosmeticNotifications");
            ReplicatedStorage.Remotes.Data.SilenceCosmeticNotification:FireServer(p33, p34);
        end;

        return;
    end;

    v35[p33] = nil;
    p32.CurrentData:Replicate("CosmeticNotifications");
    ReplicatedStorage.Remotes.Data.SilenceCosmeticNotification:FireServer(p33, nil);
end;

function u1.WaitUntilLoaded(p36) -- Line: 196
    if not p36.CurrentData then
        p36.PlayerDataAdded:Wait();
    end;
end;

function u1._PlayerDataChanged(p37, p38, ...) -- Line: 207
    -- upvalues: EnumLibrary (copy), ReplicatedStorage (copy)
    local CurrentData = p37.CurrentData;

    if not CurrentData then
        return;
    end;

    EnumLibrary:WaitForEnumBuilder();
    local v39 = EnumLibrary:FromEnum(p38) or p38;

    if v39 == "DataValueChanged" then
        CurrentData:SetReplicate(...);

        return;
    end;

    if v39 == "BulkDataValueChanged" then
        for _, v in pairs((...)) do
            CurrentData:SetReplicate(v[1], v[2]);
        end;

        return;
    end;

    if v39 == "StatisticsBatchUpdate" then
        local StatisticsLibrary = require(ReplicatedStorage.Modules.StatisticsLibrary);
        local v40 = ...;

        for i, v in pairs(v40[utf8.char(0)] or {}) do
            CurrentData:Set(CurrentData:FromEnum(i), v);
        end;

        for i, v in pairs(StatisticsLibrary.STATISTICS_DIRECTORY_INFO) do
            local table_unpack_ret, _ = table.unpack(v);
            local v41 = p37:Get(table_unpack_ret);

            for i2, v2 in pairs(v40[utf8.char(0 + i)] or {}) do
                local v42 = CurrentData:FromEnum(i2);
                v41[v42] = v41[v42] or {};

                for i3, v3 in pairs(v2) do
                    v41[v42][CurrentData:FromEnum(i3)] = v3;
                end;
            end;
        end;

        p37.StatisticsUpdated:Fire();

        return;
    end;

    if v39 ~= "WeaponDataChanged" then
        if v39 == "BatchUpdateWeaponXP" then
            local v43 = false;

            for _, v in pairs((...)) do
                local WeaponData = p37:GetWeaponData(CurrentData:FromEnum(v[utf8.char(0)]));

                if WeaponData then
                    WeaponData.Level = v[utf8.char(1)];
                    WeaponData.XP = v[utf8.char(2)];
                    v43 = true;
                end;
            end;

            if v43 then
                CurrentData:Replicate("WeaponInventory");

                return;
            end;
        else
            if v39 == "SettingChanged" then
                p37:SetSetting(...);

                return;
            end;

            if v39 == "AddReceipt" then
                local v44 = CurrentData:Get("Receipts");
                table.insert(v44, (...));
                CurrentData:Replicate("Receipts");

                return;
            end;

            CurrentData:ReplicateFromServer(v39, ...);
        end;

        return;
    end;

    local v45 = CurrentData:Get("WeaponInventory");
    local v46 = ...;

    for i, v in pairs(v45) do
        if v.Name == v46.Name then
            v45[i] = v46;
            break;
        end;
    end;

    CurrentData:Replicate("WeaponInventory");
end;

function u1._CreatePlayerData(p47, p48) -- Line: 296
    -- upvalues: ClientPlayerData (copy)
    local v49 = typeof(p48) == "table";
    local v50 = "Argument 1 invalid, expected a table, got " .. tostring(p48);
    assert(v49, v50);
    local v51 = ClientPlayerData.new(p48);
    p47.CurrentData = v51;
    p47.PlayerDataAdded:Fire(v51);
end;

function u1._RequestPlayerData(p52) -- Line: 304
    -- upvalues: RequestPlayerData (copy)
    local v53 = RequestPlayerData:InvokeServer();

    if not v53 then
        return;
    end;

    p52:_CreatePlayerData(v53);
end;

function u1._Init(u54) -- Line: 314
    -- upvalues: PlayerDataChanged (copy), PlayerDataAdded (copy)
    PlayerDataChanged.OnClientEvent:Connect(function(...) -- Line: 315
        -- upvalues: u54 (copy)
        u54:_PlayerDataChanged(...);
    end);
    PlayerDataAdded.OnClientEvent:Connect(function(...) -- Line: 319
        -- upvalues: u54 (copy)
        u54:_CreatePlayerData(...);
    end);
    task.spawn(u54._RequestPlayerData, u54);
end;

return u1._new();