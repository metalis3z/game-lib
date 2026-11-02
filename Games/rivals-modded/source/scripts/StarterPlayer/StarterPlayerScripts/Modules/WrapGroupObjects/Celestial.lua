-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local u1 = setmetatable({}, WrapGroupObject);
u1.__index = u1;

function u1.new(...) -- Line: 13
    -- upvalues: WrapGroupObject (copy), u1 (copy)
    local v2 = WrapGroupObject.new(...);
    local v3 = setmetatable(v2, u1);
    v3._moving_textures = {};
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 27
    for i, v in pairs(p4._moving_textures) do
        local v6 = (tick() * 0.01 + v) % 1;
        local v7 = math.sin(3.141592653589793 * v6 - 1.5707963267948966) ^ 20 * 0.75 + 0.25;
        local v8 = 0.05 + 1.075 * v6 ^ 2;
        i.Transparency = v7;
        i.StudsPerTileU = v8;
        i.StudsPerTileV = v8;
    end;
end;

function u1._Setup(p9) -- Line: 43
    for _, v in pairs(p9.ExtraObjects) do
        p9._moving_textures[v] = v.Name == "Big" and 0.5 or 0;
    end;
end;

function u1._Init(p10) -- Line: 49
    p10:_Setup();
end;

return u1;