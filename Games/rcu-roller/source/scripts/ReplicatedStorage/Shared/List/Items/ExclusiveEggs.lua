-- ExclusiveEggs config
-- pets table: { [petName] = weight } where weight > 0
-- Weights are relative. All pets must have weight > 0 or rollPet() breaks.
return {
	stormExclusiveEgg = {
		name = "Storm Exclusive Egg";
		description = "\xE4h nu tar vi helg!";
		icon = "rbxassetid://87665405845134";
		rarity = "Exclusive";
		pets = {
			["Storm Wisp"]    = 40;
			["Storm Ghoul"]   = 30;
			["Storm Striker"] = 20;
			["Thunder Fury"]  = 8;
			["Tempest Lord"]  = 2;
		};
	};
}
