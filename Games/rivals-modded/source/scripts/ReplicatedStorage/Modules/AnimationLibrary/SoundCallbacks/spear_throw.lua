-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = { "rbxassetid://111073083700270", "rbxassetid://94924686270578", "rbxassetid://132703068792668" };

return function(p2, p3, p4) -- Line: 3
    -- upvalues: u1 (copy)
    p2:CreateSound(u1[math.random(#u1)], 1.25, 0.9 + 0.2 * math.random(), true, 5);
end;