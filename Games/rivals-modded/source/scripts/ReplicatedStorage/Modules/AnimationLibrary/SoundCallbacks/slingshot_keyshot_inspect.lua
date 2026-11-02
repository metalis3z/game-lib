-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    if not p1:_AnimationWait(script.Name, p3, 0.55 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://8971407217", 0.5, 1.25, true, 5);
    p1:CreateSound("rbxassetid://110122962237431", 1.25, 1 + 0.1 * math.random(), true, 5);

    if not p1:_AnimationWait(script.Name, p3, 2.85 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://14241444681", 0.5, 1.5, true, 10);
    p1:CreateSound("rbxassetid://110122962237431", 1.25, 1 + 0.1 * math.random(), true, 5);
    p1:CreateSound("rbxasset://sounds//Rubber band sling shot.mp3", 0.75, 1.4 + 0.2 * math.random(), true, 5);
end;