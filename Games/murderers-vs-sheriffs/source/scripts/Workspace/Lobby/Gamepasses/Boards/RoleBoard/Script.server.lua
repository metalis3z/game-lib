local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SurfaceGui = script.Parent.Board.SurfaceGui
local Murderer = SurfaceGui:WaitForChild("Murderer")
local Sheriff = SurfaceGui:WaitForChild("Sheriff")
local ClientServices = ReplicatedStorage.ClientServices
local Button = require(ClientServices.Button)
local Shimmer = require(ClientServices.FX.Shimmer)
local ButtonFX = require(ClientServices.FX.ButtonFX)
local WindowService_upvr = require(ReplicatedStorage.Modules.WindowService)

ButtonFX(Murderer.Buy.Button)
ButtonFX(Sheriff.Buy.Button)
ButtonFX(Murderer.Swap.Button)
ButtonFX(Sheriff.Swap.Button)
Shimmer(Murderer.Buy.Container)
Shimmer(Sheriff.Buy.Container)

Button.createButton(Murderer.Buy)
Murderer.Buy.Button.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.Remotes.Shop.PurchaseProduct:FireServer("Murderer", "Gameplay")
	WindowService_upvr:AddToStack("ProcessPending")
end)

Button.createButton(Murderer.Swap)
Murderer.Swap.Button.MouseButton1Click:Connect(function()
	Murderer.Visible = false
	Sheriff.Visible = true
end)

Button.createButton(Sheriff.Buy)
Sheriff.Buy.Button.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.Remotes.Shop.PurchaseProduct:FireServer("Sheriff", "Gameplay")
	WindowService_upvr:AddToStack("ProcessPending")
end)

Button.createButton(Sheriff.Swap)
Sheriff.Swap.Button.MouseButton1Click:Connect(function()
	Murderer.Visible = true
	Sheriff.Visible = false
end)

