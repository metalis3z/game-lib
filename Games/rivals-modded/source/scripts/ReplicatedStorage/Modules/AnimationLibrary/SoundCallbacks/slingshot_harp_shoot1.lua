-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    local v4, _, _ = workspace.CurrentCamera.CFrame:ToEulerAnglesYXZ();
    local math_clamp_ret = math.clamp(v4 / 1.3962634015954636, -1, 1);
    p1:CreateSound("rbxassetid://117069125273832", 0.75, math_clamp_ret * 0.5 + 1.75, true, 5);
    p1:CreateSound("rbxassetid://127039236309973", 1, math_clamp_ret * 0.25 + 1, true, 5);
end;