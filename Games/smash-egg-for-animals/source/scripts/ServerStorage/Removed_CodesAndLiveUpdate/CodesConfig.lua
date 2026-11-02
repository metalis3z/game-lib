-- Codes fixes : CODE (MAJUSCULES) -> {Money = nombre?, Pet = "NomDuPet"?, Pets = {"Pet1", "Pet2"}?}
-- Les noms de pets doivent correspondre aux clés de EggConfig.Pets (ex. "Chicken", "Dragon").
-- Le pet apparaît dans la Common Egg Zone, réservé au joueur qui a utilisé le code.
-- Chaque joueur peut utiliser un code une seule fois.
-- Les codes avec nombre de personnes limité (SOLD OUT) se créent depuis le panneau admin.

local Codes = {
	["RELEASE"] = {Money = 500},
	["CHICKEN"] = {Pet = "Chicken"},
	["LUCKY500"] = {Money = 1000},
}

return Codes
