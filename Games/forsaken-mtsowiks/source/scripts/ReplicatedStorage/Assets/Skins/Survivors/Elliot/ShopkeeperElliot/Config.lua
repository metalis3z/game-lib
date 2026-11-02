-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Config, time of decompilation: Fri Nov 28 21:11:14 2025 ]]
return {
    DisplayName = "Shopkeeper", 
    Description = "The characters are starting to pile up, aren't they?", 
    RenderImage = "rbxassetid://133934807253863", 
    Price = 900, 
    Expressions = {
        Happy = "rbxassetid://129372483513283", 
        SlightlyHappy = "rbxassetid://113374365949955", 
        Default = "rbxassetid://77357871251053", 
        Hurt = "rbxassetid://83498397189774", 
        Injured = "rbxassetid://107840502244970", 
        Dead = "rbxassetid://90972972267469", 
        Drinking = "rbxassetid://139227986395923"
    }, 
    Sounds = {
        PizzaEaten = "rbxassetid://100461592771108", 
        PizzaThrown = "rbxassetid://91500604053592", 
        RushHourStart = "rbxassetid://99658188707737"
    }, 
    TextInteractions = {
        Requests = {
            ElliotPizza = {
                "\195\135a sent bigrement bon dans le coin, puis-je avoir une bouch\195\169e?", 
                "Entre camarades marchant, on s'entreaide, non?", 
                "La pizza est un \195\169l\195\169ment, le plus important des \195\169l\195\169ments. En auriez-vous?"
            }, 
            BuildermanSentry = {
                "Nous aurions grandement besoin d'une sentinelle par ces parages.", 
                "Pas pour vous alarmer, mais nous ferions mieux surveiller ce coin.", 
                "Une sentinelle l\195\160 ou je me tient ne serais pas de refus, mon ami.", 
                "Pourriez-vous placer une tourelle ici? \195\128 bon chat, bon rat comme on dit."
            }, 
            BuildermanDispenser = {
                "\195\135a me ressemble pas de demander de faveurs, mais un distributeur me serais d'une grande aide.", 
                "Un peu d'aide, pla\195\174t-il? Consid\195\169rez \195\167a comme du donnant-donnant, mon ami.", 
                "Le joueur ne veut pas stresser a devoir survivre avec si peu de vie, \195\167a serais b\195\170te de nous nier de l'aide.", 
                "Je pourrais user de votre savoir-faire, ma barre de vie n'est pas particuli\195\168rement rempli \195\160 ras bord."
            }, 
            DusekkarForceField = {
                "J'ai ou\195\175 dire que le danger rode, un petit coup de baguette magique?", 
                "Je suis m\195\170me pr\195\170t a payer le prix de votre pr\195\169cieuse aide si il le faut.", 
                "Ne pas finir autant que revenant ectoplasmique me ferais un bien fou.", 
                "J'appr\195\169cie \195\169norm\195\169ment vos gouts en mati\195\168res de masques, pourrions nous peut-\195\170tre venir a un arrangement?"
            }, 
            Thanks = {
                "Vous ne le regretterais pas!", 
                "Grand merci, et sinon \195\167a vas?", 
                "Au moins \195\167a vous feras de l'EXP en plus.", 
                "Merci, cher t\195\169m\195\169raire complice!", 
                "Je vous pairas en retour bien entendu!", 
                "Et \195\167a serais encore mieux si vous d\195\169pensiez les cr\195\169dits que vous venez de gagner. "
            }
        }
    }
};