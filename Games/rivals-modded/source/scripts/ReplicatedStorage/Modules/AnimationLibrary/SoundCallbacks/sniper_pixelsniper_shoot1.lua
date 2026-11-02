-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://17650837718", 1, 0.95 + 0.1 * math.random(), true, 10);
    p1:CreateSound("rbxassetid://17650837503", 0.875, 0.95 + 0.1 * math.random(), true, 10);
    p1:CreateSound("rbxassetid://17650964342", 0.75, 1 + 0.1 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17650837861", 1, 3, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.067 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17650837861", 1, 2, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.05 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17650837861", 1, 2, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.183 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17650837861", 1, 3, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.05 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17650838003", 0.5, 0.875 + 0.25 * math.random(), true, 10);
end;