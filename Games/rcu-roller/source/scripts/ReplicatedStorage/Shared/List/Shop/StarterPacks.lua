-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:03
-- Luau version 6, Types version 3
-- Time taken: 0.000889 seconds

local Items = require(game:GetService("ReplicatedStorage").Shared.Items)
local Variables = require(game:GetService("ReplicatedStorage").Shared.Variables)
return {
	starterPack = {
		expires = 3600;
		rewards = {Items.pet("Rebirth Dragon"), Items.box("potionsBox")};
	};
	epicPack = {
		expires = 10800;
		rewards = {Items.pet("Fire Dominus"), Items.box("potionsBox"):setAmount(2), Items.box("fruitsBox"):setAmount(2)};
	};
	ultraPack = {
		expires = 21600;
		rewards = {Items.exclusiveEgg(Variables.currentExclusiveEgg.name), Items.box("potionsBox"):setAmount(2), Items.box("fruitsBox"):setAmount(2), Items.auraDice("voidAuraDice")};
	};
	insanePack = {
		expires = 43200;
		rewards = {Items.exclusiveEgg(Variables.currentExclusiveEgg.name), Items.box("fruitsChest"):setAmount(2), Items.box("potionsChest"):setAmount(1), Items.auraDice("royalAuraDice")};
	};
}