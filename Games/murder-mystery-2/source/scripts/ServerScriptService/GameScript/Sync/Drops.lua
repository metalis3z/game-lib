local Boxes = {


	DropCountChance = {33,50,0};

	DropTree = {

		--[[["Christmas"] = {
			Type = "Materials";
			Chance = {25,0,0};
			DropTable = {
				
				["SkateboardParts"] = {
					Amount = {1,1};
					Chance = 5;
				};
				
				["BasketballParts"] = {
					Amount = {1,1};
					Chance = 29;
				};
				
				["GameSystemParts"] = {
					Amount = {1,1};
					Chance = 1;
				};
				
				["ActionFigureParts"] = {
					Amount = {1,1};
					Chance = 12;
				};
				
				["WrappingPaperRed"] = {
					Amount = {1,1};
					Chance = 52;
				};
				
				
			};
		};]]


		["Shards"] = {
			Type = "Materials";
			Chance = {0,100,0};
			DropTable = {
				["CommonShards"]={Amount={1,3};Chance=6000;};
				["UncommonShards"]={Amount={1,3};Chance=2500;};
				["RareShards"]={Amount={1,2};Chance=1000;};
				["LegendaryShards"]={Amount={1,1};Chance=500;};
				["GodlyShards"]={Amount={1,1};Chance=1;};
			};
		};
		["Metals"] = {
			Type = "Materials";
			Chance = {100,0,0};
			DropTable = {
				["CommonMetal"]={Amount={1,2};Chance=6000;};
				["UncommonMetal"]={Amount={1,2};Chance=2500;};
				["RareMetal"]={Amount={1,2};Chance=1000;};
				["LegendaryMetal"]={Amount={1,1};Chance=500;};
				["GodlyMetal"]={Amount={1,1};Chance=1;};


			};
		};
		["UltraHammer"] = {
			Type = "Weapons";
			Chance = {100,0,0};
			DropTable = {
				["UltraHammer"]={Amount={1,1};Chance=100;};
				["ToxicCore"]={Amount={1,1};Chance=100;};
				["BombasticBatwing"]={Amount={1,1};Chance=500;};
				["Donut"]={Amount={1,1};Chance=3000;};
				["Night"]={Amount={1,1};Chance=3000;};
				["Future"]={Amount={1,1};Chance=3000;};
				["Overseer"]={Amount={1,1};Chance=3000;};
				["Midnight"]={Amount={1,1};Chance=3000;};
				["Damp"]={Amount={1,1};Chance=3000;};
				["Checker"]={Amount={1,1};Chance=3000;};
				["MoltenKnife"]={Amount={1,1};Chance=2500;};
				["Molten"]={Amount={1,1};Chance=2500;};
				["Spitfire"]={Amount={1,1};Chance=2500;};
				["Nether"]={Amount={1,1};Chance=2500;};
				["Heat"]={Amount={1,5};Chance=1000;};
				["Luger"]={Amount={1,5};Chance=1000;};
				["Laser"]={Amount={1,5};Chance=1000;};
				["Slasher"]={Amount={1,5};Chance=1000;};
				["DarkBrod"]={Amount={1,5};Chance=1000;};
				["LightBrod"]={Amount={1,5};Chance=1000;};
				["Shark"]={Amount={1,5};Chance=1000;};
				["TheSeer"]={Amount={1,10};Chance=1500;};












			};
		};
		
		
		["Bussiness"] = {
			Type = "Materials";
			Chance = {100,0,0};
			DropTable = {
				["PumpkinKey"]={Amount={1,2};Chance=6000;};
				["ReaverKeyMaterial"]={Amount={1,2};Chance=25;};
				["2020PumpkinKeyMaterial"]={Amount={1,2};Chance=25;};
				["DeathKey"]={Amount={1,1};Chance=15;};
				["KnightmareShard"]={Amount={1,1};Chance=1;};


			};
		};
		


		--[[["Weapons"] = {
			Type = "Weapons";
			Chance = {0,5,0};
			DropTabale = {
				
			};
		};]]
	};





};


return Boxes;
