-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://130860307965581", 1, 1 + 0.1 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 7.15 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://114610550422028", 1, 1 + 0.25 * math.random(), true, 10);
end;