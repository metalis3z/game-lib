-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = { "rbxassetid://14417089307", "rbxassetid://14417089152", "rbxassetid://14417089046", "rbxassetid://14417088974" };

return function(p2, p3, p4) -- Line: 3
    -- upvalues: u1 (copy)
    p2:CreateSound(u1[math.random(#u1)], 1, 0.75 + 0.125 * math.random(), true, 10);
    p2:CreateSound(u1[math.random(#u1)], 1, 1.25 + 0.25 * math.random(), true, 10);
    p2:CreateSound("rbxassetid://13483008798", 1.25, 2, true, 10);
    p2:CreateSound("rbxassetid://90757583550672", 0.625, 1 + 0.1 * math.random(), true, 5);
    p2:CreateSound("rbxassetid://110122962237431", 1.25, 1 + 0.1 * math.random(), true, 5);
end;