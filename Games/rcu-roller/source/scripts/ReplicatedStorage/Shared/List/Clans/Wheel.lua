-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:02
-- Luau version 6, Types version 3
-- Time taken: 0.000662 seconds

local Items = require(game:GetService("ReplicatedStorage").Shared.Items)
return {
	fruitsBox = {
		rotation = 360;
		chance = 45;
		item = Items.box("fruitsBox");
	};
	potionsBox = {
		rotation = 300;
		chance = 35;
		item = Items.box("potionsBox");
	};
	voidAuraDice = {
		rotation = 240;
		chance = 15;
		item = Items.auraDice("voidAuraDice"):setAmount(5);
	};
	royalAuraDice = {
		rotation = 180;
		chance = 4;
		item = Items.auraDice("royalAuraDice");
	};
	epicLuck = {
		rotation = 120;
		chance = 1;
		item = Items.exclusive("epicLuck");
	};
	currentExclusiveEgg = {
		rotation = 60;
		chance = 0.025;
		item = Items.exclusiveEgg(require(game:GetService("ReplicatedStorage").Shared.Variables).currentExclusiveEgg.name);
	};
}