-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.05 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17803360572", 1, 2, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.85 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17803360572", 1, 3, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.55 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17803360572", 1, 1.25, true, 10);
end;