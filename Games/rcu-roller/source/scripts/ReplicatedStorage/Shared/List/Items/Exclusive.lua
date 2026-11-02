-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:42
-- Luau version 6, Types version 3
-- Time taken: 0.001173 seconds

return {
	woodenAxe = {
		name = "Wooden Axe";
		description = "Deals 1 HP damage!";
		icon = "rbxassetid://101733631060665";
		rarity = "Exclusive";
		layoutOrder = 9999;
		multiplier = 1;
		index = 1;
	};
	stoneAxe = {
		name = "Stone Axe";
		description = "Deals 5 HP damage!";
		icon = "rbxassetid://118496482923906";
		rarity = "Exclusive";
		layoutOrder = 9999;
		multiplier = 5;
		index = 2;
	};
	ironAxe = {
		name = "Iron Axe";
		description = "Deals 15 HP damage!";
		icon = "rbxassetid://108746349950852";
		rarity = "Exclusive";
		layoutOrder = 9999;
		multiplier = 15;
		index = 3;
	};
	goldenAxe = {
		name = "Golden Axe";
		description = "Deals 50 HP damage!";
		icon = "rbxassetid://110638164476558";
		rarity = "Exclusive";
		layoutOrder = 9999;
		multiplier = 50;
		index = 4;
	};
	diamondAxe = {
		name = "Diamond Axe";
		description = "Deals 100 HP damage!";
		icon = "rbxassetid://103905108119738";
		rarity = "Exclusive";
		layoutOrder = 9999;
		multiplier = 100;
		index = 5;
	};
	emeraldAxe = {
		name = "Emerald Axe";
		description = "Deals 300 HP damage!";
		icon = "rbxassetid://108487537389862";
		rarity = "Exclusive";
		layoutOrder = 9999;
		multiplier = 300;
		index = 6;
	};
	rubyAxe = {
		name = "Ruby Axe";
		description = "Deals 1,000 HP damage!";
		icon = "rbxassetid://132507644614451";
		rarity = "Exclusive";
		layoutOrder = 9999;
		multiplier = 1000;
		index = 7;
	};
	tradeTokens = {
		name = "Trade Tokens";
		description = "Spend tokens to buy Exclusive Items and Passes in the shop!";
		icon = "rbxassetid://138788240428195";
		rarity = "Exclusive";
		layoutOrder = 100;
		unusable = true;
	};
	ancientTicket = {
		name = "Ancient Ticket";
		description = "Spend tickets in the Ancient Shop or Spin Wheel! (Great for F2P!)";
		icon = "rbxassetid://88413710147336";
		rarity = "Exclusive";
		layoutOrder = 10;
		unusable = true;
	};
	epicLuck = {
		name = "Epic Luck";
		description = "Increase your Luck by 100% for the next 3 hours!";
		icon = "rbxassetid://136386616326984";
		rarity = "Exclusive";
		multiplier = 1;
		seconds = 10800;
		layoutOrder = 99;
		confirm = true;
	};
	globalLuck = {
		name = "Global Luck";
		description = "Add +25% extra Luck on all active servers for 30 minutes!";
		icon = "rbxassetid://134765457255395";
		rarity = "Global";
		layoutOrder = 997;
		confirm = true;
	};
	globalLuckyEgg = {
		name = "Global Lucky Egg";
		description = "Spawn your best egg with +250% luck on all active servers!";
		icon = "rbxassetid://138058441282308";
		rarity = "Global";
		layoutOrder = 998;
		confirm = true;
	};
	globalStarEvent = {
		name = "Global Star Event";
		description = "Spawn a Falling Star Event on all active servers!";
		icon = "rbxassetid://119264527490946";
		rarity = "Global";
		layoutOrder = 999;
		confirm = true;
	};
}