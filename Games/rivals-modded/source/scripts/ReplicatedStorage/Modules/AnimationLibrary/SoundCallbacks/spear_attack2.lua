-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = { "rbxassetid://117634080761694", "rbxassetid://119713534712313", "rbxassetid://105025971160103" };

return function(p2, p3, p4) -- Line: 3
    -- upvalues: u1 (copy)
    p2:CreateSound(u1[math.random(#u1)], 0.9 + 0.2 * math.random(), 0.95 + 0.1 * math.random(), true, 10);
end;