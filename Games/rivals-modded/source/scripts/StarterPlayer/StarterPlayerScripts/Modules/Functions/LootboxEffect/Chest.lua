-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Utility = require(ReplicatedStorage.Modules.Utility);

return function(p1) -- Line: 5
    -- upvalues: Utility (copy)
    Utility:CreateSound("rbxassetid://7384906695", 0.8, 1, p1.HumanoidRootPart, true);
    wait(2.75);
    Utility:CreateSound("rbxassetid://7384913560", 0.6, 1, p1.HumanoidRootPart, true);
    wait(0.5);
    Utility:CreateSound("rbxassetid://7384913560", 0.8, 1.5, p1.HumanoidRootPart, true);
end;