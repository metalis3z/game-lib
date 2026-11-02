-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local u1 = require(Players.LocalPlayer.PlayerScripts.Modules.ViewModels["Energy Rifle"]);
local u2 = Players.LocalPlayer.PlayerScripts.Assets.Misc:WaitForChild("2025BeamTracerEffect");
local u3 = setmetatable({}, u1);
u3.__index = u3;

function u3.new(...) -- Line: 10
    -- upvalues: u1 (copy), u3 (copy)
    local v4 = u1.new(...);
    local v5 = setmetatable(v4, u3);
    v5:_Init();

    return v5;
end;

function u3.GetTracerTemplate(p6) -- Line: 22
    -- upvalues: u2 (copy)
    return u2;
end;

function u3._Init(p7) -- Line: 30
end;

return u3;