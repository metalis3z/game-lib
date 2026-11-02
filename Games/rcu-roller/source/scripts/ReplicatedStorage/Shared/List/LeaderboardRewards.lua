-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:24
-- Luau version 6, Types version 3
-- Time taken: 0.002630 seconds

local Items = require(game:GetService("ReplicatedStorage").Shared.Items)
local Variables = require(game:GetService("ReplicatedStorage").Shared.Variables)
return {{
	min = 1;
	max = 1;
	rewards = {Items.pet("Rebirth Trophy"), Items.box("leaderboardsBox"):setAmount(15), Items.exclusiveEgg(Variables.currentExclusiveEgg.name):setAmount(5), Items.exclusive("tradeTokens"):setAmount(1000), Items.upgrade("luckMultiplier"):setAmount(0.35), Items.booth("royalBooth"), Items.mount("royalHoverboard"), Items.exclusive("globalLuck"), Items.exclusive("globalStarEvent"), Items.exclusive("globalLuckyEgg")};
}, {
	min = 2;
	max = 3;
	rewards = {Items.pet("Rebirth Hydra"):setTier(2), Items.box("leaderboardsBox"):setAmount(10), Items.exclusiveEgg(Variables.currentExclusiveEgg.name):setAmount(3), Items.exclusive("tradeTokens"):setAmount(250), Items.upgrade("luckMultiplier"):setAmount(0.25), Items.booth("royalBooth"), Items.mount("royalHoverboard"), Items.box("globalBox"), Items.box("potionsBox"):setAmount(5)};
}, {
	min = 4;
	max = 10;
	rewards = {Items.pet("Rebirth Hydra"), Items.box("leaderboardsBox"):setAmount(5), Items.exclusive("tradeTokens"):setAmount(150), Items.upgrade("luckMultiplier"):setAmount(0.2), Items.booth("royalBooth"), Items.mount("royalHoverboard"), Items.box("potionsBox"):setAmount(3), Items.exclusiveEgg(Variables.currentExclusiveEgg.name):setAmount(1)};
}, {
	min = 11;
	max = 25;
	rewards = {Items.pet("Rebirth Phoenix"), Items.box("leaderboardsBox"):setAmount(3), Items.exclusive("tradeTokens"):setAmount(50), Items.upgrade("luckMultiplier"):setAmount(0.1), Items.auraDice("royalAuraDice"):setAmount(1)};
}, {
	min = 26;
	max = 100;
	rewards = {Items.box("leaderboardsBox"):setAmount(1), Items.potion("hatch"):setAmount(5), Items.potion("megaLuck"):setAmount(5), Items.exclusive("ancientTicket"):setAmount(20)};
}}