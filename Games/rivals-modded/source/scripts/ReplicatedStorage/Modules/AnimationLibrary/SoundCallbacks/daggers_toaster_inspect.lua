-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.85 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://88834968924220", 1, 1 + 0.2 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.35 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13160326139", 0.25, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://18128896162", 1, 1 + 0.25 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.05 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://122724754588572", 1.25, 1 + 0.2 * math.random(), true, 5);
end;