-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://113227486192611", 0.875, 0.7 + 0.1 * math.random(), true, 10);
    p1:CreateSound("rbxassetid://122971606160018", 0.875, 0.7 + 0.1 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 2.13 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17672502879", 0.875, 0.875, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.62 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17672502879", 0.5, 3, true, 10);
end;