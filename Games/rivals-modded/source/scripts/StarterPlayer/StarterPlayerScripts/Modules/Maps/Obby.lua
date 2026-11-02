-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ClientMap = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientDuel.ClientMap);
local u1 = setmetatable({}, ClientMap);
u1.__index = u1;

function u1.new(...) -- Line: 8
    -- upvalues: ClientMap (copy), u1 (copy)
    local v2 = ClientMap.new(...);
    local v3 = setmetatable(v2, u1);
    v3:_Init();

    return v3;
end;

function u1._Init(p4) -- Line: 26
    p4.ClientDuel:SetReplicate("DuelMusic", "Obby");
end;

return u1;