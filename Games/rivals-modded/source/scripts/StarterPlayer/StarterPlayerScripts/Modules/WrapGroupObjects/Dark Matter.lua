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
    v3._moving_textures = {};
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 22
    for i, v in pairs(p4._moving_textures) do
        i.OffsetStudsU = tick() * v.Speed * v.Direction.X % i.StudsPerTileU;
        i.OffsetStudsV = tick() * v.Speed * v.Direction.Y % i.StudsPerTileV;
    end;
end;

function u1._Setup(p6) -- Line: 33
    for _, v in pairs(p6.ExtraObjects) do
        local Attribute = v:GetAttribute("Speed");
        local Attribute2 = v:GetAttribute("Direction");

        if Attribute and Attribute2 then
            p6._moving_textures[v] = {
                Speed = Attribute,
                Direction = Attribute2
            };
        end;
    end;
end;

function u1._Init(p7) -- Line: 46
    p7:_Setup();
end;

return u1;