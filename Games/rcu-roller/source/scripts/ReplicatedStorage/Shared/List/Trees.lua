-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:17
-- Luau version 6, Types version 3
-- Time taken: 0.000953 seconds

local Items = require(game:GetService("ReplicatedStorage").Shared.Items)
return {
	spawn = {
		trees = {{
			hp = 10;
			cooldown = 300;
			chance = 100;
			item = Items.mapItem("wood"):setAmount(3);
		}};
	};
	desert = {
		trees = {{
			hp = 25;
			cooldown = 180;
			chance = 100;
			item = Items.mapItem("cactusWood"):setAmount(3);
		}};
	};
	nuclear = {
		trees = {{
			hp = 150;
			cooldown = 60;
			chance = 100;
			item = Items.mapItem("nuclearWood"):setAmount(3);
		}};
	};
	atlantis = {
		trees = {{
			hp = 500;
			cooldown = 60;
			chance = 100;
			item = Items.mapItem("underwaterWood"):setAmount(3);
		}};
	};
	kingdom = {
		trees = {{
			hp = 1500;
			cooldown = 120;
			chance = 100;
			item = Items.mapItem("royalWood"):setAmount(3);
		}};
	};
	city = {
		trees = {{
			hp = 5000;
			cooldown = 180;
			chance = 100;
			item = Items.mapItem("hackerWood"):setAmount(3);
		}};
	};
}