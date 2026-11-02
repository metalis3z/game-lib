-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 1.1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13236549929", 1, 0.875, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 2.05 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13236549929", 1, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.7 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13455395017", 1, 0.75, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.7 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13455395017", 1, 1.1, true, 10);
end;