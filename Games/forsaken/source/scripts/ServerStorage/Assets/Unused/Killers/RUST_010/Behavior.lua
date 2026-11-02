-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled by Krnl

local Behavior = {}
local SoundsModule = require(game.ReplicatedStorage.Modules.Sounds)
local UtilModule = require(game.ReplicatedStorage.Modules.Util)
local HitboxModule = require(game.ReplicatedStorage.Modules.Hitboxes)
local StatusModule = require(game.ReplicatedStorage.Modules.Statuses)
local Moveset
if game["Run Service"]:IsServer() then
	Moveset = require(game.ServerScriptService.Server.Modules.Movesets.RUST_010)
end
local Abilities = {
	["Slash"] = {
		["LayoutOrder"] = 1,
		["Icon"] = "rbxassetid://93874368032471",
		["KeybindType"] = "MainAbility",
		["Cooldown"] = 2,
		["Callback"] = function(Actor)
			if game["Run Service"]:IsServer() then
				Moveset:Slash(Actor)
			elseif game["Run Service"]:IsClient() then
				Actor.Animations.Slash:Play(0.025)
			end
		end
	}
}
Behavior.Abilities = Abilities
return Behavior
