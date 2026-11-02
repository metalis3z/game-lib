-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 2.2 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17274387490", 0.375, 1, true, 10);
    p1:CreateSound("rbxassetid://17803360572", 1, 2.5 + 0.25 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.7 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17274387490", 0.25, 0.9, true, 10);
    p1:CreateSound("rbxassetid://17803360572", 1, 2 + 0.2 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.25 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158735106", 0.25, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.6 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158735106", 0.2, 1.25, true, 10);
end;