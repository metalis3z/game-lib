-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13515046872", 0.75, 1, true, 10);
    p1:CreateSound("rbxassetid://90757583550672", 0.5, 3 + 0.25 * math.random(), true, 5);
end;