-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Utility = require(ReplicatedStorage.Modules.Utility);

return function(p1) -- Line: 5
    -- upvalues: Utility (copy)
    wait(0.4);
    Utility:CreateSound("rbxassetid://18184509157", 6, 1, p1.HumanoidRootPart, true);
    wait(0.25);
    Utility:CreateSound("rbxassetid://18184509157", 6, 1.25, p1.HumanoidRootPart, true);
    wait(0.25);
    Utility:CreateSound("rbxassetid://18184509157", 6, 1.125, p1.HumanoidRootPart, true);
    wait(0.25);
    Utility:CreateSound("rbxassetid://18184509157", 6, 1.375, p1.HumanoidRootPart, true);
    wait(1);
    Utility:CreateSound("rbxassetid://18184414067", 0.625, 1, p1.HumanoidRootPart, true);
end;