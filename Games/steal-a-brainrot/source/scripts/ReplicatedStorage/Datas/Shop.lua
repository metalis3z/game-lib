-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Packages_0 = l_ReplicatedStorage_0.Packages;
local _ = require(l_Packages_0.Synchronizer);
local _ = require(l_ReplicatedStorage_0.Datas.ServerData);
local v4 = require(l_ReplicatedStorage_0.Datas.ValentinesShop);
local v47 = {
	[3312891057] = {
		Display = "[Rainbow Machine] Fill Now", 
		Callback = function(_) --[[ Line: 43 ]] --[[ Name: Callback ]]
			return false;
		end, 
		Type = "RainbowMachine"
	}, 
	[3337520317] = {
		Display = "[Bubblegum Machine] Fill Now", 
		Callback = function(_) --[[ Line: 57 ]] --[[ Name: Callback ]]
			return false;
		end, 
		Type = "RainbowMachine"
	}, 
	[3312944986] = {
		Display = "1x Spin (Rainbow Wheel)", 
		Identifier = "x1", 
		Type = "RainbowSpinWheel", 
		Value = 1
	}, 
	[3312945232] = {
		Display = "1x Spin (Rainbow Wheel) DISCOUNT", 
		Identifier = "x1", 
		Type = "RainbowSpinWheel", 
		Value = 1
	}, 
	[3312945488] = {
		Display = "3x Spins (Rainbow Wheel)", 
		Identifier = "x3", 
		Type = "RainbowSpinWheel", 
		Value = 3
	}, 
	[3312944807] = {
		Display = "10x Spins (Rainbow Wheel)", 
		Identifier = "x10", 
		Type = "RainbowSpinWheel", 
		Value = 10
	}, 
	[3307371795] = {
		Display = "1x Spin (Bloodmoon Wheel)", 
		Identifier = "x1", 
		Type = "BloodmoonWheelSpin", 
		Value = 1
	}, 
	[3307372046] = {
		Display = "1x Spin (Bloodmoon Wheel) DISCOUNT", 
		Identifier = "x1", 
		Type = "BloodmoonWheelSpin", 
		Value = 1
	}, 
	[3307372342] = {
		Display = "3x Spins (Bloodmoon Wheel)", 
		Identifier = "x3", 
		Type = "BloodmoonWheelSpin", 
		Value = 3
	}, 
	[3307372798] = {
		Display = "10x Spins (Bloodmoon Wheel)", 
		Identifier = "x10", 
		Type = "BloodmoonWheelSpin", 
		Value = 10
	}, 
	[3322567440] = {
		Display = "1x Spin (Candy Wheel)", 
		Identifier = "x1", 
		Type = "CandyWheelSpin", 
		Value = 1
	}, 
	[3322568083] = {
		Display = "1x Spin (Candy Wheel) DISCOUNT", 
		Identifier = "x1", 
		Type = "CandyWheelSpin", 
		Value = 1
	}, 
	[3322567771] = {
		Display = "3x Spins (Candy Wheel)", 
		Identifier = "x3", 
		Type = "CandyWheelSpin", 
		Value = 3
	}, 
	[3322567871] = {
		Display = "10x Spins (Candy Wheel)", 
		Identifier = "x10", 
		Type = "CandyWheelSpin", 
		Value = 10
	}, 
	[3345489415] = {
		Display = "1x Spin (Molten Wheel)", 
		Identifier = "x1", 
		Type = "MoltenWheelSpin", 
		Value = 1
	}, 
	[3345489701] = {
		Display = "1x Spin (Molten Wheel) DISCOUNT", 
		Identifier = "x1", 
		Type = "MoltenWheelSpin", 
		Value = 1
	}, 
	[3345489943] = {
		Display = "3x Spins (Molten Wheel)", 
		Identifier = "x3", 
		Type = "MoltenWheelSpin", 
		Value = 3
	}, 
	[3345489151] = {
		Display = "10x Spins (Molten Wheel)", 
		Identifier = "x10", 
		Type = "MoltenWheelSpin", 
		Value = 10
	}, 
	[3377020181] = {
		Display = "1x Spin (Galaxy Wheel)", 
		Identifier = "x1", 
		Type = "GalaxyWheelSpin", 
		Value = 1
	}, 
	[3377020567] = {
		Display = "1x Spin (Galaxy Wheel) DISCOUNT", 
		Identifier = "x1", 
		Type = "GalaxyWheelSpin", 
		Value = 1
	}, 
	[3377021022] = {
		Display = "3x Spins (Galaxy Wheel)", 
		Identifier = "x3", 
		Type = "GalaxyWheelSpin", 
		Value = 3
	}, 
	[3377020761] = {
		Display = "10x Spins (Galaxy Wheel)", 
		Identifier = "x10", 
		Type = "GalaxyWheelSpin", 
		Value = 10
	}, 
	[3414123796] = {
		Display = "1x Spin (Yin Yang Wheel)", 
		Identifier = "x1", 
		Type = "YinYangWheelSpin", 
		Value = 1
	}, 
	[3414123985] = {
		Display = "1x Spin (Yin Yang Wheel) DISCOUNT", 
		Identifier = "x1", 
		Type = "YinYangWheelSpin", 
		Value = 1
	}, 
	[3414124199] = {
		Display = "3x Spins (Yin Yang Wheel)", 
		Identifier = "x3", 
		Type = "YinYangWheelSpin", 
		Value = 3
	}, 
	[3414124509] = {
		Display = "10x Spins (Yin Yang Wheel)", 
		Identifier = "x10", 
		Type = "YinYangWheelSpin", 
		Value = 10
	}, 
	[3456071068] = {
		Display = "1x Spin (Radioactive Wheel)", 
		Identifier = "x1", 
		Type = "RadioactiveWheelSpin", 
		Value = 1
	}, 
	[3456071066] = {
		Display = "1x Spin (Radioactive Wheel) DISCOUNT", 
		Identifier = "x1", 
		Type = "RadioactiveWheelSpin", 
		Value = 1
	}, 
	[3456071067] = {
		Display = "3x Spins (Radioactive Wheel)", 
		Identifier = "x3", 
		Type = "RadioactiveWheelSpin", 
		Value = 3
	}, 
	[3456071065] = {
		Display = "10x Spins (Radioactive Wheel)", 
		Identifier = "x10", 
		Type = "RadioactiveWheelSpin", 
		Value = 10
	}, 
	[3488386426] = {
		Display = "1x Spin (Christmas Wheel)", 
		Identifier = "x1", 
		Type = "ChristmasWheelSpin", 
		Value = 1
	}, 
	[3488386429] = {
		Display = "1x Spin (Christmas Wheel) DISCOUNT", 
		Identifier = "x1", 
		Type = "ChristmasWheelSpin", 
		Value = 1
	}, 
	[3488386430] = {
		Display = "3x Spin (Christmas Wheel)", 
		Identifier = "x3", 
		Type = "ChristmasWheelSpin", 
		Value = 3
	}, 
	[3488386428] = {
		Display = "10x Spin (Christmas Wheel)", 
		Identifier = "x10", 
		Type = "ChristmasWheelSpin", 
		Value = 10
	}, 
	[3499648585] = {
		Display = "1x Spin (Cursed Wheel)", 
		Identifier = "x1", 
		Type = "CursedWheelSpin", 
		Value = 1
	}, 
	[3499648586] = {
		Display = "1x Spin (Cursed Wheel) DISCOUNT", 
		Identifier = "x1", 
		Type = "CursedWheelSpin", 
		Value = 1
	}, 
	[3499648590] = {
		Display = "3x Spins (Cursed Wheel)", 
		Identifier = "x3", 
		Type = "CursedWheelSpin", 
		Value = 3
	}, 
	[3499648587] = {
		Display = "10x Spins (Cursed Wheel)", 
		Identifier = "x10", 
		Type = "CursedWheelSpin", 
		Value = 10
	}, 
	[3593047340] = {
		Display = "1x Spin (Cyber Wheell)", 
		Identifier = "x1", 
		Type = "CyberWheelSpin", 
		Value = 1
	}, 
	[3582062449] = {
		Display = "1x Spin (Divine Wheel)", 
		Identifier = "x1", 
		Type = "DivineWheelSpin", 
		Value = 1
	}, 
	[3582062749] = {
		Display = "1x Spin (Divine Wheel) DISCOUNT", 
		Identifier = "x1", 
		Type = "DivineWheelSpin", 
		Value = 1
	}, 
	[3582062921] = {
		Display = "3x Spins (Divine Wheel)", 
		Identifier = "x3", 
		Type = "DivineWheelSpin", 
		Value = 3
	}, 
	[3593047918] = {
		Display = "3x Spins (Cyber Wheel)", 
		Identifier = "x3", 
		Type = "CyberWheelSpin", 
		Value = 3
	}, 
	[3541032361] = {
		Display = "10x Spins (Divine Wheel)", 
		Identifier = "x10", 
		Type = "DivineWheelSpin", 
		Value = 10
	}, 
	[3570837655] = {
		Display = "2x Server Luck", 
		Type = "ServerLuck", 
		Index = 1
	}, 
	[3570837656] = {
		Display = "4x Server Luck", 
		Type = "ServerLuck", 
		Index = 2
	}, 
	[3570837657] = {
		Display = "8x Server Luck", 
		Type = "ServerLuck", 
		Index = 3
	}, 
	[1800564757] = {
		Display = "VIP", 
		Type = "GamepassProduct", 
		GiftProduct = 1785602558, 
		GiftProductNoRegional = 1800564757
	}, 
	[1800820512] = {
		Display = "Admin Commands", 
		Attribute = "AdminCommands", 
		Type = "GamepassProduct", 
		GiftProduct = 1784957853, 
		GiftProductNoRegional = 1800820512
	}, 
	[1801015136] = {
		Display = "2x Money", 
		Attribute = "2xMoney", 
		Type = "GamepassProduct", 
		GiftProduct = 1785073759, 
		GiftProductNoRegional = 1801015136
	}, 
	[3581995285] = {
		Display = "Cash Pack #1", 
		Type = "Coins", 
		Value = 3000, 
		GiftProduct = 3484554689, 
		GiftProductNoRegional = 3581995285
	}, 
	[3581996075] = {
		Display = "Cash Pack #2", 
		Type = "Coins", 
		Value = 25000, 
		GiftProduct = 3484554693, 
		GiftProductNoRegional = 3581996075
	}, 
	[3570837660] = {
		Display = "Cash Pack #3", 
		Type = "Coins", 
		Value = 100000, 
		GiftProduct = 3484554718, 
		GiftProductNoRegional = 3570837660
	}, 
	[3582052029] = {
		Display = "Cash Pack #4", 
		Type = "Coins", 
		Value = 500000, 
		GiftProduct = 3484554694, 
		GiftProductNoRegional = 3582052029
	}, 
	[3582053415] = {
		Display = "Cash Pack #5", 
		Type = "Coins", 
		Value = 1000000, 
		GiftProduct = 3484554719, 
		GiftProductNoRegional = 3582053415
	}, 
	[3570837666] = {
		Display = "Blackhole Slap", 
		Type = "Item", 
		Icon = "rbxassetid://88520285647604", 
		GiftProduct = 3484554727, 
		GiftProductNoRegional = 3570837666
	}, 
	[3570837669] = {
		Display = "Laser Gun", 
		Type = "Item", 
		Icon = "rbxassetid://127461267233201", 
		GiftProduct = 3484554707, 
		GiftProductNoRegional = 3570837669
	}, 
	--3610327634 (Meowl - Brainrot)
	[3610327634] = {
		Display = "Meowl", 
		Type = "Brainrot", 
		Value = "Meowl",
		GiftProduct = 3484554722, 
		GiftProductNoRegional = 3610327634
	},
	[3612055210] = {
		Display = "Ultime Lucky Block", 
		Type = "Brainrot", 
		Value = "Ultime Lucky Block"
	}, 
	[3442807551] = {
		Display = "Witch's Broom", 
		Type = "Item"
	}, 
	[3570837661] = {
		Display = "Ban Hammer", 
		Type = "Item", 
		Icon = "rbxassetid://113735454516185", 
		GiftProduct = 3484554720, 
		GiftProductNoRegional = 3570837661
	}, 
	[1800820512] = {
		Display = "Admin Commands", 
		Attribute = "AdminCommands", 
		Type = "Gamepass"
	}, 
	[1800564757] = {
		Display = "VIP", 
		Type = "Gamepass"
	}, 
	[1801015136] = {
		Display = "2x Money", 
		Attribute = "2xMoney", 
		Type = "Gamepass"
	}, 
	[3570837659] = {
		Display = "Starter Pack", 
		Type = "Pack", 
		Rewards = {
			Items = {
				"Blackhole Slap", 
				"Coil Combo"
			}, 
			Animals = {
				"Brr Brr Patapim"
			}, 
			Coins = 1000
		}, 
		GiftProduct = 3484554690, 
		GiftProductNoRegional = 3570837659
	}, 
	[3442292161] = {
		Display = "Halloween Pack", 
		Type = "Pack", 
		Rewards = {
			Items = {
				"Witch's Broom"
			}, 
			Animals = {
				"Spooky Lucky Block", 
				"Spooky Lucky Block", 
				"Spooky Lucky Block"
			}, 
			Coins = 0
		}
	}, 
	[3483721069] = {
		Display = "Santa's Sleigh", 
		Type = "Item", 
		Icon = "rbxassetid://106575011463424", 
		GiftProduct = 3484554698, 
		GiftProductNoRegional = 3484554726
	}, 
	[3481756179] = {
		Display = "Santa's Sleigh Pack", 
		Type = "Pack", 
		Icon = "rbxassetid://106575011463424", 
		Rewards = {
			Items = {
				"Santa's Sleigh"
			}, 
			Animals = {
				"Premium Festive Lucky Block", 
				"Premium Festive Lucky Block"
			}, 
			Coins = 0
		}, 
		GiftProduct = 3484576546, 
		GiftProductNoRegional = 3484576544
	}, 
	[3536298171] = {
		Display = "Cupid's Wings", 
		Type = "Item", 
		Icon = "rbxassetid://125592127726740", 
		GiftProduct = 3536298176, 
		GiftProductNoRegional = 3536298172
	}, 
	[3536298173] = {
		Display = "Cupid's Wings Pack", 
		Type = "Pack", 
		Icon = "rbxassetid://125592127726740", 
		Rewards = {
			Items = {
				"Cupid's Wings"
			}, 
			Animals = {
				"Premium Heart Lucky Block", 
				"Premium Heart Lucky Block"
			}, 
			Coins = 0
		}, 
		GiftProduct = 3536298177, 
		GiftProductNoRegional = 3536298175
	}, 
	[1898655285] = {
		Display = "Witch's Broom", 
		Type = "Item", 
		Icon = "rbxassetid://118466141203194"
	}, 
	[1909369625] = {
		Display = "Waverider", 
		Type = "Item", 
		Icon = "rbxassetid://125399512921257"
	}, 
	[3483709817] = {
		Display = "Gingerbread Base Pack", 
		Type = "Pack", 
		Icon = "rbxassetid://126481609231646", 
		Rewards = {
			Items = {}, 
			Animals = {
				"Premium Festive Lucky Block"
			}, 
			Base = {
				"Gingerbread"
			}, 
			Coins = 0
		}, 
		GiftProduct = 3484576542, 
		GiftProductNoRegional = 3484576545
	}, 
	[3483736285] = {
		Display = "Gingerbread Base", 
		Type = "Base", 
		Icon = "rbxassetid://126481609231646", 
		Value = "Gingerbread", 
		GiftProduct = 3484554704, 
		GiftProductNoRegional = 3484554692
	}, 
	[3531055926] = {
		Display = "Rose Base Pack", 
		Type = "Pack", 
		Icon = "rbxassetid://110395949945587", 
		Rewards = {
			Items = {}, 
			Animals = {
				"Premium Heart Lucky Block"
			}, 
			Base = {
				"Rose"
			}, 
			Coins = 0
		}, 
		GiftProduct = 3531055922, 
		GiftProductNoRegional = 3531055924
	}, 
	[3531055923] = {
		Display = "Rose Base", 
		Type = "Base", 
		Icon = "rbxassetid://110395949945587", 
		Value = "Rose", 
		GiftProduct = 3531055927, 
		GiftProductNoRegional = 3531055925
	}, 
	[3559685461] = {
		Display = "Pot of Gold Base Pack", 
		Type = "Pack", 
		Icon = "rbxassetid://90829604470739", 
		Rewards = {
			Items = {}, 
			Animals = {
				"Premium Leprechaun Lucky Block"
			}, 
			Base = {
				"Pot of Gold"
			}, 
			Coins = 0
		}, 
		GiftProduct = 3555794278, 
		GiftProductNoRegional = 3555794279
	}, 
	[3559685691] = {
		Display = "Pot of Gold Base", 
		Type = "Base", 
		Icon = "rbxassetid://90829604470739", 
		Value = "Pot of Gold", 
		GiftProduct = 3555794275, 
		GiftProductNoRegional = 3555794277
	}, 
	[1898907505] = { -- 🔴 REMPLACE PAR TON VRAI PRODUCT ID ROBUX (Teykx Base)
		Display = "Teykx Base", 
		Type = "Base", 
		Icon = "rbxassetid://0", 
		Value = "Teykx", 
	}, 
	[1904802290] = { -- 🔴 REMPLACE PAR TON VRAI PRODUCT ID ROBUX (Cursed Base)
		Display = "Cursed Base", 
		Type = "Base", 
		Icon = "rbxassetid://0", 
		Value = "Cursed", 
	}, 
	[1902438696] = { -- 🔴 REMPLACE PAR TON VRAI PRODUCT ID ROBUX (Divine Base)
		Display = "Divine Base", 
		Type = "Base", 
		Icon = "rbxassetid://0", 
		Value = "Divine", 
	}, 
	[1902492734] = { -- 🔴 REMPLACE PAR TON VRAI PRODUCT ID ROBUX (Galaxy Base)
		Display = "Galaxy Base", 
		Type = "Base", 
		Icon = "rbxassetid://0", 
		Value = "Galaxy", 
	}, 
	[1902804713] = { -- 🔴 REMPLACE PAR TON VRAI PRODUCT ID ROBUX (YinYang Base)
		Display = "YinYang Base", 
		Type = "Base", 
		Icon = "rbxassetid://0", 
		Value = "YinYang", 
	}, 
	[1902204734] = { -- 🔴 REMPLACE PAR TON VRAI PRODUCT ID ROBUX (Cyber Base)
		Display = "Cyber Base", 
		Type = "Base", 
		Icon = "rbxassetid://0", 
		Value = "Cyber", 
	}, 
	[1903632668] = { -- 🔴 REMPLACE PAR TON VRAI PRODUCT ID ROBUX (Candy Base)
		Display = "Candy Base", 
		Type = "Base", 
		Icon = "rbxassetid://0", 
		Value = "Candy", 
	}, 
	[1903650645] = { -- 🔴 REMPLACE PAR TON VRAI PRODUCT ID ROBUX (Lava Base)
		Display = "Lava Base", 
		Type = "Base", 
		Icon = "rbxassetid://0", 
		Value = "Lava", 
	}, 
	[1904082309] = { -- 🔴 REMPLACE PAR TON VRAI PRODUCT ID ROBUX (Radioactive Base)
		Display = "Radioactive Base", 
		Type = "Base", 
		Icon = "rbxassetid://0", 
		Value = "Radioactive", 
	}, 
	[1904700280] = { -- 🔴 REMPLACE PAR TON VRAI PRODUCT ID ROBUX (Gold Base)
		Display = "Gold Base", 
		Type = "Base", 
		Icon = "rbxassetid://0", 
		Value = "Gold", 
	}, 
	[1903506663] = { -- 🔴 REMPLACE PAR TON VRAI PRODUCT ID ROBUX (Diamond Base)
		Display = "Diamond Base", 
		Type = "Base", 
		Icon = "rbxassetid://0", 
		Value = "Diamond", 
	}, 
	[3570617107] = {
		Display = "Unlock Base", 
		Type = "UnlockBase"
	}, 
	[3570617401] = {
		Display = "Unlock First Floor", 
		Type = "UnlockBase"
	}, 
	[3570617707] = {
		Display = "Unlock Second Floor", 
		Type = "UnlockBase"
	}, 
	[3570618178] = {
		Display = "Unlock Third Floor", 
		Type = "UnlockBase"
	}, 
	[3570837667] = {
		Display = "Mythic Lucky Block", 
		Type = "LuckyBlock", 
		Value = "Mythic Lucky Block"
	}, 
	[3570837668] = {
		Display = "Brainrot God Lucky Block", 
		Type = "LuckyBlock", 
		Value = "Brainrot God Lucky Block"
	}, 
	[3609989221] = {
		Display = "Secret Lucky Block", 
		Type = "LuckyBlock", 
		Value = "Secret Lucky Block"
	}, 
	[3437062543] = {
		Display = "+3 Secret Lucky Block", 
		Type = "LuckyBlock", 
		Value = "Secret Lucky Block", 
		Amount = 3
	}, 
	[3437979356] = {
		Display = "+8 Secret Lucky Block", 
		Type = "LuckyBlock", 
		Value = "Secret Lucky Block", 
		Amount = 8
	}, 
	[3437989614] = {
		Display = "+1 Secret, Brainrot God, Mythic Lucky Block", 
		Type = "LuckyBlock", 
		Value = {
			"Secret Lucky Block", 
			"Brainrot God Lucky Block", 
			"Mythic Lucky Block"
		}
	}, 
	[3478819642] = {
		Display = "Premium Festive Lucky Block", 
		Type = "LuckyBlock", 
		Value = "Premium Festive Lucky Block"
	}, 
	[3478819641] = {
		Display = "+3 Premium Festive Lucky Block", 
		Type = "LuckyBlock", 
		Value = "Premium Festive Lucky Block", 
		Amount = 3
	}, 
	[3478819648] = {
		Display = "+10 Premium Festive Lucky Block", 
		Type = "LuckyBlock", 
		Value = "Premium Festive Lucky Block", 
		Amount = 10
	}, 
	[3531057541] = {
		Display = "Premium Heart Lucky Block", 
		Type = "LuckyBlock", 
		Value = "Premium Heart Lucky Block"
	}, 
	[3531057803] = {
		Display = "+3 Premium Heart Lucky Block", 
		Type = "LuckyBlock", 
		Value = "Premium Heart Lucky Block", 
		Amount = 3
	}, 
	[3531057804] = {
		Display = "+10 Premium Heart Lucky Block", 
		Type = "LuckyBlock", 
		Value = "Premium Heart Lucky Block", 
		Amount = 10
	}, 
	[3582055262] = {
		Display = "Premium Leprechaun Lucky Block", 
		Type = "LuckyBlock", 
		Value = "Premium Leprechaun Lucky Block"
	}, 
	[3559687278] = {
		Display = "+3 Premium Leprechaun Lucky Block", 
		Type = "LuckyBlock", 
		Value = "Premium Leprechaun Lucky Block", 
		Amount = 3
	}, 
	[3555794274] = {
		Display = "+10 Premium Leprechaun Lucky Block", 
		Type = "LuckyBlock", 
		Value = "Premium Leprechaun Lucky Block", 
		Amount = 10
	}, 
	[3450973929] = {
		Display = "Cupcake Koala", 
		Type = "MerchantBrainrot", 
		Value = "Cupcake Koala"
	}, 
	[3450973937] = {
		Display = "Doi Doi Do", 
		Type = "MerchantBrainrot", 
		Value = "Doi Doi Do"
	}, 
	[3450973935] = {
		Display = "Clickerino Crabo", 
		Type = "MerchantBrainrot", 
		Value = "Clickerino Crabo"
	}, 
	[3450973930] = {
		Display = "Stoppo Luminino", 
		Type = "MerchantBrainrot", 
		Value = "Stoppo Luminino"
	}, 
	[3450973932] = {
		Display = "Money Money Man", 
		Type = "MerchantBrainrot", 
		Value = "Money Money Man"
	}, 
	[3450973934] = {
		Display = "Noo La Polizia", 
		Type = "MerchantBrainrot", 
		Value = "Noo La Polizia"
	}, 
	[3450973933] = {
		Display = "Pirulitoita Bicicleteira", 
		Type = "MerchantBrainrot", 
		Value = "Pirulitoita Bicicleteira"
	}, 
	[3450973936] = {
		Display = "Los Puggies", 
		Type = "MerchantBrainrot", 
		Value = "Los Puggies"
	}, 
	[3582058537] = {
		Display = "Reveal Now", 
		Type = "FuseMachineRevealNow", 
		Callback = function(v7) --[[ Line: 804 ]] --[[ Name: Callback ]]
			local l_ServerScriptService_0 = game:GetService("ServerScriptService");
			return require(l_ServerScriptService_0.Services.FuseMachineService):PurchaseRevealNow(v7);
		end, 
		GiftProduct = 3484554699, 
		GiftProductNoRegional = 3484554702
	}, 
	[3483927303] = {
		Display = "Fuse Machine Luck", 
		Type = "FuseMachineLuck", 
		Callback = function(_) --[[ Line: 816 ]] --[[ Name: Callback ]]
			local l_ServerScriptService_1 = game:GetService("ServerScriptService");
			return require(l_ServerScriptService_1.Services.FuseMachineService):AddLuck();
		end
	}, 
	[3394964472] = {
		Display = "Craft Now - Epic", 
		Type = "CraftingMachineClaimNow", 
		Callback = function(v11) --[[ Line: 827 ]] --[[ Name: Callback ]]
			local l_ServerScriptService_2 = game:GetService("ServerScriptService");
			return require(l_ServerScriptService_2.Services.CraftingMachineService):PurchaseCraftNow(v11, "Epic");
		end
	}, 
	[3394964604] = {
		Display = "Craft Now - Legendary", 
		Type = "CraftingMachineClaimNow", 
		Callback = function(v13) --[[ Line: 836 ]] --[[ Name: Callback ]]
			local l_ServerScriptService_3 = game:GetService("ServerScriptService");
			return require(l_ServerScriptService_3.Services.CraftingMachineService):PurchaseCraftNow(v13, "Legendary");
		end
	}, 
	[3394964736] = {
		Display = "Craft Now - Mythic", 
		Type = "CraftingMachineClaimNow", 
		Callback = function(v15) --[[ Line: 845 ]] --[[ Name: Callback ]]
			local l_ServerScriptService_4 = game:GetService("ServerScriptService");
			return require(l_ServerScriptService_4.Services.CraftingMachineService):PurchaseCraftNow(v15, "Mythic");
		end
	}, 
	[3394965881] = {
		Display = "Craft Now - Brainrot God", 
		Type = "CraftingMachineClaimNow", 
		Callback = function(v17) --[[ Line: 854 ]] --[[ Name: Callback ]]
			local l_ServerScriptService_5 = game:GetService("ServerScriptService");
			return require(l_ServerScriptService_5.Services.CraftingMachineService):PurchaseCraftNow(v17, "Brainrot God");
		end
	}, 
	[3394969112] = {
		Display = "Craft Now - Secret", 
		Type = "CraftingMachineClaimNow", 
		Callback = function(v19) --[[ Line: 863 ]] --[[ Name: Callback ]]
			local l_ServerScriptService_6 = game:GetService("ServerScriptService");
			return require(l_ServerScriptService_6.Services.CraftingMachineService):PurchaseCraftNow(v19, "Secret");
		end
	}, 
	[3532165598] = {
		Display = "Skip Cupid's Machine", 
		Type = "CupidsMachineSkip", 
		Callback = function(v21) --[[ Line: 874 ]] --[[ Name: Callback ]]
			local l_ServerScriptService_7 = game:GetService("ServerScriptService");
			return require(l_ServerScriptService_7.Services.CupidsMachineService):PurchaseSkip(v21);
		end
	}, 
	[3467217692] = {
		Display = "Recover [1]", 
		Type = "AdventCalendarRecover", 
		Callback = function(v23) --[[ Line: 885 ]] --[[ Name: Callback ]]
			local l_ServerScriptService_8 = game:GetService("ServerScriptService");
			return (require(l_ServerScriptService_8.Services.AdventService):Recover(v23));
		end
	}, 
	[3467217695] = {
		Display = "Recover [2]", 
		Type = "AdventCalendarRecover", 
		Callback = function(v25) --[[ Line: 895 ]] --[[ Name: Callback ]]
			local l_ServerScriptService_9 = game:GetService("ServerScriptService");
			return (require(l_ServerScriptService_9.Services.AdventService):Recover(v25));
		end
	}, 
	[3467217689] = {
		Display = "Recover [3]", 
		Type = "AdventCalendarRecover", 
		Callback = function(v27) --[[ Line: 905 ]] --[[ Name: Callback ]]
			local l_ServerScriptService_10 = game:GetService("ServerScriptService");
			return (require(l_ServerScriptService_10.Services.AdventService):Recover(v27));
		end
	}, 
	[3467217690] = {
		Display = "Recover [4]", 
		Type = "AdventCalendarRecover", 
		Callback = function(v29) --[[ Line: 915 ]] --[[ Name: Callback ]]
			local l_ServerScriptService_11 = game:GetService("ServerScriptService");
			return (require(l_ServerScriptService_11.Services.AdventService):Recover(v29));
		end
	}, 
	[3467217694] = {
		Display = "Recover [5]", 
		Type = "AdventCalendarRecover", 
		Callback = function(v31) --[[ Line: 925 ]] --[[ Name: Callback ]]
			local l_ServerScriptService_12 = game:GetService("ServerScriptService");
			return (require(l_ServerScriptService_12.Services.AdventService):Recover(v31));
		end
	}, 
	[3467217691] = {
		Display = "Recover [6]", 
		Type = "AdventCalendarRecover", 
		Callback = function(v33) --[[ Line: 935 ]] --[[ Name: Callback ]]
			local l_ServerScriptService_13 = game:GetService("ServerScriptService");
			return (require(l_ServerScriptService_13.Services.AdventService):Recover(v33));
		end
	}, 
	[3467217693] = {
		Display = "Recover [7]", 
		Type = "AdventCalendarRecover", 
		Callback = function(v35) --[[ Line: 945 ]] --[[ Name: Callback ]]
			local l_ServerScriptService_14 = game:GetService("ServerScriptService");
			return (require(l_ServerScriptService_14.Services.AdventService):Recover(v35));
		end
	}, 
	[3477983793] = {
		Display = "Festive 67", 
		Type = "MerchShopItem", 
		Callback = function(v37) --[[ Line: 957 ]] --[[ Name: Callback ]]
			local l_ServerScriptService_15 = game:GetService("ServerScriptService");
			return (require(l_ServerScriptService_15.Services.MerchShopService):AwardItem(v37, "Festive 67"));
		end
	}, 
	[3487835433] = {
		Display = "Los Jolly Combinasionas", 
		Type = "SantaMerchantBrainrot", 
		Value = "Los Jolly Combinasionas"
	}, 
	[3487835436] = {
		Display = "Money Money Reindeer", 
		Type = "SantaMerchantBrainrot", 
		Value = "Money Money Reindeer"
	}, 
	[3487835435] = {
		Display = "Jolly Jolly Sahur", 
		Type = "SantaMerchantBrainrot", 
		Value = "Jolly Jolly Sahur"
	}, 
	[3487835440] = {
		Display = "Ginger Gerat", 
		Type = "SantaMerchantBrainrot", 
		Value = "Ginger Gerat"
	}, 
	[3520721003] = {
		Display = "+1 Speed Upgrade", 
		Type = "TsunamiSpeedUpgrade", 
		Callback = function(v39) --[[ Line: 992 ]] --[[ Name: Callback ]]
			local l_ServerScriptService_16 = game:GetService("ServerScriptService");
			return require(l_ServerScriptService_16.Services.TsunamiEventService):IncreaseUpgrade(v39, 1);
		end
	}, 
	[3520721003] = {
		Display = "+1 Speed", 
		Type = "TsunamiSpeedUpgrade", 
		Callback = function(v41) --[[ Line: 1002 ]] --[[ Name: Callback ]]
			local l_ServerScriptService_17 = game:GetService("ServerScriptService");
			return require(l_ServerScriptService_17.Services.TsunamiEventService):IncreaseUpgrade(v41, 1);
		end
	}, 
	[3520721005] = {
		Display = "+5 Speed", 
		Type = "TsunamiSpeedUpgrade", 
		Callback = function(v43) --[[ Line: 1012 ]] --[[ Name: Callback ]]
			local l_ServerScriptService_18 = game:GetService("ServerScriptService");
			return require(l_ServerScriptService_18.Services.TsunamiEventService):IncreaseUpgrade(v43, 5);
		end
	}, 
	[3520721004] = {
		Display = "+10 Speed", 
		Type = "TsunamiSpeedUpgrade", 
		Callback = function(v45) --[[ Line: 1022 ]] --[[ Name: Callback ]]
			local l_ServerScriptService_19 = game:GetService("ServerScriptService");
			return require(l_ServerScriptService_19.Services.TsunamiEventService):IncreaseUpgrade(v45, 10);
		end
	}
};
for v48, v49 in v4.Products do
	v47[v49.discountedProductId] = {
		Display = ("[20%% OFF] %*"):format(v47[v48].Display), 
		Type = "ValentinesGift", 
		NoGift = true, 
		Callback = function(v50, v51) --[[ Line: 1035 ]] --[[ Name: Callback ]]
			local l_ServerScriptService_20 = game:GetService("ServerScriptService");
			return require(l_ServerScriptService_20.Services.ValentinesShopService):ProcessGiftPurchase(v50, v51);
		end
	};
end;
v47[3612068332] = {
	Display = "Admin Panel",
	Type = "Item"
};
v47[3612068469] = {
	Display = "Witch's Broom",
	Type = "Item"
};
return v47;