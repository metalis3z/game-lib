-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.PlayFlashSound(p4, p5) -- Line: 22
    -- upvalues: Utility (copy)
    Utility:CreateSound("rbxassetid://14778230670", 1, 1, p5, true, 10);
end;

function u1.PlayRingingSound(p6) -- Line: 26
    -- upvalues: Utility (copy)
    return Utility:CreateSound("rbxassetid://14778230632", 1, 1, script, true, 10);
end;

function u1._Init(p7) -- Line: 34
end;

return u1;