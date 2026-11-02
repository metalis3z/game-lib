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
    v3._textures1 = {};
    v3._textures2 = {};
    v3._random = Random.new();
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 29
    local v6 = workspace:GetServerTimeNow() / 4;

    for _, v in pairs(p4._textures1) do
        v.OffsetStudsV = v6 % 0.6;
        v.OffsetStudsU = math.sin(v6 * 10) / 14 + p4._random:NextNumber(-0.01, 0.01);
    end;

    for _, v in pairs(p4._textures2) do
        v.OffsetStudsU = v6 % 0.7;
        v.OffsetStudsV = v6 % 0.5;
    end;
end;

function u1._Setup(p7) -- Line: 47
    for _, v in pairs(p7.ExtraObjects) do
        if v.Name == "Souls" then
            table.insert(p7._textures1, v);
        elseif v.Name == "Clouds2" then
            table.insert(p7._textures2, v);
        end;
    end;
end;

function u1._Init(p8) -- Line: 57
    p8:_Setup();
end;

return u1;