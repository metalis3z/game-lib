-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.55 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://101161696630107", 1.5, 1, true, 10);
    p1:CreateSound("rbxassetid://136174258344321", 0.5, 2 + 0.25 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.9 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://14427935597", 0.75, 1.125, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.6 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13160326139", 1, 1.25, true, 10);
end;