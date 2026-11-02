-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 1.05 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13160326139", 0.25, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.6 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://70883497288606", 0.75, 1 + 0.1 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://70883497288606", 0.6, 0.875 + 0.075 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.3 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://70883497288606", 0.45, 0.75 + 0.05 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 2.15 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158735106", 0.25, 1.5, true, 10);
end;