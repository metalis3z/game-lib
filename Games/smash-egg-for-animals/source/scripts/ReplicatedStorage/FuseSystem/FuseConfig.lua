-- Fuse Machine : réglages et calcul du résultat, partagés par le serveur (FuseServer) et l'interface (FuseClient).
local FuseConfig = {}

FuseConfig.Slots = 3            -- nombre de pets à mettre dans la machine (3 fois le MÊME animal)
FuseConfig.Duration = 3600      -- (anciennes fusions sauvegardées avec un timer dans la machine)
FuseConfig.WeightBonus = 1      -- le pet obtenu pèse la somme des 3 poids
FuseConfig.EggHatchTime = 3600  -- l'œuf fusionné éclot 1 h après avoir été posé dans le jardin
FuseConfig.BadLuckChance = 0.3  -- 30 % de malchance : le pet fusionné sort NORMAL (poids normal de l'animal, ni mutation, ni trait, ni niveau)

-- l'œuf qui représente un animal fusionné : celui qui contient cet animal (sinon un œuf de la même rareté)
function FuseConfig.EggKeyFor(petName, Config)
	local best, bestChance
	for key, egg in Config.Eggs do
		for _, entry in egg.Pets or {} do
			if entry.Pet == petName and (not best or (entry.Chance or 0) > bestChance) then best, bestChance = key, entry.Chance or 0 end
		end
	end
	if best then return best end
	local info = Config.Pets[petName]
	for key, egg in Config.Eggs do
		if info and egg.Rarity == info.Rarity then return key end
	end
	return next(Config.Eggs)
end
FuseConfig.PromptDistance = 14  -- distance d'activation de l'invite devant la machine
FuseConfig.CloseDistance = 32   -- la fenêtre se ferme si on s'éloigne plus que ça de la machine

-- Le résultat : les trois pets sont le même animal ; son poids devient la somme des poids des trois pets (x WeightBonus).
-- (le plus rare / le plus lourd garde sa fiche, pour les anciennes fusions) Il garde sa mutation et son trait, sinon il prend ceux d'un des
-- deux autres.
function FuseConfig.Result(records, Config)
	local best, bestRank
	local total = 0
	for _, rec in records do
		local info = Config.Pets[rec.Pet]
		local rank = info and (Config.RarityRank[info.Rarity] or 0) or -1
		total += tonumber(rec.Kg) or (info and info.Kg) or 0
		if not best or rank > bestRank or (rank == bestRank and (tonumber(rec.Kg) or 0) > (tonumber(best.Kg) or 0)) then
			best, bestRank = rec, rank
		end
	end
	if not best then return nil end
	local result = {Pet = best.Pet, Kg = total * FuseConfig.WeightBonus, Mutation = best.Mutation, Trait = best.Trait, Level = best.Level, Xp = best.Xp}
	for _, rec in records do
		result.Mutation = result.Mutation or rec.Mutation
		result.Trait = result.Trait or rec.Trait
	end
	return result
end

return FuseConfig
