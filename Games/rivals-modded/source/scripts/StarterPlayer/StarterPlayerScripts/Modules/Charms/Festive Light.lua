-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Charm = require(Players.LocalPlayer.PlayerScripts.Modules.Charm);
local u1 = { Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 176, 0), Color3.fromRGB(0, 255, 0) };
local u2 = setmetatable({}, Charm);
u2.__index = u2;

function u2.new(...) -- Line: 11
    -- upvalues: Charm (copy), u2 (copy)
    local v3 = Charm.new(...);
    local v4 = setmetatable(v3, u2);
    v4._light_color_index = 0;
    v4._light_part = v4.Model:WaitForChild("Extra"):WaitForChild("Light");
    v4:_Init();

    return v4;
end;

function u2.Update(p5, p6) -- Line: 26
    -- upvalues: Charm (copy), u1 (copy)
    Charm.Update(p5, p6);
    local v7 = tick() * 1;
    local v8 = math.floor(v7) % #u1;

    if v8 == p5._light_color_index then
        return;
    end;

    p5._light_color_index = v8;
    p5._light_part.Color = u1[p5._light_color_index + 1];
end;

function u2._Init(p9) -- Line: 43
end;

return u2;