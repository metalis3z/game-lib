-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local PreloadController = require(Players.LocalPlayer.PlayerScripts.Controllers.PreloadController);

return function(p1, p2) -- Line: 5
    -- upvalues: PreloadController (copy)
    p1:LoadAnimation(PreloadController:GetPreloadedAnimation(p2)):Play();
end;