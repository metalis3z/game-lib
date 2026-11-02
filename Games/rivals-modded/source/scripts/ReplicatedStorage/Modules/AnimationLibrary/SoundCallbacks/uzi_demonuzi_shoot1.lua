-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = { "rbxassetid://16526185100", "rbxassetid://16526184479", "rbxassetid://16526184730" };

return function(p2, p3, p4) -- Line: 3
    -- upvalues: u1 (copy)
    p2:CreateSound("rbxassetid://16397424081", 0.2, 4 + 0.5 * math.random(), true, 5);
    p2:CreateSound("rbxassetid://16526184265", 0.5, 2 + 0.5 * math.random(), true, 5);
    p2:CreateSound(u1[math.random(#u1)], 1.25, 0.75 + 0.5 * math.random(), true, 5);
    p2:CreateSound("rbxassetid://108887853497578", 0.75, 1.75 + 0.5 * math.random(), true, 10);
end;