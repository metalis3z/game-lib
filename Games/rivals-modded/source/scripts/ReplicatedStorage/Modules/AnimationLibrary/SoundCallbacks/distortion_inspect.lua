-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 2.2 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://139955889483895", 0.75, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 2.45 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://139955889483895", 0.75, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://132926867312544", 0.25, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158735106", 0.25, 1.5, true, 10);
end;