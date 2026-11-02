-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://96253147006478", 0.6, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.15 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://110122962237431", 0.75, 0.5 + 0.1 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.85 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://110122962237431", 1, 1.1 + 0.1 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13160326139", 0.375, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158735106", 0.25, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 2.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158735106", 0.25, 1.5, true, 10);
end;