-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Requests = require(Players.LocalPlayer.PlayerScripts.Modules.UserInterface.Lobby.Requests);

return function(...) -- Line: 5
    -- upvalues: Requests (copy)
    Requests:ChallengeRequest(...);
end;