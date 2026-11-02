-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.55 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://126069605787926", 1, 1.25 + 0.25 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.03 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://126069605787926", 1, 1.25 + 0.25 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.12 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://126069605787926", 1, 1.25 + 0.25 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.083 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://126069605787926", 1, 1.25 + 0.25 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://126069605787926", 1, 1.25 + 0.25 * math.random(), true, 10);
end;