-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = { "rbxassetid://13677205703", "rbxassetid://13677205578", "rbxassetid://13677205647" };

return function(p2, p3, p4) -- Line: 3
    -- upvalues: u1 (copy)
    p2:CreateSound(u1[math.random(#u1)], 3, 0.95 + 0.1 * math.random(), true, 10);
    p2:CreateSound("rbxassetid://82249006680828", 0.375, 0.95 + 0.25 * math.random(), true, 10);

    if not p2:_AnimationWait(script.Name, p4, 0.5 / p3) then
        return;
    end;

    p2:CreateSound("rbxassetid://13682183816", 0.5, 0.95 + 0.1 * math.random(), true, 10);
end;