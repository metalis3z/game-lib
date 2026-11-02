-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.HideHookSubModel(p4, p5) -- Line: 20
    p4:HideSubModel("Hook", p5);
end;

function u1.PlayShootSounds(p6) -- Line: 24
    p6:CreateSound("rbxassetid://92178332551602", 1, 0.9 + 0.2 * math.random(), true, 5);
end;

function u1.PlayPullSounds(p7) -- Line: 28
    p7:CreateSound("rbxassetid://105623111691289", 1.25, 0.9 + 0.2 * math.random(), true, 5);
end;

function u1._Init(p8) -- Line: 36
end;

return u1;