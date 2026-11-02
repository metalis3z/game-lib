-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.8 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17650945056", 1.25, 1.5, true, 10);
    p1:CreateSound("rbxassetid://17650837503", 1.25, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.63 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17650945056", 1, 1, true, 10);
    p1:CreateSound("rbxassetid://17650837718", 1, 2, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.03 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17650837861", 1, 2, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.66 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17650837861", 1, 1, true, 10);
end;