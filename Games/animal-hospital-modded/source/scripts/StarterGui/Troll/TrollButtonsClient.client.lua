-- TrollButtonsClient
-- Conecta los botones de accion del panel Troll a sus DevProducts reales.
--   TrollFrame (single, 19 R$)      -> actua sobre el jugador espectado
--                                       (target sincronizado por TrollSpectatorClient)
--   ServerTrollFrame (ALL, 49 R$)   -> actua sobre todos los jugadores del server
-- La entrega real (fling/explode/freeze/trip/kill/kick) la hace el server
-- (TrollActionServer) al procesar la compra via ProcessReceipt.
--
-- Modo gratis (SOLO thehalconyt1, "/troll free"): si LocalPlayer tiene el
-- atributo TrollFree en true, en vez de abrir el prompt de compra dispara
-- FreeTrollAction directo — el server vuelve a comprobar el atributo + el
-- nombre antes de aplicar nada, asi que nadie mas puede activarlo.

local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ProductConfig = require(ReplicatedStorage.Data.ProductConfig)

local LocalPlayer = Players.LocalPlayer
local trollGui = script.Parent
local trollFrame = trollGui:WaitForChild("TrollFrame")
local serverTrollFrame = trollGui:WaitForChild("ServerTrollFrame")

local FreeTrollAction = ReplicatedStorage:WaitForChild("Events"):WaitForChild("FreeTrollAction")

-- Both client prompts and server receipt handlers share these entries.
local SINGLE_PRODUCTS = ProductConfig.TrollButtons.Single
local ALL_PRODUCTS = ProductConfig.TrollButtons.All

local function wire(frame, products)
	for buttonName, info in pairs(products) do
		local btn = frame:FindFirstChild(buttonName)
		if btn and btn:IsA("GuiButton") then
			btn.MouseButton1Click:Connect(function()
				if LocalPlayer:GetAttribute("TrollFree") then
					FreeTrollAction:FireServer(info.action)
				else
					MarketplaceService:PromptProductPurchase(LocalPlayer, info.id)
				end
			end)
		else
			warn("[TrollButtonsClient] no encontre el boton '" .. buttonName .. "' en " .. frame:GetFullName())
		end
	end
end

wire(trollFrame, SINGLE_PRODUCTS)
wire(serverTrollFrame, ALL_PRODUCTS)