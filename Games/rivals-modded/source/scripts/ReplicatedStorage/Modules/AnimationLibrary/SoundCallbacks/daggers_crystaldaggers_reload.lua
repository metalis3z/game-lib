-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://72570123237418", 0.875, 4, true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.1 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://72570123237418", 0.5, 6, true, 10);
end;