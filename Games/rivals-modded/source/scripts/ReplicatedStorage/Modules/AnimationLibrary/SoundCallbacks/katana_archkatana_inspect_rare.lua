-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.95 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://108879620126710", 1.25, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 2.05 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://14000023581", 1, 0.75, true, 10);
    p1:CreateSound("rbxassetid://86510987016114", 0.75, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.82 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://90310901394527", 1.25, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.33 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://14427782350", 1, 0.875, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.25 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://118906938239363", 1, 0.9 + 0.2 * math.random(), true, 10);
end;