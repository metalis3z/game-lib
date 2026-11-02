-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.3 / p2) then
        return;
    end;

    if not p1:_AnimationWait(script.Name, p3, 0.3 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17092564046", 0.5, 1.75, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.6 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://14427935597", 0.5, 0.75, true, 10);
    p1:CreateSound("rbxassetid://13456860578", 1.25, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.95 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17092564046", 0.75, 1, true, 10);

    if p1:_AnimationWait(script.Name, p3, 0.2 / p2) then
    end;
end;