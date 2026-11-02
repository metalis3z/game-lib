-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-17 06:50:47
-- Luau version 6, Types version 3
-- Time taken: 0.003122 seconds

return {
	DisplayName = "Stalkalek";
	Description = "Can't flee from her for much longer.";
	RenderImage = "rbxassetid://115146611163944";
	Price = 1100;
	SentryTemplate = script.Sentry;
	DispenserTemplate = script.Dispenser;
	Animations = {
		ConstructStart = "rbxassetid://96106870769937";
		ConstructLoop = "rbxassetid://106224771809337";
		ConstructEnd = "rbxassetid://86855569435170";
	};
	DispenserAnimations = {
		Construction = "rbxassetid://73092511364877";
		Idle = "rbxassetid://86355093619201";
	};
	Expressions = {
		Happy = "rbxassetid://113633464795030";
		Concentrating = "rbxassetid://138477260882187";
		Default = "rbxassetid://79765929651890";
		Hurt = "rbxassetid://78758141300061";
		Injured = "rbxassetid://132843468057375";
		Dead = "rbxassetid://87455550865738";
		Drinking = "rbxassetid://95006804567428";
	};
	TextInteractions = {
		Requests = {
			ElliotPizza = {"Need it. I want it. I can't stop thinking about PIZZA!", "Pizza delivery to a Stalkalek, please!", "I'm hungry for some pizza!"};
			BuildermanSentry = {"Got a spare sentry? I won't mess it up!", "We need more automated chaos!", "Can we pleeease get a sentry here?", "Requesting a turret for defensive purposes!", "Go-Go sentry here, please!"};
			StalkalekBuildermanSentry = {"Oh hi me! Got a sentry?", "Can we get a sentry? We know we want it!", "Gimme a sentry my awesome self!", "I'm humbly asking myself for a sentry (do it)!", "Get me a sentry! Wait, is that me!?"};
			BuildermanDispenser = {"Be a hero and deploy a dispenser!", "Would love to get a dispenser here!", "Build a dispenser! I'm too close to being responsible for my survival.", "Would love to get some ammo and snacks from a dispenser.", "DISPENSEEEEEEEEER please :]"};
			StalkalekBuildermanDispenser = {"I'd ask Builderman for a dispenser, but its better if you do it, my other self!", "Hello me! Could use a dispenser.", "We both know we need ourselves a dispenser!", "Place a dispenser, me! We need more MATERIALS."};
			DusekkarProtection = {"Grant me your spawn safety!", "I'm gonna need some protection here!", "I need a shield! I don't wanna die again!"};
			HemmorhageAsk = {"I’m bleeding, I need help here!", "Heal me please!", "I need treatment! I'm bleeding alot here! :["};
		};
		Thanks = {
			Regular = {"And the name is Alek… Stalkalek.", "Thanks for the help! :]", "Very much appreciated!", "I won’t let you all down, trust me."};
		};
	};
}