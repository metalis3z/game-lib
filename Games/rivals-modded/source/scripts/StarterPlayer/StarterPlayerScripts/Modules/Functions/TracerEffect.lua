-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TracerEffect = require(Players.LocalPlayer.PlayerScripts.Modules.TracerEffect);

return function(...) -- Line: 5
    -- upvalues: TracerEffect (copy)
    TracerEffect:Play(...);
end;