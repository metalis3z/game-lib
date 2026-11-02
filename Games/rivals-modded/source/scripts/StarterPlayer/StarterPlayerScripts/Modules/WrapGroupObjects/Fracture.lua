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
    v3._shatter1 = {};
    v3._shatter2 = {};
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 28
    local v6 = workspace:GetServerTimeNow() * 1.5;
    local v7 = math.sin(v6) / 7 + 0.75;

    for _, v in pairs(p4._shatter1) do
        v.StudsPerTileU = v7 + 1.574 + Random.new():NextNumber(-0.02, 0.02);
        v.StudsPerTileV = v7 + 1.574 + Random.new():NextNumber(-0.02, 0.02);
    end;

    for _, v in pairs(p4._shatter2) do
        v.StudsPerTileU = v7 / 1.75 + 2.5 + Random.new():NextNumber(-0.01, 0.01);
        v.StudsPerTileV = v7 / 1.75 + 2.5 + Random.new():NextNumber(-0.01, 0.01);
    end;
end;

function u1._Setup(p8) -- Line: 46
    for _, v in pairs(p8.ExtraObjects) do
        if v.Name == "Shatter" then
            table.insert(p8._shatter1, v);
        elseif v.Name == "Shatter2" then
            table.insert(p8._shatter2, v);
        end;
    end;
end;

function u1._Init(p9) -- Line: 56
    p9:_Setup();
end;

return u1;