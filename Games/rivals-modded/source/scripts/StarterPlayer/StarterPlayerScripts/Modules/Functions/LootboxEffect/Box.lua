-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Utility = require(ReplicatedStorage.Modules.Utility);

return function(p1) -- Line: 5
    -- upvalues: Utility (copy)
    wait(0.1);
    Utility:CreateSound("rbxassetid://18184413727", 1, 1, p1.HumanoidRootPart, true);
    wait(2.4);
    Utility:CreateSound("rbxassetid://18184413521", 1, 1.75, p1.HumanoidRootPart, true);
    wait(0.4);
    p1.Tape:Destroy();
    wait(0.85);
    Utility:CreateSound("rbxassetid://18184413295", 1.25, 1, p1.HumanoidRootPart, true);
end;