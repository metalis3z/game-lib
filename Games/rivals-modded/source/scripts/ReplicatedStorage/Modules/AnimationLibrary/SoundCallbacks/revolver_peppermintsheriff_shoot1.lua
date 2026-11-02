-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = { "rbxassetid://137835445333923" };
local u2 = { "rbxassetid://111635700014206", "rbxassetid://71082815960227", "rbxassetid://102452124576950" };

return function(p3, p4, p5) -- Line: 4
    -- upvalues: u1 (copy), u2 (copy)
    p3:CreateSound(u1[math.random(#u1)], 1, 1.5 + 0.25 * math.random(), true, 10);
    p3:CreateSound(u2[math.random(#u2)], 1, 1.2 + 0.1 * math.random(), true, 10);
end;