-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
game:GetService("ReplicatedStorage");
local script_Parent = script.Parent;
local u1 = tick();
RunService.RenderStepped:Connect(function() -- Line: 8
    -- upvalues: u1 (copy), script_Parent (copy)
    script_Parent.Rotation = (tick() - u1) * 15 % 360;
end);