-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 1.2 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158735106", 0.25, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.9 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158735106", 0.25, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.35 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://114830743588818", 0.5, 1 + 0.1 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.3 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://114830743588818", 0.5, 1.1 + 0.1 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.25 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://114830743588818", 0.5, 1.2 + 0.1 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.05 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://135828654526098", 1, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 3.1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://78252768764835", 1, 1, true, 10);
    p1:CreateSound("rbxassetid://92760487729234", 1, 1.5, true, 10);
end;