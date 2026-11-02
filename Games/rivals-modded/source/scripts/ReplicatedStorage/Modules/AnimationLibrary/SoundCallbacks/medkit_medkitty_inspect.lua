-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.65 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://92941076104902", 1, 0.75, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 1.1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://128990235337969", 1.5, 1, true, 10);
end;