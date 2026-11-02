-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = { "rbxassetid://14000023581", "rbxassetid://14000023392" };

return function(p2, p3, p4) -- Line: 6
    -- upvalues: u1 (copy)
    for i = 1, 15 do
        p2:CreateSound(u1[math.random(#u1)], 0.75 + 0.5 * math.random(), 2 + 0.5 * math.random(), true, 10);
        p2:CreateSound("rbxassetid://13455968853", 0.375, 1.25 + 0.25 * math.random(), true, 10);

        if not p2:_AnimationWait(script.Name, p4, 0.06666666666666667 / p3) then
            return;
        end;

        local _ = i;
    end;
end;