-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 2 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158735106", 0.25, 1.5, true, 10);
    p1:CreateSound("rbxassetid://110122962237431", 1.25, 1.25 + 0.25 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 3 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13456860578", 1.25, 1.25, true, 10);
    p1:CreateSound("rbxassetid://110122962237431", 1.25, 1.25 + 0.25 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.45 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13456860578", 1, 1.5, true, 10);
    p1:CreateSound("rbxassetid://110122962237431", 1.25, 1.25 + 0.25 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13456860578", 0.75, 1.75, true, 10);
    p1:CreateSound("rbxassetid://110122962237431", 1.25, 1.25 + 0.25 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13456860578", 0.25, 1, true, 10);
    p1:CreateSound("rbxassetid://110122962237431", 1.25, 1.25 + 0.25 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 1.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://96253147006478", 0.625, 0.9, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.75 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158735106", 0.25, 1.5, true, 10);
end;