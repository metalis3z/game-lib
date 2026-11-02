-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 1.05 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://71387264231358", 1.25, 1.5, true, 10);
    p1:CreateSound("rbxassetid://13483008798", 0.5, 2, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://71387264231358", 1.25, 1, true, 10);
    p1:CreateSound("rbxassetid://13483008798", 0.5, 1.75, true, 10);
end;