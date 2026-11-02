-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.35 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://125248293081026", 1, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.3 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://110013540349061", 1, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.7 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://125248293081026", 1, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.75 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://96411310492226", 1, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://92333760834779", 0.5, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.25 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://127123065378139", 1, 1, true, 10);
end;