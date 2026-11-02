-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.9 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13160326139", 0.5, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.05 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://95394392315850", 0.5, 1, true, 5);
    p1:CreateSound("rbxassetid://14000023581", 0.125, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.9 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://113130804676761", 0.5, 1, true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.36 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://113130804676761", 0.4, 1.25, true, 5);

    if not p1:_AnimationWait(script.Name, p3, 3.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://92660146054151", 0.5, 1, true, 5);
end;