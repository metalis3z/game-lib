-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://73644074370077", 0.875, 1 + 0.2 * math.random(), true, 5);
    p1:CreateSound("rbxassetid://108166862465565", 0.75, 1 + 0.2 * math.random(), true, 5);

    for i = 1, 3 do
        p1:CreateSound("rbxassetid://18763517194", 1, 1 + 0.25 * math.random(), true, 5);

        if not p1:_AnimationWait(script.Name, p3, 0.1 / p2) then
            return;
        end;

        local _ = i;
    end;
end;