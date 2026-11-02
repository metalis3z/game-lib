-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.2833333333333333 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13483008798", 1, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.3 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13236026280", 0.5, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13235979356", 1, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.6166666666666667 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13483008798", 1, 1, true, 10);
end;