-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 1.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://115253895253213", 0.875, 1 + 0.2 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://115253895253213", 0.875, 1 + 0.2 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.75 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://137209644295911", 0.875, 1 + 0.2 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.95 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://137209644295911", 0.875, 1 + 0.2 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 1.1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://137209644295911", 0.875, 1 + 0.2 * math.random(), true, 5);
    p1:CreateSound("rbxassetid://135586619814232", 0.875, 1 + 0.2 * math.random(), true, 5);
    p1:CreateSound("rbxassetid://92587536325720", 0.875, 1 + 0.2 * math.random(), true, 5);
end;