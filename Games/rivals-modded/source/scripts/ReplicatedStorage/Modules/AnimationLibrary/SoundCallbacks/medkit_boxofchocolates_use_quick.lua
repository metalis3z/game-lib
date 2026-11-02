-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://75064925834262", 0.875, 1 + 0.2 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.3 / p2) then
        return;
    end;

    for i = 1, 3 do
        p1:CreateSound("rbxassetid://128380920423591", 0.875, 0.8 + 0.2 * math.random(), true, 5);

        if not p1:_AnimationWait(script.Name, p3, 0.1 / p2) then
            return;
        end;

        local _ = i;
    end;

    p1:CreateSound("rbxassetid://18128896325", 0.75, 1 + 0.25 * math.random(), true, 10);
end;