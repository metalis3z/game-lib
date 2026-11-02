-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if tick() < p1.EnergyPistolsShootSoundCooldown then
        return;
    end;

    p1.EnergyPistolsShootSoundCooldown = tick() + 0.05;
    p1:CreateSound("rbxassetid://120386834342865", 0.625, 1.4 + 0.2 * math.random(), true, 1);
    p1:CreateSound("rbxassetid://119904392413280", 1, 3.5 + 0.25 * math.random(), true, 5);
end;