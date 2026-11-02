-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedClass = require(ReplicatedStorage.Modules.ReplicatedClass);
local u1 = setmetatable({}, ReplicatedClass);
u1.__index = u1;

function u1._new() -- Line: 8
    -- upvalues: ReplicatedClass (copy), u1 (copy)
    local v2 = ReplicatedClass.new();
    local v3 = setmetatable(v2, u1);
    v3.Data.AreHandicapsEnabled = false;
    v3.Data.DisableTransparentHats = false;
    v3:_Init();

    return v3;
end;

function u1._Init(p4) -- Line: 29
end;

return u1._new();