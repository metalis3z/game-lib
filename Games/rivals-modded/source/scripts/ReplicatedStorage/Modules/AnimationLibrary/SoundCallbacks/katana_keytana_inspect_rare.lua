-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = { "rbxassetid://14000023581", "rbxassetid://14000023392" };

return function(u2, u3, u4) -- Line: 3
    -- upvalues: u1 (copy)
    if not u2:_AnimationWait(script.Name, u4, 2 / u3) then
        return;
    end;

    u2:CreateSound("rbxassetid://14427935597", 0.5, 1.125, true, 10);
    u2:CreateSound("rbxassetid://96253147006478", 0.75, 1.25, true, 10);

    if not u2:_AnimationWait(script.Name, u4, 0.25 / u3) then
        return;
    end;

    u2:CreateSound("rbxassetid://96253147006478", 0.5, 1.375, true, 10);

    if not u2:_AnimationWait(script.Name, u4, 0.25 / u3) then
        return;
    end;

    u2:CreateSound("rbxassetid://96253147006478", 0.25, 1.5, true, 10);

    if not u2:_AnimationWait(script.Name, u4, 0.375 / u3) then
        return;
    end;

    for i = 1, 15 do
        u2:CreateSound(u1[math.random(#u1)], 1, 1 + 0.25 * math.random(), true, 10);
        u2:CreateSound("rbxassetid://96253147006478", 0.375, 1 + 0.5 * math.random(), true, 10);

        if not u2:_AnimationWait(script.Name, u4, 0.058333333333333334 / u3) then
            return;
        end;

        local _ = i;
    end;

    if not u2:_AnimationWait(script.Name, u4, 0.15 / u3) then
        return;
    end;

    u2:CreateSound("rbxassetid://96253147006478", 0.2, 1.25, true, 10);

    if not u2:_AnimationWait(script.Name, u4, 0.25 / u3) then
        return;
    end;

    u2:CreateSound("rbxassetid://96253147006478", 0.1, 1.5, true, 10);
    u2:CreateSound("rbxassetid://89056031983351", 0.75, 1.117, true, 10);

    if not u2:_AnimationWait(script.Name, u4, 0.933 / u3) then
        return;
    end;

    u2:CreateSound("rbxassetid://133090858473825", 0.75, 1, true, 10);

    if not u2:_AnimationWait(script.Name, u4, 0.5 / u3) then
        return;
    end;

    u2:CreateSound("rbxassetid://90757583550672", 0.75, 1 + 0.125 * math.random(), true, 5);

    for i = 1, 3 do
        u2:CreateSound("rbxassetid://14427782350", 1, (i - 1) * 0.25 + 1, true, 10);

        if not u2:_AnimationWait(script.Name, u4, 0.05 / u3) then
            return;
        end;

        local _ = i;
    end;

    if not u2:_AnimationWait(script.Name, u4, 0.5 / u3) then
        return;
    end;

    u2:CreateSound("rbxassetid://71387264231358", 1, 0.875, true, 10);

    if not u2:_AnimationWait(script.Name, u4, 0.767 / u3) then
        return;
    end;

    local u5 = u2:CreateSound("rbxassetid://82637145735352", 0.5, 1 + 0.1 * math.random(), true);
    task.spawn(function() -- Line: 81
        -- upvalues: u2 (copy), u4 (copy), u3 (copy), u5 (copy)
        if not u2:_AnimationWait(script.Name, u4, 2.5 / u3) then
            return;
        end;

        if u5 then
            u5:Destroy();
        end;
    end);

    if not u2:_AnimationWait(script.Name, u4, 1.45 / u3) then
        return;
    end;

    for i = 1, 5 do
        u2:CreateSound("rbxassetid://13160326139", 0.75, 1 + 0.25 * math.random(), true, 10);

        if not u2:_AnimationWait(script.Name, u4, 0.2 / u3) then
            return;
        end;

        local _ = i;
    end;
end;