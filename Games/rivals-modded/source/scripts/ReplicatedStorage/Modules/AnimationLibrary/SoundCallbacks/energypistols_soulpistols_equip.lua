-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    p1:CreateSound("rbxassetid://13456860578", 1.25, 1.5, true, 0.5 / p2);
    p1:CreateSound("rbxassetid://134917124344503", 0.5, 1.25, true, 5);

    if not p1:_AnimationWait(script.Name, p3, 0.5 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13483008798", 1, 2, true, 10);
end;