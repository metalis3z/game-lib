-- Update GALACTIC : tant qu'un admin n'a pas cliqué "GALACTIC UPDATE" (panneau admin, onglet Galactic), tout le contenu Galactic
-- reste caché : zone Galaxy, ses œufs, son gardien Zorvex, marteaux Planet / Sun, section Galactic de l'Index, tapis Galactic.
-- L'état est l'attribut "GalacticUpdate" de ReplicatedStorage (posé par ServerScriptService.GalacticUpdateServer).
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ATTRIBUTE = "GalacticUpdate"
local Gate = {}
function Gate.Released()
	return ReplicatedStorage:GetAttribute(ATTRIBUTE) == true
end
-- attend la sortie de l'update (rend la main tout de suite si elle est déjà sortie)
function Gate.Wait()
	while not Gate.Released() do ReplicatedStorage:GetAttributeChangedSignal(ATTRIBUTE):Wait() end
end
-- fn() une seule fois, dès que l'update est sortie
function Gate.OnRelease(fn)
	task.spawn(function()
		Gate.Wait()
		fn()
	end)
end
-- vrai pour une rareté encore cachée
function Gate.Hidden(rarity)
	return rarity == "Galactic" and not Gate.Released()
end
return Gate
