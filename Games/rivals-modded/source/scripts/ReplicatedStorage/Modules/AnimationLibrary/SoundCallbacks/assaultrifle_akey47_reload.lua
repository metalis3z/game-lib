-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://13158735106", 0.25, 0.5, true, 10);
    p1:CreateSound("rbxassetid://96253147006478", 0.6, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.94 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13236549929", 1, 0.875, true, 10);
    p1:CreateSound("rbxassetid://110122962237431", 1, 1.1 + 0.1 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.86 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13236549962", 1, 1, true, 10);
    p1:CreateSound("rbxassetid://110122962237431", 1, 1 + 0.1 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.87 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13455395017", 1, 0.75, true, 10);
    p1:CreateSound("rbxassetid://110122962237431", 1, 0.75 + 0.05 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.3 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13455395017", 1, 1, true, 10);
    p1:CreateSound("rbxassetid://110122962237431", 1, 1.1 + 0.1 * math.random(), true, 5);
end;