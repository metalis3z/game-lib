-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:07
-- Luau version 6, Types version 3
-- Time taken: 0.003349 seconds

local Items = require(game:GetService("ReplicatedStorage").Shared.Items)
return {{
	names = {"spawnLuck", "spawnLuck2", "spawnLuck3"};
	rewards = {Items.potion("luck"):setAmount(1)};
}, {
	names = {"spawnClicks", "spawnClicks2", "spawnClicks3"};
	rewards = {Items.potion("clicks"):setAmount(1)};
}, {
	names = {"spawnGems", "spawnGems2", "spawnGems3"};
	rewards = {Items.potion("gems"):setAmount(1)};
}, {
	names = {"spawnMega"};
	rewards = {Items.potion("gems"):setAmount(1), Items.potion("luck"):setAmount(1), Items.potion("hatch"):setAmount(1), Items.potion("clicks"):setAmount(1)};
}, {
	names = {"farm1a", "farm2a"};
	rewards = {Items.fruit("apple"):setAmount(1)};
	requiredMap = 2;
}, {
	names = {"farm1c", "farm2c"};
	rewards = {Items.fruit("carrot"):setAmount(1)};
	requiredMap = 2;
}, {
	names = {"farm1g", "farm2g"};
	rewards = {Items.fruit("grape"):setAmount(1)};
	requiredMap = 2;
}, {
	names = {"farm1s", "farm2s"};
	rewards = {Items.fruit("strawberry"):setAmount(1)};
	requiredMap = 2;
}, {
	names = {"farmMega"};
	rewards = {Items.fruit("strawberry"):setAmount(1), Items.fruit("grape"):setAmount(1), Items.fruit("carrot"):setAmount(1), Items.fruit("apple"):setAmount(1)};
	requiredMap = 2;
}, {
	names = {"desert1", "desert2", "desert3", "desert4", "desert5", "desert6", "desert7"};
	rewards = {Items.exclusive("ancientTicket"):setAmount(1)};
	requiredMap = 3;
}, {
	names = {"desertMega"};
	rewards = {Items.potion("gems"):setAmount(1), Items.potion("luck"):setAmount(1), Items.potion("hatch"):setAmount(1), Items.potion("clicks"):setAmount(1)};
	requiredMap = 3;
}, {
	names = {"nuclear1", "nuclear2"};
	rewards = {Items.potion("luck"):setAmount(1)};
	requiredMap = 4;
}, {
	names = {"nuclear3", "nuclear4"};
	rewards = {Items.potion("clicks"):setAmount(1)};
	requiredMap = 4;
}, {
	names = {"nuclear5", "nuclear6"};
	rewards = {Items.potion("gems"):setAmount(1)};
	requiredMap = 4;
}, {
	names = {"nuclear7"};
	rewards = {Items.potion("hatch"):setAmount(1)};
	requiredMap = 4;
}, {
	names = {"nuclear8"};
	rewards = {Items.exclusive("ancientTicket"):setAmount(3)};
	requiredMap = 4;
}, {
	names = {"atlantis1", "atlantis2", "atlantis3"};
	rewards = {Items.auraDice("fireAuraDice"):setAmount(2)};
	requiredMap = 5;
}, {
	names = {"atlantis4", "atlantis5", "atlantis6"};
	rewards = {Items.auraDice("magicAuraDice"):setAmount(1)};
	requiredMap = 5;
}, {
	names = {"atlantis7"};
	rewards = {Items.auraDice("auraDice"):setAmount(15)};
	requiredMap = 5;
}, {
	names = {"kingdom1"};
	rewards = {Items.exclusive("ancientTicket"):setAmount(3)};
	requiredMap = 6;
}, {
	names = {"kingdom2", "kingdom3", "kingdom4"};
	rewards = {Items.auraDice("magicAuraDice"):setAmount(1)};
	requiredMap = 6;
}, {
	names = {"kingdom5"};
	rewards = {Items.auraDice("voidAuraDice"):setAmount(1)};
	requiredMap = 6;
}, {
	names = {"kingdom6", "kingdom7", "kingdom8"};
	rewards = {Items.potion("rngLuck"):setAmount(1)};
	requiredMap = 6;
}, {
	names = {"clan1"};
	rewards = {Items.potion("gems"):setAmount(1), Items.potion("luck"):setAmount(1), Items.potion("hatch"):setAmount(1), Items.potion("clicks"):setAmount(1)};
	requiredMap = 6;
}, {
	names = {"city1"};
	rewards = {Items.auraDice("voidAuraDice"):setAmount(1)};
	requiredMap = 7;
}, {
	names = {"hacker1", "hacker2"};
	rewards = {Items.potion("gems"):setAmount(1), Items.potion("luck"):setAmount(1), Items.potion("hatch"):setAmount(1), Items.potion("clicks"):setAmount(1)};
	requiredMap = 7;
}, {
	names = {"city3"};
	rewards = {Items.potion("luck"):setAmount(1)};
	requiredMap = 7;
}, {
	names = {"city4", "city5"};
	rewards = {Items.potion("clicks"):setAmount(1)};
	requiredMap = 7;
}, {
	names = {"city6", "city7"};
	rewards = {Items.potion("gems"):setAmount(1)};
	requiredMap = 7;
}, {
	names = {"city8"};
	rewards = {Items.potion("hatch"):setAmount(1)};
	requiredMap = 7;
}}