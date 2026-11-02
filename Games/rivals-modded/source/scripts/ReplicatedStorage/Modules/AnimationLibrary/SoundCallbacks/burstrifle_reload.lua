-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13236549962", 1, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.1 / p2) then
        return;
    end;

    if not p1:_AnimationWait(script.Name, p3, 0.95 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13236549929", 1, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.39 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13160326139", 0.75, 1, true, 10);
end;