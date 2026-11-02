-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.7 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://93644201634454", 0.75, 0.75 + 0.1 * math.random(), true, 5);
    p1:CreateSound("rbxassetid://107381185026224", 0.5, 1 + 0.1 * math.random(), true, 5);
end;