-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = { "rbxassetid://16526185100", "rbxassetid://16526184479", "rbxassetid://16526184730" };
local u2 = { "rbxassetid://88544860864804", "rbxassetid://129694620679651", "rbxassetid://102804344908530" };

return function(p3, p4, p5) -- Line: 4
    -- upvalues: u1 (copy), u2 (copy)
    p3:CreateSound(u1[math.random(#u1)], 0.5, 0.75 + 0.5 * math.random(), true, 5);
    p3:CreateSound("rbxassetid://16397424081", 0.2, 4 + 0.5 * math.random(), true, 5);
    p3:CreateSound("rbxassetid://16526184265", 0.5, 2 + 0.5 * math.random(), true, 5);
    p3:CreateSound(u2[math.random(#u2)], 0.875, 1 + 0.2 * math.random(), true, 10);
    p3:CreateSound("rbxassetid://76983701785959", 1.5, 1, true, 5);
end;