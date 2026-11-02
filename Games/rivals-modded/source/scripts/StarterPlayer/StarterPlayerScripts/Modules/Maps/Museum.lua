-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ClientMap = require(Players.LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientDuel.ClientMap);
local u1 = { "Museum - Day", "Museum - Dusk", "Museum - Night" };
local u2 = setmetatable({}, ClientMap);
u2.__index = u2;

function u2.new(...) -- Line: 10
    -- upvalues: ClientMap (copy), u2 (copy)
    local v3 = ClientMap.new(...);
    local v4 = setmetatable(v3, u2);
    v4:_Init();

    return v4;
end;

function u2._Init(p5) -- Line: 28
    -- upvalues: u1 (copy)
    p5:SetReplicate("LightingProfileOverride", u1[Random.new(p5._seed):NextInteger(1, #u1)]);
end;

return u2;