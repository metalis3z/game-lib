-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if tick() < p1.EnergyPistolsShootSoundCooldown then
        return;
    end;

    p1.EnergyPistolsShootSoundCooldown = tick() + 0.05;
    p1:CreateSound("rbxassetid://94684661380385", 0.625, 1 + 0.2 * math.random(), true, 1);
end;