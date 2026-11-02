-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:06
-- Luau version 6, Types version 3
-- Time taken: 0.005119 seconds

local Items = require(game:GetService("ReplicatedStorage").Shared.Items)
local Variables = require(game:GetService("ReplicatedStorage").Shared.Variables)
return {
	spawn = {
		cooldown = 21600;
		group = true;
		rewardAmount = 3;
		rewards = {{
			item = Items.potion("clicks"):setAmount(1);
			chance = 20;
		}, {
			item = Items.potion("gems"):setAmount(1);
			chance = 20;
		}, {
			item = Items.potion("luck"):setAmount(1);
			chance = 20;
		}, {
			item = Items.potion("hatch"):setAmount(1);
			chance = 10;
		}, {
			item = Items.potion("golden"):setAmount(1);
			chance = 1;
		}, {
			item = Items.potion("shiny"):setAmount(1);
			chance = 1;
		}, {
			item = Items.potion("toxic"):setAmount(1);
			chance = 1;
		}, {
			item = Items.box("potionsBox"):setAmount(1);
			chance = 2;
		}, {
			item = Items.exclusive("ancientTicket"):setAmount(3);
			chance = 3;
		}, {
			item = Items.box("fruitsBox"):setAmount(1);
			chance = 2;
		}, {
			item = Items.fruit("apple"):setAmount(1);
			chance = 5;
		}, {
			item = Items.fruit("carrot"):setAmount(1);
			chance = 5;
		}, {
			item = Items.fruit("grape"):setAmount(1);
			chance = 5;
		}, {
			item = Items.fruit("strawberry"):setAmount(1);
			chance = 5;
		}, {
			item = Items.mount("magicHoverboard");
			chance = 0.001;
		}, {
			item = Items.box("globalBox");
			chance = 0.0004;
		}, {
			item = Items.exclusiveEgg(Variables.currentExclusiveEgg.name);
			chance = 0.0002;
		}, {
			item = Items.mount("ufoMount");
			chance = 0.0001;
		}};
	};
	nuclear = {
		cooldown = 21600;
		rewardAmount = 3;
		rewards = {{
			item = Items.potion("clicks"):setAmount(1);
			chance = 15;
		}, {
			item = Items.potion("gems"):setAmount(1);
			chance = 15;
		}, {
			item = Items.potion("luck"):setAmount(1);
			chance = 20;
		}, {
			item = Items.potion("hatch"):setAmount(1);
			chance = 15;
		}, {
			item = Items.potion("golden"):setAmount(1);
			chance = 1;
		}, {
			item = Items.potion("shiny"):setAmount(1);
			chance = 1;
		}, {
			item = Items.potion("toxic"):setAmount(1);
			chance = 1;
		}, {
			item = Items.box("potionsBox"):setAmount(1);
			chance = 3;
		}, {
			item = Items.exclusive("ancientTicket"):setAmount(5);
			chance = 5;
		}, {
			item = Items.box("fruitsBox"):setAmount(1);
			chance = 3;
		}, {
			item = Items.fruit("apple"):setAmount(1);
			chance = 5;
		}, {
			item = Items.fruit("carrot"):setAmount(1);
			chance = 5;
		}, {
			item = Items.fruit("grape"):setAmount(1);
			chance = 5;
		}, {
			item = Items.fruit("strawberry"):setAmount(1);
			chance = 5;
		}, {
			item = Items.potion("megaClicks"):setAmount(1);
			chance = 0.3;
		}, {
			item = Items.potion("megaGems"):setAmount(1);
			chance = 0.3;
		}, {
			item = Items.potion("megaLuck"):setAmount(1);
			chance = 0.3;
		}, {
			item = Items.mount("magicHoverboard");
			chance = 0.001;
		}, {
			item = Items.box("globalBox");
			chance = 0.0004;
		}, {
			item = Items.exclusiveEgg(Variables.currentExclusiveEgg.name);
			chance = 0.0002;
		}, {
			item = Items.mount("ufoMount");
			chance = 0.0001;
		}};
	};
	kingdom = {
		cooldown = 21600;
		buildingId = "kingdomChest";
		rewardAmount = 3;
		rewards = {{
			item = Items.potion("clicks"):setAmount(1);
			chance = 12;
		}, {
			item = Items.potion("gems"):setAmount(1);
			chance = 12;
		}, {
			item = Items.potion("luck"):setAmount(1);
			chance = 20;
		}, {
			item = Items.potion("hatch"):setAmount(1);
			chance = 15;
		}, {
			item = Items.potion("golden"):setAmount(1);
			chance = 1;
		}, {
			item = Items.potion("shiny"):setAmount(1);
			chance = 1;
		}, {
			item = Items.potion("toxic"):setAmount(1);
			chance = 1;
		}, {
			item = Items.box("potionsBox"):setAmount(1);
			chance = 5;
		}, {
			item = Items.exclusive("ancientTicket"):setAmount(5);
			chance = 5;
		}, {
			item = Items.box("fruitsBox"):setAmount(1);
			chance = 4;
		}, {
			item = Items.fruit("apple"):setAmount(1);
			chance = 5;
		}, {
			item = Items.fruit("carrot"):setAmount(1);
			chance = 5;
		}, {
			item = Items.fruit("grape"):setAmount(1);
			chance = 5;
		}, {
			item = Items.fruit("strawberry"):setAmount(1);
			chance = 5;
		}, {
			item = Items.potion("megaClicks"):setAmount(1);
			chance = 1.3;
		}, {
			item = Items.potion("megaGems"):setAmount(1);
			chance = 1.3;
		}, {
			item = Items.potion("megaLuck"):setAmount(1);
			chance = 1.3;
		}, {
			item = Items.mount("magicHoverboard");
			chance = 0.001;
		}, {
			item = Items.box("globalBox");
			chance = 0.0004;
		}, {
			item = Items.exclusiveEgg(Variables.currentExclusiveEgg.name);
			chance = 0.0002;
		}, {
			item = Items.mount("ufoMount");
			chance = 0.0001;
		}};
	};
	clan = {
		cooldown = 21600;
		clan = true;
		buildingId = "clanChest";
		rewardAmount = 3;
		rewards = {{
			item = Items.potion("clicks"):setAmount(2);
			chance = 12;
		}, {
			item = Items.potion("gems"):setAmount(2);
			chance = 12;
		}, {
			item = Items.potion("luck"):setAmount(2);
			chance = 20;
		}, {
			item = Items.potion("hatch"):setAmount(2);
			chance = 15;
		}, {
			item = Items.potion("golden"):setAmount(1);
			chance = 1;
		}, {
			item = Items.potion("shiny"):setAmount(1);
			chance = 1;
		}, {
			item = Items.potion("toxic"):setAmount(1);
			chance = 1;
		}, {
			item = Items.box("potionsBox"):setAmount(1);
			chance = 5;
		}, {
			item = Items.exclusive("ancientTicket"):setAmount(5);
			chance = 5;
		}, {
			item = Items.box("fruitsBox"):setAmount(1);
			chance = 4;
		}, {
			item = Items.fruit("apple"):setAmount(10);
			chance = 5;
		}, {
			item = Items.fruit("carrot"):setAmount(10);
			chance = 5;
		}, {
			item = Items.fruit("grape"):setAmount(10);
			chance = 5;
		}, {
			item = Items.fruit("strawberry"):setAmount(10);
			chance = 5;
		}, {
			item = Items.potion("megaClicks"):setAmount(2);
			chance = 1.3;
		}, {
			item = Items.potion("megaGems"):setAmount(2);
			chance = 1.3;
		}, {
			item = Items.potion("megaLuck"):setAmount(2);
			chance = 1.3;
		}, {
			item = Items.exclusive("epicLuck");
			chance = 0.1;
		}, {
			item = Items.mount("magicHoverboard");
			chance = 0.001;
		}, {
			item = Items.box("globalBox");
			chance = 0.0004;
		}, {
			item = Items.exclusiveEgg(Variables.currentExclusiveEgg.name);
			chance = 0.0002;
		}, {
			item = Items.mount("ufoMount");
			chance = 0.0001;
		}};
	};
}