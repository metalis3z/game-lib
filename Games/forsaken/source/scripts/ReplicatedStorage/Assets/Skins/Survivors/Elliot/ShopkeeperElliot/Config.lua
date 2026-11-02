-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2025-12-17 06:48:14
-- Luau version 6, Types version 3
-- Time taken: 0.002633 seconds

return {
	DisplayName = "Shopkeeper";
	Description = "The characters are starting to pile up, aren't they?";
	RenderImage = "rbxassetid://133934807253863";
	Price = 900;
	Expressions = {
		Happy = "rbxassetid://129372483513283";
		SlightlyHappy = "rbxassetid://113374365949955";
		Default = "rbxassetid://77357871251053";
		Hurt = "rbxassetid://83498397189774";
		Injured = "rbxassetid://107840502244970";
		Dead = "rbxassetid://90972972267469";
		Drinking = "rbxassetid://139227986395923";
	};
	Sounds = {
		PizzaEaten = "rbxassetid://100461592771108";
		PizzaThrown = "rbxassetid://91500604053592";
		RushHourStart = "rbxassetid://99658188707737";
	};
	TextInteractions = {
		Requests = {
			ElliotPizza = {"\xC7a sent bigrement bon dans le coin, puis-je avoir une bouch\xE9e?", "Entre camarades marchant, on s'entreaide, non?", "La pizza est un \xE9l\xE9ment, le plus important des \xE9l\xE9ments. En auriez-vous?"};
			BuildermanSentry = {"Nous aurions grandement besoin d'une sentinelle par ces parages.", "Pas pour vous alarmer, mais nous ferions mieux surveiller ce coin.", "Une sentinelle l\xE0 ou je me tient ne serais pas de refus, mon ami.", "Pourriez-vous placer une tourelle ici? \xC0 bon chat, bon rat comme on dit."};
			BuildermanDispenser = {"\xC7a me ressemble pas de demander de faveurs, mais un distributeur me serais d'une grande aide.", "Un peu d'aide, pla\xEEt-il? Consid\xE9rez \xE7a comme du donnant-donnant, mon ami.", "Le joueur ne veut pas stresser a devoir survivre avec si peu de vie, \xE7a serais b\xEAte de nous nier de l'aide.", "Je pourrais user de votre savoir-faire, ma barre de vie n'est pas particuli\xE8rement rempli \xE0 ras bord."};
			DusekkarForceField = {"J'ai ou\xEF dire que le danger rode, un petit coup de baguette magique?", "Je suis m\xEAme pr\xEAt a payer le prix de votre pr\xE9cieuse aide si il le faut.", "Ne pas finir autant que revenant ectoplasmique me ferais un bien fou.", "J'appr\xE9cie \xE9norm\xE9ment vos gouts en mati\xE8res de masques, pourrions nous peut-\xEAtre venir a un arrangement?"};
			Thanks = {"Vous ne le regretterais pas!", "Grand merci, et sinon \xE7a vas?", "Au moins \xE7a vous feras de l'EXP en plus.", "Merci, cher t\xE9m\xE9raire complice!", "Je vous pairas en retour bien entendu!", "Et \xE7a serais encore mieux si vous d\xE9pensiez les cr\xE9dits que vous venez de gagner. "};
		};
	};
}