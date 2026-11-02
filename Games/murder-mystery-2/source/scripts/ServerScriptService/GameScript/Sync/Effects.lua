local Boxes = {
	--[[["None"] = {
		["Name"] = "None";
		["Description"] = "How lame!";
		["Image"] = "";
		["KnifeModule"] = 0;
		["DeathModule"] = 0;
		["Price"] = 0;
	};]]

	["Burn"] = {
		["Name"] = "Flaming Knife";
		["Description"] = "Set your knife on fire and burn your enemies!";
		["Image"] = "https://www.roblox.com/asset/?id=387182858";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.FlamingKnifeModule;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.FlamingDeathEffect;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Common";
		["Price"] = 0;
	};
	["BlueFire"] = {
		["Name"] = "Blue Flaming Knife";
		["Description"] = "Set your knife on (blue) fire and burn your enemies!";
		["Image"] = "https://www.roblox.com/asset/?id=387182852";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.BlueFlamingKnifeModule;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.BlueFlamingDeathModule;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
		["Rarity"] = "Rare";
		["Gems"] = false;
	};

	--[[["Arctic"] = {
		["Name"] = "Arctic";
		["Description"] = "BRRR! Freeze your enemies!";
		["Image"] = "rbxassetid://2740352587";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Arctic;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Balloons"] = {
		["Name"] = "Balloons";
		["Description"] = "Best effect to perform!";
		["Image"] = "rbxassetid://2740351971";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Balloons;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Biohazard"] = {
		["Name"] = "Biohazard";
		["Description"] = "Wow! Toxic";
		["Image"] = "rbxassetid://2743462231";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Biohazard;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Blaze"] = {
		["Name"] = "Blaze";
		["Description"] = "Wow! hot";
		["Image"] = "rbxassetid://2743459382";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Blaze;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Comet"] = {
		["Name"] = "Comet";
		["Description"] = "Space?";
		["Image"] = "rbxassetid://2743462399";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Comet;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Desire"] = {
		["Name"] = "Desire";
		["Description"] = "Take my heart!";
		["Image"] = "rbxassetid://2834878986";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Desire;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Disco"] = {
		["Name"] = "Disco";
		["Description"] = "Everybody dance now!";
		["Image"] = "rbxassetid://2743462786";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Disco;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Eggcellent"] = {
		["Name"] = "Eggcellent";
		["Description"] = "Happy easter";
		["Image"] = "rbxassetid://3090762873";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.EggCellent;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Emoji"] = {
		["Name"] = "Emoji";
		["Description"] = "XD";
		["Image"] = "rbxassetid://2733154706";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Emoji;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Fireworks"] = {
		["Name"] = "Fireworks";
		["Description"] = "YOOOO";
		["Image"] = "rbxassetid://2700428991";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Fireworks;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Galactic"] = {
		["Name"] = "Galactic";
		["Description"] = "To the moooooon!!";
		["Image"] = "rbxassetid://2921433249";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Galactic;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Gamma"] = {
		["Name"] = "Gamma";
		["Description"] = "Gamma! Yes!!";
		["Image"] = "rbxassetid://2938320882";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Gamma;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Honeycomb"] = {
		["Name"] = "Honeycomb";
		["Description"] = "Bee swarm simulator!";
		["Image"] = "rbxassetid://2743461813";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Honeycomb;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Horizon"] = {
		["Name"] = "Horizon";
		["Description"] = "-";
		["Image"] = "rbxassetid://2938320696";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Horizon;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Icecream"] = {
		["Name"] = "Icecream";
		["Description"] = "yum!";
		["Image"] = "rbxassetid://2733153190";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Icecream;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Jumpy"] = {
		["Name"] = "Jumpy";
		["Description"] = "-";
		["Image"] = "rbxassetid://3090762987";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Jumpy;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Love"] = {
		["Name"] = "Love";
		["Description"] = "Love";
		["Image"] = "rbxassetid://2740352888";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Love;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Night"] = {
		["Name"] = "Night";
		["Description"] = "Goodnight";
		["Image"] = "rbxassetid://2743489178";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Night;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};

	["Nova"] = {
		["Name"] = "Nova";
		["Description"] = "";
		["Image"] = "rbxassetid://3090762736";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Nova;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Nuclear"] = {
		["Name"] = "Nuclear";
		["Description"] = "";
		["Image"] = "rbxassetid://2740352736";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Nuclear;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Oof"] = {
		["Name"] = "Oof";
		["Description"] = "Get noobed! LOL";
		["Image"] = "rbxassetid://2733154198";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Oof;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Paint"] = {
		["Name"] = "Paint";
		["Description"] = "";
		["Image"] = "rbxassetid://2743461663";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Paint;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Pizza"] = {
		["Name"] = "Pizza";
		["Description"] = "YUM!!!";
		["Image"] = "rbxassetid://2733153358";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Pizza;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};]]
	["RainbowE"] = {
		["Name"] = "Rainbow";
		["Description"] = "";
		["Image"] = "rbxassetid://2743462651";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.RainbowKnifeModule;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.RainbowDeathModule;
		["Type"] = "Weapon Effect";
		["Price"] = "NotForSale";
	};
	--[[["Shine"] = {
		["Name"] = "Shine";
		["Description"] = "Bling bling!";
		["Image"] = "rbxassetid://2733154444";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Shine;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModule;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Starpower"] = {
		["Name"] = "Starpower";
		["Description"] = "stars";
		["Image"] = "rbxassetid://2733153985";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Starpower;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModule;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Toxic"] = {
		["Name"] = "Toxic";
		["Description"] = "!";
		["Image"] = "rbxassetid://2740351388";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Toxic;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModule;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Limited"] = {
		["Name"] = "Limited";
		["Description"] = "Be rich!";
		["Image"] = "rbxassetid://2733153814";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Limited;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModule;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};
	["Venom"] = {
		["Name"] = "Venom";
		["Description"] = "";
		["Image"] = "rbxassetid://2743461474";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Venom;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModule;
		["Type"] = "Weapon Effect";
		["Price"] = "NotForSale";
	};
	["Volt"] = {
		["Name"] = "Volt";
		["Description"] = "ZAP zAp ZaP!";
		["Image"] = "rbxassetid://2740351528";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Volt;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModule;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
	};

	["IceMagic"] = {
		["Name"] = "Ice Magic";
		["Description"] = "Ice Magic!";
		["Image"] = "https://www.roblox.com/asset/?id=8320233180";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.BlueFlamingKnifeModule;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.BlueFlamingDeathModule;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
		["Rarity"] = "Rare";
		["Gems"] = false;
	};

	["Gingerbread"] = {
		["Name"] = "Gingerbread";
		["Description"] = "";
		["Image"] = "rbxassetid://6747774589&bust=6891";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.GingerbreadKnifeModule;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.GingerbreadDeathModule;
		["Type"] = "Weapon Effect";
		["Price"] = "NotForSale";
	};

	["CandyCane"] = {
		["Name"] = "Candy Cane";
		["Description"] = "";
		["Image"] = "rbxassetid://6745541163&bust=5989";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.CandyKnifeModule;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.CandyDeathModule;
		["Type"] = "Weapon Effect";
		["Price"] = "NotForSale";
		["Christmas"]   = true;
		["Year"]    = "2016";
	};

	["Vampire"] = {
		["Name"] = "Vampire";
		["Description"] = "Yum, victim blood!";
		["Image"] = "https://www.roblox.com/asset/?id=5873283412";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.VampireKnifeModule;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.DeathModule;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Godly";
		["Price"] = "NotForSale";
	};
]]
	["Ghostly"] = {
		["Name"] = "Ghostly";
		["Description"] = "oOoOOoOoOOo!";
		["Image"] = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=415915771";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.GhostlyKnifeModule; -- Empty Module
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.GhostifyDeathModule;
		["Type"] = "Weapon Effect";
		["Price"] = "NotForSale";
	};

	["UncommonOrnament"] = {
		["Name"] = "Uncommon Ornament";
		["Description"] = "";
		["Image"] = "rbxassetid://2674907876";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.BlueOrnamentsKnifeModule;
		["DeathModule"] = 0;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Christmas";
		["Price"] = "NotForSale";
		["Christmas"]   = true;
		["Year"]    = "2018";
	};

	["Knifeception"] = {
		["Name"] = "Knifeception";
		["Description"] = "Your knife spawns mini knives! Changes based on your equipped knife.";
		["Image"] = "https://www.roblox.com/asset/?id=418207962";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Knifeception;
		["DeathModule"] = 0; -- death module is just a nil death module
		["Type"] = "Weapon Effect";
		["Price"] = 0;
		["GemPrice"] = 1;
		["Rarity"] = "Uncommon";
		["Gems"] = false;
	};



	["PinkFire"] = {
		["Name"] = "Pink Flaming Knife";
		["Description"] = "Set your knife on (pink) fire and burn your enemies!";
		["Image"] = "https://www.roblox.com/asset/?id=387182855";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.PinkFlamingKnifeModule;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.PinkFlamingDeathModule;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
		["Rarity"] = "Rare";
		["Gems"] = false;
	};
	["GreenFire"] = {
		["Name"] = "Green Flaming Knife";
		["Description"] = "Set your knife on (green) fire and burn your enemies!";
		["Image"] = "https://www.roblox.com/asset/?id=387182851";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.GreenFlamingKnife;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.GreenFlamingKnifeDeathModule;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
		["Rarity"] = "Rare";
		["Gems"] = false;
	};

	["Electric"] = {
		["Name"] = "Electric Knife";
		["Description"] = "Zap your enemies and turn them into skeletons!";
		["Image"] = "http://www.roblox.com/asset/?id=3059979563";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Electric;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.ElectricDeathModule;
		["Type"] = "Weapon Effect";
		["Gems"] = false;
		["Rarity"] = "Common";
		["Price"] = 0;
	};

	["Dual"] = {
		["Name"] = "Dual Wield";
		["Description"] = "Dual wield your current knife!";
		["Image"] = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=237811060";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.DualWield;
		["DeathModule"] = 0;
		["Type"] = "Weapon Effect";
		["Price"] = 0;
		["Rarity"] = "Legendary";
		["Gems"] = false;
	};

	["MoneyEffect"] = {
		["Name"] = "Monify";
		["Description"] = "Turn your victims into money!";
		["Image"] = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=238446940";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Money;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.MonifyDeathModule;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Common";
		["Price"] = "NotForSale";
	};

	["Doge"] = {
		["Name"] = "Doge";
		["Description"] = "Dogefy your knife and victims!";
		["Image"] = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=345179425";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Doge;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.DogeDeathModule;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Common";
		["Price"] = 0;
	};

	["Ghostify"] = {
		["Name"] = "Ghostify";
		["Description"] = "Give your knife a ghostly effect, and turn your victims into ghosts!";
		["Image"] = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=415915771";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Ghostify; -- Empty Module
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.GhostifyDeathModule;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Common";
		["Price"] = 0;
	};

	["Heartify"] = {
		["Name"] = "Heartify";
		["Description"] = "Heartify your knife and give your victims hearteyes.";
		["Image"] = "https://www.roblox.com/asset/?id=416769271";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Heartify; -- Empty Module
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.HeartifyDeathModule;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Common";
		["Price"] = 0;
	};

	["Radioactive"] = {
		["Name"] = "Radioactive";
		["Description"] = "Give your knife a radioactive effect and turn your victims green.";
		["Image"] = "https://www.roblox.com/asset/?id=416805902";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.RadioactiveKnife; -- Empty Module
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.RadioactiveDeathModule;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Rare";
		["Price"] = 0;
	};

	["Musical"] = {
		["Name"] = "Musical";
		["Description"] = "Give your knife a musical effect. No kill effect.";
		["Image"] = "https://www.roblox.com/asset/?id=416811723";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.MusicalKnife; -- Empty Module
		["DeathModule"] = 0;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Common";
		["Price"] = 0;
	};

	["Elitify"] = {
		["Name"] = "Elite-ify";
		["Description"] = "Elite-ify your knife and victims!";
		["Image"] = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=346681501";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Elitify;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.EliteifyDeathModule;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Legendary";
		["Price"] = "Elite";
	};

	["GearStorm"] = {
		["Name"] = "Gear Storm";
		["Description"] = "Unleash the Gear Storm on your enemies!";
		["Image"] = "https://www.roblox.com/asset/?id=360666852";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.GearstormKnifeModule;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.GearstormDeathModule;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Common";
		["Price"] = "NotForSale";
	};

	["Bitsplosion"] = {
		["Name"] = "Bitsplosion";
		["Description"] = "Make your enemies pixplode!";
		["Image"] = "https://www.roblox.com/asset/?id=365367041";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.BitsplosionKnifeModule;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.BitsplosionDeathModule;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Common";
		["Price"] = "NotForSale";
	};
	
	["RadioactiveGun"] = {
		["Name"] = "Radioactive";
		["Description"] = "Give your knife a radioactive effect and turn your victims green.";
		["Image"] = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=14235594271";
		["GunModule"] = game.ServerStorage.EffectsDatabase.RadioactiveGun; -- Empty Module
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.RadioactiveDeathModule2;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Rare";
		["Price"] = "NotForSale";
	};
	
	["Grimace"] = {
		["Name"] = "Grimace Shake";
		["Description"] = "Happy Birthday Grimace!";
		["Image"] = "https://www.roblox.com/asset/?id=13974902615";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.GrimaceShake;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.GrimaceShakeDeathModule;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Godly";
		["Price"] = 500;
	};

	["Darkfire"] = {
		["Name"] = "Darkfire";
		["Description"] = "Engulf your enemies in the flames of darkness.";
		["Image"] = "https://www.roblox.com/asset/?id=475504088";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.DarkFireKnifeModule;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.DarkFireDeathModule;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Common";
		["Price"] = "NotForSale";
	};

	["Snowflakes"] = {
		["Name"] = "Snowflakes 2017";
		["Description"] = "Snowflakes!";
		["Image"] = "rbxassetid://585820804";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Snowflake2017;
		["DeathModule"] = 0;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Common";
		["Price"] = "NotForSale";
		["ChristmasDescription"] = "Effect";
	};

	["Blizzard"] = {
		["Name"] = "Blizzard";
		["Description"] = "Blizzarding Time";
		["Image"] = "rbxassetid://11897911241";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Blizzard;
		["DeathModule"] = 0;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Common";
		["Price"] = "NotForSale";
		["ChristmasDescription"] = "Effect";
	};

	["Rainbow"] = {
		["Name"] = "Rainbow Fire";
		["Description"] = "ITS RAINBOW!1!!";
		["Image"] = "https://www.roblox.com/asset/?id=619571884";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.RainbowFireKnifeModule;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.RainbowFireDeathModule;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Common";
		["Price"] = "NotForSale";
	};
	
	["Sunshine"] = {
		["Name"] = "Sunshine";
		["Description"] = "Sunshine Time";
		["Image"] = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=13867377847";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.Sunshine;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.SunshineDeathModule;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Godly";
		["Price"] = 500;
	};
	
	["PLight"] = {
		["Name"] = "Pink Lightning";
		["Description"] = "Idk what to put here - Jaden";
		["Image"] = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=13869476059";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.LightningKnifeModule;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.LightningDeathModule;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Common";
		["Price"] = 500;
		["GemPrice"] = 1;
	};
	
	["ItsJustWata"] = {
		["Name"] = "Blue Fog";
		["Description"] = "Idk what to put here either - Jaden";
		["Image"] = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=13873093708";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.BlueF;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.BlueFDeathModule;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Common";
		["Price"] = 50;
	};
	
	["GingerBreadMan"] = {
		["Name"] = "Gingerbread Man";
		["Description"] = "Turn your enemies into gingerbread men";
		["Image"] = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=13873093708";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.GingerbreadManKnifeModule;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.GingerbreadManDeathModule;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Legendary";
		["Price"] = "NotForSale";
	};
	
	["SandKnifeModule"] = {
		["Name"] = "Wrapped Sand Knife";
		["Description"] = "Turn your enemies into sand people";
		["Image"] = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=365568056";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.SandKnifeModule;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.SandDeathModule;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Legendary";
		["Price"] = 0;
	};
	
	["Water"] = {
		["Name"] = "Water Effect";
		["Description"] = "Water Effect";
		["Image"] = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=13890798256";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.WaterKnifeModule;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.GingerbreadManDeathModule;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Legendary";
		["Price"] = 0;
	};
	
	["FlowEffect"] = {
		["Name"] = "Flow Effect";
		["Description"] = "Just follow the Flow.";
		["Image"] = "http://www.roblox.com/Thumbs/Asset.ashx?format=png&width=250&height=250&assetId=13957853725";
		["KnifeModule"] = game.ServerStorage.EffectsDatabase.FlowKnifeModule;
		["DeathModule"] = game.ServerStorage.EffectsDatabase.DeathModules.FlowDeathModule;
		["Type"] = "Weapon Effect";
		["Rarity"] = "Legendary";
		["Price"] = 0;
	};

};


return Boxes;
