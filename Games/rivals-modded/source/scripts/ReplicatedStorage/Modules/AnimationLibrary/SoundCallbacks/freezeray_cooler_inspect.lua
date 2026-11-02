-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://130350823905316", 0.875, 1 + 0.2 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.7 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://91186416702443", 0.25, 1 + 0.1 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 1.95 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://91186416702443", 0.5, 0.9 + 0.1 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://130350823905316", 0.875, 1 + 0.2 * math.random(), true, 5);
end;