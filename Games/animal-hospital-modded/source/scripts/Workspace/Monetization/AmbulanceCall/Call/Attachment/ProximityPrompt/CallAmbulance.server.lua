--[[ AmbulanceCall — comprar el llamado de ambulancia (DevProduct).
     Al confirmarse la compra (ProcessReceipt, dueño = GunService) se dispara el
     evento real de ambulancia (ServerScriptService.AmbulanceEvent, expuesto como
     _G.RunAmbulanceEvent): llega con sirena, se queda y se va.
     El giro 360° de la ambulancia de exhibición es AUTOMÁTICO y lo hace el
     LocalScript StarterPlayerScripts.AmbulanceSpin (visual, no depende de la compra). ]]
local MarketplaceService = game:GetService("MarketplaceService")
local ServerScriptService = game:GetService("ServerScriptService")

local Prods = require(game.ReplicatedStorage.Data.Prods)
local GunService = require(ServerScriptService:WaitForChild("GunService"))

-- Registrar el grant en el dueño único del ProcessReceipt.
GunService:RegisterProduct(Prods.ambulance_call.id, function(_player)
	local run = _G.RunAmbulanceEvent
	if type(run) == "function" then
		task.spawn(run)          -- dispara la cutscene de ambulancia a todos
	else
		warn("[CallAmbulance] _G.RunAmbulanceEvent no está disponible (¿corrió AmbulanceEvent?)")
	end
	return true                  -- la compra se concede igual
end)

-- Disparar la compra al activar el prompt.
script.Parent.Triggered:Connect(function(player)
	MarketplaceService:PromptProductPurchase(player, Prods.ambulance_call.id)
end)
