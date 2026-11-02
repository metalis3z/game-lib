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
    v3._textures1 = {};
    v3._textures2 = {};
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 23
    local v6 = workspace:GetServerTimeNow() / 8;
    local v7 = math.sin(v6 * 24) / 2 + 0.25;
    local math_clamp_ret = math.clamp(v7, 0, 1);
    local v8 = math.sin((v6 + 3.5342917352885173) * 24) / 2 + 0.25;
    local math_clamp_ret2 = math.clamp(v8, 0, 1);
    local v9 = (math.sin(v6) + 4) / 2;

    for _, v in pairs(p4._textures1) do
        v.StudsPerTileU = v9;
        v.StudsPerTileV = v9;
        v.Transparency = math_clamp_ret;
    end;

    for _, v in pairs(p4._textures2) do
        v.StudsPerTileU = v9;
        v.StudsPerTileV = v9;
        v.Transparency = math_clamp_ret2;
    end;
end;

function u1._Setup(p10) -- Line: 46
    for _, v in pairs(p10.ExtraObjects) do
        if v.Name == "RedStars" or v.Name == "BlueStars2" then
            table.insert(p10._textures1, v);
        elseif v.Name == "BlueStars" or v.Name == "RedStars2" then
            table.insert(p10._textures2, v);
        end;
    end;
end;

function u1._Init(p11) -- Line: 56
    p11:_Setup();
end;

return u1;