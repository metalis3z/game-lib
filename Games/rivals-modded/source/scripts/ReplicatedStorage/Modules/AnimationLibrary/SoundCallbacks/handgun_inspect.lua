-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.8 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158330666", 1, 1.4, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.63 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158330666", 1, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.03 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13907558696", 1, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.66 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13907558634", 1, 1, true, 10);
end;