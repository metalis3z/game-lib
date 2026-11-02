-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

game:GetService("CollectionService");
local Players = game:GetService("Players");
local PlayerDataController = require(Players.LocalPlayer.PlayerScripts.Controllers.PlayerDataController);
local SpectateController = require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local FighterController = require(Players.LocalPlayer.PlayerScripts.Controllers.FighterController);
local u1 = {};
u1.__index = u1;

function u1._new() -- Line: 13
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._connections = {};
    v2._local_fighter = nil;
    v2:_Init();

    return v2;
end;

function u1._ObjectAdded(p3, p4) -- Line: 34
    -- upvalues: SpectateController (copy)
    if not (SpectateController.CurrentSubject and SpectateController.CurrentSubject.FighterInterface) then
        return;
    end;

    if not (p4:IsDescendantOf(workspace) and p4.Parent:IsA("BasePart")) then
        return;
    end;

    SpectateController.CurrentSubject.FighterInterface.AudioVisualizers:Create(p4, p4.RollOffMinDistance, p4.RollOffMaxDistance);
end;

function u1._UpdateEnabled(p5) -- Line: 46
    for _, v in pairs(p5._connections) do
        v:Disconnect();
    end;

    p5._connections = {};
end;

function u1._HookLocalFighter(u6) -- Line: 62
    -- upvalues: FighterController (copy)
    u6._local_fighter = FighterController:WaitForLocalFighter();
    u6._local_fighter:GetDataChangedSignal("IsInShootingRange"):Connect(function() -- Line: 65
        -- upvalues: u6 (copy)
        u6:_UpdateEnabled();
    end);
    u6._local_fighter:GetDataChangedSignal("IsInDuel"):Connect(function() -- Line: 69
        -- upvalues: u6 (copy)
        u6:_UpdateEnabled();
    end);
    u6:_UpdateEnabled();
end;

function u1._Init(u7) -- Line: 76
    -- upvalues: PlayerDataController (copy)
    PlayerDataController:GetSettingChangedSignal("Audio Visualizers"):Connect(function() -- Line: 77
        -- upvalues: u7 (copy)
        u7:_UpdateEnabled();
    end);
    u7:_UpdateEnabled();
    task.defer(u7._HookLocalFighter, u7);
end;

return u1._new();