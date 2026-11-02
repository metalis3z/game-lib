-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local l_Game_0 = script.Parent.Parent:WaitForChild("Game");
local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
local l_Emotes_0 = l_Game_0:WaitForChild("Emotes");
_G.EmoteFrame = l_Emotes_0;
local v3 = require(game.ReplicatedStorage.Modules.EmoteModule);
v3.EmoteGUI = l_Emotes_0;
v3.GenerateEmotes(l_ProfileData_0.Emotes.Owned, l_Emotes_0);
v3.SetupPageButtons();
_G.UpdateEmotes();