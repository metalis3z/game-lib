local Perk = script.Parent
local Character = Perk.Parent
local Player = game.Players:GetPlayerFromCharacter(Character)
local GiveWeapon = require(game.ServerScriptService.GameScript.GameFunctions.GiveWeapon)
GiveWeapon.Gun(Player, "Fake")