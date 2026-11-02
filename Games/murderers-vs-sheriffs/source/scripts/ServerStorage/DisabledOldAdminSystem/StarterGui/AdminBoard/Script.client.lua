local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shimmer_upvr = require(ReplicatedStorage.ClientServices.FX.Shimmer)
local ButtonFX_upvr = require(ReplicatedStorage.ClientServices.FX.ButtonFX)
local Button_upvr = require(ReplicatedStorage.ClientServices.Button)
local WindowService_upvr = require(ReplicatedStorage.Modules.WindowService)
local MarketplaceService = game:GetService("MarketplaceService")
local GamepassID = 1435534780

local v6 = Button_upvr.createButton(game.Workspace.Lobby.Gamepasses.Boards.AdminBoard.Display.SurfaceGui.Container.Buy, function()
	MarketplaceService:PromptGamePassPurchase(game.Players.LocalPlayer, GamepassID)
	WindowService_upvr:AddToStack("ProcessPending")
end)

if not v6 then
	warn("Not found.")
end

ButtonFX_upvr(game.Workspace.Lobby.Gamepasses.Boards.AdminBoard.Display.SurfaceGui.Container.Buy)

