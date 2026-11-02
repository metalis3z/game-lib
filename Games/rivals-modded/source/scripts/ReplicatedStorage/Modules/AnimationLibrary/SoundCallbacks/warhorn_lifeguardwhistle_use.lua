-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    local v4 = p1:CreateSound("rbxassetid://72342434543613", 1, 1, true, 5, 100, 400);

    if v4 then
        v4:SetAttribute("DontClearSound", true);
    end;

    local v5 = p1:CreateSound("rbxassetid://94406584083681", 1, 1, true, 5, 100, 400);

    if v5 then
        v5:SetAttribute("DontClearSound", true);
    end;

    if not p1:_AnimationWait(script.Name, p3, 0.07 / p2) then
        return;
    end;

    p1:CreateSound("rbxassetid://13158735106", 0.5, 1.25, true, 10);
end;