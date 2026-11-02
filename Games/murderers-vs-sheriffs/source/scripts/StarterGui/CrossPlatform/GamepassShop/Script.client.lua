local MainUI = script.Parent
local Sync = require(game.ReplicatedStorage.Database.Sync)
local Shop = Sync.GamepassShop
local MarketplaceService = game:GetService("MarketplaceService")
local WindowService = require(game.ReplicatedStorage.Modules.WindowService)
local Tier_Container = script.Parent.Container.Container:WaitForChild("List")
local Tier_Frame = script:WaitForChild("Tier")
local Button = require(game.ReplicatedStorage.ClientServices.Button)
local CloseButton = MainUI:WaitForChild("Title"):WaitForChild("Close")
Button.createButton(CloseButton)
local function ClearFrames()
	for _, Frame in pairs(Tier_Container:GetChildren()) do
		if Frame:IsA("Frame") then
			Frame:Destroy()
		end
	end
end
local function Owned(GamePassID)
	local Player = game.Players.LocalPlayer
	if MarketplaceService:UserOwnsGamePassAsync(Player.UserId, GamePassID) then
		return true
	else
		return false
	end
end
local function Generate()
	for _, Tier in pairs(Shop) do	
		local Tier_Copy = Tier_Frame:Clone()
		local GamePassID= Tier.GamepassID
		require(game:GetService("ReplicatedStorage").ClientServices.FX.ButtonFX)(Tier_Copy.Buy.Button)
		Tier_Copy.Parent = Tier_Container
		Tier_Copy.Buy.Container.Container.ImageLabel.Image = Tier.Image
		Tier_Copy.Buy.Container.Container.Txt.Text = Tier.Text
		Tier_Copy.Buy.Container.Background.BackgroundColor3 = Tier.Color
		Tier_Copy.Buy.Container.Shadow.BackgroundColor3 = Tier.Color
		Tier_Copy.Name = Tier.Text
		Button.createButton(Tier_Copy:WaitForChild("Buy"))
		if Tier.ChromaText and Tier.ChromaText == true then
			local ChromaGradient = script.UIGradient
			local CloneChroma = ChromaGradient:Clone()
			CloneChroma.Parent = Tier_Copy.Buy.Container.Container.Txt
		end
		if Tier.ChromaImg and Tier.ChromaImg == true then
			local ChromaGradient = script.UIGradient
			local CloneChroma = ChromaGradient:Clone()
			CloneChroma.Parent = Tier_Copy.Buy.Container.Container.ImageLabel
		end
		if not Owned(GamePassID) then
			local ProductInfo = MarketplaceService:GetProductInfo(GamePassID, Enum.InfoType.GamePass)
			Tier_Copy.Buy.Container.Container.ImageLabel.RobuxCost.Price.Text = tostring(ProductInfo.PriceInRobux)
		else
			Tier_Copy.Buy.Container.Container.ImageLabel.RobuxCost.Visible = false
			Tier_Copy.Buy.Container.Container.ImageLabel.Owned.Visible = true
		end
		Tier_Copy.LayoutOrder = Tier.LayoutOrder
		Tier_Copy.Buy.Button.MouseButton1Click:Connect(function()
			if not Owned(GamePassID) then
				local FinishedConnection
				MarketplaceService:PromptGamePassPurchase(game.Players.LocalPlayer, GamePassID)
				WindowService:AddToStack("ProcessPending")
			end	
		end)

	end
end
CloseButton.Button.MouseButton1Click:Connect(function()
	MainUI.Visible = false
	game.Lighting.MenuBlur.Enabled = false
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
end)
ClearFrames()
Generate()
MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(Player, ID, Purchased)
	if Purchased then
		ClearFrames()
		Generate()
	end
end)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WindowService = require(ReplicatedStorage.Modules.WindowService)
WindowService:RegisterFrame(script.Parent, "GamepassShop")