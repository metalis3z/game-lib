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
    v3._gradient1 = {};
    v3._gradient2 = {};
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 23
    local v6 = workspace:GetServerTimeNow() / 4;

    for _, v in pairs(p4._gradient1) do
        local v7 = v6 / 2.5 % v.StudsPerTileU;

        if v.Face == Enum.NormalId.Top or v.Face == Enum.NormalId.Front then
            v7 = -v7;
        end;

        v.OffsetStudsU = v7;
        v.OffsetStudsV = math.sin(v6 * 4) / 14;
    end;
end;

function u1._Setup(p8) -- Line: 42
    for _, v in pairs(p8.ExtraObjects) do
        if v.Name == "Gradient" then
            table.insert(p8._gradient1, v);
        elseif v.Name == "Gradient2" then
            table.insert(p8._gradient2, v);
        end;
    end;
end;

function u1._Init(p9) -- Line: 52
    p9:_Setup();
end;

return u1;