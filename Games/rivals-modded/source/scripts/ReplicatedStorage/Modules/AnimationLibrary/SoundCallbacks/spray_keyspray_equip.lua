-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = { 23, 27, 30, 36, 41, 47, 49, 54, 67 };

return function(p2, p3, p4) -- Line: 3
    -- upvalues: u1 (copy)
    p2:CreateSound("rbxassetid://100664516053133", 0.25, 1.5, true, 10);

    for i, v in pairs(u1) do
        p2:CreateSound("rbxassetid://14241444681", 1, 1 + 0.25 * math.random(), true, 10);
        p2:CreateSound("rbxassetid://110122962237431", 1.25, 1.25 + 0.25 * math.random() + 0.25, true, 5);

        if not p2:_AnimationWait(script.Name, p4, (v - (u1[i - 1] or 0)) / 60 / p3) then
            return;
        end;
    end;

    if not p2:_AnimationWait(script.Name, p4, 0.2 / p3) then
        return;
    end;

    p2:CreateSound("rbxassetid://13158735106", 0.25, 1.5, true, 10);
end;