-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:37
-- Luau version 6, Types version 3
-- Time taken: 0.000720 seconds

local module = {
	pet = require(script.Pet);
	exclusiveEgg = require(script.ExclusiveEgg);
	potion = require(script.Potion);
	exclusive = require(script.Exclusive);
	box = require(script.Box);
	fruit = require(script.Fruit);
	auraDice = require(script.AuraDice);
	aura = require(script.Aura);
	activeEvent = require(script.ActiveEvent);
	mount = require(script.Mount);
	booth = require(script.Booth);
	mapItem = require(script.MapItem);
	upgrade = require(script.Upgrade);
	gamepass = require(script.Gamepass);
}
local tbl = {}
local Functions_upvr = require(game.ReplicatedStorage.Shared.Functions)
function tbl.__index(arg1, arg2) -- Line 21
	--[[ Upvalues[1]:
		[1]: Functions_upvr (readonly)
	]]
	print(debug.traceback())
	Functions_upvr.print(`Item '{tostring(arg2)}' existerar inte`, warn)
end
setmetatable(module, tbl)
return module