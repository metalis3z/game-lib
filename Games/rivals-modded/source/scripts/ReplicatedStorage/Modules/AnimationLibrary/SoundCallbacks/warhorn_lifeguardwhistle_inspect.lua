-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 3.7 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://14427935597", 0.75, 1.125, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13160326139", 0.25, 1.75, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.35 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13160326139", 0.5, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 2.7 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://14427935597", 0.75, 1.125, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13160326139", 0.25, 1.75, true, 10);
end;