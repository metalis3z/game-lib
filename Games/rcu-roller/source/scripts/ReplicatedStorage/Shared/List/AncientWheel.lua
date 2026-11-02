-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:13
-- Luau version 6, Types version 3
-- Time taken: 0.000646 seconds

local Items = require(game:GetService("ReplicatedStorage").Shared.Items)
return {
	magicAuraDice = {
		rotation = 360;
		chance = 50;
		item = Items.auraDice("magicAuraDice");
	};
	carrot = {
		rotation = 300;
		chance = 30;
		item = Items.fruit("carrot");
	};
	potionsBox = {
		rotation = 240;
		chance = 10;
		item = Items.box("potionsBox");
	};
	epicLuck = {
		rotation = 180;
		chance = 1;
		item = Items.exclusive("epicLuck");
	};
	voidAuraDice = {
		rotation = 120;
		chance = 9;
		item = Items.auraDice("voidAuraDice");
	};
	currentExclusiveEgg = {
		rotation = 60;
		chance = 0.01;
		item = Items.exclusiveEgg(require(game:GetService("ReplicatedStorage").Shared.Variables).currentExclusiveEgg.name);
	};
}