-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:21
-- Luau version 6, Types version 3
-- Time taken: 0.010954 seconds

local Items = require(game:GetService("ReplicatedStorage").Shared.Items)
local Variables = require(game:GetService("ReplicatedStorage").Shared.Variables)
return {{
	required = 60;
	rewardAmount = 1;
	rewards = {{
		item = Items.fruit("apple"):setAmount(1);
		chance = 25;
	}, {
		item = Items.fruit("carrot"):setAmount(1);
		chance = 25;
	}, {
		item = Items.fruit("grape"):setAmount(1);
		chance = 25;
	}, {
		item = Items.fruit("strawberry"):setAmount(1);
		chance = 25;
	}};
}, {
	required = 120;
	rewardAmount = 1;
	rewards = {{
		item = Items.fruit("apple"):setAmount(1);
		chance = 25;
	}, {
		item = Items.fruit("carrot"):setAmount(1);
		chance = 25;
	}, {
		item = Items.fruit("grape"):setAmount(1);
		chance = 25;
	}, {
		item = Items.fruit("strawberry"):setAmount(1);
		chance = 25;
	}};
}, {
	required = 300;
	rewardAmount = 1;
	rewards = {{
		item = Items.fruit("apple"):setAmount(1);
		chance = 15;
	}, {
		item = Items.fruit("carrot"):setAmount(1);
		chance = 15;
	}, {
		item = Items.fruit("grape"):setAmount(1);
		chance = 15;
	}, {
		item = Items.fruit("strawberry"):setAmount(1);
		chance = 15;
	}, {
		item = Items.potion("clicks"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("luck"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("hatch"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("gems"):setAmount(1);
		chance = 10;
	}};
}, {
	required = 600;
	rewardAmount = 2;
	rewards = {{
		item = Items.fruit("apple"):setAmount(1);
		chance = 15;
	}, {
		item = Items.fruit("carrot"):setAmount(1);
		chance = 15;
	}, {
		item = Items.fruit("grape"):setAmount(1);
		chance = 15;
	}, {
		item = Items.fruit("strawberry"):setAmount(1);
		chance = 15;
	}, {
		item = Items.potion("clicks"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("luck"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("hatch"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("gems"):setAmount(1);
		chance = 10;
	}};
}, {
	required = 900;
	rewardAmount = 1;
	rewards = {{
		item = Items.potion("clicks"):setAmount(1);
		chance = 25;
	}, {
		item = Items.potion("gems"):setAmount(1);
		chance = 25;
	}, {
		item = Items.potion("luck"):setAmount(1);
		chance = 20;
	}, {
		item = Items.potion("hatch"):setAmount(1);
		chance = 15;
	}, {
		item = Items.potion("rngLuck"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("megaClicks"):setAmount(1);
		chance = 1;
	}, {
		item = Items.potion("megaLuck"):setAmount(1);
		chance = 1;
	}, {
		item = Items.potion("megaGems"):setAmount(1);
		chance = 1;
	}, {
		item = Items.potion("golden"):setAmount(1);
		chance = 1;
	}, {
		item = Items.potion("shiny"):setAmount(1);
		chance = 0.5;
	}, {
		item = Items.potion("toxic"):setAmount(1);
		chance = 0.5;
	}, {
		item = Items.auraDice("magicAuraDice"):setAmount(1);
		chance = 0.5;
	}};
}, {
	required = 1500;
	rewardAmount = 2;
	rewards = {{
		item = Items.potion("clicks"):setAmount(1);
		chance = 25;
	}, {
		item = Items.potion("gems"):setAmount(1);
		chance = 25;
	}, {
		item = Items.potion("luck"):setAmount(1);
		chance = 20;
	}, {
		item = Items.potion("hatch"):setAmount(1);
		chance = 15;
	}, {
		item = Items.potion("rngLuck"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("megaClicks"):setAmount(1);
		chance = 1;
	}, {
		item = Items.potion("megaLuck"):setAmount(1);
		chance = 1;
	}, {
		item = Items.potion("megaGems"):setAmount(1);
		chance = 1;
	}, {
		item = Items.potion("golden"):setAmount(1);
		chance = 1;
	}, {
		item = Items.potion("shiny"):setAmount(1);
		chance = 0.5;
	}, {
		item = Items.potion("toxic"):setAmount(1);
		chance = 0.5;
	}, {
		item = Items.auraDice("magicAuraDice"):setAmount(1);
		chance = 0.5;
	}};
}, {
	required = 2400;
	rewardAmount = 2;
	rewards = {{
		item = Items.potion("clicks"):setAmount(1);
		chance = 25;
	}, {
		item = Items.potion("gems"):setAmount(1);
		chance = 25;
	}, {
		item = Items.potion("luck"):setAmount(1);
		chance = 20;
	}, {
		item = Items.potion("hatch"):setAmount(1);
		chance = 15;
	}, {
		item = Items.potion("rngLuck"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("megaClicks"):setAmount(1);
		chance = 1;
	}, {
		item = Items.potion("megaLuck"):setAmount(1);
		chance = 1;
	}, {
		item = Items.potion("megaGems"):setAmount(1);
		chance = 1;
	}, {
		item = Items.potion("golden"):setAmount(1);
		chance = 1;
	}, {
		item = Items.potion("shiny"):setAmount(1);
		chance = 0.5;
	}, {
		item = Items.potion("toxic"):setAmount(1);
		chance = 0.5;
	}, {
		item = Items.auraDice("magicAuraDice"):setAmount(1);
		chance = 0.5;
	}};
}, {
	required = 3600;
	rewardAmount = 5;
	rewards = {{
		item = Items.potion("clicks"):setAmount(1);
		chance = 25;
	}, {
		item = Items.potion("gems"):setAmount(1);
		chance = 25;
	}, {
		item = Items.potion("luck"):setAmount(1);
		chance = 20;
	}, {
		item = Items.potion("hatch"):setAmount(1);
		chance = 15;
	}, {
		item = Items.potion("rngLuck"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("megaClicks"):setAmount(1);
		chance = 1;
	}, {
		item = Items.potion("megaLuck"):setAmount(1);
		chance = 1;
	}, {
		item = Items.potion("megaGems"):setAmount(1);
		chance = 1;
	}, {
		item = Items.potion("golden"):setAmount(1);
		chance = 1;
	}, {
		item = Items.potion("shiny"):setAmount(1);
		chance = 0.5;
	}, {
		item = Items.potion("toxic"):setAmount(1);
		chance = 0.5;
	}, {
		item = Items.auraDice("magicAuraDice"):setAmount(1);
		chance = 0.5;
	}};
}, {
	required = 5400;
	rewardAmount = 2;
	rewards = {{
		item = Items.fruit("apple"):setAmount(3);
		chance = 5;
	}, {
		item = Items.fruit("carrot"):setAmount(3);
		chance = 5;
	}, {
		item = Items.fruit("grape"):setAmount(3);
		chance = 5;
	}, {
		item = Items.fruit("strawberry"):setAmount(3);
		chance = 5;
	}, {
		item = Items.potion("clicks"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("luck"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("hatch"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("gems"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("megaClicks"):setAmount(1);
		chance = 5;
	}, {
		item = Items.potion("megaLuck"):setAmount(1);
		chance = 5;
	}, {
		item = Items.potion("megaGems"):setAmount(1);
		chance = 5;
	}, {
		item = Items.potion("clicks"):setAmount(2);
		chance = 5;
	}, {
		item = Items.potion("luck"):setAmount(2);
		chance = 5;
	}, {
		item = Items.potion("hatch"):setAmount(2);
		chance = 5;
	}, {
		item = Items.potion("gems"):setAmount(2);
		chance = 5;
	}, {
		item = Items.potion("golden"):setAmount(1);
		chance = 1;
	}, {
		item = Items.potion("toxic"):setAmount(1);
		chance = 0.5;
	}, {
		item = Items.box("potionsBox"):setAmount(1);
		chance = 1.5;
	}, {
		item = Items.box("fruitsBox"):setAmount(1);
		chance = 1.5;
	}, {
		item = Items.potion("shiny"):setAmount(1);
		chance = 0.5;
	}, {
		item = Items.auraDice("magicAuraDice"):setAmount(5);
		chance = 0.5;
	}, {
		item = Items.auraDice("voidAuraDice"):setAmount(1);
		chance = 0.1;
	}, {
		item = Items.auraDice("royalAuraDice"):setAmount(1);
		chance = 0.01;
	}};
}, {
	required = 7200;
	rewardAmount = 3;
	rewards = {{
		item = Items.fruit("apple"):setAmount(3);
		chance = 5;
	}, {
		item = Items.fruit("carrot"):setAmount(3);
		chance = 5;
	}, {
		item = Items.fruit("grape"):setAmount(3);
		chance = 5;
	}, {
		item = Items.fruit("strawberry"):setAmount(3);
		chance = 5;
	}, {
		item = Items.potion("clicks"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("luck"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("hatch"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("gems"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("megaClicks"):setAmount(1);
		chance = 5;
	}, {
		item = Items.potion("megaLuck"):setAmount(1);
		chance = 5;
	}, {
		item = Items.potion("megaGems"):setAmount(1);
		chance = 5;
	}, {
		item = Items.potion("clicks"):setAmount(2);
		chance = 5;
	}, {
		item = Items.potion("luck"):setAmount(2);
		chance = 5;
	}, {
		item = Items.potion("hatch"):setAmount(2);
		chance = 5;
	}, {
		item = Items.potion("gems"):setAmount(2);
		chance = 5;
	}, {
		item = Items.potion("golden"):setAmount(1);
		chance = 1;
	}, {
		item = Items.potion("toxic"):setAmount(1);
		chance = 0.5;
	}, {
		item = Items.box("potionsBox"):setAmount(1);
		chance = 1.5;
	}, {
		item = Items.box("fruitsBox"):setAmount(1);
		chance = 1.5;
	}, {
		item = Items.potion("shiny"):setAmount(1);
		chance = 0.5;
	}, {
		item = Items.auraDice("magicAuraDice"):setAmount(5);
		chance = 0.5;
	}, {
		item = Items.auraDice("voidAuraDice"):setAmount(1);
		chance = 0.1;
	}, {
		item = Items.auraDice("royalAuraDice"):setAmount(1);
		chance = 0.01;
	}};
}, {
	required = 9000;
	rewardAmount = 4;
	rewards = {{
		item = Items.fruit("apple"):setAmount(3);
		chance = 5;
	}, {
		item = Items.fruit("carrot"):setAmount(3);
		chance = 5;
	}, {
		item = Items.fruit("grape"):setAmount(3);
		chance = 5;
	}, {
		item = Items.fruit("strawberry"):setAmount(3);
		chance = 5;
	}, {
		item = Items.potion("clicks"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("luck"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("hatch"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("gems"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("megaClicks"):setAmount(1);
		chance = 5;
	}, {
		item = Items.potion("megaLuck"):setAmount(1);
		chance = 5;
	}, {
		item = Items.potion("megaGems"):setAmount(1);
		chance = 5;
	}, {
		item = Items.potion("clicks"):setAmount(2);
		chance = 5;
	}, {
		item = Items.potion("luck"):setAmount(2);
		chance = 5;
	}, {
		item = Items.potion("hatch"):setAmount(2);
		chance = 5;
	}, {
		item = Items.potion("gems"):setAmount(2);
		chance = 5;
	}, {
		item = Items.potion("golden"):setAmount(1);
		chance = 1;
	}, {
		item = Items.potion("toxic"):setAmount(1);
		chance = 0.5;
	}, {
		item = Items.box("potionsBox"):setAmount(1);
		chance = 1.5;
	}, {
		item = Items.box("fruitsBox"):setAmount(1);
		chance = 1.5;
	}, {
		item = Items.potion("shiny"):setAmount(1);
		chance = 0.5;
	}, {
		item = Items.box("potionsChest"):setAmount(1);
		chance = 0.25;
	}, {
		item = Items.box("fruitsChest"):setAmount(1);
		chance = 0.25;
	}, {
		item = Items.auraDice("magicAuraDice"):setAmount(5);
		chance = 0.5;
	}, {
		item = Items.auraDice("voidAuraDice"):setAmount(3);
		chance = 0.1;
	}, {
		item = Items.auraDice("royalAuraDice"):setAmount(1);
		chance = 0.01;
	}, {
		item = Items.box("globalBox");
		chance = 0.0002;
	}, {
		item = Items.exclusiveEgg(Variables.currentExclusiveEgg.name);
		chance = 0.0002;
	}, {
		item = Items.mount("ufoMount");
		chance = 0.0001;
	}, {
		item = Items.exclusive("tradeTokens"):setAmount(100);
		chance = 0.0001;
	}};
}, {
	required = 10800;
	rewardAmount = 6;
	rewards = {{
		item = Items.fruit("apple"):setAmount(3);
		chance = 5;
	}, {
		item = Items.fruit("carrot"):setAmount(3);
		chance = 5;
	}, {
		item = Items.fruit("grape"):setAmount(3);
		chance = 5;
	}, {
		item = Items.fruit("strawberry"):setAmount(3);
		chance = 5;
	}, {
		item = Items.potion("clicks"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("luck"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("hatch"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("gems"):setAmount(1);
		chance = 10;
	}, {
		item = Items.potion("megaClicks"):setAmount(1);
		chance = 5;
	}, {
		item = Items.potion("megaLuck"):setAmount(1);
		chance = 5;
	}, {
		item = Items.potion("megaGems"):setAmount(1);
		chance = 5;
	}, {
		item = Items.potion("clicks"):setAmount(2);
		chance = 5;
	}, {
		item = Items.potion("luck"):setAmount(2);
		chance = 5;
	}, {
		item = Items.potion("hatch"):setAmount(2);
		chance = 5;
	}, {
		item = Items.potion("gems"):setAmount(2);
		chance = 5;
	}, {
		item = Items.potion("golden"):setAmount(1);
		chance = 1;
	}, {
		item = Items.potion("toxic"):setAmount(1);
		chance = 0.5;
	}, {
		item = Items.box("potionsBox"):setAmount(1);
		chance = 1.5;
	}, {
		item = Items.box("fruitsBox"):setAmount(1);
		chance = 1.5;
	}, {
		item = Items.potion("shiny"):setAmount(1);
		chance = 0.5;
	}, {
		item = Items.box("potionsChest"):setAmount(1);
		chance = 0.25;
	}, {
		item = Items.box("fruitsChest"):setAmount(1);
		chance = 0.25;
	}, {
		item = Items.auraDice("magicAuraDice"):setAmount(5);
		chance = 0.5;
	}, {
		item = Items.auraDice("voidAuraDice"):setAmount(3);
		chance = 0.1;
	}, {
		item = Items.auraDice("royalAuraDice"):setAmount(1);
		chance = 0.01;
	}, {
		item = Items.box("globalBox");
		chance = 0.0002;
	}, {
		item = Items.exclusiveEgg(Variables.currentExclusiveEgg.name);
		chance = 0.0002;
	}, {
		item = Items.mount("ufoMount");
		chance = 0.0001;
	}, {
		item = Items.exclusive("tradeTokens"):setAmount(100);
		chance = 0.0001;
	}};
}}