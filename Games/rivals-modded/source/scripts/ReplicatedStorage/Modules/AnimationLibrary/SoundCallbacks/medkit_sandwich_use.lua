-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://13158735106", 0.25, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://18128896162", 1, 1 + 0.25 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.95 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://18128896162", 1, 1 + 0.25 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.56 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://18128896162", 1, 1 + 0.25 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.29 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://18128896162", 0.5, 1 + 0.25 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.8 / p2) then
        return;
    end;

    if math.random() < 0.628 then
        p1:CreateSound("rbxassetid://18128949754", 0.6, 1 + 0.1 * math.random(), true, 10);
    end;
end;