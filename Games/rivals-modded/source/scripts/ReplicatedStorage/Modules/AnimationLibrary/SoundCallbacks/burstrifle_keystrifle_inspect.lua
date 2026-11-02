-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 2.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158735106", 0.25, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.45 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://110122962237431", 1.25, 1 + 0.1 * math.random(), true, 5);
    p1:CreateSound("rbxassetid://71387264231358", 0.75, 1 + 0.1 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.55 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://71387264231358", 0.75, 0.75, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.8 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://110122962237431", 1.25, 1 + 0.1 * math.random(), true, 5);
    p1:CreateSound("rbxassetid://71387264231358", 0.75, 1 + 0.1 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.45 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158735106", 0.25, 1.5, true, 10);
end;