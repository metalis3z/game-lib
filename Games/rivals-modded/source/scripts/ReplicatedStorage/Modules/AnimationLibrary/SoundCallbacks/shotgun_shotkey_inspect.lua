-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 1.85 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://71387264231358", 2.5, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.31 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13236026280", 0.625, 2, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 2.84 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://71387264231358", 2.5, 0.875, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13236026280", 0.5, 1.75, true, 10);
end;