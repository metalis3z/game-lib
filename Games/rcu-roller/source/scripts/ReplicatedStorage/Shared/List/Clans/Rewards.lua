-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:01
-- Luau version 6, Types version 3
-- Time taken: 0.001922 seconds

local Items = require(game:GetService("ReplicatedStorage").Shared.Items)
return {{
	min = 1;
	max = 1;
	players = {{
		min = 1;
		max = 1;
		rewards = {Items.potion("clicks"):setAmount(10)};
	}, {
		min = 2;
		max = 5;
		rewards = {Items.potion("clicks"):setAmount(8)};
	}, {
		min = 6;
		max = 10;
		rewards = {Items.potion("clicks"):setAmount(6)};
	}, {
		min = 11;
		max = math.huge;
		rewards = {Items.potion("clicks"):setAmount(4)};
	}};
}, {
	min = 2;
	max = 3;
	players = {{
		min = 1;
		max = 1;
		rewards = {Items.potion("megaClicks"):setAmount(10)};
	}, {
		min = 2;
		max = 5;
		rewards = {Items.potion("megaClicks"):setAmount(8)};
	}, {
		min = 6;
		max = 10;
		rewards = {Items.potion("megaClicks"):setAmount(6)};
	}, {
		min = 11;
		max = math.huge;
		rewards = {Items.potion("megaClicks"):setAmount(4)};
	}};
}, {
	min = 4;
	max = 10;
	players = {{
		min = 1;
		max = 1;
		rewards = {Items.potion("gems"):setAmount(10)};
	}, {
		min = 2;
		max = 5;
		rewards = {Items.potion("gems"):setAmount(8)};
	}, {
		min = 6;
		max = 10;
		rewards = {Items.potion("gems"):setAmount(6)};
	}, {
		min = 11;
		max = 25;
		rewards = {Items.potion("gems"):setAmount(4)};
	}};
}, {
	min = 11;
	max = 25;
	players = {{
		min = 1;
		max = 1;
		rewards = {Items.potion("megaGems"):setAmount(10)};
	}, {
		min = 2;
		max = 5;
		rewards = {Items.potion("megaGems"):setAmount(8)};
	}, {
		min = 6;
		max = 10;
		rewards = {Items.potion("megaGems"):setAmount(6)};
	}, {
		min = 11;
		max = 25;
		rewards = {Items.potion("megaGems"):setAmount(4)};
	}};
}}