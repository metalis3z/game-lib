-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://13682898881", 1, 0.95 + 0.1 * math.random(), true, 10);
    p1:CreateSound("rbxassetid://13682223944", 0.75, 1 + 0.5 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.25 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13682898881", 1, 0.95 + 0.1 * math.random(), true, 10);
    p1:CreateSound("rbxassetid://13682223944", 0.75, 1 + 0.5 * math.random(), true, 10);
end;