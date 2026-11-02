-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.13333333333333333 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158330555", 1, 1, true, 10);
    p1:CreateSound("rbxassetid://87740786635301", 0.375 + 0.25 * math.random(), 0.9 + 0.4 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.9166666666666666 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158330666", 1, 1, true, 10);
    p1:CreateSound("rbxassetid://87740786635301", 0.375 + 0.25 * math.random(), 0.9 + 0.4 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.5166666666666667 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158330383", 1, 1, true, 10);
    p1:CreateSound("rbxassetid://87740786635301", 0.375 + 0.25 * math.random(), 0.9 + 0.4 * math.random(), true, 5);
end;