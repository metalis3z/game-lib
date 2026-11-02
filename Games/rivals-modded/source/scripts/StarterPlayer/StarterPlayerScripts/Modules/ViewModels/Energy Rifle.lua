-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ClientViewModel = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ClientViewModel"));
local EnergyBeamTracerEffect = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("EnergyBeamTracerEffect");
local u1 = setmetatable({}, ClientViewModel);
u1.__index = u1;

function u1.new(...) -- Line: 10
    -- upvalues: ClientViewModel (copy), u1 (copy)
    local v2 = ClientViewModel.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1.GetTracerTemplate(p4) -- Line: 22
    -- upvalues: EnergyBeamTracerEffect (copy)
    return EnergyBeamTracerEffect;
end;

function u1._Init(p5) -- Line: 30
end;

return u1;