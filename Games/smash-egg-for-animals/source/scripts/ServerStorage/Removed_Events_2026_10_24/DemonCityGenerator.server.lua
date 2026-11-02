-- DemonCityGenerator : au démarrage du serveur, prépare la ville détruite de la cinématique "Demon City".
-- La ville est déjà construite dans le jeu (Workspace.DestroyedCity, faite par ServerStorage.DemonCityBuilder) ; si elle a été
-- supprimée, elle est reconstruite entièrement par code. Elle est ensuite rangée dans ServerStorage : elle n'apparaît dans
-- le monde que pendant l'event (DemonCinematicServer / DemonBossController), comme l'arène du Headless.
local Builder = require(game:GetService("ServerStorage"):WaitForChild("DemonCityBuilder"))
local ok, err = pcall(function()
	Builder.get()
	Builder.setCollapsed(false)
	Builder.show(false)
end)
if not ok then warn("[DemonCity] ville : " .. tostring(err)) end
