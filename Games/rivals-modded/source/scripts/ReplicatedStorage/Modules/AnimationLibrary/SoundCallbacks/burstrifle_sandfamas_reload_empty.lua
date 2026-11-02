-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13236549962", 1, 1.25, true, 10);
    p1:CreateSound("rbxassetid://87740786635301", 0.375 + 0.25 * math.random(), 0.9 + 0.4 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.8 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13236549962", 1, 1, true, 10);
    p1:CreateSound("rbxassetid://87740786635301", 0.375 + 0.25 * math.random(), 0.9 + 0.4 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.35 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13455395017", 1, 1, true, 10);
    p1:CreateSound("rbxassetid://87740786635301", 0.375 + 0.25 * math.random(), 0.9 + 0.4 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.217 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13455395017", 1, 1.25, true, 10);
    p1:CreateSound("rbxassetid://87740786635301", 0.375 + 0.25 * math.random(), 0.9 + 0.4 * math.random(), true, 5);
end;