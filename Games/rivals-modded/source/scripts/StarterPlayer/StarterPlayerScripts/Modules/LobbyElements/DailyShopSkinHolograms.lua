-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local SkinHologram = require(Players.LocalPlayer.PlayerScripts.Modules.SkinHologram);
local LobbyElement = require(Players.LocalPlayer.PlayerScripts.Modules.LobbyElement);
local u1 = setmetatable({}, LobbyElement);
u1.__index = u1;

function u1._new(...) -- Line: 10
    -- upvalues: LobbyElement (copy), u1 (copy)
    local v2 = LobbyElement.new(...);
    local v3 = setmetatable(v2, u1);
    v3.Holograms = {};
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 24
    for _, v in pairs(p4.Holograms) do
        v:Update(p5);
    end;
end;

function u1._ObjectAdded(p6, p7) -- Line: 34
    -- upvalues: SkinHologram (copy)
    local v8 = SkinHologram.new(p7);
    table.insert(p6.Holograms, v8);
end;

function u1._Init(u9) -- Line: 39
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("LobbyDailyShopSkinHologram"):Connect(function(p10) -- Line: 40
        -- upvalues: u9 (copy)
        u9:_ObjectAdded(p10);
    end);

    for _, v in pairs(CollectionService:GetTagged("LobbyDailyShopSkinHologram")) do
        task.defer(u9._ObjectAdded, u9, v);
    end;
end;

return u1._new();