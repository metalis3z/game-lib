-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local FestiveLightsCircuit = require(Players.LocalPlayer.PlayerScripts.Modules.FestiveLightsCircuit);
local Fists = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels.Fists);
local u1 = setmetatable({}, Fists);
u1.__index = u1;

function u1.new(...) -- Line: 9
    -- upvalues: Fists (copy), u1 (copy)
    local v2 = Fists.new(...);
    local v3 = setmetatable(v2, u1);
    v3._festive_lights_circuits = {};
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5, p6, p7) -- Line: 23
    -- upvalues: Fists (copy)
    Fists.Update(p4, p5, p6, p7);

    if not p7.IsActive then
        return;
    end;

    for _, v in pairs(p4._festive_lights_circuits) do
        v:Update(p5);
    end;
end;

function u1.Destroy(p8) -- Line: 35
    -- upvalues: Fists (copy)
    for _, v in pairs(p8._festive_lights_circuits) do
        v:Destroy();
    end;

    Fists.Destroy(p8);
end;

function u1._Setup(p9) -- Line: 47
    -- upvalues: FestiveLightsCircuit (copy)
    for i in pairs(p9._arm_submodels) do
        local _festive_lights_circuits = p9._festive_lights_circuits;
        local new = FestiveLightsCircuit.new;
        local Light1 = i:WaitForChild("Light1");
        local Light2 = i:WaitForChild("Light2");
        table.insert(_festive_lights_circuits, new(0.5, Light1, Light2, i:WaitForChild("Light3")));
    end;
end;

function u1._Init(p10) -- Line: 53
    p10:_Setup();
end;

return u1;