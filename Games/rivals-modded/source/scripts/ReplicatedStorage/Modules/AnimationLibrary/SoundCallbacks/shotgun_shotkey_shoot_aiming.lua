-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://115657023572170", 1, 1.5 + 0.25 * math.random(), true, 10);
    p1:CreateSound("rbxassetid://13479562219", 0.875, 2 + 0.25 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.2 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://96253147006478", 0.75, 1.25, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.2 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://96253147006478", 0.25, 1.5, true, 10);
end;