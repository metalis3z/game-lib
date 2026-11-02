-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://13456860578", 1.5, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.35 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13236026280", 1, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13235979356", 1, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.3 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158330383", 1, 0.75, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.25 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158330383", 1, 1, true, 10);
end;