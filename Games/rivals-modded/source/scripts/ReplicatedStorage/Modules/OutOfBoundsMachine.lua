-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local GameplayUtility = require(ReplicatedStorage.Modules.GameplayUtility);
local Signal = require(ReplicatedStorage.Modules.Signal);
local u1 = CONSTANTS.IS_CLIENT and require(Players.LocalPlayer.PlayerScripts.Controllers.SpectateController);
local u2 = {};
u2.__index = u2;

function u2.new(p3, p4) -- Line: 15
    -- upvalues: u2 (copy), Signal (copy)
    local v5 = setmetatable({}, u2);
    v5.SteppedOut = Signal.new();
    v5.Warning = Signal.new();
    v5.Kill = Signal.new();
    v5._fighter_subject = p3;
    v5._update_frequency = p4 or 0.1;
    v5._next_update = 0;
    v5._oob_details = nil;
    v5._connections = {};
    v5._object_connections = {};
    v5._is_visible = false;
    v5:_Init();

    return v5;
end;

function u2.GetSubject(p6) -- Line: 39
    -- upvalues: u1 (copy)
    if p6._fighter_subject then
        return p6._fighter_subject.Entity;
    end;

    return u1 and (u1.CurrentSubject and u1.CurrentSubject.IsLocalPlayer) and u1.CurrentSubject.Entity;
end;

function u2.IsOutOfBounds(p7) -- Line: 44
    -- upvalues: GameplayUtility (copy)
    local Subject = p7:GetSubject();

    if Subject and (Subject:IsAlive() and Subject.RootPart) then
        return GameplayUtility:IsWithinOOBPart(Subject.RootPart.Position);
    end;
end;

function u2.SetVisible(p8, p9) -- Line: 54
    -- upvalues: CollectionService (copy)
    p8._is_visible = p9;

    if p8._is_visible then
        return;
    end;

    for _, v in pairs(CollectionService:GetTagged("OutOfBoundsSafePart")) do
        p8:_UpdateVisibilityForPart(v);
    end;

    for _, v in pairs(CollectionService:GetTagged("OutOfBoundsPart")) do
        p8:_UpdateVisibilityForPart(v);
    end;
end;

function u2.Update(p10, p11) -- Line: 70
    -- upvalues: GameplayUtility (copy)
    if tick() < p10._next_update then
        return;
    end;

    p10._next_update = tick() + p10._update_frequency;

    if p10:_CheckKill() then
        return;
    end;

    local v12 = p10:IsOutOfBounds();

    if v12 then
        if not p10._oob_details or v12 ~= p10._oob_details.Part then
            local OOBWarnDelay = GameplayUtility:GetOOBWarnDelay(v12:GetAttribute("WarnDelay"));
            local OOBKillDelay = GameplayUtility:GetOOBKillDelay(v12:GetAttribute("KillDelay"));

            if not p10._oob_details or OOBWarnDelay + OOBKillDelay < p10._oob_details.KillTime - tick() then
                p10._oob_details = {
                    Part = v12,
                    WarnTime = tick() + OOBWarnDelay,
                    KillTime = tick() + OOBWarnDelay + OOBKillDelay
                };
                p10.Warning:Fire(OOBWarnDelay + OOBKillDelay);
            end;
        end;
    elseif p10._oob_details then
        p10._oob_details = nil;
        p10.SteppedOut:Fire();
    end;

    p10:_CheckKill();
end;

function u2.Destroy(p13) -- Line: 107
    p13.SteppedOut:Destroy();
    p13.Warning:Destroy();
    p13.Kill:Destroy();

    for _, v in pairs(p13._connections) do
        v:Disconnect();
    end;

    for _, v in pairs(p13._object_connections) do
        for _, v2 in pairs(v) do
            v2:Disconnect();
        end;
    end;
end;

function u2._CheckKill(p14) -- Line: 127
    if p14._oob_details and tick() >= p14._oob_details.KillTime then
        p14.Kill:Fire(p14._oob_details.Part, p14:GetSubject() or nil);
        p14._oob_details = nil;
        p14.SteppedOut:Fire();

        return true;
    end;
end;

function u2._UpdateVisibilityForPart(p15, p16) -- Line: 136
    if not p15._is_visible then
        task.defer(p16.ClearAllChildren, p16);
        p16.Transparency = 1;

        return;
    end;

    p16.Transparency = 0;
    p16.Material = Enum.Material.ForceField;
    p16.Color = Color3.fromRGB(255, 215, 0);
end;

function u2._ObjectAdded(p17, p18) -- Line: 147
    p17:_ObjectRemoved(p18);
    p17._object_connections[p18] = {};
    table.insert(p17._object_connections[p18], p18.ChildAdded:Connect(function(p19) -- Line: 152
        task.defer(p19.Destroy, p19);
    end));
    p17:_UpdateVisibilityForPart(p18);
end;

function u2._ObjectRemoved(p20, p21) -- Line: 159
    for _, v in pairs(p20._object_connections[p21] or {}) do
        v:Disconnect();
    end;

    p20._object_connections[p21] = nil;
end;

function u2._Init(u22) -- Line: 167
    -- upvalues: CollectionService (copy)
    local _connections = u22._connections;
    local InstanceAddedSignal = CollectionService:GetInstanceAddedSignal("OutOfBoundsPart");
    table.insert(_connections, InstanceAddedSignal:Connect(function(p23) -- Line: 168
        -- upvalues: u22 (copy)
        u22:_ObjectAdded(p23);
    end));
    local _connections2 = u22._connections;
    local InstanceAddedSignal2 = CollectionService:GetInstanceAddedSignal("OutOfBoundsSafePart");
    table.insert(_connections2, InstanceAddedSignal2:Connect(function(p24) -- Line: 172
        -- upvalues: u22 (copy)
        u22:_ObjectAdded(p24);
    end));

    for _, v in pairs(CollectionService:GetTagged("OutOfBoundsPart")) do
        task.defer(u22._ObjectAdded, u22, v);
    end;

    for _, v in pairs(CollectionService:GetTagged("OutOfBoundsSafePart")) do
        task.defer(u22._ObjectAdded, u22, v);
    end;
end;

return u2;