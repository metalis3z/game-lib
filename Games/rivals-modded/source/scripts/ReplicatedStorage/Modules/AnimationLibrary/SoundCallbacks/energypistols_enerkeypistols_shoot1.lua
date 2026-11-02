-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if tick() < p1.EnergyPistolsShootSoundCooldown then
        return;
    end;

    p1.EnergyPistolsShootSoundCooldown = tick() + 0.05;
    p1:CreateSound("rbxassetid://120386834342865", 0.5, 2 + 0.2 * math.random(), true, 1);
    p1:CreateSound("rbxassetid://105707527740934", 0.625, 1.2 + 0.2 * math.random(), true, 1);
end;