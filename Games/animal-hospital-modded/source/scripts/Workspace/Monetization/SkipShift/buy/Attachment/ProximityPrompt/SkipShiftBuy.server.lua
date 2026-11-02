--[[ SkipShift — comprar el salto de turno (DevProduct).
     Al confirmarse la compra (ProcessReceipt, dueño = GunService) se avanza el
     turno actual llamando a ShiftService:GoToShift() (sin argumento = +1 noche).
     El giro 360° del Skull de exhibición es AUTOMÁTICO y lo hace el LocalScript
     StarterPlayerScripts.SkullSpin (visual, no depende de la compra). ]]
local MarketplaceService = game:GetService("MarketplaceService")
local ServerScriptService = game:GetService("ServerScriptService")

local Prods = require(game.ReplicatedStorage.Data.Prods)
local GunService = require(ServerScriptService:WaitForChild("GunService"))

-- Registrar el grant en el dueño único del ProcessReceipt.
GunService:RegisterProduct(Prods.skip_shift.id, function(_player)
	local ShiftService = require(ServerScriptService:WaitForChild("ShiftService"))
	ShiftService:GoToShift()   -- avanza 1 turno (salta la noche actual)
	return true                -- la compra se concede
end)

-- Disparar la compra al activar el prompt.
script.Parent.Triggered:Connect(function(player)
	MarketplaceService:PromptProductPurchase(player, Prods.skip_shift.id)
end)
