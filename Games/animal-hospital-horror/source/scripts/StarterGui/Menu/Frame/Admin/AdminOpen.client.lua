--[[ AdminOpen — al presionar el botón Admin abre el AdminPanel SI el jugador
     compró el DevProduct (atributo OwnsAdminPanel). Si no, ofrece la compra. ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Prods = require(ReplicatedStorage.Data.Prods)
local LocalPlayer = game.Players.LocalPlayer
local panel = game.StarterGui.AdminPanel.AdminPanel

script.Parent.MouseButton1Click:Connect(function()
	panel.Visible = true
end)
