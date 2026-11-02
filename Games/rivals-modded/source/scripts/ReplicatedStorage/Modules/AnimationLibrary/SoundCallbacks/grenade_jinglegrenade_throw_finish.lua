-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.175 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://14522189766", 2, 1 + 0.25 * math.random(), true, 10);
    p1:CreateSound("rbxassetid://137900058595276", 1, 1.25, true, 10);
end;