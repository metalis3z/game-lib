-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local u1 = setmetatable({}, WrapGroupObject);
u1.__index = u1;

function u1.new(...) -- Line: 12
    -- upvalues: WrapGroupObject (copy), u1 (copy)
    local v2 = WrapGroupObject.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 24
    local v6 = tick() * 10;
    local v7 = math.floor(v6) * 0.027 % 0.25;

    for _, v in pairs(p4.ExtraObjects) do
        v.OffsetStudsV = v7;
    end;
end;

function u1._Init(p8) -- Line: 36
end;

return u1;