-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 1.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://92914419322840", 1, 1 + 0.1 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.3 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://92914419322840", 0.875, 1 + 0.1 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://18128896162", 1, 1 + 0.25 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://78700624599503", 1.25, 1 + 0.1 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1 / p2) then
        return;
    end;

    for i = 1, 5 do
        p1:CreateSound("rbxassetid://18128896325", 1 - i * 0.15, i * 0.1 + 1, true, 10);

        if not p1:_AnimationWait(script.Name, p3, 0.1 / p2) then
            return;
        end;

        local _ = i;
    end;
end;