-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.55 / p2) then
        return;
    end;

    p1:CreateSpectatorSound("rbxassetid://113941779770778", 1, 1 + 0.1 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.3 / p2) then
        return;
    end;

    p1:CreateSpectatorSound("rbxassetid://108891371725091", 1, 1 + 0.1 * math.random(), true, 10);
    p1:CreateSpectatorSound("rbxassetid://76064160033456", 1, 1 + 0.1 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.55 / p2) then
        return;
    end;

    p1:CreateSpectatorSound("rbxassetid://108891371725091", 1, 1 + 0.1 * math.random(), true, 10);

    if not p1:_AnimationWait(script.Name, p3, 0.15 / p2) then
        return;
    end;

    p1:CreateSpectatorSound("rbxassetid://106430462780583", 1, 1.5 + 0.2 * math.random(), true, 10);
end;