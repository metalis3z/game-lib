-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return function(p1, p2, p3) -- Line: 1
    local v4, _, _ = workspace.CurrentCamera.CFrame:ToEulerAnglesYXZ();
    local math_clamp_ret = math.clamp(v4 / 1.3962634015954636, -1, 1);
    p1:CreateSound("rbxassetid://82715240396507", 1, 1, true, 10);
    p1:CreateSound("rbxassetid://100943371677728", 1, math_clamp_ret * 0.5 + 1, true, 10);
end;