-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.375 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://134160823775126", 0.5, 1, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.75 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://128990235337969", 0.75, 0.75, true, 10);
end;