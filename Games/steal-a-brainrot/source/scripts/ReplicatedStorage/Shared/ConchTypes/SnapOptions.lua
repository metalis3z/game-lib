local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Conch = require(ReplicatedStorage.Packages.Conch)

local SnapMusic = {
	"Concert",
	"Brazil",
	"Rap Concert",
	"Mexico",
	"Indonesia",
	"Ay Mi Gatito"
}

local SnapType = {
	"Normal",
	"Coffin"
}

-- Enregistrer le type de musique
Conch.register_type(
	"Snap Music",
	Conch.args.enum_new(SnapMusic)
)

-- Enregistrer le type de snap (Normal ou Coffin)
Conch.register_type(
	"Snap Type",
	Conch.args.enum_new(SnapType)
)

return Conch