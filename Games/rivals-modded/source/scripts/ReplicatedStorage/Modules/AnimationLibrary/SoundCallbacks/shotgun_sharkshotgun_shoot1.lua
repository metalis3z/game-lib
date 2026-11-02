-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://13479562219", 0.75, 1.25 + 0.25 * math.random(), true, 10);
    p1:CreateSound("rbxassetid://89420994269759", 1, 1 + 0.1 * math.random(), true, 5);
    p1:CreateSound("rbxassetid://107381185026224", 1, 1 + 0.1 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.3 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://93644201634454", 0.75, 1 + 0.1 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.15 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://93644201634454", 0.25, 0.75 + 0.1 * math.random(), true, 5);
end;