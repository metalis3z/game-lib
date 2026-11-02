-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local FestiveLightsCircuit = require(Players.LocalPlayer.PlayerScripts.Modules.FestiveLightsCircuit);
local BaseChainsaw = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ViewModels"):WaitForChild("BaseChainsaw"));
local u1 = setmetatable({}, BaseChainsaw);
u1.__index = u1;

function u1.new(...) -- Line: 9
    -- upvalues: BaseChainsaw (copy), u1 (copy), FestiveLightsCircuit (copy)
    local v2 = BaseChainsaw.new(...);
    local v3 = setmetatable(v2, u1);
    v3._festive_lights_circuit_body = FestiveLightsCircuit.new(0.5, v3.ItemModel:WaitForChild("Body"):WaitForChild("Light1"), v3.ItemModel:WaitForChild("Body"):WaitForChild("Light2"), v3.ItemModel:WaitForChild("Body"):WaitForChild("Light3"));
    v3._festive_lights_circuit_spin = FestiveLightsCircuit.new(0.1, v3.ItemModel:WaitForChild("Spin"):WaitForChild("Light1"), v3.ItemModel:WaitForChild("Spin"):WaitForChild("Light2"), v3.ItemModel:WaitForChild("Spin"):WaitForChild("Light3"));
    v3:_Init();

    return v3;
end;

function u1.Update(p4, p5, p6, p7) -- Line: 24
    -- upvalues: BaseChainsaw (copy)
    BaseChainsaw.Update(p4, p5, p6, p7);

    if not p7.IsActive then
        return;
    end;

    p4._festive_lights_circuit_body:Update(p5);
    p4._festive_lights_circuit_spin:Update(p5);
end;

function u1.Destroy(p8) -- Line: 35
    -- upvalues: BaseChainsaw (copy)
    p8._festive_lights_circuit_body:Destroy();
    p8._festive_lights_circuit_spin:Destroy();
    BaseChainsaw.Destroy(p8);
end;

function u1._Init(p9) -- Line: 45
end;

return u1;