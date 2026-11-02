-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CONSTANTS = require(ReplicatedStorage.Modules.CONSTANTS);
local EnumLibrary = require(ReplicatedStorage.Modules.EnumLibrary);
local Signal = require(ReplicatedStorage.Modules.Signal);
local u1 = CONSTANTS.IS_CLIENT and Players.LocalPlayer and Players.LocalPlayer.PlayerScripts:WaitForChild("Modules"):WaitForChild("ClientReplicatedClasses");
local u2 = 0;
local u3 = {};
u3.__index = u3;

function u3.new(p4, p5) -- Line: 16
    -- upvalues: u2 (ref), u3 (copy), CONSTANTS (copy), Signal (copy)
    local v6 = not p4 or typeof(p4) == "table";
    assert(v6, "Argument 1 invalid, expected a table or nil");
    u2 = (u2 + 1) % 1000000;
    local v7 = setmetatable({}, u3);
    v7.Data = {
        ObjectID = utf8.char(u2)
    };
    v7.ReplicateToClient = CONSTANTS.IS_SERVER and Signal.new() or nil;
    v7.ReplicateToClientUnreliable = CONSTANTS.IS_SERVER and Signal.new() or nil;
    v7._value_changed_events = {};
    v7._temp_serial = p4;
    v7._dont_compress_replication = p5;
    v7:_Init();

    return v7;
end;

function u3.GetReplicatedClass(p8, p9) -- Line: 43
    -- upvalues: CONSTANTS (copy), u1 (copy), u3 (copy)
    assert(CONSTANTS.IS_CLIENT);

    if p9 then
        p9 = u1:FindFirstChild(p9, true);
    end;

    return p9 and require(p9) or u3;
end;

function u3.Get(p10, p11) -- Line: 52
    return p10.Data[p11];
end;

function u3.Set(p12, p13, p14) -- Line: 59
    p12.Data[p13] = p14;
end;

function u3.GetDataChangedSignal(p15, p16) -- Line: 66
    -- upvalues: Signal (copy)
    local v17 = typeof(p16) == "string";
    assert(v17, "Argument 1 invalid, expected a string");

    if not p15._value_changed_events[p16] then
        p15._value_changed_events[p16] = Signal.new();
    end;

    return p15._value_changed_events[p16];
end;

function u3.Replicate(p18, p19, p20) -- Line: 77
    local v21 = typeof(p19) == "string";
    assert(v21, "Argument 1 invalid, expected a string");
    local v22 = p18:Get(p19);
    local v23 = p20 and "ReplicateToClientUnreliable" or "ReplicateToClient";

    if p18[v23] then
        p18[v23]:Fire("DataValueChanged", p18._dont_compress_replication and p19 and p19 or (p18:ToEnum(p19) or p19), v22);
    end;

    if p18._value_changed_events[p19] then
        p18._value_changed_events[p19]:Fire(v22, p19);
    end;
end;

function u3.SetReplicate(p24, p25, p26, p27) -- Line: 93
    local v28 = typeof(p25) == "string";
    assert(v28, "Argument 1 invalid, expected a string");
    p24:Set(p25, p26);
    p24:Replicate(p25, p27);
end;

function u3.Increment(p29, p30, p31) -- Line: 101
    local v32 = typeof(p30) == "string";
    assert(v32, "Argument 1 invalid, expected a string");
    local v33 = typeof(p31) == "number";
    assert(v33, "Argument 2 invalid, expected a number");

    if p31 == 0 then
        return;
    end;

    p29:Set(p30, p29:Get(p30) + p31);
end;

function u3.IncrementReplicate(p34, p35, p36) -- Line: 113
    local v37 = typeof(p35) == "string";
    assert(v37, "Argument 1 invalid, expected a string");
    local v38 = typeof(p36) == "number";
    assert(v38, "Argument 2 invalid, expected a number");

    if p36 == 0 then
        return;
    end;

    p34:Increment(p35, p36);
    p34:Replicate(p35);
end;

function u3.ReplicateFromServer(p39, p40, ...) -- Line: 127
    if p40 == "DataValueChanged" then
        local v41, v42 = ...;
        p39:SetReplicate(p39._dont_compress_replication and v41 and v41 or (p39:FromEnum(v41) or v41), v42);

        return;
    end;

    local v43 = "No implementation for change type: " .. tostring(p40);
    assert(false, v43);
end;

function u3.ToEnum(p44, p45) -- Line: 137
    -- upvalues: EnumLibrary (copy)
    return EnumLibrary:ToEnum(p45);
end;

function u3.FromEnum(p46, p47) -- Line: 141
    -- upvalues: EnumLibrary (copy)
    return EnumLibrary:FromEnum(p47);
end;

function u3.Serialize(p48) -- Line: 145
    return p48:_EncodeSerial({
        ClientReplicatedClassType = nil,
        Data = p48:_SerializeData()
    });
end;

function u3.Destroy(p49) -- Line: 154
    if p49.ReplicateToClient then
        p49.ReplicateToClient:Destroy();
    end;

    if p49.ReplicateToClientUnreliable then
        p49.ReplicateToClientUnreliable:Destroy();
    end;

    for _, v in pairs(p49._value_changed_events) do
        v:Destroy();
    end;
end;

function u3._DecodeSerial(p50, p51) -- Line: 172
    -- upvalues: EnumLibrary (copy)
    if p50._dont_compress_replication then
        return p51;
    end;

    local v52 = {};

    for i, v in pairs(p51) do
        v52[EnumLibrary:ToEnum(i, true) and i and i or p50:FromEnum(i)] = v;
    end;

    table.clear(p51);

    for i, v in pairs(v52) do
        p51[i] = v;
    end;

    return p51;
end;

function u3._EncodeSerial(p53, p54) -- Line: 192
    -- upvalues: EnumLibrary (copy)
    if p53._dont_compress_replication then
        return p54;
    end;

    local v55 = {};

    for i, v in pairs(p54) do
        if EnumLibrary:FromEnum(i, true) then
            v55[i] = v;
        end;
    end;

    for i, v in pairs(p54) do
        if not EnumLibrary:FromEnum(i, true) then
            v55[p53:ToEnum(i)] = v;
        end;
    end;

    return v55;
end;

function u3._SerializeData(p56) -- Line: 218
    if p56._dont_compress_replication then
        return p56.Data;
    end;

    local v57 = {};

    for i, v in pairs(p56.Data) do
        v57[p56:ToEnum(i)] = v;
    end;

    return v57;
end;

function u3._Setup(p58) -- Line: 232
    if p58._temp_serial then
        p58:_DecodeSerial(p58._temp_serial);

        for i, v in pairs(p58._temp_serial.Data) do
            p58:SetReplicate(p58._dont_compress_replication and i and i or p58:FromEnum(i), v);
        end;
    end;

    p58._temp_serial = nil;
end;

function u3._Init(p59) -- Line: 244
    p59:_Setup();
end;

return u3;