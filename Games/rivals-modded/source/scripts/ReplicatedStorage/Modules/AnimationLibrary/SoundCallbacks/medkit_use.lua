-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13236026280", 0.5, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.48 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13160326139", 0.5, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.22 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13505411336", 0.75, 3.1 * p2, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.2 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13505411414", 0.75, 1.25, true, 10);
end;