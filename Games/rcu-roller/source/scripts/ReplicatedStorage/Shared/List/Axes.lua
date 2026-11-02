-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:26
-- Luau version 6, Types version 3
-- Time taken: 0.001039 seconds

local Items = require(game:GetService("ReplicatedStorage").Shared.Items)
return {
	stoneAxe = {
		required = {Items.mapItem("wood"):setAmount(20), Items.mapItem("cactusWood"):setAmount(3)};
	};
	ironAxe = {
		required = {Items.mapItem("wood"):setAmount(50), Items.mapItem("cactusWood"):setAmount(25)};
	};
	goldenAxe = {
		required = {Items.mapItem("wood"):setAmount(100), Items.mapItem("cactusWood"):setAmount(50), Items.mapItem("nuclearWood"):setAmount(10)};
	};
	diamondAxe = {
		required = {Items.mapItem("wood"):setAmount(250), Items.mapItem("nuclearWood"):setAmount(50), Items.mapItem("underwaterWood"):setAmount(15)};
	};
	emeraldAxe = {
		required = {Items.mapItem("nuclearWood"):setAmount(100), Items.mapItem("underwaterWood"):setAmount(100), Items.mapItem("royalWood"):setAmount(50), Items.mapItem("hackerWood"):setAmount(15)};
	};
	rubyAxe = {
		required = {Items.mapItem("wood"):setAmount(111), Items.mapItem("underwaterWood"):setAmount(111), Items.mapItem("royalWood"):setAmount(111), Items.mapItem("hackerWood"):setAmount(111)};
	};
}