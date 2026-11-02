-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Utility = require(ReplicatedStorage.Modules.Utility);

return function(p1) -- Line: 5
    -- upvalues: Utility (copy)
    Utility:CreateSound("rbxassetid://83402774833713", 1, 1, p1.HumanoidRootPart, true);
    wait(1);
    Utility:CreateSound("rbxassetid://139804361555491", 1.5, 1, p1.HumanoidRootPart, true);
    Utility:PlayParticles(p1.R);
    wait(0.1);
    Utility:CreateSound("rbxassetid://78951730047565", 0.75, 1, p1.HumanoidRootPart, true);
end;