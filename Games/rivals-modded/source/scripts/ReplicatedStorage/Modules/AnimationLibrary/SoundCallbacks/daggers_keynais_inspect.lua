-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://71387264231358", 1.25, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.6 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13160326139", 0.375, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.35 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158735106", 0.25, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 3.2 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://96253147006478", 0.6, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.25 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://96253147006478", 0.6, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://96253147006478", 0.6, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.35 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://96253147006478", 0.6, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.45 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://93178963908825", 1, 1 + 0.25 * math.random(), true, 10);
    p1:CreateSound("rbxassetid://96253147006478", 0.625, 1.75 + 0.5 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.9 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://71387264231358", 1.25, 1, true, 10);
end;