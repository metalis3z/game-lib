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
    v3._sparkles1 = {};
    v3._sparkles2 = {};
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 23
    local v6 = workspace:GetServerTimeNow() / 4;
    local v7 = math.sin(v6 * 24) / 3 + 0.5;
    local math_clamp_ret = math.clamp(v7, 0, 1);
    local v8 = math.sin((v6 + 3.5342917352885173) * 24) / 3 + 0.5;
    local math_clamp_ret2 = math.clamp(v8, 0, 1);

    for _, v in pairs(p4._sparkles1) do
        v.OffsetStudsV = v6 % v.StudsPerTileV;
        v.Transparency = math_clamp_ret;
    end;

    for _, v in pairs(p4._sparkles2) do
        v.OffsetStudsV = v6 % v.StudsPerTileV;
        v.Transparency = math_clamp_ret2;
    end;
end;

function u1._Setup(p9) -- Line: 43
    for _, v in pairs(p9.ExtraObjects) do
        if v.Name == "Sparkles" then
            table.insert(p9._sparkles1, v);
        elseif v.Name == "Sparkles2" then
            table.insert(p9._sparkles2, v);
        end;
    end;
end;

function u1._Init(p10) -- Line: 53
    p10:_Setup();
end;

return u1;