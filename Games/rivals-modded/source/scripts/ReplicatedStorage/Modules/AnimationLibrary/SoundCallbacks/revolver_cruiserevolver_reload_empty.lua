-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.3 / p2) then
        return;
    end;

    for i = 1, 8 do
        p1:CreateSound("rbxassetid://134815282110155", 1, (i - 1) * 0.05 + 1, true, 10);

        if not p1:_AnimationWait(script.Name, p3, 0.05625 / p2) then
            return;
        end;

        local _ = i;
    end;
end;