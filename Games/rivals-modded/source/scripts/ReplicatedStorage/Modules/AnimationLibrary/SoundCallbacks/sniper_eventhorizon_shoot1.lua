-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = { "rbxassetid://124463680760542", "rbxassetid://93542288707517", "rbxassetid://110622947899700", "rbxassetid://96443038656377" };
local u2 = { "rbxassetid://77109116351775", "rbxassetid://134101368984038" };

return function(p3, p4, p5) -- Line: 4
    -- upvalues: u1 (copy), u2 (copy)
    p3:CreateSound("rbxassetid://17672502566", 0.875, 0.725 + 0.05 * math.random(), true, 10);
    p3:CreateSound(u1[math.random(#u1)], 0.875, 0.95 + 0.1 * math.random(), true, 10);
    p3:CreateSound(u2[math.random(#u2)], 0.875, 0.6 + 0.1 * math.random(), true, 10);
end;