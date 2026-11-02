-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local OutOfBoundsMachine = require(ReplicatedStorage.Modules.OutOfBoundsMachine);
local u1 = setmetatable({}, OutOfBoundsMachine);
u1.__index = u1;

function u1._new() -- Line: 8
    -- upvalues: OutOfBoundsMachine (copy), u1 (copy)
    local v2 = OutOfBoundsMachine.new(nil, nil);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._Init(p4) -- Line: 26
    -- upvalues: ReplicatedStorage (copy)
    p4.Kill:Connect(function(p5, p6) -- Line: 27
        -- upvalues: ReplicatedStorage (ref)
        local v7 = p6 and p6:Get("ObjectID") or nil;
        ReplicatedStorage.Remotes.Replication.Fighter.OutOfBounds:FireServer(p5, v7);
    end);
end;

return u1._new();