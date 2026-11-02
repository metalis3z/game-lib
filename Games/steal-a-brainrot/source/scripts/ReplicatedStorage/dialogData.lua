-- ModuleScript: dialogData
-- Structure: dialogData = { ["NPCName"] = { { text = "...", responses = { ... } }, ... } }
local dialogData = {
	["Admin !"] = {
		{
			text = "A tu rejoin le Discord?",
			responses = {
				{ text = "OUI", next = 2 },
				{ text = "NON", exitQuip = "Bha tu Attend Quoi?" },
			}
		},
		{
			text = "Merci pour le soutien:",
			responses = { "Cool", "Annuler" },
		},
	},
}

return dialogData

