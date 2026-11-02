-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 2.05 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://96253147006478", 0.5, 0.8, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.05 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://96253147006478", 0.625, 0.9, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.2 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://96253147006478", 0.75, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.25 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://96253147006478", 0.5, 1.375, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.25 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://96253147006478", 0.25, 1.5, true, 10);
end;