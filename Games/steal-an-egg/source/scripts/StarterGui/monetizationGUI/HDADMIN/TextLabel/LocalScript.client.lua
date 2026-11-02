-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local UIGradient = script.Parent:WaitForChild("UIGradient");
local u1 = 3;
RunService.Heartbeat:Connect(function(p2) -- Line: 8
    -- upvalues: u1 (ref), UIGradient (copy)
    u1 = u1 + p2;
    UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromHSV(u1 % 1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.fromHSV((u1 + 0.2) % 1, 1, 1)) });
    UIGradient.Rotation = u1 * 60 % 360;
end);