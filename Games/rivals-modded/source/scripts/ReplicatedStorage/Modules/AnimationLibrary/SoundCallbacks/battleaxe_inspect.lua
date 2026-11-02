-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 2.75 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158735106", 0.25, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.6 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://137300623286123", 0.75, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://128809359344035", 1, 0.9 + 0.1 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.233 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://128809359344035", 1, 1 + 0.1 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.217 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://128809359344035", 1, 0.8 + 0.1 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.317 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158735106", 0.25, 1.5, true, 10);
end;