-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13515046921", 1, 1.25, true, 10);
    p1:CreateSound("rbxassetid://13236026280", 1, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.717 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13160326139", 1, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 2.783 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13160326139", 0.5, 1.75, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.6 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13235979356", 1, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.15 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13515046988", 1, 1.25, true, 10);
end;