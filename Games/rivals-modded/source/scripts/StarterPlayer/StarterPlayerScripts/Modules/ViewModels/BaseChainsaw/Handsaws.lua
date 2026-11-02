-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local BaseChainsaw = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels:WaitForChild("BaseChainsaw"));
local u1 = setmetatable({}, BaseChainsaw);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: BaseChainsaw (copy), u1 (copy)
    local v2 = BaseChainsaw.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._Init(p4) -- Line: 26
    p4:_RegisterBlade(p4.ItemModel:WaitForChild("RightBlade"):WaitForChild("Blade"));
    p4:_RegisterBlade(p4.ItemModel:WaitForChild("LeftBlade"):WaitForChild("Blade"));
    p4:_RegisterSpikesPart(p4.ItemModel:WaitForChild("RightBlade"):WaitForChild("Spikes1"), true);
    p4:_RegisterSpikesPart(p4.ItemModel:WaitForChild("RightBlade"):WaitForChild("Spikes2"), false);
    p4:_RegisterSpikesPart(p4.ItemModel:WaitForChild("LeftBlade"):WaitForChild("Spikes1"), false);
    p4:_RegisterSpikesPart(p4.ItemModel:WaitForChild("LeftBlade"):WaitForChild("Spikes2"), true);
end;

return u1;