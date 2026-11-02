-- Decompiled with the Synapse X Luau decompiler.

local v1 = require(game.ReplicatedStorage.Modules.EmoteModule);
local l__Emotes__2 = script.Parent.Parent.Game.Emotes;
_G.EmoteFrame = l__Emotes__2;
v1.EmoteGUI = l__Emotes__2;
v1.GenerateEmotes(_G.PlayerData.Emotes.Owned, l__Emotes__2);
v1.SetupPageButtons();

