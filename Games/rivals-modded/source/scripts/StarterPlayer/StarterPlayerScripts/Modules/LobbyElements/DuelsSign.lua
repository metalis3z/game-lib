-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local LobbyElement = require(Players.LocalPlayer.PlayerScripts.Modules.LobbyElement);
local u1 = setmetatable({}, LobbyElement);
u1.__index = u1;

function u1._new(...) -- Line: 13
    -- upvalues: LobbyElement (copy), u1 (copy)
    local v2 = LobbyElement.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 25
    -- upvalues: CollectionService (copy)
    for _, v in pairs(CollectionService:GetTagged("LobbyDuelsSign")) do
        local v6 = tick();
        local Yellow = v.Yellow;
        local v7 = p4:_GetOriginalPivot(v.Yellow);
        local v8 = math.cos(v6) ^ 3 - math.sin(v6) ^ 3;
        Yellow:PivotTo(v7 + Vector3.new(0, v8, 0) * 0.5);
        local Purple = v.Purple;
        local v9 = p4:_GetOriginalPivot(v.Purple);
        local v10 = math.cos(v6 - 3.141592653589793) ^ 3 - math.sin(v6 - 3.141592653589793) ^ 3;
        Purple:PivotTo(v9 + Vector3.new(0, v10, 0) * 0.5);
    end;
end;

function u1._Setup(p11) -- Line: 38
    -- upvalues: CONSTANTS (copy), CollectionService (copy)
    local function object_added(p12) -- Line: 50
        -- upvalues: CONSTANTS (ref)
        p12:WaitForChild("Screen"):WaitForChild("Duels").Enabled = CONSTANTS.QUEUES_ACTIVE;
        p12:WaitForChild("Screen"):WaitForChild("Play").Enabled = not CONSTANTS.QUEUES_ACTIVE;
    end;

    CollectionService:GetInstanceAddedSignal("LobbyDuelsSign"):Connect(object_added);

    for _, v in pairs(CollectionService:GetTagged("LobbyDuelsSign")) do
        v:WaitForChild("Screen"):WaitForChild("Duels").Enabled = CONSTANTS.QUEUES_ACTIVE;
        v:WaitForChild("Screen"):WaitForChild("Play").Enabled = not CONSTANTS.QUEUES_ACTIVE;
    end;
end;

function u1._Init(p13) -- Line: 63
    p13:_Setup();
end;

return u1._new();