-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local EliminatedEffect = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.EliminatedEffect);

return function(...) -- Line: 5
    -- upvalues: EliminatedEffect (copy)
    EliminatedEffect:Play(...);
end;