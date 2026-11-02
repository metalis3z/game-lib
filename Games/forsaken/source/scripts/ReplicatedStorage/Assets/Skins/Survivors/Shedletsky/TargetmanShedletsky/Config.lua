-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-17 06:45:16
-- Luau version 6, Types version 3
-- Time taken: 0.003757 seconds

return {
	DisplayName = "Targetman";
	Description = "You're no fun.";
	RenderImage = "rbxassetid://93639588977930";
	Price = 1250;
	CollabInfo = "Doomed2Die";
	Expressions = {
		Happy = "rbxassetid://96531744529259";
		Default = "rbxassetid://139245665743955";
		Hurt = "rbxassetid://77905042045077";
		Injured = "rbxassetid://129913059622259";
		Dead = "rbxassetid://129006653115391";
		Drinking = "rbxassetid://119430361163645";
		StunnedKiller = "rbxassetid://116097757350462";
		EatStart = "rbxassetid://96531744529259";
		Eating = "rbxassetid://116097757350462";
	};
	Animations = {
		Slash = "rbxassetid://119462383658044";
		EatChicken = "rbxassetid://107074146593306";
	};
	Sounds = {
		Unsheath = "rbxassetid://83851356262523";
		Slash = "rbxassetid://127324570265084";
		Hit = "rbxassetid://117042542745218";
	};
	Voicelines = {
		Injured = {"rbxassetid://108274975519678", "rbxassetid://102575375831606"};
		Died = "rbxassetid://108986515110688";
		SlashHit = {"rbxassetid://84604142462465", "rbxassetid://107461513637257", "rbxassetid://125710567799059"};
		FriedChickenYum = "rbxassetid://92646660532696";
	};
	TextInteractions = {
		Requests = {
			ElliotPizza = {"I’m hurt, I’m injured!", "It’s not a medkit, but I’ll take it!", "Throw me a pizza! Something! ANYTHING!", "Gimme two slices! One for me, and one for my cymbal monkey, please!", "Gosh, I don’t feel so good... I’m seein’ black and blue and.. Violet? That’s a new one"};
			MedicElliotPizza = {"MEDIC! THROW ME A MEDKIT! I NEED IT!!", "Medic… they got me…", "DOC! C’MON, MAN!", "IT’S IN MY EYES, DOC! IT’S IN MY EYES!!!", "MAKE IT STOP, DOC! MAKE IT STOP!"};
			BuildermanSentry = {"Wish I had my Deagle with me, but your sentry can still work!", "You know, a sentry would be pretty friggin’ cool right here.", "Look, I don’t care HOW it works, just place a sentry down so we can stay safe!", "PLEASE! A SENTRY HERE!", "Is that Technician’s turret? I swear, it looks just like it…"};
			TechnicianBuildermanSentry = {"Blah blah blah,” just get a sentry here already, dudette.", "You have GOT to teach me how to build a sentry sometime!", "Why can’t you just give me the wrench? I’d make a great sentry… probably.", "Your sentry and my cymbal monkey; NOTHING can stop us!", "We need something to stop this horde, Technic!"};
			BuildermanDispenser = {"I would LOVE a dispenser here!", "You, dispenser! Here, now!", "You gotta build a dispenser here, bud!", "I need a dispenser, and I need it NOW!", "Dispenser! Please!"};
			TechnicianBuildermanDispenser = {"I’ve got your back, bud!", "Um… you never showed me something like this before, Tech-y…", "This works awfully familiar to Medic’s little gadget…", "If you build this, I’ll give you all of my Vitas for the next week, got it?", "No, take your time! It’s not like I’m HURT or anything. No, no—that would be CRAZY, right?!"};
			DusekkarForceField = {"Zap me!", "Could you give me a shield just like Juggernaut’s?", "Be a magical mage and magic me!", "WIZARD PERSON! SHIELD ME, AND MY LIFE IS YOURS!"};
			Thanks = {"Thank you, bud!", "I might have been a bit rude earlier, but thank you. Seriously.", "Thank you, thank you!", "Just for that, I will name one of my cymbal monkeys after you.", "I owe you a LOT after this!", "Thanks a million!"};
		};
	};
}