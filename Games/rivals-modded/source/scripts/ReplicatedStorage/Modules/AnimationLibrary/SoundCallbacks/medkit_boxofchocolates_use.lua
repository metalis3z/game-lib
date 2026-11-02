-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://75064925834262", 0.875, 1 + 0.2 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 2.05 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://128380920423591", 0.875, 0.8 + 0.2 * math.random(), true, 5);
    p1:CreateSound("rbxassetid://18128896325", 0.75, 1 + 0.25 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://128380920423591", 0.875, 0.8 + 0.2 * math.random(), true, 5);
    p1:CreateSound("rbxassetid://18128896325", 0.75, 1 + 0.25 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.85 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://128380920423591", 0.875, 0.8 + 0.2 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://128380920423591", 0.875, 0.8 + 0.2 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.07 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://128380920423591", 0.75, 0.9 + 0.2 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.04 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://128380920423591", 0.625, 1 + 0.2 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.03 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://18128896325", 0.75, 1 + 0.25 * math.random(), true, 10);
end;