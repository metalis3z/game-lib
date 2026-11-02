-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://13270206222", 0.875, 0.95 + 0.1 * math.random(), true, 10);
    p1:CreateSound("rbxassetid://13270206087", 0.875, 0.95 + 0.1 * math.random(), true, 10);
    p1:CreateSound("rbxassetid://71304774842482", 0.875, 0.95 + 0.1 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13455395017", 1, 2, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.067 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13455395017", 1, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.05 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13455394948", 1, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.183 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13455394948", 1, 2, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.05 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13455395090", 0.25, 0.75 + 0.25 * math.random(), true, 10);
end;