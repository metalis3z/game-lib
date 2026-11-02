-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local u1 = setmetatable({}, WrapGroupObject);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: WrapGroupObject (copy), u1 (copy)
    local v2 = WrapGroupObject.new(...);
    local v3 = setmetatable(v2, u1);
    v3._fire1 = {};
    v3._fire2 = {};
    v3._beams = {};
    v3._sparks = {};
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 25
    local v6 = workspace:GetServerTimeNow() / 4;
    local v7 = math.sin(v6 * 12) / 3 + 0.5;
    local math_clamp_ret = math.clamp(v7, 0, 1);
    local v8 = math.sin((v6 + 3.5342917352885173) * 12) / 3 + 0.5;
    local math_clamp_ret2 = math.clamp(v8, 0, 1);

    for _, v in pairs(p4._fire1) do
        v.Transparency = math_clamp_ret;
    end;

    for _, v in pairs(p4._fire2) do
        v.Transparency = math_clamp_ret2;
    end;

    for _, v in pairs(p4._beams) do
        v.Transparency = math.sin(v6 * 6) / 10 + 0.8;
    end;

    for _, v in pairs(p4._sparks) do
        v.OffsetStudsU = v6 / 4 % v.StudsPerTileU + math.sin(v6 * 9) / 64;
        v.OffsetStudsV = v6 / 2 % v.StudsPerTileV;
        v.Transparency = math.sin(v6 * 8) / 10 + 0.2;
    end;
end;

function u1._Setup(p9) -- Line: 53
    for _, v in pairs(p9.ExtraObjects) do
        if v.Name == "Fire1" then
            table.insert(p9._fire1, v);
        elseif v.Name == "Fire2" then
            table.insert(p9._fire1, v);
        elseif v.Name == "Beam" then
            table.insert(p9._beams, v);
        elseif v.Name == "Sparks1" then
            table.insert(p9._sparks, v);
        end;
    end;
end;

function u1._Init(p10) -- Line: 67
    p10:_Setup();
end;

return u1;