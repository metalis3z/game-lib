-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local PingEffect = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.PingEffect);

return function(...) -- Line: 5
    -- upvalues: PingEffect (copy)
    PingEffect:Play(...);
end;