-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-17 06:52:14
-- Luau version 6, Types version 3
-- Time taken: 0.001913 seconds

return {
	DisplayName = "Combat Wizard";
	Description = "An uncommon but elite group who are practitioners of magic, fielding in every part of study regarding it.";
	RenderImage = "rbxassetid://113284076545529";
	Price = 1500;
	CollabInfo = "CombatInitiation";
	VFXTemplate = script.VFX;
	PlasmaBeamColor1 = Color3.fromRGB(255, 255, 0);
	PlasmaBeamColor2 = Color3.fromRGB(255, 255, 0);
	Voicelines = {
		Died = {"rbxassetid://172613272"};
	};
	Sounds = {
		SpawnProtectionActivate = "rbxassetid://10209268";
		SpawnProtectionLoop = "rbxassetid://5272402531";
		SpawnProtectionShieldBreak = {
			Volume = 0.1;
			"rbxassetid://3727463344"
		};
	};
	Expressions = {
		Happy = "rbxassetid://84627315080756";
		Default = "rbxassetid://91588663834343";
		Hurt = "rbxassetid://83540224151209";
		Injured = "rbxassetid://90031317199581";
		Dead = "rbxassetid://138735634063459";
		Drinking = "rbxassetid://139098226549474";
	};
}