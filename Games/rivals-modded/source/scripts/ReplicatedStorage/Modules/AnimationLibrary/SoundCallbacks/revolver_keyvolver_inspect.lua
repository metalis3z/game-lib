-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.25 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13456860578", 1.25, 1.5, true, 10);
    p1:CreateSound("rbxassetid://110122962237431", 1.25, 1.25 + 0.25 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.55 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13483008798", 1, 2, true, 10);
    p1:CreateSound("rbxassetid://110122962237431", 1.25, 1 + 0.1 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 1.75 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://71387264231358", 0.25, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.55 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://71387264231358", 0.125, 1.25, true, 10);
end;