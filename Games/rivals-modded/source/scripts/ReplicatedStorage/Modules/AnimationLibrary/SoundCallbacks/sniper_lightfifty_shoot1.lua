-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://13270206222", 1.1, 0.7 + 0.05 * math.random(), true, 10);
    p1:CreateSound("rbxassetid://13270206087", 1.1, 0.7 + 0.05 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.55 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13455395017", 1, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.45 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13455395090", 0.25, 0.75 + 0.25 * math.random(), true, 10);
    p1:CreateSound("rbxassetid://13455395017", 1, 0.7, true, 10);
end;