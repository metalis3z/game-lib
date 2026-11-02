-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://80245415527547", 0.75, 1 + 0.1 * math.random(), true, 5);
    p1:CreateSound("rbxassetid://94519339983000", 0.75, 1 + 0.1 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://86450952337176", 0.75, 1 + 0.1 * math.random(), true, 5);
end;