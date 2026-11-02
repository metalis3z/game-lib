-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
require(ReplicatedStorage.Modules.CosmeticLibrary);
require(ReplicatedStorage.Modules.ItemLibrary);
local ShopLibrary = require(ReplicatedStorage.Modules.ShopLibrary);
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local LobbyController = require(Players.LocalPlayer.PlayerScripts.Controllers.LobbyController);
local LooseWeaponDisplay = require(Players.LocalPlayer.PlayerScripts.Modules.LooseWeaponDisplay);
local LobbyElement = require(Players.LocalPlayer.PlayerScripts.Modules.LobbyElement);
local u1 = setmetatable({}, LobbyElement);
u1.__index = u1;

function u1._new(...) -- Line: 17
    -- upvalues: LobbyElement (copy), u1 (copy)
    local v2 = LobbyElement.new(...);
    local v3 = setmetatable(v2, u1);
    v3.Displays = {};
    v3:_Init();

    return v3;
end;

function u1.Shuffle(p4) -- Line: 31
    -- upvalues: PlayerDataController (copy), ShopLibrary (copy), CONSTANTS (copy)
    local v5 = {};

    for _, v in pairs(PlayerDataController:Get("WeaponInventory")) do
        v5[v.Name] = true;
    end;

    local v6 = {};

    for _, v in pairs(ShopLibrary:GetReleasedOwnableWeapons(CONSTANTS.WEAPON_EARLY_ACCESS_TIME_OFFSET, ShopLibrary.OwnableWeaponsAlphabetized)) do
        if not v5[v] then
            local math_random_ret = math.random(1, #v6 + 1);
            table.insert(v6, math_random_ret, v);
        end;
    end;

    local v7 = {};

    for i = 1, #p4.Displays do
        local math_random_ret = math.random(1, #v7 + 1);
        table.insert(v7, math_random_ret, i);
        local _ = i;
    end;

    for _, v in pairs(v7) do
        p4.Displays[v]:ChangeWeapon(p4:_VerifyLooseWeaponDisplayWeapon(table.remove(v6, 1)));
    end;
end;

function u1.Update(p8, p9) -- Line: 58
    for _, v in pairs(p8.Displays) do
        v:Update(p9);
    end;
end;

function u1._VerifyLooseWeaponDisplayWeapon(p10, p11) -- Line: 68
    -- upvalues: PlayerDataController (copy)
    if p11 and not PlayerDataController:GetWeaponData(p11) then
        return p11;
    end;

    return nil;
end;

function u1._ObjectAdded(p12, p13) -- Line: 72
    -- upvalues: LooseWeaponDisplay (copy)
    local v14 = LooseWeaponDisplay.new(p13);
    table.insert(p12.Displays, v14);
end;

function u1._Init(u15) -- Line: 77
    -- upvalues: LobbyController (copy), PlayerDataController (copy), CollectionService (copy)
    LobbyController.LocalFighter:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 78
        -- upvalues: LobbyController (ref), u15 (copy)
        if not LobbyController.LocalFighter:Get("IsInDuel") then
            u15:Shuffle();
        end;
    end);
    PlayerDataController:GetDataChangedSignal("WeaponInventory"):Connect(function() -- Line: 84
        -- upvalues: u15 (copy)
        for _, v in pairs(u15.Displays) do
            v:ChangeWeapon(u15:_VerifyLooseWeaponDisplayWeapon(v.CurrentWeapon));
        end;
    end);
    CollectionService:GetInstanceAddedSignal("LobbyLooseWeaponDisplay"):Connect(function(p16) -- Line: 90
        -- upvalues: u15 (copy)
        u15:_ObjectAdded(p16);
    end);

    for _, v in pairs(CollectionService:GetTagged("LobbyLooseWeaponDisplay")) do
        task.spawn(u15._ObjectAdded, u15, v);
    end;

    u15:Shuffle();
end;

return u1._new();