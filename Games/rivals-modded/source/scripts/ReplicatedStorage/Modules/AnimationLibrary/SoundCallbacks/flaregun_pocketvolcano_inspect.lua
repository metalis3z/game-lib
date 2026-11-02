-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 2.2 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://111475442610934", 4, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.28 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://106855758356398", 0.25, 1.5, true, 10);
end;