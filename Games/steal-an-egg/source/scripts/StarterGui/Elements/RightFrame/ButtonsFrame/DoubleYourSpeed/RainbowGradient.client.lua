-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local UIGradient = script.Parent:WaitForChild("UIGradient");
local u1 = 0;
RunService.RenderStepped:Connect(function(p2) -- Line: 7
    -- upvalues: u1 (ref), UIGradient (copy)
    u1 = u1 + p2 * 0.1;
    local Color3_fromHSV_ret = Color3.fromHSV(u1 % 1, 0.8, 1);
    local Color3_fromHSV_ret2 = Color3.fromHSV((u1 + 0.05) % 1, 0.8, 1);
    UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3_fromHSV_ret), ColorSequenceKeypoint.new(1, Color3_fromHSV_ret2) });
end);