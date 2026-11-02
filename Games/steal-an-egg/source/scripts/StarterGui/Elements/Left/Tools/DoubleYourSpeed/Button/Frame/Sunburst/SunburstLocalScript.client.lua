-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local script_Parent = script.Parent;
local u1 = 0;
RunService.RenderStepped:Connect(function(p2) -- Line: 7
    -- upvalues: u1 (ref), script_Parent (copy)
    u1 = u1 + 20 * p2;
    script_Parent.Rotation = u1 % 360;
end);