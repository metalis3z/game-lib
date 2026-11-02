-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.2 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13456860578", 1.5, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.35 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13456860578", 1.25, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.45 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13483008798", 1, 2, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 3.95 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13456860578", 1.5, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.45 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13483008798", 1.25, 2.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.25 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13456860578", 1.25, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.41 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13483008798", 1, 2, true, 10);
end;