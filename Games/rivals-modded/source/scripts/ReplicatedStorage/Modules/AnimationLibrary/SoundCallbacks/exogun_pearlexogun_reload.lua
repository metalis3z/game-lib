-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.4 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://17266070911", 0.75, 1, true, 10);
    p1:CreateSound("rbxassetid://121938614359106", 0.75, 0.75, true, 10);
end;