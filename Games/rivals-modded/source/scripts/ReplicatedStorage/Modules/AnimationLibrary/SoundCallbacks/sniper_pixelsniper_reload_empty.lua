-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.65 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17650837861", 1, 3, true, 10);
    p1:CreateSound("rbxassetid://17650837861", 1, 2, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.233 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17650838003", 0.5, 0.875 + 0.25 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.2 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17650945056", 1, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.85 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17650945056", 1, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.78 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17650837861", 1, 2, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.25 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17650837861", 1, 3, true, 10);
end;