-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local LeaderboardDisplay = require(Players.LocalPlayer.PlayerScripts.Modules.LeaderboardDisplay);
local LobbyElement = require(Players.LocalPlayer.PlayerScripts.Modules.LobbyElement);
local u1 = setmetatable({}, LobbyElement);
u1.__index = u1;

function u1._new(...) -- Line: 10
    -- upvalues: LobbyElement (copy), u1 (copy)
    local v2 = LobbyElement.new(...);
    local v3 = setmetatable(v2, u1);
    v3.Displays = {};
    v3:_Init();

    return v3;
end;

function u1._DisplayAdded(p4, p5) -- Line: 30
    -- upvalues: LeaderboardDisplay (copy)
    local v6 = LeaderboardDisplay.new(p5);
    table.insert(p4.Displays, v6);
end;

function u1._Init(u7) -- Line: 35
    -- upvalues: CollectionService (copy)
    CollectionService:GetInstanceAddedSignal("LeaderboardDisplay"):Connect(function(p8) -- Line: 36
        -- upvalues: u7 (copy)
        u7:_DisplayAdded(p8);
    end);

    for _, v in pairs(CollectionService:GetTagged("LeaderboardDisplay")) do
        task.defer(u7._DisplayAdded, u7, v);
    end;
end;

return u1._new();