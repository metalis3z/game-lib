-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.35 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13483008798", 1.25, 2.5, true, 10);
    p1:CreateSound("rbxassetid://90757583550672", 0.625, 1.25 + 0.25 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13456860578", 0.25, 2, true, 10);
    p1:CreateSound("rbxassetid://100664516053133", 0.25, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.25 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://71387264231358", 1.25, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://14241444681", 1, 1.125, true, 10);
    p1:CreateSound("rbxassetid://110122962237431", 1.25, 1.25 + 0.25 * math.random() + 0.125, true, 5);
end;