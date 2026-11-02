-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.3 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13455229044", 1, 1.1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.1666666666666667 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13455229188", 1, 1.1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.7166666666666667 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13455395017", 1, 2, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.18333333333333332 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13455395017", 1, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.2166666666666666 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13455394948", 1, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.23333333333333334 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13455394948", 1, 2, true, 10);
end;