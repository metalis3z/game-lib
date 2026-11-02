-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local u1 = setmetatable({}, WrapGroupObject);
u1.__index = u1;

function u1.new(...) -- Line: 11
    -- upvalues: WrapGroupObject (copy), u1 (copy)
    local v2 = WrapGroupObject.new(...);
    local v3 = setmetatable(v2, u1);
    v3._moving_textures = {};
    v3._shift = 0;
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 26
    local v6 = tick() * 1;
    local v7 = math.sin(v6) ^ 20 * 0.75 + 0.25;
    p4._shift = (p4._shift + p5 * v7) % 0.2;

    for i, v in pairs(p4._moving_textures) do
        i.OffsetStudsU = p4._shift * v;
    end;
end;

function u1._Setup(p8) -- Line: 40
    for _, v in pairs(p8.ExtraObjects) do
        p8._moving_textures[v] = v.Name == "Left" and 1 or -1;
    end;
end;

function u1._Init(p9) -- Line: 46
    p9:_Setup();
end;

return u1;