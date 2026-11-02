-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.2 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://96886470957330", 0.875, 1.25 + 0.125 * math.random(), true, 5);
    p1:CreateSound("rbxassetid://135836738518083", 0.5, 1.25, true, 10);
    p1:CreateSound("rbxassetid://115657023572170", 0.875, 0.95 + 0.1 * math.random(), true, 10);
end;