-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Charm = require(Players.LocalPlayer.PlayerScripts.Modules.Charm);
local u1 = setmetatable({}, Charm);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: Charm (copy), u1 (copy)
    local v2 = Charm.new(...);
    local v3 = setmetatable(v2, u1);
    v3._spin_anchor = v3.Model:WaitForChild("Extra"):WaitForChild("SpinAnchor");
    v3._spin_objects = {};
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5) -- Line: 23
    -- upvalues: Charm (copy)
    Charm.Update(p4, p5);
    local CFrame_Angles_ret = CFrame.Angles(0, tick() * 3.141592653589793 * 2 % 6.283185307179586, 0);

    for i, v in pairs(p4._spin_objects) do
        i.CFrame = p4._spin_anchor.CFrame * CFrame_Angles_ret * v;
    end;
end;

function u1._Setup(p6) -- Line: 37
    for i = 1, 3 do
        local v7 = p6.Model:WaitForChild("Extra"):WaitForChild("Spin" .. i);
        p6._spin_objects[v7] = v7.CFrame:ToObjectSpace(p6._spin_anchor.CFrame):Inverse();
        local _ = i;
    end;
end;

function u1._Init(p8) -- Line: 44
    p8:_Setup();
end;

return u1;