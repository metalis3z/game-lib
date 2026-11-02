-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://136633555539199", 1, 0.625, true, 10);
    p1:CreateSound("rbxassetid://21343225", 0.25 + 0.125 * math.random(), 0.9 + 0.2 * math.random(), true, 10);
end;