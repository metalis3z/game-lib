-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://107901458751913", 1.5, 2, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://92573395473684", 1.25, 0.7 * p2 / 0.729, true, 10);
end;