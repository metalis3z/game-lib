-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");

return function(p1, p2, p3) -- Line: 3
    -- upvalues: RunService (copy)
    if not p1:_AnimationWait(script.Name, p3, 0.75 / p2) then
        return;
    end;

    local v4 = p1:CreateSound("rbxassetid://135262581066376", 1, 1, true, 10);

    while p1.Animator:IsAnimationHashValid(script.Name, p3) do
        RunService.RenderStepped:Wait();
    end;

    if v4 then
        v4:Destroy();
    end;
end;