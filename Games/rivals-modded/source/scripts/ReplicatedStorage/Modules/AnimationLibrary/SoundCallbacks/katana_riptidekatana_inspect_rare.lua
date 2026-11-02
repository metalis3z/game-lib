-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 1.7 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://14427935597", 0.5, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.45 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://14427935597", 0.5, 1.125, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://14427935597", 0.5, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.55 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://14000023581", 0.5, 1, true, 10);
    p1:CreateSound("rbxassetid://14427782350", 1, 1, true, 10);
    p1:CreateSound("rbxassetid://118319832364364", 0.875, 1 + 0.125 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.15 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://14000023581", 0.5, 1, true, 10);
    p1:CreateSound("rbxassetid://14427782350", 1, 1, true, 10);
    p1:CreateSound("rbxassetid://118319832364364", 0.875, 1.125 + 0.125 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.55 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://14000023581", 0.5, 1, true, 10);
    p1:CreateSound("rbxassetid://14427782350", 1, 1, true, 10);
    p1:CreateSound("rbxassetid://118319832364364", 0.875, 1.25 + 0.125 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 1.55 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://70883497288606", 0.625, 1.25 + 0.1 * math.random(), true, 5);
end;