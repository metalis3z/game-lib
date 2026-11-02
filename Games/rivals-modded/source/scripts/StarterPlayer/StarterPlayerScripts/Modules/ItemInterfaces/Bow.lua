-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ItemInterface = require(Players.LocalPlayer.PlayerScripts.Modules:WaitForChild("ClientReplicatedClasses"):WaitForChild("ClientFighter"):WaitForChild("ClientItem"):WaitForChild("ItemInterface"));
local Charge = require(script:WaitForChild("Charge"));
local u1 = setmetatable({}, ItemInterface);
u1.__index = u1;

function u1.new(...) -- Line: 9
    -- upvalues: ItemInterface (copy), u1 (copy), Charge (copy)
    local v2 = ItemInterface.new(...);
    local v3 = setmetatable(v2, u1);
    v3.Charge = Charge.new(v3);
    v3:_Init();

    return v3;
end;

function u1.Destroy(p4) -- Line: 23
    -- upvalues: ItemInterface (copy)
    p4.Charge:Destroy();
    ItemInterface.Destroy(p4);
end;

function u1._Init(p5) -- Line: 32
end;

return u1;