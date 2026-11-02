-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = { "rbxassetid://72815891526849", "rbxassetid://134260292117186" };

return function(p2, p3, p4) -- Line: 3
    -- upvalues: u1 (copy)
    p2:CreateSound(u1[math.random(#u1)], 0.75, 1 + 0.2 * math.random(), true, 5);
    p2:CreateSound("rbxassetid://101461115963186", 1.2, 1 + 0.2 * math.random(), true, 5);
end;