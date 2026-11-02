-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = { "rbxassetid://14417089307", "rbxassetid://14417089152", "rbxassetid://14417089046", "rbxassetid://14417088974" };

return function(p2, p3, p4) -- Line: 3
    -- upvalues: u1 (copy)
    p2:CreateSound(u1[math.random(#u1)], 1, 0.95 + 0.1 * math.random(), true, 10);
    p2:CreateSound("rbxassetid://94299557217235", 1, 0.95 + 0.1 * math.random(), true, 10);
    p2:CreateSound("rbxassetid://134815282110155", 1.25, 1, true, 10);
end;