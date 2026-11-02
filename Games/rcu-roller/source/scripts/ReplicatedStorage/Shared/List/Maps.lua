-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:04
-- Luau version 6, Types version 3
-- Time taken: 0.002768 seconds

local module = {}
local tbl_2 = {
	name = "Spawn";
	icon = "rbxassetid://79110604347671";
	background = "rbxassetid://108379018063166";
	color = Color3.fromRGB(255, 255, 255);
	ambience = "Birds Chirping";
	machines = {{
		name = "Index";
		icon = "rbxassetid://90688825735302";
	}, {
		name = "Leaderboards";
		icon = "rbxassetid://94756955284497";
	}, {
		name = "Upgrades";
		icon = "rbxassetid://112415555217981";
	}, {
		name = "Chest";
		icon = "rbxassetid://107371842783453";
	}};
	cframe = CFrame.new(-276, 5, -13, 0, 0, -1, 0, 1, 0, 1, 0, 0);
}
local function getBestEgg(arg1) -- Line 18
	return "Forest"
end
tbl_2.getBestEgg = getBestEgg
module[1] = tbl_2
module[2] = {
	name = "Farm";
	icon = "rbxassetid://76706675308921";
	background = "rbxassetid://123687139086197";
	color = Color3.fromRGB(255, 191, 0);
	ambience = "Birds Chirping";
	quests = {{
		quest = "rebirths";
		amount = 300;
	}, {
		quest = "openEgg";
		name = "Forest";
		amount = 25;
	}};
	machines = {{
		name = "Golden Machine";
		icon = "rbxassetid://81141484395888";
	}, {
		name = "Farming Machine";
		icon = "rbxassetid://91879320298032";
	}};
	cframe = CFrame.new(-79, 5, -9, 0, 0, -1, 0, 1, 0, 1, 0, 0);
}
module[3] = {
	name = "Desert";
	icon = "rbxassetid://99455032930482";
	background = "rbxassetid://101506796868862";
	color = Color3.fromRGB(157, 255, 0);
	quests = {{
		quest = "rebirths";
		amount = 5000;
	}, {
		quest = "openEgg";
		name = "Farm";
		amount = 100;
	}, {
		quest = "usePotions";
		amount = 3;
	}};
	machines = {};
	cframe = CFrame.new(193.127, 6, -7.1, 0, 0, -1, 0, 1, 0, 1, 0, 0);
}
module[4] = {
	name = "Nuclear";
	icon = "rbxassetid://112855606566563";
	background = "rbxassetid://125532373262565";
	color = Color3.fromRGB(255, 217, 0);
	night = true;
	quests = {{
		quest = "rebirths";
		amount = 50000;
	}, {
		quest = "collectFruits";
		amount = 3;
	}, {
		quest = "openEgg";
		name = "Desert";
		amount = 250;
	}, {
		quest = "hatchPet";
		name = "Sand Of Time";
		amount = 1;
	}};
	machines = {{
		name = "Toxic Machine";
		icon = "rbxassetid://122335164328718";
	}, {
		name = "Nuclear Chest";
		icon = "rbxassetid://107371842783453";
	}};
	cframe = CFrame.new(569, 5, 12, 0, 0, -1, 0, 1, 0, 1, 0, 0);
}
module[5] = {
	name = "Atlantis";
	icon = "rbxassetid://80076580835732";
	background = "rbxassetid://132540763339482";
	color = Color3.fromRGB(0, 195, 255);
	quests = {{
		quest = "rebirths";
		amount = 750000;
	}, {
		quest = "openEgg";
		name = "Nuclear";
		amount = 500;
	}, {
		quest = "hatchPet";
		name = "Abomination";
		amount = 3;
	}, {
		quest = "usePotions";
		amount = 10;
	}};
	machines = {{
		name = "Auras Machine";
		icon = "rbxassetid://135257818488139";
	}};
	cframe = CFrame.new(703.9, 5, -204, 70, 0, -1, 0, 1, 0, 1, 0, 0);
}
module[6] = {
	name = "Kingdom";
	icon = "rbxassetid://110563988510849";
	background = "rbxassetid://133066972443442";
	color = Color3.fromRGB(170, 170, 170);
	ambience = "Birds Chirping";
	unlocksAt = 1742666400;
	quests = {{
		quest = "rebirths";
		amount = 5000000;
	}, {
		quest = "hatchPet";
		name = "Atlantean Guardian";
		amount = 1;
	}, {
		quest = "collectFruits";
		amount = 5;
	}, {
		quest = "useAuraDice";
		amount = 30;
	}};
	machines = {{
		name = "Clan Castle";
		icon = "rbxassetid://116664706344052";
	}, {
		name = "Axe Machine";
		icon = "rbxassetid://116992575426878";
	}, {
		name = "Kingdom Chest";
		icon = "rbxassetid://107371842783453";
	}};
	cframe = CFrame.new(810, 5, -438, 70, 0, -1, 0, 1, 0, 1, 0, 0);
}
local tbl = {
	name = "City";
	icon = "rbxassetid://70816314078042";
	background = "rbxassetid://130035185548841";
	color = Color3.fromRGB(47, 172, 255);
	ambience = "Birds Chirping";
	night = true;
	unlocksAt = 1742745600;
	quests = {{
		quest = "rebirths";
		amount = 50000000;
	}, {
		quest = "openEgg";
		name = "Kingdom";
		amount = 300;
	}, {
		quest = "destroyTree";
		name = "kingdom";
		amount = 3;
	}, {
		quest = "building";
		name = "Wooden Bridge";
		amount = 1;
	}};
	machines = {};
	cframe = CFrame.new(1087, 5, -444, 0, 0, -1, 0, 1, 0, 1, 0, 0);
}
function tbl.getBestEgg(arg1) -- Line 223
	if #arg1.lightSwitches == 6 then
		return "Hacker"
	end
	return "City"
end
module[7] = tbl
return module