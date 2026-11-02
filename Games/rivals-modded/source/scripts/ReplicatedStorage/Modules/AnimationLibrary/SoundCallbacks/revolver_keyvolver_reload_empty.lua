-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.283 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13483008798", 1.25, 2.5, true, 10);
    p1:CreateSound("rbxassetid://90757583550672", 0.625, 1.25 + 0.25 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.283 / p2) then
        return;
    end;

    for i = 1, 6 do
        p1:CreateSound("rbxassetid://14241444681", 1, i * 0.125 + 1, true, 10);
        p1:CreateSound("rbxassetid://110122962237431", 1.25, 1.25 + 0.25 * math.random() + i * 0.125, true, 5);

        if not p1:_AnimationWait(script.Name, p3, 0.044500000000000005 / p2) then
            return;
        end;

        local _ = i;
    end;

    p1:CreateSound("rbxassetid://71387264231358", 1.25, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.45 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13483008798", 1.25, 1.75, true, 10);
    p1:CreateSound("rbxassetid://90757583550672", 0.625, 1 + 0.1 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.767 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13483008798", 0.5, 2, true, 10);
    p1:CreateSound("rbxassetid://110122962237431", 0.375, 1.5 + 0.5 * math.random(), true, 5);
end;