-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-17 06:51:33
-- Luau version 6, Types version 3
-- Time taken: 0.002405 seconds

return {
	DisplayName = "LOVESHOT!";
	Description = "\"Duse Duse Kyun!\"";
	RenderImage = "rbxassetid://124805292578223";
	Price = 1000;
	PlasmaBeamColor1 = Color3.fromRGB(235, 176, 255);
	PlasmaBeamColor2 = Color3.fromRGB(239, 189, 255);
	VFXTemplate = script.VFX;
	SpawnProtectionRadiusTemplate = script.MouseRadius;
	SpawnProtectionIndicatorTemplate = script.Indicator;
	Sounds = {
		SpawnProtectionActivate = "rbxassetid://129029554388212";
		SpawnProtectionLoop = "rbxassetid://112817390462957";
		SpawnProtectionShieldBreak = "rbxassetid://74107940047586";
		PlasmaBeamShoot = "rbxassetid://73124945436787";
	};
	TextInteractions = {
		Requests = {
			ElliotPizza = {"If my pain can be a cure for peace, I don’t mind!", "So what if I might shed a tear, get some bruises?", "A pizza is all I need to clean a cherry blush away, ha!", "Whatever it may cost, there’s no reason to stop!"};
			BuildermanSentry = {"And now, it’s time for the moment you’ve been waiting for!", "Combat ‘till the dawn until every villain’s gone, yeah!", "Monsters might be a scary foe to fight! But we'll take the stand!", "We can take the pain, fight all day, fill up the syringe!"};
			BuildermanDispenser = {"My job’s not all rainbows…", "All alone it's so hard for me to get through the rain…", "Bearing through the pain, I'll try to be brave!", "It can all be so hard for me to get through the day…"};
			DusekkarProtection = {"It’s time to open up your eyes and start the day!", "Shout a magic word and set the world in place!", "One, two, three, ready?!", "Keep going!", "With love, heal up the world and go again!"};
		};
		Thanks = {
			Regular = {"If you need me to heal, go out and call my name!", "I'll bonk away what puts you down, a pink hammer melee! Yeah!", "Your smile is enough to make my day!", "I'm not gonna bend! Ha!", "Your smile is enough to heal my aches!"};
		};
	};
}