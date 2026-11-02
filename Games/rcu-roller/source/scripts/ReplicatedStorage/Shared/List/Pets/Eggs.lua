-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:33
-- Luau version 6, Types version 3
-- Time taken: 0.001410 seconds

return {
	Basic = {
		cost = 250;
		pets = {
			Dog = 50;
			Cat = 35;
			Bunny = 15;
		};
	};
	Forest = {
		cost = 5000;
		pets = {
			Bear = 50;
			Wolf = 30;
			Fox = 17;
			["Forest Dragon"] = 3;
		};
	};
	Farm = {
		cost = 250000;
		pets = {
			Pig = 50;
			Duck = 30;
			Cow = 16;
			Goat = 4.75;
			["Apple Dragon"] = 0.25;
		};
		requiredMap = 2;
	};
	Desert = {
		cost = 30000000;
		pets = {
			Lion = 45;
			["Desert Fox"] = 38;
			Elephant = 15;
			Eagle = 2;
			["Sand Of Time"] = 0.25;
			["Desert Prophecy"] = 0.01;
		};
		requiredMap = 3;
	};
	Nuclear = {
		cost = 3000000000;
		pets = {
			["Nuclear Golem"] = 45;
			["Nuclear Cow"] = 37;
			["Nuclear Hydra"] = 15;
			["Hazmat Demon"] = 3;
			Abomination = 0.25;
			["Nuclear Beast"] = 0.01;
		};
		requiredMap = 4;
	};
	Atlantis = {
		cost = 80000000000;
		pets = {
			Fish = 55;
			Crab = 37;
			Octopus = 8;
			["Atlantean Guardian"] = 0.25;
			["Pearl Maiden"] = 0.01;
			Cthulhu = 0.0005;
		};
		requiredMap = 5;
	};
	Kingdom = {
		cost = 1000000000000;
		pets = {
			["Royal Panda"] = 55;
			["Royal Dog"] = 37;
			["Royal Cat"] = 8;
			["The Fool"] = 0.2;
			["Dragon Queen"] = 0.01;
			["Dragon King"] = 0.0005;
			["The Admin"] = 0.000001;
		};
		requiredMap = 6;
	};
	City = {
		cost = 50000000000000;
		pets = {
			["Skate Cat"] = 55;
			["Police Wolf"] = 37;
			Hacker = 8;
			["Skyscraper Stack"] = 0.1;
			["Ox of Justice"] = 0.01;
			["The Broadcasting"] = 0.0005;
			["The Admin"] = 0.000005;
		};
		requiredMap = 7;
	};
	Hacker = {
		cost = 75000000000000;
		pets = {
			["Police Wolf"] = 75;
			Hacker = 25;
			["Skyscraper Stack"] = 0.25;
			["Ox of Justice"] = 0.015;
			["The Broadcasting"] = 0.00075;
			["The Admin"] = 0.00001;
		};
		requiredMap = 7;
		canHatch = function(arg1) -- Line 116, Named "canHatch"
			local var20
			if #arg1.lightSwitches ~= 6 then
				var20 = false
			else
				var20 = true
			end
			return var20
		end;
	};
}