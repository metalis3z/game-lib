wait(5)
local UI = script.Parent.Parent.Parent.Parent.Parent
local list = script.Parent.Products
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local HoverInfo = require(game.ReplicatedStorage.Modules.InfoHover)
local Donations = require(game.ReplicatedStorage.Modules.Donations)
local UIScale = UI:WaitForChild("UIScale")
local UserInputService = game:GetService("UserInputService")
Scale = UI.AbsoluteSize.Y / 1080 * 1.1

for _, Donation in pairs(list:GetChildren()) do
	if Donation:IsA("Frame") then
		if Donation.Name ~= "ITEMS" then
			local DonationInfo = Donations[Donation.Name]
			Donation.MouseEnter:Connect(function()
				HoverInfo:UpdateText(DonationInfo.String)
				HoverInfo:Move(UDim2.new(0, UserInputService:GetMouseLocation().X / Scale, 0, UserInputService:GetMouseLocation().Y / (Scale * 1.1), 0), Scale, Vector2.new(0,0.22))
			end)
			Donation.MouseMoved:Connect(function()
				HoverInfo:Move(UDim2.new(0, UserInputService:GetMouseLocation().X / Scale, 0, UserInputService:GetMouseLocation().Y / (Scale * 1.1), 0), Scale, Vector2.new(0,0.22))
			end)
			Donation.MouseLeave:Connect(function()
				HoverInfo:Remove()
			end)
			Donation.Buy.MouseButton1Click:Connect(function()
				if DonationInfo then
					if DonationInfo.Type == "Product" then
						MarketplaceService:PromptProductPurchase(Player, DonationInfo.ID)
					else
						MarketplaceService:PromptGamePassPurchase(Player, DonationInfo.ID)
					end
				end
			end)
		else
			for _, Donation2 in pairs(Donation:GetChildren()) do
				if Donation2:IsA("TextButton") then
					local DonationInfo2 = Donations[Donation2.Name]
					Donation2.MouseEnter:Connect(function()
						Donation2:TweenSize(UDim2.new(0.252*1.12, 0, 0.758*1.12, 0), "Out", "Back", 0.25, true)
						HoverInfo:UpdateText(DonationInfo2.String)
						HoverInfo:Move(UDim2.new(0, UserInputService:GetMouseLocation().X / Scale, 0, UserInputService:GetMouseLocation().Y / (Scale * 1.1), 0), Scale, Vector2.new(0,0.22))
					end)
					Donation2.MouseMoved:Connect(function()
						HoverInfo:Move(UDim2.new(0, UserInputService:GetMouseLocation().X / Scale, 0, UserInputService:GetMouseLocation().Y / (Scale * 1.1), 0), Scale, Vector2.new(0,0.22))
					end)
					Donation2.MouseLeave:Connect(function()
						Donation2:TweenSize(UDim2.new(0.252, 0, 0.758, 0), "Out", "Back", 0.25, true)
						HoverInfo:Remove()
					end)
					Donation2.Buy.MouseButton1Click:Connect(function()
						if DonationInfo2 then
							if DonationInfo2.Type == "Product" then
								MarketplaceService:PromptProductPurchase(Player, DonationInfo2.ID)
							else
								MarketplaceService:PromptGamePassPurchase(Player, DonationInfo2.ID)
							end
						end
					end)
				end
			end
		end
	end
end

