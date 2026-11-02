-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:18:34
-- Luau version 6, Types version 3
-- Time taken: 0.005142 seconds

return {
	Dog = {
		multiplier = 1.2;
		rarity = "Common";
		images = {"rbxassetid://135001511032708", "rbxassetid://82137322846433", "rbxassetid://133443437896760"};
	};
	Cat = {
		multiplier = 1.5;
		rarity = "Uncommon";
		images = {"rbxassetid://95604538597367", "rbxassetid://99783753488808", "rbxassetid://110679932557594"};
	};
	Bunny = {
		multiplier = 2;
		rarity = "Rare";
		images = {"rbxassetid://125087872229425", "rbxassetid://85039216115751", "rbxassetid://70379768163817"};
	};
	Bear = {
		multiplier = 3;
		rarity = "Common";
		images = {"rbxassetid://137975671245248", "rbxassetid://87077998880539", "rbxassetid://117153147947248"};
	};
	Wolf = {
		multiplier = 4.5;
		rarity = "Uncommon";
		images = {"rbxassetid://103219768270826", "rbxassetid://93932040865040", "rbxassetid://97198622755649"};
	};
	Fox = {
		multiplier = 7;
		rarity = "Rare";
		images = {"rbxassetid://140644200539089", "rbxassetid://122003037795005", "rbxassetid://111001160817498"};
	};
	["Forest Dragon"] = {
		multiplier = 15;
		rarity = "Epic";
		images = {"rbxassetid://132504317414618", "rbxassetid://120853354141223", "rbxassetid://72428422294481"};
		fly = true;
		luck = true;
	};
	Pig = {
		multiplier = 12;
		rarity = "Common";
		images = {"rbxassetid://87343725799367", "rbxassetid://123051282048728", "rbxassetid://135284116630424"};
	};
	Duck = {
		multiplier = 17;
		rarity = "Uncommon";
		images = {"rbxassetid://75195339752217", "rbxassetid://113290422598717", "rbxassetid://70685149427596"};
	};
	Cow = {
		multiplier = 25;
		rarity = "Rare";
		images = {"rbxassetid://101554057872884", "rbxassetid://79460619836789", "rbxassetid://91843942824610"};
	};
	Goat = {
		multiplier = 32;
		rarity = "Epic";
		images = {"rbxassetid://72447838777644", "rbxassetid://91495773801829", "rbxassetid://116471466906948"};
		luck = true;
	};
	["Apple Dragon"] = {
		multiplier = 75;
		rarity = "Legendary";
		images = {"rbxassetid://117520299767348", "rbxassetid://139634425373957", "rbxassetid://111468720810185"};
		luck = true;
		fly = true;
	};
	Lion = {
		multiplier = 30;
		rarity = "Common";
		images = {"rbxassetid://78326300728573", "rbxassetid://108964821280742", "rbxassetid://94980666240799"};
	};
	["Desert Fox"] = {
		multiplier = 36;
		rarity = "Uncommon";
		images = {"rbxassetid://75731096481916", "rbxassetid://115011670657514", "rbxassetid://138000397675947"};
	};
	Elephant = {
		multiplier = 48;
		rarity = "Rare";
		images = {"rbxassetid://90259797604595", "rbxassetid://90634049336937", "rbxassetid://93576616328352"};
	};
	Eagle = {
		multiplier = 64;
		rarity = "Epic";
		images = {"rbxassetid://81224839015381", "rbxassetid://99089825565756", "rbxassetid://73295680882018"};
		luck = true;
	};
	["Sand Of Time"] = {
		multiplier = 250;
		rarity = "Legendary";
		images = {"rbxassetid://101033793141427", "rbxassetid://78252559941754", "rbxassetid://87934153328706"};
		luck = true;
		fly = true;
	};
	["Desert Prophecy"] = {
		multiplier = 1000;
		rarity = "Mythical";
		images = {"rbxassetid://123173959485237", "rbxassetid://134930047917157", "rbxassetid://136106218786711"};
		luck = true;
		fly = true;
	};
	["Nuclear Golem"] = {
		multiplier = 70;
		rarity = "Common";
		images = {"rbxassetid://75868348243770", "rbxassetid://82015971814105", "rbxassetid://126132436608194"};
	};
	["Nuclear Cow"] = {
		multiplier = 90;
		rarity = "Uncommon";
		images = {"rbxassetid://77039360673901", "rbxassetid://73119588118626", "rbxassetid://101691925531180"};
	};
	["Nuclear Hydra"] = {
		multiplier = 120;
		rarity = "Rare";
		images = {"rbxassetid://87244617894129", "rbxassetid://87387290953980", "rbxassetid://90543031430302"};
		fly = true;
	};
	["Hazmat Demon"] = {
		multiplier = 200;
		rarity = "Epic";
		images = {"rbxassetid://110299392624481", "rbxassetid://99683035760506", "rbxassetid://119520558672978"};
		luck = true;
	};
	Abomination = {
		multiplier = 750;
		rarity = "Legendary";
		images = {"rbxassetid://110904890069080", "rbxassetid://98380381269491", "rbxassetid://77762399850306"};
		luck = true;
		fly = true;
	};
	["Nuclear Beast"] = {
		multiplier = 2500;
		rarity = "Mythical";
		images = {"rbxassetid://118237214545309", "rbxassetid://91636978080543", "rbxassetid://96213795637430"};
		luck = true;
	};
	Fish = {
		multiplier = 250;
		rarity = "Uncommon";
		images = {"rbxassetid://116098498126368", "rbxassetid://107498799428019", "rbxassetid://75724669456420"};
	};
	Crab = {
		multiplier = 350;
		rarity = "Rare";
		images = {"rbxassetid://102342114335488", "rbxassetid://116470234977877", "rbxassetid://113288183042647"};
	};
	Octopus = {
		multiplier = 500;
		rarity = "Epic";
		images = {"rbxassetid://114640837472585", "rbxassetid://112047970362298", "rbxassetid://102029096942341"};
		fly = true;
	};
	["Atlantean Guardian"] = {
		multiplier = 1800;
		rarity = "Legendary";
		images = {"rbxassetid://117681832272129", "rbxassetid://111647206163694", "rbxassetid://99009731756777"};
		luck = true;
		fly = true;
	};
	["Pearl Maiden"] = {
		multiplier = 7000;
		rarity = "Mythical";
		images = {"rbxassetid://118642002506426", "rbxassetid://108675588174305", "rbxassetid://79500211296309"};
		luck = true;
		fly = true;
	};
	Cthulhu = {
		multiplier = 25000;
		rarity = "Eternal";
		images = {"rbxassetid://82160438239464", "rbxassetid://138324662148539", "rbxassetid://111679520612032"};
		luck = true;
		fly = true;
		size = "big";
	};
	["Royal Panda"] = {
		multiplier = 700;
		rarity = "Uncommon";
		images = {"rbxassetid://100235548559090", "rbxassetid://90023939581701", "rbxassetid://105504970030289"};
	};
	["Royal Dog"] = {
		multiplier = 850;
		rarity = "Rare";
		images = {"rbxassetid://76006746294401", "rbxassetid://132580244257488", "rbxassetid://83215850521158"};
	};
	["Royal Cat"] = {
		multiplier = 1200;
		rarity = "Epic";
		images = {"rbxassetid://72805500080193", "rbxassetid://125797707858214", "rbxassetid://138178265746438"};
	};
	["The Fool"] = {
		multiplier = 5000;
		rarity = "Legendary";
		images = {"rbxassetid://112021195021103", "rbxassetid://95625167965754", "rbxassetid://110684699567102"};
		luck = true;
		fly = true;
	};
	["Dragon Queen"] = {
		multiplier = 22000;
		rarity = "Mythical";
		images = {"rbxassetid://123852850760311", "rbxassetid://77092317299073", "rbxassetid://96900103064443"};
		luck = true;
		fly = true;
	};
	["Dragon King"] = {
		multiplier = 75000;
		rarity = "Eternal";
		images = {"rbxassetid://89214923790783", "rbxassetid://137347336267362", "rbxassetid://125350870152555"};
		luck = true;
		fly = true;
		size = "big";
	};
	["Skate Cat"] = {
		multiplier = 1700;
		rarity = "Uncommon";
		images = {"rbxassetid://80576770488374", "rbxassetid://125479284144719", "rbxassetid://112599586379476"};
	};
	["Police Wolf"] = {
		multiplier = 2400;
		rarity = "Rare";
		images = {"rbxassetid://111396867946069", "rbxassetid://105205827973014", "rbxassetid://128742525773884"};
	};
	Hacker = {
		multiplier = 3000;
		rarity = "Epic";
		images = {"rbxassetid://113241637173380", "rbxassetid://127400615344134", "rbxassetid://99421470262680"};
		fly = true;
	};
	["Skyscraper Stack"] = {
		multiplier = 15000;
		rarity = "Legendary";
		images = {"rbxassetid://124646302627325", "rbxassetid://88286150681953", "rbxassetid://133753090094141"};
		luck = true;
	};
	["Ox of Justice"] = {
		multiplier = 50000;
		rarity = "Mythical";
		images = {"rbxassetid://94961039737613", "rbxassetid://86821564487521", "rbxassetid://108844056795120"};
		luck = true;
		fly = true;
	};
	["The Broadcasting"] = {
		multiplier = 200000;
		rarity = "Eternal";
		images = {"rbxassetid://130290743354528", "rbxassetid://119257036678445", "rbxassetid://121013921304111"};
		luck = true;
		fly = true;
		size = "big";
	};
	["The Admin"] = {
		multiplier = 1500000;
		rarity = "Secret";
		images = {"rbxassetid://103808417429432", "rbxassetid://131161098581596", "rbxassetid://102667927387105"};
		luck = true;
		fly = true;
		size = "big";
		webhook = true;
		globalMessage = true;
	};
	["Storm Wisp"] = {
		multiplier = 1500;
		rarity = "Exclusive";
		images = {"rbxassetid://90586950593794", "rbxassetid://97429803074112", "rbxassetid://110631316822649"};
		fly = true;
		isPaid = true;
	};
	["Storm Ghoul"] = {
		multiplier = 2000;
		rarity = "Exclusive";
		images = {"rbxassetid://91921280240706", "rbxassetid://71400389386416", "rbxassetid://99247319308901"};
		fly = true;
		isPaid = true;
	};
	["Storm Striker"] = {
		multiplier = 3000;
		rarity = "Exclusive";
		images = {"rbxassetid://108976792041442", "rbxassetid://122293196359645", "rbxassetid://99161280199935"};
		fly = true;
		isPaid = true;
	};
	["Thunder Fury"] = {
		multiplier = 50000;
		rarity = "Supreme";
		images = {"rbxassetid://114808799118072", "rbxassetid://79959021098178", "rbxassetid://138045275652520"};
		fly = true;
		size = "big";
		special = 1;
		globalMessage = true;
		webhook = true;
		desc = "Multiplier is %s%% of the average stats of your top 10 pets!";
		isPaid = true;
	};
	["Tempest Lord"] = {
		multiplier = 500000;
		rarity = "Ultimate";
		images = {"rbxassetid://82054922688874", "rbxassetid://98681282571993", "rbxassetid://73422779780765"};
		fly = true;
		size = "huge";
		globalMessage = true;
		webhook = true;
		special = 4;
		desc = "Multiplier is %s%% of the average stats of your top 10 pets!";
		isPaid = true;
	};
	Tutel = {
		multiplier = 111;
		rarity = "Exclusive";
		images = {"rbxassetid://74685805545623", "rbxassetid://121115163093898", "rbxassetid://129675851656236"};
	};
	["Rebirth Dragon"] = {
		multiplier = 50;
		rarity = "Exclusive";
		images = {"rbxassetid://71730413185334", "rbxassetid://135009140699104", "rbxassetid://116323912115849"};
		fly = true;
	};
	["Fire Dominus"] = {
		multiplier = 250;
		rarity = "Exclusive";
		images = {"rbxassetid://137102856103761", "rbxassetid://123172750807155", "rbxassetid://72048424267110"};
		fly = true;
	};
	["Magic Shard"] = {
		multiplier = 1250;
		rarity = "Exclusive";
		images = {"rbxassetid://110743052360424", "rbxassetid://127205296671429", "rbxassetid://81406068166343"};
		fly = true;
	};
	["Rebirth Phoenix"] = {
		multiplier = 105;
		rarity = "Supreme";
		images = {"rbxassetid://136664812070097", "", ""};
		fly = true;
		size = "big";
		special = 1;
		desc = "Multiplier is %s%% of the average stats of your top 10 pets!";
		untradeable = true;
		temporary = true;
	};
	["Rebirth Hydra"] = {
		multiplier = 105;
		rarity = "Supreme";
		images = {"rbxassetid://102204676311870", "rbxassetid://122791001354313", ""};
		fly = true;
		size = "big";
		special = 1.5;
		desc = "Multiplier is %s%% of the average stats of your top 10 pets!";
		untradeable = true;
		temporary = true;
	};
	["Rebirth Trophy"] = {
		multiplier = 105;
		rarity = "Ultimate";
		images = {"rbxassetid://110457144652175", "", ""};
		fly = true;
		size = "huge";
		special = 5;
		desc = "Multiplier is %s%% of the average stats of your top 10 pets!";
		untradeable = true;
		temporary = true;
	};
}