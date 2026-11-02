-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local LocalizationService = game:GetService("LocalizationService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local UserService = game:GetService("UserService");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController"));
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 13
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._is_fetching_user_info = {};
    v2._user_info_cache = {};
    v2:_Init();

    return v2;
end;

function u1.IsChina(p3, p4) -- Line: 28
    -- upvalues: PlayerDataController (copy)
    local v5 = p4 or PlayerDataController:Get("PolicyInfo");

    return not v5 or v5.IsSubjectToChinaPolicies;
end;

function u1.IsExternalReferencesAllowed(p6, p7) -- Line: 34
    -- upvalues: PlayerDataController (copy)
    local v8 = PlayerDataController:Get("PolicyInfo");
    local v9 = v8 and not p6:IsChina() and table.find(v8.AllowedExternalLinkReferences, p7 or "YouTube");

    return v9;
end;

function u1.ArePaidRandomItemsRestricted(p10, p11) -- Line: 40
    -- upvalues: PlayerDataController (copy)
    local v12 = p11 or PlayerDataController:Get("PolicyInfo");

    return not v12 or (v12.ArePaidRandomItemsRestricted or p10:IsChina(v12));
end;

function u1.IsPaidItemTradingAllowed(p13) -- Line: 46
    -- upvalues: PlayerDataController (copy)
    local v14 = PlayerDataController:Get("PolicyInfo");

    if v14 then
        v14 = v14.IsPaidItemTradingAllowed;
    end;

    return v14;
end;

function u1.UserIDsAllowed(p15) -- Line: 52
    return not p15:IsChina();
end;

function u1.UsernamesAllowed(p16) -- Line: 56
    return not p16:IsChina();
end;

function u1.UseDisplayNames(p17) -- Line: 60
    return true;
end;

function u1.GetName(p18, p19) -- Line: 65
    -- upvalues: Utility (copy)
    return Utility:GetName(p19, p18:UseDisplayNames() and p19.DisplayName or p19.Name);
end;

function u1.GetUserInfos(p20, p21, p22) -- Line: 69
    if not p22 then
        return p20:_GetUserInfos(p21);
    end;

    local v23 = {};
    local v24 = {};

    for i, v in pairs(p21) do
        if i <= p22 then
            table.insert(v23, v);
        else
            table.insert(v24, v);
        end;
    end;

    local v25 = {};

    for _, v in pairs({ v23, v24 }) do
        for i, v2 in pairs(p20:_GetUserInfos(v)) do
            v25[i] = v2;
        end;
    end;

    return v25;
end;

function u1._GetUserInfos(p26, p27) -- Line: 101
    -- upvalues: UserService (copy)
    local v28 = {};

    for _, v in pairs(p27) do
        if not (p26._user_info_cache[tostring(v)] or p26._is_fetching_user_info[tostring(v)]) then
            table.insert(v28, v);
        end;
    end;

    for _, v in pairs(v28) do
        p26._is_fetching_user_info[tostring(v)] = true;
    end;

    local success, result = pcall(UserService.GetUserInfosByUserIdsAsync, UserService, v28);

    for _, v in pairs(v28) do
        p26._is_fetching_user_info[tostring(v)] = nil;
    end;

    if not success then
        return {};
    end;

    for _, v in pairs(result) do
        p26._user_info_cache[tostring(v.Id)] = v;
    end;

    local v29 = {};

    for _, v in pairs(p27) do
        v29[tostring(v)] = p26._user_info_cache[tostring(v)] or nil;
    end;

    for _, v in pairs(result) do
        v29[tostring(v.Id)] = v;
    end;

    return v29;
end;

function u1._BlacklistedObject(p30, p31) -- Line: 152
    if p30._country_code == p31:GetAttribute("CountryCode") then
        task.defer(p31.Destroy, p31);
    end;
end;

function u1._WhitelistedObject(p32, p33) -- Line: 158
    if p32._country_code ~= p33:GetAttribute("CountryCode") then
        task.defer(p33.Destroy, p33);
    end;
end;

function u1._SetupLocaleObjects(u34) -- Line: 164
    -- upvalues: LocalizationService (copy), Players (copy), CollectionService (copy)
    local success, result = pcall(LocalizationService.GetCountryRegionForPlayerAsync, LocalizationService, Players.LocalPlayer);

    if success then
        u34._country_code = result;
    else
        warn("Failed to fetch country code, error:", result);
    end;

    CollectionService:GetInstanceAddedSignal("RegionHideThisObject"):Connect(function(p35) -- Line: 173
        -- upvalues: u34 (copy)
        u34:_BlacklistedObject(p35);
    end);
    CollectionService:GetInstanceAddedSignal("RegionShowThisObject"):Connect(function(p36) -- Line: 177
        -- upvalues: u34 (copy)
        u34:_WhitelistedObject(p36);
    end);

    for _, v in pairs(CollectionService:GetTagged("RegionHideThisObject")) do
        task.defer(u34._BlacklistedObject, u34, v);
    end;

    for _, v in pairs(CollectionService:GetTagged("RegionShowThisObject")) do
        task.defer(u34._WhitelistedObject, u34, v);
    end;
end;

function u1._Init(p37) -- Line: 190
    task.defer(p37._SetupLocaleObjects, p37);
end;

return u1._new();