-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    while p1.Animator:IsAnimationHashValid(script.Name, p3) do
        if not p1:_AnimationWait(script.Name, p3, 0.1 / p2) then
            return;
        end;

        p1:CreateSound("rbxassetid://130511754869111", 1, 1 + 0.1 * math.random(), true, 10);
        p1:CreateSound("rbxassetid://119684878895970", 1, 1 + 0.1 * math.random(), true, 10);

        if not p1:_AnimationWait(script.Name, p3, 0.15 / p2) then
            return;
        end;

        p1:CreateSound("rbxassetid://130511754869111", 1, 1 + 0.1 * math.random(), true, 10);
        p1:CreateSound("rbxassetid://119684878895970", 1, 1 + 0.1 * math.random(), true, 10);

        if not p1:_AnimationWait(script.Name, p3, 0.2 / p2) then
            return;
        end;

        p1:CreateSound("rbxassetid://130511754869111", 1, 1 + 0.1 * math.random(), true, 10);
        p1:CreateSound("rbxassetid://119684878895970", 1, 1 + 0.1 * math.random(), true, 10);

        if not p1:_AnimationWait(script.Name, p3, 0.2 / p2) then
            return;
        end;

        p1:CreateSound("rbxassetid://130511754869111", 1, 1 + 0.1 * math.random(), true, 10);
        p1:CreateSound("rbxassetid://119684878895970", 1, 1 + 0.1 * math.random(), true, 10);

        if not p1:_AnimationWait(script.Name, p3, 0.15 / p2) then
            return;
        end;

        p1:CreateSound("rbxassetid://130511754869111", 1, 1 + 0.1 * math.random(), true, 10);
        p1:CreateSound("rbxassetid://119684878895970", 1, 1 + 0.1 * math.random(), true, 10);
    end;
end;