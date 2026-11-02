-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.25 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13483008798", 1, 2.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.65 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://14240944488", 0.75, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.9 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://14240944327", 1, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.35 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13483008798", 1, 1.75, true, 10);
end;