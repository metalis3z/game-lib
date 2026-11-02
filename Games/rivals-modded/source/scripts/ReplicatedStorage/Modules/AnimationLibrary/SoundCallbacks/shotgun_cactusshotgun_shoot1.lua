-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://13479562219", 1, 1.25 + 0.25 * math.random(), true, 10);
    p1:CreateSound("rbxassetid://117893025759206", 1.25, 1 + 0.25 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.35 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13515046921", 1, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.15 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13515046988", 1, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13531443905", 0.125, 0.75 + 0.25 * math.random(), true, 10);
end;