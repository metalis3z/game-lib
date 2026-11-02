-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://124941279780653", 1, 1 + 0.1 * math.random(), true, 5):SetAttribute("DontClearSound", true);
    p1:CreateSound("rbxassetid://125852790214228", 1, 1 + 0.1 * math.random(), true, 5):SetAttribute("DontClearSound", true);
    p1:CreateSound("rbxassetid://124261472912756", 1, 1 + 0.1 * math.random(), true, 5):SetAttribute("DontClearSound", true);

    for i = 1, 5 do
        if not p1:_AnimationWait(script.Name, p3, 0.1 / p2) then
            return;
        end;

        p1:CreateSound("rbxassetid://10730819", 2 + 0.25 * math.random(), 0.9 + 0.2 * math.random(), true, 10):SetAttribute("DontClearSound", true);
        local _ = i;
    end;
end;