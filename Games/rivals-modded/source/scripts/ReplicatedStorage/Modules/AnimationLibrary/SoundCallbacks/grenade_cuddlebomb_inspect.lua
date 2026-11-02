-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 2 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://102298651472826", 0.875, 1 + 0.2 * math.random(), true, 5);
end;