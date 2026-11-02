-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    local v4, _, _ = workspace.CurrentCamera.CFrame:ToEulerAnglesYXZ();
    local math_clamp_ret = math.clamp(v4 / 1.3962634015954636, -1, 1);
    p1:CreateSound("rbxassetid://77594993345414", 0.875, math_clamp_ret * 0.4 + 0.9, true, 5);
    p1:CreateSound("rbxassetid://132970131270232", 0.875, math_clamp_ret * 0.2 + 0.95, true, 5);
end;