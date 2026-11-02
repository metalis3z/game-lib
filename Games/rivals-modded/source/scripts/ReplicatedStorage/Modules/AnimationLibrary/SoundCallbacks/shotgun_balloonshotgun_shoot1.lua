-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(u1, u2, u3) -- Line: 1
    for i = 1, 5 do
        task.spawn(function() -- Line: 3
            -- upvalues: u1 (copy), u3 (copy), u2 (copy), i (copy)
            if not u1:_AnimationWait(script.Name, u3, 0.15 / u2 * i / 5) then
                return;
            end;

            u1:CreateSound("rbxassetid://17803308936", 1 + 0.25 * math.random(), 1 + 0.3 * math.random(), true, 10);
        end);
        local _ = i;
    end;

    if not u1:_AnimationWait(script.Name, u3, 0.35 / u2) then
        return;
    end;

    u1:CreateSound("rbxassetid://17803360572", 1, 2, true, 10);

    if not u1:_AnimationWait(script.Name, u3, 0.15 / u2) then
        return;
    end;

    u1:CreateSound("rbxassetid://17803360572", 1, 1.25, true, 10);

    if not u1:_AnimationWait(script.Name, u3, 0.1 / u2) then
        return;
    end;

    u1:CreateSound("rbxassetid://17803368105", 0.5, 0.75 + 0.25 * math.random(), true, 10);
end;