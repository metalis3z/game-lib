-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.3 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://124893673183314", 1, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.6 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://129245637994313", 0.5, 1.5, true, 10);
    p1:CreateSound("rbxassetid://80643999817278", 0.5, 1.5, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.75 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13456860578", 1, 1, true, 10);
    p1:CreateSound("rbxassetid://13160326139", 0.25, 1, true, 10);
end;