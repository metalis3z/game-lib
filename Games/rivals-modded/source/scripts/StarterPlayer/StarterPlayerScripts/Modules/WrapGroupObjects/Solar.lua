-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local WrapGroupObject = require(Players.LocalPlayer.PlayerScripts.Modules.WrapGroupObject);
local u1 = setmetatable({}, WrapGroupObject);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: WrapGroupObject (copy), u1 (copy)
    local v2 = WrapGroupObject.new(...);
    local v3 = setmetatable(v2, u1);
    v3._shake_these = {};
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 24
    for _, v in pairs(p4._shake_these) do
        v.OffsetStudsU = (math.random() - 0.5) * 0.01;
        v.OffsetStudsV = (math.random() - 0.5) * 0.01;
    end;
end;

function u1._Setup(p6) -- Line: 35
    for _, v in pairs(p6.ExtraObjects) do
        if v.Name == "Wireframe" then
            table.insert(p6._shake_these, v);
        end;
    end;
end;

function u1._Init(p7) -- Line: 43
    p7:_Setup();
end;

return u1;